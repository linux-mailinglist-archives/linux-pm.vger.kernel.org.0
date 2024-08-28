Return-Path: <linux-pm+bounces-13093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAE79634D6
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 00:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859FE1F25EE6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7041B1512;
	Wed, 28 Aug 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMU+3ntS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADDC1B1404;
	Wed, 28 Aug 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884185; cv=none; b=r5L/7vfYAZfRT6PyCBdNwAphS4c+rScPE9bl68qNVOBGbe6Iby/Hi3Sc5/WAuL4OvysKZPcXX1fpYujysx3yMhkjpR3dEKHJp2lYu9bjF7C8i+Cp0GL8SBq5HILemicC5QyvP3tO5IevQGG2PHXSCR8ulCLYnvoUr+ih26stQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884185; c=relaxed/simple;
	bh=n2+XxhS8RbCA2nUKj977ASw/uOoZJC2tIZ2qEyh/RFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTquNsuPsBRIeVgTBFOguQ+tNX759sZ+DWqNTDjNm6YRwcjo/OKIMQhB+mU8UOlDWsgJ+SbYZkH2b2p6dYlx5SoLrtNTIPzFsQniQe0F1x37uOO6aKWN+d3WS1kgqKHgJKF7SyGbVvDQQ81aSX0yfHvz4aCmYVNcdpSri7x1j+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMU+3ntS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884184; x=1756420184;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=n2+XxhS8RbCA2nUKj977ASw/uOoZJC2tIZ2qEyh/RFQ=;
  b=LMU+3ntSgXggzvQQ6KuRvgynwpWBL/IOKNBn/BQVNhesRmk7n25WeJo4
   D5EiqbXgvSiSH5QgU6N+ma/KUWsGaC5mQdVVE/pl2NLEI9nAY+WBYTX2n
   aVHVkqStEPSFdURhzFI24HxxBdbkJTJk+cDvIBTqArtYQShA2zQzDh/xS
   ctGp7//ESEmDcRUCLmrIuVeNAQI2xSyfvbKp9DDHWt1iQEVhxSrcQbD4s
   Wg4qGxRlifFOS8Iz0Ur4anhDrgPKw+CDGdYMA2yVUGkIxpxXs2y76hy7B
   FBGmGSqorftAo+MS4XaeoHbhKDthv+OreGIRVXYhtz1hh+LGSf3cQceJq
   g==;
X-CSE-ConnectionGUID: KwJk5KreQUuR0LRhWKypIg==
X-CSE-MsgGUID: pCF86SZBSjqZkdwiioCg1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23406498"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23406498"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:42 -0700
X-CSE-ConnectionGUID: R8PZHepqSwuj8rBGuO6tLA==
X-CSE-MsgGUID: d6xJDn9mTZmoxLmW5PleQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271833"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.220.10])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:29:42 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 11/11] platform/x86:intel/pmc: Get LPM information for Lunar Lake
Date: Wed, 28 Aug 2024 15:29:26 -0700
Message-ID: <20240828222932.1279508-12-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to find and read the requirements from the telemetry
entries for Lunar Lake platforms.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/lnl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 109b08d43fc8..f5fee9e105e2 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,8 +13,13 @@
 
 #include "core.h"
 
+#define SOCM_LPM_REQ_GUID	0x15099748
+
+static const u8 LNL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 static struct pmc_info lnl_pmc_info_list[] = {
 	{
+		.guid	= SOCM_LPM_REQ_GUID,
 		.devid	= PMC_DEVID_LNL_SOCM,
 		.map	= &lnl_socm_reg_map,
 	},
@@ -536,6 +541,7 @@ const struct pmc_reg_map lnl_socm_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 	.s0ix_blocker_maps = lnl_blk_maps,
 	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+	.lpm_reg_index = LNL_LPM_REG_INDEX,
 };
 
 #define LNL_NPU_PCI_DEV		0x643e
@@ -561,6 +567,8 @@ static int lnl_resume(struct pmc_dev *pmcdev)
 
 int lnl_core_init(struct pmc_dev *pmcdev)
 {
+	bool ssram_init = true;
+	int func = 2;
 	int ret;
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 
@@ -578,6 +586,7 @@ int lnl_core_init(struct pmc_dev *pmcdev)
 
 	/* If regbase not assigned, set map and discover using legacy method */
 	if (ret) {
+		ssram_init = false;
 		pmc->map = &lnl_socm_reg_map;
 		ret = get_primary_reg_base(pmc);
 		if (ret)
@@ -586,5 +595,11 @@ int lnl_core_init(struct pmc_dev *pmcdev)
 
 	pmc_core_get_low_power_modes(pmcdev);
 
+	if (ssram_init)	{
+		ret = pmc_core_ssram_get_lpm_reqs(pmcdev, func);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
-- 
2.43.0


