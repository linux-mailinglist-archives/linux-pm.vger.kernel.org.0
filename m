Return-Path: <linux-pm+bounces-9406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F149E90C33B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 07:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2531C21E06
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 05:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D95F1CAB0;
	Tue, 18 Jun 2024 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4LMZ2Fe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9017984;
	Tue, 18 Jun 2024 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689955; cv=none; b=X2BbXx7kvsyp+iEvmKmX3AGh9Dn/rDhUsQR4Mavc9l24BRkgi1eXjLpPclH91RrZ7WXmx+j0aL9lmzwa3xynbYCEYWan8AzM6R1ArKiy0F4tmstOFFGswqCMOfsQFPMAvjnYldVbkACDyD4dU717TsBca2MQLCOZJpiadRSlDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689955; c=relaxed/simple;
	bh=wt7xCVTFfKMu8aCJOlbZ/3AyuVG3qL/1z88/Rnk0WEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIghS8y//SaC4RiCmtClTqyNLPxnWxXYF9Oen0tM0MevVEPIYXMb/iJZZ84Hyo9xheaKavYn67RoCIJeuVH/WXgRC5nW+bGO1XLe6H0Yv0EEMmut7uZkJElb7KxKkqiKweWmvBO+VYXgHWpkSzu8vF3Fgk5wobqsdjZMeGk3dac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4LMZ2Fe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718689954; x=1750225954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wt7xCVTFfKMu8aCJOlbZ/3AyuVG3qL/1z88/Rnk0WEk=;
  b=l4LMZ2FeHyvPSpF3Sg+U1BO4aMPVQHSa0Ovf19SDSlG15O8AIcaLDFgI
   4yK1UmMcXiNAmPDaIyQV/oey4BVoqN1rBkXOKHMDF1dobniFQfZj6nwVx
   2aQUg81Yoe+qm37AvzBNyVV8ATFhywKeLHAlyW80lBADgCFIreULr/OSk
   vIFC7E53Xz5ZsrxP3x/eaVTy65QDDHXlyVm8IGljvKq3M3Z1docDW4x4C
   6C7O6q62YmvKKYSglJrxs5EHhomYwGRVMiLhFE1OCLX15W1CNdThNXtTn
   L7oBXmq1xA81liHim+Pf4rg81PVYtMCzpEV2n7vLIV1Gqcbq5eGMSBtks
   g==;
X-CSE-ConnectionGUID: PTk9q5YCSIi5uwD7MLrLQg==
X-CSE-MsgGUID: nbOWs0XFR3ix26EnAnsk5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15685680"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15685680"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 22:52:33 -0700
X-CSE-ConnectionGUID: glyAr8txS66BfBWnm1LLPw==
X-CSE-MsgGUID: Ps4cPlzdTei2MgpC/Xjr3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41352842"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa010.jf.intel.com with ESMTP; 17 Jun 2024 22:52:33 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Update Lunar Lake hybrid scaling factor
Date: Mon, 17 Jun 2024 22:52:21 -0700
Message-ID: <20240618055221.446108-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618055221.446108-1-srinivas.pandruvada@linux.intel.com>
References: <20240618055221.446108-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change hybrid scaling factor for Lunar Lake. Scaling factor is
1.15 for P-cores compared to E-cores.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 72d9e60369e0..32c331ee97ca 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -300,6 +300,7 @@ static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
 #define HYBRID_SCALING_FACTOR		78741
 #define HYBRID_SCALING_FACTOR_MTL	80000
+#define HYBRID_SCALING_FACTOR_LNL	86957
 
 static int hybrid_scaling_factor = HYBRID_SCALING_FACTOR;
 
@@ -3402,6 +3403,7 @@ static const struct x86_cpu_id intel_epp_default[] = {
 static const struct x86_cpu_id intel_hybrid_scaling_factor[] = {
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE, HYBRID_SCALING_FACTOR_MTL),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
 	{}
 };
 
-- 
2.44.0


