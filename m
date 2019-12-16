Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40D911FC40
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 01:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfLPApc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 19:45:32 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61469 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPApb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 19:45:31 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191216004528epoutp02c271c8dd01919a131a706aa060b90dd2~gs2ffW1y-1304813048epoutp02S
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 00:45:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191216004528epoutp02c271c8dd01919a131a706aa060b90dd2~gs2ffW1y-1304813048epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576457128;
        bh=8SrOS0uNXUB2064t8Tnx6zhtsjBJWxM95cvkex1+2Ew=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HmShdL8ANtJE85uKW5k2r81+JX/mfv4FtW4PoWN3Mw3vVkG/TtphhMQUkRrICwezq
         WWrgckvyNZv5f5LFyjSnrMvCdjAd9I/QwAB5heOi3MtRHRCV1c4JN7MvYusc7OhQ4s
         qf7hAyvtRAER81v6N3vbUM7ORGG8LKlNiMyz706Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191216004527epcas1p4efe5964a2622230fc39c68110c5adf1d~gs2eVX1NW1662016620epcas1p4K;
        Mon, 16 Dec 2019 00:45:27 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47bjH752xxzMqYm3; Mon, 16 Dec
        2019 00:45:23 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.EC.48019.3A3D6FD5; Mon, 16 Dec 2019 09:45:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191216004522epcas1p3dd06bfb24212c2fee558e7a7a23cf65c~gs2aaPWXQ2782227822epcas1p3L;
        Mon, 16 Dec 2019 00:45:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216004522epsmtrp195288207fd38caf8dc6ee3651a632978~gs2aZcB2Y2107121071epsmtrp19;
        Mon, 16 Dec 2019 00:45:22 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-52-5df6d3a38a79
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.C8.10238.2A3D6FD5; Mon, 16 Dec 2019 09:45:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216004522epsmtip2a349e34b2a186331be05484d1c596d08~gs2aHWWc12795527955epsmtip2n;
        Mon, 16 Dec 2019 00:45:22 +0000 (GMT)
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
Message-ID: <693e250d-9656-df67-9685-188020b43542@samsung.com>
Date:   Mon, 16 Dec 2019 09:51:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20190919142236.4071-9-a.swigon@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmvu7iy99iDfZe0LC4P6+V0WLjjPWs
        FvOPnGO1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2ixV3P7JabHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3Hxnc7mDz6tqxi9Pi8SS6A
        PSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfobiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFC
        dsaqyfNYCvrkKmbMmcbWwLhQvIuRk0NCwERi2vf/bF2MXBxCAjsYJd71vWEGSQgJfGKUmN4f
        BpH4xihxp/07M0xH/7o2RojEXkaJrgmtUM57RonzXx6zgVQJC6RLXO/8xASSEBH4zyhxetlK
        VhCHWeAYo8TeOz9ZQKrYBLQk9r+4AdbBL6AocfXHY0YQm1fATuLtvadMIDaLgKrEp7NXweKi
        AmESJ7e1QNUISpyc+QRoDgcHp4ClROdsfZAws4C4xK0n85kgbHmJ5q2zoc7exS4xaZ0qhO0i
        8WdDLzuELSzx6vgWKFtK4mV/G5RdLbHy5BFwwEgIdDBKbNl/gRUiYSyxf+lkJpC9zAKaEut3
        6UOEFSV2/p7LCLGXT+Ld1x5WkBIJAV6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8swsJB/M
        QvLBLIRlCxhZVjGKpRYU56anFhsWmCDH9iZGcJrWstjBuOeczyFGAQ5GJR7eFxnfYoVYE8uK
        K3MPMUpwMCuJ8KZqf44V4k1JrKxKLcqPLyrNSS0+xGgKDOuJzFKiyfnAHJJXEm9oamRsbGxh
        YmhmamioJM7L8eNirJBAemJJanZqakFqEUwfEwenVANjbBfLzxqn93mu+0qKTX8UWjoLZ7/O
        dekWjwi+U+qpytI+wXL2zXPzGbZfE/4Rl2g1Z/UlWcXpLRt3qi8OzBD+1swyI8p83Y7opp6b
        K49b5SdX3Sq8/uuN68T59UdK/23ZHvLg2LkP1XVB0atn1antT+MK+Vq4WJcr7bRJm9Me6T2P
        naIvvAlQYinOSDTUYi4qTgQAXewU4OkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvO6iy99iDZo+aVncn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HsVlk5Kak1mWWqRvl8CVsWryPJaCPrmKGXOmsTUwLhTvYuTkkBAwkehf18bYxcjFISSwm1Hi
        ypG5LBAJSYlpF48ydzFyANnCEocPF0PUvGWUmNHbwgpSIyyQLnG98xMTSEJE4D+jxMO2Y2CT
        mAWOMUp8XLGeFW7sgqMPmUBa2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCTeHvvKVgNi4CqxKez
        V8HiogJhEjuXPGaCqBGUODnzCQvISZwClhKds/VBwswC6hJ/5l1ihrDFJW49mc8EYctLNG+d
        zTyBUXgWku5ZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4JjV
        0tzBeHlJ/CFGAQ5GJR5eh+xvsUKsiWXFlbmHGCU4mJVEeFO1P8cK8aYkVlalFuXHF5XmpBYf
        YpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwBj76rf0OfvNDTY1mfliR3v2OvZpVap/
        t+Q58FRp2wzGm6sC0jt/zpeUZwx/mz1jf9PK7d69e7R8fxsVGH8Xv70nNeD4jCs9O5IlXh3+
        FONhE8Rz89xV+Yld4imrir30TJcskbt7o2OFE98udVlduRCD3woCT329tB7ecLx40d+r3Hlq
        XF/+dCWW4oxEQy3mouJEAE1MdK/VAgAA
X-CMS-MailID: 20191216004522epcas1p3dd06bfb24212c2fee558e7a7a23cf65c
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

As I mentioned on other reply,
I'm not sure to use the specific 'parent' property to make
the connection between buses. If possible, you better to
use the standard way like OF graph. Except for making
the connection between buses by 'parent' property,
looks good to me.


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
