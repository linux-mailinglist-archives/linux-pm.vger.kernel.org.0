Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB968114A68
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 02:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfLFBTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 20:19:13 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:42713 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLFBTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 20:19:12 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191206011909epoutp010fb77f70c5dba3872127f5c75d0a6641~do3C0wUaJ1046010460epoutp01X
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 01:19:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191206011909epoutp010fb77f70c5dba3872127f5c75d0a6641~do3C0wUaJ1046010460epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575595149;
        bh=r3tMXv0TpIy9rfTL1uGD4ABEaKCsaJoN4EThtD4tc28=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oII3LuBaSB/OJ7TyAzNvo+K3ctoJsnE9NQLCLzlXfRhlgwaGHBDYIRC7xE9C22jA5
         r4W6pIvhZUK1l6fS5aVqobIbgPf9Jy+z2DD4NCG4UW+QGgr1+Cx6iw8U1TO+CAdA4j
         d2uAXle6jvpmhDnG8Uo1y6dH0oZ1ZPCKi9YyRZic=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206011908epcas1p1e762a030e25a1f0601ca1d829ffa7f7c~do3CO4wbB2626026260epcas1p1t;
        Fri,  6 Dec 2019 01:19:08 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47TZVd6PfszMqYkX; Fri,  6 Dec
        2019 01:19:05 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.CD.51241.98CA9ED5; Fri,  6 Dec 2019 10:19:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191206011905epcas1p1e78d075bda03abf4a2546883c21ae0b0~do2-XQixH1735217352epcas1p1W;
        Fri,  6 Dec 2019 01:19:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191206011905epsmtrp12f1ec31403685519d987a1821c82d0cb~do2-WcvcE0669706697epsmtrp1d;
        Fri,  6 Dec 2019 01:19:05 +0000 (GMT)
X-AuditID: b6c32a39-163ff7000001c829-50-5de9ac893e20
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.A5.10238.98CA9ED5; Fri,  6 Dec 2019 10:19:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206011905epsmtip1639079fe456066b43e75fcc622ca1f96~do2-GD4wj2662826628epsmtip1D;
        Fri,  6 Dec 2019 01:19:05 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d33badc0-95be-bf2d-588c-b01e6d4cb7a1@samsung.com>
Date:   Fri, 6 Dec 2019 10:25:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <de72b641-c150-0368-b0bd-f46c87a8c2d0@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmvm7nmpexBo8+mlhsnLGe1WLBpxms
        Fv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN4nPvEUaLGef3MVmsPXKX3eJ24wo2B26PTas6
        2Tw2L6n36NuyitHj8ya5AJaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnF
        pXnpesn5uVaGBgZGpkCFCdkZt1bvZix4aF1xa94U1gbGF/pdjJwcEgImEn+3vGIFsYUEdjBK
        bGio62LkArI/MUq8vneaEcL5xijxbN43ZpiOO/s/MUMk9jJK3J/1lAnCec8oMaH5NBNIlbBA
        tsS308vAOkQEYiQmL/0G1sEscJtJovfTLxaQBJuAlsT+FzfYQGx+AUWJqz8eM4LYvAJ2Emuf
        vQSLswioSFy9+xpskKhAmMTJbS1QNYISJ2c+AZvDKWAv0fX8LVg9s4C4xK0n85kgbHmJ5q2z
        wRZLCDSzS5xtnsMI8YOLxO0pa9ghbGGJV8e3QNlSEi/726DsaomVJ4+wQTR3MEps2X+BFSJh
        LLF/6WSgDRxAGzQl1u+ChqSixM7fcxkhFvNJvPvawwpSIiHAK9HRJgRRoixx+cFdJghbUmJx
        eyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJT5OjexAhOsVqWOxiPnfM5xCjA
        wajEwzvj84tYIdbEsuLK3EOMEhzMSiK86XwvY4V4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhy
        PjD955XEG5oaGRsbW5gYmpkaGiqJ83L8uBgrJJCeWJKanZpakFoE08fEwSnVwDjxcOSzP4d/
        PJowI8n0199u82scps78P2dYzPvPPvvCZJVfr4zkIz8bqXEr2bgUFDA/nKjItXqhN3tgYX5q
        RLnkvcD2W3MUFv0wepvw0SlC4qGDx/XuzqMO0xfO17+9/ueeuD9bd24XU/xQv7n6gG2W7ocf
        yT81pxjGrY7mmnwg7mZN1pvvEpOVWIozEg21mIuKEwEDvRsuxwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnG7nmpexBrt7BSw2zljParHg0wxW
        i/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbA7fHplWd
        bB6bl9R79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8at1bsZCx5aV9yaN4W1gfGFfhcjJ4eE
        gInEnf2fmEFsIYHdjBIrv7pDxCUlpl08ChTnALKFJQ4fLu5i5AIqecsosf7WE0aQGmGBbIlv
        p5eB9YoIxEicObSDFaSIWeAuk8S6bx+YIIZ2s0i0rRcBsdkEtCT2v7jBBmLzCyhKXP3xGGwQ
        r4CdxNpnL8HiLAIqElfvvgYbKioQJrFzyWMmiBpBiZMzn7CA2JwC9hJdz9+C1TMLqEv8mXeJ
        GcIWl7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WK
        E3OLS/PS9ZLzczcxgiNNS3MH4+Ul8YcYBTgYlXh4Z3x+ESvEmlhWXJl7iFGCg1lJhDed72Ws
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwy4ivaNMuC
        16TX+Kn8MavgmlDvOzH4bEiy1Pfbhpduxrnwlty/f2nNul9HmF1nr70QrDSX45KeZdvRSZnp
        a5kfbe+pUufi4TW8eeya5o7+jR9kD6YttGONLvYOa0z+qvTYgUW7a/uc1cubNLanbU0q5mDv
        SvpXqLRRPuKbkkS2waSyt+WHGpRYijMSDbWYi4oTAYgRWjewAgAA
X-CMS-MailID: 20191206011905epcas1p1e78d075bda03abf4a2546883c21ae0b0
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
        <9e0a4aa6-46a6-3ca6-42db-11ed55b468dd@samsung.com>
        <635904ed-93e1-944b-9317-8c9a19844223@samsung.com>
        <de72b641-c150-0368-b0bd-f46c87a8c2d0@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 12/5/19 8:23 PM, Marek Szyprowski wrote:
> Hi
> 
> On 14.11.2019 08:38, Chanwoo Choi wrote:
>> On 11/14/19 3:07 PM, Chanwoo Choi wrote:
>>> On 11/14/19 12:12 AM, Kamil Konieczny wrote:
>>>> On 14.10.2019 08:46, Chanwoo Choi wrote:
>>>>> On 19. 10. 11. 오후 8:33, Marek Szyprowski wrote:
>>>>>> On 10.10.2019 04:50, Chanwoo Choi wrote:
>>>>>>> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>>>>>>>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>>>>>>>> dev_pm_opp_set_rate()") introduced errors:
>>>>>>>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>>>>>>>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>>>>>>>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>>>>>>>> ...
>>>>>>>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>>>>>>>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>>>>>>>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>>>>>>>
>>>>>>>> They are caused by incorrect PLL assigned to clock source, which results
>>>>>>>> in clock rate outside of OPP range. Add workaround for this in
>>>>>>>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
>>>>>>> If the clock caused this issue, you can set the initial clock on DeviceTree
>>>>>>> with assigned-clock-* properties. Because the probe time of clock driver
>>>>>>> is early than the any device drivers.
>>>>>>>
>>>>>>> It is not proper to fix the clock issue on other device driver.
>>>>>>> I think you can fix it by using the supported clock properties.
>>>>>> This issue is about something completely different. The OPPs defined in
>>>>>> DT cannot be applied, because it is not possible to derive the needed
>>>>>> clock rate from the bootloader-configured clock topology (mainly due to
>>>>>> lack of common divisor values for some of the parent clocks). Some time
>>>>>> ago Lukasz tried initially to redefine this clock topology using
>>>>>> assigned-clock-rates/parents properties (see
>>>>>> https://protect2.fireeye.com/url?k=4b80c0304459bc8e.4b814b7f-f87f1e1aee1a85c0&u=https://lkml.org/lkml/2019/7/15/276), but it has limitations and some
>>>>>> such changes has to be done in bootloader. Until this is resolved,
>>>>>> devfreq simply cannot set some of the defined OPPs.
>>>>> As you mentioned, the wrong setting in bootloader cause the this issue.
>>>>> So, this patch change the rate on exynos-bus.c in order to fix
>>>>> the issue with workaround style.
>>>>>
>>>>> But, also, it can be fixed by initializing the clock rate on DT
>>>>> although it is not fundamental solution as you mentioned.
>>>>>
>>>>> If above two method are workaround way, I think that set the clock
>>>>> rate in DT is proper. The role of 'assigned-clock-*' properties
>>>>> is for this case in order to set the initial frequency on probe time.
>>>> I can add 'assigned-clock-*' to DT, but the issue is caused in opp points,
>>>> so the warning from exynos-bus will still be there.
>>>>
>>>> Before this fix, devfreq will issue warning and then change clock to max
>>>> frequency within opp range. This fix mask warning, and as Marek and
>>>> Lukasz Luba wrotes, the proper fix will be to make changes in u-boot
>>>> (and connect proper PLLs to IPs).
>>> PLL could be changed by clock device driver in the linux kernel.
>>> If you don't add the supported frequency into PLL frequency table
>>> of clock device driver, will fail to change the wanted frequency
>>> on the linux kernel. It means that it is not fixed by only touching
>>> the bootloader.
>>>
>>> As you commented, the wrong opp points which are specified on dt
>>> cause this issue. Usually, have to initialize the clock rate on dt
>>> by using 'assigned-clocks-*' property and then use the clock
>>> with the preferable clock rate. I think that we have to fix
>>> the fundamental problem.
>>>
>>> Without bootloader problem, you can fix it by initializing
>>> the clock on dt with 'assigned-clocks-*' property.
>>>
>>> As I knew that it is correct way and I always tried to do this method
>>> for resolving the similar clock issue.
>>>
>>> Lastly, I think that my opinion is more simple and correct.
>>> It could give the more correct information to linux kernel user
>>> which refer to the device tree file.
>>>
>>> 1. Your suggestion
>>> 	a. Add opp-table with unsupported frequency on dt
>>> 	b. Try to change the clock rate on exynos-bus.c by using unsupported frequency from opp-table
>>> 	c. If failed, retry to change the clock rate on exynos-bus.c
>>>
>>> 2. My opinion
>>> 	a. Initialize the PLL or any clock by using assigned-clock-* property on dt
>>> 	   and add opp-table with supported frequency on dt
>>> 	b. Try to change the clock rate on exynos-bus.c by using supported frequency from opp-table
>>>
>> Just I tried to add 'assigned-clock-rates' property to initialize
>> the clock rate of some bus node as following on odroid-xu3 board:
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> index 829147e320e0..9a237af5436a 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -42,6 +42,8 @@
>>   };
>>   
>>   &bus_wcore {
>> +       assigned-clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
>> +       assigned-clock-rates = <400000000>;
>>          devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
>>                          <&nocp_mem1_0>, <&nocp_mem1_1>;
>>          vdd-supply = <&buck3_reg>;
>> @@ -50,11 +52,15 @@
>>   };
>>   
>>   &bus_noc {
>> +       assigned-clocks = <&clock CLK_DOUT_ACLK100_NOC>;
>> +       assigned-clock-rates = <100000000>;
>>          devfreq = <&bus_wcore>;
>>          status = "okay";
>>   };
>>   
>>   &bus_fsys_apb {
>> +       assigned-clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
>> +       assigned-clock-rates = <200000000>;
>>          devfreq = <&bus_wcore>;
>>          status = "okay";
>>   };
>> @@ -120,6 +126,8 @@
>>   };
>>   
>>   &bus_mscl {
>> +       assigned-clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
>> +       assigned-clock-rates = <400000000>;
>>          devfreq = <&bus_wcore>;
>>          status = "okay";
>>   };
> 
> 
> Well, this is a poor workaround. There is indeed no warning, but the 
> clock rates are far from the specified in the device tree. For WCORE 
> assigned-clock-rates = <400000000> on Odroid XU3/XU4 kernel will set 
> dout_aclk400_wcore clock to 266MHz, because it is not possible to derive 
> 400MHz from 532MHz MPLL...

Ah. You're right. It seems that my mistake of original patch of bus_wcore_opp_table.
I think that OPP table has the wrong OPP entries.

> 
> I plan to measure the impact of different rates on the performance of 
> the various components and overall power consumption. Only then IMHO it 
> makes sense to decide if we really should adjust OPPs to the current 
> PLLs configuration (-> basically define following OPPs for WCORE: 
> 532MHz, 266MHz, 133MHZ and 77MHz) or change PLL configuration and 
> re-parent WCORE to 1200MHz to properly drive: 400MHz, 300MHz, 200MHz and 
> 100MHz.
I agree your both suggestions. 

> 
> Other devfreq buses should IMHO use the values similar to the selected 
> for WCORE.
> 
> Best regards
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
