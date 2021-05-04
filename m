Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60BA372C8A
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhEDOxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 10:53:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:58896 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhEDOxc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 May 2021 10:53:32 -0400
IronPort-SDR: mOvQqQHwPVq5M1b3myPkLh4/H9hMMlAzWwIiAdCM2/O1wtPsa9XBX0T4ZnsmnGYKcUnWo19SCo
 NUDZAs6wy4PQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="177535840"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="177535840"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 07:52:37 -0700
IronPort-SDR: /3CJVygitC5W6BiZk6/VqToTkswgRIqrwuceVxyiKxTrGToPuYBydgrzUUvx47QJdzhvo3Df5E
 iJBnsUbTP3oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="429081998"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2021 07:52:35 -0700
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] tools/power/turbostat: Remove Package C6 Retention on Ice Lake Server
Date:   Tue,  4 May 2021 17:52:34 +0300
Message-Id: <20210504145234.4103405-1-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

Currently the turbostat treats ICX the same way as SKX and shares the
code among them. But one difference is that ICX does not support Package
C6 Retention, unlike SKX and CLX.

So this patch:

1. Splitting SKX and ICX in turbostat.
2. Removing Package C6 Rentention for ICX.

And after this split, it would be easier to cutomize Ice Lake Server
in turbostat in the future.

Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 36 ++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ace100dd5a83..81afaff81f43 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2259,7 +2259,7 @@ int amt_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV,
 int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int glm_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__3, PCL__6, PCL__7, PCL_7S, PCL__8, PCL__9, PCL_10, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 int skx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
-
+int icx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL__6, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
 
 static void
 calculate_tsc_tweak()
@@ -2374,6 +2374,7 @@ int has_turbo_ratio_group_limits(int family, int model)
 	switch (model) {
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:
 	case INTEL_FAM6_ATOM_TREMONT_D:
 		return 1;
@@ -3613,6 +3614,10 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = skx_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
+	case INTEL_FAM6_ICELAKE_X:	/* ICX */
+		pkg_cstate_limits = icx_pkg_cstate_limits;
+		has_misc_feature_control = 1;
+		break;
 	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
 		no_MSR_MISC_PWR_MGMT = 1;
 	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
@@ -3701,6 +3706,20 @@ int is_skx(unsigned int family, unsigned int model)
 	}
 	return 0;
 }
+
+int is_icx(unsigned int family, unsigned int model)
+{
+
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_ICELAKE_X:
+		return 1;
+	}
+	return 0;
+}
+
 int is_ehl(unsigned int family, unsigned int model)
 {
 	if (!genuine_intel)
@@ -3803,6 +3822,7 @@ int has_glm_turbo_ratio_limit(unsigned int family, unsigned int model)
 	switch (model) {
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_FAM6_ICELAKE_X:
 		return 1;
 	default:
 		return 0;
@@ -3828,6 +3848,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
+	case INTEL_FAM6_ICELAKE_X:	/* ICX */
 
 	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
 		return 1;
@@ -4358,6 +4379,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
+	case INTEL_FAM6_ICELAKE_X:	/* ICX */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		BIC_PRESENT(BIC_PKG__);
@@ -4514,7 +4536,8 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 
 void automatic_cstate_conversion_probe(unsigned int family, unsigned int model)
 {
-	if (is_skx(family, model) || is_bdx(family, model))
+	if (is_skx(family, model) || is_bdx(family, model) ||
+	    is_icx(family, model))
 		has_automatic_cstate_conversion = 1;
 }
 
@@ -4729,6 +4752,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_L:		/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:		/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
+	case INTEL_FAM6_ICELAKE_X:		/* ICX */
 	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
@@ -5067,10 +5091,9 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_ATOM_TREMONT_L:
 		return INTEL_FAM6_ATOM_TREMONT;
 
-	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ICELAKE_D:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-		return INTEL_FAM6_SKYLAKE_X;
+		return INTEL_FAM6_ICELAKE_X;
 	}
 	return model;
 }
@@ -5180,8 +5203,9 @@ void process_cpuid()
 			edx_flags & (1 << 28) ? "HT" : "-",
 			edx_flags & (1 << 29) ? "TM" : "-");
 	}
-	if (genuine_intel)
+	if (genuine_intel) {
 		model = intel_model_duplicates(model);
+	}
 
 	if (!(edx_flags & (1 << 5)))
 		errx(1, "CPUID: no MSR");
@@ -5359,7 +5383,7 @@ void process_cpuid()
 		BIC_NOT_PRESENT(BIC_Pkgpc7);
 		use_c1_residency_msr = 1;
 	}
-	if (is_skx(family, model)) {
+	if (is_skx(family, model) || is_icx(family, model)) {
 		BIC_NOT_PRESENT(BIC_CPU_c3);
 		BIC_NOT_PRESENT(BIC_Pkgpc3);
 		BIC_NOT_PRESENT(BIC_CPU_c7);
-- 
2.29.2

