Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470E2125D0B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 09:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLSI4Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 03:56:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:59080 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSI4Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 03:56:16 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191219085612epoutp0142c9a3c38510062c8d90b05fa29f9dd9~hue0uu4Yl2901729017epoutp01y
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 08:56:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191219085612epoutp0142c9a3c38510062c8d90b05fa29f9dd9~hue0uu4Yl2901729017epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576745772;
        bh=zlEn52rFg8t/FAFW3jpMwy2BIAbfeGV5RMc2+SZ6ODw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iRhK/sw5O1V6KcAtApB3Mtq1sDY8vX5hvvFK3ommoRC2CdbQ8Z0qqsxAfBXFdFZwa
         V32SLk6X6BOit533bJLpzuFX+McEMr16eDEWqOGwH4m+28bttFvd7GXP7VLgGtz/2D
         VUVw4mxsVQpq4mF6V/egHOafKjfvbCh9vwXTTk0s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191219085612epcas1p30f5194683c1e97dafcb2d4b9ed1ba85d~hue0jI05B0661006610epcas1p3U;
        Thu, 19 Dec 2019 08:56:12 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47dm210GMJzMqYm3; Thu, 19 Dec
        2019 08:56:09 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.D0.51241.82B3BFD5; Thu, 19 Dec 2019 17:56:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191219085608epcas1p19d65ee459ccd5a4801be63d4297a4b81~huewtq8hz2000420004epcas1p1N;
        Thu, 19 Dec 2019 08:56:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191219085608epsmtrp13dece5a58f26f2b756bcb27ff3929206~huewsspqf0913909139epsmtrp1m;
        Thu, 19 Dec 2019 08:56:08 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-77-5dfb3b287d55
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.1C.06569.82B3BFD5; Thu, 19 Dec 2019 17:56:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191219085608epsmtip275ae095672c6bd6181c6fdf08d295817~huewZrxxE2793927939epsmtip26;
        Thu, 19 Dec 2019 08:56:08 +0000 (GMT)
Subject: Re: [PATCH 1/2] ARM: dts: exynos: Move bus related OPPs to the
 boards DTS
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <13e06691-feed-de06-cf7a-af628e73df95@samsung.com>
Date:   Thu, 19 Dec 2019 18:02:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191219082927.11898-2-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmrq6G9e9Yg7n/rCw2zljParHg0wxW
        i/PnN7BbXN41h83ic+8RRosZ5/cxWaw9cpfdgd1j06pONo++LasYPT5vkgtgjsq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzvi+YzFLweyq
        igXzXjE3MPaFdzFyckgImEhc37eYuYuRi0NIYAejxO5j3xkhnE+MEgvPd0JlvjFKTJr1jBGm
        Zd28RqiqvYwS+/pXQFW9Z5TYOe8NM0iVsECIxKJJP9lAbBGBPkaJX9cUQIqYBXoYJZYe+8gK
        kmAT0JLY/+IGWBG/gKLE1R+PgcZycPAK2En8aCwDCbMIqEp82X+YBcQWFQiTOLmtBewKXgFB
        iZMzn4DFOYHKP1xZBxZnFhCXuPVkPhOELS+x/e0csOMkBO6zSTzce5UN4gUXiZWLFjFD2MIS
        r45vYYewpSRe9rdB2dUSK08eYYNo7mCU2LL/AitEwlhi/9LJTCCHMgtoSqzfpQ8RVpTY+Xsu
        1BF8Eu++9rCClEgI8Ep0tAlBlChLXH5wlwnClpRY3N7JNoFRaRaSd2YheWEWkhdmISxbwMiy
        ilEstaA4Nz212LDAFDm6NzGCU6aW5Q7GY+d8DjEKcDAq8fD+cP0VK8SaWFZcmXuIUYKDWUmE
        93bHz1gh3pTEyqrUovz4otKc1OJDjKbA0J7ILCWanA9M53kl8YamRsbGxhYmhmamhoZK4rwc
        Py7GCgmkJ5akZqemFqQWwfQxcXBKNTBO/ijSNLlXoyhsxty577/FnU8Ue/Xu/BcBwcAwmSa1
        NGfFX7ucn81Z8u1cJYfiBcHTzhuDJ0jwnb22YMv2wJeiqW0PHirxpmzp/rB9Sfb26OrGugn3
        NWa1FnWZ6Xv6V0f71Dh6WH1jCzfnvHlHxyCPPZal4KXmsninj0nmOxiy3qgdOLuuKVOJpTgj
        0VCLuag4EQDMEFrLrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXlfD+neswcfN0hYbZ6xntVjwaQar
        xfnzG9gtLu+aw2bxufcIo8WM8/uYLNYeucvuwO6xaVUnm0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBlfN+xmKVgdlXFgnmvmBsY+8K7GDk5JARMJNbNa2TsYuTiEBLYzSgxed1cRoiEpMS0
        i0eZuxg5gGxhicOHiyFq3jJKLJg0iw2kRlggROLygmNgtohAH6PE9VsBIDYziD3jJxNEw1FG
        iTenZ4MVsQloSex/cQPM5hdQlLj64zEjyAJeATuJH41lIGEWAVWJL/sPs4DYogJhEjuXPGYC
        sXkFBCVOznwCFucEKv9wZR0jxC51iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYh
        aZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgyNHS2sF44kT8IUYBDkYl
        Ht4frr9ihVgTy4orcw8xSnAwK4nw3u74GSvEm5JYWZValB9fVJqTWnyIUZqDRUmcVz7/WKSQ
        QHpiSWp2ampBahFMlomDU6qB0dOm/JZL7PEMH1YlL8mQl6kd989+6A2YL+N3I89AO0Zn/ZOM
        Tyu542Tc82aZasV58mn3Pct23djwpJG/2XrDvaqNk5YaXPt0tHSjzH/+7Xe55crM1kib/N4T
        kR/IZzs14mOIceDr5PzCQycU2Kp29z789mlJXpPIXeGgkwWV7Sb33wq/+ZuuxFKckWioxVxU
        nAgAmcSqvZgCAAA=
X-CMS-MailID: 20191219085608epcas1p19d65ee459ccd5a4801be63d4297a4b81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191219082939eucas1p248ca8b95ede6f2704b83515f461f6927
References: <20191219082927.11898-1-m.szyprowski@samsung.com>
        <CGME20191219082939eucas1p248ca8b95ede6f2704b83515f461f6927@eucas1p2.samsung.com>
        <20191219082927.11898-2-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On 12/19/19 5:29 PM, Marek Szyprowski wrote:
> Currently the only Exynos5422-based boards that support bus frequency
> scaling are Hardkernel's Odroid XU3/XU4/HC1. Move the bus related OPPs to
> the boards DTS, because those OPPs heavily depend on the clock topology
> and top PLL rates, which are being configured by the board's bootloader.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 259 -----------------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 261 +++++++++++++++++-
>  2 files changed, 260 insertions(+), 260 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index f95567bc10e3..f66a2d1b3428 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1092,7 +1092,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK400_WCORE>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_wcore_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1100,7 +1099,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK100_NOC>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_noc_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1108,7 +1106,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_PCLK200_FSYS>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_fsys_apb_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1116,7 +1113,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK200_FSYS>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_fsys_apb_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1124,7 +1120,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK200_FSYS2>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_fsys2_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1132,7 +1127,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK333>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_mfc_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1140,7 +1134,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK266>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_gen_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1148,7 +1141,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK66>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_peri_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1156,7 +1148,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK333_G2D>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_g2d_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1164,7 +1155,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK266_G2D>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_g2d_acp_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1172,7 +1162,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK300_JPEG>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_jpeg_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1180,7 +1169,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK166>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_jpeg_apb_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1188,7 +1176,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK300_DISP1>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_disp1_fimd_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1196,7 +1183,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK400_DISP1>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_disp1_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1204,7 +1190,6 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK300_GSCL>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_gscl_opp_table>;
>  			status = "disabled";
>  		};
>  
> @@ -1212,252 +1197,8 @@
>  			compatible = "samsung,exynos-bus";
>  			clocks = <&clock CLK_DOUT_ACLK400_MSCL>;
>  			clock-names = "bus";
> -			operating-points-v2 = <&bus_mscl_opp_table>;
>  			status = "disabled";
>  		};
> -
> -		bus_wcore_opp_table: opp_table2 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <84000000>;
> -				opp-microvolt = <925000 925000 1400000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <111000000>;
> -				opp-microvolt = <950000 950000 1400000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <222000000>;
> -				opp-microvolt = <950000 950000 1400000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <333000000>;
> -				opp-microvolt = <950000 950000 1400000>;
> -			};
> -			opp04 {
> -				opp-hz = /bits/ 64 <400000000>;
> -				opp-microvolt = <987500 987500 1400000>;
> -			};
> -		};
> -
> -		bus_noc_opp_table: opp_table3 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <67000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <75000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <86000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <100000000>;
> -			};
> -		};
> -
> -		bus_fsys_apb_opp_table: opp_table4 {
> -			compatible = "operating-points-v2";
> -			opp-shared;
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <100000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <200000000>;
> -			};
> -		};
> -
> -		bus_fsys2_opp_table: opp_table5 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <75000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <100000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <150000000>;
> -			};
> -		};
> -
> -		bus_mfc_opp_table: opp_table6 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <96000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <111000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <167000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <222000000>;
> -			};
> -			opp04 {
> -				opp-hz = /bits/ 64 <333000000>;
> -			};
> -		};
> -
> -		bus_gen_opp_table: opp_table7 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <89000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <133000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <178000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <267000000>;
> -			};
> -		};
> -
> -		bus_peri_opp_table: opp_table8 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <67000000>;
> -			};
> -		};
> -
> -		bus_g2d_opp_table: opp_table9 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <84000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <167000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <222000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <300000000>;
> -			};
> -			opp04 {
> -				opp-hz = /bits/ 64 <333000000>;
> -			};
> -		};
> -
> -		bus_g2d_acp_opp_table: opp_table10 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <67000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <133000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <178000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <267000000>;
> -			};
> -		};
> -
> -		bus_jpeg_opp_table: opp_table11 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <75000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <150000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <200000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <300000000>;
> -			};
> -		};
> -
> -		bus_jpeg_apb_opp_table: opp_table12 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <84000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <111000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <134000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <167000000>;
> -			};
> -		};
> -
> -		bus_disp1_fimd_opp_table: opp_table13 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <120000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <200000000>;
> -			};
> -		};
> -
> -		bus_disp1_opp_table: opp_table14 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <120000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <200000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <300000000>;
> -			};
> -		};
> -
> -		bus_gscl_opp_table: opp_table15 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <150000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <200000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <300000000>;
> -			};
> -		};
> -
> -		bus_mscl_opp_table: opp_table16 {
> -			compatible = "operating-points-v2";
> -
> -			opp00 {
> -				opp-hz = /bits/ 64 <84000000>;
> -			};
> -			opp01 {
> -				opp-hz = /bits/ 64 <167000000>;
> -			};
> -			opp02 {
> -				opp-hz = /bits/ 64 <222000000>;
> -			};
> -			opp03 {
> -				opp-hz = /bits/ 64 <333000000>;
> -			};
> -			opp04 {
> -				opp-hz = /bits/ 64 <400000000>;
> -			};
> -		};
>  	};
>  
>  	thermal-zones {
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 80b0acfec547..663a38d53c9e 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -35,7 +35,250 @@
>  		};
>  	};
>  
> -	dmc_opp_table: opp_table2 {
> +	bus_wcore_opp_table: opp_table2 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <84000000>;
> +			opp-microvolt = <925000 925000 1400000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <111000000>;
> +			opp-microvolt = <950000 950000 1400000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <222000000>;
> +			opp-microvolt = <950000 950000 1400000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <333000000>;
> +			opp-microvolt = <950000 950000 1400000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <987500 987500 1400000>;
> +		};
> +	};
> +
> +	bus_noc_opp_table: opp_table3 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <67000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <75000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <86000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +	};
> +
> +	bus_fsys_apb_opp_table: opp_table4 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <200000000>;
> +		};
> +	};
> +
> +	bus_fsys2_opp_table: opp_table5 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <75000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <100000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <150000000>;
> +		};
> +	};
> +
> +	bus_mfc_opp_table: opp_table6 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <96000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <111000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <167000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <222000000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <333000000>;
> +		};
> +	};
> +
> +	bus_gen_opp_table: opp_table7 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <89000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <133000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <178000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <267000000>;
> +		};
> +	};
> +
> +	bus_peri_opp_table: opp_table8 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <67000000>;
> +		};
> +	};
> +
> +	bus_g2d_opp_table: opp_table9 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <84000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <167000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <222000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <300000000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <333000000>;
> +		};
> +	};
> +
> +	bus_g2d_acp_opp_table: opp_table10 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <67000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <133000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <178000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <267000000>;
> +		};
> +	};
> +
> +	bus_jpeg_opp_table: opp_table11 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <75000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <150000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <200000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <300000000>;
> +		};
> +	};
> +
> +	bus_jpeg_apb_opp_table: opp_table12 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <84000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <111000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <134000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <167000000>;
> +		};
> +	};
> +
> +	bus_disp1_fimd_opp_table: opp_table13 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <120000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <200000000>;
> +		};
> +	};
> +
> +	bus_disp1_opp_table: opp_table14 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <120000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <200000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <300000000>;
> +		};
> +	};
> +
> +	bus_gscl_opp_table: opp_table15 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <150000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <200000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <300000000>;
> +		};
> +	};
> +
> +	bus_mscl_opp_table: opp_table16 {
> +		compatible = "operating-points-v2";
> +
> +		opp00 {
> +			opp-hz = /bits/ 64 <84000000>;
> +		};
> +		opp01 {
> +			opp-hz = /bits/ 64 <167000000>;
> +		};
> +		opp02 {
> +			opp-hz = /bits/ 64 <222000000>;
> +		};
> +		opp03 {
> +			opp-hz = /bits/ 64 <333000000>;
> +		};
> +		opp04 {
> +			opp-hz = /bits/ 64 <400000000>;
> +		};
> +	};
> +
> +	dmc_opp_table: opp_table18 {

opp_table18 -> opp_table17?

(snip)

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
