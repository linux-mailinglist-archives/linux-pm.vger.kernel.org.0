Return-Path: <linux-pm+bounces-40391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF7CFF6F4
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 19:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B4332077F5
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D2364047;
	Wed,  7 Jan 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PQlHK/uY"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011015.outbound.protection.outlook.com [52.101.125.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA5332912;
	Wed,  7 Jan 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805951; cv=fail; b=Us04lJv70w1QrrDUhGXP+5A9g2cA89Ox/E1KITljwWCfPEpuBo6gWFTSOYfK+mkjxv4sGMGhtr+vQRUI7XufLWB4mizIkBMxOri57tQoeyLUVpFf5Gi5dhRaD46V2aXokCfN3SeHf9FWoUzfBiedB1q2vj4wL9cM5M7oupY2dJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805951; c=relaxed/simple;
	bh=+b0eX9rvhtWA4KatAmalukGx9Yv5ewxXCj3EWcxNyBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARAw0XxlkBl6J2PUtOrlIp8vpikD1YUpxY3bw1WMJWCtxhKv5MQbJzpcPIg21PCikANj2wxNf5F2ltKHQ1GBdBcWwVcy95XjVtAx3AvB0ljQDY5A2kOqsXM2ARQwVSdCaADfJHeYj3szFMPFTkZy24NmB5Gp3Lq12nQU7wg4gtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=PQlHK/uY; arc=fail smtp.client-ip=52.101.125.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPgb5LBT0Wb2Qwfd8My3okXd/cxMnGA0R9qMcCF+/st49DUV8VaAbpJN0N/hHfkAegx9jl7b7RSw7Qe7tR0ctLmE1PpC/WGDR3YIIJs0qcHEfs2HZhZJXpLxkKs8xH7QcFwcownXJh3Mpt34o9Rotzz3m12s8d6yNJQRwl7/4GhvRwxykezeJ0XHH4Ht1lf/ZpaBpiMGJLrYHEd3Oue9H9GdgVClsTKCrwmrWUTVPEbcXj4WwYFgG0HhicZGeZJ1nMNARM0jWzeLK07qYRgiHDO1YrTO7iRthdZKSKcGhSe9gwi1Vee7t1g0zWu5L11le+Znq8UcWx/ndIWDGs+fZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VoF5j3BL9iUS4r1I5VHsXS2DmmQDsPCvte0wLkOh7Q=;
 b=Cd6ZYsxIraNs/ViEaNKZLxIIFS6yaq/kfiaVNP8jKwihZAZz7g1AUMjqcC0Gdegy3HFDJnERG56Fh9lkiPQZcZT+8AdeRA9+EiZVhddYZzw2edRGQkqQz4Qyi64ylPyYTvUAsuQVlIfCZav3DiTUfp72zu2Gsddy5udmqMOsc5FicqCWIbdGno6eaCM9FvwgQq5it6imdHYOqyvmlJYGVIR1g8icIxEmOHqzn/mGJA4wPLiefDIpNbbNPmpP9GTSfj5aq64BXe0KRB5AziohV2oBl730OwUNpvDpp2UCbi4XIodNjtlKN1pWRiKNMMjbwEQ8XoS8fbMezLXq3AhKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VoF5j3BL9iUS4r1I5VHsXS2DmmQDsPCvte0wLkOh7Q=;
 b=PQlHK/uY7NFrZkEvAPvz+dszAzJ25WhDGS/xtwt8ZFdr9wANoQOuSqcuhqbCKt+UkWgYJ/svybxpkU5fsEwFJFRrbFBMCNziXP512ycWJFNZjQVW3Qi07D+IV/+ui75p/hiP7Gj3DKsU3mot/AICMA4smNCtccfOSGVtCevfYes=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYCPR01MB9892.jpnprd01.prod.outlook.com (2603:1096:400:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Wed, 7 Jan
 2026 17:12:24 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:12:24 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 5/9] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v3 5/9] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcXtVPSSWMxGwP7EWSCyHZj4V5trVHM3bw
Date: Wed, 7 Jan 2026 17:12:24 +0000
Message-ID:
 <TY6PR01MB17377A111B9CF808AB27C0259FF84A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251126130356.2768625-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-6-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYCPR01MB9892:EE_
x-ms-office365-filtering-correlation-id: a5e3482c-e3dd-490b-d017-08de4e0fed0a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+37j2b3UE/CeLwY2EEX9fB2TzwQQgk5/YGLPV4BIMz479xJi74hlAQAcQDCT?=
 =?us-ascii?Q?Ar1Sq/q8NkY911qYMJdOsWbpQcPoeC/Jh+ZNp9iWS26q8gn1A6iiQO9jWqOb?=
 =?us-ascii?Q?9pdJp/AVmoRUXf/qXD+pNpMP5ScBk2BjnrsAKCh9o1J3uE8ZsbqKFDwmiZ5z?=
 =?us-ascii?Q?enHOamWvCFzzdapVFOTNrV0rbS6m/8M/jg1S9XGHcz2DnVgLfVGLUYrcb3la?=
 =?us-ascii?Q?RVoml9iStXwblviV1cw+3MTrbSU/jE2iBDqjLDZQdsiC3vCOGi4jHTC74I9Q?=
 =?us-ascii?Q?UXDQ9TloXgGwKAYAm4GQhPP9RtQdQT72g61qSOvcLEEgITADRdFZsGuivBgY?=
 =?us-ascii?Q?OR9fYOMUjnZrJhsIbfkiXje97UraBW+osHub7KVcjTdqsbP9za6OzRPPdE1P?=
 =?us-ascii?Q?V9G6m/KVzYVXn+/WdlZ/n+/wrDpzeRzwGY8O53+XW3C7xULbBENEbAcf0oxL?=
 =?us-ascii?Q?BsmF6it9s3usZkRd624nd7+3Zfjbgg/dwv85oUtceiyajcVhprqEnq0NhNMN?=
 =?us-ascii?Q?7iXa/ZGAnsEM/aXI+UOTNWcWBmANQdAVbkIO676rSJB8LsLahbhg1cbfAgaS?=
 =?us-ascii?Q?xAxHVDo13mRtibWs/5ImEDRPgzvHwB1aYUSeaKTTa/he54aKQpBnPbigs3Ij?=
 =?us-ascii?Q?0Y1DcxvrbFQ0ff5m6cKJ59uDWIS3zcaVHm31QlRLdh4vrej8G2K3LD4vx+KB?=
 =?us-ascii?Q?BA1ncKUu2akSAnphwFg6GHlMIGhtVvKQfRRKOz2l7mKJpOW3aRwDSxAlvnfw?=
 =?us-ascii?Q?V/hzmOu0XlpkrBodJU9IZIrXc6Vw1SmueibWKae0o8CTtPojHK9ztr7dKP5C?=
 =?us-ascii?Q?tjO+gWcea5Sx1qbsa6VeBeCQbJ83xHZkzvPzXQH6I+CMiCszsUh9wftBrNZ9?=
 =?us-ascii?Q?hTyRfKektlCBIeogvMehETPuW0a57NpXCrQ8EYYPzfSseOhWcUpyUwcQqLXY?=
 =?us-ascii?Q?VzCSgWVfvWnnoj8RWp1AjBKhurAasGNtncSVK/4nAc53jcT4eAFp0QURR8qt?=
 =?us-ascii?Q?ULAlHbQbArgrntuCI6/DVe8Tf4jTn8HZUpEpdmdcyiQ1ku47Ib/MzClnI/SQ?=
 =?us-ascii?Q?OYCsM/FGD1rKcCw+jrgsxJ10bINfy7nqlcDCrRVzQXQeZvqqusmDBKrNfhrc?=
 =?us-ascii?Q?XJaL5cFTiueSDzTM82SgwM4I2oJ835EXztzv3EK9PTO69GZUzutQ00Zqssq+?=
 =?us-ascii?Q?3H9m5T02MN/y/M+E15ZSMAddRfVyg2lhwMlxJZs9OtmfbdpBtr+1qoxHbzUy?=
 =?us-ascii?Q?qvxuqT3EKJVSnSv6EMJ5URhhXEuHQ+KQ3BoVIHnZYLCJmcZA/0s2O7J/hLmw?=
 =?us-ascii?Q?R4g8Hxd1OASaxhuxpUNKgKvDvsdkhROwZCzQykp6zk29QOs22pODlSL4klsm?=
 =?us-ascii?Q?CdhtQivd5ORMv1lu2xwWD631RXzSb5Nl/pacV1N5FQeEwwPZtu/5OyRcOMS9?=
 =?us-ascii?Q?Ava6svVQ3SnHcas3SCZfumgUl+CyZvmSjo2jLjhR7FZM1JUvjF030n3HkZlD?=
 =?us-ascii?Q?tLXHDxWDBt2oRr6NG/x21Mgf8QXMwtq+FTpIYbPzQ5uXakmFpg3QSt/UPA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ahEB3IP4XJNItJj6NTHgW/ksVPvZQ2fPoLUXHU6bYbHwhJUO0hlIY0w71vpp?=
 =?us-ascii?Q?RaU7HufV6et/R0/zybRpm6YpNraMVn9nX6k4PoOulTixL1irXjvxVciO2v5n?=
 =?us-ascii?Q?XTRiARMDOp+qyXli+kXAURdXPe0niMf8LaGby05834G+D7bEjqT2MlpRmpaG?=
 =?us-ascii?Q?+jmi9GMWeJT2g1laBwMu4lOOQAuciqgSKHoXJZ2nEmW3VNsl5Z9QfGtB5ZdH?=
 =?us-ascii?Q?mZXW126auqrbyG5fjpXv5FyeTJV+Rt3V5sJHiQKpONTnpmmZiQV1YYzFGroI?=
 =?us-ascii?Q?6sbUO0gsLcJz1h5Q/GG+Srj2xUI8t0yEjEgLmy+bMo+Wk/gkL+4ORZm5yEJN?=
 =?us-ascii?Q?pOntC6kTYoI6Fq2JD+x/imp89yFa2AVA46v8966aIhMnTDEAGOsla2u1R1WT?=
 =?us-ascii?Q?33FMYUzLiisa9+57bZu3TgAb2FxE7yxzHPxK0C1VibLUAH0PP0H2r5kN/BCO?=
 =?us-ascii?Q?yMMWRKqbwqte0nVzX2CmSff1Lv1IqlVSVQSSu2BCFm12jewp7TTftwJj7adv?=
 =?us-ascii?Q?ZnqqpD6tpm4fEw4sqMZZKUiXwkNRze/STSoX6ukhryx9r0X95P5pd/86xjcd?=
 =?us-ascii?Q?SELfMHBEa44jW0LIaBM3CzIBn6Q2dPxI3recLh5uRuSucJCSfvtSNi6Q1djO?=
 =?us-ascii?Q?SKZnB+1BDVx+G0BBXKcj5RBZh2RBuy9FBK7HhDUgi7UjAPbtMTalT7Wj8msV?=
 =?us-ascii?Q?k/jDEUKveTfSwCM5BKEL2OBwmGCeHh7F/qJEZipurLLoAL/7FrmB+RrmoeV7?=
 =?us-ascii?Q?/VHbL1cTzF6sbEfyaXaFumjA2yy4HU0TWM+ahcfGQscXclJIcfrHbDp45Wqq?=
 =?us-ascii?Q?j5UBhDlVHjyKPlL5JxUMOAGeLZgs3QoUIt1oU3LxUBmpCmaIuYgNiDT9JQJ+?=
 =?us-ascii?Q?riCNCgOO/VqjPMa6raV46XXcyfVwMsJQyeqcjosdLyDtlsbRRjnMvtq1X241?=
 =?us-ascii?Q?KiMYch1cgfQrB7pLX+vtpCT0NIZ4YatPEY1GWqTyj9T70DwKusYF/ccMCG6Y?=
 =?us-ascii?Q?m/jWJ7oGySvwbi9bVVZry5eW55pVdfv7omdpw0jopZ6vpqbJAajn4tVfzQmD?=
 =?us-ascii?Q?MnDm6p1xF1fWuP7kE9r5EldI3qBfI4776ex9VPap8w3KI09b+XKO4/VuR3p/?=
 =?us-ascii?Q?eyJVTvCStDkiIFNMAEea+HbGD+G6eVJCoTSb1/RpYAnxqANemnVcp4o6qkFl?=
 =?us-ascii?Q?kBDMbsnBeLF0e83tMPwCrNHClrfKch+6oN1+bt9il2TiLW/JGqJHyHuUez7Z?=
 =?us-ascii?Q?aK6vY+y+/4IiU01LIOP66IqGfe4Y0T1Ml0ZB2cknUNhv5Qby0FIxv98IjGKd?=
 =?us-ascii?Q?T5bQWsYt3Wy+pE3xHUOQ87sxgY1RTyDXjeE1Y5g1lkk7JA2mUvx44xB6gW67?=
 =?us-ascii?Q?tM/Il0Z1znjH69IaPCaQr3Pt7cBJsrEG38wjD26DQ+vgA55nBzHVzE/MPVR8?=
 =?us-ascii?Q?OWxrGfmJNVyzAW5zGSd5n5XwIaSx+PYwNX0xqOaqJjZJhBXuRJ+QV9ZXdDFt?=
 =?us-ascii?Q?GccDUMqtL73rvN3aTD+O1uNEEKpRtVEVzro6EJzPrqipglUZVAqJxTG4n+5+?=
 =?us-ascii?Q?5r/RkVofJu1knmiJYkK46xO9s9csihSvr67mLSCJtP17luqRJGLVnElZlpe7?=
 =?us-ascii?Q?H476EHN4i6wWmhe69m0UmUmgHef8ZnsV/SgwLaJXeJaDt4LLdnd7FMAdCx82?=
 =?us-ascii?Q?2bVQm0A5tiIRQKlXVjAFEqI6TO9m8XhWJSJzxZ79lwf7kFe+B6VndxpkbyjR?=
 =?us-ascii?Q?+Q1/e0mDV4hCxxRg6QGqjs6YXmGcO/c=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e3482c-e3dd-490b-d017-08de4e0fed0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:12:24.1297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QSsYCrAXq7CHKTAdYniHX16BCt+KklB0EM23/3o9zsEG72J32LlI6BI2SXbHWiYMj6Is5KGJ/7PT8X/EEBqsc2mEU6y8WP8v8I49wcMWBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9892

Hi Cosmin,

Thanks for your patch.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Wednesday, November 26, 2025 2:04 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; Rafael J . Wysocki
> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Zhang Ru=
i
> <rui.zhang@intel.com>; Lukasz Luba <lukasz.luba@arm.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>;
> magnus.damm <magnus.damm@gmail.com>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Cosmin-Gabriel
> Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Subject: [PATCH v3 5/9] thermal: renesas: rzg3e: add support for RZ/T2H
> and RZ/N2H
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> temperature calibration via SMC SIP and do not have a reset for the TSU
> peripheral, and use different minimum and maximum temperature values
> compared to the already supported RZ/G3E.
>=20
> Although the calibration data is stored in an OTP memory, the OTP itself
> is not memory-mapped, access to it is done through an OTP controller.
>=20
> The OTP controller is only accessible from the secure world, but the
> temperature calibration data stored in the OTP is exposed via SMC.
>=20
> Add support for retrieving the calibration data using arm_smcc_smc().
>=20
> Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> V3:
>  * no changes
>=20
> V2:
>  * no changes
>=20
>  drivers/thermal/renesas/rzg3e_thermal.c | 26 +++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c
> b/drivers/thermal/renesas/rzg3e_thermal.c
> index d2525ad3ffcc..efd09c35b216 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -72,6 +72,10 @@
>=20
>  #define TSU_TEMP_MASK		GENMASK(11, 0)
>=20
> +#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
> +#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
> +#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
> +
>  struct rzg3e_thermal_priv;
>=20
>  struct rzg3e_thermal_info {
> @@ -381,6 +385,21 @@ static int rzg3e_thermal_get_syscon_trim(struct
> rzg3e_thermal_priv *priv)
>  	return 0;
>  }
>=20
> +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
> +{
> +	struct arm_smccc_res local_res;
> +
> +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> +		      0, 0, 0, 0, 0, 0, &local_res);
> +	priv->trmval0 =3D local_res.a0 & TSU_TEMP_MASK;
> +
> +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
> +		      0, 0, 0, 0, 0, 0, &local_res);
> +	priv->trmval1 =3D local_res.a0 & TSU_TEMP_MASK;
> +
> +	return 0;
> +}
> +
>  static int rzg3e_thermal_probe(struct platform_device *pdev)  {
>  	struct device *dev =3D &pdev->dev;
> @@ -539,8 +558,15 @@ static const struct rzg3e_thermal_info
> rzg3e_thermal_info =3D {
>  	.temp_e_mc =3D 126000,
>  };
>=20
> +static const struct rzg3e_thermal_info rzt2h_thermal_info =3D {
> +	.get_trim =3D rzg3e_thermal_get_smc_trim,
> +	.temp_d_mc =3D -40000,
> +	.temp_e_mc =3D 125000,
> +};
> +
>  static const struct of_device_id rzg3e_thermal_dt_ids[] =3D {
>  	{ .compatible =3D "renesas,r9a09g047-tsu", .data =3D &rzg3e_thermal_inf=
o
> },
> +	{ .compatible =3D "renesas,r9a09g077-tsu", .data =3D &rzt2h_thermal_inf=
o
> +},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
> --
> 2.52.0

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>

