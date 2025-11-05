Return-Path: <linux-pm+bounces-37485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5411AC381A2
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 22:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD6BC4EB9D4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E612DF716;
	Wed,  5 Nov 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6iVsTNI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5128726E;
	Wed,  5 Nov 2025 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379435; cv=none; b=olNzBn2s+BSkNLRSyZebQl++Kqf23kha6irjuMPVCsm9KsMSG07quGnLEtNF/Bn+y4sM+LEOh5VaBkfWntmPTFiet1lN3s/Rk8sz4bsU5myv1jxbKzN0glwYWP1g2rbpZscPRooZaT0vTWb4K/bXd+9YLNTYYRUwo+oZMLAu9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379435; c=relaxed/simple;
	bh=S5nQUd1tO6xifhkAYmsEUK4WsftUOMiysdyeasv2TVk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVIfaIS+SQf5zKRR4g+GX6Sltw9ncG/x5M1Ob8P8R8n0BwsLugc3QQmbgIz+jhwLfn/7tK+6UhzqzsmZUoYfqUQKiGqSRARQDOBqdsldYsrZTj3Vrqz43yfBSS3ZiqhmITyo/m/SP6a+t9+VPBaa6fU86IIQowxM58ejgiio3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6iVsTNI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762379434; x=1793915434;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=S5nQUd1tO6xifhkAYmsEUK4WsftUOMiysdyeasv2TVk=;
  b=h6iVsTNIXUAUemSJKmP2f7ktWTnSZN3qj3YGpDYdLTf7CMvETUM8Iql/
   mVGuR5pscsppHL04MqeIiOeJKJSCFQ6yUt5XAh3Y9M0bfgGgl1AZPIQHJ
   b2/Hi9iZWUBLxtpDg78ccyS3ze5b0ivftzmdfuFGuulF6h6p2SCrsDULw
   HyBHSGrJHp+2G79lN/+Wz+gSUOo1nALeR3iU4mDhxO1HGvIGwkYoTjEbd
   Al+rag2RKhOeOewn0D72RFjm7DPEI/x7iF7NeM4UcXZe8gDkKjGbu7SSC
   6lSsJC/XbzSBDVza9pKjFeoqyDx/5XctFXKC1Uo2ODbg65VblFvdxFXUb
   w==;
X-CSE-ConnectionGUID: Ua+EYx/WROyzLuMaq/rpWw==
X-CSE-MsgGUID: Tz3Y0LUJTYKEy1LO6VaJzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75622027"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75622027"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:50:33 -0800
X-CSE-ConnectionGUID: fqAa/V+JTomBSFS95a/o3g==
X-CSE-MsgGUID: o19tOGFaR9GoecF3kGcxUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="186856285"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.111.12])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:50:32 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] platform/x86:intel/pmc: Enable SSRAM support for Wildcat Lake
Date: Wed,  5 Nov 2025 13:50:15 -0800
Message-ID: <20251105215020.1984036-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105215020.1984036-1-xi.pardee@linux.intel.com>
References: <20251105215020.1984036-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Wildcat Lake platforms to achieve PMC information from
Intel PMC SSRAM Telemetry driver and substate requirements data
from telemetry region.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h |  2 ++
 drivers/platform/x86/intel/pmc/wcl.c  | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 61c8d3c5faa0f..272fb4f57f346 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -304,6 +304,8 @@ enum ppfear_regs {
 /* Wildcat Lake */
 #define WCL_PMC_LTR_RESERVED			0x1B64
 #define WCL_PCD_PMC_MMIO_REG_LEN		0x3178
+#define WCL_NUM_S0IX_BLOCKER			94
+#define WCL_BLK_REQ_OFFSET			50
 
 /* SSRAM PMC Device ID */
 /* LNL */
diff --git a/drivers/platform/x86/intel/pmc/wcl.c b/drivers/platform/x86/intel/pmc/wcl.c
index 85e90a639e651..a45707e6364f2 100644
--- a/drivers/platform/x86/intel/pmc/wcl.c
+++ b/drivers/platform/x86/intel/pmc/wcl.c
@@ -11,6 +11,9 @@
 
 #include "core.h"
 
+/* PMC SSRAM PMT Telemetry GUIDS */
+#define PCDN_LPM_REQ_GUID 0x33747648
+
 static const struct pmc_bit_map wcl_pcdn_pfear_map[] = {
 	{"PMC_0",               BIT(0)},
 	{"FUSE_OSSE",           BIT(1)},
@@ -453,6 +456,17 @@ static const struct pmc_reg_map wcl_pcdn_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.s0ix_blocker_maps = wcl_pcdn_blk_maps,
 	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+	.num_s0ix_blocker = WCL_NUM_S0IX_BLOCKER,
+	.blocker_req_offset = WCL_BLK_REQ_OFFSET,
+	.lpm_req_guid = PCDN_LPM_REQ_GUID,
+};
+
+static struct pmc_info wcl_pmc_info_list[] = {
+	{
+		.devid	= PMC_DEVID_WCL_PCDN,
+		.map	= &wcl_pcdn_reg_map,
+	},
+	{}
 };
 
 #define WCL_NPU_PCI_DEV                0xfd3e
@@ -479,8 +493,12 @@ static int wcl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info wcl_pmc_dev = {
+	.pci_func = 2,
+	.regmap_list = wcl_pmc_info_list,
 	.map = &wcl_pcdn_reg_map,
+	.sub_req_show = &pmc_core_substate_blk_req_fops,
 	.suspend = cnl_suspend,
 	.resume = wcl_resume,
 	.init = wcl_core_init,
+	.sub_req = pmc_core_pmt_get_blk_sub_req,
 };
-- 
2.43.0


