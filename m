Return-Path: <linux-pm+bounces-17462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0449C6619
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 01:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD1CB24925
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BA21CFA1;
	Wed, 13 Nov 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZZuRF5I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069621CF9A;
	Wed, 13 Nov 2024 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456006; cv=none; b=rQB+kqGjiXsch2SLjeiDFdtTD3KdLiz03UcVfl7PpyvDmoHpxhK1aMvK0PNRerLp3yjn7+SVrfviZ2HO4gOv615TdDdxSfSv0Dv/UuiNWonWj/o9quTyQpMCIIc5ZpXv94ukv78kD0gC9orjXCJU9NtzcXzQ0FBM7FqcQ+nZzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456006; c=relaxed/simple;
	bh=AFbGSoCPJWHADJAVEA2b1Fwl3qKWb0vv5uWZgsOuN28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZ671t9R6TqHAnrtWPAW0uDgq2oi26yvadB9iZJ9vI/utoqBNRgNT5lMamjxabwLLiJO2ZmN94kRtBV+dCCw8PBM2b5+sQallGJmV5ePJYjtEoS8llSzhDalGa7ia6HP4f2IETKpe5ihEVT4R7m9nBpNYuXOopMVMOZ8Q7B9zOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZZuRF5I; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731456005; x=1762992005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AFbGSoCPJWHADJAVEA2b1Fwl3qKWb0vv5uWZgsOuN28=;
  b=SZZuRF5IxD8B37lXvyLIcqmvoRpIIN4hxNjx7L/qfO3JfapUflYlSlbX
   hkRF3XDiFtlXVsinnk6S1Au72i66qjD8DcNc4iAqkkWp0x1EA0YuS15BE
   KuQcQaedITUnEaEIavyD8nIiyn4yyS6F96p12ACna5c4FDIOSPejXBMZl
   yx1MDIeIvbAT72ADoTW9c1nNi/Q/PfDWgoXip9c0QPGOO8nudXl2QJd4d
   sRI/t05JcEVXWNkIjCOmsX/KK5EsteRCaQ75GRJpgs5Z9BhNnv+6geYC6
   dxqgoqfCtaCSzrjEJSgpFltDSzNbSEXQ6CiWHTTtdwc2LhqCGzn+m6Fat
   w==;
X-CSE-ConnectionGUID: gZDAz5RmS0SrliGxSRLJjg==
X-CSE-MsgGUID: 2dCCmcq1Q8q7R/m8ISOsQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18935423"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="18935423"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 16:00:04 -0800
X-CSE-ConnectionGUID: sMdS8ppXQ86/CVoXwzGAfw==
X-CSE-MsgGUID: mQqHx4tDS1uKxQ+HK9FKsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="92465814"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2024 16:00:04 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Update Balance performance EPP for Granite Rapids
Date: Tue, 12 Nov 2024 15:59:46 -0800
Message-ID: <20241112235946.368082-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update EPP default for balance_performance to 32. This will give better
performance out of box using Intel P-State powersave governor while still
offering power savings compared to performance governor.

This is in line with what has already been done for Emerald Rapids and
Sapphire Rapids.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index cd2ac1ba53d2..f1db73a52bae 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3658,6 +3658,8 @@ static const struct x86_cpu_id intel_epp_default[] = {
 	X86_MATCH_VFM(INTEL_ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
 		      179, 64, 16)),
 	X86_MATCH_VFM(INTEL_ARROWLAKE, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
-- 
2.47.0


