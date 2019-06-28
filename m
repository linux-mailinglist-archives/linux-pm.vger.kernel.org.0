Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA359621
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF1IbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 04:31:03 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:12647
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfF1IbD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf8QcMn7wuNGlQ7cO6ZNBj+vaqdkjVTG6vtYWclAlOk=;
 b=gU0nFtivr+OwiVUNMbCQ0QaCU6Dcn67GblhD92sKGMuqPva9bk8vgvDcKk6rFmbVCX63Zhefz8GA9y118TDGHiStwW3kqPdWrBZBcNL8LhVvTJuCK5Ubqf0gXTIy7cKONNHm0fJZzdyQkCVAVnNyRB6P6CW6RUvjaSQbC8G3IGA=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB3104.eurprd04.prod.outlook.com (10.170.229.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 08:30:59 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 08:30:59 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Cedric Neveux <cedric.neveux@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Nitin Garg <nitin.garg@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] clk: imx8mm: Add dram freq switch support
Thread-Topic: [RFC] clk: imx8mm: Add dram freq switch support
Thread-Index: AQHVFrc7ODGIzaJAMkqnt2iUWhij6w==
Date:   Fri, 28 Jun 2019 08:30:59 +0000
Message-ID: <VI1PR04MB50551B5AFFBF2C58D40D993FEEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <475e0250b1e77a660c095749e78427fde318d5f6.1559200405.git.leonard.crestez@nxp.com>
 <20190627211453.37FF4208CB@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1efd5c5-02d2-4e19-11e1-08d6fba2f2ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3104;
x-ms-traffictypediagnostic: VI1PR04MB3104:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB310413E9E2C6F0ADC7B40F79EEFC0@VI1PR04MB3104.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(14454004)(966005)(33656002)(26005)(186003)(99286004)(102836004)(55016002)(6436002)(53936002)(9686003)(6306002)(68736007)(66066001)(478600001)(229853002)(53546011)(6506007)(7696005)(76176011)(74316002)(8676002)(305945005)(7736002)(81156014)(81166006)(6116002)(3846002)(8936002)(52536014)(6246003)(316002)(110136005)(5660300002)(54906003)(66446008)(64756008)(66556008)(66476007)(76116006)(73956011)(66946007)(7416002)(446003)(44832011)(476003)(486006)(4326008)(25786009)(2906002)(86362001)(14444005)(256004)(71190400001)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3104;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: acQZ0q4jIdn/e4NEVEcQvAylbeRJonSgXqia/0QGGKgSQIzP6MTAvQGwPjsYg9TvbL/3mVSxVBC+KSwZR75FRwDuhKzN66dpZaguf4kYsbJsHMALQW8Ldr8fR2FmoF65bFDc0iqS7NUdL+Lz59TDZtrd+HAmMBRbHcL0prp1Vji67vmFEzdDcLn6zI7huCwKVgsTtLGmTuxfOSgV7aRIo2ldaogqbB9VT4dEW7mJifIAkKnxXp+FaRQMizIWs7VcznEDEZXz+VwbM6PlRdX8VqSzPOKlza2iA8MlYLBh0oMTShJFwSkEhWg8uFP1D/phwLWfLkkWktfxSWWZmdBCYYs+UL22rftlEsqs+xK/BMIyHmjCs0j3nv1nAykiosS8pfQkKG0YSATqovKmqlhZMNNkUMa2yGuy0gB/DIfhzxM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1efd5c5-02d2-4e19-11e1-08d6fba2f2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 08:30:59.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3104
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28.06.2019 00:15, Stephen Boyd wrote:=0A=
> Quoting Leonard Crestez (2019-05-30 00:13:51)=0A=
=0A=
>> Add a wrapper clock encapsulating dram frequency switch support for=0A=
>> imx8m chips. This allows higher-level DVFS code to manipulate dram=0A=
>> frequency using standard clock framework APIs.=0A=
>>=0A=
>> Linux-side implementation is similar in principle to imx_clk_cpu or a=0A=
>> composite clock. Only some preparation is done inside the kernel, the=0A=
>> actual freq switch is performed from TF-A code which runs from an SRAM=
=0A=
>> area. Cores other than the one performing the switch are also made to=0A=
>> spin inside TF-A by sending each an IRQ.=0A=
>>=0A=
>> This is an early proof-of-concept which only support low/high mode on=0A=
>> imx8mm but NXP has secure-world dram freq switching implementations for=
=0A=
>> multiple other chips and this approach can be extended.=0A=
>>=0A=
>> Many platforms handle this kind of stuff externally but cpufreq is quite=
=0A=
>> insistent that actual rates are set by clk code and that new platforms=
=0A=
>> use cpufreq-dt.=0A=
>>=0A=
>> Let me know if there are objections to handling dram freq via clk.=0A=
> =0A=
> Can it be an interconnect driver instead? I don't see how this is a clk=
=0A=
> driver. It looks more like a driver that itself manages a collection of=
=0A=
> clks, and you've put the coordination of those clks behind the clk_ops=0A=
> interface. We don't want to have clk_ops calling clk consumer APIs in=0A=
> general, so the whole approach doesn't seem correct.=0A=
=0A=
The imx8m dram clk structure is only slightly more complicated than that =
=0A=
for the cpu. It's not clear why mux manipulation should be pushed away =0A=
from clk and onto consumers. Isn't it desirable for clk_set_rate to =0A=
"just work"?=0A=
=0A=
Implementation uses consumer APIs because the constructor takes struct =0A=
clk*. It could be modifed to take struct clk_hw*, but probably only with =
=0A=
larger changes to clk-imx8m.=0A=
=0A=
The interrupt handling should be moved to secure world.=0A=
=0A=
> Hopefully this can=0A=
> work out as some other sort of driver that is used directly from devfreq=
=0A=
> or interconnect core instead and then have a different consumer driver=0A=
> of devfreq or interconnect core that knows how to drive the clk tree.=0A=
=0A=
Hiding dram rate setting behind a clk rate makes it much easier to =0A=
implement devfreq or interconnect, as in this series:=0A=
=0A=
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D139367=
=0A=
=0A=
I sent than RFC after you replied to this email, mostly because it's =0A=
been pending for a while.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
