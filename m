Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B392111FC52
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 01:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLPAup (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 19:50:45 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:39110 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfLPAup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 19:50:45 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191216005041epoutp04b20d52be8419f42d9709938b5f854b97~gs7DpMArt1856918569epoutp04M
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 00:50:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191216005041epoutp04b20d52be8419f42d9709938b5f854b97~gs7DpMArt1856918569epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576457442;
        bh=YR5okB+wE/Z5Q0Ri2lb11HOcE/emcjAXckc5wfCRTkM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I3dI0KrWAmrSzVtHZtkVD/d/o5L7//30G4VTAZe57bnq8hNoPYea4O1Dv/45WDE4y
         QALks5yqv/I7buOaIWVjampWF/FnZDkUK3utpR56fdmvKQJ4diA193tmb+q7OO1GV4
         wwcJE1SClXAnVAAGrSL8rG8rXC5Qn1dgXOZpU9IQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191216005041epcas1p1b0ae2eebb1b374c2dd9c60594bab86c0~gs7DN11mb1634216342epcas1p1A;
        Mon, 16 Dec 2019 00:50:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47bjPB5KS0zMqYkZ; Mon, 16 Dec
        2019 00:50:38 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.B7.57028.6D4D6FD5; Mon, 16 Dec 2019 09:50:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191216005030epcas1p191ea4419b39728833efab03c75ce42cc~gs64xzxfP1857218572epcas1p1w;
        Mon, 16 Dec 2019 00:50:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191216005030epsmtrp23c57b205909841b728479d74b61e75e1~gs64xBc4f1502215022epsmtrp2T;
        Mon, 16 Dec 2019 00:50:30 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-98-5df6d4d6d0e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.AA.06569.6D4D6FD5; Mon, 16 Dec 2019 09:50:30 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216005029epsmtip22675afefb21a12808597f328abc97c95~gs64cAA_w2795427954epsmtip2h;
        Mon, 16 Dec 2019 00:50:29 +0000 (GMT)
Subject: Re: [RFC PATCH v2 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     myungjoo.ham@samsung.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, georgi.djakov@linaro.org,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Organization: Samsung Electronics
Message-ID: <61a0b84c-9154-81f6-717c-b0b684b98830@samsung.com>
Date:   Mon, 16 Dec 2019 09:57:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <f0453b39-fd05-9824-ee24-39b6bd587876@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmru61K99iDVqWalvcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0t5JC
        WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAh
        O2PvpcmMBbMVKrpeLWVpYGyV7GLk4JAQMJGY3hbXxcjFISSwg1Hi8tNrLBDOJ0aJp2t2skI4
        3xglGmYfZ+xi5ATrePVwHxNEYi+jxItlp5khnPeMEjuPb2MCqRIWSJe43vkJzGYT0JLY/+IG
        G0iRiMB/RonTy1aCzWUWOMYosffOTxaQKn4BRYmrPx6D7eAVsJPonLmGGcRmEVCVWPGsG6xG
        VCBM4uS2FqgaQYmTM5+AxTkF7CXaFu8Aq2cWEJe49WQ+E4QtL9G8dTbYeRIC+9glJh9+ww7x
        hIvEuqVT2CBsYYlXx7dAxaUkPr/bCxWvllh58ggbRHMHo8SW/RdYIRLGEvuXTmYChR+zgKbE
        +l36EGFFiZ2/5zJCLOaTePe1hxUSxLwSHW1CECXKEpcf3GWCsCUlFrd3sk1gVJqF5J1ZSF6Y
        heSFWQjLFjCyrGIUSy0ozk1PLTYsMESO702M4FStZbqDcco5n0OMAhyMSjy8DtnfYoVYE8uK
        K3MPMUpwMCuJ8KZqf44V4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKiyfnAPJJXEm9oamRsbGxh
        YmhmamioJM7L8eNirJBAemJJanZqakFqEUwfEwenVAMjx/99vLOm9MWFbH15YLqjyCy2c49C
        N6/ji1qWbfPy7Te23IusuW7XQ8QifompNgR/c6qw2ntnlcgOq4O8201szZ+u1N92R87FXMWo
        aEWxkGPQN+uJO6wz/m0JYEvu4f1j/6xL6KWb4ro9odHqM4rzlvA4yQjZBfz7aVd6x7K5clGp
        4/VvlX5KLMUZiYZazEXFiQA48xwr6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvO61K99iDRZd4bK4P6+V0WLjjPWs
        FvOPnGO1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2ixV3P7JabHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3Hxnc7mDz6tqxi9Pi8SS6A
        PYrLJiU1J7MstUjfLoErY++lyYwFsxUqul4tZWlgbJXsYuTkkBAwkXj1cB8TiC0ksJtR4tYU
        I4i4pMS0i0eZuxg5gGxhicOHi7sYuYBK3jJKzDvZzApSIyyQLnG98xNYL5uAlsT+FzfYQIpE
        BP4zSjxsO8YI4jALHGOU+LhiPStE+wdGicVzHzKDtPALKEpc/fGYEcTmFbCT6Jy5BizOIqAq
        seJZNwuILSoQJrFzyWMmiBpBiZMzn4DFOQXsJdoW7wCrZxZQl/gz7xKULS5x68l8JghbXqJ5
        62zmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTH
        rJbWDsYTJ+IPMQpwMCrx8Dpkf4sVYk0sK67MPcQowcGsJMKbqv05Vog3JbGyKrUoP76oNCe1
        +BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVAPjku6G8598Zwdt/vx14t8357YGhF7b
        9orhRcMascDwpFOTKtblia67cmhJ9VrdW++TnJe1zqgKuZ9742REh2Cv2Jzmr3x2lXm781Mj
        ojW+an1zYBPVjT5UXf5SOj1P22fhZqVTfgKrTe93nXI6fdl8Y0DIaiGvJNE1Aat2c0+ZvGL2
        puv95mt0lFiKMxINtZiLihMBTBV6KtUCAAA=
X-CMS-MailID: 20191216005030epcas1p191ea4419b39728833efab03c75ce42cc
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
        <f0453b39-fd05-9824-ee24-39b6bd587876@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Please ignore second reply. It is my mistake
to send the duplicate message because of my company firewall issue.

Regards,
Chanwoo Choi

On 12/16/19 9:55 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 9/19/19 11:22 PM, Artur Świgoń wrote:
>> From: Artur Świgoń <a.swigon@partner.samsung.com>
>>
>> This patch adds two fields to the Exynos4412 DTS:
>>   - parent: to declare connections between nodes that are not in a
>>     parent-child relation in devfreq;
>>   - #interconnect-cells: required by the interconnect framework.
>>
>> Please note that #interconnect-cells is always zero and node IDs are not
>> hardcoded anywhere. The above-mentioned parent-child relation in devfreq
>> means that there is a shared power line ('devfreq' property). The 'parent'
>> property only signifies an interconnect connection.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
>>  arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> index ea55f377d17c..bdd61ae86103 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> @@ -106,6 +106,7 @@
>>  &bus_leftbus {
>>  	devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>>  	vdd-supply = <&buck3_reg>;
>> +	parent = <&bus_dmc>;
> 
> As I mentioned on other patch,
> I'm not sure to use 'parent' property for this driver.
> If possible, we better to use the standard way like OF graph
> in order to make the tree between buses. Except for making
> the connection between the buses with 'parent', looks good to me.
> 
>>  	status = "okay";
>>  };
>>  
>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>> index d20db2dfe8e2..a70a671acacd 100644
>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>> @@ -390,6 +390,7 @@
>>  			clocks = <&clock CLK_DIV_DMC>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_dmc_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -398,6 +399,7 @@
>>  			clocks = <&clock CLK_DIV_ACP>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_acp_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -406,6 +408,7 @@
>>  			clocks = <&clock CLK_DIV_C2C>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_dmc_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -459,6 +462,7 @@
>>  			clocks = <&clock CLK_DIV_GDL>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_leftbus_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -467,6 +471,7 @@
>>  			clocks = <&clock CLK_DIV_GDR>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_leftbus_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -475,6 +480,7 @@
>>  			clocks = <&clock CLK_ACLK160>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_display_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -483,6 +489,7 @@
>>  			clocks = <&clock CLK_ACLK133>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_fsys_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -491,6 +498,7 @@
>>  			clocks = <&clock CLK_ACLK100>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_peri_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>> @@ -499,6 +507,7 @@
>>  			clocks = <&clock CLK_SCLK_MFC>;
>>  			clock-names = "bus";
>>  			operating-points-v2 = <&bus_leftbus_opp_table>;
>> +			#interconnect-cells = <0>;
>>  			status = "disabled";
>>  		};
>>  
>>
> 
> 
