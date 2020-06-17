Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76331FD210
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 18:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgFQQ1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 12:27:04 -0400
Received: from foss.arm.com ([217.140.110.172]:60326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgFQQ1D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 12:27:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C2A1045;
        Wed, 17 Jun 2020 09:27:02 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BF103F71F;
        Wed, 17 Jun 2020 09:27:00 -0700 (PDT)
Subject: Re: [PATCH 1/4] ARM: exynos: Apply little core workaround only under
 secure firmware
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
 <CGME20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3@eucas1p1.samsung.com>
 <20200616081230.31198-2-m.szyprowski@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1f59ab26-94e8-6ee8-48f9-568cf1a0edfa@arm.com>
Date:   Wed, 17 Jun 2020 17:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200616081230.31198-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

I've give it a try with hotplug torture tests and has only one a minor
comment.

On 6/16/20 9:12 AM, Marek Szyprowski wrote:
> The additional soft-reset call during little core power up was needed
> to properly boot all cores on the Exynos5422-based boards with secure
> firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
> CPUidle driver, which worked only on boards without secure firmware
> (like Peach-Pit/Pi Chromebooks).
> 
> Apply the workaround only when board is running under secure firmware.
> 
> Fixes: 833b 5794 e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   arch/arm/mach-exynos/mcpm-exynos.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 9a681b421ae1..cd861c57d5ad 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -26,6 +26,7 @@
>   #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
>   
>   static void __iomem *ns_sram_base_addr __ro_after_init;
> +static bool secure_firmware __ro_after_init;
>   
>   /*
>    * The common v7_exit_coherency_flush API could not be used because of the
> @@ -58,15 +59,16 @@ static void __iomem *ns_sram_base_addr __ro_after_init;
>   static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>   {
>   	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
> +	bool state;
>   
>   	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>   	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>   		cluster >= EXYNOS5420_NR_CLUSTERS)
>   		return -EINVAL;
>   
> -	if (!exynos_cpu_power_state(cpunr)) {
> -		exynos_cpu_power_up(cpunr);
> -
> +	state = exynos_cpu_power_state(cpunr);
> +	exynos_cpu_power_up(cpunr);

I can see that you have moved this call up, probably to avoid more
'if-else' stuff. I just wanted to notify you that this function
'exynos_cpu_powerup' is called twice when cpu is going up:
1. by the already running cpu i.e. CPU0 and the 'state' is 0 for i.e.
CPU2
2. by the newly starting cpu i.e. CPU2 by running
'secondary_start_kernel' and the state is 3.

In this scenario the 'exynos_cpu_power_up' will be called twice.
I have checked in hotplug that this is not causing any issues, but
thought maybe it's worth share it with you. Maybe you can double check
in TRM that this is not causing anything.

> +	if (!state && secure_firmware) {
>   		/*
>   		 * This assumes the cluster number of the big cores(Cortex A15)
>   		 * is 0 and the Little cores(Cortex A7) is 1.
> @@ -258,6 +260,8 @@ static int __init exynos_mcpm_init(void)
>   		return -ENOMEM;
>   	}
>   
> +	secure_firmware = exynos_secure_firmware_available();
> +
>   	/*
>   	 * To increase the stability of KFC reset we need to program
>   	 * the PMU SPARE3 register
> 

Other than that, the patch set looks good to me.

Regards,
Lukasz
