Return-Path: <linux-pm+bounces-17088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B19BF527
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 19:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837351F224D1
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43831E0DC4;
	Wed,  6 Nov 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEesobcX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E52537FF;
	Wed,  6 Nov 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917405; cv=none; b=WhGxCgwhYv5BtnhZ1Tv/l8T9Oyol5Zlzk7OE2Hru7f10A0cFqrV0JD74T11OXNsAJ1ZJq53I4XI/mzCEnY5TJjd/WT/Wy8vjQzzVuAYFoSyMOKY/fM50stvVJGWF6lbWiyj3kVG8MRrIi6CNF6m7evtVPl9VViLuHsgeqrfGWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917405; c=relaxed/simple;
	bh=N3qZZ1LRSWfjeNPXkmXAJUYnDFbJ1Sjl4uTJSoeW7Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OarPQYwSglqz/oMBo8qThXI8fDHvrTcLHz77RLb1/Rwieg9sbCdnVA5uDKaIEe5bINvsOt3fg8sRWGDEDR7skK7xa8+5tzCTF786ye78UuqQdkk63zuKDhoLOt2vC/FHsGjcsTq/TEqndoHn0jRu3BZjShsa1L4R16oyvfoNVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEesobcX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730917402; x=1762453402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N3qZZ1LRSWfjeNPXkmXAJUYnDFbJ1Sjl4uTJSoeW7Jo=;
  b=iEesobcXww3Jx4NPE2/P/q7BXi+0aqtLrTs5VhbNnuCDJbSjyclVHz3N
   5sYM1VGo20R2hKLBWI5woIstrdU/kfKCOXuntVq9iUDBVUO6s2/ZeGUwF
   CAtmFBYykDh4ihHD/kXXi5ii7DT6y/g7A7plHM8iVY/QQ+XFlA3M32PhG
   7dRD1LK0bwk70TVmA3WJykZq+0M68Ct9V36k1tywmRGZ1NDGusuHWPpho
   PsA1NJuP3YIfwgk7EOpFlKBq9O73YvZjgF9zvtuanK1X34zCQjpw+2Mj6
   RTex+54nDI8fiXsdCXV43lqGorkbMBkP0jIpC6S7z1jetQLLvn+m687qo
   A==;
X-CSE-ConnectionGUID: q0hflda7QIOIhq6Q/RaYTQ==
X-CSE-MsgGUID: BTmy13VpSfGe0vwBwLcv3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30892946"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30892946"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:23:21 -0800
X-CSE-ConnectionGUID: NTk86eyzRDaeDKqDyPE6MQ==
X-CSE-MsgGUID: b+TnazhAQbWucELKcjh2uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="115485748"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.113.164])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2024 10:23:22 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	chang.seok.bae@intel.com
Subject: [PATCH] cpufreq: Simplify MSR read on the boot CPU
Date: Wed,  6 Nov 2024 10:23:13 -0800
Message-Id: <20241106182313.165297-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e9afefb7-3c4e-48ee-aab1-2f338c4e989d@intel.com>
References: <e9afefb7-3c4e-48ee-aab1-2f338c4e989d@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the 32-bit MSR access function with a 64-bit variant to simplify
the call site, eliminating unnecessary 32-bit value manipulations.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
---
I've received feedback to use rdmsrl_on_cpu() instead of rdmsr_on_cpu()
for similar code in my feature-enabling series [1]. While auditing the
tree, I found this case as well, so here's another cleanup.

[1] https://lore.kernel.org/lkml/e9afefb7-3c4e-48ee-aab1-2f338c4e989d@intel.com/
---
 drivers/cpufreq/acpi-cpufreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0f04feb6cafa..b942cd11e179 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -73,20 +73,17 @@ static unsigned int acpi_pstate_strict;
 
 static bool boost_state(unsigned int cpu)
 {
-	u32 lo, hi;
 	u64 msr;
 
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
-		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
-		msr = lo | ((u64)hi << 32);
+		rdmsrl_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &msr);
 		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
-		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
-		msr = lo | ((u64)hi << 32);
+		rdmsrl_on_cpu(cpu, MSR_K7_HWCR, &msr);
 		return !(msr & MSR_K7_HWCR_CPB_DIS);
 	}
 	return false;
-- 
2.34.1


