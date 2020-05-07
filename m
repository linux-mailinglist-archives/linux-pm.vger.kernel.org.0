Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00A71C9542
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgEGPmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 11:42:52 -0400
Received: from foss.arm.com ([217.140.110.172]:34304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgEGPmv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 11:42:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C801FB;
        Thu,  7 May 2020 08:42:51 -0700 (PDT)
Received: from [10.37.12.53] (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292293F68F;
        Thu,  7 May 2020 08:42:48 -0700 (PDT)
Subject: Re: [PATCH] memory/samsung: Maybe wrong triming parameter
To:     Bernard Zhao <bernard@vivo.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200507114514.11589-1-bernard@vivo.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2eeb33f7-1acc-66bb-704a-b724fa0be0a8@arm.com>
Date:   Thu, 7 May 2020 16:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200507114514.11589-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bernard,


On 5/7/20 12:45 PM, Bernard Zhao wrote:
> In function create_timings_aligned, all the max is to use
> dmc->min_tck->xxx, aligned with val dmc->timings->xxx.
> But the dmc->timings->tFAW use dmc->min_tck->tXP?
> Maybe this point is wrong parameter useing.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>   drivers/memory/samsung/exynos5422-dmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index 81a1b1d01683..22a43d662833 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1091,7 +1091,7 @@ static int create_timings_aligned(struct exynos5_dmc *dmc, u32 *reg_timing_row,
>   	/* power related timings */
>   	val = dmc->timings->tFAW / clk_period_ps;
>   	val += dmc->timings->tFAW % clk_period_ps ? 1 : 0;
> -	val = max(val, dmc->min_tck->tXP);
> +	val = max(val, dmc->min_tck->tFAW);
>   	reg = &timing_power[0];
>   	*reg_timing_power |= TIMING_VAL2REG(reg, val);
>   
> 

Good catch! Indeed this should be a dmc->min_tck->tFAW used for
clamping.

It didn't show up in testing because the frequency values based on
which the 'clk_period_ps' are calculated are sane.
Check the dump below:

[    5.458227] DMC: mem tFAW=25000, clk_period_ps=6060
[    5.461743] DMC: tFAW=5, tXP=2 val=5
[    5.465273] DMC: mem tFAW=25000, clk_period_ps=4854
[    5.470101] DMC: tFAW=5, tXP=2 val=6
[    5.473668] DMC: mem tFAW=25000, clk_period_ps=3636
[    5.478507] DMC: tFAW=5, tXP=2 val=7
[    5.482072] DMC: mem tFAW=25000, clk_period_ps=2421
[    5.486951] DMC: tFAW=5, tXP=2 val=11
[    5.490531] DMC: mem tFAW=25000, clk_period_ps=1841
[    5.495439] DMC: tFAW=5, tXP=2 val=14
[    5.499113] DMC: mem tFAW=25000, clk_period_ps=1579
[    5.503877] DMC: tFAW=5, tXP=2 val=16
[    5.507476] DMC: mem tFAW=25000, clk_period_ps=1373
[    5.512368] DMC: tFAW=5, tXP=2 val=19
[    5.515968] DMC: mem tFAW=25000, clk_period_ps=1212
[    5.520826] DMC: tFAW=5, tXP=2 val=21

That's why in the existing configuration it does not harm
(the calculated 'val' is always >= 5) the board.

But I think this patch should be applied (after small changes in the
commit message).

@Krzysztof could you have a look on the commit message or take the
patch with small adjustment in the description, please?

I conditionally give (because of this description):

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>


Thank you Bernard for reporting and fixing this.

Regards,
Lukasz
