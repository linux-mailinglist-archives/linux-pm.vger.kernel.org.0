Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F874458021
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 20:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhKTTms (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 14:42:48 -0500
Received: from mail-tycjpn01on2114.outbound.protection.outlook.com ([40.107.114.114]:20865
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhKTTms (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Nov 2021 14:42:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA2skl6BIkEr/eyPe+mIRqe5cW6dRUAOdGxVDEfRi65aTmVjMwdcAyw3c+fLYHdPBxhs+nEQWKn3uGO4PZZMGe1a1oPmHUSx/RqG23CBgHS6y4g5mNNNF6lLwh+ulID8SxQw91Gl40O3xmZXVoSkqsjkUwKVhf5CwzY/maF8JAwWI5iH1fTCaHTJ0hzkvOLXc8JLIt48GlCQFr96VQ33kIsbSM2UtqDlAgGOo2RUvzQfNdHccnBUOTz0b4wxmEuCeQ1a6tV4wbOWyofK4rlZ/T1GKv6/lGdUbNOfTnxyAbGzBfPJV6nJzObYb2C5gZKJQCfmY73R/32mUmiIdVyBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7T+BBrH1HOx+XAPQIU1QVOOcSJqGFPywbeZ4yww7LE=;
 b=iHWhVq9/sS/Mv2DmYWMY2pfWE+M1yqzOB2Jcwf6r7p5uQIwIeEasnGXwDC+tT9eZFZY8FC+0GmC6+ul6yDcrHMSuNybB3A2XMDXCi5t81JrQF5mvBvqc3RptXMXgQxwbIbSuFxjcBQzpsvgU6K6bH93mXz1OhD+Tv8uuGqQjV/gbo+kn+yWL/iLwONE7jUupOmqnU7wqvlzgTCSNwyIuH1tbTnl7VfsrMuOZE0JRkOpZHfPM0SmImzIZGaLglWPrtvtjIPy2hsIYHG57RXxdir87Fkabx258eJtfwVGMS1nEFBTbFq14fsPAFmRR46iva16w0jkM9FjGcUZsosyGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7T+BBrH1HOx+XAPQIU1QVOOcSJqGFPywbeZ4yww7LE=;
 b=SqKkoXR/D6ehDNWlaC4o2tiziVFXLkRelfOQFkFU2xewJMCO9kQVxzUGkDTYOBT80guW9lxP142Gb+nsJtv0IS2UKFfr3cKWM+au3SS18ws4bnd2GvyGHhaJYKD/WoNBr+w6bm+SlQYR9loZFiMktgHT6b05KrjRYcD9xbgx+UE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB1873.jpnprd01.prod.outlook.com (2603:1096:603:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sat, 20 Nov
 2021 19:39:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%9]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 19:39:40 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Niklas_S=F6derlund?= <niklas.soderlund@ragnatech.se>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
Thread-Topic: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
Thread-Index: AQHX2v0oE66oWNNWJkWwQPaKhKKvwqwHZ6gAgAVFWZCAAClt8A==
Date:   Sat, 20 Nov 2021 19:39:40 +0000
Message-ID: <OS0PR01MB5922EAA9D23FBDBF9E48CCF2869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20211116151750.24857-1-biju.das.jz@bp.renesas.com>
 <20211116151750.24857-4-biju.das.jz@bp.renesas.com>
 <YZTAEIv2AcURBA1Q@oden.dyn.berto.se>
 <OS0PR01MB5922C3499601771A882451D7869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922C3499601771A882451D7869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c7ef6dd-071b-4163-61e6-08d9ac5d7e9b
x-ms-traffictypediagnostic: OSAPR01MB1873:
x-microsoft-antispam-prvs: <OSAPR01MB18737B60F390B41E1FF0FDDD869D9@OSAPR01MB1873.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L/zCIsSlg7aS7OKwvfHslnXbFVoMCxcXjbZMTXOEm68+ox2f0930lnvlJz75MhUdMIzPotnLxsi/kyuhcwYL9J3nR+NL8QbMMvj+L4Ic8Q/wUMtsqKVt43/4JRCZcU5VX1N6YrpVprzfGRsm2ExStcurmDGO7zuODisxgpVBd7NZkBK6gMANR+WLt5WCvc5bRfjrVmQA+8PDIcXJ2L7zCV/rlBImufg8FHCoeh3luvwiCxGnMojWEsO/MTOyJE+NXqQmFT2sOgTwcxpTq0BVZnPmzMCUh2HaOQ74oHtH1Ec8BQiBmcM5/5YwsQmr16nlGjWEdPxIe4Dhp5HlEUkyIuS1G1jNFlMWPm079d+5bBkGZrsrd2twuHF7DqBf+26uC2qwvmEvCKgqQLZoI5AdcsUKP7Lt3uTGQMzT9B1y/KyOkSA0/TjvnH+bs1SAF9pBN8Tt35iNC+eAQchelxzhl+VQ899TLJ/kMeMpvWwsYoxoDHA0EuMlnUgbz+3T3flpk8+tsSLm+JI97eREx6EjeMxoZOfhfseEDNSxfrLPJyrfJu955wzz4a8la9FivGS2QRj+vjhfUVbIY248IvtNQzHOR4GdjesITp3ChSyk1bOH75d+TxKL3og5velWJ9C3voa4Sh3nFyb7mKLAUmqOoUtBkC0VKdgH0c8pVSBjD4jtcBhFwlAMJAw+8PGcVsKnPLJOTWKNxV6Nlua8i2o4AXC3MktHv6TSDSnlKniBFgTkxjt1IbnrillrKL3RgWTR+2hz8Y0VNTM1Qn9Dba+p6QtHoV2XA0K9y3QrwB+h0Bw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6916009)(76116006)(66446008)(83380400001)(966005)(38070700005)(122000001)(55016002)(5660300002)(33656002)(9686003)(52536014)(4001150100001)(66946007)(66476007)(66556008)(64756008)(66574015)(2940100002)(30864003)(86362001)(186003)(26005)(8676002)(4326008)(7696005)(2906002)(316002)(6506007)(53546011)(8936002)(71200400001)(54906003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OVCxT4SPNLqQjV6lzdcj0toGXOYJjzo6pLPSBLT+rffWE0IVJAOhA55pSF?=
 =?iso-8859-1?Q?U5EHg2YUxAr2wrYHDhU1isjwfyscQsOOl8TlZKT2xCtwsZi2da90PZUp0f?=
 =?iso-8859-1?Q?N6Vg7e3vcOiRIAdl6H/UMTwtu0aNcAtZn0ppygTPN8z9n3CKRinBWqoCyo?=
 =?iso-8859-1?Q?JyaoN+yjEOXSIzlJ8SmKYhFhartVNGKPQDkIsDjQeu8TAxVgoYnnVVfNs8?=
 =?iso-8859-1?Q?K1vBfuOjZzpqwEsQdnHLvBw3riQDzvNolcxfzgnIHwZ2Xa0UqiXbJWWq28?=
 =?iso-8859-1?Q?GMd1+7AVpet5XUxzp07dEGTbQ4hHmdfMxQSnBgRgBl5H/HDjWS167oOYR9?=
 =?iso-8859-1?Q?O6aVU6jjPmKDbmFqt/Xpi1cPNiy1NsBtqL65/ejVzeIuJ0aWfH4QWDmobT?=
 =?iso-8859-1?Q?Z6+9nKz0mrAHZl+njv2cPQG6HCgmCEtkohu0FsxZYSni2QztH0thMSli8m?=
 =?iso-8859-1?Q?vaG/dG3MmuEkL3/RQJl2rN1pJxiwU61mIgrHceFbs0GKSgRNSs/ffz5KAt?=
 =?iso-8859-1?Q?KuS/QRBQHZgHYhrccRk18bbVuNE09llp5tRTBUhp9jHcIddgXGM+8ix4BQ?=
 =?iso-8859-1?Q?mzicKFEUUxMELAy4UafolEIV+9Z4Svu1r2QKUS6hjJ6j51prPP2Mw36k9r?=
 =?iso-8859-1?Q?Nsq2GIX1jcyuPbgamtKMWKRwIXfYhb4P9FJtJWisQHfQGJaXoZVDBg/ejT?=
 =?iso-8859-1?Q?c3k0VWkSw+WRjVLJf15201KHQ0VA+nGUMOv+eX0iP1GmcDyCA2hh96eu2g?=
 =?iso-8859-1?Q?H+ozbRMErI82aYz6+Yuh/I5g8m8/evisW4y9IbKGsGgoAOL1QizMtRaRON?=
 =?iso-8859-1?Q?KCPlZvMMaojGqz3UvGjcS7C7MTUarDBrZY3rXHOhOtl4YbdgXX2Mt0yKdL?=
 =?iso-8859-1?Q?8PJkRX9XgjVm+L8s88LHHdRTGi6D2LNylG++YEito40XizM96gVEGTeGdP?=
 =?iso-8859-1?Q?LoYdEvNKzmAryrxjWBec36fg+YDWSexhrSsM5Wqit7ZqoJK+SNtdaydvAM?=
 =?iso-8859-1?Q?2XPT1Q2Pg/GH4tWrCMdcTIPBziMwe2o0b3tUmb/wWkgK6W2UXx/YXVK2BD?=
 =?iso-8859-1?Q?+d3cso4dwNcd+Mb00mcvbhCPq+sDMGgW5o0AuJ3OatLJM3vDqk9oe3NNxc?=
 =?iso-8859-1?Q?T495wDr+1eYDembjv9ed2JhRoxZRiNlL1S3ePiRa3PuEGBr3nmaRngrkSW?=
 =?iso-8859-1?Q?+OoKp1dA37FKevitJW7gvHNdbGZyfoUAIzkGeOjOjtEOZo+9+ZnJp0qwUC?=
 =?iso-8859-1?Q?V+ESUfoTHXG/YgmSUp6jsTrqFJluKjD/3beY4uCYCvihcFcoFIvPcAqmFD?=
 =?iso-8859-1?Q?+ECib0CbbARYsqMWwRfUePJp0VhGfIgiTDXVDXWjg1kPEg/Zj6LAnwAD0K?=
 =?iso-8859-1?Q?wpI72wfx5klET5i01bCJHesgtsljlODLp0Z6XUI5D0Hhucp6ftbZvT+u/j?=
 =?iso-8859-1?Q?9fr9raVMGPZA7FbboeYy605xWykBsBBNxCPEqlNa1IHWWxtNN7V7ywD8dd?=
 =?iso-8859-1?Q?a/nuvGwS+5I+W039u/PgrJXBb3AFl3Sa8nsKIRQ4VuxQgtI+fsRf19EQWw?=
 =?iso-8859-1?Q?DHkywYLrictzLucw3evSvzbQCb5KRnwCaD3SCBqRmDJQIL18tK+uP9g5hZ?=
 =?iso-8859-1?Q?N5S0xToTVtjhrSK5gXSZCGrrVcDvXyI1S/WLch4OgtGtTOfZ+Hy6yZXIW/?=
 =?iso-8859-1?Q?fcxAKHkc3KuMeA6HliTLnPNlmNkB16DNRkCIlekIwE1DU8KIAQgJdsDf1g?=
 =?iso-8859-1?Q?oehA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7ef6dd-071b-4163-61e6-08d9ac5d7e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2021 19:39:40.1870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xC/8pIi7lStYr/BlK61GQy3Hfy/w+/+1MIvxwyETyh561UN6VVvOnZ8d24zp9864UIbdMktwg9mekGrlN77GRnaTyNgRXadsXRfmW6m5tvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1873
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Biju Das
> Sent: 20 November 2021 17:21
> To: 'Niklas S=F6derlund' <niklas.soderlund@ragnatech.se>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>; Rafael J. Wysocki
> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Amit
> Kucheria <amitk@kernel.org>; Zhang Rui <rui.zhang@intel.com>; linux-
> pm@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: RE: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
>=20
> Hi Niklas,
>=20
> > -----Original Message-----
> > From: Niklas S=F6derlund <niklas.soderlund@ragnatech.se>
> > Sent: 17 November 2021 08:41
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>; Rafael J. Wysocki
> > <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Amit
> > Kucheria <amitk@kernel.org>; Zhang Rui <rui.zhang@intel.com>; linux-
> > pm@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>;
> > Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> > <biju.das@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> > Subject: Re: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
> >
> > HI Biju,
> >
> > Thanks for your work.
> >
> > On 2021-11-16 15:17:48 +0000, Biju Das wrote:
> > > Add Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  drivers/thermal/Kconfig         |   9 ++
> > >  drivers/thermal/Makefile        |   1 +
> > >  drivers/thermal/rzg2l_thermal.c | 239
> > > ++++++++++++++++++++++++++++++++
> > >  3 files changed, 249 insertions(+)
> > >  create mode 100644 drivers/thermal/rzg2l_thermal.c
> > >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig index
> > > d7f44deab5b1..e37691e0bf20 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -354,6 +354,15 @@ config RCAR_GEN3_THERMAL
> > >  	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor
> > > driver
> > into
> > >  	  the Linux thermal framework.
> > >
> > > +config RZG2L_THERMAL
> > > +	tristate "Renesas RZ/G2L thermal driver"
> > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > +	depends on HAS_IOMEM
> > > +	depends on OF
> > > +	help
> > > +	  Enable this to plug the RZ/G2L thermal sensor driver into the
> > Linux
> > > +	  thermal framework.
> > > +
> > >  config KIRKWOOD_THERMAL
> > >  	tristate "Temperature sensor on Marvell Kirkwood SoCs"
> > >  	depends on MACH_KIRKWOOD || COMPILE_TEST diff --git
> > > a/drivers/thermal/Makefile b/drivers/thermal/Makefile index
> > > 82fc3e616e54..f0c36a1530d5 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -37,6 +37,7 @@ obj-$(CONFIG_SUN8I_THERMAL)     +=3D sun8i_thermal.=
o
> > >  obj-$(CONFIG_ROCKCHIP_THERMAL)	+=3D rockchip_thermal.o
> > >  obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
> > >  obj-$(CONFIG_RCAR_GEN3_THERMAL)	+=3D rcar_gen3_thermal.o
> > > +obj-$(CONFIG_RZG2L_THERMAL)	+=3D rzg2l_thermal.o
> > >  obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
> > >  obj-y				+=3D samsung/
> > >  obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
> > > diff --git a/drivers/thermal/rzg2l_thermal.c
> > > b/drivers/thermal/rzg2l_thermal.c new file mode 100644 index
> > > 000000000000..e551355cd4f6
> > > --- /dev/null
> > > +++ b/drivers/thermal/rzg2l_thermal.c
> > > @@ -0,0 +1,239 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Renesas RZ/G2L TSU Thermal Sensor Driver
> > > + *
> > > + * Copyright (C) 2021 Renesas Electronics Corporation  */ #include
> > > +<linux/delay.h> #include <linux/err.h> #include <linux/io.h>
> > > +#include <linux/iopoll.h> #include <linux/module.h> #include
> > > +<linux/of_device.h> #include <linux/platform_device.h> #include
> > > +<linux/pm_runtime.h> #include <linux/reset.h> #include
> > > +<linux/thermal.h>
> > > +
> > > +#include "thermal_hwmon.h"
> > > +
> > > +#define CTEMP_MASK	0xFFF
> > > +
> > > +/* default calibration values, if FUSE values are missing */
> > > +#define SW_CALIB0_VAL	3148
> > > +#define SW_CALIB1_VAL	503
> > > +
> > > +/* Register offsets */
> > > +#define TSU_SM		0x00
> > > +#define TSU_ST		0x04
> > > +#define TSU_SAD		0x0C
> > > +#define TSU_SS		0x10
> > > +
> > > +#define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
> > > +
> > > +/* Sensor Mode Register(TSU_SM) */
> > > +#define TSU_SM_EN_TS		BIT(0)
> > > +#define TSU_SM_ADC_EN_TS	BIT(1)
> > > +#define TSU_SM_NORMAL_MODE	(TSU_SM_EN_TS | TSU_SM_ADC_EN_TS)
> > > +
> > > +/* TSU_ST bits */
> > > +#define TSU_ST_START		BIT(0)
> > > +
> > > +#define TSU_SS_CONV_RUNNING	BIT(0)
> > > +
> > > +#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
> > > +#define MCELSIUS(temp)		((temp) * 1000)
> > > +#define TS_CODE_CAP_TIMES	8	/* Capture  times */
> > > +#define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
> > > +
> > > +#define RZG2L_TSU_SS_TIMEOUT_US	1000
> > > +
> > > +struct rzg2l_thermal_priv {
> > > +	struct device *dev;
> > > +	void __iomem *base;
> > > +	struct thermal_zone_device *zone;
> > > +	struct reset_control *rstc;
> > > +	u32 calib0, calib1;
> > > +};
> > > +
> > > +static inline u32 rzg2l_thermal_read(struct rzg2l_thermal_priv
> > > +*priv,
> > > +u32 reg) {
> > > +	return ioread32(priv->base + reg); }
> > > +
> > > +static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv
> > > +*priv,
> > u32 reg,
> > > +				       u32 data)
> > > +{
> > > +	iowrite32(data, priv->base + reg); }
> > > +
> > > +static int rzg2l_thermal_round(int temp) {
> > > +	int result, round_offs;
> > > +
> > > +	round_offs =3D temp >=3D 0 ? RZG2L_THERMAL_GRAN / 2 : -
> > RZG2L_THERMAL_GRAN / 2;
> > > +	result =3D (temp + round_offs) / RZG2L_THERMAL_GRAN;
> > > +
> > > +	return result * RZG2L_THERMAL_GRAN; }
> > > +
> > > +static int rzg2l_thermal_get_temp(void *devdata, int *temp) {
> > > +	struct rzg2l_thermal_priv *priv =3D devdata;
> > > +	u32 result, dsensor, ts_code_ave;
> > > +	int val, i;
> > > +
> > > +	result =3D 0;
> > > +	/*  Read the ADC value 8 times with an interval of 20 microsecs */
> > > +	for (i =3D 0; i < TS_CODE_CAP_TIMES ; i++) {
> > > +		result +=3D rzg2l_thermal_read(priv, TSU_SAD) & CTEMP_MASK;
> > > +		usleep_range(20, 30);
> > > +	}
> > > +
> > > +	/* Calculate the average value */
> > > +	ts_code_ave =3D result / TS_CODE_CAP_TIMES;
> > > +
> > > +	/* Curvature correction */
> > > +	dsensor =3D TS_CODE_AVE_SCALE(ts_code_ave) /
> > > +		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * 13));
> > > +
> > > +	/* Temperature calculation */
> > > +	val =3D ((dsensor - priv->calib1) * (MCELSIUS(165) /
> > > +		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
> > > +
> > > +	/* Round value to device granularity setting */
> > > +	*temp =3D rzg2l_thermal_round(val);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops =3D {
> > > +	.get_temp =3D rzg2l_thermal_get_temp, };
> > > +
> > > +static int rzg2l_thermal_init(struct rzg2l_thermal_priv *priv) {
> > > +	u32 reg_val;
> > > +
> > > +	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
> > > +	rzg2l_thermal_write(priv, TSU_ST, 0);
> > > +
> > > +	/* Before setting START bit, Wait for 60 =B5s */
> > > +	usleep_range(60, 80);
> > > +
> > > +	reg_val =3D rzg2l_thermal_read(priv, TSU_ST);
> > > +	reg_val |=3D TSU_ST_START;
> > > +	rzg2l_thermal_write(priv, TSU_ST, reg_val);
> > > +
> > > +	return readl_poll_timeout(priv->base + TSU_SS, reg_val,
> > > +				  reg_val =3D=3D TSU_SS_CONV_RUNNING, 50,
> > > +				  RZG2L_TSU_SS_TIMEOUT_US);
> > > +}
> > > +
> > > +static int rzg2l_thermal_remove(struct platform_device *pdev) {
> > > +	struct rzg2l_thermal_priv *priv =3D dev_get_drvdata(&pdev->dev);
> > > +
> > > +	pm_runtime_put(&pdev->dev);
> > > +	pm_runtime_disable(&pdev->dev);
> > > +	reset_control_assert(priv->rstc);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void rzg2l_hwmon_action(void *data) {
> > > +	struct thermal_zone_device *zone =3D data;
> > > +
> > > +	thermal_remove_hwmon_sysfs(zone);
> > > +}
> > > +
> > > +static int rzg2l_thermal_probe(struct platform_device *pdev) {
> > > +	struct thermal_zone_device *zone;
> > > +	struct rzg2l_thermal_priv *priv;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	int ret;
> > > +
> > > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(priv->base))
> > > +		return PTR_ERR(priv->base);
> > > +
> > > +	priv->dev =3D dev;
> > > +	priv->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > > +	if (IS_ERR(priv->rstc))
> > > +		return dev_err_probe(dev, PTR_ERR(priv->rstc),
> > > +				     "failed to get cpg reset");
> > > +
> > > +	reset_control_deassert(priv->rstc);
> > > +
> > > +	pm_runtime_enable(dev);
> > > +	pm_runtime_get_sync(dev);
> > > +
> > > +	priv->calib0 =3D rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
> > > +	if (!priv->calib0)
> > > +		priv->calib0 =3D SW_CALIB0_VAL;
> > > +
> > > +	priv->calib1 =3D rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
> > > +	if (!priv->calib1)
> > > +		priv->calib1 =3D SW_CALIB1_VAL;
> > > +
> > > +	platform_set_drvdata(pdev, priv);
> > > +	ret =3D rzg2l_thermal_init(priv);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to start TSU");
> > > +		goto error_unregister;
> > > +	}
> > > +
> > > +	zone =3D devm_thermal_zone_of_sensor_register(dev, 0, priv,
> > > +						    &rzg2l_tz_of_ops);
> > > +	if (IS_ERR(zone)) {
> > > +		dev_err(dev, "Can't register thermal zone");
> > > +		ret =3D PTR_ERR(zone);
> > > +		goto error_unregister;
> > > +	}
> > > +
> > > +	priv->zone =3D zone;
> > > +	priv->zone->tzp->no_hwmon =3D false;
> > > +	ret =3D thermal_add_hwmon_sysfs(priv->zone);
> > > +	if (ret)
> > > +		goto error_unregister;
> > > +
> > > +	ret =3D devm_add_action_or_reset(dev, rzg2l_hwmon_action, zone);
> > > +	if (ret)
> > > +		goto error_unregister;
> >
>=20
> > This driver only uses one zone would it be worth considering calling
> > thermal_remove_hwmon_sysfs() directly from rzg2l_thermal_remove()?
>=20
> In fact this is correct.
>=20
> > Compare then Renesas Gen2 and Gen3 drivers. Where Gen3 uses devres to
> > make it easier to deal with more then one zone wile Gen2 calls it
> > directly from its remove function.
>=20
> If you see rcar-thermal.c there are unregister path (goto
> error_unregister) Where we call thermal_remove_hwmon_sysfs without adding
> hwmon_sys
>=20
> See [1]
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/thermal/rcar_therm=
a
> l.c#L561
>=20
> For any error upto L561, any unregister blindly calls
> thermal_remove_hwmon_sysfs, Which is wrong.

Oops, I am wrong, remove function is taking care.
Sorry for the noise.

Regards,
Biju

>=20
> >
> > > +
> > > +	dev_info(dev, "TSU probed with %s caliberation values",
> > > +		 rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
> > > +
> > > +	return 0;
> > > +
> > > +error_unregister:
> > > +	rzg2l_thermal_remove(pdev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static const struct of_device_id rzg2l_thermal_dt_ids[] =3D {
> > > +	{ .compatible =3D "renesas,rzg2l-tsu", },
> > > +	{ /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, rzg2l_thermal_dt_ids);
> > > +
> > > +static struct platform_driver rzg2l_thermal_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "rzg2l_thermal",
> > > +		.of_match_table =3D rzg2l_thermal_dt_ids,
> > > +	},
> > > +	.probe =3D rzg2l_thermal_probe,
> > > +	.remove =3D rzg2l_thermal_remove,
> > > +};
> > > +module_platform_driver(rzg2l_thermal_driver);
> > > +
> > > +MODULE_DESCRIPTION("Renesas RZ/G2L TSU Thermal Sensor Driver");
> > > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.17.1
> > >
> >
> > --
> > Kind Regards,
> > Niklas S=F6derlund
