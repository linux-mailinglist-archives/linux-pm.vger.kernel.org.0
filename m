Return-Path: <linux-pm+bounces-20172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E9A083F6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271013A97FC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 00:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF951E2312;
	Fri, 10 Jan 2025 00:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYSfzs8P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1C1422AB;
	Fri, 10 Jan 2025 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736468784; cv=none; b=El/TUOnnxvRWweDhjVqHZmVuhwy0z+jObllzGBampkCGTFbX4P6p5nV39iJdja8V+Z/wpHc1buKnwD07qtBrGVyKYWJOy5d0uoURVqmp0Wmd758ZKdb374WXa2EwQJK1lRUC5K3J1Z/Kiu+Ckpn8ZjbW8KfD9Ga3ALcWdEZ9S0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736468784; c=relaxed/simple;
	bh=+UrA7eQ6e6KKtHkbyrE8p4uR7yTBKFbSTJgH3mDO27U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAwEQ4EIUIvCk/B7gUYuewu4MR3/G/p3teA9QoYZAhkftFJheWJk6q8LHKVXX7ci1oBxISM9/WUIrgzTBQzvY3nImNr4Ocf9jB7rK5tU/ZaP+lNFFz9IrPUvB57eZoTO1Rovxy7oSxKUZ9Mewmr5vwmenTcVuL/xYHSI6FXJg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYSfzs8P; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736468783; x=1768004783;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+UrA7eQ6e6KKtHkbyrE8p4uR7yTBKFbSTJgH3mDO27U=;
  b=AYSfzs8PxGdvp0onJXnewdb7W/8wvvMNaFuxQUA5TCD63jAZkDPnD/AR
   mOtoeSJTClOIjytwZHC+1/16QKvTww89FthEe2u/v3p3HzWjB6Pi76nMF
   1TTw6rFlWY2II0EyaBkwPa3mrSSSiRwWqqgYk0p2uSPzRHyf5LHVah5hT
   yOA6vSNGR27qFX53O9v4wEyKsTOuykp94JI3JMo/7IbqU/fcwg5wi6xFv
   Ao5rp6p/lsr7zF+5sOXVQPSK9q4KjpvS63u+zMbQhR9oxjdckz/irvsb2
   7/j2/J73PFBQVejRh3JJ340mBAhuAjHlJke/uiclZh7DPROEgzbeXCqth
   w==;
X-CSE-ConnectionGUID: 7zzYRzbbTmOZ3ge7U5JHtA==
X-CSE-MsgGUID: 6O7gMyP7QVWenF7hclFIeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36653500"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36653500"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:21 -0800
X-CSE-ConnectionGUID: 3QEb/32ORoi8pD/G5aI5vw==
X-CSE-MsgGUID: Fzxk4UjZSJu8Yn89P8SQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104097036"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.100])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 16:26:20 -0800
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
Subject: [PATCH v4 6/6] platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core driver
Date: Thu,  9 Jan 2025 16:26:08 -0800
Message-ID: <20250110002612.244782-7-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110002612.244782-1-xi.pardee@linux.intel.com>
References: <20250110002612.244782-1-xi.pardee@linux.intel.com>
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
 drivers/platform/x86/intel/pmc/core.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index a55381640c23b..49b35aaa09d4b 100644
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
 struct pmc_dev_info arl_pmc_dev = {
 	.func = 0,
 	.dmu_guid = ARL_PMT_DMU_GUID,
@@ -701,7 +722,23 @@ struct pmc_dev_info arl_pmc_dev = {
 	.arch_specific = arl_specific_init,
 };
 
+struct pmc_dev_info arl_h_pmc_dev = {
+	.func = 2,
+	.dmu_guid = ARL_PMT_DMU_GUID,
+	.regmap_list = arl_pmc_info_list,
+	.map = &mtl_socm_reg_map,
+	.suspend = cnl_suspend,
+	.resume = arl_h_resume,
+	.arch_specific = arl_h_specific_init,
+};
+
 void arl_specific_init(struct pmc_dev *pmcdev)
 {
 	arl_d3_fixup();
 }
+
+void arl_h_specific_init(struct pmc_dev *pmcdev)
+{
+	arl_h_d3_fixup();
+}
+
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index d2ce52366b1c4..ce4308dccc773 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1412,6 +1412,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&adl_pmc_dev),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&mtl_pmc_dev),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&arl_pmc_dev),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&arl_h_pmc_dev),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&arl_h_pmc_dev),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_pmc_dev),
 	{}
 };
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 771f06b193c66..78a4f429d3c1c 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -624,9 +624,11 @@ extern struct pmc_dev_info tgl_pmc_dev;
 extern struct pmc_dev_info adl_pmc_dev;
 extern struct pmc_dev_info mtl_pmc_dev;
 extern struct pmc_dev_info arl_pmc_dev;
+extern struct pmc_dev_info arl_h_pmc_dev;
 extern struct pmc_dev_info lnl_pmc_dev;
 
 void arl_specific_init(struct pmc_dev *pmcdev);
+void arl_h_specific_init(struct pmc_dev *pmcdev);
 void mtl_specific_init(struct pmc_dev *pmcdev);
 void lnl_specific_init(struct pmc_dev *pmcdev);
 void tgl_specific_init(struct pmc_dev *pmcdev);
-- 
2.43.0


