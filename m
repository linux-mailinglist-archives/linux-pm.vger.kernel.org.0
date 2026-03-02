Return-Path: <linux-pm+bounces-43455-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOI0GKAWpmkCKQAAu9opvQ
	(envelope-from <linux-pm+bounces-43455-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:00:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7C71E6262
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DD9530CEBF5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115FA33F5A8;
	Mon,  2 Mar 2026 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+U8F8Vq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2431F9B5;
	Mon,  2 Mar 2026 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490742; cv=none; b=s9YEKlFZqsIf1j231Lc2dysR5ca0oNZ4hVDfF2F/zWhukED1Bc4Hp5PtzyPQiylyLITgQTQbfYpiOT8PcG49swMFHOoy7+CDPieD6d+jtHZvrjqHRAdJotFsTf2MC5p+iNl6imbvBPZCp0spz4vNWeSRGGKxVH+O9GkjEJo9nG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490742; c=relaxed/simple;
	bh=CuzRV0GDRADxSnYmElyIl7zEe+sonb2+QyA99xsOpYE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTfJcmMpqXtrc25gPnXnZ488izqUK6M8wupvrBc61ielnwM+ZtmQIqNxqxEzzy911wJeUUV9DCcCudPqLsT3vwSsV2DIgyuK3b1p9EbBehYfsSTVt+JKQebTpju8+q/t9jk0L6j2Uw/DGiyrt3Ntm8RPXq28bMtQA3LOAeJ4Z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+U8F8Vq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772490741; x=1804026741;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CuzRV0GDRADxSnYmElyIl7zEe+sonb2+QyA99xsOpYE=;
  b=Y+U8F8Vqsq1HWMTxMEhfF9/zP+M8P8pSTDNJEF9K+LRsud/+l+mE58l6
   cgWNrsgO8jf4QSyVi+191Vgj+8cxzOjyhcgQC0NAKTJUJg5rwXqU3fR5M
   AkuyVDt3ywRtxZtQ471ED/Wkk729/E1c/q4llnhg4TrpOilrN6p3muilt
   /oK/HcH+HyH45C5/mywxrJ1M6g6Aa0bm6FtmmnSrAJPubA3ToarjepWKS
   A/qanPr8iRjUg8TKMoJOA1wCuGOvPK2d/SxTR2w0rA1tYku6ElUfIa9oE
   9l1JMgZ1wEBVbb8W65ghLd+pwZqxZsfk7/8DBHIKCKaitirGW8SLUmCzY
   A==;
X-CSE-ConnectionGUID: OTHjaWv5RiudUnTwc9Y2fQ==
X-CSE-MsgGUID: yfVj2NGvTgiyjd9AIYOo4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73554508"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73554508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:19 -0800
X-CSE-ConnectionGUID: /t6jzE1qS8aUqeTuh+YUVA==
X-CSE-MsgGUID: pc4zgkICTA2strCc9OMoqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217793515"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.108.86])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 14:32:20 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 5/6] platform/x86/intel/pmc: Retrieve PMC info only for available PMCs
Date: Mon,  2 Mar 2026 14:32:07 -0800
Message-ID: <20260302223214.484585-6-xi.pardee@linux.intel.com>
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
X-Rspamd-Queue-Id: 5A7C71E6262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[xi.pardee@linux.intel.com,linux-pm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-43455-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.intel.com:mid]
X-Rspamd-Action: no action

Update the Intel PMC Core driver to fetch PMC information only for
available PMCs. Previously, the driver attempted to retrieve PMC info
even when the corresponding PMC was not present.

This change aligns with recent updates to the Intel SSRAM Telemetry
driver. Starting with NVL, the SSRAM Telemetry driver is probed for
each individual SSRAM device. The prior implementation could not
differentiate between an unavailable PMC and one that had not yet
completed information retrieval. To resolve this, the PMC Core driver
now skips obtaining PMC info for unavailable PMCs.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  |  5 +++++
 drivers/platform/x86/intel/pmc/core.c | 19 +++++++++++--------
 drivers/platform/x86/intel/pmc/core.h |  2 ++
 drivers/platform/x86/intel/pmc/lnl.c  |  3 +++
 drivers/platform/x86/intel/pmc/mtl.c  |  3 +++
 drivers/platform/x86/intel/pmc/ptl.c  |  3 +++
 drivers/platform/x86/intel/pmc/wcl.c  |  3 +++
 7 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 4d91ee010f6d0..34506542c94da 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -672,6 +672,9 @@ static struct pmc_info arl_pmc_info_list[] = {
 	{}
 };
 
+static u8 arl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_PCH, PMC_IDX_MAX};
+static u8 arl_h_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_MAX};
+
 #define ARL_NPU_PCI_DEV			0xad1d
 #define ARL_GNA_PCI_DEV			0xae4c
 #define ARL_H_NPU_PCI_DEV		0x7d1d
@@ -721,6 +724,7 @@ static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_
 static u32 ARL_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_pmc_dev = {
 	.dmu_guids = ARL_PMT_DMU_GUIDS,
+	.pmc_list = arl_pmc_list,
 	.regmap_list = arl_pmc_info_list,
 	.map = &arl_socs_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
@@ -735,6 +739,7 @@ struct pmc_dev_info arl_pmc_dev = {
 static u32 ARL_H_PMT_DMU_GUIDS[] = {ARL_PMT_DMU_GUID, ARL_H_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info arl_h_pmc_dev = {
 	.dmu_guids = ARL_H_PMT_DMU_GUIDS,
+	.pmc_list = arl_h_pmc_list,
 	.regmap_list = arl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 7bd0e1eaa32e2..85fff5e3abe0d 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1744,16 +1744,19 @@ static int pmc_core_pmc_add(struct pmc_dev *pmcdev, unsigned int pmc_idx)
 	return 0;
 }
 
-static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev)
+static int pmc_core_ssram_get_reg_base(struct pmc_dev *pmcdev, u8 *pmc_list)
 {
+	unsigned int i;
 	int ret;
 
-	ret = pmc_core_pmc_add(pmcdev, PMC_IDX_MAIN);
-	if (ret)
-		return ret;
-
-	pmc_core_pmc_add(pmcdev, PMC_IDX_IOE);
-	pmc_core_pmc_add(pmcdev, PMC_IDX_PCH);
+	for (i = 0; pmc_list[i] != PMC_IDX_MAX; ++i) {
+		if (pmc_list[i] == PMC_IDX_MAIN) {
+			ret = pmc_core_pmc_add(pmcdev, pmc_list[i]);
+			if (ret)
+				return ret;
+		} else
+			pmc_core_pmc_add(pmcdev, pmc_list[i]);
+	}
 
 	return 0;
 }
@@ -1775,7 +1778,7 @@ int generic_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 	ssram = pmc_dev_info->regmap_list != NULL;
 	if (ssram) {
 		pmcdev->regmap_list = pmc_dev_info->regmap_list;
-		ret = pmc_core_ssram_get_reg_base(pmcdev);
+		ret = pmc_core_ssram_get_reg_base(pmcdev, pmc_dev_info->pmc_list);
 		/*
 		 * EAGAIN error code indicates Intel PMC SSRAM Telemetry driver
 		 * has not finished probe and PMC info is not available yet. Try
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index f09791f866223..c4984e44f7b80 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -501,6 +501,7 @@ enum pmc_index {
  * @pc_guid:		GUID for telemetry region to read PKGC blocker info
  * @pkgc_ltr_blocker_offset: Offset to PKGC LTR blockers in telemetry region
  * @pkgc_blocker_offset:Offset to PKGC blocker in telemetry region
+ * @pmc_list:		Index list of available PMC
  * @regmap_list:	Pointer to a list of pmc_info structure that could be
  *			available for the platform. When set, this field implies
  *			SSRAM support.
@@ -521,6 +522,7 @@ struct pmc_dev_info {
 	u32 pc_guid;
 	u32 pkgc_ltr_blocker_offset;
 	u32 pkgc_blocker_offset;
+	u8 *pmc_list;
 	struct pmc_info *regmap_list;
 	const struct pmc_reg_map *map;
 	const struct file_operations *sub_req_show;
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 18f303af328e3..7b09b59e1326c 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -544,6 +544,8 @@ static struct pmc_info lnl_pmc_info_list[] = {
 	{}
 };
 
+static u8 lnl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
+
 #define LNL_NPU_PCI_DEV		0x643e
 #define LNL_IPU_PCI_DEV		0x645d
 
@@ -571,6 +573,7 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info lnl_pmc_dev = {
+	.pmc_list = lnl_pmc_list,
 	.regmap_list = lnl_pmc_info_list,
 	.map = &lnl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index b724dd8c34dba..6438fca266392 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -965,6 +965,8 @@ static struct pmc_info mtl_pmc_info_list[] = {
 	{}
 };
 
+static u8 mtl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_IOE, PMC_IDX_MAX};
+
 #define MTL_GNA_PCI_DEV	0x7e4c
 #define MTL_IPU_PCI_DEV	0x7d19
 #define MTL_VPU_PCI_DEV	0x7d1d
@@ -995,6 +997,7 @@ static int mtl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 static u32 MTL_PMT_DMU_GUIDS[] = {MTL_PMT_DMU_GUID, 0x0};
 struct pmc_dev_info mtl_pmc_dev = {
 	.dmu_guids = MTL_PMT_DMU_GUIDS,
+	.pmc_list = mtl_pmc_list,
 	.regmap_list = mtl_pmc_info_list,
 	.map = &mtl_socm_reg_map,
 	.sub_req_show = &pmc_core_substate_req_regs_fops,
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
index 6c68772e738c8..538ca5ae2e9ec 100644
--- a/drivers/platform/x86/intel/pmc/ptl.c
+++ b/drivers/platform/x86/intel/pmc/ptl.c
@@ -543,6 +543,8 @@ static struct pmc_info ptl_pmc_info_list[] = {
 	{}
 };
 
+static u8 ptl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
+
 #define PTL_NPU_PCI_DEV                0xb03e
 #define PTL_IPU_PCI_DEV                0xb05d
 
@@ -569,6 +571,7 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info ptl_pmc_dev = {
+	.pmc_list = ptl_pmc_list,
 	.regmap_list = ptl_pmc_info_list,
 	.map = &ptl_pcdp_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
diff --git a/drivers/platform/x86/intel/pmc/wcl.c b/drivers/platform/x86/intel/pmc/wcl.c
index b55069945e9e7..429f53f22a89f 100644
--- a/drivers/platform/x86/intel/pmc/wcl.c
+++ b/drivers/platform/x86/intel/pmc/wcl.c
@@ -469,6 +469,8 @@ static struct pmc_info wcl_pmc_info_list[] = {
 	{}
 };
 
+static u8 wcl_pmc_list[] = {PMC_IDX_MAIN, PMC_IDX_MAX};
+
 #define WCL_NPU_PCI_DEV                0xfd3e
 
 /*
@@ -494,6 +496,7 @@ static int wcl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 
 struct pmc_dev_info wcl_pmc_dev = {
 	.regmap_list = wcl_pmc_info_list,
+	.pmc_list = wcl_pmc_list,
 	.map = &wcl_pcdn_reg_map,
 	.sub_req_show = &pmc_core_substate_blk_req_fops,
 	.suspend = cnl_suspend,
-- 
2.43.0


