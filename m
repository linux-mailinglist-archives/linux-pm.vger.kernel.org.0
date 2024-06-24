Return-Path: <linux-pm+bounces-9910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE99155A6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 19:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF621C22884
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C519F485;
	Mon, 24 Jun 2024 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jvgWuTqF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00319F460;
	Mon, 24 Jun 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251165; cv=none; b=MMOhrKmXugZh3mHgoyRT6Vt6Dwk5uDnAdfivksF0fjLeHppIIS+ExXJsl8ASvQTiV2gzrv3BEz9gyRZjQ96TCQhllSkRxzjyRFEv+1LVjyASUPoH20A8yXws+AzaiKS9iylEgYABe5/x6zFVw4h34cdyxC1pMiVf/6dNMGao/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251165; c=relaxed/simple;
	bh=wnlrNGQMlnKCxKZZnq/IoYFHt1i1ApodOFEfFtEwzfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqA1BNI6b+Nfz0MzT2UBITWE5RWKPORUd+saXLaY5ZmlWOESI/Z0UDsxUpHe4RPP6wZLkyLKcKm2XDJK2li+1jkNNeDiP+FS6lW4oiXXpVNq5qcSdgxBcgLq360vrzCEBrp3GfVegXNycGC8HK+zI5X4r4Up7dPYiGF/XSyaH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jvgWuTqF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 935CC40E021A;
	Mon, 24 Jun 2024 17:45:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bo3Cj6EJxago; Mon, 24 Jun 2024 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719251155; bh=A0FFsYhCpP+dP8qHNI+qcpY3a4kmsg7NF0TjBowZK7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvgWuTqFvY7DjYES3a6Zf3ZF36tLbjE9NPe9k+mJbSYNSOBYLFsdIP52otr/3cYCx
	 wFvrinVOx3Ilr2BO9JK3a4y9/faHvtKdRS2bZ6jLaa21Is1b3yW/5drp7jci9o/YnK
	 mguqzUX4QMtA4RsYIcs1gSux4I04qmiFme4UI4jR7MVh2tvr1GxiXdaGVXiP2QZvI+
	 WK0NuMbRGYPi/SmfNJoU3X89V568QC/DEF+b9EepCGUtpxMFb7alzO63LzHreMjAfu
	 WwxXZ0YJof2QdxZxmayEezgVne6WVZgN/UERWm5nBfpKybeTb1RKd8860+OS85zbGi
	 e2RP+rq22uPvA6FwCshntsPU4tF/QQnt9RfOBfrs6PgJBd7E4db+rvlmFVwyGEWzOZ
	 U+reCMjqcLv5Ut0AkJ65hkemyhQYKZ7BwOgtlTWk/1Upl2UBlnsXCMIuyzktj51+kX
	 kHAmSeT4ib1VtbuAUXYelm3m8ThyUGfNlJYDjDa6CvmHlPwXvE24O+uWHF26OkdnRi
	 HDKTmFTj6YabZr6uZ6egaOurRcWqmdF559PJn1creKmAnHopvGr56pSkxN1nqpJnTL
	 bPmsfDBis9Ljh87jEXs9+WXs6Z50gIAr52JQQc21OkT34FW+ab9QVzkEfeijpO/zfZ
	 hARq6BQlb+svA1tluOQP5LNg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F54F40E01D6;
	Mon, 24 Jun 2024 17:45:45 +0000 (UTC)
Date: Mon, 24 Jun 2024 19:45:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpufeatures: Add HWP highest perf change
 feature flag
Message-ID: <20240624174538.GGZnmwwt3K_J-FtpJA@fat_crate.local>
References: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
 <20240624161109.1427640-2-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240624161109.1427640-2-srinivas.pandruvada@linux.intel.com>

On Mon, Jun 24, 2024 at 09:11:08AM -0700, Srinivas Pandruvada wrote:
> When CPUID[6].EAX[15] is set to 1, this CPU supports notification for
> HWP (Hardware P-states) highest performance change.
> 
> Add a feature flag to check if the CPU supports HWP highest performance
> change.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Prevent display in /proc/cpuinfo flags as suggested by Borris
> 
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 3c7434329661..4cf929c457bb 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -361,6 +361,7 @@
>  #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
>  #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
>  #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
> +#define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* "" HWP Highest perf change */

Yeah, in the meantime I made it even simpler:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cpu&id=78ce84b9e0a54a0c91a7449f321c1f852c0cd3fc

so in case you have to send your patch again, you can drop the "" too.

New flags are not exposed in /proc/cpuinfo by default after the above change.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

