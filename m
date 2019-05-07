Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CD615E45
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfEGHfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 03:35:31 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43267 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEGHfb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 03:35:31 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190507073528epoutp04e331e42ad939d93b6ea47b9a5dddea93~cVlz4woDt1479014790epoutp04m
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 07:35:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190507073528epoutp04e331e42ad939d93b6ea47b9a5dddea93~cVlz4woDt1479014790epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557214528;
        bh=FYl5euwdsPPChv+/efoMBPph1L1YgFkS2vAGuXunfFQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cxWAMWq2M/AmkIyrnwUPCh7Qawr1xeZVDhFqyiPKTWMO1FVkyPdIfd4DLzYBbuJ+c
         LEIZFjkprrDcfywUF/NjwysffPohzoN39cBlugA6F1d9vEvZc953c/funFOizVX/xK
         OAkvaEzg34GiFrZCDboUlzV7+EIP4hnx+sT581YM=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190507073525epcas1p29ade2ba4a25f0272b8c0a0e3b34bd3ed~cVlxIu9Xm1903619036epcas1p2O;
        Tue,  7 May 2019 07:35:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.D5.04143.D3531DC5; Tue,  7 May 2019 16:35:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190507073524epcas1p198f3608c10098e2e270c9392b302622f~cVlwgQVs71535215352epcas1p1V;
        Tue,  7 May 2019 07:35:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190507073524epsmtrp2f5d59f52c51bd3e01489ff281025c441~cVlwdyvmE0559305593epsmtrp26;
        Tue,  7 May 2019 07:35:24 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-13-5cd1353ded4d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.68.03662.C3531DC5; Tue,  7 May 2019 16:35:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190507073524epsmtip2156111aa2fcaed3035b1ad7ba65ac495~cVlwMz6W22664026640epsmtip26;
        Tue,  7 May 2019 07:35:24 +0000 (GMT)
Subject: Re: [PATCH v7 03/13] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1db8ffb8-1038-edbc-81b5-689f8a4c3c6b@samsung.com>
Date:   Tue, 7 May 2019 16:36:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557155521-30949-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmvq6t6cUYg5Zn4hYbZ6xntZh/5Byr
        xeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4v4/JYu2R
        u+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPL49nUSi8fshossHjtn3WX32LSqk82jt/kd
        m8fBd3uYPPq2rGL02Hy62uPzJrkAzqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNL
        C3MlhbzE3FRbJRefAF23zBygZ5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYF
        esWJucWleel6yfm5VoYGBkamQIUJ2Rk7T/xiKvgtWNE/cy9jA2MLfxcjJ4eEgInEzbkf2boY
        uTiEBHYwSpz7t5IRwvnEKNG5aTeU841R4s7rm+wwLRse9DFBJPYySszqWQTV/55R4tilDlaQ
        KmGBUIkdfzYzgyREBJYzSuybehdsFrPAaiaJP1/XglWxCWhJ7H9xgw3E5hdQlLj64zEjiM0r
        YCexe8F3oDgHB4uAisSuSfogYVGBCIn7xzawQpQISpyc+YQFxOYU8JY4uqYJ7DxmAXGJW0/m
        M0HY8hLNW2eDHSEhcI9dYuaZ7YwQP7hIHN10mw3CFpZ4dXwL1G9SEp/f7YWKV0usPHmEDaK5
        g1Fiy/4LrBAJY4n9SyczgRzHLKApsX6XPsQyPol3X3tYQcISArwSHW1CENXKEpcf3GWCsCUl
        Frd3Qo33kNi9aiX7BEbFWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJj5PjexAhO6lrm
        Oxg3nPM5xCjAwajEw/vA9kKMEGtiWXFl7iFGCQ5mJRHexGfnYoR4UxIrq1KL8uOLSnNSiw8x
        mgIDeyKzlGhyPjDj5JXEG5oaGRsbW5gYmpkaGiqJ8653cI4REkhPLEnNTk0tSC2C6WPi4JRq
        YOQ96fT51YGbzeLTdRK+xyQq73pVcDq5qeWOwNalZxJ0TmZFTI/cF3L+WscezdDHixdVL0ic
        pW7eL3HjsmfvhfuGwokZrmezn6dIfN9zi6nn9/zJU0RF5LaEuEmvm+tr2f/KlXc349bYadPj
        Jz5jZ3y0zMg29/3RSq1yw3/iPCdLJxxdsPrl/iglluKMREMt5qLiRABgx4SiAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7bCSvK6N6cUYg5+ntSw2zljPajH/yDlW
        i9UfHzNaTD41l8niTHeuRf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktbjeuYLM4/Kad1WL/FS+L27/5LL6deMToIOTx7eskFo/ZDRdZPHbOusvusWlVJ5tHb/M7
        No+D7/YwefRtWcXosfl0tcfnTXIBnFFcNimpOZllqUX6dglcGTtP/GIq+C1Y0T9zL2MDYwt/
        FyMnh4SAicSGB31MXYxcHEICuxklXl36wwSRkJSYdvEocxcjB5AtLHH4cDFEzVtGiSUNF8Bq
        hAVCJXb82cwMkhARWM4oMffvUhYQh1lgNZPEpI9b2CBa7jNKnGv4xgrSwiagJbH/xQ02EJtf
        QFHi6o/HjCA2r4CdxO4F39lA1rEIqEjsmqQPEhYViJA4834FC0SJoMTJmU/AbE4Bb4mja5rY
        QWxmAXWJP/MuMUPY4hK3nsxngrDlJZq3zmaewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56
        brFhgVFearlecWJucWleul5yfu4mRnB0a2ntYDxxIv4QowAHoxIPb4f1hRgh1sSy4srcQ4wS
        HMxKIryJz87FCPGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCU
        amCcobb88p3fdzcyiBTMan7DMtWwleWucuS51x6L5M0/rGpj2h9rw1C67MjTF/P3BTGYXLjq
        f+tYqZU9zwnBFYYvfA4FJ0UUGBT5r9ku9ebPPo1Sw3/rfme80172u6zjsrM+X33J5gI/5nPG
        yxSnxgfrz/rSeyT24sHEjc2XnDpm8z5bZ16aEtyixFKckWioxVxUnAgASH8NyeoCAAA=
X-CMS-MailID: 20190507073524epcas1p198f3608c10098e2e270c9392b302622f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d@eucas1p2.samsung.com>
        <1557155521-30949-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
> Controller frequencies for driver's DRAM timings.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index af62b6d..23c60a5 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1335,6 +1335,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>  	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>  };
>  
> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
> +};
> +
>  static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>  	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>  	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
> @@ -1477,9 +1488,13 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  	}
>  
> +	if (soc == EXYNOS5420)
> +		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +	else
> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
> +
>  	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>  					reg_base);
>  	samsung_clk_register_fixed_rate(ctx, exynos5x_fixed_rate_clks,
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
