Return-Path: <linux-pm+bounces-13205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A1965970
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33ABB23A10
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B77016CD00;
	Fri, 30 Aug 2024 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="eAd/QSq/"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011054.outbound.protection.outlook.com [52.101.125.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1A148827;
	Fri, 30 Aug 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005192; cv=fail; b=CfLGVMgAJDuZorETsi7qazAAc+0XCfE8XJQLkyo0JUP71M+EogJVMVFWkREo1OnF+WibOEjGicaPjoMyP2hm4cHOR61fKY1OGm8141ZCEf9wrPVXKWu1JFO/zWsHq48k65LtaxQPawBoSHSzVy6T4orHEiSMNRpxAcPOwaoujJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005192; c=relaxed/simple;
	bh=9a7ldjUZw1M22M5VBcybOwT69NGeaNbDAEPQuF0BUtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pH4O2dyiJN5DJWVrNwEMsFI5ase3vvS4yqSnjnNHYTWV5QRuHZueBNZqeDrsdap8wQdRKoi/hB0/K5eHvSrs4UUgbTCoab+HNKyhsS0LcrHJa1KnTQs8PytFV0KVkdV70N7LBQaUdN1FCvaSu6JujwjKhkEy3gSAV2n7BxkpVHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=eAd/QSq/; arc=fail smtp.client-ip=52.101.125.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYRQaxm4jB3XM/TUjIdlBNvJKlSoNeJN/mxIjBCDayTC22Ee664Od5fgoCeCYqGHnE3rHd8mPjFgA1hWY5ohvILArlx2WUlWvNghOgHbB6inaePUAHPWTS/DfmJnq7vDJPYwSEXxN1pBbq71EMYcPyGxdcwr4T6BukP/YlhJafzRWlB7Knxccu9G61LM7Z5ByK9o9gN6RqYC5d6pcczunzO4L5eLjO0vkDBErB7juLwV/VXDTTXkYA+HAcavootkc52D/JPEAXhADd9MK3jpzLYG16hBnyZHVh9H3DIB7rXXxe/mOglHVTzcCiDAfBSdqq8yykVAcollNlmssJo51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a7ldjUZw1M22M5VBcybOwT69NGeaNbDAEPQuF0BUtQ=;
 b=LysZ72xuKdoCulIiHxCzR0j1uqQrOLhRRrzQrPaq64J9cNqB/4ApI3vuXdociX9BL0b99JWjsl4y1OhB6SGI21kcqSzQ1hIRkWz0QyVYEyQZOfMlmupeBLP2wRh690sUZ44I7FVXMwsVPui5IxixPPsJP1Eo0+MxuWU9OU07SVkl5pz5H3scYmeqQt0QQe/WiFUvvVccZS/n2ENjmQYhX3lpCueCRF6UvYAoFnNirhJkfRrqN/FRpRJYV57sMUh8Krs6b8IIKIxTTYb9Q4uc+qvQISYzHzPdBTLzZ5thrIVZd9MZwkXhCiH9+cQqd9xkuxpryboja0os9C+Bcnb8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a7ldjUZw1M22M5VBcybOwT69NGeaNbDAEPQuF0BUtQ=;
 b=eAd/QSq/Mz2LKEen6+ANJydaueu6DkWsi3z32nNEVUZL1pnPR/upd1qGELsFIW8ZU4JvViXmLa+sfgM56AiEoWdX1BMdpEE4oz6HxesXT4t3lRGSJ7w8L/gOBf1d0x/ZNxqharzyTR7mdR7mJ5lVYAl16cqlYu9zo3HzT7nLIC4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12825.jpnprd01.prod.outlook.com (2603:1096:405:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 08:06:25 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 08:06:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Thread-Topic: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Thread-Index: AQHa9Kf4PPM3ttIrIU+GFs1JG0RdeLI0cirAgAAZfgCAAABPEIAK8MEAgAAAiaA=
Date: Fri, 30 Aug 2024 08:06:25 +0000
Message-ID:
 <TY3PR01MB11346AE72983D6E3749AC8EC386972@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113468A6CA4ADBCA577670AD486882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <8faa6b6d-a013-4a71-a8b7-af02ac92d94b@tuxon.dev>
 <TY3PR01MB11346FBA77256F2156D374ECF86882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZtF8rtI7e/7cK4BR@vaman>
In-Reply-To: <ZtF8rtI7e/7cK4BR@vaman>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12825:EE_
x-ms-office365-filtering-correlation-id: fcb5c223-6471-4917-43a3-08dcc8caa4b3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/gJKBM7KORLkGBVw22rIhGT0K2Kk+ZZC33Npz6TJA4GDfS1MIal+eJO8RV0k?=
 =?us-ascii?Q?980DnraAmef+/H2+m6pkIUszaNKwqhZ4Fcxag89YEM87jlAsXkLfTDghw7aS?=
 =?us-ascii?Q?alBaR8Haqa96nLn2U+W9wsjId7fE4btVEmbI5vKiLR/4JLXKLO6H51C09E04?=
 =?us-ascii?Q?VCRrcfnPXhlkoDxBJz+IHjt2oCDd7jmmJHGEmkxpIxY7CC+hanNukCAGitNX?=
 =?us-ascii?Q?WR7DDBbgRuTPxmKyxoSi4Md3gT12oNtpMy2BMioeDrQquXdv92/siFToP0Q4?=
 =?us-ascii?Q?TQbu7rnNYsA37VN7va5QbwLhwOOEY7bbp+Twd4gaoPYfASSu+zW1iEkuEmiD?=
 =?us-ascii?Q?4IVTZfkHiaIra1+MgYPahhbPgb8TPQ+kf10ijjkHdzxcZzGeHTQu5gp2hhnb?=
 =?us-ascii?Q?SmPqnsduNNHEC/dJh4s/NaL7JwZJEdqNQ1rzX+VanN01XlV+7+ZmmiLzAgbw?=
 =?us-ascii?Q?K/tcYtRaNbFFi39VezTJzjppW/Ybs1r6Ikt8uWZfBbQhF5kVx2d3b7JxR2i1?=
 =?us-ascii?Q?uJRcINKU4ccYlRcFx5Gxu+WwDBzjmrdWiVLduwK7VGxrtz1vmmkt2qevN/qN?=
 =?us-ascii?Q?mByoFSfXAKHFU4vcMvbC+O4ddyUaudtAsNK8FDTsoPEH67g6tXC2uU2SiHcA?=
 =?us-ascii?Q?I53ChU41z44a1H/lef1lvleR4lvt9fdnhENESWA8UyJbzOhpHpdsuenn+x4o?=
 =?us-ascii?Q?z5XA0gePyP3+7TQZrD/WpdDfe4L90AdKXAzqMUsh7RVyPXFg9I22VHwl3KyR?=
 =?us-ascii?Q?EvcrfxiJ9Ko7UukGmDewAJU7WfDjzN3sglVFADdkRpGIKRHAXZdIkwijPCn7?=
 =?us-ascii?Q?NbVDDPdVwpOzwzbwS73aMPZ+B6+iiYFTLOptRGV8o0AU+Dy7GOGXqzhNh83a?=
 =?us-ascii?Q?YI9EEfo12doryZ7lZIC4J70wlr4KL0A+N7Sks7S0Y7vVuhUK29isfA0daLye?=
 =?us-ascii?Q?jrI3UDa5G36i9LbuP46vV7+kK92s7cV0Qn873nkSoETUQsfY0B6OYQhtu1H8?=
 =?us-ascii?Q?sizQUuHBXV9aVgssemddEY68SJzuh3eKyGlVChcQ5o8oJolSN8GbMUbKHkuN?=
 =?us-ascii?Q?ppou1HQWdGBzzIPdaycDT+gYhHSMjnTLy17XDo6kEQ5ISst6Y6pTeU0aMgbl?=
 =?us-ascii?Q?J/s0QBy3p40Lb9MDLwysT/Ttd7ao06+0S5iEdvTbTPpGtIL2sR1Q0rmizJXB?=
 =?us-ascii?Q?G7fCNlqej2BmIFwGzMOYnkZxAbo986IT1omK8qVhb0AQ09QBBnvsSAT0K8Fc?=
 =?us-ascii?Q?uJJAYGyw9ExiRl7XeTbdqnCW+NkNROloOzt45+FvaoDZjpT7ZvTNWrd2sD0U?=
 =?us-ascii?Q?OD3qwqB1kCNfrquMeD1A3xcWC7o/VuXEl7rg4Dxj9MI/8kmfLbeYYzur0XGc?=
 =?us-ascii?Q?wBcYwxQm4CUTgouqw//Wl/R28fG9MahMrBAbHv1lAWVCpVJvBQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?it+Kb6gaqnDv2gAgPc4FVI633Zz1/PdBJpot750Hmn+jnshA0o/vzar0UZ9n?=
 =?us-ascii?Q?FmFLxigmJuDbIZjwvnVm2fjfvBqasFBlXsL3KJsfgJLtY6ZhpbEDm9YJu3hM?=
 =?us-ascii?Q?WtUWRUPwo5cw2y9mGcaYGfVbhwKzjdj2ZbF2EbH8CXe+lW2voFLXDHVJREOQ?=
 =?us-ascii?Q?Qk5Vo0X/wXHH6h6eOhDCXVGRpczQSxz+aUVREbrlz45iC7upZCalGo7T2r0S?=
 =?us-ascii?Q?BG1tv2YLLOEboIVdcCFE89g0WEh+R8LTsQSPkRyWlQWvVUyXrd0sjVJPWeWm?=
 =?us-ascii?Q?YnNJ+Y+6rkc5UYRI9VTnRNIyKMhAWZ3f+S5JF6Rdjq2Cyphdo033sL7DKMi8?=
 =?us-ascii?Q?nfHISU3QsKS4nJx0rFfMKUnSCuQOCMRIyqlVdvVRA8Al4xgq2GKKht/zxpCS?=
 =?us-ascii?Q?cVzUX1FHRBJzvSUfLIOZRfI1bBBjFA1BqvZ9DX8JlW7dotgfw+9fSgbIosC+?=
 =?us-ascii?Q?RzIdfx37Ipjxwoh2ZN7Vj9Ep8sfdkv5/kPoZAkNuyvRBlSXN9HneSS1z9lu/?=
 =?us-ascii?Q?HoGJpK1HrhAEtEY3HhoRqkWTxe9MVk3oH+u35jL4mlniehx/gKW1Hx717Z2H?=
 =?us-ascii?Q?sVlWm1b43+3IsEy+Z3jZJtzBZ7PiXeEa8oHdyHiKLbvJfonebnbTazLtNpO1?=
 =?us-ascii?Q?79l2r0h30ymSPTDryeMU4mLwwF6JprKo7xj2TUaRgwCu4UDBjJ54uFRYYGAN?=
 =?us-ascii?Q?qUWJeaMlKRLkG49PkdYuWNEgYzvZxtsZcO1t6tsQXrou0eUj1DM3YcJlw7G1?=
 =?us-ascii?Q?+pTwDydg5s7R/z2Yl59HaXrjJb0wx8Xul4Qpm4jHUwUWXASmc5eUNuh3YnRm?=
 =?us-ascii?Q?DVatyIGFdA9axLJga+LTpZ+3s4CiH2RgkmoFXoYKik8s1qIX7DLi1d+QnENb?=
 =?us-ascii?Q?DXWOiwaHbgZ9DZxp7pAsR3YV44UMmX6zsbanfa6ZXxVmApNWM8y+4O9NC2+A?=
 =?us-ascii?Q?V/i5f4SeYY4RErWAZnuyADKBURxoiPZWm1/RtfbhtU8a3NY22yxQwn9+7sud?=
 =?us-ascii?Q?a89dQFVK8wfEcrxa7Oi+q/hahBxoPZwiaYzCqRqXHHW8gDOtyE+zWmTDXwIJ?=
 =?us-ascii?Q?8pGr95v+wyGuXTsI05T3GZYtWP3X3YSagpYFogJiTgx/zjIuat6EPx/HbnZJ?=
 =?us-ascii?Q?Yz7dBN8Keh3jLtR758RoFpvRZvyy179bk+ST073wkMKVCCHKo7YB5NnjTTFN?=
 =?us-ascii?Q?5QyOBeJizulxg8/gmw0+F9OmoqM48E6f9vulYLbqfyszyLDnmGf3YE0Z0f5z?=
 =?us-ascii?Q?57AhlU1yGiEnITyFeXvdFkIRxOHFnYziDUJ0OYr4piRQ4E+A690kk6M/DQvj?=
 =?us-ascii?Q?Tf6/GPwnVKnHEUkUgiwEcWhhvjw397vZ1ThOzNDtASAPp5ya4g7XLXSfFRw8?=
 =?us-ascii?Q?d0a5r3p2wktO2boNTklkEHFUMd32Ua3+0BjcF7+YyVGVWLWs2F2h+61yRwTo?=
 =?us-ascii?Q?H8zutcQmtC5IokC6LpSAYAzjfGuNA39VzeyNhzO+MnOWteKazd1fK/CyAuyj?=
 =?us-ascii?Q?dQ3UD/GcoekVZ3xKlcsKvrLQJcg5mt+EufvZemVsC1LyJkdTP3xqBH74TGU2?=
 =?us-ascii?Q?8G1jMUzgqwE7QTDsfjQ7f6Gr1aAqohR22rxIYPMeApWhgWlqrAih33uAF+rC?=
 =?us-ascii?Q?dQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb5c223-6471-4917-43a3-08dcc8caa4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 08:06:25.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfREIIYZl+ejE7ilUKhGD6k2P+rwSnsarRDIRpYkXADY1ONiqtKqNqiXgJNXyBfVEGwKz236cCj0H4bzadDHAsRSAz9wtqyeRQPpgdWdqmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12825

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Friday, August 30, 2024 9:03 AM
> Subject: Re: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to i=
nitialize the bus
>=20
> On 23-08-24, 09:01, Biju Das wrote:
> > > >> The Renesas RZ/G3S need to initialize the USB BUS before
> > > >> transferring data due to hardware
> > > limitation.
> > > >> As the register that need to be touched for this is in the
> > > >> address space of the USB PHY, and the UBS PHY need to be
> > > >> initialized before any other USB drivers handling data transfer, a=
dd support to initialize the
> USB BUS.
> > > >>
> > > >> As the USB PHY is probed before any other USB drivers that
> > > >> enables clocks and de-assert the reset signals and the BUS
> > > >> initialization is done in the probe phase, we need to add code to
> > > >> de-assert reset signal and runtime resume the
> > > device (which enables its clocks) before accessing the registers.
> > > >>
> > > >> As the reset signals are not required by the USB PHY driver for
> > > >> the other USB PHY hardware variants, the reset signals and
> > > >> runtime PM was handled only in the function
> > > that initialize the USB BUS.
> > > >>
> > > >> The PHY initialization was done right after runtime PM enable to
> > > >> have all in place when the PHYs are registered.
> > > >
> > > > There is no user for this patch. The first user is RZ/G3S and you
> > > > should merge this patch with next one.
> > >
> > > I think this is a matter of taste... This is how I usually format
> > > the patches (for scenarios like
> > > this) and got no request for squashing.
> >
> > That is strange for trivial patches like this.
>=20
> Splitting is better, this patch does one thing whereas the next one uses =
it adds in new device, i
> would say quite a clean approach
>=20
> NOTE: Don't quote the not required context while replying, it is good mai=
l list hygiene

Agreed. I was wrong then. To support a new device, bus initialization is re=
quired.
So I thought it should go together.

Cheers,
Biju

