Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8511FD02
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 03:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLPCwv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 21:52:51 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:14046 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfLPCwv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 21:52:51 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191216025246epoutp0129c603800a343dc654f170cfc7d89b11~gulpSqKdT1373613736epoutp01c
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 02:52:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191216025246epoutp0129c603800a343dc654f170cfc7d89b11~gulpSqKdT1373613736epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576464766;
        bh=/PWYmeUhh3ou+AZOp2VAT0jkte7v9srIXdaSGzR3udg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p4xhlFqFTdkJYKSnAHwZxP4JU3aaRY33TG4wrQ8DRF/npI3l34PtV3cTl0SKuUmlX
         UUg+SriHTpvY5BP/tEW89C2Rk4vE+zV4gV3t/YZ32nKlz5EdHvZtocZxvChXgCxzia
         ma6SwbgGVYNwGedbUb1TexDvZLBAsJNJ1vc+Horo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191216025246epcas1p3eff9b42f49bcd6e27e8c91891e9f4c31~gulotuucC2925429254epcas1p3I;
        Mon, 16 Dec 2019 02:52:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47bm626JyYzMqYkV; Mon, 16 Dec
        2019 02:52:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.10.48019.A71F6FD5; Mon, 16 Dec 2019 11:52:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191216025242epcas1p4af6a46c4d50f5e41a44d50b0fdfc1825~gullMawfQ1584215842epcas1p4B;
        Mon, 16 Dec 2019 02:52:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191216025242epsmtrp182ab11862d87b6219cde22d349bbaad6~gullKire_1347813478epsmtrp1F;
        Mon, 16 Dec 2019 02:52:42 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-0c-5df6f17a2b32
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.A6.06569.A71F6FD5; Mon, 16 Dec 2019 11:52:42 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191216025242epsmtip2ef8a4df971d610f9c2658d0b080c8238~gulk84ytd2221022210epsmtip22;
        Mon, 16 Dec 2019 02:52:42 +0000 (GMT)
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
Message-ID: <eecc5d38-f6ab-b1ea-1a08-0afb2dcddbef@samsung.com>
Date:   Mon, 16 Dec 2019 11:59:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <693e250d-9656-df67-9685-188020b43542@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRmVeSWpSXmKPExsWy7bCmgW7Vx2+xBjuXmFjcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0t5JC
        WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAh
        O+Nv3yWmgitaFT233zE3MC5Q7GLk5JAQMJG4sOYscxcjF4eQwA5GiZl7T0A5nxglFp5vY4Fw
        vjFKbL+6lRWm5eLJ71BVexkl/l1+yAaSEBJ4zyix54I/iC0skC5xvfMTE4jNJqAlsf/FDTaQ
        BhGB/4wSp5etZAVxmAWOMUrsvfOTBaSKX0BR4uqPx4wgNq+AncTMc7vBprIIqEosXHsAbJKo
        QJjEyW0tUDWCEidnPgHr5RSwl/g2axoziM0sIC5x68l8JghbXqJ562xmiLMPsUvcWm7RxcgB
        ZLtIHNiWDhEWlnh1fAs7hC0l8bK/Dcqullh58gjY0RICHYwSW/ZfgHrfWGL/0slMIHOYBTQl
        1u/ShwgrSuz8PZcRYi2fxLuvPawQq3glOtqEIEqUJS4/uMsEYUtKLG7vZJvAqDQLyTOzkDww
        C8kDsxCWLWBkWcUollpQnJueWmxYYIIc25sYwWlay2IH455zPocYBTgYlXh4X2R8ixViTSwr
        rsw9xCjBwawkwpuq/TlWiDclsbIqtSg/vqg0J7X4EKMpMKwnMkuJJucDc0heSbyhqZGxsbGF
        iaGZqaGhkjgvx4+LsUIC6YklqdmpqQWpRTB9TBycUg2MWkdTU5UD35r9mTk3s0CapziH/4rd
        xyYfi89eMmnXN+w3Or1NIplB41bI+zdvJt4+czxqodS68/8L36hd7+lfvPHEhosm2unxYZ+W
        tapqC1ixXZmywOZ6/fOJnnc4p1+aOIl3Bcuk2yvy5JdIvt06q76s9ted9k2dXFHWRSWtT8w9
        O1xm6HBrKbEUZyQaajEXFScCAMLL5vvpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCSvG7Vx2+xBhvO81jcn9fKaLFxxnpW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xYq7H1ktNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2CxmTH7J5sDvsWlVJ5vHnWt72Dzudx9n8ti8pN5j47sdTB59W1YxenzeJBfA
        HsVlk5Kak1mWWqRvl8CV8bfvElPBFa2KntvvmBsYFyh2MXJySAiYSFw8+Z25i5GLQ0hgN6NE
        97a/LBAJSYlpF48CJTiAbGGJw4eLIWreMkqs3tfNCFIjLJAucb3zExOIzSagJbH/xQ02kCIR
        gf+MEg/bjjGCOMwCxxglPq5YzwrR/oFRYvLz36wgLfwCihJXfzwGG8UrYCcx89xuNhCbRUBV
        YuHaA2BjRQXCJHYuecwEUSMocXLmE7DzOAXsJb7NmsYMYjMLqEv8mXcJyhaXuPVkPhOELS/R
        vHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC
        o1ZLawfjiRPxhxgFOBiVeHgdsr/FCrEmlhVX5h5ilOBgVhLhTdX+HCvEm5JYWZValB9fVJqT
        WnyIUZqDRUmcVz7/WKSQQHpiSWp2ampBahFMlomDU6qBUUPjxK3mjDfvVZKe+dXzbP/113KJ
        34lbYRLqM86rrfg2+9juqfv+buT880pySfiEaJtd//9FLyj6oqUbOuX4FI2nPfOFuc7wRmxw
        O8TELxituFHy0POzoenpK8t9go/e3CF4eP0Xw+nKBzI9uU3M9RgOPDuyv27rkpm6Z+vmPrHW
        4TE9FXFvs4QSS3FGoqEWc1FxIgA03wJD1gIAAA==
X-CMS-MailID: 20191216025242epcas1p4af6a46c4d50f5e41a44d50b0fdfc1825
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
        <693e250d-9656-df67-9685-188020b43542@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 12/16/19 9:51 AM, Chanwoo Choi wrote:
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
> As I mentioned on other reply,
> I'm not sure to use the specific 'parent' property to make
> the connection between buses. If possible, you better to
> use the standard way like OF graph. Except for making
> the connection between buses by 'parent' property,
> looks good to me.

I tried to think it continuously. I withdraw the my opinion
using OF graph. If you make the property name like the following
example, it is possible for exynos.
- exynos,interconnect-parent-node = <&bus_dmc>; or other proper name.

Regardless of existing 'devfreq' property, I think you better to
make the connection between buses for only interconnect as following
example: This make it possible user can draw the correct tree by tracking
the 'exynos,interconnect-parent-node' value.

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index ea55f377d17c..53f87f46e161 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -90,6 +90,7 @@
 &bus_dmc {
        devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
        vdd-supply = <&buck1_reg>;
+       #interconnect-cells = <0>;
        status = "okay";
 };
 
@@ -106,6 +107,8 @@
 &bus_leftbus {
        devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
        vdd-supply = <&buck3_reg>;
+       exynos,interconnect-parent-node = <&bus_dmc>;
+       #interconnect-cells = <0>;
        status = "okay";
 };
 
@@ -116,6 +119,8 @@
 
 &bus_display {
        devfreq = <&bus_leftbus>;
+       exynos,interconnect-parent-node = <&bus_leftbus>;
+       #interconnect-cells = <0>;
        status = "okay";
 };


> 
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


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
