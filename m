Return-Path: <linux-pm+bounces-17542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757B9C8482
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4776285267
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA51F706F;
	Thu, 14 Nov 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gS8oxjsU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85251F6671
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571413; cv=none; b=Co6WSw+aXvpjW8E+3XnHuIdFG1eNEVTpJ32JoZmdP17QJH45DNH+CDGQe/sJnTOn6kj6MNXFot+arbRmdrNOZ9BE68Ve5InAn/UcRAcxeBpsrbWnE7C4DvjZqdstcxAZ0QPAxJdCoDU4ozEWP38ivYWfJuyvWk03vYt+5gJ9jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571413; c=relaxed/simple;
	bh=pvS1h4Gp7T7xHYcLKeXGBr2z+uIKQs0CI+BDqdqe/qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQKCSKpxb5R8SJcpLEHp3Lb/eLuFan2BdZrpJ2Yo9EWEsMsihyEBEic898n4+E41R1emN7KASgXRTblfBXz0ouqG/Loy3n+58QIvE1j3KbiGkcH1wh470Q/YvtBOT6F5WND4UPIuXXKhx4oRQHL7vVA3r/rzTyW+CjAY5cYtlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gS8oxjsU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571411; x=1763107411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pvS1h4Gp7T7xHYcLKeXGBr2z+uIKQs0CI+BDqdqe/qI=;
  b=gS8oxjsULT1/9S+sd7C8h0BBdbc39BwymqnzV9VqvHjclVu287HW18/9
   isyeL9c36lB5uk9gsSbbqxwpun7N79sW86BTaenW8+TDFebcngFdEPrW+
   aNSqEyD6ZsUj7jYwtLDefMURslKpdvcVoGeZyyZCr4ZXY19gExHH68N1L
   a7pwQQgKW/r7BYSJNoFPjfM1zqO2fIqW1R5tw0GGaIUjcGg9YqcAyvcnR
   mhqx+YajyuwL/jtAE+18QgdBh8eb1WiqrfVk8loWxzISVnLd5iGUL9O/7
   TDU06GMlJu1Yufso8CwrG3mzMyO0Hhce1BOIbtCyn+vGX/k+Wxyxs73cP
   A==;
X-CSE-ConnectionGUID: VIwDIklWSP+cPV9lWobeuQ==
X-CSE-MsgGUID: 0Jh5mnM3Sc+wC0g59BWREQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600442"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600442"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:22 -0800
X-CSE-ConnectionGUID: 56werRu4TRqkGa2hAtb4YQ==
X-CSE-MsgGUID: 8q6vYVKbQ+WnoZm49j9W3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627475"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:20 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 06/10] tools/power turbostat: Enhance platform divergence description
Date: Thu, 14 Nov 2024 15:59:42 +0800
Message-ID: <20241114075946.118577-7-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114075946.118577-1-rui.zhang@intel.com>
References: <20241114075946.118577-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In various generations, platforms often share a majority of features,
diverging only in a few specific aspects. The current approach of using
hardcoded values in 'platform_features' structure fails to effectively
represent these divergences.

To improve the description of platform divergence:
1. Each newly introduced 'platform_features' structure must have a base,
   typically derived from the previous generation.
2. Platform feature values should be inherited from the base structure
   rather than being hardcoded.
This approach ensures a more accurate and maintainable representation of
platform-specific features across different generations.

Converts `adl_features` and `lnl_features` to follow this new scheme.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 58 ++++++++++++++-------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d8338458d031..8a45b1c4c225 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -729,38 +729,40 @@ static const struct platform_features cnl_features = {
 	.enable_tsc_tweak = 1,
 };
 
+/* Copied from cnl_features, with PC7/PC9 removed */
 static const struct platform_features adl_features = {
-	.has_msr_misc_feature_control = 1,
-	.has_msr_misc_pwr_mgmt = 1,
-	.has_nhm_msrs = 1,
-	.has_config_tdp = 1,
-	.bclk_freq = BCLK_100MHZ,
-	.supported_cstates = CC1 | CC6 | CC7 | PC2 | PC3 | PC6 | PC8 | PC10,
-	.cst_limit = CST_LIMIT_HSW,
-	.has_irtl_msrs = 1,
-	.has_msr_core_c1_res = 1,
-	.has_ext_cst_msrs = 1,
-	.trl_msrs = TRL_BASE,
-	.tcc_offset_bits = 6,
-	.rapl_msrs = RAPL_PKG_ALL | RAPL_CORE_ALL | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_GFX,
-	.enable_tsc_tweak = 1,
+	.has_msr_misc_feature_control	= cnl_features.has_msr_misc_feature_control,
+	.has_msr_misc_pwr_mgmt		= cnl_features.has_msr_misc_pwr_mgmt,
+	.has_nhm_msrs			= cnl_features.has_nhm_msrs,
+	.has_config_tdp			= cnl_features.has_config_tdp,
+	.bclk_freq			= cnl_features.bclk_freq,
+	.supported_cstates		= CC1 | CC6 | CC7 | PC2 | PC3 | PC6 | PC8 | PC10,
+	.cst_limit			= cnl_features.cst_limit,
+	.has_irtl_msrs			= cnl_features.has_irtl_msrs,
+	.has_msr_core_c1_res		= cnl_features.has_msr_core_c1_res,
+	.has_ext_cst_msrs		= cnl_features.has_ext_cst_msrs,
+	.trl_msrs			= cnl_features.trl_msrs,
+	.tcc_offset_bits		= cnl_features.tcc_offset_bits,
+	.rapl_msrs			= cnl_features.rapl_msrs,
+	.enable_tsc_tweak		= cnl_features.enable_tsc_tweak,
 };
 
+/* Copied from adl_features, with PC3/PC8 removed */
 static const struct platform_features lnl_features = {
-	.has_msr_misc_feature_control = 1,
-	.has_msr_misc_pwr_mgmt = 1,
-	.has_nhm_msrs = 1,
-	.has_config_tdp = 1,
-	.bclk_freq = BCLK_100MHZ,
-	.supported_cstates = CC1 | CC6 | CC7 | PC2 | PC6 | PC10,
-	.cst_limit = CST_LIMIT_HSW,
-	.has_irtl_msrs = 1,
-	.has_msr_core_c1_res = 1,
-	.has_ext_cst_msrs = 1,
-	.trl_msrs = TRL_BASE,
-	.tcc_offset_bits = 6,
-	.rapl_msrs = RAPL_PKG_ALL | RAPL_CORE_ALL | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_GFX,
-	.enable_tsc_tweak = 1,
+	.has_msr_misc_feature_control	= adl_features.has_msr_misc_feature_control,
+	.has_msr_misc_pwr_mgmt		= adl_features.has_msr_misc_pwr_mgmt,
+	.has_nhm_msrs			= adl_features.has_nhm_msrs,
+	.has_config_tdp			= adl_features.has_config_tdp,
+	.bclk_freq			= adl_features.bclk_freq,
+	.supported_cstates		= CC1 | CC6 | CC7 | PC2 | PC6 | PC10,
+	.cst_limit			= adl_features.cst_limit,
+	.has_irtl_msrs			= adl_features.has_irtl_msrs,
+	.has_msr_core_c1_res		= adl_features.has_msr_core_c1_res,
+	.has_ext_cst_msrs		= adl_features.has_ext_cst_msrs,
+	.trl_msrs			= adl_features.trl_msrs,
+	.tcc_offset_bits		= adl_features.tcc_offset_bits,
+	.rapl_msrs			= adl_features.rapl_msrs,
+	.enable_tsc_tweak		= adl_features.enable_tsc_tweak,
 };
 
 static const struct platform_features skx_features = {
-- 
2.43.0


