Return-Path: <linux-pm+bounces-40526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F9D08143
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2FD30115D5
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E59358D11;
	Fri,  9 Jan 2026 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="VS7iaSqB"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010006.outbound.protection.outlook.com [52.101.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E0331213;
	Fri,  9 Jan 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949587; cv=fail; b=aJispxQVrnpmGdok5itRYnVCv+RdTI0E2GL9yv5YUb2VFKeUxVd1YLldyIFapxOXeh5lZwEA+iQ5oxv8pembNVabvcdPjDKbBMBVmiSSFX3y7VdhArLOoCBt+sPULuHTBwfRuARJ++E6GUprPUaHqUZUhJro4xcOrPEwmncBygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949587; c=relaxed/simple;
	bh=kdeYFITenbbLHevRSSExvkFao5TLf1nNAKHUwhVRxVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lgMeDWZ1VSAVusGRayaqpxUVYBXD3SzTErFah+zKWpXZMKG3e/Ql1sAlMQVkU4fb1rfpSxt6LIUiTaNyWMhG5fXSQgBUDaoIKiB/gICNR7kbK6u3VZtkMagteFYCisZVtvWHjWK/QEubpaaZeoNtO2aYiZXw+RkvxBSy5KA5LCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=VS7iaSqB; arc=fail smtp.client-ip=52.101.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYyTzDCge+1spYPESboePjs6AMlVPBr3BM9aFNYF2yNy+gJFc77w3SFClLYyDMu8LWHcfs/rBlSbfRe4NkUjIroHw/wjWq7KJ113dCbA+fcIg6aMroIxqsYnHJOg/7kqb7ZP2LNptODVgOWzfo49o2OR0cJhP2vTSMNcZotQrIxPw6ZFGrL3PbAM1MpXM3SLN/xyPXUOBSCGEceXUSrSJirvmb0OO1rcPNgppsoglax/eHni720EcrTL3Lf5ocLKewm5fhNk+p4dpidWZikh8DmmTwP9Z468gw1diYMlGDCsmvNGaqo57pSNty3/QqL/7ZNuLlwKrhiYy8mV9o3VUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MjqDHWSz+23Gs/0yGX7Az26sMms6lEvdrAURCXDY2c=;
 b=OVoIXSj084CG78QBei2kmbSdogCeNl3aI/iK4E05yYwvp05eebIK2Qttz3UnLRQ0QyZG/s2VSQYQcPlwM2KNP54mC81Yc5YFdjnOUwnDukqZEuKmhYICsIvziq6O1QhkMYH0vYs4jjfiXIiNz1E1v61PrmTCUAhCBOLsv6/Y7V6K7DYprTLvge7pqNtc5ps5xLM3oYhrSI6v4zmVff9Dv5sqOhMMBnQl0oFIQvCF4IKHZko5HmDbgUHODQ+C+mmCApYqvGoJZBjreI3udpn+w0AG3Vd+fNXVIHZsLLCb9SInBLhKaXSRBCqTaY0CgvHJGCkoberAolGu58R6WvPLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MjqDHWSz+23Gs/0yGX7Az26sMms6lEvdrAURCXDY2c=;
 b=VS7iaSqBgyIazbj9i4K40Y6jJdHnMi1wPF3InqRE2ZrGsQS4+jbpf4GyJaC/212rxh3XkEzZga3oLQ9xNwrS8x+mxKpKbR+FQSyzD4Lu4xtyo2MoFib/vWTLOgyvjBQWeWzqAmpXIKcOd1p+/uxd25Aw5zkSu0CdDD3Uv1FPbJA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB15680.jpnprd01.prod.outlook.com (2603:1096:604:3c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 09:06:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 09:06:19 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, John
 Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcgNjpP7tWju4kVEOD2PeFnHW2A7VJWgkggAAujYCAAABl0A==
Date: Fri, 9 Jan 2026 09:06:19 +0000
Message-ID:
 <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260108195223.193531-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY3PR01MB113464DB06BD82F3CC72B5B458682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TYRPR01MB15619CB167FAD4042FE45D95A8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYRPR01MB15619CB167FAD4042FE45D95A8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB15680:EE_
x-ms-office365-filtering-correlation-id: b4aa3a35-480f-46f2-6ee9-08de4f5e5a4a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BEIpzu8Z3Fnkf+GMl/2vGGySHubScE+B1Fmh30FHiYj5ynqRdVc7m2Z1Pqsh?=
 =?us-ascii?Q?93jX/0FXprScISv+b2S9tQYk7yxikODn8ZztPXQ9WJFJ45BeA4TZMsasLn7B?=
 =?us-ascii?Q?EmsBN0kN8zBXgWvkE0pJX/RkRlmHIKlOjsCGW6sJcCrdPjKKsb4GQaZXy3Jv?=
 =?us-ascii?Q?UvyEt0DS+DeAkAblIWADKA2KPsxOQmrLIkchJLmWXkPsJqWjuapGN8cTZOsJ?=
 =?us-ascii?Q?RgpEIeFmOjSY2sAKgQOgxpNKjotSXpCU87hAfoWiclap5wEDOlKoxUwN1qmC?=
 =?us-ascii?Q?B2G6CV5AuMDT9slQ1knGX/PvHezR0Nep05eTGkdbtqo2+OEZ6MXodIeFKh7h?=
 =?us-ascii?Q?6z1Z7T+XSr3cmZH45ZoTs2nJZPtERZDpspByuQp9q/S/wws1YtWf1hZxL1zI?=
 =?us-ascii?Q?xJw1at3ftpQXD4DQUKyZ194KhX+FZGtSATQ+cbwV185UbkQ3JmNlDk8Vv8+J?=
 =?us-ascii?Q?j9s8n/i9z0OlioiAeJZY0sk6ZP1EIAJ3o0scgeZtn86xstcvLaRYdUElBx/d?=
 =?us-ascii?Q?qx8Mj0PdFsX6xLLlmyfk/u8vmNCWtLqoawNfB977Z5iWYmjNudrOyxx7ERp8?=
 =?us-ascii?Q?p0g41akU7qZxCyDdw82OJ2sNqXyUyQ9dYTApg1OUxkbb/d2SZiwlcucgUssS?=
 =?us-ascii?Q?DbPCx3yeHRKaiVKyrMO/m4z+Og/V03G34YvEzENt2m6XHw2eZrfxUFWVH+3x?=
 =?us-ascii?Q?vPF7DEQ1Qa7cGyyI+IRi69VHUwn7D1DvbKCndRO6arQb796xKTSI8oHUdYHr?=
 =?us-ascii?Q?DplKZHD6mZGWAqHEKM/tklMlT7yUJhv0uO+bThol2o4yqDjwE0R/wkFAiy7E?=
 =?us-ascii?Q?sNUS1IKN1jY0XNpoHayIK4oY+cXG7EeUPaMLlKCvhkGruJnGmc+vGvOrqsRF?=
 =?us-ascii?Q?PbVn70SgYwC/em1EbR0pN1dq8beQz+QYfriXfl80HkpXR5T2mXm0+hEVMMbk?=
 =?us-ascii?Q?Bk0adsREr7vBZQaXjmIM0ofSmHGW0sMRBfgEdzAj2ksKUxXKI2KU0Mx32PgY?=
 =?us-ascii?Q?j7kVLlklN4U0irxFaAgI+OF5HDyMBtCYXltOW6r53pHI0Bhmg2UHqgxB1ejw?=
 =?us-ascii?Q?G/AMIm4dRnFK1YjN0JqFC+/g0SD7J9Fa0HWMV2vMG4qNw7yJSTRvD2yjqjya?=
 =?us-ascii?Q?RpAGM30qAQ6LcjUeW4o+01SWl71D2Ok0u/DgxkRP8fHED6sryUCHwgkyrqYX?=
 =?us-ascii?Q?E4z1GecbB6cuyjGqmmhbIj9Ji3RYLkIiec75iezuJBT93tlEvky21LcNB/UL?=
 =?us-ascii?Q?dppQKlqbOsw5SwOU6lUpeZl4uHOpJp67MaLwbxkFiEc3/cq5whtCTRKjEc+Z?=
 =?us-ascii?Q?Dummk8ysc33bBOYyXjyJKgNcElgM0dUvfl+hpqGieFZKYF0Nq2x+s2IaXesY?=
 =?us-ascii?Q?CJXABLl+1j4wGGmTr9fvcLdgary/niBGNpgcN7GEz+JqcfWXgi5aTZ5nsTKC?=
 =?us-ascii?Q?oR5LD83YSN/BAl83DIwcdt8k2FQ/csREut9uLCP+dLqfrZe1LS2TOKvNiceV?=
 =?us-ascii?Q?B6Z2Zt/jdjwTS7lZN2uakoULGU01WLPj3N6G5DJGAgfWKBfzmwQD1A43dQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N656VHRJ/bPnz/tzogDhMV9Jt3n18imVAU1BCCbDV801yrg0uLETs8PwN5U9?=
 =?us-ascii?Q?Z7nCr9mAByPIwKIE04S/C9aJdr2Pjn3iAjkapYMYbfXCGQzPLxvqzGgXDQth?=
 =?us-ascii?Q?KGnMD3G4fvts2qsV7oIiy2OmXs4ctdcgAxhr+Xts/BSUYCQIv0k94KQr/Tc+?=
 =?us-ascii?Q?PCfeWNtsXg+nZHRqArupZgoy8Tff7y+9nwTnu8HmqRhJHLUda64lgVYHSezX?=
 =?us-ascii?Q?IRfyAfpCQkR9U6Rw9d/TTCQ9sJQ/TvBk8L1vRej9JqJrjuzHLppCwTVQquY/?=
 =?us-ascii?Q?GUXM2Kq5O+XFql/by/DJXGG+zKWD8VYAFSyLO2XgcWSApEeWYm9MML4inFBD?=
 =?us-ascii?Q?OX8lxhpi5lNq/9CBjnAtWDOYbnAbtNUcitJtbh3facy2O6yBXDMQJQ+WHJ9u?=
 =?us-ascii?Q?xAjjjSqxacNadpmgaDenWJO/ahW+9FLGAv+cFKLcMC4eoZmyTn0V0v50Tsq8?=
 =?us-ascii?Q?SFKOtrKZynZSegdE+eZlox7ES5QgJr9QszxWTEaqBbgmDcRzd7yWPvIwCtty?=
 =?us-ascii?Q?43JdOQSASjO34AvHVBbJWO/SoUvH7R6M7rK5cdDxhrySfe60kxV0MM2o8NRR?=
 =?us-ascii?Q?Of2MbFEhFZJtBqLKKkTr4D0EE0tNypvSHKpSLkuowFULCsUrlE1pVpFNCY4G?=
 =?us-ascii?Q?b0Z/WIYCqmj8mhcoTn3lre3tbeUBhzJ6e8WtTKN4QcYQ1LuDXeBbPauc5U4N?=
 =?us-ascii?Q?UOiBMe9a1XGiVt/BZvxoYQvNzpX0z/LZ4+pKF5uidUn7ARW/+hHCGWN5jIaV?=
 =?us-ascii?Q?VyoHnD44D0EZj5l4ordp5lC/c4Y2BoBUXmFDyBSfDmOMSRmspGZ9ofiCkXmS?=
 =?us-ascii?Q?VYc7sFQPe4LcFuxrm482PTQphZo5TZ8WADyp7dTnsmwGtL4DG3e9tQKRTBtr?=
 =?us-ascii?Q?G7LeweMe3BY0h6dc1nMbt22hPNj/Wn9Xop8ZeFonsqURjun3iyVp2x9e3ZPK?=
 =?us-ascii?Q?Iq3RuzQARQFDn3k65xmGXzRZFBA4Rn+n1fxqhBsx75u1GUj+m0u9IvLZO44a?=
 =?us-ascii?Q?RrL4jurjX/i8m/k9Iw2Sn6yRWKwV8AVKKrGO/0VOKTou0tiwarMn6RuXDu8Y?=
 =?us-ascii?Q?Di0FcG6SOoCOsMnx8t3iEJUqUb2X1QA1Vb1ji7/oR4v4GHQAXcVyyCtTgdU0?=
 =?us-ascii?Q?z0hTrIyH/DyvoKyY28n+Tk1qwP0oSF2NrJrisRVr0Xz+iP8rBYyNBdUPYbUc?=
 =?us-ascii?Q?FP5n7KUAy/l1LQCJ3bBm7krO9ZF+ZLYNvX8WxB1iDbRNP+ST0yMraiAFV/k5?=
 =?us-ascii?Q?iyKQASkFnN4pn4x+CFvredBaTf17EAJ7BegZjiF6uXkUjL+5VTLLwW7bmtzu?=
 =?us-ascii?Q?C3922oozLhtwIGqQpD99IwyMCL/76bdUdF4THV9Vmm2IiqdfTUyGYlvMtdH/?=
 =?us-ascii?Q?SeC6rMNDCWpHVLxSxfl1ZindqufPC7XjGq4mm9qHF3fCQWzM14trTD4FRbxx?=
 =?us-ascii?Q?MUJdgwcvXrRqD7QkoRVwqIOKR/JQ7oGDWIDF7z5RHr1G2Iy3oRr0gtNrcbO4?=
 =?us-ascii?Q?XX0klSr8FjxCIfmWlGrtmd4VAIe+xlagruHe6shHGnIVScF8+OYz7f35l43K?=
 =?us-ascii?Q?6PSjyh20GW3KwQ7b4E5Dhsr+QD2qMYRL/IywdxqiCRkxlcZ7oA+fKliF4Cxh?=
 =?us-ascii?Q?BX6gseSNw+O96fu8L1jK1fb+05G8LFg3n8UTZCyEYq10rDl/pfvSeVpRLrvY?=
 =?us-ascii?Q?fbjB8nBFACJZ2q5oiGnQ8Y0xIsOwWKoMWd5NdLqJaBRLoxVjKKy8TDssPCu7?=
 =?us-ascii?Q?ip0XJiEdJA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aa3a35-480f-46f2-6ee9-08de4f5e5a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 09:06:19.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ihy45d7XdCnWwZaX8xxZ4DK3KuosFRPptwo+uHXe3HFLLE6+bDNQ0z+QN0xCsZVTBXCBPyGjxVSCArUh823hXwnkDLgN82fXlzz7ou9Q6ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15680


Hi Cosmin,

> -----Original Message-----
> From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 09 January 2026 08:51
> Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T=
2H and RZ/N2H
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Friday, January 9, 2026 8:12 AM
> >
> > Hi Geert/Cosmin/John,
> >
> > > -----Original Message-----
> > > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > Sent: 08 January 2026 19:52
> > > Subject: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for
> > > RZ/T2H and RZ/N2H
> > >
> > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose
> > > the temperature calibration via
> > SMC
> > > SIP and do not have a reset for the TSU peripheral, and use
> > > different minimum and maximum
> > temperature
> > > values compared to the already supported RZ/G3E.
> > >
> > > Although the calibration data is stored in an OTP memory, the OTP
> > > itself is not memory-mapped,
> > access
> > > to it is done through an OTP controller.
> > >
> > > The OTP controller is only accessible from the secure world, but the
> > > temperature calibration data stored in the OTP is exposed via SMC.
> > >
> > > Add support for retrieving the calibration data using arm_smcc_smc().
> > >
> > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > >
> > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Signed-off-by: Cosmin Tanislav
> > > <cosmin-gabriel.tanislav.xa@renesas.com>
> > > ---
> > >
> > > V5:
> > >  * add arm-smccc.h include
> > >
> > > V4:
> > >  * pick up John's Reviewed-by and Tested-by
> > >  * replace new macro TSU_TEMP_MASK usage with existing macro
> > >    TSU_CODE_MAX
> > >
> > > V3:
> > >  * no changes
> > >
> > > V2:
> > >  * no changes
> > >
> > >  drivers/thermal/renesas/rzg3e_thermal.c | 27
> > > +++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/drivers/thermal/renesas/rzg3e_thermal.c
> > > b/drivers/thermal/renesas/rzg3e_thermal.c
> > > index 97c4053303e0..dde021e283b7 100644
> > > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > > @@ -4,6 +4,7 @@
> > >   *
> > >   * Copyright (C) 2025 Renesas Electronics Corporation
> > >   */
> > > +#include <linux/arm-smccc.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/cleanup.h>
> > >  #include <linux/delay.h>
> > > @@ -70,6 +71,10 @@
> > >  #define TSU_POLL_DELAY_US	10	/* Polling interval */
> > >  #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
> > >
> > > +#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
> >
> > Maybe add a comment mentioning firmware should support this index and
> > the otp value is stored in
> > arm_smccc_res.a0
> >
>=20
> The fact that the calibration value is stored in .a0 is clear from the re=
trieval code, let's not add
> comments where the code is straightforward.

If you have just a0, then driver expect a0 from firmware
is either error and OTP value.

If you have a0 and a1

Success case a0=3D0
Error case a0=3DSMC_UNK

a1 will have the value from OTP.


>=20
> Regarding the firmware support, it's obvious that the firmware needs to s=
upport this and that the
> values don't just magically appear, no?

How do you share this info to customers that they have their own firmware?

Eg: Customer firmware is using different service ID and driver uses differe=
nt one.

>=20
> Let's see what Geert thinks.
>=20
> > > +#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
> > > +#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
> > > +
> > >  struct rzg3e_thermal_priv;
> > >
> > >  struct rzg3e_thermal_info {
> > > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(struct =
rzg3e_thermal_priv *priv)
> > >  	return 0;
> > >  }
> > >
> > > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv
> > > +*priv) {
> > > +	struct arm_smccc_res local_res;
> > > +
> > > +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > +		      0, 0, 0, 0, 0, 0, &local_res);
> > > +	priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;
> >
> > Do you think it is worth to ask firmware team to return error values
> > in a0 and actual OTP value in a1.
> >
> > So that driver can check the error code and propagate to the caller.
> >
>=20
> If we do that, we will have one more variant to handle here, as we cannot=
 make sure that the TF-A
> running on the board is always the latest.

Mainline will use new variant, that can have both a0 and a1, if we take tha=
t route.

>=20
> Right now things are simple as it's either supported or not supported.
>=20
> If a0 is some error value, how would you distinguish between an error in =
the new variant and a proper
> value in the old variant? Both cases would only populate a0.
>=20
> Also, I'm not sure how much use we can get out of a TF-A error value.
>=20
> The error that TF-A already returns in SMC_UNK =3D -1, or 0xFFFFFFFF in u=
32, it is pretty standard for
> SMC calls and the probe() function already checks against it.

The OTP value can be 0xFFFFFFFF, if it is not programmed, if that is case
How do you distinguish error with respect actual otp value.

Cheers,
Biju

