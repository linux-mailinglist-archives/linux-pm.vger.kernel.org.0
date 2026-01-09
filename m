Return-Path: <linux-pm+bounces-40532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D147BD086E0
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 11:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6906302F73C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB533BBAF;
	Fri,  9 Jan 2026 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Wt01WdBU"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010060.outbound.protection.outlook.com [52.101.228.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9933B97A;
	Fri,  9 Jan 2026 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952989; cv=fail; b=BG/277OSedWBIS58DR/iEERcpa38cCZc4070/QXGY/hCflZ7q9JyZchAciEc0sdS74o1DcJUc0xewzWzOUYwIRcw17WO1+SFGdA7WVic9+UYRAv2opwLD1g/cJNNcnnr2z/mrmy+x+9yxm6lu+qTchQfWQ1hHuXgzyX6SvZ8bwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952989; c=relaxed/simple;
	bh=gnZLbT45+8c/Y4GOd0BYq7vq0IdplkExHa46Aybh4wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s++uiIj+4Op4zeTiHbgwdsD2kcbXfjAHIbjr43P/3jCOF0e4hZcsQbKm4QiyvJH7UQYdnqjj/H5n0I07gHyCSRAxiltB4Y44CV12nmMte7cqte+a8H+IGv8iGMLq5/3QbzKyy9g/Gpg9D1/3R+/19/y/TJDRZ18K1+IfSgH4zh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Wt01WdBU; arc=fail smtp.client-ip=52.101.228.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2eOXi0W0EJ96ZnPjz7fWQDELqeFuzuTkxJH72C8kdRaY1w2jmdb9p/Pcct1Rk4M4Q0f33rVNhBTWLb4e5eTiOFxrA2D8T/1VbYTrOnazpV3UXYnH0aUqVcNBePC0gUd6LE0RR3qmVjBbuBXObCVG2jYGsRTc2xT/9rtoOHFMf4FlwZ0KwqYS/HeeKXkgxQTJ3c95TucuGKimcKrqMa0FpU22PEeeKkAIldVCd/71kkH4doo+34gGeKxGWApL9oT7hqGD1kCgap1qLRuP57WeRKBQkEId+F5g5WyjXLO1cFUEA/T2wd5k5wFNP2+st6Ae+xXkdmCfwRtSY7/w6KQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOzPa9FvzNOOha0PUGYYTzKc2UJI3m1rB761PeDimgo=;
 b=OtsptzAybIchyQqqOAChzUp04QJ+FYOjacSIHq0jwM5ocZ/JY84p2/J0a4Bwgunb3HEB8y1YgLVAnr1Gg7MQT7YoMVfXszwVjKxKEcBT3n4MOAtynuuRg77nMjVGWBzpd/W68HTgV2U0H0iQ/Yj6x3UAx5lClVrrfv65+bDYgwEvgtBv2bINuM4a1+nGY93ucRvrVY+OUvuCED0C2xykwO9qtgm8mOj+0SLyX25z0DuyaITXEAol2Q/L9mEMI3UW7xv1USHZJCf67ATe5KJYHEad+A6su1pU/Jk9U6MXoBGJZsph94fVZNsDcZEpc01zidwy7bmkoRM77UCNdybFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOzPa9FvzNOOha0PUGYYTzKc2UJI3m1rB761PeDimgo=;
 b=Wt01WdBUY7FbFamaZeNDLeXjyDAiq7WctjNU0RX5gl0T3DSGcR70ZVxqBBQ/TNNbbLmI4xZYs807mLT4A7NUhI5N9MlTBV6AgnEjmXLNsB7KU4/37UDoNzJwb586vlHbtFWvLw5IKc+hraJ/UbNJmnQS87ETv1EeVnXDkhYFe44=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by OSZPR01MB8204.jpnprd01.prod.outlook.com (2603:1096:604:1a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 10:03:01 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%2]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 10:03:01 +0000
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
Thread-Index: AQHcgNjpP7tWju4kVEOD2PeFnHW2A7VJWgkggAAujYCAAABl0IAAEgEAgAAAlKA=
Date: Fri, 9 Jan 2026 10:03:01 +0000
Message-ID:
 <TYCPR01MB11332D8F192023ADF4D8490398682A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260108195223.193531-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY3PR01MB113464DB06BD82F3CC72B5B458682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TYRPR01MB15619CB167FAD4042FE45D95A8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TYYPR01MB15615737AD71FC9DBE4923D778582A@TYYPR01MB15615.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYYPR01MB15615737AD71FC9DBE4923D778582A@TYYPR01MB15615.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|OSZPR01MB8204:EE_
x-ms-office365-filtering-correlation-id: 73cbed54-baf7-4c13-7835-08de4f6645f6
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SzZizeyd1sv4pbBlI6wIkvH/kfADlhR5IXdkRZwa+lL+SrhNWHvnffph6Qui?=
 =?us-ascii?Q?nmbuR+qk9Z6iHYii/6h+K4vEyQ13pUbcDxkJA1I6vnhdWCaXmTzkbOoicmQT?=
 =?us-ascii?Q?P1VwldXCxTHPrKmwhn6iNg/b+k+tcZFV8H4vk987EXf7FK9AFMNPoqypBUkA?=
 =?us-ascii?Q?yuMQVNr32+LjrXzUkP4niB/FkDrAv+Uu1AY3lnBpwLg8SURKLyMmYe6AgQoe?=
 =?us-ascii?Q?wANVFd8szk5uhmOco5L1TPvDSkNbJVyyV3fWbeoQFia4mPeyMtklBptZjRPX?=
 =?us-ascii?Q?/ce27eX3XtW+2/KESwFB+zSMmtoGSRwR5Ryehk+VrayC9uvxSsCv4AU/AWuq?=
 =?us-ascii?Q?cWssEgoZsFIEZWptXXvOwKTSHoofXpWCO4yCUHghIOnXz+bRPVuUSrR/Yd5Z?=
 =?us-ascii?Q?U0zT05pH5OSPyOTYMdzJGjxEzM6I2KCrrn/ctRx1SiAh6vAkZaN1NLIQFt1x?=
 =?us-ascii?Q?PaRDtGCNGxy9m3iuMzbvAzgw0fmlCFvfUf+CMzY68lLvnj+cfY5ePNx09ee3?=
 =?us-ascii?Q?YoPGgweQEuPsHU3Oc9EOw2kQ1jOxa6ndHY6HUxun0tmD8FjEO9RzWOgSVNcb?=
 =?us-ascii?Q?H+TnJF2GMQL4pX1Spisqj4AV5yHqUz2L74vOsAaeJ8Uqf+MDo/YUxR1djFKv?=
 =?us-ascii?Q?3R3yGzOjSVlfePnZpJmGJtRDBoV/KK6RNPMWa1eHNznQIr1rCKTCC8ifMqfB?=
 =?us-ascii?Q?gUt7J1MKnLvw3/fnfQrLlo4ME1fHcLIEDEWrr+xcVaUie00poUHVouH3rL4l?=
 =?us-ascii?Q?rWNa3a4EP7d1dC9asBx/3m8ZMUXu1Bx0AmuBzBdNgjYIuvxdING0AerVCEpU?=
 =?us-ascii?Q?8qlyj5QEDuZW3nDFb9QbDVnMXkmSHUwsKBu/0cZZAdhGNOjs3ZvfAJZWy/Vp?=
 =?us-ascii?Q?i5UbZkbCWrRdE1vS/HyAH2ylSeW4iMsvr2vY9Fs1kFwWY/aDVwLUdVqcuwY2?=
 =?us-ascii?Q?8yoVd8K5pMRDrMUno9knir45KvXchLBI4cBqncN+VMiQZl9eFbFNgu8B8uAr?=
 =?us-ascii?Q?v9FRsD9VtRgXLytbq+FuGShWoCpQH4IIz8ye90wKAAKD/iO+M4J5X4HsLQzK?=
 =?us-ascii?Q?uynzxwyST9H+25hi6MPlLTKrKMmTuRj0N85hRIMbJaJ174p57e0Av30YMGjF?=
 =?us-ascii?Q?wORN2Cxn6+LZLH4xt8k8QJHX6Z7u1tZ2MzKKnCdtBobc+UgukpJ0PH07v64z?=
 =?us-ascii?Q?ipVT0olfFkGloFENOAYEc7QAIwwCiK0BGMdpLERxhcw1LQ79c/myF9O4hbxs?=
 =?us-ascii?Q?9V+88GI7qSCXe0njGxLi/KdgQ7pmBgpEk+aTe9RIufzKBVCfjwaEG10XGBQs?=
 =?us-ascii?Q?n8x/WNWOh7A/iRSFq0xipo5AQrHg6ZlH5M3euLrAkCf5Y20Ab0wQVSXHX0Lu?=
 =?us-ascii?Q?U56oL2h+mADjGtVlSt1dZMeuKWuud8KzPf/zT2l9UBWOeOBAJL1QnSf3UAKQ?=
 =?us-ascii?Q?rmNkr2tpDH2JuuAeCIAs0sU+B+OuTPkpHnlyCgfpCuOGpLK672Ap4TufTy9K?=
 =?us-ascii?Q?n7YAC4s9wO1opwTdeLNFF9KLUFD/nS4ejaMyHAGzI2N9c12bTjfaTKyg/g?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zA7T0KgS03qmtCcx69FlLQyJVu2xxUZO/tuHe0dlvmfZx86CmWuruSldBOYI?=
 =?us-ascii?Q?rFJjpHJblR0cCSmGpTg87oNqm/FkrE/pbKlZH5qM4bYQbF03Tv8ySmQd6zGs?=
 =?us-ascii?Q?bIK1zpHrg0F14W2W8U755z+j+zAwU23TOkPJnx96il9tQ1lcUkwKIdq9p8Qr?=
 =?us-ascii?Q?Ek0g042jy8TZd9LMSZyx+enXbb5q2B0h9+svn1w8MX26UxGT2hge3hn0xhr3?=
 =?us-ascii?Q?u0OQxOTWC7iyQTrZaa4PiCexGC6UOcthDOzBuEriDFUQ//Oi3Hc+k/IuyH2m?=
 =?us-ascii?Q?5G3tr4cjzQfSYoP7eCStcEY1dgiMVFmP0A5pfKlw+PlECW+i6dyWqylNuqn7?=
 =?us-ascii?Q?KejINzgaR9ODehaIdz3Ew31xicu/y0IjADuSbEYwSq0UBRfSL+wW+RoF0v3H?=
 =?us-ascii?Q?FDwObpvX9QjXhAgn2mUj5fjzbziMt+gHwI6cWISa65dN8VNw0eculeSGxbkD?=
 =?us-ascii?Q?b2vWqyS9c5GBgTKMo7MkeHBcb+cV074mGlEJ9Ka1GaBdbAoej8hwCzkQNZvI?=
 =?us-ascii?Q?vr2j7NKD2Qm2KUSuqBr4PkSSq6k3urMeKg3r3UkLKi0hMeLJCFoV3cYTUJTb?=
 =?us-ascii?Q?zmz5Fen3k7zmrGXh8K08wCFYNNDiGgvqLmaYPjAah3ota8ECIy/GrJ0G8k4M?=
 =?us-ascii?Q?kIQ7XGQ5uGO1yekeyGefpjFGKIuzZ2pm4uUtEOo5BuWeKMocRCA2eQbV5nm8?=
 =?us-ascii?Q?f8i1exICmMfFlsDG0ClwniKwvXKkjx1xqgkKN5wwJogoIQtoCYJEvDUigPH+?=
 =?us-ascii?Q?1c09htZfdgBS5ihmT0Xv/TXkBFX0rwN+i6xRQuAosFr9Eh7B0uPLJObEyw7N?=
 =?us-ascii?Q?6vM96Djbu7NNsbJ14u7LW3lmKdYvoruHW8aenBQmlG9nr2bu47XhQSuROV04?=
 =?us-ascii?Q?NSvUmFOy0eYVZMvVB82EgZXwr2iQULK9Cs6paq0X+l/rXno/f6pG5qPG7t1z?=
 =?us-ascii?Q?AAT5zfJ5ISMrgLHeQkY8leg/DhK0YHe58tRUqSe2hZ29n91DTNqWsyh9mYYJ?=
 =?us-ascii?Q?NKJHM5dH/KPZ3x8d9nODdwKpilHkj0w9VGms7bFZ7XRcWKsKFwYK6GfXWrQ5?=
 =?us-ascii?Q?8sEcQVonrzbpTCVEkjGDVZ4chccyslrXMjBM2hvIL5aco32+cfn0nvcno04t?=
 =?us-ascii?Q?YTBqXiMhKRJAn5Vn0h5FG++sKSXDpFZzckjpfyEr6hdssptkkQ72R3kyUoQL?=
 =?us-ascii?Q?CadLiUb54pNVf01vPPN8tubT4V+zZc4lK7kaaMo3m6g811Ts40Kv4csQGs/h?=
 =?us-ascii?Q?jZZbkaJr9VX26mC5m6pvIPAi5xq00uQjGaP92HVVFJ8Dh1Ui/YEWmJWcK/Um?=
 =?us-ascii?Q?RGF4YpaO0VZhcZLrI++WLJhmgc+YcNT6wPgPjSHRHU/t7mQasDXbrWyI5CLA?=
 =?us-ascii?Q?6mykUuwaLoe+rlfHyOLYYnGeFjhrH3iUwS6NB/rxthBXLT+zx43/yDVkcPqR?=
 =?us-ascii?Q?aCLHNbvvkrGCJ2pmkZNuiZtK56D4y5mSviMrCZJqDLgshrdMzUe1nh364iup?=
 =?us-ascii?Q?lyEaNNypZo+cmbl40aBPCmTUfPnqQWTKY7Ejt+fDsn3pIyT3j/dZQ0zcGiGd?=
 =?us-ascii?Q?24jo0t1Djz6ASPS2xVHK3qbLWLXjYWRuwXIYImLFQrVwIvdsGp3q29lgXAx2?=
 =?us-ascii?Q?qB9d2/GYiGhCfip0dSKUhZU2MBAzR0PRMR48TVXBMMfDLAvFnFS9v1Ugk0I+?=
 =?us-ascii?Q?XYZZ9oOWxx9eu8H3/yIDKl+7NVLqeBtbSqwO8/8zd0BT4OI1zB7KUbm4sysu?=
 =?us-ascii?Q?SaKeBwo3/A=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cbed54-baf7-4c13-7835-08de4f6645f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 10:03:01.1923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXQS6N+1VKLB16ErDXQkiFxh/djVDPNhZEmcfTuhPEs1NytqVvFR7a5hu+LGCu0cTCtYFbJwzYq2eH9QfqOE1ZnY1PgJfnWRna30CwuSlp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8204

Hi Cosmin,

> -----Original Message-----
> From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 09 January 2026 09:57
> Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T=
2H and RZ/N2H
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Friday, January 9, 2026 11:06 AM
> >
> >
> > Hi Cosmin,
> >
> > > -----Original Message-----
> > > From: Cosmin-Gabriel Tanislav
> > > <cosmin-gabriel.tanislav.xa@renesas.com>
> > > Sent: 09 January 2026 08:51
> > > Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for
> > > RZ/T2H and RZ/N2H
> > >
> > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Sent: Friday, January 9, 2026 8:12 AM
> > > >
> > > > Hi Geert/Cosmin/John,
> > > >
> > > > > -----Original Message-----
> > > > > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > > Sent: 08 January 2026 19:52
> > > > > Subject: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for
> > > > > RZ/T2H and RZ/N2H
> > > > >
> > > > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs
> > > > > expose the temperature calibration via
> > > > SMC
> > > > > SIP and do not have a reset for the TSU peripheral, and use
> > > > > different minimum and maximum
> > > > temperature
> > > > > values compared to the already supported RZ/G3E.
> > > > >
> > > > > Although the calibration data is stored in an OTP memory, the
> > > > > OTP itself is not memory-mapped,
> > > > access
> > > > > to it is done through an OTP controller.
> > > > >
> > > > > The OTP controller is only accessible from the secure world, but
> > > > > the temperature calibration data stored in the OTP is exposed via=
 SMC.
> > > > >
> > > > > Add support for retrieving the calibration data using arm_smcc_sm=
c().
> > > > >
> > > > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > > > >
> > > > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > Signed-off-by: Cosmin Tanislav
> > > > > <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > > ---
> > > > >
> > > > > V5:
> > > > >  * add arm-smccc.h include
> > > > >
> > > > > V4:
> > > > >  * pick up John's Reviewed-by and Tested-by
> > > > >  * replace new macro TSU_TEMP_MASK usage with existing macro
> > > > >    TSU_CODE_MAX
> > > > >
> > > > > V3:
> > > > >  * no changes
> > > > >
> > > > > V2:
> > > > >  * no changes
> > > > >
> > > > >  drivers/thermal/renesas/rzg3e_thermal.c | 27
> > > > > +++++++++++++++++++++++++
> > > > >  1 file changed, 27 insertions(+)
> > > > >
> > > > > diff --git a/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > b/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > index 97c4053303e0..dde021e283b7 100644
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
> > > > >  #define TSU_POLL_DELAY_US	10	/* Polling interval */
> > > > >  #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz *=
/
> > > > >
> > > > > +#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
> > > >
> > > > Maybe add a comment mentioning firmware should support this index
> > > > and the otp value is stored in
> > > > arm_smccc_res.a0
> > > >
> > >
> > > The fact that the calibration value is stored in .a0 is clear from
> > > the retrieval code, let's not add comments where the code is straight=
forward.
> >
> > If you have just a0, then driver expect a0 from firmware is either
> > error and OTP value.
> >
> > If you have a0 and a1
> >
> > Success case a0=3D0
> > Error case a0=3DSMC_UNK
> >
> > a1 will have the value from OTP.
> >
> >
> > >
> > > Regarding the firmware support, it's obvious that the firmware needs
> > > to support this and that the values don't just magically appear, no?
> >
> > How do you share this info to customers that they have their own firmwa=
re?
> >
> > Eg: Customer firmware is using different service ID and driver uses dif=
ferent one.
> >
>=20
> If you think it will help customers, we can add a comment like below.
>=20
> /*
>  * SMC function ID for reading TSU calibration values from OTP needs to
>  * be supported by the TF-A firmware. Calibration value must be returned
>  * in the a0 register.
>  */


OK.

> #define RZ_SIP_SVC_GET_SYSTSU	0x82000022
> #define OTP_TSU_REG_ADR_TEMPHI	0x01DC
> #define OTP_TSU_REG_ADR_TEMPLO	0x01DD
>=20
> > >
> > > Let's see what Geert thinks.
> > >
> > > > > +#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
> > > > > +#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
> > > > > +
> > > > >  struct rzg3e_thermal_priv;
> > > > >
> > > > >  struct rzg3e_thermal_info {
> > > > > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(str=
uct rzg3e_thermal_priv *priv)
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv
> > > > > +*priv) {
> > > > > +	struct arm_smccc_res local_res;
> > > > > +
> > > > > +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > > > +		      0, 0, 0, 0, 0, 0, &local_res);
> > > > > +	priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;
> > > >
> > > > Do you think it is worth to ask firmware team to return error
> > > > values in a0 and actual OTP value in a1.
> > > >
> > > > So that driver can check the error code and propagate to the caller=
.
> > > >
> > >
> > > If we do that, we will have one more variant to handle here, as we
> > > cannot make sure that the TF-A running on the board is always the lat=
est.
> >
> > Mainline will use new variant, that can have both a0 and a1, if we take=
 that route.
> >
>=20
> Mainline code will be backported to CIP, and customers might try to use o=
ld firmware with CIP. Not
> adding another variant is the better way in my opinion.
>=20
> We can wait for Geert's opinion.

OK.

>=20
> > >
> > > Right now things are simple as it's either supported or not supported=
.
> > >
> > > If a0 is some error value, how would you distinguish between an
> > > error in the new variant and a
> > proper
> > > value in the old variant? Both cases would only populate a0.
> > >
> > > Also, I'm not sure how much use we can get out of a TF-A error value.
> > >
> > > The error that TF-A already returns in SMC_UNK =3D -1, or 0xFFFFFFFF
> > > in u32, it is pretty standard for SMC calls and the probe() function =
already checks against it.
> >
> > The OTP value can be 0xFFFFFFFF, if it is not programmed, if that is
> > case How do you distinguish error with respect actual otp value.
> >
>=20
> From the kernel's standpoint both error case and an unprogrammed value st=
ored in OTP have the same
> effect: missing calibration data, cannot use the TSU.

If a0 =3D -1
Error case could be missing SVC handler in TF_A, Wrong ID.

If a0=3D0 , a1 =3D -1
Unprogrammed value: missing calibration data, cannot use the TSU.

Cheers,
Biju

