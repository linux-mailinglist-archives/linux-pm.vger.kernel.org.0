Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0780BF82DE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 23:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKKW3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 17:29:01 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:61038
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbfKKW3B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 17:29:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYMQ1F8XLHf+MlN5x3kf/U5NxDLcWxg62fFspuGK8yKUn+efyD38nKTbcEsv3I/a5+3vwBT2M0PHSK9lEbke2PX4m8putaeJ4kXJUjY+Obi/NOOZdqgGxVhTf66MME7LGjyq3GMwuu67rtbeDJ5Byd6gR4nHoF+xYUb2aRuOQJ1pazk/TNyaXvH1+wu4zPeqtkkr8ymTbgJ3lyEYkGGyYc3goM1lag/puK1kuXmfEATHjzrIuFB1x6d53irJq81wkvuyLRpcBYzRyDwDT998SVnQ7GOmEs5eCvs14IgUfYssAhtp4VwZEMZQdoR8uZ/1l5li2u78FDph7QdXog9MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxKffuqR37xnFlK5JbWKXmgjjah1Kb8kLY6Gr8m3IXw=;
 b=ONxsCJHT+JZzWgq9BURoY6Ol0LrP7LVnFyvqDoS+deGDRVeCENEgn3uvYwKS97Bbji6vYIkRWAI3G9/Ra4gw27LwLkMkbjmCmzKURCwednVXfVyobn5oqcW3QbwL2tclqmu8VOO7qcjXwu0Np3Gvg3Hty/AzTw5FotoLTb2NpykrmG3skKIzhKba2JXvOXE05nXr3ty4H+LksP04mXhxjNPHQOlOVZJBgW5dwrkWOfvfKsdIgy7ESpqHqcRxDPckUuuoXwo5rSXrvtLiS4qe2GnhJTXKnT/mGaIxYaLrNLy3g3wpADg4dztwVfLWFlKEX2cDdzji15cYc/Ikbh3rGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxKffuqR37xnFlK5JbWKXmgjjah1Kb8kLY6Gr8m3IXw=;
 b=CRm5G9GOw9+8VZL0gdKqv5fvf8cE35c+44EgGjAxT65rSajw9MHGX4xb4dFke6nMqq24YZMpXSW7RfjJNJ8obCCRYvHyyDvz7Y1BCj7x1fU45cCEp7fcTWMN+7ubVMrdei0cCIymO2hEPrHkiRS5e6+VBHCypvyMPUtax+xa0rY=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6207.eurprd04.prod.outlook.com (20.179.28.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Mon, 11 Nov 2019 22:28:53 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 22:28:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC v5 01/10] dt-bindings: devfreq: Add bindings for
 generic imx buses
Thread-Topic: [PATCH RFC v5 01/10] dt-bindings: devfreq: Add bindings for
 generic imx buses
Thread-Index: AQHVkD3as9Sa7H/jhkWE+GL1DYQYRg==
Date:   Mon, 11 Nov 2019 22:28:53 +0000
Message-ID: <VI1PR04MB7023FE9E511FDB48DE619F30EE740@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572562150.git.leonard.crestez@nxp.com>
 <0e4118456f8eb67e1ba8a7c23127fc3def58547b.1572562150.git.leonard.crestez@nxp.com>
 <20191104224946.GB17515@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b95cfc0b-5ecb-493f-fc2d-08d766f688c4
x-ms-traffictypediagnostic: VI1PR04MB6207:|VI1PR04MB6207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6207786022DA94E3DCA2DD3CEE740@VI1PR04MB6207.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(26005)(186003)(54906003)(52536014)(71190400001)(71200400001)(110136005)(6116002)(3846002)(316002)(66066001)(6506007)(486006)(102836004)(76176011)(53546011)(476003)(446003)(7696005)(66446008)(64756008)(66556008)(66476007)(99286004)(5660300002)(229853002)(478600001)(8936002)(45080400002)(6436002)(4326008)(305945005)(74316002)(14444005)(25786009)(256004)(7416002)(7736002)(76116006)(9686003)(86362001)(8676002)(55016002)(44832011)(2906002)(6306002)(91956017)(966005)(14454004)(66946007)(81166006)(81156014)(6246003)(33656002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6207;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BdzjInwLpUDPCMsTHvpf6mjF1ZnSldqo5GR0jvsndbZ7X/ow0p2EZkkHABlEnO5BPj4P5E9AnURwuOs4KyZXiV3RcnrEVIuNfBjcFc3/t3VYA6CNOATb6NoTdy8haqb8yfsnQ5+bwvXZvIpYviR9MU5++q9j438Ce5qIuttJKbYuelXi2HLzYAjHlrP2/d+IuuBHz6lPwlrDyHYlvr7oj6zVcJVBq5BfJj3fhbcjl8Jt1TebSpGoezkm+SMo7ULpv+23EAL3fXFOjh+BT4CxM8rN6yS+oPt/BLYXLdxFySbLAiR9nQ2wjcb8KexhEpaTmfFp1gOaxxxag6HC0AO3vAXSxBNZe1JE5iwrYg0ovKzRPSLCVjsKC79Xj8QakX081KAznzuKrk7L0mpUv22V2HNHsXUgi0c2xiDR79qi6VpaG4MdvZNyjHOcI60mkcj4
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95cfc0b-5ecb-493f-fc2d-08d766f688c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 22:28:53.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUsAcgSuNOoIMm045yNWr45uFeDv+LKwSMvVbp1Wnh4I+nEqwXmH/zzrtnu2w5r+yKyTrTDeLsCoD4Ih0yPfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6207
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05.11.2019 00:49, Rob Herring wrote:=0A=
> On Fri, Nov 01, 2019 at 12:52:00AM +0200, Leonard Crestez wrote:=0A=
>> Add initial dt bindings for the interconnects inside i.MX chips.=0A=
>> Multiple external IPs are involved but SOC integration means the=0A=
>> software controllable interfaces are very similar.=0A=
>>=0A=
>> Single node also acts as interconnect provider if #interconnect-cells is=
=0A=
>> present.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>=0A=
>> ---=0A=
>>   .../devicetree/bindings/devfreq/imx.yaml      | 83 +++++++++++++++++++=
=0A=
> =0A=
> bindings/interconnect/=0A=
=0A=
Make sense. The only other two files in devicetree/bindings/devfreq are:=0A=
  * rk3399_dmc: a memory controller=0A=
  * exynos-bus: arguably an interconnect=0A=
=0A=
>>   1 file changed, 83 insertions(+)=0A=
>>   create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml=
=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/devfreq/imx.yaml b/Docume=
ntation/devicetree/bindings/devfreq/imx.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..bfc825407764=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/devfreq/imx.yaml=0A=
>> @@ -0,0 +1,83 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0=0A=
>> +%YAML 1.2=0A=
>> +---=0A=
>> +$id: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
Fdevicetree.org%2Fschemas%2Fdevfreq%2Fimx.yaml%23&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7C95911400e0834b06269c08d761794cd2%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C1%7C637085045930647253&amp;sdata=3D88iAXoKObu%2FXBqZ=
u6hNwnOUIffB8GxVLdGeBWiCjClI%3D&amp;reserved=3D0=0A=
>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%=
2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7C95911400e0834b06269c08d761794cd2%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C1%7C637085045930647253&amp;sdata=3D0phpsG05ZsYc5SnI3=
FXZODJpJSEB2tzA5v02r7N%2BY2I%3D&amp;reserved=3D0=0A=
>> +=0A=
>> +title: Generic i.MX bus frequency device=0A=
> =0A=
> i.MX8 specific?=0A=
=0A=
Not really, but it's initially targeted at imx8m.=0A=
=0A=
>> +maintainers:=0A=
>> +  - Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> +=0A=
>> +description: |=0A=
>> +  The i.MX SoC family has multiple buses for which clock frequency (and=
=0A=
>> +  sometimes voltage) can be adjusted.=0A=
>> +=0A=
>> +  Some of those buses expose register areas mentioned in the memory map=
s as GPV=0A=
>> +  ("Global Programmers View") but not all. Access to this area might be=
 denied=0A=
>> +  for normal (non-secure) world.=0A=
>> +=0A=
>> +  The buses are based on externally licensed IPs such as ARM NIC-301 an=
d=0A=
>> +  Arteris FlexNOC but DT bindings are specific to the integration of th=
ese bus=0A=
>> +  interconnect IPs into imx SOCs.=0A=
>> +=0A=
>> +properties:=0A=
>> +  compatible:=0A=
>> +    oneOf:=0A=
>> +      - items:=0A=
>> +        - enum:=0A=
>> +          - fsl,imx8mn-nic=0A=
>> +          - fsl,imx8mm-nic=0A=
>> +          - fsl,imx8mq-nic=0A=
>> +        - const: fsl,imx8m-nic=0A=
>> +      - items:=0A=
>> +        - enum:=0A=
>> +          - fsl,imx8mn-noc=0A=
>> +          - fsl,imx8mm-noc=0A=
>> +          - fsl,imx8mq-noc=0A=
>> +        - const: fsl,imx8m-noc=0A=
>> +=0A=
>> +  reg:=0A=
>> +    maxItems: 1=0A=
>> +=0A=
>> +  clocks:=0A=
>> +    maxItems: 1=0A=
>> +=0A=
>> +  operating-points-v2: true=0A=
>> +=0A=
>> +  devfreq:=0A=
>> +    description: |=0A=
>> +      Phandle to another devfreq device to match OPPs with by using the=
=0A=
>> +      passive governor.=0A=
>> +    $ref: "/schemas/types.yaml#/definitions/phandle"=0A=
>> +=0A=
>> +  '#interconnect-cells':=0A=
>> +    description: |=0A=
>> +      If specified then also act as an interconnect provider. Should on=
ly be=0A=
>> +      set once per soc on main noc.=0A=
>> +    const: 1=0A=
>> +=0A=
>> +  interconnect-node-id:=0A=
> =0A=
> Looks like common property, but it's not...=0A=
> =0A=
> Generally, we don't do indexes or instance ids. So it needs a better=0A=
> explanation or drop this. The driver side looks like an odd marriage=0A=
> between interconnect and devfreq drivers that needs better integration,=
=0A=
> but I'm not all that familar with either.=0A=
=0A=
Current interconnect drivers all operate by sending messages via a =0A=
mailbox to a system controller which handles bandwidth requests. They =0A=
only perform request aggregation. On imx8m frequency scaling is also =0A=
implemented in the kernel so the NOC becomes almost like a MFD.=0A=
=0A=
The interconnect-node-id is used to find other scalable nodes for the =0A=
same interconnect provider. I can replace this with a "scalable-nodes" =0A=
array like this:=0A=
=0A=
	noc: interconnect@32700000 {=0A=
		compatible =3D "fsl,imx8mq-noc", "fsl,imx8m-noc";=0A=
		reg =3D <0x32700000 0x100000>;=0A=
		clocks =3D <&clk IMX8MQ_CLK_NOC>;=0A=
		#interconnect-cells =3D <1>;=0A=
		fsl,scalable-node-ids =3D <IMX8MQ_ICN_NOC>,=0A=
					<IMX8MQ_ICS_DRAM>;=0A=
		fsl,scalable-nodes =3D <&noc>,=0A=
				     <&ddrc>;=0A=
		operating-points-v2 =3D <&noc_opp_table>;=0A=
=0A=
		noc_opp_table: opp-table {=0A=
			compatible =3D "operating-points-v2";=0A=
=0A=
			opp-133M {=0A=
				opp-hz =3D /bits/ 64 <133333333>;=0A=
			};=0A=
			opp-400M {=0A=
				opp-hz =3D /bits/ 64 <400000000>;=0A=
			};=0A=
			opp-800M {=0A=
				opp-hz =3D /bits/ 64 <800000000>;=0A=
			};=0A=
		};=0A=
	};=0A=
=0A=
	ddrc: dram-controller@3d400000 {=0A=
		compatible =3D "fsl,imx8mq-ddrc", "fsl,imx8m-ddrc";=0A=
		reg =3D <0x3d400000 0x400000>;=0A=
		clock-names =3D "core", "pll", "alt", "apb";=0A=
		clocks =3D <&clk IMX8MQ_CLK_DRAM_CORE>,=0A=
			 <&clk IMX8MQ_DRAM_PLL_OUT>,=0A=
			 <&clk IMX8MQ_CLK_DRAM_ALT>,=0A=
			 <&clk IMX8MQ_CLK_DRAM_APB>;=0A=
		devfreq-events =3D <&ddr_pmu>;=0A=
	};=0A=
=0A=
It's a bit strange that the noc references itself but in advanced =0A=
multiple NOC can be be present and there needs to be a way to map from =0A=
the interconnect graph (node ids) to devicetree nodes.=0A=
=0A=
>> +    description: |=0A=
>> +      i.MX chips have multiple scalable buses based on the same IP, thi=
s is=0A=
>> +      used to distinguish between. Uses same identifier namespace as co=
nsumer=0A=
> =0A=
> It's not names, so number space? Just guessing because there's no type=0A=
> nor example.=0A=
=0A=
Maybe "numeric namespace"?=0A=
=0A=
>> +      "interconnects" property, for example one of the values in=0A=
>> +      "include/dt-bindings/interconnect/imx8mm.h"=0A=
>> +=0A=
>> +    const: 1=0A=
>> +=0A=
>> +required:=0A=
>> +  - compatible=0A=
>> +  - clocks=0A=
>> +=0A=
>> +additionalProperties: false=0A=
>> +=0A=
>> +examples:=0A=
>> +  - |=0A=
>> +    #include <dt-bindings/clock/imx8mm-clock.h>=0A=
>> +    noc: noc@32700000 {=0A=
>> +            compatible =3D "fsl,imx8mm-noc", "fsl,imx8m-noc";=0A=
>> +            reg =3D <0x32700000 0x100000>;=0A=
>> +            clocks =3D <&clk IMX8MM_CLK_NOC>;=0A=
>> +            operating-points-v2 =3D <&noc_opp_table>;=0A=
>> +    };=0A=
>> -- =0A=
>> 2.17.1=0A=
