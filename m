Return-Path: <linux-pm+bounces-23639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6761A56CB5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 16:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF36A3B0C47
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999DD220699;
	Fri,  7 Mar 2025 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="CcAOD66v"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011022.outbound.protection.outlook.com [52.101.125.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9AB22068F;
	Fri,  7 Mar 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362934; cv=fail; b=DmCYj31zyM42o5HyBzFTWL0clMmunnEGImNGvyJL68HEiYEs8ky9i4mFo7qmzRvm2mLZ4XC31LxCrcKuCHedv++wdDNbz19T0qLglCJfIOVwEfeeTH4em32tEHCZ5HZyR07Cvj4d5UAE6FNOOVXLdOJDuda8BL9/JboPnk6XKJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362934; c=relaxed/simple;
	bh=MAI6RaZ1Pid3rbBKH8a+MIc2ZvBceIzOwYBXexqqACg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mp+bET/vHrxIS9iGU8p3mairD+kZiFnBKGfSGxa+fohfkomulX7O+rcqu1cbPVw7im2ffKs9n0Mn6U0j/LI7u02KThKgdHFPSatdlR2gIXPjhZ+uoZGh6VgBZoPlrp6sdPn3Kmxunw1aCej8G9FBEYwIe3sfL5blYEnN89wR75I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=CcAOD66v; arc=fail smtp.client-ip=52.101.125.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuQwpBSktw08vMhDNVHAEV75jLhRSff9YpCQyogE/75meAoHfQMaCQyr9bjftgfKPvmTIZQc3hrY5nc+sDTHDXJnNT7TbHTpJLos50I6v60yGFERRcXK/WUgg9XJCDGEqXqaqhoWRlJiBntSPvCGVOWhl0SG/+AoUldBgXtzIfIiuW5v584/oGPj1X9z4JGRt2IFFDHEBWYreRsa8+7rWpX8cGkuSn6VCOCRyrY3aPf3JSeoX4jRWR1I8msKOltvP0iA/8hZvdX3m8CH+DUAz+c0odQLTz9gczbpo6C34qHaEVEwLzLIe78RX3ouHH6beFulWH4cB/89FZdZZ9O3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+TPUM6lLT4F42aTHtMfIaGIT64ZHrncuMb2K0KsmI4=;
 b=ko91cnJXY/iQR//cAwiz720eBsjyt3Q5YiHNH4fCIb+xSsuwyw/Qf67uYp0jLHDuD7GO7781Esb52Ib5k9EiUcmFDXxzq4n4F3fNOxFltby9hgitVyB/Lya0wjoO1Kt+sVxTyilMTAjPpcgUsIziooMD9XiKZVM88b5LKo66BujN5vMtxBptmMpHxAzzBirzQaA/vAU31dwkESPWh9baUp1wtyxV17AERKFVIADHtdVpKffksD5x+MuBdKUVfU6TqV8GK85BJAXZ/zu3WQf2PZATMi9IGMA0Wk5oxhesrGMDJwIwIY0OejUys77M3M/3u6OQ7QVATSOW9Be+00ucFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+TPUM6lLT4F42aTHtMfIaGIT64ZHrncuMb2K0KsmI4=;
 b=CcAOD66vR8aHMZ4udMyrP9Oy9nnxYJriClkgMSLMf67puOY4FUveRsNFNzlremh/tGCy7uZ4IqRq3gKswUJoa2t2OEuSh0fNAkUym57zS1hZaRpN/W/gUDxbbr6oYggHDA5W616eiBwwlHYYB3jzQi+AYPKHgE/ERA1Yof0yQug=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TYCPR01MB10605.jpnprd01.prod.outlook.com (2603:1096:400:300::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:55:28 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 15:55:28 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>, "robh@kernel.org" <robh@kernel.org>
CC: "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Topic: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Index: AQHbiRKwzjBFhg3PXkG3oKF6ljEYA7NdFKWAgAc7OeCAA4ptgIAAAsFw
Date: Fri, 7 Mar 2025 15:55:27 +0000
Message-ID:
 <OSBPR01MB277531D7C872C9EB0B287069FFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-everyone-ragweed-e05a10a9646b@spud>
In-Reply-To: <20250307-everyone-ragweed-e05a10a9646b@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TYCPR01MB10605:EE_
x-ms-office365-filtering-correlation-id: 162e482f-d38b-4f08-4221-08dd5d907b28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?66t9DjxM9xxcxTSpx6ZersGiLuk213a5c7XD6FJqEs0+tTSfgnHCc3zgi+be?=
 =?us-ascii?Q?b8MLmONu5LWVeRW53Mqcz2u8shFmEPJk+rwfph2zWnr6fvZQaKbBXlDxzuCN?=
 =?us-ascii?Q?tuiTvfiAFoyqIzvDb3DFOkl3EUO0jg4GLvCb07eAnoS1BLmocyu8hAT4YnuV?=
 =?us-ascii?Q?L9w6WNp0K+ucldZy9Nt/jIFFQlwteWkG3atPCxntVPzUI08B1HFnfW6uCvEd?=
 =?us-ascii?Q?ImhcpTxXCXt4ugEh5/xEWZzwMO3aQaWhIRrknkbAMNuUQpkxWPhMJ3ePUvc9?=
 =?us-ascii?Q?t9CB8wEdrp6xS0X1t34dXwex01lP6gYM+oQrCX9QGxyEhi+UCafEdiWbMTgf?=
 =?us-ascii?Q?VJqaY8qfFJo6i5Sha/2PQI+RUH9s7ZeTW7esmGP6um/tePrwMIvRTcp6HhtL?=
 =?us-ascii?Q?I9wKIuoYeBbTQ+BilZoiaijCEh+segCKht9hCPAR0Z6fJ4e4CemDATUZ/paq?=
 =?us-ascii?Q?L/OJd6iPCMbZtjS8+7E+I7RXYfatvNsie2Oi1Nts7+uZrAFpJXjgPSxwiAaQ?=
 =?us-ascii?Q?96zj5vXTwm0doI1grNq9IqJyH53/LoIRJzOhaIklxwELX/WgMVL6cBYha92p?=
 =?us-ascii?Q?WFdVTr77T5wiaikxR8NCUOSbqcZMBFFJWhnpO1xwgvvnbQfkpYNtVGq9js4c?=
 =?us-ascii?Q?1PQQddINc/iJz1hSN3VO/A+QB3Pbl2K6w+EgUahUkfYe/Jd3soT6XrHAkX+5?=
 =?us-ascii?Q?ugM/+Rlfdpk3MAd8FcBgGrGpUUOUQCT+v4QR9K6Hggov+Fe7lEhMrNdpYgXU?=
 =?us-ascii?Q?ay/iExTC/KgYlhbdtEijQsStpRTdOGGH5bovzxZ/gqysIRWMWgdtXX62/cxP?=
 =?us-ascii?Q?7SqrPf5Qcg6o03e4Yi0vHr6koNvfjMBZ+e3oqyTKxkCJNPuliCW80TAaKjmF?=
 =?us-ascii?Q?gCR/C43l3pzNlbpVjyOozMUSoC9gz4ErYLqqfBH5B7sAIzsY8yAXWvn3vHvY?=
 =?us-ascii?Q?jM2wisQZeXE3DNUA1cR5dhLcMELf7leeaSRbVxDq2J1eOx0fPwsJQKIOpc+8?=
 =?us-ascii?Q?01YrYwNKCQii86Aql8zf7xg5NTqbKQqM4qIJ6IU+kIJS+zeFmopMGB7f/soP?=
 =?us-ascii?Q?RYOs04T5HsmmUfVmK4ZAxqibqiVCd2cHtWiOdxeayQnEmB49kKSvAlkbwsmN?=
 =?us-ascii?Q?BLogOssn2pGGavPErqjcAiskKq8jW72jf8XiJjSk2pWdGkTRdtozrOLbzkBa?=
 =?us-ascii?Q?z5Nx0BBovD9xJhQQIoHT56ey47duElJOmCNx3BqGbLpOBI/Es81uYXOFFXhX?=
 =?us-ascii?Q?geaLMcGD9yf1c8zfoqcYco51XA/o8m+/7Ut9OJA11xJn3nPHFrAqgHE2l5gx?=
 =?us-ascii?Q?6u2UUPlUancwpykeoHJ4w8xP8OuFPF1Ssk/ccYnnjSy1FEIIXk5uYEWRvuRi?=
 =?us-ascii?Q?W3fM52oNmOsVJzolP4r6XwZp/khpMs1b173E3wFwMn70k6fYeTPvpLS51wV7?=
 =?us-ascii?Q?rMAcuO5y2BxX026sUltq9555qVQNcjH1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JBHb0ISVi8RXvLN95Th5pueHc8KjhLHZ36OxYPHzghS8J/hVKOho8q1azmgU?=
 =?us-ascii?Q?fksAXjQ5IJUWrjkConc9vfsg3Ybfd4N6LRGMNKh6M+Y2J4ZNcvDLvy+3ri4b?=
 =?us-ascii?Q?IrQs9lomjD/ZgNygQ1o4f7OIcy48Xb+Vbf2QH/ABzx1nQtJta5L6KNwt5fov?=
 =?us-ascii?Q?uFc4wZUjc3hp10Emhg5Sm5r1Z0RlDHT2WEmZUwASJ7diCwR5Q/9IInSB8ajt?=
 =?us-ascii?Q?vk/8z0ROrMR1PSQ9E8YLRCwnrZn1iG/n2FKqmUVNRaaiSquhsQYYBHWw6Ipa?=
 =?us-ascii?Q?Q8osiG9FiVplqz2P5pm8xZnBS9JOcWMmbOIhizFMwX3PGdnuKbMX+wqcT9wT?=
 =?us-ascii?Q?IC9XZmBqQA9LfxEqkO0Q5OhvnQ3aDEthBEbg0oCtU8H8OM0Zf1EBFKgvWa50?=
 =?us-ascii?Q?Z02zRj1DrfCa0jhYrGhsvWAyBjJG+/r89iR7cfX7Aa8x7Mo77yiU6OmIgATV?=
 =?us-ascii?Q?QoZNCY05wBdltUuxmBmO7as2Zb/a3ePittvEC5oO4IuvlTLt2oPHBTyhwQF8?=
 =?us-ascii?Q?8DZuj251XCPnSkSyUu2OnE1kXZgYuVuvHhF1U0ztAZocM6oC/Ian5KoiBSq9?=
 =?us-ascii?Q?bwIjjL7Xzn4+9oPpQYQivzPAaJca85bI2qDSRXLR0agRxHK6J5E3mQf/cLEq?=
 =?us-ascii?Q?1ALKrzU6jyUMhIYzNPSGH6tU7v5/AgeSVhzGIfgV9fq+CZXPk2yehVr6GTAg?=
 =?us-ascii?Q?U3+gyd0zjHwlpA6DLqLQ+cuPXOuUKdWJ4mUnTN2Tn1hsnhDnCPp6G3k0tvcS?=
 =?us-ascii?Q?YQgNE7rLLXmFGq99ok3t43HF2gJP/AbnP9/gLinnIujnTlxKnqDRhRHt2A4e?=
 =?us-ascii?Q?M/Au8LVoGJT3vo4Bhbl/T2bVcGMO/8ARaz4FAM6bv8CNHWbVFdn8PDBeBqKP?=
 =?us-ascii?Q?eDp+iG/W3d1BbleQMGAVhSX8zPzrOhQw3UP1Ts+AiX+ra6Yv5CxmKNJy9RdI?=
 =?us-ascii?Q?mXIlCyITCK8rtPFBlhZaFmMt8gw7Z3K0LnBVmV32qdbS2m8M0fAhsOsFCTJU?=
 =?us-ascii?Q?vaDES1ESJd2rRtMeytn8L/9IBwKnrmtTiSdvYufhCXd77LfgcPOIyUNKDmOM?=
 =?us-ascii?Q?1y6/zWXH9P6T/DO71mGUD1Sp/nsGJIlKF1evYEl3OIU4bdryOIE3uRA6ppmH?=
 =?us-ascii?Q?AMP9lEeuOmdKu7Jl96s2ZVmazm4REH0XB9+LCPR5yG6cL8Xh2Y2w33Ecl6sM?=
 =?us-ascii?Q?KWXn7XorTMrjrHXzyF0QY6pntZxh0oDmnkcxIEvj30hzdCmdfqr2I9olWQjS?=
 =?us-ascii?Q?AAjae1VnQ0kTW/5N1Q7Dy/0xkOjVikTHd8eZISqkRjVM80lgWXNz1Vh8HSet?=
 =?us-ascii?Q?HwBBWMiLPj6a0/qpSAjKK621nX1FyBE6/LKSgV7Odr3uqf2mnKKmxKalHlNX?=
 =?us-ascii?Q?UR3YdsgSeTJgsXhRFeQlO0pJ5Xd/CQTG/riJ+cRojDa7vcXqNfEANZC7guS7?=
 =?us-ascii?Q?yXUgBIB/KuRERPlIA1iOKWy7JmXsumtM+ObETP6WwgZGWgLZC3LQ+xQjFKJT?=
 =?us-ascii?Q?xkJQRxlHFZElSICrqm/9xraSUM2Gjxt1UQt1Xyg0ftBak/Z6wFVB2BHWIavH?=
 =?us-ascii?Q?+nDHDa2NHFOe9bSly3yKhIgtYnjJdeu9j7sLCsHEN3yF7uuthjBgfgs5ZK0x?=
 =?us-ascii?Q?hQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162e482f-d38b-4f08-4221-08dd5d907b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 15:55:27.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJc1y6TmK6HRMp1vXRCMVnSqNoqRsBhgTSLh9N2FltR8/l2A9rzbshPL4E409q9t72EuS6AvcD48RTlo6WkTPJm770+EfA0E3hHSsOrJevE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10605

Hi Conor,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, March 7, 2025 4:33 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document
> the TSU unit
>=20
> On Fri, Mar 07, 2025 at 03:14:05PM +0000, John Madieu wrote:
> > Hi Conor,
> >
> > Thanks for your review!
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Friday, February 28, 2025 8:03 PM
> > > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu:
> > > Document the TSU unit
> > >
> > > On Thu, Feb 27, 2025 at 01:24:39PM +0100, John Madieu wrote:
> > > > The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block
> > > > designed to measure the junction temperature. The device provides
> > > > real-time temperature measurements for thermal management,
> > > > utilizing a single dedicated channel (channel 1) for temperature
> sensing.
> > > >
> > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > ---
> > > > v1 -> v2:
> > > >  * Fix reg property specifier to get rid of yamlint warnings
> > > >  * Fix IRQ name to reflect TSU expectations
> > > >
> > > > +    enum: [0, 1]
> > > > +    description: |
> > > > +      TSU operating mode:
> > > > +      0: Mode 0 - Conversion started by software
> > > > +      1: Mode 1 - Conversion started by ELC trigger
> > >
> > > Can you make this "software" and "elc" or something please, unless
> > > people will genuinely find "0" and 1" to be more informative.
> > > And why doesn't the property have a default?
> >
> > Sorry for miss-specifying.
> > ELC is an external event trigger. May be should I specify it like that =
?
>=20
> If "elc trigger" is meaningful to people using hte device (IOW, it matche=
s
> datasheet wording) then that's fine I think.

"elc trigger" matches datasheet wording.

>=20
> > To make sure I got your point, do you mean specifying a default value
> > in bindings ?
>=20
> The property doesn't actually need to be required, it could easily have a
> default (say software) and only be set in the case of using the elc
> trigger - which brings you to Rob's comment that it can just be a boolean=
,
> setting the property if elc and leaving it out of software.

Got the point now. I can make it default to software trigger, and add optio=
nal
Boolean property to ELC trigger. Let's say "renesas,elc-trigger;"

>=20
> Rob's other comment was
>=20
> | Who/what decides the mode? If a user is going to want to change this,
> | then it should be a runtime control, not a DT property.

Changes are not possible at runtime. Some customers may want software,
while other may want the external trigger, and this is immutable=20
configuration.

>=20
> which I think needs an answer ;)

Regards,
John

