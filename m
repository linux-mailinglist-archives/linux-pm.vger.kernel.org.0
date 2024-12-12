Return-Path: <linux-pm+bounces-19092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912219EDFA9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1390188B42B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB28204F8D;
	Thu, 12 Dec 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdZ9+RXq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C3205513;
	Thu, 12 Dec 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986664; cv=none; b=b4ujXErr3BeVK8wB3BI/wvKdw/G751DTkqUR4G+Z4e/gtasuYhLz09Lh5ntxUToCBLGliPUhNC4/nqlDlYL/sjwzaW35fWv/fW1JT951pbc8HX6w1lb1ctnIa30gufHjbBhtRlC97L6I+ITmtbndHE4Bvv7TlydT7M56sXDAutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986664; c=relaxed/simple;
	bh=0ZzOq2V4e+YFlxsyQdyiOKg5eryGrazxHADgZpLlQZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1oOeh2cp6RcHw8MW5daD2qUoKdM93ybRZVW8YyhiboGVbI9TV0R3fAliP7FikB0gj6ZWNYwWKbCqDGDrkuLRqaZXXvv1Z9vJXKFLEYRZXPrrEPywdVoH02M4K4IA15JkESZEjoKf2fWs6RuOZKIs2+HNQWsv8dHjlOqIj212FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdZ9+RXq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986663; x=1765522663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ZzOq2V4e+YFlxsyQdyiOKg5eryGrazxHADgZpLlQZY=;
  b=SdZ9+RXqImyPZ47Fyylv3uJhrQn+DhP7lSGfJay+jUagYB0V60bp76lN
   ldEYetEmnFwaXNsow8H6RsdQK+uXS+tMEMbYot2Yf2iaECMUqkr5fcjf7
   h5bycjshpwUXqfoH/7k5zNTy3WU02xIpIJ85b1CS1lkTqbXqzHqvZOIHu
   ugmpHb9OsIFLFtBt5K3lBFd0xVC9/ugKjr1RBpWuu35TRYeO/eEO0uJNh
   Uw9s8pyzgq1aKdMtMNPwdqnVSN+NLG1NmCjHBpgABrg7BpCP64o22pSgS
   xnZfRYg4If5Tx84P0Ysyf7d22PO3wLFXcANMduqt15IumqAlfHvlz+HnC
   A==;
X-CSE-ConnectionGUID: 5tlB9qHyT6Sz/ARp8I45eQ==
X-CSE-MsgGUID: Ymqo3dDZQPqnAMOmTpBWcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34533443"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34533443"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:43 -0800
X-CSE-ConnectionGUID: XtP5uTU3RgiQDUa0Afba8Q==
X-CSE-MsgGUID: Br6hWtE3SsOQdWdjiLZJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96223529"
Received: from unknown (HELO desk) ([10.125.145.3])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:42 -0800
Date: Wed, 11 Dec 2024 22:57:41 -0800
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
Subject: [PATCH v5 4/9] x86/cpu: Remove get_this_hybrid_cpu_*()
Message-ID: <20241211-add-cpu-type-v5-4-2ae010f50370@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>

Because calls to get_this_hybrid_cpu_type() and
get_this_hybrid_cpu_native_id() are not required now. cpu-type and
native-model-id are cached at boot in per-cpu struct cpuinfo_topology.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu.h  | 14 --------------
 arch/x86/kernel/cpu/intel.c | 31 -------------------------------
 2 files changed, 45 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 98eced5084ca..0c8ec62789a1 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -50,20 +50,6 @@ static inline void split_lock_init(void) {}
 static inline void bus_lock_init(void) {}
 #endif
 
-#ifdef CONFIG_CPU_SUP_INTEL
-u8 get_this_hybrid_cpu_type(void);
-u32 get_this_hybrid_cpu_native_id(void);
-#else
-static inline u8 get_this_hybrid_cpu_type(void)
-{
-	return 0;
-}
-
-static inline u32 get_this_hybrid_cpu_native_id(void)
-{
-	return 0;
-}
-#endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
 #else
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d1de300af173..adb34184c74a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -876,34 +876,3 @@ static const struct cpu_dev intel_cpu_dev = {
 };
 
 cpu_dev_register(intel_cpu_dev);
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
-
-/**
- * get_this_hybrid_cpu_native_id() - Get the native id of this hybrid CPU
- *
- * Returns the uarch native ID [23:0] of a CPU in a hybrid processor.
- * If the processor is not hybrid, returns 0.
- */
-u32 get_this_hybrid_cpu_native_id(void)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return 0;
-
-	return cpuid_eax(0x0000001a) &
-	       (BIT_ULL(X86_HYBRID_CPU_TYPE_ID_SHIFT) - 1);
-}

-- 
2.34.1



