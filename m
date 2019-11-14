Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20F5FBFFA
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 07:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKNGCB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 01:02:01 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:20752 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNGCB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 01:02:01 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191114060157epoutp049e5c61dcf6cc97bab2cc6a1440dbc847~W8hr07pEf0876408764epoutp04Q
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 06:01:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191114060157epoutp049e5c61dcf6cc97bab2cc6a1440dbc847~W8hr07pEf0876408764epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573711317;
        bh=844ttLUpNaaPNiYTmal0WcOkLi3t0g8bvltfaZY1WMc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VBYQcNJQ1iVNHjtoMtIsf0jCA1BJO3EQRz+CWpVBs2r1VuP4QKMXy3zDqeXRSq1zg
         PNDynsc3i7IWj8txMXkZA8sPR3XcQbHHSUu+hEXXKIAHsetN796T5eIK2eFKsZCnqP
         8r6IBl/eNGiQvLYwCWkc3odzhhZPbqpgvMlTLqJM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191114060156epcas1p16c31d92b8a67fe418f70844229933091~W8hrbCU_n2708227082epcas1p1W;
        Thu, 14 Nov 2019 06:01:56 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47D9q658vBzMqYkn; Thu, 14 Nov
        2019 06:01:54 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.86.04068.2DDECCD5; Thu, 14 Nov 2019 15:01:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191114060153epcas1p439994a9d2b13c795d4c91d3e86d24c24~W8honRn_j2958129581epcas1p4g;
        Thu, 14 Nov 2019 06:01:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114060153epsmtrp269df35d7f834333cbe5b05004f6757af~W8homjPdy0512805128epsmtrp2b;
        Thu, 14 Nov 2019 06:01:53 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-1e-5dccedd259b1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.74.24756.1DDECCD5; Thu, 14 Nov 2019 15:01:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114060153epsmtip1cb6f59fbc93e5ea722e2eda400d1f728~W8hoWvjWh2319423194epsmtip1T;
        Thu, 14 Nov 2019 06:01:53 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
To:     Kamil Konieczny <k.konieczny@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9e0a4aa6-46a6-3ca6-42db-11ed55b468dd@samsung.com>
Date:   Thu, 14 Nov 2019 15:07:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dd5bc937-e776-f717-1cf3-ee0e17621304@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0gUURTmzuzOjtXWbc06bVHbRJDSqpNtjZE96LWUlFBED8QGHVZzH8PO
        allU2lvLXhrpZiSUWkKpq5mJtmVSLFZGllgRGUpZlpHa0167O0b++84533fP+c69lyY19ZSW
        TrI6BLuVNzPUMEX17eAw/aMP92LDM9+EcBV5ZUru6I0/iCvszVNyxzq6Sa65uVzF3d/zXsW5
        OlqVXEttAcX1ZTciLq/5BsFdbnyh4p5nXKQWjjC6SjMpY+WF3cZbPXWE8WhVKTL2uSbFKDcm
        z0sU+ATBrhOs8baEJKspilm5Jm5xnGF2OKtnI7k5jM7KW4QoZkl0jH5Zktk7HqNL5c0p3lQM
        L0lM2Px5dluKQ9Al2iRHFCOICWYxUgyVeIuUYjWFxtssc9nw8JkGL3FzcuLJvXaxjNtWUp5B
        paNOfRYKoAHPgpy77VQWGkZrcA2Cbnc7IQe9CPK7H5Fy8AVB9rVa4p+kJqcFyYV6BO9enh3U
        f0TwqadL4WMF4mT40lRM+vAYvBOOpTtVPhKJnxOQ3fvDT6JwCLi72igfHoWnwJNvHciH1Xg+
        fM8942+nwNPgleurl0PTQXg9NH3mZcpo8OR3+o8JwAvge+2AyodJPA6edZ4jZDwZ9l4947cA
        OEcFBT/eItnCEnicXz2IA+Hd3SqVjLXQ11NPyXgHXPI0UrL4EIIq90OlXIgAd1EO4RuIxMFQ
        Vhsmp6fA9YGzSG48Eno+H1H6KIDVcOiARqZMhZb2F4NbHA/nD2ZSxxHjHGLHOcSCc4gF5/9m
        hUhRisYKomQxCRIrGobetgv5n25IZA268yC6AWEaMSPUN4PuxWqUfKqUZmlAQJPMGPV0qzel
        TuDTtgt2W5w9xSxIDcjgXfYJUhsUb/N+BKsjjjXMjIiI4Gaxsw0sy4xTLyopitVgE+8QkgVB
        FOz/dAQdoE1HE+qe9q/Q7DcV/Hav1vRXNSm3pgVuXxzd1rg2d3/mwi2t+l/MU3W/OGPTwfrc
        S/s8w5df6ZpWk6abW1HSeidrILB1fHD/zverQtu11y6fJo2Hl55+9bou5mr0vulbO6s9Xyeu
        i00/lXG7YUNG4YW2ioFJHZWndn1b6/mZtOAcUZwqHgkLZRRSIs+GkHaJ/wtmJ1T90AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSnO7Ft2diDTZ8NrTYOGM9q0Xfvv+M
        Fgs+zWC16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFrcbV7A5
        8HhsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY1JzUcF6i4rlGxrZ
        Ghif6HYxcnJICJhI7Jh8mbGLkYtDSGA3o8TKOefYIBKSEtMuHmXuYuQAsoUlDh8uhqh5yyjx
        p+84E0iNsEC2xLfTy8BqRARqJTq+SIPUMAvcZZJY9+0DE0TDGyaJv28PgA1lE9CS2P/iBpjN
        L6AocfXHY0YQm1fATuLnlNlgQ1kEVCUebvoOViMqECHxfPsNqBpBiZMzn7CA2JwC9hI/d/1m
        B7GZBdQl/sy7xAxhi0vcejKfCcKWl2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnp
        ucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHRp6W5g/HykvhDjAIcjEo8vAdEz8QKsSaWFVfmHmKU
        4GBWEuHVyAMK8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnV
        wMhgu4O/dV5UyOZU268PF0xrWySRWP527z03Z+sTN07MvTIvPSMs9+2i66EnBFfLPzQ9MV0j
        0TlpT61JX1+v0YwZa9nu+Fg/7BK4v8JNpeD6T6OM1kMFJqceMm/h2ZWflXp6q0Kp0OeUzh3n
        PYMu2zzqWdD/d1v4ysK7M//ce9pxwCzrzgQTx51KLMUZiYZazEXFiQA966KAugIAAA==
X-CMS-MailID: 20191114060153epcas1p439994a9d2b13c795d4c91d3e86d24c24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b
References: <CGME20191008134950eucas1p15cfef5800efc10d5b18ec5eb37dde60b@eucas1p1.samsung.com>
        <20191008134923.30123-1-k.konieczny@partner.samsung.com>
        <4f14d3af-e455-d05b-fc03-cba58e001f41@samsung.com>
        <0ce56e65-d989-18f8-af84-2fbd74ba20aa@samsung.com>
        <d742e7be-ca79-ae9e-6cc2-dc1fae08d252@samsung.com>
        <dd5bc937-e776-f717-1cf3-ee0e17621304@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

On 11/14/19 12:12 AM, Kamil Konieczny wrote:
> Hi Chanwoo,
> 
> On 14.10.2019 08:46, Chanwoo Choi wrote:
>> Hi Marek,
>>
>> On 19. 10. 11. 오후 8:33, Marek Szyprowski wrote:
>>> Hi Chanwoo,
>>>
>>> On 10.10.2019 04:50, Chanwoo Choi wrote:
>>>> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>>>>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>>>>> dev_pm_opp_set_rate()") introduced errors:
>>>>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>>>>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>>>>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>>>>> ...
>>>>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>>>>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>>>>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>>>>
>>>>> They are caused by incorrect PLL assigned to clock source, which results
>>>>> in clock rate outside of OPP range. Add workaround for this in
>>>>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
>>>> If the clock caused this issue, you can set the initial clock on DeviceTree
>>>> with assigned-clock-* properties. Because the probe time of clock driver
>>>> is early than the any device drivers.
>>>>
>>>> It is not proper to fix the clock issue on other device driver.
>>>> I think you can fix it by using the supported clock properties.
>>>
>>> This issue is about something completely different. The OPPs defined in 
>>> DT cannot be applied, because it is not possible to derive the needed 
>>> clock rate from the bootloader-configured clock topology (mainly due to 
>>> lack of common divisor values for some of the parent clocks). Some time 
>>> ago Lukasz tried initially to redefine this clock topology using 
>>> assigned-clock-rates/parents properties (see 
>>> https://protect2.fireeye.com/url?k=4b80c0304459bc8e.4b814b7f-f87f1e1aee1a85c0&u=https://lkml.org/lkml/2019/7/15/276), but it has limitations and some 
>>> such changes has to be done in bootloader. Until this is resolved, 
>>> devfreq simply cannot set some of the defined OPPs.
>>
>> As you mentioned, the wrong setting in bootloader cause the this issue.
>> So, this patch change the rate on exynos-bus.c in order to fix
>> the issue with workaround style. 
>>
>> But, also, it can be fixed by initializing the clock rate on DT
>> although it is not fundamental solution as you mentioned.
>>
>> If above two method are workaround way, I think that set the clock
>> rate in DT is proper. The role of 'assigned-clock-*' properties
>> is for this case in order to set the initial frequency on probe time.
> 
> I can add 'assigned-clock-*' to DT, but the issue is caused in opp points,
> so the warning from exynos-bus will still be there.
> 
> Before this fix, devfreq will issue warning and then change clock to max
> frequency within opp range. This fix mask warning, and as Marek and
> Lukasz Luba wrotes, the proper fix will be to make changes in u-boot
> (and connect proper PLLs to IPs).

PLL could be changed by clock device driver in the linux kernel.
If you don't add the supported frequency into PLL frequency table 
of clock device driver, will fail to change the wanted frequency
on the linux kernel. It means that it is not fixed by only touching
the bootloader. 

As you commented, the wrong opp points which are specified on dt
cause this issue. Usually, have to initialize the clock rate on dt
by using 'assigned-clocks-*' property and then use the clock
with the preferable clock rate. I think that we have to fix
the fundamental problem. 

Without bootloader problem, you can fix it by initializing
the clock on dt with 'assigned-clocks-*' property.

As I knew that it is correct way and I always tried to do this method
for resolving the similar clock issue.

Lastly, I think that my opinion is more simple and correct.
It could give the more correct information to linux kernel user
which refer to the device tree file.

1. Your suggestion 
	a. Add opp-table with unsupported frequency on dt
	b. Try to change the clock rate on exynos-bus.c by using unsupported frequency from opp-table
	c. If failed, retry to change the clock rate on exynos-bus.c

2. My opinion
	a. Initialize the PLL or any clock by using assigned-clock-* property on dt
	   and add opp-table with supported frequency on dt
	b. Try to change the clock rate on exynos-bus.c by using supported frequency from opp-table

> 
> Second solution would be to write down new OPP points with currently used
> frequencies, and with max one for 532 MHz.
> 
>> I think that the previous patch[1] of Kamil Konieczny is missing
>> the patches which initialize the clock rate on DT file.
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4294a779bd8dff6c65e7e85ffe7a1ea236e92a68
>>
>>>
>>> This issue was there from the beginning, recent Kamil's patch only 
>>> revealed it. In fact it was even worse - devfreq and common clock 
>>> framework silently set lower clock than the given OPP defined.
>>>
>>>>> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
>>>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>>> ---
>>>>>   drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>>> index c832673273a2..37bd34d5625b 100644
>>>>> --- a/drivers/devfreq/exynos-bus.c
>>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>>> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>   {
>>>>>   	struct device *dev = bus->dev;
>>>>>   	struct dev_pm_opp *opp;
>>>>> -	unsigned long rate;
>>>>> +	unsigned long rate, opp_rate;
>>>>>   	int ret;
>>>>>   
>>>>>   	/* Get the clock to provide each bus with source clock */
>>>>> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>   	}
>>>>>   
>>>>>   	rate = clk_get_rate(bus->clk);
>>>>> -
>>>>> -	opp = devfreq_recommended_opp(dev, &rate, 0);
>>>>> +	opp_rate = rate;
>>>>> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>>>>>   	if (IS_ERR(opp)) {
>>>>>   		dev_err(dev, "failed to find dev_pm_opp\n");
>>>>>   		ret = PTR_ERR(opp);
>>>>>   		goto err_opp;
>>>>>   	}
>>>>> +	/*
>>>>> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
>>>>> +	 * in clock rate outside defined OPP rate. Work around this bug by
>>>>> +	 * setting clock rate to recommended one.
>>>>> +	 */
>>>>> +	if (rate > opp_rate)
>>>>> +		clk_set_rate(bus->clk, opp_rate);
>>>>> +
>>>>>   	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>>>   	dev_pm_opp_put(opp);
>>>>>   
>>>>>
>>>>
>>> Best regards
>>>
>>
>>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
