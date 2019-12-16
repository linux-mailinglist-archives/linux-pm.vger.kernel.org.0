Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC16120951
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 16:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfLPPJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 10:09:55 -0500
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:40870
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbfLPPJz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Dec 2019 10:09:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1qpe112iG0KYV+JtdEV66lNgUGaDMWqBQ8I3Fr4BXb3YJeSIMYVGIYkrlXh5VLg7EoWJE+JAi9t7FhdPnJK3uMW1Rbo3YKa7kPBdVRJOXEjYG1VXwRgmn0IhKIa/rxGq6UYMKanT3YFsLSB/Hqm+QBivvCbAUcZwK5tNVWr7ljA3J1yOAIX1cjVxeVxxt720PDXBZ9zgEaJ89AVTW6dQfKuLxRgJ3f4Qr8BNRkqR2VojvEpDD5mPC6xaXb1nico1Rf+FS3ORUocfSNX4Q4RdKQ48NPd3Xzp4NrD2Hj9J3XEisnQgT0Uos7oAcTIhA5uV+FjJ2mvn+NzgNcPfnmCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHt18L0MfLv/x5OEWWvgLf3TZk0dXRy3dbsYLxUdt+M=;
 b=jqkueMDRFoukJEo6yB0UYYGHBmdc15hubRBUmtz2qslQ6LOI2IQYD0nUxsjri2em1A7d1Zmuv+yhDXEkux0WArpwUCcCkRhwLMBpb/uq5jpylHUh83oss8QJqLat+o7SWlpeMiL++ceg+/mOM/OdUW2nxbKC/jstbM519PgM0z1FS7a6ZgtbfG4Yuxtvf9KbgOR5Cgrq9dDhq9KSMcMV+Fw3gJrr8Vi3Q6Xae+iob2VoJUChMSwp3aEOBiMiBjxb6oRF+NB/fVmqsqrP5h/7xjvNt53wsKm1osDtaLc97A4WuU8b488okJyeAGi5WCbQe084pDwqC3Rp9C+BwR+ySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHt18L0MfLv/x5OEWWvgLf3TZk0dXRy3dbsYLxUdt+M=;
 b=I5zjZunFNQ1IGFJVOPDtI+kZzt241H6Lk5L7u8V1wZw4JJEJuk3x3MT8ddJV3XL2HPXxCqh+avCtjY8Nqr5kh+T9UhC48qRvoFkYXjg/wMvOe2K57+ckeyuCkBlXYdAHXK+PRP89fXXPBtuF9Dv+hgwN9XNG9Gjp1XrE+sDuVPU=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4560.eurprd04.prod.outlook.com (20.177.55.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Mon, 16 Dec 2019 15:09:47 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 15:09:47 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Alexandre Bailon <abailon@baylibre.com>,
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
Subject: Re: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
Thread-Topic: [PATCH RFC v6 1/9] dt-bindings: interconnect: Add bindings for
 imx8m noc
Thread-Index: AQHVmyeXQvJfRqjmjUWtYoVDBCNHfg==
Date:   Mon, 16 Dec 2019 15:09:47 +0000
Message-ID: <VI1PR04MB7023A61DD48302CF0E0B3B81EE510@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <CGME20191114201051epcas5p2a6b58f0d86fb8bed72a206ecd5df295d@epcas5p2.samsung.com>
 <6db2ce55ee62dd8548aa8e1e0ecdf8c06eda868f.1573761527.git.leonard.crestez@nxp.com>
 <c1c03b30-d82a-6f2b-156d-0e1948e0df5b@samsung.com>
 <afd618d6-d78c-a989-2d1e-60c368ec267f@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ba88407-b895-42ae-3fb8-08d78239fd6b
x-ms-traffictypediagnostic: VI1PR04MB4560:|VI1PR04MB4560:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4560B8068CCAFAEEE1C8ECCDEE510@VI1PR04MB4560.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(51444003)(199004)(189003)(186003)(7696005)(66476007)(66556008)(66946007)(64756008)(66446008)(91956017)(5660300002)(53546011)(6506007)(81166006)(45080400002)(71200400001)(316002)(8936002)(54906003)(110136005)(478600001)(52536014)(8676002)(33656002)(966005)(55016002)(44832011)(2906002)(26005)(7416002)(76116006)(9686003)(81156014)(86362001)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4560;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pHMj8VUMFKb4+fU0jA92g2dvWQkR8QTvf9WSeq/4hrG+xSvuexw8wQXC3rQ9Gsz0TlrElOBlxM03xEQxDs8ZP7gm3mqfZCt/Ud/mgAhWq3duz07yfFujCTuA5PYW9vfhV5i47e+qqRLIN1kFITvEF4dfoyzOWNi/5ZLOqJ/U63SNENNPNyHx2GoLon3Xj04h6nGLOimUqzEjWmzdGaIIHZRCeCxCR1AE8qlJ2BQ9buhcWsd2c1GdG2A+ng/68Ddu44r+BMdhKRzGmnp7CRMTbhTSlcDIS988raRPveRvqUhSyDcP3kUgznC9mnI3Xi2aXc6oWIDVoCBFWqQBcGl6cTaetjlXXhQofQbmpBGA2ksCY+MqWBwevNbTrx7WocF7QsZrYfdwdry7JV6OCgf7ZCVMDHnRP+nndPQbdkA3kcvxidZ46sGlAauexSViTRkuNKbE4xBHUK3RILNU/+TeIUSndz9TMeJ8kVqa8WD8ABbiJOmKYjJ3LAxwKVZTwXDU+hsWMKMp34/tpipZc0BR04lLxH8bASjJwcrCk7GZmk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba88407-b895-42ae-3fb8-08d78239fd6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 15:09:47.0295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjxH6YErQUkzLGMo4V66ec9ciX/nfL1fA2CW01hDBT7JF+SUbn/ckZo0N0QJMd6v5dPJL4Kza9QSY1G22V1mWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4560
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16.12.2019 05:18, Chanwoo Choi wrote:=0A=
> Hi,=0A=
> =0A=
> On 12/16/19 10:12 AM, Chanwoo Choi wrote:=0A=
>> On 11/15/19 5:09 AM, Leonard Crestez wrote:=0A=
>>> Add initial dt bindings for the interconnects inside i.MX chips.=0A=
>>> Multiple external IPs are involved but SOC integration means the=0A=
>>> software controllable interfaces are very similar.=0A=
>>>=0A=
>>> Main NOC node acts as interconnect provider if #interconnect-cells is=
=0A=
>>> present.=0A=
>>>=0A=
>>> Multiple interconnects can be present, each with their own OPP table.=
=0A=
>>>=0A=
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>> ---=0A=
>>>   .../bindings/interconnect/fsl,imx8m-noc.yaml  | 104 +++++++++++++++++=
+=0A=
>>>   1 file changed, 104 insertions(+)=0A=
>>>   create mode 100644 Documentation/devicetree/bindings/interconnect/fsl=
,imx8m-noc.yaml=0A=
>>>=0A=
>>> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-n=
oc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml=
=0A=
>>> new file mode 100644=0A=
>>> index 000000000000..5cd94185fec3=0A=
>>> --- /dev/null=0A=
>>> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml=
=0A=
>>> @@ -0,0 +1,104 @@=0A=
>>> +# SPDX-License-Identifier: GPL-2.0=0A=
>>> +%YAML 1.2=0A=
>>> +---=0A=
>>> +$id: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fprotect2.fireeye.com%2Furl%3Fk%3D0c13f3e0-51df3f45-0c1278af-0cc47a30d446=
-77e809543b673ffd%26u%3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Finterconnec=
t%2Ffsl%2Cimx8m-noc.yaml%23&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%=
7C2d1f1868afa140702a6b08d781d6ab68%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7=
C0%7C637120631307418544&amp;sdata=3DH2q5nQlKYyLIivkBYUTaRD1Nu3WcnphPJny3k%2=
BK%2BGFE%3D&amp;reserved=3D0=0A=
>>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fprotect2.fireeye.com%2Furl%3Fk%3D87c672dc-da0abe79-87c7f993-0cc47a30=
d446-414d3b4d0127419a%26u%3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fco=
re.yaml%23&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C2d1f1868afa1407=
02a6b08d781d6ab68%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637120631307=
418544&amp;sdata=3DT6PgQ1DWI4OLOx3gifRRt%2FNImdVrgDUoswZ%2FNKw3oR8%3D&amp;r=
eserved=3D0=0A=
>>> +=0A=
>>> +title: Generic i.MX bus frequency device=0A=
>>> +=0A=
>>> +maintainers:=0A=
>>> +  - Leonard Crestez <leonard.crestez@nxp.com>=0A=
>>> +=0A=
>>> +description: |=0A=
>>> +  The i.MX SoC family has multiple buses for which clock frequency (an=
d=0A=
>>> +  sometimes voltage) can be adjusted.=0A=
>>> +=0A=
>>> +  Some of those buses expose register areas mentioned in the memory ma=
ps as GPV=0A=
>>> +  ("Global Programmers View") but not all. Access to this area might b=
e denied=0A=
>>> +  for normal (non-secure) world.=0A=
>>> +=0A=
>>> +  The buses are based on externally licensed IPs such as ARM NIC-301 a=
nd=0A=
>>> +  Arteris FlexNOC but DT bindings are specific to the integration of t=
hese bus=0A=
>>> +  interconnect IPs into imx SOCs.=0A=
>>> +=0A=
>>> +properties:=0A=
>>> +  compatible:=0A=
>>> +    oneOf:=0A=
>>> +      - items:=0A=
>>> +        - enum:=0A=
>>> +          - fsl,imx8mn-nic=0A=
>>> +          - fsl,imx8mm-nic=0A=
>>> +          - fsl,imx8mq-nic=0A=
>>> +        - const: fsl,imx8m-nic=0A=
>>> +      - items:=0A=
>>> +        - enum:=0A=
>>> +          - fsl,imx8mn-noc=0A=
>>> +          - fsl,imx8mm-noc=0A=
>>> +          - fsl,imx8mq-noc=0A=
>>> +        - const: fsl,imx8m-noc=0A=
>>> +=0A=
>>> +  reg:=0A=
>>> +    maxItems: 1=0A=
>>> +=0A=
>>> +  clocks:=0A=
>>> +    maxItems: 1=0A=
>>> +=0A=
>>> +  operating-points-v2: true=0A=
>>> +  opp-table: true=0A=
>>> +=0A=
>>> +  devfreq:=0A=
>>> +    $ref: "/schemas/types.yaml#/definitions/phandle"=0A=
>>> +    description:=0A=
>>> +      Phandle to another devfreq device to match OPPs with by using th=
e=0A=
>>=0A=
>> Better to use 'parent' instead of 'another' word for improving the under=
standing.=0A=
> =0A=
> I think that 'devfreq' is not proper way to get the parent node=0A=
> in devicetree. Because 'devfreq' name is linuxium. The property name=0A=
> didn't indicate the any h/w device. So, I'll make 'devfreq' property depr=
ecated.=0A=
> =0A=
> So, you better to make the specific property for this device driver=0A=
> like as following: and use devfreq_get_devfreq_by_node() function=0A=
> which is developed by you in order to get the devfreq instance node.=0A=
> =0A=
> 	fsl,parent-device =3D <&parent devfreq device>;=0A=
=0A=
This is only a "parent" in the sense that it's assigned to =0A=
devfreq_passive.data.parent. The "devfreq" name is indeed too generic.=0A=
=0A=
The DDRC can measure bandwith usage and I want to use the passive =0A=
governor to make the main NOC match OPPs. But at the bus level DDRC only =
=0A=
has AXI and APB slave ports.=0A=
=0A=
Buses on imx don't have a parent/child relationship; in fact there are =0A=
even a few cycles.=0A=
=0A=
> =0A=
> [1] [PATCH RFC v5 04/10] PM / devfreq: Add devfreq_get_devfreq_by_node=0A=
> =0A=
>>=0A=
>>> +      passive governor.=0A=
>>> +=0A=
>>> +  '#interconnect-cells':=0A=
>>> +    description:=0A=
>>> +      If specified then also act as an interconnect provider. Should o=
nly be=0A=
>>> +      set once per soc on main noc.=0A=
>>> +    const: 1=0A=
>>> +=0A=
>>> +  fsl,scalable-node-ids:=0A=
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array=0A=
>>> +    description:=0A=
>>> +      Array of node ids for scalable nodes. Uses same numeric identifi=
er=0A=
>>> +      namespace as the consumer "interconnects" binding.=0A=
>>> +=0A=
>>> +  fsl,scalable-nodes:=0A=
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array=0A=
>>> +    description:=0A=
>>> +      Array of phandles to scalable nodes. Must be of same length as=
=0A=
>>> +      fsl,scalable-node-ids.=0A=
>>> +=0A=
>>> +required:=0A=
>>> +  - compatible=0A=
>>> +  - clocks=0A=
>>> +=0A=
>>> +additionalProperties: false=0A=
>>> +=0A=
>>> +examples:=0A=
>>> +  - |=0A=
>>=0A=
>> Is it enough example to understand the relation between=0A=
>> imx8m-ddrc.c, imx-devfreq.c and imx interconnect driver?=0A=
>>=0A=
>> In my case, if possible, hope to show the more detailed=0A=
>> example. This example seems that don't contain the ddrc=0A=
>> dt node (imx8m-ddrc.c).=0A=
=0A=
OK, I'll elaborate explanation on noc binding.=0A=
=0A=
>>=0A=
>>> +    #include <dt-bindings/clock/imx8mq-clock.h>=0A=
>>> +    #include <dt-bindings/interconnect/imx8mq.h>=0A=
>>> +    noc: interconnect@32700000 {=0A=
>>> +            compatible =3D "fsl,imx8mq-noc", "fsl,imx8m-noc";=0A=
>>> +            reg =3D <0x32700000 0x100000>;=0A=
>>> +            clocks =3D <&clk IMX8MQ_CLK_NOC>;=0A=
>>> +            #interconnect-cells =3D <1>;=0A=
>>> +            fsl,scalable-node-ids =3D <IMX8MQ_ICN_NOC>,=0A=
>>> +                                    <IMX8MQ_ICS_DRAM>;=0A=
>>> +            fsl,scalable-nodes =3D <&noc>,=0A=
>>> +                                 <&ddrc>;=0A=
>>> +            operating-points-v2 =3D <&noc_opp_table>;=0A=
>>> +=0A=
>>> +            noc_opp_table: opp-table {=0A=
>>> +                    compatible =3D "operating-points-v2";=0A=
>>> +=0A=
>>> +                    opp-133M {=0A=
>>> +                            opp-hz =3D /bits/ 64 <133333333>;=0A=
>>> +                    };=0A=
>>> +                    opp-800M {=0A=
>>> +                            opp-hz =3D /bits/ 64 <800000000>;=0A=
>>> +                    };=0A=
>>> +            };=0A=
>>> +    };=0A=
