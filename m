Return-Path: <linux-pm+bounces-34422-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1EB52341
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 23:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E71BC179B
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD834309F07;
	Wed, 10 Sep 2025 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oA05b95i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F830748D;
	Wed, 10 Sep 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538399; cv=none; b=AiWFIKKPGuXTbYoRhy02V36tXq8616B3yLD6UJzEgw8Aj7Q+f0u283RH+WEFiTUlw/K3qSv5QDwcU+89qdsKx9rOqF/CLHgrT/Snqcl72v0HWWxRyylW9glq7KN3GnPKMAieqmwYJjxEOh9Bl5fN4Ss+FDzBMr8GoynGHtS3bdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538399; c=relaxed/simple;
	bh=/2NkNQuE+1Dc77xeUbrmiQTm9He187B/H7jaxccCAT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEuG8IfZ1ks8WfuTIuZ75fPhJZLhSZSmCVVvqssHS40+RHW8ZxER5prtGJZ931AGsSTaDYXr2fuPB9RaFs2dBBAwiVRANcm5jKFnARIy0+L2h+anjEzmdQMakUz4q3qXcDTiJcIIrGHMtGL5QNo1UCXJxGqJCX6My/4msf8QBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oA05b95i; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757538398; x=1789074398;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/2NkNQuE+1Dc77xeUbrmiQTm9He187B/H7jaxccCAT0=;
  b=oA05b95izTlMomR5OeHIlchS59ctfobNZl++CrE1bGk5ARB7KEAnMnr0
   MX5UgjGCkBrUa0qAcx/o3wbeZ2v1ohM/tySNLWNLo9bjH76o9Gs4StqNe
   8M8XjvAqNm2yxmQCElFijrPlfxakHjYp+CekVGyHoVmVQi8xM3kBRd+eI
   j762K4HDQU0iHDCGWX1O7++iReYGt87w8E51m1wp29B4QCO/h/UCI/inx
   Sb44N21BciPf3cFVM2mrT6ilC9MAKV5ePrB+x+oZHERRQt6ZMuTeSZifZ
   Rnfh0/itqoTiP3fEiKgNR0h2sXpBAxe49iwmFHiIP69X8kgt5HIgkHe2U
   Q==;
X-CSE-ConnectionGUID: v8JiLHclSbK59q0HV1oclw==
X-CSE-MsgGUID: trrnCr/gTKysX+HtW4CL5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82448493"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82448493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:37 -0700
X-CSE-ConnectionGUID: /3VqNt5mR2mC3+b6bx44FA==
X-CSE-MsgGUID: rBjPClj+TxG8OkMrRJ9Dcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177842755"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:06:37 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 5/5] platform/x86:intel/pmc: Enable SSRAM support for Panther Lake
Date: Wed, 10 Sep 2025 14:06:25 -0700
Message-ID: <20250910210629.11198-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910210629.11198-1-xi.pardee@linux.intel.com>
References: <20250910210629.11198-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Panther Lake platforms to achieve PMC information from
Intel PMC SSRAM Telemetry driver and substate requirements data
from telemetry region.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h |  2 ++
 drivers/platform/x86/intel/pmc/ptl.c  | 31 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index b554805db689d..f4dadb696a314 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -297,6 +297,8 @@ enum ppfear_regs {
 #define PTL_PMC_LTR_CUR_ASLT			0x1C28
 #define PTL_PMC_LTR_CUR_PLT			0x1C2C
 #define PTL_PCD_PMC_MMIO_REG_LEN		0x31A8
+#define PTL_NUM_S0IX_BLOCKER			106
+#define PTL_BLK_REQ_OFFSET			55
 
 /* Wildcat Lake */
 #define WCL_PMC_LTR_RESERVED			0x1B64
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
index 1bbec9856867d..1b35b84e06fa2 100644
--- a/drivers/platform/x86/intel/pmc/ptl.c
+++ b/drivers/platform/x86/intel/pmc/ptl.c
@@ -10,6 +10,17 @@
 
 #include "core.h"
 
+/* PMC SSRAM PMT Telemetry GUIDS */
+#define PCDP_LPM_REQ_GUID 0x47179370
+
+/*
+ * Die Mapping to Product.
+ * Product PCDDie
+ * PTL-H   PCD-H
+ * PTL-P   PCD-P
+ * PTL-U   PCD-P
+ */
+
 static const struct pmc_bit_map ptl_pcdp_pfear_map[] = {
 	{"PMC_0",               BIT(0)},
 	{"FUSE_OSSE",           BIT(1)},
@@ -515,6 +526,22 @@ static const struct pmc_reg_map ptl_pcdp_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.s0ix_blocker_maps = ptl_pcdp_blk_maps,
 	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+	.num_s0ix_blocker = PTL_NUM_S0IX_BLOCKER,
+	.blocker_req_offset = PTL_BLK_REQ_OFFSET,
+};
+
+static struct pmc_info ptl_pmc_info_list[] = {
+	{
+		.guid	= PCDP_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_PTL_PCDH,
+		.map	= &ptl_pcdp_reg_map,
+	},
+	{
+		.guid   = PCDP_LPM_REQ_GUID,
+		.devid  = PMC_DEVID_PTL_PCDP,
+		.map    = &ptl_pcdp_reg_map,
+	},
+	{}
 };
 
 #define PTL_NPU_PCI_DEV                0xb03e
@@ -543,8 +570,12 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info ptl_pmc_dev = {
+	.pci_func = 2,
+	.regmap_list = ptl_pmc_info_list,
 	.map = &ptl_pcdp_reg_map,
+	.sub_req_show = &pmc_core_substate_blk_req_fops,
 	.suspend = cnl_suspend,
 	.resume = ptl_resume,
 	.init = ptl_core_init,
+	.sub_req = pmc_core_pmt_get_blk_sub_req,
 };
-- 
2.43.0


