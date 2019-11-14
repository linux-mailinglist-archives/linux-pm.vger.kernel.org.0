Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79DFBD42
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 02:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKNBBl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 20:01:41 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36687 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNBBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 20:01:41 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191114010138epoutp03323c274b46562f5f8c264b3e65c2c604~W4beitTaM1177711777epoutp03N
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 01:01:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191114010138epoutp03323c274b46562f5f8c264b3e65c2c604~W4beitTaM1177711777epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573693298;
        bh=+MOp+XNhPhATM4wUAWXX64y1DZVUK+kAsl5shRYV7lE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s+5YVkh3anKOWBrtzxqI850/jmmfe1MVfAVFYceDAFFPiUxMVPT9n0YVd8pZu6XtI
         163v7X7Iler46om4LADPfkgTJaBHNKutPR6maOw9ljSrCRBFL1SxXMlyOwwtUg7M15
         MJjrpCKnnMoxOVlWlWBI08Ut4zhoVQkVJ4zi/86s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191114010137epcas1p3320db99c8bf041495be34680d3942ca2~W4bd6O_ld2933229332epcas1p3M;
        Thu, 14 Nov 2019 01:01:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47D38Z6JD8zMqYkx; Thu, 14 Nov
        2019 01:01:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.29.04224.E67ACCD5; Thu, 14 Nov 2019 10:01:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191114010134epcas1p46723fae863169ec546225f2c70904198~W4badc8Td2865228652epcas1p4M;
        Thu, 14 Nov 2019 01:01:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191114010134epsmtrp13fa88e42b4b5dd8ea3ff7af8fd3ba479~W4bacToNB0961709617epsmtrp1Z;
        Thu, 14 Nov 2019 01:01:34 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-9e-5dcca76e8d9c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.4C.24756.E67ACCD5; Thu, 14 Nov 2019 10:01:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191114010133epsmtip1eaaddbcc3a42ade9b3096d9e63186797~W4baAJSxk2066820668epsmtip1S;
        Thu, 14 Nov 2019 01:01:33 +0000 (GMT)
Subject: Re: [PATCH v5 3/5] dt-bindings: memory: Add bindings for imx8m ddr
 controller
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <dcdf04b4-7caf-668b-7979-70f5174d5f9b@samsung.com>
Date:   Thu, 14 Nov 2019 10:07:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB702328B4F8744FBF42E0D537EE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxj29H70llC9qzLOmkzLNSaOCLQCctzESWTLXWYYZFnCljC8oTct
        obRNb0vG9kNcZpUGh2QhjDoEx4CKLJECExkFqQViwSoozAmOLSXOLVsJXwtzYNYvk/57zvM+
        z5v3eU9eCpMNieVUqd7Mm/ScjiHj8B9uvZaWou+YLFJ2WNORe6xPjNYnvAC1T48CtFY/gCH/
        whxA1xtLULPHR6DunjkcNbicJOqsv4Gju3evidGdz/8SI8fjZQI5/bMEWq75hUC2Z1cwtHre
        A1DbT1MiNOuoI9DqNT9AU9630NxpB4mu+kZINDkxTaAzLo8Y2dxbJHo+242jp72JqHudPfYq
        W29zALbrUhdglx6eEbMXq6ZwtsVpYZ2d1SQ7PztIsj3fnWK7A/0idiQwKGJrt5Tss1sJbO/M
        WZz9srcTsKvO3fk7Pio7ouU5NW9S8PoSg7pUr8lm3n2/+Hhx5iGlKkV1GGUxCj1XzmczuSfy
        U94u1QXXwygqOJ0lSOVzgsCkHT1iMljMvEJrEMzZDG9U64yHjakCVy5Y9JrUEkP56yql8mBm
        UHiyTPtFZztpfK745PLyRbIK3JPbgISCdAacq7lJ2EAcJaP7AdzsWCBCBRm9AuBY+4FI4R8A
        qxz/il84xs+PRh0uABu6+qOPJQD7Bn8kQ6qddCG8vDEebrWLLoDfjraSIRFGOyTQ17ECQgWS
        TobDTx+GDTvoJDiz4Q/yFCWlj0JXQ1KIxul98JF1mAjRCcGeE+tciJbSL8HbjYt4CEvoIlh/
        fyvcEaNT4ROvHY/gRPhosVkUwXvg9b+/wUIjQNpDwTV3NRFJkwu9p6uxCN4J/xzvjaaUwz9q
        rVH8Gbxy20NGzOcA7B2+FzWnw+G2r0QRnARv/NcUnWI7DKzXhIeGtBSes8oikr3w/q+Po/JX
        YOvZavICYOwxeewxGewxGewxGVoA3gle5o1CuYYXVMaM2O92gvDtJKN+MOg74QY0BZh46c2E
        ySIZwVUIleVuACmM2SXdrw9SUjVX+SlvMhSbLDpecIPM4LrrMHlCiSF4iXpzsSrzYHp6OspQ
        HcpUqZhEaU5HW5GM1nBmvoznjbzphU9ESeRVIGs+bqvwatzPxxyagW21rvgP5isIg9ESnzVd
        uUClNRoC0y3bYcEbleqmJf/GhQEhd2Dfg27Nyd9av3+PGcqb9dV97erRntr8sO7Nghzikr+0
        acRauGKQ5W0+8PbtP/Dxk98lU2l3PHk5Q8fj90ytDr2zl9vGrM2MBRYLm9t3q9lWBhe0nCoZ
        Mwnc/4KSC/BRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xSUQDHd7gPLizmDXWcbFnQ29J09eHYyvGldT9Wa6U1Zze7oSXEuNpr
        rbSVFbOUDWKhZW5KSGaBlj10Fb4qTUOHkdpr2LLUGmnlSlsCtfHl7Lf///x/58uhMKmViKGy
        NbmcTsPmKEgxfqdZERuvudaZnjh6W4hcbTPH945nAFl7WgGaMN3HkO/tAEANlzJReUsXgRx1
        AzgyNzlJZDfdw1F39y0hen5yVIhsr/0Ecvr6COQvekMg/a9qDI2fbwGo6qVbgPpsBgKN3/IB
        5H62AQ0U2Eh0vesxiTo7egh0uqlFiPSuaRL96XPgaLhehhzfGeU8xqS3AabmSg1gvnpPC5nS
        fDfOXHXmMU77OZIZ7GskmbrKE4zjy10B8/hLo4Apnk5kfjVHM/WeMzhzod4OmHFn7KaIHeJ1
        e7ic7IOcblXKLnHWKbuV1P5ZcLjCX0rmgxcxeiCiIL0Gtp9vJfRATEnpBwD6u34SoWIOvOhu
        xfSAmuFI2NzMB2IpPQbgoEEX4Eg6FVZMtgevR9GbYa2nGg8wRteI4PsnqSHnZwEsnvxBBgqS
        joMPh71BjqDl0DPpAwG/hE6BTWZ5IMbpxbC/8GHQGT3j/9jgBQGW0LPh00tDQb+IToem3mkQ
        emslLByvEIRYBvuHyv/xfNgwVoaVgEhL2NwSNrGETSxhk6sAt4M5nJZXq9R8kjZJwx1K4Fk1
        n6dRJWQeUDtB8PfELb8LeiszXICmgGKW5FF0Z7qUYA/yR9QuAClMESVZppmJJHvYI0c53YEM
        XV4Ox7vAXApXyCQfNG1pUlrF5nL7OU7L6f63AkoUkw/2ZR0XGTN71i50130qmsIGsr+RjhyP
        pPrDi1jbyd3bDDcLrKvNrP6rbGyjPNFzbHsm66tdMWXwuoRp4uSREutSfEnVjbNHL5JVWrlx
        ZDlt3OqPV5YNkcZZWcqdU7UqyzuX+PJvwhaR/OrNMfkWFT7xtDDix3rzXi87b1GKX6nA+Sw2
        KQ7T8exfDMQRDzkDAAA=
X-CMS-MailID: 20191114010134epcas1p46723fae863169ec546225f2c70904198
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191112215123epcas5p13e9eec7f2209a73bb1a6f09434ec91ba
References: <cover.1573595318.git.leonard.crestez@nxp.com>
        <CGME20191112215123epcas5p13e9eec7f2209a73bb1a6f09434ec91ba@epcas5p1.samsung.com>
        <872fb6e3117955b679678280483f82b3d73dd376.1573595319.git.leonard.crestez@nxp.com>
        <296a7e8a-78e5-62bb-e4e1-8f5a9095cb6d@samsung.com>
        <VI1PR04MB702328B4F8744FBF42E0D537EE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/13/19 9:35 PM, Leonard Crestez wrote:
> On 13.11.2019 04:32, Chanwoo Choi wrote:
>> On 11/13/19 6:50 AM, Leonard Crestez wrote:
>>> Add devicetree bindings for the i.MX DDR Controller on imx8m series
>>> chips. It supports dynamic frequency switching between multiple data
>>> rates and this is exposed to Linux via the devfreq subsystem.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>   .../memory-controllers/fsl/imx8m-ddrc.yaml    | 57 +++++++++++++++++++
>>>   1 file changed, 57 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
>>> new file mode 100644
>>> index 000000000000..7c98e3509f75
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml
>>> @@ -0,0 +1,57 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fmemory-controllers%2Ffsl%2Fimx8m-ddrc.yaml%23&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C23e819d42b664965975808d767e1c084%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637092091602846215&amp;sdata=frWd1MENZm%2FsPjQp%2FWbphMgkkCMtwsgV8hLQyIhC3%2BI%3D&amp;reserved=0
>>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C23e819d42b664965975808d767e1c084%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637092091602846215&amp;sdata=4IweKQJO9ZsB%2B9QxixSQjfYOFm3%2FY7iMHFBSsquK1B0%3D&amp;reserved=0
>>> +
>>> +title: i.MX8M DDR Controller
>>> +
>>> +maintainers:
>>> +  - Leonard Crestez <leonard.crestez@nxp.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +        - fsl,imx8mn-ddrc
>>> +        - fsl,imx8mm-ddrc
>>> +        - fsl,imx8mq-ddrc
>>> +      - const: fsl,imx8m-ddrc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 4
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: core
>>> +      - const: pll
>>> +      - const: alt
>>> +      - const: apb
>>> +
>>> +  operating-points-v2: true
>>> +  opp-table: true
>>> +
>>> +required:
>>> +  - reg
>>> +  - compatible
>>> +  - clocks
>>> +  - clock-names
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/imx8mm-clock.h>
>>> +    ddrc: memory-controller@3d400000 {
>>> +        compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
>>> +        reg = <0x3d400000 0x400000>;
>>
>> The probe() function doesn't get the IORESOURCE_MEM from dt?
>> Is it needed?
> 
> This area is not currently mapped by the driver. As far as I understand 
> it's acceptable to "describe hardware" even if you don't use the full 
> description in driver code.
> 
> If I were to remove the "reg" area wouldn't I also have to move the node 
> outside of the bus to keep DT validation? It's better to keep the address.

The dt bidning documentation and device driver have not any explanation
about this. It makes the confusion to user who don't know the history.
I'd like you to add the explanation on dt bidning documentation
in order to remove the confusion.

Actually, you get the confirm from DT maintainer. I'm OK.

> 
> Maybe it will be mapped in the future or maybe firmware will start to 
> parse linux DT instead of hardcoding SOC-specific addresses (this 
> already happens in some cases).

OK. Do you implement them in the future? If you have a plan,
you better to do this on this time.

> 
>>> +        clock-names = "core", "pll", "alt", "apb";
>>> +        clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
>>> +                 <&clk IMX8MM_DRAM_PLL>,
>>> +                 <&clk IMX8MM_CLK_DRAM_ALT>,
>>> +                 <&clk IMX8MM_CLK_DRAM_APB>;
>>> +        operating-points-v2 = <&ddrc_opp_table>;
>>> +    };
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
