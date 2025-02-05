Return-Path: <linux-pm+bounces-21357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88816A28017
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 01:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B0B7A2884
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 00:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB022338;
	Wed,  5 Feb 2025 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SynAupUj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2585227;
	Wed,  5 Feb 2025 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738714571; cv=none; b=nuoDkCe+9KbI042WRDxREeY5ra28sggqGYKng+rwbi33v2r9oF5wqBp65UQ+SQNf64hap3GKFM9GCywwP26DioWolNEfW6ciGkYXGQ3Y2DGKFsmgbVqWIf2uRlp+IzXULeWDJBfci5mnz7Q1acLqwiAt+j4vSuAbJNIwyJITcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738714571; c=relaxed/simple;
	bh=h0lDu/H9cE5gTRf2r1EgYwaFGoDSkaBMh1IcpJaTo5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKqQ5nYXk8aGpa6j+YJeUGU8zTbmPB1v3Kw9tsNQvADSRuVMPVfysyZbwkGPav/xLa63CrDeVK5UpU0IvzpCNZ+g5Vj+av2ymDlhMjNhSF57+kUrJD6lDrf6XVqjkuOpSNNnuzs7xGWibyZJmmVtzTHj1x2RbSCXqpQhuZXX3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SynAupUj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738714570; x=1770250570;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=h0lDu/H9cE5gTRf2r1EgYwaFGoDSkaBMh1IcpJaTo5g=;
  b=SynAupUjcjQU/u2eLPpG59djEYTz4rp5ia6Hdb+tQANSUw4+ytu3FTRC
   rGDnPvDjuYTpF8d3xOr9uA4VqT5xA7uRoL09wj4DXcXyxuybixuiWus23
   3X/ep3ucOpx5xXxNs0AMXRpa9X5/xNd5F5tcwM1nUgY3uwGR93ANL0mYx
   d5PJic2X2lqTwZCi2XptejhjenxlWez6fltC9dkLpf1Ba7wmEmmmtPVJJ
   F2Ff0+6ss9AaXxoCA5/fhl0yNboYJ75trBoLCoH1rm53YMgJB3aSUj/3k
   QBx2vfu36hQ7NweKQYfdBSRViraXw9bDPpuuYkHaMH61CuS5cLMZE+xfb
   g==;
X-CSE-ConnectionGUID: cd2OgixJTmaxK1XDXnv/2A==
X-CSE-MsgGUID: RZImsJKpQXq1FjtKfDHb+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39372367"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39372367"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:08 -0800
X-CSE-ConnectionGUID: g1b+VPP5Tq6Vy68RXBiCDA==
X-CSE-MsgGUID: r4MTNvU2T/W2ne7Zm3AySg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="110635695"
Received: from tfalcon-desk.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.214])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 16:16:06 -0800
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
Subject: [PATCH v5 4/5] platform/x86/intel/pmc: Remove simple init functions
Date: Tue,  4 Feb 2025 16:15:56 -0800
Message-ID: <20250205001601.689782-5-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205001601.689782-1-xi.pardee@linux.intel.com>
References: <20250205001601.689782-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove simple init functions to avoid duplicate code. Store
init function performing architecture specific action in the
corresponding pmc_dev_info structure. Replace init function
with pmc_dev_info structure in X86_MATCH_VFM() of core.c.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  |  7 +--
 drivers/platform/x86/intel/pmc/arl.c  |  7 +--
 drivers/platform/x86/intel/pmc/cnp.c  |  6 +--
 drivers/platform/x86/intel/pmc/core.c | 61 +++++++++++++++------------
 drivers/platform/x86/intel/pmc/core.h | 26 ++++++++----
 drivers/platform/x86/intel/pmc/icl.c  |  7 +--
 drivers/platform/x86/intel/pmc/lnl.c  |  7 +--
 drivers/platform/x86/intel/pmc/mtl.c  |  7 +--
 drivers/platform/x86/intel/pmc/spt.c  |  7 +--
 drivers/platform/x86/intel/pmc/tgl.c  | 19 +++------
 10 files changed, 72 insertions(+), 82 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index ac37f4ece9c70..de361a316d51d 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -311,13 +311,8 @@ const struct pmc_reg_map adl_reg_map = {
 	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
 };
 
-static struct pmc_dev_info adl_pmc_dev = {
+struct pmc_dev_info adl_pmc_dev = {
 	.map = &adl_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
 };
-
-int adl_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &adl_pmc_dev);
-}
diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 91f8e9ab1c2e6..2e604f934f068 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -691,17 +691,18 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
-static struct pmc_dev_info arl_pmc_dev = {
+struct pmc_dev_info arl_pmc_dev = {
 	.pci_func = 0,
 	.dmu_guid = ARL_PMT_DMU_GUID,
 	.regmap_list = arl_pmc_info_list,
 	.map = &arl_socs_reg_map,
 	.suspend = cnl_suspend,
 	.resume = arl_resume,
+	.init = arl_core_init,
 };
 
-int arl_core_init(struct pmc_dev *pmcdev)
+int arl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	arl_d3_fixup();
-	return generic_core_init(pmcdev, &arl_pmc_dev);
+	return generic_core_init(pmcdev, pmc_dev_info);
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 6d268058e40b9..f147ec51c7fd0 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -274,13 +274,9 @@ int cnl_resume(struct pmc_dev *pmcdev)
 	return pmc_core_resume_common(pmcdev);
 }
 
-static struct pmc_dev_info cnp_pmc_dev = {
+struct pmc_dev_info cnp_pmc_dev = {
 	.map = &cnp_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
 };
 
-int cnp_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &cnp_pmc_dev);
-}
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index d1cbf49ce5bc9..628cb22221fbc 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1388,29 +1388,29 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 }
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	X86_MATCH_VFM(INTEL_SKYLAKE_L,		spt_core_init),
-	X86_MATCH_VFM(INTEL_SKYLAKE,		spt_core_init),
-	X86_MATCH_VFM(INTEL_KABYLAKE_L,		spt_core_init),
-	X86_MATCH_VFM(INTEL_KABYLAKE,		spt_core_init),
-	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	cnp_core_init),
-	X86_MATCH_VFM(INTEL_ICELAKE_L,		icl_core_init),
-	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	icl_core_init),
-	X86_MATCH_VFM(INTEL_COMETLAKE,		cnp_core_init),
-	X86_MATCH_VFM(INTEL_COMETLAKE_L,	cnp_core_init),
-	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	tgl_l_core_init),
-	X86_MATCH_VFM(INTEL_TIGERLAKE,		tgl_core_init),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	tgl_l_core_init),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	icl_core_init),
-	X86_MATCH_VFM(INTEL_ROCKETLAKE,		tgl_core_init),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	tgl_l_core_init),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	tgl_l_core_init),
-	X86_MATCH_VFM(INTEL_ALDERLAKE,		adl_core_init),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	tgl_l_core_init),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,		adl_core_init),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
-	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
-	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
-	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&spt_pmc_dev),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&spt_pmc_dev),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&spt_pmc_dev),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&spt_pmc_dev),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&cnp_pmc_dev),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_pmc_dev),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	&icl_pmc_dev),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&cnp_pmc_dev),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&cnp_pmc_dev),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&tgl_l_pmc_dev),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&tgl_pmc_dev),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&tgl_l_pmc_dev),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&icl_pmc_dev),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&tgl_pmc_dev),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&tgl_l_pmc_dev),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&tgl_l_pmc_dev),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&adl_pmc_dev),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,	&tgl_l_pmc_dev),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&adl_pmc_dev),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_pmc_dev),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_pmc_dev),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&arl_pmc_dev),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_pmc_dev),
 	{}
 };
 
@@ -1494,7 +1494,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	static bool device_initialized;
 	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
-	int (*core_init)(struct pmc_dev *pmcdev);
+	struct pmc_dev_info *pmc_dev_info;
 	struct pmc *primary_pmc;
 	int ret;
 
@@ -1514,7 +1514,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!cpu_id)
 		return -ENODEV;
 
-	core_init = (int (*)(struct pmc_dev *))cpu_id->driver_data;
+	pmc_dev_info = (struct pmc_dev_info *)cpu_id->driver_data;
 
 	/* Primary PMC */
 	primary_pmc = devm_kzalloc(&pdev->dev, sizeof(*primary_pmc), GFP_KERNEL);
@@ -1536,11 +1536,16 @@ static int pmc_core_probe(struct platform_device *pdev)
 	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
 	 * in this case.
 	 */
-	if (core_init == spt_core_init && !pci_dev_present(pmc_pci_ids))
-		core_init = cnp_core_init;
+	if (pmc_dev_info == &spt_pmc_dev && !pci_dev_present(pmc_pci_ids))
+		pmc_dev_info = &cnp_pmc_dev;
 
 	mutex_init(&pmcdev->lock);
-	ret = core_init(pmcdev);
+
+	if (pmc_dev_info->init)
+		ret = pmc_dev_info->init(pmcdev, pmc_dev_info);
+	else
+		ret = generic_core_init(pmcdev, pmc_dev_info);
+
 	if (ret) {
 		pmc_core_clean_structure(pdev);
 		return ret;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 7c9e999ee6318..94039930422b3 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -446,6 +446,7 @@ enum pmc_index {
  *			specific attributes of the primary PMC
  * @suspend:		Function to perform platform specific suspend
  * @resume:		Function to perform platform specific resume
+ * @init:		Function to perform platform specific init action
  */
 struct pmc_dev_info {
 	u8 pci_func;
@@ -454,6 +455,7 @@ struct pmc_dev_info {
 	const struct pmc_reg_map *map;
 	void (*suspend)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
+	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 };
 
 extern const struct pmc_bit_map msr_map[];
@@ -613,15 +615,21 @@ extern void pmc_core_set_device_d3(unsigned int device);
 extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
 
 int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
-int spt_core_init(struct pmc_dev *pmcdev);
-int cnp_core_init(struct pmc_dev *pmcdev);
-int icl_core_init(struct pmc_dev *pmcdev);
-int tgl_core_init(struct pmc_dev *pmcdev);
-int tgl_l_core_init(struct pmc_dev *pmcdev);
-int adl_core_init(struct pmc_dev *pmcdev);
-int mtl_core_init(struct pmc_dev *pmcdev);
-int arl_core_init(struct pmc_dev *pmcdev);
-int lnl_core_init(struct pmc_dev *pmcdev);
+
+extern struct pmc_dev_info spt_pmc_dev;
+extern struct pmc_dev_info cnp_pmc_dev;
+extern struct pmc_dev_info icl_pmc_dev;
+extern struct pmc_dev_info tgl_l_pmc_dev;
+extern struct pmc_dev_info tgl_pmc_dev;
+extern struct pmc_dev_info adl_pmc_dev;
+extern struct pmc_dev_info mtl_pmc_dev;
+extern struct pmc_dev_info arl_pmc_dev;
+extern struct pmc_dev_info lnl_pmc_dev;
+
+int arl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
+int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
+int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
+int tgl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 
 void cnl_suspend(struct pmc_dev *pmcdev);
 int cnl_resume(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 0e4565dea0452..6952c8ef58a01 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -50,11 +50,6 @@ const struct pmc_reg_map icl_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
-static struct pmc_dev_info icl_pmc_dev = {
+struct pmc_dev_info icl_pmc_dev = {
 	.map = &icl_reg_map,
 };
-
-int icl_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &icl_pmc_dev);
-}
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 1142e65225be7..519b4b0e325e1 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -550,14 +550,15 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
-static struct pmc_dev_info lnl_pmc_dev = {
+struct pmc_dev_info lnl_pmc_dev = {
 	.map = &lnl_socm_reg_map,
 	.suspend = cnl_suspend,
 	.resume = lnl_resume,
+	.init = lnl_core_init,
 };
 
-int lnl_core_init(struct pmc_dev *pmcdev)
+int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	lnl_d3_fixup();
-	return generic_core_init(pmcdev, &lnl_pmc_dev);
+	return generic_core_init(pmcdev, pmc_dev_info);
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 28ea8fe8a493f..0678df8fb5e3c 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -990,17 +990,18 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
-static struct pmc_dev_info mtl_pmc_dev = {
+struct pmc_dev_info mtl_pmc_dev = {
 	.pci_func = 2,
 	.dmu_guid = MTL_PMT_DMU_GUID,
 	.regmap_list = mtl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
 	.suspend = cnl_suspend,
 	.resume = mtl_resume,
+	.init = mtl_core_init,
 };
 
-int mtl_core_init(struct pmc_dev *pmcdev)
+int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	mtl_d3_fixup();
-	return generic_core_init(pmcdev, &mtl_pmc_dev);
+	return generic_core_init(pmcdev, pmc_dev_info);
 }
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index ab5f66fcb0c30..956b2ec1c7510 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -134,11 +134,6 @@ const struct pmc_reg_map spt_reg_map = {
 	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
 
-static struct pmc_dev_info spt_pmc_dev = {
+struct pmc_dev_info spt_pmc_dev = {
 	.map = &spt_reg_map,
 };
-
-int spt_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &spt_pmc_dev);
-}
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index bc3cb949c672e..9f210d4095bd9 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -285,19 +285,21 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
-static struct pmc_dev_info tgl_l_pmc_dev = {
+struct pmc_dev_info tgl_l_pmc_dev = {
 	.map = &tgl_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
+	.init = tgl_core_init,
 };
 
-static struct pmc_dev_info tgl_pmc_dev = {
+struct pmc_dev_info tgl_pmc_dev = {
 	.map = &tgl_h_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
+	.init = tgl_core_init,
 };
 
-static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+int tgl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	int ret;
 
@@ -306,15 +308,6 @@ static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pm
 		return ret;
 
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
-	return 0;
-}
 
-int tgl_l_core_init(struct pmc_dev *pmcdev)
-{
-	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
-}
-
-int tgl_core_init(struct pmc_dev *pmcdev)
-{
-	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
+	return 0;
 }
-- 
2.43.0


