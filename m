Return-Path: <linux-pm+bounces-10148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C338E91B0BE
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E201286F09
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEC31A01DA;
	Thu, 27 Jun 2024 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+PqMDbz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2C1A01CE;
	Thu, 27 Jun 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521068; cv=none; b=b39De0OlF3uqJ7VNwCgLNhN1zNF/yiMA0mgMGnwF8gidgi+PuJJ062dma3dpXIK3Erp6KsW27u5oQX+zw/hghjQQ8PnuTYT5Y5fUac2Wnv1paa55HxVSe5TgWUGtVFW34Pde4K+ENpEO12QIQzkALI1i1fJpeR+SBT0TDxqPuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521068; c=relaxed/simple;
	bh=L2IcI1EjQZtbklruJIn6Yv5Q4rHmaf70lTCCFIPHBrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyeZ6tUeJGL+6ceA9RhEpdUiGc7PzH1RY3Px5zsrzlWaG0fgUNzcnU0lbIBP9+sNA/6T1/Z+nKloZf89hCBrZ2W+lsLEirfmUA+aYF4RIXu6QtQ3NXR3yoeom2gAyg3LEJmRewj3HhAJk6QyQJilQRfG0UIUSA0KmGV46BuJXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+PqMDbz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719521067; x=1751057067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L2IcI1EjQZtbklruJIn6Yv5Q4rHmaf70lTCCFIPHBrc=;
  b=I+PqMDbzEawNTZtVTpbjdX3ZD2rmOhY+l7Oow4M4EU6dFfQsf1f9v0Ck
   yfiPgzfs6mso74YNzMU+RHlDvhGCafR4qXxyxSRPt4gvYRFxGR3YTEyQC
   b+AX42qmIKUFqeVD1Wj7Ztg2vlASp3IwrMLzCJrV7eQmuc/ajfiZB7cqM
   TPgMGCT8QMqAAtKLMeLC5DV4HyNigge2nrciAd8vKnybnxTTOMBUAK1p6
   zUoPJVSmn0mzkBdqi8Im049FPAOPMJWHI1B4URIHMBDoNeRlW6c95esoz
   SZZ8BFHsFPgk7TH5zhgfymk/+XrsyIKTiC9WGLn+QmDmVhTke5oxXv7IB
   A==;
X-CSE-ConnectionGUID: JdQOqN8tTgGAazTcBX7J/g==
X-CSE-MsgGUID: UvCGxU1XSZaS8amOi1Cp1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27816240"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="27816240"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:25 -0700
X-CSE-ConnectionGUID: F/n3hlJAQISAj+eHodAlgQ==
X-CSE-MsgGUID: LhH9NVjVQSu21ZtcFuHqRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44913369"
Received: from gbpfeiff-mobl.amr.corp.intel.com (HELO desk) ([10.255.229.132])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:44:26 -0700
Date: Thu, 27 Jun 2024 13:44:24 -0700
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
Subject: [PATCH PATCH v2 4/9] x86/cpu: Remove get_this_hybrid_cpu_type()
Message-ID: <20240627-add-cpu-type-v2-4-f927bde83ad0@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>

get_this_hybrid_cpu_type() is replaced by topology_hw_cpu_type(). There are
no more callers, remove it.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu.h  |  6 ------
 arch/x86/kernel/cpu/intel.c | 16 ----------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index aa30fd8cad7f..20e491c22b98 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -31,7 +31,6 @@ extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
-u8 get_this_hybrid_cpu_type(void);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -45,11 +44,6 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 }
 
 static inline void handle_bus_lock(struct pt_regs *regs) {}
-
-static inline u8 get_this_hybrid_cpu_type(void)
-{
-	return 0;
-}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fdf3489d92a4..ac6c68a39051 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1335,19 +1335,3 @@ void __init sld_setup(struct cpuinfo_x86 *c)
 	sld_state_setup();
 	sld_state_show();
 }
-
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

-- 
2.34.1



