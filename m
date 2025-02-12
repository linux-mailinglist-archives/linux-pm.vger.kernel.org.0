Return-Path: <linux-pm+bounces-21928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A8A31EF5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 07:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BA164B4A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB51FECB3;
	Wed, 12 Feb 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHzyg60E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0FE1FDE23;
	Wed, 12 Feb 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341939; cv=none; b=AM7ziLfH8Tv6i4+L/9WZ8Mi8gtMLBcU9Tdc0IW5bANrxsfYhtoM+OKXuYSrW2M5tikm58VXtZkc+LPrFNgyAOKNA8Zj2F7u+XL//Lj58ic14XamDZ/BOur6dvvidgheIFtq/NdcmZkvRNxps5QvL6P6Qe8KXiOZ0oRAmNKZRVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341939; c=relaxed/simple;
	bh=5F+lkSQQh8TX1vgm4qYATHq4JgX+LN+xPDQdliDxoGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C74IMv2nHSsaYpfxq7STkc8OHYaweyWh0nbAaVL+H1vcdw5Vh4SLjLBSOGDAqt3VT7oRITfmIjIpr22M+D4bhErW+DNaNdZJzZMv8JLiwzBeVeZFClzhxoWNEEnziw6Trghg38E6oNQZ0zD0MpWf6IrmSDNwC7ZWcvamWYc3avw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHzyg60E; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341937; x=1770877937;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5F+lkSQQh8TX1vgm4qYATHq4JgX+LN+xPDQdliDxoGg=;
  b=eHzyg60E22wNYQpyC9exSifmBLvN8/w7JaoICTbEVM4/tIZyXwAK5RzI
   QZANlcKpeNiQZVriFqnw+BZSPm23WTMbKIdunIulNTtldSHzVxavKzIxt
   SzpWkCcQPs9zef4VllWnr9bqbK7Z6tMIRCC93BXJCVaZ1K8wgVprS7mDB
   G1xKIDt82aIN+Btk64Oy1SGUMkkwcyKALH3UZcsLofGl1HVMwqJxS5sgS
   j6sb8HgoScV35/v1wHnnDwyRhf8njvojVz5i3FLrX040xxgbPdDilmSHl
   czIvJeGO8MfWTaYSHfEOeZ/fp97pgh3RC+Ulioeb+WYbGKql+FENKzgNX
   A==;
X-CSE-ConnectionGUID: 7aJTmGIMTIGm4r5X1HhA2w==
X-CSE-MsgGUID: pMgLwLolRqatetq2/AxzIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005673"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005673"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:32:16 -0800
X-CSE-ConnectionGUID: PZLaMbPdQA267S9vYd5TXw==
X-CSE-MsgGUID: HV7hk2u2T1aZFXuGlsYF8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117354054"
Received: from iweiny-desk3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.222.126])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:32:16 -0800
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
Subject: [PATCH] platform/x86/intel/pmc: Add Panther Lake support to intel_pmc_core
Date: Tue, 11 Feb 2025 22:32:12 -0800
Message-ID: <20250212063213.1232792-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Panther Lake support to intel_pmc_core driver

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile |   2 +-
 drivers/platform/x86/intel/pmc/core.c   |   1 +
 drivers/platform/x86/intel/pmc/core.h   |  32 ++
 drivers/platform/x86/intel/pmc/ptl.c    | 551 ++++++++++++++++++++++++
 4 files changed, 585 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/pmc/ptl.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 389e5419dadf2..b148b40d09f54 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -4,7 +4,7 @@
 #
 
 intel_pmc_core-y			:= core.o core_ssram.o spt.o cnp.o \
-					   icl.o tgl.o adl.o mtl.o arl.o lnl.o
+					   icl.o tgl.o adl.o mtl.o arl.o lnl.o ptl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index bd90d38e62e94..9c759bbc78941 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1413,6 +1413,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&arl_h_pmc_dev),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&arl_h_pmc_dev),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_pmc_dev),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_pmc_dev),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 987fde3ffc1ce..d30442ae1d7f0 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -285,6 +285,14 @@ enum ppfear_regs {
 #define LNL_PPFEAR_NUM_ENTRIES			12
 #define LNL_S0IX_BLOCKER_OFFSET			0x2004
 
+/* Panther Lake Power Management Controller register offsets */
+#define PTL_LPM_NUM_MAPS			14
+#define PTL_PMC_LTR_SATA2			0x1B90
+#define PTL_PMC_LTR_PMC				0x1BA8
+#define PTL_PMC_LTR_CUR_ASLT			0x1C28
+#define PTL_PMC_LTR_CUR_PLT			0x1C2C
+#define PTL_PCD_PMC_MMIO_REG_LEN		0x31A8
+
 extern const char *pmc_lpm_modes[];
 
 struct pmc_bit_map {
@@ -602,6 +610,29 @@ extern const struct pmc_bit_map arl_pchs_signal_status_map[];
 extern const struct pmc_bit_map *arl_pchs_lpm_maps[];
 extern const struct pmc_reg_map arl_pchs_reg_map;
 
+/* PTL */
+extern const struct pmc_bit_map ptl_pcdp_pfear_map[];
+extern const struct pmc_bit_map *ext_ptl_pcdp_pfear_map[];
+extern const struct pmc_bit_map ptl_pcdp_ltr_show_map[];
+extern const struct pmc_bit_map ptl_pcdp_clocksource_status_map[];
+extern const struct pmc_bit_map ptl_pcdp_power_gating_status_0_map[];
+extern const struct pmc_bit_map ptl_pcdp_power_gating_status_1_map[];
+extern const struct pmc_bit_map ptl_pcdp_power_gating_status_2_map[];
+extern const struct pmc_bit_map ptl_pcdp_d3_status_0_map[];
+extern const struct pmc_bit_map ptl_pcdp_d3_status_1_map[];
+extern const struct pmc_bit_map ptl_pcdp_d3_status_2_map[];
+extern const struct pmc_bit_map ptl_pcdp_d3_status_3_map[];
+extern const struct pmc_bit_map ptl_pcdp_vnn_req_status_0_map[];
+extern const struct pmc_bit_map ptl_pcdp_vnn_req_status_1_map[];
+extern const struct pmc_bit_map ptl_pcdp_vnn_req_status_2_map[];
+extern const struct pmc_bit_map ptl_pcdp_vnn_req_status_3_map[];
+extern const struct pmc_bit_map ptl_pcdp_vnn_misc_status_map[];
+extern const struct pmc_bit_map ptl_pcdp_signal_status_map[];
+extern const struct pmc_bit_map ptl_pcdp_rsc_status_map[];
+extern const struct pmc_bit_map *ptl_pcdp_lpm_maps[];
+extern const struct pmc_bit_map *ptl_pcdp_blk_maps[];
+extern const struct pmc_reg_map ptl_pcdp_reg_map;
+
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
 int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value, int ignore);
@@ -626,6 +657,7 @@ extern struct pmc_dev_info mtl_pmc_dev;
 extern struct pmc_dev_info arl_pmc_dev;
 extern struct pmc_dev_info arl_h_pmc_dev;
 extern struct pmc_dev_info lnl_pmc_dev;
+extern struct pmc_dev_info ptl_pmc_dev;
 
 void cnl_suspend(struct pmc_dev *pmcdev);
 int cnl_resume(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/ptl.c b/drivers/platform/x86/intel/pmc/ptl.c
new file mode 100644
index 0000000000000..c9380ce7de2a7
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/ptl.c
@@ -0,0 +1,551 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains platform specific structure definitions
+ * and init function used by Panther Lake PCH.
+ *
+ * Copyright (c) 2025, Intel Corporation.
+ *
+ */
+
+#include <linux/pci.h>
+
+#include "core.h"
+
+const struct pmc_bit_map ptl_pcdp_pfear_map[] = {
+	{"PMC_0",               BIT(0)},
+	{"FUSE_OSSE",           BIT(1)},
+	{"ESPISPI",             BIT(2)},
+	{"XHCI",                BIT(3)},
+	{"SPA",                 BIT(4)},
+	{"SPB",                 BIT(5)},
+	{"MPFPW2",              BIT(6)},
+	{"GBE",                 BIT(7)},
+
+	{"SBR16B20",            BIT(0)},
+	{"SBR8B20",             BIT(1)},
+	{"SBR16B21",            BIT(2)},
+	{"DBG_SBR16B",          BIT(3)},
+	{"OSSE_HOTHAM",         BIT(4)},
+	{"D2D_DISP_1",          BIT(5)},
+	{"LPSS",                BIT(6)},
+	{"LPC",                 BIT(7)},
+
+	{"SMB",                 BIT(0)},
+	{"ISH",                 BIT(1)},
+	{"SBR16B2",             BIT(2)},
+	{"NPK_0",		BIT(3)},
+	{"D2D_NOC_1",           BIT(4)},
+	{"SBR8B2",              BIT(5)},
+	{"FUSE",                BIT(6)},
+	{"SBR16B0",             BIT(7)},
+
+	{"PSF0",		BIT(0)},
+	{"XDCI",                BIT(1)},
+	{"EXI",                 BIT(2)},
+	{"CSE",                 BIT(3)},
+	{"KVMCC",		BIT(4)},
+	{"PMT",			BIT(5)},
+	{"CLINK",		BIT(6)},
+	{"PTIO",		BIT(7)},
+
+	{"USBR0",		BIT(0)},
+	{"SUSRAM",		BIT(1)},
+	{"SMT1",		BIT(2)},
+	{"MPFPW1",              BIT(3)},
+	{"SMS2",		BIT(4)},
+	{"SMS1",		BIT(5)},
+	{"CSMERTC",		BIT(6)},
+	{"CSMEPSF",		BIT(7)},
+
+	{"D2D_NOC_0",           BIT(0)},
+	{"ESE",			BIT(1)},
+	{"P2SB8B",              BIT(2)},
+	{"SBR16B7",             BIT(3)},
+	{"SBR16B3",             BIT(4)},
+	{"OSSE_SMT1",           BIT(5)},
+	{"D2D_DISP",            BIT(6)},
+	{"DBG_SBR",             BIT(7)},
+
+	{"U3FPW1",              BIT(0)},
+	{"FIA_X",               BIT(1)},
+	{"PSF4",                BIT(2)},
+	{"CNVI",                BIT(3)},
+	{"UFSX2",               BIT(4)},
+	{"ENDBG",               BIT(5)},
+	{"DBC",                 BIT(6)},
+	{"FIA_PG",              BIT(7)},
+
+	{"D2D_IPU",             BIT(0)},
+	{"NPK1",		BIT(1)},
+	{"FIACPCB_X",           BIT(2)},
+	{"SBR8B4",              BIT(3)},
+	{"DBG_PSF",             BIT(4)},
+	{"PSF6",                BIT(5)},
+	{"UFSPW1",              BIT(6)},
+	{"FIA_U",		BIT(7)},
+
+	{"PSF8",                BIT(0)},
+	{"SBR16B4",             BIT(1)},
+	{"SBR16B5",             BIT(2)},
+	{"FIACPCB_U",           BIT(3)},
+	{"TAM",			BIT(4)},
+	{"D2D_NOC_2",           BIT(5)},
+	{"TBTLSX",              BIT(6)},
+	{"THC0",		BIT(7)},
+
+	{"THC1",                BIT(0)},
+	{"PMC_1",		BIT(1)},
+	{"SBR8B1",              BIT(2)},
+	{"TCSS",                BIT(3)},
+	{"DISP_PGA",            BIT(4)},
+	{"SBR16B1",             BIT(5)},
+	{"SBRG",		BIT(6)},
+	{"PSF5",		BIT(7)},
+
+	{"P2SB16B",             BIT(0)},
+	{"ACE_0",		BIT(1)},
+	{"ACE_1",               BIT(2)},
+	{"ACE_2",               BIT(3)},
+	{"ACE_3",               BIT(4)},
+	{"ACE_4",               BIT(5)},
+	{"ACE_5",		BIT(6)},
+	{"ACE_6",		BIT(7)},
+
+	{"ACE_7",		BIT(0)},
+	{"ACE_8",		BIT(1)},
+	{"ACE_9",		BIT(2)},
+	{"ACE_10",		BIT(3)},
+	{"FIACPCB_PG",		BIT(4)},
+	{"SBR16B6",		BIT(5)},
+	{"OSSE",		BIT(6)},
+	{"SBR8B0",              BIT(7)},
+	{}
+};
+
+const struct pmc_bit_map *ext_ptl_pcdp_pfear_map[] = {
+	ptl_pcdp_pfear_map,
+	NULL
+};
+
+const struct pmc_bit_map ptl_pcdp_ltr_show_map[] = {
+	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
+	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
+	{"SATA",		CNP_PMC_LTR_SATA},
+	{"GIGABIT_ETHERNET",	CNP_PMC_LTR_GBE},
+	{"XHCI",		CNP_PMC_LTR_XHCI},
+	{"SOUTHPORT_F",		ADL_PMC_LTR_SPF},
+	{"ME",			CNP_PMC_LTR_ME},
+	{"SATA1",		CNP_PMC_LTR_EVA},
+	{"SOUTHPORT_C",		CNP_PMC_LTR_SPC},
+	{"HD_AUDIO",		CNP_PMC_LTR_AZ},
+	{"CNV",			CNP_PMC_LTR_CNV},
+	{"LPSS",		CNP_PMC_LTR_LPSS},
+	{"SOUTHPORT_D",		CNP_PMC_LTR_SPD},
+	{"SOUTHPORT_E",		CNP_PMC_LTR_SPE},
+	{"SATA2",		PTL_PMC_LTR_SATA2},
+	{"ESPI",		CNP_PMC_LTR_ESPI},
+	{"SCC",			CNP_PMC_LTR_SCC},
+	{"ISH",			CNP_PMC_LTR_ISH},
+	{"UFSX2",		CNP_PMC_LTR_UFSX2},
+	{"EMMC",		CNP_PMC_LTR_EMMC},
+	{"WIGIG",		ICL_PMC_LTR_WIGIG},
+	{"THC0",		TGL_PMC_LTR_THC0},
+	{"THC1",		TGL_PMC_LTR_THC1},
+	{"SOUTHPORT_G",		MTL_PMC_LTR_SPG},
+	{"ESE",			MTL_PMC_LTR_ESE},
+	{"IOE_PMC",		MTL_PMC_LTR_IOE_PMC},
+	{"DMI3",		ARL_PMC_LTR_DMI3},
+	{"OSSE",		LNL_PMC_LTR_OSSE},
+
+	/* Below two cannot be used for LTR_IGNORE */
+	{"CURRENT_PLATFORM",	PTL_PMC_LTR_CUR_PLT},
+	{"AGGREGATED_SYSTEM",	PTL_PMC_LTR_CUR_ASLT},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_clocksource_status_map[] = {
+	{"AON2_OFF_STS",                 BIT(0),	1},
+	{"AON3_OFF_STS",                 BIT(1),	0},
+	{"AON4_OFF_STS",                 BIT(2),	1},
+	{"AON5_OFF_STS",                 BIT(3),	1},
+	{"AON1_OFF_STS",                 BIT(4),	0},
+	{"XTAL_LVM_OFF_STS",             BIT(5),	0},
+	{"MPFPW1_0_PLL_OFF_STS",         BIT(6),	1},
+	{"USB3_PLL_OFF_STS",             BIT(8),	1},
+	{"AON3_SPL_OFF_STS",             BIT(9),	1},
+	{"MPFPW2_0_PLL_OFF_STS",         BIT(12),	1},
+	{"XTAL_AGGR_OFF_STS",            BIT(17),	1},
+	{"USB2_PLL_OFF_STS",             BIT(18),	0},
+	{"SAF_PLL_OFF_STS",		 BIT(19),	1},
+	{"SE_TCSS_PLL_OFF_STS",		 BIT(20),	1},
+	{"DDI_PLL_OFF_STS",		 BIT(21),	1},
+	{"FILTER_PLL_OFF_STS",           BIT(22),	1},
+	{"ACE_PLL_OFF_STS",              BIT(24),	0},
+	{"FABRIC_PLL_OFF_STS",           BIT(25),	1},
+	{"SOC_PLL_OFF_STS",              BIT(26),	1},
+	{"REF_PLL_OFF_STS",              BIT(28),	1},
+	{"IMG_PLL_OFF_STS",              BIT(29),	1},
+	{"RTC_PLL_OFF_STS",              BIT(31),	0},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_power_gating_status_0_map[] = {
+	{"PMC_PGD0_PG_STS",              BIT(0),	0},
+	{"FUSE_OSSE_PGD0_PG_STS",	 BIT(1),	0},
+	{"ESPISPI_PGD0_PG_STS",          BIT(2),	0},
+	{"XHCI_PGD0_PG_STS",             BIT(3),	1},
+	{"SPA_PGD0_PG_STS",              BIT(4),	1},
+	{"SPB_PGD0_PG_STS",              BIT(5),	1},
+	{"MPFPW2_PGD0_PG_STS",           BIT(6),	0},
+	{"GBE_PGD0_PG_STS",              BIT(7),	1},
+	{"SBR16B20_PGD0_PG_STS",         BIT(8),	0},
+	{"SBR8B20_PGD0_PG_STS",          BIT(9),	0},
+	{"SBR16B21_PGD0_PG_STS",         BIT(10),	0},
+	{"DBG_PGD0_PG_STS",		 BIT(11),	0},
+	{"OSSE_HOTHAM_PGD0_PG_STS",      BIT(12),	1},
+	{"D2D_DISP_PGD1_PG_STS",         BIT(13),	1},
+	{"LPSS_PGD0_PG_STS",             BIT(14),	1},
+	{"LPC_PGD0_PG_STS",              BIT(15),	0},
+	{"SMB_PGD0_PG_STS",              BIT(16),	0},
+	{"ISH_PGD0_PG_STS",              BIT(17),	0},
+	{"SBR16B2_PGD0_PG_STS",		 BIT(18),	0},
+	{"NPK_PGD0_PG_STS",              BIT(19),	0},
+	{"D2D_NOC_PGD1_PG_STS",		 BIT(20),	1},
+	{"SBR8B2_PGD0_PG_STS",           BIT(21),	0},
+	{"FUSE_PGD0_PG_STS",             BIT(22),	0},
+	{"SBR16B0_PGD0_PG_STS",		 BIT(23),	0},
+	{"PSF0_PGD0_PG_STS",		 BIT(24),	0},
+	{"XDCI_PGD0_PG_STS",             BIT(25),	1},
+	{"EXI_PGD0_PG_STS",              BIT(26),	0},
+	{"CSE_PGD0_PG_STS",              BIT(27),	1},
+	{"KVMCC_PGD0_PG_STS",            BIT(28),	1},
+	{"PMT_PGD0_PG_STS",              BIT(29),	1},
+	{"CLINK_PGD0_PG_STS",            BIT(30),	1},
+	{"PTIO_PGD0_PG_STS",             BIT(31),	1},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_power_gating_status_1_map[] = {
+	{"USBR0_PGD0_PG_STS",            BIT(0),	1},
+	{"SUSRAM_PGD0_PG_STS",           BIT(1),	1},
+	{"SMT1_PGD0_PG_STS",             BIT(2),	1},
+	{"MPFPW1_PGD0_PG_STS",           BIT(3),	0},
+	{"SMS2_PGD0_PG_STS",             BIT(4),	1},
+	{"SMS1_PGD0_PG_STS",             BIT(5),	1},
+	{"CSMERTC_PGD0_PG_STS",          BIT(6),	0},
+	{"CSMEPSF_PGD0_PG_STS",          BIT(7),	0},
+	{"D2D_NOC_PGD0_PG_STS",          BIT(8),	0},
+	{"ESE_PGD0_PG_STS",		 BIT(9),	1},
+	{"P2SB8B_PGD0_PG_STS",           BIT(10),	1},
+	{"SBR16B7_PGD0_PG_STS",          BIT(11),	0},
+	{"SBR16B3_PGD0_PG_STS",          BIT(12),	0},
+	{"OSSE_SMT1_PGD0_PG_STS",        BIT(13),	1},
+	{"D2D_DISP_PGD0_PG_STS",         BIT(14),	1},
+	{"DBG_SBR_PGD0_PG_STS",          BIT(15),	0},
+	{"U3FPW1_PGD0_PG_STS",           BIT(16),	0},
+	{"FIA_X_PGD0_PG_STS",            BIT(17),	0},
+	{"PSF4_PGD0_PG_STS",             BIT(18),	0},
+	{"CNVI_PGD0_PG_STS",             BIT(19),	0},
+	{"UFSX2_PGD0_PG_STS",            BIT(20),	1},
+	{"ENDBG_PGD0_PG_STS",            BIT(21),	0},
+	{"DBC_PGD0_PG_STS",		 BIT(22),	0},
+	{"FIA_PG_PGD0_PG_STS",           BIT(23),	0},
+	{"D2D_IPU_PGD0_PG_STS",          BIT(24),	1},
+	{"NPK_PGD1_PG_STS",              BIT(25),	0},
+	{"FIACPCB_X_PGD0_PG_STS",	 BIT(26),	0},
+	{"SBR8B4_PGD0_PG_STS",           BIT(27),	0},
+	{"DBG_PSF_PGD0_PG_STS",          BIT(28),	0},
+	{"PSF6_PGD0_PG_STS",             BIT(29),	0},
+	{"UFSPW1_PGD0_PG_STS",           BIT(30),	0},
+	{"FIA_U_PGD0_PG_STS",            BIT(31),	0},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_power_gating_status_2_map[] = {
+	{"PSF8_PGD0_PG_STS",             BIT(0),	0},
+	{"SBR16B4_PGD0_PG_STS",          BIT(1),	0},
+	{"SBR16B5_PGD0_PG_STS",          BIT(2),	0},
+	{"FIACPCB_U_PGD0_PG_STS",        BIT(3),	0},
+	{"TAM_PGD0_PG_STS",              BIT(4),	1},
+	{"D2D_NOC_PGD0_PG_STS",          BIT(5),	1},
+	{"TBTLSX_PGD0_PG_STS",           BIT(6),	1},
+	{"THC0_PGD0_PG_STS",             BIT(7),	1},
+	{"THC1_PGD0_PG_STS",             BIT(8),	1},
+	{"PMC_PGD1_PG_STS",              BIT(9),	0},
+	{"SBR8B1_PGD0_PG_STS",           BIT(10),	0},
+	{"TCSS_PGD0_PG_STS",             BIT(11),	0},
+	{"DISP_PGA_PGD0_PG_STS",         BIT(12),	0},
+	{"SBR16B1_PGD0_PG_STS",          BIT(13),	0},
+	{"SBRG_PGD0_PG_STS",		 BIT(14),	0},
+	{"PSF5_PGD0_PG_STS",             BIT(15),	0},
+	{"P2SB16B_PGD0_PG_STS",          BIT(16),	1},
+	{"ACE_PGD0_PG_STS",              BIT(17),	0},
+	{"ACE_PGD1_PG_STS",              BIT(18),	0},
+	{"ACE_PGD2_PG_STS",              BIT(19),	0},
+	{"ACE_PGD3_PG_STS",              BIT(20),	0},
+	{"ACE_PGD4_PG_STS",              BIT(21),	0},
+	{"ACE_PGD5_PG_STS",              BIT(22),	0},
+	{"ACE_PGD6_PG_STS",              BIT(23),	0},
+	{"ACE_PGD7_PG_STS",              BIT(24),	0},
+	{"ACE_PGD8_PG_STS",              BIT(25),	0},
+	{"ACE_PGD9_PG_STS",              BIT(26),	0},
+	{"ACE_PGD10_PG_STS",             BIT(27),	0},
+	{"FIACPCB_PG_PGD0_PG_STS",       BIT(28),	0},
+	{"SBR16B6_PGD0_PG_STS",          BIT(29),	0},
+	{"OSSE_PGD0_PG_STS",		 BIT(30),	1},
+	{"SBR8B0_PGD0_PG_STS",           BIT(31),	0},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_d3_status_0_map[] = {
+	{"LPSS_D3_STS",                  BIT(3),	1},
+	{"XDCI_D3_STS",                  BIT(4),	1},
+	{"XHCI_D3_STS",                  BIT(5),	1},
+	{"OSSE_D3_STS",                  BIT(6),	0},
+	{"SPA_D3_STS",                   BIT(12),	0},
+	{"SPB_D3_STS",                   BIT(13),	0},
+	{"ESPISPI_D3_STS",               BIT(18),	0},
+	{"PSTH_D3_STS",                  BIT(21),	0},
+	{"OSSE_SMT1_D3_STS",             BIT(30),	0},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_d3_status_1_map[] = {
+	{"GBE_D3_STS",                   BIT(19),	0},
+	{"ITSS_D3_STS",                  BIT(23),	0},
+	{"CNVI_D3_STS",                  BIT(27),	0},
+	{"UFSX2_D3_STS",                 BIT(28),	1},
+	{"OSSE_HOTHAM_D3_STS",           BIT(29),	0},
+	{"ESE_D3_STS",                   BIT(30),	0},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_d3_status_2_map[] = {
+	{"CSMERTC_D3_STS",               BIT(1),	0},
+	{"SUSRAM_D3_STS",                BIT(2),	0},
+	{"CSE_D3_STS",                   BIT(4),	0},
+	{"KVMCC_D3_STS",                 BIT(5),	0},
+	{"USBR0_D3_STS",                 BIT(6),	0},
+	{"ISH_D3_STS",                   BIT(7),	0},
+	{"SMT1_D3_STS",                  BIT(8),	0},
+	{"SMT2_D3_STS",                  BIT(9),	0},
+	{"SMT3_D3_STS",                  BIT(10),	0},
+	{"OSSE_SMT2_D3_STS",             BIT(12),	0},
+	{"CLINK_D3_STS",                 BIT(14),	0},
+	{"PTIO_D3_STS",                  BIT(16),	0},
+	{"PMT_D3_STS",                   BIT(17),	0},
+	{"SMS1_D3_STS",                  BIT(18),	0},
+	{"SMS2_D3_STS",                  BIT(19),	0},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_d3_status_3_map[] = {
+	{"THC0_D3_STS",                  BIT(14),	1},
+	{"THC1_D3_STS",                  BIT(15),	1},
+	{"OSSE_SMT3_D3_STS",             BIT(18),	0},
+	{"ACE_D3_STS",                   BIT(23),	0},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_vnn_req_status_0_map[] = {
+	{"LPSS_VNN_REQ_STS",             BIT(3),	1},
+	{"OSSE_VNN_REQ_STS",             BIT(6),	1},
+	{"ESPISPI_VNN_REQ_STS",          BIT(18),	1},
+	{"OSSE_SMT1_VNN_REQ_STS",        BIT(30),	1},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_vnn_req_status_1_map[] = {
+	{"NPK_VNN_REQ_STS",              BIT(4),	1},
+	{"DFXAGG_VNN_REQ_STS",           BIT(8),	0},
+	{"EXI_VNN_REQ_STS",              BIT(9),	1},
+	{"P2D_VNN_REQ_STS",              BIT(18),	1},
+	{"GBE_VNN_REQ_STS",              BIT(19),	1},
+	{"SMB_VNN_REQ_STS",              BIT(25),	1},
+	{"LPC_VNN_REQ_STS",              BIT(26),	0},
+	{"ESE_VNN_REQ_STS",              BIT(30),	1},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_vnn_req_status_2_map[] = {
+	{"CSMERTC_VNN_REQ_STS",          BIT(1),	1},
+	{"CSE_VNN_REQ_STS",              BIT(4),	1},
+	{"ISH_VNN_REQ_STS",              BIT(7),	1},
+	{"SMT1_VNN_REQ_STS",             BIT(8),	1},
+	{"CLINK_VNN_REQ_STS",            BIT(14),	1},
+	{"SMS1_VNN_REQ_STS",             BIT(18),	1},
+	{"SMS2_VNN_REQ_STS",             BIT(19),	1},
+	{"GPIOCOM4_VNN_REQ_STS",         BIT(20),	1},
+	{"GPIOCOM3_VNN_REQ_STS",         BIT(21),	1},
+	{"GPIOCOM1_VNN_REQ_STS",         BIT(23),	1},
+	{"GPIOCOM0_VNN_REQ_STS",         BIT(24),	1},
+	{"DISP_SHIM_VNN_REQ_STS",        BIT(26),	1},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_vnn_req_status_3_map[] = {
+	{"DTS0_VNN_REQ_STS",             BIT(7),	0},
+	{"GPIOCOM5_VNN_REQ_STS",         BIT(11),	1},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_vnn_misc_status_map[] = {
+	{"CPU_C10_REQ_STS",              BIT(0),	0},
+	{"TS_OFF_REQ_STS",               BIT(1),	0},
+	{"PNDE_MET_REQ_STS",             BIT(2),	1},
+	{"PG5_PMA0_REQ_STS",		 BIT(3),	0},
+	{"FW_THROTTLE_ALLOWED_REQ_STS",  BIT(4),	0},
+	{"VNN_SOC_REQ_STS",              BIT(6),	1},
+	{"ISH_VNNAON_REQ_STS",           BIT(7),	0},
+	{"D2D_NOC_CFI_QACTIVE_REQ_STS",	 BIT(8),	1},
+	{"D2D_NOC_GPSB_QACTIVE_REQ_STS", BIT(9),	1},
+	{"D2D_IPU_QACTIVE_REQ_STS",	 BIT(10),	1},
+	{"PLT_GREATER_REQ_STS",          BIT(11),	1},
+	{"ALL_SBR_IDLE_REQ_STS",         BIT(12),	0},
+	{"PMC_IDLE_FB_OCP_REQ_STS",      BIT(13),	0},
+	{"PM_SYNC_STATES_REQ_STS",       BIT(14),	0},
+	{"EA_REQ_STS",                   BIT(15),	0},
+	{"MPHY_CORE_OFF_REQ_STS",        BIT(16),	0},
+	{"BRK_EV_EN_REQ_STS",            BIT(17),	0},
+	{"AUTO_DEMO_EN_REQ_STS",         BIT(18),	0},
+	{"ITSS_CLK_SRC_REQ_STS",         BIT(19),	1},
+	{"ARC_IDLE_REQ_STS",             BIT(21),	0},
+	{"PG5_PMA1_REQ_STS",		 BIT(22),	0},
+	{"FIA_DEEP_PM_REQ_STS",          BIT(23),	0},
+	{"XDCI_ATTACHED_REQ_STS",        BIT(24),	1},
+	{"ARC_INTERRUPT_WAKE_REQ_STS",   BIT(25),	0},
+	{"D2D_DISP_DDI_QACTIVE_REQ_STS", BIT(26),	1},
+	{"PRE_WAKE0_REQ_STS",            BIT(27),	1},
+	{"PRE_WAKE1_REQ_STS",            BIT(28),	1},
+	{"PRE_WAKE2_REQ_STS",		 BIT(29),	1},
+	{"D2D_DISP_EDP_QACTIVE_REQ_STS", BIT(31),	1},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_signal_status_map[] = {
+	{"LSX_Wake0_STS",		 BIT(0),	0},
+	{"LSX_Wake1_STS",		 BIT(1),	0},
+	{"LSX_Wake2_STS",		 BIT(2),	0},
+	{"LSX_Wake3_STS",		 BIT(3),	0},
+	{"LSX_Wake4_STS",		 BIT(4),	0},
+	{"LSX_Wake5_STS",		 BIT(5),	0},
+	{"LSX_Wake6_STS",		 BIT(6),	0},
+	{"LSX_Wake7_STS",		 BIT(7),	0},
+	{"LPSS_Wake0_STS",		 BIT(8),	1},
+	{"LPSS_Wake1_STS",		 BIT(9),	1},
+	{"Int_Timer_SS_Wake0_STS",	 BIT(10),	1},
+	{"Int_Timer_SS_Wake1_STS",	 BIT(11),	1},
+	{"Int_Timer_SS_Wake2_STS",	 BIT(12),	1},
+	{"Int_Timer_SS_Wake3_STS",	 BIT(13),	1},
+	{"Int_Timer_SS_Wake4_STS",	 BIT(14),	1},
+	{"Int_Timer_SS_Wake5_STS",	 BIT(15),	1},
+	{}
+};
+
+const struct pmc_bit_map ptl_pcdp_rsc_status_map[] = {
+	{"Memory",		0,		1},
+	{"PSF0",		0,		1},
+	{"PSF4",		0,		1},
+	{"PSF5",		0,		1},
+	{"PSF6",		0,		1},
+	{"PSF8",		0,		1},
+	{"SAF_CFI_LINK",	0,		1},
+	{"SB",			0,		1},
+	{}
+};
+
+const struct pmc_bit_map *ptl_pcdp_lpm_maps[] = {
+	ptl_pcdp_clocksource_status_map,
+	ptl_pcdp_power_gating_status_0_map,
+	ptl_pcdp_power_gating_status_1_map,
+	ptl_pcdp_power_gating_status_2_map,
+	ptl_pcdp_d3_status_0_map,
+	ptl_pcdp_d3_status_1_map,
+	ptl_pcdp_d3_status_2_map,
+	ptl_pcdp_d3_status_3_map,
+	ptl_pcdp_vnn_req_status_0_map,
+	ptl_pcdp_vnn_req_status_1_map,
+	ptl_pcdp_vnn_req_status_2_map,
+	ptl_pcdp_vnn_req_status_3_map,
+	ptl_pcdp_vnn_misc_status_map,
+	ptl_pcdp_signal_status_map,
+	NULL
+};
+
+const struct pmc_bit_map *ptl_pcdp_blk_maps[] = {
+	ptl_pcdp_power_gating_status_0_map,
+	ptl_pcdp_power_gating_status_1_map,
+	ptl_pcdp_power_gating_status_2_map,
+	ptl_pcdp_rsc_status_map,
+	ptl_pcdp_vnn_req_status_0_map,
+	ptl_pcdp_vnn_req_status_1_map,
+	ptl_pcdp_vnn_req_status_2_map,
+	ptl_pcdp_vnn_req_status_3_map,
+	ptl_pcdp_d3_status_0_map,
+	ptl_pcdp_d3_status_1_map,
+	ptl_pcdp_d3_status_2_map,
+	ptl_pcdp_d3_status_3_map,
+	ptl_pcdp_clocksource_status_map,
+	ptl_pcdp_vnn_misc_status_map,
+	ptl_pcdp_signal_status_map,
+	NULL
+};
+
+const struct pmc_reg_map ptl_pcdp_reg_map = {
+	.pfear_sts = ext_ptl_pcdp_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
+	.ltr_show_sts = ptl_pcdp_ltr_show_map,
+	.msr_sts = msr_map,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = PTL_PCD_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = LNL_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.lpm_num_maps = PTL_LPM_NUM_MAPS,
+	.ltr_ignore_max = LNL_NUM_IP_IGN_ALLOWED,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.etr3_offset = ETR3_OFFSET,
+	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
+	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
+	.lpm_en_offset = MTL_LPM_EN_OFFSET,
+	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
+	.lpm_sts = ptl_pcdp_lpm_maps,
+	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
+	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
+	.s0ix_blocker_maps = ptl_pcdp_blk_maps,
+	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
+};
+
+#define PTL_NPU_PCI_DEV                0xb03e
+#define PTL_IPU_PCI_DEV                0xb05d
+
+/*
+ * Set power state of select devices that do not have drivers to D3
+ * so that they do not block Package C entry.
+ */
+static void ptl_d3_fixup(void)
+{
+	pmc_core_set_device_d3(PTL_IPU_PCI_DEV);
+	pmc_core_set_device_d3(PTL_NPU_PCI_DEV);
+}
+
+static int ptl_resume(struct pmc_dev *pmcdev)
+{
+	ptl_d3_fixup();
+	return cnl_resume(pmcdev);
+}
+
+static int ptl_core_init(struct pmc_dev *pmcdev, struct pmc_dev_info *pmc_dev_info)
+{
+	ptl_d3_fixup();
+	return generic_core_init(pmcdev, pmc_dev_info);
+}
+
+struct pmc_dev_info ptl_pmc_dev = {
+	.map = &ptl_pcdp_reg_map,
+	.suspend = cnl_suspend,
+	.resume = ptl_resume,
+	.init = ptl_core_init,
+};
-- 
2.43.0


