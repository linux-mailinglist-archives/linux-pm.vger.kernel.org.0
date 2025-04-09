Return-Path: <linux-pm+bounces-25043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C243A8302D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258E83A9FF9
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9EA27CB0C;
	Wed,  9 Apr 2025 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXFbB2t0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6D27BF8E;
	Wed,  9 Apr 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225868; cv=none; b=s5fUEcTVdqSAzP9jydCZzG9IoqhDWX2yx3/x843lhICfOMp3MzGvuUqzQv/MDGoIKTvClW7QqUz+VUktSRi9F/h2gZBov9sKDzIL8tExj+ZaLpLfH+/z/5cYUi2Bt6GyvSIGlsebzH8qAH3C4Qax0jCCDEMZxqej+cPXBet6V6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225868; c=relaxed/simple;
	bh=yEpXj1HkRH7ifUKlI9+h2ntdAnOhvdHxkfvdoacKOPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQTlCOeMr81rKdm5x6+RTxYhmZockJJa3St6NifQ2QNQkuchFutLpvrFCp4+LMApggaQw4v9INnLlQhYknWbYhpYxN7/iCNPQXyMhC5dQFgANDLtZPvaQzcYFoMWgkcAl1FAYI0RGP6Av5IjYih59zrdH1/ieIdAIo5F+IC+lrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXFbB2t0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225867; x=1775761867;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yEpXj1HkRH7ifUKlI9+h2ntdAnOhvdHxkfvdoacKOPE=;
  b=SXFbB2t07w57T3OgBngXEd2Rqneq3zUEbOVB2U8WmVm4Tq3lvDO0Q5kk
   A/JGD5vnrIGWw0ZSUbd/DSPz6M6IUYMbc5WbGVOe6cQM7sCIo8o2nNj7l
   fan+Qa2gIvnvTMQTwK9OklLdVLS25PAG6FmAw+5HGENG7zgCkK6xe2nCR
   UwGMRulCqZ5mx+FpWsb3h4g+49Rx+TeEiwl9Sw5vnd4lCa+lQvEUC/0uL
   sUrdAaEsQG4PTZGiV+tXEjElJJlm5DjB9qL0P79RXNeywOf7OSNuBWMsw
   tSR1QPgCAahbJpC4uM9qbbe1T4w/GjN+v5R7oAF81M2WASNZUI6wFbQkJ
   Q==;
X-CSE-ConnectionGUID: xuMAYHE7TOqBEtEMdScGyg==
X-CSE-MsgGUID: ZgX0VBU9S1SYan5mwMLdpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386785"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386785"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:04 -0700
X-CSE-ConnectionGUID: kHU7L01YQOObNOx1Y3DKYQ==
X-CSE-MsgGUID: adTrvhb4QYGeB8Itqs7JEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401290"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:03 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 7/8] platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
Date: Wed,  9 Apr 2025 12:10:49 -0700
Message-ID: <20250409191056.15434-8-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409191056.15434-1-xi.pardee@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ssram device related functionalities to a new driver named Intel
PMC SSRAM Telemetry driver. Modify PMC Core driver to use API exported by
the driver to discover and achieve devid and PWRMBASE address information
for each available PMC. PMC Core driver needs to get PCI device when
reading from telemetry regions.

The new SSRAM driver binds to the SSRAM device and provides the following
functionalities:
1. Look for and register telemetry regions available in SSRAM device.
2. Provide devid and PWRMBASE address information for the corresponding
   PMCs.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Kconfig        |  14 ++
 drivers/platform/x86/intel/pmc/Makefile       |   8 +-
 drivers/platform/x86/intel/pmc/core.c         |  80 +++++++----
 drivers/platform/x86/intel/pmc/core.h         |   7 -
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 132 ++++++++++++------
 .../platform/x86/intel/pmc/ssram_telemetry.h  |  35 +++++
 6 files changed, 198 insertions(+), 78 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
index d2f651fbec2c..f5fb1bdc266e 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -8,6 +8,7 @@ config INTEL_PMC_CORE
 	depends on PCI
 	depends on ACPI
 	depends on INTEL_PMT_TELEMETRY
+	select INTEL_PMC_SSRAM_TELEMETRY
 	help
 	  The Intel Platform Controller Hub for Intel Core SoCs provides access
 	  to Power Management Controller registers via various interfaces. This
@@ -24,3 +25,16 @@ config INTEL_PMC_CORE
 		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
 		- Low Power Mode registers (Tigerlake and beyond)
 		- PMC quirks as needed to enable SLPS0/S0ix
+
+config INTEL_PMC_SSRAM_TELEMETRY
+	tristate
+	help
+	  The PMC SSRAM device contains counters structured in Intel Platform
+	  Monitoring Techology (PMT) telemetry regions. The driver  provides
+	  API to expose information of PMCs available in the platform. This
+	  driver also looks for and register telemetry regions so they would
+	  be available for read through sysfs and Intel PMT API.
+
+	  The driver needs INTEL_VSEC driver to register for telemetry regions.
+	  This requirement has been fulfilled by INTEL_PMC_CORE driver which
+	  selects INTEL_PMC_SSRAM_TELEMETRY driver.
diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index e842647d3ced..5f68c8503a56 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,8 +3,12 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o ssram_telemetry.o spt.o cnp.o \
-					   icl.o tgl.o adl.o mtl.o arl.o lnl.o ptl.o
+intel_pmc_core-y			:= core.o spt.o cnp.o icl.o \
+					   tgl.o adl.o mtl.o arl.o lnl.o ptl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
+
+# Intel PMC SSRAM driver
+intel_pmc_ssram_telemetry-y		+= ssram_telemetry.o
+obj-$(CONFIG_INTEL_PMC_SSRAM_TELEMETRY)	+= intel_pmc_ssram_telemetry.o
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index a53a7677122c..26c1c75b709a 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -29,6 +29,7 @@
 #include <asm/tsc.h>
 
 #include "core.h"
+#include "ssram_telemetry.h"
 #include "../pmt/telemetry.h"
 
 /* Maximum number of modes supported by platfoms that has low power mode capability */
@@ -1354,7 +1355,7 @@ static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *m
 	return 0;
 }
 
-static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
+static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct pci_dev *pcidev)
 {
 	struct telem_endpoint *ep;
 	const u8 *lpm_indices;
@@ -1371,7 +1372,7 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
 	if (!guid)
 		return -ENXIO;
 
-	ep = pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, guid, 0);
+	ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
 	if (IS_ERR(ep)) {
 		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
 			PTR_ERR(ep));
@@ -1455,27 +1456,30 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
 	return ret;
 }
 
-static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
+static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev, int func)
 {
+	struct pci_dev *pcidev;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
-	if (!pmcdev->ssram_pcidev)
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
+	if (!pcidev)
 		return -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		if (!pmcdev->pmcs[i])
 			continue;
 
-		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
+		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i], pcidev);
 		if (ret)
-			return ret;
+			break;
 	}
 
-	return 0;
+	pci_dev_put(pcidev);
+	return ret;
 }
 
-const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
+static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
 {
 	for (; list->map; ++list)
 		if (devid == list->devid)
@@ -1484,23 +1488,32 @@ const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
 	return NULL;
 }
 
-int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
-		     const struct pmc_reg_map *reg_map, unsigned int pmc_index)
+static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_index)
+
 {
-	struct pmc *pmc = pmcdev->pmcs[pmc_index];
+	struct pmc_ssram_telemetry pmc_ssram_telemetry;
+	const struct pmc_reg_map *map;
+	struct pmc *pmc;
+	int ret;
+
+	ret = pmc_ssram_telemetry_get_pmc_info(pmc_index, &pmc_ssram_telemetry);
+	if (ret)
+		return ret;
 
-	if (!pwrm_base)
+	map = pmc_core_find_regmap(pmcdev->regmap_list, pmc_ssram_telemetry.devid);
+	if (!map)
 		return -ENODEV;
 
-	/* Memory for primary PMC has been allocated in core.c */
+	pmc = pmcdev->pmcs[pmc_index];
+	/* Memory for primary PMC has been allocated */
 	if (!pmc) {
 		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
 		if (!pmc)
 			return -ENOMEM;
 	}
 
-	pmc->map = reg_map;
-	pmc->base_addr = pwrm_base;
+	pmc->map = map;
+	pmc->base_addr = pmc_ssram_telemetry.base_addr;
 	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
 
 	if (!pmc->regbase) {
@@ -1513,6 +1526,20 @@ int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
 	return 0;
 }
 
+static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev)
+{
+	int ret;
+
+	ret = pmc_core_pmc_add(pmcdev, PMC_IDX_MAIN);
+	if (ret)
+		return ret;
+
+	pmc_core_pmc_add(pmcdev, PMC_IDX_IOE);
+	pmc_core_pmc_add(pmcdev, PMC_IDX_PCH);
+
+	return 0;
+}
+
 /*
  * When supported, ssram init is used to achieve all available PMCs.
  * If ssram init fails, this function uses legacy method to at least get the
@@ -1530,10 +1557,18 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	ssram = pmc_dev_info->regmap_list != NULL;
 	if (ssram) {
 		pmcdev->regmap_list = pmc_dev_info->regmap_list;
-		ret = pmc_core_ssram_init(pmcdev, pmc_dev_info->pci_func);
+		ret = pmc_core_ssram_get_reg_base(pmcdev);
+		/*
+		 * EAGAIN error code indicates Intel PMC SSRAM Telemetry driver
+		 * has not finished probe and PMC info is not available yet. Try
+		 * again later.
+		 */
+		if (ret == -EAGAIN)
+			return -EPROBE_DEFER;
+
 		if (ret) {
 			dev_warn(&pmcdev->pdev->dev,
-				 "ssram init failed, %d, using legacy init\n", ret);
+				 "Failed to get PMC info from SSRAM, %d, using legacy init\n", ret);
 			ssram = false;
 		}
 	}
@@ -1550,7 +1585,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
 
 	if (ssram)
-		return pmc_core_ssram_get_lpm_reqs(pmcdev);
+		return pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
 
 	return 0;
 }
@@ -1639,15 +1674,10 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
 		struct pmc *pmc = pmcdev->pmcs[i];
 
-		if (pmc)
+		if (pmc && pmc->regbase)
 			iounmap(pmc->regbase);
 	}
 
-	if (pmcdev->ssram_pcidev) {
-		pci_dev_put(pmcdev->ssram_pcidev);
-		pci_disable_device(pmcdev->ssram_pcidev);
-	}
-
 	if (pmcdev->punit_ep)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index c3b07075d017..e136d18b1d38 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -413,7 +413,6 @@ struct pmc {
  * struct pmc_dev - pmc device structure
  * @devs:		pointer to an array of pmc pointers
  * @pdev:		pointer to platform_device struct
- * @ssram_pcidev:	pointer to pci device struct for the PMC SSRAM
  * @crystal_freq:	crystal frequency from cpuid
  * @dbgfs_dir:		path to debugfs interface
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
@@ -433,7 +432,6 @@ struct pmc_dev {
 	struct pmc *pmcs[MAX_NUM_PMC];
 	struct dentry *dbgfs_dir;
 	struct platform_device *pdev;
-	struct pci_dev *ssram_pcidev;
 	unsigned int crystal_freq;
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
@@ -510,12 +508,7 @@ void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
 void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
 void pmc_core_set_device_d3(unsigned int device);
 
-int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
-
 int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
-const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid);
-int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
-		     const struct pmc_reg_map *reg_map, unsigned int pmc_index);
 
 extern struct pmc_dev_info spt_pmc_dev;
 extern struct pmc_dev_info cnp_pmc_dev;
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
index 7b8443092b20..232263008030 100644
--- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -1,19 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file contains functions to handle discovery of PMC metrics located
- * in the PMC SSRAM PCI device.
+ * Intel PMC SSRAM TELEMETRY PCI Driver
  *
  * Copyright (c) 2023, Intel Corporation.
- * All Rights Reserved.
- *
  */
 
 #include <linux/cleanup.h>
 #include <linux/intel_vsec.h>
 #include <linux/pci.h>
+#include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "core.h"
+#include "ssram_telemetry.h"
 
 #define SSRAM_HDR_SIZE		0x100
 #define SSRAM_PWRM_OFFSET	0x14
@@ -23,12 +22,14 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
-DEFINE_FREE(pmc_core_iounmap, void __iomem *, if (_T) iounmap(_T))
+DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *, if (_T) iounmap(_T))
+
+static struct pmc_ssram_telemetry *pmc_ssram_telems;
+static bool device_probed;
 
 static void
-pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
+pmc_ssram_telemetry_add_pmt(struct pci_dev *pcidev, u64 ssram_base, void __iomem *ssram)
 {
-	struct pci_dev *pcidev = pmcdev->ssram_pcidev;
 	struct intel_vsec_platform_info info = {};
 	struct intel_vsec_header *headers[2] = {};
 	struct intel_vsec_header header;
@@ -57,7 +58,7 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
 	info.caps = VSEC_CAP_TELEMETRY;
 	info.headers = headers;
 	info.base_addr = ssram_base;
-	info.parent = &pmcdev->pdev->dev;
+	info.parent = &pcidev->dev;
 
 	intel_vsec_register(pcidev, &info);
 }
@@ -68,19 +69,14 @@ static inline u64 get_base(void __iomem *addr, u32 offset)
 }
 
 static int
-pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
+pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, unsigned int pmc_idx, u32 offset)
 {
-	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
-	void __iomem __free(pmc_core_iounmap) *tmp_ssram = NULL;
-	void __iomem __free(pmc_core_iounmap) *ssram = NULL;
-	const struct pmc_reg_map *map;
+	void __iomem __free(pmc_ssram_telemetry_iounmap) * tmp_ssram = NULL;
+	void __iomem __free(pmc_ssram_telemetry_iounmap) * ssram = NULL;
 	u64 ssram_base, pwrm_base;
 	u16 devid;
 
-	if (!pmcdev->regmap_list)
-		return -ENOENT;
-
-	ssram_base = ssram_pcidev->resource[0].start;
+	ssram_base = pcidev->resource[0].start;
 	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
 	if (!tmp_ssram)
 		return -ENOMEM;
@@ -107,45 +103,93 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
 	devid = readw(ssram + SSRAM_DEVID_OFFSET);
 
 	/* Find and register and PMC telemetry entries */
-	pmc_add_pmt(pmcdev, ssram_base, ssram);
+	pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
 
-	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
-	if (!map)
+	pmc_ssram_telems[pmc_idx].devid = devid;
+	pmc_ssram_telems[pmc_idx].base_addr = pwrm_base;
+
+	return 0;
+}
+
+int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
+				     struct pmc_ssram_telemetry *pmc_ssram_telemetry)
+{
+	/*
+	 * PMCs are discovered in probe function. If this function is called before
+	 * probe function complete, the result would be invalid. Use device_probed
+	 * variable to avoid this case. Return -EAGAIN to inform the consumer to call
+	 * again later.
+	 */
+	if (!device_probed)
+		return -EAGAIN;
+
+	/*
+	 * Memory barrier is used to ensure the correct read order between
+	 * device_probed variable and PMC info.
+	 */
+	smp_rmb();
+	if (pmc_idx >= MAX_NUM_PMC)
+		return -EINVAL;
+
+	if (!pmc_ssram_telems || !pmc_ssram_telems[pmc_idx].devid)
 		return -ENODEV;
 
-	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
+	pmc_ssram_telemetry->devid = pmc_ssram_telems[pmc_idx].devid;
+	pmc_ssram_telemetry->base_addr = pmc_ssram_telems[pmc_idx].base_addr;
+	return 0;
 }
+EXPORT_SYMBOL_GPL(pmc_ssram_telemetry_get_pmc_info);
 
-int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func)
+static int intel_pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 {
-	struct pci_dev *pcidev;
 	int ret;
 
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
-	if (!pcidev)
-		return -ENODEV;
+	pmc_ssram_telems = devm_kzalloc(&pcidev->dev, sizeof(*pmc_ssram_telems) * MAX_NUM_PMC,
+					GFP_KERNEL);
+	if (!pmc_ssram_telems) {
+		ret = -ENOMEM;
+		goto probe_finish;
+	}
 
 	ret = pcim_enable_device(pcidev);
-	if (ret)
-		goto release_dev;
-
-	pmcdev->ssram_pcidev = pcidev;
+	if (ret) {
+		dev_dbg(&pcidev->dev, "failed to enable PMC SSRAM device\n");
+		goto probe_finish;
+	}
 
-	ret = pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_MAIN, 0);
+	ret = pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_MAIN, 0);
 	if (ret)
-		goto disable_dev;
-
-	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
-	pmc_core_ssram_get_pmc(pmcdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
-
-	return 0;
-
-disable_dev:
-	pmcdev->ssram_pcidev = NULL;
-	pci_disable_device(pcidev);
-release_dev:
-	pci_dev_put(pcidev);
-
+		goto probe_finish;
+
+	pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
+	pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
+
+probe_finish:
+	/*
+	 * Memory barrier is used to ensure the correct write order between PMC info
+	 * and device_probed variable.
+	 */
+	smp_wmb();
+	device_probed = true;
 	return ret;
 }
+
+static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCM) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
+
+static struct pci_driver intel_pmc_ssram_telemetry_driver = {
+	.name = "intel_pmc_ssram_telemetry",
+	.id_table = intel_pmc_ssram_telemetry_pci_ids,
+	.probe = intel_pmc_ssram_telemetry_probe,
+};
+module_pci_driver(intel_pmc_ssram_telemetry_driver);
+
 MODULE_IMPORT_NS("INTEL_VSEC");
+MODULE_AUTHOR("Xi Pardee <xi.pardee@intel.com>");
+MODULE_DESCRIPTION("Intel PMC SSRAM Telemetry driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.h b/drivers/platform/x86/intel/pmc/ssram_telemetry.h
new file mode 100644
index 000000000000..459a29efebea
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel PMC SSRAM Telemetry PCI Driver Header File
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ */
+
+#ifndef PMC_SSRAM_H
+#define PMC_SSRAM_H
+
+/**
+ * struct pmc_ssram_telemetry - Structure to keep pmc info in ssram device
+ * @devid:		device id of the pmc device
+ * @base_addr:		contains PWRM base address
+ */
+struct pmc_ssram_telemetry {
+	u16 devid;
+	u64 base_addr;
+};
+
+/**
+ * pmc_ssram_telemetry_get_pmc_info() - Get a PMC devid and base_addr information
+ * @pmc_idx:               Index of the PMC
+ * @pmc_ssram_telemetry:   pmc_ssram_telemetry structure to store the PMC information
+ *
+ * Return:
+ * * 0           - Success
+ * * -EAGAIN     - Probe function has not finished yet. Try again.
+ * * -EINVAL     - Invalid pmc_idx
+ * * -ENODEV     - PMC device is not available
+ */
+int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
+				     struct pmc_ssram_telemetry *pmc_ssram_telemetry);
+
+#endif /* PMC_SSRAM_H */
-- 
2.43.0


