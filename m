Return-Path: <linux-pm+bounces-19552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E99F88BE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 00:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60182189645F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9D1F755E;
	Thu, 19 Dec 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoLD6E41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97A1EE7CF;
	Thu, 19 Dec 2024 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734652550; cv=none; b=oKyCdYmNcPKg7Ct4GBNApucijjM7cL2hDEaTPun+UWREcWKuB5eaGMdRqFT8wmICIMVzIjL7pdIDdGMOi4NDZxs9uu61pNi9cqA/QOB1YJwrNcyGLfF7uOd3nnhzDRIm7ZWnuCTPeKiNvYXktQuqFHN7zQYGx+RCruv9oy0C3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734652550; c=relaxed/simple;
	bh=XOS/Lo8PRO5FYOmv2qknmwmm/BzyirfDvLWN/RNtc3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpfGmML43icfIAXrS/6ykrntCwsFCMo1RqeKGbPKcWhCrc2GK9IagK3/Au8zLDaGVE5dwODUHafJoWQtznXLJV5rcXFs5gC0bpm1guIn4EAs2rqOEsHj+pEFn8DtKW1Ni8f2J98milmdCn1irKWLiWOkeRW3FGTkAiI4PSDuqKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoLD6E41; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734652549; x=1766188549;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=XOS/Lo8PRO5FYOmv2qknmwmm/BzyirfDvLWN/RNtc3g=;
  b=FoLD6E41Wum8geCgwaRRSi3evZYxi/hQBWELEWLn0N54sp0AwC7PPuZZ
   sOaQLHEosfZ/YtTBQoLADKcuLJnI1QbfbAEu9q/yN65RJdaiUgbCWeXPo
   hQO6AYjjda4E2Q62hhua7uoAbMdw4kOOwKgAoLVg1FGGOFHryENzbskzB
   n3+UcPLTOTzEbqayTZ3jtrmqzv1qfwW7iT03RKqwdrKykEkV24Q5Hg9E0
   /wvpASj1ctR/cQTXNJvX7hOtdJY4XB9JX1P60cIRkPdYbLorGrobwO2lj
   +CJNVPXRMl8ZLGBjSd0n4DuyFc/A4WZ53QYwnGZdVVljI7g8pzzxeBRNI
   Q==;
X-CSE-ConnectionGUID: sOHFhpGcTGurSnxSQth/qQ==
X-CSE-MsgGUID: 89N+wi1hTxi6brzkEYurHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="38975822"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="38975822"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:48 -0800
X-CSE-ConnectionGUID: wEpQQx7eQIqIk60sVuaJUg==
X-CSE-MsgGUID: xp/n6BBvS+iu34CBUx6OiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="98745834"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.167])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 15:55:47 -0800
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
Subject: [PATCH v3 3/3] platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core driver
Date: Thu, 19 Dec 2024 15:55:40 -0800
Message-ID: <20241219235543.236592-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241219235543.236592-1-xi.pardee@linux.intel.com>
References: <20241219235543.236592-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Arrow Lake U and Arrow Lake H support in intel_pmc_core driver.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 36 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.c |  2 ++
 drivers/platform/x86/intel/pmc/core.h |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 137a1fdfee715..05c45e37f2449 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -16,6 +16,7 @@
 #define IOEP_LPM_REQ_GUID	0x5077612
 #define SOCS_LPM_REQ_GUID	0x8478657
 #define PCHS_LPM_REQ_GUID	0x9684572
+#define SOCM_LPM_REQ_GUID	0x2625030
 
 static const u8 ARL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
 
@@ -650,6 +651,7 @@ const struct pmc_reg_map arl_pchs_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
+#define PMC_DEVID_SOCM 0x777f
 #define PMC_DEVID_SOCS 0xae7f
 #define PMC_DEVID_IOEP 0x7ecf
 #define PMC_DEVID_PCHS 0x7f27
@@ -669,11 +671,17 @@ static struct pmc_info arl_pmc_info_list[] = {
 		.devid	= PMC_DEVID_PCHS,
 		.map	= &arl_pchs_reg_map,
 	},
+	{
+		.guid	= SOCM_LPM_REQ_GUID,
+		.devid	= PMC_DEVID_SOCM,
+		.map	= &mtl_socm_reg_map,
+	},
 	{}
 };
 
 #define ARL_NPU_PCI_DEV			0xad1d
 #define ARL_GNA_PCI_DEV			0xae4c
+#define ARL_H_GNA_PCI_DEV		0x774c
 /*
  * Set power state of select devices that do not have drivers to D3
  * so that they do not block Package C entry.
@@ -684,6 +692,12 @@ static void arl_d3_fixup(void)
 	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
 }
 
+static void arl_h_d3_fixup(void)
+{
+	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
+	pmc_core_set_device_d3(ARL_H_GNA_PCI_DEV);
+}
+
 static int arl_resume(struct pmc_dev *pmcdev)
 {
 	arl_d3_fixup();
@@ -691,6 +705,13 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static int arl_h_resume(struct pmc_dev *pmcdev)
+{
+	arl_h_d3_fixup();
+
+	return cnl_resume(pmcdev);
+}
+
 static struct pmc_dev_info arl_pmc_dev = {
 	.func = 0,
 	.ssram = true,
@@ -702,8 +723,23 @@ static struct pmc_dev_info arl_pmc_dev = {
 	.resume = arl_resume,
 };
 
+static struct pmc_dev_info arl_h_pmc_dev = {
+	.func = 2,
+	.ssram = true,
+	.dmu_guid = ARL_PMT_DMU_GUID,
+	.regmap_list = arl_pmc_info_list,
+	.map = &mtl_socm_reg_map,
+	.fixup = arl_h_d3_fixup,
+	.suspend = cnl_suspend,
+	.resume = arl_h_resume,
+};
+
 int arl_core_init(struct pmc_dev *pmcdev)
 {
 	return generic_core_init(pmcdev, &arl_pmc_dev);
 }
 
+int arl_h_core_init(struct pmc_dev *pmcdev)
+{
+	return generic_core_init(pmcdev, &arl_h_pmc_dev);
+}
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 8b73101dcfe95..8890dda174b6e 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1412,6 +1412,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	arl_h_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	arl_h_core_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
 	{}
 };
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 82be953db9463..e4c0b9477262f 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -625,6 +625,7 @@ int tgl_l_core_init(struct pmc_dev *pmcdev);
 int adl_core_init(struct pmc_dev *pmcdev);
 int mtl_core_init(struct pmc_dev *pmcdev);
 int arl_core_init(struct pmc_dev *pmcdev);
+int arl_h_core_init(struct pmc_dev *pmcdev);
 int lnl_core_init(struct pmc_dev *pmcdev);
 
 void cnl_suspend(struct pmc_dev *pmcdev);
-- 
2.43.0


