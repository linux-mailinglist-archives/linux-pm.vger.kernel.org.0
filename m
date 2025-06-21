Return-Path: <linux-pm+bounces-29206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B883AE2C86
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 23:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9848B3BB7A6
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DB2741D1;
	Sat, 21 Jun 2025 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kc3WlPrY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F2273D7F;
	Sat, 21 Jun 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750539944; cv=none; b=KJgTK1DVl0gf3hIhVmKdnq+bm6H9aWUUWpCV+IZwPhwsf55n0UuPOCoUzLUDi7InslV8/anlkh2LXK5kgrraB5pFlnaxZqnEJF1Om0ja0XjY1vMy3eYu2fNrabe1dfbD5iONtKLj4/fgcZK1no6WddIuqWu/Z3/CeOwzJQi49zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750539944; c=relaxed/simple;
	bh=SMiK8R4rvJPitqeDKcJiQw7hgXniGdGbaSll/QfassA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEP9V/D/rBJsMG3QMyBSPPXrfvyhK9t/cw60F0llJ7n6wyyLwOJwgqr/xNf98dR7xdjSlrqk528LSKR4rkZKD2FNlTfQtkjw9y6peIrBHN5Mo3A/B/RN97VgVOuKfWNzmf1MgSCuhCyMk2ZkKYmVAWgpd/T6x40wQCFNNBo3CRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kc3WlPrY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750539944; x=1782075944;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SMiK8R4rvJPitqeDKcJiQw7hgXniGdGbaSll/QfassA=;
  b=Kc3WlPrYRDodOvYwCix9g9qjrjIccScDNrM+JElYmCKb2yvPiXNR1dM3
   zcjEyDQR7p/Pxby35ERcl/9tqfcDRzDWn+fadAXhI4H/IAvvU/LiUd9KL
   S7U2FQuqbFcwEHUYvup0bK7XgF7OCgBNvAyBM0dN0naccmb/1PVn7eK4w
   VwQaZPa8OKJ+fsKxPrJ3cliIzKaHlBjDDV+DY+x508kzee6+KkZHhCl7X
   LBmJ4JIZxuLSGyvx52GC8zrg5WeGZLUwSiVxOFTLVnKBThD3VyKc4vzs9
   1sWstv7S8pkKfYjISVlq4sDpoDP+ZfmaC1md5evIeUk39zdLhp2D6pS2x
   Q==;
X-CSE-ConnectionGUID: 6gDswicOSkGJpbNUPo8mGA==
X-CSE-MsgGUID: xfXqSYAyTiyVkRpNjEB9+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="63826263"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="63826263"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:43 -0700
X-CSE-ConnectionGUID: tC0UU2EmRqqfqw525sJZHg==
X-CSE-MsgGUID: KTnUx5w6QIeXuFN7eQvtiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155775328"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.74])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:41 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 5/5] platform/x86:intel/pmc: Enable SSRAM support for Panther Lake
Date: Sat, 21 Jun 2025 14:05:25 -0700
Message-ID: <20250621210529.237964-6-xi.pardee@linux.intel.com>
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


