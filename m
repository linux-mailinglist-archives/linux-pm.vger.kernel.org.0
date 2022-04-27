Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490145110E3
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 08:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiD0GMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 02:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiD0GMH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 02:12:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616966F88
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 23:08:58 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="245749366"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="245749366"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="807873514"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2022 23:08:56 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Jan Beulich <jbeulich@suse.com>,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 1/2] intel_idle: fix the 'preferred_cstates' module parameter
Date:   Wed, 27 Apr 2022 09:08:52 +0300
Message-Id: <20220427060853.3975453-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427060853.3975453-1-dedekind1@gmail.com>
References: <20220427060853.3975453-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch is a fix for the following 5.18-rc1 commit:
   da0e58c038e6 intel_idle: add 'preferred_cstates' module argument

Problem description.

When user boots kernel up with the 'intel_idle.preferred_cstates=4' option,
we enable C1E and disable C1 states on Sapphire Rapids Xeon (SPR). In order
for C1E to work on SPR, we have to enable the C1E promotion bit on all
CPUs.  However, we enable it only on one CPU.

Fix description.

The 'intel_idle' driver already has the infrastructure for disabling C1E
promotion on every CPU. This patch uses the same infrastructure for
enabling C1E promotion on every CPU. It changes the boolean
'disable_promotion_to_c1e' variable to a tri-state 'c1e_promotion'
variable.

Tested on a 2-socket SPR system. I verified the following combinations:
* C1E promotion enabled and disabled in BIOS.
* Booted with and without the 'intel_idle.preferred_cstates=4' kernel
  argument.

In all 4 cases C1E promotion was correctly set on all CPUs.

Also tested on an old Broadwell system, just to make sure it does not cause
a regression. C1E promotion was correctly disabled on that system, both C1
and C1E were exposed (as expected).

Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b7640cfe0020..cf5ed4c1d02c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -69,7 +69,12 @@ static unsigned int preferred_states_mask;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
 static unsigned long auto_demotion_disable_flags;
-static bool disable_promotion_to_c1e;
+
+static enum {
+	C1E_PROMOTION_PRESERVE,
+	C1E_PROMOTION_ENABLE,
+	C1E_PROMOTION_DISABLE
+} c1e_promotion = C1E_PROMOTION_PRESERVE;
 
 struct idle_cpu {
 	struct cpuidle_state *state_table;
@@ -1398,8 +1403,6 @@ static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
 static inline bool intel_idle_off_by_default(u32 mwait_hint) { return false; }
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
-static void c1e_promotion_enable(void);
-
 /**
  * ivt_idle_state_table_update - Tune the idle states table for Ivy Town.
  *
@@ -1587,8 +1590,7 @@ static void __init spr_idle_state_table_update(void)
 		spr_cstates[1].flags &= ~CPUIDLE_FLAG_UNUSABLE;
 
 		/* Enable C1E using the "C1E promotion" bit. */
-		c1e_promotion_enable();
-		disable_promotion_to_c1e = false;
+		c1e_promotion = C1E_PROMOTION_ENABLE;
 	}
 
 	/*
@@ -1754,7 +1756,9 @@ static int intel_idle_cpu_init(unsigned int cpu)
 	if (auto_demotion_disable_flags)
 		auto_demotion_disable();
 
-	if (disable_promotion_to_c1e)
+	if (c1e_promotion == C1E_PROMOTION_ENABLE)
+		c1e_promotion_enable();
+	else if (c1e_promotion == C1E_PROMOTION_DISABLE)
 		c1e_promotion_disable();
 
 	return 0;
@@ -1833,7 +1837,8 @@ static int __init intel_idle_init(void)
 	if (icpu) {
 		cpuidle_state_table = icpu->state_table;
 		auto_demotion_disable_flags = icpu->auto_demotion_disable_flags;
-		disable_promotion_to_c1e = icpu->disable_promotion_to_c1e;
+		if (icpu->disable_promotion_to_c1e)
+			c1e_promotion = C1E_PROMOTION_DISABLE;
 		if (icpu->use_acpi || force_use_acpi)
 			intel_idle_acpi_cst_extract();
 	} else if (!intel_idle_acpi_cst_extract()) {
-- 
2.35.1

