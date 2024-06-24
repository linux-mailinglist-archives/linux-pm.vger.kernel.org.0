Return-Path: <linux-pm+bounces-9901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C7915333
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E351C2286F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39219DF47;
	Mon, 24 Jun 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6Uc2Q6/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DE19D896;
	Mon, 24 Jun 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245485; cv=none; b=fABl7bJJJ7Vj20IcwylEw0l188LQaUvbzWHNMjY83BrRng2GrtqyUz3r0Kf7nZ8mEEGXzXgu5HZUxPD6+gxzUg3dsXjHD1IT2K4yltGL/tO7FNy1Dzg3ETOf5k5SgDbV37Kte1Z/4nl11l3Y+LCl+LwYUwCWOGbm5xIOR4us2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245485; c=relaxed/simple;
	bh=cXRsgCVXUUj3FzRs1EdGSN3ic6K6LQL4rj8URPH90gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSYHyKx5MQM2ObjD7l04pAVSeX3FMBDbs+2V9AZejpuDuXy7rN4CYNBun9uUobu2ryKR5cMRyehsJOuUXlU2huuzpYj1ZTznJjpeTyRCXahXbubYHWToID8yoO9Jr9YhyJ4hllv7EtIbVtedzFOVK0M/kx+v+6iCrIlRJkNpvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6Uc2Q6/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719245484; x=1750781484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cXRsgCVXUUj3FzRs1EdGSN3ic6K6LQL4rj8URPH90gk=;
  b=l6Uc2Q6/761QuP69Jx9C6HuzWtGC6TsQcc0m4ANnfcUpUoYWdXx5Ln9t
   R6UorVtMMtU16nUe9spzeoy0gX78DKIa4gYCso9ddTWKT7Mz08t357wAk
   ASdEg18CBs5vgVc9/7t/fPRWXEcmkCbHqDYVAKO2t6ZomQYIwdoYt+0I4
   tzGUWMXlnLTTzzpc+Y/AJn0QpLhXsTs1Vu01YOmUAMQWIRU57eMKEhYLU
   RyuO9gcIUUViaQlDACD/cZ6xfoQ0ABPicuwiq4YsTYD7H7j/2ZCVRH99T
   cLK/0JwrVhHIRyZF0blV0YaxYF+pRkd4UK1VUsfBJOzl0n0BsqiP4thDY
   A==;
X-CSE-ConnectionGUID: g0tCbCO2TxCEh4ugp6rKAw==
X-CSE-MsgGUID: Hbgxz8RVTqOf86hQW2lwvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12218608"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="12218608"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:11:12 -0700
X-CSE-ConnectionGUID: 6vYcOs9jSw+6HK2cw48drg==
X-CSE-MsgGUID: CRCBQnPZTD6zeEcETIe4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="44012674"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa007.jf.intel.com with ESMTP; 24 Jun 2024 09:11:13 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] x86/cpufeatures: Add HWP highest perf change feature flag
Date: Mon, 24 Jun 2024 09:11:08 -0700
Message-ID: <20240624161109.1427640-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
References: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CPUID[6].EAX[15] is set to 1, this CPU supports notification for
HWP (Hardware P-states) highest performance change.

Add a feature flag to check if the CPU supports HWP highest performance
change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Prevent display in /proc/cpuinfo flags as suggested by Borris

 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..4cf929c457bb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -361,6 +361,7 @@
 #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
 #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
 #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
+#define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* "" HWP Highest perf change */
 #define X86_FEATURE_HFI			(14*32+19) /* Hardware Feedback Interface */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
-- 
2.40.1


