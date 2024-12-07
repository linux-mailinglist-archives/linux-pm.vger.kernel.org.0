Return-Path: <linux-pm+bounces-18734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBADF9E7E62
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 06:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2F21886A22
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 05:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05D13B2B6;
	Sat,  7 Dec 2024 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM1qZEbA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F137112E1CD;
	Sat,  7 Dec 2024 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549778; cv=none; b=ru3Phdb5zbko3TN0vfeb3+3I5tkQuk/lF3FaslLERaljH5Vumw/yM1uXRuTSaUs+JeefXHT9VG+WOASrIUTeHGJWZ1IbBXrQw0Os+fG1BW5EYpurMaHybQDRb5L267SAxw73LR3rTGWMKCqxjmXSLKpjh1zVv8vHvnCgPirADj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549778; c=relaxed/simple;
	bh=ZDnid7P/ElsWL/SYsOcVI6Pqhb0ywhKCOnvLannCwmI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UT+wMGY2WhOrNmF5NlK5nVBw30RvNuPrVpNmHsDe3XukIOwlayM/ERCdZxcYNVtbyR4KIOC4liuFCGFFGG43qpKQAvDUgIacsvwb5bJOBN0e3pvNP/YLHet0zgIBfAN8l1Isd1fkX+6nhFVzaOKHR56ZxC0hP96xyvjYcMpWCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM1qZEbA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733549777; x=1765085777;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ZDnid7P/ElsWL/SYsOcVI6Pqhb0ywhKCOnvLannCwmI=;
  b=QM1qZEbAki9goXBBanISiQOiFo0kBlq8IN1keNmr45uY8f/lQ+kOEBU/
   E6ZoQQ9AQTvIKUhN0ubIxpYJxl2qyuf0DH7nPXQiBEtpWGm5iQX+DJIH6
   Z1Yo/kxnXgVDshmCknJiA6gXUnyJpDqkSR+fKrgQajhqxr21RyLmrVdO3
   R6lyrz+KvPI1DE4aiLL1orIY/8PfvIcFo5jkDIYTRJj1fpC3pblO+rol5
   qY7JBA8aCLRSbdGDx+1aOVEOuYlWjRiBwRlxXsbsUEOgNlgVmTSe+Hnp2
   K17Ip3nzTymZwE3xKh12iBPK1UAI/sCODBXlaGNFDn5eKE4wXZRFUO1qy
   w==;
X-CSE-ConnectionGUID: ByUnqraBTOOHqVrfxsz1LA==
X-CSE-MsgGUID: VFqwe91gRJa5qJKHQgjvqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37590273"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="37590273"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:17 -0800
X-CSE-ConnectionGUID: PUfuc2ePRdyB8GKKXxOx8w==
X-CSE-MsgGUID: JGa0J1oaT0K+H2fqNdVu8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="99543371"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.37])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:16 -0800
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
Subject: [PATCH 3/3] platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core driver
Date: Fri,  6 Dec 2024 21:35:53 -0800
Message-ID: <20241207053607.14806-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241207053607.14806-1-xi.pardee@linux.intel.com>
References: <20241207053607.14806-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Arrow Lake U and Arrow Lake H support in intel_pmc_core driver.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 64 +++++++++++++++++++++++----
 drivers/platform/x86/intel/pmc/core.c |  2 +
 drivers/platform/x86/intel/pmc/core.h |  1 +
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 05dec4f5019f3..d16e1dea63e7d 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -16,6 +16,7 @@
 #define IOEP_LPM_REQ_GUID	0x5077612
 #define SOCS_LPM_REQ_GUID	0x8478657
 #define PCHS_LPM_REQ_GUID	0x9684572
+#define SOCM_LPM_REQ_GUID	0x2625030
 
 static const u8 ARL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
 
@@ -650,6 +651,7 @@ const struct pmc_reg_map arl_pchs_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+#define PMC_DEVID_SOCM 0x777f
 #define PMC_DEVID_SOCS 0xae7f
 #define PMC_DEVID_IOEP 0x7ecf
 #define PMC_DEVID_PCHS 0x7f27
@@ -669,11 +671,17 @@ static struct pmc_info arl_pmc_info_list[] = {
 		.devid	= PMC_DEVID_PCHS,
 		.map	= &arl_pchs_reg_map,
 	},
+	{
+		.guid	= SOCM_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_SOCM,
+		.map	= &mtl_socm_reg_map,
+	},
 	{}
 };
 
 #define ARL_NPU_PCI_DEV			0xad1d
 #define ARL_GNA_PCI_DEV			0xae4c
+#define ARL_H_GNA_PCI_DEV		0x774c
 /*
  * Set power state of select devices that do not have drivers to D3
  * so that they do not block Package C entry.
@@ -684,6 +692,12 @@ static void arl_d3_fixup(void)
 	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
 }
 
+static void arl_h_d3_fixup(void)
+{
+	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
+	pmc_core_set_device_d3(ARL_H_GNA_PCI_DEV);
+}
+
 static int arl_resume(struct pmc_dev *pmcdev)
 {
 	arl_d3_fixup();
@@ -691,26 +705,46 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
-int arl_core_init(struct pmc_dev *pmcdev)
+static int arl_h_resume(struct pmc_dev *pmcdev)
+{
+	arl_h_d3_fixup();
+
+	return cnl_resume(pmcdev);
+}
+
+static struct pmc_dev_info arl_pmc_dev = {
+	.func = 0,
+	.map = &arl_socs_reg_map,
+	.suspend = cnl_suspend,
+	.resume = arl_resume,
+};
+
+static struct pmc_dev_info arl_h_pmc_dev = {
+	.func = 2,
+	.map = &mtl_socm_reg_map,
+	.suspend = cnl_suspend,
+	.resume = arl_h_resume,
+};
+
+static int arl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 	int ret;
-	int func = 0;
 	bool ssram_init = true;
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+
+	pmcdev->suspend = pmc_dev_info->suspend;
+	pmcdev->resume = pmc_dev_info->resume;
 
-	arl_d3_fixup();
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = arl_resume;
 	pmcdev->regmap_list = arl_pmc_info_list;
 
 	/*
 	 * If ssram init fails use legacy method to at least get the
 	 * primary PMC
 	 */
-	ret = pmc_core_ssram_init(pmcdev, func);
+	ret = pmc_core_ssram_init(pmcdev, pmc_dev_info->func);
 	if (ret) {
 		ssram_init = false;
-		pmc->map = &arl_socs_reg_map;
+		pmc->map = pmc_dev_info->map;
 
 		ret = get_primary_reg_base(pmc);
 		if (ret)
@@ -728,3 +762,17 @@ int arl_core_init(struct pmc_dev *pmcdev)
 
 	return 0;
 }
+
+int arl_h_core_init(struct pmc_dev *pmcdev)
+{
+	arl_h_d3_fixup();
+
+	return arl_core_generic_init(pmcdev, &arl_h_pmc_dev);
+}
+
+int arl_core_init(struct pmc_dev *pmcdev)
+{
+	arl_d3_fixup();
+
+	return arl_core_generic_init(pmcdev, &arl_pmc_dev);
+}
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3e7f99ac8c941..fbc43e090e7cc 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1367,6 +1367,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	arl_h_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	arl_h_core_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
 	{}
 };
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 3124315d2b925..76ef2f56d897b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -615,6 +615,7 @@ int tgl_l_core_init(struct pmc_dev *pmcdev);
 int adl_core_init(struct pmc_dev *pmcdev);
 int mtl_core_init(struct pmc_dev *pmcdev);
 int arl_core_init(struct pmc_dev *pmcdev);
+int arl_h_core_init(struct pmc_dev *pmcdev);
 int lnl_core_init(struct pmc_dev *pmcdev);
 
 void cnl_suspend(struct pmc_dev *pmcdev);
-- 
2.43.0


