Return-Path: <linux-pm+bounces-33776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B1B42DDD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 02:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 281C44E2AC8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 00:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D464C6D;
	Thu,  4 Sep 2025 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6rG+g/v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59A27461;
	Thu,  4 Sep 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944372; cv=none; b=f2ygxNouW8WprgnM+GRpaRNJBkbMkyw6fYGVXDTB6m2WpIhYaAHXlhfQr7NUmCSSsAbMIArtjQR0AXHXzwasbwLDq4t5EB9X+a+FOuvntvoB8jnIJvCzIvRH1pnbeOIuiDDnnwYig+vklOx+dZhFyYMpJL/tLh40ypFnxCE9Xtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944372; c=relaxed/simple;
	bh=Es+eq3ZVRi11VoTkAIPX61SkuKDGfB2WFAcKjQwm51I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CRGQFtQdjmi/hSGV6AEHlQvBTsbHy/bFM5RVqwMidEx7WX4p8fL1cW7AIuISJ6NaOqETSXZhGbP9LVXkUAO3DslpdNqYhR6WFeUlJ8upKNkz+ok2/o/W4Ys6WVqFD/C3f0uZASmIQX/gx7zxAFG3XKXejVvVcUCWoLLEegvDsyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6rG+g/v; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756944370; x=1788480370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Es+eq3ZVRi11VoTkAIPX61SkuKDGfB2WFAcKjQwm51I=;
  b=i6rG+g/vVLOrO5H1tocbNeZQt2lQAnoDt+ARRfUpSJDGYiBGYuCoDxuj
   6wCQ7yDbSkvFiBsKzrBwmCT+oC33YPz2Bq6NxZVJTviE4eB3P5HN/Rnco
   UMGmX+Orbo+KCJe9+iE+Ag5rEQ3//TmISY3GfME+Z/Zyxb3djPWxdrv7C
   r2PyzQY4acW53L9jgCkF412u1Ri+D0fqmhuy1duAnWp5CAPQkxCNmzLnV
   I0+LsOol7UzlNuHwglS6n8ffdCEs6yQghL4iiByqcC83V9hJkgItLkeYw
   Ixq/ct2ktHG3uEVU4eeGKhqyocNezU7G6ZCPQAP+Xe/A2KXg+exGiJAJi
   w==;
X-CSE-ConnectionGUID: S89anMysTCanBa2wtpjBwQ==
X-CSE-MsgGUID: Y89dUxDvSnOaJRn9hEf96Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="46847195"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="46847195"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 17:06:09 -0700
X-CSE-ConnectionGUID: pmdnLPlgSz2UO/gu3s9YrA==
X-CSE-MsgGUID: cwv28y9ORqiaqiWelLT3ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="172099996"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa008.fm.intel.com with ESMTP; 03 Sep 2025 17:06:09 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Remove EPB related changes
Date: Wed,  3 Sep 2025 17:06:07 -0700
Message-ID: <20250904000608.260817-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_pstate driver does not enable HWP mode when CPUID.06H:EAX[10]
is not set, indicating that EPP (Energy Performance Preference) is not
supported by the hardware.

When EPP is unavailable, the system falls back to using EPB (Energy
Performance Bias) if the feature is supported. However, since the
intel_pstate driver will not enable HWP in this scenario, any EPB-related
code becomes unreachable and irrelevant. Remove the EPB handling code
paths simplifying the driver logic and reducing code size.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 49 +++-------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f366d35c5840..c28454b16723 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -620,24 +620,9 @@ static int min_perf_pct_min(void)
 		(cpu->pstate.min_pstate * 100 / turbo_pstate) : 0;
 }
 
-static s16 intel_pstate_get_epb(struct cpudata *cpu_data)
-{
-	u64 epb;
-	int ret;
-
-	if (!boot_cpu_has(X86_FEATURE_EPB))
-		return -ENXIO;
-
-	ret = rdmsrq_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
-	if (ret)
-		return (s16)ret;
-
-	return (s16)(epb & 0x0f);
-}
-
 static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
 {
-	s16 epp;
+	s16 epp = -EOPNOTSUPP;
 
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		/*
@@ -651,34 +636,13 @@ static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
 				return epp;
 		}
 		epp = (hwp_req_data >> 24) & 0xff;
-	} else {
-		/* When there is no EPP present, HWP uses EPB settings */
-		epp = intel_pstate_get_epb(cpu_data);
 	}
 
 	return epp;
 }
 
-static int intel_pstate_set_epb(int cpu, s16 pref)
-{
-	u64 epb;
-	int ret;
-
-	if (!boot_cpu_has(X86_FEATURE_EPB))
-		return -ENXIO;
-
-	ret = rdmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
-	if (ret)
-		return ret;
-
-	epb = (epb & ~0x0f) | pref;
-	wrmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
-
-	return 0;
-}
-
 /*
- * EPP/EPB display strings corresponding to EPP index in the
+ * EPP display strings corresponding to EPP index in the
  * energy_perf_strings[]
  *	index		String
  *-------------------------------------
@@ -782,7 +746,7 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
 					      u32 raw_epp)
 {
 	int epp = -EINVAL;
-	int ret;
+	int ret = -EOPNOTSUPP;
 
 	if (!pref_index)
 		epp = cpu_data->epp_default;
@@ -802,10 +766,6 @@ static int intel_pstate_set_energy_pref_index(struct cpudata *cpu_data,
 			return -EBUSY;
 
 		ret = intel_pstate_set_epp(cpu_data, epp);
-	} else {
-		if (epp == -EINVAL)
-			epp = (pref_index - 1) << 2;
-		ret = intel_pstate_set_epb(cpu_data->cpu, epp);
 	}
 
 	return ret;
@@ -1337,9 +1297,8 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		value &= ~GENMASK_ULL(31, 24);
 		value |= (u64)epp << 24;
-	} else {
-		intel_pstate_set_epb(cpu, epp);
 	}
+
 skip_epp:
 	WRITE_ONCE(cpu_data->hwp_req_cached, value);
 	wrmsrq_on_cpu(cpu, MSR_HWP_REQUEST, value);
-- 
2.51.0


