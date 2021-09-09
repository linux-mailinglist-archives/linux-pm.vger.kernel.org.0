Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A71405C6D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbhIIR7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 13:59:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237205AbhIIR7n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 13:59:43 -0400
Received: from zn.tnic (p200300ec2f0e45009795463d03f535a2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4500:9795:463d:3f5:35a2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48C2A1EC04D6;
        Thu,  9 Sep 2021 19:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631210308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAQ32i/uilW2AnN+2fKp4zP0VR9Mk/umGQrt9CT52ew=;
        b=JGKcL1wEwc2cxYXvu+M/NENv4Yz2GKdaToYJeE4yFTiJeIcfkNewGXeZchxnuON6ZZ8FT0
        soQu/nDGee05dSCkX754alY3Z+y8jp+DNJTSa4o0LpTQ0Un8v7RcU6G6Ud1gCMePqOw726
        /uEIBYsZXjcZ6Vzy+l6VSme7/c4nHxg=
Date:   Thu, 9 Sep 2021 19:58:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 01/19] x86/cpufreatures: add AMD CPPC extension feature
 flag
Message-ID: <YTpLO6M2C0IqJ9XC@zn.tnic>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-2-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210908150001.3702552-2-ray.huang@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 08, 2021 at 10:59:43PM +0800, Huang Rui wrote:
> Add Collaborative Processor Performance Control Extension feature flag
> for AMD processors.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d0ce5cfd3ac1..f7aea50e3371 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -313,6 +313,7 @@
>  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
>  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_CPPC_EXT	(13*32+27) /* Collaborative Processor Performance Control Extension */

Why not simply X86_FEATURE_AMD_CPPC ?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
