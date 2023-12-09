Return-Path: <linux-pm+bounces-855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D580B51A
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4648028104F
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3104D168B0;
	Sat,  9 Dec 2023 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IAyc385q"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D899AC;
	Sat,  9 Dec 2023 07:41:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2TQRcucuEpM62QWgNm+8BBtXbELZbGM3oLC/iupRg+fMYvnw4+lP1lWlqPFdB03tHBpr9mUx4LqhkHQOQZSv9zthfTHn8Asl5WtvP6bH+T8l/mLV04w8XzeVomiBshm00jJttnAJH3Pd6SxvV9EPyUAY4EuBrTR8b+uAUFFr10RlsF4lzyKaYcZrHC9R/Ny//2uI5U8236EqHm9kXgEjfMiJyLrFljdHAcZvhysgHYAFPjEY7BVswLehHY+RfRjT11Iqm9hAk8SJU3npdnsVIxfWIiSbCF2BY2f3KsPa/yzWxy9xpalimngraOXJ0+Dbl0uEO9CMyt2IQqPWAMHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR9L2KUn/PuuWv86l54dxIcQeo2LJi1wZZQ2oFrhQQM=;
 b=Pu+LAkAkgjbEKWPNwH3l5s5fIufT9L8nXoeYR4UYpvhAe6mblxHROi2m35O7YykDHnu81XxDqtyFrLPH/2aNnSg0YDIA/hgVxbGlJGZoXi44VI+QdsvGBlhEYr92nK78RYOvWC4M2tKnl/KrdgrRh8OJoQ0GZKKyC4UHXvxnR9ER2EOHJZ5whQti3/SyXZ0okHVvJV5SN1O/bsts3XThLNBaSxHBh/8XRCSaeEX2QnGvkA9EDqx0Cpi/VwpdhNhAE9Ub2UZoX4GPzooMyhmJeWUxnLTPBsjuCimOCsSQL2iH34vOtalnQgAWu5QV84n3SXkOetMmrwwscSJlP8Um6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR9L2KUn/PuuWv86l54dxIcQeo2LJi1wZZQ2oFrhQQM=;
 b=IAyc385qWwmvp9saA5e/+x2kz1bhgPT7OmVUzcdcVuzuXQuDxDR5A2PVSNcXhwMjnrMFeRu/VqVNxBkROcnm68GYHT4mcPacdZxKizrlkKDvB4LtFQHBp8pNZLZVYrpat9KFLR/enqkZzOf+/y96Lb6hBNxD5iDyD1M8j54Du5Q=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB9641.jpnprd01.prod.outlook.com
 (2603:1096:400:195::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.17; Sat, 9 Dec
 2023 15:41:55 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.018; Sat, 9 Dec 2023
 15:41:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
CC: Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Steve Twiss
	<stwiss.opensource@diasemi.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Topic: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Index: AQHaKF0O3M4G5vsMkEy5OPyHlzeaZ7Cdgj4AgACF+8CAAP7tgIACEfiQ
Date: Sat, 9 Dec 2023 15:41:51 +0000
Message-ID:
 <TYCPR01MB11269F887AE07FDA09F19112D8689A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231206155740.5278-1-biju.das.jz@bp.renesas.com>
 <20231206155740.5278-9-biju.das.jz@bp.renesas.com>
 <114c9baf-66d1-4055-a47c-916642b6dedd@linaro.org>
 <TYCPR01MB11269C774B8FFE9E43455EB61868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <11ec89a8-5fdd-456c-b070-988bbf8f312d@linaro.org>
In-Reply-To: <11ec89a8-5fdd-456c-b070-988bbf8f312d@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB9641:EE_
x-ms-office365-filtering-correlation-id: 5ffac354-1915-4d3b-1209-08dbf8cd5cfc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AO9/BZ3PJHvZanxgb+lDcw+4Kjh62L4DkQEUdYoX7jhnQn/zU4rDF4dPEKqVFAYSVQVHeB4rLUXDbnDeqhe18n6ZO+sBqBnXfrqG/YNNwW1gxAWkALPcZlabOOUbCqyc9PrdDNqv6+COcj9zpXibXTN3bABnqLy3PrZJSBP4pSbxa58PphuSKNxvhr8zf75e/Rlv/V6ot0hvVyj4bvpgtfTIDdnnvuv594QkeEQnMtzUFVJE8hBuqnnjqHwgT2znOk84gtKebL4juMI0mzWAvSk4o6TubSCyPow0B0dPJHo/55R7tXJiGUF2llD4ThATdE7ZiZmjYsuxxeTmLuhznnhTqC/kCtZstxib6OKj6nwUJO6ziPEndKExw66sAwnI4F3MkOifCBLEPoTjh5fYcXqSvmdG7ehf9xpHesZhFHG3jAy55QOPQISZdXotpOxTpBXUETsp9WnqpMXLxaBIVFhBc77i+Rwc2ce03Z5AkKhq8Y949XzsvYyYYvB9TLwITOT14YT46gGH23xmnZLCszgMIhkNTMg78a2tK1qlyRzEcoXdD5E43x+jedbnzhmKWg2Zeejz9Ulmx3e65BG/ulwuGmob8ZM3SZBUCBzk3Kc1dF33VsBuMpHKkmvLcRP/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(66556008)(66446008)(76116006)(64756008)(66476007)(110136005)(55016003)(66946007)(7416002)(54906003)(316002)(33656002)(83380400001)(2906002)(478600001)(71200400001)(8676002)(8936002)(4326008)(52536014)(86362001)(38100700002)(53546011)(9686003)(7696005)(41300700001)(6506007)(122000001)(38070700009)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CuPosz/Ev6pu7EBCXGV7/HmmdZ9DFSoZXK8B+y17ObT3yFr8FQEkyDUO7J6t?=
 =?us-ascii?Q?HLbs9iqHp/X/KrkibJj48zL1ya1zJAJnNwaT0T2SncNs0U0pbZBpG0BMI+vp?=
 =?us-ascii?Q?arsq8GLBVD+Yjji3A6SykbKgE9fcDmvzoVLubkIV20ZADf145aPPOffveL5j?=
 =?us-ascii?Q?Jsf+O6ieihvXH4EFHySxH2Eaq9MrHMSXQUm/SIQyXIlr+WY9DsG3eRFbjP2z?=
 =?us-ascii?Q?Ya2XwTWHRfDWd89lpCgkVqqDIKJR3z40lqJ2oBZowbrMjM69luNd0fZX+4dd?=
 =?us-ascii?Q?StAcoM3xSSWUPjVLESrvrx4Dbne2YBBridsaFfg1QWmb7b1wFKLt8LLETV6d?=
 =?us-ascii?Q?3EA/+eiiBQmrUA+B/mfKPqX+O75N3TXbpI2gzA1mTokEwMd8HLAZhzASv8En?=
 =?us-ascii?Q?wZktZJwZK4ela74J12pY80Y4TD/IprUK306Js4obje6F4naAfW5GMzLcUJHH?=
 =?us-ascii?Q?WjGPoRcyFy0sYM9C6iBC4+oeKZsW8vFm8csqlikzjjSbgEfjkE1FQSF22gT+?=
 =?us-ascii?Q?7CEBBosodIcQp31sd6/FyUcoUmaUfNVp81Oeq+7O3nsMumOjpA81Ed8BHmvj?=
 =?us-ascii?Q?XVYTvxzzh8J4BP5QdLwTDKwUG9Vp+HB8qpRrh7ZXFaesYcvrTInwnNCg1hys?=
 =?us-ascii?Q?gTj77qCSI5YZcsRLpSpjZM+qs7HoqoRDauVL4+xRSlN0rAs/RbTFmLKDL6PT?=
 =?us-ascii?Q?nVZcPZjVa5lI6EKN2F+IwQB7e5zMRsPOD1S2qND4W2KPyFQxEEDz3oal+jSq?=
 =?us-ascii?Q?6KmePCi0MNvkbezNRhkxY9DxgzdUljBSgbCJAQkC7Ctdy7RzPxuW0R1iqy7n?=
 =?us-ascii?Q?lT/HAvpgf8GNWWNCpL8l0C0bPABtNc1eKSmLZ+8wru9fdct6B6V+56FIx/OI?=
 =?us-ascii?Q?kXbEq0ZYPqx9yo4WceNgRl7zHaoG81pSaJBbEVCXDigD+kjtZKsOC747W0/y?=
 =?us-ascii?Q?52sVqkUxc+ZI3GE3KlCEJb7HbbHvw4HY5rwfYYt8bHS0gQgKFEs8v0+gHGsj?=
 =?us-ascii?Q?Bkee7XM4mSVTFO24UDUekxNPyVgjdtUC5rgjgYlQhq/6mo7FwCA88PQkDpHn?=
 =?us-ascii?Q?2mPdVUX3CvXIWDgmi2KDA/K1UBxvbbcV5GvcVdcu789nwasCi5YTzB0u0xFs?=
 =?us-ascii?Q?D8pH6bh1+10Sfh4pqzVUJM36TKewBqjADt5F/z3t4cXOxY7Wp/0yMjsmjWTO?=
 =?us-ascii?Q?eK/8Y3GQtiKwlFmTfdzWFq0dYkIJcjWMy/36N2oACF9CLJoLQAPoFWx9NjJi?=
 =?us-ascii?Q?lbB17D1fUU97aNSiDoZqUZM8dDW/+h5/BOrwQAQMLCpOGhSu1vOuE/VXlf6W?=
 =?us-ascii?Q?olCjqz+iK0JY6nP/tmdTkj0oWf9LIm+TWGEKkL5rNHVjvGRVTwSL3hVvrcn0?=
 =?us-ascii?Q?5RUByzVweconkxfNteCmej4zThb7X6rw6ZcfTLKpANqWkGLVyLnHWvIZnuq5?=
 =?us-ascii?Q?NGVmx2kzggOSXfzKD5ODl2nXKy6+DPU9HcIpDZ5IzyEatzeaBT2p5/+ZJY0P?=
 =?us-ascii?Q?YkslT9wD9eKQqEyauBHGXLUdpShChmQUjJ6j4l99WAHvrvVjr3fOmw+11hZA?=
 =?us-ascii?Q?I3kK34f9Xe05ysDAb3sO6URL8n/ViE1Wz4pSukGfNDttqLpO0DY8VAOiVs/B?=
 =?us-ascii?Q?Yw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffac354-1915-4d3b-1209-08dbf8cd5cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2023 15:41:51.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSzqGnQCP8bbb11xLIghGCE3N1j4kBeMBqqtQhqbYG/dmvFU8vyLeQiW2NZhwitWsk2Xn1xO9wwxpWk+6V+LGDqr7Hc2QB9jPjlpOKl2euQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9641

Hi Krzysztof Kozlowski,

Thanks for the feedback.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, December 8, 2023 7:56 AM
> Subject: Re: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062
> to json-schema
>=20
> On 07/12/2023 18:03, Biju Das wrote:
>=20
> Trim the quote from irrelevant context, especially if your email client
> malforms replies... (because it does)
>=20
> >>> @@ -35,6 +42,19 @@ properties:
> >>>    "#interrupt-cells":
> >>>      const: 2
> >>>
> >>> +  gpio:
> >>
> >> Old binding did not have such node and nothing in commit msg
> >> explained changes from pure conversion.
> >
> > OK will update the commit message. Check patch complained about
> undocumented compatible.
> >
> >>
> >>> +    type: object
> >>> +    $ref: /schemas/gpio/gpio.yaml#
> >>
> >> ?!? Why? First: It's always selected. Second, so you have two gpio
> >> controllers? And original binding had 0? Why this is not explained at
> all?
> >> Open the binding and look at its properties.
> >
> >
> > I have referred[1] and [2] to add gpio controller property.
> >
>=20
> But does it make sense? Don't just blindly copy things, but actually
> investigate whether this is correct DTS.

It is indeed incorrect.=20

I have tested GPIO on my board. The gpio controller must be defined in pare=
nt node.
Otherwise gpio probe will fail.

the dt example is as below

da9062: pmic@58 {
		compatible =3D "dlg,da9062";
		reg =3D <0x58>;
		gpio-controller;
 		#gpio-cells =3D <2>;

		sd0-pwr-sel {
			gpio-hog;
			gpios =3D <1 0>;
			input;
			line-name =3D "SD0_PWR_SEL";
		};

		sd1-pwr-sel {
			gpio-hog;
			gpios =3D <2 0>;
			input;
			line-name =3D "SD1_PWR_SEL";
		};

		sw-et0-en {
			gpio-hog;
			gpios =3D <3 0>;
			input;
			line-name =3D "SW_ET0_EN#";
		};

		pmic-good {
			gpio-hog;
			gpios =3D <4 0>;
			output-high;
			line-name =3D "PMIC_PGOOD";
		};

		da9062_rtc: rtc {
			compatible =3D "dlg,da9062-rtc";
		};

		da9062_onkey: onkey {
			compatible =3D "dlg,da9062-onkey";
			status =3D "disabled";
		};

		watchdog {
			compatible =3D "dlg,da9062-watchdog";
			status =3D "disabled";
		};

		thermal {
			compatible =3D "dlg,da9062-thermal";
			status =3D "disabled";
		};

		gpio {
			compatible =3D "dlg,da9062-gpio";
		};
	};


>=20
> >
> >>
> >>
> >>> +    unevaluatedProperties: false
> >>> +    properties:
> >>> +      compatible:
> >>> +        const: dlg,da9062-gpio
> >>> +
> >>> +  gpio-controller: true
> >>
> >> And here is the second gpio-controller...
> >
> > So you mean it is redundant as $ref: /schemas/gpio/gpio.yaml has
> > already defined gpio-controller for this object??
>=20
> I meant this would mean you have two GPIO controllers. Why one device
> would have two GPIO controllers? Please answer to this in commit msg, so
> there will be no questions/concerns. You have entire commit msg to explai=
n
> all weird and unexpected things with this binding.

This is correct. gpio-controller should be defined in the parent node.
Otherwise gpio probe will fail.

>=20
> ...
>=20
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> >>> +    i2c {
> >>> +      #address-cells =3D <1>;
> >>> +      #size-cells =3D <0>;
> >>> +      pmic@58 {
> >>> +        compatible =3D "dlg,da9062";
> >>> +        reg =3D <0x58>;
> >>> +        #interrupt-cells =3D <2>;
> >>> +        interrupt-parent =3D <&gpio1>;
> >>> +        interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
> >>> +        interrupt-controller;
> >>> +
> >>> +        gpio {
> >>> +          compatible =3D "dlg,da9062-gpio";
> >>> +          status =3D "disabled";
> >>
> >> Why?
>=20
> Why disabling? Drop all statuses from all your binding examples.
>=20
> >> Where are gpio-controller and cells? For this node and for parent?
> >> Why this example is incomplete?
> >
> > Currently I don't see any driver is using this compatible other than
> MFD.
>=20
> Open the MFD so you will see it...

Actually, found the driver and tested GPIOs,=20
For input gpio, I can see the sd1_pwr_sel values are=20
toggled during card insert/removal.=20
For outout gpio,
System is entering into reset mode, if I set output-low in DT. So set
Init state as output-high to avoid reset.

drivers/pinctrl/pinctrl-da9062.c

Cheers,
Biju


