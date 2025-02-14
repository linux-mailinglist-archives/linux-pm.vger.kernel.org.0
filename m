Return-Path: <linux-pm+bounces-22117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC6A367B1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 22:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2A33B1AB5
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821E1FC0EB;
	Fri, 14 Feb 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZpIm1E+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73F1D9A79;
	Fri, 14 Feb 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569464; cv=none; b=IdpzVpShW/YK7LRukXqlXvj13DQFZYfEeH5OuMDog30fmb2rCnPRKZVEjoUSke4ACHa1Fu7RXHPmujO1bwDpNSfVR53rEtURWEL9KYiFmMhL/2osK9qGic5WYkjrmcRvUlrvZKtlRwznX/l8n2wlSuZrlX6rY3Nvxvhck+Pm8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569464; c=relaxed/simple;
	bh=sAJUnYiH+ouHkWMbJ6L5fpG5ii1H9ebPNbrFbn6ajwI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bte6NhpwBZB0z4Oud/nAl5/4Q9HyGaoSV77wBEws+y+/i8zqMcJd2Tw82g1IqU//SeMiBYPoqniIuJ34kzRObogbOn/MxnRUXTlvi8Xp7+o3a5WLECWNS2lZw9mMS3EfJ0TmfKubjvBMH6dXmjMVOKyWqCOgThKeRFve1sq921U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZpIm1E+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739569462; x=1771105462;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sAJUnYiH+ouHkWMbJ6L5fpG5ii1H9ebPNbrFbn6ajwI=;
  b=UZpIm1E+JoEGm6uPjrzEQOZbqb6NUghYxNv0jtRhMgzfVO2yUY0YuBCD
   C39aXRJWWxDgcTlpTlA5NKBhEMQ9DsaPkHQgUI+027vLJiXwbGsA77T28
   MPGhMk2uT9ceJDYqJJ+ja5AwK7Jauxl5Ye0PhcM8A1acXYkzItTN132Sy
   v30ihI42m1dw8anAd289BLc7RmtcxtQaauT4whEcBHJb4z0zUsNdQ6JEq
   RWHm3ZVpTn2cmv/cCg5tDFHqhMPDyhFzHXuoTf/Abb5N4WxXCiRhXimtS
   vFgBVSqTwhhLt+g4Pow5FSP7YHLU4bp0LIXKqYXKQnvfciDlD2ycu3/UB
   g==;
X-CSE-ConnectionGUID: 7ookzAZVRU+irj3qcLIlWA==
X-CSE-MsgGUID: 3QFuXwDDTgGJYVNDDQ2+AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40253126"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40253126"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:44:20 -0800
X-CSE-ConnectionGUID: J8aSJ1oKRPuv6oxYiMq8Rg==
X-CSE-MsgGUID: 1uPcjER1S2K3yYAq+/dLdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="113546312"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.223.241])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 13:44:19 -0800
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
Subject: [PATCH v2 2/3] platform/x86/intel/pmc: Remove unnecessary declarations in header
Date: Fri, 14 Feb 2025 13:44:10 -0800
Message-ID: <20250214214416.10150-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214214416.10150-1-xi.pardee@linux.intel.com>
References: <20250214214416.10150-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary declarations in header file. Variable that are
used by only one .c file are removed from header file and changed
to be static in their corresponding .c file.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  |  34 +++----
 drivers/platform/x86/intel/pmc/arl.c  |  58 ++++++------
 drivers/platform/x86/intel/pmc/cnp.c  |   8 +-
 drivers/platform/x86/intel/pmc/core.h | 126 --------------------------
 drivers/platform/x86/intel/pmc/icl.c  |   6 +-
 drivers/platform/x86/intel/pmc/lnl.c  |  42 ++++-----
 drivers/platform/x86/intel/pmc/mtl.c  |  64 ++++++-------
 drivers/platform/x86/intel/pmc/spt.c  |  12 +--
 drivers/platform/x86/intel/pmc/tgl.c  |  20 ++--
 9 files changed, 122 insertions(+), 248 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index de361a316d51d..9e7dfd6e3310a 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -11,7 +11,7 @@
 #include "core.h"
 
 /* Alder Lake: PGD PFET Enable Ack Status Register(s) bitmap */
-const struct pmc_bit_map adl_pfear_map[] = {
+static const struct pmc_bit_map adl_pfear_map[] = {
 	{"SPI/eSPI",		BIT(2)},
 	{"XHCI",		BIT(3)},
 	{"SPA",			BIT(4)},
@@ -54,7 +54,7 @@ const struct pmc_bit_map adl_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_adl_pfear_map[] = {
+static const struct pmc_bit_map *ext_adl_pfear_map[] = {
 	/*
 	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
 	 * a list of core SoCs using this.
@@ -63,7 +63,7 @@ const struct pmc_bit_map *ext_adl_pfear_map[] = {
 	NULL
 };
 
-const struct pmc_bit_map adl_ltr_show_map[] = {
+static const struct pmc_bit_map adl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
 	{"SATA",		CNP_PMC_LTR_SATA},
@@ -100,7 +100,7 @@ const struct pmc_bit_map adl_ltr_show_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_clocksource_status_map[] = {
+static const struct pmc_bit_map adl_clocksource_status_map[] = {
 	{"CLKPART1_OFF_STS",			BIT(0)},
 	{"CLKPART2_OFF_STS",			BIT(1)},
 	{"CLKPART3_OFF_STS",			BIT(2)},
@@ -128,7 +128,7 @@ const struct pmc_bit_map adl_clocksource_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_power_gating_status_0_map[] = {
+static const struct pmc_bit_map adl_power_gating_status_0_map[] = {
 	{"PMC_PGD0_PG_STS",			BIT(0)},
 	{"DMI_PGD0_PG_STS",			BIT(1)},
 	{"ESPISPI_PGD0_PG_STS",			BIT(2)},
@@ -158,7 +158,7 @@ const struct pmc_bit_map adl_power_gating_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_power_gating_status_1_map[] = {
+static const struct pmc_bit_map adl_power_gating_status_1_map[] = {
 	{"USBR0_PGD0_PG_STS",			BIT(0)},
 	{"SMT1_PGD0_PG_STS",			BIT(2)},
 	{"CSMERTC_PGD0_PG_STS",			BIT(6)},
@@ -170,14 +170,14 @@ const struct pmc_bit_map adl_power_gating_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_power_gating_status_2_map[] = {
+static const struct pmc_bit_map adl_power_gating_status_2_map[] = {
 	{"THC0_PGD0_PG_STS",			BIT(7)},
 	{"THC1_PGD0_PG_STS",			BIT(8)},
 	{"SPF_PGD0_PG_STS",			BIT(14)},
 	{}
 };
 
-const struct pmc_bit_map adl_d3_status_0_map[] = {
+static const struct pmc_bit_map adl_d3_status_0_map[] = {
 	{"ISH_D3_STS",				BIT(2)},
 	{"LPSS_D3_STS",				BIT(3)},
 	{"XDCI_D3_STS",				BIT(4)},
@@ -193,13 +193,13 @@ const struct pmc_bit_map adl_d3_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_d3_status_1_map[] = {
+static const struct pmc_bit_map adl_d3_status_1_map[] = {
 	{"GBE_D3_STS",				BIT(19)},
 	{"CNVI_D3_STS",				BIT(27)},
 	{}
 };
 
-const struct pmc_bit_map adl_d3_status_2_map[] = {
+static const struct pmc_bit_map adl_d3_status_2_map[] = {
 	{"CSMERTC_D3_STS",			BIT(1)},
 	{"CSE_D3_STS",				BIT(4)},
 	{"KVMCC_D3_STS",			BIT(5)},
@@ -210,20 +210,20 @@ const struct pmc_bit_map adl_d3_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_d3_status_3_map[] = {
+static const struct pmc_bit_map adl_d3_status_3_map[] = {
 	{"THC0_D3_STS",				BIT(14)},
 	{"THC1_D3_STS",				BIT(15)},
 	{}
 };
 
-const struct pmc_bit_map adl_vnn_req_status_0_map[] = {
+static const struct pmc_bit_map adl_vnn_req_status_0_map[] = {
 	{"ISH_VNN_REQ_STS",			BIT(2)},
 	{"ESPISPI_VNN_REQ_STS",			BIT(18)},
 	{"DSP_VNN_REQ_STS",			BIT(19)},
 	{}
 };
 
-const struct pmc_bit_map adl_vnn_req_status_1_map[] = {
+static const struct pmc_bit_map adl_vnn_req_status_1_map[] = {
 	{"NPK_VNN_REQ_STS",			BIT(4)},
 	{"EXI_VNN_REQ_STS",			BIT(9)},
 	{"GBE_VNN_REQ_STS",			BIT(19)},
@@ -232,7 +232,7 @@ const struct pmc_bit_map adl_vnn_req_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_vnn_req_status_2_map[] = {
+static const struct pmc_bit_map adl_vnn_req_status_2_map[] = {
 	{"CSMERTC_VNN_REQ_STS",			BIT(1)},
 	{"CSE_VNN_REQ_STS",			BIT(4)},
 	{"SMT1_VNN_REQ_STS",			BIT(8)},
@@ -245,12 +245,12 @@ const struct pmc_bit_map adl_vnn_req_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map adl_vnn_req_status_3_map[] = {
+static const struct pmc_bit_map adl_vnn_req_status_3_map[] = {
 	{"GPIOCOM5_VNN_REQ_STS",		BIT(11)},
 	{}
 };
 
-const struct pmc_bit_map adl_vnn_misc_status_map[] = {
+static const struct pmc_bit_map adl_vnn_misc_status_map[] = {
 	{"CPU_C10_REQ_STS",			BIT(0)},
 	{"PCIe_LPM_En_REQ_STS",			BIT(3)},
 	{"ITH_REQ_STS",				BIT(5)},
@@ -265,7 +265,7 @@ const struct pmc_bit_map adl_vnn_misc_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *adl_lpm_maps[] = {
+static const struct pmc_bit_map *adl_lpm_maps[] = {
 	adl_clocksource_status_map,
 	adl_power_gating_status_0_map,
 	adl_power_gating_status_1_map,
diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 54b0e8e56de92..320993bd6d31d 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -20,7 +20,7 @@
 
 static const u8 ARL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
 
-const struct pmc_bit_map arl_socs_ltr_show_map[] = {
+static const struct pmc_bit_map arl_socs_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
 	{"SATA",		CNP_PMC_LTR_SATA},
@@ -60,7 +60,7 @@ const struct pmc_bit_map arl_socs_ltr_show_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_socs_clocksource_status_map[] = {
+static const struct pmc_bit_map arl_socs_clocksource_status_map[] = {
 	{"AON2_OFF_STS",		BIT(0)},
 	{"AON3_OFF_STS",		BIT(1)},
 	{"AON4_OFF_STS",		BIT(2)},
@@ -88,7 +88,7 @@ const struct pmc_bit_map arl_socs_clocksource_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_socs_power_gating_status_0_map[] = {
+static const struct pmc_bit_map arl_socs_power_gating_status_0_map[] = {
 	{"PMC_PGD0_PG_STS",		BIT(0)},
 	{"DMI_PGD0_PG_STS",		BIT(1)},
 	{"ESPISPI_PGD0_PG_STS",		BIT(2)},
@@ -124,7 +124,7 @@ const struct pmc_bit_map arl_socs_power_gating_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_socs_power_gating_status_1_map[] = {
+static const struct pmc_bit_map arl_socs_power_gating_status_1_map[] = {
 	{"USBR0_PGD0_PG_STS",		BIT(0)},
 	{"SUSRAM_PGD0_PG_STS",		BIT(1)},
 	{"SMT1_PGD0_PG_STS",		BIT(2)},
@@ -160,7 +160,7 @@ const struct pmc_bit_map arl_socs_power_gating_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_socs_power_gating_status_2_map[] = {
+static const struct pmc_bit_map arl_socs_power_gating_status_2_map[] = {
 	{"PSF8_PGD0_PG_STS",		BIT(0)},
 	{"FIA_PGD0_PG_STS",		BIT(1)},
 	{"SOC_D2D_PGD3_PG_STS",		BIT(2)},
@@ -188,7 +188,7 @@ const struct pmc_bit_map arl_socs_power_gating_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_socs_d3_status_2_map[] = {
+static const struct pmc_bit_map arl_socs_d3_status_2_map[] = {
 	{"CSMERTC_D3_STS",		BIT(1)},
 	{"SUSRAM_D3_STS",		BIT(2)},
 	{"CSE_D3_STS",			BIT(4)},
@@ -207,7 +207,7 @@ const struct pmc_bit_map arl_socs_d3_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_socs_d3_status_3_map[] = {
+static const struct pmc_bit_map arl_socs_d3_status_3_map[] = {
 	{"GBETSN_D3_STS",		BIT(13)},
 	{"THC0_D3_STS",			BIT(14)},
 	{"THC1_D3_STS",			BIT(15)},
@@ -215,13 +215,13 @@ const struct pmc_bit_map arl_socs_d3_status_3_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_socs_vnn_req_status_3_map[] = {
+static const struct pmc_bit_map arl_socs_vnn_req_status_3_map[] = {
 	{"DTS0_VNN_REQ_STS",		BIT(7)},
 	{"GPIOCOM5_VNN_REQ_STS",	BIT(11)},
 	{}
 };
 
-const struct pmc_bit_map *arl_socs_lpm_maps[] = {
+static const struct pmc_bit_map *arl_socs_lpm_maps[] = {
 	arl_socs_clocksource_status_map,
 	arl_socs_power_gating_status_0_map,
 	arl_socs_power_gating_status_1_map,
@@ -239,7 +239,7 @@ const struct pmc_bit_map *arl_socs_lpm_maps[] = {
 	NULL
 };
 
-const struct pmc_bit_map arl_socs_pfear_map[] = {
+static const struct pmc_bit_map arl_socs_pfear_map[] = {
 	{"RSVD64",			BIT(0)},
 	{"RSVD65",			BIT(1)},
 	{"RSVD66",			BIT(2)},
@@ -250,13 +250,13 @@ const struct pmc_bit_map arl_socs_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_arl_socs_pfear_map[] = {
+static const struct pmc_bit_map *ext_arl_socs_pfear_map[] = {
 	mtl_socm_pfear_map,
 	arl_socs_pfear_map,
 	NULL
 };
 
-const struct pmc_reg_map arl_socs_reg_map = {
+static const struct pmc_reg_map arl_socs_reg_map = {
 	.pfear_sts = ext_arl_socs_pfear_map,
 	.ppfear_buckets = ARL_SOCS_PPFEAR_NUM_ENTRIES,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
@@ -284,7 +284,7 @@ const struct pmc_reg_map arl_socs_reg_map = {
 	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
 };
 
-const struct pmc_bit_map arl_pchs_ltr_show_map[] = {
+static const struct pmc_bit_map arl_pchs_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
 	{"SATA",		CNP_PMC_LTR_SATA},
@@ -324,7 +324,7 @@ const struct pmc_bit_map arl_pchs_ltr_show_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_clocksource_status_map[] = {
+static const struct pmc_bit_map arl_pchs_clocksource_status_map[] = {
 	{"AON2_OFF_STS",		BIT(0)},
 	{"AON3_OFF_STS",		BIT(1)},
 	{"AON4_OFF_STS",		BIT(2)},
@@ -359,7 +359,7 @@ const struct pmc_bit_map arl_pchs_clocksource_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_power_gating_status_0_map[] = {
+static const struct pmc_bit_map arl_pchs_power_gating_status_0_map[] = {
 	{"PMC_PGD0_PG_STS",		BIT(0)},
 	{"DMI_PGD0_PG_STS",		BIT(1)},
 	{"ESPISPI_PGD0_PG_STS",		BIT(2)},
@@ -395,7 +395,7 @@ const struct pmc_bit_map arl_pchs_power_gating_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_power_gating_status_1_map[] = {
+static const struct pmc_bit_map arl_pchs_power_gating_status_1_map[] = {
 	{"USBR0_PGD0_PG_STS",		BIT(0)},
 	{"SUSRAM_PGD0_PG_STS",		BIT(1)},
 	{"SMT1_PGD0_PG_STS",		BIT(2)},
@@ -431,7 +431,7 @@ const struct pmc_bit_map arl_pchs_power_gating_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_power_gating_status_2_map[] = {
+static const struct pmc_bit_map arl_pchs_power_gating_status_2_map[] = {
 	{"U3FPW2_PGD0_PG_STS",		BIT(0)},
 	{"FIA_PGD0_PG_STS",		BIT(1)},
 	{"FIACPCB_X_PGD0_PG_STS",	BIT(2)},
@@ -458,7 +458,7 @@ const struct pmc_bit_map arl_pchs_power_gating_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_d3_status_0_map[] = {
+static const struct pmc_bit_map arl_pchs_d3_status_0_map[] = {
 	{"SPF_D3_STS",			BIT(0)},
 	{"LPSS_D3_STS",			BIT(3)},
 	{"XDCI_D3_STS",			BIT(4)},
@@ -475,7 +475,7 @@ const struct pmc_bit_map arl_pchs_d3_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_d3_status_1_map[] = {
+static const struct pmc_bit_map arl_pchs_d3_status_1_map[] = {
 	{"GBETSN1_D3_STS",		BIT(14)},
 	{"GBE_D3_STS",			BIT(19)},
 	{"ITSS_D3_STS",			BIT(23)},
@@ -484,7 +484,7 @@ const struct pmc_bit_map arl_pchs_d3_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_d3_status_2_map[] = {
+static const struct pmc_bit_map arl_pchs_d3_status_2_map[] = {
 	{"CSMERTC_D3_STS",		BIT(1)},
 	{"SUSRAM_D3_STS",		BIT(2)},
 	{"CSE_D3_STS",			BIT(4)},
@@ -505,7 +505,7 @@ const struct pmc_bit_map arl_pchs_d3_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_d3_status_3_map[] = {
+static const struct pmc_bit_map arl_pchs_d3_status_3_map[] = {
 	{"ESE_D3_STS",			BIT(3)},
 	{"GBETSN_D3_STS",		BIT(13)},
 	{"THC0_D3_STS",			BIT(14)},
@@ -514,13 +514,13 @@ const struct pmc_bit_map arl_pchs_d3_status_3_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_vnn_req_status_0_map[] = {
+static const struct pmc_bit_map arl_pchs_vnn_req_status_0_map[] = {
 	{"FIA_VNN_REQ_STS",		BIT(17)},
 	{"ESPISPI_VNN_REQ_STS",		BIT(18)},
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_vnn_req_status_1_map[] = {
+static const struct pmc_bit_map arl_pchs_vnn_req_status_1_map[] = {
 	{"NPK_VNN_REQ_STS",		BIT(4)},
 	{"DFXAGG_VNN_REQ_STS",		BIT(8)},
 	{"EXI_VNN_REQ_STS",		BIT(9)},
@@ -531,7 +531,7 @@ const struct pmc_bit_map arl_pchs_vnn_req_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_vnn_req_status_2_map[] = {
+static const struct pmc_bit_map arl_pchs_vnn_req_status_2_map[] = {
 	{"FIA2_VNN_REQ_STS",		BIT(0)},
 	{"CSMERTC_VNN_REQ_STS",		BIT(1)},
 	{"CSE_VNN_REQ_STS",		BIT(4)},
@@ -549,7 +549,7 @@ const struct pmc_bit_map arl_pchs_vnn_req_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_vnn_req_status_3_map[] = {
+static const struct pmc_bit_map arl_pchs_vnn_req_status_3_map[] = {
 	{"ESE_VNN_REQ_STS",		BIT(3)},
 	{"DTS0_VNN_REQ_STS",		BIT(7)},
 	{"GPIOCOM5_VNN_REQ_STS",	BIT(11)},
@@ -557,7 +557,7 @@ const struct pmc_bit_map arl_pchs_vnn_req_status_3_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_vnn_misc_status_map[] = {
+static const struct pmc_bit_map arl_pchs_vnn_misc_status_map[] = {
 	{"CPU_C10_REQ_STS",			BIT(0)},
 	{"TS_OFF_REQ_STS",			BIT(1)},
 	{"PNDE_MET_REQ_STS",			BIT(2)},
@@ -587,7 +587,7 @@ const struct pmc_bit_map arl_pchs_vnn_misc_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map arl_pchs_signal_status_map[] = {
+static const struct pmc_bit_map arl_pchs_signal_status_map[] = {
 	{"LSX_Wake0_STS",		BIT(0)},
 	{"LSX_Wake1_STS",		BIT(1)},
 	{"LSX_Wake2_STS",		BIT(2)},
@@ -607,7 +607,7 @@ const struct pmc_bit_map arl_pchs_signal_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *arl_pchs_lpm_maps[] = {
+static const struct pmc_bit_map *arl_pchs_lpm_maps[] = {
 	arl_pchs_clocksource_status_map,
 	arl_pchs_power_gating_status_0_map,
 	arl_pchs_power_gating_status_1_map,
@@ -625,7 +625,7 @@ const struct pmc_bit_map *arl_pchs_lpm_maps[] = {
 	NULL
 };
 
-const struct pmc_reg_map arl_pchs_reg_map = {
+static const struct pmc_reg_map arl_pchs_reg_map = {
 	.pfear_sts = ext_arl_socs_pfear_map,
 	.ppfear_buckets = ARL_SOCS_PPFEAR_NUM_ENTRIES,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index f147ec51c7fd0..2c5af158bbe2e 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -88,7 +88,7 @@ const struct pmc_bit_map cnp_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_cnp_pfear_map[] = {
+static const struct pmc_bit_map *ext_cnp_pfear_map[] = {
 	/*
 	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
 	 * a list of core SoCs using this.
@@ -97,7 +97,7 @@ const struct pmc_bit_map *ext_cnp_pfear_map[] = {
 	NULL
 };
 
-const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
+static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
 	{"AUDIO_D3",		BIT(0)},
 	{"OTG_D3",		BIT(1)},
 	{"XHCI_D3",		BIT(2)},
@@ -110,7 +110,7 @@ const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
+static const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
 	{"SDIO_PLL_OFF",	BIT(0)},
 	{"USB2_PLL_OFF",	BIT(1)},
 	{"AUDIO_PLL_OFF",	BIT(2)},
@@ -127,7 +127,7 @@ const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map cnp_slps0_dbg2_map[] = {
+static const struct pmc_bit_map cnp_slps0_dbg2_map[] = {
 	{"MPHY_CORE_GATED",	BIT(0)},
 	{"CSME_GATED",		BIT(1)},
 	{"USB2_SUS_GATED",	BIT(2)},
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index eb9450b3b69e6..21c247beee50d 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -467,148 +467,22 @@ struct pmc_dev_info {
 };
 
 extern const struct pmc_bit_map msr_map[];
-extern const struct pmc_bit_map spt_pll_map[];
-extern const struct pmc_bit_map spt_mphy_map[];
-extern const struct pmc_bit_map spt_pfear_map[];
-extern const struct pmc_bit_map *ext_spt_pfear_map[];
-extern const struct pmc_bit_map spt_ltr_show_map[];
-extern const struct pmc_reg_map spt_reg_map;
 extern const struct pmc_bit_map cnp_pfear_map[];
-extern const struct pmc_bit_map *ext_cnp_pfear_map[];
-extern const struct pmc_bit_map cnp_slps0_dbg0_map[];
-extern const struct pmc_bit_map cnp_slps0_dbg1_map[];
-extern const struct pmc_bit_map cnp_slps0_dbg2_map[];
 extern const struct pmc_bit_map *cnp_slps0_dbg_maps[];
 extern const struct pmc_bit_map cnp_ltr_show_map[];
 extern const struct pmc_reg_map cnp_reg_map;
-extern const struct pmc_bit_map icl_pfear_map[];
-extern const struct pmc_bit_map *ext_icl_pfear_map[];
-extern const struct pmc_reg_map icl_reg_map;
-extern const struct pmc_bit_map tgl_pfear_map[];
-extern const struct pmc_bit_map *ext_tgl_pfear_map[];
-extern const struct pmc_bit_map tgl_clocksource_status_map[];
-extern const struct pmc_bit_map tgl_power_gating_status_map[];
-extern const struct pmc_bit_map tgl_d3_status_map[];
-extern const struct pmc_bit_map tgl_vnn_req_status_map[];
-extern const struct pmc_bit_map tgl_vnn_misc_status_map[];
 extern const struct pmc_bit_map tgl_signal_status_map[];
-extern const struct pmc_bit_map *tgl_lpm_maps[];
-extern const struct pmc_reg_map tgl_reg_map;
-extern const struct pmc_reg_map tgl_h_reg_map;
-extern const struct pmc_bit_map adl_pfear_map[];
-extern const struct pmc_bit_map *ext_adl_pfear_map[];
-extern const struct pmc_bit_map adl_ltr_show_map[];
-extern const struct pmc_bit_map adl_clocksource_status_map[];
-extern const struct pmc_bit_map adl_power_gating_status_0_map[];
-extern const struct pmc_bit_map adl_power_gating_status_1_map[];
-extern const struct pmc_bit_map adl_power_gating_status_2_map[];
-extern const struct pmc_bit_map adl_d3_status_0_map[];
-extern const struct pmc_bit_map adl_d3_status_1_map[];
-extern const struct pmc_bit_map adl_d3_status_2_map[];
-extern const struct pmc_bit_map adl_d3_status_3_map[];
-extern const struct pmc_bit_map adl_vnn_req_status_0_map[];
-extern const struct pmc_bit_map adl_vnn_req_status_1_map[];
-extern const struct pmc_bit_map adl_vnn_req_status_2_map[];
-extern const struct pmc_bit_map adl_vnn_req_status_3_map[];
-extern const struct pmc_bit_map adl_vnn_misc_status_map[];
-extern const struct pmc_bit_map *adl_lpm_maps[];
 extern const struct pmc_reg_map adl_reg_map;
 extern const struct pmc_bit_map mtl_socm_pfear_map[];
-extern const struct pmc_bit_map *ext_mtl_socm_pfear_map[];
-extern const struct pmc_bit_map mtl_socm_ltr_show_map[];
-extern const struct pmc_bit_map mtl_socm_clocksource_status_map[];
-extern const struct pmc_bit_map mtl_socm_power_gating_status_0_map[];
-extern const struct pmc_bit_map mtl_socm_power_gating_status_1_map[];
-extern const struct pmc_bit_map mtl_socm_power_gating_status_2_map[];
 extern const struct pmc_bit_map mtl_socm_d3_status_0_map[];
 extern const struct pmc_bit_map mtl_socm_d3_status_1_map[];
-extern const struct pmc_bit_map mtl_socm_d3_status_2_map[];
-extern const struct pmc_bit_map mtl_socm_d3_status_3_map[];
 extern const struct pmc_bit_map mtl_socm_vnn_req_status_0_map[];
 extern const struct pmc_bit_map mtl_socm_vnn_req_status_1_map[];
 extern const struct pmc_bit_map mtl_socm_vnn_req_status_2_map[];
-extern const struct pmc_bit_map mtl_socm_vnn_req_status_3_map[];
 extern const struct pmc_bit_map mtl_socm_vnn_misc_status_map[];
 extern const struct pmc_bit_map mtl_socm_signal_status_map[];
-extern const struct pmc_bit_map *mtl_socm_lpm_maps[];
 extern const struct pmc_reg_map mtl_socm_reg_map;
-extern const struct pmc_bit_map mtl_ioep_pfear_map[];
-extern const struct pmc_bit_map *ext_mtl_ioep_pfear_map[];
-extern const struct pmc_bit_map mtl_ioep_ltr_show_map[];
-extern const struct pmc_bit_map mtl_ioep_clocksource_status_map[];
-extern const struct pmc_bit_map mtl_ioep_power_gating_status_0_map[];
-extern const struct pmc_bit_map mtl_ioep_power_gating_status_1_map[];
-extern const struct pmc_bit_map mtl_ioep_power_gating_status_2_map[];
-extern const struct pmc_bit_map mtl_ioep_d3_status_0_map[];
-extern const struct pmc_bit_map mtl_ioep_d3_status_1_map[];
-extern const struct pmc_bit_map mtl_ioep_d3_status_2_map[];
-extern const struct pmc_bit_map mtl_ioep_d3_status_3_map[];
-extern const struct pmc_bit_map mtl_ioep_vnn_req_status_0_map[];
-extern const struct pmc_bit_map mtl_ioep_vnn_req_status_1_map[];
-extern const struct pmc_bit_map mtl_ioep_vnn_req_status_2_map[];
-extern const struct pmc_bit_map mtl_ioep_vnn_req_status_3_map[];
-extern const struct pmc_bit_map mtl_ioep_vnn_misc_status_map[];
-extern const struct pmc_bit_map *mtl_ioep_lpm_maps[];
 extern const struct pmc_reg_map mtl_ioep_reg_map;
-extern const struct pmc_bit_map mtl_ioem_pfear_map[];
-extern const struct pmc_bit_map *ext_mtl_ioem_pfear_map[];
-extern const struct pmc_bit_map mtl_ioem_power_gating_status_1_map[];
-extern const struct pmc_bit_map mtl_ioem_vnn_req_status_1_map[];
-extern const struct pmc_bit_map *mtl_ioem_lpm_maps[];
-extern const struct pmc_reg_map mtl_ioem_reg_map;
-extern const struct pmc_reg_map lnl_socm_reg_map;
-
-/* LNL */
-extern const struct pmc_bit_map lnl_ltr_show_map[];
-extern const struct pmc_bit_map lnl_clocksource_status_map[];
-extern const struct pmc_bit_map lnl_power_gating_status_0_map[];
-extern const struct pmc_bit_map lnl_power_gating_status_1_map[];
-extern const struct pmc_bit_map lnl_power_gating_status_2_map[];
-extern const struct pmc_bit_map lnl_d3_status_0_map[];
-extern const struct pmc_bit_map lnl_d3_status_1_map[];
-extern const struct pmc_bit_map lnl_d3_status_2_map[];
-extern const struct pmc_bit_map lnl_d3_status_3_map[];
-extern const struct pmc_bit_map lnl_vnn_req_status_0_map[];
-extern const struct pmc_bit_map lnl_vnn_req_status_1_map[];
-extern const struct pmc_bit_map lnl_vnn_req_status_2_map[];
-extern const struct pmc_bit_map lnl_vnn_req_status_3_map[];
-extern const struct pmc_bit_map lnl_vnn_misc_status_map[];
-extern const struct pmc_bit_map *lnl_lpm_maps[];
-extern const struct pmc_bit_map *lnl_blk_maps[];
-extern const struct pmc_bit_map lnl_pfear_map[];
-extern const struct pmc_bit_map *ext_lnl_pfear_map[];
-extern const struct pmc_bit_map lnl_signal_status_map[];
-
-/* ARL */
-extern const struct pmc_bit_map arl_socs_ltr_show_map[];
-extern const struct pmc_bit_map arl_socs_clocksource_status_map[];
-extern const struct pmc_bit_map arl_socs_power_gating_status_0_map[];
-extern const struct pmc_bit_map arl_socs_power_gating_status_1_map[];
-extern const struct pmc_bit_map arl_socs_power_gating_status_2_map[];
-extern const struct pmc_bit_map arl_socs_d3_status_2_map[];
-extern const struct pmc_bit_map arl_socs_d3_status_3_map[];
-extern const struct pmc_bit_map arl_socs_vnn_req_status_3_map[];
-extern const struct pmc_bit_map *arl_socs_lpm_maps[];
-extern const struct pmc_bit_map arl_socs_pfear_map[];
-extern const struct pmc_bit_map *ext_arl_socs_pfear_map[];
-extern const struct pmc_reg_map arl_socs_reg_map;
-extern const struct pmc_bit_map arl_pchs_ltr_show_map[];
-extern const struct pmc_bit_map arl_pchs_clocksource_status_map[];
-extern const struct pmc_bit_map arl_pchs_power_gating_status_0_map[];
-extern const struct pmc_bit_map arl_pchs_power_gating_status_1_map[];
-extern const struct pmc_bit_map arl_pchs_power_gating_status_2_map[];
-extern const struct pmc_bit_map arl_pchs_d3_status_0_map[];
-extern const struct pmc_bit_map arl_pchs_d3_status_1_map[];
-extern const struct pmc_bit_map arl_pchs_d3_status_2_map[];
-extern const struct pmc_bit_map arl_pchs_d3_status_3_map[];
-extern const struct pmc_bit_map arl_pchs_vnn_req_status_0_map[];
-extern const struct pmc_bit_map arl_pchs_vnn_req_status_1_map[];
-extern const struct pmc_bit_map arl_pchs_vnn_req_status_2_map[];
-extern const struct pmc_bit_map arl_pchs_vnn_req_status_3_map[];
-extern const struct pmc_bit_map arl_pchs_vnn_misc_status_map[];
-extern const struct pmc_bit_map arl_pchs_signal_status_map[];
-extern const struct pmc_bit_map *arl_pchs_lpm_maps[];
-extern const struct pmc_reg_map arl_pchs_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 6952c8ef58a01..db7ed15bf863a 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -10,7 +10,7 @@
 
 #include "core.h"
 
-const struct pmc_bit_map icl_pfear_map[] = {
+static const struct pmc_bit_map icl_pfear_map[] = {
 	{"RES_65",		BIT(0)},
 	{"RES_66",		BIT(1)},
 	{"RES_67",		BIT(2)},
@@ -22,7 +22,7 @@ const struct pmc_bit_map icl_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_icl_pfear_map[] = {
+static const struct pmc_bit_map *ext_icl_pfear_map[] = {
 	/*
 	 * Check intel_pmc_core_ids[] users of icl_reg_map for
 	 * a list of core SoCs using this.
@@ -32,7 +32,7 @@ const struct pmc_bit_map *ext_icl_pfear_map[] = {
 	NULL
 };
 
-const struct pmc_reg_map icl_reg_map = {
+static const struct pmc_reg_map icl_reg_map = {
 	.pfear_sts = ext_icl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slp_s0_res_counter_step = ICL_PMC_SLP_S0_RES_COUNTER_STEP,
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 5a78807b9bc25..da513c234714b 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -13,7 +13,7 @@
 
 #include "core.h"
 
-const struct pmc_bit_map lnl_ltr_show_map[] = {
+static const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
 	{"SATA",		CNP_PMC_LTR_SATA},
@@ -55,7 +55,7 @@ const struct pmc_bit_map lnl_ltr_show_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_power_gating_status_0_map[] = {
+static const struct pmc_bit_map lnl_power_gating_status_0_map[] = {
 	{"PMC_PGD0_PG_STS",			BIT(0),		0},
 	{"FUSE_OSSE_PGD0_PG_STS",		BIT(1),		0},
 	{"ESPISPI_PGD0_PG_STS",			BIT(2),		0},
@@ -91,7 +91,7 @@ const struct pmc_bit_map lnl_power_gating_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_power_gating_status_1_map[] = {
+static const struct pmc_bit_map lnl_power_gating_status_1_map[] = {
 	{"USBR0_PGD0_PG_STS",			BIT(0),		1},
 	{"SUSRAM_PGD0_PG_STS",			BIT(1),		1},
 	{"SMT1_PGD0_PG_STS",			BIT(2),		1},
@@ -127,7 +127,7 @@ const struct pmc_bit_map lnl_power_gating_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_power_gating_status_2_map[] = {
+static const struct pmc_bit_map lnl_power_gating_status_2_map[] = {
 	{"PSF8_PGD0_PG_STS",			BIT(0),		0},
 	{"SBR16B2_PGD0_PG_STS",			BIT(1),		0},
 	{"D2D_IPU_PGD0_PG_STS",			BIT(2),		1},
@@ -163,7 +163,7 @@ const struct pmc_bit_map lnl_power_gating_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_d3_status_0_map[] = {
+static const struct pmc_bit_map lnl_d3_status_0_map[] = {
 	{"LPSS_D3_STS",				BIT(3),		1},
 	{"XDCI_D3_STS",				BIT(4),		1},
 	{"XHCI_D3_STS",				BIT(5),		1},
@@ -175,7 +175,7 @@ const struct pmc_bit_map lnl_d3_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_d3_status_1_map[] = {
+static const struct pmc_bit_map lnl_d3_status_1_map[] = {
 	{"OSSE_SMT1_D3_STS",			BIT(7),		0},
 	{"GBE_D3_STS",				BIT(19),	0},
 	{"ITSS_D3_STS",				BIT(23),	0},
@@ -185,7 +185,7 @@ const struct pmc_bit_map lnl_d3_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_d3_status_2_map[] = {
+static const struct pmc_bit_map lnl_d3_status_2_map[] = {
 	{"ESE_D3_STS",				BIT(0),		0},
 	{"CSMERTC_D3_STS",			BIT(1),		0},
 	{"SUSRAM_D3_STS",			BIT(2),		0},
@@ -205,7 +205,7 @@ const struct pmc_bit_map lnl_d3_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_d3_status_3_map[] = {
+static const struct pmc_bit_map lnl_d3_status_3_map[] = {
 	{"THC0_D3_STS",				BIT(14),	1},
 	{"THC1_D3_STS",				BIT(15),	1},
 	{"OSSE_SMT3_D3_STS",			BIT(21),	0},
@@ -213,14 +213,14 @@ const struct pmc_bit_map lnl_d3_status_3_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_vnn_req_status_0_map[] = {
+static const struct pmc_bit_map lnl_vnn_req_status_0_map[] = {
 	{"LPSS_VNN_REQ_STS",			BIT(3),		1},
 	{"OSSE_VNN_REQ_STS",			BIT(15),	1},
 	{"ESPISPI_VNN_REQ_STS",			BIT(18),	1},
 	{}
 };
 
-const struct pmc_bit_map lnl_vnn_req_status_1_map[] = {
+static const struct pmc_bit_map lnl_vnn_req_status_1_map[] = {
 	{"NPK_VNN_REQ_STS",			BIT(4),		1},
 	{"OSSE_SMT1_VNN_REQ_STS",		BIT(7),		1},
 	{"DFXAGG_VNN_REQ_STS",			BIT(8),		0},
@@ -232,7 +232,7 @@ const struct pmc_bit_map lnl_vnn_req_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_vnn_req_status_2_map[] = {
+static const struct pmc_bit_map lnl_vnn_req_status_2_map[] = {
 	{"eSE_VNN_REQ_STS",			BIT(0),		1},
 	{"CSMERTC_VNN_REQ_STS",			BIT(1),		1},
 	{"CSE_VNN_REQ_STS",			BIT(4),		1},
@@ -249,14 +249,14 @@ const struct pmc_bit_map lnl_vnn_req_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_vnn_req_status_3_map[] = {
+static const struct pmc_bit_map lnl_vnn_req_status_3_map[] = {
 	{"DISP_SHIM_VNN_REQ_STS",		BIT(2),		0},
 	{"DTS0_VNN_REQ_STS",			BIT(7),		0},
 	{"GPIOCOM5_VNN_REQ_STS",		BIT(11),	2},
 	{}
 };
 
-const struct pmc_bit_map lnl_vnn_misc_status_map[] = {
+static const struct pmc_bit_map lnl_vnn_misc_status_map[] = {
 	{"CPU_C10_REQ_STS",			BIT(0),		0},
 	{"TS_OFF_REQ_STS",			BIT(1),		0},
 	{"PNDE_MET_REQ_STS",			BIT(2),		1},
@@ -292,7 +292,7 @@ const struct pmc_bit_map lnl_vnn_misc_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_clocksource_status_map[] = {
+static const struct pmc_bit_map lnl_clocksource_status_map[] = {
 	{"AON2_OFF_STS",			BIT(0),		0},
 	{"AON3_OFF_STS",			BIT(1),		1},
 	{"AON4_OFF_STS",			BIT(2),		1},
@@ -317,7 +317,7 @@ const struct pmc_bit_map lnl_clocksource_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_signal_status_map[] = {
+static const struct pmc_bit_map lnl_signal_status_map[] = {
 	{"LSX_Wake0_STS",			BIT(0),		0},
 	{"LSX_Wake1_STS",			BIT(1),		0},
 	{"LSX_Wake2_STS",			BIT(2),		0},
@@ -337,7 +337,7 @@ const struct pmc_bit_map lnl_signal_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map lnl_rsc_status_map[] = {
+static const struct pmc_bit_map lnl_rsc_status_map[] = {
 	{"Memory",				0,		1},
 	{"PSF0",				0,		1},
 	{"PSF4",				0,		1},
@@ -349,7 +349,7 @@ const struct pmc_bit_map lnl_rsc_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *lnl_lpm_maps[] = {
+static const struct pmc_bit_map *lnl_lpm_maps[] = {
 	lnl_clocksource_status_map,
 	lnl_power_gating_status_0_map,
 	lnl_power_gating_status_1_map,
@@ -367,7 +367,7 @@ const struct pmc_bit_map *lnl_lpm_maps[] = {
 	NULL
 };
 
-const struct pmc_bit_map *lnl_blk_maps[] = {
+static const struct pmc_bit_map *lnl_blk_maps[] = {
 	lnl_power_gating_status_0_map,
 	lnl_power_gating_status_1_map,
 	lnl_power_gating_status_2_map,
@@ -386,7 +386,7 @@ const struct pmc_bit_map *lnl_blk_maps[] = {
 	NULL
 };
 
-const struct pmc_bit_map lnl_pfear_map[] = {
+static const struct pmc_bit_map lnl_pfear_map[] = {
 	{"PMC_0",			BIT(0)},
 	{"FUSE_OSSE",			BIT(1)},
 	{"ESPISPI",			BIT(2)},
@@ -498,12 +498,12 @@ const struct pmc_bit_map lnl_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_lnl_pfear_map[] = {
+static const struct pmc_bit_map *ext_lnl_pfear_map[] = {
 	lnl_pfear_map,
 	NULL
 };
 
-const struct pmc_reg_map lnl_socm_reg_map = {
+static const struct pmc_reg_map lnl_socm_reg_map = {
 	.pfear_sts = ext_lnl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 705b7e1b0b865..8862829694a71 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -102,12 +102,12 @@ const struct pmc_bit_map mtl_socm_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_mtl_socm_pfear_map[] = {
+static const struct pmc_bit_map *ext_mtl_socm_pfear_map[] = {
 	mtl_socm_pfear_map,
 	NULL
 };
 
-const struct pmc_bit_map mtl_socm_ltr_show_map[] = {
+static const struct pmc_bit_map mtl_socm_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
 	{"SATA",		CNP_PMC_LTR_SATA},
@@ -141,7 +141,7 @@ const struct pmc_bit_map mtl_socm_ltr_show_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_socm_clocksource_status_map[] = {
+static const struct pmc_bit_map mtl_socm_clocksource_status_map[] = {
 	{"AON2_OFF_STS",                 BIT(0)},
 	{"AON3_OFF_STS",                 BIT(1)},
 	{"AON4_OFF_STS",                 BIT(2)},
@@ -167,7 +167,7 @@ const struct pmc_bit_map mtl_socm_clocksource_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_socm_power_gating_status_0_map[] = {
+static const struct pmc_bit_map mtl_socm_power_gating_status_0_map[] = {
 	{"PMC_PGD0_PG_STS",              BIT(0)},
 	{"DMI_PGD0_PG_STS",              BIT(1)},
 	{"ESPISPI_PGD0_PG_STS",          BIT(2)},
@@ -203,7 +203,7 @@ const struct pmc_bit_map mtl_socm_power_gating_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_socm_power_gating_status_1_map[] = {
+static const struct pmc_bit_map mtl_socm_power_gating_status_1_map[] = {
 	{"USBR0_PGD0_PG_STS",            BIT(0)},
 	{"SUSRAM_PGD0_PG_STS",           BIT(1)},
 	{"SMT1_PGD0_PG_STS",             BIT(2)},
@@ -239,7 +239,7 @@ const struct pmc_bit_map mtl_socm_power_gating_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_socm_power_gating_status_2_map[] = {
+static const struct pmc_bit_map mtl_socm_power_gating_status_2_map[] = {
 	{"PSF8_PGD0_PG_STS",             BIT(0)},
 	{"FIA_PGD0_PG_STS",              BIT(1)},
 	{"SOC_D2D_PGD1_PG_STS",          BIT(2)},
@@ -291,7 +291,7 @@ const struct pmc_bit_map mtl_socm_d3_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_socm_d3_status_2_map[] = {
+static const struct pmc_bit_map mtl_socm_d3_status_2_map[] = {
 	{"GNA_D3_STS",                   BIT(0)},
 	{"CSMERTC_D3_STS",               BIT(1)},
 	{"SUSRAM_D3_STS",                BIT(2)},
@@ -310,7 +310,7 @@ const struct pmc_bit_map mtl_socm_d3_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_socm_d3_status_3_map[] = {
+static const struct pmc_bit_map mtl_socm_d3_status_3_map[] = {
 	{"ESE_D3_STS",                   BIT(2)},
 	{"GBETSN_D3_STS",                BIT(13)},
 	{"THC0_D3_STS",                  BIT(14)},
@@ -353,7 +353,7 @@ const struct pmc_bit_map mtl_socm_vnn_req_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_socm_vnn_req_status_3_map[] = {
+static const struct pmc_bit_map mtl_socm_vnn_req_status_3_map[] = {
 	{"ESE_VNN_REQ_STS",              BIT(2)},
 	{"DTS0_VNN_REQ_STS",             BIT(7)},
 	{"GPIOCOM5_VNN_REQ_STS",         BIT(11)},
@@ -432,7 +432,7 @@ const struct pmc_bit_map mtl_socm_signal_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *mtl_socm_lpm_maps[] = {
+static const struct pmc_bit_map *mtl_socm_lpm_maps[] = {
 	mtl_socm_clocksource_status_map,
 	mtl_socm_power_gating_status_0_map,
 	mtl_socm_power_gating_status_1_map,
@@ -476,7 +476,7 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
-const struct pmc_bit_map mtl_ioep_pfear_map[] = {
+static const struct pmc_bit_map mtl_ioep_pfear_map[] = {
 	{"PMC_0",               BIT(0)},
 	{"OPI",                 BIT(1)},
 	{"TCSS",                BIT(2)},
@@ -563,12 +563,12 @@ const struct pmc_bit_map mtl_ioep_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_mtl_ioep_pfear_map[] = {
+static const struct pmc_bit_map *ext_mtl_ioep_pfear_map[] = {
 	mtl_ioep_pfear_map,
 	NULL
 };
 
-const struct pmc_bit_map mtl_ioep_ltr_show_map[] = {
+static const struct pmc_bit_map mtl_ioep_ltr_show_map[] = {
 	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
 	{"SATA",		CNP_PMC_LTR_SATA},
@@ -600,7 +600,7 @@ const struct pmc_bit_map mtl_ioep_ltr_show_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_clocksource_status_map[] = {
+static const struct pmc_bit_map mtl_ioep_clocksource_status_map[] = {
 	{"AON2_OFF_STS",                 BIT(0)},
 	{"AON3_OFF_STS",                 BIT(1)},
 	{"AON4_OFF_STS",                 BIT(2)},
@@ -623,7 +623,7 @@ const struct pmc_bit_map mtl_ioep_clocksource_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_power_gating_status_0_map[] = {
+static const struct pmc_bit_map mtl_ioep_power_gating_status_0_map[] = {
 	{"PMC_PGD0_PG_STS",              BIT(0)},
 	{"DMI_PGD0_PG_STS",              BIT(1)},
 	{"TCSS_PGD0_PG_STS",             BIT(2)},
@@ -650,7 +650,7 @@ const struct pmc_bit_map mtl_ioep_power_gating_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_power_gating_status_1_map[] = {
+static const struct pmc_bit_map mtl_ioep_power_gating_status_1_map[] = {
 	{"PSF9_PGD0_PG_STS",             BIT(0)},
 	{"MPFPW4_PGD0_PG_STS",           BIT(1)},
 	{"SBR0_PGD0_PG_STS",             BIT(8)},
@@ -668,7 +668,7 @@ const struct pmc_bit_map mtl_ioep_power_gating_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_power_gating_status_2_map[] = {
+static const struct pmc_bit_map mtl_ioep_power_gating_status_2_map[] = {
 	{"FIA_PGD0_PG_STS",              BIT(1)},
 	{"FIA_P_PGD0_PG_STS",            BIT(3)},
 	{"TAM_PGD0_PG_STS",              BIT(4)},
@@ -680,7 +680,7 @@ const struct pmc_bit_map mtl_ioep_power_gating_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_d3_status_0_map[] = {
+static const struct pmc_bit_map mtl_ioep_d3_status_0_map[] = {
 	{"SPF_D3_STS",                   BIT(0)},
 	{"SPA_D3_STS",                   BIT(12)},
 	{"SPB_D3_STS",                   BIT(13)},
@@ -691,43 +691,43 @@ const struct pmc_bit_map mtl_ioep_d3_status_0_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_d3_status_1_map[] = {
+static const struct pmc_bit_map mtl_ioep_d3_status_1_map[] = {
 	{"GBETSN1_D3_STS",               BIT(14)},
 	{"P2S_D3_STS",                   BIT(24)},
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_d3_status_2_map[] = {
+static const struct pmc_bit_map mtl_ioep_d3_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_d3_status_3_map[] = {
+static const struct pmc_bit_map mtl_ioep_d3_status_3_map[] = {
 	{"GBETSN_D3_STS",                BIT(13)},
 	{"ACE_D3_STS",                   BIT(23)},
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_vnn_req_status_0_map[] = {
+static const struct pmc_bit_map mtl_ioep_vnn_req_status_0_map[] = {
 	{"FIA_VNN_REQ_STS",              BIT(17)},
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_vnn_req_status_1_map[] = {
+static const struct pmc_bit_map mtl_ioep_vnn_req_status_1_map[] = {
 	{"DFXAGG_VNN_REQ_STS",           BIT(8)},
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_vnn_req_status_2_map[] = {
+static const struct pmc_bit_map mtl_ioep_vnn_req_status_2_map[] = {
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_vnn_req_status_3_map[] = {
+static const struct pmc_bit_map mtl_ioep_vnn_req_status_3_map[] = {
 	{"DTS0_VNN_REQ_STS",             BIT(7)},
 	{"DISP_VNN_REQ_STS",             BIT(19)},
 	{}
 };
 
-const struct pmc_bit_map mtl_ioep_vnn_misc_status_map[] = {
+static const struct pmc_bit_map mtl_ioep_vnn_misc_status_map[] = {
 	{"CPU_C10_REQ_STS",              BIT(0)},
 	{"TS_OFF_REQ_STS",               BIT(1)},
 	{"PNDE_MET_REQ_STS",             BIT(2)},
@@ -762,7 +762,7 @@ const struct pmc_bit_map mtl_ioep_vnn_misc_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *mtl_ioep_lpm_maps[] = {
+static const struct pmc_bit_map *mtl_ioep_lpm_maps[] = {
 	mtl_ioep_clocksource_status_map,
 	mtl_ioep_power_gating_status_0_map,
 	mtl_ioep_power_gating_status_1_map,
@@ -800,7 +800,7 @@ const struct pmc_reg_map mtl_ioep_reg_map = {
 	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
-const struct pmc_bit_map mtl_ioem_pfear_map[] = {
+static const struct pmc_bit_map mtl_ioem_pfear_map[] = {
 	{"PMC_0",               BIT(0)},
 	{"OPI",                 BIT(1)},
 	{"TCSS",                BIT(2)},
@@ -887,12 +887,12 @@ const struct pmc_bit_map mtl_ioem_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_mtl_ioem_pfear_map[] = {
+static const struct pmc_bit_map *ext_mtl_ioem_pfear_map[] = {
 	mtl_ioem_pfear_map,
 	NULL
 };
 
-const struct pmc_bit_map mtl_ioem_power_gating_status_1_map[] = {
+static const struct pmc_bit_map mtl_ioem_power_gating_status_1_map[] = {
 	{"PSF9_PGD0_PG_STS",                    BIT(0)},
 	{"MPFPW4_PGD0_PG_STS",                  BIT(1)},
 	{"SBR0_PGD0_PG_STS",                    BIT(8)},
@@ -909,7 +909,7 @@ const struct pmc_bit_map mtl_ioem_power_gating_status_1_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *mtl_ioem_lpm_maps[] = {
+static const struct pmc_bit_map *mtl_ioem_lpm_maps[] = {
 	mtl_ioep_clocksource_status_map,
 	mtl_ioep_power_gating_status_0_map,
 	mtl_ioem_power_gating_status_1_map,
@@ -927,7 +927,7 @@ const struct pmc_bit_map *mtl_ioem_lpm_maps[] = {
 	NULL
 };
 
-const struct pmc_reg_map mtl_ioem_reg_map = {
+static const struct pmc_reg_map mtl_ioem_reg_map = {
 	.regmap_length = MTL_IOE_PMC_MMIO_REG_LEN,
 	.pfear_sts = ext_mtl_ioem_pfear_map,
 	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index 440594acac6cf..b50534aa2cba0 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -12,7 +12,7 @@
 
 #include "core.h"
 
-const struct pmc_bit_map spt_pll_map[] = {
+static const struct pmc_bit_map spt_pll_map[] = {
 	{"MIPI PLL",			SPT_PMC_BIT_MPHY_CMN_LANE0},
 	{"GEN2 USB2PCIE2 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE1},
 	{"DMIPCIE3 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE2},
@@ -20,7 +20,7 @@ const struct pmc_bit_map spt_pll_map[] = {
 	{}
 };
 
-const struct pmc_bit_map spt_mphy_map[] = {
+static const struct pmc_bit_map spt_mphy_map[] = {
 	{"MPHY CORE LANE 0",           SPT_PMC_BIT_MPHY_LANE0},
 	{"MPHY CORE LANE 1",           SPT_PMC_BIT_MPHY_LANE1},
 	{"MPHY CORE LANE 2",           SPT_PMC_BIT_MPHY_LANE2},
@@ -40,7 +40,7 @@ const struct pmc_bit_map spt_mphy_map[] = {
 	{}
 };
 
-const struct pmc_bit_map spt_pfear_map[] = {
+static const struct pmc_bit_map spt_pfear_map[] = {
 	{"PMC",				SPT_PMC_BIT_PMC},
 	{"OPI-DMI",			SPT_PMC_BIT_OPI},
 	{"SPI / eSPI",			SPT_PMC_BIT_SPI},
@@ -84,7 +84,7 @@ const struct pmc_bit_map spt_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_spt_pfear_map[] = {
+static const struct pmc_bit_map *ext_spt_pfear_map[] = {
 	/*
 	 * Check intel_pmc_core_ids[] users of spt_reg_map for
 	 * a list of core SoCs using this.
@@ -93,7 +93,7 @@ const struct pmc_bit_map *ext_spt_pfear_map[] = {
 	NULL
 };
 
-const struct pmc_bit_map spt_ltr_show_map[] = {
+static const struct pmc_bit_map spt_ltr_show_map[] = {
 	{"SOUTHPORT_A",		SPT_PMC_LTR_SPA},
 	{"SOUTHPORT_B",		SPT_PMC_LTR_SPB},
 	{"SATA",		SPT_PMC_LTR_SATA},
@@ -118,7 +118,7 @@ const struct pmc_bit_map spt_ltr_show_map[] = {
 	{}
 };
 
-const struct pmc_reg_map spt_reg_map = {
+static const struct pmc_reg_map spt_reg_map = {
 	.pfear_sts = ext_spt_pfear_map,
 	.mphy_sts = spt_mphy_map,
 	.pll_sts = spt_pll_map,
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 758bd8d162e59..02e731ed33914 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -18,7 +18,7 @@ enum pch_type {
 	PCH_LP
 };
 
-const struct pmc_bit_map tgl_pfear_map[] = {
+static const struct pmc_bit_map tgl_pfear_map[] = {
 	{"PSF9",		BIT(0)},
 	{"RES_66",		BIT(1)},
 	{"RES_67",		BIT(2)},
@@ -29,7 +29,7 @@ const struct pmc_bit_map tgl_pfear_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *ext_tgl_pfear_map[] = {
+static const struct pmc_bit_map *ext_tgl_pfear_map[] = {
 	/*
 	 * Check intel_pmc_core_ids[] users of tgl_reg_map for
 	 * a list of core SoCs using this.
@@ -39,7 +39,7 @@ const struct pmc_bit_map *ext_tgl_pfear_map[] = {
 	NULL
 };
 
-const struct pmc_bit_map tgl_clocksource_status_map[] = {
+static const struct pmc_bit_map tgl_clocksource_status_map[] = {
 	{"USB2PLL_OFF_STS",			BIT(18)},
 	{"PCIe/USB3.1_Gen2PLL_OFF_STS",		BIT(19)},
 	{"PCIe_Gen3PLL_OFF_STS",		BIT(20)},
@@ -55,7 +55,7 @@ const struct pmc_bit_map tgl_clocksource_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map tgl_power_gating_status_map[] = {
+static const struct pmc_bit_map tgl_power_gating_status_map[] = {
 	{"CSME_PG_STS",				BIT(0)},
 	{"SATA_PG_STS",				BIT(1)},
 	{"xHCI_PG_STS",				BIT(2)},
@@ -83,7 +83,7 @@ const struct pmc_bit_map tgl_power_gating_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map tgl_d3_status_map[] = {
+static const struct pmc_bit_map tgl_d3_status_map[] = {
 	{"ADSP_D3_STS",				BIT(0)},
 	{"SATA_D3_STS",				BIT(1)},
 	{"xHCI0_D3_STS",			BIT(2)},
@@ -98,7 +98,7 @@ const struct pmc_bit_map tgl_d3_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map tgl_vnn_req_status_map[] = {
+static const struct pmc_bit_map tgl_vnn_req_status_map[] = {
 	{"GPIO_COM0_VNN_REQ_STS",		BIT(1)},
 	{"GPIO_COM1_VNN_REQ_STS",		BIT(2)},
 	{"GPIO_COM2_VNN_REQ_STS",		BIT(3)},
@@ -123,7 +123,7 @@ const struct pmc_bit_map tgl_vnn_req_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map tgl_vnn_misc_status_map[] = {
+static const struct pmc_bit_map tgl_vnn_misc_status_map[] = {
 	{"CPU_C10_REQ_STS_0",			BIT(0)},
 	{"PCIe_LPM_En_REQ_STS_3",		BIT(3)},
 	{"ITH_REQ_STS_5",			BIT(5)},
@@ -175,7 +175,7 @@ const struct pmc_bit_map tgl_signal_status_map[] = {
 	{}
 };
 
-const struct pmc_bit_map *tgl_lpm_maps[] = {
+static const struct pmc_bit_map *tgl_lpm_maps[] = {
 	tgl_clocksource_status_map,
 	tgl_power_gating_status_map,
 	tgl_d3_status_map,
@@ -185,7 +185,7 @@ const struct pmc_bit_map *tgl_lpm_maps[] = {
 	NULL
 };
 
-const struct pmc_reg_map tgl_reg_map = {
+static const struct pmc_reg_map tgl_reg_map = {
 	.pfear_sts = ext_tgl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
@@ -210,7 +210,7 @@ const struct pmc_reg_map tgl_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
-const struct pmc_reg_map tgl_h_reg_map = {
+static const struct pmc_reg_map tgl_h_reg_map = {
 	.pfear_sts = ext_tgl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
 	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
-- 
2.43.0


