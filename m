Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88C211B4F
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEBOXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 10:23:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48527 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEBOXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 10:23:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190502142308euoutp013b922c9ea86c55f630c033bacba7687e~a47UYodUU1465114651euoutp01w
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 14:23:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190502142308euoutp013b922c9ea86c55f630c033bacba7687e~a47UYodUU1465114651euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556806988;
        bh=zbCRIGD19ZlsyDoT0AKDehhi/Wr3SiotaHEs37U/hi4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pxlqr/eayAkL3DFBVNm7Eu6kVJ1x8suad/kFq94PQaIqvMyykl/xSh9pr2NuMsP1/
         SX41QxPaB/L7KB/Q3wlbdxNQS6TS/6KvJpiLfpXF3+0x85CgYGlCkIqwyP3Zu1btIU
         0eyHqLZ1k0ouw6ZSfST5p0L4AAGzZ2neIvOVCUdQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190502142307eucas1p220f5c18851319ebded0db97e40cf96fe~a47TqdRt_0832308323eucas1p29;
        Thu,  2 May 2019 14:23:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4D.14.04377.B4DFACC5; Thu,  2
        May 2019 15:23:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190502142306eucas1p2c83555417d2dd37e99be73214c89d46c~a47S3b_3V0982609826eucas1p2O;
        Thu,  2 May 2019 14:23:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190502142306eusmtrp19fba09dedcf9fd9fcc251b0687b2734f~a47SpOs9e1828518285eusmtrp1B;
        Thu,  2 May 2019 14:23:06 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-f9-5ccafd4ba11c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AF.F3.04146.A4DFACC5; Thu,  2
        May 2019 15:23:06 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190502142305eusmtip20d0ef38e186a88ee355fa6941290bb73~a47R9fk-41443114431eusmtip2k;
        Thu,  2 May 2019 14:23:05 +0000 (GMT)
Subject: Re: [PATCH v6 03/10] clk: samsung: add BPLL rate table for Exynos
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
Message-ID: <e280645a-3a7a-5bec-6372-5b46996a7a47@partner.samsung.com>
Date:   Thu, 2 May 2019 16:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <62f85c18-d3ac-3425-8ee3-538f8c677603@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGfXfv7q7S7HWanuwLVkQWmZbQW0YfFDUqpH+CUKlWXrVyU3e1
        MkOWy8zKVUamUzOJmC4tMy2/yFDJ1NRWitKyJNenGYTTCk1yu5P87/c85znvOQdelpINiX3Z
        I+oETqNWxsgZN/rRsz+dK3f9bQsPKHvKkAc598Wk1/ZZTAqbO8Xk7s9BRK61FYjIi4sqcnlw
        iCJdXeUS0pH6XUJe1+YzZCSzGZGcriciUtbcLyGWM8UMafqeLiYN3TuJZdydjD3/gDbLFGOj
        WbQiT2umFTWGfomiwpTBKDJ1PxiFvtKEFA/bkxUjFQv3sKFuGyK4mCPHOc2qjQfdoruzfzNx
        +vkns4w1lBaZvS8gVxZwENRczaYuIDdWhosRDL9tpAVhQ5BdP+QUIwhaLXpquuXrx2GJUDAi
        6C06LxbEMAJbzy+xPeWJ90JaQYvIXvDCtxFcLxl3CArfFcHEaNlUimUZ7A/Vpng7SvF2sAyE
        2ntpvASKrUWOaXPwPnj/rNzxphR7QGuulbazK94EZRetjgyFfeCNtVAk8CLQVeU5N81l4WqT
        n8DboCq9CAnsCd9aKiUCz4f2a5dogXnQZk5nTsPg5QJnJhiaWsyOjSnsB/drVwn2FrhXV0rZ
        bcDu0DfsIWzgDlmPbjhtKZw/JxPSy6Dy0kuRwN5gLM2WXEFyw4y7DDNuMcy4xfB/7i1Em5AP
        l8irojh+tZo74c8rVXyiOsr/cKyqAk19wfbJFls1qp041Igwi+SzpPCuLVwmVh7nk1SNCFhK
        7iXd/3PKkkYok05xmtgDmsQYjm9E81ha7iNNdhkIk+EoZQJ3jOPiOM10VcS6+mrRjZ6t+pL9
        o5KjtZ87dIaG+E9PV5TXqxbvTu0PZ6J2LggLqq+wtj42zmUm16T3j/cEWX8Fr62LDrEFl/hG
        9nYZO/xdDPms+WzSl74BHBGUFnLlRcomrAvwjaVL7yTodmToMwKq/V6ljFS5zIt8bvr9Z+nN
        2fHbi9b3BCYnqNd9cY2U03y0MnA5peGV/wDNIQgDfgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xe7pef0/FGMz9xm+xccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFofftLNa7L/iZXH7N5/FtxOPGB2EPL59ncTiMbvhIovHzll32T02repk8+ht
        fsfm0bdlFaPH5tPVHp83yQVwROnZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlXJn2g62gT6Zi0vKdzA2MF8W6GDk5JARMJF4+fcvexcjFISSwlFFi
        8r5pzBAJMYlJ+7azQ9jCEn+udbGB2EICrxklFjZWg9jCAqESrXOPM4HYIgKLGSW+tlaDDGIW
        WM0kMenjFjaIqVOYJG4+esDSxcjBwSagJ7FjVSGIySvgJnH7QRRIL4uAisSKJwvB9ooKREic
        eb+CBcTmFRCUODnzCZjNKWAvsbb7CVgNs4CZxLzND6FscYlbT+YzQdjyEs1bZzNPYBSahaR9
        FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMw7rcd+7l5B+OljcGHGAU4
        GJV4eCXunYoRYk0sK67MPcQowcGsJMIb9xEoxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnA
        lJRXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFRYaHTza7+UK7d
        G2aYF+qkWNY9rCn/OPee0ORfFgmbD14VcU6Z8Cs/Um7G3dXVrAxJkbuOVb09G7AvRKefYbrn
        8crpR9hXNUr8dhB6dEvBsZWFgfeHX5T/9+TXFWdzGpZ/rspa070i+UlYxM176tEnJ2jsviS/
        qz2W1zm0cdkvpfnb2CbV/RBWYinOSDTUYi4qTgQArQP2YxEDAAA=
X-CMS-MailID: 20190502142306eucas1p2c83555417d2dd37e99be73214c89d46c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141943eucas1p220d77bacfc4fcba8ec6a10f540e1a27d@eucas1p2.samsung.com>
        <1555683568-20882-4-git-send-email-l.luba@partner.samsung.com>
        <62f85c18-d3ac-3425-8ee3-538f8c677603@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 5/2/19 7:15 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 19. 오후 11:19, Lukasz Luba wrote:
>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>> Controller frequencies for driver's DRAM timings.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index d9e6653..ddee8bd 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -1323,6 +1323,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
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
>> @@ -1465,7 +1476,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>   		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>   		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
> 
> According to your previous reply, the released odroid-xu3 board by hardkernel
> might be only CONFIG_SOC_EXYNOS5422_REV_0. Because the kernel configurattion
> from hardkernel has 'CONFIG_SOC_EXYNOS5422_REV_0=y'. I'm ok about adding bpll rate_table.
> 
> But, just I have one question. I think that this bpll rate_table is for
> only Exynos5422 series. Because the kernel of hardkernel used
> driver/clk/samsung/clk-exynos5422.c instead of clk-exynos5420.c commonn driver.
> It means that the clk-exynos5422.c of hardkernel's kernel support only Exynos5422
> without any considering the Exynos5420 series.
> 
> I think that it might need to check the soc version to use
> bpll rate_table as following:
Fair enough.
> 
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1438,7 +1438,10 @@ static void __init exynos5x_clk_init(struct device_node *np,
>                  exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>                  exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>                  exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -               exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
> +
> +               if (soc == EXYNOS5800)
> +                       exynos5x_plls[bpll].rate_table
> +                               = exynos5422_bpll_rate_table;
>          }
> 
I will add this check. Thank you.

Regards,
Lukasz
> 
>>   	}
>>   
>>   	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>
> 
> 
