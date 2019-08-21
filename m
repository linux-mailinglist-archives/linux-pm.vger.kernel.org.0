Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5C97C85
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfHUOVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 10:21:43 -0400
Received: from mail-eopbgr50070.outbound.protection.outlook.com ([40.107.5.70]:36487
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729455AbfHUOVj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Aug 2019 10:21:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1S7q5ePngZUV/W4Qv46NZUElPhsD7EuLeDC5d75fuGer4X9qCeyZKlfNHFiMvYu+NMutw6qXGTJon35qCZ4z3yEzTlQTZB8ySoxDxy6oze80Ct6ZKAWYCm8QTiHwkmzZgesfwGr28d9ywuDXbthgv46vrm5ZZvVniGQnWAeftejrECm7MN5IJsavHPzYb7E7XH7wIWNc1MrpDY0QFVOcyXfanH/rmHM2n8ppuEAANJWEPy5obrWpPCzHURK5cXRAiCrcXDvsUCHZfbeiyodunSkiMmvqKfmYe5VcQHOoLnEsO4PErDE3MRpHhreJPOdMPrKQRTzf3tHjJ4YaKM1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUgh1gxEi6hlJCpGBTs/Cn1pMZHKoLhVVoKNMR1/LKw=;
 b=P6rU4iPAZufvH5XMpA2zHl43Hzfotz2vUPIaUigHaMnKz+Wy+gczMYNHNK21jgCJ9JZfD4q4arcVKcCDf2NgxdGARuxYTRSjLxtjdLIwgtK6LG3C9RwQNMgxfPIMvaPBhuhBd6o4l7/Fe/I9CmWQtT+oRibRMAxT5dfvYDdIRvMADAR5s6XtnQWiWFcj4VlRq4klaat01bHvQwCcCRvPQg4j0kYyM7YT4LDqidTaALLVqVo7U9IDRmgpPvhs9UG+Vq8nxCP/saqSzukx5BL9ClbA+lQwnDXQmq3d9dpC2+Mu34r9RtR7yfl8F50jtnASjedab5HCAALZcPrCVUVBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUgh1gxEi6hlJCpGBTs/Cn1pMZHKoLhVVoKNMR1/LKw=;
 b=aUAMqZhdMEIFCarGBvhrdV6gbkx5Ck47+ovQsWkckm+5NqC+7GyeIXfJGPvZRQWoAtEthmp5PpgKWB3KowCl+iCfYYt2NdnC730EJW77REyrWXCxh8HugNjnmaDDEs3/nXNxZgGgyEf7PtNt0BSJyh7Eld9M9QrVPi+i6bUnz9c=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6285.eurprd04.prod.outlook.com (20.179.27.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Wed, 21 Aug 2019 14:21:36 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 14:21:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Anson Huang <anson.huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv3 3/3] interconnect: imx: Add platform driver for imx8mm
Thread-Topic: [RFCv3 3/3] interconnect: imx: Add platform driver for imx8mm
Thread-Index: AQHVTEWKNFF2Yqu6YU66bS83yX49og==
Date:   Wed, 21 Aug 2019 14:21:36 +0000
Message-ID: <VI1PR04MB7023E441FEE0D9288CAC0F44EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1565088423.git.leonard.crestez@nxp.com>
 <cf265add1502a75c4d6e6261ab1570c665e82c83.1565088423.git.leonard.crestez@nxp.com>
 <a2e09a9b-574f-8410-423e-0b0d8ea5c2ab@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97d71ead-b2cf-47f4-9294-08d72642e004
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB6285;
x-ms-traffictypediagnostic: VI1PR04MB6285:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB628544B532DFFF6943C82997EEAA0@VI1PR04MB6285.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(76116006)(486006)(476003)(44832011)(54906003)(5660300002)(7416002)(52536014)(25786009)(446003)(53936002)(66066001)(4326008)(6246003)(229853002)(2906002)(14454004)(8936002)(74316002)(81166006)(305945005)(8676002)(81156014)(7736002)(316002)(66946007)(478600001)(55016002)(76176011)(26005)(6916009)(6506007)(102836004)(33656002)(6116002)(3846002)(7696005)(66556008)(99286004)(91956017)(186003)(71200400001)(71190400001)(9686003)(53546011)(64756008)(66476007)(66446008)(6436002)(966005)(86362001)(256004)(6306002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6285;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /7yWEx21AP9z4cw0B5oaoDMJ9jfp/PzqIUwzn5+bUToKiDNCD7A+NKvq6xDJ4TYJUrCIriBWFGVGm6rfZiWMk6MEz4KXsynz8lQhvAMa9MRX6Lu5Tm01OIZk1V4FBDfQLv4lsDQnPqwZNjVmMdJq3PNm0dmCGrRYYVrmRu1PQyXUHL90ZBT0pHqGRmHZN/fOznnEcS2xHmLx6yf7nw3IYZOia1hqOlYxvhhdzxXKZ7GqzhtQRCJDmmpIrNNED7G73auTmaWqdpY0Tqa8svxT9GEjB6pcGFZJOHaahrhUDnWxhYObUs0rfRXJuFMfHp6ff8UmEX0CAFwlAk5ILEoJUd4hwsCduoPJoygRDq67PNNxpovS4DXZGL8y4PEE+If2wBsQYBvgN2/qpuCM6UxeXijafyE9bAGdP9eH+0gqN2s=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d71ead-b2cf-47f4-9294-08d72642e004
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:21:36.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrZ7Xx7TBNYiq9bwOG+znQ2VR+79bsLxqoeMr2v3jSdGzt1dUllkxUOuCZiI9P4sfTtoeyuKatdbWIJ5oL8JQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6285
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21.08.2019 17:03, Martin Kepplinger wrote:=0A=
> On 06.08.19 12:55, Leonard Crestez wrote:=0A=
>> This adds a platform driver for the i.MX8MM SoC.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>=0A=
>> ---=0A=
>>   drivers/interconnect/imx/Kconfig          |   4 +=0A=
>>   drivers/interconnect/imx/Makefile         |   1 +=0A=
>>   drivers/interconnect/imx/imx8mm.c         | 114 ++++++++++++++++++++++=
=0A=
>>   include/dt-bindings/interconnect/imx8mm.h |  49 ++++++++++=0A=
>>   4 files changed, 168 insertions(+)=0A=
>>   create mode 100644 drivers/interconnect/imx/imx8mm.c=0A=
>>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h=0A=
> =0A=
> Do you plan to add such a driver for imx8mq too?=0A=
=0A=
Yes! The topology is different (serving different IP blocks) but no =0A=
functional code changes are required between 8mm 8mn 8mq.=0A=
=0A=
I already wrote the code and tested it but didn't post because I want to =
=0A=
get the core parts in first. I periodically push my "full" =0A=
work-in-progress to github:=0A=
=0A=
https://github.com/cdleonard/linux/commits/next_imx8mm_busfreq=0A=
=0A=
You need out-of-tree ATF changes or devfreq probe will fail:=0A=
=0A=
https://github.com/cdleonard/arm-trusted-firmware/commits/imx_2.0.y_busfreq=
=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
