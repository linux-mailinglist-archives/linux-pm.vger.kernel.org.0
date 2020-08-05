Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97F623D061
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgHETsJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 15:48:09 -0400
Received: from foss.arm.com ([217.140.110.172]:33406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgHEQ5a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 12:57:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4482C101E;
        Wed,  5 Aug 2020 03:39:31 -0700 (PDT)
Received: from [10.37.12.81] (unknown [10.37.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330773FA32;
        Wed,  5 Aug 2020 03:39:28 -0700 (PDT)
Subject: Re: [PATCH] clk: samsung: Mark top BPLL mux on Exynos542x as critical
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <CGME20200805091612eucas1p28c955b21e57898de60d3ed50c95b9d18@eucas1p2.samsung.com>
 <20200805091601.11983-1-m.szyprowski@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <8f441d23-4700-3c94-74ff-caeda9c24725@arm.com>
Date:   Wed, 5 Aug 2020 11:39:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200805091601.11983-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 8/5/20 10:16 AM, Marek Szyprowski wrote:
> BPLL clock must not be disabled because it is needed for proper DRAM
> operation. This is normally handled by respective memory devfreq driver,
> but when that driver is not yet probed or its probe has been deferred the
> clock might got disabled what causes board hang. Fix this by marking it
> as critical.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos5420.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index fea33399a632..5ef78928938a 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -734,7 +734,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>   	MUX_F(CLK_MOUT_MCLK_CDREX, "mout_mclk_cdrex", mout_mclk_cdrex_p,
>   			SRC_CDREX, 4, 1, CLK_SET_RATE_PARENT, 0),
>   	MUX_F(CLK_MOUT_BPLL, "mout_bpll", mout_bpll_p, SRC_CDREX, 0, 1,
> -			CLK_SET_RATE_PARENT, 0),
> +			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
>   
>   	/* MAU Block */
>   	MUX(CLK_MOUT_MAUDIO0, "mout_maudio0", mout_maudio0_p, SRC_MAU, 28, 3),
> 

I've tested it in the way that we discussed yesterday.
I can confirm this patch solves the issue.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you for investigating this further and fixing it.

Regards,
Lukasz
