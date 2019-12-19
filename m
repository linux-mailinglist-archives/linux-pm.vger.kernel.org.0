Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800AC125D74
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 10:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLSJRO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 04:17:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:22305 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLSJRO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 04:17:14 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191219091710epoutp032fe781880c9605f6036b2f5cc0216771~huxH88kRg1687116871epoutp03Q
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 09:17:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191219091710epoutp032fe781880c9605f6036b2f5cc0216771~huxH88kRg1687116871epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576747030;
        bh=veZAEGFC6kLObM0nRYW35x35QcNkIaEWhK6Y/JFi6gU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WcNXEtRjxIf1GA6PIPfTmL75HfhifdP6diP087JzIUMaGy4z2b4QHR92MnlM7boaL
         EM44pxuWcP408b7yBf/HleGYwFjMKrx99mqUvNAeQea/wRuDlChjOyG7VHciidLdUG
         tRfFqlvfy6XIAO57z0i/n4zuxhE45CNs5celIJeo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191219091710epcas1p140fb778a3ae52b73b1362714e689c49b~huxHuK0eW2146321463epcas1p1j;
        Thu, 19 Dec 2019 09:17:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47dmVC1cQNzMqYlr; Thu, 19 Dec
        2019 09:17:07 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.6A.52419.E004BFD5; Thu, 19 Dec 2019 18:17:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191219091702epcas1p353df2a266e0be579858ef1f1452abc64~huxAIkpVe1575215752epcas1p3p;
        Thu, 19 Dec 2019 09:17:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191219091702epsmtrp2855f0131e0752616ae9aff89163b12e8~huxAH2-oU0967409674epsmtrp2Y;
        Thu, 19 Dec 2019 09:17:02 +0000 (GMT)
X-AuditID: b6c32a37-5b7ff7000001ccc3-93-5dfb400ebf16
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.AB.10238.D004BFD5; Thu, 19 Dec 2019 18:17:01 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219091701epsmtip103043d3ec1f2aca2c6cda370dd16f674~huw-3OMgj1115711157epsmtip1f;
        Thu, 19 Dec 2019 09:17:01 +0000 (GMT)
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
Message-ID: <ebdb5558-2e0c-8167-8ad7-3413fa35ed8a@samsung.com>
Date:   Thu, 19 Dec 2019 18:23:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <2113afca-4f8b-ec06-ee1d-b84776b5b70d@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGuTu7s6O1dV0tT0K1TQ/QsnbcNsdSM7LNyEC0F4XYoNO6uC92
        VulBZWXlLia91cVSNLOEyBYxjUxTK4zIIkyxROmFFGkplhVFO06R//0453z3u9+9hyLUF8gQ
        ymR18g4rZ6ZJf3l9W2h4+LS4n6naobw57M3iGwq2fKRYwXZ21irZ57dLSXb0ZDtiizvvytjr
        7X3KOGWCt8ZFJhTW1aCEUe+cJGJHVnQmz2XwDg1vTbdlmKzGGHpjStraNP0KLRPORLGRtMbK
        WfgYOj4xKdxgMvvMaU0OZ872lZI4QaCXxUY7bNlOXpNpE5wxNG/PMNuj7EsFziJkW41L022W
        lYxWG6H3De7KyvzgOaW0Dybt8Rbty0WHo93IjwK8HFxVJYQb+VNq3IDgfXePUmyo8QiC7u+x
        UuMrgrI7brkbUROKhsEFUr0Jgdd14a9gGMG3xwEiB+Ld8KJxhBA5CBci+PFCIwoIXICg6sEX
        hdggcRg0D/aQIk/H86Br/A0SDVQ4Fh4VOESU44XQ5qbFiRl4K3TU5yGRVTgAOkreykX2w6vh
        XPn4xCkEDobet2UyiefCrU+lE8EA95PwqqwISfePh95CjRQ+ED48rFNKHAKjQ02kxPvhWkc7
        KWnzEdQ1P1VIDR00V52ViecQOBRu3F4mledB48+LSPKdBkNjBQrJSgX5x9XSyHx4PtAnk3gW
        VJ5wkacQ7ZmUxjMpgWdSAs9/s3Ikr0EzebtgMfICY9dN/mgvmtjJsMgGVPsksRVhCtFTVePr
        fqSqFVyOsNfSioAi6CDVy/zvqWpVBrd3H++wpTmyzbzQivS+tz5NhMxIt/k23OpMY/QROp2O
        Xc6s0DMMHayixp+lqrGRc/JZPG/nHf90MsovJBdVDBdePR+XUrNpx5qN7oNZlsvV20aHA4Jd
        UwcMl359rvxoTj7Qf2U4dLYhUNnXcu/Ygi2Npu1H/b07zwT8MoJzw+s7bwxHYsc2aaMXJ3dt
        /329i24d2tz+2NNSXZmb87soMG9JSrdh7FAoGb/GdOXdQE/kbmrRfWrVwykRFXnroyJyvbRc
        yOSYMMIhcH8AWS42bqkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTpfX4XeswfkjlhYbZ6xntVjwaQar
        xfnzG9gtLu+aw2bxufcIo8WM8/uYLNYeucvuwO6xaVUnm0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBlvJo1gb3gRUDFpulVDYyNNl2MHBwSAiYSO16odDFycQgJ7GaU2LF/E1MXIydQXFJi
        2sWjzBA1whKHDxdD1LxllOjsX84OUiMskCZxbecnZhBbRKCPUeL6rQAQmxnEnvGTCaJhPZPE
        m0Vr2EASbAJaEvtf3ACz+QUUJa7+eMwIsoBXwE7iVE8RiMkioCpxuEsJpEJUIExi55LHYOfw
        CghKnJz5hAXE5hSwl5iy4AcbxCp1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFReBaS9llIWmYh
        aZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgmNHS3MF4eUn8IUYBDkYl
        Ht4frr9ihVgTy4orcw8xSnAwK4nw3u74GSvEm5JYWZValB9fVJqTWnyIUZqDRUmc92nesUgh
        gfTEktTs1NSC1CKYLBMHp1QDY0qTYdXjQ5Ur/Zb8qHhz43Lpq9/GLQuki24X/ZmzU69h0wL3
        e6+0T1lZVX9c/veVzvrE4MsZ3gLv5W33pBmfCfcuT+X5N/1gfYnJ3cB3jk9KWHhmh8fu2c2f
        I9yoP1PuqqjY1/Rje1nUzGROVGxxF8qwzNO21hc7zBpzYleh9JzCuScduTuslViKMxINtZiL
        ihMBiBMO/JUCAAA=
X-CMS-MailID: 20191219091702epcas1p353df2a266e0be579858ef1f1452abc64
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
        <9ff5cf7a-1dea-4f35-c4d3-066c87fbe896@samsung.com>
        <2113afca-4f8b-ec06-ee1d-b84776b5b70d@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/19/19 6:09 PM, Marek Szyprowski wrote:
> Hi Chanwoo,
> 
> On 19.12.2019 10:07, Chanwoo Choi wrote:
>> On 12/19/19 5:29 PM, Marek Szyprowski wrote:
>>> Hardkernel's Odroid XU3/XU4/HC1 boards use bootloader, which configures top
>>> PLLs to the following values: MPLL: 532MHz, CPLL: 666MHz and DPLL: 600MHz.
>>>
>>> Adjust all bus related OPPs to the values that are possible to derive from
>>> the top PLL configured by the bootloader. Also add a comment for each bus
>>> describing which PLL is used for it.
>>>
>>> The most significant change is the highest rate for wcore bus. It has been
>>> increased to 532MHz as this is the value configured initially by the
>>> bootloader. Also the voltage for this OPP is changed to match the value
>>> set by the bootloader.
>>>
>>> This patch finally allows the buses to operate on the rates matching the
>>> values set for each OPP and fixes the following warnings observed on boot:
>>>
>>> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
>>> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
>>> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
>>> ...
>>> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
>>> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
>>> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
>>>
>>> The problem with setting incorrect (in some cases much lower) clock rate
>>> for the defined OPP were there from the beginning, but went unnoticed
>>> because the only way to observe it was to manually check the rate of the
>>> respective clocks. The commit 4294a779bd8d ("PM / devfreq: exynos-bus:
>>> Convert to use dev_pm_opp_set_rate()") finally revealed it, because it
>>> enabled use of the generic code from the OPP framework, which issues the
>>> above mentioned warnings.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 75 +++++++++++--------
>>>   1 file changed, 45 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>>> index 663a38d53c9e..b6d6022e8735 100644
>>> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
>>> @@ -38,42 +38,44 @@
>>>   	bus_wcore_opp_table: opp_table2 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 532MHz MPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <84000000>;
>>> +			opp-hz = /bits/ 64 <88700000>;
>>>   			opp-microvolt = <925000 925000 1400000>;
>>>   		};
>>>   		opp01 {
>>> -			opp-hz = /bits/ 64 <111000000>;
>>> +			opp-hz = /bits/ 64 <133000000>;
>>>   			opp-microvolt = <950000 950000 1400000>;
>>>   		};
>>>   		opp02 {
>>> -			opp-hz = /bits/ 64 <222000000>;
>>> +			opp-hz = /bits/ 64 <177400000>;
>>>   			opp-microvolt = <950000 950000 1400000>;
>>>   		};
>>>   		opp03 {
>>> -			opp-hz = /bits/ 64 <333000000>;
>>> +			opp-hz = /bits/ 64 <266000000>;
>>>   			opp-microvolt = <950000 950000 1400000>;
>>>   		};
>>>   		opp04 {
>>> -			opp-hz = /bits/ 64 <400000000>;
>>> -			opp-microvolt = <987500 987500 1400000>;
>>> +			opp-hz = /bits/ 64 <532000000>;
>>> +			opp-microvolt = <1000000 1000000 1400000>;
>>>   		};
>>>   	};
>>>   
>>>   	bus_noc_opp_table: opp_table3 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 666MHz CPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <67000000>;
>>> +			opp-hz = /bits/ 64 <66600000>;
>>>   		};
>>>   		opp01 {
>>> -			opp-hz = /bits/ 64 <75000000>;
>>> +			opp-hz = /bits/ 64 <74000000>;
>>>   		};
>>>   		opp02 {
>>> -			opp-hz = /bits/ 64 <86000000>;
>>> +			opp-hz = /bits/ 64 <83250000>;
>>>   		};
>>>   		opp03 {
>>> -			opp-hz = /bits/ 64 <100000000>;
>>> +			opp-hz = /bits/ 64 <111000000>;
>>>   		};
>>>   	};
>>>   
>>> @@ -81,39 +83,42 @@
>>>   		compatible = "operating-points-v2";
>>>   		opp-shared;
>>>   
>>> +		/* derived from 666MHz CPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <100000000>;
>>> +			opp-hz = /bits/ 64 <111000000>;
>>>   		};
>>>   		opp01 {
>>> -			opp-hz = /bits/ 64 <200000000>;
>>> +			opp-hz = /bits/ 64 <222000000>;
>>>   		};
>>>   	};
>>>   
>>>   	bus_fsys2_opp_table: opp_table5 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 600MHz DPLL */
>>>   		opp00 {
>>>   			opp-hz = /bits/ 64 <75000000>;
>>>   		};
>>>   		opp01 {
>>> -			opp-hz = /bits/ 64 <100000000>;
>>> +			opp-hz = /bits/ 64 <120000000>;
>>>   		};
>>>   		opp02 {
>>> -			opp-hz = /bits/ 64 <150000000>;
>>> +			opp-hz = /bits/ 64 <200000000>;
>>>   		};
>>>   	};
>>>   
>>>   	bus_mfc_opp_table: opp_table6 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 666MHz CPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <96000000>;
>>> +			opp-hz = /bits/ 64 <83250000>;
>>>   		};
>>>   		opp01 {
>>>   			opp-hz = /bits/ 64 <111000000>;
>>>   		};
>>>   		opp02 {
>>> -			opp-hz = /bits/ 64 <167000000>;
>>> +			opp-hz = /bits/ 64 <166500000>;
>>>   		};
>>>   		opp03 {
>>>   			opp-hz = /bits/ 64 <222000000>;
>>> @@ -126,8 +131,9 @@
>>>   	bus_gen_opp_table: opp_table7 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 532MHz MPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <89000000>;
>>> +			opp-hz = /bits/ 64 <88700000>;
>>>   		};
>>>   		opp01 {
>>>   			opp-hz = /bits/ 64 <133000000>;
>>> @@ -136,32 +142,34 @@
>>>   			opp-hz = /bits/ 64 <178000000>;
>>>   		};
>>>   		opp03 {
>>> -			opp-hz = /bits/ 64 <267000000>;
>>> +			opp-hz = /bits/ 64 <266000000>;
>>>   		};
>>>   	};
>>>   
>>>   	bus_peri_opp_table: opp_table8 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 666MHz CPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <67000000>;
>>> +			opp-hz = /bits/ 64 <66600000>;
>>>   		};
>>>   	};
>>>   
>>>   	bus_g2d_opp_table: opp_table9 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 666MHz CPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <84000000>;
>>> +			opp-hz = /bits/ 64 <83250000>;
>>>   		};
>>>   		opp01 {
>>> -			opp-hz = /bits/ 64 <167000000>;
>>> +			opp-hz = /bits/ 64 <111000000>;
>>>   		};
>>>   		opp02 {
>>> -			opp-hz = /bits/ 64 <222000000>;
>>> +			opp-hz = /bits/ 64 <166500000>;
>>>   		};
>>>   		opp03 {
>>> -			opp-hz = /bits/ 64 <300000000>;
>>> +			opp-hz = /bits/ 64 <222000000>;
>>>   		};
>>>   		opp04 {
>>>   			opp-hz = /bits/ 64 <333000000>;
>>> @@ -171,8 +179,9 @@
>>>   	bus_g2d_acp_opp_table: opp_table10 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 532MHz MPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <67000000>;
>>> +			opp-hz = /bits/ 64 <66500000>;
>>>   		};
>>>   		opp01 {
>>>   			opp-hz = /bits/ 64 <133000000>;
>>> @@ -181,13 +190,14 @@
>>>   			opp-hz = /bits/ 64 <178000000>;
>>>   		};
>>>   		opp03 {
>>> -			opp-hz = /bits/ 64 <267000000>;
>>> +			opp-hz = /bits/ 64 <266000000>;
>>>   		};
>>>   	};
>>>   
>>>   	bus_jpeg_opp_table: opp_table11 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 600MHz DPLL */
>>>   		opp00 {
>>>   			opp-hz = /bits/ 64 <75000000>;
>>>   		};
>>> @@ -205,23 +215,25 @@
>>>   	bus_jpeg_apb_opp_table: opp_table12 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 666MHz CPLL */
>>>   		opp00 {
>>> -			opp-hz = /bits/ 64 <84000000>;
>>> +			opp-hz = /bits/ 64 <83250000>;
>>>   		};
>>>   		opp01 {
>>>   			opp-hz = /bits/ 64 <111000000>;
>>>   		};
>>>   		opp02 {
>>> -			opp-hz = /bits/ 64 <134000000>;
>>> +			opp-hz = /bits/ 64 <133000000>;
>>>   		};
>>>   		opp03 {
>>> -			opp-hz = /bits/ 64 <167000000>;
>>> +			opp-hz = /bits/ 64 <166500000>;
>>>   		};
>>>   	};
>>>   
>>>   	bus_disp1_fimd_opp_table: opp_table13 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 600MHz DPLL */
>>>   		opp00 {
>>>   			opp-hz = /bits/ 64 <120000000>;
>>>   		};
>>> @@ -233,6 +245,7 @@
>>>   	bus_disp1_opp_table: opp_table14 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 600MHz DPLL */
>>>   		opp00 {
>>>   			opp-hz = /bits/ 64 <120000000>;
>>>   		};
>>> @@ -247,6 +260,7 @@
>>>   	bus_gscl_opp_table: opp_table15 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 600MHz DPLL */
>>>   		opp00 {
>>>   			opp-hz = /bits/ 64 <150000000>;
>>>   		};
>>> @@ -261,6 +275,7 @@
>>>   	bus_mscl_opp_table: opp_table16 {
>>>   		compatible = "operating-points-v2";
>>>   
>>> +		/* derived from 666MHz CPLL */
>>>   		opp00 {
>>>   			opp-hz = /bits/ 64 <84000000>;
>>>   		};
>>> @@ -274,7 +289,7 @@
>>>   			opp-hz = /bits/ 64 <333000000>;
>>>   		};
>>>   		opp04 {
>>> -			opp-hz = /bits/ 64 <400000000>;
>>> +			opp-hz = /bits/ 64 <666000000>;
>>>   		};
>>>   	};
>>>   
>>> @@ -398,7 +413,7 @@
>>>   };
>>>   
>>>   &bus_fsys {
>>> -	operating-points-v2 = <&bus_fsys_apb_opp_table>;
>>> +	operating-points-v2 = <&bus_fsys2_opp_table>;
>>
>> Need to remove 'opp-shared' property in bus_fsys_apb_opp_table.
>> And need to add 'opp-shared' property to bus_fsys2_opp_table.
> 
> I've checked the dt bindings and I think that opp-shared property has to 
> be removed at all. Clocks between fsys and fsys2 buses are not related 
> and regulator is currently already handled by in a different way by the 
> passive governor.

You're right. I realized 'opp-shared' is not necessary
by reading Documentation/devicetree/bindings/opp/opp.txt. Thanks.

> 
>>>   	devfreq = <&bus_wcore>;
>>>   	status = "okay";
>>>   };
>>>
>> If you fix the things related to 'opp-shared', Looks good to me.
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> Best regards
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
