Return-Path: <linux-pm+bounces-647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823C80225C
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 11:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9D9280EA3
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AC8F4F;
	Sun,  3 Dec 2023 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="R9OlyEsK"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA93114;
	Sun,  3 Dec 2023 02:07:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEV/ubkFhgf0MJlokZF0QALgNhcs84Dw4lE+qQeGcsOdmFEkOkWYXVPuLnQG7vVE6azIVKRmXnPyenc43uQCDzT9kbUKWw3AOZb3rFhjr3Pqm6+61J3I+7zynzHYcIIIes5sJgYK7vIk8MaXHnyycB3d+u2xlvx9fsyyZAXUiNLcwUBffwNygdgnylT3z3GrgIN251HLIamHTbYsWIyAFFBjFtYz/S0GPaXWQmWfF2q1C+oIJhE1oida9uSx+rUlYyexk1m6DjGdprInT0x7tgSthbjTp44VnuMO3G3CyjbnX0Hl5nKpvwSeQ/HkgHsGq/N21K6jEUG1CTnB++SoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ06i4QFfANpPLuqVbcAHIk4d6bKswVUQcwM4PrsbkI=;
 b=dYTbUz9v6+1PjdC3qP1xFmKx7koZYYj5RNk/AMGF9uD2mch/l2liUdK/k6alIlZxsygRizcC27dnpUv8aPK6J43KI2HKuJy4TXQAOX6FLtWbaWHvL9JHVpKLgt0jYkHPQSrxZSwkjjcoVwJUtHvcQD3aL32yKgTvvA2M8LSs5Zv68Ama3rHHJmyiaoYpORqgvAncr/ZH3hPoiVMLn88S+7duSNn3FuZ8OsptPJAtcXweg1psdxzfTM5Lxr50DspNPET4WvE5OMb9how24n7Rth5uQvipOFUK6lAr9tezr2TfNwVFHg6qy92sszKx2T8hfg5iUicE2HZrEgM0L2aphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ06i4QFfANpPLuqVbcAHIk4d6bKswVUQcwM4PrsbkI=;
 b=R9OlyEsK4eb1Y+N3hOhS5lF/DwNjWtofLSsB/bTnGo27U5pbSzht5C5t2zZjXpzJ0o7TFomESRxk5uHMkShOjCVYXBZqVKKfZLJm23hfWz5n6OJDDJpJrj612Ojsued+0suXbaCBtNc1GKUVLrLXdNw+/XpCyLlowiy+D+Vt1yA=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB8140.jpnprd01.prod.outlook.com
 (2603:1096:604:1a5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 10:07:23 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7046.032; Sun, 3 Dec 2023
 10:07:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, biju.das.au <biju.das.au@gmail.com>, Lukasz
 Luba <lukasz.luba@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Support Opensource
	<support.opensource@diasemi.com>
Subject: RE: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2} thermal
 to json-schema
Thread-Topic: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
Thread-Index: AQHaJVVpNr8VVPZoO0mAS8LwJgirUrCWhYEAgADPH2A=
Date: Sun, 3 Dec 2023 10:07:19 +0000
Message-ID:
 <TYCPR01MB112694B04B266A50E3AE3291B8687A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231202192536.266885-1-biju.das.jz@bp.renesas.com>
 <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
 <170155319437.438762.13341872732989255147.robh@kernel.org>
In-Reply-To: <170155319437.438762.13341872732989255147.robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB8140:EE_
x-ms-office365-filtering-correlation-id: 09dcdf72-2874-42f0-21fe-08dbf3e7a2ee
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1mchKXpsz6cp07DSXmL5DwgQe8XKrvyEgPzXBKr0/vem69XW8Qkdkb2ZjwM4zmjIeGkP/pa+2dCdOTtltqGQgEOeFcE3ZV6FGT52s8cGCrtmx1PaFwxRklBgJSElrrRBgWypVN5E+BBbqGDt7tPTFs26/msHtr/LgpACsc+r7+iQAthCTpIEzHb/FsIH5sV2DipcHFXrLykJITbF7byiw1Co/ybljDsHX9Ma1DnQvARVZWj3kIWO+rQpkc1bbMqRj1glHGFlQik4nHBmrB2CrTh2FuHNKhYzm6CFpAQ+Lr0XEqJeUInIOPoJepDemxX0mftbucL0uyu6SYNINYeg3RhBnoSSeom+OrCu7ST80c/3ZckoohgPxFUdoAGYLvSrZN3cdZSlRDwel8OsawhPkTFyjuTiIYjrdGuEkQ/5AH26oR88xy+QqjDdS2YV9VMbsoUuqLXOASA1bpt3omPrhdns4Z/2IGBEdXyS3QH3cNXNPnNLD7kIpDR7Asqp92OkNq+WCltUrbAkMl766kc1JhuPWEKe/mttK3xvIKIFSTOycCpDc5ds+TyM4mCgEP6mb1mFNIesVy/ygIeMLZwaaUNF9h3QO2Ncklz5pfeTFmOpoUHAJv9vm9WR8nzOxaLDkK3Nf5ohQcU1lzgopbJHlv/Mfr/SpBCgtEHAAbbzgsQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(52536014)(7416002)(86362001)(4326008)(8676002)(8936002)(2906002)(38070700009)(41300700001)(33656002)(9686003)(6506007)(83380400001)(478600001)(26005)(7696005)(71200400001)(38100700002)(55016003)(122000001)(316002)(54906003)(6916009)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YulUVFD4uB5eS2UAzqLoFzbEQS1iI3x/R4TXdwaqd1TsnpnxxdO4+dw89O3e?=
 =?us-ascii?Q?Fnk94NAsbS1/hkTcjTc+8y0i2g5OcWgv347Z7LuEB7irbinZKWuGZj9T1GoJ?=
 =?us-ascii?Q?KKX2ID4TB8ftNH8Fv2ouWELkx17H1GDqiK/6eiwRd1VQGUIGhL/Y4evu/9ou?=
 =?us-ascii?Q?QN3qs/k/td9wdsamj8+0LvUq3FEqy9aky6KSrhM99ExNcdNy0bf5E+9hvM4f?=
 =?us-ascii?Q?TA0P46zx09UtP9iUblFYHP2tKuMw/W7G+dbJLnHFsMnZAogjR8zgAC5yGtIT?=
 =?us-ascii?Q?x4f+TaqhgP2dXpaPFRHtvKIq7mF1G4j8m3ECi3VmrI5F+p90ZGgpk/wanSQ9?=
 =?us-ascii?Q?+aIexp/V6lK28vBtBl/KN+F3KjhYZCDQpaQ1BkbhDeanVnXLTHv3ZSuwQE/e?=
 =?us-ascii?Q?yIraH44upoBxV/ngYWfbOqz9CI9lnjgp9qqXgy8QTtxRB/AqdkSXUmpnirPH?=
 =?us-ascii?Q?/rLWgoDPB6aiY3q1A5cS+anAcC++9WD6yDeRMI7ltl7gBjQiZMBCqEr9Kqu4?=
 =?us-ascii?Q?82ajluC8Uo/fTuoMu7Fi3bt1+YWRcEnDBoEyZau0k1agL3CYAV1vpV/TZAu1?=
 =?us-ascii?Q?rkOXXUWWDx4YQX4x6EvvBvQUsn1o1M+6Zg3SZSynHOtjdkeFV+2wP8ZMt9cR?=
 =?us-ascii?Q?zOwb+9NkRm4ivSldpZ7s0yZecVkfbwsPuuN5cwHGs5u0LIwgbw0LpDs7NVOU?=
 =?us-ascii?Q?4pE+ocaC8vm6pucBzgHUCF0Pm7lrgQG6LIOoyRxp4Tva5Hb2CUj92A1WS5e3?=
 =?us-ascii?Q?cLYPdRPHbgmShvVyy3ZF8gjH5d9K3gr42jWOU4DVVS0Gyn49PLzd3R1e4LxA?=
 =?us-ascii?Q?iAHwDqQKOUQC57uR/4kFzy4oihnFS8y0o04yr5SMmTdNMFgSwnibwlfsdwHA?=
 =?us-ascii?Q?6tz7Li0tssvJvl6eKCMktrKSauMcq4LfQi+NBIX5TPug6B+URc9cLLTB01RX?=
 =?us-ascii?Q?cie5dB8IXJI+poOytKBYKApdU4wHgmzBwX4fcGef0O0yWgLEEZzk+wVg7wZW?=
 =?us-ascii?Q?azpjkfnfRWo6GAskOwIzRcJPivGa7iXCWYke6qo41br8VfUcGA6murFldw4h?=
 =?us-ascii?Q?pjYuBuieOfLB632lnK72+cwOxqJAzpL7Pgk3K/XS8atpNk/cf1IjsNfRym5k?=
 =?us-ascii?Q?+6oMNQ+/UVelKfna2GHoks3jA/yGdYSdWSXDJDFMXJlBmkTtGqU7WZY1jbXy?=
 =?us-ascii?Q?HHoTRymBlJA49+e2+2RcL8Qww+/6dh//XyA3xJAFwcZZm8N/x70W+lbKrBpe?=
 =?us-ascii?Q?RYRR5dGAvqbvchqzsbSlIh0LCJBOLr4B0OwzKgkkGTsZ1jH9ndNbpM1Rtnwy?=
 =?us-ascii?Q?yt3/mEp0+Gm0NOAjRWaxX9vLQ0w8wt9TxOe1+uPQUF/TL48af4m4zhZaN2lF?=
 =?us-ascii?Q?r6WrQPWMQh7shah0Fl8bEKEc9Ql8mlCMoQ8lHV8/n8gVAYJw9FknAcCQgRY2?=
 =?us-ascii?Q?NUcdY1roGVMw7/Wn1Prmmp5hjZ1J026MLS4qkG3QTlZSHISEKqq9C4NwyYCr?=
 =?us-ascii?Q?Egn9k3jEMVr/r89wu1RzSJk2VbgS8/rq1wW4a3T+xPJSMa7dJ3qos6RFMPm5?=
 =?us-ascii?Q?4cHujL0oVMNwQi+wX9m2TEjZ0E3R2QanunwAsVKSWRT+ooN9kI2oiz/b7lOm?=
 =?us-ascii?Q?7w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dcdf72-2874-42f0-21fe-08dbf3e7a2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2023 10:07:19.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKtgqIcXdpbq+1+a4zQ3qvaOQiFxryh6c0+awKSiFFJCknjyUQbyLFNtYU0SjFS/Tx3MHGSqmeq2M7iwpuMGa6lB3etnkaw7LXOf4lhPbMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8140

Hi Rob Herring,

Thanks for the feedback,

> Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
> thermal to json-schema
>=20
>=20
> On Sat, 02 Dec 2023 19:25:28 +0000, Biju Das wrote:
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
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.example.dtb:
> /example-0/i2c/pmic@58: failed to match any schema with compatible:
> ['dlg,da9062']

Looks validation is not checking compatible defines in the mfd/da9062.txt f=
ile.=20
So will merge this patch with patch #11 to fix this error.

>=20
> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/thermal/da90??-thermal.txt
> MAINTAINERS: Documentation/devicetree/bindings/thermal/da90??-thermal.txt

Also, will fix the MAINTAINERS entry.

Cheers,
Biju

