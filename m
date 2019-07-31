Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9178E7B875
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 06:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfGaEVV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 00:21:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:41294 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfGaEVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 00:21:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 21:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,328,1559545200"; 
   d="scan'208";a="347395045"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by orsmga005.jf.intel.com with ESMTP; 30 Jul 2019 21:21:18 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yu.c.chen@intel.com,
        Len Brown <len.brown@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Rui Zhang <rui.zhang@intel.com>,
        David Box <david.e.box@intel.com>,
        "Tan, Raymond" <raymond.tan@intel.com>
Subject: [PATCH] Introducing the mask_cstate to disable specific c-states during bootup
Date:   Wed, 31 Jul 2019 12:31:44 +0800
Message-Id: <20190731043144.30863-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is request to disable specific c-states during bootup for
debug purpose. For example, deeper c-states except C1,C1E,C10
are disabled during bootup otherwise it might not boot up well
due to incorrect setting in FW.

For example, intel_idle.mask_cstate=0x3c, would disable cstate
2,3,4,5 in the table
(1<<2) | (1<<3) | (1<<4) | (1<<5)
which is C6,C7s,C8,C9 on Broxton.
This could have it come up as present, but with c-states disabled,
so user can enable those c-states later to test.

Cc: Len Brown <len.brown@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Cc: David Box <david.e.box@intel.com>
Cc: "Tan, Raymond" <raymond.tan@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++
 drivers/idle/intel_idle.c                     | 36 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7ccd158b3894..93a326c42877 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1733,6 +1733,13 @@
 			provided by tboot because it makes the system
 			vulnerable to DMA attacks.
 
+	intel_idle.mask_cstate=	[HW,X86]
+			Mask of C-states to be disabled during bootup. For
+			example, mask_cstate=0x3c, would disable cstate 2,3,4,5
+			in the table
+			(1<<2) | (1<<3) | (1<<4) | (1<<5)
+			which is C6,C7s,C8,C9 on Broxton.
+
 	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
 			0	disables intel_idle and fall back on acpi_idle.
 			1 to 9	specify maximum depth of C-state.
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index fa5ff77b8fe4..ed3233864b69 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -63,6 +63,8 @@ static struct cpuidle_driver intel_idle_driver = {
 /* intel_idle.max_cstate=0 disables driver */
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
 
+static unsigned int mask_cstate;
+
 static unsigned int mwait_substates;
 
 #define LAPIC_TIMER_ALWAYS_RELIABLE 0xFFFFFFFF
@@ -1354,6 +1356,12 @@ static void __init intel_idle_cpuidle_driver_init(void)
 		if (num_substates == 0)
 			continue;
 
+		if ((1UL<<cstate) & mask_cstate) {
+			pr_info("Disable #%d[%s] by user\n",
+					cstate,
+					cpuidle_state_table[cstate].name);
+			cpuidle_state_table[cstate].disabled = 1;
+		}
 		/* if state marked as disabled, skip it */
 		if (cpuidle_state_table[cstate].disabled != 0) {
 			pr_debug("state %s is disabled\n",
@@ -1480,3 +1488,31 @@ device_initcall(intel_idle_init);
  * is the easiest way (currently) to continue doing that.
  */
 module_param(max_cstate, int, 0444);
+
+static int mask_cstate_set(const char *arg, const struct kernel_param *kp)
+{
+	int ret = 0;
+	unsigned long new_mask_cstate, max_bit;
+
+	ret = kstrtoul(arg, 0, &new_mask_cstate);
+	if (ret)
+		goto exit_mask;
+
+	max_bit = find_last_bit(&new_mask_cstate, BITS_PER_LONG);
+	if (max_bit >= CPUIDLE_STATE_MAX) {
+		ret = -EINVAL;
+		goto exit_mask;
+	}
+
+	mask_cstate = new_mask_cstate;
+	smp_mb();
+
+exit_mask:
+	return ret;
+}
+
+static const struct kernel_param_ops mask_cstate_ops = {
+	.set = mask_cstate_set,
+	.get = param_get_int,
+};
+module_param_cb(mask_cstate, &mask_cstate_ops, &mask_cstate, 0644);
-- 
2.17.1

