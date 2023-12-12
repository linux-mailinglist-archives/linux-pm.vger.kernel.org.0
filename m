Return-Path: <linux-pm+bounces-992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D180F437
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A2281CC9
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30497B3D2;
	Tue, 12 Dec 2023 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fbKkRwS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D446E4;
	Tue, 12 Dec 2023 09:16:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJfxargpIPploQ+y4dXHbN4vs0J0DYI+gfz/m8SWsNTvNrfyrsfnqcyWYysb68Rp+qQ+z4pgRul4W+Kl0obetNr/gLplC3Zo0eMNShGTlF9M9RzVHUUpIL4Izg8b/l5e5SvM/q6U9HiZ8u99xPeL+3u7+VbtLO2DM+NEsbw1B9PtHiHqg5yxMLf2BQ00RuTXj7Us/nidmKVLVpzjiQnY94CkRyZh4u/uuVcUyBU1N0HkfERF6IddxS/YHBa2JiX7ICWLpmF1Fo5lH6FcugC1DpOlOTS0MEGCYP3mCbQMVGfCdkY9tsHksu5NggALUzogBNUvnGzrMQt744hmSbScEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbo0Az2G1j6VieEvASdGSY/LtJsQ+25Vhj521966QwU=;
 b=KpUI1VbnL/ygVFgC8BjewZ9lHTXgfhElHRG6Fq5dj0scOb2oASidgKyk180A1p+rGJyDnG54C070UEzQphDaFQYwCPz7H22OpebvDv5Otr6caplZvUwIKvIAD2lPV5fRbBkY/2z00JlFvmOlAuVcCeBeYm3Qbpd9Rq0YQVYqZVVvNStwglVyjfymtM6Zut05tl0U5wN/KKxBSdPmDTs8OVrGjEEOQyci9pQR+0oY2Nzs6HmFJQwktl6yHynW/c6XEv/Kh6PNvTebRhc5wdf7h9vJXTWJSHtBrB6Go7/uLfFjWeMsR5LwJlRN4dXPZqL0nwMlq8YDaLVfeOdEiRvXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbo0Az2G1j6VieEvASdGSY/LtJsQ+25Vhj521966QwU=;
 b=fbKkRwS/Q+uWlOPd3tkDXTpziezZoNALQKe4sPjVkkfMd3mzcPmI+gCqHkVeQ9iA8z52DgDl+IQNqa/IdYtYRTSv7J021TxCkFK2aC9owZuHvNSSpJHGdVZ0602Mq33i8iq0O70FRBL+vg4rWJO+a7lhGgFAvMk0oAa5FAXQ2lk=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB9279.jpnprd01.prod.outlook.com
 (2603:1096:400:1a2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 17:16:20 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 17:16:18 +0000
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
Thread-Index: AQHaK2+CO5V9wAfdBEqN6/S8f3RG87Cka12AgAADMCCAAXJDgIAABW6w
Date: Tue, 12 Dec 2023 17:16:18 +0000
Message-ID:
 <TYCPR01MB11269E81E35B3D63AADCF1DDA868EA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231210134717.94020-1-biju.das.jz@bp.renesas.com>
 <20231210134717.94020-9-biju.das.jz@bp.renesas.com>
 <20231211-dissuade-skirt-5961ef525497@spud>
 <TYCPR01MB112697AA2A3BC9F58C7BF4B67868FA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <20231212-enrich-borax-7943611e2586@spud>
In-Reply-To: <20231212-enrich-borax-7943611e2586@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB9279:EE_
x-ms-office365-filtering-correlation-id: af0cf0d4-09e7-4c35-1993-08dbfb360e05
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RyMo3lWjk+PRx+ZelL5Nin/aaUW1svwLcQFBX3P+3sVVn0snah0SnlDb4qw3164ooRBpPdzMpAqV8Qs/6ddLoXCU5K0UHjJ8dloN4dQUnaciltm2VOlncjROAjklMKWH9Ak1E3Q/wLsjoEmjJBAT0cuqE3ECuJBTe3RGkGqMlVmypgC8QbWvzuVPyfclacXRYb+0o+ViziloMvYJxJKY6THYsMtR9Vyit6emk6IkA//ww72x1wc8Umyr+kGJ4M4u5r8IbmMEGjMVXiaTzNSeSUUoHPCAg/4jGeP5n6TCVJDj0S8JNcWG/jXuQAIBEC1+Sefj9zjbVYqokfGjat/ihpWsDXXFIG04HaXz5BeXv9oUST/+XDMvxKAYlTHWaSCtL2G84glIPrJd12Qv4jy1vUW+DEH19ywe31EcCmWUaKY4vuBw11HJtOTVlLTqCI34fSMMoKeB0IRnWYbt4ZzOQJRDTSWPKY8izq0/EZjr35tF3F6OVKO8t19Xn3vSZ1jVPBb1pmcKDuAGj90z2bVk01NctDI0FlE324OmysgGxsh6gaVDPh6GG9znr6D6TVaFv3MfW0+QMNGU7SIblPI97Wa1C24Ak1s75w2MKtoZQ70TiejDuboFW78JiS2aRr9+8IGbIB8z2OZ1qqKrILvcZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(2906002)(41300700001)(66946007)(86362001)(64756008)(33656002)(66446008)(6916009)(66476007)(66556008)(122000001)(76116006)(38100700002)(54906003)(9686003)(53546011)(966005)(478600001)(71200400001)(7696005)(6506007)(26005)(83380400001)(7416002)(5660300002)(8936002)(38070700009)(8676002)(316002)(52536014)(4326008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RIj1LBF2rjJqiO/+XlrmeEwnwJyY0kqhRo9QXkZaO5HcZEJOvqM8w1+t8l1v?=
 =?us-ascii?Q?lOTyru73nK5VJ/4qw6M+gb1AX654T+W9GsqwLwSt0NTC7lYU6h5QjRbKh9tl?=
 =?us-ascii?Q?adX1czvNE60Z2/VMQW/bLEblmqwx5LLV8ptj0F1xKIKJg9p0RYqguIRy0EYX?=
 =?us-ascii?Q?WqwP2N7NG9v5UiWwMF7+KApsSwPur6nFPjSiy81CqAJr165Wb8o0wSsulBZ0?=
 =?us-ascii?Q?WCBugzEDGmAXdH5ISYFvP9Jtryd4s4Qan7ac1wymGrMrhMEAyE5pSLen/sgQ?=
 =?us-ascii?Q?kkt4OpDohx/YgDolAULdIbkXq81bOHD4hPb8z7PrrajajIfBv5+Y/trXpke5?=
 =?us-ascii?Q?sJx4YYvoKJF2lY3TnqcDRHrhvzhPyrxZiJ8SHcRMV5f8uGSHvPn9uFTy9lV7?=
 =?us-ascii?Q?cB7YHJWTMlJ/3QleGl03EetFo8+xGQSDe5OMo+BvixkGT/QGuJG6rzrc0g8e?=
 =?us-ascii?Q?TqsAhhtXUUOsmBoBN9E5O2oHCp5QnBwZ2jqckPdfBDxjRwWvV9p15qnF7N0i?=
 =?us-ascii?Q?anB8YqX+1u2XAPRMPyZMs0bz4DZcEUEIHyoB4DtA8JVDZpAoW4ljbImdetjW?=
 =?us-ascii?Q?Ym1A6NJ669jij9W13s3MeShseBabXBp+3zcwUhkrE0ExUo9T+dnZ0+QHnUgk?=
 =?us-ascii?Q?FCNjIJZTsPUvs0+zbFNaAwYhH0Dt0isUnqcIi9JkS3yFTZ5APT/KneZtRym7?=
 =?us-ascii?Q?xJap8yMpJulJNSGHMK3SoU7X8t04cYxCWO5bzywVCNe7dC6iXC2jFDMapLrB?=
 =?us-ascii?Q?IPE4oEVMBmR2dhhpo+ScA90egFAFQpqDaqRkDDk0uPLaQiM9xFur7HDBKab9?=
 =?us-ascii?Q?0xMb8SYmwiwtXn0H1YYqQGmPg0jz34ieVJQJaDdEtyytZXxWYV1UuU1GmoRD?=
 =?us-ascii?Q?ZlmqQIrC+83+eDCPjb+wzem/hhhmcdjOwXZu8Oevovwzrx4PBvIejGfEpL1y?=
 =?us-ascii?Q?XPAPkWj6Lem4ZU7LSY4dYMTHVNe2tDYQByA8/F7Pv//NQM6QrYn5XHUk9mEw?=
 =?us-ascii?Q?PYLzmaX9WRKcYLtz1JsG/8BFAftBrMGD4AXYnUMbI0nG6+cVIeZYTzYdVOTJ?=
 =?us-ascii?Q?nKHF4tKwBjWnjgARTQnxiRf5HVropHm4LfuzeZVQ+r//RwyL/qFhy93cQ6Tk?=
 =?us-ascii?Q?D5A67WDXe9otCirqqoDVIoBzJVfVYhpsx4QABeQaSvmINYoMv87d3aOvj8B+?=
 =?us-ascii?Q?8aoYsiCRD32sZpVBloR7haV1S8V+gzBByvuOkkBZOlM3H42Zi3Lb5K0dOit9?=
 =?us-ascii?Q?mIh5utLJ7GSsWlb3yKc3KuvWuBN1/2ZHE2Irh68RE2+d5ka+kWvo2O8h/Yfv?=
 =?us-ascii?Q?fRGEOA/Y6ETKR8OqTAiGg7iw42ZYO3WwfE2DnJHYP+rDr3Ngf2VLvL77jAng?=
 =?us-ascii?Q?gc5ANh+pw5AKlAQwihUybJl6Dp3v2tgohsvMhDSz6zexM0Gv2BNuimjiWToa?=
 =?us-ascii?Q?GSBsL6zI+cykgqWCatfUVqA7cRlq8LXSjqoG/QexNpLtNkAkDsAMihDz/5Oz?=
 =?us-ascii?Q?/1eIrhRIm8GsHdSZhCYYbvKihENz85Mme3h9T6Y51BUH+U1IOlPIDlP/pX4a?=
 =?us-ascii?Q?jCKHrFOWdC7wPAq1OGvQ5ff4Bhx6LnS5PPrhH+EomJ626/aXl6Ps13KQAWvh?=
 =?us-ascii?Q?Eg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: af0cf0d4-09e7-4c35-1993-08dbfb360e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 17:16:18.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y41vXZb/seSydTYKv+Y0MIvbI9gqkP8mL/92Vr5owMp4rmRHlwtf7V0blBDw7Xp3p/YgXpwE7lKFIFTnPBcjrIKPUBbINdQvpowRl95pQZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9279

Hi Conor Dooley,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, December 12, 2023 4:54 PM
> Subject: Re: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062
> to json-schema
>=20
> On Mon, Dec 11, 2023 at 06:51:14PM +0000, Biju Das wrote:
> > Hi Conor Dooley,
> >
> > Thanks for the feedback.
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Monday, December 11, 2023 6:38 PM
> > > Subject: Re: [PATCH v5 8/8] dt-bindings: mfd: dlg,da9063: Convert
> > > da9062 to json-schema
> > >
> > > On Sun, Dec 10, 2023 at 01:47:17PM +0000, Biju Das wrote:
> > > > Convert the da9062 PMIC device tree binding documentation to json-
> > > schema.
> > > >
> > > > Document the missing gpio child node for da9062.
> > > >
> > > > While at it, update description with link to product information
> > > > and example.
> > > >
> > > > The missing child node with of_compatible defined in MFD_CELL_OF
> > > > is causing the below warning message:
> > > > da9062-gpio: Failed to locate of_node [id: -1]
> > > >
> > > > So, make all child nodes with of_compatible defined in struct
> > > > mfd_cell as required property for da906{1,2} devices.
> > >
> > > > +  gpio-controller: true
> > > > +
> > > > +  "#gpio-cells":
> > > > +    const: 2
> > > > +
> > > > +  gpio:
> > > > +    type: object
> > > > +    additionalProperties: false
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: dlg,da9062-gpio
> > >
> > > > +  - |
> > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> > > > +    i2c {
> > > > +      #address-cells =3D <1>;
> > > > +      #size-cells =3D <0>;
> > > > +      pmic@58 {
> > > > +        compatible =3D "dlg,da9062";
> > > > +        reg =3D <0x58>;
> > > > +        gpio-controller;
> > > > +        #gpio-cells =3D <2>;
> > >
> > > > +        gpio {
> > > > +          compatible =3D "dlg,da9062-gpio";
> > > > +        };
> > >
> > > I know you had some conversation with Krzysztof, but I still don;t
> > > really follow this. Why is the parent, rather than the child, the
> > > one that gets the "gpio-controller" and "#gpio-cells" properties?
> > > The commit message just mentions why missing child node was added,
> > > but not the reason for the gpio properties being added at what appear=
s
> to be the "wrong" level.
> >
> >
> > Please see [1], The driver is checking against parent "gpio-controller"
> >
> > [1]
> > https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/pinctrl/pinct
> > rl-da9062.c#L270
>=20
> I would appreciate if you could note in your commit message the rationale
> behind the strange setup. Citing the existing driver users etc would be
> helpful.

OK, I don't add this because the existing binding add this property in pare=
nt
and driver is based on this documentation.

There is no harm in adding this info in commit message as we are converting=
 .txt into .yaml.

Cheers,
Biju




