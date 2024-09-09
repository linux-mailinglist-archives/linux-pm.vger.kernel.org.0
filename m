Return-Path: <linux-pm+bounces-13914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E739725BC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 01:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58948B22F8F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 23:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC6E18DF69;
	Mon,  9 Sep 2024 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ico9HHff"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB912130495;
	Mon,  9 Sep 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725924529; cv=none; b=GPEJ0wSXFrB0joePxrXJ/3591zq/nmGYQOjYguELEUSVHVQMmjUgumS8jJ/rpi3/EPwPCNtrZsGWI5z09j5C9x9EGkgU6vBe9rMMaInjaQfROoONWL02PRD+uEHq1tZQ097podNu5pVpxmZVYYy09GMqXccii6ZUYwqMJwY7EKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725924529; c=relaxed/simple;
	bh=f0VHQU73xeHnXfPxJX4dESj3StMiXQPugv1d/lnGwEo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qgn9+BIuRXDOH9FJd7YpNoAvmUNzwNfCfMfhCyyAACalYQc+MapQTj7PyKHGYDccdwYs4YrOJr1MGcn5nZ6hUvmLAD3w7pRd3TuyPO3RAkVeOmsEUw3J5wNE3firMop1gnIeH4A5aPKi9mBwAQMnKz08rOp4THfIhL97vLPYzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ico9HHff; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725924527; x=1757460527;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f0VHQU73xeHnXfPxJX4dESj3StMiXQPugv1d/lnGwEo=;
  b=ico9HHffL3DfOOWED60IEKvFM4Y+49e6gnWr8so8U6bpd6iB2iK3Z4LG
   WR+3f7lUlN+8kWveBetwiNYoiCIYJqKjwupZ0l5s+HXGCPc8k92vUPJ6B
   ZQfMGvVg8wlMIQHHlfgLym/f124BQKAM/nMP9chUxxK+scDsdq6EdHUQI
   g6C/Qd8YZY96z9B1MpV4XNCdYLAg1YdCc/y/ae4N/vwGLwjNe0TDTxAvz
   IO7zSm2aLHL/tHm/ibpTTUqRKTiuNC7240McyVMkrTzGBEGU6F3pVwGzH
   tounl0og3ZQ1JCzsS3YZz7E0/uCDu6uPoMYd4Ke1JlYMwwOAszzBxBX2M
   Q==;
X-CSE-ConnectionGUID: RuJeMw01T964VANzeM3T7g==
X-CSE-MsgGUID: wzJ/rcBjTg+n+ER2v6iTnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="47164118"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="47164118"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 16:28:47 -0700
X-CSE-ConnectionGUID: S8AM3VkhSQioi7EXuePXiw==
X-CSE-MsgGUID: Uv4BJMqHSUSCALOfIzI84g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="66850786"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.124.223.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 16:28:46 -0700
From: Rajvi Jingar <rajvi.jingar@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core driver
Date: Mon,  9 Sep 2024 16:28:42 -0700
Message-ID: <20240909232842.2896965-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Arrow Lake U and Arro Lake H support in intel_pmc_core driver

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c  | 65 ++++++++++++++++++++++-----
 drivers/platform/x86/intel/pmc/core.c |  2 +
 drivers/platform/x86/intel/pmc/core.h |  7 +++
 3 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index e10527c4e3e0..964f5f040dd9 100644
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
+#define ARL_H_GNA_PCI_DEV 		0x774c
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
@@ -692,16 +706,47 @@ static int arl_resume(struct pmc_dev *pmcdev)
 	return pmc_core_resume_common(pmcdev);
 }
 
+static int arl_h_resume(struct pmc_dev *pmcdev)
+{
+	arl_h_d3_fixup();
+	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
+
+	return pmc_core_resume_common(pmcdev);
+}
+
+int arl_h_core_init(struct pmc_dev *pmcdev)
+{
+	arl_h_d3_fixup();
+
+	return arl_core_generic_init(pmcdev, SOC_M);
+}
+
 int arl_core_init(struct pmc_dev *pmcdev)
 {
-	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
+	arl_d3_fixup();
+
+	return arl_core_generic_init(pmcdev, SOC_S);
+}
+
+int arl_core_generic_init(struct pmc_dev *pmcdev, int soc_tp)
+{
 	int ret;
-	int func = 0;
+	int func;
 	bool ssram_init = true;
+	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_SOC];
 
-	arl_d3_fixup();
 	pmcdev->suspend = cnl_suspend;
-	pmcdev->resume = arl_resume;
+
+	if (soc_tp == SOC_M) {
+		func = 2;
+		pmcdev->resume = arl_h_resume;
+	} else if (soc_tp == SOC_S) {
+		func = 0;
+		pmcdev->resume = arl_resume;
+	} else {
+		return -EINVAL;
+	}
+
 	pmcdev->regmap_list = arl_pmc_info_list;
 
 	/*
@@ -711,7 +756,10 @@ int arl_core_init(struct pmc_dev *pmcdev)
 	ret = pmc_core_ssram_init(pmcdev, func);
 	if (ret) {
 		ssram_init = false;
-		pmc->map = &arl_socs_reg_map;
+		if (soc_tp == SOC_M)
+			pmc->map = &mtl_socm_reg_map;
+		else
+			pmc->map = &arl_socs_reg_map;
 
 		ret = get_primary_reg_base(pmc);
 		if (ret)
@@ -721,11 +769,8 @@ int arl_core_init(struct pmc_dev *pmcdev)
 	pmc_core_get_low_power_modes(pmcdev);
 	pmc_core_punit_pmt_init(pmcdev, ARL_PMT_DMU_GUID);
 
-	if (ssram_init)	{
-		ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
-		if (ret)
-			return ret;
-	}
+	if (ssram_init)
+		return pmc_core_ssram_get_lpm_reqs(pmcdev);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 01ae71c6df59..046791f21619 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1319,6 +1319,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	adl_core_init),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	mtl_core_init),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		arl_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	arl_h_core_init),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	arl_h_core_init),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	lnl_core_init),
 	{}
 };
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ea04de7eb9e8..5771f40185c2 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -365,6 +365,11 @@ struct pmc_info {
 	const struct pmc_reg_map *map;
 };
 
+enum soc_type {
+	SOC_M,
+	SOC_S
+};
+
 /**
  * struct pmc - pmc private info structure
  * @base_addr:		contains pmc base address
@@ -599,6 +604,8 @@ int tgl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
 int adl_core_init(struct pmc_dev *pmcdev);
 int mtl_core_init(struct pmc_dev *pmcdev);
 int arl_core_init(struct pmc_dev *pmcdev);
+int arl_h_core_init(struct pmc_dev *pmcdev);
+int arl_core_generic_init(struct pmc_dev *pmcdev, int pch_tp);
 int lnl_core_init(struct pmc_dev *pmcdev);
 
 void cnl_suspend(struct pmc_dev *pmcdev);
-- 
2.43.0


