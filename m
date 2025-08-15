Return-Path: <linux-pm+bounces-32462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC965B2888E
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 00:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53453A714E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1A2797B7;
	Fri, 15 Aug 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFJ3KC87"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553E26FA5B;
	Fri, 15 Aug 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297982; cv=none; b=CO8ewOJTS8cEZQwAz0NBsO1RH1akmGfQy979Kbtdvp4GG9e5AQqp9GJksXVKwdoqLiV1svpoTpWOVKGbGOOrLGAGUIGsFXYRDaiG1LJUl5cQ4Se5ITNkUAU8W7sEcdSPWCdzO4SQXF3s5xaC9e4qXH5pd0TdY/a7tg/mG+Q4MIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297982; c=relaxed/simple;
	bh=u9fFsF2iHOwJaZjt2Mj49SD8+5gqYNXn9/RV/uV7boE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcROuywlffmdc3tkp6CVljj+ExIn6QiQbONGjWyS1BuIBJ88EdS63bcQU0bUjP1X+Mmd6JdIo4Uz0iXdbnhsTvq04nNdudcyzQyJ0DSLq9uQ58yG51JtVUjqEPodDkWln25s4yTFrjTMPblVzX2KLWvgsBRxV9vpzIeyF30GFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFJ3KC87; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297980; x=1786833980;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=u9fFsF2iHOwJaZjt2Mj49SD8+5gqYNXn9/RV/uV7boE=;
  b=jFJ3KC87wPjJT4n06i2IPHXSsiFrGhJy4fawJmFCqRhSTjwa4oczPHM0
   q0+V/nvMrClbLLFEb3PdIdiROITOauiJeY4GUH18ddywcoxRqkK2ldCnU
   rBByoBYjqCRk4PyuyEXHjvI0f4DDYKG1eVB087mAwdITo6BA7TVAY8xi6
   T/+boFYesEr4EadREN6xALyyeLn9HLUjN8KOWgeocejBSACkePe5tu2N5
   1DnVJbDotee4Wug0Clgx87eo/6BSOoVs4ejMQUm98gyQBo1r4/OpqWuDK
   G2YILJFIR/+Q0USG39MPqu9oOeTmBpnQ0yQkbPyNchhlJ3CMDMgZGLdl5
   Q==;
X-CSE-ConnectionGUID: Fxijb6FPR8epEje44Gjkqg==
X-CSE-MsgGUID: D08B+xhGSsmLvsCakltTwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57724954"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57724954"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:18 -0700
X-CSE-ConnectionGUID: RM8aahzWRDK+6S7oZSNsOA==
X-CSE-MsgGUID: rdzRp68gQK+m6ixyVZKKoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166734421"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:17 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 6/6] platform/x86:intel/pmc: Enable SSRAM support for Panther Lake
Date: Fri, 15 Aug 2025 15:46:04 -0700
Message-ID: <20250815224611.2460255-7-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
References: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
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
 drivers/platform/x86/intel/pmc/core.h |  4 ++++
 drivers/platform/x86/intel/pmc/ptl.c  | 33 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 6ff2d171dc2ba..381755aaeafaf 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -297,6 +297,10 @@ enum ppfear_regs {
 #define PTL_PMC_LTR_CUR_ASLT			0x1C28
 #define PTL_PMC_LTR_CUR_PLT			0x1C2C
 #define PTL_PCD_PMC_MMIO_REG_LEN		0x31A8
+#define PTL_NUM_S0IX_BLOCKER			106
+#define PTL_BLK_REQ_OFFSET			55
+#define PTL_BDF_OFFSET				0x0
+#define PTL_BDF_TABLE_SIZE			54
 
 /* SSRAM PMC Device ID */
 /* LNL */
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
index 394515af60d60..20c6dac7a6729 100644
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
@@ -515,6 +526,24 @@ static const struct pmc_reg_map ptl_pcdp_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.s0ix_blocker_maps = ptl_pcdp_blk_maps,
 	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+	.num_s0ix_blocker = PTL_NUM_S0IX_BLOCKER,
+	.blocker_req_offset = PTL_BLK_REQ_OFFSET,
+	.bdf_offset = PTL_BDF_OFFSET,
+	.bdf_table_size = PTL_BDF_TABLE_SIZE,
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
@@ -543,8 +572,12 @@ static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info ptl_pmc_dev = {
+	.pci_func = 2,
+	.regmap_list = ptl_pmc_info_list,
 	.map = &ptl_pcdp_reg_map,
+	.sub_req_show = &pmc_core_substate_blk_req_fops,
 	.suspend = cnl_suspend,
 	.resume = ptl_resume,
 	.init = ptl_core_init,
+	.sub_req = pmc_core_pmt_get_sub_req_bdf,
 };
-- 
2.43.0


