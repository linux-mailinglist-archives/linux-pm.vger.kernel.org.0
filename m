Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD4125D26
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 10:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLSJAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 04:00:43 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:18640 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLSJAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 04:00:43 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191219090040epoutp0274f57aa55e620a4f30d1fab1b2f38b8b~huiuFsS6u2016120161epoutp02d
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 09:00:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191219090040epoutp0274f57aa55e620a4f30d1fab1b2f38b8b~huiuFsS6u2016120161epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576746040;
        bh=qUe64HH6eQC1rH67+6iFAZoEBHMzxsVFkSdlibI2LcI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LiPE0ifsfRgLFjEULOZhgh6XbYZ0oUp+y5CPAEAgtfNsVuk30R8dZhwFW4r/mAJJN
         NDjr1wUNYs8vTSv27jxzjjPKcF4ylOfZmrflb4qZqgOkWjYRDZVBF4aabLkKjB4BHp
         shNyxAz90HpxYe5DYDG7AU64Kgv4jO/Fn3EKg9WU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191219090040epcas1p433ddb371b35a63400e480e828b506858~huityjSaq2604026040epcas1p4l;
        Thu, 19 Dec 2019 09:00:40 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47dm786G9KzMqYlx; Thu, 19 Dec
        2019 09:00:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.C0.57028.43C3BFD5; Thu, 19 Dec 2019 18:00:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191219090036epcas1p18c57c13cc4ae50542a77e6c6b5c86c86~huiqAkkd61675816758epcas1p1I;
        Thu, 19 Dec 2019 09:00:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219090036epsmtrp19b344314116b1e8eac9076d1bac9f761~huip-8BXu1106211062epsmtrp1P;
        Thu, 19 Dec 2019 09:00:36 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-6f-5dfb3c3430b8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.7C.06569.43C3BFD5; Thu, 19 Dec 2019 18:00:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191219090036epsmtip27fdd46901d2e942dc58bc482f472b3ad~huip2q47G2793827938epsmtip2b;
        Thu, 19 Dec 2019 09:00:36 +0000 (GMT)
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Adjust bus related OPPs to the
 values correct for Odroids
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9ff5cf7a-1dea-4f35-c4d3-066c87fbe896@samsung.com>
Date:   Thu, 19 Dec 2019 18:07:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191219082927.11898-3-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGObvb3VVa3Va2N4laVwsazby61S1UgqyESgRBSJB10dMUt7ux
        OyUzwiJsmdl32VITQqiFZbZKhTLMDPuYmSX2YUVJlGKSVvhVtO0u8r/fe3ie9+E551CEuoqM
        pPIEJ3YIvIUhw+W37q+I0RsSprJiXaUG7nrlNQVXO1qp4Lq6GpRcT0sVyY0daUdcZdddGVff
        3q9cr0xp9BwiUyq8HpQy1rg4jcjMT8jFfA52aLGQbcvJE8yJzJZ00waTcXUsq2fXcmsYrcBb
        cSKTvDVNvynP4g9ntIW8pcB/lMaLIrMqKcFhK3Biba5NdCYy2J5jsa+1x4i8VSwQzDHZNus6
        NjY2zugX7sjPney7orCPbdo1UHVYWYJOGcpQGAW0AWouXZWXoXBKTTchaPHeU0rDKILBoQek
        NPxC8Lvfo/hnOfuoImS5g+Dx9J+QagSBr9wrD6jm0Tuht3mUCPB8ugLBZK82ICLocgR1Hd+D
        q0haB61f+sgAz6GXwsvxTyjAKjoJzv78JguwnF4G3UfPBxdF0BnQeetASDMXOs8NBMPC/HrP
        hC+oIWgNvB64IJN4CdweriICwUC/J2H46We/mfIPydDxg5PqzIPBh16lxJHw9WhpiIvhcmc7
        KXldCLytz0L946G17qQssIegV8C1llXS8VJonqpGUu5s+PazXCFFqcBVqpYkUdDzoV8m8UK4
        ePAQeQwx7hlt3DMauGc0cP8Pq0VyD1qA7aLVjEXWzs587kYU/Jk6YxM65dvahmgKMbNU4xsn
        s9QKvlAssrYhoAhmvuqNayJLrcrhi3Zjh83kKLBgsQ0Z/Zd9nIiMyLb5/7ngNLHGuPj4eM7A
        rjayLKNRUePdWWrazDtxPsZ27Pjnk1FhkSXo7oYb4y+WnHBtVpZE6DrqD190pX7cXrNIX6h5
        NxxdtLzoZnr0rj1N5j5jY/Wn6qFmtal8G5n3cCTzTzJ+ixoqNQ1HdLMz9wqbo6bOp/p6O/VN
        Q4aw8MEz+HnxK82zupO1GW5X2cv9Sb3dPe37puMmvmz0rVdVTK9pGXlyY6VcOF3MyMVcntUR
        DpH/C7yTO4uvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXtfE5neswbH3PBYbZ6xntVjwaQar
        xfnzG9gtLu+aw2bxufcIo8WM8/uYLNYeucvuwO6xaVUnm0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBl/LqxmrXgs1vFkznd7A2MU0y6GDk5JARMJKaf6mPpYuTiEBLYzSixfP98ZoiEpMS0
        i0eBbA4gW1ji8OFiiJq3jBKTX0xhAakRFkiTuLbzE1i9iEAfo8T1WwEgNjOIPeMnE0TDUUaJ
        M91HGUESbAJaEvtf3GADsfkFFCWu/ngMFucVsJOY/vUdE4jNIqAqcbF/NthQUYEwiZ1LHjNB
        1AhKnJz5BGwxJ1D9qp/nmCGWqUv8mXcJyhaXuPVkPhOELS+x/e0c5gmMwrOQtM9C0jILScss
        JC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEx46W1g7GEyfiDzEKcDAq8fD+
        cP0VK8SaWFZcmXuIUYKDWUmE93bHz1gh3pTEyqrUovz4otKc1OJDjNIcLErivPL5xyKFBNIT
        S1KzU1MLUotgskwcnFINjLKHzgVuKH52YW2Ols1546cd39Z/frc3fCl7YtDMpZu66threHqK
        7+zcnqzn8OqHzB6H714CSXr5eQYB069tOfJk8v5PR3+as23cs+jOumcez9N8Kr/sPjFv55eb
        q3kUpyeFTv2XkKJV84CjJ3/qeu8YU7t9Zz9VqKgGx1797VEebBF918Rc85USS3FGoqEWc1Fx
        IgAdUFRmmQIAAA==
X-CMS-MailID: 20191219090036epcas1p18c57c13cc4ae50542a77e6c6b5c86c86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191219082939eucas1p2afc32535df1512dc21ca983daa012568
References: <20191219082927.11898-1-m.szyprowski@samsung.com>
        <CGME20191219082939eucas1p2afc32535df1512dc21ca983daa012568@eucas1p2.samsung.com>
        <20191219082927.11898-3-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 12/19/19 5:29 PM, Marek Szyprowski wrote:
> Hardkernel's Odroid XU3/XU4/HC1 boards use bootloader, which configures top
> PLLs to the following values: MPLL: 532MHz, CPLL: 666MHz and DPLL: 600MHz.
> 
> Adjust all bus related OPPs to the values that are possible to derive from
> the top PLL configured by the bootloader. Also add a comment for each bus
> describing which PLL is used for it.
> 
> The most significant change is the highest rate for wcore bus. It has been
> increased to 532MHz as this is the value configured initially by the
> bootloader. Also the voltage for this OPP is changed to match the value
> set by the bootloader.
> 
> This patch finally allows the buses to operate on the rates matching the
> values set for each OPP and fixes the following warnings observed on boot:
> 
> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
> ...
> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
> 
> The problem with setting incorrect (in some cases much lower) clock rate
> for the defined OPP were there from the beginning, but went unnoticed
> because the only way to observe it was to manually check the rate of the
> respective clocks. The commit 4294a779bd8d ("PM / devfreq: exynos-bus:
> Convert to use dev_pm_opp_set_rate()") finally revealed it, because it
> enabled use of the generic code from the OPP framework, which issues the
> above mentioned warnings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 75 +++++++++++--------
>  1 file changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 663a38d53c9e..b6d6022e8735 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -38,42 +38,44 @@
>  	bus_wcore_opp_table: opp_table2 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 532MHz MPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <84000000>;
> +			opp-hz = /bits/ 64 <88700000>;
>  			opp-microvolt = <925000 925000 1400000>;
>  		};
>  		opp01 {
> -			opp-hz = /bits/ 64 <111000000>;
> +			opp-hz = /bits/ 64 <133000000>;
>  			opp-microvolt = <950000 950000 1400000>;
>  		};
>  		opp02 {
> -			opp-hz = /bits/ 64 <222000000>;
> +			opp-hz = /bits/ 64 <177400000>;
>  			opp-microvolt = <950000 950000 1400000>;
>  		};
>  		opp03 {
> -			opp-hz = /bits/ 64 <333000000>;
> +			opp-hz = /bits/ 64 <266000000>;
>  			opp-microvolt = <950000 950000 1400000>;
>  		};
>  		opp04 {
> -			opp-hz = /bits/ 64 <400000000>;
> -			opp-microvolt = <987500 987500 1400000>;
> +			opp-hz = /bits/ 64 <532000000>;
> +			opp-microvolt = <1000000 1000000 1400000>;
>  		};
>  	};
>  
>  	bus_noc_opp_table: opp_table3 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 666MHz CPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <67000000>;
> +			opp-hz = /bits/ 64 <66600000>;
>  		};
>  		opp01 {
> -			opp-hz = /bits/ 64 <75000000>;
> +			opp-hz = /bits/ 64 <74000000>;
>  		};
>  		opp02 {
> -			opp-hz = /bits/ 64 <86000000>;
> +			opp-hz = /bits/ 64 <83250000>;
>  		};
>  		opp03 {
> -			opp-hz = /bits/ 64 <100000000>;
> +			opp-hz = /bits/ 64 <111000000>;
>  		};
>  	};
>  
> @@ -81,39 +83,42 @@
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> +		/* derived from 666MHz CPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <100000000>;
> +			opp-hz = /bits/ 64 <111000000>;
>  		};
>  		opp01 {
> -			opp-hz = /bits/ 64 <200000000>;
> +			opp-hz = /bits/ 64 <222000000>;
>  		};
>  	};
>  
>  	bus_fsys2_opp_table: opp_table5 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 600MHz DPLL */
>  		opp00 {
>  			opp-hz = /bits/ 64 <75000000>;
>  		};
>  		opp01 {
> -			opp-hz = /bits/ 64 <100000000>;
> +			opp-hz = /bits/ 64 <120000000>;
>  		};
>  		opp02 {
> -			opp-hz = /bits/ 64 <150000000>;
> +			opp-hz = /bits/ 64 <200000000>;
>  		};
>  	};
>  
>  	bus_mfc_opp_table: opp_table6 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 666MHz CPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <96000000>;
> +			opp-hz = /bits/ 64 <83250000>;
>  		};
>  		opp01 {
>  			opp-hz = /bits/ 64 <111000000>;
>  		};
>  		opp02 {
> -			opp-hz = /bits/ 64 <167000000>;
> +			opp-hz = /bits/ 64 <166500000>;
>  		};
>  		opp03 {
>  			opp-hz = /bits/ 64 <222000000>;
> @@ -126,8 +131,9 @@
>  	bus_gen_opp_table: opp_table7 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 532MHz MPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <89000000>;
> +			opp-hz = /bits/ 64 <88700000>;
>  		};
>  		opp01 {
>  			opp-hz = /bits/ 64 <133000000>;
> @@ -136,32 +142,34 @@
>  			opp-hz = /bits/ 64 <178000000>;
>  		};
>  		opp03 {
> -			opp-hz = /bits/ 64 <267000000>;
> +			opp-hz = /bits/ 64 <266000000>;
>  		};
>  	};
>  
>  	bus_peri_opp_table: opp_table8 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 666MHz CPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <67000000>;
> +			opp-hz = /bits/ 64 <66600000>;
>  		};
>  	};
>  
>  	bus_g2d_opp_table: opp_table9 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 666MHz CPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <84000000>;
> +			opp-hz = /bits/ 64 <83250000>;
>  		};
>  		opp01 {
> -			opp-hz = /bits/ 64 <167000000>;
> +			opp-hz = /bits/ 64 <111000000>;
>  		};
>  		opp02 {
> -			opp-hz = /bits/ 64 <222000000>;
> +			opp-hz = /bits/ 64 <166500000>;
>  		};
>  		opp03 {
> -			opp-hz = /bits/ 64 <300000000>;
> +			opp-hz = /bits/ 64 <222000000>;
>  		};
>  		opp04 {
>  			opp-hz = /bits/ 64 <333000000>;
> @@ -171,8 +179,9 @@
>  	bus_g2d_acp_opp_table: opp_table10 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 532MHz MPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <67000000>;
> +			opp-hz = /bits/ 64 <66500000>;
>  		};
>  		opp01 {
>  			opp-hz = /bits/ 64 <133000000>;
> @@ -181,13 +190,14 @@
>  			opp-hz = /bits/ 64 <178000000>;
>  		};
>  		opp03 {
> -			opp-hz = /bits/ 64 <267000000>;
> +			opp-hz = /bits/ 64 <266000000>;
>  		};
>  	};
>  
>  	bus_jpeg_opp_table: opp_table11 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 600MHz DPLL */
>  		opp00 {
>  			opp-hz = /bits/ 64 <75000000>;
>  		};
> @@ -205,23 +215,25 @@
>  	bus_jpeg_apb_opp_table: opp_table12 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 666MHz CPLL */
>  		opp00 {
> -			opp-hz = /bits/ 64 <84000000>;
> +			opp-hz = /bits/ 64 <83250000>;
>  		};
>  		opp01 {
>  			opp-hz = /bits/ 64 <111000000>;
>  		};
>  		opp02 {
> -			opp-hz = /bits/ 64 <134000000>;
> +			opp-hz = /bits/ 64 <133000000>;
>  		};
>  		opp03 {
> -			opp-hz = /bits/ 64 <167000000>;
> +			opp-hz = /bits/ 64 <166500000>;
>  		};
>  	};
>  
>  	bus_disp1_fimd_opp_table: opp_table13 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 600MHz DPLL */
>  		opp00 {
>  			opp-hz = /bits/ 64 <120000000>;
>  		};
> @@ -233,6 +245,7 @@
>  	bus_disp1_opp_table: opp_table14 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 600MHz DPLL */
>  		opp00 {
>  			opp-hz = /bits/ 64 <120000000>;
>  		};
> @@ -247,6 +260,7 @@
>  	bus_gscl_opp_table: opp_table15 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 600MHz DPLL */
>  		opp00 {
>  			opp-hz = /bits/ 64 <150000000>;
>  		};
> @@ -261,6 +275,7 @@
>  	bus_mscl_opp_table: opp_table16 {
>  		compatible = "operating-points-v2";
>  
> +		/* derived from 666MHz CPLL */
>  		opp00 {
>  			opp-hz = /bits/ 64 <84000000>;
>  		};
> @@ -274,7 +289,7 @@
>  			opp-hz = /bits/ 64 <333000000>;
>  		};
>  		opp04 {
> -			opp-hz = /bits/ 64 <400000000>;
> +			opp-hz = /bits/ 64 <666000000>;
>  		};
>  	};
>  
> @@ -398,7 +413,7 @@
>  };
>  
>  &bus_fsys {
> -	operating-points-v2 = <&bus_fsys_apb_opp_table>;
> +	operating-points-v2 = <&bus_fsys2_opp_table>;


Need to remove 'opp-shared' property in bus_fsys_apb_opp_table.
And need to add 'opp-shared' property to bus_fsys2_opp_table.


>  	devfreq = <&bus_wcore>;
>  	status = "okay";
>  };
> 

If you fix the things related to 'opp-shared', Looks good to me.
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
