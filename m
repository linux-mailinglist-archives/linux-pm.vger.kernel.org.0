Return-Path: <linux-pm+bounces-20171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C12A083F3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3107D7A27A5
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5161E0E08;
	Fri, 10 Jan 2025 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKDfHbyv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CF74E09;
	Fri, 10 Jan 2025 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468783; cv=none; b=d3eaEMTAu885JpNzfmssSQzt0SiDJSkwQ1UB7iASHFwOqZAR7lP5s3o71VDMBRvrXH3En0rVAcdl1JwOJHWJwld7K1/nxFvDginJRgKTD8dAZn7DTen5kWPAIVQdZwQMihKoLHR7kok/5FqGulPqZjRscCHBo6oa+w0YoofGmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468783; c=relaxed/simple;
	bh=/Coid9RXgij7omFqCHoPi58AJLg647MbYRd2eUBWt9o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0BMFmeBbkduACvyhelH9BoLeUt5K02J1BnEF9c/uyCbdTWOxIJc4AUb8pnvFUug9nVQ1bz2wxp9QgW2AFvY7NnIfSLNZ9/hOqisP2b3vfyX7bhlbNqdU8zOSzPnVHdjtKW9qUu0ROFwY2jtND6+R4mcgk+pXCh7QlnL7Bnxkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKDfHbyv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736468782; x=1768004782;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/Coid9RXgij7omFqCHoPi58AJLg647MbYRd2eUBWt9o=;
  b=MKDfHbyvIo/9yDeHVt41S508PRr6whTS6it+cmOoTV8+0DAhGu55dY3q
   bZGhYqJpG2EAm4P9IcO/kDyqnBFIIjg3tQ/D7Xxr1Ts6uKiGne4ugd1bA
   qZGvMKjlIHn4bZZdkNWPAIDPPXf2O4GbXgUfvtjZzrpJCgFm5eStzfaZb
   HujGFrKfEfNfy2nWv3qoWAGBOYG6gt09VUx3YQVa0c9D9WNC5kZEgbNRE
   I6/qzxagEH2vQl5Mt1apx7qq4/XzXvuQioFQj3o3R7Lt7E4mgf5132tis
   tvERq55e83VKYfRYPVcMQ6GRAHyRBOC+ERAOQL/cvcE3791rzMkY3MR87
   Q==;
X-CSE-ConnectionGUID: LSGm7KKSTEG3s31i1ghNvA==
X-CSE-MsgGUID: KIDPpf89QQW5fZzE17zuyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36653494"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36653494"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:20 -0800
X-CSE-ConnectionGUID: V/Ky/2eIRtKb3ajVdttMJw==
X-CSE-MsgGUID: MVxBd/HITgqKZVKd3Nw2sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104097033"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:20 -0800
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
Subject: [PATCH v4 5/6] platform/x86/intel/pmc: Remove init functions per architecture
Date: Thu,  9 Jan 2025 16:26:07 -0800
Message-ID: <20250110002612.244782-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110002612.244782-1-xi.pardee@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove all init functions for each architecture. The architecture
specific information for generic init function is stored in the
corresponding pmc_dev_info structure and this structure is stored
in X86_MATCH_VFM() instead of init function.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  |  7 +---
 drivers/platform/x86/intel/pmc/arl.c  |  7 +---
 drivers/platform/x86/intel/pmc/cnp.c  |  6 +--
 drivers/platform/x86/intel/pmc/core.c | 56 +++++++++++++--------------
 drivers/platform/x86/intel/pmc/core.h | 19 ++++-----
 drivers/platform/x86/intel/pmc/icl.c  |  7 +---
 drivers/platform/x86/intel/pmc/lnl.c  |  7 +---
 drivers/platform/x86/intel/pmc/mtl.c  |  7 +---
 drivers/platform/x86/intel/pmc/spt.c  |  7 +---
 drivers/platform/x86/intel/pmc/tgl.c  | 14 +------
 10 files changed, 47 insertions(+), 90 deletions(-)

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
index 9ff90d32a635f..a55381640c23b 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -691,7 +691,7 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
-static struct pmc_dev_info arl_pmc_dev = {
+struct pmc_dev_info arl_pmc_dev = {
 	.func = 0,
 	.dmu_guid = ARL_PMT_DMU_GUID,
 	.regmap_list = arl_pmc_info_list,
@@ -705,8 +705,3 @@ void arl_specific_init(struct pmc_dev *pmcdev)
 {
 	arl_d3_fixup();
 }
-
-int arl_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &arl_pmc_dev);
-}
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
index 45efe0e948831..d2ce52366b1c4 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1390,29 +1390,29 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
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
 
@@ -1496,7 +1496,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	static bool device_initialized;
 	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
-	int (*core_init)(struct pmc_dev *pmcdev);
+	struct pmc_dev_info *pmc_dev_info;
 	struct pmc *primary_pmc;
 	int ret;
 
@@ -1516,7 +1516,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!cpu_id)
 		return -ENODEV;
 
-	core_init = (int (*)(struct pmc_dev *))cpu_id->driver_data;
+	pmc_dev_info = (struct pmc_dev_info *)cpu_id->driver_data;
 
 	/* Primary PMC */
 	primary_pmc = devm_kzalloc(&pdev->dev, sizeof(*primary_pmc), GFP_KERNEL);
@@ -1538,11 +1538,11 @@ static int pmc_core_probe(struct platform_device *pdev)
 	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
 	 * in this case.
 	 */
-	if (core_init == spt_core_init && !pci_dev_present(pmc_pci_ids))
-		core_init = cnp_core_init;
+	if (pmc_dev_info == &spt_pmc_dev && !pci_dev_present(pmc_pci_ids))
+		pmc_dev_info = &cnp_pmc_dev;
 
 	mutex_init(&pmcdev->lock);
-	ret = core_init(pmcdev);
+	ret = generic_core_init(pmcdev, pmc_dev_info);
 	if (ret) {
 		pmc_core_clean_structure(pdev);
 		return ret;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 9430e4209ce97..771f06b193c66 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -615,15 +615,16 @@ extern void pmc_core_set_device_d3(unsigned int device);
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
 
 void arl_specific_init(struct pmc_dev *pmcdev);
 void mtl_specific_init(struct pmc_dev *pmcdev);
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
index 957d7a9062397..bbe707c37703f 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -550,7 +550,7 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
-static struct pmc_dev_info lnl_pmc_dev = {
+struct pmc_dev_info lnl_pmc_dev = {
 	.map = &lnl_socm_reg_map,
 	.suspend = cnl_suspend,
 	.resume = lnl_resume,
@@ -561,8 +561,3 @@ void lnl_specific_init(struct pmc_dev *pmcdev)
 {
 	lnl_d3_fixup();
 }
-
-int lnl_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &lnl_pmc_dev);
-}
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 2a7d79dd37d6a..fe10726962733 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -990,7 +990,7 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
-static struct pmc_dev_info mtl_pmc_dev = {
+struct pmc_dev_info mtl_pmc_dev = {
 	.func = 2,
 	.dmu_guid = MTL_PMT_DMU_GUID,
 	.regmap_list = mtl_pmc_info_list,
@@ -1004,8 +1004,3 @@ void mtl_specific_init(struct pmc_dev *pmcdev)
 {
 	mtl_d3_fixup();
 }
-
-int mtl_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &mtl_pmc_dev);
-}
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
index 29a9109afc782..c2f935cb29a7a 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -285,14 +285,14 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
-static struct pmc_dev_info tgl_l_pmc_dev = {
+struct pmc_dev_info tgl_l_pmc_dev = {
 	.map = &tgl_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
 	.arch_specific = tgl_specific_init,
 };
 
-static struct pmc_dev_info tgl_pmc_dev = {
+struct pmc_dev_info tgl_pmc_dev = {
 	.map = &tgl_h_reg_map,
 	.suspend = cnl_suspend,
 	.resume = cnl_resume,
@@ -303,13 +303,3 @@ void tgl_specific_init(struct pmc_dev *pmcdev)
 {
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
 }
-
-int tgl_l_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &tgl_l_pmc_dev);
-}
-
-int tgl_core_init(struct pmc_dev *pmcdev)
-{
-	return generic_core_init(pmcdev, &tgl_pmc_dev);
-}
-- 
2.43.0


