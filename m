Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD720121F3D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 01:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfLQAIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 19:08:49 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:52047 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfLQAIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 19:08:49 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191217000845epoutp04436397ac38929f2907ade3bca05f65f5~g--uCmgVg2745027450epoutp04H
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 00:08:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191217000845epoutp04436397ac38929f2907ade3bca05f65f5~g--uCmgVg2745027450epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576541325;
        bh=WQb59wUVb4ENykfc/VzmAmvV0Vm4LY77U8HXze17Kxc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CqbFAK7zkmpHC7x5YTDd8nxrarg0Qyg77GZGdyAvP5jv0kpRgOm2aDfT93dFQfNe+
         oQptIsE7s3FFVrDXJMS/FmcqXTBoPr8GWPsiEAYTYpzLlouZ1Xb480gEBFcb1k5RqL
         iDIH6FK4JiOIHF3oM32UoFUBL+K/hc9TX7LaOHKo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191217000844epcas1p40836f5eed0ad643180003037fdd17c49~g--tTNxvG2849428494epcas1p4W;
        Tue, 17 Dec 2019 00:08:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47cJQK1VQszMqYlx; Tue, 17 Dec
        2019 00:08:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.90.57028.98C18FD5; Tue, 17 Dec 2019 09:08:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191217000840epcas1p1ff31c37af0d920704b66477e90dd7661~g--pvkMOK1574215742epcas1p1q;
        Tue, 17 Dec 2019 00:08:40 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191217000840epsmtrp15cc4e0902d9b9916a12447df3834d4cc~g--puYxiK0451504515epsmtrp1i;
        Tue, 17 Dec 2019 00:08:40 +0000 (GMT)
X-AuditID: b6c32a35-4f3ff7000001dec4-95-5df81c894e92
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.01.06569.88C18FD5; Tue, 17 Dec 2019 09:08:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217000840epsmtip19b0aeb84ab5a60c2fb52348f76112323~g--pShe-A0399603996epsmtip1p;
        Tue, 17 Dec 2019 00:08:40 +0000 (GMT)
Subject: Re: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b8fc116f-d99f-37c6-ce07-aa0f844ac604@samsung.com>
Date:   Tue, 17 Dec 2019 09:15:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023A61DD48302CF0E0B3B81EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tb0xTVxzN7Xt9fRC7vVUZdx06fG5LbIb0iXUXY42Zur1FPpCZsDlH4AXe
        gNB/6WvJHB9kaB1tnIiuGur8yzAF2WgLURAZocAWmJTVZZ2T1W2pC0UcRiqDMZW1fZrx7dzz
        Oyfnnt/NJTHF1zIlWWGw8GYDp6OJVPzSwFp1lj1jvlA90pOKZr8fAejC9SGAHjivYCjy2zhA
        lxtL0JnBgBR5O8ZxdKLXR6BWZzeOxsY8MjRae1eG3OH7UuSLhKTIsdCCodhngwA1/xyUoJC7
        QYpinghAwZEdaPwTN4EuBvoJdOqBE0O23kEZcvgfEehxyIujaGc6am4KYcg7y27NYJ0ON2Db
        TrcB9t4Nm4w9WRPE2bM+K+trtRPsr6GrBNvx5T7WO90lYesfqdmFgTT2cGcrYGO+Vfny9ys3
        l/NcKW/O5A0lxtIKQ5mW3rmraFuRZqOayWJy0et0poHT81p6e15+1psVuvg+6MwqTmeNU/mc
        INDZWzabjVYLn1luFCxamjeV6ky5pnUCpxeshrJ1JUb9JkatXq+JC4sryydnrslMD7d9NGnz
        EDVgRuMAKSSkNsDrh27KHCCVVFBdALa038XFwwyA7SEbkVApqL8BHKoveOo4PuXHRb4XwMUA
        LRruAdj20CZLDJZT70Jnhx1L4BVUNTwyWitJiDDKTcI7+6OSxICgVLAveiOZ8Cy1Gv40HwEJ
        LKe2wHD4fJLHqVdg//3FpD6NKoDDlw480TwHhxtvJ2+RQhXChXAwGYZR6fDm7TMSEb8EL//1
        BZYIhlQLCQONE4RYYTucCvZgIl4O73zXKROxEk7WH3yCq2HL8CAhmusA7Oz7QSoOcmBf87F4
        AhlPWAvbr2SL9GrY/e8pIAY/A6dnD0kTEkjJYd1BhShZA3/8PSwR8Quw6VM7cQTQriV1XEsq
        uJZUcP0fdhbgreB53iToy3iBMTFLX9sHkn9FpekCnwfy/IAiAb1MbqqaK1RIuSphr94PIInR
        K+RdmXFKXsrt/Zg3G4vMVh0v+IEmvu0GTJlWYoz/PIOliNGsz8nJQRuYjRqGodPl5HywUEGV
        cRa+kudNvPmpT0KmKGvA280H8lIbF5ZdbZvbeXHPy39EraruqUXlLbz4m+rIi7sHhmPZxU1T
        09zudv1r2ncM+ytujRXsyw3MejQpE98eP9effTJj67isNlz/1RtvMT1/Dj329Eb/6Tm86txR
        bd17H9h1o7FfNhVfI3bt0dTNNe1wTDS4Vko+XHn66IVXj0mRatpL40I5x6gws8D9B8x1jSJB
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXfOzo7S6DQVX000B1kMM7ULb6VWiHAwAr90BbWlxws6lR3n
        paDMEHKgFTKHVk5MZU6Rbd6maeHUMk1lQlPSJTEtJS28kZmz3Gbgtx/P8/z4f/mTmKCC602m
        ZmQz0gxxupBwxdv7hL7HHvlsxAZXbPii9eEhgOrHBwBaU3RhyDozBVBHRQJS9Y9yka5lCkfK
        Hj2BNIpOHI2NaXlopHCRh9SWZS7SW81cJN9swNBqST9AdRMmDjKrn3LRqtYKkGkoCk09UBOo
        cbSXQC/WFBgq6unnIbnRRqBtsw5H862eqO6lGUO6dfqCD62QqwHdVNUE6J+TRTz6WYEJp6v1
        MlqvKSboaXM3QbfU3qd1Pwwc+rEtmN7s86BLWzWAXtX7xvBvuoYlMumpOYz0eMQt15SFlQ+8
        rK3IvIUiLVEAVk7JgQsJqZOw/LsRlwNXUkC9AnDl2zLmLLxguWlgh8kddoN9faxzswTgQqse
        t2/cqGtQ0VLs2LtTd+HW13cOxqhmEv5eT3EKKgyul7Zx7QVBieCb+UnCzvspf/hxwwrszKci
        oMVS48hx6jDsXf7LsbMHdRV21lo5zs0B+L5i1nHYhYqFmxbT7rEjcKtqfJc94adZFcfJfrBj
        6Tn2BLhV7tEr9yiVe5TKPUo1wDXAi8liJckSNiQrNIPJDWLFElaWkRyUkCnRA8fDiEQGMDgY
        bwQUCYT7+DD7V6yAK85h8yVGAElM6M43HNqJ+Ini/DuMNDNeKktnWCM4SOJCT75f5tsbAipZ
        nM2kMUwWI/3fckgX7wLgnRdeljd5ObGscfb6lbbhSZ5axIbPdylDecFBa0fP6fTT7eq5s+oJ
        oTb/Uk3DXJoyOsrlzOmCL90Gw/nC3CTASYqTKCXRcScWk5iAz3nE0OuAwIES2+38i6qpkYeB
        ym2OzOY1I6qPbC5J8xd3B1eFMDEyC+i990e+GGbkdgtxNkUcIsKkrPgfm5cT1CwDAAA=
X-CMS-MailID: 20191217000840epcas1p1ff31c37af0d920704b66477e90dd7661
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d
References: <cover.1573761527.git.leonard.crestez@nxp.com>
        <CGME20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d@epcas5p2.samsung.com>
        <6db2ce55ee62dd8548aa8e1e0ecdf8c06eda868f.1573761527.git.leonard.crestez@nxp.com>
        <c1c03b30-d82a-6f2b-156d-0e1948e0df5b@samsung.com>
        <afd618d6-d78c-a989-2d1e-60c368ec267f@samsung.com>
        <VI1PR04MB7023A61DD48302CF0E0B3B81EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/17/19 12:09 AM, Leonard Crestez wrote:
> On 16.12.2019 05:18, Chanwoo Choi wrote:
>> Hi,
>>
>> On 12/16/19 10:12 AM, Chanwoo Choi wrote:
>>> On 11/15/19 5:09 AM, Leonard Crestez wrote:
>>>> Add initial dt bindings for the interconnects inside i.MX chips.
>>>> Multiple external IPs are involved but SOC integration means the
>>>> software controllable interfaces are very similar.
>>>>
>>>> Main NOC node acts as interconnect provider if #interconnect-cells is
>>>> present.
>>>>
>>>> Multiple interconnects can be present, each with their own OPP table.
>>>>
>>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>>> ---
>>>>   .../bindings/interconnect/fsl,imx8m-noc.yaml  | 104 ++++++++++++++++++
>>>>   1 file changed, 104 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
>>>> new file mode 100644
>>>> index 000000000000..5cd94185fec3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
>>>> @@ -0,0 +1,104 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: https://protect2.fireeye.com/url?k=8570eb5a-d8a45732-85716015-0cc47a3356b2-92a5b92cc514d07e&u=https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fprotect2.fireeye.com%2Furl%3Fk%3D0c13f3e0-51df3f45-0c1278af-0cc47a30d446-77e809543b673ffd%26u%3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Finterconnect%2Ffsl%2Cimx8m-noc.yaml%23&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C2d1f1868afa140702a6b08d781d6ab68%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637120631307418544&amp;sdata=H2q5nQlKYyLIivkBYUTaRD1Nu3WcnphPJny3k%2BK%2BGFE%3D&amp;reserved=0
>>>> +$schema: https://protect2.fireeye.com/url?k=f7cec483-aa1a78eb-f7cf4fcc-0cc47a3356b2-4154a3c43886f5ed&u=https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fprotect2.fireeye.com%2Furl%3Fk%3D87c672dc-da0abe79-87c7f993-0cc47a30d446-414d3b4d0127419a%26u%3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C2d1f1868afa140702a6b08d781d6ab68%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637120631307418544&amp;sdata=T6PgQ1DWI4OLOx3gifRRt%2FNImdVrgDUoswZ%2FNKw3oR8%3D&amp;reserved=0
>>>> +
>>>> +title: Generic i.MX bus frequency device
>>>> +
>>>> +maintainers:
>>>> +  - Leonard Crestez <leonard.crestez@nxp.com>
>>>> +
>>>> +description: |
>>>> +  The i.MX SoC family has multiple buses for which clock frequency (and
>>>> +  sometimes voltage) can be adjusted.
>>>> +
>>>> +  Some of those buses expose register areas mentioned in the memory maps as GPV
>>>> +  ("Global Programmers View") but not all. Access to this area might be denied
>>>> +  for normal (non-secure) world.
>>>> +
>>>> +  The buses are based on externally licensed IPs such as ARM NIC-301 and
>>>> +  Arteris FlexNOC but DT bindings are specific to the integration of these bus
>>>> +  interconnect IPs into imx SOCs.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - items:
>>>> +        - enum:
>>>> +          - fsl,imx8mn-nic
>>>> +          - fsl,imx8mm-nic
>>>> +          - fsl,imx8mq-nic
>>>> +        - const: fsl,imx8m-nic
>>>> +      - items:
>>>> +        - enum:
>>>> +          - fsl,imx8mn-noc
>>>> +          - fsl,imx8mm-noc
>>>> +          - fsl,imx8mq-noc
>>>> +        - const: fsl,imx8m-noc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  operating-points-v2: true
>>>> +  opp-table: true
>>>> +
>>>> +  devfreq:
>>>> +    $ref: "/schemas/types.yaml#/definitions/phandle"
>>>> +    description:
>>>> +      Phandle to another devfreq device to match OPPs with by using the
>>>
>>> Better to use 'parent' instead of 'another' word for improving the understanding.
>>
>> I think that 'devfreq' is not proper way to get the parent node
>> in devicetree. Because 'devfreq' name is linuxium. The property name
>> didn't indicate the any h/w device. So, I'll make 'devfreq' property deprecated.
>>
>> So, you better to make the specific property for this device driver
>> like as following: and use devfreq_get_devfreq_by_node() function
>> which is developed by you in order to get the devfreq instance node.
>>
>> 	fsl,parent-device = <&parent devfreq device>;
> 
> This is only a "parent" in the sense that it's assigned to 
> devfreq_passive.data.parent. The "devfreq" name is indeed too generic.

I thought that 'devfreq' property name is generic.
But, it's not proper for DT binding because DT file show
the h/w and the relation of h/w. 'devfreq' property name
has not meant h/w.

So that devfreq core doesn't force to use the specific property
name to get the devfreq parent instance on DT. Just, devfreq core
will provide devfreq_get_devfreq_by_node() function.

I developed it on devfre-testing branch[2]. Before I'm sending
the these patches, you can check them.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=f3678b4e6b75dccfe8bb87d005da2d68c70fdeab
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing

> 
> The DDRC can measure bandwith usage and I want to use the passive 
> governor to make the main NOC match OPPs.

which one use the passive governor? And which one is the parent 
devfreq device for devfreq device using passive governor?

In my case, it is difficult to catch the relationship
between devices. I'd like you to explain the detailed relationship
on binding document for user.

> But at the bus level DDRC only has AXI and APB slave ports.

'DDRC' indicates the 'drivers/devfreq/imx8m-ddrc.c?

> 
> Buses on imx don't have a parent/child relationship; in fact there are 
> even a few cycles.

You mentioned that 'imx don't have a parent/child relationship',
Why do you use 'passive' governor? It is difficult to understand
the hierarchy of imx.

> 
>>
>> [1] [PATCH RFC v5 04/10] PM / devfreq: Add devfreq_get_devfreq_by_node
>>
>>>
>>>> +      passive governor.
>>>> +
>>>> +  '#interconnect-cells':
>>>> +    description:
>>>> +      If specified then also act as an interconnect provider. Should only be
>>>> +      set once per soc on main noc.
>>>> +    const: 1
>>>> +
>>>> +  fsl,scalable-node-ids:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    description:
>>>> +      Array of node ids for scalable nodes. Uses same numeric identifier
>>>> +      namespace as the consumer "interconnects" binding.
>>>> +
>>>> +  fsl,scalable-nodes:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description:
>>>> +      Array of phandles to scalable nodes. Must be of same length as
>>>> +      fsl,scalable-node-ids.
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - clocks
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>
>>> Is it enough example to understand the relation between
>>> imx8m-ddrc.c, imx-devfreq.c and imx interconnect driver?
>>>
>>> In my case, if possible, hope to show the more detailed
>>> example. This example seems that don't contain the ddrc
>>> dt node (imx8m-ddrc.c).
> 
> OK, I'll elaborate explanation on noc binding.

Thanks. If possible, you better to add almost example cases.

> 
>>>
>>>> +    #include <dt-bindings/clock/imx8mq-clock.h>
>>>> +    #include <dt-bindings/interconnect/imx8mq.h>
>>>> +    noc: interconnect@32700000 {
>>>> +            compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
>>>> +            reg = <0x32700000 0x100000>;
>>>> +            clocks = <&clk IMX8MQ_CLK_NOC>;
>>>> +            #interconnect-cells = <1>;
>>>> +            fsl,scalable-node-ids = <IMX8MQ_ICN_NOC>,
>>>> +                                    <IMX8MQ_ICS_DRAM>;
>>>> +            fsl,scalable-nodes = <&noc>,
>>>> +                                 <&ddrc>;
>>>> +            operating-points-v2 = <&noc_opp_table>;
>>>> +
>>>> +            noc_opp_table: opp-table {
>>>> +                    compatible = "operating-points-v2";
>>>> +
>>>> +                    opp-133M {
>>>> +                            opp-hz = /bits/ 64 <133333333>;
>>>> +                    };
>>>> +                    opp-800M {
>>>> +                            opp-hz = /bits/ 64 <800000000>;
>>>> +                    };
>>>> +            };
>>>> +    };
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
