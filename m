Return-Path: <linux-pm+bounces-31545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC18BB149B2
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 10:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E537218A161F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A626D4F1;
	Tue, 29 Jul 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KcqrOF91"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B19221FD0;
	Tue, 29 Jul 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776170; cv=fail; b=a/8z4Yh7NJJw3jhbSA/AlZz7uDuXENiXfgBqJ/VUTj708g16wo/2amLsZLPY0yVKgHejqgTC2v/IpTJOVGAHvx84tVu5uXoVzwvmXua6RDsmvdR/+ny3BdTuQypWrot4psvQGRu0x3xaDRKbVbPQr4ZuJ8s9N/+Z3yF1qVTcIz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776170; c=relaxed/simple;
	bh=MqzZyWzemLOP/3h6dSBZaZ7O1xcIPpd2w3wkTnkfBdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exFZNBIX7EifEVfUYY94qyzXpfEnpq0WWqQSqdnQxg4e+fFbcSt6wTHCAyvKMwfu0VnvCJmV0ez7XpL15wTccjfRD3EXfUKLz+Qbu3gFUmdBKJ+fJCAC0tlcg/ZGsLzKKB9MR0ZoPt2e86bIPHfOFJCZSEK/EHAaC5vivCuJU4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KcqrOF91; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0VLg1CcxCmeCLW8abi50TTJPLtN1QT5kLJPtj77RfIhfIKUyM+IOfc3o9qOA63gdPKrl8PvFIXXBiPP59GkD7cIJ524Hp/jBEl9jvsh/EaB1I+2hg4TtQWucvAy8WznvpiAKbOwI7GKVFC1WmS1CC0JFsHxO6sF/a/D/GcQ3mXjNp9gVyuoeJF2Z4SPpG9v86xguNzaFrvA8JVOBDEr+zuy6prTOc6yfsVPrvc7jF9qW9SH3AWTJjWVZ/F+G1GQ0Vc6tlbqwgOwiQqN6g74k1wappZ2k59Z84xxPFVKutew7hwK6Iit+08lskh8Cztt8evK18c62ukjiuQFov+JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPMCLEEkl7MgPgTLvKN3Z66FqCDZuMSs/DsT2LgabzY=;
 b=pbMy7TOPfnjYkvmJnDF6IXaEpfUP2vlVJ76YcMMR7iHeHqv27NSZ5oOrKKtVSmOaP9uhni/KVEmaAmnwMCtQlurcfQ09OwxFfCgDfsE55x8Rn/S5lFFvmUNKPyFWO9OTKrBuQTwiE9IBSOHtg8XL4tynZUhx3k1Zma0uNUgwnURFTLycKHtVa9t/tWNZd2tvfu/fvrcslzItPiR/n0lksIFgJwg6DZ/SEc4gKNapjaVMQBegNHFu0uGKBdsnlD7Ycb1i1dBBHO9RdDZEn39D+v8gtPb+bwIuzRaYRJY+M1Y+/QcgVs4fWIu/g577yuePDzlEDVyq2Fdh0SFrX3vb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPMCLEEkl7MgPgTLvKN3Z66FqCDZuMSs/DsT2LgabzY=;
 b=KcqrOF91oIaXfNhaCLUGkCdFZS9/vpXioKT50VwrzUIovUDvcPRDONTkMQq5nz70O6b7UeUhtlUHcW3aoaOlNW11gurwc5WwB1odNlf6hqjoCGlOi/EdnYEITv7frgwdeErAAatmvn3/NnCMCygBTO4tnIBzGiazIxkUBzcXGx502Pkkrf5N9J/ggtTSjYUdmQScUBL5XsWoLYrrap1h7HmOcLrh3qlD6FKB5/OfIoBCAwNigIU0VOz26QjmguoR4i8EHHmrLMmzBzogbZ01gbEoLNOXXtK/fhYCRwQAdikjpXySPfuIeguP0bWG154wUcs6D9w9LMyAt94kckqC0A==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 08:02:44 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8964.023; Tue, 29 Jul 2025
 08:02:44 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Topic: [PATCH 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Index: AQHcADHIj7Ah5US3Lk2vWufsX1crirRIp5KAgAACpNA=
Date: Tue, 29 Jul 2025 08:02:44 +0000
Message-ID:
 <AS8PR04MB8642DDDAF4E9CA5E98F94E9B8725A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250729024039.1223771-1-ping.bai@nxp.com>
 <20250729024039.1223771-2-ping.bai@nxp.com>
 <21ce4f23-8aec-486f-8fbb-021c1e114908@kernel.org>
In-Reply-To: <21ce4f23-8aec-486f-8fbb-021c1e114908@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|PAXPR04MB8606:EE_
x-ms-office365-filtering-correlation-id: 49b5818a-cce4-49b9-983c-08ddce764cc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O/9PpbxyQL5yfuiC3cGZYuJeZ06+RcRyjfOYU7KEAIm/rcEmTvWGk17IdUYO?=
 =?us-ascii?Q?U/zdaG0cN0uO9Zdvt7GaxCWFWbJNQVYe5EJ97hxytXgZFysfA2J3j46vaSmF?=
 =?us-ascii?Q?uF/z9/zCRplEQDm8KqvKNy/XsXWoslgzAEfWrLCewb1Lgkcf4BC29hTZ6V92?=
 =?us-ascii?Q?PHX5h4bGHDFbTdaLucFREzpAUfPsIe/EXM22UziYizFqKY7l+zUeda8t64pl?=
 =?us-ascii?Q?qsv2ZFPIK7a5djnM5T4PZHKgtBTprQmbkv7gK6UQ21lVMq67glii6Xg729Mu?=
 =?us-ascii?Q?Btn3W1u6SbLx7+cjmdkLiOGfQeKeDl3dq3wL/g/6MttSAELehD+8+84Nk1Bk?=
 =?us-ascii?Q?RZUClFerc1IBFlcbhsOvlpFxssoxnaGzLmYg/SQsSaVO2rUk9md2N1zGW3kz?=
 =?us-ascii?Q?IzIs/FN6GLV9DA8cPvo2p+G7bpMhIEKMG9PC3OJwtnbLKTOARt8+sPI1JOmb?=
 =?us-ascii?Q?OHYp7xPCoo4u6FrM8oUUoTus7LX4HvZO+fJ/6k1CzYmiK+ZWLmx9gKcoTWFA?=
 =?us-ascii?Q?6DpUZ5+4VYO4JQn9KombYFqkkWnZ0stRY6tRiYLhjgwDmtmOXK6VZdNbVVAK?=
 =?us-ascii?Q?NSfr5VcD672tkT/yC2zZ60euEZLrU2V+Bmh4OWds8/zzK7/JEW221xd+NXML?=
 =?us-ascii?Q?y86N+u+STysW6YzcamMkq83t7CPjj/lRb1CC0Etvt3wf8K8qFmCKRqQkum6Y?=
 =?us-ascii?Q?Lho12IbKLwzBcea4zkOCJugvoXW5qx2LalWvTRdZ08j7m6emMpCG57D7dxzH?=
 =?us-ascii?Q?pwIOZWmQ8KIH2SJnAaD7GmgMuwWaVVpnAJFJ/t65oWMd7aazXYzfYCqRGtqj?=
 =?us-ascii?Q?jRAfGWdqrbe1NtZYGJCqUsE2w69xf+XyW34GbT8NmGulZrx4Cs3TYkUF3OSa?=
 =?us-ascii?Q?Wtjq4DAHEflUBzNN41SeFJx11e3u8NAMsOu1mpIbRSZBNGORlhGHEX06/IBr?=
 =?us-ascii?Q?UJNzxGrnOFfeVLmXpEy4Rg5ouhMyhGasaJwJQ90zbJzbF1hd5aXFgVOF5plZ?=
 =?us-ascii?Q?DLpR/h8GLMxBYDCeSCz8rH57gaePiPXYXEQfE3lFPMuUJfNs1QsR31RgWFs5?=
 =?us-ascii?Q?/X5+FajTlIrQl/fVplY3WPxtNNcE7Mvy/UyLcsFzJVFIHBVHX+rFdyZn4xA6?=
 =?us-ascii?Q?Jq9g1SdY+FNOhLSoYKotvq9pLt4gmlBBCecd+UxKVHyZYY4YE8THkN1Jwge/?=
 =?us-ascii?Q?FDTu7awRpyjABUSMUEsLnvVNVZnA8DO2zIKm5RbWtKCRPV1j6cjPs0ci95jD?=
 =?us-ascii?Q?iK1VLuGcKOqisG+1nXRH0Ow/ikiey8K6YHb8qeXvKFghT4mv0rx9gzo7/9sj?=
 =?us-ascii?Q?bdJORW7wd5a6M0GnEEdk48hqvt5Upww1Qfmf8blk0ajPJ+Y/j9wIZjWIPxeZ?=
 =?us-ascii?Q?y0lhbWAOGTfKEbtgnz+lO7ZFQGzMTttVrlEYXFF1GDAIPMvQY+KxJ/4+x/h1?=
 =?us-ascii?Q?LBi3gOm5CPiVZ/IYg6Q8pfpzFHFVU80M0pMzyl0Ucg80qyDJ9xb8NA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r+DNxb8qVilOKL6dwEEamxuHuHrLoxNul83qDdR//f7C+RsaQt9GfImUh6uW?=
 =?us-ascii?Q?F0YtbxZbt7e1g3KlUOzEQO/PZR68uq7X8iMM1zibfxaqo4UlphOot+oufLpA?=
 =?us-ascii?Q?mmLCfPDVjMZvxCl1BNNhArleK2AZ7GmZiPrihLJAQkensHyvqyBhziOrrOOB?=
 =?us-ascii?Q?XYKTUjcnj2c5wVCqTeLinGls05zYZYUdeO4YblciNrHjOSv6vyyXjxi3WDff?=
 =?us-ascii?Q?VXgO+zPntr/JTVuyBCd57gcH3tFD7D4Q6k192aBSO9fAaSKxZp4gUm+QLaBv?=
 =?us-ascii?Q?lPEu0gUlKH9WbVTVjypnwn7ppQ6imSKO7t02ptRx52acoRIb5eP3aE+2mJjs?=
 =?us-ascii?Q?e6brWGmtaW+m1T3+mAlpQ9Zv56e7eLtvU5js2G8oVI/Xzj8BtmNASKHESIE6?=
 =?us-ascii?Q?5Cp/afbmZ14aRjcFjtAHWPp4uz/QUXn8Dv6L3XRgXCthYyY26iioV6pg9RjM?=
 =?us-ascii?Q?KdV4WbI6daXxhp2oikUMVdMRKqMmhKkqN7y3eCgUoE7v8tXpc1kyWn2aNYX9?=
 =?us-ascii?Q?034hXT+/5C7AeQvNzdvCloMJegRC0jNRUXk4U/7ACtK5gcPdrZxASwPXPS1Z?=
 =?us-ascii?Q?6cRybWogg/jRXrV8i2YOTI79FpVxumNCEyanzsbO6mRwgrMNjXAwslMpx1Bw?=
 =?us-ascii?Q?MdOJU9wPj0uIdhYpS1g4Zc14WgFuI6kkKp8YGF5tdHzs/Yx91hr3YgqbT5QU?=
 =?us-ascii?Q?w+CvLdoAuuXvG8amob7GofGh6nuiif9es0djTngMNPPDt5TW/yyehfbLXtrG?=
 =?us-ascii?Q?cydq50itZ+ToO2+WgMBWZpLxaaJRorNgCXqCYjMPG1B85ZNKHhjKxyGW8iwF?=
 =?us-ascii?Q?8fVR+2YpiFHXMaKoEWqd8E2TCGzqHEZ+Q6VFA8Wv5jlg2UfdFCQnzqBUDeL6?=
 =?us-ascii?Q?Lma8jN79tpAqNF0sReU+BSVQQCutKl0csMjD7E973IG5eQgNnE8nm/7DJ2Of?=
 =?us-ascii?Q?oP4f4NS69kDrfXEX1KHbCJtnal9H2GviNt0tZt+oDBgm6IX8ok+IAAxs5uzw?=
 =?us-ascii?Q?Pjp8xIrq+jPt/SKl+sqyCc/01YIckrOseKl8XeziiU3Tsdct61UaB0qgtIMa?=
 =?us-ascii?Q?TViSaUS5y/0w+cFfn8TfwjSXmt8FhS9bqCXcLSsxC/ypgl7yikmgcZna78n8?=
 =?us-ascii?Q?zJ/opnkJATjKDSWQB8bqxvvkyMZABNDJFDaHbUD4LoLDGWNBg5Mf1iQAmgDi?=
 =?us-ascii?Q?6gmebXqut//Fu+0pTvL6E2XsNCeuwqwFaVWd8umoQrgAsqN1DUpedl1izdFb?=
 =?us-ascii?Q?FOh19YVT3TbwrB7o7yWBk8BMQI7H1ZR+YHueX4QenaWxD5WMStytVKrPfZ5G?=
 =?us-ascii?Q?an5xHyuSGCWGIwnt97Y2TW1+hM8bg//g4XlpDs1iHhgsTWsgjgJSoGzTjgKB?=
 =?us-ascii?Q?epzxZK2KO45NpkTIJyGQ+hLQNYkzJr/4LEOpQsdQI7LrGrGMIdYr/p4s7hx0?=
 =?us-ascii?Q?A7oz2DEMzwl40lPj5jK6dY0SKD2mT+XaWqExBg1HlJEU8B/zeKtTB55y56Ug?=
 =?us-ascii?Q?BPA5q012PJ3Rayw9aU2J/Yv38FpA8u1pATMtDZ5WS+ar8r20xwa3Gb2UGkJ6?=
 =?us-ascii?Q?kgLz6WuXYMoPY4soits=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b5818a-cce4-49b9-983c-08ddce764cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 08:02:44.5672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wu5ALB2KeEOVqP8FsrtIXk5Nfv0KzHs5DboV1aCO1OKFKwujCzYkSlyALqzilh7VL6S62zl8lTu/DMuJ5NMyng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

> Subject: Re: [PATCH 2/4] thermal: qoriq: add i.MX93 TMU support
>=20
...

> > +325,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >
> >  	data->ver =3D (ver >> 8) & 0xff;
> >
> > +	if (of_find_compatible_node(NULL, NULL, "fsl,imx93-tmu"))
> > +		data->ver =3D TMU_VER93;
>=20
> No, you have driver match data for this.
>=20

No compatible specific data info provided in the driver, will use
the 'of_device_is_compatible' to refine the above changes.

> Anyway, are you sure devices are compatible how you expressed in the
> bindings?
>=20

The tmu hardware version read from the ID register is not designed as expec=
ted.
With the qoriq compatible, the tmu device can work on i.MX93. but for i.MX9=
3,
the Central Module Configuration value suggested by design is not the same =
as on
QorIQ platform, and there is a TMU SW workaround need be applied on i.MX93
due to HW bug.

BR
Jacky Bai
> > +
> >  	qoriq_tmu_init_device(data);	/* TMU initialization */
> >
> >  	ret =3D qoriq_tmu_calibration(dev, data);	/* TMU calibration */
> > @@ -379,6 +388,7 @@ static
> DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
> >  static const struct of_device_id qoriq_tmu_match[] =3D {
> >  	{ .compatible =3D "fsl,qoriq-tmu", },
> >  	{ .compatible =3D "fsl,imx8mq-tmu", },
> > +	{ .compatible =3D "fsl,imx93-tmu", },
>=20
> Otherwise I claim devices are compatible and this should be dropped.
>=20
>=20
>=20
> Best regards,
> Krzysztof

