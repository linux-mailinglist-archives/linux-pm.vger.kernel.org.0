Return-Path: <linux-pm+bounces-28241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E2AD13B7
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713FF168F29
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0CC1D88A6;
	Sun,  8 Jun 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7dRXDOJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED21A316C
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406743; cv=none; b=Rh3HdUeH4u8qzbwv5390B7b1Rm9OV4LjxlI3awvrbcuj1vSGGNgxOLpVijd3at0cprLUppJ6M8LLIgmzsiPJoxK9A7YmjeHHLFe99vFJ2XtoxdR5PEyAXRwixynUTS2/wJzNoQ9QVo4Hh6wvSu2JKu+OcaP70hdNesfZE8L7TmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406743; c=relaxed/simple;
	bh=5XJKdmFlYICN/VGuJaAD42nmvRgFZWuMHKz27MODxwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKEkggrxEkVCgfWE2DPdznAPGyP28CSda0+iMX72kj70Xn0lgfy6m7rm6oIqV045e/Kx8mTeEJgOvmGt7301iPdZYp/yDstropx1/c5HoupifcrpLeylSOcrEjOkSpWeY4ytBHaAlTduC74+G9wl/gvVS9UhUkdNWziG05NBswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7dRXDOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1133C4CEF1;
	Sun,  8 Jun 2025 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406743;
	bh=5XJKdmFlYICN/VGuJaAD42nmvRgFZWuMHKz27MODxwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=b7dRXDOJ+//vthiuJkiJ4sTDeWdMLvJIdbFezbhr5jO4PnDjLrUuLbL1l40UtnrjV
	 wj1rFWwSAwW03A0mDrQFI4gcmjAKvaJrmb+wzTH6NDV5uyPbOx807YL0dcoj1fKBrl
	 PfX4MvcTBprt4KrKkg0anAsWorNjyvTslPDOs77ZGBqSR5A9D7A4ms4fDaOlYY4Z/2
	 a7fl5NViZOHyFL+GPTPzpmGL6Irl3JPfMy/JAaHXkRRAhVKbJaj89q6/ZzKEw+Hd1x
	 jpuw868LKTQ0+loEJVyxdqmXBwNYVmt4r0qDb9LLHqPjZX4LSAs9cnYWkhFOqldoDd
	 MuRtmFYulMVnA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 16/18] tools/power turbostat: Add initial support for DMR
Date: Sun,  8 Jun 2025 14:17:15 -0400
Message-ID: <7e7f0d80128721ace3c79196bcc9ed5814625cff.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Add initial support for DMR.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 30faa214676f..dca0753a76fb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -839,6 +839,23 @@ static const struct platform_features spr_features = {
 	.rapl_msrs = RAPL_PKG_ALL | RAPL_DRAM_ALL | RAPL_PSYS,
 };
 
+static const struct platform_features dmr_features = {
+	.has_msr_misc_feature_control = spr_features.has_msr_misc_feature_control,
+	.has_msr_misc_pwr_mgmt = spr_features.has_msr_misc_pwr_mgmt,
+	.has_nhm_msrs = spr_features.has_nhm_msrs,
+	.has_config_tdp = spr_features.has_config_tdp,
+	.bclk_freq = spr_features.bclk_freq,
+	.supported_cstates = spr_features.supported_cstates,
+	.cst_limit = spr_features.cst_limit,
+	.has_msr_core_c1_res = spr_features.has_msr_core_c1_res,
+	.has_msr_module_c6_res_ms = 1,	/* DMR has Dual Core Module and MC6 MSR */
+	.has_irtl_msrs = spr_features.has_irtl_msrs,
+	.has_cst_prewake_bit = spr_features.has_cst_prewake_bit,
+	.has_fixed_rapl_psys_unit = spr_features.has_fixed_rapl_psys_unit,
+	.trl_msrs = spr_features.trl_msrs,
+	.rapl_msrs = 0,		/* DMR does not have RAPL MSRs */
+};
+
 static const struct platform_features srf_features = {
 	.has_msr_misc_feature_control = 1,
 	.has_msr_misc_pwr_mgmt = 1,
@@ -1028,6 +1045,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_EMERALDRAPIDS_X, &spr_features },
 	{ INTEL_GRANITERAPIDS_X, &spr_features },
 	{ INTEL_GRANITERAPIDS_D, &spr_features },
+	{ INTEL_PANTHERCOVE_X, &dmr_features },
 	{ INTEL_LAKEFIELD, &cnl_features },
 	{ INTEL_ALDERLAKE, &adl_features },
 	{ INTEL_ALDERLAKE_L, &adl_features },
-- 
2.45.2


