Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7C11284
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 07:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfEBFOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 01:14:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:44420 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfEBFOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 01:14:45 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190502051442epoutp03794012e6393ae2133d3f9c082f425249~axcezCnBQ1995019950epoutp03i
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 05:14:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190502051442epoutp03794012e6393ae2133d3f9c082f425249~axcezCnBQ1995019950epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556774082;
        bh=XLV5tk/LWS1F7CKYRYZhM+g9pIWwdU+llTi5XmZU/PA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tzF7wPw4YIhQnWIo7q+2WHw+c+uVD5aJqQqgf8G3m8mFSjVZFGMdoL5CmloQu6J/n
         oq2F+8pxyr5H1nh3uD23dKMotWqXINIKNge4uE/QQxO8bEPswdSGF2dxEtRS38oEue
         lomfqdqrHLY8dqsbrVajeXh+p8len4pAkmhTcXyo=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190502051439epcas1p19684e29355ffd9313a8c98a9d0db47fb~axccJ6NvN1771017710epcas1p1L;
        Thu,  2 May 2019 05:14:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.F4.04143.FBC7ACC5; Thu,  2 May 2019 14:14:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190502051439epcas1p2a6894ac4ccfe59d87388fa949d6ef7e3~axcbvID3i0842208422epcas1p2q;
        Thu,  2 May 2019 05:14:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190502051439epsmtrp141fd018dbbe33a58dfb424b6652788f0~axcbuFVsZ2560525605epsmtrp15;
        Thu,  2 May 2019 05:14:39 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-b2-5cca7cbf70f7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.DC.03662.FBC7ACC5; Thu,  2 May 2019 14:14:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190502051439epsmtip2241f85ad7a40881b2e0a68a46e7dc486~axcbcjc_q1959519595epsmtip2Q;
        Thu,  2 May 2019 05:14:39 +0000 (GMT)
Subject: Re: [PATCH v6 03/10] clk: samsung: add BPLL rate table for Exynos
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
Message-ID: <62f85c18-d3ac-3425-8ee3-538f8c677603@samsung.com>
Date:   Thu, 2 May 2019 14:15:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555683568-20882-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJsWRmVeSWpSXmKPExsWy7bCmge7+mlMxBtefG1psnLGe1WL+kXOs
        Fqs/Pma0mHxqLpPFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwWZx+E07q8X+K14Wt3/zWXw78YjRQcjj29dJLB6zGy6yeOycdZfdY9OqTjaP3uZ3
        bB4H3+1h8ujbsorRY/Ppao/Pm+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOAnlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFFgW
        6BUn5haX5qXrJefnWhkaGBiZAhUmZGfMmfScreCiVMWkRXfYGxivinYxcnBICJhIfPlT0MXI
        xSEksINRYvPRE4wQzidGiZONS9kgnG+MEqv3PGXvYuQE6zg4eRUjiC0ksJdRYmUnH0TReyB7
        92NmkISwQKhE69zjTCAJEYHljBL7pt4Fm8sssJpJ4s/XtawgVWwCWhL7X9xgA7H5BRQlrv54
        DDaWV8BOYsrLJWA1LAIqEvs33WMCsUUFIiTuH9vAClEjKHFy5hMWEJtTwFvi27plYOcxC4hL
        3HoynwnClpdo3jqbGWSxhMA9dond7Q8YIb52kVjyzhviHWGJV8e3QL0mJfGyvw3KrpZYefII
        G0RvB6PElv0XWCESxhL7l05mApnDLKApsX6XPsQuPol3X3tYIcbzSnS0CUFUK0tcfnCXCcKW
        lFjc3skGYXtIPD76ln0Co+IsJN/MQvLBLCQfzEJYtoCRZRWjWGpBcW56arFhgTFybG9iBCd0
        LfMdjBvO+RxiFOBgVOLh/TH1ZIwQa2JZcWXuIUYJDmYlEd5be4BCvCmJlVWpRfnxRaU5qcWH
        GE2BgT2RWUo0OR+YbfJK4g1NjYyNjS1MDM1MDQ2VxHnXOzjHCAmkJ5akZqemFqQWwfQxcXBK
        NTDqd25Ypnl/V5+VK8eEb4vOLt21qLg4+pnztoDZDaxFKy+daHh9MSoo6M9K13k+z68e2xE+
        c9fe15W6EwOeu0h9Y2s72PEhfvZP7xNLt9yad71YyfPhldwP6/O6bXkmJBgluXIY+17cdfeh
        bcFW3Sl/v1/OOPVX53CBv7KNnz3n9j9v7/DmOHibKrEUZyQaajEXFScCADDQNpv+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSvO7+mlMxBpNmC1lsnLGe1WL+kXOs
        Fqs/Pma0mHxqLpPFme5ci/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH
        7rJb3G5cwWZx+E07q8X+K14Wt3/zWXw78YjRQcjj29dJLB6zGy6yeOycdZfdY9OqTjaP3uZ3
        bB4H3+1h8ujbsorRY/Ppao/Pm+QCOKO4bFJSczLLUov07RK4MuZMes5WcFGqYtKiO+wNjFdF
        uxg5OSQETCQOTl7F2MXIxSEksJtR4t/vbcwQCUmJaRePAtkcQLawxOHDxRA1bxkl7j04yAJS
        IywQKtE69zgTSEJEYDmjxNy/S1lAHGaB1UwSkz5uYYNouc8ocfXaC1aQFjYBLYn9L26wgdj8
        AooSV388ZgSxeQXsJKa8XAJWwyKgIrF/0z0mEFtUIELizPsVLBA1ghInZz4BszkFvCW+rVvG
        DmIzC6hL/Jl3iRnCFpe49WQ+E4QtL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPT
        c4sNC4zyUsv1ihNzi0vz0vWS83M3MYLjW0trB+OJE/GHGAU4GJV4eH9MPRkjxJpYVlyZe4hR
        goNZSYT31h6gEG9KYmVValF+fFFpTmrxIUZpDhYlcV75/GORQgLpiSWp2ampBalFMFkmDk6p
        BsZq3zRpyZc13BnnHNLirDv2H9zEWyYvLsV5dZHwfNOO6Qk3c2Tmeild3OTrrBh4Zs7pmTeE
        fZ6s/nBDtPrKegsTrQ3yi69Ln7mesCJLfPJX/gvWj+7MzMs8/aJ0SomPVXO+YZzQt/MzV3e+
        8HO7v9iyb8E39f+7zpb+XHi2/KGznHIX3zx2MT0lluKMREMt5qLiRABQQiCD6wIAAA==
X-CMS-MailID: 20190502051439epcas1p2a6894ac4ccfe59d87388fa949d6ef7e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d@eucas1p2.samsung.com>
        <1555683568-20882-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
> Controller frequencies for driver's DRAM timings.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index d9e6653..ddee8bd 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1323,6 +1323,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
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
> @@ -1465,7 +1476,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;

According to your previous reply, the released odroid-xu3 board by hardkernel
might be only CONFIG_SOC_EXYNOS5422_REV_0. Because the kernel configurattion
from hardkernel has 'CONFIG_SOC_EXYNOS5422_REV_0=y'. I'm ok about adding bpll rate_table.

But, just I have one question. I think that this bpll rate_table is for
only Exynos5422 series. Because the kernel of hardkernel used
driver/clk/samsung/clk-exynos5422.c instead of clk-exynos5420.c commonn driver.
It means that the clk-exynos5422.c of hardkernel's kernel support only Exynos5422
without any considering the Exynos5420 series. 

I think that it might need to check the soc version to use
bpll rate_table as following:

--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1438,7 +1438,10 @@ static void __init exynos5x_clk_init(struct device_node *np,
                exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
                exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
                exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-               exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
+
+               if (soc == EXYNOS5800)
+                       exynos5x_plls[bpll].rate_table
+                               = exynos5422_bpll_rate_table;
        }


>  	}
>  
>  	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
