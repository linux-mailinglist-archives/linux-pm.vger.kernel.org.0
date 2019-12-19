Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69AE125D4B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 10:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLSJJl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 04:09:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59089 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSJJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 04:09:40 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191219090938euoutp02c6103f64d26e81d10b1c5254cb0d6ff8~huqjS7Mxn1251712517euoutp02M
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 09:09:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191219090938euoutp02c6103f64d26e81d10b1c5254cb0d6ff8~huqjS7Mxn1251712517euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576746578;
        bh=dd5PCXyucktEopzkBqVfaSjM09FbRZTvN//xnjiw5WE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ABgcV1DZdIV5L0+usvmmAUr9hOTr/cXSjLjWl8sysreO+DX8hoZhsQ3dLWoDh3yzW
         GoV89fgRmLWgnPnQQE90OQE3pjp5DW95kF0g68xzzHqwAIglwpzWQ7gxtUzliALJW7
         KaD+rFavkh7+p6FpwZ7wc9nNcF7hsU1oxpDdKWN8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191219090938eucas1p2639d41917117a80c276e0a48a1ea4567~huqjGvtm91206012060eucas1p2U;
        Thu, 19 Dec 2019 09:09:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 61.21.60679.25E3BFD5; Thu, 19
        Dec 2019 09:09:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191219090937eucas1p1bcbb1db2a9d2c1ec3c2b75e6ef7e4d93~huqiZu-em0048200482eucas1p1e;
        Thu, 19 Dec 2019 09:09:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191219090937eusmtrp29e4579dc1164fa5ef478e89ba6fb5d4a~huqiZKZwL1213812138eusmtrp2J;
        Thu, 19 Dec 2019 09:09:37 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-d4-5dfb3e52a431
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.8E.07950.15E3BFD5; Thu, 19
        Dec 2019 09:09:37 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219090937eusmtip13478b6cd157c9617fb5b1810355be2d9~huqiCmYM80351503515eusmtip1Q;
        Thu, 19 Dec 2019 09:09:37 +0000 (GMT)
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Adjust bus related OPPs to the
 values correct for Odroids
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2113afca-4f8b-ec06-ee1d-b84776b5b70d@samsung.com>
Date:   Thu, 19 Dec 2019 10:09:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9ff5cf7a-1dea-4f35-c4d3-066c87fbe896@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87pBdr9jDS69UrLYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mB3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoEr48GVyywFX30qZjXtZmtg3G7RxcjJISFgIvFq2jnmLkYuDiGBFYwSU9c/YoVwvjBK
        nGz7ywjhfGaUOPBzMytMy7rrE6ESyxklbrcdYINw3jJKLGvuA6sSFkiTuLbzE9hgEYFWRonO
        l9/AWpgFehgllh77CFbFJmAo0fW2iw3E5hWwk3jyaCKYzSKgKrHw+UeWLkYODlGBWImO5RkQ
        JYISJ2c+YQGxOQXsJT43zgErZxaQl9j+dg4zhC0ucevJfCaQXRICi9glbhxoYQOZIyHgInGr
        KRjiBWGJV8e3sEPYMhL/d8LUNzNKPDy3lh3CATr0ctMMRogqa4nDxy+yggxiFtCUWL9LHyLs
        KLHg7j+o+XwSN94KQtzAJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPSLCSfzULyzSwk
        38xC2LuAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYMo5/e/4lx2Mu/4kHWIU4GBU
        4uH94forVog1say4MvcQowQHs5II7+2On7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY0XvYwV
        EkhPLEnNTk0tSC2CyTJxcEo1MMrtDt8z49zTg5cnr7x+S+lN06yfLN8fvowpzZ5ypSnvQqe3
        uJisj2/klTZPq4m+dxTr33hvUn32+D6Ho+bSW7INqpdsN0uX/jl3pTy2JirN5V+4h8afiwb3
        PiQlt0lFROX9Kdr649DmjhxfrqwOtj2+K3fY9irITc+QkPxmfNxnp41z033jbiWW4oxEQy3m
        ouJEADnXajg1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7qBdr9jDa6cNLDYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLy7vmsFl87j3CaDHj/D4mB3aPTas62Tz6tqxi9Pi8SS6AOUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48GVyywFX30qZjXt
        Zmtg3G7RxcjJISFgIrHu+kTGLkYuDiGBpYwS8+buZINIyEicnNbACmELS/y51sUGUfSaUeLy
        vxPMIAlhgTSJazs/MYMkRARaGSXatt1gAUkwC/QxSsz4yQTR8YtRoundDLAONgFDia63XWAr
        eAXsJJ48mghmswioSix8/hGsWVQgVuL7yk+MEDWCEidnPgGLcwrYS3xunMMGscBMYt7mh8wQ
        trzE9rdzoGxxiVtP5jNNYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10v
        OT93EyMwyrYd+7llB2PXu+BDjAIcjEo8vAEev2KFWBPLiitzDzFKcDArifDe7vgZK8SbklhZ
        lVqUH19UmpNafIjRFOi5icxSosn5wASQVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qB0V9uomDPlqrPc/6vuN70XEIlM0jFcemRs33tH61jD/sbL9rWKs++MuN6
        6tmKF/rGQpM1wxf7LbTattrkwBLR+mbZmM4yS5FP2bsNL55qeF+uMdPFNnKzV9g/jUjBjzcu
        h8y7eS7U1+RbXqYQS54F//7Lr/dGhPlNPBiT9uLpwVIXlmt1CQ+XKLEUZyQaajEXFScCALQn
        wIrIAgAA
X-CMS-MailID: 20191219090937eucas1p1bcbb1db2a9d2c1ec3c2b75e6ef7e4d93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191219082939eucas1p2afc32535df1512dc21ca983daa012568
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219082939eucas1p2afc32535df1512dc21ca983daa012568
References: <20191219082927.11898-1-m.szyprowski@samsung.com>
        <CGME20191219082939eucas1p2afc32535df1512dc21ca983daa012568@eucas1p2.samsung.com>
        <20191219082927.11898-3-m.szyprowski@samsung.com>
        <9ff5cf7a-1dea-4f35-c4d3-066c87fbe896@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 19.12.2019 10:07, Chanwoo Choi wrote:
> On 12/19/19 5:29 PM, Marek Szyprowski wrote:
>> Hardkernel's Odroid XU3/XU4/HC1 boards use bootloader, which configures top
>> PLLs to the following values: MPLL: 532MHz, CPLL: 666MHz and DPLL: 600MHz.
>>
>> Adjust all bus related OPPs to the values that are possible to derive from
>> the top PLL configured by the bootloader. Also add a comment for each bus
>> describing which PLL is used for it.
>>
>> The most significant change is the highest rate for wcore bus. It has been
>> increased to 532MHz as this is the value configured initially by the
>> bootloader. Also the voltage for this OPP is changed to match the value
>> set by the bootloader.
>>
>> This patch finally allows the buses to operate on the rates matching the
>> values set for each OPP and fixes the following warnings observed on boot:
>>
>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>> ...
>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>
>> The problem with setting incorrect (in some cases much lower) clock rate
>> for the defined OPP were there from the beginning, but went unnoticed
>> because the only way to observe it was to manually check the rate of the
>> respective clocks. The commit 4294a779bd8d ("PM / devfreq: exynos-bus:
>> Convert to use dev_pm_opp_set_rate()") finally revealed it, because it
>> enabled use of the generic code from the OPP framework, which issues the
>> above mentioned warnings.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 75 +++++++++++--------
>>   1 file changed, 45 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> index 663a38d53c9e..b6d6022e8735 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>> @@ -38,42 +38,44 @@
>>   	bus_wcore_opp_table: opp_table2 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 532MHz MPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <84000000>;
>> +			opp-hz = /bits/ 64 <88700000>;
>>   			opp-microvolt = <925000 925000 1400000>;
>>   		};
>>   		opp01 {
>> -			opp-hz = /bits/ 64 <111000000>;
>> +			opp-hz = /bits/ 64 <133000000>;
>>   			opp-microvolt = <950000 950000 1400000>;
>>   		};
>>   		opp02 {
>> -			opp-hz = /bits/ 64 <222000000>;
>> +			opp-hz = /bits/ 64 <177400000>;
>>   			opp-microvolt = <950000 950000 1400000>;
>>   		};
>>   		opp03 {
>> -			opp-hz = /bits/ 64 <333000000>;
>> +			opp-hz = /bits/ 64 <266000000>;
>>   			opp-microvolt = <950000 950000 1400000>;
>>   		};
>>   		opp04 {
>> -			opp-hz = /bits/ 64 <400000000>;
>> -			opp-microvolt = <987500 987500 1400000>;
>> +			opp-hz = /bits/ 64 <532000000>;
>> +			opp-microvolt = <1000000 1000000 1400000>;
>>   		};
>>   	};
>>   
>>   	bus_noc_opp_table: opp_table3 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 666MHz CPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <67000000>;
>> +			opp-hz = /bits/ 64 <66600000>;
>>   		};
>>   		opp01 {
>> -			opp-hz = /bits/ 64 <75000000>;
>> +			opp-hz = /bits/ 64 <74000000>;
>>   		};
>>   		opp02 {
>> -			opp-hz = /bits/ 64 <86000000>;
>> +			opp-hz = /bits/ 64 <83250000>;
>>   		};
>>   		opp03 {
>> -			opp-hz = /bits/ 64 <100000000>;
>> +			opp-hz = /bits/ 64 <111000000>;
>>   		};
>>   	};
>>   
>> @@ -81,39 +83,42 @@
>>   		compatible = "operating-points-v2";
>>   		opp-shared;
>>   
>> +		/* derived from 666MHz CPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <100000000>;
>> +			opp-hz = /bits/ 64 <111000000>;
>>   		};
>>   		opp01 {
>> -			opp-hz = /bits/ 64 <200000000>;
>> +			opp-hz = /bits/ 64 <222000000>;
>>   		};
>>   	};
>>   
>>   	bus_fsys2_opp_table: opp_table5 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 600MHz DPLL */
>>   		opp00 {
>>   			opp-hz = /bits/ 64 <75000000>;
>>   		};
>>   		opp01 {
>> -			opp-hz = /bits/ 64 <100000000>;
>> +			opp-hz = /bits/ 64 <120000000>;
>>   		};
>>   		opp02 {
>> -			opp-hz = /bits/ 64 <150000000>;
>> +			opp-hz = /bits/ 64 <200000000>;
>>   		};
>>   	};
>>   
>>   	bus_mfc_opp_table: opp_table6 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 666MHz CPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <96000000>;
>> +			opp-hz = /bits/ 64 <83250000>;
>>   		};
>>   		opp01 {
>>   			opp-hz = /bits/ 64 <111000000>;
>>   		};
>>   		opp02 {
>> -			opp-hz = /bits/ 64 <167000000>;
>> +			opp-hz = /bits/ 64 <166500000>;
>>   		};
>>   		opp03 {
>>   			opp-hz = /bits/ 64 <222000000>;
>> @@ -126,8 +131,9 @@
>>   	bus_gen_opp_table: opp_table7 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 532MHz MPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <89000000>;
>> +			opp-hz = /bits/ 64 <88700000>;
>>   		};
>>   		opp01 {
>>   			opp-hz = /bits/ 64 <133000000>;
>> @@ -136,32 +142,34 @@
>>   			opp-hz = /bits/ 64 <178000000>;
>>   		};
>>   		opp03 {
>> -			opp-hz = /bits/ 64 <267000000>;
>> +			opp-hz = /bits/ 64 <266000000>;
>>   		};
>>   	};
>>   
>>   	bus_peri_opp_table: opp_table8 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 666MHz CPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <67000000>;
>> +			opp-hz = /bits/ 64 <66600000>;
>>   		};
>>   	};
>>   
>>   	bus_g2d_opp_table: opp_table9 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 666MHz CPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <84000000>;
>> +			opp-hz = /bits/ 64 <83250000>;
>>   		};
>>   		opp01 {
>> -			opp-hz = /bits/ 64 <167000000>;
>> +			opp-hz = /bits/ 64 <111000000>;
>>   		};
>>   		opp02 {
>> -			opp-hz = /bits/ 64 <222000000>;
>> +			opp-hz = /bits/ 64 <166500000>;
>>   		};
>>   		opp03 {
>> -			opp-hz = /bits/ 64 <300000000>;
>> +			opp-hz = /bits/ 64 <222000000>;
>>   		};
>>   		opp04 {
>>   			opp-hz = /bits/ 64 <333000000>;
>> @@ -171,8 +179,9 @@
>>   	bus_g2d_acp_opp_table: opp_table10 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 532MHz MPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <67000000>;
>> +			opp-hz = /bits/ 64 <66500000>;
>>   		};
>>   		opp01 {
>>   			opp-hz = /bits/ 64 <133000000>;
>> @@ -181,13 +190,14 @@
>>   			opp-hz = /bits/ 64 <178000000>;
>>   		};
>>   		opp03 {
>> -			opp-hz = /bits/ 64 <267000000>;
>> +			opp-hz = /bits/ 64 <266000000>;
>>   		};
>>   	};
>>   
>>   	bus_jpeg_opp_table: opp_table11 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 600MHz DPLL */
>>   		opp00 {
>>   			opp-hz = /bits/ 64 <75000000>;
>>   		};
>> @@ -205,23 +215,25 @@
>>   	bus_jpeg_apb_opp_table: opp_table12 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 666MHz CPLL */
>>   		opp00 {
>> -			opp-hz = /bits/ 64 <84000000>;
>> +			opp-hz = /bits/ 64 <83250000>;
>>   		};
>>   		opp01 {
>>   			opp-hz = /bits/ 64 <111000000>;
>>   		};
>>   		opp02 {
>> -			opp-hz = /bits/ 64 <134000000>;
>> +			opp-hz = /bits/ 64 <133000000>;
>>   		};
>>   		opp03 {
>> -			opp-hz = /bits/ 64 <167000000>;
>> +			opp-hz = /bits/ 64 <166500000>;
>>   		};
>>   	};
>>   
>>   	bus_disp1_fimd_opp_table: opp_table13 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 600MHz DPLL */
>>   		opp00 {
>>   			opp-hz = /bits/ 64 <120000000>;
>>   		};
>> @@ -233,6 +245,7 @@
>>   	bus_disp1_opp_table: opp_table14 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 600MHz DPLL */
>>   		opp00 {
>>   			opp-hz = /bits/ 64 <120000000>;
>>   		};
>> @@ -247,6 +260,7 @@
>>   	bus_gscl_opp_table: opp_table15 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 600MHz DPLL */
>>   		opp00 {
>>   			opp-hz = /bits/ 64 <150000000>;
>>   		};
>> @@ -261,6 +275,7 @@
>>   	bus_mscl_opp_table: opp_table16 {
>>   		compatible = "operating-points-v2";
>>   
>> +		/* derived from 666MHz CPLL */
>>   		opp00 {
>>   			opp-hz = /bits/ 64 <84000000>;
>>   		};
>> @@ -274,7 +289,7 @@
>>   			opp-hz = /bits/ 64 <333000000>;
>>   		};
>>   		opp04 {
>> -			opp-hz = /bits/ 64 <400000000>;
>> +			opp-hz = /bits/ 64 <666000000>;
>>   		};
>>   	};
>>   
>> @@ -398,7 +413,7 @@
>>   };
>>   
>>   &bus_fsys {
>> -	operating-points-v2 = <&bus_fsys_apb_opp_table>;
>> +	operating-points-v2 = <&bus_fsys2_opp_table>;
>
> Need to remove 'opp-shared' property in bus_fsys_apb_opp_table.
> And need to add 'opp-shared' property to bus_fsys2_opp_table.

I've checked the dt bindings and I think that opp-shared property has to 
be removed at all. Clocks between fsys and fsys2 buses are not related 
and regulator is currently already handled by in a different way by the 
passive governor.

>>   	devfreq = <&bus_wcore>;
>>   	status = "okay";
>>   };
>>
> If you fix the things related to 'opp-shared', Looks good to me.
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

