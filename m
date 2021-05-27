Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB282392696
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 06:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhE0Ex3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 00:53:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:57901 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhE0Ex3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 00:53:29 -0400
IronPort-SDR: L87SDuFUovS5MHTtqVESlsIKTHif70Hx0Ljw2ouMIv6W95yNANJPlKLNKXmzs0D/AqsyFEEh6w
 TdP94saI5aPg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202411548"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="202411548"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:51:52 -0700
IronPort-SDR: Bl8poXRU2Tsbv09kdrjwMS83I7WZaiBIchUlDudPk4f+Q/QkJb8ny3jZEYC7VmooKpsxfIpBKY
 Wpwgb6ZFrzVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="477321703"
Received: from unknown (HELO chenyu-desktop.sh.intel.com) ([10.239.158.131])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2021 21:51:49 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] intel_idle: Adjust the SKX C6 latency and residency if PC6 is disabled
Date:   Thu, 27 May 2021 12:56:47 +0800
Message-Id: <20210527045647.3599-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently cpuidle assumes worst-case C-state parameters, and so C6
is described with PC6 parameters, which is worst case for requesting
CC6. When PC6 is enabled, this is appropriate. But if PC6 is disabled
in BIOS, the exit latency and target_residency should be adjusted
accordingly.

Exit latency:
The C6 exit latency is measured when woken up from CC6/PC6. In the past,
if PC6 is disabled, CPU would be demoted to CC6/PC3, which is close to
the latency from CC6/PC6 and there is no need to update the C6 exit latency.
However on newer platform there is no CC3/PC3 anymore, then the C6 exit
latency with PC6 disabled should be CC6/PC0.

Target residency:
With PC6 disabled and C3/PC3 supported, the OS requests C3 if idle
duration is within [CC6, PC6) target_residency. On new CPU generations
with C3/PC3 deprecated, the OS would request C1E. This would cause
low energy-efficiency. In summary, the question is, should we lower
the bar to request C6 when PC6 is disabled? The answer is yes.

To fill this gap, check if PC6 is disabled in the BIOS in the
MSR_PKG_CST_CONFIG_CONTROL(0xe2). If so, use CC6/PC0 parameters as the
new exit latency. Meanwhile, update target_residency to 3 times of the new
exit latency. This is consistent with how intel_idle driver uses _CST to
calculate the target_residency. The consequence is that, the OS would
be more offen to choose C6 over C1E when PC6 is disabled. The new exit
latency of CC6/PC0 was from wult[1] result, which was measured via NIC
wakeup from 99.99th latency.

Before the change:
PC6 enabled        Y          N           N
has C3/PC3         N          N           Y
idle duration      [CC6,PC6)  [CC6,PC6)   [CC6,PC6)
CPU request        C1E        C1E         C3

After the change:
PC6 enabled        Y          N           N
has C3/PC3         N          N           Y
idle duration      [CC6,PC6)  [CC6,PC6)   [CC6,PC6)
CPU request        C1E        *C6*        C3

*C6* rather than C1E is chosen.

There is concern that if we should introduce a more generic solution
rather than optimizing on each platforms. However consider the
code complexity and different PC6 bit interpretation on different
platforms, tune the code per platform seems to be an acceptable trade-off.

[1] https://intel.github.io/wult/

Suggested-by: Len Brown <len.brown@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/idle/intel_idle.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ec1b9d306ba6..e6c543b5ee1d 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1484,6 +1484,36 @@ static void __init sklh_idle_state_table_update(void)
 	skl_cstates[6].flags |= CPUIDLE_FLAG_UNUSABLE;	/* C9-SKL */
 }
 
+/**
+ * skx_idle_state_table_update - Adjust the Sky Lake/Cascade Lake
+ * idle states table.
+ */
+static void __init skx_idle_state_table_update(void)
+{
+	unsigned long long msr;
+
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr);
+
+	/*
+	 * 000b: C0/C1 (no package C-state support)
+	 * 001b: C2
+	 * 010b: C6 (non-retention)
+	 * 011b: C6 (retention)
+	 * 111b: No Package C state limits.
+	 */
+	if ((msr & 0x7) < 2) {
+		/*
+		 * Uses the CC6 + PC0 latency and 3 times of
+		 * latency for target_residency if the PC6
+		 * is disabled in BIOS. This is consistent
+		 * with how intel_idle driver uses _CST
+		 * to set the target_residency.
+		 */
+		skx_cstates[2].exit_latency = 92;
+		skx_cstates[2].target_residency = 276;
+	}
+}
+
 static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 {
 	unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
@@ -1515,6 +1545,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_FAM6_SKYLAKE:
 		sklh_idle_state_table_update();
 		break;
+	case INTEL_FAM6_SKYLAKE_X:
+		skx_idle_state_table_update();
+		break;
 	}
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
-- 
2.25.1

