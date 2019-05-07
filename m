Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2016009
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEGJCM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 05:02:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55936 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfEGJCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 05:02:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190507090210euoutp014ec2ce87f94b468133738c7b96c119a3~cWxhCpgJB1185411854euoutp01-
        for <linux-pm@vger.kernel.org>; Tue,  7 May 2019 09:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190507090210euoutp014ec2ce87f94b468133738c7b96c119a3~cWxhCpgJB1185411854euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557219730;
        bh=hLEg2smoVNibs0A7WS7nGatMVz2luqvh+b291jyrQ6I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rTP/inEmFUDSlyeQ/u7sQq/YOl0dtuxf5DN5SPUKWo5P1uN2WCTdgco9pjlyFAzob
         LPLlKqrj5CD7NufhvU+3rjqDeks4sxp5f/C6Wd1kIGEGl5OEokhzLOTYbPwFQnuHyI
         wy4MBMCFvqX7zBBmX6TIYfiFTVHOMZZCl2X8t+Z0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190507090210eucas1p1b464d9195225ed226947bf0007753f09~cWxgUTcVh1465414654eucas1p1U;
        Tue,  7 May 2019 09:02:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.91.04377.19941DC5; Tue,  7
        May 2019 10:02:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190507090209eucas1p11f3a54a14cba6bb3217e773f6b72766e~cWxfkAIVn1203112031eucas1p1X;
        Tue,  7 May 2019 09:02:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190507090209eusmtrp13c70ed2c49436da49f6fb1be2c70f0d1~cWxfVxJqz2943329433eusmtrp1x;
        Tue,  7 May 2019 09:02:09 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-06-5cd14991623b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7A.B6.04146.09941DC5; Tue,  7
        May 2019 10:02:09 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190507090208eusmtip2b53546d7073e0e5d8d096613331c6028~cWxee99_F2351423514eusmtip2Y;
        Tue,  7 May 2019 09:02:08 +0000 (GMT)
Subject: Re: [PATCH v7 03/13] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <6346e0e4-adaa-4eed-d0ae-f62b853c151e@partner.samsung.com>
Date:   Tue, 7 May 2019 11:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1db8ffb8-1038-edbc-81b5-689f8a4c3c6b@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUYRTF/eYt85TGnqPlZYqKoaIMtUXig1bLaqyICiQpIcd6mTQz6by0
        rCjLFtNccmkZFTXLXdzGJSkrM62mskEtM6TFcSmdwLTAhciZp+R/v3vvudxz4DKEtJ+SMUGa
        E5xWo1TJaTuyqnGk2fWGt9FveWrlalx2u4TCH4Z7KZzR8JbChYNdCCe9Shfh1zFqHN/VT+Dm
        5lIxfnNxQIxbatNoPBTbgPDt5joRLm7oFONPF/Jo/GzgKoUft27Hn8bs8Z8X39BGqeLP70RS
        kRphJBUPdJ1iRXnBNVoRG/mTVsTpC5CiwnBGMVQ+bzez327tYU4VFMZp3df72x291NdLB3dL
        T8XdaUMRqGVmNLJlgPWAvpx2kYWlbB6CqIdzBB5GMJqoikZ2EzyE4FHOIJpa6DWXksIgF0G/
        qY0QCjOCtI4RwqJyZH2gZrzCOnBisxGk5I+JLAXBFopg/HcxFY0YhmbdoKYgxLIgYbdCTXeW
        dZlkF4I56jNl4VmsL3xuLKUEjQO8vGMiLWzLboAYfbLYwgTrDB2mDJHA8yGyMtV6GNgUBpJb
        IknBtxfUFRtogR3hR5NeLPBcMCRdn9TwEBGbNZnzLHTFp09q1sCzJqPVM8EuhZJad6HtCe0d
        ZdY2sPbQbnYQLNhDYtUtQmhLIOqKVFAvAf31dyKBZ0Nu0U1xApLrpgXTTQujmxZG9/9uJiIL
        kDMXyqsDOX6lhjvpxivVfKgm0O3QcXU5mnhBw9+m4RpUOx5Qj1gGyWdIEja985NSyjA+XF2P
        gCHkThJlz1s/qeSwMvw0pz1+UBuq4vh6NIch5c6SMzZfDkjZQOUJ7hjHBXPaqamIsZVFIK9w
        uSnwa8iTPR+M7udD34+WueqzPH7JZi4fwrKQqrt03mhmtjNxdXjnN+P3no+n8PluncEmd+U+
        2nfXlkUnc4jq/NeDI6sCvDXVQa1Rex1cU++rPB+uy6TuDbj4HHl6Lm6NTWcYLI417/2eVtS7
        bdldZsHlqkL/lzKZ787G56Ydm+Ukf1S5woXQ8sp/0Csivn4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Pd2JnhdjDFrvMFlsnLGe1eL6l+es
        FvOPnGO1WP3xMaPF5FNzmSzOdOda9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnG7cQWbxeE37awW+694Wdz+zWfx7cQjRgchj29fJ7F4zG64yOKxc9Zddo9NqzrZPHqb
        37F59G1Zxeix+XS1x+dNcgEcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
        +nY2Kak5mWWpRfp2CXoZLS+esxU8Farom3mVsYHxMn8XIyeHhICJxPO3G1i6GLk4hASWMkq8
        /nGQCSIhJjFp33Z2CFtY4s+1LjaIoteMElvev2UFSQgLhErs+LOZGcQWEVjMKPG1tRqkiFlg
        NZPEpI9boDqmMEm8nLISaCwHB5uAnsSOVYUgDbwCbhI7ni4Ea2YRUJF423EfbKioQITEmfcr
        WCBqBCVOznwCZnMK2Et0b5kCdhGzgJnEvM0PmSFscYlbT+YzQdjyEs1bZzNPYBSahaR9FpKW
        WUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw9rcd+7l5B+OljcGHGAU4GJV4
        eB/YXogRYk0sK67MPcQowcGsJMKb+OxcjBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA9NS
        Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRnuGuEWCKX5zLwiu
        m7c37m/D6m1T8mRDI39lVZxu9l54+9iFoLfWX+MucpWu/xG6/d9Tpr37bW3/HL97xqyppvom
        98G4zSdquOMcD9j79klO+vmUqY494kdmYeyEXo01YrF5TxiDIuYxvlfucXIu89Rw3P2tzu/2
        IUGHVr40WdNnj5duqW04qMRSnJFoqMVcVJwIACsWLgkTAwAA
X-CMS-MailID: 20190507090209eucas1p11f3a54a14cba6bb3217e773f6b72766e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151212eucas1p24110f75fa6ed945f9ae7614fbb8aa13d@eucas1p2.samsung.com>
        <1557155521-30949-4-git-send-email-l.luba@partner.samsung.com>
        <1db8ffb8-1038-edbc-81b5-689f8a4c3c6b@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/7/19 9:36 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 5. 7. 오전 12:11, Lukasz Luba wrote:
>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>> Controller frequencies for driver's DRAM timings.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index af62b6d..23c60a5 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -1335,6 +1335,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>>   	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>>   };
>>   
>> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
>> +};
>> +
>>   static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>>   	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>>   	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
>> @@ -1477,9 +1488,13 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>   		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>   		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   	}
>>   
>> +	if (soc == EXYNOS5420)
>> +		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> +	else
>> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
>> +
>>   	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>   					reg_base);
>>   	samsung_clk_register_fixed_rate(ctx, exynos5x_fixed_rate_clks,
>>
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you, added to the patch.

Regards,
Lukasz

