Return-Path: <linux-pm+bounces-21572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507AFA2D114
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE26188F821
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E21DE3A4;
	Fri,  7 Feb 2025 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVq1UAcG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D101DDC3F;
	Fri,  7 Feb 2025 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968987; cv=none; b=BjD7FNRp5tba2s3Sd1qxkV3Fz8pfWrjJTPF5Iyuq/YY7mAS00kJCqZwa8JiF0R9Xq10O8l2kWxeWtTh99ezsEi8rPfRAc2n2oLKibE2gGZE73P9wIzYVx7vuiA/nM5DG6gR6w886Qdo2Z/z3egK8K57isbUF+ALHN1Gqr1cclfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968987; c=relaxed/simple;
	bh=ji14hv8lLadA3/v0WxfISu9PQKrkITVpdQnF3nKJ30A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLvroJvCswR7dKlElY9I4uRPCFGXgKQph9u24J1dws4p41X2BE5S73dMN5QEH0LlcNRz9j198Ludgc0wwRLWli4qL7RmHOh0OMXouuoD9mi5Asy2hFYTtXLI1A2VRNPGCcv62ecPjjN6jV6TprONOG01jW2tNrjVwTJ4WJrUNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVq1UAcG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738968985; x=1770504985;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ji14hv8lLadA3/v0WxfISu9PQKrkITVpdQnF3nKJ30A=;
  b=SVq1UAcGh2G5GLg2zqgFl2cHzVjQFjlrNjdnXZq+1CBAwbWNDk4JCAbn
   H0FMsdRJfhTdwoKlGVSUFMtXXSkijZN5kHtIqWeAdW+HBqzXlcVGESxUd
   4jBNTTAlh1R+CYABE3iY34zbxhgSxX1bualfOxI1LuJdPteaXK9h3310+
   gHzWcsIw01dGiE4LulSJMlKvdXqY6oosnJzEefGrZ0f9L+G2GMfSedJxr
   HbGAQTkcmY3xY7N7yt2pin21sj20WYfb/rNnQTNSfkBw+Hj2nY/1qDR+a
   Nilj9gKlBvBDGfZ/uZTsqyVKvFMd0dVDYvmW7vgsoIbEE241PiUFobYKs
   w==;
X-CSE-ConnectionGUID: RVVIqLdpTY2A6t8yFQh+CA==
X-CSE-MsgGUID: vMvJYm92TPiDICmUzXoDEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38855821"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38855821"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:24 -0800
X-CSE-ConnectionGUID: cTuxsyaASAyJgOscUTTRXQ==
X-CSE-MsgGUID: ZxruSqlASPqV8yzhToVhYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111421997"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:22 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 3/6] platform/x86:intel/pmc: Create generic_core_init() for all platforms
Date: Fri,  7 Feb 2025 14:56:09 -0800
Message-ID: <20250207225615.401235-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207225615.401235-1-xi.pardee@linux.intel.com>
References: <20250207225615.401235-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a generic_core_init() function for all architectures to reduce
duplicate code in each architecture file. Create an info structure
to catch the variations between each architecture and pass it to the
generic init function.

Convert all architectures to call the generic core init function.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  | 21 +++++--------
 drivers/platform/x86/intel/pmc/arl.c  | 43 +++++++--------------------
 drivers/platform/x86/intel/pmc/cnp.c  | 21 +++++--------
 drivers/platform/x86/intel/pmc/core.c | 42 ++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h | 22 ++++++++++++++
 drivers/platform/x86/intel/pmc/icl.c  | 17 ++++-------
 drivers/platform/x86/intel/pmc/lnl.c  | 22 +++++---------
 drivers/platform/x86/intel/pmc/mtl.c  | 42 +++++++-------------------
 drivers/platform/x86/intel/pmc/spt.c  | 17 ++++-------
 drivers/platform/x86/intel/pmc/tgl.c  | 31 +++++++++----------
 10 files changed, 131 insertions(+), 147 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index e7878558fd909..ac37f4ece9c70 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -311,20 +311,13 @@ const struct pmc_reg_map adl_reg_map = {
 	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
 };
 
+static struct pmc_dev_info adl_pmc_dev = {
+	.map = &adl_reg_map,
+	.suspend = cnl_suspend,
+	.resume = cnl_resume,
+};
+
 int adl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	int ret;
-
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = cnl_resume;
-
-	pmc->map = &adl_reg_map;
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
-
-	pmc_core_get_low_power_modes(pmcdev);
-
-	return 0;
+	return generic_core_init(pmcdev, &adl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index ad976cc83ecae..91f8e9ab1c2e6 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -691,40 +691,17 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static struct pmc_dev_info arl_pmc_dev = {
+	.pci_func = 0,
+	.dmu_guid = ARL_PMT_DMU_GUID,
+	.regmap_list = arl_pmc_info_list,
+	.map = &arl_socs_reg_map,
+	.suspend = cnl_suspend,
+	.resume = arl_resume,
+};
+
 int arl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	int ret;
-	int func = 0;
-	bool ssram_init = true;
-
 	arl_d3_fixup();
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = arl_resume;
-	pmcdev->regmap_list = arl_pmc_info_list;
-
-	/*
-	 * If ssram init fails use legacy method to at least get the
-	 * primary PMC
-	 */
-	ret = pmc_core_ssram_init(pmcdev, func);
-	if (ret) {
-		ssram_init = false;
-		pmc->map = &arl_socs_reg_map;
-
-		ret = get_primary_reg_base(pmc);
-		if (ret)
-			return ret;
-	}
-
-	pmc_core_get_low_power_modes(pmcdev);
-	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
-
-	if (ssram_init)	{
-		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return generic_core_init(pmcdev, &arl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index fc5193fdf8a88..6d268058e40b9 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -274,20 +274,13 @@ int cnl_resume(struct pmc_dev *pmcdev)
 	return pmc_core_resume_common(pmcdev);
 }
 
+static struct pmc_dev_info cnp_pmc_dev = {
+	.map = &cnp_reg_map,
+	.suspend = cnl_suspend,
+	.resume = cnl_resume,
+};
+
 int cnp_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	int ret;
-
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = cnl_resume;
-
-	pmc->map = &cnp_reg_map;
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
-
-	pmc_core_get_low_power_modes(pmcdev);
-
-	return 0;
+	return generic_core_init(pmcdev, &cnp_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 10f04b9441174..d1cbf49ce5bc9 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1345,6 +1345,48 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
+/*
+ * When supported, ssram init is used to achieve all available PMCs.
+ * If ssram init fails, this function uses legacy method to at least get the
+ * primary PMC.
+ */
+int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+{
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	bool ssram;
+	int ret;
+
+	pmcdev->suspend = pmc_dev_info->suspend;
+	pmcdev->resume = pmc_dev_info->resume;
+
+	ssram = pmc_dev_info->regmap_list != NULL;
+	if (ssram) {
+		pmcdev->regmap_list = pmc_dev_info->regmap_list;
+		ret = pmc_core_ssram_init(pmcdev, pmc_dev_info->pci_func);
+		if (ret) {
+			dev_warn(&pmcdev->pdev->dev,
+				 "ssram init failed, %d, using legacy init\n", ret);
+			ssram = false;
+		}
+	}
+
+	if (!ssram) {
+		pmc->map = pmc_dev_info->map;
+		ret = get_primary_reg_base(pmc);
+		if (ret)
+			return ret;
+	}
+
+	pmc_core_get_low_power_modes(pmcdev);
+	if (pmc_dev_info->dmu_guid)
+		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
+
+	if (ssram)
+		return pmc_core_ssram_get_lpm_reqs(pmcdev);
+
+	return 0;
+}
+
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_SKYLAKE_L,		spt_core_init),
 	X86_MATCH_VFM(INTEL_SKYLAKE,		spt_core_init),
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a0f6cc427ddca..7c9e999ee6318 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -435,6 +435,27 @@ enum pmc_index {
 	PMC_IDX_MAX
 };
 
+/**
+ * struct pmc_dev_info - Structure to keep PMC device info
+ * @pci_func:		Function number of the primary PMC
+ * @dmu_guid:		Die Management Unit GUID
+ * @regmap_list:	Pointer to a list of pmc_info structure that could be
+ *			available for the platform. When set, this field implies
+ *			SSRAM support.
+ * @map:		Pointer to a pmc_reg_map struct that contains platform
+ *			specific attributes of the primary PMC
+ * @suspend:		Function to perform platform specific suspend
+ * @resume:		Function to perform platform specific resume
+ */
+struct pmc_dev_info {
+	u8 pci_func;
+	u32 dmu_guid;
+	struct pmc_info *regmap_list;
+	const struct pmc_reg_map *map;
+	void (*suspend)(struct pmc_dev *pmcdev);
+	int (*resume)(struct pmc_dev *pmcdev);
+};
+
 extern const struct pmc_bit_map msr_map[];
 extern const struct pmc_bit_map spt_pll_map[];
 extern const struct pmc_bit_map spt_mphy_map[];
@@ -591,6 +612,7 @@ extern void pmc_core_set_device_d3(unsigned int device);
 
 extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
 
+int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
 int icl_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 71b0fd6cb7d84..0e4565dea0452 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -50,18 +50,11 @@ const struct pmc_reg_map icl_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+static struct pmc_dev_info icl_pmc_dev = {
+	.map = &icl_reg_map,
+};
+
 int icl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	int ret;
-
-	pmc->map = &icl_reg_map;
-
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
-
-	pmc_core_get_low_power_modes(pmcdev);
-
-	return ret;
+	return generic_core_init(pmcdev, &icl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 09b13df90d685..1142e65225be7 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -550,22 +550,14 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static struct pmc_dev_info lnl_pmc_dev = {
+	.map = &lnl_socm_reg_map,
+	.suspend = cnl_suspend,
+	.resume = lnl_resume,
+};
+
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
-	int ret;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-
 	lnl_d3_fixup();
-
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = lnl_resume;
-
-	pmc->map = &lnl_socm_reg_map;
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
-
-	pmc_core_get_low_power_modes(pmcdev);
-
-	return 0;
+	return generic_core_init(pmcdev, &lnl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 07687a3e436d5..28ea8fe8a493f 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -990,39 +990,17 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static struct pmc_dev_info mtl_pmc_dev = {
+	.pci_func = 2,
+	.dmu_guid = MTL_PMT_DMU_GUID,
+	.regmap_list = mtl_pmc_info_list,
+	.map = &mtl_socm_reg_map,
+	.suspend = cnl_suspend,
+	.resume = mtl_resume,
+};
+
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	int ret;
-	int func = 2;
-	bool ssram_init = true;
-
 	mtl_d3_fixup();
-
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = mtl_resume;
-	pmcdev->regmap_list = mtl_pmc_info_list;
-
-	/*
-	 * If ssram init fails use legacy method to at least get the
-	 * primary PMC
-	 */
-	ret = pmc_core_ssram_init(pmcdev, func);
-	if (ret) {
-		ssram_init = false;
-		dev_warn(&pmcdev->pdev->dev,
-			 "ssram init failed, %d, using legacy init\n", ret);
-		pmc->map = &mtl_socm_reg_map;
-		ret = get_primary_reg_base(pmc);
-		if (ret)
-			return ret;
-	}
-
-	pmc_core_get_low_power_modes(pmcdev);
-	pmc_core_punit_pmt_init(pmcdev, MTL_PMT_DMU_GUID);
-
-	if (ssram_init)
-		return pmc_core_ssram_get_lpm_reqs(pmcdev);
-
-	return 0;
+	return generic_core_init(pmcdev, &mtl_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index ab993a69e33ee..ab5f66fcb0c30 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -134,18 +134,11 @@ const struct pmc_reg_map spt_reg_map = {
 	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
 
+static struct pmc_dev_info spt_pmc_dev = {
+	.map = &spt_reg_map,
+};
+
 int spt_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	int ret;
-
-	pmc->map = &spt_reg_map;
-
-	ret = get_primary_reg_base(pmc);
-	if (ret)
-		return ret;
-
-	pmc_core_get_low_power_modes(pmcdev);
-
-	return ret;
+	return generic_core_init(pmcdev, &spt_pmc_dev);
 }
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 4fec43d212d01..bc3cb949c672e 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -285,35 +285,36 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
-static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
-{
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
-	int ret;
+static struct pmc_dev_info tgl_l_pmc_dev = {
+	.map = &tgl_reg_map,
+	.suspend = cnl_suspend,
+	.resume = cnl_resume,
+};
 
-	if (pch_tp == PCH_H)
-		pmc->map = &tgl_h_reg_map;
-	else
-		pmc->map = &tgl_reg_map;
+static struct pmc_dev_info tgl_pmc_dev = {
+	.map = &tgl_h_reg_map,
+	.suspend = cnl_suspend,
+	.resume = cnl_resume,
+};
 
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = cnl_resume;
+static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+{
+	int ret;
 
-	ret = get_primary_reg_base(pmc);
+	ret = generic_core_init(pmcdev, pmc_dev_info);
 	if (ret)
 		return ret;
 
-	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
-
 	return 0;
 }
 
 int tgl_l_core_init(struct pmc_dev *pmcdev)
 {
-	return tgl_core_generic_init(pmcdev, PCH_LP);
+	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
 }
 
 int tgl_core_init(struct pmc_dev *pmcdev)
 {
-	return tgl_core_generic_init(pmcdev, PCH_H);
+	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
 }
-- 
2.43.0


