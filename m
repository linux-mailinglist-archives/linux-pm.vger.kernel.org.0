Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB120E01C
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgF2Umu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbgF2TOD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:14:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C92C008775;
        Mon, 29 Jun 2020 02:13:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so15824552ejq.6;
        Mon, 29 Jun 2020 02:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3y8JQhJxn3CQlaKZteqal2/97kZCmMBM7dtDyKGGv64=;
        b=tXvn0UHMgVbxGSsnrbFejJhoGstArJKYgxJ4LsZKe3InYTYQuEMZ9MfAT/5sRv+hEm
         HhxZY5Z7VK3/GF+b3p842g4dAC3oK/gzQ803sy+Lthtr2SdXgUbfTmP+y78CuKQe4mAi
         t+KwfxCMS+PfQEZJfVU4oGLRjOQJaDEYCqHlJU624iQxrlcyVPOYsB59c3O649GlWCxW
         2kMj6Ys/NjIzBbrMuy2mTA/T7yoiZlibx17cEqOhRWQCFabX45lQEtkMgoNkLMvNw5DF
         mh9f/2ArtHAWQ6nLto6KaRSfxSz2mI0ed3UaH/Bg/nmQLtjrO/y4z6WI6wpKgIl5+pTo
         NSlg==
X-Gm-Message-State: AOAM532wE7IXCRE1nmDKaP1tk3VsgjhdEaNV3Gmv3UhhhK94V8TnQ0JL
        E39KPeWhvGtCjOj6kAgeuZhDqP75
X-Google-Smtp-Source: ABdhPJyUgK9GSbdCJz/BUuE5Y9gd62uMCDp7R4PGI83oXcm73c/vzRhudmdjK8/T6BUfn6qrxsCr9g==
X-Received: by 2002:a17:906:3e84:: with SMTP id a4mr12493437ejj.372.1593422027202;
        Mon, 29 Jun 2020 02:13:47 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id f17sm28318273edj.32.2020.06.29.02.13.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 02:13:46 -0700 (PDT)
Date:   Mon, 29 Jun 2020 11:13:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/4] ARM: exynos: Apply little core workaround only under
 secure firmware
Message-ID: <20200629091343.GA16015@kozik-lap>
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CGME20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3@eucas1p1.samsung.com>
 <20200616081230.31198-2-m.szyprowski@samsung.com>
 <1f59ab26-94e8-6ee8-48f9-568cf1a0edfa@arm.com>
 <20200622171904.GA4174@kozik-lap>
 <96d7f0f2-63c0-8c8d-5a79-ba27295b389a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96d7f0f2-63c0-8c8d-5a79-ba27295b389a@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 29, 2020 at 10:54:27AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 22.06.2020 19:19, Krzysztof Kozlowski wrote:
> > On Wed, Jun 17, 2020 at 05:26:58PM +0100, Lukasz Luba wrote:
> >> I've give it a try with hotplug torture tests and has only one a minor
> >> comment.
> >>
> >> On 6/16/20 9:12 AM, Marek Szyprowski wrote:
> >>> The additional soft-reset call during little core power up was needed
> >>> to properly boot all cores on the Exynos5422-based boards with secure
> >>> firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
> >>> CPUidle driver, which worked only on boards without secure firmware
> >>> (like Peach-Pit/Pi Chromebooks).
> >>>
> >>> Apply the workaround only when board is running under secure firmware.
> >>>
> >>> Fixes: 833b 5794 e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
> > Fix the Fixes tag (in case of resend, otherwise I'll do it).
> >
> >>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>> ---
> >>>    arch/arm/mach-exynos/mcpm-exynos.c | 10 +++++++---
> >>>    1 file changed, 7 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> >>> index 9a681b421ae1..cd861c57d5ad 100644
> >>> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> >>> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> >>> @@ -26,6 +26,7 @@
> >>>    #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
> >>>    static void __iomem *ns_sram_base_addr __ro_after_init;
> >>> +static bool secure_firmware __ro_after_init;
> >>>    /*
> >>>     * The common v7_exit_coherency_flush API could not be used because of the
> >>> @@ -58,15 +59,16 @@ static void __iomem *ns_sram_base_addr __ro_after_init;
> >>>    static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
> >>>    {
> >>>    	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
> >>> +	bool state;
> >>>    	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> >>>    	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
> >>>    		cluster >= EXYNOS5420_NR_CLUSTERS)
> >>>    		return -EINVAL;
> >>> -	if (!exynos_cpu_power_state(cpunr)) {
> >>> -		exynos_cpu_power_up(cpunr);
> >>> -
> >>> +	state = exynos_cpu_power_state(cpunr);
> >>> +	exynos_cpu_power_up(cpunr);
> >> I can see that you have moved this call up, probably to avoid more
> >> 'if-else' stuff. I just wanted to notify you that this function
> >> 'exynos_cpu_powerup' is called twice when cpu is going up:
> >> 1. by the already running cpu i.e. CPU0 and the 'state' is 0 for i.e.
> >> CPU2
> >> 2. by the newly starting cpu i.e. CPU2 by running
> >> 'secondary_start_kernel' and the state is 3.
> >>
> >> In this scenario the 'exynos_cpu_power_up' will be called twice.
> >> I have checked in hotplug that this is not causing any issues, but
> >> thought maybe it's worth share it with you. Maybe you can double check
> >> in TRM that this is not causing anything.
> > This brings the old code, before 833b5794e33. I wonder why? I understood
> > that only soft-reset should be skipped.
> 
> Because otherwise the Peach boards hangs during the cpuidle. I didn't 
> analyze the code that much to judge if it is really necessary in all 
> cases, I only restored what worked initially. I can add a comment about 
> that to the commit log if needed.

Yes, please mention this in commit msg.

Best regards,
Krzysztof

