Return-Path: <linux-pm+bounces-12293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD0954063
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2869A1C22B1C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BE13FD8C;
	Fri, 16 Aug 2024 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRxrmRpl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5D78C73;
	Fri, 16 Aug 2024 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781202; cv=none; b=WS5FJooPhO8mwa50BZTJJKKGT5yLK1SIQtvqVSmaQZpKkOrG9TYikzjz7K74sSukbNuxnL4sp0E6X8fTd5Sk7NgMh0VPtszr1Jn+r6W82yj74mFV3PfdlhsqkTfqWHQQBjiKQ+m7fnSflyz1O+/YKsZzmxe1ZEWFqudxuNovUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781202; c=relaxed/simple;
	bh=gXed3CM4au/pZEiN4zH4SDAKAVR50p0fuE+ekmc0NyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3T7+staO9Mtn6WPDGh/M2RZtC5max3rn9yVsh3Z3a3I+HZw+34SfdHKyJxBPwcyHMijzOGqdbf1eg0T15bQLTGk+72sZqExrmgG+yk4Uw3l5/72rO3eXWkriurCZcbRenvwjXKCN72VQ2xVfOQ1KgQ2TTWERvwq7cvGHQ0npnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRxrmRpl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781201; x=1755317201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gXed3CM4au/pZEiN4zH4SDAKAVR50p0fuE+ekmc0NyA=;
  b=hRxrmRpls2fG1ZCDNCUorP93qJ90lR0L+mW06B6tp4h25uQ7+cp5Z6Vj
   aGizFS16cE6G8mMFiAFOXOKeNGyZRSlPGgovVZ48xPpj5K1KBbe3LFxQr
   eesHzDtaWjb8UjjR32kUSVZXdUwXW2Sv+LNMObAQ83d0ZXpFnX5mdhiiB
   oaaprNBftRzAfwx1yK4Iste/VS2mlwLffP8jVgH3hr6QeS6j3xWL/0yBI
   MWza7it/fAQP1VGxF3bG1rUOq/ye88NSgGpVr9lcOAaskdlGk4JXs4M4e
   uJof7kqDKqmYpawsKINR81kuTQXA8DOtIrS/7yPiSxvOE+0IsAjpWGbLF
   g==;
X-CSE-ConnectionGUID: Ipb+e69lT+eHBInNI41oDg==
X-CSE-MsgGUID: HIuQ7mcCTpGFmOlBDAapzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33220568"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="33220568"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:40 -0700
X-CSE-ConnectionGUID: 2WDiU3UITiO7sMc0Sl3Aow==
X-CSE-MsgGUID: zaJO10m+T96AWjbuc9JH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59718282"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:39 -0700
Date: Thu, 15 Aug 2024 21:06:39 -0700
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
Subject: [PATCH v3 05/10] x86/cpu: Remove get_this_hybrid_cpu_type()
Message-ID: <20240815-add-cpu-type-v3-5-234162352057@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>

Because calls to get_this_hybrid_cpu_type() were replaced by
topology_hw_cpu_type().

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu.h  |  6 ------
 arch/x86/kernel/cpu/intel.c | 16 ----------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index f480c36a07b7..026151d9da50 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -31,7 +31,6 @@ extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
-u8 get_this_hybrid_cpu_type(void);
 u32 intel_hw_native_model_id(struct cpuinfo_x86 *c);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
@@ -47,11 +46,6 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 
 static inline void handle_bus_lock(struct pt_regs *regs) {}
 
-static inline u8 get_this_hybrid_cpu_type(void)
-{
-	return 0;
-}
-
 static u32 intel_hw_native_model_id(struct cpuinfo_x86 *c)
 {
 	return 0;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e47a53280369..eba7a93f4bdf 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1282,22 +1282,6 @@ void __init sld_setup(struct cpuinfo_x86 *c)
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
 u32 intel_hw_native_model_id(struct cpuinfo_x86 *c)
 {
 	return c->topo.intel_core_native_model_id;

-- 
2.34.1



