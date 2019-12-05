Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C01114009
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 12:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfLELX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 06:23:27 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46772 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 06:23:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191205112325euoutp029ad6be4f16e2bd09468fc10c09b723ac~dddWh5jv72434024340euoutp02Z
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 11:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191205112325euoutp029ad6be4f16e2bd09468fc10c09b723ac~dddWh5jv72434024340euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575545005;
        bh=4cZz6jB9XqYzT/+qcSSKXwM6MSppAW1MvQ8WfWj920M=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=IGK0NmSQwxVg2PkeYxtFFkcLqnL3hUi01p7d4jxcAOWVkz+4D1x3IVTCysVj8BYcg
         XWNaf15HUonk654wu3R75iqbKVRwCVolOzE3J5xvyVHaS4dj+a9dOxKfKPeiO+ofTf
         4aq/pT+B8o1MifLsTwUK80xZ3UtuSttyh5+QbUls=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205112324eucas1p1655be95b30dc529a1be583b878b6cc56~dddV5P-AS1131911319eucas1p1E;
        Thu,  5 Dec 2019 11:23:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 62.63.61286.CA8E8ED5; Thu,  5
        Dec 2019 11:23:24 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191205112324eucas1p2f8a449e76cd80ecbe8eeee6fdb5ee85f~dddVlTDf42069020690eucas1p2r;
        Thu,  5 Dec 2019 11:23:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205112324eusmtrp186f6072b724ed9277abbc3a249002fa8~dddVkjH-f1370513705eusmtrp1E;
        Thu,  5 Dec 2019 11:23:24 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-60-5de8e8ac70bd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.F1.07950.BA8E8ED5; Thu,  5
        Dec 2019 11:23:23 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191205112323eusmtip1f0505dc253968033d941192647daf571~dddU7LGZh1180011800eusmtip1H;
        Thu,  5 Dec 2019 11:23:23 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <de72b641-c150-0368-b0bd-f46c87a8c2d0@samsung.com>
Date:   Thu, 5 Dec 2019 12:23:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <635904ed-93e1-944b-9317-8c9a19844223@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87prXryINZh4XMhi44z1rBbXvzxn
        tVjwaQarRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz+Nx7hNFixvl9TBa3G1ewOXB7bFrV
        yeaxeUm9R9+WVYwenzfJBbBEcdmkpOZklqUW6dslcGWc2LGKteCURcW0EyeZGhgX6HYxcnJI
        CJhIbN/4khHEFhJYwSjRulO0i5ELyP7CKDH9VgsbROIzo8SfTheYhhOrJ7NCxJczSjS9KoBo
        eMsoseHdB3aQBJuAoUTX2y6wZmGBbIlvp5cxg9giAnkSHXevsoM0MAvcZpLo/fSLpYuRg4NX
        wE7ixklVkBoWARWJLad3gYVFBWIlOpZngIR5BQQlTs58AhbmFLCX6D9UBRJmFhCXuPVkPhOE
        LS/RvHU2M8h0CYFz7BLty++zQ9zsInFxbSszhC0s8er4Fqi4jMTpyT0sEA3NjBIPz61lh3B6
        GCUuN81ghKiyljh8/CIryGZmAU2J9bv0IcKOEm/vX2YECUsI8EnceCsIcQSfxKRt05khwrwS
        HW1CENVqErOOr4Nbe/DCJeYJjEqzkHw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJ
        ucWleel6yfm5mxiBien0v+OfdjB+vZR0iFGAg1GJh7dh0/NYIdbEsuLK3EOMEhzMSiK82ySe
        xgrxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg3PbOoFSZ
        i4VFZ+9TuY/vNid48b65tlrvkoqU7bE5B3/w9El6SllmP+acsyc4xY3pwXMx7c0Ld/GYhl27
        HK6z5fyDBVPb1p2KqbZwYrjerMM9f+Gk1c7fWKZMvfVyluGrXoUpBXdsjv/UibrS7vqk7ZFh
        vMipt0WtNzXSZt/8lBB4TOV3rHv+QSWW4oxEQy3mouJEADClLldIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7qrX7yINTi429Ji44z1rBbXvzxn
        tVjwaQarRf/j18wW589vYLc42/SG3WLT42usFpd3zWGz+Nx7hNFixvl9TBa3G1ewOXB7bFrV
        yeaxeUm9R9+WVYwenzfJBbBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GWc2LGKteCURcW0EyeZGhgX6HYxcnJICJhInFg9mbWLkYtDSGApo8TK
        eR/YIRIyEienNbBC2MISf651sUEUvWaUmPptF1iCTcBQoustSIKTQ1ggW+Lb6WXMILaIQJ7E
        vp7JLCANzAJ3mSTWffvABNF9jVli/pxFQCs4OHgF7CRunFQFaWARUJHYcnoXC4gtKhAr8X3l
        J0YQm1dAUOLkzCcsIOWcAvYS/YeqQMLMAmYS8zY/ZIawxSVuPZnPBGHLSzRvnc08gVFoFpLu
        WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAiNx27OeWHYxd74IPMQpw
        MCrx8DZseh4rxJpYVlyZe4hRgoNZSYR3m8TTWCHelMTKqtSi/Pii0pzU4kOMpkC/TWSWEk3O
        ByaLvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjBqyZ6tF2fZN
        DPyaJuHKGVz5vWLuSm6OM1yqfq/iy9b8OOPdGH60dJGcj5DFlCxfwX1GM97evXl1otRZS4mM
        vKRK2xPOyWoXzlgq6O2U/HRUJmrLjdVPtKwnTp2uMuFlgCWvZPiqWdcCxZ7YiUVtEeSwmXys
        NE/pcxFD/5mNIfyT5WN5dkxepsRSnJFoqMVcVJwIAPxb/mHeAgAA
X-CMS-MailID: 20191205112324eucas1p2f8a449e76cd80ecbe8eeee6fdb5ee85f
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
        <dd5bc937-e776-f717-1cf3-ee0e17621304@samsung.com>
        <9e0a4aa6-46a6-3ca6-42db-11ed55b468dd@samsung.com>
        <635904ed-93e1-944b-9317-8c9a19844223@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

On 14.11.2019 08:38, Chanwoo Choi wrote:
> On 11/14/19 3:07 PM, Chanwoo Choi wrote:
>> On 11/14/19 12:12 AM, Kamil Konieczny wrote:
>>> On 14.10.2019 08:46, Chanwoo Choi wrote:
>>>> On 19. 10. 11. 오후 8:33, Marek Szyprowski wrote:
>>>>> On 10.10.2019 04:50, Chanwoo Choi wrote:
>>>>>> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>>>>>>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>>>>>>> dev_pm_opp_set_rate()") introduced errors:
>>>>>>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>>>>>>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>>>>>>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>>>>>>> ...
>>>>>>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>>>>>>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>>>>>>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>>>>>>
>>>>>>> They are caused by incorrect PLL assigned to clock source, which results
>>>>>>> in clock rate outside of OPP range. Add workaround for this in
>>>>>>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
>>>>>> If the clock caused this issue, you can set the initial clock on DeviceTree
>>>>>> with assigned-clock-* properties. Because the probe time of clock driver
>>>>>> is early than the any device drivers.
>>>>>>
>>>>>> It is not proper to fix the clock issue on other device driver.
>>>>>> I think you can fix it by using the supported clock properties.
>>>>> This issue is about something completely different. The OPPs defined in
>>>>> DT cannot be applied, because it is not possible to derive the needed
>>>>> clock rate from the bootloader-configured clock topology (mainly due to
>>>>> lack of common divisor values for some of the parent clocks). Some time
>>>>> ago Lukasz tried initially to redefine this clock topology using
>>>>> assigned-clock-rates/parents properties (see
>>>>> https://protect2.fireeye.com/url?k=4b80c0304459bc8e.4b814b7f-f87f1e1aee1a85c0&u=https://lkml.org/lkml/2019/7/15/276), but it has limitations and some
>>>>> such changes has to be done in bootloader. Until this is resolved,
>>>>> devfreq simply cannot set some of the defined OPPs.
>>>> As you mentioned, the wrong setting in bootloader cause the this issue.
>>>> So, this patch change the rate on exynos-bus.c in order to fix
>>>> the issue with workaround style.
>>>>
>>>> But, also, it can be fixed by initializing the clock rate on DT
>>>> although it is not fundamental solution as you mentioned.
>>>>
>>>> If above two method are workaround way, I think that set the clock
>>>> rate in DT is proper. The role of 'assigned-clock-*' properties
>>>> is for this case in order to set the initial frequency on probe time.
>>> I can add 'assigned-clock-*' to DT, but the issue is caused in opp points,
>>> so the warning from exynos-bus will still be there.
>>>
>>> Before this fix, devfreq will issue warning and then change clock to max
>>> frequency within opp range. This fix mask warning, and as Marek and
>>> Lukasz Luba wrotes, the proper fix will be to make changes in u-boot
>>> (and connect proper PLLs to IPs).
>> PLL could be changed by clock device driver in the linux kernel.
>> If you don't add the supported frequency into PLL frequency table
>> of clock device driver, will fail to change the wanted frequency
>> on the linux kernel. It means that it is not fixed by only touching
>> the bootloader.
>>
>> As you commented, the wrong opp points which are specified on dt
>> cause this issue. Usually, have to initialize the clock rate on dt
>> by using 'assigned-clocks-*' property and then use the clock
>> with the preferable clock rate. I think that we have to fix
>> the fundamental problem.
>>
>> Without bootloader problem, you can fix it by initializing
>> the clock on dt with 'assigned-clocks-*' property.
>>
>> As I knew that it is correct way and I always tried to do this method
>> for resolving the similar clock issue.
>>
>> Lastly, I think that my opinion is more simple and correct.
>> It could give the more correct information to linux kernel user
>> which refer to the device tree file.
>>
>> 1. Your suggestion
>> 	a. Add opp-table with unsupported frequency on dt
>> 	b. Try to change the clock rate on exynos-bus.c by using unsupported frequency from opp-table
>> 	c. If failed, retry to change the clock rate on exynos-bus.c
>>
>> 2. My opinion
>> 	a. Initialize the PLL or any clock by using assigned-clock-* property on dt
>> 	   and add opp-table with supported frequency on dt
>> 	b. Try to change the clock rate on exynos-bus.c by using supported frequency from opp-table
>>
> Just I tried to add 'assigned-clock-rates' property to initialize
> the clock rate of some bus node as following on odroid-xu3 board:
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 829147e320e0..9a237af5436a 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -42,6 +42,8 @@
>   };
>   
>   &bus_wcore {
> +       assigned-clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
> +       assigned-clock-rates = <400000000>;
>          devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
>                          <&nocp_mem1_0>, <&nocp_mem1_1>;
>          vdd-supply = <&buck3_reg>;
> @@ -50,11 +52,15 @@
>   };
>   
>   &bus_noc {
> +       assigned-clocks = <&clock CLK_DOUT_ACLK100_NOC>;
> +       assigned-clock-rates = <100000000>;
>          devfreq = <&bus_wcore>;
>          status = "okay";
>   };
>   
>   &bus_fsys_apb {
> +       assigned-clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
> +       assigned-clock-rates = <200000000>;
>          devfreq = <&bus_wcore>;
>          status = "okay";
>   };
> @@ -120,6 +126,8 @@
>   };
>   
>   &bus_mscl {
> +       assigned-clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
> +       assigned-clock-rates = <400000000>;
>          devfreq = <&bus_wcore>;
>          status = "okay";
>   };


Well, this is a poor workaround. There is indeed no warning, but the 
clock rates are far from the specified in the device tree. For WCORE 
assigned-clock-rates = <400000000> on Odroid XU3/XU4 kernel will set 
dout_aclk400_wcore clock to 266MHz, because it is not possible to derive 
400MHz from 532MHz MPLL...

I plan to measure the impact of different rates on the performance of 
the various components and overall power consumption. Only then IMHO it 
makes sense to decide if we really should adjust OPPs to the current 
PLLs configuration (-> basically define following OPPs for WCORE: 
532MHz, 266MHz, 133MHZ and 77MHz) or change PLL configuration and 
re-parent WCORE to 1200MHz to properly drive: 400MHz, 300MHz, 200MHz and 
100MHz.

Other devfreq buses should IMHO use the values similar to the selected 
for WCORE.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

