Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B220D7D0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbgF2Tc6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 15:32:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46845 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733239AbgF2Tcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:32:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200629085429euoutp027a33e7663936a2d00d88ed35f17a4239~c99aPp5Ye1661516615euoutp02S
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 08:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200629085429euoutp027a33e7663936a2d00d88ed35f17a4239~c99aPp5Ye1661516615euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593420869;
        bh=YlAFohUClF6fXd9Dd0WUGQ39SkUErpo90z0R/My8u0w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fT+8AMMFythHZpx3OevJ8MdbaSfAPtxjjVekgXURjd7WwZlF1GDYUHBEjFrSuSfK4
         PLzNnCVgENjcGmdtWlE4fFI5ziSTQm/JoZpsKznJyxd8ybkXLdjaipiH6WFssWer8j
         rD9YNw8EPO1GC5sJckS8SXwrZL62HJZfd+6pPT9A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200629085428eucas1p2111bbe24e970e591af3dadf6bcb6a6e6~c99Z9vbJD1440114401eucas1p2R;
        Mon, 29 Jun 2020 08:54:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E9.AE.06318.44CA9FE5; Mon, 29
        Jun 2020 09:54:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200629085428eucas1p11249d948db0ab18926cab2c859422185~c99Zl_V6R3114531145eucas1p1T;
        Mon, 29 Jun 2020 08:54:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200629085428eusmtrp20b44aad88d63ca89afa48378554e93d2~c99ZlTwRv2274322743eusmtrp2i;
        Mon, 29 Jun 2020 08:54:28 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-7e-5ef9ac44d5d3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.04.06017.44CA9FE5; Mon, 29
        Jun 2020 09:54:28 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200629085427eusmtip2a88a5e0777a651a80ac1492da2899afd~c99ZDb4Vi0269702697eusmtip20;
        Mon, 29 Jun 2020 08:54:27 +0000 (GMT)
Subject: Re: [PATCH 1/4] ARM: exynos: Apply little core workaround only
 under secure firmware
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <96d7f0f2-63c0-8c8d-5a79-ba27295b389a@samsung.com>
Date:   Mon, 29 Jun 2020 10:54:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622171904.GA4174@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87oua37GGTTc1LLYOGM9q8W8z7IW
        589vYLfY9Pgaq8Xn3iOMFjPO72OyePP7BbvFwqYWdgcOjzXz1jB6bFrVyeZx59oeNo/NS+o9
        +rasYvT4vEkugC2KyyYlNSezLLVI3y6BK+PMti2MBackK96e2sHcwPhSpIuRg0NCwETiztXI
        LkYuDiGBFYwSj2dsY4FwvjBK/F96hx3C+cwoMe/XMiCHE6zj8swdTBCJ5YwS06+dYYNw3jNK
        3D1ziBmkSlggXmL1lA5mkB0iAj4SbS1ZIDXMAn8YJX5NbWACqWETMJToetvFBmLzCthJnHyy
        nhXEZhFQlbg9/wEjiC0qECvRt3QBVI2gxMmZT1hAbE4BPYmZX26A1TALyEtsfzuHGcIWl7j1
        ZD7YdRIC+9gldsz9xQZxtotE15xmZghbWOLV8S1Q78hI/N8J09DMKPHw3Fp2CKeHUeJy0wxG
        iCpriTvnQCZxAK3QlFi/Sx8i7Cixe9E5JkhI8knceCsIcQSfxKRt05khwrwSHW1CENVqErOO
        r4Nbe/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5
        mxiBSen0v+NfdzDu+5N0iFGAg1GJh9fh4o84IdbEsuLK3EOMEhzMSiK8TmdPxwnxpiRWVqUW
        5ccXleakFh9ilOZgURLnNV70MlZIID2xJDU7NbUgtQgmy8TBKdXAmCty/mJTQNuFdaH7cic2
        ZDuw1HVE3pu7bssO1976r44mvyqSN0XtXzFBr1x924Y/l/YoF/10S5Fz70ssyL8T0Bijl3tZ
        fA4XX/dXgTzTJF0ZZTY7OZva3bMsLLP7WBXYPBc89LrNYc66WfGq5/Id9u3Xv9V6l218/MD9
        8KXZ/SXy867VTNivxFKckWioxVxUnAgAib+VuEYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7oua37GGby9KmCxccZ6Vot5n2Ut
        zp/fwG6x6fE1VovPvUcYLWac38dk8eb3C3aLhU0t7A4cHmvmrWH02LSqk83jzrU9bB6bl9R7
        9G1ZxejxeZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsaZbVsYC05JVrw9tYO5gfGlSBcjJ4eEgInE5Zk7mLoYuTiEBJYySsz+vJkZIiEj
        cXJaAyuELSzx51oXG4gtJPCWUWJKW3kXIweHsEC8xOGVoiCmiICPRFtLFsgYZoF/jBLnF+5m
        g5g5i0ni8fLzYDPZBAwlut5CzOEVsJM4+WQ92HwWAVWJ2/MfMILYogKxEt/ubYGqEZQ4OfMJ
        C4jNKaAnMfPLDbAaZgEziXmbHzJD2PIS29/OgbLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEj
        yypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAGNx27OeWHYxd74IPMQpwMCrx8Dpc/BEnxJpY
        VlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aHvJJ4Q1NDcwtL
        Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjFcY2ozDDhozO2Z0zD257iFXXEDW
        4mD+YxuS/v9K+qIbVbDNrrVOhGOhwTaRxkvGDEGLGCX+BjFyRYVILs093bC6j/eOwOb1qsU/
        bwtzV19e7qrs+c/qzsSH11xjj/1U3mLZJ+e5lbX/zOXTB/ZJ3/28+ZIn48N2pp8+N4pVOxbq
        VWqaXj+3RImlOCPRUIu5qDgRAKzpzFXXAgAA
X-CMS-MailID: 20200629085428eucas1p11249d948db0ab18926cab2c859422185
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3
References: <20200616081230.31198-1-m.szyprowski@samsung.com>
        <CGME20200616081249eucas1p151a8892ca0abfa3108955e1fc5054fc3@eucas1p1.samsung.com>
        <20200616081230.31198-2-m.szyprowski@samsung.com>
        <1f59ab26-94e8-6ee8-48f9-568cf1a0edfa@arm.com>
        <20200622171904.GA4174@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 22.06.2020 19:19, Krzysztof Kozlowski wrote:
> On Wed, Jun 17, 2020 at 05:26:58PM +0100, Lukasz Luba wrote:
>> I've give it a try with hotplug torture tests and has only one a minor
>> comment.
>>
>> On 6/16/20 9:12 AM, Marek Szyprowski wrote:
>>> The additional soft-reset call during little core power up was needed
>>> to properly boot all cores on the Exynos5422-based boards with secure
>>> firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
>>> CPUidle driver, which worked only on boards without secure firmware
>>> (like Peach-Pit/Pi Chromebooks).
>>>
>>> Apply the workaround only when board is running under secure firmware.
>>>
>>> Fixes: 833b 5794 e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
> Fix the Fixes tag (in case of resend, otherwise I'll do it).
>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>    arch/arm/mach-exynos/mcpm-exynos.c | 10 +++++++---
>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
>>> index 9a681b421ae1..cd861c57d5ad 100644
>>> --- a/arch/arm/mach-exynos/mcpm-exynos.c
>>> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>>> @@ -26,6 +26,7 @@
>>>    #define EXYNOS5420_USE_L2_COMMON_UP_STATE	BIT(30)
>>>    static void __iomem *ns_sram_base_addr __ro_after_init;
>>> +static bool secure_firmware __ro_after_init;
>>>    /*
>>>     * The common v7_exit_coherency_flush API could not be used because of the
>>> @@ -58,15 +59,16 @@ static void __iomem *ns_sram_base_addr __ro_after_init;
>>>    static int exynos_cpu_powerup(unsigned int cpu, unsigned int cluster)
>>>    {
>>>    	unsigned int cpunr = cpu + (cluster * EXYNOS5420_CPUS_PER_CLUSTER);
>>> +	bool state;
>>>    	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>>>    	if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>>>    		cluster >= EXYNOS5420_NR_CLUSTERS)
>>>    		return -EINVAL;
>>> -	if (!exynos_cpu_power_state(cpunr)) {
>>> -		exynos_cpu_power_up(cpunr);
>>> -
>>> +	state = exynos_cpu_power_state(cpunr);
>>> +	exynos_cpu_power_up(cpunr);
>> I can see that you have moved this call up, probably to avoid more
>> 'if-else' stuff. I just wanted to notify you that this function
>> 'exynos_cpu_powerup' is called twice when cpu is going up:
>> 1. by the already running cpu i.e. CPU0 and the 'state' is 0 for i.e.
>> CPU2
>> 2. by the newly starting cpu i.e. CPU2 by running
>> 'secondary_start_kernel' and the state is 3.
>>
>> In this scenario the 'exynos_cpu_power_up' will be called twice.
>> I have checked in hotplug that this is not causing any issues, but
>> thought maybe it's worth share it with you. Maybe you can double check
>> in TRM that this is not causing anything.
> This brings the old code, before 833b5794e33. I wonder why? I understood
> that only soft-reset should be skipped.

Because otherwise the Peach boards hangs during the cpuidle. I didn't 
analyze the code that much to judge if it is really necessary in all 
cases, I only restored what worked initially. I can add a comment about 
that to the commit log if needed.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

