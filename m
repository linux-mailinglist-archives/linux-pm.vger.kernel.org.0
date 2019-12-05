Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F34E113A06
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 03:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfLECmk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 21:42:40 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:61563 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfLECmj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 21:42:39 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191205024236epoutp03f27fdd850ff62a777f075cf4aa98eea7~dWWn83LF22038720387epoutp03I
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 02:42:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191205024236epoutp03f27fdd850ff62a777f075cf4aa98eea7~dWWn83LF22038720387epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575513756;
        bh=/AV8cj+Rs9i4o/YmUSbBp9ReMoY1GecfCLegvS5bIEI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OML49Db0atWrV5+4ve0rCS5S5qw1EHcDurQxlJqk7znjLfpXcPMU8lsU47oSuUI0F
         ixuUP2k2m33oH7AxsL2l/19LizJUeBsgwLwjan1JGvbMPX94HQCwR8k/7qVHtzFTwl
         U6a737NWFnAURjib+MxTm+wAm/rR8byTfx02SYho=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191205024235epcas1p4efff8c86dda4cd5a4e7a4b84fbbecfe1~dWWnk_Msw1080810808epcas1p4S;
        Thu,  5 Dec 2019 02:42:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47T0PP46jRzMqYlx; Thu,  5 Dec
        2019 02:42:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.C5.48019.99E68ED5; Thu,  5 Dec 2019 11:42:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205024233epcas1p17bce651f379f78abe435c2be1f1fb3e7~dWWlDdQ9m1651816518epcas1p1h;
        Thu,  5 Dec 2019 02:42:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205024233epsmtrp1b991c1c072a713d81582fa414d35b615~dWWlClvAz2961129611epsmtrp1R;
        Thu,  5 Dec 2019 02:42:33 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-86-5de86e99a8f4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.E5.06569.99E68ED5; Thu,  5 Dec 2019 11:42:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191205024233epsmtip1dd6db9d7ecbed2a18f9ed4a6a8fcf5f4~dWWkzfi9M0534105341epsmtip1W;
        Thu,  5 Dec 2019 02:42:32 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Kamil Konieczny <k.konieczny@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <99bc2b8a-8977-8020-f3d9-faac93416cd8@samsung.com>
Date:   Thu, 5 Dec 2019 11:48:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <635904ed-93e1-944b-9317-8c9a19844223@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOjqvV18x6G5R2KijDy1FXp8gKilrlj1EUFMo6uIMTd+Oc
        GTWD7IKZ1ZYUpatQMUsNsZaZhbpaQomW3W9mCVrZhSJXIV2gbcfIf8/7vM/D+z7f91KE5hKp
        pXJtTl6wcRaaVMmbb85LSii3DWUl19THshfLGhVs5XCZgvUMfCTYnp4LSvbOnk9K1jfwRME+
        vHaKZIOHOxBb1tMuYxs6+pRs7+5acvk4va/+AKm/dGaX3t1Uj/RB3wyDfEveEjPPmXghjrdl
        2025tpx0et0G4wqjbkEyk8AsYhfScTbOyqfTKzMMCatyLaGl6LhtnCU/RBk4UaSTli4R7PlO
        Ps5sF53pNO8wWRyLHIkiZxXzbTmJ2XbrYiY5OUUXEm7NM/vfu0nHZ357a2sJWYiK1pegKApw
        GtzoeiArQSpKg1sQuCvaSKkYRtB1zoOk4geCmneN6J/lpc9NSI02BNW3f8vDDQ3+gsB/gwnj
        aJwHP7rOEmFM4njwDz0jw3gyzoS283WKsJnAvTI4PPwzYp6IZ8LjkYHIBDVeCn8aXkUMcjwb
        AlUtEU0M3gSdzftGNZOgs3wwxFNUFF4GnoArTBN4KrwYrJBJOBb2Xj4ZWRTwQSWUnmkgpQQr
        ofaERyHhaPhwq0kpYS289xSN4gKo6+wgJXMxgib/vVFDKvhrjsrCgwk8DxqvJUn0TLj66zSS
        Bk+Az98PKcISwGooLtJIklnwsL9PJuFpUL3/AHkE0d4xabxjInjHRPD+H1aJ5PVoCu8QrTm8
        yDjSxv62D0UONp5tQa13MwIIU4gery70vcvSKLht4g5rAAFF0JPVzfAmS6M2cTtcvGA3CvkW
        XgwgXeixSwltTLY9dP42p5HRpaSmprJpzAIdw9BT1dTI/SwNzuGcfB7PO3jhn09GRWkL0aSR
        zXbjsehjHpVqfvBtbGCN58+h6wUpFe0n+5/0Z967moH21UXji3Mf2a98fb6wMq32+rP4p/7f
        H/oZ1y/DFq1+9reK5bFD3x53FwRblq1+zZr7Mru9hvntdPDnnaJe4fic4HS1OyWxe1dpefeF
        jU2m6rvC2uLNrqoJMYOq466dn2i5aOaYeEIQub/Y+5mQxgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnO7MvBexButu8VhsnLGe1WLBpxms
        Fv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN4nPvEUaLGef3MVmsPXKX3eJ24wo2B26PTas6
        2Tw2L6n36NuyitHj8ya5AJYoLpuU1JzMstQifbsEroz9L/vYCt6lVuzZ08XWwNgW1MXIySEh
        YCJxZ1MfcxcjF4eQwG5GiS9tV5kgEpIS0y4eBUpwANnCEocPF0PUvGWUWPbzMjNIjbBAtsS3
        08vAbDYBLYn9L26wgdgiAjESX9Y0soM0MAvcZZJY9+0DE0T3NWaJ+XMWsYNU8QsoSlz98ZgR
        xOYVsJP4u/YeWDeLgIrEoYU7WEBsUYEwiZ1LHjNB1AhKnJz5hAXkIk4Be4n+Q1UgYWYBdYk/
        8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfcsJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5q
        uV5xYm5xaV66XnJ+7iZGcKxpae1gPHEi/hCjAAejEg/vjS3PY4VYE8uKK3MPMUpwMCuJ8G6T
        eBorxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6YklqdmpqQWoRTJaJg1OqgTHzM8PS
        GCbeNAdZ4f2ZaTXxTT+yt8+89uVpfbN+YeJy2/CkT7430v6Xpy/t674gwvvmZLTiRvucjE/n
        mhYuvGXkr29u+PDT1lun2w7N2eWbO/NDXeQ9kQnv9lXN/Ces4b3hflzd4XdzTj4Qcay+YrSM
        8XT635OfSjjd5/J5CL9tec+cGjrLMVWJpTgj0VCLuag4EQDMimubsQIAAA==
X-CMS-MailID: 20191205024233epcas1p17bce651f379f78abe435c2be1f1fb3e7
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

On 11/14/19 4:38 PM, Chanwoo Choi wrote:
> Hi Kamil,
> 
> On 11/14/19 3:07 PM, Chanwoo Choi wrote:
>> Hi Kamil,
>>
>> On 11/14/19 12:12 AM, Kamil Konieczny wrote:
>>> Hi Chanwoo,
>>>
>>> On 14.10.2019 08:46, Chanwoo Choi wrote:
>>>> Hi Marek,
>>>>
>>>> On 19. 10. 11. 오후 8:33, Marek Szyprowski wrote:
>>>>> Hi Chanwoo,
>>>>>
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
>>>>>
>>>>> This issue is about something completely different. The OPPs defined in 
>>>>> DT cannot be applied, because it is not possible to derive the needed 
>>>>> clock rate from the bootloader-configured clock topology (mainly due to 
>>>>> lack of common divisor values for some of the parent clocks). Some time 
>>>>> ago Lukasz tried initially to redefine this clock topology using 
>>>>> assigned-clock-rates/parents properties (see 
>>>>> https://protect2.fireeye.com/url?k=4b80c0304459bc8e.4b814b7f-f87f1e1aee1a85c0&u=https://lkml.org/lkml/2019/7/15/276), but it has limitations and some 
>>>>> such changes has to be done in bootloader. Until this is resolved, 
>>>>> devfreq simply cannot set some of the defined OPPs.
>>>>
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
>>>
>>> I can add 'assigned-clock-*' to DT, but the issue is caused in opp points,
>>> so the warning from exynos-bus will still be there.
>>>
>>> Before this fix, devfreq will issue warning and then change clock to max
>>> frequency within opp range. This fix mask warning, and as Marek and
>>> Lukasz Luba wrotes, the proper fix will be to make changes in u-boot
>>> (and connect proper PLLs to IPs).
>>
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
> 
> Just I tried to add 'assigned-clock-rates' property to initialize
> the clock rate of some bus node as following on odroid-xu3 board:
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 829147e320e0..9a237af5436a 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -42,6 +42,8 @@
>  };
>  
>  &bus_wcore {
> +       assigned-clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
> +       assigned-clock-rates = <400000000>;
>         devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
>                         <&nocp_mem1_0>, <&nocp_mem1_1>;
>         vdd-supply = <&buck3_reg>;
> @@ -50,11 +52,15 @@
>  };
>  
>  &bus_noc {
> +       assigned-clocks = <&clock CLK_DOUT_ACLK100_NOC>;
> +       assigned-clock-rates = <100000000>;
>         devfreq = <&bus_wcore>;
>         status = "okay";
>  };
>  
>  &bus_fsys_apb {
> +       assigned-clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
> +       assigned-clock-rates = <200000000>;
>         devfreq = <&bus_wcore>;
>         status = "okay";
>  };
> @@ -120,6 +126,8 @@
>  };
>  
>  &bus_mscl {
> +       assigned-clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
> +       assigned-clock-rates = <400000000>;
>         devfreq = <&bus_wcore>;
>         status = "okay";
>  };
> 
> 
> In result,
> [Before on v5.4-rc6, failed to set the rate by dev_pm_opp_set_rate()]
> [    4.855811] exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
> [    4.863374] exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
> [    4.871240] exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
> [    4.879509] exynos-bus: new bus device registered: soc:bus_fsys (100000 KHz ~ 200000 KHz)
> [    4.887957] exynos-bus: new bus device registered: soc:bus_fsys2 ( 75000 KHz ~ 150000 KHz)
> [    4.896361] exynos-bus: new bus device registered: soc:bus_mfc ( 96000 KHz ~ 333000 KHz)
> [    4.904330] exynos-bus: new bus device registered: soc:bus_gen ( 89000 KHz ~ 267000 KHz)
> [    4.911802] exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
> [    4.912710] exynos-bus: new bus device registered: soc:bus_peri ( 67000 KHz ~  67000 KHz)
> [    4.924655] exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
> [    4.932125] exynos-bus: new bus device registered: soc:bus_g2d ( 84000 KHz ~ 333000 KHz)
> [    4.939607] exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
> [    4.949758] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 67000 KHz ~ 267000 KHz)
> [    4.966991] exynos-bus: new bus device registered: soc:bus_jpeg ( 75000 KHz ~ 300000 KHz)
> [    4.975136] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 84000 KHz ~ 167000 KHz)
> [    4.983452] exynos-bus: new bus device registered: soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
> [    4.992218] exynos-bus: new bus device registered: soc:bus_disp1 (120000 KHz ~ 300000 KHz)
> [    5.000483] exynos-bus: new bus device registered: soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
> [    5.009331] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 400000 KHz)
> [    5.020207] exynos-bus soc:bus_mscl: dev_pm_opp_set_rate: failed to find current OPP for freq 666000000 (-34)
> 
> [After applied the 'assigned-clock-*' patch on v5.4-rc6]
> [    4.840571] exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
> [    4.848099] exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
> [    4.856016] exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
> [    4.864307] exynos-bus: new bus device registered: soc:bus_fsys (100000 KHz ~ 200000 KHz)
> [    4.872723] exynos-bus: new bus device registered: soc:bus_fsys2 ( 75000 KHz ~ 150000 KHz)
> [    4.881124] exynos-bus: new bus device registered: soc:bus_mfc ( 96000 KHz ~ 333000 KHz)
> [    4.889147] exynos-bus: new bus device registered: soc:bus_gen ( 89000 KHz ~ 267000 KHz)
> [    4.896867] exynos-bus: new bus device registered: soc:bus_peri ( 67000 KHz ~  67000 KHz)
> [    4.907430] exynos-bus: new bus device registered: soc:bus_g2d ( 84000 KHz ~ 333000 KHz)
> [    4.914797] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 67000 KHz ~ 267000 KHz)
> [    4.923205] exynos-bus: new bus device registered: soc:bus_jpeg ( 75000 KHz ~ 300000 KHz)
> [    4.931352] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 84000 KHz ~ 167000 KHz)
> [    4.939658] exynos-bus: new bus device registered: soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
> [    4.948401] exynos-bus: new bus device registered: soc:bus_disp1 (120000 KHz ~ 300000 KHz)
> [    4.956650] exynos-bus: new bus device registered: soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
> [    4.965573] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 400000 KHz)
> 

Actually, I don't want to leave this problem on mainline.
We have to need to fix the fail of exynos-bus registration for kernel booting.
Please reply your opinion or send the fix-up patch as I commented above.

> 
>>>
>>> Second solution would be to write down new OPP points with currently used
>>> frequencies, and with max one for 532 MHz.
>>>
>>>> I think that the previous patch[1] of Kamil Konieczny is missing
>>>> the patches which initialize the clock rate on DT file.
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4294a779bd8dff6c65e7e85ffe7a1ea236e92a68
>>>>
>>>>>
>>>>> This issue was there from the beginning, recent Kamil's patch only 
>>>>> revealed it. In fact it was even worse - devfreq and common clock 
>>>>> framework silently set lower clock than the given OPP defined.
>>>>>
>>>>>>> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
>>>>>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>>>>> ---
>>>>>>>   drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>>>>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>>>>> index c832673273a2..37bd34d5625b 100644
>>>>>>> --- a/drivers/devfreq/exynos-bus.c
>>>>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>>>>> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>>>   {
>>>>>>>   	struct device *dev = bus->dev;
>>>>>>>   	struct dev_pm_opp *opp;
>>>>>>> -	unsigned long rate;
>>>>>>> +	unsigned long rate, opp_rate;
>>>>>>>   	int ret;
>>>>>>>   
>>>>>>>   	/* Get the clock to provide each bus with source clock */
>>>>>>> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>>>   	}
>>>>>>>   
>>>>>>>   	rate = clk_get_rate(bus->clk);
>>>>>>> -
>>>>>>> -	opp = devfreq_recommended_opp(dev, &rate, 0);
>>>>>>> +	opp_rate = rate;
>>>>>>> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>>>>>>>   	if (IS_ERR(opp)) {
>>>>>>>   		dev_err(dev, "failed to find dev_pm_opp\n");
>>>>>>>   		ret = PTR_ERR(opp);
>>>>>>>   		goto err_opp;
>>>>>>>   	}
>>>>>>> +	/*
>>>>>>> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
>>>>>>> +	 * in clock rate outside defined OPP rate. Work around this bug by
>>>>>>> +	 * setting clock rate to recommended one.
>>>>>>> +	 */
>>>>>>> +	if (rate > opp_rate)
>>>>>>> +		clk_set_rate(bus->clk, opp_rate);
>>>>>>> +
>>>>>>>   	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>>>>>   	dev_pm_opp_put(opp);
>>>>>>>   
>>>>>>>
>>>>>>
>>>>> Best regards
>>>>>
>>>>
>>>>
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
