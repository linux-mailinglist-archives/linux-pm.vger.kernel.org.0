Return-Path: <linux-pm+bounces-24619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5AA75EBB
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 08:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FFE162091
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 06:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E915DBBA;
	Mon, 31 Mar 2025 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="frHwuyD3"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010032.outbound.protection.outlook.com [52.101.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AC20E6;
	Mon, 31 Mar 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743401316; cv=fail; b=hTKh3NzUiHqRwOYwyjtUVUs3jZENnfvVqUMNsNG9eX53DBLpegZmqNx3sheDLunXUPgitRlzkg0uQE0JjeY1gSix+iI+RbCKmixveZS1+NN8GAH7ghooA60yfrQSvChbeJbA7NlUzZe3AYAad67dbFdUaph7fuutF+7VjFxY5iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743401316; c=relaxed/simple;
	bh=FtdY8YmY/dZ/f0AAueS5C1Cdf0nqwDRvTS3zq6f8rMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDo5H8/EUoM+TqJHmQLCjikyh80IStWqVXwKg9+TEyIFT13ebow7EuEAf56XM26mWIo1hx3Jn0bcIk2KiRxn0UY5QP+jRJ2FRActKzoKKlTPa74JPDyxfpVa8zcykXvVNaEY3ZvBjPwrltTAg+sdfToDiEAjh/TVtJIbVcTsqvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=frHwuyD3; arc=fail smtp.client-ip=52.101.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7Nnq845iqumP3arv3R1wrLvMY6Oi7ZprX1YThtfUOsWLy73OJTMYyG0fsHOfBx0vSEgiFBkZZcw7EmqbPEbsEfZrii4dd786BXE2RWCwhvMUcMYytggDJThGs9pcT5ClImm5LY1z5/c2yjLn/Ks71pvEYBTahh0WHHSnijg79mT2C/Z8xExff5FEkwLSkVioxPreGfemIyEcM0xhTkRDd7yOHMzd+Du2Ks6Q2Z6hQlon6CkreVynvMIvuoIRcYSHvbHNO3U5l+DDjYjcaBk77mHd8jmIpVvKOn/mM9+Wmy7l5xaLDV9lnbjgHruRqY+POHGprkoRb2fiw6LbEg6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5l5oPPsMQb8AJPAGJFli9g3SG1FpR27BHWwYAswq1M=;
 b=iHZ18R6POlWuJHRomsBBX5BZkpEbiMW0HEaWT5gLMEzMTwnMx/itueo9X88oLPG7RbXmDt/xJAgqwalrB31DaU2uLQRRXedqSagZfRJNR21PscvfZa1gMqz9ilwwHc43t9jk2NjORV4MAkOhWIFHopkY6chvu9AjdZWjeJRYMR6mDwmzwFeJezvzSVBRcoGh82ilGyC5AIYIlV002rL+yDOyGXu6se3zu5zPJHsr7EpIi93M9NiLmKkDcxLL7ZZWY8QtremxwUd+ILdRfS37LLFQCMM2wVCBWwuwh+DkOsWs7DpMwCkJRZQg/YTUjpzArKxKibG4eBPe/IDrlKVwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5l5oPPsMQb8AJPAGJFli9g3SG1FpR27BHWwYAswq1M=;
 b=frHwuyD359r1USWqPplDgdV9QxthnxGROXZ7CXW61Mtm0zyPdcQoTpPCZt9mDkdNUBCER2wjP7bOQRIAef6DjJzcbKCmGJDaWMsKxXxjeUsBt5n654ZgSrMZT/pPrAfsSqvx7djEeSzPDDvY4yeUobT+xnsWXZZoHSlqI7Yx9j0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8780.jpnprd01.prod.outlook.com (2603:1096:604:152::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.35; Mon, 31 Mar
 2025 06:08:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8583.033; Mon, 31 Mar 2025
 06:08:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, John Madieu <john.madieu.xa@bp.renesas.com>
Subject: RE: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Topic: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Index: AQHbocDO+wUDExZfT0SzDbBz4INUPLOMwV7A
Date: Mon, 31 Mar 2025 06:08:29 +0000
Message-ID:
 <TY3PR01MB11346D2794D3D5C0FC870550286AD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-2-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250330214945.185725-2-john.madieu.xa@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8780:EE_
x-ms-office365-filtering-correlation-id: 9f6872b4-b83a-4f1e-1380-08dd701a7503
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/8YzYnRJH/f5eYcp0F3yt05hMiH5K9bAynt1jf7r0Valxp20TIYWYlwjkUW+?=
 =?us-ascii?Q?RwcO0yXtc7fMIEA8UunLs0hPlt3ersHDHWn6OwxqoJtJ0b5er3tC4O+OAVjF?=
 =?us-ascii?Q?1pIDfHGytNksQZM07LlXChMJ5Plste5pJdEzBiayonNce60pg7Q0IUn1DdnZ?=
 =?us-ascii?Q?cCIMMNn2b3/3BaVmT0VppeF+kQs1g4uiiUUck1qiPIv2ns4SublmDM3BQOTA?=
 =?us-ascii?Q?RnIY0yXdFLdxj4SC7XcWmaapju8CaD9Bf0FJJHGkyeR5rgj6Njd30Kdgjv/8?=
 =?us-ascii?Q?ETC95ON8La2+19kziF5k4bF9wY3xHnHSIGbGBg27IW5zS2k3Ez/cHaGvh3Ti?=
 =?us-ascii?Q?9HTG3B4y7OJryoBaG/c5K4rUzrPq6X/7ZhIOe9jbzer62z48Uxoiip4P27Jd?=
 =?us-ascii?Q?LyERY/GJT52px682BMC8bAuVSU4DHvwgIauTioPzYsoMKuRqqJxtmPyNZHCo?=
 =?us-ascii?Q?dMPzF3j4ZOxGhnOr1OhAhK8LfjlE5wKkZB5N7ADZroGMrGrlMDrhGbPeAc45?=
 =?us-ascii?Q?6/jrlWLJO5YUXWfrygZ4/R83dl9wv4wK4XDdROzaerlyLVBKIu//r9cb5/QJ?=
 =?us-ascii?Q?vJ4IpOtKSy0EcX2RSHYMdQh2Vba8ZKFeOhGgXt1L7sZtvfrNb4ifq0yvK1fb?=
 =?us-ascii?Q?Rd9dt29x5uH/G541U1/DA/AWZ6CyVj708d+tGdvURG3T8QUMSoNGfFSQEnEe?=
 =?us-ascii?Q?ATw4VZojHZ8A9zX3/brCSBIe7FJSG3QlvEmPlmkwshhvgdET6m56fRA74KVF?=
 =?us-ascii?Q?kHjDrOXiQMIxenu2X2aPN1OD8WG7LW3/lhMLOeSnDjev5YKxTK+BguH7EHVP?=
 =?us-ascii?Q?/hD3GXiM9qhutbczExcg5M4YySp5WMNPupcQQZkqwco2LDulwIfCdF2WrfWL?=
 =?us-ascii?Q?KFTfejeb+ks9qIb61mtV0HpYkNS6IFudx17U/ZF9sNy9LTRD5RmcVxjEbzGK?=
 =?us-ascii?Q?/k47m+ozajqz9k4MjoRrJ+khfBUS+LKHi5iaps3n01hzWTYvBdHbLWrr7DqQ?=
 =?us-ascii?Q?wntQZmzquZVDP5F4e64xl/opC5VJ8Ur2txnirxVZ7yGlt7+5iLswNVV1HcKF?=
 =?us-ascii?Q?S6WUKJVbXlCbasqSfLCy8qsz0oNQSuEGhml3/UpNt1flCYQjf3hSjMpkG5R/?=
 =?us-ascii?Q?/mUv8ReaDc6+6BOiSofyaMgLlUvDk4RmtVo1JEiaa1RTMcI8CcIL8EuJPNVq?=
 =?us-ascii?Q?b538FRvUBtNmr5yUAg6BxTbz0qYFHo6cKESnRBSv6El+xhREIOW5/MOQTLsh?=
 =?us-ascii?Q?ApoAa+NhRmXA4cQuGjDx2ks1UqHHBriv/Og2siC83PNDZCxuNqAOaBkmp9eh?=
 =?us-ascii?Q?cIjktlE01b4EFJ5A1mVHpAYQAD1JtreoC7LVxFxSWreS441d44FockG9uf6m?=
 =?us-ascii?Q?EGP0s1zvYaX1619iDYcKnJsfHQcjOrz1jBY9oVtXXETcP5CKM1sudHhLfYIS?=
 =?us-ascii?Q?qjdqA2jIkGl9iLk+EQAYkgJNV0QV6K6UFodesVPx8h9pl31bse1bYg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TCPxliMljsHYaZLluslq6r3XVXTzie5ir6OOGmZSL2MTabitxFWIbLjdiGBt?=
 =?us-ascii?Q?4sbjm7NFbCDBqLqjczALrxlwHP99HDFYjPZJWxWxJyXq2SCfFZuuXFIVLqYZ?=
 =?us-ascii?Q?Xh2OC4eUzBmvqq+WOymQECS9cpeaxTUfqQCpY2EpkG/N2ASky6NEPZG5t4w/?=
 =?us-ascii?Q?oMptl4WOkug3ibJCbmNQx0JG4eVho6esM//cJbJp6VwYnAO8dw2sC9JNXOsW?=
 =?us-ascii?Q?PIXc58x4keGZqtxiNBCVLFhpBKyajmVRwJ0nSsQjZKbDnFMuYSXBwqDepwE5?=
 =?us-ascii?Q?5QQnW4nZdWi9oBhTiDZwA8KvKkMewA6H/82NTUaVY6YNdtS8jWceocsv0JT1?=
 =?us-ascii?Q?BNQXa2j1g+l8oGgQbBd3wJKOjzIVH+6udyKvsLRNJNJl0974ieeYCPUbagks?=
 =?us-ascii?Q?84EyGUv0/eAK/g4VMWyFZwxIRy75KG8+UyXFUIYWFY6amIEyixn+KR/qfPs1?=
 =?us-ascii?Q?8uEF9YEpW4LZf+TipvCTJpHYQBHFcfBW+POAAoCaaLB9DraWBd8XWkoUqt8T?=
 =?us-ascii?Q?hMm1Lm1JGjf69hrdKYBEvlP3xgMwPo2rPrd6avgMvIceoPpSrIp6hTyphOK9?=
 =?us-ascii?Q?MmZiioQTFJBd9WLt62L0OgXvBxmAnMvoyzeotvN6mYoi8/nOa+CQZyyAOIGb?=
 =?us-ascii?Q?RtbOSHQ+MkOr9njSXnmhq0mL9yhSS7gdpF9Sj7k5LsjvvCwK4mBbkPGVuBiG?=
 =?us-ascii?Q?7Y6p8CXD/0Fbs8wkkM7qksy04aWvv1pga6J54aRtpI3pRlKOdjIbab1E33Q+?=
 =?us-ascii?Q?VUn0wjdthal4mmMevxYusnu7vupj7dcPQX5bqSmGj3070/QH/4bpKsqg61AI?=
 =?us-ascii?Q?y7vNlS/SktdZrdKjWkkuz40cTNEU2Yz7M2wV+MUv1ElBYwSD0F92Dxr+a8Cs?=
 =?us-ascii?Q?ETgDnTrk21s/HlYFPG2GvGFWRSMxQGa6CUMeDiT3YOsGMYVJrz40uiCLi3/Q?=
 =?us-ascii?Q?+55w7SdbMxsBDRaJyFfqj/sAKimRU3j9gSJmJA4KGbkecsXbh2ShvIoIqWO/?=
 =?us-ascii?Q?TWefY23W0CUs9CgVuLbfE2N1OwneYwxxKW9H7EJF2uJS52YsXJx2NV3eFTVb?=
 =?us-ascii?Q?drrf91nPt6YZp9GkfnJmJtxJI8gqBfOmdk4/5ZO5bqVP//1r7kCGslN7bJNo?=
 =?us-ascii?Q?uzqSdkcOg1rcw3igb4GZQSd9/+/btfXemO5q2Z+BSvD7gYbuyNs2dwetg8NC?=
 =?us-ascii?Q?oOvyaPIeAbj1GWp4uacpSkoF7k2EChHXai/66+M/l/9wDR8E6I6Amg0NzwiN?=
 =?us-ascii?Q?ZAa8v4CPakECl2q1lLt8C+F5/+RNeYsoV25aqR9MaifOG0dsnW6FL1W9w6US?=
 =?us-ascii?Q?P9E90rgp2IQS2uhzMXfOOmn6B/cS79HzDEGQiaEfFTN04sLjHJtbp6TWv9IP?=
 =?us-ascii?Q?b7MAq9UxIs0pz0LkLVkbIFKHemjIohIQ8ECel1wTt9UDusqp1FPv/DKecbtA?=
 =?us-ascii?Q?fTTB84/hmSr/cD8uTJB5Bo0gA/30xJMi4/Igy1mW6/vApQN3ynkyoN+yrjBe?=
 =?us-ascii?Q?qTr9+Mt9reutgbVqx07QkCJnqsWygkIf4qkon4Gw93lOLRq6BPycgoFW+c6+?=
 =?us-ascii?Q?AadKdRsqigHVI6pn9p8rBMUb88rH3y5pcympx/PARYcEB3/07lBzO5NsGjvi?=
 =?us-ascii?Q?kA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6872b4-b83a-4f1e-1380-08dd701a7503
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 06:08:29.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bem0kN/WeAXHxfxChgyGVheiQOxeHDF7o648UTEq4PgdAjP0+vbd8peWwtnKTM4jHuDtBhdifvTlzs1W6meGFQ0t5D6efQve9M/vVHzvhpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8780

Hi John,

Thanks for the patch.

> -----Original Message-----
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> Sent: 30 March 2025 22:50
> Subject: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap support
>=20
> The RZ/G3E system controller has various registers that control or report=
 some properties specific to
> individual IPs. The regmap is registered as a syscon device to allow thes=
e IP drivers to access the
> registers through the regmap API.
>=20
> As other RZ SoCs might have custom read/write callbacks or max-offsets, l=
et's register a custom regmap
> configuration.
>=20
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> v1 -> v2: no changes
> v2 -> v3: no changes
> v3 -> v4: no changes
> v4 -> v5: no changes
>=20
> Note for Maintainers: There is a false positive warning reported by check=
patch.pl on this patch patch
> stating that the regmap_config struct should be const, despite the fact i=
t's updated in probe().
>=20
>  drivers/soc/renesas/Kconfig         |  1 +
>  drivers/soc/renesas/r9a09g047-sys.c |  1 +
>  drivers/soc/renesas/rz-sysc.c       | 30 ++++++++++++++++++++++++++++-
>  drivers/soc/renesas/rz-sysc.h       |  2 ++
>  4 files changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig in=
dex
> 49648cf28bd2..3ffd3a4ca18d 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -388,6 +388,7 @@ config RST_RCAR
>=20
>  config SYSC_RZ
>  	bool "System controller for RZ SoCs" if COMPILE_TEST
> +	select MFD_SYSCON
>=20
>  config SYSC_R9A08G045
>  	bool "Renesas RZ/G3S System controller support" if COMPILE_TEST diff --=
git
> a/drivers/soc/renesas/r9a09g047-sys.c b/drivers/soc/renesas/r9a09g047-sys=
.c
> index cd2eb7782cfe..5b010a519fab 100644
> --- a/drivers/soc/renesas/r9a09g047-sys.c
> +++ b/drivers/soc/renesas/r9a09g047-sys.c
> @@ -64,4 +64,5 @@ static const struct rz_sysc_soc_id_init_data rzg3e_sys_=
soc_id_init_data __initco
>=20
>  const struct rz_sysc_init_data rzg3e_sys_init_data =3D {
>  	.soc_id_init_data =3D &rzg3e_sys_soc_id_init_data,
> +	.max_register_offset =3D 0x170c,

 Replace max_register_offset->rz_sysc_regmap
>  };
> diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.=
c index
> 1c98da37b7d1..bcbc23da954b 100644
> --- a/drivers/soc/renesas/rz-sysc.c
> +++ b/drivers/soc/renesas/rz-sysc.c
> @@ -6,8 +6,10 @@
>   */
>=20
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/sys_soc.h>
>=20
>  #include "rz-sysc.h"
> @@ -81,6 +83,14 @@ static int rz_sysc_soc_init(struct rz_sysc *sysc, cons=
t struct of_device_id *mat
>  	return 0;
>  }
>=20
> +static struct regmap_config rz_sysc_regmap =3D {
> +	.name =3D "rz_sysc_regs",
> +	.reg_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.val_bits =3D 32,
> +	.fast_io =3D true,
> +};
> +

Move this to SoC specific file.

static const struct regmap_config rz_g3e_sysc_regmap =3D {
	.name =3D "rz_g3e_sysc_regs",
	.reg_bits =3D 32,
	.reg_stride =3D 4,
	.val_bits =3D 32,
	.fast_io =3D true,
      .max_register_offset =3D 0x170c,
};


>  static const struct of_device_id rz_sysc_match[] =3D {  #ifdef CONFIG_SY=
SC_R9A08G045
>  	{ .compatible =3D "renesas,r9a08g045-sysc", .data =3D &rzg3s_sysc_init_=
data }, @@ -97,14 +107,21 @@
> MODULE_DEVICE_TABLE(of, rz_sysc_match);
>=20
>  static int rz_sysc_probe(struct platform_device *pdev)  {
> +	const struct rz_sysc_init_data *data;
>  	const struct of_device_id *match;
>  	struct device *dev =3D &pdev->dev;
> +	struct regmap *regmap;
>  	struct rz_sysc *sysc;
> +	int ret;
>=20
>  	match =3D of_match_node(rz_sysc_match, dev->of_node);
>  	if (!match)
>  		return -ENODEV;
>=20
> +	data =3D match->data;
> +	if (!data)
> +		return -EINVAL;
> +
>  	sysc =3D devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
>  	if (!sysc)
>  		return -ENOMEM;
> @@ -114,7 +131,18 @@ static int rz_sysc_probe(struct platform_device *pde=
v)
>  		return PTR_ERR(sysc->base);
>=20
>  	sysc->dev =3D dev;
> -	return rz_sysc_soc_init(sysc, match);
> +	ret =3D rz_sysc_soc_init(sysc, match);
> +
> +	if (data->max_register_offset) {
	If(data->rz_sysc_regmap)

> +		rz_sysc_regmap.max_register =3D data->max_register_offset;
Drop it.

> +		regmap =3D devm_regmap_init_mmio(dev, sysc->base, &rz_sysc_regmap);

regmap =3D devm_regmap_init_mmio(dev, sysc->base, data->rz_sysc_regmap);

> +		if (IS_ERR(regmap))
> +			return PTR_ERR(regmap);
> +
> +		ret =3D of_syscon_register_regmap(dev->of_node, regmap);
> +	}
> +
> +	return ret;
>  }
>=20
>  static struct platform_driver rz_sysc_driver =3D { diff --git a/drivers/=
soc/renesas/rz-sysc.h
> b/drivers/soc/renesas/rz-sysc.h index aa83948c5117..37a3bb2c87f8 100644
> --- a/drivers/soc/renesas/rz-sysc.h
> +++ b/drivers/soc/renesas/rz-sysc.h
> @@ -34,9 +34,11 @@ struct rz_sysc_soc_id_init_data {
>  /**
>   * struct rz_sysc_init_data - RZ SYSC initialization data
>   * @soc_id_init_data: RZ SYSC SoC ID initialization data
> + * @max_register_offset: Maximum SYSC register offset to be used by the
> + regmap config
>   */
>  struct rz_sysc_init_data {
>  	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
> +	u32 max_register_offset;

      const struct regmap_config *rz_sysc_regmap;

Cheers,
Biju

>  };
>=20
>  extern const struct rz_sysc_init_data rzg3e_sys_init_data;
> --
> 2.25.1


