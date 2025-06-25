Return-Path: <linux-pm+bounces-29463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3666AE770A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E376617B4B3
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 06:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1220010C;
	Wed, 25 Jun 2025 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ce93dUPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254D1F7060;
	Wed, 25 Jun 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833114; cv=none; b=DxX05dLMCwWqRkCbS9tDmmqNvlq9Tuv+BvSdhkELmQfkOpSbxFu6uT9kZb/qPrVbIDtmk3fQbddGfXrtCLxPJC2M93BJvxB7t9xrvruLJZRTIaDIObJs3z3Gzn8HfZm7J1CV21ywgEqsq6g8+nj/fjM4vKXoqgWDbvPf4488ZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833114; c=relaxed/simple;
	bh=SMiK8R4rvJPitqeDKcJiQw7hgXniGdGbaSll/QfassA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBkwQ1y2X969sG/Pt9c4rvRdqqJm9zbJ0xB0exCg7qm6chIQPmsA+/keLIJ5NsRa/LrayW5ZRt4LF4yHql1PE/p9ONGkAoEb0XVkZbMAI15nIbZf86DNCLcAsHm0xz5AJPrH7cMRQIJrlzSzpOLZrj0SRJ88lECqpUu/Fjus7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ce93dUPU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750833113; x=1782369113;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SMiK8R4rvJPitqeDKcJiQw7hgXniGdGbaSll/QfassA=;
  b=Ce93dUPUmeK2ADq/PXQHI0pQfFNFWHlz45pXFGZ+bFMRDszpioCIty8I
   ZVJnSs+1ecEyyAvdVBL9zTyHYw92J/Ba18vY+bf91Dhw0RQ31iqtpVIc9
   RwVkjPL4A7pQA1kh9FLh+LPAzJ6MvSKyL771cfL4nDSXJ3Z2/k+ufCMgg
   eMGaQEGa7dvJpf94tWsFPGJ9MoRBRJudSH6DOMJnMbdkZZksTOf4ITx1s
   l9K8xWkKXnpwLsS7InpJMskNmr6Bb6b8FvZbVoCNFTvMEs627yMh2lliH
   3/Ub7pWPImRNZWaFo7ADhWCOtJwjzE0zJ3FVsvNJD7SKdJVGa7m3Xle8i
   w==;
X-CSE-ConnectionGUID: 6qQFeM5eSJy3kCilHHMXZA==
X-CSE-MsgGUID: unC6ecZ+ToWtvwQgwf0PGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53187472"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53187472"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:51 -0700
X-CSE-ConnectionGUID: aKc48rkyTwOrIAwOnLYbRQ==
X-CSE-MsgGUID: L991gemuTMCOYIYmXeBdSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152257582"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.223.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:50 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 5/5] platform/x86:intel/pmc: Enable SSRAM support for Panther Lake
Date: Tue, 24 Jun 2025 23:31:42 -0700
Message-ID: <20250625063145.624585-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625063145.624585-1-xi.pardee@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com>
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
 drivers/platform/x86/intel/pmc/ptl.c  | 30 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index d8c7b28493055..cdb32f2203cff 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -301,6 +301,8 @@ enum ppfear_regs {
 #define PTL_PMC_LTR_CUR_ASLT			0x1C28
 #define PTL_PMC_LTR_CUR_PLT			0x1C2C
 #define PTL_PCD_PMC_MMIO_REG_LEN		0x31A8
+#define PTL_NUM_S0IX_BLOCKER			106
+#define PTL_BLK_REQ_OFFSET			55
 
 /* SSRAM PMC Device ID */
 /* LNL */
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
index 394515af60d60..48be79b4e769f 100644
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
@@ -543,6 +570,9 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info ptl_pmc_dev = {
+	.pci_func = 2,
+	.telem_info = SUB_REQ_BLK,
+	.regmap_list = ptl_pmc_info_list,
 	.map = &ptl_pcdp_reg_map,
 	.suspend = cnl_suspend,
 	.resume = ptl_resume,
-- 
2.43.0


