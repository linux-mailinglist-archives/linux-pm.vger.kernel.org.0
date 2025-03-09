Return-Path: <linux-pm+bounces-23687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489ADA5832F
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637A516BE99
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213181BAEDC;
	Sun,  9 Mar 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="cCxtFmtZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011050.outbound.protection.outlook.com [52.101.125.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFF1A4AAA;
	Sun,  9 Mar 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516779; cv=fail; b=HQoHHSbU1DwCpiLamH9kiDbiLQPAJ9OUruvTecaYCANYxliDSkKItEdeqGiTTVO8OkuA74R1/3xlvPgZ4feCZuDIXGgc/mOgiZWrgIHfvjCVwiUiJtAXrPcer8WJIGBPx6u2vupDbTOY5erU414gt41i/0i2FDUahZtlskms3BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516779; c=relaxed/simple;
	bh=BVAlbAB8pbjkuBdW0pr32ZRsimaNX0OZ/gNijSfN/aU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Re2oUzBnRdAv74lTMbQ62QmNMaQ3RZgOLEMbuY+Jf0YcqUBSdHfvBeKazA8a0lE8hnuz59lhaED8nZbp6aX2kWtdOLBqKvYGlIK5eDxMR4D/jgSlF0rt2tFmoQrKuwiq6puRqXbjqsE3V4XSXqftXcc9Wrg8fazkuWhD8GpiGwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=cCxtFmtZ; arc=fail smtp.client-ip=52.101.125.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUTQXtg5QhDZwBgy3wUIALWrpwtiXyV01Gxi4chJxOyT3Bnyva2gVE7bdEKPyJdewuXJHNsDif60DrFiC8qaC+q6GO5jCaaDa3sSfcsnE2Y8FcLZ8ktqlkIh0lkGZq3dyQwUw+Of1vh4aBbE5ILA1KZPeCWfs45ECtZwXp2dOMzVsJ2TEIl7Zqs/Wfv29d3m+nruSEUumxxYjeZ6KjPnfuFzBg65gLT7hLJoibZbHpOalJ78enNOSxKgGvsICk7eEiLpTrdf4KZW8ViTDk6zIdm0AnPltCRQwGmREIGVRetQ8IpBY0dPFg+idJbWEq5r+cu8GQPGQ1lH6WelVG9/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JyivJo74RnuIsmmr/W7IVelnKGRJrY0/qpSPlO8Df4=;
 b=nRfz5Pb1Mnz3CZn6KQK+y/0MEJdajZBhtBGBWQt/m4Ttb0YB2IlXggkyH5MVLU2jbDCHLV6vl7KuuF0qR/R5diAuxaMTjqLbYLNnFujg78h6LzYD8N1dzTQQXUT4mYhedRyaodD4P7mlPWoS1GMpw8MHBAxDZSoW0yrDNclEE649o4vfqJ1JPmzlL9As0H+fK6n2MztltKFoTXkcIu04kPNxAiqTZzqxNSvsXnpZ+boK0llwIwgKBQrW4q2o1VydUwKZNNiztB+dahKvGpNDY1LLt0b6j8eoWsHAchL6c6mJ4iJPLRq+YcOX5HNbr6xafC6dxKmHqowKqag8Mn0JSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JyivJo74RnuIsmmr/W7IVelnKGRJrY0/qpSPlO8Df4=;
 b=cCxtFmtZUJMLxakabaebKO6jlkgnIHjjBLA2U8kXWW3TtYZUyhg2KNtG9qnotG86/7QYpYJOOg0y+aS/l1mHlc0GxmbZTRRdCevO+FDffEzaItttk9lq8b9PlY8yy+bXbRBaVEou7VOoxzVAHVuga9QJKweVmOcf0EMjh9XP0Ug=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TY4PR01MB13028.jpnprd01.prod.outlook.com (2603:1096:405:1de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 10:39:31 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8489.025; Sun, 9 Mar 2025
 10:39:27 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Topic: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Index:
 AQHbiRKwzjBFhg3PXkG3oKF6ljEYA7NdFKWAgAc7OeCAA4ptgIAAAsFwgAAF0QCAAsfM0A==
Date: Sun, 9 Mar 2025 10:39:27 +0000
Message-ID:
 <OSBPR01MB2775D121B55A0C543F251BAEFFD72@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
 <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
 <20250228-shampoo-uprising-44ae0d3bd68b@spud>
 <OSBPR01MB2775DFC184F78E9FB50F28FFFFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-everyone-ragweed-e05a10a9646b@spud>
 <OSBPR01MB277531D7C872C9EB0B287069FFD52@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <20250307-barbell-pretzel-368d6a4d1336@spud>
In-Reply-To: <20250307-barbell-pretzel-368d6a4d1336@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TY4PR01MB13028:EE_
x-ms-office365-filtering-correlation-id: 57c2622c-a673-41ea-d612-08dd5ef6aaaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?blnWLpT+ZUcHleyekuWH+zZH2yvfwwJvzVeQia+0M4VavbaznshcxQf8Z7km?=
 =?us-ascii?Q?3pLv6QLSLRIiD5Sq7L+X49XQWg6dMj6F3r85xmXGj8Prgf50C3U8yelzSab4?=
 =?us-ascii?Q?zDFXlmhzOcYw1FUkY+i1G9bSpeTEeoL+VrNFV5LswZGztqbwE90eouOKZWyt?=
 =?us-ascii?Q?T7d6nplttFezhe/BK63GkFr/ZRo7siWEZc2PQLz51iQsYe4m6tJIimuOOVew?=
 =?us-ascii?Q?+B3v8hoQazIG5Chza2D+NXCwEVjEDIfC2pSErGG7XdSqkNWbanCauDxbwP/u?=
 =?us-ascii?Q?x53Qkl76Ragzot7gHqQNuAPqqS1yY+R/tZxKB40df+hUw1BrnJMLNXHiKySB?=
 =?us-ascii?Q?1GrODqcsZIJwv7h0grciSygu8FhDKshMT8djwFs0szPkmPugYGLYkWU50F6y?=
 =?us-ascii?Q?TH0rIPM1AQEFVKRWWyQe8TMnFfotku2MJgWK6e1nKlpi5JGK6zI/UMGlwV2r?=
 =?us-ascii?Q?XaNsLbKtHzmwFlG6HLSq3rflOgZelRUjk4B98Xs1ejbD3V/obzTI7vdrr94u?=
 =?us-ascii?Q?2hT/W+2I9jAg4FuMf8lkIQ1/yBF8apjPPqmv1E1QPdKTT7TKsPUF37kfK6rS?=
 =?us-ascii?Q?dBTGHzxNd6Ug+KflSq06WViZMa/+2MNkktvK6sFvwQ287gcTg8fPNJylMiYx?=
 =?us-ascii?Q?1WJ6XY4jJsDVWgzUxuo1rzqMs4g74Secc7BmI13pL3xOOaue6h4Sbp7IIopX?=
 =?us-ascii?Q?vovgHAaOv8PW3kNa7s5PBDWuqwy2yX6dht60mc072UX1yykEsXHtDk30Z91/?=
 =?us-ascii?Q?fCta26IEyVJ85fwO+EvPGXli7Ig2S8ENpafGCukFXKuwufuDQs1d8+8+o/i+?=
 =?us-ascii?Q?ythaUs2QKe6/O1bSB0XQbvjNO8tKcpJ0F+OqIzf5hZ62DPj3jHC/tH5EXr+8?=
 =?us-ascii?Q?RdrnO25dYFlLlWv4LI5/nMiq54hU+MupmEDPJfC5ztKOGgXU5z7LAm7YUij6?=
 =?us-ascii?Q?AbEF2M/4HUnfM0+xc1sfFwe5el9w3bCJs2XuJQXmZlXZhCiCnb7pHyyRvwyl?=
 =?us-ascii?Q?PmWJsPxDzyb8MezSOK64MJXTr7lzYZEo3KxwOnO1F04XqWdAkqGhv7oLoUPz?=
 =?us-ascii?Q?FRBjmLWUA49dkuLPQ/qTCuZhhSefY/okbIxXDGDIuueVZOPbwFB3l90rZFzd?=
 =?us-ascii?Q?kPC24PIFM5C5+Hd/zg5Fk1FcC6BgGoN7rMnAwtQcfD2CGqlUr+Qi85E22dMa?=
 =?us-ascii?Q?tIIHo4gtYGqydYqPvzVZdTgdlTAftkew49AYmC2UBbMFLm/mPzQXDATtSq4K?=
 =?us-ascii?Q?uP7F2YhPAO9LObGo7MfKGIOk1DjwvFHU6l6WpR8e+xhoN10hXpLvtKXx9SPK?=
 =?us-ascii?Q?sdO5P+5+gKX89l/6h7YWcSmO0hGZk+8Qq1btw76sv5vC4shpZX+ZPtcARy15?=
 =?us-ascii?Q?RZO/V46GVaNd7JFnwUBuGvl+qt4vrrwTS2w/ovnA0RqbwIAREBMhDqUhOLQk?=
 =?us-ascii?Q?powljQK8gLM3VnGmPnHEwidgfCc+0hrK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HDFB43IZ6lFLorZAKx9/7pDMU7WSlbSMLidjAi6KhOYrGfxrLPzJdZPpEmI6?=
 =?us-ascii?Q?Bxh9vS+G6IFIdEZTJfuc66go40SovF/RbBs+eCHjTh4/3yC0Y1aBTvRFGx2c?=
 =?us-ascii?Q?skAr5+sdeBalYAJlp8XbQVXj8UXs+AjhcbOlsc7/ERo72dA1cua1ti8HRT4c?=
 =?us-ascii?Q?w0fKe3UheL8wYaJ2WLZZJxyPH2b+o4s2BdROLvlU27NqVkQKBzpYl0YHgSah?=
 =?us-ascii?Q?BCYpM4uRxnhtTLAzL1RHZBcqGQyGEBM+TstKYfz0nO+wy9r6mRbaz8cwKMgP?=
 =?us-ascii?Q?JWhS6c43E3Mdt92zXjc4iAp4ZajA5IBeBkDG4acTFWhmPMVTqE8V84eLJ3oe?=
 =?us-ascii?Q?hvDNBpU1ByDacHyQJLEPu2lAzK/pJpikNTDLVfuR6TV4R+ucUolsQykClMpE?=
 =?us-ascii?Q?iYUD32JQCTebT5zse2C15HUgTzmL++rVQMDFS3nWGKaxgtxkd2SbvqkSX83j?=
 =?us-ascii?Q?TERWvlBcyrpcpzY7nsZEZ9/+t/r0xoaZ1ZlktqVsSAsQO+UDtTdocclQKexd?=
 =?us-ascii?Q?oEZBnC4qaCOwGkydy+y8juI95LY4Rl9/uO0chT+soBAa65w8WY8D8zH0gsLL?=
 =?us-ascii?Q?kA4Gu5PVJxNeHqD+4qX+SZTggg3wPDE5jXCNmqDEsZSh/JV1AlOvaVlmevft?=
 =?us-ascii?Q?DDqVg8ytDgW26KhNG90kwDFXgcdhfANI9QReu7eUybmJETaOsAhbv4GX2kdf?=
 =?us-ascii?Q?LR250wHCoVEHlL/whMDJmfvpU3GDB+mb2RPFehMzeTXPTV+ob3cTdfPUgL9m?=
 =?us-ascii?Q?E5FI6JfbNfAtJWXsTnGc/e5aRpEILeMLzjIYdHHJZ7E8cRJNgJmGQBNV8Pzb?=
 =?us-ascii?Q?4HXOMHybEmJ5bI7nRlDIL26jH77YnzALiXzRBv4YkwoCKZAykFLPpcwvInAF?=
 =?us-ascii?Q?rVRX0mlAQle3Qng4iC64hiaePcZzUCwiHVwlQBprasIaRLa+Vb4EvOt4mbK/?=
 =?us-ascii?Q?LIJ9dD5zaca5LlSsBIlnLOS6FwHqn1l+WnjkCN1jmpQqzz9HiO39tlrhVmK7?=
 =?us-ascii?Q?6E7SA5UX3ENGy0ODU96btu4971pbOFWG95btvX3nkN9lTKi7WzLzIhO50TfL?=
 =?us-ascii?Q?8b9vjqravsNhg/d1xkYR7X0YEaJuHIcyAdJe53ejNeTvHZEM6QVraUUGP7qW?=
 =?us-ascii?Q?KHYrGSh3Fa+mGei2JHZPCmNfJF3tWI2QBJV36RsK2VjBTnXaZDQYS937dgDB?=
 =?us-ascii?Q?R4x13Sf+VqepWSZZhfvNsxaEEL/rCVbe8Mzf715U0K6Tf1GjetatqhYw8UlX?=
 =?us-ascii?Q?/JI+3+sjBxep3/9yZCY0X3O+dwMubfcTJpUIoKZln/485H4pVYN+ftaW0Gq6?=
 =?us-ascii?Q?AzbDyXsI6Cb5zT7apC6w7ehK7HTKZtZ+jm+tuoMRlI9FoptYzImu5Yf1U7qT?=
 =?us-ascii?Q?cy2o2rDFVOYxFFIAi1HRpFzumV2Umj9Zs0ChEeUSyh3xJjdsFb9S2QAh1xcc?=
 =?us-ascii?Q?Wh1OLxQNRPoZ1NcRWDhS0wxdo3w6JGQaCh7PlrTdMvps+i4R6thytllBX8tr?=
 =?us-ascii?Q?F2XOwMj1YgBXHY/XHwTEPsWsOxCh7gxV9DnUXuckoo8yfmJ2qSbVPjMB53+E?=
 =?us-ascii?Q?ewNfD2sxsOu/uA2WqhyK9d4OBtFaUIAuOoZzoiqMl4xDeWohxTTZor8EBCJN?=
 =?us-ascii?Q?bg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c2622c-a673-41ea-d612-08dd5ef6aaaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 10:39:27.4534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNjqmzXZKeONb1wdSJbc/4dS17xf8O8bR9CAnzMNDghYrI643XGhetEWILhOynTjfl2Jmn6zE1iIYA62CfqnMkEWJBWwdrZCpX+iqDT7mL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13028

Hi Conor,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, March 7, 2025 5:04 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document
> the TSU unit
>=20
> On Fri, Mar 07, 2025 at 03:55:27PM +0000, John Madieu wrote:
> > Hi Conor,
> >
> > > > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > > ---
> > > > > > v1 -> v2:
> > > > > >  * Fix reg property specifier to get rid of yamlint warnings
> > > > > >  * Fix IRQ name to reflect TSU expectations
> > > > > >
> > > > > > +    enum: [0, 1]
> > > > > > +    description: |
> > > > > > +      TSU operating mode:
> > > > > > +      0: Mode 0 - Conversion started by software
> > > > > > +      1: Mode 1 - Conversion started by ELC trigger
> > > > >
> > > > > Can you make this "software" and "elc" or something please,
> > > > > unless people will genuinely find "0" and 1" to be more
> informative.
> > > > > And why doesn't the property have a default?
> > > >
> > > > Sorry for miss-specifying.
> > > > ELC is an external event trigger. May be should I specify it like
> that ?
> > >
> > > If "elc trigger" is meaningful to people using hte device (IOW, it
> > > matches datasheet wording) then that's fine I think.
> >
> > "elc trigger" matches datasheet wording.
> >
> > >
> > > > To make sure I got your point, do you mean specifying a default
> > > > value in bindings ?
> > >
> > > The property doesn't actually need to be required, it could easily
> > > have a default (say software) and only be set in the case of using
> > > the elc trigger - which brings you to Rob's comment that it can just
> > > be a boolean, setting the property if elc and leaving it out of
> software.
> >
> > Got the point now. I can make it default to software trigger, and add
> > optional Boolean property to ELC trigger. Let's say "renesas,elc-
> trigger;"
>=20
> Yah, that works.
>=20
> >
> > >
> > > Rob's other comment was
> > >
> > > | Who/what decides the mode? If a user is going to want to change
> > > | this, then it should be a runtime control, not a DT property.
> >
> > Changes are not possible at runtime. Some customers may want software,
> > while other may want the external trigger, and this is immutable
> > configuration.
>=20
> What makes it immutable? Set by some wiring on the board? I couldn't find
> the user in your driver patches to better understand how you were using
> it.

I haven't prototyped ELC trigger yet. Since the hardware manual
describes about ELC trigger, I have documented it in bindings. If you
think, it is not needed at this stage, then I can drop it now and
revisit later.

Regards,
John

