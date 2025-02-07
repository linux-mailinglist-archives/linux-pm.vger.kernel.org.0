Return-Path: <linux-pm+bounces-21575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF3CA2D11F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 23:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D0B7A654B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 22:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CEF1DF269;
	Fri,  7 Feb 2025 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLS3csVY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727B1D5CFA;
	Fri,  7 Feb 2025 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968992; cv=none; b=dBbxdsKRH7N57eotDUyIlZUmLP+1W7kNi+URMQUW+DJZPV1m90ti+yLzn0Ms4VBg4+mzstMMc6gRXt7pwT0XEATaCwx/jmAVUAzCm12BW1gn8/RWJBCHkPcJLQjHOKfxjiEOFCyn3WsjTHJmkjqkYCKfISpsXlrrSSW/reOscEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968992; c=relaxed/simple;
	bh=RkvEGYhbSe1gp4o7hhEdKFJndjMTQnqtE5Y33SBVvEE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQnm1jCq6noXtDmXVS6IQwe/divJb7DQ9AOaX7uBn7xmJRtsvsFYcoX2FIDFOZvZ3oq21sD+Zm4BUC9SWncq58qwTi3BVbFyj1hUQ8+124E9IE+w6i18NFJUeCGTwHyaxWgJp9sRNGiotfm9c2lmyNVoS5VrKcAcXDeUi+TYBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLS3csVY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738968991; x=1770504991;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RkvEGYhbSe1gp4o7hhEdKFJndjMTQnqtE5Y33SBVvEE=;
  b=iLS3csVYE3OhaDZ3E7J/tFw2zS6WhvOTwsK041P/FucHKxcM/TWn3Rb/
   k1W/s8DmpwffCXUL7epRCXn0hoFNjkuaFCNUUwj26nWveArVAIv/YuHBA
   v+PLT4S4ehUgbjgVx26elJkQ9frteSVS7Epu59LM3eT4lLR11UW6zGXRT
   iixilkfIh1pOV38c4lLnLNTKyNd6fjddNE126RU1QkNgAr0HieIUNvNXT
   JG4vGvFnmmX9jhDNftdMFaJK0U5DffvzIDc8jv0xhL7soFlL/B7NNWxEG
   0S3CGKD2c5PwENWqAWxyFlDloYQT4fmd+u6iJaS4uHoI6X4zxCP18A6r8
   A==;
X-CSE-ConnectionGUID: 9jIVl0kaTIitxg7R80o4cQ==
X-CSE-MsgGUID: m5WVgyfDQsydDalqDIdHvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38855859"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38855859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:31 -0800
X-CSE-ConnectionGUID: au7s15nNSPC8M++5q0aWlw==
X-CSE-MsgGUID: ps6TkpumSYGTmFF1LGFAQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111422031"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:56:29 -0800
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
Subject: [PATCH v6 6/6] platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core driver
Date: Fri,  7 Feb 2025 14:56:12 -0800
Message-ID: <20250207225615.401235-7-xi.pardee@linux.intel.com>
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

Add Arrow Lake U and Arrow Lake H support in intel_pmc_core driver.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 37 +++++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.c |  2 ++
 drivers/platform/x86/intel/pmc/core.h |  1 +
 3 files changed, 40 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index f57da4e01f6f9..54b0e8e56de92 100644
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
@@ -691,12 +705,25 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return cnl_resume(pmcdev);
 }
 
+static int arl_h_resume(struct pmc_dev *pmcdev)
+{
+	arl_h_d3_fixup();
+
+	return cnl_resume(pmcdev);
+}
+
 static int arl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
 {
 	arl_d3_fixup();
 	return generic_core_init(pmcdev, pmc_dev_info);
 }
 
+static int arl_h_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+{
+	arl_h_d3_fixup();
+	return generic_core_init(pmcdev, pmc_dev_info);
+}
+
 struct pmc_dev_info arl_pmc_dev = {
 	.pci_func = 0,
 	.dmu_guid = ARL_PMT_DMU_GUID,
@@ -706,3 +733,13 @@ struct pmc_dev_info arl_pmc_dev = {
 	.resume = arl_resume,
 	.init = arl_core_init,
 };
+
+struct pmc_dev_info arl_h_pmc_dev = {
+	.pci_func = 2,
+	.dmu_guid = ARL_PMT_DMU_GUID,
+	.regmap_list = arl_pmc_info_list,
+	.map = &mtl_socm_reg_map,
+	.suspend = cnl_suspend,
+	.resume = arl_h_resume,
+	.init = arl_h_core_init,
+};
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 06821c41fbeb9..bd90d38e62e94 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1410,6 +1410,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_pmc_dev),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_pmc_dev),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&arl_pmc_dev),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&arl_h_pmc_dev),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&arl_h_pmc_dev),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_pmc_dev),
 	{}
 };
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index b004b784bfeb2..987fde3ffc1ce 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -624,6 +624,7 @@ extern struct pmc_dev_info tgl_pmc_dev;
 extern struct pmc_dev_info adl_pmc_dev;
 extern struct pmc_dev_info mtl_pmc_dev;
 extern struct pmc_dev_info arl_pmc_dev;
+extern struct pmc_dev_info arl_h_pmc_dev;
 extern struct pmc_dev_info lnl_pmc_dev;
 
 void cnl_suspend(struct pmc_dev *pmcdev);
-- 
2.43.0


