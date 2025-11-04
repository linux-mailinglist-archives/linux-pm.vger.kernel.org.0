Return-Path: <linux-pm+bounces-37353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949AC308F1
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 11:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6591618979AF
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CA729BDBF;
	Tue,  4 Nov 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="leE1dI3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EE2D3755;
	Tue,  4 Nov 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253004; cv=fail; b=Wq0rHgOAMnNG0OowE1jMmahUudYrSsJHMxrRNpC6f02pw6HsarHElOaA7XfBUGb4seJcKhuaDoQ3cIM2XauarbHz8jKnpU7HmDMLEoj5ff+zrcFDOkz7czGbMNDv9R8xG0GnHHoaHYbIIFyyFsLVXU0rQPn4VAvd3Pe4F/g6des=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253004; c=relaxed/simple;
	bh=YeTaijhWa/RhWNQevXj45X2lJP4JhdyHVkfijWllLW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l4D++GzVsmXz2lvkYfkHeUSLv+/qzgrcEVAC9jLhDMXNTaV7Id1S3kBoTMgCHEqlGnYmr5D2on9FgSCyn77yINppIlzIydKhrcgwvFKCPN11boabWgTvIIQYfIXFVw6aIEDjMywzl5y24V+PM1KoKN0u2ftgqtg3vYb2dyLc7Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=leE1dI3F; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+2tFror6Q1VO4tDHN/rk2/KBpGBqc06Kq3t3Si28saQvWhE1N5WHmhe2aC1h1do4ibGq4i7THWORH18aY8zpdEqnDQo0UrYSKyp3rn8tHMmdJFHs1T9UNtaB4oG036DN8ONwyhQ5TTc3IkThODd2x9uWk+WgxMkVoWJsm4CDUw0l8Fd5TAY7IAwuY7w1u42T9QNi3nMFlwsL8GqXCI/PWEUkgUWOvV5HrzIuobaxjkijEOjmCOfiwwyU6PyP5qR1SC+EdGCdLeRPs3t4JaCgfb9vNUczFqMZb7Z0FCp+fb3e6r8zlPKCA5GJlnUmln9NfpscrFspx8zTdBULMIetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD1bwxLQnZk08S5SwGPWCMyhwATyUlBRw6/aO9P170w=;
 b=vakzM70q/f79r4uCUyWgJyjAT0Jse0PoWaYXEd7VxV8bV6BfEne4YUSfCFHAJaPTwtfKDDh40bYSCnSgSl4zmxRAg9Nu4O2bMpwo3wQzyjpEIm8rvcP25XjOJ0T81AuKrK0DUGiwXM9trIJGAYIus1NMuQdwMhn1alu/VsboRBHNAL8h56JksVX8zl7/f9WIwC2LksZui6b2X3Z8nMngsl2Bo+vXlT6dkYi+i7vJCG3X1YcNPIMxSNOp6WXRvSLlrmyYBaSps4Lxw9ohTMCfglpGr0j1bUKnaHtftGw+FIs+HfRH4MsGkg6AXlW8TwnQUUe8Lje5xmDJTXqpCfieIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD1bwxLQnZk08S5SwGPWCMyhwATyUlBRw6/aO9P170w=;
 b=leE1dI3FLXSnocXOl/kRECsLu/nAvlznGyWgAeQ6WPLkGkfsqDdrxaSGJ7g7YXtxjCB8z1W50jTYi8LROZridHCoD1NMsSvyHnB9JdLuhTnv5i2NHm/u9lsocl9TBRxQJ/73J4VAhMM9p2y48TpyeBW0vhL59cM0YwYii4thrQw8gQV6+h9EjULL9YAQnnwP7C0bGjAr/1E+AjzFluCnh92XxbK2cSIh9xEdcg9kHZsPEv3mgrty8hvGpeavDfrlA4hiJb7ps9SExMfZb8htW8jM1SxkbfYQGCV9hCExmbfgNOwWZD8nAgJoATDe+AlzY8gac63BJxq6FAmnYbDHnw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by GVXPR04MB11689.eurprd04.prod.outlook.com (2603:10a6:150:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 10:43:18 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 10:43:18 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: John Ogness <john.ogness@linutronix.de>, "esben@geanix.com"
	<esben@geanix.com>, "pmladek@suse.com" <pmladek@suse.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "ryotkkr98@gmail.com" <ryotkkr98@gmail.com>,
	"kkartik@nvidia.com" <kkartik@nvidia.com>, "fj6611ie@aa.jp.fujitsu.com"
	<fj6611ie@aa.jp.fujitsu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial
	<linux-serial@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Thread-Topic: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Thread-Index: AdxNWDvvSHwf8ruwQWK/6o5sXxny8wADMeQAAAJkdwAAAV1ngAAAwrYA
Date: Tue, 4 Nov 2025 10:43:18 +0000
Message-ID:
 <DB9PR04MB8429F50811DDC648DD8A7B8792C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
References:
 <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87qzuem7bo.fsf@jogness.linutronix.de>
In-Reply-To: <87qzuem7bo.fsf@jogness.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|GVXPR04MB11689:EE_
x-ms-office365-filtering-correlation-id: 65d368f2-9734-495e-6668-08de1b8ef74c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Lhf2Y8HkpLuF1ChzmuMml1U8uuoKVwxBwHPSt9z3Az+69h+LjdD+jgZB6ZtC?=
 =?us-ascii?Q?EBpJjdbEFSIL4yz5wV5X6mXyLCtzjfjBm4LAMhDsm8wnk5LdhjtskN3AAoBv?=
 =?us-ascii?Q?JLGsLf59D+ErEUQKuV81qT9D7M3huYIvYGyuGNkQyIZFJuQTW7/cZxGnPgQo?=
 =?us-ascii?Q?PlLgFTnRkBYq4ER4ddOPfbDzTLovQEcwG++dilg/Qu1iRMYRxS429pAv5WB0?=
 =?us-ascii?Q?ft1HaftbKguJWB+nUdGdW9bSu8WisrwMtK837laaZlnURtlQOHLJlBGwTJbH?=
 =?us-ascii?Q?rIill0L0+Te2L2v4Fa/+YxTAw4IGJgjk5Fzf8WNPr5H6QHg3uSV7Ef59QK8f?=
 =?us-ascii?Q?KA57MoYTTBElTkC+r+GiUY78YyerBef4G5RDSki40ApVrqO9K2g7njOAFyto?=
 =?us-ascii?Q?bjsCGQDUZ/LbMm5KEdDcPG2fDLosA0hzQPcy0qvP60+5tye4iBMuFjOZpeby?=
 =?us-ascii?Q?N70dxJWZWgCV9qrJe2PEahJP2xi1BZw3+sfnwHa4umM2fjWHQm5vCEcro1tu?=
 =?us-ascii?Q?5i4iY1ytpoHakKMM59jfsMT/kDYkBcMLYmL8963sd6pSeUv/R+4JjGb3A3NK?=
 =?us-ascii?Q?U6ieUNzzUJr75ScoKCIbIPvfEVjJyclNO2mLduD1cTqsySjNl4gkDl4HzKFk?=
 =?us-ascii?Q?OPr1SYyY6xeBQcmYocy6cQXxL+BSwAi141Ifv1UV7ys8uVF3zzGFWERsNXuf?=
 =?us-ascii?Q?MqOzCOzILXE6xewm4RF2FEjs1wQveJqwiQGNhh+L4dEhu5LNF6LFl9zm/xeT?=
 =?us-ascii?Q?u2PRwPNd15eU2Y4XvpYcA0mC7sezUbiDLiWzPEqrNIwb9QvEwMJ/fiao7fAi?=
 =?us-ascii?Q?5WNUs4AAjHhikvRAzVxiGKJV1vEumRt7RMv7kpVc72XQQxX9hS70IXICBRtp?=
 =?us-ascii?Q?zjHsM5G19Mk5Zm+XLvNqq8PFqCWrnEz0aU+KIDii08vR/JGATDx3ghCkJpjj?=
 =?us-ascii?Q?e+zuDCdboHSuaMLhAiMpt7doFDHuzYf7Tt+F1m4zkuOi53Ikd6lPasm7DMG8?=
 =?us-ascii?Q?xKu6CQZxlSTbQ882DHyKWK3ZFjdyaHGkJNStjLvICCzWD/61ZhDOFZwvhiIw?=
 =?us-ascii?Q?NbTy+2bt4OKfdMtXIzVoaI3XBZbTrkzWdcjtZJT5YxVYNq79GqV436dqOj9l?=
 =?us-ascii?Q?LoMjvqGwsC+Bh+CTAwSf3jAtOpzJibyQ19bDFvoHiiSC11KPf0s9hQ+eM/2A?=
 =?us-ascii?Q?ji8Et8IG1Xn5KHcZbe36HNqVRj5iYcJV1oTAiSRELaxbJ0iD2omCTR7oSG1a?=
 =?us-ascii?Q?srrTaWKvhhVWz7v+i1YPNGVJcuHXyGDgrQ+IO53R+Z9Y4kaQ14qh6szMa0UP?=
 =?us-ascii?Q?/F/ahLmuGdik6rua81Ui4HJlSwMp3aHGhnYpFH49zZNOplc+M3BQ0kNp9wp2?=
 =?us-ascii?Q?XO8J2RwhX4Jdyl8VjK2WJvSwz9NtyNErT0Y+HG469PBh0sRNYacvLiRA52gt?=
 =?us-ascii?Q?Zxwzx36mHYvcjCxSZr7cjtUqn0cOk5Z/ZQOTIDtFplsw1tEX8I/SoOMoWJCW?=
 =?us-ascii?Q?cNJ+lAs6I9HsVSml0J/D9FteXYFpYUOOpf9uk3+ZPEZxy5G/DNtiDokFzg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5uxsPC7f6uk2JJpJ0iL3D39YtNQgPk2C+0p9zEs8y372GNphdOHgvV0M9sd4?=
 =?us-ascii?Q?VBOF56oGkFRqr4fZx1ua1X9juffZ+fi60NKQdRbBiyYet6dhOrqezXAhtXka?=
 =?us-ascii?Q?NZp8DvIFDaj4wAHowcxJ5PL1TZOgE7UfbduPmRTyAlqtwMzX6T0lBocuHeS/?=
 =?us-ascii?Q?SXKSbToMY35JjTLeqN9jWM4NkWEUiVMaIastcg8Leay8cnRB5yh4eC1DIOr8?=
 =?us-ascii?Q?TL1n/CUPQxE2aNSuNOWfOlgGCXa4oiYnNND4TKuKQxX6oiTJW6Keb9/tGiu7?=
 =?us-ascii?Q?Sbno1LDBulUnWm1ZfjtCECEdl1d4Ou84g+lHBNd1fUCebrgEueRaAGBldBRk?=
 =?us-ascii?Q?AyB2J1BNb7f1UJGZIA3BBoDsSiJ80Cklg/GBu5Mww11wfUb9jEVSG+74+MpL?=
 =?us-ascii?Q?F5jAby4s66f1l8xK4upxQEh5Pxlhq4Wq1plTcmq6AbVwtyzjL3EqWykoYvS/?=
 =?us-ascii?Q?VPZ49xEXqIXVQIrHVg1Nw/OSozdJ8eZPYaFAe6S5Pw3zOxClupgFfwK3Eu9d?=
 =?us-ascii?Q?HCGggH7vFeKQUwEjhHzlwCxYdD7sZUCc/WuMamGV3+xrIO1X+tjda71IAes/?=
 =?us-ascii?Q?d6bSBNEo/pU151Um6Fqyb6TrkyMthG10fJme+BRYxsk1yctKBlzDalAET2Jn?=
 =?us-ascii?Q?zod35bOj6prEYx2VtW0cijJgn7QZAptRKrpQD8NK0y5sdfwQy7fhERRhbdsu?=
 =?us-ascii?Q?dtbJ0sXgM26OrRv46GXzTBt2/zO9B+cpRUSswcA/0kVcxTpTqOzONeXBJrdd?=
 =?us-ascii?Q?obiOb+dBPCQ66Qs+7en1eucgDb47G0BrYM2Zh2HD41+iNj9u4ikjl5+Eud6I?=
 =?us-ascii?Q?wDKrLEv5ALIRJdSO8GbJX+bws8en2jf7AXI4OVdZ8w3y3i+eP/aynTHHNT1D?=
 =?us-ascii?Q?7OkC4/N8ayEcIAD+Ys3jZYyWD70+5xBqv3PfNGoq/avZ+i5tRezbNGu/9e1V?=
 =?us-ascii?Q?SSakIJDYYXsTOcV0p+4QyNk4+tOvgSaM/4wFWzPWk1M5kmuB/VwuClK1cwPY?=
 =?us-ascii?Q?ZiSnFtmkQs7hSl80LizmNBhCuDeyEUUm/YUJwbNapl8NqiaJ5WxX372w6gJc?=
 =?us-ascii?Q?W19BKZ89/2gHI8CKs7cpw720Ggbb6fU+e75AtEqa6NrQcU86kMA/2LAUibcP?=
 =?us-ascii?Q?LpyhvQPzWXe9/xbCYZebMWGb2eSYbbVUO2a4xvnHy0bCBl1Ov9QvwSKdzh82?=
 =?us-ascii?Q?YxNdE0hKce+KuKm/desnKn7kGwQ8dz1sj2dSrayf/W9lk7ZRj4XMVgXRNaXF?=
 =?us-ascii?Q?GF918P67OH7UXrIGqlE8E0j/kkzqCwekNGa+VxsGmpr0YqKa7cscfthQSwDG?=
 =?us-ascii?Q?luJ2ZzQA5lk90dgWx9p4if4XmjxIHAccdguwGs/B8+v3Nmyfc6QCEb/4fHiM?=
 =?us-ascii?Q?UyN2xSyopl748v3EhtzEywkj4sdx2uWZlSHdlImO1qd29YGXEZp6o6B8kt0S?=
 =?us-ascii?Q?QbVfhutPEmHli2gltCrMeMdtjiRF84Q3gjXCvjlRMLhmq9375Zt+/9Tn4Bqs?=
 =?us-ascii?Q?HdMC6slrS+3psm3/l+e4JxRDF2hb1rSrT1IzFngDE0Jog8OAvW1ZjH2T/ZHB?=
 =?us-ascii?Q?6zQV72J0zVAXF79/glE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d368f2-9734-495e-6668-08de1b8ef74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 10:43:18.0844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JxeR0ahvfWdE61j4FvYJ/e1jk0tkMKax9wLrbBqFWoKs2SxvjtJwFxkmkV9vw0Rt3S4lMf9jT6l8MBHFJe+tbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11689

> On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
> >> Thanks for reporting! I believe this is the same issue reported by
> >> NVIDIA [0] when we tried to switch the 8250 UART driver to nbcon.
> >>
> >> We have been working with NVIDIA recently to address the issue. There
> >> is a patch [1] we are currently testing that looks good so far. It is
> >> based on 6.17 but should work fine for 6.18-rc4 as well. Can you give =
it a
> spin?
> >
> > Thanks a lot for your quick reply, I just tried the patch [1] on my
> > i.MX8MP EVK with L6.18-rc4, it does fix the suspend issue.  Now i.MX
> > UART nbcon can enter suspend with `pm_debug_messages` is turned on.
> > May I know what is the upstream plan for the patch [1]?
>=20
> Thanks for confirming the fix. I will make an official post on LKML with =
the
> patch today. Since the i.MX nbcon-driver is already mainline, I will CC s=
table. I
> will CC you as well.
>=20
> Note that the patch still needs a formal review from the printk folks onc=
e it
> hits LKML.
>=20

Hi John, got it.
I'll keep an eye on any fixes you send later and verify them if necessary. =
Hope this fix can be applied to the mainline and the stable tree ASAP.

Best Regards
Sherry

