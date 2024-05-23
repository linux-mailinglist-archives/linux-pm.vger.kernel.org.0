Return-Path: <linux-pm+bounces-8093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D658CDCE5
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 00:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04934B2263E
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9912837C;
	Thu, 23 May 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGbr5+uS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4C7E766;
	Thu, 23 May 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503709; cv=none; b=UE3gdNlkkiNdHN4UkwG5qTks9ucCCYnEpqhUzJ6A02T5K1wQW1GZaE2yH3bdifkQij7iddHJu9LAHWpZkcdm6iRjzoct6casEQ/xdEn6iakfJde5w3i5xOvjla9SspwCA0dtOCWMJcqmNIhlsjwXtW3OcMn7loZxFwZXcX3ob7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503709; c=relaxed/simple;
	bh=ZQptd+OO0ItLP5kvR5qOd72R0dOqNNH+K7BlscVW4Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk3THvj5JzJU36fGctzP1xX2aqY0+tSaCDb9X+UJrA7K48V3LB53LhvhckeZiwAHKibXwtQqPVZRK7Y//8duEmOG5btWRdrIksuWOuD4V4L3rs5P8Rhb61id4DajiuomotHU9ngtLa+3YYuEXxNpFvY9d+3TpsmNVDOSnrK8yiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGbr5+uS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716503708; x=1748039708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQptd+OO0ItLP5kvR5qOd72R0dOqNNH+K7BlscVW4Vw=;
  b=oGbr5+uSYAoxc22LWRgt4sXM1lSZMK7UW+4W7TCOYojFvApXFHax0F9w
   kkq5TPJNzryIl20sQ7xqWnPZkOdpConNFi86Z/tbM1S6kHxS2jzpoGi7w
   SPsYFsRuONmyWZgPB2I/mP10YFOnQCNcxMTCR/n1ZC3qC6xL4UOy2f1zn
   iCy/d5UQbC3qonOZzedj4AZgUvcPwlqyEvsvyKBpEB23Gwd+L3Oqt6/OS
   R1XMMAS0mGYas7E+pATKGPg3LpKEkI+wylu0D0awa0yr1xnWoliGtCQb+
   EYmbyGjOyNIGtCpYGZDO1t5HYFfR5n3OHSxrh+phVe4wGCW4DU9FVJX9p
   A==;
X-CSE-ConnectionGUID: 7y608XeVRO2QehalQQB9pA==
X-CSE-MsgGUID: PSsN2TLqQYu41+y0xtjPBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="35375205"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="35375205"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:35:07 -0700
X-CSE-ConnectionGUID: mZlFUw8eRuuilkVNQYWBhg==
X-CSE-MsgGUID: +amaWa7gTOC4OsjWndT2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="34311784"
Received: from jbalogun-mobl.amr.corp.intel.com (HELO desk) ([10.212.227.156])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:35:07 -0700
Date: Thu, 23 May 2024 15:35:01 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Xiaojian Du <Xiaojian.Du@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pm@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	sandipan.das@amd.com, kai.huang@intel.com, ray.huang@amd.com,
	rafael@kernel.org, Perry.Yuan@amd.com, gautham.shenoy@amd.com,
	Borislav.Petkov@amd.com, mario.limonciello@amd.com
Subject: Re: [PATCH v3 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Message-ID: <20240523223501.k2bcmvmfbvbxiuf6@desk>
References: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
 <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691ec6cf79788e6db919965f787505434b072fac.1716444920.git.Xiaojian.Du@amd.com>

On Thu, May 23, 2024 at 02:16:59PM +0800, Xiaojian Du wrote:
> From: Perry Yuan <perry.yuan@amd.com>
> 
> Some AMD Zen 4 processors support a new feature FAST CPPC which
> allows for a faster CPPC loop due to internal architectual
> enhancements. The goal of this faster loop is higher performance
> at the same power consumption.
> 
> Reference:
> See the page 99 of PPR for AMD Family 19h Model 61h rev.B1, docID 56713
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 3c7434329661..6c128d463a14 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -470,6 +470,7 @@
>  #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
> +#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
>  
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index af5aa2c754c2..9c273c231f56 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> +	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX,  15, 0x80000007, 0 },

This list is sorted by the leaf level, so position of this entry should be
higher:

diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..09e0e40dce6c 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
+	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX, 15, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },

>  	{ 0, 0, 0, 0, 0 }
>  };
>  
> -- 
> 2.34.1
> 

