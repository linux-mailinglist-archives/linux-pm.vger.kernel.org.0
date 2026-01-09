Return-Path: <linux-pm+bounces-40524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1FD07F8E
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 09:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B16723009241
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4AB352C21;
	Fri,  9 Jan 2026 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WIETuEiz"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010041.outbound.protection.outlook.com [52.101.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA83350A15;
	Fri,  9 Jan 2026 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948695; cv=fail; b=fk86r9nE18JC1Hwf8+WcL1DrnzH7EdDU3qgArFTL+z+3vRNM4F/0vr/4qwyy0Mk45oJ8feiJXMn4BoKME9n9zD1R866yuRM4X435Ai4mwXXK1TYmYnB/DMRnUTXgeg3KQ7JTUGI1hlpVZWhh8o1TJ2pTIiQYBLunxS9Rtm5OP2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948695; c=relaxed/simple;
	bh=z6Yz18U2V2WNzqZDQqh8SP2EcTirYQDfoGBE2On70EU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kloMHNVKN2lVNatD1LQ8UH+VCMwQ6/stvTjNEQDvBjmsIjXE8jln2uGJ52MUw9ZaagtGNOJ8ikAl2k5JFJq9KgtNSh8cui51zevVytH8HkrvC9ubwbY7M6sLmgQfX6dSqjZ7Ryn1BIHxf1OE2+tB5Eg/s2uQ8FGZPIkEk1VtC5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=WIETuEiz; arc=fail smtp.client-ip=52.101.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7l/joVUphis8apF6VwuX83KrpJGwdTjsvgFUQjKBrAMgAZBt6SHP47uqJwqCLrRe0pHad3ZrEckPDMEdoukgVuCxkVzJAPq/YiRAtVpoRADVQCUywQ6Tw0w5HykDGXucOJ+R9eWBI5s+rmWsJsu6ZDGBeEDJc73AsTeMrC2D8mPjmG+IEoIUgpGRD0zzjvJ9NStaQ3Rk6HtxWNoPpI3vimFvYOfAIjpHJV1MYQ1pomL2trMwHoTtEym16Nhgaoz/yXmjUa6uI76LuT3sifBhiPl8hK8+fL/CugQ3c6s7V7sS+B1nmQA2yHCY7a1aNNYmvPXIIygQHdIxfV9YRjtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97rYN3EfqVSi1ihceER+KkgANQFWH1ej4ogLx8qOf6U=;
 b=bw2INk3+KCVkE9htc4uqTrjyRuSpcJvZ+wh5TdEpUfDt5cw3z2x89LsoFdjnoRNsSLkOrR/cDGL7879YJgpogD7zCN9fQbVrNknkqOPmd/B+1zvLLScibe5nMxShbKwcHCtG+Et10kwB3xP1Vm1aDkSfKnSq0hiWNHps60Vtxtt12vdWNaaexQcz3vD33SAN2enve5TTwRM9pQWy0eGMMVpKHRWIrqcbuZ6/pcVkNGJ6mhlC8XoJOmQeEcMAHmxMqK1AsoFdRqdlXH+sSou7H8tJu64p6BKsM654MMNqYtIgLEXDxFKatMjJc7rPEiM+luhyJTdN7wzq5CHk2gpEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97rYN3EfqVSi1ihceER+KkgANQFWH1ej4ogLx8qOf6U=;
 b=WIETuEiz08JUOcnpIqPZ/NNWYQq+I9a5qQHtsq5GJ0YV+JOL/Y99dV+6376ckooWshoK4CuFm6m1rk+a94xzq+W5qdQek1Ew9Yv1E0149KJk0cSl3jSj+3dSrJ3EGXOhrh+fPffDhGuSH4j6U9lRPPdI26DC2Mulib3lNuTsg1U=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYYPR01MB13970.jpnprd01.prod.outlook.com
 (2603:1096:405:19e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 08:51:27 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6%4]) with mapi id 15.20.9520.000; Fri, 9 Jan 2026
 08:51:27 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, John Madieu
	<john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcgNiGYhiwEGfBgEGPuaKI9I9oWrVJXCsAgAAo+GA=
Date: Fri, 9 Jan 2026 08:51:27 +0000
Message-ID:
 <TYRPR01MB15619CB167FAD4042FE45D95A8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260108195223.193531-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY3PR01MB113464DB06BD82F3CC72B5B458682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB113464DB06BD82F3CC72B5B458682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYYPR01MB13970:EE_
x-ms-office365-filtering-correlation-id: 6a13cd0c-938a-482a-2ab2-08de4f5c46b9
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TcqhxVheCdZ5aOKSDmsSL0SJPFn/2Jfw4bNGQSeLcNFoJE1ur5ebm9IAioWw?=
 =?us-ascii?Q?aFdHC/nCcOJyucuw/FfLI9ot1w4yjiRUV3dEm598nqK2+1/n64vPOFQ/saY3?=
 =?us-ascii?Q?o/mvb0yomPWUejJurgbdmV2Oet4e2fGf3LQzRh0uliJPMkdUuHhKGXf+YkLR?=
 =?us-ascii?Q?h33bFQvfwRZnuYLg/nFByx3gCD5WUNBNEBl59LxnBU1ko/oCx0OgBGB5MQ2z?=
 =?us-ascii?Q?wtVPBZnyVmEaz2HA8cVZlm13vfMzqqkXVxuWIlI/M/JhPkHgwEwJvywHJLKC?=
 =?us-ascii?Q?cepr5qP9+rvXthqxjkDNS5oodIGrcyRn72MV4LWWhvdgPPPSJEYiSyVxEiLb?=
 =?us-ascii?Q?+WX7nat/FSzjMjdMmWHImobVwM1nsoIu3r+KvMOnLFa1gYdeiScDSWOgt+d5?=
 =?us-ascii?Q?aEA7JI7WeL0g4nY1FfGRbnFXQ1Td+NWbjR99RwU7jXb8i8N00uGwcbbzbdxJ?=
 =?us-ascii?Q?XhUS4juvSHZv+2Rk4GzDuD0xHTLLQqCEuVJ5yTWGb2NAhQAINBuyJuMXKXwr?=
 =?us-ascii?Q?Znzk+msWXIi7talgRmoSyIdhV5D4RZ1lUJCHTuvWsFpP+LdYK8BB2Na9U6gV?=
 =?us-ascii?Q?S3+x3/1BCdqXK7/XEtHUHrbMLeSm46Jom0PrdQv3d6aASU6Dvv2hxGezgNdp?=
 =?us-ascii?Q?ESkR7TgHmsRo8SVCCIaAgIOglQM0sbhPt/HCwqi9taie31CvweMNeQxNrMjx?=
 =?us-ascii?Q?g8ljHDKeNOy7tvzQ6f/kBFeVOpZADrOmTcF1PVrJJa2lIlDBN1RSJDOcO1vB?=
 =?us-ascii?Q?BeXtzo/jvsPQIY/8znfUPzMw1VfT9zLst7H5o2ls10/WXTshC0qvnjG7Cie9?=
 =?us-ascii?Q?hWTCcKjSV0URtJVV4xaz7WQvA7c6lAkwLEPmU1EwzcFEr3esvuNjBRyT/FvS?=
 =?us-ascii?Q?mC5pXh8voumJpr0BFejYCmnRcVVMlM32ab6heStPqY8Eznjpk/HaDinEvx+D?=
 =?us-ascii?Q?fVoNZP0JnyJ5nG50tDYqrmvHTVpIhDYi2idGe0YUZ2MJpqYfdWPGlZ1r7Bz2?=
 =?us-ascii?Q?2PLCF+F/kl/+BHTWmhPhEWdet9lthy7wUBsKF7auQxtPzq2L2sQwuHmGYWzD?=
 =?us-ascii?Q?VPuRCzBtPhIDXUixh/ZGcP22lms5oKsuMX2qa6MiksEB4CA3YlTx0X6CStcj?=
 =?us-ascii?Q?jLQFy5IasI0WS6EadpTvpFBqnVUuOjAxLqYY2col4vvUYvVENZuLIqRTW2dm?=
 =?us-ascii?Q?NRLOLlyx/yqgfrRBQsJkzQqUbKkwyFpZBWzNKI9ErsYTgftcf/F2Zf1u3GUm?=
 =?us-ascii?Q?xWM46oiqw2FKQkY7nR82O4Mo39Z6MVRyOaSKrthLOOpP3vSl8HIHQvS8DqQi?=
 =?us-ascii?Q?HNxaemK2/IkBdO5MAfdBArAs79ricrq2OvsBhu6pnsv33qc6/wXt+jf9J0qx?=
 =?us-ascii?Q?IBaps1LivhbdNhd+9kPrlSIGhWMhv0cbBcQc9i9E92G5EioGzgHiFZKAcyPV?=
 =?us-ascii?Q?1geBVX6qLV5HSAbJq0sNC4RRR4vPaOhu24ass822h7OnbocDG+4NDAyoOfpA?=
 =?us-ascii?Q?1czdOsS7r15rCrNZB8f+GzgDVhkyotr/09yeSm55h8HxNNo6L6MuFUO2RA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iXGFBmBy2xNlPVWo15e7XHVxgkzn7aDsl4narPG7xZdh6KVw5wp9VoFPU8Pk?=
 =?us-ascii?Q?S1943mOpBc5jWn6dORYASoKxTciTyXTQ5hJ4MD26lRYpWB9YTALzT/DhL40R?=
 =?us-ascii?Q?zgMEyIfoVFLBtIsQM3IAQhm1W0kAsb0z9TJiu4t0DIeA1BiVBR1o7NMz8Q5f?=
 =?us-ascii?Q?tFRdecxhxt0CQWG3fHm1VqTPeGKgu2tr/r9h+dXI25387p6DEmksVfxirTRa?=
 =?us-ascii?Q?oz3I+2ul9zcSXCHTxWRP7o/KMKPX4cXOq5orBqBXT1lstJOW+d45vxuQmoLM?=
 =?us-ascii?Q?onxfx/Ff0qdWRaMnNayfxqAGOfmuWeEsZ9HFHLqPZPEch/zdLoIiLgTitCc9?=
 =?us-ascii?Q?fRpwwOmE3EFBjT3FMhQ2uj7ttEBLjIXCe8AyPR0OH+YaR2ycUMoL4rniZSYV?=
 =?us-ascii?Q?PWflorDyJObnWowEovrMLgi84E865mTpkMGClUgb9Fjxyg3//2e5ab3Fxgk+?=
 =?us-ascii?Q?3OuBElwDob7gkXSm8MbW54+Sb3Bi9GzMxa3N3QvoYMANh4ds9ukg3PQSjv9n?=
 =?us-ascii?Q?TgZrYXnFkPjV7v7M1EEXTY7s+WEarJsp9PP5dGW8VjUZhcUE5yhxcYsoMa2X?=
 =?us-ascii?Q?PtxgukHGkIn9ZnCYZVNeDQagPywCdMTDOyPzn0X+EGJ7h2d7HZHqUmQnZsII?=
 =?us-ascii?Q?nGtGiFlsYHh9QE4ifTVo5/9tfWjJfjK9ttM8vSWK07Y4FOTkJLqvgxhveRJm?=
 =?us-ascii?Q?Wlu4AGjNIE4GvqUNX5kUkga+LXqxoAaAGW4D1bOU+MivQh5smk/deRwtPvq5?=
 =?us-ascii?Q?Me3Gy4U6B7X/ThTKgut52bkd2YeAILzGCvXR5a+vZd4YMcrwraig4I/yn8Pv?=
 =?us-ascii?Q?u5Cl4+r2y+Y2d9KVfr5fHfHRdjC2mVyJHO7WJSrjVMnL04LnB3oQciWgEX40?=
 =?us-ascii?Q?veHHmFZFGjTQ6VLBOfJGZFhle7ZwVyHcGaC5zLovQgpkdvnz97cd/Y2b1y3X?=
 =?us-ascii?Q?xAOy6pChJ2vkcFg7qc9d47Bnns14T/G8d0lGUVAnkWUn+tf4o9vmaPM6bVAP?=
 =?us-ascii?Q?/eLrYnmPLtWSOHmM3+Xp861kQXDOJ3Cl25D5RetXr1WPi+A9fdONfQ5OznZK?=
 =?us-ascii?Q?EsKY/cZApT2A2kmoi+L/JB5zpuFZHE0G9jDvGBDLs6B8pnwIBX2fs2Ldynyg?=
 =?us-ascii?Q?9K8DuaLukSgfRfJEVqFKginv9D9U2biJmbZcJROJwl8oUmqfM3xZDlsi4OJ6?=
 =?us-ascii?Q?RMVtdQH6SMjUmmTrT2gBT9EG3zLkrAIQHGOBb5TkyCxSgWsfBf2wV5rKwYG9?=
 =?us-ascii?Q?qM/aP+ootOCa3k4UDpgSeKNzoz/KLFOT7yai3ELbYY7wmcgilh/iU8FLFtaf?=
 =?us-ascii?Q?C6Lek0dAscWZ8/q5sVQT+PwaSO7oCOn16KFhhpaMBcOlvp0BN4G7POxTRKFD?=
 =?us-ascii?Q?ogAbnGvWgJFJ5Lg+JLYsVJDQYT8fWwwCFrHM+FI/2x0C9B2yfg1N+FcLg/3c?=
 =?us-ascii?Q?He/JSUBLyr4J89P5wmswMJ7M9fMfpr/PLgqwqIOmOxwtLGFav9/iSJTeeQ2f?=
 =?us-ascii?Q?03mI6tjyPd4qn9kqgZIsv2MSVcCfi+e+HOHTcJP4peGkYTtryCPD/2xKP+T4?=
 =?us-ascii?Q?fmskBg77slZS5I/Brt3og2+R6X60Zgo+ZgS41CdZMBNmd4a0s7McI7hvWawY?=
 =?us-ascii?Q?z2bQWop6BK4MgbNRjc/MT1JjBhwGJ7baJakc4Yy1MHArsA3qPavdZTRGYQBY?=
 =?us-ascii?Q?aCMEJ77GHbM0QOI6rz79OsqaAHzqJLsShzBAZTWpalJoKKCg+Agd14DRSh9p?=
 =?us-ascii?Q?uJgDx1Fx0xVhkbHviqokvDhwhRgDA8h4Lo8vhW7/3n9jB0pgIBcp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a13cd0c-938a-482a-2ab2-08de4f5c46b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 08:51:27.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miosJkHMT/rUKedKPCiPlVYrOw8JHaifviH6tjaDxjNlr+4jsBYJeL4t9uf5ROItLLFovVpLiiYQ2zA2fXpOmjrjHrRKzUtj05eX5KMMnXtfZmsg6AcII3ycpi/NUOm3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13970

> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, January 9, 2026 8:12 AM
>=20
> Hi Geert/Cosmin/John,
>=20
> > -----Original Message-----
> > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Sent: 08 January 2026 19:52
> > Subject: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H=
 and RZ/N2H
> >
> > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the t=
emperature calibration via
> SMC
> > SIP and do not have a reset for the TSU peripheral, and use different m=
inimum and maximum
> temperature
> > values compared to the already supported RZ/G3E.
> >
> > Although the calibration data is stored in an OTP memory, the OTP itsel=
f is not memory-mapped,
> access
> > to it is done through an OTP controller.
> >
> > The OTP controller is only accessible from the secure world, but the te=
mperature calibration data
> > stored in the OTP is exposed via SMC.
> >
> > Add support for retrieving the calibration data using arm_smcc_smc().
> >
> > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> >
> > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > ---
> >
> > V5:
> >  * add arm-smccc.h include
> >
> > V4:
> >  * pick up John's Reviewed-by and Tested-by
> >  * replace new macro TSU_TEMP_MASK usage with existing macro
> >    TSU_CODE_MAX
> >
> > V3:
> >  * no changes
> >
> > V2:
> >  * no changes
> >
> >  drivers/thermal/renesas/rzg3e_thermal.c | 27 +++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/=
renesas/rzg3e_thermal.c
> > index 97c4053303e0..dde021e283b7 100644
> > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright (C) 2025 Renesas Electronics Corporation
> >   */
> > +#include <linux/arm-smccc.h>
> >  #include <linux/clk.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/delay.h>
> > @@ -70,6 +71,10 @@
> >  #define TSU_POLL_DELAY_US	10	/* Polling interval */
> >  #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
> >
> > +#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
>=20
> Maybe add a comment mentioning firmware should
> support this index and the otp value is stored in
> arm_smccc_res.a0
>=20

The fact that the calibration value is stored in .a0 is clear from
the retrieval code, let's not add comments where the code is
straightforward.

Regarding the firmware support, it's obvious that the firmware needs
to support this and that the values don't just magically appear, no?

Let's see what Geert thinks.

> > +#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
> > +#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
> > +
> >  struct rzg3e_thermal_priv;
> >
> >  struct rzg3e_thermal_info {
> > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rz=
g3e_thermal_priv *priv)
> >  	return 0;
> >  }
> >
> > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
> > +{
> > +	struct arm_smccc_res local_res;
> > +
> > +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > +		      0, 0, 0, 0, 0, 0, &local_res);
> > +	priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;
>=20
> Do you think it is worth to ask firmware team to return error values in a=
0
> and actual OTP value in a1.
>=20
> So that driver can check the error code and propagate to the caller.
>=20

If we do that, we will have one more variant to handle here, as we cannot
make sure that the TF-A running on the board is always the latest.

Right now things are simple as it's either supported or not supported.

If a0 is some error value, how would you distinguish between an error in
the new variant and a proper value in the old variant? Both cases would
only populate a0.

Also, I'm not sure how much use we can get out of a TF-A error value.

The error that TF-A already returns in SMC_UNK =3D -1, or 0xFFFFFFFF in u32=
,
it is pretty standard for SMC calls and the probe() function already checks
against it.

> Cheers,
> Biju
>=20
>=20
> > +
> > +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
> > +		      0, 0, 0, 0, 0, 0, &local_res);
> > +	priv->trmval1 =3D local_res.a0 & TSU_CODE_MAX;
> > +
> > +	return 0;
> > +}
> > +
> >  static int rzg3e_thermal_probe(struct platform_device *pdev)  {
> >  	struct device *dev =3D &pdev->dev;
> > @@ -524,8 +544,15 @@ static const struct rzg3e_thermal_info rzg3e_therm=
al_info =3D {
> >  	.temp_e_mc =3D 126000,
> >  };
> >
> > +static const struct rzg3e_thermal_info rzt2h_thermal_info =3D {
> > +	.get_trim =3D rzg3e_thermal_get_smc_trim,
> > +	.temp_d_mc =3D -40000,
> > +	.temp_e_mc =3D 125000,
> > +};
> > +
> >  static const struct of_device_id rzg3e_thermal_dt_ids[] =3D {
> >  	{ .compatible =3D "renesas,r9a09g047-tsu", .data =3D &rzg3e_thermal_i=
nfo },
> > +	{ .compatible =3D "renesas,r9a09g077-tsu", .data =3D &rzt2h_thermal_i=
nfo
> > +},
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
> > --
> > 2.52.0


