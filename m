Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52884C9EFF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 09:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiCBIQu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 03:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBIQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 03:16:49 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0841B7C40
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 00:16:04 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="314058967"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="314058967"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 00:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="510913503"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 00:16:02 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        chang.seok.bae@intel.com
Subject: [PATCH v1 2/3] intel_idle: add 'preferred_cstates' module argument
Date:   Wed,  2 Mar 2022 10:15:59 +0200
Message-Id: <20220302081600.1751716-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220302081600.1751716-1-dedekind1@gmail.com>
References: <20220302081600.1751716-1-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

On Sapphire Rapids Xeon (SPR) the C1 and C1E states are basically mutually
exclusive - only one of them can be enabled. By default, 'intel_idle' driver
enables C1 and disables C1E. However, some users prefer to use C1E instead of
C1, because it saves more energy.

This patch adds a new module parameter ('preferred_cstates') for enabling C1E
and disabling C1. Here is the idea behind it.

1. This option has effect only for "mutually exclusive" C-states like C1 and
   C1E on SPR.
2. It does not have any effect on independent C-states, which do not require
   other C-states to be disabled (most states on most platforms as of today).
3. For mutually exclusive C-states, the 'intel_idle' driver always has a
   reasonable default, such as enabling C1 on SPR by default. On other
   platforms, the default may be different.
4. Users can override the default using the 'preferred_cstates' parameter.
5. The parameter accepts the preferred C-states bit-mask, similarly to the
   existing 'states_off' parameter.
6. This parameter is not limited to C1/C1E, and leaves room for supporting
   other mutually exclusive C-states, if they come in the future.

Today 'intel_idle' can only be compiled-in, which means that on SPR, in order
to disable C1 and enable C1E, users should boot with the following kernel
argument: intel_idle.preferred_cstates=4

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 1c7c25909e54..b2688c326522 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -64,6 +64,7 @@ static struct cpuidle_driver intel_idle_driver = {
 /* intel_idle.max_cstate=0 disables driver */
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask;
+static unsigned int preferred_states_mask;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
@@ -1400,6 +1401,8 @@ static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
 static inline bool intel_idle_off_by_default(u32 mwait_hint) { return false; }
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
+static void c1e_promotion_enable(void);
+
 /**
  * ivt_idle_state_table_update - Tune the idle states table for Ivy Town.
  *
@@ -1570,6 +1573,26 @@ static void __init skx_idle_state_table_update(void)
 	}
 }
 
+/**
+ * spr_idle_state_table_update - Adjust Sapphire Rapids idle states table.
+ */
+static void __init spr_idle_state_table_update(void)
+{
+	/* Check if user prefers C1E over C1. */
+	if (preferred_states_mask & BIT(2)) {
+		if (preferred_states_mask & BIT(1))
+			/* Both can't be enabled, stick to the defaults. */
+			return;
+
+		spr_cstates[0].flags |= CPUIDLE_FLAG_UNUSABLE;
+		spr_cstates[1].flags &= ~CPUIDLE_FLAG_UNUSABLE;
+
+		/* Enable C1E using the "C1E promotion" bit. */
+		c1e_promotion_enable();
+		disable_promotion_to_c1e = false;
+	}
+}
+
 static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 {
 	unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
@@ -1604,6 +1627,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_FAM6_SKYLAKE_X:
 		skx_idle_state_table_update();
 		break;
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+		spr_idle_state_table_update();
+		break;
 	}
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
@@ -1676,6 +1702,15 @@ static void auto_demotion_disable(void)
 	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
 }
 
+static void c1e_promotion_enable(void)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	msr_bits |= 0x2;
+	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
+}
+
 static void c1e_promotion_disable(void)
 {
 	unsigned long long msr_bits;
@@ -1845,3 +1880,14 @@ module_param(max_cstate, int, 0444);
  */
 module_param_named(states_off, disabled_states_mask, uint, 0444);
 MODULE_PARM_DESC(states_off, "Mask of disabled idle states");
+/*
+ * Some platforms come with mutually exclusive C-states, so that if one is
+ * enabled, the other C-states must not be used. Example: C1 and C1E on
+ * Sapphire Rapids platform. This parameter allows for selecting the
+ * preferred C-states among the groups of mutually exclusive C-states - the
+ * selected C-states will be registered, the other C-states from the mutually
+ * exclusive group won't be registered. If the platform has no mutually
+ * exclusive C-states, this parameter has no effect.
+ */
+module_param_named(preferred_cstates, preferred_states_mask, uint, 0444);
+MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
-- 
2.31.1

