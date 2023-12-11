Return-Path: <linux-pm+bounces-910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FF80D922
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 19:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0E91F21AA7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63751C46;
	Mon, 11 Dec 2023 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sDLvIl9X"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E30AC;
	Mon, 11 Dec 2023 10:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WepDNqSYT3QUQufQ5PziVImgzr5KBa8CmSaNDrtM+31KNVVCPC4FrcEZ9lyC9MumqJx+1EvnB7XQQYXwCWwxQkHRanqk4FGKYbgVDvbEIIhjEWHG4MSvcSSnVzsMr5CLmusjsbHhF05eF0qNHZTiCR27Fd0IoN6JkYLva5Js9qS5XsxVCJXI481vfyOGgSZ1O9Rhn6dQxDqa3cyg6ZU6e+pDohHYeaG1lkw9GtR+Avuc0J7W0eTl4EiTDS24wOhFXk7pUn2gd/oVsDE1FR2U88KKH9wyqrkRYm8SHXzMY5gNo6Jb3fbGsc54QG028IS+G/zq8lscGPvX+s6GBrk9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYJf+UViK6Qkzh9sCSxUbPeJ1OWZxJO9vbpWuAtVMYU=;
 b=A8CjWcMqSUz0J/gBToq5W8nAPtFz+WthTzrK5JdYaeoiCrZiVlhHllMCsv9gkFWY18d/9d1bSYUtIiceyalDr4ioxf1Ozn59aXplgLZF/mWHp6ob4syk6zy59gud970jVyiGGWMLNH0OP4CwxSftOzP1/WV7G2hcD7mOJhJWF59QBD8lE3tqcfZMnnvP6dKEs9lnMdO7g/MSQ3PV28M4YYaqfGb0bVhP7Ft/jTXqm7i3TBXwJ4IXaGTkteDrn9zg3Fedfb0U4+znY9KerW2qMA4ufoG0yrT/y3ep9nqRh9EsqC02ziavUMwflro1gUxzERDDNENQf6HLe73G8MjVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYJf+UViK6Qkzh9sCSxUbPeJ1OWZxJO9vbpWuAtVMYU=;
 b=sDLvIl9X/aZUUILO7wct5ofuPqKzwQHypuKMmZ+ALHONyUe458t+V7ymLc9p4IMsXoo2kLGuMY007tSQ0f1sBEUQcKfxANQL6sLN7ZOd6hVVfUDzf0ybHYmUbHnJneaY4yUOY9PkpxrY4Yj1ft6KtQBCxXjVNpcVPMgRoPJU5CU=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB8354.jpnprd01.prod.outlook.com
 (2603:1096:604:16f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21; Mon, 11 Dec
 2023 18:51:15 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.020; Mon, 11 Dec 2023
 18:51:14 +0000
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
Thread-Index: AQHaK2+CO5V9wAfdBEqN6/S8f3RG87Cka12AgAADMCA=
Date: Mon, 11 Dec 2023 18:51:14 +0000
Message-ID:
 <TYCPR01MB112697AA2A3BC9F58C7BF4B67868FA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB8354:EE_
x-ms-office365-filtering-correlation-id: 1b7f57bb-e99c-4ca2-6f2b-08dbfa7a26f0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YI1+faBHMFvVQb90rCE8gI+h+Ss0iSjGa+K8kBMTHN4amXbjRQ3yOnWlLRp56NMEmBEKVjUuBWg89enA1Mqz7qILg7sHqeCJu6RLP9qzDaVRd0qyUFazgAkbkizodOkHPl5Lh4v1zsQRiUrjA0SqQSXzyS9HLwBhBQV7MGM+SIzpFOiZy/npRuxQjgrTInM8saJ8HKn+bmC2UC4q/+XEzckLQHthN2vJMQPmopwR3fMTvxEO/I15buiMQkFW1Y4HHw7ssv0wKjnruFmqapzdrJ9Qz4+iw+U/BTnBpgJbSwscpji3ks4cnoZfSX6KjBu8C+kbTZyUjZNUKtYtAC9KB4rJFZ4/wr3f5xmbNlj9VSscvORuXcegrFowTwfxzA0jq49tWV5BO/8m4XjbqbSpYrw9T4lfO8DNl1YRKM/aQOwiFE9vEPIIabOklZD48tlfL70Bfh/ccECSQULI4QvHpfNxA29dIXAArcrM5S1GYH4iV7Zm1AyjlC/Lgoc7l4ACDkVddEwZpSgqv23qwlt6ztod/mPDURAGQAwdIncrhzSm4gk+u36Xdc97AJKDU+zXrncxB1RwWx0i2WzQy++UlunLkqAHrlpwn763Y50G0wzbkOG6grAK6zzOaYzYXQ1thmEXT23y2AQjavD78kKbEA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(66446008)(7696005)(53546011)(6506007)(71200400001)(966005)(478600001)(2906002)(83380400001)(26005)(9686003)(4326008)(8936002)(8676002)(5660300002)(52536014)(7416002)(38070700009)(76116006)(6916009)(54906003)(66946007)(316002)(33656002)(38100700002)(122000001)(86362001)(55016003)(66476007)(66556008)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SvXet1AEkSzttpNcz3xSOwo3Xf4s5u3QHy2IEKOO+Us9eu9BzV7AtemxxLXM?=
 =?us-ascii?Q?QLh9M0+wgxl1By+Z00+LjIlnA0yNbT8lF2M17EA59TbBWA9ZA6qwzLLNQWl/?=
 =?us-ascii?Q?1bs7Zzn4iGIWcsq6Ryn6XzLCDrN8LUxT9CIusGMcgGcjPjVotDU4QE7Ijzzr?=
 =?us-ascii?Q?RQR79NEBGsyBS75abifDkyK983RgndWIwK1yyCI0+tViMY+YUi4142fwdPA9?=
 =?us-ascii?Q?kSd47cJrdMujvHunmb83QQj355Y42WL+z2rnAIR7WIOaSOCmd5dEA8bKfk0l?=
 =?us-ascii?Q?bxc6qUa+AFHm5SVTclFXcZZEWSIHES6SKgNFWv71wdosNSFO0RI98hF/ofzV?=
 =?us-ascii?Q?LDSv2FHzbkpqPsLYntBvzy7aYUBjqxW6vSL2jzaz4Klqm4yQ1/HMRrzQFneL?=
 =?us-ascii?Q?xzK9EjHH6ffTVDCFD5AH3vQsUzo8jM6F9Xve3/UmTeld7zNvuBxBEt0Bqx9J?=
 =?us-ascii?Q?0LQD+fj4HEB6ZsgrNTmGslNnMaebgSWriU+A0FRafcs+00wH5xhYLHtmz4qS?=
 =?us-ascii?Q?XFwplmWJz3RFDA3w3u46Jz9AFI9N4a3hmSsvXujgfm6YQr8Crb3cZfkEEWcJ?=
 =?us-ascii?Q?CKMIj9ajh8T9t/chiYnWIPu/wCl1hhA6vZU0PUTm92WUnV6MN2cfS6haM3x5?=
 =?us-ascii?Q?6YsXSH/yRzMGKp/COKsp9kK6x8nc2hgYuEWZLqcBdKcjVpkSulimirgMTxC2?=
 =?us-ascii?Q?tBIYb3PE9xh3MmWEUN//rZ+eWkc2TSttTWD4PgPpi1A2ERspuNjsTfrGnvCj?=
 =?us-ascii?Q?tdTCf8oTwGZzKkzrZDPziJO65wwZtzjS0j5BYsPE9u7t/PTdSggXwIReRvHx?=
 =?us-ascii?Q?dQedluy83TGijuBAQ3vK6toaUeoyDnB8l/Ipe5Lpws1pgVeaRGJIdhc06K8v?=
 =?us-ascii?Q?BQdSOcuu+98h6JrXv1lYBe8VIgP0e2T+VZbD3qRBPTPgnj+ar9zPWqSSXBke?=
 =?us-ascii?Q?m4HY2FNzN2TqJFqL9SPHmU5JBcZBjpsBhU4kFQwUH4T2fvH9DPWTEgeeH4gt?=
 =?us-ascii?Q?2ZSGdLkBwMo4FVCTqixGAWADQfWseZY14Vy167SSazpDnnTvhppT66uXXxYp?=
 =?us-ascii?Q?1mJv6QBKOn6yZfO/1Ln9bOlT4448ZcOR5srsgKha/L+iIoQjqW+uyge8frBV?=
 =?us-ascii?Q?LdzEFYkCIR5+XrJj67dPTzxW2FeIzNmwCP9CNoWKq3oJ+Rx6Wqn5XcjF6+D9?=
 =?us-ascii?Q?Xd7o597d+OlkbRt/FSJPOCSgkZ48LPRm7SzhKCNj39Mb3nsJV6Nwb2+J2x9T?=
 =?us-ascii?Q?FEju16Bl7MhbIddbWZgVeeFK+x+/h7E4QBdTWy3idR1wj0E6/gcdJYiF0lwl?=
 =?us-ascii?Q?YI+0wv+HWZIqXswtS95rMch8ZPqUd6tBNcFslsgEmgEaJ61RWT1al+Jl8tzr?=
 =?us-ascii?Q?XlaBkuSKedapLkDKeSQRPRoRdOpBki6r/BMN1Mg8TlnqC4nuO+inqH3RydrI?=
 =?us-ascii?Q?3xZ7gRLW/nUyy2XsvX4dvP85Jbz0wBW9hBqwb5bfnh1thewunHA2NhilKfVp?=
 =?us-ascii?Q?F+AfuzD2axulIW5BCo1Afo9lzVMhnU0vDAfaL7u+ZWtpboQW6Mub0Mi7lOck?=
 =?us-ascii?Q?92+3Fz6/mpx7ZfVlejkyg1odzmkaz7BkqEDBQbf6IIE2cfQLpTIXi39BkrAo?=
 =?us-ascii?Q?xw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7f57bb-e99c-4ca2-6f2b-08dbfa7a26f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 18:51:14.8928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl9QgNJAViowR7y0YWqxPwPfrx3AA/6k02k44baC7v1/lSiTk82zne4fwXU66CYa9V04qkoKsB99dQCQCjex8bHznhjzaybPhepTX2I4P1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8354

Hi Conor Dooley,

Thanks for the feedback.

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


Please see [1], The driver is checking against parent "gpio-controller"

[1] https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/pinctrl/pinctr=
l-da9062.c#L270


Cheers,
Biju

