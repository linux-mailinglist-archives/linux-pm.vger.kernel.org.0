Return-Path: <linux-pm+bounces-28441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86959AD4C0A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 08:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A1B189D56B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2714B07A;
	Wed, 11 Jun 2025 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7j0RIok"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9EC133;
	Wed, 11 Jun 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624632; cv=none; b=BBxl6AeRN5E2YmhyT+brspqOHw6NaJybnfQ6L1lz6V821YhN+h1OcRvdSE77s2N1qScvr3FFZXoHiD3q+YTrK6QcUgv+TjsPuMNHGAyE78RQ/ioIZNqH9VRtOVOYhMqKgYA3eU9zy9PTtIadOVZqwMo3PgrWUg70/GKEaM2gLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624632; c=relaxed/simple;
	bh=FwpKkLG3+RwxJ2mfo58pxQUOQslBoHID+Rur2lHls4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ccf88cenM30zkk1vtqEsfzATc4CxpXQxNgk8QuQc+nNsiwEYatfz85MWZe+RJ5KUNEl1BRTQEZxOOceRaSWnbk3wr17nHlUHXBBvqdIvabvhbScN3HUbLBjP67ruTPtjCrQBPyHGeOxJb8JU8Y2USidFrSnOUd2ZLp8pxrF9/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7j0RIok; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749624631; x=1781160631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FwpKkLG3+RwxJ2mfo58pxQUOQslBoHID+Rur2lHls4w=;
  b=I7j0RIokW4Rbcp9Gshg1m7Y/gQZq7iVneUfz6JwJx1CksF1pNn3kWL1z
   v8+OzvKIAkKsgX5utUffrrObGTHPxeD/nPAphTqdhK+It8iWYf0cR5nWC
   +Oc9EVZyI0/MAdVKuyJhFRlNVGGXh0avfbo80LaKXr9OpfSeSsjvv6XkE
   R0DF0T2NEl65YZvrLXWDe3LZ24UXox/qINXpVsLI5GfhA5NaeuVnqKoSC
   7l87AIqCZSsahpuBy9YRMOeQawFUK15VzYwofiG0aDoWA4fNb0TtS9OVM
   0etT5NeculrL9ADMyvHyzFxjFrCNibyV/s47O7XvOMb+5/SGZn92iuKG9
   w==;
X-CSE-ConnectionGUID: PvPTslniQ5a7ijmpOPHjyw==
X-CSE-MsgGUID: kkLnZLkhSciHb7uuALuKCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55550824"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="55550824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 23:50:30 -0700
X-CSE-ConnectionGUID: y5ABTcSHSGu0SCu/FJROqA==
X-CSE-MsgGUID: rUJ0g4N+TfWrFjR0r9tr6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152314520"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by orviesa005.jf.intel.com with ESMTP; 10 Jun 2025 23:50:28 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Fix DMR support
Date: Wed, 11 Jun 2025 14:50:26 +0800
Message-ID: <20250611065026.40117-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Together with the RAPL MSRs, there are more MSRs gone on DMR, including
PLR (Perf Limit Reasons), and IRTL (Package cstate Interrupt Response
Time Limit) MSRs. The configurable TDP info should also be retrieved
from TPMI based Intel Speed Select Technology feature.

Remove the access of these MSRs for DMR. Improve the DMR platform
feature table to make it more readable at the same time.

Fixes: 83075bd59de2 ("tools/power turbostat: Add initial support for DMR")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 29 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5230e072e414..690c534905ea 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -840,20 +840,21 @@ static const struct platform_features spr_features = {
 };
 
 static const struct platform_features dmr_features = {
-	.has_msr_misc_feature_control = spr_features.has_msr_misc_feature_control,
-	.has_msr_misc_pwr_mgmt = spr_features.has_msr_misc_pwr_mgmt,
-	.has_nhm_msrs = spr_features.has_nhm_msrs,
-	.has_config_tdp = spr_features.has_config_tdp,
-	.bclk_freq = spr_features.bclk_freq,
-	.supported_cstates = spr_features.supported_cstates,
-	.cst_limit = spr_features.cst_limit,
-	.has_msr_core_c1_res = spr_features.has_msr_core_c1_res,
-	.has_msr_module_c6_res_ms = 1,	/* DMR has Dual Core Module and MC6 MSR */
-	.has_irtl_msrs = spr_features.has_irtl_msrs,
-	.has_cst_prewake_bit = spr_features.has_cst_prewake_bit,
-	.has_fixed_rapl_psys_unit = spr_features.has_fixed_rapl_psys_unit,
-	.trl_msrs = spr_features.trl_msrs,
-	.rapl_msrs = 0,		/* DMR does not have RAPL MSRs */
+	.has_msr_misc_feature_control	= spr_features.has_msr_misc_feature_control,
+	.has_msr_misc_pwr_mgmt		= spr_features.has_msr_misc_pwr_mgmt,
+	.has_nhm_msrs			= spr_features.has_nhm_msrs,
+	.bclk_freq			= spr_features.bclk_freq,
+	.supported_cstates		= spr_features.supported_cstates,
+	.cst_limit			= spr_features.cst_limit,
+	.has_msr_core_c1_res		= spr_features.has_msr_core_c1_res,
+	.has_cst_prewake_bit		= spr_features.has_cst_prewake_bit,
+	.has_fixed_rapl_psys_unit	= spr_features.has_fixed_rapl_psys_unit,
+	.trl_msrs			= spr_features.trl_msrs,
+	.has_msr_module_c6_res_ms	= 1,	/* DMR has Dual-Core-Module and MC6 MSR */
+	.rapl_msrs			= 0,	/* DMR does not have RAPL MSRs */
+	.plr_msrs			= 0,	/* DMR does not have PLR  MSRs */
+	.has_irtl_msrs			= 0,	/* DMR does not have IRTL MSRs */
+	.has_config_tdp			= 0,	/* DMR does not have CTDP MSRs */
 };
 
 static const struct platform_features srf_features = {
-- 
2.43.0


