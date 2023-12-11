Return-Path: <linux-pm+bounces-911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8BC80DA9C
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B82F1F219AE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 19:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADFC524C4;
	Mon, 11 Dec 2023 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="atCkFv7e"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C61C0;
	Mon, 11 Dec 2023 11:10:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhginq/b5K+Us1Z/MdpIXtdm6DsItRU9ULTq/35vre+9AuNr+aWRP1+Pdy9eX4Cwkj+zkEzRf+KVD6aVtjJKG7xdyj17+cBlQuiZq9Sx4QhM6PfQ+iiu011F+NycnhUvGgkYFjtch3i5a6eZqEdgFLRtS7X4OyqLGk1JUKWB4a9brjaTtGp84DGpNmAdMYnhRxufJs7ykxLxMXkXD8KKw9GXE+R0Vcs8bA/+4WSDsUt4PTFXmdmoPWEmynOxSusfBeTfI7dKZXTcr8NuPhhRHApPBpf+UxdzBXyiij6YYA8JEixoAT/ni75zipN1ESgbPJ4+6C5F5gOvbKDBfy2bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg8l10l4xpiYzyJ5gw6IrfmnU50kFUTZJr4oXCRpXRQ=;
 b=hYXtVvO/o8SFfNARV1kfBtM6nE9e3iRPlNODZNt9YxhqdM+5j//aCCOOCLqheoGLk/VC5B8sxoM9kJyzVL1gyJ8q+L+pot4CNIInZhCt3srExAwxOrcV1i9bu+lPmMVYSGamLdBx2Hu3JLqM+414jr5vnwe6MBSNzZ6jC1t0dO7HaKxZ1Ny6F2Wrc+r8qM3Kt2bixI2ZbXbgz9n3hbK1LOwT+TOqvbYcU9n/eh007CQ5eGH4W3+d1Sc8t9uBqQz/ld2ReMD+a/KtDsU6U2pYykqyO3Wu9CTc9giFJ5HTyN4GFNYI5Lq1gco4eQH+dNM0e30xOTUvBXSLtjLhkAO7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg8l10l4xpiYzyJ5gw6IrfmnU50kFUTZJr4oXCRpXRQ=;
 b=atCkFv7eT/WTzRejycTsrS0z7VQSF4R42ptGX+m7xp0+1R/JEwC43WgQPGo2lo8GquFDKCkEN83+n058JKg723rYzvjEdMhI4Brn4cqMG17dRPKDsumeiwOUg0sOhhIzOVmlVxlHObqM4BIsCdqObhs8OUPrCGvqAjdw4oIB9j8=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS7PR01MB11742.jpnprd01.prod.outlook.com
 (2603:1096:604:239::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25; Mon, 11 Dec
 2023 19:10:10 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.020; Mon, 11 Dec 2023
 19:10:10 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>, Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Steve Twiss <stwiss.opensource@diasemi.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Topic: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Index: AQHaK2+CO5V9wAfdBEqN6/S8f3RG87Cka12AgAAInaA=
Date: Mon, 11 Dec 2023 19:10:10 +0000
Message-ID:
 <TYCPR01MB11269C8A251D5A3B54623B98E868FA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231210134717.94020-1-biju.das.jz@bp.renesas.com>
 <20231210134717.94020-9-biju.das.jz@bp.renesas.com>
 <20231211-dissuade-skirt-5961ef525497@spud>
In-Reply-To: <20231211-dissuade-skirt-5961ef525497@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS7PR01MB11742:EE_
x-ms-office365-filtering-correlation-id: 38d121ef-7630-445a-af4d-08dbfa7ccb9d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MMRaFYfy1kLBLSL1CAL9hsXnQmlBWU2Gh82KzhnsWk1hLfOdA1gDSCUTLuQQoBEnT8IXnQEtjiUIEE3vQohMu3Nv5rvfReHuejm/irH2N5GlvIrWkSqiB1I0zH7zX0Cz9Uh2rIjraw5KwHZgNcU2AifVFpNBucrzHFPeOML/Xk+CQkSKg0qzYiqLNoxsCgXsDEGSmsrFeGcBj6UPVjgPwukQZLJg1UXx0Y2CerZP4M9yn4Z9ip/aHKMR1cU05Eh4Tzu45hCRPqmw/KRnPtRR804/FqVlsr+X801hgInnGJrJVdMFq19hailngYHFggambo+ofPH3DEXKl0lu+2RR/ar5h+1sBI9sU7ahfUsUuwZY1f1b2iXIPFzEHmEtx2shP3k3n9iW8ttiDTkMd5YFg+u0EcApF8kWd26wg6zUX1BAji6tj9/2QW4cY8eZDzLCEgCAD16McvvwFGebzbcRm0NoRXRYYt+DyFoQVDN1tOItAQKaItqfs8gH7ix6awT21WvykM5pFtoMVYMwRzj2PfseaNKST1TUUuwyWJg/kAhumaMmajZnMqcVzeCnKeJG5SvWN1YhTINxHzr70pg4er3nYbipVJhaSaw7CLOl4BMQJyXILTOx+f9OfsO+vzDFpOsT9HyU3cM3Py7t0Zmo4g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(26005)(122000001)(38100700002)(33656002)(86362001)(38070700009)(83380400001)(52536014)(7416002)(5660300002)(9686003)(6506007)(53546011)(7696005)(71200400001)(8936002)(8676002)(76116006)(66946007)(966005)(66556008)(66476007)(316002)(66446008)(54906003)(6916009)(2906002)(64756008)(41300700001)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QOJZt6nSk4/P9+J+X5axKt37c4vSDVlfap+rp9dQNwI30nBH2MS8GjTOzyCJ?=
 =?us-ascii?Q?WCF2nG2HrxjmX7FUKTzv4XKDnEB7bSNbSbezlQ+uxunkGebhekfhssInA7Zw?=
 =?us-ascii?Q?Vv4Pqrj3lDnagyY+qCBbjvVh/iWFdt1ppB/C9rvd5HSmvaD7wXN0nj34Ic7F?=
 =?us-ascii?Q?koFy48QwZg8+uytKvz+mWNOvGjTQjGbpND17ads23ekrGdwdyURixloA2OkS?=
 =?us-ascii?Q?yy4ziplr9xTI9lGvVY8nnjq/YhAX1a+JZOEFGaNV74kw1mvzfD6sHhmQQhG4?=
 =?us-ascii?Q?mwjj8O+uW1VbeUILBTEJkbgZ5cwWphMg9vRP7LPKJAeOB2jQeBxFxV5cBLM3?=
 =?us-ascii?Q?81V9+LWg2rkyoH6S1Nt0WEN361qU6k397omsJSK69PQIkqohD7Z4/dUOwuwy?=
 =?us-ascii?Q?caDA3ed3adX3/V2Td1GVrbomCLgvNV45CQWcXc6I3yOV+wNn54Ug0QLZ0u//?=
 =?us-ascii?Q?mAnlR1+tt0aZ6pNUz8DpfQuTc1U3yEDQ+aPhT1V/sfwH9KF7kKlPJKLhCtrP?=
 =?us-ascii?Q?K5egvsCIU9WdfQ2wEX5y0O64EjBBwYvQwOykrJukKzQkccBFKebBBZJXWjNa?=
 =?us-ascii?Q?yDkzh2t6UJz1oMPtkGHOdKCySvDsA8c8ksapkA2Z7L9wI6ZWrQbrNv6JRXUh?=
 =?us-ascii?Q?5B03su708494qOhb6NazuvNjBw509M8P6vFQIVGCtPFTgGWHWt9NrW+nm+rx?=
 =?us-ascii?Q?1JLTmkf1JdzI+HQz+w5Tr68D3geKwpS3PMzOulGt/iiKsGOdBNbr2ZFKaPjs?=
 =?us-ascii?Q?k3RgNBtYF6dy5B41g2Td/SI+lxsSYUSSWEY5WrRd8W66kxZ68Pz/4lQcWrfp?=
 =?us-ascii?Q?vXqPrG+eZXz5DEp9w611d4IY24CKdIUgorGNO2tWNsuuuDYa3ZtpNV1f5Hq1?=
 =?us-ascii?Q?+DiMwMrGftOOYqSsmzayqYU3R/6OqYbZxt0WO3478HXlmPL97evi8IFAkNbN?=
 =?us-ascii?Q?MA0Wnsz6z9HILBwx023TXCP+Z+6ABbm7Zk4vlQ5hkeWUU0hFpFM4xG9EwFiC?=
 =?us-ascii?Q?MGX1f1ho5c1/4TdFv8rA59pGKT0WZfIEeJyIwqGKTUaNHJ0skZvmWGWancLx?=
 =?us-ascii?Q?CzwzEl87EqdLmfT+4ga618Td15CvwevKggVwrU+R0zr1TIlumCBBiIojSKpS?=
 =?us-ascii?Q?qNZ5pKp783GVMV1kfUj93+dC/mlCgUqmuyZFB7Mqp9+gl3AW/4fG4Z1Q9lCZ?=
 =?us-ascii?Q?RpbI2RK0bEKi7GmbT5i3wwQm8ghljB/G2VDfGuuKPx+NvWdbAslSlTYhY74j?=
 =?us-ascii?Q?IRQC1oQ2iNDErdeL5EE65g6NoSUrk+wwFBrQeUz/DVvd7hPfSm8BwTV/qVtf?=
 =?us-ascii?Q?EfaDWfUZFdCpKuHwAq9iGIqgYBQ5mYYbfm3H1DuCv23WxLE5FUUZbLvF0+ri?=
 =?us-ascii?Q?WezcV7T1Ogoy0sAaY4VNy+FE7XQVo2vMN8OTyhihxXP1dnYvSsvIWBbIb4cn?=
 =?us-ascii?Q?ZGJIJBzN8raKmMzXvRJJB+f5VpKI8ynzuThyDXq4MM2xND3AnK90nLP/odom?=
 =?us-ascii?Q?pxtmcsvqL0HDPX1NJUYLHU3nOPF9G7LaJ5gszZfeBKL97ZH//9m1p9jAFFsm?=
 =?us-ascii?Q?cXGjC71XiMrqmkkiUv9+iiWtEAuVGS4LhBVUQWfYAAPCAiN3IN1SgxTPeuHP?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d121ef-7630-445a-af4d-08dbfa7ccb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 19:10:10.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcsQ/ruDOqAx89oSZANy4aX9JNFU/nGl216zf7GaPP2OaF5kPqVZhJzMj1RFT0aNQnlYFWcCC0LoFO6b78hc/g1KAvpaXRVj0f/mAdJqq8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11742


Hi Conor Dooley,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, December 11, 2023 6:38 PM
> Subject: Re: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062
> to json-schema
>=20
> On Sun, Dec 10, 2023 at 01:47:17PM +0000, Biju Das wrote:
> > Convert the da9062 PMIC device tree binding documentation to json-
> schema.
> >
> > Document the missing gpio child node for da9062.
> >
> > While at it, update description with link to product information and
> > example.
> >
> > The missing child node with of_compatible defined in MFD_CELL_OF is
> > causing the below warning message:
> > da9062-gpio: Failed to locate of_node [id: -1]
> >
> > So, make all child nodes with of_compatible defined in struct mfd_cell
> > as required property for da906{1,2} devices.
>=20
> > +  gpio-controller: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  gpio:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      compatible:
> > +        const: dlg,da9062-gpio
>=20
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      pmic@58 {
> > +        compatible =3D "dlg,da9062";
> > +        reg =3D <0x58>;
> > +        gpio-controller;
> > +        #gpio-cells =3D <2>;
>=20
> > +        gpio {
> > +          compatible =3D "dlg,da9062-gpio";
> > +        };
>=20
> I know you had some conversation with Krzysztof, but I still don;t really
> follow this. Why is the parent, rather than the child, the one that gets
> the "gpio-controller" and "#gpio-cells" properties? The commit message
> just mentions why missing child node was added, but not the reason for th=
e
> gpio properties being added at what appears to be the "wrong" level.

The original binding has this in parent. See [1] and driver is based on thi=
s documentation[2]

[1]

https://elixir.bootlin.com/linux/v6.0-rc4/source/Documentation/devicetree/b=
indings/mfd/da9062.txt#L44

[2]

https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/pinctrl/pinctrl-da=
9062.c#L270


Cheers,
Biju

