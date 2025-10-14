Return-Path: <linux-pm+bounces-36098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5978FBDB713
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 23:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6804FC86D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010530C353;
	Tue, 14 Oct 2025 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWF/vCZF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95A2EA479;
	Tue, 14 Oct 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478384; cv=none; b=usznek1M9+DVMLPmPFEM2VUzSsPkEEyTi9lmhUoASYWZMkuaY6z92TzFLJnZxcj7MWihC+UFytViJ9uPT/PlxRbnSWd1R7YJ31mBZsZ1nW5v3chKYE4CgobBOun8MdaALIfBih391/aX7qSislAI6N4PloHkfdXfw1O3VQlfl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478384; c=relaxed/simple;
	bh=ZzLZaEgdjOlMGc6JxGdj/17LmKKhHp+96Ija2D67ojc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgacm7r7FCZbjn+N26apad3qCWq5XPuLZlBwnYhcEVDTX9i2F7RZvf/eOh3ytTeT79RQ4eQTGpUEc8lvTCyinBEnTx+apYFYgtOPO/kYi4xhq141oekuDpztMdp6FgiQZANvyXFbbVK0Aa0DDWVT7Xw67DY6DS50wsmW3tIAv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWF/vCZF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478383; x=1792014383;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ZzLZaEgdjOlMGc6JxGdj/17LmKKhHp+96Ija2D67ojc=;
  b=HWF/vCZFaRPeetdsIqUKO/RhGj0z0Y74Pg6Wbv5mVb3Q8jdqIAiz/s0S
   G6s79v8GMw64fg2RtPLVtoGYTgIsSvOZfb3Z+atV74Mw//Lkted2a1wRX
   myqzi3wiDlmL2pvIJAc+UOPqQ31ay1LYFApcXy0zlFMwzyBE+4r7tgxSQ
   Z1OLT2BOMjMBaCY+SH9oSfE717ftBHVuteZeWIqDNjFXZCzPkj/agoxhL
   fYMBwyOORA7pc8nU6FX/mL0qTfD2e6U7AiPtYBKn18sVMGakFs0djSYbr
   HYVpfiHX1VnoPxew/cy8AbMsmAZcMkJwm4dF7v7naKh2x7N3qnbCIm7/u
   g==;
X-CSE-ConnectionGUID: f38S8NcTTEKi+yYFXMIetg==
X-CSE-MsgGUID: GBAtZ43SREm7uu+7ZhZ8lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62682442"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62682442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:21 -0700
X-CSE-ConnectionGUID: zrD33d/rR6a8Fg89W+wN7Q==
X-CSE-MsgGUID: VfLr0L+vQ9Chr7oQTDtK1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="187300332"
Received: from kcaccard-desk.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:46:20 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/6] platform/x86:intel/pmc: Add support for multiple DMU GUIDs
Date: Tue, 14 Oct 2025 14:45:30 -0700
Message-ID: <20251014214548.629023-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014214548.629023-1-xi.pardee@linux.intel.com>
References: <20251014214548.629023-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable support for multiple DMU GUIDs to accommodate Arrow
Lake H/U platforms. Arrow Lake U/H may have several GUIDs
pointing to a single telemetry region providing die C6 value
Add support to search for available GUIDs.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  |  6 ++++--
 drivers/platform/x86/intel/pmc/core.c | 23 +++++++++++++++++++----
 drivers/platform/x86/intel/pmc/core.h |  6 +++---
 drivers/platform/x86/intel/pmc/mtl.c  |  3 ++-
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 17ad87b392abe..cc05a168c3721 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -720,9 +720,10 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
 	return generic_core_init(pmcdev, pmc_dev_info);
 }
 
+static u32 ARL_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_pmc_dev = {
 	.pci_func = 0,
-	.dmu_guid = ARL_PMT_DMU_GUID,
+	.dmu_guids = ARL_PMT_DMU_GUIDS,
 	.regmap_list = arl_pmc_info_list,
 	.map = &arl_socs_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
@@ -732,9 +733,10 @@ struct pmc_dev_info arl_pmc_dev = {
 	.sub_req = pmc_core_pmt_get_lpm_req,
 };
 
+static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_h_pmc_dev = {
 	.pci_func = 2,
-	.dmu_guid = ARL_PMT_DMU_GUID,
+	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
 	.regmap_list = arl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index ac3d19ae8c56d..b6d45289eb84d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1281,7 +1281,22 @@ int get_primary_reg_base(struct pmc *pmc)
 	return 0;
 }
 
-void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid)
+static struct telem_endpoint *pmc_core_register_endpoint(struct pci_dev *pcidev, u32 *guids)
+{
+	struct telem_endpoint *ep;
+	unsigned int i;
+
+	for (i = 0; guids[i]; i++) {
+		ep = pmt_telem_find_and_register_endpoint(pcidev, guids[i], 0);
+
+		if (IS_ERR(ep))
+			continue;
+		return ep;
+	}
+	return ERR_PTR(-ENODEV);
+}
+
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
 {
 	struct telem_endpoint *ep;
 	struct pci_dev *pcidev;
@@ -1292,7 +1307,7 @@ void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid)
 		return;
 	}
 
-	ep = pmt_telem_find_and_register_endpoint(pcidev, guid, 0);
+	ep = pmc_core_register_endpoint(pcidev, guids);
 	pci_dev_put(pcidev);
 	if (IS_ERR(ep)) {
 		dev_err(&pmcdev->pdev->dev,
@@ -1689,8 +1704,8 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	}
 
 	pmc_core_get_low_power_modes(pmcdev);
-	if (pmc_dev_info->dmu_guid)
-		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guid);
+	if (pmc_dev_info->dmu_guids)
+		pmc_core_punit_pmt_init(pmcdev, pmc_dev_info->dmu_guids);
 
 	if (ssram) {
 		ret = pmc_core_get_telem_info(pmcdev, pmc_dev_info);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index d6818bd34768e..83d6e2e833785 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -481,7 +481,7 @@ enum pmc_index {
 /**
  * struct pmc_dev_info - Structure to keep PMC device info
  * @pci_func:		Function number of the primary PMC
- * @dmu_guid:		Die Management Unit GUID
+ * @dmu_guids:		List of Die Management Unit GUID
  * @regmap_list:	Pointer to a list of pmc_info structure that could be
  *			available for the platform. When set, this field implies
  *			SSRAM support.
@@ -495,7 +495,7 @@ enum pmc_index {
  */
 struct pmc_dev_info {
 	u8 pci_func;
-	u32 dmu_guid;
+	u32 *dmu_guids;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
 	const struct file_operations *sub_req_show;
@@ -532,7 +532,7 @@ int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
 void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
-void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 guid);
+void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids);
 void pmc_core_set_device_d3(unsigned int device);
 
 int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 0b87e10f864e6..19470ca311cf7 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -992,9 +992,10 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 	return generic_core_init(pmcdev, pmc_dev_info);
 }
 
+static u32 MTL_PMT_DMU_GUIDS[] = {MTL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info mtl_pmc_dev = {
 	.pci_func = 2,
-	.dmu_guid = MTL_PMT_DMU_GUID,
+	.dmu_guids = MTL_PMT_DMU_GUIDS,
 	.regmap_list = mtl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
-- 
2.43.0


