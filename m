Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD7322E7D8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgG0Ifk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:35:40 -0400
Received: from foss.arm.com ([217.140.110.172]:39540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgG0Ifj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 04:35:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 259E6D6E;
        Mon, 27 Jul 2020 01:35:39 -0700 (PDT)
Received: from [10.37.12.33] (unknown [10.37.12.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AD63F718;
        Mon, 27 Jul 2020 01:35:37 -0700 (PDT)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Do not ignore return
 code of regmap_read()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200720110301.22996-1-krzk@kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1f9f9bf2-d93e-5d8b-adcd-c63939b8cf8a@arm.com>
Date:   Mon, 27 Jul 2020 09:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200720110301.22996-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 7/20/20 12:03 PM, Krzysztof Kozlowski wrote:
> Check for regmap_read() return code before using the read value in
> following write in exynos5_switch_timing_regs().  Pass reading error
> code to the callers.
> 
> This does not introduce proper error handling for such failed reads (and
> obviously regmap_write() error is still ignored) because the driver
> ignored this in all places.  Therefor it only fixes reported issue while
> matching current driver coding style:
> 
>         drivers/memory/samsung/exynos5422-dmc.c: In function 'exynos5_switch_timing_regs':
>      >> drivers/memory/samsung/exynos5422-dmc.c:216:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 93e9c2429c0d..2c326998cb1c 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -270,12 +270,14 @@ static int find_target_freq_idx(struct exynos5_dmc *dmc,
>    * This function switches between these banks according to the
>    * currently used clock source.
>    */
> -static void exynos5_switch_timing_regs(struct exynos5_dmc *dmc, bool set)
> +static int exynos5_switch_timing_regs(struct exynos5_dmc *dmc, bool set)
>   {
>   	unsigned int reg;
>   	int ret;
>   
>   	ret = regmap_read(dmc->clk_regmap, CDREX_LPDDR3PHY_CON3, &reg);
> +	if (ret)
> +		return ret;
>   
>   	if (set)
>   		reg |= EXYNOS5_TIMING_SET_SWI;
> @@ -283,6 +285,8 @@ static void exynos5_switch_timing_regs(struct exynos5_dmc *dmc, bool set)
>   		reg &= ~EXYNOS5_TIMING_SET_SWI;
>   
>   	regmap_write(dmc->clk_regmap, CDREX_LPDDR3PHY_CON3, reg);
> +
> +	return 0;
>   }
>   
>   /**
> @@ -516,7 +520,7 @@ exynos5_dmc_switch_to_bypass_configuration(struct exynos5_dmc *dmc,
>   	/*
>   	 * Delays are long enough, so use them for the new coming clock.
>   	 */
> -	exynos5_switch_timing_regs(dmc, USE_MX_MSPLL_TIMINGS);
> +	ret = exynos5_switch_timing_regs(dmc, USE_MX_MSPLL_TIMINGS);
>   
>   	return ret;
>   }
> @@ -577,7 +581,9 @@ exynos5_dmc_change_freq_and_volt(struct exynos5_dmc *dmc,
>   
>   	clk_set_rate(dmc->fout_bpll, target_rate);
>   
> -	exynos5_switch_timing_regs(dmc, USE_BPLL_TIMINGS);
> +	ret = exynos5_switch_timing_regs(dmc, USE_BPLL_TIMINGS);
> +	if (ret)
> +		goto disable_clocks;
>   
>   	ret = clk_set_parent(dmc->mout_mclk_cdrex, dmc->mout_bpll);
>   	if (ret)
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
