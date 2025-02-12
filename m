Return-Path: <linux-pm+bounces-21920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9566A31AED
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 02:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7848916852B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6BD29A1;
	Wed, 12 Feb 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfcBKe/C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827D271811;
	Wed, 12 Feb 2025 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739322386; cv=none; b=D15xJ+C4ydskHVB7T2k1woTEyPoe9TUPkAPDaRRBqRpKy0YMJL9fO7fFLRkDndQt5jK8IqbORMVFlIg2ZFpulzUpTG0FbpC5bN6p6M3Y7jXE/bR1Y2dUts+g3O0S+VcRrMSPgkcLrlQXFUmGTsZpzgeuu3zTLQDPHgHSVvtf7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739322386; c=relaxed/simple;
	bh=lPLtbO08wzB1FZuAkE1t6UltO8e/hBN62YEOAPcWXpY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h+DJtsjFyERBEuN//nTvvwuoBKG87WwQbHmXWd6MJcQ8+1/B9jVzwJOEzjMpO6k+vtNv+lS/TdMuJV+ViqHYRsguulCoLunL7sOiDurrLE3nQuKagCETvy2CfzR+BXC75seL6x3/8jnLp4AWn+aQTkoREh1Oxx8R4W9qfUAA14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfcBKe/C; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739322385; x=1770858385;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lPLtbO08wzB1FZuAkE1t6UltO8e/hBN62YEOAPcWXpY=;
  b=hfcBKe/CY3cHrs3D0kE37KsvP/Fp9eUVxyxVoLnUu0A3dBGbSXDVQdyF
   PNpL262CU399KzWLGPufIUdv+WS9IRxCWZGdT1H158oX12K6pbIQBRuZi
   s26cdRZgdrjcp6FW2Z+IrEWVZ94JtjZrTwbJL/iLJWsi7VLeJHhWfgb59
   mvOFIipqWmnNmMp5bGFw/zDpceGRiQubdsyqrg9422qpbOwTpp1Gr5gVb
   w32XXAVZO6ipUEt+9gzxId2aPEc3geVSRIx9SpwCKwcMwNoZJjLSMVTNx
   gzfIDFOqGkDkaiT7fPQdhGXmKksexCTOk3sOJiHBrrBifD0q0w459u2Xd
   g==;
X-CSE-ConnectionGUID: 3eBHkES+RaOR9FF0ma1P7w==
X-CSE-MsgGUID: gqSQhn18StSHgKX1HZoazA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50187930"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50187930"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 17:06:24 -0800
X-CSE-ConnectionGUID: j4ShramuSlaO3SHJzaSjsw==
X-CSE-MsgGUID: genqVSeeToGdVVdxvmP+nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149853272"
Received: from iweiny-desk3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.126])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 17:06:23 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] platform/x86:intel/pmc: Move arch specific action to init function
Date: Tue, 11 Feb 2025 17:05:56 -0800
Message-ID: <20250212010621.1003663-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
v2->v1:
- Change the name of pmc_pci_ids to spt_pmc_pci_id

 drivers/platform/x86/intel/pmc/core.c | 13 -------------
 drivers/platform/x86/intel/pmc/spt.c  | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index d819478fea29a..bd90d38e62e94 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1418,11 +1418,6 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
 
-static const struct pci_device_id pmc_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID) },
-	{ }
-};
-
 /*
  * This quirk can be used on those platforms where
  * the platform BIOS enforces 24Mhz crystal to shutdown
@@ -1533,14 +1528,6 @@ static int pmc_core_probe(struct platform_device *pdev)
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
index 956b2ec1c7510..440594acac6cf 100644
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
 
+static const struct pci_device_id spt_pmc_pci_id[] = {
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
+	if (!pci_dev_present(spt_pmc_pci_id))
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


