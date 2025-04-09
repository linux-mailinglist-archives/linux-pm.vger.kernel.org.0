Return-Path: <linux-pm+bounces-25037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D2A83010
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA43B1B6384F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948527816F;
	Wed,  9 Apr 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8zX1raA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956AB25A344;
	Wed,  9 Apr 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225864; cv=none; b=BnDBXrQUiKa+Wg4gbVIhsUgA/Z23FBoDj63TMDc3USadQpl/iIksuc/Fo21KwXPn6UYxqnpMfdYQoJII1DoBZKx7GeIdsy2LD8QEUbz9iwTiKiVI9xH3OoozocXNWLLSL2Agp8NfoyhwWQ5RjCoKXbmSmuHuNHB6B5E1TPo45zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225864; c=relaxed/simple;
	bh=sVJ/NzJrIiJRVWiBKwmNW8YOVTMec0WzA0teDY3qMy0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3tUJACvJT8ZRCcYYD0G5hLadv+o1h73NZzZ7WsxN3Y9vmwxMJ5PnXmEfsbkN5brllLJNc3EELBToa/Ye+LnKS0JBvtoJmHKIHFoW2oLehYMIdUw1xn5U7ngvTzbhE5gdieDXyz78N8EM+fQ8gBHpbX1L+uKJXzQ2sRB+R0/CuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8zX1raA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744225863; x=1775761863;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sVJ/NzJrIiJRVWiBKwmNW8YOVTMec0WzA0teDY3qMy0=;
  b=K8zX1raA6OsBP0NhsOv+hTNjlJklo5cjiwotU3BAZYvTOtQJbm4fx4xp
   XrOz4hivqp1uYI1QuTYObZ+EUAeF8XOJ073azeymb7ci25EE+hQUfmEeG
   E4A6dVLIQtjGSiDs1+lAJHWc+w6ZO3Ri+KjuUTaHkEMqn6TQHRPtP5qAB
   ueYGsWyq/R9P0KbUSEaLX7zy1Gymw4W6ROroAO8I7vK9tvBk+F5RgKd1G
   YwAETkGOZ2Nm+MKe/+vu0Ed3eBf07GQgOnGuzTxwvdLAUd54ndKqItP7S
   xsHSkrHspQ5xory+r0W+1zya86Qjx4IlojnmbeIuWMqnUSV29OYakXELq
   w==;
X-CSE-ConnectionGUID: HNEpqs/yS56zZ6yCtEOlpg==
X-CSE-MsgGUID: gyxZTDNmRxOcyFGhUT7Utg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56386760"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="56386760"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:01 -0700
X-CSE-ConnectionGUID: vvDYeOV6Rmq2+I4XfeghCg==
X-CSE-MsgGUID: ljTFxoibTBG+7Xu9ciOeLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="133401215"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.220.250])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 12:11:00 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/8] platform/x86:intel/pmc: Move PMC Core related functions
Date: Wed,  9 Apr 2025 12:10:43 -0700
Message-ID: <20250409191056.15434-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409191056.15434-1-xi.pardee@linux.intel.com>
References: <20250409191056.15434-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move functions that implements PMC Core feature from core_ssram.c
to core.c. This patch is a preparation step to introduce a new
SSRAM Telemetry driver for the SSRAM device.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c       | 168 +++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h       |   9 +-
 drivers/platform/x86/intel/pmc/core_ssram.c | 175 --------------------
 3 files changed, 176 insertions(+), 176 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7a1d11f2914f..a42dc62d70da 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1345,6 +1345,173 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
+static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
+{
+	for (; list->map; ++list)
+		if (list->map == map)
+			return list->guid;
+
+	return 0;
+}
+
+static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
+{
+	struct telem_endpoint *ep;
+	const u8 *lpm_indices;
+	int num_maps, mode_offset = 0;
+	int ret, mode;
+	int lpm_size;
+	u32 guid;
+
+	lpm_indices = pmc->map->lpm_reg_index;
+	num_maps = pmc->map->lpm_num_maps;
+	lpm_size = LPM_MAX_NUM_MODES * num_maps;
+
+	guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
+	if (!guid)
+		return -ENXIO;
+
+	ep = pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, guid, 0);
+	if (IS_ERR(ep)) {
+		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
+			PTR_ERR(ep));
+		return -EPROBE_DEFER;
+	}
+
+	pmc->lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev,
+					 lpm_size * sizeof(u32),
+					 GFP_KERNEL);
+	if (!pmc->lpm_req_regs) {
+		ret = -ENOMEM;
+		goto unregister_ep;
+	}
+
+	/*
+	 * PMC Low Power Mode (LPM) table
+	 *
+	 * In telemetry space, the LPM table contains a 4 byte header followed
+	 * by 8 consecutive mode blocks (one for each LPM mode). Each block
+	 * has a 4 byte header followed by a set of registers that describe the
+	 * IP state requirements for the given mode. The IP mapping is platform
+	 * specific but the same for each block, making for easy analysis.
+	 * Platforms only use a subset of the space to track the requirements
+	 * for their IPs. Callers provide the requirement registers they use as
+	 * a list of indices. Each requirement register is associated with an
+	 * IP map that's maintained by the caller.
+	 *
+	 * Header
+	 * +----+----------------------------+----------------------------+
+	 * |  0 |      REVISION              |      ENABLED MODES         |
+	 * +----+--------------+-------------+-------------+--------------+
+	 *
+	 * Low Power Mode 0 Block
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |  2 |           LPM0 Requirements 0                           |
+	 * +----+---------------------------------------------------------+
+	 * |    |                  ...                                    |
+	 * +----+---------------------------------------------------------+
+	 * | 29 |           LPM0 Requirements 27                          |
+	 * +----+---------------------------------------------------------+
+	 *
+	 * ...
+	 *
+	 * Low Power Mode 7 Block
+	 * +----+--------------+-------------+-------------+--------------+
+	 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
+	 * +----+--------------+-------------+-------------+--------------+
+	 * | 60 |           LPM7 Requirements 0                           |
+	 * +----+---------------------------------------------------------+
+	 * |    |                  ...                                    |
+	 * +----+---------------------------------------------------------+
+	 * | 87 |           LPM7 Requirements 27                          |
+	 * +----+---------------------------------------------------------+
+	 *
+	 */
+	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
+	pmc_for_each_mode(mode, pmcdev) {
+		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
+		int m;
+
+		for (m = 0; m < num_maps; m++) {
+			u8 sample_id = lpm_indices[m] + mode_offset;
+
+			ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
+			if (ret) {
+				dev_err(&pmcdev->pdev->dev,
+					"couldn't read Low Power Mode requirements: %d\n", ret);
+				devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
+				goto unregister_ep;
+			}
+			++req_offset;
+		}
+		mode_offset += LPM_REG_COUNT + LPM_MODE_OFFSET;
+	}
+
+unregister_ep:
+	pmt_telem_unregister_endpoint(ep);
+
+	return ret;
+}
+
+static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
+{
+	int ret, i;
+
+	if (!pmcdev->ssram_pcidev)
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		if (!pmcdev->pmcs[i])
+			continue;
+
+		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
+{
+	for (; list->map; ++list)
+		if (devid == list->devid)
+			return list->map;
+
+	return NULL;
+}
+
+int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
+		     const struct pmc_reg_map *reg_map, int pmc_index)
+{
+	struct pmc *pmc = pmcdev->pmcs[pmc_index];
+
+	if (!pwrm_base)
+		return -ENODEV;
+
+	/* Memory for primary PMC has been allocated in core.c */
+	if (!pmc) {
+		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
+		if (!pmc)
+			return -ENOMEM;
+	}
+
+	pmc->map = reg_map;
+	pmc->base_addr = pwrm_base;
+	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
+
+	if (!pmc->regbase) {
+		devm_kfree(&pmcdev->pdev->dev, pmc);
+		return -ENOMEM;
+	}
+
+	pmcdev->pmcs[pmc_index] = pmc;
+
+	return 0;
+}
+
 /*
  * When supported, ssram init is used to achieve all available PMCs.
  * If ssram init fails, this function uses legacy method to at least get the
@@ -1719,5 +1886,6 @@ static struct platform_driver pmc_core_driver = {
 
 module_platform_driver(pmc_core_driver);
 
+MODULE_IMPORT_NS("INTEL_PMT_TELEMETRY");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 945a1c440cca..09aac6daabbd 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -24,6 +24,11 @@ struct telem_endpoint;
 #define MAX_NUM_PMC			3
 #define S0IX_BLK_SIZE			4
 
+/* PCH query */
+#define LPM_HEADER_OFFSET	1
+#define LPM_REG_COUNT		28
+#define LPM_MODE_OFFSET		1
+
 /* Sunrise Point Power Management Controller PCI Device ID */
 #define SPT_PMC_PCI_DEVICE_ID			0x9d21
 #define SPT_PMC_BASE_ADDR_OFFSET		0x48
@@ -485,7 +490,6 @@ extern const struct pmc_reg_map mtl_socm_reg_map;
 extern const struct pmc_reg_map mtl_ioep_reg_map;
 
 void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
-int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
 int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
@@ -497,6 +501,9 @@ void pmc_core_set_device_d3(unsigned int device);
 int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
 
 int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
+const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid);
+int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
+		     const struct pmc_reg_map *reg_map, int pmc_index);
 
 extern struct pmc_dev_info spt_pmc_dev;
 extern struct pmc_dev_info cnp_pmc_dev;
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 739569803017..e1a83425d802 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -14,7 +14,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "core.h"
-#include "../pmt/telemetry.h"
 
 #define SSRAM_HDR_SIZE		0x100
 #define SSRAM_PWRM_OFFSET	0x14
@@ -24,142 +23,8 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
-/* PCH query */
-#define LPM_HEADER_OFFSET	1
-#define LPM_REG_COUNT		28
-#define LPM_MODE_OFFSET		1
-
 DEFINE_FREE(pmc_core_iounmap, void __iomem *, if (_T) iounmap(_T))
 
-static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
-{
-	for (; list->map; ++list)
-		if (list->map == map)
-			return list->guid;
-
-	return 0;
-}
-
-static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
-{
-	struct telem_endpoint *ep;
-	const u8 *lpm_indices;
-	int num_maps, mode_offset = 0;
-	int ret, mode;
-	int lpm_size;
-	u32 guid;
-
-	lpm_indices = pmc->map->lpm_reg_index;
-	num_maps = pmc->map->lpm_num_maps;
-	lpm_size = LPM_MAX_NUM_MODES * num_maps;
-
-	guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
-	if (!guid)
-		return -ENXIO;
-
-	ep = pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, guid, 0);
-	if (IS_ERR(ep)) {
-		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
-			PTR_ERR(ep));
-		return -EPROBE_DEFER;
-	}
-
-	pmc->lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev,
-					 lpm_size * sizeof(u32),
-					 GFP_KERNEL);
-	if (!pmc->lpm_req_regs) {
-		ret = -ENOMEM;
-		goto unregister_ep;
-	}
-
-	/*
-	 * PMC Low Power Mode (LPM) table
-	 *
-	 * In telemetry space, the LPM table contains a 4 byte header followed
-	 * by 8 consecutive mode blocks (one for each LPM mode). Each block
-	 * has a 4 byte header followed by a set of registers that describe the
-	 * IP state requirements for the given mode. The IP mapping is platform
-	 * specific but the same for each block, making for easy analysis.
-	 * Platforms only use a subset of the space to track the requirements
-	 * for their IPs. Callers provide the requirement registers they use as
-	 * a list of indices. Each requirement register is associated with an
-	 * IP map that's maintained by the caller.
-	 *
-	 * Header
-	 * +----+----------------------------+----------------------------+
-	 * |  0 |      REVISION              |      ENABLED MODES         |
-	 * +----+--------------+-------------+-------------+--------------+
-	 *
-	 * Low Power Mode 0 Block
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |  2 |           LPM0 Requirements 0                           |
-	 * +----+---------------------------------------------------------+
-	 * |    |                  ...                                    |
-	 * +----+---------------------------------------------------------+
-	 * | 29 |           LPM0 Requirements 27                          |
-	 * +----+---------------------------------------------------------+
-	 *
-	 * ...
-	 *
-	 * Low Power Mode 7 Block
-	 * +----+--------------+-------------+-------------+--------------+
-	 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
-	 * +----+--------------+-------------+-------------+--------------+
-	 * | 60 |           LPM7 Requirements 0                           |
-	 * +----+---------------------------------------------------------+
-	 * |    |                  ...                                    |
-	 * +----+---------------------------------------------------------+
-	 * | 87 |           LPM7 Requirements 27                          |
-	 * +----+---------------------------------------------------------+
-	 *
-	 */
-	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
-	pmc_for_each_mode(mode, pmcdev) {
-		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
-		int m;
-
-		for (m = 0; m < num_maps; m++) {
-			u8 sample_id = lpm_indices[m] + mode_offset;
-
-			ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
-			if (ret) {
-				dev_err(&pmcdev->pdev->dev,
-					"couldn't read Low Power Mode requirements: %d\n", ret);
-				devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
-				goto unregister_ep;
-			}
-			++req_offset;
-		}
-		mode_offset += LPM_REG_COUNT + LPM_MODE_OFFSET;
-	}
-
-unregister_ep:
-	pmt_telem_unregister_endpoint(ep);
-
-	return ret;
-}
-
-int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
-{
-	int ret, i;
-
-	if (!pmcdev->ssram_pcidev)
-		return -ENODEV;
-
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		if (!pmcdev->pmcs[i])
-			continue;
-
-		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static void
 pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
 {
@@ -203,50 +68,11 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
 	intel_vsec_register(pcidev, &info);
 }
 
-static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
-{
-	for (; list->map; ++list)
-		if (devid == list->devid)
-			return list->map;
-
-	return NULL;
-}
-
 static inline u64 get_base(void __iomem *addr, u32 offset)
 {
 	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
 }
 
-static int
-pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
-		 const struct pmc_reg_map *reg_map, int pmc_index)
-{
-	struct pmc *pmc = pmcdev->pmcs[pmc_index];
-
-	if (!pwrm_base)
-		return -ENODEV;
-
-	/* Memory for primary PMC has been allocated in core.c */
-	if (!pmc) {
-		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
-		if (!pmc)
-			return -ENOMEM;
-	}
-
-	pmc->map = reg_map;
-	pmc->base_addr = pwrm_base;
-	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
-
-	if (!pmc->regbase) {
-		devm_kfree(&pmcdev->pdev->dev, pmc);
-		return -ENOMEM;
-	}
-
-	pmcdev->pmcs[pmc_index] = pmc;
-
-	return 0;
-}
-
 static int
 pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 {
@@ -329,4 +155,3 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func)
 	return ret;
 }
 MODULE_IMPORT_NS("INTEL_VSEC");
-MODULE_IMPORT_NS("INTEL_PMT_TELEMETRY");
-- 
2.43.0


