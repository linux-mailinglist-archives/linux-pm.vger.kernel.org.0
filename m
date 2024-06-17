Return-Path: <linux-pm+bounces-9296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0B090A8A5
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 10:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA911C21213
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270D190495;
	Mon, 17 Jun 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VjYLWuY2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8319048B;
	Mon, 17 Jun 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613569; cv=none; b=E1UIuB2szIslYZdCtLYY7itFZrnPX2Me3+uYxwq+LRVa3S/SsiWVH/xkWmHsFJZ7u3eKYQ0oNPimYtdfFl2vCXGs6BAbRXlY1nWSBHuECnwA5OBiEbTGe+a+iPjpV5ngY61hbod4TjxfsR2S3k2+NPmF5X+Rcfg1phyunbRqzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613569; c=relaxed/simple;
	bh=NGzawbQFzzlStBHgqNSSGSxkI34bALkZ1eerHvEGUJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUiuEemqu0nZCYXU3kQjCTxkN6wnkkEd+Sb8lsD/otJSTQ9fMOwW1YADcN/oqXx1hLK2pNJbsFBMVuSzGsQjE3IlUWoxiXdpVQC6yPW+3z9x5K850EsgWcfzNdHrgVk3jZHTnUWhMZEtQL02zUauXw3JoNO5HX30gAgR4WCfJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VjYLWuY2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 17BE340E021A;
	Mon, 17 Jun 2024 08:39:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5RvHKJP8QKWj; Mon, 17 Jun 2024 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718613560; bh=NJ7nN9pQjl1VOGiirNtVZHlQR6bnwKbT1TCjSyF+yVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjYLWuY2RN88v7bp7298JlYGMgNHxGammOKKTTvsxXINjH1T5tmDSeiLW4SA6uYvx
	 mY85sZYU4SR9U81c0IHAaD7T0tja+QKLqBZGjcQePEguTS4159vRc/RqEqzp3DmBpy
	 8+/NwW7NB50fDjdH6fWGwgHVBTPt/C+7VSDCloPb28WpUTBMEUFqT9MdQuII0BmIRa
	 NrnXX/R6dfH7lmTp0Fe4l7lpekeHOjsk+ELejQKvXlX4u3IU8SZwhJuJXLD4J457Wd
	 W/fcTfobp0CWlFJN+BnJcaXPTNYB14IDanSRSMzDkUZ4d9uO2DthPksCoBWOhdmYfN
	 8Wwdf/yUSLKH/A50jIkVXBpXESubgUTRm/wFLLswO5b2MgFo+uWCUGOw2ueQR17zhn
	 9VQW6bGXyMI4Tw4dwDEfziGpyciNHqhCGUvHr2TkTd4VdC9SALZkRk0wdpxDBc7khy
	 5SV0ufTNJRot10YkQRBF9PJRoQsqurqEMlpiuizFrpIMR6QHFIR3E02ntCr/SZI9U3
	 0Rany5gZ4i237Gt915qBv1GFP4HesryAAhx3ZBT/eRbRXClRGg3ixy3ddkHni/QjSn
	 96A5w2o6ile5YbGP0aHaiPR6aToIxJHcbiNsSZCDWA7U4HrUd84CmAinqoWowU4cmv
	 qljfIG0RAk2wpTLNTHiLvu08=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1654140E01A5;
	Mon, 17 Jun 2024 08:39:08 +0000 (UTC)
Date: Mon, 17 Jun 2024 10:39:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
Message-ID: <20240617083902.GEZm_2JjnNvHaT0Knq@fat_crate.local>
References: <cover.1718606975.git.perry.yuan@amd.com>
 <4416ff72ea5a33173b69561803f1578073baccae.1718606975.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4416ff72ea5a33173b69561803f1578073baccae.1718606975.git.perry.yuan@amd.com>

On Mon, Jun 17, 2024 at 02:59:10PM +0800, Perry Yuan wrote:
> CPUID leaf 0x80000026 advertises core types with different efficiency rankings
> 
> Bit 30 indicates the heterogeneous core topology feature, if the bit
> set, it means not all instances at the current hierarchical level have
> the same core topology.
> 
> For better utilization of feature words and help to identify core type,
> X86_FEATURE_HETERO_CORE_TOPOLOGY is added as a few scattered feature bits.
> 
> Reference:
> See the page 119 of PPR for AMD Family 19h Model 61h B1, docID 56713
> 
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/scattered.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 6c128d463a14..eceaa0df0137 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -471,6 +471,7 @@
>  #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
>  #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
>  #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
> +#define X86_FEATURE_HETERO_CORE_TOPOLOGY       (21*32+ 6) /* "" Heterogeneous Core Topology */
>  
>  /*
>   * BUG word(s)
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index c84c30188fdf..6b3477503dd0 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -52,6 +52,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> +	{ X86_FEATURE_HETERO_CORE_TOPOLOGY,     CPUID_EAX,  30, 0x80000026, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };
>  
> -- 

Nacked-by: Borislav Petkov (AMD) <bp@alien8.de>

Until all review comments have been addressed:

https://lore.kernel.org/r/20240611105216.GAZmgsYC-J_yLfdupF@fat_crate.local

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

