Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF49B203DB0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgFVRTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 13:19:11 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:33561 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgFVRTK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 13:19:10 -0400
Received: by mail-ej1-f66.google.com with SMTP id n24so18829510ejd.0;
        Mon, 22 Jun 2020 10:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ln85lt/Tkp1vKFWqTv00g+4W/YsS086NIYrAVE4JpT0=;
        b=hIiFE6qtZzcpkqtZynPzaG+YpFGyXDX4bz4jwnWl6Wm2jqIc6wAGfwAWs4VgDAdQDW
         5W6zVTF4teJzH7/grIz43MQA/BTRH+MBbAppSQ5+qf6nbJa9A7DwO+TK/Q0/ejrncItx
         x4KOV2cPhdvw5i5w5aQFNhddZzcICsoEaliBer9RPmhgoj4KhhEtF/3XFDk2vyXdiEGM
         RayYsTtW10B450veEHMOmEiI+F6UEmRfpoav02Ouaab8LOIyRlSXG7/6CN/iQUsocN3m
         FUMn48SU7PftBYvBC+Ywr+6oVvAjIb55ULg+6aZf/K02n2hFGbUFOdZsNQ2Y0ehqRaLx
         qs+A==
X-Gm-Message-State: AOAM532xxhb5x06oZQ7z+KVku9/WI5cPaL7uqDtFKKPLZvbRXfXtP0ft
        i3oL+OCbS8pFaF+LfpNbbxw=
X-Google-Smtp-Source: ABdhPJyKgq8iRpzKLQo5IV3+fqcBuikBkINfz718scwpI9EXxdN7s66bem51nkTf+pp3l+ytbFDS5A==
X-Received: by 2002:a17:906:1c4b:: with SMTP id l11mr6340914ejg.307.1592846348168;
        Mon, 22 Jun 2020 10:19:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.235])
        by smtp.googlemail.com with ESMTPSA id y2sm12128925ejj.103.2020.06.22.10.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 10:19:07 -0700 (PDT)
Date:   Mon, 22 Jun 2020 19:19:04 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/4] ARM: exynos: Apply little core workaround only under
 secure firmware
Message-ID: <20200622171904.GA4174@kozik-lap>
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CGME20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3@eucas1p1.samsung.com>
 <20200616081230.31198-2-m.szyprowski@samsung.com>
 <1f59ab26-94e8-6ee8-48f9-568cf1a0edfa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f59ab26-94e8-6ee8-48f9-568cf1a0edfa@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 17, 2020 at 05:26:58PM +0100, Lukasz Luba wrote:
> Hi Marek,
> 
> I've give it a try with hotplug torture tests and has only one a minor
> comment.
> 
> On 6/16/20 9:12 AM, Marek Szyprowski wrote:
> > The additional soft-reset call during little core power up was needed
> > to properly boot all cores on the Exynos5422-based boards with secure
> > firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
> > CPUidle driver, which worked only on boards without secure firmware
> > (like Peach-Pit/Pi Chromebooks).
> > 
> > Apply the workaround only when board is running under secure firmware.
> > 
> > Fixes: 833b 5794 e330 ("ARM: EXYNOS: reset Little cores when cpu is up")

Fix the Fixes tag (in case of resend, otherwise I'll do it).

> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >   arch/arm/mach-exynos/mcpm-exynos.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> > index 9a681b421ae1..cd861c57d5ad 100644
> > --- a/arch/arm/mach-exynos/mcpm-exynos.c
> > +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> > @@ -26,6 +26,7 @@
> >   #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
> >   static void __iomem *ns_sram_base_addr __ro_after_init;
> > +static bool secure_firmware __ro_after_init;
> >   /*
> >    * The common v7_exit_coherency_flush API could not be used because of the
> > @@ -58,15 +59,16 @@ static void __iomem *ns_sram_base_addr __ro_after_init;
> >   static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
> >   {
> >   	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
> > +	bool state;
> >   	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> >   	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
> >   		cluster >= EXYNOS5420_NR_CLUSTERS)
> >   		return -EINVAL;
> > -	if (!exynos_cpu_power_state(cpunr)) {
> > -		exynos_cpu_power_up(cpunr);
> > -
> > +	state = exynos_cpu_power_state(cpunr);
> > +	exynos_cpu_power_up(cpunr);
> 
> I can see that you have moved this call up, probably to avoid more
> 'if-else' stuff. I just wanted to notify you that this function
> 'exynos_cpu_powerup' is called twice when cpu is going up:
> 1. by the already running cpu i.e. CPU0 and the 'state' is 0 for i.e.
> CPU2
> 2. by the newly starting cpu i.e. CPU2 by running
> 'secondary_start_kernel' and the state is 3.
> 
> In this scenario the 'exynos_cpu_power_up' will be called twice.
> I have checked in hotplug that this is not causing any issues, but
> thought maybe it's worth share it with you. Maybe you can double check
> in TRM that this is not causing anything.

This brings the old code, before 833b5794e33. I wonder why? I understood
that only soft-reset should be skipped.

Best regards,
Krzysztof
