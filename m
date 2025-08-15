Return-Path: <linux-pm+bounces-32460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DDDB28885
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 00:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42F6AE7CEC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538B2750E6;
	Fri, 15 Aug 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOtCUfsg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD65270575;
	Fri, 15 Aug 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297981; cv=none; b=rPeD1aQAVchJby54sXMPKvbJejLba0J3d4KoT3jyd++2xsuSTho9c0D+IswFhbn430ka3tORSGkcaj7JW1DssTYrsTdilncS/E1YOtYPc+8+bNm6BTaAZ2TCi3u5ELGU9IlfbkOJuZ6CARkfvpNCKsVL88XWeKwmvEHIBSVJXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297981; c=relaxed/simple;
	bh=tyfvZR6c2jtlMiqFXSLHXdmtkWj3ZoQ6BHUcDwglJDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MctIwLfBbkchUHpBLbJI48iQRCJMNNByqWM4MDcmDkV9BPdw9z0gxzO9H2EBlmHTZqDRFZUhdl+zA8gcneffGl9oYDfgD6Qh73krfrk/xYymkGsy42tSwLi0sqIduOURH0Ebf7FuEjE0pk/psgJbKy0mkDNXFQE0g/9uePrX5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOtCUfsg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297979; x=1786833979;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tyfvZR6c2jtlMiqFXSLHXdmtkWj3ZoQ6BHUcDwglJDc=;
  b=YOtCUfsg3GcNJ4MqXW4wbcYHUUKVDX0PVrzQHJV1OCAkaS0Sn4NzW5l8
   wRV207BvSvqOHYVhKtwso+OhX2AS6hwdkkYAbrqanHJAgo7NYeLGZivEa
   Wd03tnYA06uCqEPc9xOrYugGtweCmVOI0+9uNvwYHSzyK7O06soY4X8Rc
   K3Xcqn0x3A7NsSsZyb8X2jvdhO56EqFJ6aSsvDBTmqaTRAtv6/VOFT/SC
   t/4/EYOdebJQb/87rbZs8iNHQUXrWa18dpMwRaFP3vuMIhngf1nCEn4dE
   ldUXRUp0xvbV30zWSwmU4IG54WxN+r1R80jPQREKEMPanH46dck5BKB37
   w==;
X-CSE-ConnectionGUID: swuF0vVDQw25iBG3RqIHYg==
X-CSE-MsgGUID: 78QspDiDSmmVw4prwyhaRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57724939"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57724939"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:15 -0700
X-CSE-ConnectionGUID: YvQFVHYdQeyA8/KenFXNhg==
X-CSE-MsgGUID: sM9v7TfHRdOefShZM8KJEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166734410"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:15 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 2/6] platform/x86:intel/pmc: Move telemetry endpoint register handling
Date: Fri, 15 Aug 2025 15:46:00 -0700
Message-ID: <20250815224611.2460255-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move telemetry endpoint handling to pmc_core_get_telem_info(). This
is a preparation patch to introduce a new table to obtain Low Power
Mode substate requirement data for platforms starting from Panther
Lake.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


