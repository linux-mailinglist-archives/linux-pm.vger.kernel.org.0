Return-Path: <linux-pm+bounces-18733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6DE9E7E64
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 06:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06DD16C30F
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 05:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70188139CEF;
	Sat,  7 Dec 2024 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="da3KuxmI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65583CC7;
	Sat,  7 Dec 2024 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549778; cv=none; b=V73DJyw7NT2ewpo7ParxezkWnN7Xrk61DrE/7RyvkHh1RiNVBfQBl9ptBy0whUAlJl7nuEvBn8fay0nensHiqqnMADscqJ5StuSapx+oB+N6xnfIrge31RTyFztMc+qa4XQKSz0iVdNwx/c3YgweHBuisCd01cH9LcoR7i43gqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549778; c=relaxed/simple;
	bh=tiweYiO/o78z7gOGlzjAhkrotb1TXERqKcY10pXpfNY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBDAGCXJkgmQ1yq3QSmccHF+QrzO+vHnkz7xaSqcqblkDSZwd3rz6t+3n2ytxQcsvZRkmvDn/7OOY7XGqt096yfIEc5CpHG4xXAJH25PMkTM+q3HzO/raVVrCyhfjpQMdSx64dED5pdfjxu6j3raHYMVOFAS3sZiQpvTOS0IgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=da3KuxmI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733549777; x=1765085777;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tiweYiO/o78z7gOGlzjAhkrotb1TXERqKcY10pXpfNY=;
  b=da3KuxmINltpI78gsF5nUhg4b/Ey2ZaL/rOA+AZrJz88MXk10pNGkCmb
   WJ0rYXbL88DyRAjP+nhgjaJKlmdduwrui3Ctl843tYJ2jDQAj6SilPn6v
   yYGQToLA0E3d60Iwcm05WRSR5nXxNX202UeUmsiMHmSYvbW/YAVBU9BTg
   vO1y4/JOK2aW3RKKpSUqYSB3KsZRnnNbiwopTAe4WeP8J2YIY+8TVuYG9
   w8/3MnwBDy2FT3kUNyg9QoIviV8wkS72o1o7F4NrvhcLXy66/qDvjRIve
   c8oDoaHMCBxevc4Q/aNmEokPmXQ6Zao5SmQtKnqhlM8X84NSAxTaWaLFT
   A==;
X-CSE-ConnectionGUID: ZKiFOOJTTBiKLzOlgEVuqQ==
X-CSE-MsgGUID: ahH2q8cJT9Os7xwznAbKaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37590270"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="37590270"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:17 -0800
X-CSE-ConnectionGUID: vYIGwOQFR92jNcOScAvpyA==
X-CSE-MsgGUID: M0EN5+/dTieStk+twuWFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="99543370"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.37])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:14 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/3] platform/x86:intel/pmc: Create info structure for pmc device
Date: Fri,  6 Dec 2024 21:35:52 -0800
Message-ID: <20241207053607.14806-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241207053607.14806-1-xi.pardee@linux.intel.com>
References: <20241207053607.14806-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an info structure to store platform specific information.
For Tiger Lake and Arrow Lake platforms, multiple platform variations
could share one generic init function. Using info structure could
avoid if () forest. Modify tgl.c to use the info structure.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h | 15 ++++++++++++
 drivers/platform/x86/intel/pmc/tgl.c  | 33 +++++++++++++++------------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a1886d8e1ef3e..3124315d2b925 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -428,6 +428,21 @@ struct pmc_dev {
 	struct pmc_info *regmap_list;
 };
 
+/**
+ * struct pmc_dev_info - Structure to keep pmc device info
+ * @func:		function number of the primary pmc
+ * @map:		pointer to a pmc_reg_map struct that contains platform
+ *			specific attributes of the primary pmc
+ * @suspend:		Function to perform platform specific suspend
+ * @resume:		Function to perform platform specific resume
+ */
+struct pmc_dev_info {
+	u8 func;
+	const struct pmc_reg_map *map;
+	void (*suspend)(struct pmc_dev *pmcdev);
+	int (*resume)(struct pmc_dev *pmcdev);
+};
+
 enum pmc_index {
 	PMC_IDX_MAIN,
 	PMC_IDX_SOC = PMC_IDX_MAIN,
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 4fec43d212d01..c6fc3a0225a55 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -13,11 +13,6 @@
 #define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
 #define ACPI_GET_LOW_MODE_REGISTERS	1
 
-enum pch_type {
-	PCH_H,
-	PCH_LP
-};
-
 const struct pmc_bit_map tgl_pfear_map[] = {
 	{"PSF9",		BIT(0)},
 	{"RES_66",		BIT(1)},
@@ -285,18 +280,26 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
-static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
+static struct pmc_dev_info tgl_l_pmc_dev = {
+	.map = &tgl_reg_map,
+	.suspend = cnl_suspend,
+	.resume = cnl_resume,
+};
+
+static struct pmc_dev_info tgl_pmc_dev = {
+	.map = &tgl_h_reg_map,
+	.suspend = cnl_suspend,
+	.resume = cnl_resume,
+};
+
+static int tgl_core_generic_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
 	int ret;
 
-	if (pch_tp == PCH_H)
-		pmc->map = &tgl_h_reg_map;
-	else
-		pmc->map = &tgl_reg_map;
-
-	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = cnl_resume;
+	pmc->map = pmc_dev_info->map;
+	pmcdev->suspend = pmc_dev_info->suspend;
+	pmcdev->resume = pmc_dev_info->resume;
 
 	ret = get_primary_reg_base(pmc);
 	if (ret)
@@ -310,10 +313,10 @@ static int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp)
 
 int tgl_l_core_init(struct pmc_dev *pmcdev)
 {
-	return tgl_core_generic_init(pmcdev, PCH_LP);
+	return tgl_core_generic_init(pmcdev, &tgl_l_pmc_dev);
 }
 
 int tgl_core_init(struct pmc_dev *pmcdev)
 {
-	return tgl_core_generic_init(pmcdev, PCH_H);
+	return tgl_core_generic_init(pmcdev, &tgl_pmc_dev);
 }
-- 
2.43.0


