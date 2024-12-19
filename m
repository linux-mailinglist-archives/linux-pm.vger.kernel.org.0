Return-Path: <linux-pm+bounces-19551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD089F88BF
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 00:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CBD16A9F5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5FC1F7074;
	Thu, 19 Dec 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhlotYom"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A31EBFF8;
	Thu, 19 Dec 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652550; cv=none; b=XCHUoU8rV+Ek8hzsqWrjRFGK1sJpyxrS2/VhicDWL7R199gI20bNNtm0SBh3UGcxnWoeEE0T1hU9dP7lqmWb5LhPLARImShOSv9bGu03srjxbMQ1RVbYzO7dMKvXGfkNg+awhhxFmSAJ6AtzvuqKiKFEEQUst3Sqt3ZbS+pbooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652550; c=relaxed/simple;
	bh=6VeqRqyVw7EXgvi1MrkWVx5iq4HhOz9yrlX7ZAQoBwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkaETKmtPm3f9EJyxulpuhELvWdViOpljNhUpk5xu0Rt5zDkevB4wCjSDREawfWEqYBlcU2+0D8iq8CUqydLtsOo85fSIjA9v9OcZkYWnlY1n1gYHRZCgV+VgFzMZl+RiTNelNEQya4DWNtKtvlJcJQg6Cluh7avLxcRTkwWUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhlotYom; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734652549; x=1766188549;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6VeqRqyVw7EXgvi1MrkWVx5iq4HhOz9yrlX7ZAQoBwc=;
  b=ZhlotYomOsVJBed+j70wsKslu8au30ghFwxvbfDh4jO1xS9+7aRm32eC
   YCyyXh/QQkf8CojpSXcAAOo1nOyCx7I1lBFH7Mn3lAAN/zYVTsJz1Hm9Q
   cz2O2qs4l6x1hBfsChRpgVBsQFT2EJA/EyCQz67t+w/IpChMAhUsKMPNf
   +aewwf2UDzYMFl85oi+sY77i3NH7Y/3hSENUfw192+A7PwSyoiYqAjoxX
   NU0d2lUyRtOyByLmBHsVdClfzssWIA4pLhR5Q4vKLHoPRaRY5bcW9k+jY
   VLkvWT28Ph2PTHr+m+HgMXyiWj1/Lui+QkonxAKE31kOb2XHXXN725EE6
   w==;
X-CSE-ConnectionGUID: 6pefPToPQySKthBfzs71dw==
X-CSE-MsgGUID: hI+A+t+vQ9+Tsu49Jxd2pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="38975817"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="38975817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:47 -0800
X-CSE-ConnectionGUID: qxhTSraGQPOsYEwwKLnquw==
X-CSE-MsgGUID: Ec0s4iHqRh2Y/ox9WUqeaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="98745832"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:46 -0800
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
Subject: [PATCH v3 2/3] platform/x86:intel/pmc: Create generic_core_init() for all platforms
Date: Thu, 19 Dec 2024 15:55:39 -0800
Message-ID: <20241219235543.236592-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219235543.236592-1-xi.pardee@linux.intel.com>
References: <20241219235543.236592-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a generic_core_init() function for all architecture to reduce
duplicate code in each architecture file. Create an info structure
to catch the variations between each architecture and pass it to the
generic init function.

Convert all architectures to call the generic core init function.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  | 21 ++++--------
 drivers/platform/x86/intel/pmc/arl.c  | 47 ++++++++-------------------
 drivers/platform/x86/intel/pmc/cnp.c  | 21 ++++--------
 drivers/platform/x86/intel/pmc/core.c | 45 +++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h | 25 ++++++++++++++
 drivers/platform/x86/intel/pmc/icl.c  | 18 ++++------
 drivers/platform/x86/intel/pmc/lnl.c  | 24 +++++---------
 drivers/platform/x86/intel/pmc/mtl.c  | 45 +++++++------------------
 drivers/platform/x86/intel/pmc/spt.c  | 18 ++++------
 drivers/platform/x86/intel/pmc/tgl.c  | 31 +++++++++---------
 10 files changed, 145 insertions(+), 150 deletions(-)

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
index 05dec4f5019f3..137a1fdfee715 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -691,40 +691,19 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static struct pmc_dev_info arl_pmc_dev = {
+	.func = 0,
+	.ssram = true,
+	.dmu_guid = ARL_PMT_DMU_GUID,
+	.regmap_list = arl_pmc_info_list,
+	.map = &arl_socs_reg_map,
+	.fixup = arl_d3_fixup,
+	.suspend = cnl_suspend,
+	.resume = arl_resume,
+};
+
 int arl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
-	int ret;
-	int func = 0;
-	bool ssram_init = true;
-
-	arl_d3_fixup();
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
+
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
index 3e7f99ac8c941..8b73101dcfe95 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1344,6 +1344,51 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
+int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+{
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
+	void (*fixup)(void) = pmc_dev_info->fixup;
+	bool ssram;
+	int ret;
+
+	if (fixup)
+		fixup();
+
+	pmcdev->suspend = pmc_dev_info->suspend;
+	pmcdev->resume = pmc_dev_info->resume;
+
+	/*
+	 * If ssram init fails use legacy method to at least get the
+	 * primary PMC
+	 */
+	ssram = pmc_dev_info->ssram;
+	if (ssram) {
+		pmcdev->regmap_list = pmc_dev_info->regmap_list;
+		ret = pmc_core_ssram_init(pmcdev, pmc_dev_info->func);
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
index a1886d8e1ef3e..82be953db9463 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -436,6 +436,30 @@ enum pmc_index {
 	PMC_IDX_MAX
 };
 
+/**
+ * struct pmc_dev_info - Structure to keep pmc device info
+ * @func:		Function number of the primary pmc
+ * @ssram:		Bool shows if platform has ssram support
+ * @dmu_guid:		DMU GUID
+ * @regmap_list:	Pointer to a list of pmc_info structure that could be
+ *			available for the platform
+ * @map:		Pointer to a pmc_reg_map struct that contains platform
+ *			specific attributes of the primary pmc
+ * @fixup:		Function to perform platform specific fixup
+ * @suspend:		Function to perform platform specific suspend
+ * @resume:		Function to perform platform specific resume
+ */
+struct pmc_dev_info {
+	u8 func;
+	bool ssram;
+	u32 dmu_guid;
+	struct pmc_info *regmap_list;
+	const struct pmc_reg_map *map;
+	void (*fixup)(void);
+	void (*suspend)(struct pmc_dev *pmcdev);
+	int (*resume)(struct pmc_dev *pmcdev);
+};
+
 extern const struct pmc_bit_map msr_map[];
 extern const struct pmc_bit_map spt_pll_map[];
 extern const struct pmc_bit_map spt_mphy_map[];
@@ -592,6 +616,7 @@ extern void pmc_core_set_device_d3(unsigned int device);
 
 extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
 
+int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
 int icl_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 71b0fd6cb7d84..f044546e1aa5e 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -50,18 +50,12 @@ const struct pmc_reg_map icl_reg_map = {
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
+
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index be029f12cdf40..8f6b2a8d30438 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -550,22 +550,14 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static struct pmc_dev_info lnl_pmc_dev = {
+	.map = &lnl_socm_reg_map,
+	.fixup = lnl_d3_fixup,
+	.suspend = cnl_suspend,
+	.resume = lnl_resume,
+};
+
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
-	int ret;
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
-
-	lnl_d3_fixup();
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
index 02949fed76e91..b7a752e8adbc6 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -990,39 +990,18 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static struct pmc_dev_info mtl_pmc_dev = {
+	.func = 2,
+	.ssram = true,
+	.dmu_guid = MTL_PMT_DMU_GUID,
+	.regmap_list = mtl_pmc_info_list,
+	.map = &mtl_socm_reg_map,
+	.fixup = mtl_d3_fixup,
+	.suspend = cnl_suspend,
+	.resume = mtl_resume,
+};
+
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
-	int ret;
-	int func = 2;
-	bool ssram_init = true;
-
-	mtl_d3_fixup();
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
index ab993a69e33ee..09d3ce09af736 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -134,18 +134,12 @@ const struct pmc_reg_map spt_reg_map = {
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
+
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 4fec43d212d01..43a2aec4a5673 100644
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
+	ret = generic_core_init(pmcdev, &tgl_l_pmc_dev);
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


