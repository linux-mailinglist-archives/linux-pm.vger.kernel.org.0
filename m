Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2242A457FD4
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbhKTRYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 12:24:19 -0500
Received: from mail-tycjpn01on2093.outbound.protection.outlook.com ([40.107.114.93]:13998
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230337AbhKTRYQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Nov 2021 12:24:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0Iom0VBG7p1gkpFBDWzsXnmYzaAacWeJXCB62qv+ZtLiOFZeNWOIT1oLoM48126ielyv42dr4rgG/U5rqzPbCJKXSEIHih0hXWP4nrC6kI2v6TVTlZ+zTfjgaa1aAtqKhMGNdfc59IBd/VfTaUTHXzBh7gHsnJK2cD7RHFXW70Kqnl33/e5yLol5x30W9EjxZzGEFCJKjcfBlRdfSfDYjSKsYXFyZKhTs9+SfYj4vDekgLyLIAz5GnTf1Ch173SdnbyMdEJr3ifrfXJMntrdbkonlyB5nJMWzsFXHHbzDiIq3bzwaPIep5UaBut3mn+JWtagIAAcQO+NS1zXVP0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE296Dlg7todTeODOChK8keok4/3mCKyj+yEJI3qXb4=;
 b=Ji/VDy//UCss6+bO6TJw7VXewL0Xhakc3Fru1jXz9KGzgWOgt8HKnxoO4WZQqt8KW4xu/dIIu5a4YGT2SG9mv2UK6z11COSrXdvy6aw0YxaAoIA8YBMrKYh1bxeVtjqhZS4kXM4ZfHTqzZ+5rE4tUQ3D1kvqRtFNwzVTqpF7Va1D5iBe5PyP1p4NNrJG44K3gIsSc/i34f0uvtImRhrB2McnWOYRnE4Eo74PXKqRkVJ0loTc/RS1Z/VxHzl+BGmEITVWW26Jmk01HYzDqpjUOtZ8V0mBKn06pqN/FV/zH9BTRPqDm1cFCtT8Hn1T3csq/dmi7NPtBeTNBSMbR77Y0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE296Dlg7todTeODOChK8keok4/3mCKyj+yEJI3qXb4=;
 b=KlktUQcR6mTg2jWqx5h08EmyXCdwt+TsVjs+UeWk+YKYG4c4r1XoBJ/pQv1be9YJ+3xgdFdXMrEiz4mNyasMeUCnDfJbi1kz1+sGsfM9Z/hF41TU8SC9CNNQBR6suOqPyn8cP/kSwH7ODcZpVwqKjfx8TFdilFXtp37is2/K7M8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB3890.jpnprd01.prod.outlook.com (2603:1096:604:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Sat, 20 Nov
 2021 17:21:09 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c0bd:405a:cdd3:f153%9]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 17:21:06 +0000
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
Thread-Index: AQHX2v0oE66oWNNWJkWwQPaKhKKvwqwHZ6gAgAVFWZA=
Date:   Sat, 20 Nov 2021 17:21:06 +0000
Message-ID: <OS0PR01MB5922C3499601771A882451D7869D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 3525a57d-f47d-41ec-fdb6-08d9ac4a231c
x-ms-traffictypediagnostic: OSAPR01MB3890:
x-microsoft-antispam-prvs: <OSAPR01MB389047C1949CF2ED73B250D0869D9@OSAPR01MB3890.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ea88UzrdLuPLIe18ZqZQLh08EfcGpF5gHI8AHNRFWOSRE7N/htVSG02+KchRMqpew3P2DVCMUpvexpB2dP4YFu3AYUSxMfegf6XBzhR+oqSav9HXjZNBy59XbAYthTsvzYIwI+ocFEmwIz+vPVaMKZktIV9XwnK29kVuKwhY1YjMnaP9gQz/TeEEA8Ek1+3zf/SgfcoUR3uMnVNuzfney4RDg8aBBrh7otvjjjQ7D59NM0Ob+F6jE3WVt20J25ATo1wFOGQC5n2uUFD/jd5K53PK7dgyv0dOE9Unx9OK5ZTT9/o1EHRiq2P+m+dIMs+5xt1V6UMPXAsEchC3tY5IGP4LB2DIieLSlAEYNTBEiIVHdzetzdlqc0lbcHRn7ywZTgeWmRNdch9nGzwB0+S4iyfdV/6kMu3KLG9LfrMNRgg1o5ee8PBCD9uaLghZ61yA+wZOEW1Zt29G/Zhi65DtIoCNatKradhDudASCgVFNTW8TlQeuAVF6LIIE9oEAT3QKH1L6CfaILkbepKPkeeRvkjYT+TFifZB9xhWsq1fPVibCD2qGg3BQsTtRz6Zy0Zjnw8mLPz64ii81E/EaQimUdxn+ScwVqNF6Uem2nyhPYnPDT1yJPk+Sj5J7bssDXzBFIMOfBjh6Asm1vCQsT666Hbry/+QcuvYzPPybqWeGw0if49Ju14/O5f7RZ64r2H/hF7BGqcQ8ERmk945w2X0ZRExNJOHFVBYWjBtL5X3maW9Qo7WcI7l2OYR7D/ew4XUOEKpKgOIdHuZHyfsq9JibJOXlOUvyEbLgR6+pw3Hzhc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(38070700005)(6916009)(966005)(83380400001)(9686003)(55016002)(76116006)(4326008)(54906003)(38100700002)(30864003)(86362001)(4001150100001)(66574015)(122000001)(26005)(7696005)(316002)(8676002)(66946007)(66476007)(64756008)(6506007)(53546011)(66446008)(66556008)(5660300002)(2906002)(33656002)(8936002)(52536014)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pRchBARSmLFIc0VPcjKKfqWiliGiuToYXEDCmU6AWnOC7N1Nj3TkBWKO1e?=
 =?iso-8859-1?Q?nQHMBfulr5GyHOEu5paSiq98gMlfz6mU3qbEUxbW9CQrAfpdDtGjLxxoRk?=
 =?iso-8859-1?Q?EBGHKDc3SJoUZQeh0F6CDHrb92pBzm1LIFxSBl3LL+TSYgP7MUcwuvEpDZ?=
 =?iso-8859-1?Q?vXvtM3P1YSra2lEKXvuwt7M0Bg+xjNCBeTSkSBjmtHWGUwKEUcJKUMTYW0?=
 =?iso-8859-1?Q?guRIKkQTDYWYJRsjeobtkRRPwSVU+mmo10rx3z2Hwpxcw6HVcqmwDW5JSL?=
 =?iso-8859-1?Q?ytxIuSM4eV3oTlap2NBFh4oRTzLZtiHPTfKdLHaLSUKST817YJ3Fz2xN8f?=
 =?iso-8859-1?Q?UyLdLiQ4PXrSv9iGvxwPRZHOLjnPYScUy5V+13HvKw5ZWPvKcxrLXUausX?=
 =?iso-8859-1?Q?r9dQciCz1oqcVv2iq8I1hjHislhQY9nEPrL+8vtEQEvlFyRXOtNeZ/EbN7?=
 =?iso-8859-1?Q?fPnP7/bucd5UjNPydmSHPccQ+rh6MQ6QNMLzaZhiWUnqgmmOtVjl3v+x/7?=
 =?iso-8859-1?Q?YMYxPTf3p9wbj9LTwDD994qlFxmibBegnnIelqYEdJxak6WFJnPc3cZ4Ld?=
 =?iso-8859-1?Q?BBmjBaj7HIMh4DIhpE7tGA2D9yqwU3Th4BYY7P+vVd04Q0U2s98D2FU16+?=
 =?iso-8859-1?Q?lQlrF0JIys028RHOSCum6rF8q7pDWoTeOa1X8pUseeaPdEvIKBGPyP4zPX?=
 =?iso-8859-1?Q?skE5umuSrMxDnq5U/wymCq21oLljD4ANtqyMwrfqDEu0ts6Yh4t+LPsCuh?=
 =?iso-8859-1?Q?y7Us4q7FNuFraxsZDhbDX7zKY0Ux50/nrPp2Wu7R9SK3TgMkYpeNIa+L51?=
 =?iso-8859-1?Q?48G+zmNCMy5JtHuPsPGcf+WpsF1Y53qVWfizlDPXIOEmRtdJT8pDEQfQ7X?=
 =?iso-8859-1?Q?xtJBCBh/p9MYSmtWe09Cxl2B/qDBvx9sGUazSKP+TNI/KYC954mXJd1GTD?=
 =?iso-8859-1?Q?YhTTyeCA7X22o4X0WRLYndUhoKHskRs3N4Gm6z0bAubCBCKbyGe324Q8Bt?=
 =?iso-8859-1?Q?d7+r1RqQJnQ+ERlUU2ZKKlx5mYyLuIudXmKvwn6X/zKPJXORqq302nXGoB?=
 =?iso-8859-1?Q?7/o8yREFs+SuGg83J6WRpQgOo4ZpPX1BXJaNqM3moRJs7XYD4Ha0qRcG/l?=
 =?iso-8859-1?Q?/hiOC0kYV+lQr6efJ+aCtmDS9rTYh0enVGWdsGhIHg9Zt+Dc2ws87hh6IR?=
 =?iso-8859-1?Q?sv6RsR80uCnc6DnKABbzuFVtCp0sv+TWhw2BsRor3q0RY2cNdhunBGX5Tl?=
 =?iso-8859-1?Q?UZnDKfrodmI/QQqdb+UWVZih8ur/NKaHfe88wxrBmsf1kTL9KnecsgxDgc?=
 =?iso-8859-1?Q?gfkQTq4eNUspZJmrYv4VeqFv1KY1i5zDmiVtQg1zgfRzZIud5876OzhFi7?=
 =?iso-8859-1?Q?/mJMeym1xvzRcwWN3QstrRlRrQ5qtf4esOV7K1CGga9Cg/pzBnQusKW/Dl?=
 =?iso-8859-1?Q?d7vqG1LOlilQiDHEXE1A7e2dgzgGcy/L+oxV3GAyarEwNsrfz2/Qhw8/0C?=
 =?iso-8859-1?Q?8LHZUJR+hAWI/rkIzd8JgptXPYOVgqfBWNnMZXgMCoosZYx7aPsklJ3yVr?=
 =?iso-8859-1?Q?PtWZFyew/Ys+a1WU1L/xKkzUrc5rpZrRKzH66eUv6KIXeENdv4ZBinA1ma?=
 =?iso-8859-1?Q?ZiJQgDDCzJgSzJwokjyNwf9bKyft2W0hPArv3wHzIZ5ufrwB4MPqIGJHPG?=
 =?iso-8859-1?Q?nV37BhhPylkcWdejUxH1iIS5yQXVxYbUvfvyFHWcrkI9HvCM21QJRgjPEf?=
 =?iso-8859-1?Q?DxGw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3525a57d-f47d-41ec-fdb6-08d9ac4a231c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2021 17:21:06.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qq90+gy/6mumq4TL3h+sGxkMvGmve5td5nZMiTUyhgJJ5gX//4R09lntGL2rHHMQQhbCuLsU7J/MxfcXb4XH2Y0g26yWnLJl+cpcVFHm+FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3890
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

> -----Original Message-----
> From: Niklas S=F6derlund <niklas.soderlund@ragnatech.se>
> Sent: 17 November 2021 08:41
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>; Rafael J. Wysocki
> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Amit
> Kucheria <amitk@kernel.org>; Zhang Rui <rui.zhang@intel.com>; linux-
> pm@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
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

In fact this is correct.

> Compare then Renesas Gen2 and Gen3 drivers. Where Gen3 uses devres to mak=
e
> it easier to deal with more then one zone wile Gen2 calls it directly fro=
m
> its remove function.

If you see rcar-thermal.c there are unregister path (goto error_unregister)
Where we call thermal_remove_hwmon_sysfs without adding hwmon_sys

See [1]
[1] https://elixir.bootlin.com/linux/latest/source/drivers/thermal/rcar_the=
rmal.c#L561

For any error upto L561, any unregister blindly calls thermal_remove_hwmon_=
sysfs,
Which is wrong.

Looks like we need a fix on Gen2 drivers.

Please let me know, if I am missing anything here.

Regards,
biju

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
