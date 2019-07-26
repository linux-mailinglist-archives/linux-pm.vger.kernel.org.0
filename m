Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24A276513
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 14:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfGZMCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 08:02:43 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56961 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfGZMCm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 08:02:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190726120239euoutp025a7a9f8c98d9430d1872e9e289e6496e~08179R0oQ3068230682euoutp02G
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 12:02:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190726120239euoutp025a7a9f8c98d9430d1872e9e289e6496e~08179R0oQ3068230682euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564142559;
        bh=DpZBxh2b3FgthXala1yFlfzP7R3sugOAntJqovIx5ks=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gkZItRGkiEfS246wY2lcNcwXj1+9oKYG/cG/j0IFhNQI4up5bXH43DY/Eo7ILurcL
         LNogapGj+FApDzNMGsX1lgXEwGsfR/aiC0ugaf87G1p9v3jkyoMRpZEY1KZyqCV5cb
         ypjeiakYVqv/zpJMgiESU5X1LFkjwM11kPVrxpPU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190726120239eucas1p20656c7e558391a8f78390c795dafdbbe~0817JtnK02738827388eucas1p2t;
        Fri, 26 Jul 2019 12:02:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CE.45.04377.EDBEA3D5; Fri, 26
        Jul 2019 13:02:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190726120238eucas1p243c54e3f3ff3d514e3873d40e2bdf3ab~0816VHYQC0843408434eucas1p2o;
        Fri, 26 Jul 2019 12:02:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190726120237eusmtrp21bb6a34874d8337ecbd2413f228e72b4~0816EElWM1338313383eusmtrp2e;
        Fri, 26 Jul 2019 12:02:37 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-dc-5d3aebdef158
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.DF.04140.DDBEA3D5; Fri, 26
        Jul 2019 13:02:37 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190726120237eusmtip2c70175156eed774cdc329002f19d0590~0815ZG3vE1048010480eusmtip2N;
        Fri, 26 Jul 2019 12:02:37 +0000 (GMT)
Subject: Re: [RFC PATCH 08/11] arm: dts: exynos: Add parents and
 #interconnect-cells to Exynos4412
To:     cwchoi00@gmail.com,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, inki.dae@samsung.com,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        georgi.djakov@linaro.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <cc4c48c3-06a5-c58f-20de-0aa18ae8667e@samsung.com>
Date:   Fri, 26 Jul 2019 14:02:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH1_Qk+vNa_AJW_8OA8MJbnZa3yCTLLRs2w23bNTm72gyQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRD16263S0Pxs6BM0ABpgihGEKJxBaNoMNk/GDz+eBCosuGQcrRQ
        PGLkSDwQEDAEKAjG4JEmeBRKKCBSBCoQAVFR5I6IoIIJrT84BCkryr83b97Mm5cMTUj7hE50
        ZEwCp4yRR8soMVnVMtOxffC7b/CO1FseTGOLXsR8sHwVMmPN25jSpg4h8+7XT4rJf66jmNyh
        bJLp7HwqYnSfe4TM25piijFnNiGmoLNewPSlPKKYgtsTlL8da9AMiFid9gbF9vfUUezQTZOA
        rSi7whqn6gRsVqUWsWadcxB9Urw3jIuOVHNKr32h4oj7IxmCuEX38wv9RpSM2iEd2dCAd8JE
        wyBKR2Jaih8haKttFfCFBcFsRxnJF2YEOcUjwpWRnPtGgm88RJA31vt3ZBKB+ZVBZFXZ4zAY
        r3+NrNgBn4Bc09VlEwLPEZB1Z25ZRGFvSJ9Mp6xYgvfB6ND0EqZpErtBQ8V+K70enwbDjwyC
        l6yD1sJR0opt8BEwFJcsjxLYBdL0RQSPHeHTaOnyQYB/iyD78XuRdSfgAHgxsJZPYA/fTJUi
        Hm+CRcOKPg3BSEe5iC8yELxNLUC8yg9emt4IrYsIvBWe1Hjx9AGwtF8j+f128HFyHX+DHeRW
        5RM8LYHrV6W8ejNoTI//2Rq7uolsJNOsSqZZlUazKo3mv+9dRGqRI5eoUoRzKp8YLslTJVeo
        EmPCPc/GKnRo6eXaF0yWalQzf6YRYRrJbCVbtHuCpUK5WnVB0YiAJmQOEn31EiUJk1+4yClj
        Q5SJ0ZyqEW2kSZmj5NKa4VNSHC5P4M5xXBynXOkKaBunZJQkVh5NSUVj8cVNx20PWgTds4eL
        jjVDSNe92sL4jSXeifOZltoBlzXDisvmeDWbVP5gIVCBt7i32U6luNplTEc9m3lwfVfohqii
        CLcydaDPnviE8f5Fbe96fQA3dMjJVv9kxh/tftjlEJnn6xHqUYCD1PbO3BeTG1EX6MpO+8lI
        VYTc24NQquR/AB0p7rFuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xe7p3X1vFGlzdpGdx6NhWdovrX56z
        Wjw7qm0x/8g5VosrX9+zWUzfu4nNYtL9CSwW589vYLfY9Pgaq8XlXXPYLD73HmG0mHF+H5PF
        7cYVbBYzJr9kc+Dz2DnrLrvHplWdbB53ru1h87jffZzJY/OSeo+D7/YwefRtWcXo8XmTXABH
        lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G0oc9
        TAX/1Sv+3TnI2MB4WqKLkZNDQsBEYuLSg8xdjFwcQgJLGSX+TjrBBpGQkTg5rYEVwhaW+HOt
        iw2i6DWjxOYJL1lAEsICKRIv9p1lBLFFBCIlGpZPYQIpYhb4yyyxf80dRoiOKUwS/V8vgHWw
        CRhKdL3tAlvBK2An8eT+JyCbg4NFQFXiwGZ7kLCoQIzEvjPb2SFKBCVOznwC1sopECixc848
        sFZmATOJeZsfMkPY8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpu
        sZFecWJucWleul5yfu4mRmBcbzv2c8sOxq53wYcYBTgYlXh4Lyy3jBViTSwrrsw9xCjBwawk
        wrt1B1CINyWxsiq1KD++qDQntfgQoynQbxOZpUST84EpJ68k3tDU0NzC0tDc2NzYzEJJnLdD
        4GCMkEB6YklqdmpqQWoRTB8TB6dUA2NYbcmhy2fqTspY9euu6pqnIX6Fe8qX91pm/4+lM/L/
        z/33OtY9cZ/AuWUqhcfN/vol6zwv13h0uOBgu9WHumdBBp8Vtz6aVSiU7/R62hNj8z9Fxyds
        XsxXoPvNyWglu+ah+w8Yp9mePq0SEvrt6+5Jz142rZzLlm049+gVk/jFyV6CgT0L4pYrsRRn
        JBpqMRcVJwIArD3n3wEDAAA=
X-CMS-MailID: 20190726120238eucas1p243c54e3f3ff3d514e3873d40e2bdf3ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98
References: <CGME20190723122027eucas1p24b1d76e3139f7cc52614d7613ff9ba98@eucas1p2.samsung.com>
        <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <20190723122016.30279-9-a.swigon@partner.samsung.com>
        <CAGTfZH1_Qk+vNa_AJW_8OA8MJbnZa3yCTLLRs2w23bNTm72gyQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

On 2019-07-25 15:13, Chanwoo Choi wrote:
> 2019년 7월 24일 (수) 오전 8:07, Artur Świgoń <a.swigon@partner.samsung.com>님이 작성:
>> This patch adds two fields tp the Exynos4412 DTS:
>>    - parent: to declare connections between nodes that are not in a
>>      parent-child relation in devfreq;
>>    - #interconnect-cells: required by the interconnect framework.
>>
>> Please note that #interconnect-cells is always zero and node IDs are not
>> hardcoded anywhere.
>>
>> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 +
>>   arch/arm/boot/dts/exynos4412.dtsi               | 9 +++++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> index ea55f377d17c..bdd61ae86103 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> @@ -106,6 +106,7 @@
>>   &bus_leftbus {
>>          devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>>          vdd-supply = <&buck3_reg>;
>> +       parent = <&bus_dmc>;
> It is wrong. 'bus_leftbus' has not any h/w dependency of 'bus_dmc'
> and 'bus_leftbus' is not child of 'bus_dmc'.
>
> Even it there are some PMQoS requirement between them,
> it it not proper to tie both 'bus_leftbus' and 'bus_dmc'.

There is strict dependency between them. DMC bus running at frequency 
lower than left (or right) bus really doesn't make much sense, because 
it will limit the left bus performance. This dependency should be 
modeled somehow.

>>          status = "okay";
>>   };
>>
>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>> index d20db2dfe8e2..a70a671acacd 100644
>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>> @@ -390,6 +390,7 @@
>>                          clocks = <&clock CLK_DIV_DMC>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_dmc_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -398,6 +399,7 @@
>>                          clocks = <&clock CLK_DIV_ACP>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_acp_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -406,6 +408,7 @@
>>                          clocks = <&clock CLK_DIV_C2C>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_dmc_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -459,6 +462,7 @@
>>                          clocks = <&clock CLK_DIV_GDL>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_leftbus_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -467,6 +471,7 @@
>>                          clocks = <&clock CLK_DIV_GDR>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_leftbus_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -475,6 +480,7 @@
>>                          clocks = <&clock CLK_ACLK160>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_display_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -483,6 +489,7 @@
>>                          clocks = <&clock CLK_ACLK133>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_fsys_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -491,6 +498,7 @@
>>                          clocks = <&clock CLK_ACLK100>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_peri_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> @@ -499,6 +507,7 @@
>>                          clocks = <&clock CLK_SCLK_MFC>;
>>                          clock-names = "bus";
>>                          operating-points-v2 = <&bus_leftbus_opp_table>;
>> +                       #interconnect-cells = <0>;
>>                          status = "disabled";
>>                  };
>>
>> --
>> 2.17.1
>>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

