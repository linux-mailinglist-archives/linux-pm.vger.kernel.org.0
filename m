Return-Path: <linux-pm+bounces-43453-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF5AIwUXpmlWKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43453-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:02:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2C1E6323
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62B06309E105
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF642330D23;
	Mon,  2 Mar 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhuihO+L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123131F989;
	Mon,  2 Mar 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490741; cv=none; b=aHuEQQ3vN78W0jXbmQ5PAspUwJbehEG/3jW6NM2Ia0M+pc3ehxMVqmWMszSOZQSbKV/mOJxBXTJcYzs1ahhjbnb8LnUsU/cM24am0tOXGgY7cgaFWxAa+goPGdkYbrA32j79ex+TL2YSpLyp9It0C5wTXA2uWDZZMwyCuWnMzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490741; c=relaxed/simple;
	bh=V9PZnqBIi5r2xsZsKGa2Cl0Nu9rIT5U5xF+SBEuSVNA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjJ31opi0j5fLIO/bzkG17kLhl3p2XWtOR9DcHiE/smavxnJUIDvHmKp1kEG4YVDRav6c+mfswszKYJAR0JomLGNPQGY/1Wfxm6d2b3A4RQfH24wVy3kcgb3aObgK8LlTNX4O/7Z0A3yCn9+AExSsH+LZv28xZLZO5zIaOso5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhuihO+L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772490740; x=1804026740;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=V9PZnqBIi5r2xsZsKGa2Cl0Nu9rIT5U5xF+SBEuSVNA=;
  b=VhuihO+Lmqp4pTAgIxGcqJHzTx3LQ5aNZANLg5FEACfKQIKa13uCstu9
   gIJxsvP0ww95r+yObo/pkYKA70Gt3yo5EWe0ZYkxge/t7X0w/c1KWX0ec
   ZHpkIM52xH350sH5FBUtDmQHw9fJTKeDfMzJHa8lfuQtpNlNWAg1AlA/d
   BJsKbgbdoxb3TAVrEfJczgQaf7TiT4qQhH7z0UojZPWRp4LqFmEaR1/jW
   mA7HZczwLKKtz07JLNcTHJu+lOZHthfXj5R0/7XtRGX0U7L8/CaeGEGBp
   CTfGXxI6h+3LlGwSyqCxaa5UQWVH31TjADebwBZmKLC/2PEpV9kSWODgJ
   Q==;
X-CSE-ConnectionGUID: zTbBrCSlSyyO9Y7E7XCyeQ==
X-CSE-MsgGUID: BajKfMEsRVKDq1jHAEjKsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73554504"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73554504"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:18 -0800
X-CSE-ConnectionGUID: /9DEG6iSTYOKraDXM8aF+Q==
X-CSE-MsgGUID: s4jcXGkITXaaeF7IjcZRcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217793512"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.108.86])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:19 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/6] platform/x86/intel/pmc: Use PCI DID for PMC SSRAM device discovery
Date: Mon,  2 Mar 2026 14:32:05 -0800
Message-ID: <20260302223214.484585-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302223214.484585-1-xi.pardee@linux.intel.com>
References: <20260302223214.484585-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BD2C1E6323
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[xi.pardee@linux.intel.com,linux-pm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43453-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Update the PMC SSRAM discovery process to identify the device using its
PCI Device ID rather than relying on a fixed PCI bus location. The
enumeration of integrated devices on the PCI bus is no longer guaranteed
to be consistent across CPUs.

On earlier platforms, the IOE and PCH SSRAM devices were hidden from the
BIOS, and the SOC SSRAM device is associated to telemetry regions from all
available SSRAM devices. Starting with Nova Lake, the IOE and PCH SSRAM
devices register their telemetry regions independently, meaning each
telemetry region is now linked to its corresponding SSRAM device. A new
ssram_hidden attribute has been added to the pmc_dev_info structure to
reflect this distinction.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  |  4 ++--
 drivers/platform/x86/intel/pmc/core.c | 16 ++++++++++++----
 drivers/platform/x86/intel/pmc/core.h |  6 ++++--
 drivers/platform/x86/intel/pmc/lnl.c  |  2 +-
 drivers/platform/x86/intel/pmc/mtl.c  |  2 +-
 drivers/platform/x86/intel/pmc/ptl.c  |  2 +-
 drivers/platform/x86/intel/pmc/wcl.c  |  2 +-
 7 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index eb23bc68340ab..95372a0807acf 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -720,7 +720,6 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
 
 static u32 ARL_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_pmc_dev = {
-	.pci_func = 0,
 	.dmu_guids = ARL_PMT_DMU_GUIDS,
 	.regmap_list = arl_pmc_info_list,
 	.map = &arl_socs_reg_map,
@@ -729,11 +728,11 @@ struct pmc_dev_info arl_pmc_dev = {
 	.resume = arl_resume,
 	.init = arl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
 
 static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_h_pmc_dev = {
-	.pci_func = 2,
 	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
 	.regmap_list = arl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
@@ -742,4 +741,5 @@ struct pmc_dev_info arl_h_pmc_dev = {
 	.resume = arl_h_resume,
 	.init = arl_h_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index e5b48a68cf495..7670970c995b9 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1660,12 +1660,10 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *
 	unsigned int pmc_idx;
 	int ret;
 
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, pmc_dev_info->pci_func));
-	if (!pcidev)
-		return -ENODEV;
-
 	for (pmc_idx = 0; pmc_idx < ARRAY_SIZE(pmcdev->pmcs); ++pmc_idx) {
+		struct pci_dev *pcidev __free(pci_dev_put) = NULL;
 		struct pmc *pmc;
+		u16 devid;
 
 		pmc = pmcdev->pmcs[pmc_idx];
 		if (!pmc)
@@ -1674,6 +1672,15 @@ static int pmc_core_get_telem_info(struct pmc_dev *pmcdev, struct pmc_dev_info *
 		if (!pmc->map->lpm_req_guid)
 			return -ENXIO;
 
+		if (pmc_dev_info->ssram_hidden)
+			devid = pmcdev->pmcs[PMC_IDX_MAIN]->devid;
+		else
+			devid = pmc->devid;
+
+		pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, devid, NULL);
+		if (!pcidev)
+			return -ENODEV;
+
 		ep = pmt_telem_find_and_register_endpoint(pcidev, pmc->map->lpm_req_guid, 0);
 		if (IS_ERR(ep)) {
 			dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %pe", ep);
@@ -1724,6 +1731,7 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_idx)
 
 	pmc->map = map;
 	pmc->base_addr = pmc_ssram_telemetry.base_addr;
+	pmc->devid = pmc_ssram_telemetry.devid;
 	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
 
 	if (!pmc->regbase) {
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 829b1dee3f636..31fe71b01120b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -425,6 +425,7 @@ struct pmc_info {
  * @ltr_ign:		Holds LTR ignore data while suspended
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
+ * @devid:		Device ID of the SSRAM device
  *
  * pmc contains info about one power management controller device.
  */
@@ -436,6 +437,7 @@ struct pmc {
 	u32 ltr_ign;
 	u8 num_lpm_modes;
 	u8 lpm_en_modes[LPM_MAX_NUM_MODES];
+	u16 devid;
 };
 
 /**
@@ -495,7 +497,6 @@ enum pmc_index {
 
 /**
  * struct pmc_dev_info - Structure to keep PMC device info
- * @pci_func:		Function number of the primary PMC
  * @dmu_guids:		List of Die Management Unit GUID
  * @pc_guid:		GUID for telemetry region to read PKGC blocker info
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
@@ -512,9 +513,9 @@ enum pmc_index {
  * @resume:		Function to perform platform specific resume
  * @init:		Function to perform platform specific init action
  * @sub_req:		Function to achieve low power mode substate requirements
+ * @ssram_hidden:	Flag to indicate whether SSRAM is hidden
  */
 struct pmc_dev_info {
-	u8 pci_func;
 	u32 *dmu_guids;
 	u32 pc_guid;
 	u32 pkgc_ltr_blocker_offset;
@@ -528,6 +529,7 @@ struct pmc_dev_info {
 	int (*resume)(struct pmc_dev *pmcdev);
 	int (*init)(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info);
 	int (*sub_req)(struct pmc_dev *pmcdev, struct pmc *pmc, struct telem_endpoint *ep);
+	bool ssram_hidden;
 };
 
 extern const struct pmc_bit_map msr_map[];
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 1cd81ee54dcf8..18f303af328e3 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -571,7 +571,6 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info lnl_pmc_dev = {
-	.pci_func = 2,
 	.regmap_list = lnl_pmc_info_list,
 	.map = &lnl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
@@ -579,4 +578,5 @@ struct pmc_dev_info lnl_pmc_dev = {
 	.resume = lnl_resume,
 	.init = lnl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 57508cbf9cd42..193ebbe584023 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -994,7 +994,6 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 
 static u32 MTL_PMT_DMU_GUIDS[] = {MTL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info mtl_pmc_dev = {
-	.pci_func = 2,
 	.dmu_guids = MTL_PMT_DMU_GUIDS,
 	.regmap_list = mtl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
@@ -1003,4 +1002,5 @@ struct pmc_dev_info mtl_pmc_dev = {
 	.resume = mtl_resume,
 	.init = mtl_core_init,
 	.sub_req = pmc_core_pmt_get_lpm_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
index 1f48e2bbc699f..6c68772e738c8 100644
--- a/drivers/platform/x86/intel/pmc/ptl.c
+++ b/drivers/platform/x86/intel/pmc/ptl.c
@@ -569,7 +569,6 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info ptl_pmc_dev = {
-	.pci_func = 2,
 	.regmap_list = ptl_pmc_info_list,
 	.map = &ptl_pcdp_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
@@ -577,4 +576,5 @@ struct pmc_dev_info ptl_pmc_dev = {
 	.resume = ptl_resume,
 	.init = ptl_core_init,
 	.sub_req = pmc_core_pmt_get_blk_sub_req,
+	.ssram_hidden = true,
 };
diff --git a/drivers/platform/x86/intel/pmc/wcl.c b/drivers/platform/x86/intel/pmc/wcl.c
index a45707e6364f2..b55069945e9e7 100644
--- a/drivers/platform/x86/intel/pmc/wcl.c
+++ b/drivers/platform/x86/intel/pmc/wcl.c
@@ -493,7 +493,6 @@ static int wcl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info wcl_pmc_dev = {
-	.pci_func = 2,
 	.regmap_list = wcl_pmc_info_list,
 	.map = &wcl_pcdn_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
@@ -501,4 +500,5 @@ struct pmc_dev_info wcl_pmc_dev = {
 	.resume = wcl_resume,
 	.init = wcl_core_init,
 	.sub_req = pmc_core_pmt_get_blk_sub_req,
+	.ssram_hidden = true,
 };
-- 
2.43.0


