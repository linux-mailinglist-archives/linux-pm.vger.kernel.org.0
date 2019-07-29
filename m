Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F282782FF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 03:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfG2BRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 21:17:32 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:23226 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2BRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jul 2019 21:17:32 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190729011729epoutp038101ac6b694b0966f9225dc952aca434~1u_efjqdz2620626206epoutp03y
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 01:17:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190729011729epoutp038101ac6b694b0966f9225dc952aca434~1u_efjqdz2620626206epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564363049;
        bh=S6WvFuHyC3NX9s6k4IjzrHq6hRq/ZQFcaSzn6Sw1BmA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NSti5Mub5ui1d98vSVw4ffDwBRw+AQx/tqrjpIAcZjo+xQtayFTDxecgfakGfQQ1b
         A2LOztQfIhR7usqT9IKXNmN8Bb3pfZpW0kaaJZfnG0ncjZpsdAN9xiunZrRO5XYA5k
         8ehCzR7DMLc+I/B4i47WLhhqsC2qIky5igSDdo/U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190729011728epcas1p32a387721ae32336480c6ab141ef236a1~1u_d7Wn3a2966729667epcas1p3q;
        Mon, 29 Jul 2019 01:17:28 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45xhch635NzMqYls; Mon, 29 Jul
        2019 01:17:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.7E.04088.F194E3D5; Mon, 29 Jul 2019 10:17:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190729011718epcas1p27e2688e814efde7913e27a4050c3ace3~1u_VAXdu72470324703epcas1p2R;
        Mon, 29 Jul 2019 01:17:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190729011718epsmtrp1de5659750d6cffc81b1eb1afb6647a7e~1u_U-jPy-2021620216epsmtrp1R;
        Mon, 29 Jul 2019 01:17:18 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-69-5d3e491fb4b4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.90.03706.E194E3D5; Mon, 29 Jul 2019 10:17:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190729011718epsmtip2eebd1c41819dae9d269918a295727d26~1u_Uwk3X61549815498epsmtip2b;
        Mon, 29 Jul 2019 01:17:18 +0000 (GMT)
Subject: Re: [RFC PATCH 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
To:     Marek Szyprowski <m.szyprowski@samsung.com>, cwchoi00@gmail.com,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <64416ab4-855e-2bb6-199c-64086663a29f@samsung.com>
Date:   Mon, 29 Jul 2019 10:20:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cc4c48c3-06a5-c58f-20de-0aa18ae8667e@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOJsWRmVeSWpSXmKPExsWy7bCmga68p12swdGD0haHjm1lt3h2VNti
        /pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslvc
        blzBZjFj8ks2Bz6PnbPusntsWtXJ5nHn2h42j/vdx5k8Ni+p9zj4bg+TR9+WVYwenzfJBXBE
        ZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2tpFCW
        mFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjO
        WNR0nqXgs2HFjw0HGRsYHyh0MXJwSAiYSGx4btrFyMUhJLCDUaJvx0U2COcTkHPwKzuE841R
        4s6bI4xdjJxgHT/PPoJK7GWU2HNrHiuE855RYsruaWBVwgIpEi/2nWUESYgItDFK7P3dCjaY
        WeAqs0TvpEMsIFVsAloS+1/cYAOx+QUUJa7+eAzWzStgJ/FoZycriM0ioCqx8c5HsLioQITE
        pweHWSFqBCVOznwCNodTwF7i9IoNYHFmAXGJW0/mM0HY8hLNW2czgyyWENjHLjHjxBRmiCdc
        JDo/HmKDsIUlXh3fwg5hS0m87G+DsqslVp48wgbR3MEosWX/BVaIhLHE/qWTmUDhxyygKbF+
        lz5EWFFi5++5jBCL+STefe1hhQQxr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaSF2Yh
        eWEWwrIFjCyrGMVSC4pz01OLDQsMkeN7EyM4UWuZ7mCccs7nEKMAB6MSD++La7axQqyJZcWV
        uYcYJTiYlUR4tyhZxwrxpiRWVqUW5ccXleakFh9iNAWG9kRmKdHkfGAWySuJNzQ1MjY2tjAx
        NDM1NFQS5134wyJWSCA9sSQ1OzW1ILUIpo+Jg1OqgVFUTvrSp8pJTaxTXQ/6GdtluYdZyjtV
        pf0t9ve89mV7w4oP8e8vbU79ZrHYV3nqQ5OLr+dOSyte+2HePP+50jnFAk8y3+rMf6UqG8cr
        YnhpW0HRCleZ1hl7rMUmnE542Ph+99IZa8IVoyRfltavt3ZQvnviVXPT9SeHwrN+ZzqtXKfR
        nlqwr0mJpTgj0VCLuag4EQAlOg4c6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvK6cp12swbxOfYtDx7ayWzw7qm0x
        /8g5VosrX9+zWUzfu4nNYtL9CSwW589vYLfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S1u
        N65gs5gx+SWbA5/Hzll32T02repk87hzbQ+bx/3u40wem5fUexx8t4fJo2/LKkaPz5vkAjii
        uGxSUnMyy1KL9O0SuDIWNZ1nKfhsWPFjw0HGBsYHCl2MnBwSAiYSP88+Yu9i5OIQEtjNKPFh
        +ilWiISkxLSLR5m7GDmAbGGJw4eLIWreMkrsWL6KGaRGWCBF4sW+s4wgCRGBNkaJbeuamEAc
        ZoHrzBKvL3xkhGg5ySQxY/8NNpAWNgEtif0vIGx+AUWJqz8eM4LYvAJ2Eo92doKtZhFQldh4
        5yNYXFQgQuLwjllQNYISJ2c+YQGxOQXsJU6v2ABWzyygLvFn3iVmCFtc4taT+UwQtrxE89bZ
        zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjlkt
        zR2Ml5fEH2IU4GBU4uF1uGkbK8SaWFZcmXuIUYKDWUmEd4uSdawQb0piZVVqUX58UWlOavEh
        RmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjOkGp2/z5fBZLU+flvvygm+kx2xB38cd
        Xx5tzQ/LthWN6OLiSjP6/X365uUTd856cUn29mnJ29/SuZdXyu+bn7+e8WyM/kv2vzfOnCs4
        c5ZR65KGuOsloavaflPmnL7jHfrDbMfdVqPzLf9Wyk6fumqf2K2kRZvMpzJMz1Gu0f5f2rTk
        cdGZl9uUWIozEg21mIuKEwFGwdtI1QIAAA==
X-CMS-MailID: 20190729011718epcas1p27e2688e814efde7913e27a4050c3ace3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
References: <CGME20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98@eucas1p2.samsung.com>
        <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <20190723122016.30279-9-a.swigon@partner.samsung.com>
        <CAGTfZH1_Qk+vNa_AJW_8OA8MJbnZa3yCTLLRs2w23bNTm72gyQ@mail.gmail.com>
        <cc4c48c3-06a5-c58f-20de-0aa18ae8667e@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 7. 26. 오후 9:02, Marek Szyprowski wrote:
> Hi
> 
> On 2019-07-25 15:13, Chanwoo Choi wrote:
>> 2019년 7월 24일 (수) 오전 8:07, Artur Świgoń <a.swigon@partner.samsung.com>님이 작성:
>>> This patch adds two fields tp the Exynos4412 DTS:
>>>    - parent: to declare connections between nodes that are not in a
>>>      parent-child relation in devfreq;
>>>    - #interconnect-cells: required by the interconnect framework.
>>>
>>> Please note that #interconnect-cells is always zero and node IDs are not
>>> hardcoded anywhere.
>>>
>>> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
>>> ---
>>>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
>>>   arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
>>>   2 files changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> index ea55f377d17c..bdd61ae86103 100644
>>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> @@ -106,6 +106,7 @@
>>>   &bus_leftbus {
>>>          devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>>>          vdd-supply = <&buck3_reg>;
>>> +       parent = <&bus_dmc>;
>> It is wrong. 'bus_leftbus' has not any h/w dependency of 'bus_dmc'
>> and 'bus_leftbus' is not child of 'bus_dmc'.
>>
>> Even it there are some PMQoS requirement between them,
>> it it not proper to tie both 'bus_leftbus' and 'bus_dmc'.
> 
> There is strict dependency between them. DMC bus running at frequency 
> lower than left (or right) bus really doesn't make much sense, because 
> it will limit the left bus performance. This dependency should be 
> modeled somehow.

I misunderstood new 'parent' prototype as the existing 'devfreq' property.
I didn't understand why use the 'devfreq' property because 'bus_dmc' and
'bus_leftbus' don't share the power line. Please ignore my previous comment.

Basically, I agree that it is necessary to support the QoS requirement
between buses or if possible, between bus and gpu.

To support the interconnect between bus_dmc, bus_leftbus and bus_display,
it used the either 'devfreq' or 'parent' properties to connect them.

In order to catch the meaning of 'devfreq' and 'parent' properties,
If possible, it would be separate the usage role of between 'devfreq'
or 'parent' properties. Because it is possible to connect the 'buses'
with only using 'parent' property if all buses in the path uses
the devfreq governors except for 'passive' governor.

- If 'devfreq' property is used between buses,
  it indicates that there are requirement of shading of power line.
- If 'parent' property is used between buses,
  it indicates that there are requirement of interconnect connection.

> 
>>>          status = "okay";
>>>   };
>>>
>>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>>> index d20db2dfe8e2..a70a671acacd 100644
>>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>>> @@ -390,6 +390,7 @@
>>>                          clocks = <&clock CLK_DIV_DMC>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_dmc_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -398,6 +399,7 @@
>>>                          clocks = <&clock CLK_DIV_ACP>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_acp_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -406,6 +408,7 @@
>>>                          clocks = <&clock CLK_DIV_C2C>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_dmc_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -459,6 +462,7 @@
>>>                          clocks = <&clock CLK_DIV_GDL>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_leftbus_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -467,6 +471,7 @@
>>>                          clocks = <&clock CLK_DIV_GDR>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_leftbus_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -475,6 +480,7 @@
>>>                          clocks = <&clock CLK_ACLK160>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_display_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -483,6 +489,7 @@
>>>                          clocks = <&clock CLK_ACLK133>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_fsys_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -491,6 +498,7 @@
>>>                          clocks = <&clock CLK_ACLK100>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_peri_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> @@ -499,6 +507,7 @@
>>>                          clocks = <&clock CLK_SCLK_MFC>;
>>>                          clock-names = "bus";
>>>                          operating-points-v2 = <&bus_leftbus_opp_table>;
>>> +                       #interconnect-cells = <0>;
>>>                          status = "disabled";
>>>                  };
>>>
>>> --
>>> 2.17.1
>>>
>>
> Best regards
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
