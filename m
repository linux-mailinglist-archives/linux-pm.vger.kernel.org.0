Return-Path: <linux-pm+bounces-34419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8DB5233B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B61C1708FF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75A307481;
	Wed, 10 Sep 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr1nXy8n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769A2FA0C4;
	Wed, 10 Sep 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538398; cv=none; b=IxQppvXMURoAiztQrWwZn7m/gA6fL+RZRPHSHfvS/Zu7QMIwe2tX9nveegST0mHVjB+93iK0JwQm8UtC2EHtbvnPR9INNT294KNulOGjetzGT67nAWOnSaIv/ivASyLXPBfsyz+gJF0PQLh6neeYRLLYJsDF5a5pqCS9mdDxB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538398; c=relaxed/simple;
	bh=/+NC8gHblKAo7flm8rfpQEMgdMw+LxxY4hPW+A/9IKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awPmJumoxRH2xCkmmtyenbDTSQhLloAulFmDm6o8k7dqNcLKnZNWHHQopagsm9dezHOaFb5gLNAJEBx7RxDDdUqOf4HqkKonoIzCZx0arcemz9MCSGNkIHWOrBvehApWLGtLFTlq9jONGPHQmUoZSsgI1dPfsOm/nOcoBuo1OMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr1nXy8n; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757538396; x=1789074396;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/+NC8gHblKAo7flm8rfpQEMgdMw+LxxY4hPW+A/9IKw=;
  b=Qr1nXy8nov6Au34bZUHcZXoEDMsdaxPAiHAmUvYAJxPydIEkqRXMr7iw
   BfyvnjCZ+WYdTBswts1E5kcHDb7ZnUbUNLAB33F3NNL56tCQtUe3jPUwH
   bvkL72tDdq62tv+i9Emnk6RFX2I8mpquvSLDfZvw0r7cMUfikCzRVsErX
   xlIzyAj4AuQ8AjdpXCp+XrFKhFAc/dh1BGnBvdysbMvU9zK26uP+qHso0
   7xy2E0ENShpalamo2qxvCOJ5aAZFGwvtzW1GXrWgHmb0ard0/i5czL5H5
   ssErCVDS4ewJ1YhoTqbDQeJ2SU+uMNSrsY3ApDdsd5qzpQcwancE6cmVe
   A==;
X-CSE-ConnectionGUID: tYeK77H+TbKovoWLowipEQ==
X-CSE-MsgGUID: JJDAL0l4TUOWw7xBcv31zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82448481"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82448481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:34 -0700
X-CSE-ConnectionGUID: 5Kf9bX+wSQqf5vBBNKKefw==
X-CSE-MsgGUID: ZqBt0dxCQIKx1MvAP/XapQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177842752"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:34 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 2/5] platform/x86:intel/pmc: Move telemetry endpoint register handling
Date: Wed, 10 Sep 2025 14:06:22 -0700
Message-ID: <20250910210629.11198-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210629.11198-1-xi.pardee@linux.intel.com>
References: <20250910210629.11198-1-xi.pardee@linux.intel.com>
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
index 7d55af8e303cf..a1ab0e31eca7b 100644
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


