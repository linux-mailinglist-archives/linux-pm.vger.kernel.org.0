Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD2312D35
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBHJZr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 04:25:47 -0500
Received: from foss.arm.com ([217.140.110.172]:58852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhBHJXt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Feb 2021 04:23:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B1221FB;
        Mon,  8 Feb 2021 01:23:02 -0800 (PST)
Received: from [10.57.5.103] (unknown [10.57.5.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0563F719;
        Mon,  8 Feb 2021 01:23:00 -0800 (PST)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Correct function names
 in kerneldoc
To:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20210206111715.20774-1-krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7bb5b6af-a075-3b84-2864-1c7d75c188f0@arm.com>
Date:   Mon, 8 Feb 2021 09:22:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210206111715.20774-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/6/21 11:17 AM, Krzysztof Kozlowski wrote:
> Correct kerneldoc to fix W=1 warnings:
> 
>      drivers/memory/samsung/exynos5422-dmc.c:290: warning:
>          expecting prototype for find_target_freq_id(). Prototype was for find_target_freq_idx() instead
>      drivers/memory/samsung/exynos5422-dmc.c:1015: warning:
>          expecting prototype for exynos5_dmc_align_initial_frequency(). Prototype was for exynos5_dmc_align_init_freq() instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thank you Krzysztof for looking at this.
LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz



> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index c5ee4121a4d2..1dabb509dec3 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -278,7 +278,7 @@ static int exynos5_counters_disable_edev(struct exynos5_dmc *dmc)
>   }
>   
>   /**
> - * find_target_freq_id() - Finds requested frequency in local DMC configuration
> + * find_target_freq_idx() - Finds requested frequency in local DMC configuration
>    * @dmc:	device for which the information is checked
>    * @target_rate:	requested frequency in KHz
>    *
> @@ -998,7 +998,7 @@ static struct devfreq_dev_profile exynos5_dmc_df_profile = {
>   };
>   
>   /**
> - * exynos5_dmc_align_initial_frequency() - Align initial frequency value
> + * exynos5_dmc_align_init_freq() - Align initial frequency value
>    * @dmc:	device for which the frequency is going to be set
>    * @bootloader_init_freq:	initial frequency set by the bootloader in KHz
>    *
> 
