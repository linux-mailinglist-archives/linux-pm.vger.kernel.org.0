Return-Path: <linux-pm+bounces-683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A580392A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 16:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4F11F21178
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B012CCB0;
	Mon,  4 Dec 2023 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="j/bi3yMO"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB43A4;
	Mon,  4 Dec 2023 07:49:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+CS6FxYQc36/FBcD/38MoDyU6H3mIoXm/4EwQWQspVFWWUQ/TrxrSOPhVa0iY6J91NRBQXP9ImdgZirMNYj4U7hqA6ToX+doVUoxjG0kXXkXJIsJC87YE4Ex9AY02jwZHZN1sCgj0ZoSRjTZ46eLu6Kgv7XFcwYG+egAZ9Qu3ZBRteCHE0LJXK3TtJ2Hp/5BU80bDlJeB31/RTlH+WGqIitrSivWgdh/1Y91Rrzy9W/dE3Wbf4Ae9zA6akPu9jkecVpeCcYOajjvN+H92Im4lXnhvL1b/1/ASemg/Xnzn6ptDA7ElnXjdLslYNuuC+adliDrvOxTDIthWlFxM3QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTOGB/erSm+V2kgc7ZuCC9stsKP89Wz+i6n/C6RUKUE=;
 b=mRs1C1ihfpKreQAR4pYljmZKK9yjvLGvH6UK5sNe/7DBY8P49qdlTvvB6Z+qYNdpBnjNbaVHqmrrzpRJ3rmJL9ylXmWbjRZHLAM3gZzB4rRAF3ZKe7RKCdU4OohI5x88ojmEo7fmPvUET7XcdQqr7tZlp2fYPVKb83E4AQLDMiKEYSpeyAyvJDOFG+uourSx/TOGFDcQxnqyfQWGDmh/chcT7mHIcuibwrDpkxRxaibqG10s2UKrN/qiRxLl/gawoT1YYXrMLZap0vFJZtcK8gQyWX1D+QS0+JYh0xQlYlo++xoQxJ8wpVM6Fg0sF9jnQHagUCMu5Zv6v563NxCXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTOGB/erSm+V2kgc7ZuCC9stsKP89Wz+i6n/C6RUKUE=;
 b=j/bi3yMOb7mRyE/bNxubNC2qj+Hq4oQsx9pBqum4R46crb/fDCASWYQ3nlx6bKaZJuUnbaTUOQV8Q1uJeprueyyqEc7MsqcajHDiZr1CPeJOE5KdBcKuSZN1sdlWb4eQZBorM/nFmJhJAasMZilQLFs2/9WxECALXa5JpD65GUY=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB6144.jpnprd01.prod.outlook.com
 (2603:1096:400:4c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 15:49:44 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 15:49:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2} thermal
 to json-schema
Thread-Topic: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
Thread-Index: AQHaJVVpNr8VVPZoO0mAS8LwJgirUrCZPhWAgAAJ6TA=
Date: Mon, 4 Dec 2023 15:49:44 +0000
Message-ID:
 <TYCPR01MB1126965FC215410679E8DD3D88686A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231202192536.266885-1-biju.das.jz@bp.renesas.com>
 <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
 <20231204151303.GB1260709-robh@kernel.org>
In-Reply-To: <20231204151303.GB1260709-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB6144:EE_
x-ms-office365-filtering-correlation-id: 20fce9f4-edb2-4e68-3aaa-08dbf4e0a2bf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HDcS1HlWs+OgUne44zbalJTXZI7gW8lFhaW3pSjUqPqBgJutmM6HFnEo52RAK4qsCGzL321ODSwZdXEdxvqOhjcR8dRhE8iEH80xR4bOJnMkvml6FaMKRfLuWNfl27Vp4tp/nsqdhqn76dP4zbDUy8qv9J8ANMVWUc8ttGu9PLnR8Xs/Oem7k49rDoIJNopqnPw1uJCkkwc/HuEZoDOZWQU7PqDBFYXq8xiPFRNz9nPnQw4XtmPbdjTxMU4J5B+3BwdG57PFYfKQ6RN2W9vjrilmKdxleh/zRp1bgkLNjhKXyTG6RHApXVjiQeVvMcCDmd69P2zn2IVIfbB2Pt47h5RhiOo9bzXI+KDlw0iQZvwMlODsFLuhupwjPB+sJ1ccKPQK8YBaej6E4qnPLrtS9/o4P47aL0RNS0LcWA1pAalygCH3IdJcHAaP4HZKhNOYa6KrMXd61NI/fbvYU5Ib1MJAbsy5XMZfVXaqwYApNsJ7QQA9C7p/znPGW/ilUTmK7aERDqFW5RAwZrBdbh55noWzz7iIpzWi5Hu+fEQVGfI+4mMJ/FeWVzMS/6SsyOVG2duC0n9oGflfHuHv3maLs5EbrczZXbSY+GBAiwDZV3+OL/JsMrbcOsUwD230b/5k
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(52536014)(5660300002)(7416002)(2906002)(38070700009)(33656002)(86362001)(41300700001)(6506007)(7696005)(71200400001)(9686003)(53546011)(478600001)(55016003)(38100700002)(83380400001)(26005)(66446008)(76116006)(66946007)(66556008)(316002)(66476007)(6916009)(54906003)(64756008)(4326008)(8676002)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mD5y7K4P4skoDzXHLgPKmOVATgOPq6j//p/wtvsoN47V+W1Gf6G9xDB3oyX1?=
 =?us-ascii?Q?iuUFAv7kcDc49Db3uipb3QtiSxRMscNDVlHcBxQZ1O5z78QuceJyNjPbD1kL?=
 =?us-ascii?Q?wZfjP86rGFiVN4UCNkR2YVL9DKMAgcn1dzjYW2iDrrS6045XUqzBM4qfFQd3?=
 =?us-ascii?Q?n3I0Tz5pmE0vLs1HZ6s54NCTG88PrFxVeW1WAd5TWInDhTaaJT3/DOq1Ngkx?=
 =?us-ascii?Q?rJ4Li/X5SfdaYqafPf44acZxFDJp4CSoGVX+wPSbCB0yEUGVCSk+VQHQxgzC?=
 =?us-ascii?Q?HzO09QIRZXvQDTrBtE5YjrsDVHNDNnUUpBRfbv5I7n3QULXjQJ/txez/epGg?=
 =?us-ascii?Q?E6zR2czYcReuObrgAPUDjBaFnLTQTIvoiY6mYOjMGd/g9dJyoChVqv5mhiI3?=
 =?us-ascii?Q?BZwGp1Xh+1CyBhrf/KTd7Y5fUlyQrIjjPlMGFtEWwT0FleVvtF/vD7pMF61E?=
 =?us-ascii?Q?pAypBIYltvzghRRcQOcWetiCf+Xl6UUGflVJEsB4qAt2QEJQbc7mCgQDJZLW?=
 =?us-ascii?Q?5v43kqPvH4kC1S6epu5DU6eWppNOjOk1zfuyfVqJ5zTNXCpUHc18qg7fxwK3?=
 =?us-ascii?Q?oZcIilZ7BbOXLEcyboE/PN2SpTOoeJWFy+TPm3+Ij8W//74W2jx2+bnnZVLB?=
 =?us-ascii?Q?DY3oYfiZFvd3r+5cNidD4AH8IXiuh/yd96MdWHq2jfrdA43QlP0ZgEmIXuSK?=
 =?us-ascii?Q?Q1fMt+VT47FSqdht/1B8LplM5o5dLHRNo5GcZZ+Of1ETiV8D5F1uHZZ72htA?=
 =?us-ascii?Q?L/mDHH+MwTD5x32HzKbGIHDFi/3NQpwrmErCd9h2xHp4tST2/308dkTBuvoQ?=
 =?us-ascii?Q?ayr++mHMPjeBxoBbTmuQaP8UpbedfknznFM1ZqSE6oa5G/GEg5ep0wk/WgMa?=
 =?us-ascii?Q?nMw0Me5WjPw7FSR3idhM49zNXXmGEMDnjhMo7aa2xuwyxFgj3kI2pvObjpu4?=
 =?us-ascii?Q?fRsuixYicDkGhtlGXLrYJGoWL7KPNiozApjGQ5IeENLI7Zgcfv9+aL+/dj0t?=
 =?us-ascii?Q?OSu/SIYhqLhDovB7sLR3TwVeffFO/OKuNGDcfqqPwUmwwS7XAsUO2+cxprlA?=
 =?us-ascii?Q?BDfx2oNmrlPbYOfJ7RBLzNOjWhNbMVh2a5adicAXMlZnc6Prd88vqtIixOl+?=
 =?us-ascii?Q?6u7oKDTf20LgjAeO8fAMhkpNf+LVddQ6MKFPWENYKNyZzJHzAdUQrYhb0cl9?=
 =?us-ascii?Q?9xXutTJH19IYtFHvX0KY3K+2LXz5FoGBbvWk7q+hDADJze3tGz9zbpZDk4rG?=
 =?us-ascii?Q?3NO5YF5NiWPTHnTkC37mexXuBb2Ue+xiCKFXf7TEl+YceGyL4OODcNtH93yA?=
 =?us-ascii?Q?II4zZUx3sj3uPaPN7JjPDgrU0Z2aXSCPVup2tIEgJXzoodFgICPEpOZLj8re?=
 =?us-ascii?Q?VqqA+sQjXkE0NrwCsLd8FOJkYRE7mOxHYPprNyJwbdgVbTab6IN+oEp9C9Y2?=
 =?us-ascii?Q?RK3BhmtHmlZ8rYh8qgnktC5oCt6dLCqjvWLCHZi6MERgXPnXFlNEzQOkYdJT?=
 =?us-ascii?Q?uicBFNt2LnbVCEMOh20BAo0K/dVVQR0ndgxXplczcLhgkCdDn98HIKZafchx?=
 =?us-ascii?Q?naNEJdEIEwZnXullGcJc5D+/apnh38T36x/uadLb7xhL2TLi65Wf+jYM1IQt?=
 =?us-ascii?Q?+w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fce9f4-edb2-4e68-3aaa-08dbf4e0a2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 15:49:44.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YoA5jc3pShH5hwDC1ijkzoPGqZwkjto7HgbQS3d5nJRy4kJHF6FLtL6sA4HeOnj1+Zca2u7pSRkGuYWi1JzBskjWDWiB7SzU3FIJNCOOe6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6144

Hi Rob Herring,

Thanks for the feedback.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, December 4, 2023 3:13 PM
> Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
> thermal to json-schema
>=20
> On Sat, Dec 02, 2023 at 07:25:28PM +0000, Biju Das wrote:
> > Convert the da906{1,2} thermal device tree binding documentation to
> > json-schema.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../bindings/thermal/da9062-thermal.txt       | 36 ------------
> >  .../bindings/thermal/dlg,da9062-thermal.yaml  | 58
> > +++++++++++++++++++
> >  2 files changed, 58 insertions(+), 36 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> > b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> > deleted file mode 100644
> > index e241bb5a5584..000000000000
> > --- a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> > +++ /dev/null
> > @@ -1,36 +0,0 @@
> > -* Dialog DA9062/61 TJUNC Thermal Module
> > -
> > -This module is part of the DA9061/DA9062. For more details about
> > entire
> > -DA9062 and DA9061 chips see
> > Documentation/devicetree/bindings/mfd/da9062.txt
> > -
> > -Junction temperature thermal module uses an interrupt signal to
> > identify -high THERMAL_TRIP_HOT temperatures for the PMIC device.
> > -
> > -Required properties:
> > -
> > -- compatible: should be one of the following valid compatible string
> lines:
> > -        "dlg,da9061-thermal", "dlg,da9062-thermal"
> > -        "dlg,da9062-thermal"
> > -
> > -Optional properties:
> > -
> > -- polling-delay-passive : Specify the polling period, measured in
> > -    milliseconds, between thermal zone device update checks.
> > -
> > -Example: DA9062
> > -
> > -	pmic0: da9062@58 {
> > -		thermal {
> > -			compatible =3D "dlg,da9062-thermal";
> > -			polling-delay-passive =3D <3000>;
> > -		};
> > -	};
> > -
> > -Example: DA9061 using a fall-back compatible for the DA9062 onkey
> > driver
> > -
> > -	pmic0: da9061@58 {
> > -		thermal {
> > -			compatible =3D "dlg,da9061-thermal", "dlg,da9062-thermal";
> > -			polling-delay-passive =3D <3000>;
> > -		};
> > -	};
> > diff --git
> > a/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> > b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> > new file mode 100644
> > index 000000000000..0021ebdd83a0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yam
> > +++ l
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +
> > +title: Dialog DA9062/61 TJUNC Thermal Module
> > +
> > +description:
> > +  This module is part of the DA9061/DA9062. For more details about
> > +entire
> > +  DA9062 and DA9061 chips see
> > +Documentation/devicetree/bindings/mfd/da9062.txt
> > +
> > +  Junction temperature thermal module uses an interrupt signal to
> > + identify  high THERMAL_TRIP_HOT temperatures for the PMIC device.
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - dlg,da9062-thermal
> > +      - items:
> > +          - enum:
> > +              - dlg,da9061-thermal
> > +          - const: dlg,da9062-thermal # da9062-thermal fallback
> > +
> > +  polling-delay-passive:
> > +    description:
> > +      Specify the polling period, measured in milliseconds, between
> > +      thermal zone device update checks.
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      pmic@58 {
> > +        compatible =3D "dlg,da9062";
> > +        reg =3D <0x58>;
> > +        interrupt-parent =3D <&gpio6>;
> > +        interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> > +        interrupt-controller;
> > +
> > +        thermal {
> > +          compatible =3D "dlg,da9062-thermal";
> > +          polling-delay-passive =3D <3000>;
> > +        };
> > +      };
> > +    };
>=20
> Just drop the example here. No need for 2 examples, just provide 1
> complete example in the MFD schema.
>=20
> With that,

OK, will drop example in the next version.

Cheers,
Biju

>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> Rob

