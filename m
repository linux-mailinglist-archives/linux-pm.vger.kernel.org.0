Return-Path: <linux-pm+bounces-29202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77790AE2C77
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 23:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C78C17804B
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 21:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0773271A9A;
	Sat, 21 Jun 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8GIuL/U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695427145B;
	Sat, 21 Jun 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750539939; cv=none; b=KqUVpJGMGREuZz515u4TNoMuqpzMWfWjjlhd9GdfoinUe/sDC+U4DXVKO23r6A+U3xQwIpiFR9zG5U6ThdYm6VkwbnCSIr2sNWNiZWhQaJoZFuM5UubnMdlZ7PL1vSYyZdd61OGNVKrRfE6/ySQ3R2SgRfcZNsUnQn9Hn0kJUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750539939; c=relaxed/simple;
	bh=gili3zJVF7ZQ9a+PUONOkac6Rm442IXQ0FJb+Dn1TgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWaFP7EzCjqxAyuzIGG7noVYv+lVxemN95w315mUUD98S3U6XZadcvXl0YZiFD3P6dFD3rumehRiqMRZbKII2/BKCckUUNGVQUq0ENH9tx2bnJKI4/DGEGCc/qytrQhXxcmFnjfo8lUDdpkh+WoWXBhOMjJHGGGWom2ClZrpfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8GIuL/U; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750539938; x=1782075938;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gili3zJVF7ZQ9a+PUONOkac6Rm442IXQ0FJb+Dn1TgA=;
  b=h8GIuL/UEOHFqLJu1dyoGuEERjQEiL7eTU+Y6PjhhXu94VgRfY+DLz2s
   EJZJKa3ogPSKcFD2stTNgrXlrFX1LjHi2Z0SfbBA41JC9QvxpADeGCV1o
   9IaOnwMEsLqKVlNOJp7krxbH8nZtkvgq5I8nRdsI+codcmhcd6HCVSaxS
   PkPkRNDqFlJnb6Z+sOklQ9TGgEgvdvHWlMdxczYLLmQwBU3Ta4q/UMUnI
   hr6A1di8keubbCfKsPSlekN3z6tUu6E3StkYYKVnmOdZLuQeUAz/baig/
   wAsEtipwBNMa4K0Re1/vvqIPayh0DX5WbyT2mGNizzpkx4krpaC+mY9+2
   Q==;
X-CSE-ConnectionGUID: hb2PXp8WSNOsnG5BHNkCVg==
X-CSE-MsgGUID: 8aIPXom8SEKZdxwN3Q5yVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="63826248"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="63826248"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:36 -0700
X-CSE-ConnectionGUID: 0bKJoyXJR8yuNDQ2ZOhVYA==
X-CSE-MsgGUID: p3GtArLsR46iChr1FrJeuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="155775322"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.74])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:05:33 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 1/5] platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
Date: Sat, 21 Jun 2025 14:05:21 -0700
Message-ID: <20250621210529.237964-2-xi.pardee@linux.intel.com>
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

Enable Lunar Lake platforms to achieve PMC information from
Intel PMC SSRAM Telemetry driver and substate requirements data
from telemetry region.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/lnl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index da513c234714b..e08a77c778c2c 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,6 +13,10 @@
 
 #include "core.h"
 
+#define SOCM_LPM_REQ_GUID	0x15099748
+
+static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 static const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
@@ -528,6 +532,16 @@ static const struct pmc_reg_map lnl_socm_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.s0ix_blocker_maps = lnl_blk_maps,
 	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+	.lpm_reg_index = LNL_LPM_REG_INDEX,
+};
+
+static struct pmc_info lnl_pmc_info_list[] = {
+	{
+		.guid	= SOCM_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_LNL_SOCM,
+		.map	= &lnl_socm_reg_map,
+	},
+	{}
 };
 
 #define LNL_NPU_PCI_DEV		0x643e
@@ -557,6 +571,8 @@ static int lnl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_in
 }
 
 struct pmc_dev_info lnl_pmc_dev = {
+	.pci_func = 2,
+	.regmap_list = lnl_pmc_info_list,
 	.map = &lnl_socm_reg_map,
 	.suspend = cnl_suspend,
 	.resume = lnl_resume,
-- 
2.43.0


