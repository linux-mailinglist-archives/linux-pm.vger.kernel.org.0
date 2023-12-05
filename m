Return-Path: <linux-pm+bounces-718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65C1805E21
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 19:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE5281D7A
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E3675DB;
	Tue,  5 Dec 2023 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VbD/UFgn"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2101.outbound.protection.outlook.com [40.107.114.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709EBA;
	Tue,  5 Dec 2023 10:52:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igKO5zAaEiEvlX2un9Fnzch5pAZT3HCWtyfQs5gawF2WR0HysW7bcC97/AXD13itnNbaHoKotYFvNLF0fNnwAahNI39ifxcETBLQMZkNUtoXPeB1xRT9WhQty38rYPWUkABMdKNK2Bo7lcXPGna4Dqg4xhKRlsEBMLA8uvm2nzdZxPm8SonGQokQz3nX8lFbM5xX0gIm8SOnEIGts/lajQQbjlwtzef1tsTOP1OjyFzJ7Fm+oZVvxCYRYyZXzI+K3OY6cIeWWK1VPvc+Li5IHlG4lKXN9OZ1u9xFeyjAB8C3bQ6N4Ot0BU43thAWDdyY+HduKqXsiMw1BhzlVCmY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9XzRg3ACDkP1zdbVpoWjZgU/QH4VUURAfywj1wKbeQ=;
 b=aHj7xCvLLZuyqVhNH02/AucLITH+9lylN5FtSv+HCnDk4JdYXr0AUFND+FlBPI0B2H4O1jMz4CmOjDU2gEhU81leO7ApZpz/8FxJIRWbjOs4puhCYvX8YwIlj0xNIHpMIbzTh1yRudJ4lxHTvB89qVmF86+wwKvSMpf9u+xfBfamEo6sAZOdYR9XzI1sPeUza7yHHUWNX7IEcvOe9nwl6lX71YXOpOKzLvREhDRwbRFOyLRDu8ce7YGt37o/gliCTpx69kI9fYaeRfjZavJ+kiPOIWvFgb7fTEgdu7lrEfgT1kTQSvLksQEED6smCtcKh/IDOJIShIhAcoZdkXQrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9XzRg3ACDkP1zdbVpoWjZgU/QH4VUURAfywj1wKbeQ=;
 b=VbD/UFgnBiHYPlQC39xW0QI+1Xt5OaNiHLrf8NIJZ+m4hRC5kEmrMRpQkLiNNaoF0bIXFLuI4sNBdUCPhozfC/wVSOPvJVFJE4QajBUchshCU8z6FAmW5+MdWa5eKyuuAKM4ct5nU0WzZXdQo4ViEmULT3u1V68ZyMMGsdOBqgc=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB10245.jpnprd01.prod.outlook.com
 (2603:1096:400:1ee::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:52:50 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 18:52:49 +0000
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
Subject: RE: [PATCH v3.1 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Topic: [PATCH v3.1 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062 to
 json-schema
Thread-Index: AQHaJtbxjTw9ofEJwUS1+GFW3shUgLCa7q8AgAAa4UA=
Date: Tue, 5 Dec 2023 18:52:49 +0000
Message-ID:
 <TYCPR01MB112693ED613DEAF3735282EF38685A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
 <20231204172510.35041-9-biju.das.jz@bp.renesas.com>
 <20231205-negate-matrix-0e55c151017b@spud>
In-Reply-To: <20231205-negate-matrix-0e55c151017b@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB10245:EE_
x-ms-office365-filtering-correlation-id: 3af3fd35-5dfe-483d-456e-08dbf5c36100
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sdI8J25AClrUwnHkv0PWxnoH67xJM6BIUurV3k9UPqeFJUPqRJ8mbSh8ApjgL11/RDTvLOBaRVJzj/I8r6U/+UkDGqr1qbBehSmzGANPACkdVpR8VIgi/wGyYhEkQaBPxo3+b9+oVioXI1h/zQ6SjyfKUWoyh+K645P8VZD0765pvPkJZa6UK8pgAu4rvV6ksDnugx1twukNaiYUiDYF6cx1vMoSi+8hvPKm0zh04RrdCVmUS1s2vIiVoxXrryi95QGbSLF6XIenZ8iiin7r+gGH4wW9JDjMoQ3VzVve3uQZNH7T82nnTpwXVlHQ6/32Ne9ZzQVhMICWdef/ZrBIwxgAWwMNWyXzbLNHgUwEQvU2xUQw9ORbqe506DNOrzZKLx3aUnr4cjuEqiae8YszXd0S0BNvgYFFN5SAkmdx/w4TjSillicXdLPG2ZOn+9f2zp88fShSC8dWsvQps8boVQKy9EbIhJdX0cKAamZbeb4Bj/ri2kf+K4ygr8fEITFrbx0uRDlz3Mx/eLOx844q1JGStJtAj5XMHtKDusrNrFy9ZBPL6IrMAbCN7Df6IfTB5npD9H1+y9lIQexEfhpBG/iWC+wghxuCoIEtzJCmRAI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(122000001)(8676002)(8936002)(4326008)(9686003)(6506007)(53546011)(7696005)(55016003)(83380400001)(26005)(966005)(71200400001)(478600001)(76116006)(66556008)(66476007)(54906003)(66446008)(6916009)(316002)(64756008)(66946007)(2906002)(33656002)(41300700001)(38100700002)(38070700009)(86362001)(52536014)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v6ThqOPcBGb0NrnIH/ngQCMGkCkCXT+RJb+MraG7ATK2/PoQoa/q8sd3noqZ?=
 =?us-ascii?Q?MiOfIDwr+8qCk5CQ+yEeb1rm6qaffvxdHGqWJzCYtTZpbZvfIVaEXqwhvm5a?=
 =?us-ascii?Q?/cWhNqBjQO2iLjhUsYv0UQnPk4ZS1O+leCezbWEejSqVLCPdSdCT9D4QexYs?=
 =?us-ascii?Q?cRF61Pyuh1oAZHEeRjSmqgwdLgq6bYhdKE579V2ZQl6pZbZcR7CW/ZS2ego2?=
 =?us-ascii?Q?MLgH44tENMtdKYB3HdRWqZLH7fFkB4LIeZmMjIh9mctl2BhhJcslX7zDTgDo?=
 =?us-ascii?Q?VUdM4aU/oCT87wpgnqrfqQF63cD7MNo1ifEKP/OCNGbrnlrvwix01+WksRMs?=
 =?us-ascii?Q?0JT8EkW631j5Hk8C+A8ZBknG1lezHUzaM8lAi9zqXydspnsYLvUpP5eucvyQ?=
 =?us-ascii?Q?kOm3A5/U6mqsHx3pOoZGnLLfuckzEoV3OyneUSsFuqcr28c0pc/U06SWRrvw?=
 =?us-ascii?Q?wKN1muDNPAJjKzapIhe68Bpgkj/jcqnj9HBR/+ndhWFWBydf8awt3SLLR2ED?=
 =?us-ascii?Q?uKxAWqSYLdjlKdOXZDlxhCslsL/ejIvuRIqEvXqPoH1hvazqG3qKdbxtwqcO?=
 =?us-ascii?Q?2JuJFrR64j26S/TdH6y2udZoXLp1s1LTSNeNbI9YNJb79qU0HPl2i+7KdTKf?=
 =?us-ascii?Q?pD7bFWIdirbPiaKWYi33ZP9fkI9osty4nApBuOyjx8HD00JeHknhq/FFP4wT?=
 =?us-ascii?Q?kzEjqJOo5hGVeY+/OPt7RCib6cUnnWkCL1d27ATndCJcd+2ZaNGDumhnm6t3?=
 =?us-ascii?Q?DzEQuHWXTKKZSMixoFhc+tgdmgZD1Sl3R+4SBSVZiZJWJKfOS6UcSU3JRL14?=
 =?us-ascii?Q?EWCeWLGcdc71keNHLkHhlLzwqkx1ZG56+ghoo8sFSKIsfY+xImk7Khc6J8BL?=
 =?us-ascii?Q?Kij8MRJ8ZpIbPdEigbWNrF9HbxssoAwR03kHAUqi+Kt7QurB+wI7EURKcO4R?=
 =?us-ascii?Q?jACwzzK3ZAoQfuoS5yXhlQBvU3NxPY4sKLccyukbznGRRP8/0AWo/0+GgQ0i?=
 =?us-ascii?Q?yh2ZRPj6SNVLlEzSOUP9OMXuuU+HnnAaTgZfYdPa/B3y71bJiQThSWKPqNu8?=
 =?us-ascii?Q?FSZUMwFl9ctxQz1bkc6/0tHKiQhh85bwJ5KhgvvLxstt6XSGXeaBp0i+6SpV?=
 =?us-ascii?Q?Gm+QFHaGq7v62Bjs5U6vRIE3CoykuN+0QN5t41zIzu23kXnzxfgWd61dnu+j?=
 =?us-ascii?Q?bI4CSICkbvN7OLHhScL5Wz0+ELaSWHTsQPFK/y6VIOy42ae6uXXcxRE7uQzd?=
 =?us-ascii?Q?iOFyC/Ux+JkoptSn7Wv4D6a/UTLYnXqXsiGMI678GwXXNz41dE9Nhkr/sJLs?=
 =?us-ascii?Q?qYYzzgBKxbbtR0vaFGN0ytf0X+eSyvcSyM30jcM9rdVWrsGapT5N1O0dW5OR?=
 =?us-ascii?Q?dfloMlk5Hnys/8O1pXfh0Rjk9uOB60ITa8q9N2aaabd9Wm5lOq+d1TcKwiKr?=
 =?us-ascii?Q?F0Z1nc10v38C2fXH+VTb9ZtyTTVRV0RPGaThh2i6eefm0wZzcWobzrxP5c7j?=
 =?us-ascii?Q?g+g1ZCl7Wf0mwQOmTubRGO1RXy/8vIdl4LzA2VsfXjA2rv51UvFjFKWux3J0?=
 =?us-ascii?Q?slM2uH4bDXkIh/p2I4GloTyZVoNm/yJJkz8u0ZlJZgtjoxMN2vLYnFZB0GEC?=
 =?us-ascii?Q?Sw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af3fd35-5dfe-483d-456e-08dbf5c36100
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 18:52:49.4529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxzvkgwi9dQUXf1jCrFtZYSsZA4oBzpRIdlJ4nGE2BPeeKT9qN8rs8yhJdKkG8jTH5FmCAMAlripTcmiguco+QxrtPDbkJH7VMxLG7hSZX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10245

Hi Conor Dooley,

Thanks for the feedback.

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, December 5, 2023 5:12 PM
> Subject: Re: [PATCH v3.1 8/8] dt-bindings: mfd: dlg,da9063: Convert da906=
2
> to json-schema
>=20
> On Mon, Dec 04, 2023 at 05:25:10PM +0000, Biju Das wrote:
>=20
> > @@ -60,8 +85,65 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - interrupts
> > -  - interrupt-controller
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - dlg,da9063
> > +              - dlg,da9063l
> > +    then:
> > +      properties:
> > +        thermal: false
> > +        gpio: false
> > +        gpio-controller: false
> > +        "#gpio-cells": false
> > +        regulators:
> > +          patternProperties:
> > +            "^buck[1-4]$": false
> > +      required:
> > +        - interrupts
> > +        - interrupt-controller
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - dlg,da9062
> > +    then:
> > +      properties:
> > +        regulators:
> > +          patternProperties:
> > +            "^(ldo([5-9]|10|11)|bcore([1-2]|s-
> merged)|b(pro|mem|io|peri)|bmem-bio-merged)$": false
> > +      required:
> > +        - gpio
> > +        - onkey
> > +        - rtc
> > +        - thermal
> > +        - watchdog
>=20
> Why are these required for the 9062 (and another set for the 9061)?
> The original binding does not seem to require them, nor does the yaml
> binding for the 9063.

The core drivers for 9063 and 9062 devices are different. Absence of child =
node using da9062 core driver
is giving error messages like (eg: da9062-gpio: Failed to locate of_node [i=
d: -1]).

So, Geert suggested to make them as required one[1]

[1]
https://patchwork.kernel.org/project/linux-renesas-soc/patch/20231201110840=
.37408-6-biju.das.jz@bp.renesas.com/


>=20
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - dlg,da9061
> > +    then:
> > +      properties:
> > +        gpio: false
> > +        gpio-controller: false
> > +        "#gpio-cells": false
> > +        regulators:
> > +          patternProperties:
> > +            "^(ldo([5-9]|10|11)|bcore([1-2]|s-
> merged)|b(pro|mem|io|peri)|bmem-bio-merged|buck4)$": false
> > +        rtc: false
> > +      required:
> > +        - onkey
> > +        - thermal
> > +        - watchdog
> >
> >  additionalProperties: false
> >
> > @@ -118,4 +200,98 @@ examples:
> >          };
> >        };
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/regulator/dlg,da9063-regulator.h>
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      pmic@58 {
> > +        compatible =3D "dlg,da9062";
> > +        reg =3D <0x58>;
> > +        #interrupt-cells =3D <2>;
> > +        interrupt-parent =3D <&gpio1>;
> > +        interrupts =3D <2 IRQ_TYPE_LEVEL_LOW>;
> > +        interrupt-controller;
> > +
> > +        gpio {
> > +          compatible =3D "dlg,da9062-gpio";
> > +          status =3D "disabled";
>=20
> Why add it disabled? This should be enabled IMO.

Same as above.

Cheers,
Biju

>=20
> > +        rtc {
> > +          compatible =3D "dlg,da9062-rtc";
> > +          status =3D "disabled";
> > +        };
> > +
> > +        thermal {
> > +          compatible =3D "dlg,da9062-thermal";
> > +          status =3D "disabled";
> > +        };
>=20
> Ditto for these.
>=20
> Thanks,
> Conor.


