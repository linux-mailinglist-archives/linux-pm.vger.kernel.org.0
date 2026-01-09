Return-Path: <linux-pm+bounces-40535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D7D08DCC
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85AE33025177
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 11:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DD33CE8C;
	Fri,  9 Jan 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WRoucGPE"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011066.outbound.protection.outlook.com [40.107.74.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9B33C53A;
	Fri,  9 Jan 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957734; cv=fail; b=VSAkWiLtS9vUX7556gLZJ6uTlH3cA8fN8G1Anw614P4cVNo+y4Jlhtzgipwk5EQLIokw5A7rYdC1GtU+Pc+oYDzf47kQAib2IGJQdsuwOeO8YPEJIuUebw0SbXGP3YvKWKPXzLFpqeB3SEVt+8t3oB+EKLvd8jeXrgMSF7+sRiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957734; c=relaxed/simple;
	bh=IEy43GZCtkNbWiGRExoKX16gNUX131y4DHiwa+OmJnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+1AfOhiO4mPoFq6x43dupttcXyxuiVlaKkIXwhvo2hirdHbF5/In5KXVVZbBswZyUS3fPLHhNHxZQNLCaQ0cZiMWlI5NbjMwT96YJfJn2PgciTVZAH5wfAKj13+EpVJrELhSd455IBpNWwLvt1nqX77KmdP+kuQD4rO9WKzFto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WRoucGPE; arc=fail smtp.client-ip=40.107.74.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrAZqnhWUf3bFzQjWW92zjcB5vcriiqRUwCPr5fuZbQFnmaM59Bc74Amq1L0iNK6wTxqMPMf+fOEml/EdejuqVjdK84+NSSPn54/XEKT9b9zgzQee2hh6P5Sg3SwKOteHIknzGHE/hA1XiLUacZ3g/SyiRJEMJh5bFPVm9gWuBfrF2iFV1jTkcXS+yyfSQeQtaL08o65An1mSVeYG4q53apObiwuKaN7JKSNg+FsOxvoEr3XVVMQojp6S1ulGJnWptU9efyTxHcOxkaQJL+A7YucOHK0rwEoBLhBiL/xUP35WgfDCGVUB0TKS9EgL5p6WmyhSnnnYd75xiex1zAX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4+QkqJm/aYKIEJHCUNL4hni6Ved5/8KJGd/3PRglOQ=;
 b=Gi4qqSP0odSyx2u2L29p40pjIeA33Ka7EGLKNV2B7Ek6ZJWyRD+bfuXoto8+QFAWAJgripr8dLE6rytjePnh36jYWDRJOmYB9kqWYTII/FhcJwWOpV0DGZVChnsz08z/EqPPhFFUzqJfEiu7sWVmRtJzF6xpS91/uvgHONOzIm1YTnhRYq44KpX/YdgQFaQ9hM7y5b+Tb69T/t2jGpgWWfONhz4qeT/Lt2d8wioEaaqvW6imPLOvAWo+Zy1zkhAdr0Z2n6GXJ6LdWu33j+P83O4qIfZC3tbt3w0uYOETAiHn0aIlSfQUhiPDH/F8s5yU09IZDw6YefFm4Cf4dE6vAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4+QkqJm/aYKIEJHCUNL4hni6Ved5/8KJGd/3PRglOQ=;
 b=WRoucGPEVr82sJYH/itOO4TkYqOTS8xhLPYTNkFXnoun1cvij5pw0TPUIlp5NCHkwtJKajxqSNpE0OSZO9KqmuMCiBKjYHef47VIobVPGUwOqAiMfIkLcrwdhpF+JjEg6zG0/QQoDIw90NkfcczZXweDD9wvkvTORNtFmaiFyL4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB15951.jpnprd01.prod.outlook.com (2603:1096:405:2cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Fri, 9 Jan
 2026 11:22:08 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 11:22:02 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, John Madieu
	<john.madieu.xa@bp.renesas.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, magnus.damm
	<magnus.damm@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index:
 AQHcgNjpP7tWju4kVEOD2PeFnHW2A7VJWgkggAAujYCAAABl0IAAEqaAgAAVA4CAAAE9IA==
Date: Fri, 9 Jan 2026 11:22:01 +0000
Message-ID:
 <TY3PR01MB1134619348261C19E8D04D2EC8682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References:
 <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260109095937.3317991-1-geert+renesas@glider.be>
 <TYRPR01MB156190E553ED0745039A7719C8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYRPR01MB156190E553ED0745039A7719C8582A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB15951:EE_
x-ms-office365-filtering-correlation-id: ee3d5f87-5a9f-4439-5e1f-08de4f714fb4
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T7W4WBIdoO5YSsGSB8KWjOwjDnRovpBFs5fECIIH5iYACDYjpzxAC0Yuc1Xc?=
 =?us-ascii?Q?RaiPsfZLebvO+Pwo9fWyDWy4jQqfFYtI1zuNcAwSod425UvT7PIgIU2ymlkc?=
 =?us-ascii?Q?oOHPTb5CoXFnnDydVlC7HjQsRxK8lDhqTYupV1jySaMhbbLAb3DfZwkrgGPd?=
 =?us-ascii?Q?W63y2V97imVv2MLSfW/v3o5nleCyF/L9HcWxzXnDZULfG1ka4KkbTtBTscYc?=
 =?us-ascii?Q?/yQxTIy/NisFijj1ZQMA+9SZZoPbUjkV1zrrDBHXIg+HhXq2Snombi94VhML?=
 =?us-ascii?Q?88l5ySM6jPqQuOBj1mJS1iEv3G1eotOE15xSlzMsuLH7LCUgJfqCFuTOtmeQ?=
 =?us-ascii?Q?IKTaHN4xBR9459rudVJKhmdEEI3Gzb+vl8huLd16UNsiQesXMd/YI2f2YFHC?=
 =?us-ascii?Q?HMZt9TOeHKTU23P3/P7EbMcXtp+viK0nJ69PNYFBAwAPN9K1vdEXc/2nqCPf?=
 =?us-ascii?Q?grxbC3EPITZAUrH1ROmVYpA/s5Ck25IzAluANJg3f0TV6vifSf4CJbsckBuU?=
 =?us-ascii?Q?Zbtq3jKmav4O9aVEXucHhsLkJbjo323m7BjvWu5N2oYvRcjOb9dT5Vko41/u?=
 =?us-ascii?Q?UjRR9Lud4cM280rqwN64bVuLrDU+HkkTVQRKfYZVt6GAOp+JC921ymu6cK5M?=
 =?us-ascii?Q?YUhUYtrQjAYZtxADUBQrpCYYBIg60wVfbjnVFv5WnXtXDJV+ZQegqHW2EUae?=
 =?us-ascii?Q?aI4dkM+aZx6b3W1NkuNHtkD/XS9eaBsaGqd2ekLYmFB6lezsifxiEuvQLWVK?=
 =?us-ascii?Q?1SQbDgATPET+pvs9MMtts2mQZL9LnWjY7kJpXBixYDaIoZGq5u1fplcIP+Sb?=
 =?us-ascii?Q?ZzbIJkb6WTV/FrdUhuH5a+JvokLgM0xcbeb4KmcJqA4pP/MjyuJVUlBoaWwS?=
 =?us-ascii?Q?KcXg9ubCe6aBTzOirGwxPKLRYXqRkwWam0rfYvWqdfAeyuR5jpRzQcZndRZ8?=
 =?us-ascii?Q?zLDrnEQoZbNlyxOvuZg7uNZi4tTlGXVF61FnlGQiUWq6LuAaSj0OGNUMOY9P?=
 =?us-ascii?Q?BvYEXkilPbnPmU0+P2PNH5vgFSVSfQKFvtB+l5hHq56ovuXraXHbZM0bGVHA?=
 =?us-ascii?Q?A4/75XzRZtFjS29oaxSN4jOdM6+VYJ5MDE/49tYivJ2hVrjnng47edg7zfjr?=
 =?us-ascii?Q?yCVq0h7YK25G10L5eyIVnFgCyWJxgAQEAjx+lS8aAqBgNq8vrHehsFFj1P+j?=
 =?us-ascii?Q?fuhuADCfFHy2HXY8+tN7iv9NXAdtYi8Lup1tqc8hVsslc5qEuDsa3sCZMiKW?=
 =?us-ascii?Q?pIEDawHWhh1Rvv/kgbzSLVX7BksJUc+s3IPTTI3DdsuYDZ5aAV8wpN98EhAo?=
 =?us-ascii?Q?p8TPTqDNLo/pmqBTW+Gy88FyIObh6lvJBe61oru28XMDyhgB5QCPuIJHG0do?=
 =?us-ascii?Q?uDbbuCiNY5gMxY7q62ApP6DIGWl1CxgNTO2Qq8IjxrVS0bIXaY+ZURAfCnYQ?=
 =?us-ascii?Q?wobmutK7NdryvXl7XqmKSf3PbFpmENT8MwNJYkWTH8oV7clkNndPz9Aw7/i3?=
 =?us-ascii?Q?sWn9qt9wyeQGTPmvGlX6u2T7wy7kPP1d9yrR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vQQceiYTPHbh7wiwq+NfT9aPLMPjoa67P/FECmMLYYSx1LMGAxEbXPCO8BTz?=
 =?us-ascii?Q?BzxPGcbadQuxO2/yPiLnvt7hRGpTSsIYC6YIrMVqIqznxRWKf9mmD4dBMFSA?=
 =?us-ascii?Q?9miGq5Vo2hgX1D3IgRTQEltdhGrNbJs+p1XVk5KKALhtFCMQKQsNz9x1i5xD?=
 =?us-ascii?Q?eWZblIZSbcMoKpkf5j6UdZbnEHYii3ScXoGPqu/5yX5Ci8LguVuJiAosjPWr?=
 =?us-ascii?Q?Hns03FTqEqmUbdYWhlsRFiAdoVRW1fjj9G9/i418OIVxjchR73tm8H6gzepl?=
 =?us-ascii?Q?NreKwt3wfaEyby/Lsa06SXvE6lXYUQ7PPHgA83kQDDmf79UJr9CG+qVz4KRC?=
 =?us-ascii?Q?VwQEZQTx7kkY7xcTT+SHh98LN3H/R7pX5j5dmmEcR1lQ90Nb73xV7XLuOBY/?=
 =?us-ascii?Q?4SS8vzJQSnf4wFuIIvTkxtZtiqttxK+DLHPZGA0hf3Ek8XTvVR6kvHz70nuD?=
 =?us-ascii?Q?9qR4bPfh4lVpWJxzscZIZOucnPu2MOVfCvfvXgwKyckrCkrwtmpbwCs/gijT?=
 =?us-ascii?Q?eMf7UU0ua9ZWsf7+L/9lUEuFx/A8BKuZ7Ac0dFHNQPuQdQ7OOzMSTJ1nrHZt?=
 =?us-ascii?Q?9N8utfT7PtdsjRzF/QeVI1l86amIkWpc6KGnFoZYkzEdNArgET1fevFg+jq7?=
 =?us-ascii?Q?eOwF1WFi1QOaYt3rK99ogz/JDndouxuM1g5itlLL/8Hx0AxAc8rl0wIKHplR?=
 =?us-ascii?Q?Ig+e/1By/gs5NmHfKZSZ+BS5AZUKKlws7+XpuWN3B8F/+l3u5/PJ3c7R1Bgr?=
 =?us-ascii?Q?GSGEwggYW8iUz9hbrcbETdMfJUpihDWV7AXdwO1cEq2FfiYykfdRGP46+5xz?=
 =?us-ascii?Q?zZp175HAomBsdu/RBVeCuhSqxXj6cW3Fe0UWUJPNx3phjaslTMUmnskKTQbq?=
 =?us-ascii?Q?uVsSo6KD2TT+9absdMIZWxZ/AjUCvt2MVDRCe8ICJLTgHlcnWJnio4XFleJV?=
 =?us-ascii?Q?3NlXOkSW7aLw6I+Kt9Y2XXgrc1sJ4HSNtcKnzLVM7NrSR8I2aUo3zkbi2Oig?=
 =?us-ascii?Q?A8ZbWS+1kcbuhoXPQlBLyILFpSOaePAJtJugEekl426Lc5Vigunu2RArk/uq?=
 =?us-ascii?Q?ZkPaO0nOvcFju55ygKE7Xp4asrm8Kyrq4ZHXIkOzZEqM+UK2I6TAfKWYU1Ow?=
 =?us-ascii?Q?D1JgP0LFDbc2huElRM8QJiu9xFIP5mNH2NWHwZxLtkPALj1yWQXMfBGeiMT1?=
 =?us-ascii?Q?q9odXgDK6d2wb2d0rul8yAKYGApIwE4XYAKNzXTJ/jOJkD6dj+FsyNzRkjGj?=
 =?us-ascii?Q?AEhvXRUKr9huxwqlUmzF+f+TC2eXxuwOOAe03bvdyT4ga20TCYpQ7IJddXAq?=
 =?us-ascii?Q?yquLWsQaGW7kxX2KMD+op280J1+wBDbx2QtNajYwFdGlmNQW0GehsAvhKqwL?=
 =?us-ascii?Q?/oAZwzq6jMGVM/03Lnbn0QQmu9AZRluXNFPdhOGqlxwhSNh3QX9lFjK1Nnl0?=
 =?us-ascii?Q?0bB7M4fAenI27FYVqP3OytrRufSDsApEktmvN5kUB7l4tk0LoOJACgtUvxm/?=
 =?us-ascii?Q?CnjTIaneqGXzUAuKrfshHRLa3SefjKamhGSxnxLBzKbw4h49UuP7kKdaMG6V?=
 =?us-ascii?Q?6XmhHrkb3KWgXnhxgccFFniwK65WqKRAkH+ydUt3qTHz8pjTuIcPmysWU9mf?=
 =?us-ascii?Q?ltpVvawEmVlmnokNvYvTtJfPnhA4u2udy1XFhlFU84nhXNcGTfdwwvVSQgev?=
 =?us-ascii?Q?g7nIBG/4lxF0ZLu+xfk+WlkJxeQ7hRHznNnpM2fZZc2OWWHlWJokb5XdJ/Eb?=
 =?us-ascii?Q?9YYg3XOyLQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3d5f87-5a9f-4439-5e1f-08de4f714fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 11:22:02.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHaKxOAfGbcbQ7Gj2YW7FlyxJfYoAJXGuwr0Q4glTFb70DFWURnSVij1XaYebaL/RSYF8o4is5bxvkiS0fkmgLUYP6v7sAc9R0tFFbYtJ7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15951



> -----Original Message-----
> From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 09 January 2026 11:15
> Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T=
2H and RZ/N2H
>=20
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Sent: Friday, January 9, 2026 12:00 PM
> >
> > Hi Biju, Cosmin, John,
> >
> > On Fri, 9 Jan 2026 at 10:06, Biju Das <biju.das.jz@bp.renesas.com> wrot=
e:
> > > > From: Cosmin-Gabriel Tanislav
> > > > <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs
> > > > > > expose the temperature calibration via SMC SIP and do not have
> > > > > > a reset for the TSU peripheral, and use different minimum and
> > > > > > maximum temperature values compared to the already supported
> > > > > > RZ/G3E.
> > > > > >
> > > > > > Although the calibration data is stored in an OTP memory, the
> > > > > > OTP itself is not memory-mapped, access to it is done through
> > > > > > an OTP controller.
> > > > > >
> > > > > > The OTP controller is only accessible from the secure world,
> > > > > > but the temperature calibration data stored in the OTP is expos=
ed via SMC.
> > > > > >
> > > > > > Add support for retrieving the calibration data using arm_smcc_=
smc().
> > > > > >
> > > > > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > > > > >
> > > > > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > > Signed-off-by: Cosmin Tanislav
> > > > > > <cosmin-gabriel.tanislav.xa@renesas.com>
> >
> > > > > > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > > @@ -4,6 +4,7 @@
> > > > > >   *
> > > > > >   * Copyright (C) 2025 Renesas Electronics Corporation
> > > > > >   */
> > > > > > +#include <linux/arm-smccc.h>
> > > > > >  #include <linux/clk.h>
> > > > > >  #include <linux/cleanup.h>
> > > > > >  #include <linux/delay.h>
> > > > > > @@ -70,6 +71,10 @@
> > > > > >  #define TSU_POLL_DELAY_US        10      /* Polling interval *=
/
> > > > > >  #define TSU_MIN_CLOCK_RATE       24000000  /* TSU_PCLK minimum=
 24MHz */
> > > > > >
> > > > > > +#define RZ_SIP_SVC_GET_SYSTSU    0x82000022
> > > > >
> > > > > Maybe add a comment mentioning firmware should support this
> > > > > index and the otp value is stored in
> > > > > arm_smccc_res.a0
> > > >
> > > > The fact that the calibration value is stored in .a0 is clear from
> > > > the retrieval code, let's not
> > add
> > > > comments where the code is straightforward.
> >
> > Agreed.
> >
> > > If you have just a0, then driver expect a0 from firmware is either
> > > error and OTP value.
> > >
> > > If you have a0 and a1
> > >
> > > Success case a0=3D0
> > > Error case a0=3DSMC_UNK
> > >
> > > a1 will have the value from OTP.
> > >
> > > > Regarding the firmware support, it's obvious that the firmware
> > > > needs to support this and that the values don't just magically appe=
ar, no?
> > >
> > > How do you share this info to customers that they have their own firm=
ware?
> > >
> > > Eg: Customer firmware is using different service ID and driver uses d=
ifferent one.
> >
> > Specify the service ID in DT?
> >
>=20
> We can do that in a separate series if / when needed, and use the RZ_SIP_=
SVC_GET_SYSTSU value by
> default if the device tree does not contain a SMC id for the TSU.
>=20
> > > > > > +#define OTP_TSU_REG_ADR_TEMPHI   0x01DC
> > > > > > +#define OTP_TSU_REG_ADR_TEMPLO   0x01DD
> > > > > > +
> > > > > >  struct rzg3e_thermal_priv;
> > > > > >
> > > > > >  struct rzg3e_thermal_info {
> > > > > > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(s=
truct rzg3e_thermal_priv
> *priv)
> > > > > >   return 0;
> > > > > >  }
> > > > > >
> > > > > > +static int rzg3e_thermal_get_smc_trim(struct
> > > > > > +rzg3e_thermal_priv
> > > > > > +*priv) {
> > > > > > + struct arm_smccc_res local_res;
> > > > > > +
> > > > > > + arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > > > > +               0, 0, 0, 0, 0, 0, &local_res);
> > > > > > + priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;
> > > > >
> > > > > Do you think it is worth to ask firmware team to return error
> > > > > values in a0 and actual OTP value in a1.
> > > > >
> > > > > So that driver can check the error code and propagate to the call=
er.
> > > >
> > > > If we do that, we will have one more variant to handle here, as we
> > > > cannot make sure that the TF-A running on the board is always the l=
atest.
> > >
> > > Mainline will use new variant, that can have both a0 and a1, if we ta=
ke that route.
> > >
> > > > Right now things are simple as it's either supported or not support=
ed.
> >
> > Agreed.
> >
> > > > If a0 is some error value, how would you distinguish between an
> > > > error in the new variant and a
> > proper
> > > > value in the old variant? Both cases would only populate a0.
> > > >
> > > > Also, I'm not sure how much use we can get out of a TF-A error valu=
e.
> > > >
> > > > The error that TF-A already returns in SMC_UNK =3D -1, or 0xFFFFFFF=
F
> > > > in u32, it is pretty standard
> > for
> > > > SMC calls and the probe() function already checks against it.
> > >
> > > The OTP value can be 0xFFFFFFFF, if it is not programmed, if that is
> > > case How do you distinguish error with respect actual otp value.
> >
> > What is the expected behavior when the firmware interface is not
> > available, or the OTP is not programmed?
> > Currently the thermal driver fails to probe, which is IMHO suboptimal.
> > An alternative would be to fallback to default calibration values, as
> > done on R-Car Gen3.  To handle that, rzg3e_thermal_get_smc_trim()
> > should store the unmasked values in trmval[01], so the probe code can
> > detect this case.
> >
> > BTW, what are the default values of the trim registers on RZ/G3E, when
> > the device is not trimmed? Or is this always done, unlike programming
> > the OTP on RZ/T2H?
> >
>=20
> Only early silicon should be missing the calibration values on RZ/T2H and=
 RZ/N2H.
>=20
> For RZ/T2H, I have:
> rzg3e_thermal 80086000.thermal: Calibration: b=3D0x33a (826), c=3D0xcd7 (=
3287)
>=20
> And for RZ/N2H:
> rzg3e_thermal 80086000.thermal: Calibration: b=3D0x30b (779), c=3D0xccf (=
3279)
>=20
> I asked my colleagues for their calibration values and we have the follow=
ing.
>=20
> RZ/G3E:
> rzg3e_thermal 14002000.thermal: Calibration: b=3D0x2c6 (710), c=3D0xcd5 (=
3285)
>=20
> RZ/V2H (has two TSUs):
> rzg3e_thermal 11000000.thermal: Calibration: b=3D0x319 (793), c=3D0xcbe (=
3262) rzg3e_thermal
> 14002000.thermal: Calibration: b=3D0x333 (819), c=3D0xcc8 (3272)
>=20
> RZ/V2N (Ovidiu is adding support for it as a separate series which depend=
s on this one):
> rzg3e_thermal 11000000.thermal: Calibration: b=3D0x304 (772), c=3D0xc91 (=
3217) rzg3e_thermal
> 14002000.thermal: Calibration: b=3D0x307 (775), c=3D0xc87 (3207)
>=20
>=20
> We can use the average of these samples as default values, they seem clos=
e enough.
>=20
> In a future series, of course.
>=20
> What do you think?


I just asked some questions in my mind related to tf-a/kernal sync for cust=
om SVC calls and
I am ok with the feedback.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

