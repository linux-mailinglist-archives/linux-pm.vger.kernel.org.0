Return-Path: <linux-pm+bounces-13083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5429634B7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829081C23C9C
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC01AD9F1;
	Wed, 28 Aug 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYLXuLQE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269D1AC8A9;
	Wed, 28 Aug 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884179; cv=none; b=IKMYvielWX+GmReANG/kHLVkJmeYe+nEfvus2fZPhMzHVaG7MlSuI4OU4dgxm0RJKVr0ofK/i94Ay1f46csw/yuFs6V0uTts3C/lVTBP/nL8DTRnUpQp/qsF+P+UZp1ea/63ynBUYZdaGmrlyTG3FyhIL5D6COkUV4nHz8OsMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884179; c=relaxed/simple;
	bh=3DMa12SWWXAxp33WniB6vGpQ8R/Wss/8rFlxe49ps5w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sciZXYgrrQuZf4UWKZsarc06I07ChEhxAxDxzuPxTPpgwEVtl+waDgj5asiQdBuYknHzCPt+qCf1dZVs1TT2wgWRc4eAvgSIZ6sp1ReYnJWxwVDWHvOnUGEpungyCnT3dxkKjH/SxKjIw4hGq0qeHcx/JippHxCeItMdUVp4gNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYLXuLQE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884177; x=1756420177;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=3DMa12SWWXAxp33WniB6vGpQ8R/Wss/8rFlxe49ps5w=;
  b=JYLXuLQEAZcNoEWm1+TFjFhql23UheqskuI5rrTT7XqSDkhwMhgWxnld
   66vB0fTtob+yzY9Ea3t1lMlko+sgyaEq76OP3budX8cqUsrA4r0hhGIjM
   l+dn9/ws8diaOYBmFevfthmaz4GKb7L3T3MupcD6tk3Mo4oUaOMO7NO2M
   B3ghnM0Hkpc6KJxJ9BLNckNx+3yoC+Wa6RY94u5/MC4SrL8oW1b3rnhSm
   xFg2z5LZ9TTAmgT4S4yfpj2LfxiHunRWBp1E90DbqH0YgNUd4fLzT1beF
   ND4kCMfIl/ZLIBLy+4kY+LhkH1ZvBGz2uvEHz9hp/aqfB3Xv9az57+Unp
   w==;
X-CSE-ConnectionGUID: nwbfTzUrQuasSaRAYyJUCw==
X-CSE-MsgGUID: YpNqcLpATaOxl5LE+KZNMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406456"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406456"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:36 -0700
X-CSE-ConnectionGUID: CAohibdlTV677ypAd28kfA==
X-CSE-MsgGUID: VwRqeDiMRdG22XNK4TVqsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271791"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:36 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 01/11] platform/x86:intel/pmc: Move PMC Core related functions
Date: Wed, 28 Aug 2024 15:29:16 -0700
Message-ID: <20240828222932.1279508-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move functions that implements PMC Core feature from core_ssram.c
to core.c. This patch is a preparation step to introduce a new
SSRAM Telemetry driver for the SSRAM device.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c       | 168 +++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.h       |   8 +
 drivers/platform/x86/intel/pmc/core_ssram.c | 173 --------------------
 3 files changed, 176 insertions(+), 173 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 01ae71c6df59..630ce2087552 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1604,6 +1604,173 @@ static const struct dev_pm_ops pmc_core_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
 };
 
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
+	int ret, mode, i;
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
+	pmc_for_each_mode(i, mode, pmcdev) {
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
+int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
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
 static const struct acpi_device_id pmc_core_acpi_ids[] = {
 	{"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
 	{ }
@@ -1623,5 +1790,6 @@ static struct platform_driver pmc_core_driver = {
 
 module_platform_driver(pmc_core_driver);
 
+MODULE_IMPORT_NS(INTEL_PMT_TELEMETRY);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ea04de7eb9e8..9a1cc01f31d9 100644
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
@@ -589,6 +594,9 @@ extern void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
 extern void pmc_core_set_device_d3(unsigned int device);
 
 extern int pmc_core_ssram_init(struct pmc_dev *pmcdev, int func);
+extern const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid);
+extern int pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
+			    const struct pmc_reg_map *reg_map, int pmc_index);
 
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 1bde86c54eb9..0a2bfca5ff41 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -24,142 +24,8 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
-/* PCH query */
-#define LPM_HEADER_OFFSET	1
-#define LPM_REG_COUNT		28
-#define LPM_MODE_OFFSET		1
-
 DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
 
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
-	int ret, mode, i;
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
-	pmc_for_each_mode(i, mode, pmcdev) {
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
@@ -203,50 +69,11 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
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
-- 
2.43.0


