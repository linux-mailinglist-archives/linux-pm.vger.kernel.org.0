Return-Path: <linux-pm+bounces-14946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CED98A7A8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6956C1F23D7A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8B194AD1;
	Mon, 30 Sep 2024 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHRHdPmF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5B19408B;
	Mon, 30 Sep 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707667; cv=none; b=j7trrSWtDghZdRravFEHoSTsePlwuLqyP4NSYI2Z6/YigByauuqk286U+OYiWzPEZQzy3iP88rDK1/ZDpS4vpFs3cn1h039Kbb5FQrcwvV4bSGj3ceYf4k/pEp8kN3CMhVGZI+zU8hGBWUkPCkWqXjhOznMljcNt8U0PumW5I1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707667; c=relaxed/simple;
	bh=V23pI7XlhviW2A8a02uvxkE0YvRgDgFLL75aIgLJCf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrnXfTBCNw2AjClqCSRM4DGuwqBX1jOI9b8aOJyn2NyEa5NYYmTov9LeMJ6Rmf176i9rtLptDv/gGfQt/2VjB7mKrokR4Qb4pPsquTr7b8vFtrsZhwjTkAujkMHvBA3agfDMtD7KFh85rZs6RNmi+L6T9M3ywH1CcBNXssEWl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHRHdPmF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707666; x=1759243666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V23pI7XlhviW2A8a02uvxkE0YvRgDgFLL75aIgLJCf4=;
  b=PHRHdPmF/YcKSdUHp5vwb06MvLaViFB6MjbWbZQK4l5MrWEA4TVzr2CP
   VbZIrdaFFEnKWu+7u0oDxQgfIT52Mi9p4MBCrzIorV8EE3zushDeMeqN0
   9beO3XJbWWErkFrM3LC3aw3rC70ukRFgnk0NRQHgEwjka8eIY3DbjRzXq
   Ur1T3vN+dHqMAEN7clFo7BOoJP221vN/NM/S6fNggbHc9y5pAJRwH9GNr
   K6+cG/3MdIX6dTNH+KA+YTuV3PWU3YARFDfD8pshb5U8BkBpznHcUd754
   qpNcjebe0Hi0bjOb7dwWAv6XiMwOmcztE7OrQvCSiRHUcf40oFtp0uDFN
   w==;
X-CSE-ConnectionGUID: XF4pClrjSsyD3wbFvc4uHg==
X-CSE-MsgGUID: Kap6bwqmSvCUZ3js+7kn/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="38187368"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="38187368"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:45 -0700
X-CSE-ConnectionGUID: PozQ5gHtR7a6Wf1BDdtZkg==
X-CSE-MsgGUID: AoqZgpNeSU+HXkPnqfNOTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72996091"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:44 -0700
Date: Mon, 30 Sep 2024 07:47:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v4 05/10] x86/cpu: Remove get_this_hybrid_cpu_type()
Message-ID: <20240930-add-cpu-type-v4-5-104892b7ab5f@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>

Because calls to get_this_hybrid_cpu_type() were replaced by
topology_hw_cpu_type().

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu.h  |  6 ------
 arch/x86/kernel/cpu/intel.c | 16 ----------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 2244dd86066a..c53a98751a92 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -31,7 +31,6 @@ extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
-u8 get_this_hybrid_cpu_type(void);
 u32 intel_native_model_id(struct cpuinfo_x86 *c);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
@@ -47,11 +46,6 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 
 static inline void handle_bus_lock(struct pt_regs *regs) {}
 
-static inline u8 get_this_hybrid_cpu_type(void)
-{
-	return 0;
-}
-
 static u32 intel_native_model_id(struct cpuinfo_x86 *c)
 {
 	return 0;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e56401c5c050..4536206e6b3c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1284,22 +1284,6 @@ void __init sld_setup(struct cpuinfo_x86 *c)
 	sld_state_show();
 }
 
-#define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
-
-/**
- * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
- *
- * Returns the CPU type [31:24] (i.e., Atom or Core) of a CPU in
- * a hybrid processor. If the processor is not hybrid, returns 0.
- */
-u8 get_this_hybrid_cpu_type(void)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return 0;
-
-	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
-}
-
 u32 intel_native_model_id(struct cpuinfo_x86 *c)
 {
 	return c->topo.intel_core_native_model_id;

-- 
2.34.1



