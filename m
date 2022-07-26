Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0DC581664
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiGZP3n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 11:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGZP3m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 11:29:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277AFDFCF
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 08:29:42 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349683824"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349683824"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="658735552"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2022 08:29:36 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 1/4] turbostat: separate SPR from ICX
Date:   Tue, 26 Jul 2022 18:29:32 +0300
Message-Id: <20220726152935.3183492-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Before this patch, SPR platform was considered identical to ICX platform. This
patch separates SPR support from ICX.

This patch is a preparation for adding SPR-specific package C-state limits
support.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 31 ++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..f9acb2af5bd8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2494,6 +2494,7 @@ int has_turbo_ratio_group_limits(int family, int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:
 	case INTEL_FAM6_ATOM_TREMONT_D:
 		return 1;
@@ -3746,6 +3747,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		has_misc_feature_control = 1;
 		break;
 	case INTEL_FAM6_ICELAKE_X:	/* ICX */
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 		pkg_cstate_limits = icx_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
@@ -3871,6 +3873,22 @@ int is_icx(unsigned int family, unsigned int model)
 	return 0;
 }
 
+int is_spr(unsigned int family, unsigned int model)
+{
+
+	if (!genuine_intel)
+		return 0;
+
+	if (family != 6)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+		return 1;
+	}
+	return 0;
+}
+
 int is_ehl(unsigned int family, unsigned int model)
 {
 	if (!genuine_intel)
@@ -3988,6 +4006,7 @@ int has_glm_turbo_ratio_limit(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		return 1;
 	default:
 		return 0;
@@ -4015,7 +4034,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ICELAKE_X:	/* ICX */
-
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
 		return 1;
 	default:
@@ -4486,6 +4505,7 @@ static double rapl_dram_energy_units_probe(int model, double rapl_energy_units)
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
 	case INTEL_FAM6_ICELAKE_X:	/* ICX */
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
@@ -4575,6 +4595,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ICELAKE_X:	/* ICX */
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
 		do_rapl =
 		    RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS |
@@ -4740,13 +4761,13 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 
 void automatic_cstate_conversion_probe(unsigned int family, unsigned int model)
 {
-	if (is_skx(family, model) || is_bdx(family, model) || is_icx(family, model))
+	if (is_skx(family, model) || is_bdx(family, model) || is_icx(family, model) || is_spr(family, model))
 		has_automatic_cstate_conversion = 1;
 }
 
 void prewake_cstate_probe(unsigned int family, unsigned int model)
 {
-	if (is_icx(family, model))
+	if (is_icx(family, model) || is_spr(family, model))
 		dis_cstate_prewake = 1;
 }
 
@@ -4975,6 +4996,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ICELAKE_X:	/* ICX */
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:	/* SPR */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
@@ -5367,7 +5389,6 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_ATOM_TREMONT;
 
 	case INTEL_FAM6_ICELAKE_D:
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 		return INTEL_FAM6_ICELAKE_X;
 	}
 	return model;
@@ -5654,7 +5675,7 @@ void process_cpuid()
 		BIC_NOT_PRESENT(BIC_Pkgpc7);
 		use_c1_residency_msr = 1;
 	}
-	if (is_skx(family, model) || is_icx(family, model)) {
+	if (is_skx(family, model) || is_icx(family, model) || is_spr(family, model)) {
 		BIC_NOT_PRESENT(BIC_CPU_c3);
 		BIC_NOT_PRESENT(BIC_Pkgpc3);
 		BIC_NOT_PRESENT(BIC_CPU_c7);
-- 
2.35.1

