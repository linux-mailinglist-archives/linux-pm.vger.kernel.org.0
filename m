Return-Path: <linux-pm+bounces-40534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB8D08D9B
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 12:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97DC130A3F03
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306033CE83;
	Fri,  9 Jan 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="SSPHF8hK"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714133C53D;
	Fri,  9 Jan 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957307; cv=fail; b=XE4lokltVcEryt2KBx5x6+q7YyVAhfRlQndwg/Uyqu3hD3uj3e/usDnD0SodDXwSVCkc1uYJeveP/F+WZyUzQtJ9V4R7MvKONO6Ah17Xrd1J1nc3uWE3jESTjtYmYTLSQPGLMZ0DDMH9E40Ozomo5zK2Cp5KYdPa2aKbx+eAeiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957307; c=relaxed/simple;
	bh=QFbaER8kU0sDGyITfc8imGtrRJNiKgN4Jd3XadORNBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nRBLQ1v3w0CcA7B7j3cQiHW6qz+1u5lFKeZaeKx/au3QZGH04/Nc8U+1EaYfNT2PBprlmLJs25LZVhgsqvQNBWLToR/dH7GDHcCCeR8+ahrFpIYwjlJ3uN56WlVukfmp+3mqGTA7rGcclq5sNXD7/ArBflW8R7lU5K6Md+pljiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=SSPHF8hK; arc=fail smtp.client-ip=52.101.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j13gKLysTgHm8a/R3Pyn14soU15e6QbDoSvotf02ZXLp4elnXnoTMLljMcuN/cbU8q3ErwaHMzi5Y1dUl42rrw+cSRIFdFByTdZbRwOPqCT79P/A5zGmNLW+gVW7FAHR3s1mOoLr+xRFOXGLbg/KHAWLBjWzdll8exVNH1+EAp5qO49HsWYfFrlI2SM0pLpfKMJ0kqH0Qmli9ZX6dW5n4majz86P7Z9zc59zz8hxIW4kQ3D8vbCAM0R9Y2h/fcT1HTBIuiRDJI2wC4egff7dVMyFotY+9tuTNIPIdSB2W+guIc7dbq/sTM3O03qqNgxFxhcsxYPsjMAVexR3dMPIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLkVfc67ehMUqsAYOexcScmyjcllNcdtBEX346Yj6RA=;
 b=WjbLxCyIjntTAxBBuw7TH1oq1DZhHVLdT7cBTWpYLuIV+W83pmJtuTEGa6RW2n5yRJ0bv4V4pq1pzF/tVYj4OkhOM7ZZC0u1LMhyrOGRzLpCXTRPm3/iateCwnqVC/gqc6HJ2jXxeUUzo18kSkfIYYFBZcfZvyHgdI1hmDUerHb0bsGVw5RcgKoNIFc+wVmobYZjWv08zycNhMoVgKZrTc9Epy9ENRFIfYAGN3/5tIQNMfMtq6oC4YdNemwGrsbuSxOiZBMYMBJmfDEMGXK4i+DZUuviU5GOideSHwFlNkgNgS16KQrHF8FwbKgDJdV3Po9EhBttBmQ7rfduLIfGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLkVfc67ehMUqsAYOexcScmyjcllNcdtBEX346Yj6RA=;
 b=SSPHF8hKhnvjniSjXgH9RCU3u4Jot6F6kAwWX6fkqW+VVOUy5ELHuTINCCXRAMEgvroUjQ5n0ZkgG44ur0g130A73Sy4WgKm++4PW9dOnW+Rymp2ZKwfbCCfDOOhc4rWekPPoph1BCaQ5ODxl4HgoXTeaceTFw/hqk7M6U5Lvo0=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by OSZPR01MB6815.jpnprd01.prod.outlook.com
 (2603:1096:604:137::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.2; Fri, 9 Jan
 2026 11:14:57 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6%4]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 11:14:49 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das
	<biju.das.jz@bp.renesas.com>, John Madieu <john.madieu.xa@bp.renesas.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, magnus.damm
	<magnus.damm@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcgNiGYhiwEGfBgEGPuaKI9I9oWrVJXCsAgAAo+GCAAAebgIAADuSAgAAGJSA=
Date: Fri, 9 Jan 2026 11:14:49 +0000
Message-ID:
 <TYRPR01MB156190E553ED0745039A7719C8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References:
 <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260109095937.3317991-1-geert+renesas@glider.be>
In-Reply-To: <20260109095937.3317991-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|OSZPR01MB6815:EE_
x-ms-office365-filtering-correlation-id: d0c410d6-abfb-47f9-efa1-08de4f704dbc
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?18YiWeLx8JcH0kE16ERCMBuz6Jk65T9vlAJ0B2cjbT5GUQYcz+Xtj3VwkUpG?=
 =?us-ascii?Q?4TH3f3+WXhdgEnTi6Rkd4R1AWDreshA02MCulLRjYle4UKGMnEjggAokZvfL?=
 =?us-ascii?Q?cEsKwgqmVEdzb0cEgzMVbkYDPe7h1hkTeuZzpFM9/9rwyjfklj2b4l7SfqYb?=
 =?us-ascii?Q?15p09fCBZCZ4jeUQg8yWVUafNeB9DBkDJEAGytjy+uLXG2WGBayb/m421DwT?=
 =?us-ascii?Q?H/smsgCZQOdv2DaXa7xoQTQuUnJTsNWAK8bkmCR6ZDf6K0XX+cFlgQrxigBG?=
 =?us-ascii?Q?3GixBdwPeruMgi4kYRED8odepS8o5yVLoaghMwL65heFji2zEsus9z6IcAuE?=
 =?us-ascii?Q?mVFqgkw00XLCHHTTgyhE3bfiqHbTgUzgZ5CPWigvGcUX6/g6BGtrv8+OrvsP?=
 =?us-ascii?Q?NWW/hKLkt3bHKVjLGH3RtfvVOS2B/zYEvbR6dpJK/8PgtskCZYFaWp/VDdbw?=
 =?us-ascii?Q?ziyD4Ko8bX6IfqgqamNlEAfNTnjUyFTYVseY0UYSTN2v9GgGgsvqo9H6KIaW?=
 =?us-ascii?Q?ab5p3ZrMrYTM6CntWh4wQyq0b7wZKibt4fJCgyAFsvIfff/MXMZmMAVRmF8/?=
 =?us-ascii?Q?1HpHR2koRrvSF5C509ycDYvh4ZVdddFtd+OX+917ZPeyktvuIh/AsmW2EihV?=
 =?us-ascii?Q?Ai88ajIPJ3TxYaIpZ//sZ4K7b1Ate4tBXJP2tgXBieMCQOPZweR/jbMm8jf1?=
 =?us-ascii?Q?7zT7Jzjrc92tO2hgPFGPLntsxGq1msj+C0UYG7sJagiReg9PYrdcVaHTUQFr?=
 =?us-ascii?Q?+23WVL+F1R1AHOBasuoqRVLkxZI8U6UlHA99tPtmIPv0WpopgKHimSFMu3Yh?=
 =?us-ascii?Q?lUyNAY9XEVr8wQfAaCGmeocyZ1/Hm9gg9+lIzHr6IIFWZG77hO/OcYCTxr7R?=
 =?us-ascii?Q?jYLPlc3WoyyN5c8VIn/qH0/QWxqe7JTgjhQ2Fx2vhi9X4SQRdAmATUad9vfG?=
 =?us-ascii?Q?x2+f6S79VnF9PVsfxy83SLkit8E+DpCcDBVUyCXDNLor9H/Pfo0gdefAAXsk?=
 =?us-ascii?Q?My7oQDcUuPU2hK31hdSRG++f5Q9ZKds5GYOjox99c7LwVZBvSi700Vd02UqH?=
 =?us-ascii?Q?sf6eTCiQLfBi1o2u9ANqirzfxH/KecpKNel+v+7AtyMAK1QK3Chiz2qK4Vri?=
 =?us-ascii?Q?ZyAhPwfLMXaznN3O/iWu0bz3Rc8ZIi2qzecekE1sJ/x5K98cnYA9zlxe6Bda?=
 =?us-ascii?Q?IupVujxExj7Hpz6bU00CXE3wLSthMGlWfe0puj0N4IBs3wOKRQfg85B30sYJ?=
 =?us-ascii?Q?4cXhR9Mq7hL/g10hrxCXLF8DKKpSEVr9u+9CvKIbTF1QUCj8PFb/WQnLYAF1?=
 =?us-ascii?Q?nlotN8t0aCEQckKSF5ObRBLL+KqAvfvIuQgdLuMDKB/mfTM3k7edpuTD/rJf?=
 =?us-ascii?Q?nQ4RxyJBxtVgdG/tQ5gBZFPaKsRrMpzYfc2ClQtS7Klxpv5ECpt9KwymU9YA?=
 =?us-ascii?Q?SyZX2QPUQdVeNU0k8gKbmVIK7PMR957/UtDcQC0Udwf5lHDAXnaLl0Vsiuyt?=
 =?us-ascii?Q?UZiHb7lVTPFCXKWG2v9mw36rJS0qvarlD9oX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T4o1aCfbDsUrCtEk8PbTP1/N+DZntYm6FWywNb4KjxFbMB4tciCVgp9RaOhd?=
 =?us-ascii?Q?MDTL0Z19Ont/oAhkfEgG+4BIhIUjZWDi5cAljO32u3EhXmXtzbdlqQt6YabZ?=
 =?us-ascii?Q?7NKOOzVg9Lh3XTdsTDanF5vpTE44vcL5ctrZXuLEOknFzN5WZeWJ3qXVVXOz?=
 =?us-ascii?Q?vgkX2cWpwpp2DFgdZVykMFsdQlBmmVNPgRaKjWoWW/0iAnFjHaMIcCHO+gnT?=
 =?us-ascii?Q?U7yud0x7/uylVrUw14IsfM9P48PCGtAEGj7sW+tQxT4Z/erIhDN0lWTyRAQl?=
 =?us-ascii?Q?zlNVUbZhDxt4awx/9exauVc2NP/hMqWt9hLsXO98E/t3SycrIgdWEZJQ/TUl?=
 =?us-ascii?Q?JK+vPduzxCPMStU7tURA7BvwGV5QS2fVCPspiXOXS4Y1dHavSzpuYhWzcoJW?=
 =?us-ascii?Q?aoZVNCmUigdmfHcFA0CFgOM1Z3HlmJdHQb7E8O6NsIRutZPJLU18Aepj+jH9?=
 =?us-ascii?Q?V8T6lE65RlZxj+AfdH9+h5BVQ8HT7NCffcLoZKgLENm8WPLoFdXVvJT5s6yB?=
 =?us-ascii?Q?5VmnSvrVVdTgGAaC/LLIteFO8EW+zCTtOj6Aud53DTGQTBDYfFXbSjbCPDSX?=
 =?us-ascii?Q?y+xsxweZcBwen3fMNle0I0Mu5ej8U8L73XimVpZ3iIf5gpRiQsZqUz+jNNTi?=
 =?us-ascii?Q?GGqeD7FBqnBMDLPVS5N4bv4LgaX7VxwOt9tSSh3d4T3H+gsjCHBA4TZF5GAO?=
 =?us-ascii?Q?2Ajcw1vlDf/6IeQbqLE495GO1eRlCdlr7Nuj7In/PyAnuQBfr4g54+lGC/6U?=
 =?us-ascii?Q?R/mfYHkX1AqApm9ZVHkKJkgcmtNM5SkZc5souz7dmAwE4XdCj1GfvrS7QCuH?=
 =?us-ascii?Q?E7uOPcMrtK0VYnrHVtJEj4cMwDlv/KfRsBsyvfRFq42KeboSFoD55fBGYSB3?=
 =?us-ascii?Q?39205d3F8KKCBIwcmQpnuelodhC7RkiqG1EKWM/w82KS/181/wWdjIVRYV/h?=
 =?us-ascii?Q?63uPWd7Ng1BVFbgysef2TwzsA/J0WMGFXNYdG/PO2d7YRV8SURRbaOMcEXb7?=
 =?us-ascii?Q?196jFah3XXTR1K8GCo707doBP8xJ63ikkRNvhAq/bcz72fE5+Wjl09R9NtJ+?=
 =?us-ascii?Q?8bs/chE98RLhqfbDer4vb8fxztt+ZEj4d1uX2XO+paW0AWVMvTPo/eopHhfH?=
 =?us-ascii?Q?eI18tkUkmUjFqJxGj9kmNY/QShPpei1qAWvEZmPraOPNBW8LBY/QaO1FHLYT?=
 =?us-ascii?Q?G5p/zeHn1kMVrLbh84owoh+tEWKrkS6P8NJFZOKLehhYiQogubGOJISFQwmi?=
 =?us-ascii?Q?ZA9C8z2iJTYdv5K1ebv8p+YxCbB7l5IahzYjT6qaz543P5vs35vRhCNKOx5+?=
 =?us-ascii?Q?93KTD2ELR6W4CYWJ6Z5vWAeKk5MXKDvb23bRuPHWJ7mgB/OE5V7bnGGu3Mn6?=
 =?us-ascii?Q?2EpjdcqCnSxhDR2qxuQLaz+V427TCSZ5MWrWCdvtxDzPMplviaY4sMxG2XC5?=
 =?us-ascii?Q?y013oAiO6vQcxEv1ZW636lLuEd/K0+xjop8jDE1s+vugb0qDUq58s185FvwH?=
 =?us-ascii?Q?sF6W4EQylIcxrKZeHMth9N7YCkC9M4sH/LCsu/ivNcAw7gMOeYPScxpPS7hl?=
 =?us-ascii?Q?/x8VxIjxJnQD368HX6szO+hUf6+0KEYRAzM9O1/XfikqG8zbrATjGyIVCr2G?=
 =?us-ascii?Q?X40PV+huT1bFX4O6hohdDY1GzgnrwBOfaez4mcSZIRUaTgqRNybApXlaVoNy?=
 =?us-ascii?Q?3YaCyHtSlt1bzbiU2It1DOv/Qo22vHlbcveOHAKoO0J6swr0KXJQTOvo/TfB?=
 =?us-ascii?Q?M7tXeTxBCQcy1pWPPkYBcTuc2yPEc+4MM194lqaQe+GkB9jEqqPt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c410d6-abfb-47f9-efa1-08de4f704dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 11:14:49.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PknLes9mu+3LvuGz7Uoi3sNVpqt7J4yQPjefxG7QrHk9Az84rpY1V0YItgWnki5bskCxhBd4yAsdJkqEAqamUvv6G6hPX2t4TsFrqzYlkdFJ4UMnMxaSSVAR4YgHeyk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6815

> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: Friday, January 9, 2026 12:00 PM
>=20
> Hi Biju, Cosmin, John,
>=20
> On Fri, 9 Jan 2026 at 10:06, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com=
>
> > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose
> > > > > the temperature calibration via SMC
> > > > > SIP and do not have a reset for the TSU peripheral, and use
> > > > > different minimum and maximum temperature
> > > > > values compared to the already supported RZ/G3E.
> > > > >
> > > > > Although the calibration data is stored in an OTP memory, the OTP
> > > > > itself is not memory-mapped, access
> > > > > to it is done through an OTP controller.
> > > > >
> > > > > The OTP controller is only accessible from the secure world, but =
the
> > > > > temperature calibration data stored in the OTP is exposed via SMC=
.
> > > > >
> > > > > Add support for retrieving the calibration data using arm_smcc_sm=
c().
> > > > >
> > > > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > > > >
> > > > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesa=
s.com>
>=20
> > > > > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > @@ -4,6 +4,7 @@
> > > > >   *
> > > > >   * Copyright (C) 2025 Renesas Electronics Corporation
> > > > >   */
> > > > > +#include <linux/arm-smccc.h>
> > > > >  #include <linux/clk.h>
> > > > >  #include <linux/cleanup.h>
> > > > >  #include <linux/delay.h>
> > > > > @@ -70,6 +71,10 @@
> > > > >  #define TSU_POLL_DELAY_US        10      /* Polling interval */
> > > > >  #define TSU_MIN_CLOCK_RATE       24000000  /* TSU_PCLK minimum 2=
4MHz */
> > > > >
> > > > > +#define RZ_SIP_SVC_GET_SYSTSU    0x82000022
> > > >
> > > > Maybe add a comment mentioning firmware should support this index a=
nd
> > > > the otp value is stored in
> > > > arm_smccc_res.a0
> > >
> > > The fact that the calibration value is stored in .a0 is clear from th=
e retrieval code, let's not
> add
> > > comments where the code is straightforward.
>=20
> Agreed.
>=20
> > If you have just a0, then driver expect a0 from firmware
> > is either error and OTP value.
> >
> > If you have a0 and a1
> >
> > Success case a0=3D0
> > Error case a0=3DSMC_UNK
> >
> > a1 will have the value from OTP.
> >
> > > Regarding the firmware support, it's obvious that the firmware needs =
to support this and that the
> > > values don't just magically appear, no?
> >
> > How do you share this info to customers that they have their own firmwa=
re?
> >
> > Eg: Customer firmware is using different service ID and driver uses dif=
ferent one.
>=20
> Specify the service ID in DT?
>=20

We can do that in a separate series if / when needed, and use the
RZ_SIP_SVC_GET_SYSTSU value by default if the device tree does not
contain a SMC id for the TSU.

> > > > > +#define OTP_TSU_REG_ADR_TEMPHI   0x01DC
> > > > > +#define OTP_TSU_REG_ADR_TEMPLO   0x01DD
> > > > > +
> > > > >  struct rzg3e_thermal_priv;
> > > > >
> > > > >  struct rzg3e_thermal_info {
> > > > > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(str=
uct rzg3e_thermal_priv *priv)
> > > > >   return 0;
> > > > >  }
> > > > >
> > > > > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv
> > > > > +*priv) {
> > > > > + struct arm_smccc_res local_res;
> > > > > +
> > > > > + arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > > > +               0, 0, 0, 0, 0, 0, &local_res);
> > > > > + priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;
> > > >
> > > > Do you think it is worth to ask firmware team to return error value=
s
> > > > in a0 and actual OTP value in a1.
> > > >
> > > > So that driver can check the error code and propagate to the caller=
.
> > >
> > > If we do that, we will have one more variant to handle here, as we ca=
nnot make sure that the TF-A
> > > running on the board is always the latest.
> >
> > Mainline will use new variant, that can have both a0 and a1, if we take=
 that route.
> >
> > > Right now things are simple as it's either supported or not supported=
.
>=20
> Agreed.
>=20
> > > If a0 is some error value, how would you distinguish between an error=
 in the new variant and a
> proper
> > > value in the old variant? Both cases would only populate a0.
> > >
> > > Also, I'm not sure how much use we can get out of a TF-A error value.
> > >
> > > The error that TF-A already returns in SMC_UNK =3D -1, or 0xFFFFFFFF =
in u32, it is pretty standard
> for
> > > SMC calls and the probe() function already checks against it.
> >
> > The OTP value can be 0xFFFFFFFF, if it is not programmed, if that is ca=
se
> > How do you distinguish error with respect actual otp value.
>=20
> What is the expected behavior when the firmware interface is not
> available, or the OTP is not programmed?
> Currently the thermal driver fails to probe, which is IMHO suboptimal.
> An alternative would be to fallback to default calibration values,
> as done on R-Car Gen3.  To handle that, rzg3e_thermal_get_smc_trim()
> should store the unmasked values in trmval[01], so the probe code can
> detect this case.
>=20
> BTW, what are the default values of the trim registers on RZ/G3E, when
> the device is not trimmed? Or is this always done, unlike programming
> the OTP on RZ/T2H?
>=20

Only early silicon should be missing the calibration values on RZ/T2H
and RZ/N2H.

For RZ/T2H, I have:
rzg3e_thermal 80086000.thermal: Calibration: b=3D0x33a (826), c=3D0xcd7 (32=
87)

And for RZ/N2H:
rzg3e_thermal 80086000.thermal: Calibration: b=3D0x30b (779), c=3D0xccf (32=
79)

I asked my colleagues for their calibration values and we have the followin=
g.

RZ/G3E:
rzg3e_thermal 14002000.thermal: Calibration: b=3D0x2c6 (710), c=3D0xcd5 (32=
85)

RZ/V2H (has two TSUs):
rzg3e_thermal 11000000.thermal: Calibration: b=3D0x319 (793), c=3D0xcbe (32=
62)
rzg3e_thermal 14002000.thermal: Calibration: b=3D0x333 (819), c=3D0xcc8 (32=
72)

RZ/V2N (Ovidiu is adding support for it as a separate series which depends
on this one):
rzg3e_thermal 11000000.thermal: Calibration: b=3D0x304 (772), c=3D0xc91 (32=
17)
rzg3e_thermal 14002000.thermal: Calibration: b=3D0x307 (775), c=3D0xc87 (32=
07)


We can use the average of these samples as default values, they seem
close enough.

In a future series, of course.

What do you think?

> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

