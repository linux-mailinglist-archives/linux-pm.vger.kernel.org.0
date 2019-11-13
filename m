Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D016FB087
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 13:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKMMfo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 07:35:44 -0500
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:20704
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbfKMMfn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Nov 2019 07:35:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sikx7iF3SmyS8HSgLrvowGZOZOLEyLdqn90StQOqek1ryVwDGRb18+VfLm8XrhWXmGej/3FHAT+RyF0nAP+U6xJHuDfxrpuw79vu+ZjOKED2sh9Zq5GIg183JYd8ieUSu/QV/QU6O1cbSASZ+fb/4YF2/FzZCcxQOTGNzBIyTnVAp/q6OwiyXOl3dw9wprFvXtWWv9ArPneYj/Hv3nuUcrOyfLh6MrZ44q9cvbGAdKAgfZtE3e8eGvS4qcT42Sy0ezGpXCz2C62Hxk2iL3hQlogHbQToDJLGgicW2aRk/ZeXzkA1i1sZETbatcY4TCeUjkKkyeoMzzt8kKwjXKtdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB+XF+6Gne40W/itLQd8Aj6w0yJfmY850cj+E7Lx+ow=;
 b=MYkuyMDEuDaTG8fY5KQ+Q32o5QuhF+jcItcsABY1hBTarnqMMvbTtAX1jqu05GVk5UaaFMaNJkHRnT/qXSEANf4P2Scjkur0mJ35OZNciAMnT1r4sDZOEpcyVJs8uKhIligux9E11l4PugSraQU0JLtgwu32h6BrGEixafxyqkON7PPoD+IJq3rjoO3KfElHr/839s0lY3XTr/L9RwnmgHZRlOiWZZ6FRAKyIc+cRIhjr86Jpvm10riBvVmNGpoH6WPMuSfB/9dpBi0V89XHuxc2s0WysALJhyX+A4rVxVFIbAWnkDV+/fXAm8S1A68SzfGnZ4lnwRcKumvr7u6oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB+XF+6Gne40W/itLQd8Aj6w0yJfmY850cj+E7Lx+ow=;
 b=bk5UGVMqMhbDff25cA1o4e94tvvRqsSamp2lSogSkypxb9LLbNeIu5hZf6FDR6acM55yl7lJmACbCRiKZaOUVauYTnQtrom/eg7fiBDgYoIK444lsqxoae3lk2S3Vp22uocSwZbezkfDzJeGK7Ycp+xoTXCrJbkKQ75aLnVJWbQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6928.eurprd04.prod.outlook.com (52.133.246.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 12:35:38 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 12:35:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
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
Subject: Re: [PATCH v5 3/5] dt-bindings: memory: Add bindings for imx8m ddr
 controller
Thread-Topic: [PATCH v5 3/5] dt-bindings: memory: Add bindings for imx8m ddr
 controller
Thread-Index: AQHVmaNN8+lTgarJx0yj+3LD9AtsMg==
Date:   Wed, 13 Nov 2019 12:35:38 +0000
Message-ID: <VI1PR04MB702328B4F8744FBF42E0D537EE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573595318.git.leonard.crestez@nxp.com>
 <CGME20191112215123epcas5p13e9eec7f2209a73bb1a6f09434ec91ba@epcas5p1.samsung.com>
 <872fb6e3117955b679678280483f82b3d73dd376.1573595319.git.leonard.crestez@nxp.com>
 <296a7e8a-78e5-62bb-e4e1-8f5a9095cb6d@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd5aa2c7-5031-4aed-0490-08d76835fd31
x-ms-traffictypediagnostic: VI1PR04MB6928:|VI1PR04MB6928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6928E262B6635815F573262DEE760@VI1PR04MB6928.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(199004)(189003)(102836004)(55016002)(8936002)(86362001)(74316002)(305945005)(7736002)(6116002)(3846002)(486006)(81156014)(81166006)(8676002)(52536014)(476003)(66946007)(7696005)(66476007)(66556008)(7416002)(64756008)(66446008)(5660300002)(6506007)(44832011)(76176011)(2906002)(53546011)(6306002)(9686003)(99286004)(6436002)(33656002)(6246003)(26005)(71190400001)(446003)(966005)(14454004)(4326008)(229853002)(256004)(91956017)(76116006)(45080400002)(478600001)(316002)(25786009)(54906003)(186003)(71200400001)(66066001)(110136005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6928;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnyMAQLDXtldXg5WwAVI9Jy3BmPZ1Su/w4LP92enb+RqvyfgXHyXncCWDhxnFy9nQGIs0ZmNA5kjaMHqWYLts3p15Bv9SLx3tKdQJ40Db+ij0RjeXXLdutiBV/BtR8td3whTvFVI7F9wqz2DNONzRPLL3lLDX5fMJw0L07VK+5dkjOeYqxnZFs7sw90qeefwawdKy2ypkHX58jDmzKpZYTJDR9Jbdtc+2K0UO1+sqYRW17iTFsI0DZYzfeqoWfhR7ShOEYab3ef6Z09zOR4by7oOwpYkK2U+DOHIo/HEyDS2MEVNljovlCuvdfX71z6WVG/u5fryhtAEoCe9l3LTzuLHb5X7cdkpDcZXy/PIxYeAnTUMgDXI5CUHgKuc6Fckq6pGLqfIOH+1JKzC73RCYRgx9+LVDnPvSX5MwokKF0ls5YA9CJKZXGqcGtDI1x7y
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5aa2c7-5031-4aed-0490-08d76835fd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:35:38.4467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUZSr8CtgGMVTirejB/pimcC9XFoidmUJKj/aKmVLNxO87GewSdp5KEIkeum3W4YWsNqo4YEAUjPzKxgcV2TAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13.11.2019 04:32, Chanwoo Choi wrote:=0A=
> On 11/13/19 6:50 AM, Leonard Crestez wrote:=0A=
>> Add devicetree bindings for the i.MX DDR Controller on imx8m series=0A=
>> chips. It supports dynamic frequency switching between multiple data=0A=
>> rates and this is exposed to Linux via the devfreq subsystem.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   .../memory-controllers/fsl/imx8m-ddrc.yaml    | 57 +++++++++++++++++++=
=0A=
>>   1 file changed, 57 insertions(+)=0A=
>>   create mode 100644 Documentation/devicetree/bindings/memory-controller=
s/fsl/imx8m-ddrc.yaml=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/im=
x8m-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/im=
x8m-ddrc.yaml=0A=
>> new file mode 100644=0A=
>> index 000000000000..7c98e3509f75=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-ddr=
c.yaml=0A=
>> @@ -0,0 +1,57 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0=0A=
>> +%YAML 1.2=0A=
>> +---=0A=
>> +$id: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
Fdevicetree.org%2Fschemas%2Fmemory-controllers%2Ffsl%2Fimx8m-ddrc.yaml%23&a=
mp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C23e819d42b664965975808d767e=
1c084%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637092091602846215&amp;s=
data=3DfrWd1MENZm%2FsPjQp%2FWbphMgkkCMtwsgV8hLQyIhC3%2BI%3D&amp;reserved=3D=
0=0A=
>> +$schema: https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%=
2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cleon=
ard.crestez%40nxp.com%7C23e819d42b664965975808d767e1c084%7C686ea1d3bc2b4c6f=
a92cd99c5c301635%7C0%7C0%7C637092091602846215&amp;sdata=3D4IweKQJO9ZsB%2B9Q=
xixSQjfYOFm3%2FY7iMHFBSsquK1B0%3D&amp;reserved=3D0=0A=
>> +=0A=
>> +title: i.MX8M DDR Controller=0A=
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
>> +      - const: core=0A=
>> +      - const: pll=0A=
>> +      - const: alt=0A=
>> +      - const: apb=0A=
>> +=0A=
>> +  operating-points-v2: true=0A=
>> +  opp-table: true=0A=
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
>> +    ddrc: memory-controller@3d400000 {=0A=
>> +        compatible =3D "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";=0A=
>> +        reg =3D <0x3d400000 0x400000>;=0A=
> =0A=
> The probe() function doesn't get the IORESOURCE_MEM from dt?=0A=
> Is it needed?=0A=
=0A=
This area is not currently mapped by the driver. As far as I understand =0A=
it's acceptable to "describe hardware" even if you don't use the full =0A=
description in driver code.=0A=
=0A=
If I were to remove the "reg" area wouldn't I also have to move the node =
=0A=
outside of the bus to keep DT validation? It's better to keep the address.=
=0A=
=0A=
Maybe it will be mapped in the future or maybe firmware will start to =0A=
parse linux DT instead of hardcoding SOC-specific addresses (this =0A=
already happens in some cases).=0A=
=0A=
>> +        clock-names =3D "core", "pll", "alt", "apb";=0A=
>> +        clocks =3D <&clk IMX8MM_CLK_DRAM_CORE>,=0A=
>> +                 <&clk IMX8MM_DRAM_PLL>,=0A=
>> +                 <&clk IMX8MM_CLK_DRAM_ALT>,=0A=
>> +                 <&clk IMX8MM_CLK_DRAM_APB>;=0A=
>> +        operating-points-v2 =3D <&ddrc_opp_table>;=0A=
>> +    };=0A=
