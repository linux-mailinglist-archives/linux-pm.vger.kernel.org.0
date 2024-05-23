Return-Path: <linux-pm+bounces-8092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC78CDCD7
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 00:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F336283E10
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA3126F33;
	Thu, 23 May 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUuXozQK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA7823B0;
	Thu, 23 May 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503071; cv=none; b=HSxj0tBCCtyrlb/qQ9KFomtL5ZBLADc2LVDI66uL9VFY3xgCIlgpi0R5oqo3SSwBea3G/GvRWxhuFwWpRe9ep/qUV6LwQEcW+ar5+k9QheXX8uJ14f1XXxfcQQ35GQPdCyCayHiNeFjhCnHtSuaepSfkk3SO7NNT2VyWbXv4aBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503071; c=relaxed/simple;
	bh=qvjSTZmZ1/mjUKQP4iIvyLHbx4J/qnta8BUfTpCvlog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfxHuJPxDln66EgC4ML935iJK8xvS8OOl/lzAmMV6kYteAAc+B52JLA1ydbLyLqPCe2Sb63pfzxd4NG3WUPLJ1ManAKEDub0XtIVHMdSce1d6Ch9cs71hp1z5fqk0+9fi3kJViV4/vJsAr/xBFBKt6fxoW5ePhSIrqlE+VXl51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUuXozQK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716503069; x=1748039069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qvjSTZmZ1/mjUKQP4iIvyLHbx4J/qnta8BUfTpCvlog=;
  b=IUuXozQKfWfRq2pzJn7pjJ22AAeTAlhTb1yRMWaSq9i3MhZK8DspdWVc
   W0uqqfTbtZ0Jry/BUd2jyM6CpMMpJ/Ghq/RFxdGB9NyVA1UXQr6unFYB5
   e8da36YJK6gYx2CmjYVayox/Wa8KqpVt/SaBhfRKCOo/QWcKwg0gtIbh2
   J8c5k1V+UjZctNX377/BkFFNurbleRi/QkynP7ax+vg0UvdLc9QvP3IwV
   w11i4udXIa6kyro0MFQMeYL3Av45xBl5M3QoA4JN19qCHQBBWRIlzOuCR
   iqrD7zncdb9v/KJ3oyFwuxH3AecHE3bw2MF8ZVnwHanAWjefxEHvfQoM7
   A==;
X-CSE-ConnectionGUID: gqerkGlnRie+ooZJA55kBA==
X-CSE-MsgGUID: kOdcUO9BQeOZzkaW3YwMuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12793020"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12793020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:24:29 -0700
X-CSE-ConnectionGUID: Nz/KrK75TAmGZgRqaDn3lw==
X-CSE-MsgGUID: WTYszIGbQZ6eo95wCKKvFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38271888"
Received: from jbalogun-mobl.amr.corp.intel.com (HELO desk) ([10.212.227.156])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:24:28 -0700
Date: Thu, 23 May 2024 15:24:22 -0700
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
Message-ID: <20240523222422.mezuc3qj35nix3iu@desk>
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

s/architectual/architectural/

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
                                                  ^
						  Extra space here.

