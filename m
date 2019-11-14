Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FEAFC0CE
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 08:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKNHdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 02:33:42 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:31383 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfKNHdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 02:33:42 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191114073336epoutp017bfc1ba3fa3853ec4f836fc1c8c8d103~W9xtuNgcK2482424824epoutp01E
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 07:33:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191114073336epoutp017bfc1ba3fa3853ec4f836fc1c8c8d103~W9xtuNgcK2482424824epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573716817;
        bh=+SI7PvgsA1hnFDSbbfdJq4eYpxhrXcsxbd8raCZ2420=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sjH0v8sVyyXfgCm8z+LqBlZkBI1wVGhHODOcddNyid9OFVNPptMMHF75m59on5cEx
         7s5zncD9OYN2KrvRMDAp5BAddgiWUMMbhaK1dWjcg6Mc2u/QY2RaVwuDVLvHjMatiU
         UFvYZraogaJsLaao8HwzyKlwEeVuW2CWWV5cNtoQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191114073336epcas1p48bf43710df8074d1c96c61fe3bc13157~W9xtT5oIi2772227722epcas1p4D;
        Thu, 14 Nov 2019 07:33:36 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47DCrj5CnpzMqYkp; Thu, 14 Nov
        2019 07:33:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.5F.04135.8230DCD5; Thu, 14 Nov 2019 16:32:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191114073255epcas1p33eaaaf25d260219a0c11fbbc47fc949c~W9xHFVghS1538315383epcas1p3C;
        Thu, 14 Nov 2019 07:32:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114073255epsmtrp2dd61f7672f117256e7552f646de595ab~W9xHEYwT32025920259epsmtrp2S;
        Thu, 14 Nov 2019 07:32:55 +0000 (GMT)
X-AuditID: b6c32a36-7e3ff70000001027-8e-5dcd03289ed2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.6B.24756.7230DCD5; Thu, 14 Nov 2019 16:32:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191114073255epsmtip2518ef28fb08e947876a9e69d3b60cecb~W9xGtYNil3103831038epsmtip2X;
        Thu, 14 Nov 2019 07:32:55 +0000 (GMT)
Subject: Re: [PATCH] devfreq: exynos-bus: workaround dev_pm_opp_set_rate()
 errors on Exynos5422/5800 SoCs
From:   Chanwoo Choi <cw00.choi@samsung.com>
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
Organization: Samsung Electronics
Message-ID: <635904ed-93e1-944b-9317-8c9a19844223@samsung.com>
Date:   Thu, 14 Nov 2019 16:38:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9e0a4aa6-46a6-3ca6-42db-11ed55b468dd@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmvq4G89lYg63L2Sw2zljPatG37z+j
        xYJPM1gt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xe3GFWwO
        PB6bVnWyeWxeUu9x8N0eJo++LasYPT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6T0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQndF9+jRzQX9ixdSta5kaGLf4dTFyckgImEgc
        vvSIpYuRi0NIYAejxPuvM1lBEkICnxglmjdHQiS+MUqsmD2bDabj1dy5TBCJvYwSj++uZodw
        3jNKfLoxjx2kSlggW+Lb6WXMIDabgJbE/hc3wLpFBGol+htmgTUwC9xmkuj99IsFJMEvoChx
        9cdjRhCbV8BO4vGpn2A2i4CqxOkJV4GaOThEBSIkTn9NhCgRlDg58wlYK6eAvcSbt0fAbGYB
        cYlbT+YzQdjyEs1bZzOD7JIQmMwusazjHzPECy4S638ugrKFJV4d38IOYUtJfH63F+rNaomV
        J4+wQTR3MEps2X+BFSJhLLF/6WQmkIOYBTQl1u/ShwgrSuz8PZcRYjGfxLuvPawgJRICvBId
        bUIQJcoSlx/cZYKwJSUWt3eyTWBUmoXknVlIXpiF5IVZCMsWMLKsYhRLLSjOTU8tNiwwQo7t
        TYzgpKtltoNx0TmfQ4wCHIxKPLwHRM/ECrEmlhVX5h5ilOBgVhLhnfIWKMSbklhZlVqUH19U
        mpNafIjRFBjYE5mlRJPzgRkhryTe0NTI2NjYwsTQzNTQUEmc13H50lghgfTEktTs1NSC1CKY
        PiYOTqkGxk7WA/Me3D21yq2bX6zzu5K80nKzKOOXGs2ng8xdFu0s2zGj2rqzdsOZE7umBgTN
        8jq3lN2+vLRsuYR+7QR1tVN24Su/PQ4WsBbKdKt7+bB49+roU9xR3/8J/D3p//9u7AetnW9m
        iC07WmHZ5mcYL3m6YZkQb4dmbci+vn8dwhs+nvKbqeL8SYmlOCPRUIu5qDgRAH9wgh/QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK4689lYg8P7RCw2zljPatG37z+j
        xYJPM1gt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xe3GFWwO
        PB6bVnWyeWxeUu9x8N0eJo++LasYPT5vkgtgjeKySUnNySxLLdK3S+DK6D59mrmgP7Fi6ta1
        TA2MW/y6GDk5JARMJF7NncvUxcjFISSwm1Hi1vovTBAJSYlpF48ydzFyANnCEocPF0PUvGWU
        aP/9hg2kRlggW+Lb6WXMIDabgJbE/hc32EDqRQRqJTq+SIPUMwvcZZJY9+0D1IKFzBLHD+9k
        BGngF1CUuPrjMZjNK2An8fjUTzCbRUBV4vSEq2ALRAUiJJ5vvwFVIyhxcuYTFhCbU8Be4s3b
        I2A2s4C6xJ95l5ghbHGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3
        PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4/rQ0dzBeXhJ/iFGAg1GJh/eA6JlYIdbEsuLK3EOM
        EhzMSiK8U94ChXhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCU
        amDsVpzcd9F4UW594rM7Wmo+nt9vztscqr9UKemIypPZ1V2a0TFBeocOPFp5zGHLtDsXzuX8
        22Po52bqr7i08tu1R26TYuTWPnsb2vBAh8++b/m5b6HZcil7myzf3V98d2Hv89z1vfpO7ulV
        UlO1/rL1bXAxk593dPIB09ja3H+ZSzZvvC9haJSkxFKckWioxVxUnAgA3256aLsCAAA=
X-CMS-MailID: 20191114073255epcas1p33eaaaf25d260219a0c11fbbc47fc949c
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
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

On 11/14/19 3:07 PM, Chanwoo Choi wrote:
> Hi Kamil,
> 
> On 11/14/19 12:12 AM, Kamil Konieczny wrote:
>> Hi Chanwoo,
>>
>> On 14.10.2019 08:46, Chanwoo Choi wrote:
>>> Hi Marek,
>>>
>>> On 19. 10. 11. 오후 8:33, Marek Szyprowski wrote:
>>>> Hi Chanwoo,
>>>>
>>>> On 10.10.2019 04:50, Chanwoo Choi wrote:
>>>>> On 2019년 10월 08일 22:49, k.konieczny@partner.samsung.com wrote:
>>>>>> Commit 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use
>>>>>> dev_pm_opp_set_rate()") introduced errors:
>>>>>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>>>>>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>>>>>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>>>>>> ...
>>>>>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>>>>>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>>>>>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>>>>>
>>>>>> They are caused by incorrect PLL assigned to clock source, which results
>>>>>> in clock rate outside of OPP range. Add workaround for this in
>>>>>> exynos_bus_parse_of() by adjusting clock rate to those present in OPP.
>>>>> If the clock caused this issue, you can set the initial clock on DeviceTree
>>>>> with assigned-clock-* properties. Because the probe time of clock driver
>>>>> is early than the any device drivers.
>>>>>
>>>>> It is not proper to fix the clock issue on other device driver.
>>>>> I think you can fix it by using the supported clock properties.
>>>>
>>>> This issue is about something completely different. The OPPs defined in 
>>>> DT cannot be applied, because it is not possible to derive the needed 
>>>> clock rate from the bootloader-configured clock topology (mainly due to 
>>>> lack of common divisor values for some of the parent clocks). Some time 
>>>> ago Lukasz tried initially to redefine this clock topology using 
>>>> assigned-clock-rates/parents properties (see 
>>>> https://protect2.fireeye.com/url?k=4b80c0304459bc8e.4b814b7f-f87f1e1aee1a85c0&u=https://lkml.org/lkml/2019/7/15/276), but it has limitations and some 
>>>> such changes has to be done in bootloader. Until this is resolved, 
>>>> devfreq simply cannot set some of the defined OPPs.
>>>
>>> As you mentioned, the wrong setting in bootloader cause the this issue.
>>> So, this patch change the rate on exynos-bus.c in order to fix
>>> the issue with workaround style. 
>>>
>>> But, also, it can be fixed by initializing the clock rate on DT
>>> although it is not fundamental solution as you mentioned.
>>>
>>> If above two method are workaround way, I think that set the clock
>>> rate in DT is proper. The role of 'assigned-clock-*' properties
>>> is for this case in order to set the initial frequency on probe time.
>>
>> I can add 'assigned-clock-*' to DT, but the issue is caused in opp points,
>> so the warning from exynos-bus will still be there.
>>
>> Before this fix, devfreq will issue warning and then change clock to max
>> frequency within opp range. This fix mask warning, and as Marek and
>> Lukasz Luba wrotes, the proper fix will be to make changes in u-boot
>> (and connect proper PLLs to IPs).
> 
> PLL could be changed by clock device driver in the linux kernel.
> If you don't add the supported frequency into PLL frequency table 
> of clock device driver, will fail to change the wanted frequency
> on the linux kernel. It means that it is not fixed by only touching
> the bootloader. 
> 
> As you commented, the wrong opp points which are specified on dt
> cause this issue. Usually, have to initialize the clock rate on dt
> by using 'assigned-clocks-*' property and then use the clock
> with the preferable clock rate. I think that we have to fix
> the fundamental problem. 
> 
> Without bootloader problem, you can fix it by initializing
> the clock on dt with 'assigned-clocks-*' property.
> 
> As I knew that it is correct way and I always tried to do this method
> for resolving the similar clock issue.
> 
> Lastly, I think that my opinion is more simple and correct.
> It could give the more correct information to linux kernel user
> which refer to the device tree file.
> 
> 1. Your suggestion 
> 	a. Add opp-table with unsupported frequency on dt
> 	b. Try to change the clock rate on exynos-bus.c by using unsupported frequency from opp-table
> 	c. If failed, retry to change the clock rate on exynos-bus.c
> 
> 2. My opinion
> 	a. Initialize the PLL or any clock by using assigned-clock-* property on dt
> 	   and add opp-table with supported frequency on dt
> 	b. Try to change the clock rate on exynos-bus.c by using supported frequency from opp-table
> 

Just I tried to add 'assigned-clock-rates' property to initialize
the clock rate of some bus node as following on odroid-xu3 board:

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 829147e320e0..9a237af5436a 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -42,6 +42,8 @@
 };
 
 &bus_wcore {
+       assigned-clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
+       assigned-clock-rates = <400000000>;
        devfreq-events = <&nocp_mem0_0>, <&nocp_mem0_1>,
                        <&nocp_mem1_0>, <&nocp_mem1_1>;
        vdd-supply = <&buck3_reg>;
@@ -50,11 +52,15 @@
 };
 
 &bus_noc {
+       assigned-clocks = <&clock CLK_DOUT_ACLK100_NOC>;
+       assigned-clock-rates = <100000000>;
        devfreq = <&bus_wcore>;
        status = "okay";
 };
 
 &bus_fsys_apb {
+       assigned-clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
+       assigned-clock-rates = <200000000>;
        devfreq = <&bus_wcore>;
        status = "okay";
 };
@@ -120,6 +126,8 @@
 };
 
 &bus_mscl {
+       assigned-clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
+       assigned-clock-rates = <400000000>;
        devfreq = <&bus_wcore>;
        status = "okay";
 };


In result,
[Before on v5.4-rc6, failed to set the rate by dev_pm_opp_set_rate()]
[    4.855811] exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
[    4.863374] exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
[    4.871240] exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
[    4.879509] exynos-bus: new bus device registered: soc:bus_fsys (100000 KHz ~ 200000 KHz)
[    4.887957] exynos-bus: new bus device registered: soc:bus_fsys2 ( 75000 KHz ~ 150000 KHz)
[    4.896361] exynos-bus: new bus device registered: soc:bus_mfc ( 96000 KHz ~ 333000 KHz)
[    4.904330] exynos-bus: new bus device registered: soc:bus_gen ( 89000 KHz ~ 267000 KHz)
[    4.911802] exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
[    4.912710] exynos-bus: new bus device registered: soc:bus_peri ( 67000 KHz ~  67000 KHz)
[    4.924655] exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
[    4.932125] exynos-bus: new bus device registered: soc:bus_g2d ( 84000 KHz ~ 333000 KHz)
[    4.939607] exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
[    4.949758] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 67000 KHz ~ 267000 KHz)
[    4.966991] exynos-bus: new bus device registered: soc:bus_jpeg ( 75000 KHz ~ 300000 KHz)
[    4.975136] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 84000 KHz ~ 167000 KHz)
[    4.983452] exynos-bus: new bus device registered: soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
[    4.992218] exynos-bus: new bus device registered: soc:bus_disp1 (120000 KHz ~ 300000 KHz)
[    5.000483] exynos-bus: new bus device registered: soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
[    5.009331] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 400000 KHz)
[    5.020207] exynos-bus soc:bus_mscl: dev_pm_opp_set_rate: failed to find current OPP for freq 666000000 (-34)

[After applied the 'assigned-clock-*' patch on v5.4-rc6]
[    4.840571] exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
[    4.848099] exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
[    4.856016] exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
[    4.864307] exynos-bus: new bus device registered: soc:bus_fsys (100000 KHz ~ 200000 KHz)
[    4.872723] exynos-bus: new bus device registered: soc:bus_fsys2 ( 75000 KHz ~ 150000 KHz)
[    4.881124] exynos-bus: new bus device registered: soc:bus_mfc ( 96000 KHz ~ 333000 KHz)
[    4.889147] exynos-bus: new bus device registered: soc:bus_gen ( 89000 KHz ~ 267000 KHz)
[    4.896867] exynos-bus: new bus device registered: soc:bus_peri ( 67000 KHz ~  67000 KHz)
[    4.907430] exynos-bus: new bus device registered: soc:bus_g2d ( 84000 KHz ~ 333000 KHz)
[    4.914797] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 67000 KHz ~ 267000 KHz)
[    4.923205] exynos-bus: new bus device registered: soc:bus_jpeg ( 75000 KHz ~ 300000 KHz)
[    4.931352] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 84000 KHz ~ 167000 KHz)
[    4.939658] exynos-bus: new bus device registered: soc:bus_disp1_fimd (120000 KHz ~ 200000 KHz)
[    4.948401] exynos-bus: new bus device registered: soc:bus_disp1 (120000 KHz ~ 300000 KHz)
[    4.956650] exynos-bus: new bus device registered: soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
[    4.965573] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 400000 KHz)


>>
>> Second solution would be to write down new OPP points with currently used
>> frequencies, and with max one for 532 MHz.
>>
>>> I think that the previous patch[1] of Kamil Konieczny is missing
>>> the patches which initialize the clock rate on DT file.
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4294a779bd8dff6c65e7e85ffe7a1ea236e92a68
>>>
>>>>
>>>> This issue was there from the beginning, recent Kamil's patch only 
>>>> revealed it. In fact it was even worse - devfreq and common clock 
>>>> framework silently set lower clock than the given OPP defined.
>>>>
>>>>>> Fixes: 4294a779bd8d ("PM / devfreq: exynos-bus: Convert to use dev_pm_opp_set_rate()")
>>>>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>>>>>> ---
>>>>>>   drivers/devfreq/exynos-bus.c | 14 +++++++++++---
>>>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>>>>>> index c832673273a2..37bd34d5625b 100644
>>>>>> --- a/drivers/devfreq/exynos-bus.c
>>>>>> +++ b/drivers/devfreq/exynos-bus.c
>>>>>> @@ -243,7 +243,7 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>>   {
>>>>>>   	struct device *dev = bus->dev;
>>>>>>   	struct dev_pm_opp *opp;
>>>>>> -	unsigned long rate;
>>>>>> +	unsigned long rate, opp_rate;
>>>>>>   	int ret;
>>>>>>   
>>>>>>   	/* Get the clock to provide each bus with source clock */
>>>>>> @@ -267,13 +267,21 @@ static int exynos_bus_parse_of(struct device_node *np,
>>>>>>   	}
>>>>>>   
>>>>>>   	rate = clk_get_rate(bus->clk);
>>>>>> -
>>>>>> -	opp = devfreq_recommended_opp(dev, &rate, 0);
>>>>>> +	opp_rate = rate;
>>>>>> +	opp = devfreq_recommended_opp(dev, &opp_rate, 0);
>>>>>>   	if (IS_ERR(opp)) {
>>>>>>   		dev_err(dev, "failed to find dev_pm_opp\n");
>>>>>>   		ret = PTR_ERR(opp);
>>>>>>   		goto err_opp;
>>>>>>   	}
>>>>>> +	/*
>>>>>> +	 * FIXME: U-boot leaves clock source at incorrect PLL, this results
>>>>>> +	 * in clock rate outside defined OPP rate. Work around this bug by
>>>>>> +	 * setting clock rate to recommended one.
>>>>>> +	 */
>>>>>> +	if (rate > opp_rate)
>>>>>> +		clk_set_rate(bus->clk, opp_rate);
>>>>>> +
>>>>>>   	bus->curr_freq = dev_pm_opp_get_freq(opp);
>>>>>>   	dev_pm_opp_put(opp);
>>>>>>   
>>>>>>
>>>>>
>>>> Best regards
>>>>
>>>
>>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
