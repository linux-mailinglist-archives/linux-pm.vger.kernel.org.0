Return-Path: <linux-pm+bounces-21574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E879A2D11B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFD9188F8E4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A81DE8BE;
	Fri,  7 Feb 2025 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbHemJ2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893301DE3DE;
	Fri,  7 Feb 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968991; cv=none; b=O5u5P8G2uzFIN+42hkbMuFDJOjUAcsWHhqXTLG335mOVdny1GuDwAGCqzYTthvi71Ix8KgXgIxJIVkVB6/FwCJffK/5vLI9D0IzeD9mwX+K3wyVtjSYFQcqjwC4DbH/Ee4pS1QpFuvKntU0UYYdXQUq7e7qcvqU+oJSMtPPgcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968991; c=relaxed/simple;
	bh=hPsR6NvixrvO9Cwc4g1iRATSOPB3I0OmCh+OE2ykko0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld9Pz8aVvpkZDgMCIkSi+6lllFNyuG1C5ZsdbP9O3VnPaZYSeVeub9ivjwPEKagYZnkKpRvldMPA/ZDOCth/yEogi4CRMxHocEj9maj/M0ugpvClXmqpJRCZQ2oxvaNV0JWHudB73XnNFYhLDaKb89l+OgsExPfI6FliNq3Y5kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbHemJ2k; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738968989; x=1770504989;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hPsR6NvixrvO9Cwc4g1iRATSOPB3I0OmCh+OE2ykko0=;
  b=QbHemJ2kVd4wGB9NOQfCCjxszT+ZXtogBKhOFmm3qYi1CMYaMh7u/6h9
   KdH3tJ6dt71fs5QrTgX6td1BrYDRqeIZp6609gdAd+DKI5NoxrqbW3bs1
   Nb+ba95XN67q1sfV5rOlU9NEOtz+UkXJWYOtBI77iCazDtLxz7VCpLxAC
   cUbjd+/yMOPtsWZ97hZQLd8RtytBJaiLm3hANqi8kl0efVX52nlbtNv19
   FWgflHYA8irN1beC+naQk+3ACCtXVo5hHZPDJ9PjeopKrrhNhVBq7dPUI
   V7LCg+mOxNZS74n8bakNUhKyvm920bvygcElRg7Yl8T9MsodhyfXdldf9
   Q==;
X-CSE-ConnectionGUID: Mntdl6jlQjChq+6+Sd2cFQ==
X-CSE-MsgGUID: gxDjwMy3TLqwVb11zE4rUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38855845"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38855845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:29 -0800
X-CSE-ConnectionGUID: Y0PcGw4xSRScAGai+uKc4Q==
X-CSE-MsgGUID: TF7AlOtqQeOtmhjpuTQP0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111422018"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:27 -0800
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
Subject: [PATCH v6 5/6] platform/x86:intel/pmc: Move arch specific action to init function
Date: Fri,  7 Feb 2025 14:56:11 -0800
Message-ID: <20250207225615.401235-6-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207225615.401235-1-xi.pardee@linux.intel.com>
References: <20250207225615.401235-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move arch specific action from core.c to the init() function of spt.c.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 13 -------------
 drivers/platform/x86/intel/pmc/spt.c  | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 628cb22221fbc..06821c41fbeb9 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1416,11 +1416,6 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
 
-static const struct pci_device_id pmc_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID) },
-	{ }
-};
-
 /*
  * This quirk can be used on those platforms where
  * the platform BIOS enforces 24Mhz crystal to shutdown
@@ -1531,14 +1526,6 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!pmcdev->pkgc_res_cnt)
 		return -ENOMEM;
 
-	/*
-	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
-	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
-	 * in this case.
-	 */
-	if (pmc_dev_info == &spt_pmc_dev && !pci_dev_present(pmc_pci_ids))
-		pmc_dev_info = &cnp_pmc_dev;
-
 	mutex_init(&pmcdev->lock);
 
 	if (pmc_dev_info->init)
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index 956b2ec1c7510..9289cd76b0145 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -8,6 +8,8 @@
  *
  */
 
+#include <linux/pci.h>
+
 #include "core.h"
 
 const struct pmc_bit_map spt_pll_map[] = {
@@ -134,6 +136,25 @@ const struct pmc_reg_map spt_reg_map = {
 	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
 
+static const struct pci_device_id pmc_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID) },
+	{ }
+};
+
+static int spt_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+{
+	/*
+	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
+	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
+	 * in this case.
+	 */
+	if (!pci_dev_present(pmc_pci_ids))
+		return generic_core_init(pmcdev, &cnp_pmc_dev);
+
+	return generic_core_init(pmcdev, pmc_dev_info);
+}
+
 struct pmc_dev_info spt_pmc_dev = {
 	.map = &spt_reg_map,
+	.init = spt_core_init,
 };
-- 
2.43.0


