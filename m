Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AC357129
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhDGP4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 11:56:15 -0400
Received: from foss.arm.com ([217.140.110.172]:59716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347463AbhDGP4N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Apr 2021 11:56:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4A61063;
        Wed,  7 Apr 2021 08:56:04 -0700 (PDT)
Received: from [10.57.26.91] (unknown [10.57.26.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88DF3F694;
        Wed,  7 Apr 2021 08:56:02 -0700 (PDT)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: handle clk_set_parent()
 failure
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210407154535.70756-1-krzysztof.kozlowski@canonical.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <1906533a-e86a-10fe-5bc3-4600af98d579@arm.com>
Date:   Wed, 7 Apr 2021 16:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210407154535.70756-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 4/7/21 4:45 PM, Krzysztof Kozlowski wrote:
> clk_set_parent() can fail and ignoring such case could lead to invalid
> clock setup for given frequency.
> 
> Addresses-Coverity: Unchecked return value
> Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 56f6e65d40cd..9c8318923ed0 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1293,7 +1293,9 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
>   
>   	dmc->curr_volt = target_volt;
>   
> -	clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
> +	ret = clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
> +	if (ret)
> +		return ret;
>   
>   	clk_prepare_enable(dmc->fout_bpll);
>   	clk_prepare_enable(dmc->mout_bpll);
> 

Thanks for running these tests and for the patch.
I've checked how many many places this function is used in the kernel
and return is ignored - in a lot of places...

This patch LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
