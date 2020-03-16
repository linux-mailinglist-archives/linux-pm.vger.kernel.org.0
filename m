Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7226E18639D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 04:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgCPDSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 23:18:50 -0400
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:6259
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729513AbgCPDSu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Mar 2020 23:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj1mSliTuLVmiYRtDfdp+LUH2w715J7OE4edPOpW39Xp22wD1bXIeeD0W0/LiuuNrOK3PY88rOwYDh42/QgYQfaUdE0YADhHwilbarwaZpQUysu3m2X3LRSKYFcXqPQYzXdb6pFs90PrUdaeonQXxMzn8B8CNeCV0U3mhhK5ie7GLZ/7xbYdeM/MxGyAQgnlrXP7XmsRHs3fZebY7jnrpUtvGi0yohBFMGmKU0X471S6OG5ZzANUHsbFIUAetKEpKCnSE0PJ05vFsISx+5gob0A2dvCFO33KgDG5YICObExl2h1Eq3R/c6o8Pjuec4MQynaQTqNdY6BOLabfo6xgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TahVAyBCJPLtZmEHYqzD5raKzU7F/TiG/rDAo4s/h4Y=;
 b=k2si+/UxbzsXgpxitS1JhU6m5ikA5eWBwiPnsik5jKviHVgjoZL3leVUAHq2KhWJDh6kV9TqXNdepo8+AWIuM0hVUH1X2+AJy8vkrPVNl1kXSwh2Wx2PCrOSIFqaH9qMCj5jjOCfY4pZfmxvwdHduKqRQSdX0KBAAG4Z5PTGiWaNlqRwYTOyYgflYzNp60bPEq5/9n9taYr5u5jbaGbvK+VvumnTmhBadyKH+fHqeVpU8tJ6OIPqd8ygWq2z0Fzbh+lsfwBkCUUChsadDD/8Kydh9vb3uVgGm+U5ZIy8cpZzdsKlKbWc2sxDfGi3LgkEPtzdj1eTIMz7h30XAWHfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TahVAyBCJPLtZmEHYqzD5raKzU7F/TiG/rDAo4s/h4Y=;
 b=hIGUPv4PBCI8THgjXlEEI/t9DKggGPCTDxiJy/WMk8YEcBLiq9uEqN+6TBHs0ihVmhLI+LbVI7qLHZmCGGbnNq4S7yeSglXa9eBWqYJ2vLskPQPY6JpFf7b2voXHsq4pGDe0aUIn4Fv8mVXFHnQiir0Z7pz1weq6SrPzV0+9NUY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4225.eurprd04.prod.outlook.com (52.134.91.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Mon, 16 Mar 2020 03:18:44 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 03:18:44 +0000
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
Thread-Index: AQHV9av6lP0y7UryDUCSkdoJ2q6AXKhARRTAgAop3wCAACC+IIAABReAgAACi8A=
Date:   Mon, 16 Mar 2020 03:18:43 +0000
Message-ID: <AM0PR04MB44817A48746601EADA4E06BC88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583714300-19085-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481F087AC3CDA691300710288FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316005219.GD17221@dragon>
 <AM0PR04MB44819E4A9E027F1555C33D0B88F90@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200316030744.GC17221@dragon>
In-Reply-To: <20200316030744.GC17221@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [121.239.103.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3079320c-af88-4163-89cd-08d7c958bbe0
x-ms-traffictypediagnostic: AM0PR04MB4225:|AM0PR04MB4225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB42259DF9930304848B8C219B88F90@AM0PR04MB4225.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(199004)(2906002)(33656002)(45080400002)(4326008)(966005)(7416002)(66946007)(478600001)(6916009)(86362001)(66556008)(66476007)(76116006)(64756008)(66446008)(26005)(316002)(6506007)(186003)(54906003)(5660300002)(7696005)(8936002)(9686003)(55016002)(71200400001)(8676002)(81166006)(52536014)(81156014)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4225;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhszBBbK78BO3V+mcm3R2DagCS9i8Eg7HQUhYe0sD67IsCkxp+bq2mmww1d0faekn38Oa0JW64Eb4/0iyA2dCO7rUY+/antncpcggZWkwHZnu4FW52VKrS28+CMar7nq2/0mTuK7WksB+ht1qgdFEY6FT8ZX6H2rUS/Q0wysoWfkzi/aEGx9lBYXQhIPbm9pQ739bED3hEYBkY03M+PMrCQRd+IiuK0RSDFr4dBJ7U3dAjUVgACW07FJJlwjni+MmrGIqijNau8yln229t6ZrFVytxANS1TZ1PTTGQQlo94VqGlouG+yiSdYzFm6HHQpUOfSdx/J0VNnfQQCaCTElg/bxdtKnKgenJuDL9SJXyKwHoLhnnzl8GE7kdkC8i7WDS9todOye7sDfFnQm1S0bwmUurMrUWRq9YCtisDZb9wzlZgU9GA5kzdIADGs3ZlGV2+excsb0zu44u5LwXGrjhjGl/n7v1YWuzkylPBRmAwNcG+SVBsZGQAqThGnwcR8D6iQLlQvTrc+dDuBHldCfS00Ug/cLm4xgn5Ln0/xzeOUvfmL+w8ZzqrEBI5DSfjxoxvH/xzDoaaTd256K755XQ==
x-ms-exchange-antispam-messagedata: keGqj13UOWaWwY1/m4PZxDB1TRNoLa1JIvLWJmAn5Dyui1SI9PiV7XY/W6LeK+gXimN0BzoI7pNkUOt1mTEUA9/iA3tl83V7DL77jr0/YIbiLcG5Elpe4ihA5+ONSVpuhN8niW0cP1ngy9JJKYbgQw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3079320c-af88-4163-89cd-08d7c958bbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 03:18:44.0945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBBVTlbzTHJ3ZBYP/jlTyO5iM9iLqITQVLPKka5eyc7gPbBO8b+5iMM6Nx/Ec27Ivm/vgwGMKgNnsqM+ryDJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4225
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for !CONFIG_IMX_SCU
> case
>=20
> On Mon, Mar 16, 2020 at 02:51:47AM +0000, Peng Fan wrote:
> > Hi Shawn,
> >
> > > Subject: Re: [PATCH V3 1/7] firmware: imx: Add stubs for
> > > !CONFIG_IMX_SCU case
> > >
> > > On Mon, Mar 09, 2020 at 01:40:18PM +0000, Peng Fan wrote:
> > > > > Subject: [PATCH V3 1/7] firmware: imx: Add stubs for
> > > > > !CONFIG_IMX_SCU case
> > > >
> > > > I have one patch pending reviewing.
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > patc
> > > >
> > >
> hwork.kernel.org%2Fpatch%2F11395247%2F&amp;data=3D02%7C01%7Cpeng.f
> > > an%40n
> > > >
> > >
> xp.com%7C995815002e2b490791e008d7c9445133%7C686ea1d3bc2b4c6fa9
> > > 2cd99c5c
> > > >
> > >
> 301635%7C0%7C0%7C637199167574579419&amp;sdata=3DRM4Mtwl8LZ3ft9
> > > 3uL3FQPcHT
> > > > 9lPHSqBOgugozkcLvag%3D&amp;reserved=3D0
> > >
> > > I dropped that patch from my queue and picked patch #2 from this
> > > series as the favor.
> >
> > I think dropping that patch might cause Linux-next build fail as
> > previously showed, because IMX_SCU_SOC depends on COMPILE_TEST. If
> you
> > drop that patch, also need to drop COMPILE_TEST from IMX_SCU_SOC.
> >
> >  ld: drivers/soc/imx/soc-imx-scu.o: in function `.imx_scu_soc_probe':
> >  soc-imx-scu.c:(.text.imx_scu_soc_probe+0x44): undefined reference to
> > `.imx_scu_get_handle'
> >  ld: soc-imx-scu.c:(.text.imx_scu_soc_probe+0x134): undefined
> > reference  to `.imx_scu_call_rpc'
> >  ld: soc-imx-scu.c:(.text.imx_scu_soc_probe+0x20c): undefined
> > reference  to `.imx_scu_call_rpc'
> >
> >  Caused by commit
> >
> >    68c189e3a93c ("soc: imx: increase build coverage for imx8m soc
> >  driver")
> >
> > What do you prefer? I personally think dummy functions would be good.
>=20
> I would rather drop COMPILE_TEST from IMX_SCU_SOC.  Could you send a
> patch for that shortly?

Just sent out. One more thing, I think all drivers depends on IMX_SCU shoul=
d not
have COMPILE_TEST if we plan not to add dummy functions. I see you picked u=
p
Anson's patch in imx/drivers branch, please check more.

Thanks,
Peng.

>=20
> Shawn
