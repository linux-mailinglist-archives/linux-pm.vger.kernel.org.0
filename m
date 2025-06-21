Return-Path: <linux-pm+bounces-29203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6989AE2C79
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 23:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604B41899601
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4D5272E43;
	Sat, 21 Jun 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwdfdXZ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085C271464;
	Sat, 21 Jun 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750539940; cv=none; b=Oh0xDrHU5hPcVXjciU3Iw9+fGqYkGJfq2CQttGPNE8do8321HNC7Wbzfv6ewtVSB4RblCfyfbY0y8E2RGcNHlpB5k2oqSqE4GsJQoiGZRLZUfc3o9oX3upMmShiPGzrd8Z4C5YspqfWyhrJLCuvlBEbL+nQbZVKlLfZw9+NS+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750539940; c=relaxed/simple;
	bh=pDEK6l4tV93DlVFZwk/S5bgrjdnLgvhPs43YW/brNi4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuOi6g+k4Z8ScX/2xhDbkV+FvjgjWf/WhTlm7niMJOHbkPqrpD1sWOL3UFSacYFhgpOFWbj6fsmp69RJqmZyRvtIxp83Sv6xC8lDvDeBd7iwS/Yarq+/NwaU9WQxfQCNMkwYJpwMgFda1rCpeoo9GThr7T49CWDKgsZqof5PVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwdfdXZ8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750539938; x=1782075938;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pDEK6l4tV93DlVFZwk/S5bgrjdnLgvhPs43YW/brNi4=;
  b=CwdfdXZ87wvswANysRfNcgQ27juTiM9lJuqb5Uu0QGAIyTp9V7jigVNl
   jPF8FpaHcEdsWv+TV8H7AE80VNIDXRsRhmfGVyqJzV7aQAHjByTT+zFWG
   kOGUj/ZO8r3hRlXQtTF5RKEvKSlUDRqP83KsOqNOPUcCtOW2IB6bkiT51
   2wvhOlkft8sEfGZ8DWZJPF8J2KXOUjt2NIlhpVvi1mry3W8hDI4dEHCM0
   pO5MQZuCVkli0zZo2WkhBecV+WpX2ic4Pe6crP/g6jOhwOKFSKvHMZjck
   jVlRLYtdY6nqguFhRx4JG1tuBzmqgHAytH+7ASNjzvd1CBwHg8D37SDvl
   w==;
X-CSE-ConnectionGUID: mehO/kGETy2zv6uMD0/qlg==
X-CSE-MsgGUID: ndH/kw/zQ+Kdw0Cxv71i8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="63826253"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="63826253"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:38 -0700
X-CSE-ConnectionGUID: UdRUQIrlRGysdk2ovDp2uQ==
X-CSE-MsgGUID: g05OrzokQZ6sQuze66kJ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155775325"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.74])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:36 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 2/5] platform/x86:intel/pmc: Move telemetry endpoint register handling
Date: Sat, 21 Jun 2025 14:05:22 -0700
Message-ID: <20250621210529.237964-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621210529.237964-1-xi.pardee@linux.intel.com>
References: <20250621210529.237964-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move telemetry endpoint handling to pmc_core_get_telem_info(). This
is a preparation patch to introduce a new table to obtain Low Power
Mode substate requirement data for platforms starting from Panther
Lake.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 51 +++++++++++++--------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 540cd2fb0673b..a1dd80bdbd413 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1399,36 +1399,23 @@ static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *m
  * +----+---------------------------------------------------------+
  *
  */
-static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct pci_dev *pcidev)
+static int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc,
+				    struct telem_endpoint *ep)
 {
-	struct telem_endpoint *ep;
 	const u8 *lpm_indices;
 	int num_maps, mode_offset = 0;
 	int ret, mode;
 	int lpm_size;
-	u32 guid;
 
 	lpm_indices = pmc->map->lpm_reg_index;
 	num_maps = pmc->map->lpm_num_maps;
 	lpm_size = LPM_MAX_NUM_MODES * num_maps;
 
-	guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
-	if (!guid)
-		return -ENXIO;
-
-	ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
-	if (IS_ERR(ep)) {
-		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %pe", ep);
-		return -EPROBE_DEFER;
-	}
-
 	pmc->lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev,
 					 lpm_size * sizeof(u32),
 					 GFP_KERNEL);
-	if (!pmc->lpm_req_regs) {
-		ret = -ENOMEM;
-		goto unregister_ep;
-	}
+	if (!pmc->lpm_req_regs)
+		return -ENOMEM;
 
 	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
 	pmc_for_each_mode(mode, pmcdev) {
@@ -1442,23 +1429,21 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct
 			if (ret) {
 				dev_err(&pmcdev->pdev->dev,
 					"couldn't read Low Power Mode requirements: %d\n", ret);
-				goto unregister_ep;
+				return ret;
 			}
 			++req_offset;
 		}
 		mode_offset += LPM_REG_COUNT + LPM_MODE_OFFSET;
 	}
-
-unregister_ep:
-	pmt_telem_unregister_endpoint(ep);
-
 	return ret;
 }
 
-static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev, int func)
+static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, int func)
 {
 	struct pci_dev *pcidev __free(pci_dev_put) = NULL;
+	struct telem_endpoint *ep;
 	unsigned int i;
+	u32 guid;
 	int ret;
 
 	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, func));
@@ -1466,10 +1451,24 @@ static int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev, int func)
 		return -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		if (!pmcdev->pmcs[i])
+		struct pmc *pmc;
+
+		pmc = pmcdev->pmcs[i];
+		if (!pmc)
 			continue;
 
-		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i], pcidev);
+		guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
+		if (!guid)
+			return -ENXIO;
+
+		ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
+		if (IS_ERR(ep)) {
+			dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %pe", ep);
+			return -EPROBE_DEFER;
+		}
+
+		ret = pmc_core_pmt_get_lpm_req(pmcdev, pmc, ep);
+		pmt_telem_unregister_endpoint(ep);
 		if (ret)
 			return ret;
 	}
@@ -1583,7 +1582,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
 
 	if (ssram) {
-		ret = pmc_core_ssram_get_lpm_reqs(pmcdev, pmc_dev_info->pci_func);
+		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info->pci_func);
 		if (ret)
 			goto unmap_regbase;
 	}
-- 
2.43.0


