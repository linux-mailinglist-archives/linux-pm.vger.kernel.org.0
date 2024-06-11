Return-Path: <linux-pm+bounces-8961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D9990414E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0B91F2394A
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B9751C42;
	Tue, 11 Jun 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="j/cGtoIo"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2085.outbound.protection.outlook.com [40.107.114.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC0481D1;
	Tue, 11 Jun 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123332; cv=fail; b=bYVlIupdWfiEm+M+ZHU3X6YV2edy1+G/PiKcxrK+Ae0mggjh66iHqKobTTiG69T4Yw4FnTD3J5ca4T/sHarLDiFHc0QDb5e58xfWZyXsT00CX5NRbjDw60tC5sgd61MwDQ6QaRM2lQSfWfSOU4lIFUPpKmbWWwOC7kQx61ohtB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123332; c=relaxed/simple;
	bh=4HrnlZM2JCuF7066CG176T5FdaL8XY9G9U+vLFDJxfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARgkefuOWaqF0LKUpKKwOZJA5Q4Ial+mS8312Owd7T3c4/B4sM6YTt9htZwNYkE58hVUGAyLS1txhkcIk3mS9SB4hZs1Mo+jF9/ZvOgorpH/gyY0NmX4XVTqVWSEVjsus96yYzF0FgJQri0hrCBpbcIEOWTc68ItXJJ4m6yXA/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=j/cGtoIo; arc=fail smtp.client-ip=40.107.114.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYDOCvUgkkUxBwG5068Kd/sr3ygGGb6Jj1mfNJcgTcKxDGrwG/tph24RQieiC/eMjbTvDNaDY5crfo7/82Ta1rhR49LiFdgtMWagiPi4iGUZhpO0UdiCakv1Mw1YsZHLbllUJGVPu3pQTKUJFYogZJ1R/gKx9wwGyPiv+zt8PLokpAKrmp15c3ZzRUEg64BRbc3GDQB6VZLnwiFWm7LuHUdZeH6ZfTWJPBizvji05VL+a0fBlWjhOvtEC1oNua7b9cagB73W/gqOSm/IlwizLqojM59/4CI2LxTCtq662VDRa3HN4dP+AaMcilEirIyG0kovivK0CNKMFBFz8AOVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH7qLRygBTKjJIF0uJDwBLoR4BG3L8JEOE2nuNrFASU=;
 b=HfO5bHWywWqGTPzccNy7GiAe99DqN7Yng3ws8Ydl86aRM4K8ydebShQmKhpwUgwRs5yraFtpAJMa6RXIECL6ZBm8Cc0Ed2HOMOP5zISOK0ilnuDeMJYyhmjTabNku83ADFM998mIhCmplu/Gk4gxlyvlmSKxEoQy4LBrMfFvc0F0oN2mn4HCc5Q0ocYY3qoKSDZFfuvx6Ko0wCa9cJq0TFZqn53wfomZ3rgKNg+hZvii6xYcWktxfkdIJzwAiAb+CULq0sh34Jbfif+IOa1GqL4c/Ub/6xuWhNYUctbl00k82+B8WzpW9hPojFddOAMDmRguo0/zcoy8Ove4yRV1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH7qLRygBTKjJIF0uJDwBLoR4BG3L8JEOE2nuNrFASU=;
 b=j/cGtoIoUv6C03EqLCbYqMCTOht95UotXDEAAPOtGHOZ6lxd09Zw3UItx3j3tyfhCIAykoAbbZmnxMQ1ndkPz05xdnOaJOjpM3hEN4ekQRBsNhDIhpypalxEk00P8Lmc1kAkqbQwvJ99jAzOfYd97xjuORRxFkVWjf4tLIjTaok=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10998.jpnprd01.prod.outlook.com (2603:1096:400:392::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:28:45 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 16:28:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham
 I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] regulator: core: Add helper for allow access to
 enable register
Thread-Topic: [PATCH v3 3/6] regulator: core: Add helper for allow access to
 enable register
Thread-Index: AQHau+8g8jdUQb+BWEyWYz8fbD0DGrHCqBcAgAAUSDA=
Date: Tue, 11 Jun 2024 16:28:37 +0000
Message-ID:
 <TY3PR01MB11346B807820F681E7EEF7A6786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
 <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
 <ZmhmWrvyQiCzzeYi@finisterre.sirena.org.uk>
In-Reply-To: <ZmhmWrvyQiCzzeYi@finisterre.sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10998:EE_
x-ms-office365-filtering-correlation-id: 19e6c6bd-26b8-4708-f8d1-08dc8a338be5
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|376006|7416006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RQqbBLbFM1Ak+G2D73kC5dPvPJ6+1yI3Nqq1Ykz9DedlnqZyWltG4Zrojw2j?=
 =?us-ascii?Q?fB88i5zm4T7/FjScdc7Jy5dNDHZNjS1mQf4kwuueitrn8UlPWAPR+0PkIu2V?=
 =?us-ascii?Q?Y/LHvNF0dcbQ6Siao9+HkmCn4qib/YTtnaEWdRqAjQZQKVaOczrEcSFh7xLR?=
 =?us-ascii?Q?FB6z8CF8SFwdGCQn4wvzAdUqI7+0nODJ9AhA6M3ONBxNG9g6PMWbtPZllM8r?=
 =?us-ascii?Q?Z9KXKAjkUsg0vhYbXYr51rSAe34f2HS4q3vbHR2Cvdoa8w0TFXud+9igLwIO?=
 =?us-ascii?Q?q20PdI9cshAtDn6GdTUPe4JUmFwKeXC7z2K7Bi8neYJd1CR/NBnz75e+S3Uu?=
 =?us-ascii?Q?yztmU+8S1Ha105aaLuDrxSPnExA2PuwmyldFLROIHUGP4O/fqMlhndiWrmq+?=
 =?us-ascii?Q?tRwqlGGlzjMMWoHf8pBucn5bEVcZtsLWwsp9/bei5EZN9zGiBg5yGYynwHie?=
 =?us-ascii?Q?VXFYezQLzIojIcPelWCT9wV4xuVK755RlIbopaUm6a8qabgzn4YnHx8m1bS8?=
 =?us-ascii?Q?4mskZdm9BICTPJlpxevmZD51/3gR2cadqnFxPwmpB4Cl5AwXkLHCmzCvAtkz?=
 =?us-ascii?Q?47TJx3zbJ1b1kIy+sVTg+7ZuFPXmiVZ54j6sai0hXRBUHHa/2nmMdczNuDou?=
 =?us-ascii?Q?HhvYYF27YK6moxT2bNA8fjX5BxhvTb5yt5zEL7awtE+SyLQAfeIaHYdOPPhu?=
 =?us-ascii?Q?hnvmba/p1HbQ8kATubD9MUtU5aFmxff5rVNEM7+kGzZSKIUUXIjfIG5U50Oe?=
 =?us-ascii?Q?u2gKk7k9EtITgLR3iFzT4HOcluQQmqCIG4QQSvlDqR9lpUdCm03BRbwaFuLk?=
 =?us-ascii?Q?QETgcdq646CRodzIm6xbUV//rR7aq6h2sTfFDvsXzqvL9Vw0mxrNiGqz0UhO?=
 =?us-ascii?Q?2TnrPJ8RsfRuq/2aZVf7Cizbk+bbyJHz+nwrfqifNUdEhUagXUsxvGr3vToh?=
 =?us-ascii?Q?xswYHu0n/VU3X3c2D1/8eyRErWJvTAl309zfKNdEmp+stOmY5iknaP4v0slC?=
 =?us-ascii?Q?TUvQ59cLu0swcgtNAKZ+CYEi6rsNgjBPqmniBLwvn2pnBltkbahFoy5WJmjI?=
 =?us-ascii?Q?qIMdDuLToP7zxR+oeDEquSkEMWvr9I0E36bIVQ6gaoVlyNkKApIkV8Lhztx7?=
 =?us-ascii?Q?/z5Wgk4xP9bA3exYnxHFP+nIldc6Pl0qE6vTbaCBu+S0yrnHpba7EPnWsE1o?=
 =?us-ascii?Q?FpxNxMhQJlNPFEUgHElQgI2fjoYv5Jh2T6dztt/6GqMnRWKq+FZKaurcBvGz?=
 =?us-ascii?Q?2SXJliucGdTy/F5pUGthoLXkt+4llBvAHurEMHiH7CMXpErlBiDxi7mtkURB?=
 =?us-ascii?Q?QFK8eSWLZWaee6l7HJgTYbCRjgQNI+Mink3FpyTmwO5jKWXi6yI+FW1tRvO3?=
 =?us-ascii?Q?eqh+X0M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mjBzvRYFSgfCPnIFKOe6LGffTPHkn0VKNC014XEr8I+OP6Boi/FoisVMa5rc?=
 =?us-ascii?Q?eReZym5NiwwTBetaVJ08iTL7dc1CSQebg3GAbMfyn+K3BLBUv1wHAlScM5Q7?=
 =?us-ascii?Q?eI+7J/F588Xm6DA2nwKmdwW/zwWIREX8A3skbZXieLF/1Qe0N9BEgxiujFpd?=
 =?us-ascii?Q?/nzA0wQB9yfurzzftEIomsRaP8lpDGmB+A6FNjZcGkn/Y9dumoYPv8EW+jDo?=
 =?us-ascii?Q?PQGDFs2jbyfVyzrc0fo986YK0+6rvJ337wVKcPXKHXNXf47Bq1s364oGZi9+?=
 =?us-ascii?Q?oIqLi4aU0wcaG0xUOlDbak4O2vgz6HGTrm59lo1pfx8IqC2GX8/s71cwb46M?=
 =?us-ascii?Q?zPyMMf0xr8N5rTOqGyWQQbvtIGWDFIWUswhvmBe9hjjrdDilsyvTIS8dxsji?=
 =?us-ascii?Q?eppFBAPpPPq7cxmf9KOrpcLwbrSj5h7p4ZU7j2sQxiRKOZIZJzx41WUM4uGp?=
 =?us-ascii?Q?N4lB4vfLz6aCzY85BnMIT811rgfJJKYJqOet5EvY5UDxF1zlLHdX0qVj68dE?=
 =?us-ascii?Q?7VdJ3WMqTFS0HE/1TbErCLFXGC6zIwhU/tInB6CJM4/Ozn8ydlt5mB6E77/0?=
 =?us-ascii?Q?yjYtqCTAB1Hn/bV6RYJ+hwzyBdsjYP7EDQ85x3HVSqxsrfKmbTxO6az5WTXG?=
 =?us-ascii?Q?XSb07VV7ZaWVuIe5zRK+1pwiLF9R8PsxqZ3JGVXwQZ7BD7FX1W2yFwFQjShX?=
 =?us-ascii?Q?C7wcr8N/wINvl2yFHsy5Dk7fDqZgFBlMR+cvBlRj34f/JY88ik3RQO5TU4TW?=
 =?us-ascii?Q?/0VH5TgCepw3HynyYUbCoBoqXoVQ26iwljx20r8xGLvi6p070B2mWBPZB02L?=
 =?us-ascii?Q?l+ONeHrrjoP2lO8w63o6om/vRHxl9jf+SB2SaaT5I0BTHQbGlXRV8yk1AEZp?=
 =?us-ascii?Q?8Y1x3iCnedjjkf3Rip6SnPWaYgD6MwtlKXEqozpxbcSAesuwtt50H4B7kqdB?=
 =?us-ascii?Q?c+BrjwG1cGE/R5RokNo/EqnyOxsi1iFTQdkRxyla/4ALdlXccr1aoVZKl76u?=
 =?us-ascii?Q?+NHqB9MaN6KVBb9Vxv5mZAEij/KVCkAeSsAjo1ep3lhKeLlS6yUXXHj1XnRS?=
 =?us-ascii?Q?feZmfG6kTx9KDuskv76LnHvAHh4alqQ4K6geD/keaHEVrUSDSCTfa9w4vqAC?=
 =?us-ascii?Q?RJy4k1ZgE3OgEOIl7mjrP0oC9MFtZGg43bnb+KVrcl7dV6WH2jFno0GoHiDg?=
 =?us-ascii?Q?GK7ZnvP+BogNbaD41jpbHMjV4XkEtimJm9Og3u74qUOwBMIM5EBvCLJI9cCQ?=
 =?us-ascii?Q?cnRVogdJZXluG/BL4hEb6CYGLzyeUpfYaXAez7mlqzW+5rRaIuyFNkr7oI6J?=
 =?us-ascii?Q?b/eGvKIbZc1f4rL/gtbBt1EdvUjWaGmtFTo0EWAkVzrfirybmQobpH8LgFzE?=
 =?us-ascii?Q?V5Lvs3/u2VeMavIHEDN/V0x5DfuDHWiMb4SZmv2Z5/gl9Jh9j7NL7ZjPR2v0?=
 =?us-ascii?Q?x7m2hlrrpzgELhnPR/1VNZ0UY9kElf3nGwzVarf0a/7hL2zgswnEnVUmOaAt?=
 =?us-ascii?Q?mC+bkQ9yQ3nke340KtFW8b2VAIbR25G4LZtkbwE6dGePb468uCEdTsShDJv+?=
 =?us-ascii?Q?kKrjvJ0qJVuvO10ExTOf2bcrqmBZvz3S8Y5X+DumAixrG4hSdtimvns1a//n?=
 =?us-ascii?Q?Ww=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e6c6bd-26b8-4708-f8d1-08dc8a338be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 16:28:37.4270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GgT2uZMoz5VBpG32Mj5y8pc63j7DDl4yi8hb6Tl4BdGanD2IqWU72UsCTB8HRxZJwOO/d3YS5VQI7YxFVfHr2t/TgqyZElI0V2JuzbeqB90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10998

Hi Mark Brown,

Thanks for the feedback.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, June 11, 2024 4:00 PM
> Subject: Re: [PATCH v3 3/6] regulator: core: Add helper for allow access =
to enable register
>=20
> On Tue, Jun 11, 2024 at 12:03:59PM +0100, Biju Das wrote:
> > Add a helper function that allow regulator consumers to allow
> > low-level enable register access, in order to enable/disable regulator
> > in atomic context.
>=20
> > +To access the hardware register for enabling/disabling the regulator, =
use::
> > +
> > +	int regulator_set_hardware_enable_register(struct regulator *regulato=
r,
> > +						   bool enable);
>=20
> So, it'll doubtless not be a surprise that I'm not thrilled with this - i=
t's basically just
> punching a hole straight through all the locking and reference counting i=
n a way that's just
> begging for abuse.  At the very least we should have a check for exclusiv=
e access in there.

Do you mean exclusive access by means of spinlock to avoid race between ena=
ble/disable()?
If that is the case

Option1:
    Add a spin_lock in struct regulator_dev and add locking in regulator_xx=
x_hardware_enable_xxx()

Option 2:
   Core calls the callback for enable()/disable() and driver handles the ex=
clusive access by
spin lock

or
Please share, if you have any other options?

>=20
> Also it's not sure about that name, if we were doing this it should be mo=
re describing the effect

What about the name regulator_hardware_enable() to make it generic??

> on the regulator rather than this happening to be done via a register wri=
te (this should also work
> for GPIOs...).

Do you mean to make it generic, so that it works for both regmap based enab=
le/disable() as well as
gpio based enable()/disable()??

Cheers,
Biju

