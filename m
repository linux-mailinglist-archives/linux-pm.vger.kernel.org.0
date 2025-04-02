Return-Path: <linux-pm+bounces-24733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF487A796FD
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5E03B320C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B91F3B82;
	Wed,  2 Apr 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ip2K6/5L"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011010.outbound.protection.outlook.com [40.107.74.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3329193436;
	Wed,  2 Apr 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627514; cv=fail; b=AIggIqCWxfUAiXFdnh25uuMZU3d0etkCoLN9/QDJq9XJCc7TZV4xtdgObDfl71g1eJ8XZF5kBHiVI+jXOvrqH1W0JWj47/xBCRKLExu1jEyI/qLo+NbcI8Zl/NQ7jmF/DJ5RF3LQp2LQFrB5jvvJ91dhWagXiO8Ml0fIByqPvVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627514; c=relaxed/simple;
	bh=bT1KNc22uEhNisLTSeowRZZUz18kdmz/3BWCckM9ank=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=slyNadtvn6xzefkP8Xa+TVUlH60rKxjTSm1NjH2wKgSOcI2gY9YE8m5CETSbK4kZnRCEEikwfbH9ftfBagM7HEEiT0OwLE9ECfrEFA8WSr1o5Y4vg70FejYqkLqLDWZh1y9gQ8R1JvnvhvfdCFT/DSA0pIUKX7Fu1V+UlsE0428=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ip2K6/5L; arc=fail smtp.client-ip=40.107.74.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzYoypDPTUzJ+x0cGK4jVJfA4C3UnONACsKdWoB7tTPaWCYm+ap0IvptV4moQAGsXpqgfD+msCQWvCHx4ysce6RwpmpDdJMQM5rVbP4NXFKAwZtj1jQt6xd8IhzlphUT6VMw3+Q25cgsA1vYCTbn21Ji/leTju+69JD4xk7D0I68bxwgfxwp2vNlGu+OJaexsYDkbV/oxfV3sxziT76SzMMPUM0yZHKksikMOaCqyIBiznwTg47d6rCNb8BZ3veQ6lvM3ptVIoiBvA5UeKDKWRFz7ZtM2yKKZWYPYxtjp23BHtLr+Cr4axRFU6Mx54w+6JQfqAiKs6YA66uIJZMTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqOS5jd7xPa+9F2q7ZZT4Ur+tTbbi6JQeFuWuW9YicU=;
 b=JyvfRAjP9HiIMJf0+0Ya4MZnxQfxysCTMfllS1/D00IdlKkvTeOzGZPjQlBQtIAGvrwCqk4ILWPuhLif4d9VqWG42YYQr7zuDRiHXbuUB9PHhzhvBpMyef79LlXzsN59tLg7g4PDcMezI0sM8i+FYG85ZdtUjTgA6yNMOVxsTjlvSHPdU/HO362IB6tE+n7qOtkRNYDnFCj8Xhqc8pI4k8eo1J0PKkjgEIt04uXDbcZr8mC/NjTRQSZXNLKPDHT/CR3E1PsUJxuYlgh17rsRbJTeMvkE80rNKHDi5S44jN7juxawPI9a1s5DEC7EjSBg1zzgM4ElhV5JzsJSa/EkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqOS5jd7xPa+9F2q7ZZT4Ur+tTbbi6JQeFuWuW9YicU=;
 b=ip2K6/5LqCleQSKq6ReY/yOHie9hu1oElakg+x53SD7FMrzcFX9O9N+R1mTl4048KuaihcDCyH8BQhU2jCgQX7QXogTtWbt6UzEKRCDWPAtGq6FsfBwdAI2BSjXt+vrbBa+98353VxUHd2QKleyFImAxbGXGfNek1jxObREUZT0=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by OS3PR01MB6005.jpnprd01.prod.outlook.com (2603:1096:604:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 2 Apr
 2025 20:58:23 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%2]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 20:58:23 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, "geert+renesas@glider.be"
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
	<lukasz.luba@arm.com>
Subject: RE: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Topic: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap support
Thread-Index: AQHbocDOdKVSAMtBFUO6x2CfxEhaz7OMwyOAgAQbZPA=
Date: Wed, 2 Apr 2025 20:58:23 +0000
Message-ID:
 <OSBPR01MB27755874489BF03659A1DDE8FFAF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-2-john.madieu.xa@bp.renesas.com>
 <TY3PR01MB11346D2794D3D5C0FC870550286AD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB11346D2794D3D5C0FC870550286AD2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|OS3PR01MB6005:EE_
x-ms-office365-filtering-correlation-id: 701457c1-ab97-42cf-fc7e-08dd72291b6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AXuXa+r7vj9cUt47MsYZpiZZXvH+JKlf5MTF/hFPOfZ7uoo7YctDYRFkTERe?=
 =?us-ascii?Q?rhqOylV3Eu2uO3DkvtJqcMupEtRrYgOl988iuDe6ckU+WUQrkepM8sAaCW1z?=
 =?us-ascii?Q?IsaIvXvIg+ues/DiYzpD9ds/+ZP7M27g0ge/k99fPAqDZYgMbgezhzDN9v6R?=
 =?us-ascii?Q?fcNSTk5+70L9dhBc+dwmBxcjr2tjmoEsHTVpxt4awStucpOEvuwd3k3nNrPV?=
 =?us-ascii?Q?ClR4Aw5kYl5W3hAVqnDuxDoxmnl+f2dw4Iyav7oV6iO1aCR9wCgGnTFV9gMz?=
 =?us-ascii?Q?x3zdvJYoiHkj4coflPErt4H6Ck/mVdDnvOgmPZqcbyiPD2DDwLkQ8er4+dWx?=
 =?us-ascii?Q?KtiZ9bwmSYP5oKicpE7r7Bo6NAWSPLbCB3HLgtYojKnW1AAN9F+AlOnxhOAC?=
 =?us-ascii?Q?Bok7ROHk8PMJ4wgCLxEZZESX6QIaPdwHLZbyTXu+2CX2MetODYRrib6Z1dsg?=
 =?us-ascii?Q?IwcJNV+Ed85gNyq1eMJ6LwRst7p6JJBKlFviCZGSRgyAOn3x55LgXTkDsj4A?=
 =?us-ascii?Q?475cp99+e2XN7vQRRBV3rH9JNs6Ibiw1GsbHZuK2XxHKSTVvOby03BVC7hLj?=
 =?us-ascii?Q?hlPNWwUPFTc74DCfmmL9WdPFSTSVAQSlwxMsDQiDgL/sybucDVG48MTbmINq?=
 =?us-ascii?Q?QGN943ckqGVK2HgwMAQAAynFcPWGdJ66fyekCHlEFwjc7HE5tVRNcsBKUJuF?=
 =?us-ascii?Q?F0j3x0Ylawr5ZXnNz0pCGdkQms5KNVd4hea+ol6PoMlQsN5DVBtPD7GpXo/2?=
 =?us-ascii?Q?SAgVitwtZg4PCW/gpPTsIKOywOKJXJgRyr5OC9dCFVqlrn+cjqZAnEZosXDU?=
 =?us-ascii?Q?Xm3LtWxxitU2klEjYxVdylrgnCTP63A4BVeQlrlufyKtSKTCLCdk5iZjsnF/?=
 =?us-ascii?Q?+uB16LK/Lo0rLPp3KijEjHQtpFCvHWJ4GjBxYZf96jIPVDl/c6GMIpFDw0LH?=
 =?us-ascii?Q?wA7p0SI5GxlA9Do3+t9LuvXPQTHLcpLpWgIBUYZ9AzROh2mOXXiR7J3CnZiI?=
 =?us-ascii?Q?22tpFR7ArT3m5TcnSKe6IuPJjI+clwWR8OY9igJYBAARW/uxwE7MNJrkf0gP?=
 =?us-ascii?Q?5Lf5z4vAjByQY9PbcUf9pbdmce7fhj6o7R4jLe42kbV1kYjNABnIxRs89buj?=
 =?us-ascii?Q?osJ24cHGWNOc4eyBk1i8R+30wAFY0e3A9Qv91tPIVPdLa4tlg1UuzPTZGRMT?=
 =?us-ascii?Q?qtSxR3rKM+BafpRj+Pjd9HgOuKTQVhaB9m3QFiqOCVxXEkTeCG9mLh6Ea9Kn?=
 =?us-ascii?Q?j7jX33icd8+qVLwropuzoz7RFXGW+8+vAPfvp3w7XfQ5lXqe7Ge6kmlshUMj?=
 =?us-ascii?Q?vXnb8kP9ShsH4QWg7dt9Btdcladj6HpxGdb6tilMOvhnZYeOqoC4N9p+crbB?=
 =?us-ascii?Q?aysuNhdn7ig9omQW7Z+pGxftcSDJgjI5X8hTn+nVOB3szrTjrm35yYjbZ2jC?=
 =?us-ascii?Q?kobs9xTqt6FGSVRJx3dCo492crGGz7aN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yj7roLuLWgPl/PmpvhUNsxcpl4BDEj1KrV6oRK73/urw29dHlnPT+puCGbua?=
 =?us-ascii?Q?7isfMvrEoeIe2kRgfIM3Fh2xsGUq0BWidG6Vgr0bW5iQJ3RAJqCPRm7OHA0u?=
 =?us-ascii?Q?0XJ6f1/wHFOyuFlEC3h0bwua+nzSX+6Dlb7ykB4iHC+4dtygP6Rz0P3GfqgR?=
 =?us-ascii?Q?g31CRzYtpGzQq+/Q0FLTvOwTjmkKXxH+25wetLoDB92BBS23PScjRuSwm0sU?=
 =?us-ascii?Q?3wNDcSTS7tiQaYvbbNKIuXld67aSijNl9q7I8oZzFW5d1mrQ+MR5ZRLFtTwt?=
 =?us-ascii?Q?PBVyEAisYcTKQcv8ZKs0DbOdisq/TG9EgnawjakFR2cEgNSExVZgoJs8WroE?=
 =?us-ascii?Q?X7bsBbqc9h1aZlFR5PGKCSnZNToVEYUMdxnkDJ67QazMnHFbE6NQebFgBOeQ?=
 =?us-ascii?Q?SisuKnSA+DpyAvbHBR7qZkaCcR7Qr3u5mi0S/1/l2Ko95U3H1+ScFo9f8Bby?=
 =?us-ascii?Q?Tv+SSB8vL2agHJBi0SxStk2xaChbYLXFHT+d9OnFGY/tGomr+9R/IDxRvbmC?=
 =?us-ascii?Q?/2ghoIdrRsITNtPKpa4XI1yDzl2hRIlmXjAlResseaovkPJRVHQJZ91ktsRv?=
 =?us-ascii?Q?Nln8dUCKd79rdUi5rY/Hm2hqPKThWR0aT41k/jw0QmCJ3cZ2K/Oj3ZhsfurS?=
 =?us-ascii?Q?ppLHOdzKbzUnMu6+9e92QY6d+NJoYt0VfLQJr9cboG2+4U0sIXksTLvs6QRy?=
 =?us-ascii?Q?84iggolYLM6LW/OTGf2NuGJloyVe5V0prbKscWJKrM6OUG3/0/lTCAZUEzL0?=
 =?us-ascii?Q?pDWeP7mqwVsZmrSRU2ypfpf17M/KahhL4bS6ISvF4UrxDmwnbweREXLxNJSA?=
 =?us-ascii?Q?s215n0My2SW5jgSRc0z9g7R6dbtlvbPjQXr8FLrA0LSioKmMNHjtTuhP7EfO?=
 =?us-ascii?Q?gc0A6Lu4TwfJ1iigrr3FeJTR8REfTuF+T1FuYW3hKlq+eAy5Bpg7BOqPfY9Y?=
 =?us-ascii?Q?QnUXxgt1uhMxC86nLJrcQw0/ecs5lFzkTCSffHUxjkBd801KPMFNVP5CTofy?=
 =?us-ascii?Q?kXEWwMtN1cjwmpj/+rpwUDfSxvBHRCttoyBY58ryX/6QZ8F1iRTNgTYhx0JQ?=
 =?us-ascii?Q?EEcMqK8s8PVj8YGmacAXDLHsoSFA6CScL9MTxjMLetLWtyyYrrRUM5PxRBpa?=
 =?us-ascii?Q?Y3imcdhIUGYkJ5YjU/4QlpIGaya2ETvIrTnNhRM2MtPAWyhLuSBqLtasNduf?=
 =?us-ascii?Q?btepY+6sCwmXjewwro1mUs3DUtWOiRja14iwz5TwOHb6Xty53o9AM9gHy8jT?=
 =?us-ascii?Q?sQfUNqMK9zYEXOMozb4CxfMovWqxPAXaug1Sf9RgAXSuTZk+YN5xgY3qzFnH?=
 =?us-ascii?Q?xad9yitsrO5M9dDTMyhTegCC1UcnttmggIZtmUjcAPfiw1kOK55s+OAImd3T?=
 =?us-ascii?Q?rNh5GRXRaGD2kfUyIBdBBa/A4FPGJ2/EzCWKRib4irirSHMPdAz1NXV+7J8K?=
 =?us-ascii?Q?BemU+5MhGG6WDXlb2KOd7hWFYBBi8xWf9PtUA8YK70tjuLYUuUa7ynYWi3vR?=
 =?us-ascii?Q?4BqYXANv8JyqLcjWbfZvqO1N2OOf6yJBjpFlqJ3CSKj+htyFXPgF/E5RsvBX?=
 =?us-ascii?Q?BAnH4YLPym2Mn4pHFczP7Q3jJRYLZUrnWo+p97SC3NwOYw26b3HB9BWy4uqM?=
 =?us-ascii?Q?1g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 701457c1-ab97-42cf-fc7e-08dd72291b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 20:58:23.5256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTq48MXlhb3DP8Vl8RyUC8nBlbuW9LtkIbUJR6bsv0XYxpvz9d+m8/bLmwA4sQCNzLDgahCq5Zf9snJC9ot+xRUPhK3+RxUFjgAJ/ZYtPQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6005

Hi Biju,

Thanks for your feedback.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, March 31, 2025 8:08 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; geert+renesas@glider.be;
> conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org;
> rafael@kernel.org; daniel.lezcano@linaro.org
> Subject: RE: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap
> support
>=20
> Hi John,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > Sent: 30 March 2025 22:50
> > Subject: [PATCH v5 1/5] soc: renesas: rz-sysc: add syscon/regmap
> > support
> >
> > The RZ/G3E system controller has various registers that control or
> > report some properties specific to individual IPs. The regmap is
> > registered as a syscon device to allow these IP drivers to access the
> registers through the regmap API.
> >
> > As other RZ SoCs might have custom read/write callbacks or
> > max-offsets, let's register a custom regmap configuration.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> > v1 -> v2: no changes
> > v2 -> v3: no changes
> > v3 -> v4: no changes
> > v4 -> v5: no changes
> >
> > Note for Maintainers: There is a false positive warning reported by
> > checkpatch.pl on this patch patch stating that the regmap_config struct
> should be const, despite the fact it's updated in probe().
> >
> >  drivers/soc/renesas/Kconfig         |  1 +
> >  drivers/soc/renesas/r9a09g047-sys.c |  1 +
> >  drivers/soc/renesas/rz-sysc.c       | 30 ++++++++++++++++++++++++++++-
> >  drivers/soc/renesas/rz-sysc.h       |  2 ++
> >  4 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> > index 49648cf28bd2..3ffd3a4ca18d 100644
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -388,6 +388,7 @@ config RST_RCAR
> >
> >  config SYSC_RZ
> >  	bool "System controller for RZ SoCs" if COMPILE_TEST
> > +	select MFD_SYSCON
> >
> >  config SYSC_R9A08G045
> >  	bool "Renesas RZ/G3S System controller support" if COMPILE_TEST diff
> > --git a/drivers/soc/renesas/r9a09g047-sys.c
> > b/drivers/soc/renesas/r9a09g047-sys.c
> > index cd2eb7782cfe..5b010a519fab 100644
> > --- a/drivers/soc/renesas/r9a09g047-sys.c
> > +++ b/drivers/soc/renesas/r9a09g047-sys.c
> > @@ -64,4 +64,5 @@ static const struct rz_sysc_soc_id_init_data
> > rzg3e_sys_soc_id_init_data __initco
> >
> >  const struct rz_sysc_init_data rzg3e_sys_init_data =3D {
> >  	.soc_id_init_data =3D &rzg3e_sys_soc_id_init_data,
> > +	.max_register_offset =3D 0x170c,
>=20
>  Replace max_register_offset->rz_sysc_regmap
> >  };
> > diff --git a/drivers/soc/renesas/rz-sysc.c
> > b/drivers/soc/renesas/rz-sysc.c index 1c98da37b7d1..bcbc23da954b
> > 100644
> > --- a/drivers/soc/renesas/rz-sysc.c
> > +++ b/drivers/soc/renesas/rz-sysc.c
> > @@ -6,8 +6,10 @@
> >   */
> >
> >  #include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >  #include <linux/sys_soc.h>
> >
> >  #include "rz-sysc.h"
> > @@ -81,6 +83,14 @@ static int rz_sysc_soc_init(struct rz_sysc *sysc,
> const struct of_device_id *mat
> >  	return 0;
> >  }
> >
> > +static struct regmap_config rz_sysc_regmap =3D {
> > +	.name =3D "rz_sysc_regs",
> > +	.reg_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +	.val_bits =3D 32,
> > +	.fast_io =3D true,
> > +};
> > +
>=20
> Move this to SoC specific file.
>=20
> static const struct regmap_config rz_g3e_sysc_regmap =3D {
> 	.name =3D "rz_g3e_sysc_regs",
> 	.reg_bits =3D 32,
> 	.reg_stride =3D 4,
> 	.val_bits =3D 32,
> 	.fast_io =3D true,
>       .max_register_offset =3D 0x170c,
> };
>=20

I've implemented this SoC-specific const regmap_config* approach,
and checkpatch does not warn anymore.

Geert, if you are Ok with this approach, I can send the v6
along with some other comment fixes that I've received.

>=20
> >  static const struct of_device_id rz_sysc_match[] =3D {  #ifdef
> CONFIG_SYSC_R9A08G045
> >  	{ .compatible =3D "renesas,r9a08g045-sysc", .data =3D
> > &rzg3s_sysc_init_data }, @@ -97,14 +107,21 @@ MODULE_DEVICE_TABLE(of,
> > rz_sysc_match);
> >
> >  static int rz_sysc_probe(struct platform_device *pdev)  {
> > +	const struct rz_sysc_init_data *data;
> >  	const struct of_device_id *match;
> >  	struct device *dev =3D &pdev->dev;
> > +	struct regmap *regmap;
> >  	struct rz_sysc *sysc;
> > +	int ret;
> >
> >  	match =3D of_match_node(rz_sysc_match, dev->of_node);
> >  	if (!match)
> >  		return -ENODEV;
> >
> > +	data =3D match->data;
> > +	if (!data)
> > +		return -EINVAL;
> > +
> >  	sysc =3D devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
> >  	if (!sysc)
> >  		return -ENOMEM;
> > @@ -114,7 +131,18 @@ static int rz_sysc_probe(struct platform_device
> *pdev)
> >  		return PTR_ERR(sysc->base);
> >
> >  	sysc->dev =3D dev;
> > -	return rz_sysc_soc_init(sysc, match);
> > +	ret =3D rz_sysc_soc_init(sysc, match);
> > +
> > +	if (data->max_register_offset) {
> 	If(data->rz_sysc_regmap)
>=20
> > +		rz_sysc_regmap.max_register =3D data->max_register_offset;
> Drop it.
>=20
> > +		regmap =3D devm_regmap_init_mmio(dev, sysc->base,
> &rz_sysc_regmap);
>=20
> regmap =3D devm_regmap_init_mmio(dev, sysc->base, data->rz_sysc_regmap);
>=20
> > +		if (IS_ERR(regmap))
> > +			return PTR_ERR(regmap);
> > +
> > +		ret =3D of_syscon_register_regmap(dev->of_node, regmap);
> > +	}
> > +
> > +	return ret;
> >  }
> >
> >  static struct platform_driver rz_sysc_driver =3D { diff --git
> > a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h index
> > aa83948c5117..37a3bb2c87f8 100644
> > --- a/drivers/soc/renesas/rz-sysc.h
> > +++ b/drivers/soc/renesas/rz-sysc.h
> > @@ -34,9 +34,11 @@ struct rz_sysc_soc_id_init_data {
> >  /**
> >   * struct rz_sysc_init_data - RZ SYSC initialization data
> >   * @soc_id_init_data: RZ SYSC SoC ID initialization data
> > + * @max_register_offset: Maximum SYSC register offset to be used by
> > + the regmap config
> >   */
> >  struct rz_sysc_init_data {
> >  	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
> > +	u32 max_register_offset;
>=20
>       const struct regmap_config *rz_sysc_regmap;
>=20
> Cheers,
> Biju
>=20
> >  };
> >
> >  extern const struct rz_sysc_init_data rzg3e_sys_init_data;
> > --
> > 2.25.1

Regards,
John


