Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0445430C
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 09:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhKQI6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 03:58:23 -0500
Received: from mail-tycjpn01on2105.outbound.protection.outlook.com ([40.107.114.105]:10117
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234756AbhKQI6T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Nov 2021 03:58:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQrszR00sLERafqIZdXul+uFm1q1/MLFiwCEgHV0JUhz5Ai1KS0+RanUKqFVDIQKajk8JQbwQs/9C2iBGKhabHtCXTIyytMv7ZfnInZjzZ00s4P/DukmwNIOWK94H/gpEwiup57cOKKV/Jw5BJ8xgqTVkjpsC0e2QKNytYM32f4nga4DK/tJDgclssze1CNKxJpApTeK2CXu1PY6r0lXUvJZ6ZBCuZnD1hfXsFmcpIYyk+tjv4TBI3/+V0BT+5WC4LFbWkM9j5lWAqZDpzMNuaJoMjkYbN+3d2kocQUmWz0vFGeNSDbogIety8xSNJlbWU3c8kI2fi+xm/aGRxzk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nlZn68foMp2uRb4DH4BgRnCCryoIhDthOI3wjAZ4b4=;
 b=TziDxl/uB4q9x2mAmyg0j1mPxfSQjzcys7CJ18qaFNyFmTyRac+911sBxrHjwCgsKpXjzbf3b1DqJV74sRUixAA/gXlhpoD6ryVgur55Xl+79JiGj477GiQzs8cU9RZ8+NARbSScG0XW0cqzPp+wG0YzxrmcwCQ8v0zQ2FWORMGbH/vOcfNnpI71zsT/x6BaPG1FUazOhqWqk44oLPMP4tLZOBSJC1snIzdx9BIXzVO8GbZewVuoFgWKIdm3TCzPwnSHGZ6+b/SNDB3/NWpN82TwPc8WxJnYwYXJly+BT2NupRLRy5iW2eYIYyvTnTq2y5G8ji7h+rEZ6SI7GyKX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nlZn68foMp2uRb4DH4BgRnCCryoIhDthOI3wjAZ4b4=;
 b=Js5kN4KFc8M9YUeuyqKn3ImXVfNTg3TQ8RWRRPRe+LfYDvOagHThYra3GPAtH1A1GdU2kzI8YkxD/UHVcJq/qHz5EBTP0nf4Jj5VKI69XMQulssOFwZEdrBFnTNl9hgA8RjA1s4L0xWniWr/HLXCURAiCAvIYvx/Uc6nA9SYwdM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB4625.jpnprd01.prod.outlook.com (2603:1096:604:69::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Wed, 17 Nov
 2021 08:55:15 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%8]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 08:55:15 +0000
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
Thread-Index: AQHX2v0oE66oWNNWJkWwQPaKhKKvwqwHZ6gAgAABsSA=
Date:   Wed, 17 Nov 2021 08:55:15 +0000
Message-ID: <OS0PR01MB5922E694037C0A488BF6F5D3869A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20211116151750.24857-1-biju.das.jz@bp.renesas.com>
 <20211116151750.24857-4-biju.das.jz@bp.renesas.com>
 <YZTAEIv2AcURBA1Q@oden.dyn.berto.se>
In-Reply-To: <YZTAEIv2AcURBA1Q@oden.dyn.berto.se>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62705320-f88a-4291-f4f9-08d9a9a7f90f
x-ms-traffictypediagnostic: OSAPR01MB4625:
x-microsoft-antispam-prvs: <OSAPR01MB462515743BA8121A57115CAA869A9@OSAPR01MB4625.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImaFb4NeedQ1I6L1tViFAYTM/7KMWmSUrR+Hn+Y/bzu9lZlDxjdmR/Hl4IgBXQyE8Wp2tkg1FSuMm3OXr6QsOK8cuq79s9vekFoLwH8Yni03hjwNMX0Mt07T155b0bIjWkcowQHMYiD3xxbXig/XTQpKda/iFtw7OA8AKXibXHNBlXVl9PuSi6eYK9vbr8KVrCtLdYs9CdgQHPBp+fxz9AgbRK5MKyfX1M3akrG/7E6aofkoBOiIL32aIP2br6SfP14OgbHtXaC4xcJH5wi1oBl9BnBSNm+JKOh5nDFtuWo02Xzk8vRAnVTc/+zuIrDGSGJfVikaXMll3NRdhOwpNzDNOR+ueD5tzKDAESla1/gSxy34t3VDMCtEjHmGCRIjrnWStpB+Vb/JS6QYNq+ve+Mq0mfuYU64TppNiHR0IlqJmUbjysI4vAAG7/Q/RBMD+RRQ7x5Q7L+6tYMV29XwYUgbdrCUhQQnM3Hv66+jIlzpcl0XsJ/cVlbcEpGWVZeO5rUan7IXHNZkZKgIdrOiWEu+TDR3wQgUT2gDLXTOzBf0lij67TamsVtKfJ1iw6Rxbgf6gD/iAIuT0UJcGduNLP+wcmGNHN30r5+FyNvVychzwg4usyju0Iaj09IMptJ/BVr2VVL4DQlN5ri1FfJ7sEbiOVHqAed30rWMeL/ASL0VYSdIrrYTDOPlI0NvV0ujmP/xP7FSKBrwjCjx/owkkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(2906002)(8936002)(508600001)(66476007)(7696005)(71200400001)(122000001)(316002)(38100700002)(54906003)(186003)(55016002)(9686003)(26005)(6916009)(33656002)(66556008)(66946007)(4326008)(66446008)(53546011)(64756008)(4001150100001)(52536014)(76116006)(38070700005)(86362001)(5660300002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hni+3n0O7E36PewMjrJt/qH6Qzn+Wfm6i4YYB6pkrXmz0KKGjnvO4Q4mQV?=
 =?iso-8859-1?Q?twBMFqWaxGA8v4tO4iTSBzFA4gIKFxZbI6Z8Rfzrp0FcW/3PcJSAVpWWzf?=
 =?iso-8859-1?Q?7IzT/ColCXaNFojSnJ/arbESlPagQ0OluSHupVdhLKWq4jPR/QTmFQCf1P?=
 =?iso-8859-1?Q?OGwIAMYP2XhHOl3l6cKcDnt2Qb3QzULF2TsxbqtDdT6ZLJuZicwjIQzK3L?=
 =?iso-8859-1?Q?sooV9PfzmQHVAI1tPZ4LzClGaHJEYhnJelW2QqM3JQH6S/R10ZVLpZKDvL?=
 =?iso-8859-1?Q?A7IvLXossz+473So8hXP0/moa7Ir2kGnXgZymfxAcrv6xmYixRHCZrcueU?=
 =?iso-8859-1?Q?ujfUK7V9mnMu3+Tnx3efpW5MnBkoravCad3qbEjUjxufN57ImOWyBwCxoG?=
 =?iso-8859-1?Q?X5jmL+MnpBr57wtHaeg4Tw39IcKQ9tkeq5JcRoyxgihulxYI5T3wfxbVhs?=
 =?iso-8859-1?Q?3jfJJo5F/V1iNxIXjazQ8YuiDCXj4io3XjD+Yy29CPvC72nodbFkj/OOKb?=
 =?iso-8859-1?Q?HIeHA5ohl1yhlsOu1KRMv1Z6xKtVkioaUBJtTK+YlYvYdwy0ZlU+ZiAtui?=
 =?iso-8859-1?Q?8STCOzR+ABxI35VqWf5Sxoi/aZNB6ejlVCxTKf1DnJoaHPS6gdXJfACFwB?=
 =?iso-8859-1?Q?ArksOab78AO7sJkTZg6sAlW7/F2InofBQhQ1DDabqFWQBssqOTVDV6HfkI?=
 =?iso-8859-1?Q?cnZcQn2tnOQ5WRhEiW+IE/3156xpXaZGvhl543P+Rl20tzdAiermrUVEhd?=
 =?iso-8859-1?Q?nS32+YshBaRGXg9/Wo6WVokcSEgEFBPAR2vxRafpG+IQuRGAM6zUsyfbJv?=
 =?iso-8859-1?Q?GnhWpIPDL7ygtu5/ECZorruxgLA01uSfVkOyPFk8CstFqMi5Zvmcs8IhWX?=
 =?iso-8859-1?Q?8ElIHw73KiDKmA263FHSwsIUojlrYlppAc7zUS9Ptx0strgsA81hVWzLFC?=
 =?iso-8859-1?Q?KA4dH4ICRcSJLCXasp8iKeChz0kmumJ1CZRyx764oc7i/J+E92yp2uV58G?=
 =?iso-8859-1?Q?yLzo0/U5Z+EI+h19dk91BXmqR2U/eqGTOQvpflhlkac6xMl9C0CTpRRj1i?=
 =?iso-8859-1?Q?Toq3WjNIhmF5jhfVL+lYVcrDMIKDCmSxA2U4yWbBL1/+gp9J8+g1YOhiEP?=
 =?iso-8859-1?Q?DFY3blsfOKNTp8IyGbAzA/Z1bTxfroS0DzTj51B9DnQUQbduoCk5Xz8kGh?=
 =?iso-8859-1?Q?CTnGlIodsVZ1EXxGgjc3ZcBmYKzCmelXvb3diKO2gQ7y4gKoKVfXzsYjQA?=
 =?iso-8859-1?Q?VFwzXa9X5kZcvHp5hjw6k29hZOkZrGUlUNvk8JXpJwGje4m0o5FDzEeFQK?=
 =?iso-8859-1?Q?HgY5IpzUL2Ex0dAtchEwhip+c5HJM92QTox5LXBZm1QAoD+uxZXk52zucr?=
 =?iso-8859-1?Q?7eYXSTEBJyPBEKO7wH6NCP7Yhk2pITzEYowI1UtWFLn4LmoZl6I/s8CeKF?=
 =?iso-8859-1?Q?/zGYlCgurZmH1b8PY+eN8BBh2kvvrQJGDKJQXbC/dwlUNm9RfmL/BwSk4U?=
 =?iso-8859-1?Q?pPrzbdVJ2cWN4UqKa4xpAMcFXWhCJt1/Sh1iPg7VHaM/h3oqaLCyYKc+bS?=
 =?iso-8859-1?Q?2ASn5J+jJHBXcc9/y7aQgViODAGN9DuN+iR5J2itYeoib1F0X/514x8L9V?=
 =?iso-8859-1?Q?n0FdSEedZ8SfcyAEfwr6OqCo6HwpnyBAwSlls8f62yhrSgE4HHrUIcrv9o?=
 =?iso-8859-1?Q?cHvNjlREW5OCv4ujoDUmb+W0fy5Fh4nyWpZBlcPRxvtJk2JGIvaqOaJduW?=
 =?iso-8859-1?Q?cmhA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62705320-f88a-4291-f4f9-08d9a9a7f90f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 08:55:15.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBt12XtpUgtzOQRd2IFx3FmnsdfsnkiDgdVv1J3MbMmmI62O6C59qWjF6QSXf5vKtntCH4oGfebCHFwlQ5yXr9yemd9ElwYKyJFBTqvnZsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4625
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

Thanks for the feedback.

> Subject: Re: [PATCH 3/5] thermal/drivers: Add TSU driver for RZ/G2L
>=20
> HI Biju,
>=20
> Thanks for your work.
>=20
> On 2021-11-16 15:17:48 +0000, Biju Das wrote:
> > Add Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/thermal/Kconfig         |   9 ++
> >  drivers/thermal/Makefile        |   1 +
> >  drivers/thermal/rzg2l_thermal.c | 239
> > ++++++++++++++++++++++++++++++++
> >  3 files changed, 249 insertions(+)
> >  create mode 100644 drivers/thermal/rzg2l_thermal.c
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig index
> > d7f44deab5b1..e37691e0bf20 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -354,6 +354,15 @@ config RCAR_GEN3_THERMAL
> >  	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver
> into
> >  	  the Linux thermal framework.
> >
> > +config RZG2L_THERMAL
> > +	tristate "Renesas RZ/G2L thermal driver"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	depends on OF
> > +	help
> > +	  Enable this to plug the RZ/G2L thermal sensor driver into the
> Linux
> > +	  thermal framework.
> > +
> >  config KIRKWOOD_THERMAL
> >  	tristate "Temperature sensor on Marvell Kirkwood SoCs"
> >  	depends on MACH_KIRKWOOD || COMPILE_TEST diff --git
> > a/drivers/thermal/Makefile b/drivers/thermal/Makefile index
> > 82fc3e616e54..f0c36a1530d5 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_SUN8I_THERMAL)     +=3D sun8i_thermal.o
> >  obj-$(CONFIG_ROCKCHIP_THERMAL)	+=3D rockchip_thermal.o
> >  obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
> >  obj-$(CONFIG_RCAR_GEN3_THERMAL)	+=3D rcar_gen3_thermal.o
> > +obj-$(CONFIG_RZG2L_THERMAL)	+=3D rzg2l_thermal.o
> >  obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
> >  obj-y				+=3D samsung/
> >  obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
> > diff --git a/drivers/thermal/rzg2l_thermal.c
> > b/drivers/thermal/rzg2l_thermal.c new file mode 100644 index
> > 000000000000..e551355cd4f6
> > --- /dev/null
> > +++ b/drivers/thermal/rzg2l_thermal.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L TSU Thermal Sensor Driver
> > + *
> > + * Copyright (C) 2021 Renesas Electronics Corporation  */ #include
> > +<linux/delay.h> #include <linux/err.h> #include <linux/io.h> #include
> > +<linux/iopoll.h> #include <linux/module.h> #include
> > +<linux/of_device.h> #include <linux/platform_device.h> #include
> > +<linux/pm_runtime.h> #include <linux/reset.h> #include
> > +<linux/thermal.h>
> > +
> > +#include "thermal_hwmon.h"
> > +
> > +#define CTEMP_MASK	0xFFF
> > +
> > +/* default calibration values, if FUSE values are missing */
> > +#define SW_CALIB0_VAL	3148
> > +#define SW_CALIB1_VAL	503
> > +
> > +/* Register offsets */
> > +#define TSU_SM		0x00
> > +#define TSU_ST		0x04
> > +#define TSU_SAD		0x0C
> > +#define TSU_SS		0x10
> > +
> > +#define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
> > +
> > +/* Sensor Mode Register(TSU_SM) */
> > +#define TSU_SM_EN_TS		BIT(0)
> > +#define TSU_SM_ADC_EN_TS	BIT(1)
> > +#define TSU_SM_NORMAL_MODE	(TSU_SM_EN_TS | TSU_SM_ADC_EN_TS)
> > +
> > +/* TSU_ST bits */
> > +#define TSU_ST_START		BIT(0)
> > +
> > +#define TSU_SS_CONV_RUNNING	BIT(0)
> > +
> > +#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
> > +#define MCELSIUS(temp)		((temp) * 1000)
> > +#define TS_CODE_CAP_TIMES	8	/* Capture  times */
> > +#define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
> > +
> > +#define RZG2L_TSU_SS_TIMEOUT_US	1000
> > +
> > +struct rzg2l_thermal_priv {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct thermal_zone_device *zone;
> > +	struct reset_control *rstc;
> > +	u32 calib0, calib1;
> > +};
> > +
> > +static inline u32 rzg2l_thermal_read(struct rzg2l_thermal_priv *priv,
> > +u32 reg) {
> > +	return ioread32(priv->base + reg);
> > +}
> > +
> > +static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv=
,
> u32 reg,
> > +				       u32 data)
> > +{
> > +	iowrite32(data, priv->base + reg);
> > +}
> > +
> > +static int rzg2l_thermal_round(int temp) {
> > +	int result, round_offs;
> > +
> > +	round_offs =3D temp >=3D 0 ? RZG2L_THERMAL_GRAN / 2 : -
> RZG2L_THERMAL_GRAN / 2;
> > +	result =3D (temp + round_offs) / RZG2L_THERMAL_GRAN;
> > +
> > +	return result * RZG2L_THERMAL_GRAN;
> > +}
> > +
> > +static int rzg2l_thermal_get_temp(void *devdata, int *temp) {
> > +	struct rzg2l_thermal_priv *priv =3D devdata;
> > +	u32 result, dsensor, ts_code_ave;
> > +	int val, i;
> > +
> > +	result =3D 0;
> > +	/*  Read the ADC value 8 times with an interval of 20 microsecs */
> > +	for (i =3D 0; i < TS_CODE_CAP_TIMES ; i++) {
> > +		result +=3D rzg2l_thermal_read(priv, TSU_SAD) & CTEMP_MASK;
> > +		usleep_range(20, 30);
> > +	}
> > +
> > +	/* Calculate the average value */
> > +	ts_code_ave =3D result / TS_CODE_CAP_TIMES;
> > +
> > +	/* Curvature correction */
> > +	dsensor =3D TS_CODE_AVE_SCALE(ts_code_ave) /
> > +		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * 13));
> > +
> > +	/* Temperature calculation */
> > +	val =3D ((dsensor - priv->calib1) * (MCELSIUS(165) /
> > +		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
> > +
> > +	/* Round value to device granularity setting */
> > +	*temp =3D rzg2l_thermal_round(val);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops =3D {
> > +	.get_temp =3D rzg2l_thermal_get_temp,
> > +};
> > +
> > +static int rzg2l_thermal_init(struct rzg2l_thermal_priv *priv) {
> > +	u32 reg_val;
> > +
> > +	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
> > +	rzg2l_thermal_write(priv, TSU_ST, 0);
> > +
> > +	/* Before setting START bit, Wait for 60 =B5s */
> > +	usleep_range(60, 80);
> > +
> > +	reg_val =3D rzg2l_thermal_read(priv, TSU_ST);
> > +	reg_val |=3D TSU_ST_START;
> > +	rzg2l_thermal_write(priv, TSU_ST, reg_val);
> > +
> > +	return readl_poll_timeout(priv->base + TSU_SS, reg_val,
> > +				  reg_val =3D=3D TSU_SS_CONV_RUNNING, 50,
> > +				  RZG2L_TSU_SS_TIMEOUT_US);
> > +}
> > +
> > +static int rzg2l_thermal_remove(struct platform_device *pdev) {
> > +	struct rzg2l_thermal_priv *priv =3D dev_get_drvdata(&pdev->dev);
> > +
> > +	pm_runtime_put(&pdev->dev);
> > +	pm_runtime_disable(&pdev->dev);
> > +	reset_control_assert(priv->rstc);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rzg2l_hwmon_action(void *data) {
> > +	struct thermal_zone_device *zone =3D data;
> > +
> > +	thermal_remove_hwmon_sysfs(zone);
> > +}
> > +
> > +static int rzg2l_thermal_probe(struct platform_device *pdev) {
> > +	struct thermal_zone_device *zone;
> > +	struct rzg2l_thermal_priv *priv;
> > +	struct device *dev =3D &pdev->dev;
> > +	int ret;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	priv->dev =3D dev;
> > +	priv->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->rstc))
> > +		return dev_err_probe(dev, PTR_ERR(priv->rstc),
> > +				     "failed to get cpg reset");
> > +
> > +	reset_control_deassert(priv->rstc);
> > +
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_get_sync(dev);
> > +
> > +	priv->calib0 =3D rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
> > +	if (!priv->calib0)
> > +		priv->calib0 =3D SW_CALIB0_VAL;
> > +
> > +	priv->calib1 =3D rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
> > +	if (!priv->calib1)
> > +		priv->calib1 =3D SW_CALIB1_VAL;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +	ret =3D rzg2l_thermal_init(priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to start TSU");
> > +		goto error_unregister;
> > +	}
> > +
> > +	zone =3D devm_thermal_zone_of_sensor_register(dev, 0, priv,
> > +						    &rzg2l_tz_of_ops);
> > +	if (IS_ERR(zone)) {
> > +		dev_err(dev, "Can't register thermal zone");
> > +		ret =3D PTR_ERR(zone);
> > +		goto error_unregister;
> > +	}
> > +
> > +	priv->zone =3D zone;
> > +	priv->zone->tzp->no_hwmon =3D false;
> > +	ret =3D thermal_add_hwmon_sysfs(priv->zone);
> > +	if (ret)
> > +		goto error_unregister;
> > +
> > +	ret =3D devm_add_action_or_reset(dev, rzg2l_hwmon_action, zone);
> > +	if (ret)
> > +		goto error_unregister;
>=20
> This driver only uses one zone would it be worth considering calling
> thermal_remove_hwmon_sysfs() directly from rzg2l_thermal_remove()?
> Compare then Renesas Gen2 and Gen3 drivers. Where Gen3 uses devres to mak=
e
> it easier to deal with more then one zone wile Gen2 calls it directly fro=
m
> its remove function.

OK, will use Gen2 style as it has 1 sensor on the next version.

Another separate question, I have in my mind is how do we test trip points
for negative temperature?=20
This TSU doesn't have any interrupts and
we need to use polling, The range is -40 to 125 degrees.
If it goes below -40, I guess we need to shutdown the system.
On device tree we normally specify only positive temperature.
How do we handle this?

Regards,
Biju



>=20
> > +
> > +	dev_info(dev, "TSU probed with %s caliberation values",
> > +		 rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
> > +
> > +	return 0;
> > +
> > +error_unregister:
> > +	rzg2l_thermal_remove(pdev);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id rzg2l_thermal_dt_ids[] =3D {
> > +	{ .compatible =3D "renesas,rzg2l-tsu", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rzg2l_thermal_dt_ids);
> > +
> > +static struct platform_driver rzg2l_thermal_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "rzg2l_thermal",
> > +		.of_match_table =3D rzg2l_thermal_dt_ids,
> > +	},
> > +	.probe =3D rzg2l_thermal_probe,
> > +	.remove =3D rzg2l_thermal_remove,
> > +};
> > +module_platform_driver(rzg2l_thermal_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas RZ/G2L TSU Thermal Sensor Driver");
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
> >
>=20
> --
> Kind Regards,
> Niklas S=F6derlund
