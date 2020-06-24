Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA18C2070B9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbgFXKFu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 06:05:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51533 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbgFXKFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 06:05:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200624100548euoutp02a9e697aca8b10f025d9c8271727d6a78~bctQbjf5X1842618426euoutp02Q
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 10:05:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200624100548euoutp02a9e697aca8b10f025d9c8271727d6a78~bctQbjf5X1842618426euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592993148;
        bh=SvK8JPHygH1GHuDrwGrWGGQ8B3V1JbVYqiy1TLgC2es=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gMwjNZL8wkbvXGmz6mfaXacO7fD8xL8qzQhoaqIYeErdN+JKyoE2Gb0pUCvoBYQ9d
         Z7DbcAgXOUuaefeS+NrjnEP3C9lYhR3ti1aSoaVwJyWSdrwPTiTLBXZqiVWK6+QVnV
         GaPtgfZVZQMwE6ApBNzgOPLcEgQKYPSDxELp+PyA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200624100548eucas1p16550c3f7b23dd967fd811af8a981129d~bctQHXpFF3066230662eucas1p1K;
        Wed, 24 Jun 2020 10:05:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D3.7B.06318.C7523FE5; Wed, 24
        Jun 2020 11:05:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624100547eucas1p2e0845d0df5926b97e9a758817859b5fe~bctPt6gbd1629516295eucas1p28;
        Wed, 24 Jun 2020 10:05:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624100547eusmtrp1f79a28dae455267567168e57f2ed83dc~bctPtPO6I0869908699eusmtrp1f;
        Wed, 24 Jun 2020 10:05:47 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-cb-5ef3257c645b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.56.06314.B7523FE5; Wed, 24
        Jun 2020 11:05:47 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624100547eusmtip21531c2f980a45303579ad003e53a0439~bctPLJUPk3243932439eusmtip2U;
        Wed, 24 Jun 2020 10:05:47 +0000 (GMT)
Subject: Re: [PATCH 2/4] cpuidle: big.LITTLE: enable driver only on
 Peach-Pit/Pi Chromebooks
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <db3315ef-1ca8-14b5-486a-9cc5a02150a8@samsung.com>
Date:   Wed, 24 Jun 2020 12:05:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200616081230.31198-3-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXa3u7vp5DotD5oFwwlZaqHQxUrMhEb1oW9F4PKqFzXd1M2X
        FCFb4mu+lJI6y95Ec2gOFU1TkylpLF1IjQozLQkrh9o1yMqR15vkt//5n99zzv/AQ2Bys8ib
        SNJmMDotnaLApcKeZ2u2wDwlqz6wXIBTjawvZbOZxVTnJ7uIYstHEVVnGxJQi78XxNQ9Q4GY
        ah99L44gVG2NbUjVaSrBVdP2AVzV1XRZVdFtQiq2c/cZ/Lz0SDyTkpTF6ILDY6SJC2UP8LQr
        LpeeNi+hfFQrKUUSAshQmBqcw0qRlJCTDxEMOww4X6wieMvOCDlKTrIIVgyHtl6Yamr/QS0I
        mpyLAr5wIOgosIg5yoNUQ//tcQGnPclgKCt8hTiNkVUC6JtjOI2TYXC9yLTpy8hwME4U4pwW
        kkow9Y1u6h3kOfg+OyLiGXd4Xj+/kYggJBv82rofP9IL3s3fEfB6D/Q6bmF8UIsYZipPcDiQ
        UTBRc5y3PeDrWLeY17vAWn1NyMUH8hGC9eIFjC96EbRUO3GeOgzTk79wbhBG7oWO/mDePgYN
        qzcF/Hw3eONw5yO4wY2eWoy3ZVBcKOdpfzA3m/GttaV9rVgVUhi33WXcdoxx2zHG/3vvIqEJ
        eTGZek0Cow/RMtlBelqjz9QmBMWlajrRxj+yOsd+PEZDf2ItiCSQwlVmnl1Ry0V0lj5HY0FA
        YApPWeSEVS2XxdM5uYwu9YIuM4XRW5APIVR4yULuf4mWkwl0BpPMMGmMbqsrICTe+ahpQmth
        A9LZemeqfRTPnjzKKHf6t7tMlvhS5XWVbFMrLaxvKTEW2V1+tnZdpRtiJNlTlvm8uNwWSbj1
        xdnqwUhl8qrmYv8T20Ba9EtCFvI6/UOgIGppOYxx9Tv9+dRJgz22av+YamR43PFtYdg1OvTj
        kJdVsi8uocJHG+E+ohDqE+mDAZhOT/8FCdvgBEMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7rVqp/jDK6vVLeY91nW4vz5DewW
        mx5fY7X43HuE0WLG+X1MFm9+v2C3WNjUwm6x9shddgcOjzXz1jB6bFrVyeZx59oeNo/NS+o9
        +rasYvT4vEkugC1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+NF92K2gkbuiv3L3jM2ME7n7GLk5JAQMJFYNWU6WxcjF4eQwFJGiZ1fzgE5HEAJ
        GYnj68sgaoQl/lzrgqp5zSjRsWczK0hCWCBOYtfcE0wgtoiAvkR32xVGkCJmgUlMEj/O3IHq
        OMoo8e/MNxaQKjYBK4mJ7asYQWxeATuJWWfb2EBsFgFViVU7j4DZogIREod3zIKqEZQ4OfMJ
        C8hFnED1P/+qgISZBdQl/sy7xAxhi0vcejKfCcKWl9j+dg7zBEahWUi6ZyFpmYWkZRaSlgWM
        LKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo3DbsZ+bdzBe2hh8iFGAg1GJh3fDg49xQqyJ
        ZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGCCyCuJNzQ1NLew
        NDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwCj7hP/Pkrc7WwuU+7e6fd5xpvXT
        0RPpB+ryJlpOfXh9e/SKx2o3zU7ZJr3/aP1nc/6qBe/0xMtPXzgz/cm2pl3i50OL3kXxueat
        +PVQZtIWg13h01yY9z4538iVemGSR4t0tAOP1CODfU7unm8mdfo5b2ks3MdcdLZyyspA5oyE
        XVOa/6uIb25WYinOSDTUYi4qTgQAzvG1ItgCAAA=
X-CMS-MailID: 20200624100547eucas1p2e0845d0df5926b97e9a758817859b5fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081249eucas1p2ad165b545f265bec88a06270d55fce76
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081249eucas1p2ad165b545f265bec88a06270d55fce76
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081249eucas1p2ad165b545f265bec88a06270d55fce76@eucas1p2.samsung.com>
        <20200616081230.31198-3-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/16/20 10:12 AM, Marek Szyprowski wrote:
> This driver always worked properly only on the Exynos 5420/5800 based
> Chromebooks (Peach-Pit/Pi), so change the required compatible string to
> the 'google,peach', to avoid enabling it on the other Exynos 542x/5800
> boards, which hangs in such case. The main difference between Peach-Pit/Pi
> and other Exynos 542x/5800 boards is the firmware - Peach platform doesn't
> use secure firmware at all.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/cpuidle/cpuidle-big_little.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index 7f8ddc04342d..abe51185f243 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -155,8 +155,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int part_id)
>  
>  static const struct of_device_id compatible_machine_match[] = {
>  	{ .compatible = "arm,vexpress,v2p-ca15_a7" },
> -	{ .compatible = "samsung,exynos5420" },
> -	{ .compatible = "samsung,exynos5800" },
> +	{ .compatible = "google,peach" },
>  	{},
>  };
>  
> 
