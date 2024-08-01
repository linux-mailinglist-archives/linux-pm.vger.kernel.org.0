Return-Path: <linux-pm+bounces-11784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CC9440D8
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 04:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39F51C23D1B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 02:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78CA14D717;
	Thu,  1 Aug 2024 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nroji9mP"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278413A24A;
	Thu,  1 Aug 2024 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477015; cv=fail; b=drox6PzDDrDC20ek6t/DVI6fAsNg+zQ826ybsIuVUfKQxj6XCb+6N2vqfD0PkwltWAvmw89jaXOpEubK9F7h307fU/eEo93ppiKqGcXvfItS/ru9jnCAmq2sG8q2HcTlNknCE4+mOfsyBoZLhsMiy5STdEjed50KIHIm2qMSBZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477015; c=relaxed/simple;
	bh=Q6bHx3i32cF5Jbq2TizPWVl2/H/NhwGvzEhHZps4jfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofxITwPy6ft7OdjNUf7DaggjClg7wAJe7eafHA/E3VBFfBG2vTYNLOwIvIXPNoK+Lej+V6UE/vHX1IO1MFW7HXEZdPR0Pn94yhpO4L3AZt7ZX2vXhFFFLvVqXHWIzJ/fNoO+XMus5BergEBo50rCOTwFNa8zZJmDSZMZQk4t8hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nroji9mP; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pj6gQKHzXi0pXE2bzqeBk3rYs6/ENpM1wXBLvh6Kt+FcbhZbBSTLM5V9ViQRIWFFnnXsyMEkHPCgK++4+gd8VY6eWafEaQqLIYF7rwwYWLnoOcyf8+vZbLluOysJRBcxon06YCXWzrWPXP1D5QxNKYSaQv24WRSpvBxpb1tjulF95URC3YnS6UrYK9qLEhKM3kFV5R1dzD0z3e57Efv/KidzChje7Cje52C/JF+OsJw/ookSuEbnpzWptTIfX0Z1+hoiqnM4boRi/B/gGnYtWronHkznHALF1Ux6RUa+tIXNCm1Mp5HseM6MpT0bHGBjK0Pzyctvu3ydh615iLWtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6bHx3i32cF5Jbq2TizPWVl2/H/NhwGvzEhHZps4jfY=;
 b=DlUTmijcICAvoaZQUA4ACRbRJfPhrkAGVoB9RP0mFMfZRxItXUDWR8Bty+zg3gTMM1GtqGIn2rqWVOoKnXMV5FNKLCT4Z6WJ6d77lH3NVDSxw6fnSzeZa7bYzspSUu7opgG4Rr0TL5qCdamd9RcJfnOZhmwMqO0EpBFTCTrWSsQjEeynWBCnCSTMMrmqjLfrkct9CBfFzpN5PFxPh/D6KvfJHSykJIXiHatuBZ61/9sMfg0aU001t5FroCv8kx/UaOdcypCs3lfufGojkuFTKC3I9WEeE35GzUaXrFahdTMW/wlzn6+E58Mtg9s9l58X8+q7GCAguCSsEzheuNCv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6bHx3i32cF5Jbq2TizPWVl2/H/NhwGvzEhHZps4jfY=;
 b=nroji9mPCJiBJah8gfrcm++zcVrlpZdnD8GaCT1nAS8ODPOsfcYGJis+y8MVaaiga6g70hnqAYjGUesQHrXY0j9Lmm8AREfMsKfxSSVvOb97GAyYm2oJjZskoHZHG5oiHDCd/ytySOd8VUJ63tfcSyRhIatfZjhTTc9WxtG/KSS2AbSGGtM4WJhRnXXHL9x92AdqNFPsMAMTjPDcyYoAUxZOICAKLwML1KQ/eWwiJP48Ni0hybvBWoZCto0KL/LNlHy8xaccf/LpLAw81cTpnHenJFPZWz8kjuPlbMKrG7vltVqYgEhXTISm8hAi1FtIfqRTHeaPsUdaRM+ZoNkwNQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8057.eurprd04.prod.outlook.com (2603:10a6:10:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 01:50:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 01:50:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] devfreq: imx-bus: Use of_property_present()
Thread-Topic: [PATCH] devfreq: imx-bus: Use of_property_present()
Thread-Index: AQHa434Q93oH0Yk9zUCT/166NTp5gLIRoypA
Date: Thu, 1 Aug 2024 01:50:10 +0000
Message-ID:
 <PAXPR04MB8459577498192D3DAF66F8E388B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240731191312.1710417-11-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-11-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB8057:EE_
x-ms-office365-filtering-correlation-id: b41729a2-83c2-4f2c-7629-08dcb1cc4708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q2s/sBF6W0HuSsbdIEOzoZdSFvdBpZmsY8zU8vl84ErENTc/qY5Pjwf2kqgq?=
 =?us-ascii?Q?x1m71sWaXPP78y6bB1VqsM4L3hICsKiPJs5PCt5goQiNcPLmjmtmqoqNn08X?=
 =?us-ascii?Q?kYRH9DeVML9ZpnZoo2vFiWYE7GKhntkFnw3CUcMcCCXvSJn7Ihrboel+1L9Y?=
 =?us-ascii?Q?ySFIJfkEd+pI4iviY63NBfakipuwoAl735sUwMxHeWrNCbs3jQQYcO1LNIWY?=
 =?us-ascii?Q?7vvUJWJ0GzRrDIovx6NLp7VKCwx1nRhvxRr21A/xsd1tcDroqHG2vqM8lXNs?=
 =?us-ascii?Q?Bq7Ky6+eZRzQxhc7NP8qlopdDm0ZmpYr1GPPQLXlHndyd5RCx5MykOMl1eIs?=
 =?us-ascii?Q?cPK4GzksJr39wCf5yNbHhtoKNvmoD4Fd0i/d4b8NJUap1H+ZkgjxLLFMZHO4?=
 =?us-ascii?Q?gwcRSqEbDWRxulcYaAk86Gq03AdIz00/AXkPH3L9f4/BjxRIeShJMxcDJw1E?=
 =?us-ascii?Q?Dwp/m8gpfvPocW+0COzsm7pe6w2byyhZXwB32U8anPhRV0GNSi3/qPjNt687?=
 =?us-ascii?Q?s2LwwFUyAC/HdEE3kNWck8kVCIuu6L+hv67A2x22aRj0P5cZiw/LJm0fHzUb?=
 =?us-ascii?Q?bQQSGDRmahJXYYIRocAcRO9jOt/t9D8aG4bZb0ZV7TGwKydjirM63LRVIkKE?=
 =?us-ascii?Q?/VtWMdor6cc7pohuXspu3Zb1I5gM8MOpvMCBIwSFQHngNv2uMZNI7G5ZDRlL?=
 =?us-ascii?Q?sKq0P4rtnqOXS0iTrievb7jZvEB0D2qTWDgLPJmQIZkO6lwehSJ2l8f3uQlT?=
 =?us-ascii?Q?0iMvnUm9sVP7T4T//oxrYI2djWXKE+YVwggbfJUrc1l3ZlbQdyuVoZFiPmBv?=
 =?us-ascii?Q?HPh16SKnoA6CIHUFUE7gh69/Qs5vTAvZWE1sRZlVtHY8qf1Y3G58Zuq6epjY?=
 =?us-ascii?Q?w11IXHyjbsNz6f2cL9Gw7VxqG+TTnQfKqW85EbHf4jFn4v8lR5gGnLk6Gtti?=
 =?us-ascii?Q?GLMpKfCH0tsvvCNkRTWjGglmDqh1HcKb6wc7+QpJ668L1liBaesJubHe+e3i?=
 =?us-ascii?Q?7U6UlZ2KSKvDswimfcbYbhoRnNgJb3NtyLnpZ5d2jZruizK/b1tDVAaOwC4T?=
 =?us-ascii?Q?y89YLOFDtigWmq3v+Rl3hnvCB3l7ASn/fTrbqkt/9196Z7M7nid0cJa4GH2R?=
 =?us-ascii?Q?kzY/6W6QLpd51Eeh/o4Bt8sAoKoalYn9TRj2QtIh2cpVOsLi3oUHP7fE7wqS?=
 =?us-ascii?Q?LUaH9EQgC7EPHo12bGSZsqdl+oeaPLJGCuRHiRhIv25bFBzWIgI4lMF5WU69?=
 =?us-ascii?Q?QeFwV6s+gUjkfiXl69EQDvTcHVkji3b45hjTNw3dd0XVJnC7q6ocqTyVuBNc?=
 =?us-ascii?Q?BMB/q4c+H66P6WlDQeMkDEdcbo5RxkgeWPE97bQAxNjg1J5JHEIaatm7uqiH?=
 =?us-ascii?Q?63dBVy9dEj2ST91o3H8bi5kBSK4dsEbG1MPE7ed0yE5AJp+5sA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Db1EcyjXUHRNvfxenS9pwpWkKJSwxqgR+y6+J/G/Bd4yrai8kuLQpfFzI7sZ?=
 =?us-ascii?Q?qN+BermZjpdNgKocHrexa5zvMBYj9X7YNLpLw9uVCqMJXKYgwtFR9hq3LXqd?=
 =?us-ascii?Q?twsx6GAevqe3j6qFNh/5BAc2dp8zUEDZwIY70qgmgoc/ZUnyar5kwua3pR3q?=
 =?us-ascii?Q?PP38O4BS1Almv41IjFc+UEmJNRi+YiewfTr69h0ioowpqGltZeiwqC0VCg9X?=
 =?us-ascii?Q?bIHYoB0yTfbQBZd6ye+ClbrB6MxCbL6YqeneW8s9JwYhzajso4wSQUEc85rT?=
 =?us-ascii?Q?c9UOf5Vr9lNZAhuQ0BKXLFVp97/DVRtNYZV+6fDs28nrUX75378zG1MsVQ3L?=
 =?us-ascii?Q?Itvfn2dFRYy26kN3HfDemVfWEHAU6OHnEan9y5piRx03KVnwnnJel2/1Stix?=
 =?us-ascii?Q?9SZFZbxfbe+inuKQNqr0m3YWFf/yJLiG8jO7Ek1WwRSSdGEcrJOL7pkkpWWW?=
 =?us-ascii?Q?sQ9BFBQ3u4J4H6bYP0wVQN4pbk6RkjIPfdtWVGbD6LRJxUK6TUkUKkEHeJta?=
 =?us-ascii?Q?gMGUi39fUwhWg28bRM195gXeFKeeM1/uwoj+62pg1J8D7CahntyNxMoFUc8B?=
 =?us-ascii?Q?9W6qEqZqZ4djEsFNV1EeZs2c47XoTNfS4TQfs3QcXyT49xhpXiH0HSRJa4Yt?=
 =?us-ascii?Q?BFoY8Ff8rPfbcHvGApqDs/Fku0fWWqPEvC4QE+vxWjMwztpspSzxmbgThg4w?=
 =?us-ascii?Q?pxn6ikmxKcFsGZDZxwm8gSV4se435o8jZUc8H3GaMDZkzIpRb191HEzTDaby?=
 =?us-ascii?Q?ZtgEzyY22Z8CldNfyHC1q7J/wfweu8vedg1bUH3O+qOLrdoLON59yi4jMC5t?=
 =?us-ascii?Q?y08tGjVKX+FVdPFCeeAffDm/qtX+1beFlMn5rTeDWZJ8KvTClh44yi7xJyRX?=
 =?us-ascii?Q?I4E1X4qjKTOwOIJUvlMGK0qTabzX/izxf55FnrmowzkdHvfNwJ2EPE/SB6HP?=
 =?us-ascii?Q?kuN4JjIAHY2kEAgILaSadNoRiBdM0i1k3O161KuiXQetB9O53dmtOKZCendX?=
 =?us-ascii?Q?JGWsVLcXONLdfCgis3XebC50V1NTSIkMY/D85WM0Hy1PSSZCpIY/Q1QvmHKV?=
 =?us-ascii?Q?jGcrfJG0mOWFcoUBZiwkqrsErP4M27jG3DV7LmlefTzA6LNqL4LBFiKq5lfE?=
 =?us-ascii?Q?TpcDNCjD5++ZjL5ijgVF2mx1t+J8mqz1gfgBlyw/INp/7g02PygiOx1O/3yH?=
 =?us-ascii?Q?lLFKjcjKrnne9fNDKWIR5srWvUmMZAnIE03gcnFGkJHImXlH+X5EE92PUqSx?=
 =?us-ascii?Q?J3cJmW/di1vwHm9fsIUZ7Xg+RIvH+a5NJQ7rp7QdZXaH6QwIbYHX0T8QV97J?=
 =?us-ascii?Q?AatKotla+y2ISE29loNM76tHkeYMoRfIug+PEn595NZf56r9jvbPzkXITGWy?=
 =?us-ascii?Q?1CiAF09EgJxfXWnR4VXVPUc5Jpd8v5oVlBDcBXfB1ORZt2s2T5hLF0NpAotD?=
 =?us-ascii?Q?dGDV2d9QASZePibRvKNKf+L9FteKBZWZfErzTgBMrHJE+U+pJsqoX36P2AwT?=
 =?us-ascii?Q?AWoVsfeMmIbdHBfdeEc7jirCoDnZgKMW3m7NWIQF1VxBfeOycZZH7rdqGfSc?=
 =?us-ascii?Q?9ZGVUALbaihVIVkOKwE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41729a2-83c2-4f2c-7629-08dcb1cc4708
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 01:50:10.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqrC9XuYpiBTgbpdGu0jfMDMSD/oEduEbWu4N6YDfIdTOoKdmLxt9JQeyqKAddAUvEZ/qguwVYYgXR+m4sJKOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8057

> Subject: [PATCH] devfreq: imx-bus: Use of_property_present()
>=20
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers of
> of_get_property() and similar functions. of_get_property() leaks the DT
> property data pointer which is a problem for dynamically allocated
> nodes which may be freed.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Peng Fan <peng.fan@nxp.com>

