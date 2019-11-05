Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC3F05EC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbfKET0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 14:26:07 -0500
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:59700
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390943AbfKET0H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 14:26:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8GJcIbZ0JLnP3fHrgMIQhYTTaOukFilNoKhbPYmZkFe0ynm+Nse/AHh1UE+x/Vv3zVw61XAEVrb0zOpYT5QbkGmaFk10RpWn96cG4332qDpHzQ6k/ALD8XDoxV7ssal+G3QHCHcO9Bm9sWnWkIk64I9jQ4K8i0s+Gc2DIk5A4vZDI5AS2tVuMnDR+ivjnqC35T7zAgQvofXFZSxFepNRFcoOpdvKIkVFxX/ILE+u5CeyBsPg/vsuqyLlysbPOgQBXehcNuLMLMy9YKPyuSVF02wVV2UCaxIIYfpkEmXO64aFBZZ+oN6toK4ujavqvhU948Kzq+8tXy5/EhoPOueDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddzith1KCgIQvGUdk2FllzeY1o8XmIkimAvZ7eZbiYs=;
 b=COAAhHsclhEZuBQzouJ0PXBlvbbzqQakeqDC9TmimKaXFSx9Zx+dLesIrsAt+mqVeQRdkGPMgKO99v3DHG36cByPtAHs9AeRibYTWwB+U+bhmZAKbQUb5AsvH1SLOfnxPqefXh0/HpizoivvD+PcIYnyB8mcwAYlWepqEIqHqWaOjaerl+v7GPqt+cCEqEKuJKrpGvcR4O3M2DL9cRi8SE8kgfptrIMxi4VAK0Js3EGcvJp66JadcsBRxROlkyVxPTnTNvLdmTJQgM9N+nR6qU/7HP//Q80T33D1lnDW2i91powk8GORqMqE7Ky2PtF+qX0bjMlAEGVqfPCXeC8Irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddzith1KCgIQvGUdk2FllzeY1o8XmIkimAvZ7eZbiYs=;
 b=TiRRiiKd3PMgcKZa8aTGsNLsH1rEnm8rKWzx36QC0XlBJAq80e3nRDeUuSZfUmMeDBzCp2QOYkeRzja5xR3T1/o6fpBBIWkRi5A5dyk/HQW7/QGTYYefHVmzftqVOfmYvgwT/PFNnAlJwpfwMrHA4QdMXAyzckr5+e4QEZneZPE=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5759.eurprd04.prod.outlook.com (20.178.125.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 19:25:57 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 19:25:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
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
Subject: Re: [PATCH v3 3/6] dt-bindings: devfreq: Add bindings for imx ddr
 controller
Thread-Topic: [PATCH v3 3/6] dt-bindings: devfreq: Add bindings for imx ddr
 controller
Thread-Index: AQHVkDU6emQ0aN+uuUOlCrShp6WAog==
Date:   Tue, 5 Nov 2019 19:25:57 +0000
Message-ID: <VI1PR04MB7023F375AEDC4549FA12247FEE7E0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1572558427.git.leonard.crestez@nxp.com>
 <b9a87c69eb603622303add4f0c02dd4c1262462a.1572558427.git.leonard.crestez@nxp.com>
 <20191104222126.GB5218@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7825f8c0-8c2c-4ef3-babd-08d76225fc19
x-ms-traffictypediagnostic: VI1PR04MB5759:|VI1PR04MB5759:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5759EF7E2A85C3636D71C34CEE7E0@VI1PR04MB5759.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(476003)(6246003)(9686003)(256004)(102836004)(81156014)(8676002)(76176011)(446003)(66556008)(25786009)(3846002)(71200400001)(6116002)(66476007)(6306002)(6436002)(71190400001)(14454004)(66946007)(45080400002)(76116006)(66446008)(316002)(4326008)(478600001)(966005)(7696005)(2906002)(186003)(6506007)(110136005)(86362001)(26005)(7736002)(8936002)(305945005)(64756008)(55016002)(7416002)(91956017)(486006)(99286004)(66066001)(5660300002)(44832011)(33656002)(229853002)(52536014)(74316002)(81166006)(54906003)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5759;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOa7ZzTL1I5s6UPvJLkyJ9akHpwqlqN4jM8FQgWliUnzpUJo5UaZ1eQ4ftkyq/7Vrm5+8YCLdEY6kEcnm0Khr6du5HDqMWKWwLwFPf1GoqDEiGkBeGyvsGlMyG6Jes4ta/ggAQqyMvRZ4gg7N7BjhA6Mj25Fl43cNibbJG/7CD1KMZNKUYWdd4aUaJfpTLrVbrPTrVnjOrwlu84T3N0n1sV2lqzjqoXPStTkJTw52sQ1AT8X/0Gjwqzqlon0V+FTmSTfE5+NTQTLP3HdEtsRXzFEoMGkfA5T52DuiWahwAp2eGhEhWJk4Uyg6nwEZgR88FTGPnRytcFHe61MWA+pae/F0yVTwAWJIFoiS9mP7m/Eqhiv3EfoLp9Y9KuiZf55BYaywtNGeO0nrL53xm9lA2uK2ulh5AAmNeE85n0eUVWMVIperKlprNPzcAF9bDHcNblRfKjS2VtoSJ7IQBtY49h7l2UcWX579SEN2F2drxM=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7825f8c0-8c2c-4ef3-babd-08d76225fc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 19:25:57.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXe8EaZx92W5tqBZ1CuAbY9i5q0W5GALgOEt4d1n23gxr0hJlzHlYXUrfN1tDkhAqVTMYFzjODj5vW2X+I0AjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5759
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05.11.2019 00:21, Rob Herring wrote:=0A=
> On Thu, Oct 31, 2019 at 11:50:24PM +0200, Leonard Crestez wrote:=0A=
>> Add devicetree bindings for the i.MX DDR Controller on imx8m series=0A=
>> chips. It supports dynamic frequency switching between multiple data=0A=
>> rates and this is exposed to Linux via the devfreq subsystem.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   .../devicetree/bindings/devfreq/imx-ddrc.yaml | 60 +++++++++++++++++++=
=0A=
> =0A=
> .../bindings/memory-controllers/=0A=
=0A=
Okay, but I'm not sure about the rules here. Usually there is a 1:1 =0A=
mapping between subsystems and bindings directory but I guess devfreq is =
=0A=
odd since it's not really a physical class of device.=0A=
=0A=
I saw there is also a drivers/memory and there is already a =0A=
devfreq-using driver in there (EXYNOS5422_DMC).=0A=
=0A=
It's not clear if my driver fits in there; as far as I can see the only =0A=
"core" functionality in drivers/memory is parsing DDR timings from DTS =0A=
but for imx8m this is all controlled in firmware.=0A=
=0A=
>>   1 file changed, 60 insertions(+)=0A=
>>   create mode 100644 Documentation/devicetree/bindings/devfreq/imx-ddrc.=
yaml=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml b/D=
ocumentation/devicetree/bindings/devfreq/imx-ddrc.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..31db204e6845=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml=0A=
>> @@ -0,0 +1,60 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0=0A=
> =0A=
> For new bindings:=0A=
> =0A=
> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
> =0A=
>> +%YAML 1.2=0A=
>> +---=0A=
>> +$id: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
Fdevicetree.org%2Fschemas%2Fdevfreq%2Fimx-devfreq.yaml%23&amp;data=3D02%7C0=
1%7Cleonard.crestez%40nxp.com%7Cba47e72161764d5a969a08d761755736%7C686ea1d3=
bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637085028918247356&amp;sdata=3D2DjKgyATO=
Pu7qhzpOCfRrmUM0%2FSAQrV9R7AxZxib8gk%3D&amp;reserved=3D0=0A=
> =0A=
> Run 'make dt_binding_check'. This will fail as the filename doesn't=0A=
> match.=0A=
> =0A=
>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%=
2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7Cba47e72161764d5a969a08d761755736%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C1%7C637085028918247356&amp;sdata=3DEbyVK2ZF6Z22vE%2F=
4LfIVv0S1LoMe7%2BxhM43H1i8nxtE%3D&amp;reserved=3D0=0A=
>> +=0A=
>> +title: i.MX DDR Controller=0A=
> =0A=
> Perhaps i.MX8x as it's not all i.MX chips. And the filename too?=0A=
=0A=
Ok, will rename to imx8m-ddrc since it's not even for all imx8.=0A=
=0A=
>> +=0A=
>> +maintainers:=0A=
>> +  - Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> +=0A=
>> +properties:=0A=
>> +  compatible:=0A=
>> +    items:=0A=
>> +      - enum:=0A=
>> +        - fsl,imx8mn-ddrc=0A=
>> +        - fsl,imx8mm-ddrc=0A=
>> +        - fsl,imx8mq-ddrc=0A=
>> +      - const: fsl,imx8m-ddrc=0A=
>> +=0A=
>> +  reg:=0A=
>> +    maxItems: 1=0A=
>> +=0A=
>> +  clocks:=0A=
>> +    maxItems: 4=0A=
>> +=0A=
>> +  clock-names:=0A=
>> +    items:=0A=
>> +      - const: dram_core=0A=
>> +      - const: dram_pll=0A=
>> +      - const: dram_alt=0A=
>> +      - const: dram_apb=0A=
> =0A=
> Drop 'dram_'=0A=
=0A=
OK=0A=
=0A=
>> +=0A=
>> +  operating-points-v2: true=0A=
>> +=0A=
>> +  devfreq-events:=0A=
>> +    description: Phandle of PMU node=0A=
>> +    $ref: "/schemas/types.yaml#/definitions/phandle"=0A=
>> +=0A=
>> +required:=0A=
>> +  - reg=0A=
>> +  - compatible=0A=
>> +  - clocks=0A=
>> +  - clock-names=0A=
>> +=0A=
>> +additionalProperties: false=0A=
>> +=0A=
>> +examples:=0A=
>> +  - |=0A=
>> +    #include <dt-bindings/clock/imx8mm-clock.h>=0A=
>> +    ddrc: dram-controller@3d400000 {=0A=
>> +        compatible =3D "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";=0A=
>> +        reg =3D <0x3d400000 0x400000>;=0A=
>> +        clock-names =3D "dram_core", "dram_pll", "dram_alt", "dram_apb"=
;=0A=
>> +        clocks =3D <&clk IMX8MM_CLK_DRAM_CORE>,=0A=
>> +                 <&clk IMX8MM_DRAM_PLL>,=0A=
>> +                 <&clk IMX8MM_CLK_DRAM_ALT>,=0A=
>> +                 <&clk IMX8MM_CLK_DRAM_APB>;=0A=
>> +        operating-points-v2 =3D <&ddrc_opp_table>;=0A=
>> +    };=0A=
