Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B9C3DF909
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 02:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhHDAyW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 20:54:22 -0400
Received: from ozlabs.org ([203.11.71.1]:40325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhHDAyW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 20:54:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GfYCg5V6nz9s5R;
        Wed,  4 Aug 2021 10:54:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1628038448;
        bh=ZBaaN+tHPwpLYY+UfYI00dZzEufAibCKvfz+hWbOPT8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SecjGxb4zhSK/gvdLmqKFw1IObeowXLCrXHbse9GzKj3Ujnp4pPaxQiQ2do9cGDFJ
         q79FFv5+8WEH1jFVUanj6Mob5W/7BhNZc5XS0lyBzoO06GntTYDE2+6U0gHXZNhN2s
         NNb1h4//1FAyuf7c+bgmtyT1nXF2KgY12kaetCTEzyo0wcT31T7RIXHaeMKBeH3GDA
         843YqXp8YhqEwVmxGj4YaBk9loKPGf7K2923QVx50MYuGyv4qJ4JmTTdinaNYvGLX8
         LTV0n3kjj3VKiJ3FUIqVDa3QhsRvl198z3za6WSj9CYzbtvGTEdHInVdKYawEWQuDj
         Adlu0iS1k34gA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] cpuidle: pseries: Mark pseries_idle_proble() as __init
In-Reply-To: <20210803211547.1093820-1-nathan@kernel.org>
References: <20210803211547.1093820-1-nathan@kernel.org>
Date:   Wed, 04 Aug 2021 10:54:04 +1000
Message-ID: <87lf5ini6r.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:
> After commit 7cbd631d4dec ("cpuidle: pseries: Fixup CEDE0 latency only
> for POWER10 onwards"), pseries_idle_probe() is no longer inlined when
> compiling with clang, which causes a modpost warning:
>
> WARNING: modpost: vmlinux.o(.text+0xc86a54): Section mismatch in
> reference from the function pseries_idle_probe() to the function
> .init.text:fixup_cede0_latency()
> The function pseries_idle_probe() references
> the function __init fixup_cede0_latency().
> This is often because pseries_idle_probe lacks a __init
> annotation or the annotation of fixup_cede0_latency is wrong.
>
> pseries_idle_probe() is a non-init function, which calls
> fixup_cede0_latency(), which is an init function, explaining the
> mismatch. pseries_idle_probe() is only called from
> pseries_processor_idle_init(), which is an init function, so mark
> pseries_idle_probe() as __init so there is no more warning.
>
> Fixes: 054e44ba99ae ("cpuidle: pseries: Add function to parse extended CEDE records")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/cpuidle/cpuidle-pseries.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't see this in my builds for some reason, but I guess toolchain or
config differences probably explain it.

Regardless, the patch is correct so I'll pick it up, thanks.

cheers

> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index bba449b77641..7e7ab5597d7a 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -403,7 +403,7 @@ static void __init fixup_cede0_latency(void)
>   * pseries_idle_probe()
>   * Choose state table for shared versus dedicated partition
>   */
> -static int pseries_idle_probe(void)
> +static int __init pseries_idle_probe(void)
>  {
>  
>  	if (cpuidle_disable != IDLE_NO_OVERRIDE)
>
> base-commit: a6cae77f1bc89368a4e2822afcddc45c3062d499
> -- 
> 2.33.0.rc0
