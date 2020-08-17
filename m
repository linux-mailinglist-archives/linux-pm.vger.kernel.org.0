Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9592468FF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgHQPDw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 11:03:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:11694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQPDv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 11:03:51 -0400
IronPort-SDR: vGdWbnySBWE8gjnuUinndkJx4XNZl3NMrlA93IL4uLL/h1IA9vCAkV7G3S1p/aPor8is8AcG5H
 fVz6L5PXwuCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="142554479"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="142554479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 08:03:50 -0700
IronPort-SDR: Gk6fFwOHFag2J3YYo/eqzmPCIarcxbk3hM6+P5/On4bzUD5KDCHT4tTicjgH3gHQfePuYSWAhw
 NyjyJLDIyLiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="370592521"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2020 08:03:49 -0700
From:   Antti Laakso <antti.laakso@linux.intel.com>
To:     linux-pm@vger.kernel.org
Cc:     lenb@kernel.org
Subject: [PATCH] tools/power turbostat: adjust columns for Jacobsville
Date:   Mon, 17 Aug 2020 18:03:48 +0300
Message-Id: <20200817150348.3976515-1-antti.laakso@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jacobsville doesn't have Package C2 and C6. Also
Core and DRAM RAPL are not available. Adjust output
accordingly.

Signed-off-by: Antti Laakso <antti.laakso@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 33 ++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..f210128f27a5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2173,6 +2173,7 @@ int has_turbo_ratio_group_limits(int family, int model)
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:
+	case INTEL_FAM6_ATOM_TREMONT_D:
 		return 1;
 	}
 	return 0;
@@ -3279,6 +3280,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 	case INTEL_FAM6_ATOM_TREMONT:	/* EHL */
+	case INTEL_FAM6_ATOM_TREMONT_D: /* JVL */
 		pkg_cstate_limits = glm_pkg_cstate_limits;
 		break;
 	default:
@@ -3361,6 +3363,17 @@ int is_ehl(unsigned int family, unsigned int model)
 	}
 	return 0;
 }
+int is_jvl(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_TREMONT_D:
+		return 1;
+	}
+	return 0;
+}
 
 int has_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
@@ -3959,6 +3972,14 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 			BIC_PRESENT(BIC_GFXWatt);
 		}
 		break;
+	case INTEL_FAM6_ATOM_TREMONT_D:	/* JVL */
+		do_rapl = RAPL_PKG | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
+		BIC_PRESENT(BIC_PKG__);
+		if (rapl_joules)
+			BIC_PRESENT(BIC_Pkg_J);
+		else
+			BIC_PRESENT(BIC_PkgWatt);
+		break;
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_GFX | RAPL_PKG_POWER_INFO;
@@ -4361,6 +4382,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
 	case INTEL_FAM6_ATOM_TREMONT:		/* EHL */
+	case INTEL_FAM6_ATOM_TREMONT_D:		/* JVL */
 		return 1;
 	}
 	return 0;
@@ -4687,9 +4709,6 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_TIGERLAKE:
 		return INTEL_FAM6_CANNONLAKE_L;
 
-	case INTEL_FAM6_ATOM_TREMONT_D:
-		return INTEL_FAM6_ATOM_GOLDMONT_D;
-
 	case INTEL_FAM6_ATOM_TREMONT_L:
 		return INTEL_FAM6_ATOM_TREMONT;
 
@@ -4916,6 +4935,14 @@ void process_cpuid()
 		BIC_PRESENT(BIC_Mod_c6);
 		use_c1_residency_msr = 1;
 	}
+	if (is_jvl(family, model)) {
+		BIC_NOT_PRESENT(BIC_CPU_c3);
+		BIC_NOT_PRESENT(BIC_CPU_c7);
+		BIC_NOT_PRESENT(BIC_Pkgpc2);
+		BIC_NOT_PRESENT(BIC_Pkgpc3);
+		BIC_NOT_PRESENT(BIC_Pkgpc6);
+		BIC_NOT_PRESENT(BIC_Pkgpc7);
+	}
 	if (is_dnv(family, model)) {
 		BIC_PRESENT(BIC_CPU_c1);
 		BIC_NOT_PRESENT(BIC_CPU_c3);
-- 
2.26.2

