Return-Path: <linux-pm+bounces-36228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758DBE21B6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 10:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025F73AACA4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5CC27464F;
	Thu, 16 Oct 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="opTic0Ox"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E714D18BC3D;
	Thu, 16 Oct 2025 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602516; cv=fail; b=PiL8A0x4Zg3fLaAOrX94Af/Ps4mq4tbCVzH/8/rREbWPHWarN3tBUsRpa2MvE+ZydwHTYHtbGh8yFudQC1AZIydBcjvtVsi5Mb3UbcetmXBfHRIVWXuoOaeYL3du1CAWk2ZG0ti33i5OwaCEkHWLF0JFNTC28e7IDwJDNuKWDdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602516; c=relaxed/simple;
	bh=kVdeaQDJTu+M4qTWie3p8H1Q3OMx8xy2T+/mT0yLg1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=reRFZ04Whu7zIBF6NYgAiONWLVFUnZMIcnVGWn0t/DQzC11v++M3vX1k06WjrGaTjsSDdlHZJWuOCxWGQo+MS58bbRdIeFMKJxU/5BsRGqTVBqzNX0gI4pwORxHDyi+N1wymEwJCc/FEsYZrlceYqmAIPs/GJofPM58e3Hp6rvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=opTic0Ox; arc=fail smtp.client-ip=52.101.228.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZmXXkhf63vw96Y+hDSwQjqHl3fIVeit497PBOXecqKcmpTgXNufaO5xR3ltjNBZx5991TtOJfe5Yu4hvuUjjJ5tlTL7MNsTb4ws4Ia8Yjb9/QERurkDPRwWQAty6ZvHRq5I/omhqL41Af3HxoKdExEiDWlfm3fnUui6lM7v1lu+ZPQWs/xEHtL/HlvQo7Cv5rWzNfXxKfcn/t954+Z6hvp3yLe1ITXGWk3AEggjsu2d223lzvjvlLDe91ZnRwt95Y/BYfB8Zr/LQXVN+2YSOXRWKeKUqhFy7JeMB0bnDRffMT/UlwOsstkseDAwYPjocffM0fW3QX0bJThjpRTXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVdeaQDJTu+M4qTWie3p8H1Q3OMx8xy2T+/mT0yLg1c=;
 b=T+3txz6YsoaSTEYsFsuJAW7RNjV7GuUQ7lkZCXrbQzpYSau+FCiMF1eHjI/1Sbv+RUBtUB8D5Q9nYb2fO9phJvL91Ouk3K9lFVbdfa65l/fhShsKo9e7D0NVkoZj1bJ9+9x9S/y2SOm/LH2UtiZC3IqW5P23WtXsJTlHJRFuoaBQC7V88E5ThXNeVXSXKGigEN2uaJCZuUNO3aofWGXA9aHVh1NBvH6yyPgaVkTfGtydjZEGGJanNBdepbXqemob6jlnMdB2hNbO2BLKihER+hYbGihMuJN1W1qjQNobiCENXjOaJVwPzwqoTioXr3Do5hNuW7oyIE5Bld2pzWtoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVdeaQDJTu+M4qTWie3p8H1Q3OMx8xy2T+/mT0yLg1c=;
 b=opTic0Oxe2/EABevYvubiuqOcZBdzCAk714YKx4e4yv+gG0AiRNqc36S18NDPSQvnzs7bsWAjkGFvWAF1vFG/lyBxJjM4F4nHIGglm1iNwyuhTvq+S02rjEZGYv2VvJsyk4TmPpBj4NozLwEE7vVCu+fP9MdL9zAQTUp6KEO0tw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8635.jpnprd01.prod.outlook.com (2603:1096:604:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 08:15:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 08:14:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: wsa+renesas <wsa+renesas@sang-engineering.com>, "marek.vasut@mailbox.org"
	<marek.vasut@mailbox.org>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, niklas.soderlund <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Lukasz Luba <lukasz.luba@arm.com>, magnus.damm <magnus.damm@gmail.com>, Zhang
 Rui <rui.zhang@intel.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
Thread-Topic: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
Thread-Index: AQHcPey366/c32c9J0GxfZcLKzkux7TDe60AgAAHDICAAOekAIAAAr/g
Date: Thu, 16 Oct 2025 08:14:53 +0000
Message-ID:
 <TY3PR01MB113468C08443256EC6D99209386E9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <aO_eLEFLAnjc8n4G@shikoro> <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>
 <aPCmZp8sM5oV2jPa@shikoro>
In-Reply-To: <aPCmZp8sM5oV2jPa@shikoro>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8635:EE_
x-ms-office365-filtering-correlation-id: 974f62d5-44d3-445b-e6ea-08de0c8c1613
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fQrKsT3wn+H9VfPhsjFGDlF2DZkoULgvIQy6FvqWJTUwnFq3EgIOU9YzdtAp?=
 =?us-ascii?Q?1Xb+WZDXrYhfPWsQPjxLIXRJJw680ojKbEnHAJtc9MV4VWrWoYBhjSMW4a2S?=
 =?us-ascii?Q?9h+EnH6y3XSvyrrKZhOMXVOJoyOvEin2OSMfSPja9yHxjwoVxDF/k/Wsjnaw?=
 =?us-ascii?Q?GSrkaqTk7EkQSJVZg93NoF/jLc3AbSs+VEXXnW42zhIBZH5+2eklHk1V+Gig?=
 =?us-ascii?Q?kSSzt0bN/d741YmrWwz27AMfn0qdgIFE+u0QgvdwNfI845m4rOe7fso8hEaH?=
 =?us-ascii?Q?9+trD/s1XkfPwdHfs5e1O/v1RKUk1DFWBHbhEUgBiMN/ni48Cz5vV8joNzhA?=
 =?us-ascii?Q?fXDOMaIrym592j6FzSUJezM24l1F8yaGX0CTOCnQ8EEbDf0hDBePu2HgjG0s?=
 =?us-ascii?Q?EUdKpJuJrWE13fRuFFWPBPlfyViWVX+7f2NQSDeYqN8l2hD7eyCisboMgXdU?=
 =?us-ascii?Q?97Zcn3EcBXa8WdLDB+tGn9wU7OIwS02hAv8chf85QnzNKY6mHI6I3sOa5dzf?=
 =?us-ascii?Q?1klj7FrmYQX81VKwcmkFwfkBXxeuJtYa1FVHFIrikn10c1WN7NnTQXF8LN9D?=
 =?us-ascii?Q?U41KPZRIAaZC1fDoNEQgtq7J+TTo2+pg5N0aV60LVeg+DbP4wlFO4G3BqVKY?=
 =?us-ascii?Q?dd8BRffQz8dSnzIn/UTFSawzhjcR5m+Z+cmXYmSGVB6HCOO38D4kb2ynThyp?=
 =?us-ascii?Q?kAhJJioF1jAdm490hNLfhdYFniuC/5483EZemcIQv3T216C/T4MnUmcjRinS?=
 =?us-ascii?Q?Tkdf9nSmaLZdxwAHyN+ZLkxPpM9iMK/zI/UPfQfmPY26tJc8DnjTq6wOT/Ha?=
 =?us-ascii?Q?zUQM98WZjySoU8MVw/8JSN6N2NXWWWQjVHtKLFvkTBIH0z951xD7kOfqsBr/?=
 =?us-ascii?Q?YVfgn4pXEJ+inummqDwNv4R/jCydfq76/R35UIq7b7d1tEn8r/+VpLIxFA9Q?=
 =?us-ascii?Q?+9sojd7SHNld2RlX8X1MZrJjtnpZuBCdKnR0C1lIkK3K1ofKLPFx46j8OPCE?=
 =?us-ascii?Q?/hGYcn6DYm7pfBKm7OI43v4+2+Z7zhvszsdIjD5CkuNfDjuKpuhvP4eff1BW?=
 =?us-ascii?Q?g/FU7ZjBsq8AZlGg7zImwqeHxCf52YHt1FsQQtj8eDM2wAa89SeW2ctGCPUa?=
 =?us-ascii?Q?7JZIvy5DJniutn0pbW/ExwDeMx7XyvC7J+Aq3QG7Ogaow0kigizF9PjlC9de?=
 =?us-ascii?Q?S1VnU7ceWlmvB5mG34ezHOx3PqfpQfD+b8eVeJ95yeMqS4529vIqhVc2tFZe?=
 =?us-ascii?Q?M9vjWxLwxkBJh4lqrIPgwYtPkWHiG4njmOhuOZaVyr+/Y5YoEbn4ylbpbyh0?=
 =?us-ascii?Q?lhBB46pMo3Wi/sbJamPHBgVZx4wqZmvyhE3FY7bUKrqKoIemKrDxrm6wW1X6?=
 =?us-ascii?Q?UKA3LSpTGhIa/KVoxZjCmLoMnJWsjyDrYNXLmp9EL27PeQwQaGlCe12o3gMI?=
 =?us-ascii?Q?a/7KxhSl9vCA7U2Ck/48+zoLqP1KkQg9QQuKrD12BvORDIA2S6MCFdfN0tYh?=
 =?us-ascii?Q?eDJXBYPwVXDpukHpAlw5fFieiOOhQx0TZGkK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KK3Rc3WWR3NZ1+GJa8eeEKK4YJUNwiGRkLu5vQ2EoA/VZO46uFPvH9epTc+G?=
 =?us-ascii?Q?Ic0RjEN+BpvjLq7N0R0Whd9RoFhNXirdvbFKavJA4IbcMGTzYrkssWBI0H+V?=
 =?us-ascii?Q?Ka8tQrK3bO0uoP9hMXRzU6L2LMXr0ZynSUBou6HVlmR2vv0dIycfv8IhFhvc?=
 =?us-ascii?Q?YySnKgFccdQCTDtvvIqYiTfslQgiIOSISc+fZjbV80Afst4XXGnEVi3lQGYI?=
 =?us-ascii?Q?p83r7otu/HNrRmiZOJtcJiNjPZh/zNb4r4kHjQyk3CSDqWnQBTYcsOksb1BB?=
 =?us-ascii?Q?VnZyV7/ux9gYApi6DkfV0G4QulVYYRBueQNWFSW1gLBQNu8NUdJF/BmjDUhp?=
 =?us-ascii?Q?Bc/roLoH3v9pM90QZxLYytwUo9N3p158L4IVHCbdXudKppqPsBmYPehjxoXP?=
 =?us-ascii?Q?0Y5FchfNh9HYOaH5k/PyZmuHvbF3MgYKyeUzgBEff9mS0avUFexnmUeKV69F?=
 =?us-ascii?Q?jnT9mevZpa71YsaQAROJVnSFwIgl64BEZu2PyC7rIWmIh1FKL1GeaPnO4Gyb?=
 =?us-ascii?Q?88RdvZc91XvhTfNwyy3VtRZT34p7O/lRmc8QFIXhFf0gq59HLSqaZ+E0bkj6?=
 =?us-ascii?Q?K2awcxh03s3/rO3rkpbykhcHCFL5IGYg5Vn4yVtmCEEi4YIBSolvE5TQiSkW?=
 =?us-ascii?Q?YDiG4lwtP1+b6Uyc5bpGpQ/upFLq3j2y67Ag+MyzbHEsNdhucdABq6N5pAFQ?=
 =?us-ascii?Q?3tLHQttmf1DdZ8L0NznArYcc34LIbr4G4USBjA6h+p7UwQKc0wSxR5dPsjZt?=
 =?us-ascii?Q?vjPQVfcyoPiLLh3vGpUctcdq0rTkwGJf9+l7c1HQPiKmG3aeHAEZzgJmZqPR?=
 =?us-ascii?Q?VJ18x4ZYCnLFi6BKxZnfdrQsm1nV1wlfNpOgErDocYVuzseD+zQc0hl2wS9D?=
 =?us-ascii?Q?dzKmqi6EBju3lbyD5QOtijsXN+klozXcA59lcLlrWanCdLLTduKc7DFOEY16?=
 =?us-ascii?Q?7xJPwNnlrZVT9R+7jVWkxQQR9bTkA2wzuBMVULzQDTJE0hAT6IgJS6OoOENZ?=
 =?us-ascii?Q?gXBTcyCyFOZfiiVr5NK4zUCWAgpGPdZWo4oZtbv6y0YKAEwzR6QY2GlOPiGk?=
 =?us-ascii?Q?VkP0YbryDdYzR3M5uWQ+l5U5Js2JL7IcL8ZDi1hwa2PPQD6vIiyObOmMKi3R?=
 =?us-ascii?Q?jiDKxzgNKH705E9+XZ/fzwZZv4RmQOZTUZ5VhYOrqPlcOmOaOptodZVfKEku?=
 =?us-ascii?Q?8zLUMfxmccjHpzEZS6zwvEN60O8+/Nx+oHMRIYtfMvkQWvbaLnUIremifnw1?=
 =?us-ascii?Q?oRuX804CLw4+Qyi0Ps905K+24VJNKagYh3SNINnTVCIg8Wh5i6Ue2RhTINFO?=
 =?us-ascii?Q?GWQPRTKPZDpTwjtRafQqHhFmLHHt1V+ipjb5R147OtQA+m2rN5s7Oc/nGvgh?=
 =?us-ascii?Q?eNR/kwLIb8ZCt+mPa8MjI8OGe4sLFA/0rVmeXf8Ux4pvnnpoXzX1RzXiieWP?=
 =?us-ascii?Q?flt5YvAibhqaXcWENwkbh//qQu+EM/SSZZODS3E/g5sSj8vtTpv5/Tq0TtwR?=
 =?us-ascii?Q?GhSpV9Qv3TyMne3S8VU7nciMeo+mZb0KefsEMrqIv+r0dGp0Np/Uvoix3PvD?=
 =?us-ascii?Q?FSreYhX5UO5wXZJ+U4ptoKCSv+BZiL4iuF+yUqWq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 974f62d5-44d3-445b-e6ea-08de0c8c1613
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 08:14:53.8491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0NQmEV93J4J1bM8yOBfHuwzC0b+Fgj2GACYtU0hFNo6aMf65uWEsMTxB4I3XFUI0550SFeTOkTJygBVehP3UHnVRsMlpqBMio61BMgTEUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8635

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: 16 October 2025 09:02
> Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 an=
d RZ/G2 support in driver
> comment
>=20
>=20
> > > I am not opposed to the patch. Just want to mention that such
> > > information gets stale all the time, so I would suggest:
> > >
> > > + R-Car Gen3 THS and compatible thermal sensor driver
> > This won't cover RZ/G2 which something else, and Gen5 seems like it
> > will be also a bit different, so maybe the list is now exhaustive?
>=20
> Sorry, I don't understand: If RZ/xx THS is compatible with R-Car Gen3 THS=
, why is this not covered?

RZ/G2{H,M,N,E} thermal sensors should be compatible with R-Car Gen3{H,M3W,M=
3N,E}
But RZ/{G2L,G2LC,G2UL,V2L} uses different compatible.

Cheers,
Biju


