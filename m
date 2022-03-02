Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA574C9EFE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 09:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbiCBIQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 03:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiCBIQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 03:16:49 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB9B7C4D
        for <linux-pm@vger.kernel.org>; Wed,  2 Mar 2022 00:16:03 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="314058959"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="314058959"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 00:16:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="510913490"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 00:16:01 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        chang.seok.bae@intel.com
Subject: [PATCH v1 1/3] intel_idle: add SPR support
Date:   Wed,  2 Mar 2022 10:15:58 +0200
Message-Id: <20220302081600.1751716-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add Sapphire Rapids Xeon support.

Up until very recently, the C1 and C1E C-states were independent, but this
has changed in some new chips, including Sapphire Rapids Xeon (SPR). In these
chips the C1 and C1E states cannot be enabled at the same time. The "C1E
promotion" bit in 'MSR_IA32_POWER_CTL' also has its semantics changed a bit.

Here are the C1, C1E, and "C1E promotion" bit rules on Xeons before SPR.

1. If C1E promotion bit is disabled.
   a. C1  requests end up with C1  C-state.
   b. C1E requests end up with C1E C-state.
2. If C1E promotion bit is enabled.
   a. C1  requests end up with C1E C-state.
   b. C1E requests end up with C1E C-state.

Here are the C1, C1E, and "C1E promotion" bit rules on Sapphire Rapids Xeon.
1. If C1E promotion bit is disabled.
   a. C1  requests end up with C1 C-state.
   b. C1E requests end up with C1 C-state.
2. If C1E promotion bit is enabled.
   a. C1  requests end up with C1E C-state.
   b. C1E requests end up with C1E C-state.

Before SPR Xeon, the 'intel_idle' driver was disabling C1E promotion and was
exposing C1 and C1E as independent C-states. But on SPR, C1 and C1E cannot be
enabled at the same time.

This patch adds both C1 and C1E states. However, C1E is marked as with the
"CPUIDLE_FLAG_UNUSABLE" flag, which means that in won't be registered by
default. The C1E promotion bit will be cleared, which means that by default
only C1 and C6 will be registered on SPR.

The next patch will add an option for enabling C1E and disabling C1 on SPR.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 0b66e25c0e2d..1c7c25909e54 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -761,6 +761,46 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+/*
+ * On Sapphire Rapids Xeon C1 has to be disabled if C1E is enabled, and vice
+ * versa. On SPR C1E is enabled only if "C1E promotion" bit is set in
+ * MSR_IA32_POWER_CTL. But in this case there effectively no C1, because C1
+ * requests are promoted to C1E. If the "C1E promotion" bit is cleared, then
+ * both C1 and C1E requests end up with C1, so there is effectively no C1E.
+ *
+ * By default we enable C1 and disable C1E by marking it with
+ * 'CPUIDLE_FLAG_UNUSABLE'.
+ */
+static struct cpuidle_state spr_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE | \
+					   CPUIDLE_FLAG_UNUSABLE,
+		.exit_latency = 2,
+		.target_residency = 4,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 290,
+		.target_residency = 800,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.name = "C1E",
@@ -1104,6 +1144,12 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_spr __initconst = {
+	.state_table = spr_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_avn __initconst = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1166,6 +1212,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
-- 
2.31.1

