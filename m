Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88650277D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbiDOJmx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Apr 2022 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351817AbiDOJmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 05:42:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8CE48E64
        for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2022 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650015614; x=1681551614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EEotf8IKq/O/8p3FOnKNP1mpSFh6XYPpYfaCDwbfS7E=;
  b=lg/VEh1zSucgXMKGba2Ii5wrjq1I2wjBE6Gncea3yFPkwbtPUiwc+unt
   Lef5iex0iz48LJrwASWFXLnS3JMefAdVA8qk00jH8gs3lbRKy44Ix0VZI
   NRxhrbDlc1L3reDKG4APM14rsD+KO7uDkZ0cD03qELp1LC1e8/ZVEZS6G
   T2yxtYA9D3e2pwWDQmx/PUctvMBJCh+A7KM5lVjGsITygWS9jKeckJlSv
   nOs1Mz+vqPalzuC5Z1GXTxkL7TPU4vjetuTU9sAVdWLyrdXcUmVXoKSgC
   Uj9E8/LBIvR/r8tOq8vxO6FX8fWBeXyHHw1qPelrxc6c9LB6sEcPiOXP5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250427006"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="250427006"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 02:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="553086853"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga007.jf.intel.com with ESMTP; 15 Apr 2022 02:40:12 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com
Subject: [PATCH] intel_idle: add AlderLake support
Date:   Fri, 15 Apr 2022 17:39:51 +0800
Message-Id: <20220415093951.2677170-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to SPR, the C1 and C1E states on ADL are mutually exclusive.
Only one of them can be enabled at one time.
But contrast to SPR, which usually has a strong latency requirement as a
Xeon processor, C1E is preferred on ADL from the power' perspective of
view.

This patch adds both C1 and C1E states in the custom table, and
1. enables the "C1E promotion" bit in 'MSR_IA32_POWER_CTL' and mark C1
   with the "CPUIDLE_FLAG_UNUSABLE" flag, thus C1 is not available by
   default from both hardware and software.
2. adds support for "preferred_cstates" module parameter, so that user
   can choose C1 instead of C1E by booting with
   "intel_idle.preferred_cstates=2".

Plus, separate custom cstate tables are introduced for the ADL mobile and
desktop processors, because of the latency differences between these two
processors, especially in PC10.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/idle/intel_idle.c | 137 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b7640cfe0020..f738d08dc961 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -759,6 +759,106 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+/*
+ * On AlderLake C1 has to be disabled if C1E is enabled, and vice versa.
+ * C1E is enabled only if "C1E promotion" bit is set in MSR_IA32_POWER_CTL.
+ * But in this case there is effectively no C1, because C1 requests are
+ * promoted to C1E. If the "C1E promotion" bit is cleared, then both C1
+ * and C1E requests end up with C1, so there is effectively no C1E.
+ *
+ * By default we enable C1E and disable C1 by marking it with
+ * 'CPUIDLE_FLAG_UNUSABLE'.
+ */
+static struct cpuidle_state adl_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 2,
+		.target_residency = 4,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 220,
+		.target_residency = 600,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C8",
+		.desc = "MWAIT 0x40",
+		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 280,
+		.target_residency = 800,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C10",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 680,
+		.target_residency = 2000,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
+static struct cpuidle_state adl_l_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_UNUSABLE,
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 2,
+		.target_residency = 4,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 170,
+		.target_residency = 500,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C8",
+		.desc = "MWAIT 0x40",
+		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 200,
+		.target_residency = 600,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C10",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 230,
+		.target_residency = 700,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 /*
  * On Sapphire Rapids Xeon C1 has to be disabled if C1E is enabled, and vice
  * versa. On SPR C1E is enabled only if "C1E promotion" bit is set in
@@ -1142,6 +1242,14 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_adl __initconst = {
+	.state_table = adl_cstates,
+};
+
+static const struct idle_cpu idle_cpu_adl_l __initconst = {
+	.state_table = adl_l_cstates,
+};
+
 static const struct idle_cpu idle_cpu_spr __initconst = {
 	.state_table = spr_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1210,6 +1318,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&idle_cpu_adl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&idle_cpu_adl_l),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
@@ -1570,6 +1680,29 @@ static void __init skx_idle_state_table_update(void)
 	}
 }
 
+/**
+ * adl_idle_state_table_update - Adjust AlderLake idle states table.
+ */
+static void __init adl_idle_state_table_update(void)
+{
+	/* Check if user prefers C1 over C1E. */
+	if (preferred_states_mask & BIT(1)) {
+		if (preferred_states_mask & BIT(2))
+			/* Both can't be enabled, stick to the defaults. */
+			goto end;
+
+		cpuidle_state_table[0].flags &= ~CPUIDLE_FLAG_UNUSABLE;
+		cpuidle_state_table[1].flags |= CPUIDLE_FLAG_UNUSABLE;
+
+		/* Disable C1E by clearing the "C1E promotion" bit. */
+		disable_promotion_to_c1e = true;
+		return;
+	}
+end:
+	/* Make sure C1E is enabled by default */
+	c1e_promotion_enable();
+}
+
 /**
  * spr_idle_state_table_update - Adjust Sapphire Rapids idle states table.
  */
@@ -1642,6 +1775,10 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		spr_idle_state_table_update();
 		break;
+	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
+		adl_idle_state_table_update();
+		break;
 	}
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
-- 
2.17.1

