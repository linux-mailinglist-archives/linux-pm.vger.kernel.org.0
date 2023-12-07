Return-Path: <linux-pm+bounces-801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA958808E23
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90775281863
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78757481CD;
	Thu,  7 Dec 2023 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FBl7Xm1M"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BC21709;
	Thu,  7 Dec 2023 09:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOiNt3yhL131I7Q8mY58UjCpcwcpIIsCCqVvl6jeFMeFNgVMw/j4HrUi1yMMxn153Pk3wqTcc5NEN50QU51wSIhLfucRaGnSHUEw8EpKW3OuJEAGE9HmP1oH1vqY6k3eCBbNMBQlwjKcJob7Ok5QsoAf7drFoj9PVn3JKnwT2x3Av46WCTaby8538fm1kQbRw1xUcXHzZCQCrN41AjMEfGFib/nNpyKkyawFK6vkrgomUij56bJlVYILDhD/62ME20wFyQYXu5xxMcP9+RY/od3zSs7V9e5xwFbNOYA9ufcAzD+rAlP4XHUmBfT+VqMndxSVFh59K5cMteBUXh8AuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWbpKvmDWeJpqLX1D+KqnTXBJ6gsknvmgOOARqXcgHQ=;
 b=M0kKzYAWiUhjcXXclXPDLzznobZjN6YvJ2rHfX7ncCowZ/BG+OGurlM/RiRvcKj34EEG7WTfVpkqApGRUba28AM8hkNmAZ4aN4+mYYasQ/F0GV1D1ZmHAx+bwQSkKsZQX+Ql/myo1w5CkPOwmAPGtXRZZ6dNbCExi1RmOrLrototvUPBLFMeg1tvjwpYYoyPrsiP1Kqje2fPX51Rs8iv6MdheKDI8lf0rLfTe4FgwZ9Sp59ySVfd1dmiVROWrF+Jd607MhtM+SZgjT971Jomqa3OgDYgVLFzHvGa3rg5YdWLt7Z0/KHMI54AsvtwziIzbtrU2pg0y50ivbfSHjpjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWbpKvmDWeJpqLX1D+KqnTXBJ6gsknvmgOOARqXcgHQ=;
 b=FBl7Xm1MOa+NJ+Za900iJc4jy79s+bn2pipkqfdSLxsHqTCVY9adn/SCka6wnGacb3hmUmbjezicxUFzrnhgJO2WoQXCk1ZuNBP2zIcOipj0Y3/iLr/mBVCfiAopwihYmPQ7fxUqWlpCYsZ1PUWh8UmFkW6u1jJluVvDSPxxt28=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB8202.jpnprd01.prod.outlook.com
 (2603:1096:604:1a7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 17:03:20 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7091.010; Thu, 7 Dec 2023
 17:03:20 +0000
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
Thread-Index: AQHaKF0O3M4G5vsMkEy5OPyHlzeaZ7Cdgj4AgACF+8A=
Date: Thu, 7 Dec 2023 17:03:19 +0000
Message-ID:
 <TYCPR01MB11269C774B8FFE9E43455EB61868BA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231206155740.5278-1-biju.das.jz@bp.renesas.com>
 <20231206155740.5278-9-biju.das.jz@bp.renesas.com>
 <114c9baf-66d1-4055-a47c-916642b6dedd@linaro.org>
In-Reply-To: <114c9baf-66d1-4055-a47c-916642b6dedd@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB8202:EE_
x-ms-office365-filtering-correlation-id: e0f5610e-404c-4ce6-5f30-08dbf74669f1
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rvDFHKxYpw7zp/TkOicS68+xcHCML62szR0Ai0Y6CWYZcqFw7o2hyEMw1v3cjxnMP+3mYu/fv+fIvdPK25S7QCith4Sat+2ebcX+CnwEg4iJC1RhXt+XjlUSucTuEOPb/LO4Lfar+VzRsJjJJ06oFEOwd480K7gA52XDIs2vg1kPpJVGG6iP+uHbjG9hytcUM9Laxz/4VWJ5s+rNIbnXTtU/1Dch84B1Smj3AXmGcbAqquIkgXART+XbgO726SWbbI7bQp3cWLSsotkdw1y5qjnQUqhO2sZ9caeSGyHjVh6ZGl+fApPYBq/pU6vO3FJ1ag8hKe12PRSfH6v5Ld0FU58arAgaIohKUGgvyWa12BGZRWwNEFTD/lo85QHZgg2MfkUkXxrM3EF6GMlE5Y7E1Z5wGuN37uoWGAyRudvt9pb6Tjw+3pbnjSyF0wHSvNZQLP18roCUWUhP4Xfk62l8bf7MTA7PjmcWmkFNv5fTtvlw2Fa07alyxYhOa3iZLTLou0qf5vDEDR/xJ8LM5IxGYcdc/KAkRz08a5rwoFGgG8grH5ymd41vXHuxUsOHbZbzv+WhETru5yHxxVTb6ja/sd1ZD2nbARvLgpeCyCS1+aY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(7696005)(53546011)(26005)(55016003)(83380400001)(8676002)(8936002)(4326008)(110136005)(316002)(54906003)(52536014)(66446008)(478600001)(64756008)(66476007)(66946007)(76116006)(66556008)(966005)(9686003)(122000001)(38100700002)(86362001)(71200400001)(33656002)(7416002)(41300700001)(2906002)(30864003)(5660300002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DSOXd9DQ92tMAHY+edol3RgBXcA7Gv9fiT8upYjeKkYxpkZQdoB/qNihgWgy?=
 =?us-ascii?Q?9t/Hbagw/vCFlfDiH/bdvcmpXWDnXftxjwBh7Z5aYI27GgegG0FV68k01/dg?=
 =?us-ascii?Q?+o0C9d2p7F91JTFy+VF0YSZtM33AzDpbR8JCJlYToRzeXNtSzZXxJzfJIGZb?=
 =?us-ascii?Q?5DhIQFhf8dIEtdz0ThMCczS9zk7WwZIB3I/MUzQsq4tnzRUwheszlh6paSgs?=
 =?us-ascii?Q?zECmHeTStI3MaNjZOyTR9FJJhymeG2a3prbelStaod3KvR0VOWJ1x919pt4/?=
 =?us-ascii?Q?Ry5LxdE69346XDMFFbyD6CS7SMRS05RVrPDo9GG97k55OOGfOVABBPP/3g2I?=
 =?us-ascii?Q?NaJDYsXlhZ0sqK+xK4QnITicCX++rG4JtxrqB38H78jOY1pYNZH6jIfXE7FS?=
 =?us-ascii?Q?fyfvJcr+N5P+DIHx9hRkdt6rjoYttgwtcGPQKj21NvpyuzeTqYg7qGBAwRPb?=
 =?us-ascii?Q?PM8Y0/pEqwGHdz6vgqtmbHNMEFdKW/ZSqe24F19RUvvNevth5NMm9x2KM+/n?=
 =?us-ascii?Q?oK7BSw/kX29TsOuiE7/0FNWoHZcGz0N77CHxkh1JxZlKYwE08LOh3lcg02hv?=
 =?us-ascii?Q?YRDWHJno67v7WqvYMlIT26Ax55+svsvH9EyM4wxZWQ9twaNBqxFdCaCqNaYv?=
 =?us-ascii?Q?CZSfHS4JPSRxedRYj7tPPJP4zIK7KD1zWze/+AAmzdO+YKbFOC14AvmTxaRp?=
 =?us-ascii?Q?XYSr/JPIsA2FtkTXuqC2ItNTO/PiqNVT4BjcusSpzzwEZpFmi9AfHSL/mFq1?=
 =?us-ascii?Q?+8wCt6e8RdSRDO4wJhvUVK8dOh1ivZrC/9JILkM43KPJYDv6Bw7a2Lb+UmJ4?=
 =?us-ascii?Q?nFCBtiNoWlPhW4dDji9RiM3p+l+sC93isKJg7QcrtlzZXE2S4yVyd+XEbhOM?=
 =?us-ascii?Q?k77yUpl3Ime4QXID6ETUIHldBcCU0aIK0KTfkE0P/Jc479HzUQoIn81TBJeA?=
 =?us-ascii?Q?HvyksnPPFkbMU3k3Kqy5u4yOGe50/AD76HgAjlReKF/txrJEwU0/I7xdlzsF?=
 =?us-ascii?Q?ePQR/nIw9rCOY9ceXoV2xXirmXCpvWy2OAY29gLZZbbY304gzPrK8YCny1TI?=
 =?us-ascii?Q?H6YlO33+VID8ysrUQ+z5kcT0Tfvru+0hedYAKUzsNoWF3LQcPL7Lfqerdhad?=
 =?us-ascii?Q?0Dlx2UnfzGdF4ZR0wonsSsXVf53/a8S35DjlQkjRf91ZCVraJsKE+BIytKwT?=
 =?us-ascii?Q?M6tvQggcG4ibTIfNuHmogOqLfZNY5oBFRUCIStNqTaH3ZwI7q0w/pPbsvB0r?=
 =?us-ascii?Q?ntF+KgaXr8lxtR/EcMCT0W0anZ6y+jFmzAe2yw9MaR24rVywVZ5vpKtK6S30?=
 =?us-ascii?Q?9tCtsvv54h+ucMvNHaE7fkl7i+QFs20p40e6fU1koFkG0LUdsIq61S7lNhse?=
 =?us-ascii?Q?bwqFq6p+AP4XpfKrpqHgQ11ymM17DfVucLBlPSbVi5704kSffOu/QyDoUMLg?=
 =?us-ascii?Q?Us2yfmB8fb1qvSk+jjc14tfFkIFcvj3Sjdf2wL6vn/cZKBzTNIiDErTZCQNe?=
 =?us-ascii?Q?8VWTwjk5tDgqcGc3fObqrqH77kxmGQm0fAEE4cAteWAZj6BCw8ZbbsJR/A8S?=
 =?us-ascii?Q?oIPw09FSxZHC/GWFH+YH/hWuxyjGcRsvizC/L4diyX6AENsg1EDegBew6MY6?=
 =?us-ascii?Q?Hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f5610e-404c-4ce6-5f30-08dbf74669f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 17:03:19.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVxM6ZS1q01VRg1PpcmxDQ55CF1htDId0Hm9zAivqHmOmorLXBcEICAqs06wdv4FrHLbQpCSEVYMkp7oSsRbmPrvrVTwZwHfI7YZNf7FJTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8202

Hi Krzysztof Kozlowski,

Thanks for the feedback.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, December 7, 2023 8:44 AM
> Subject: Re: [PATCH v4 8/8] dt-bindings: mfd: dlg,da9063: Convert da9062
> to json-schema
>=20
> On 06/12/2023 16:57, Biju Das wrote:
> > Convert the da9062 PMIC device tree binding documentation to json-
> schema.
> >
> > Update the example to match reality.
> >
> > While at it, update description with link to product information.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v3->v4:
> >  * Split the thermal binding patch separate.
> >  * Updated the description.
> > v2->v3:
> >  * Fixed bot errors related to MAINTAINERS entry, invalid doc
> >    references and thermal examples by merging patch#4.
> > v2:
> >  * New patch
> > ---
> >  .../bindings/input/dlg,da9062-onkey.yaml      |   3 +-
> >  .../devicetree/bindings/mfd/da9062.txt        | 124 ------------
> >  .../devicetree/bindings/mfd/dlg,da9063.yaml   | 186 +++++++++++++++++-
> >  .../bindings/thermal/dlg,da9062-thermal.yaml  |   2 +-
> >  4 files changed, 183 insertions(+), 132 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/mfd/da9062.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> > b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> > index 4cff91f4bd34..18b6a3f02c07 100644
> > --- a/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> > +++ b/Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> > @@ -11,8 +11,7 @@ maintainers:
> >
> >  description: |
> >    This module is part of the DA9061/DA9062/DA9063. For more details
> > about entire
> > -  DA9062 and DA9061 chips see
> > Documentation/devicetree/bindings/mfd/da9062.txt
> > -  For DA9063 see
> > Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> > +  DA906{1,2,3} chips see
> > + Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> >
> >    This module provides the KEY_POWER event.
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > deleted file mode 100644
> > index c8a7f119ac84..000000000000
> > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > +++ /dev/null
> > @@ -1,124 +0,0 @@
> > -* Dialog DA9062 Power Management Integrated Circuit (PMIC)
> > -
> > -Product information for the DA9062 and DA9061 devices can be found
> here:
> > --
&sdata=3DyWQlq55fIMgsfBxaNXCj4zwBiK14xZcd6l3NYKVnAWM%3D&re
> > served=3D0
> > -
> > -The DA9062 PMIC consists of:
> > -
> > -Device                   Supply Names    Description
> > -------                   ------------    -----------
> > -da9062-regulator        :               : LDOs & BUCKs
> > -da9062-rtc              :               : Real-Time Clock
> > -da9062-onkey            :               : On Key
> > -da9062-watchdog         :               : Watchdog Timer
> > -da9062-thermal          :               : Thermal
> > -da9062-gpio             :               : GPIOs
> > -
> > -The DA9061 PMIC consists of:
> > -
> > -Device                   Supply Names    Description
> > -------                   ------------    -----------
> > -da9062-regulator        :               : LDOs & BUCKs
> > -da9062-onkey            :               : On Key
> > -da9062-watchdog         :               : Watchdog Timer
> > -da9062-thermal          :               : Thermal
> > -
> > -=3D=3D=3D=3D=3D=3D
> > -
> > -Required properties:
> > -
> > -- compatible : Should be
> > -    "dlg,da9062" for DA9062
> > -    "dlg,da9061" for DA9061
> > -- reg : Specifies the I2C slave address (this defaults to 0x58 but it
> > can be
> > -  modified to match the chip's OTP settings).
> > -
> > -Optional properties:
> > -
> > -- gpio-controller : Marks the device as a gpio controller.
> > -- #gpio-cells     : Should be two. The first cell is the pin number an=
d
> the
> > -                    second cell is used to specify the gpio polarity.
> > -
> > -See Documentation/devicetree/bindings/gpio/gpio.txt for further
> > information on -GPIO bindings.
> > -
> > -- interrupts : IRQ line information.
> > -- interrupt-controller
> > -
> > -See
> > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> for -further information on IRQ bindings.
> > -
> > -Sub-nodes:
> > -
> > -- regulators : This node defines the settings for the LDOs and BUCKs.
> > -  The DA9062 regulators are bound using their names listed below:
> > -
> > -    buck1    : BUCK_1
> > -    buck2    : BUCK_2
> > -    buck3    : BUCK_3
> > -    buck4    : BUCK_4
> > -    ldo1     : LDO_1
> > -    ldo2     : LDO_2
> > -    ldo3     : LDO_3
> > -    ldo4     : LDO_4
> > -
> > -  The DA9061 regulators are bound using their names listed below:
> > -
> > -    buck1    : BUCK_1
> > -    buck2    : BUCK_2
> > -    buck3    : BUCK_3
> > -    ldo1     : LDO_1
> > -    ldo2     : LDO_2
> > -    ldo3     : LDO_3
> > -    ldo4     : LDO_4
> > -
> > -  The component follows the standard regulator framework and the
> > bindings
> > -  details of individual regulator device can be found in:
> > -  Documentation/devicetree/bindings/regulator/regulator.txt
> > -
> > -  regulator-initial-mode may be specified for buck regulators using
> > mode values
> > -  from include/dt-bindings/regulator/dlg,da9063-regulator.h.
> > -
> > -- rtc : This node defines settings required for the Real-Time Clock
> > associated
> > -  with the DA9062. There are currently no entries in this binding,
> > however
> > -  compatible =3D "dlg,da9062-rtc" should be added if a node is created=
.
> > -
> > -- onkey : See ../input/dlg,da9062-onkey.yaml
> > -
> > -- watchdog: See ../watchdog/dlg,da9062-watchdog.yaml
> > -
> > -- thermal : See ../thermal/dlg,da9062-thermal.yaml
> > -
> > -Example:
> > -
> > -	pmic0: da9062@58 {
> > -		compatible =3D "dlg,da9062";
> > -		reg =3D <0x58>;
> > -		interrupt-parent =3D <&gpio6>;
> > -		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> > -		interrupt-controller;
> > -
> > -		rtc {
> > -			compatible =3D "dlg,da9062-rtc";
> > -		};
> > -
> > -		regulators {
> > -			DA9062_BUCK1: buck1 {
> > -				regulator-name =3D "BUCK1";
> > -				regulator-min-microvolt =3D <300000>;
> > -				regulator-max-microvolt =3D <1570000>;
> > -				regulator-min-microamp =3D <500000>;
> > -				regulator-max-microamp =3D <2000000>;
> > -				regulator-initial-mode =3D <DA9063_BUCK_MODE_SYNC>;
> > -				regulator-boot-on;
> > -			};
> > -			DA9062_LDO1: ldo1 {
> > -				regulator-name =3D "LDO_1";
> > -				regulator-min-microvolt =3D <900000>;
> > -				regulator-max-microvolt =3D <3600000>;
> > -				regulator-boot-on;
> > -			};
> > -		};
> > -	};
> > -
> > diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> > b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> > index 676b4f2566ae..54bb23dbc73f 100644
> > --- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
> > @@ -4,7 +4,7 @@
> >  $id:
> >
> > -title: Dialog DA9063/DA9063L Power Management Integrated Circuit
> > (PMIC)
> > +title: Dialog DA906{3L,3,2,1} Power Management Integrated Circuit
> > +(PMIC)
> >
> >  maintainers:
> >    - Steve Twiss <stwiss.opensource@diasemi.com> @@ -17,10 +17,17 @@
> > description: |
> >    moment where all voltage monitors are disabled. Next, as da9063 only
> supports
> >    UV *and* OV monitoring, both must be set to the same severity and
> value
> >    (0: disable, 1: enable).
> > +  Product information for the DA906{3L,3,2,1} devices can be found
> here:
> > +  -
> >
> >  properties:
> >    compatible:
> >      enum:
> > +      - dlg,da9061
> > +      - dlg,da9062
> >        - dlg,da9063
> >        - dlg,da9063l
> >
> > @@ -35,6 +42,19 @@ properties:
> >    "#interrupt-cells":
> >      const: 2
> >
> > +  gpio:
>=20
> Old binding did not have such node and nothing in commit msg explained
> changes from pure conversion.

OK will update the commit message. Check patch complained about undocumente=
d compatible.

>=20
> > +    type: object
> > +    $ref: /schemas/gpio/gpio.yaml#
>=20
> ?!? Why? First: It's always selected. Second, so you have two gpio
> controllers? And original binding had 0? Why this is not explained at all=
?
> Open the binding and look at its properties.


I have referred[1] and [2] to add gpio controller property.=20


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/ar=
ch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi?h=3Dnext-20231207#n=
95

[2]

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Do=
cumentation/devicetree/bindings/mfd/da9062.txt?h=3Dnext-20231207#n38

>=20
>=20
> > +    unevaluatedProperties: false
> > +    properties:
> > +      compatible:
> > +        const: dlg,da9062-gpio
> > +
> > +  gpio-controller: true
>=20
> And here is the second gpio-controller...

So you mean it is redundant as $ref: /schemas/gpio/gpio.yaml
has already defined gpio-controller for this object??

>=20
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> >    onkey:
> >      $ref: /schemas/input/dlg,da9062-onkey.yaml
> >
> > @@ -42,7 +62,7 @@ properties:
> >      type: object
> >      additionalProperties: false
> >      patternProperties:
> > -      "^(ldo([1-9]|1[01])|bcore([1-2]|s-
> merged)|b(pro|mem|io|peri)|bmem-bio-merged)$":
> > +      "^(ldo([1-9]|1[01])|bcore([1-2]|s-
> merged)|b(pro|mem|io|peri)|bmem-bio-merged|buck[1-4])$":
> >          $ref: /schemas/regulator/regulator.yaml
> >          unevaluatedProperties: false
> >
> > @@ -52,7 +72,12 @@ properties:
> >      unevaluatedProperties: false
> >      properties:
> >        compatible:
> > -        const: dlg,da9063-rtc
> > +        enum:
> > +          - dlg,da9063-rtc
> > +          - dlg,da9062-rtc
> > +
> > +  thermal:
> > +    $ref: /schemas/thermal/dlg,da9062-thermal.yaml
> >
> >    watchdog:
> >      $ref: /schemas/watchdog/dlg,da9062-watchdog.yaml
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
> Why?
> Where are gpio-controller and cells? For this node and for parent? Why
> this example is incomplete?

I have used a real example [1] here.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi?h=3Dnext-202312=
07#n95

Currently I don't see any driver is using this compatible other than MFD.

Cheers,
Biju

>=20
> > +        };
> > +
> > +        onkey {
> > +          compatible =3D "dlg,da9062-onkey";
> > +        };
>=20
>=20
> Best regards,
> Krzysztof


