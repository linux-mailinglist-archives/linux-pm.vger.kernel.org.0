Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C7FB355
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfKMPMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 10:12:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40161 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfKMPMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 10:12:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191113151243euoutp01d5cb4cefa9af0aa94278a97f18db2d16~WwZRvC6VY0598505985euoutp01J
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 15:12:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191113151243euoutp01d5cb4cefa9af0aa94278a97f18db2d16~WwZRvC6VY0598505985euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573657963;
        bh=RiDiIT7iZ5uWRSjJDpfwksM+DRbkVa+LCl9cMMehqnI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tGXerBJ7Va5Aq7PP8dnmiz2KrZLnS/JofvI6jykP6ykDrjWcLbmeOkxA2AbBtKBlG
         BQza9yLSGjzgEPyCQOn3kxME2+T2rJRgs2G8KKzSkuExgEkhPDhWBA+W2KcsvOoA8s
         Mas6grB5W5AOTo7+ViQNfPiRIvS5iLl+Kd4G8/ME=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191113151242eucas1p19f54308ea4dd5ef747b4f485b803195a~WwZRYuPz-0444904449eucas1p1j;
        Wed, 13 Nov 2019 15:12:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.1C.04469.A6D1CCD5; Wed, 13
        Nov 2019 15:12:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191113151242eucas1p1e8b0d203e369ebfd09e6f1a0a1dcbb38~WwZQ8Azu10439304393eucas1p1z;
        Wed, 13 Nov 2019 15:12:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191113151242eusmtrp10b8b131e00d6d2b819161bb99d21f889~WwZQ7Vhb_2223022230eusmtrp1y;
        Wed, 13 Nov 2019 15:12:42 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-71-5dcc1d6acedf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D0.BE.04117.A6D1CCD5; Wed, 13
        Nov 2019 15:12:42 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191113151241eusmtip15dedb606b73b17597ce4871c94296be2~WwZQYnjNx0590005900eusmtip14;
        Wed, 13 Nov 2019 15:12:41 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <dd5bc937-e776-f717-1cf3-ee0e17621304@samsung.com>
Date:   Wed, 13 Nov 2019 16:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d742e7be-ca79-ae9e-6cc2-dc1fae08d252@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD163bbpaFkKRAmoBBL0IgKEq9NUNDEaH/4Q/8Y1KCssnIX0uXG
        RPBAIdASRUUwVAyXRQRLJYQokbOUFrkMIngQAZuIEKXQID9A2sXIvzfvvZk3kwyBSTpwDyJa
        nsQo5HScVCDiN3X/6d8ds8UUtme5zYd6WVyPUx8WzDilbF1FlGpyBqP6+xuEVN/1n0JKOzmC
        U8MtjwWUpaATUcX9rTyqrvOzkBrPrhEccZRpNbkCWWPFNVnb3GueTKnTIJlF63UKPyc6FMHE
        RacwioDgcFHUikbLS3y/M62xawxloW6fPORAALkPRgyFwjwkIiRkDYJJkwXjigUESsNHnCss
        CAxLOehfi9ZcxOOEagQDo2rEFbMIinJrBTaXCxkLVmMVZsOuZBrkq/LtczFynAcF88t8myAg
        A6Ctz2DHYjIYrOoeewSf9IUq8/RaBEG4kaFgXKQ5izMYHk3Z7Q5kCAy809jnY6Q7jE2peRz2
        hhuvSu1ZQI4IQVNZKuTWPgZ60zzGYRf4odet85vBeC+fz+FUmC5XCrnmmwgmbv9eF4KgQz+I
        2xbCyB1Q3xLA0Udh9uswstFAOsHorDO3gxPcbXqIcbQY7uRIOLcvmHvzeRz2hLzVF3ghkpZs
        uKxkwzUlG64p+Z/7BPE1yJ1JZuMjGTZQzqT6s3Q8myyP9L+cEK9Fa69lXNHPN6PFoUvtiCSQ
        1FH81s0UJsHpFDY9vh0BgUldxc1pPWEScQSdnsEoEi4qkuMYth15Enypuzhz08R5CRlJJzGx
        DJPIKP6pPMLBIws90McUXzl92F++9dPBNHRC56VzjcgtS1o4WT3Y8D3bU6AyagqGKhlFzcJI
        8pu88tmZvcWC1Ja5jMxQ66/EOF0wMVpqsT799kx3NpOWHqhI8LtVt225K/iL1nu7Z4iP24XB
        Xc+tV7OP9y7NBe0Pr1Opl8cazZHRZVL6/pn5idrVDCmfjaID/TAFS/8F3cqc4VYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7pZsmdiDdp3c1hsnLGe1eL6l+es
        Fn37/jNa9D9+zWxx/vwGdouzTW/YLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12i9uNK9gc
        eDw2repk89i8pN7j4Ls9TB59W1YxenzeJBfAGqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2Ri
        qWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8W/VJqaCK9oVm4/eYmxgPKbcxcjJISFgIrHp+RSm
        LkYuDiGBpYwSV9bMZYZISEs0nl7NBGELS/y51sUGUfSaUaLn4js2kISwQLbEt9PLwBpEBCok
        tlybATaJWeAuk8S6bx+gxm5nkrj88QULSBWbgL7EwbMnwWxeATuJb/NPMILYLAKqEsuePwVb
        JyoQIfF8+w1GiBpBiZMzn4DVcwrYS1w4twpsG7OAusSfeZegbHGJW0/mM0HY8hLNW2czT2AU
        moWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMFK3Hfu5ZQdj17vg
        Q4wCHIxKPLwSEmdihVgTy4orcw8xSnAwK4nw7qg4ESvEm5JYWZValB9fVJqTWnyI0RTouYnM
        UqLJ+cAkklcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgXGd9U3D
        ujuPZypsvbx/1fuUH/cOifmVPHFZq3Krp/5WfmYrs5iv2gvRk8575031/n+k9frzuZNqTHqn
        drwQ2/7d9/Mm3Z2rwgxm/XE6Ee/ZkRv0bIpprcpGLifnXUtWfFy6YkfcU36hLdLZpjPqzSvK
        r1q7e3/X2LVt1rHCQhVt1adFLwU+ya9VYinOSDTUYi4qTgQAEWC1r+oCAAA=
X-CMS-MailID: 20191113151242eucas1p1e8b0d203e369ebfd09e6f1a0a1dcbb38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
References: <CGME20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b@eucas1p1.samsung.com>
        <20191008134923.30123-1-k.konieczny@partner.samsung.com>
        <4f14d3af-e455-d05b-fc03-cba58e001f41@samsung.com>
        <0ce56e65-d989-18f8-af84-2fbd74ba20aa@samsung.com>
        <d742e7be-ca79-ae9e-6cc2-dc1fae08d252@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 14.10.2019 08:46, Chanwoo Choi wrote:
> Hi Marek,
> 
> On 19. 10. 11. 오후 8:33, Marek Szyprowski wrote:
>> Hi Chanwoo,
>>
>> On 10.10.2019 04:50, Chanwoo Choi wrote:
>>> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>>>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>>>> dev_pm_opp_set_rate()") introduced errors:
>>>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>>>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>>>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>>>> ...
>>>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>>>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>>>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>>>
>>>> They are caused by incorrect PLL assigned to clock source, which results
>>>> in clock rate outside of OPP range. Add workaround for this in
>>>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
>>> If the clock caused this issue, you can set the initial clock on DeviceTree
>>> with assigned-clock-* properties. Because the probe time of clock driver
>>> is early than the any device drivers.
>>>
>>> It is not proper to fix the clock issue on other device driver.
>>> I think you can fix it by using the supported clock properties.
>>
>> This issue is about something completely different. The OPPs defined in 
>> DT cannot be applied, because it is not possible to derive the needed 
>> clock rate from the bootloader-configured clock topology (mainly due to 
>> lack of common divisor values for some of the parent clocks). Some time 
>> ago Lukasz tried initially to redefine this clock topology using 
>> assigned-clock-rates/parents properties (see 
>> https://protect2.fireeye.com/url?k=4b80c0304459bc8e.4b814b7f-f87f1e1aee1a85c0&u=https://lkml.org/lkml/2019/7/15/276), but it has limitations and some 
>> such changes has to be done in bootloader. Until this is resolved, 
>> devfreq simply cannot set some of the defined OPPs.
> 
> As you mentioned, the wrong setting in bootloader cause the this issue.
> So, this patch change the rate on exynos-bus.c in order to fix
> the issue with workaround style. 
> 
> But, also, it can be fixed by initializing the clock rate on DT
> although it is not fundamental solution as you mentioned.
> 
> If above two method are workaround way, I think that set the clock
> rate in DT is proper. The role of 'assigned-clock-*' properties
> is for this case in order to set the initial frequency on probe time.

I can add 'assigned-clock-*' to DT, but the issue is caused in opp points,
so the warning from exynos-bus will still be there.

Before this fix, devfreq will issue warning and then change clock to max
frequency within opp range. This fix mask warning, and as Marek and
Lukasz Luba wrotes, the proper fix will be to make changes in u-boot
(and connect proper PLLs to IPs).

Second solution would be to write down new OPP points with currently used
frequencies, and with max one for 532 MHz.

> I think that the previous patch[1] of Kamil Konieczny is missing
> the patches which initialize the clock rate on DT file.
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4294a779bd8dff6c65e7e85ffe7a1ea236e92a68
> 
>>
>> This issue was there from the beginning, recent Kamil's patch only 
>> revealed it. In fact it was even worse - devfreq and common clock 
>> framework silently set lower clock than the given OPP defined.
>>
>>>> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
>>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>> ---
>>>>   drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>> index c832673273a2..37bd34d5625b 100644
>>>> --- a/drivers/devfreq/exynos-bus.c
>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>   {
>>>>   	struct device *dev = bus->dev;
>>>>   	struct dev_pm_opp *opp;
>>>> -	unsigned long rate;
>>>> +	unsigned long rate, opp_rate;
>>>>   	int ret;
>>>>   
>>>>   	/* Get the clock to provide each bus with source clock */
>>>> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>   	}
>>>>   
>>>>   	rate = clk_get_rate(bus->clk);
>>>> -
>>>> -	opp = devfreq_recommended_opp(dev, &rate, 0);
>>>> +	opp_rate = rate;
>>>> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>>>>   	if (IS_ERR(opp)) {
>>>>   		dev_err(dev, "failed to find dev_pm_opp\n");
>>>>   		ret = PTR_ERR(opp);
>>>>   		goto err_opp;
>>>>   	}
>>>> +	/*
>>>> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
>>>> +	 * in clock rate outside defined OPP rate. Work around this bug by
>>>> +	 * setting clock rate to recommended one.
>>>> +	 */
>>>> +	if (rate > opp_rate)
>>>> +		clk_set_rate(bus->clk, opp_rate);
>>>> +
>>>>   	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>>   	dev_pm_opp_put(opp);
>>>>   
>>>>
>>>
>> Best regards
>>
> 
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

