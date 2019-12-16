Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F55F11FC4D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 01:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLPAsl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 19:48:41 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51907 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPAsl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 19:48:41 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191216004837epoutp0145e562fbf6e547330acd546be6e56984~gs5P8e6yA1035910359epoutp01i
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 00:48:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191216004837epoutp0145e562fbf6e547330acd546be6e56984~gs5P8e6yA1035910359epoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576457317;
        bh=U46RYH5Ir7QePRkd4DNR6PbEF9ch+pNSpdpoJ6yOfuE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=o6hbFN8P404aMsrvvqJ21NQYP1saniqafyu0Vn8Q48N8XOiFVNpwTOE2XHQK8XTQA
         WeRtQnlanhkNL9BQRwgEyzThnG3sA9cPzVtg2zu1RRd9666OcgAhcxxCqon562mAut
         1gEXOYnlHn/k6/BSXuqqqqXPxboBGuayW5AXBriQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191216004837epcas1p3a5b08c2345a9838ff368c8bad1a59d72~gs5Pg2yDF0412704127epcas1p39;
        Mon, 16 Dec 2019 00:48:37 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47bjLn4yGbzMqYkd; Mon, 16 Dec
        2019 00:48:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.1A.51241.164D6FD5; Mon, 16 Dec 2019 09:48:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191216004833epcas1p1b594c5fdd00b683c18babd188fb563c3~gs5LxveXl0983709837epcas1p1p;
        Mon, 16 Dec 2019 00:48:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216004833epsmtrp16d3a93010cb15881b0164c12e4bcf7f5~gs5Lw39_o2216622166epsmtrp13;
        Mon, 16 Dec 2019 00:48:33 +0000 (GMT)
X-AuditID: b6c32a39-5bab39c00001c829-40-5df6d46123e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.F8.10238.164D6FD5; Mon, 16 Dec 2019 09:48:33 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216004832epsmtip20cbc07c0bc599c8bbc98b5d37a351388~gs5Lay3th2795527955epsmtip2z;
        Mon, 16 Dec 2019 00:48:32 +0000 (GMT)
Subject: Re: [RFC PATCH v2 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f0453b39-fd05-9824-ee24-39b6bd587876@samsung.com>
Date:   Mon, 16 Dec 2019 09:55:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-9-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmvm7ilW+xBjtOaljcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0t5JC
        WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAh
        O+Pem/NsBVPkKu4t287ewLhYvIuRk0NCwERixYZHLF2MXBxCAjsYJb6dmcsI4XxilFjVdZoR
        pEpI4BujRMfhSpiOP4v/MkMU7WWUWHfnAiuE855Ron36E2aQKmGBdInrnZ+YQBIiAv8ZJU4v
        WwlWxSxwjFFi752fLCBVbAJaEvtf3GADsfkFFCWu/ngMto9XwE5i28tf7CA2i4CqxMmPJ8Cm
        igqESZzc1gJVIyhxcuYToDkcHJwClhKds/VBwswC4hK3nsxngrDlJZq3zgY7VUJgH7vErf/H
        2CB+cJFYPnkfE4QtLPHq+BZ2CFtK4mV/G5RdLbHy5BE2iOYORokt+0H+BEkYS+xfOpkJZDGz
        gKbE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO7UGslJRa3d7JNYFSaheSb
        WUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBFju5NjOBErWW5g/HYOZ9DjAIcjEo8vA7Z32KF
        WBPLiitzDzFKcDArifCman+OFeJNSaysSi3Kjy8qzUktPsRoCgzsicxSosn5wCySVxJvaGpk
        bGxsYWJoZmpoqCTOy/HjYqyQQHpiSWp2ampBahFMHxMHp1QDY7oVW/ESuamLD1W8s1Wz+9mb
        WOn1wvDhzbN26vFuv83UhXuirzdvdnWvvLGtaoHqxIW+VS82FJ3L+LNQvdpNhMXPLmJuWCbj
        xXVrZPuqbsa8N090z9Q3ub3yxtK4m4c+79JY4r5zeXlqydHKJTc+rk1hrb+4TJQj0bX1+P6W
        HS36JtN+nj56RomlOCPRUIu5qDgRAMnSFTfqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvG7ilW+xBv0X2C3uz2tltNg4Yz2r
        xfwj51gtrnx9z2Yxfe8mNotJ9yewWJw/v4HdYsXdj6wWmx5fY7W4vGsOm8Xn3iOMFjPO72Oy
        WHvkLrvF7cYVbBYzJr9kc+D32LSqk83jzrU9bB73u48zeWxeUu+x8d0OJo++LasYPT5vkgtg
        j+KySUnNySxLLdK3S+DKuPfmPFvBFLmKe8u2szcwLhbvYuTkkBAwkfiz+C9zFyMXh5DAbkaJ
        Z2+/skEkJCWmXTwKlOAAsoUlDh8uhqh5yyhxZmoLM0iNsEC6xPXOT0wgCRGB/4wSD9uOMYI4
        zALHGCU+rljPCjd2wdGHTCAtbAJaEvtf3ABbwS+gKHH1x2NGEJtXwE5i28tf7CA2i4CqxMmP
        J8BWiAqESexc8pgJokZQ4uTMJywgJ3EKWEp0ztYHCTMLqEv8mXeJGcIWl7j1ZD4ThC0v0bx1
        NvMERuFZSLpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNW
        S3MH4+Ul8YcYBTgYlXh4HbK/xQqxJpYVV+YeYpTgYFYS4U3V/hwrxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUA6PTy5WLC+Pad8o6vjxarV8dEdJ2Y8fC
        WuOpE9gZb664ZHDC71f5hs9rb9TNKo+YbKuy6XWm9I4/3h3n+AvPdXh8KuXQ/aoxmzn2j4T4
        62eii6+6q/ttf/x8VUjozbcXzk0/lah/hqPjnI9hiPkjxon58SURysm7Fl/SFZrDYrRXloll
        783lCiZKLMUZiYZazEXFiQDggDtC1QIAAA==
X-CMS-MailID: 20191216004833epcas1p1b594c5fdd00b683c18babd188fb563c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190919142329eucas1p299762f99dd55a5d625633ceec84219f9
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142329eucas1p299762f99dd55a5d625633ceec84219f9@eucas1p2.samsung.com>
        <20190919142236.4071-9-a.swigon@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 9/19/19 11:22 PM, Artur Świgoń wrote:
> From: Artur Świgoń <a.swigon@partner.samsung.com>
> 
> This patch adds two fields to the Exynos4412 DTS:
>   - parent: to declare connections between nodes that are not in a
>     parent-child relation in devfreq;
>   - #interconnect-cells: required by the interconnect framework.
> 
> Please note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere. The above-mentioned parent-child relation in devfreq
> means that there is a shared power line ('devfreq' property). The 'parent'
> property only signifies an interconnect connection.
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
>  arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index ea55f377d17c..bdd61ae86103 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -106,6 +106,7 @@
>  &bus_leftbus {
>  	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>  	vdd-supply = <&buck3_reg>;
> +	parent = <&bus_dmc>;

As I mentioned on other patch,
I'm not sure to use 'parent' property for this driver.
If possible, we better to use the standard way like OF graph
in order to make the tree between buses. Except for making
the connection between the buses with 'parent', looks good to me.

>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index d20db2dfe8e2..a70a671acacd 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -390,6 +390,7 @@
>  			clocks = <&clock CLK_DIV_DMC>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_dmc_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -398,6 +399,7 @@
>  			clocks = <&clock CLK_DIV_ACP>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_acp_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -406,6 +408,7 @@
>  			clocks = <&clock CLK_DIV_C2C>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_dmc_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -459,6 +462,7 @@
>  			clocks = <&clock CLK_DIV_GDL>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -467,6 +471,7 @@
>  			clocks = <&clock CLK_DIV_GDR>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -475,6 +480,7 @@
>  			clocks = <&clock CLK_ACLK160>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_display_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -483,6 +489,7 @@
>  			clocks = <&clock CLK_ACLK133>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_fsys_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -491,6 +498,7 @@
>  			clocks = <&clock CLK_ACLK100>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_peri_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> @@ -499,6 +507,7 @@
>  			clocks = <&clock CLK_SCLK_MFC>;
>  			clock-names = "bus";
>  			operating-points-v2 = <&bus_leftbus_opp_table>;
> +			#interconnect-cells = <0>;
>  			status = "disabled";
>  		};
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
