Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24439186370
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 03:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgCPCv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 22:51:56 -0400
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:6158
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729387AbgCPCv4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 22:51:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxTQXlKo5y/A16QkG4Mrm06hXnCMPGeHdPCuPtJnxh0AM5wI5kobPt1mtERK4/RlKSSMvmYlc+GXhiTzutXSro9Zvou5KDDXF/TU3uyeC8XMIbqGs4kCG9c9sUcjGEcGpe3nIbrWxmsOFry1bGlyAX7x//h/iYFWtQCUbkLeqmGjA4uw4oxR9snG62IiPGJTFzL7+wTPA67BevFtwYsJvgwB8Y88Q6uv0llHXVMf/9c+LF3dUcljKGjs5yIrseo/uINh+AW2WRRxtwwuXuH5Q+87RqSrf/N5rsImwnF154N35zzIck/01n3eBU51MXNNKEFeznnhjckgvhgtNCu18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwlZXbjAkYVUzXP6NN5n4UHDnIJDONemRm9g03ueQwI=;
 b=QH/O1vPrPeJGiz2JDGhDHzmyCkYwwxKd1n1R8w7d4eW8DPmu/eYEiLMtmJ98RlbbINkJSfGsOnzYyn9zgSdnos01eUAbNrKzeCg6I3mkK7wO9MuxJlAf3DfzZZUnQfn+iOEf9SSErNbkWRHewEJettQwQom4Ey0hCis7KR8cSe3OBOydQjz4y1O/hahzBAk+TJBOtsQEPqBcZH9+1We8IlbwHFQTUAXSwmiEL7mpwps0j0utIufTcRavFYp3t0QiPaWNb6+OLnR6T4mByA1LDUcIdtWiKac7dlFvaY8lqIDqxgCELu223ISLtf+NGl2eFvZYoF/TiQpYfHwrPOdOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwlZXbjAkYVUzXP6NN5n4UHDnIJDONemRm9g03ueQwI=;
 b=EnlynJnbe4Y5NwU0CRn4t5WaBjAbkvnwo+oEatOcUjyHOB6ttwPUXyqZnB/vLP6sMlYKL/j1xg/Lo+hdCr55uwj3sL0KdM2JDyp/sX1tJ3zRVEFKplq0EqRT1CwBUpZmOZUBjp223tUf15uGuSSAZI2VQjnttx+jWgrxpGIvS8o=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4434.eurprd04.prod.outlook.com (52.135.145.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Mon, 16 Mar 2020 02:51:48 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 02:51:48 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Topic: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU case
Thread-Index: AQHV9av6lP0y7UryDUCSkdoJ2q6AXKhARRTAgAop3wCAACC+IA==
Date:   Mon, 16 Mar 2020 02:51:47 +0000
Message-ID: <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481F087AC3CDA691300710288FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316005219.GD17221@dragon>
In-Reply-To: <20200316005219.GD17221@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [121.239.103.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 808b5ae8-4eb5-4f58-3b80-08d7c954f8a0
x-ms-traffictypediagnostic: AM0PR04MB4434:|AM0PR04MB4434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB443457A914D259751E2EBBC988F90@AM0PR04MB4434.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(44832011)(4326008)(7696005)(8936002)(8676002)(2906002)(55016002)(45080400002)(81156014)(64756008)(6506007)(66946007)(66446008)(9686003)(5660300002)(81166006)(86362001)(76116006)(66556008)(66476007)(52536014)(54906003)(7416002)(71200400001)(316002)(186003)(33656002)(6916009)(26005)(966005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4434;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ga5+ka3og3smxelogrUwYl8sqD346+bn35d1R7qVc7TVnZMrz9rM+XThxd48o6WlQwLPNtFfvHC8XOEeDX23KUC4TyOB29nG1iMnmcAQisnfbgntSRPlPKGqqaVCe1LICS6qHESO3rpRwCFGSReaza1ZN0+XyBh5o1vX3oV8kgVvESEjc0vTuW2+U8FJ28+AzozmTsP+7yg+hRWvXhwBuJb3o3bpaSwq0ifM1O5fJu/pOkBhIDP/F15S1o6ZHM7LDsFddnoLw47txSXlI6bnhyvE0rsJjYZhaUurtKn0Jfe04JN3XT6gUQmpetERtm2Lvu6mX05zBS3N4n5LDJIGasYQLxO/VX+hQky3X3MRbuptGGD+Nt5HYUpP7kAkZoh4KRZfbQNUUptb6oN6Qn23fysjsc++nNNBiOzDIvTkH6oeNomaH099E5vWKAp6t7pG6gi7q8LkcbyjvGiKDcpdyDzdmqdWhgQjBk5Q5rI7I3fAJAmC7GremUAZx5qIZBrBQueKJnwYDhqVSGJbMPRrtNJ9F8lnv3lOjxneB+1UjiPcc0GHOOtT5K4Debtbu8MdbAh5iyFhUF6XPHf94HzKigmwbt5OQJ7ewOaUiq39BVTGcyItzARqQJPSvy7i9IFW
x-ms-exchange-antispam-messagedata: nv9f26/EN6MyI0Vk+jtwNfxJh3uevP7J3PBnSkcsyuDy6g9FC+y87u6NDVIO+erEf/24O9PWRgLbrYQwUpOLdPpkd6I20SEjrBsuhe8NboUHL2RjyDGtOr3qweDkEODMi2jqlGNLlOt9EE+/cvPPFg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808b5ae8-4eb5-4f58-3b80-08d7c954f8a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 02:51:48.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZiPBvZuAEjAaCBeAt/xM+CdmHtBfgu7mCRH/3DmTPCE3Awxe7xN4O4p4GW9nTJlO7spoqSpWaBliq3xd5Ie3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4434
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU
> case
>=20
> On Mon, Mar 09, 2020 at 01:40:18PM +0000, Peng Fan wrote:
> > > Subject: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU
> > > case
> >
> > I have one patch pending reviewing.
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fpatch%2F11395247%2F&amp;data=3D02%7C01%7Cpeng.f
> an%40n
> >
> xp.com%7C995815002e2b490791e008d7c9445133%7C686ea1d3bc2b4c6fa9
> 2cd99c5c
> >
> 301635%7C0%7C0%7C637199167574579419&amp;sdata=3DRM4Mtwl8LZ3ft9
> 3uL3FQPcHT
> > 9lPHSqBOgugozkcLvag%3D&amp;reserved=3D0
>=20
> I dropped that patch from my queue and picked patch #2 from this series a=
s
> the favor.

I think dropping that patch might cause Linux-next build fail as previously=
 showed,
because IMX_SCU_SOC depends on COMPILE_TEST. If you drop that patch,
also need to drop COMPILE_TEST from IMX_SCU_SOC.

 ld: drivers/soc/imx/soc-imx-scu.o: in function `.imx_scu_soc_probe':
 soc-imx-scu.c:(.text.imx_scu_soc_probe+0x44): undefined reference to=20
`.imx_scu_get_handle'
 ld: soc-imx-scu.c:(.text.imx_scu_soc_probe+0x134): undefined reference=20
 to `.imx_scu_call_rpc'
 ld: soc-imx-scu.c:(.text.imx_scu_soc_probe+0x20c): undefined reference=20
 to `.imx_scu_call_rpc'
=20
 Caused by commit
=20
   68c189e3a93c ("soc: imx: increase build coverage for imx8m soc=20
 driver")

What do you prefer? I personally think dummy functions would be good.

Thanks,
Peng.
>=20
> Shawn
