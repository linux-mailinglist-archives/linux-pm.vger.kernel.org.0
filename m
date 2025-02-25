Return-Path: <linux-pm+bounces-22877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E29A43C9E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F18E11886675
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307A267F7B;
	Tue, 25 Feb 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SacVVCr0"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10E267F77;
	Tue, 25 Feb 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481236; cv=fail; b=EDsgist+xFSHmJ78N/wB86dPtlbQEMpQdCntcAFA4Z5RDRQPVXnw0p/uKTwIs4NRh40yJlDAgXA8ciKHamdzWtN/HzCSKff10uCAj+CTHkjYnt7+JkmOlj+VJra8GMsO1HqFKWiaLirBjjUwi9reaOS2ifAeHkRM6LHiaMOm+ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481236; c=relaxed/simple;
	bh=j3BQJJmYzvfe2OKIsPP0eR8CqOHVmWmmba6QHXldPQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=naSbwd06i6DdPSv3ErCw7311g+ZLZIu+U7CKReRLeGFvKgxY5s2Sf3zcf4Nm7ZntpffxCElquvdxCmFu9+Ve05Nlz3f1qYKucjEVuWhIIYt0ehj0d/gobyR6aIFI7Ip3iAnphiAbPcDtvYD4xoeKwube6h0XJ1OWnw9uO0Q5Vlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SacVVCr0; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNsJLY28AphmBGbH3BPcCkeh9Jw87Wy4HQwDswriQyVJkwVK00dpmdGkvY5RKPIp8eBjS+EmBNlH1GnHWVt6XvBrw6JZvOazAI3vpTbSFN40Uy6vuKCo8aB7nRxt2Y6M3G0ZCj5QNm4zv4aACASzOlb8Nt24YOz+1z08nApVAqvKQZs0DxtyGMlwXWgu4jipqz1CYvQSKfqogCBjAxRi6SDc11Dc7l7umyidUzw/Dfll21EViOjAOLvK+/U5+hiSrqYDu3yhRFBhLpUs+EhrJxxmzWlKPBtvtnbi6n54gRYTxfQ5aEsRE/7U9MPkIKfVr6YbSBu2FXml4wDhhRmcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3BQJJmYzvfe2OKIsPP0eR8CqOHVmWmmba6QHXldPQ0=;
 b=DNwDlNHb6a5Z2sdMPi6Dgvi0JioeaVCKGycbFg45MVJobQCpxM3o2MI0j44yXAApfUttMZwBE7WT3B1JpTjt5heuP0Vr3oXSeI4Yob6I8bHL0zdyx2os8S4t40eEv2G46Ovqr2fjQObbBQiNNWXubIQyfDRO5EzRcVuJwIyjZfz+x/pLsEvHH0FjvOEa3RHlH/fkc8vK9MsBbQEvQaWalvBRuwHjOvDosud8AvwdS0zENlJw8h6TK8y/UtiTLdDJHz292c84MjxlWOMKX5iTcDvNtHKK2oCg3yIi6af1+1ASg32cDxtE6H9GpMCWHjK6xE42o1pLPgPbTiLBHm4SdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3BQJJmYzvfe2OKIsPP0eR8CqOHVmWmmba6QHXldPQ0=;
 b=SacVVCr0bUAKck1Vay0TrB//7nOKzBgy9hybfNrYJPlWATotuF6v+tKYf4Bpgv64Y/QWiJCoauE1R1RSLB1Kk2KeYWMZWY8knOgqjl/ZJdTBqDKTCtWS+LTawPwdbETox04+zKdoAQDPCbAPIBIaHK2gVDTGJ7GDrzJuYZUSO+tSHHydtndguw003UWOIoli7ZAusYRCpkhrp7rcsX0KAQnimcoyC8nj5Bwz1b58eEYf2SBEezxevBK9Afzoy70LyuY2+YeKcQeahyezP3fqX6/q1MfHuUrIFFvhi+TeKI6fuCsSabtXwzD2EzdsUY2GOEnyop8H71lqqXD+47lVHA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7312.eurprd04.prod.outlook.com (2603:10a6:800:1a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Tue, 25 Feb
 2025 11:00:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 11:00:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf
 Hansson <ulf.hansson@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] soc: imx: imx93-blk-ctrl: Scan subnodes and bind
 drivers to them
Thread-Topic: [PATCH v2 3/6] soc: imx: imx93-blk-ctrl: Scan subnodes and bind
 drivers to them
Thread-Index: AQHbhshzO7y3KbOJQUW16EzpI9lw3LNX2x+Q
Date: Tue, 25 Feb 2025 11:00:30 +0000
Message-ID:
 <PAXPR04MB84592DE3846EEBEFBE2302D088C32@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250224142831.485159-1-alexander.stein@ew.tq-group.com>
 <20250224142831.485159-4-alexander.stein@ew.tq-group.com>
In-Reply-To: <20250224142831.485159-4-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VE1PR04MB7312:EE_
x-ms-office365-filtering-correlation-id: 7bc7c794-0a19-42ac-9d5f-08dd558b9e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U/KDhcRs6BMmldAEdif96fvRu22ke0DUnVx8tQJ4FW2/J5Amxu8kryBdjmiT?=
 =?us-ascii?Q?kecPXwMCMxURO1tdPoiQZ88q+o5ZsXY455Njc0A+qL4ZoK5ITeOeYk5y78pq?=
 =?us-ascii?Q?MIkWcLA5Oa9Pl7wlOwK1A3NP8aBG9hMrk9XdWJtcOEOQntmKb51Bozgc1Zhi?=
 =?us-ascii?Q?DKhKUGHDG2g32izSfm05siueFDA4TZJEkx5mDZGn8ryc0BqkbjZLHdOFe4AM?=
 =?us-ascii?Q?TUs4vouUshu5euAbwJgFQLY/J3Pvt5oMtw+dHEU+3cv3JHwOcXRxbGgaeqLT?=
 =?us-ascii?Q?sL8g/4sd3zNPmXXA4nsQb0TsYgigAcfgj4hmsB/WL897l2h9h7Dc+dcST2VE?=
 =?us-ascii?Q?EVFqAG6Vm2SQ6CpeoDSaO+4TMgnuuykSDAI6gUmThul1T5midKQquSsq4cDK?=
 =?us-ascii?Q?FOLRkbR7nUYvjgzs41wcpX4WXTAK7q1T7rfKwgjVeeaNCAVPFK7ZxjvwXxfo?=
 =?us-ascii?Q?taYUFG0CXwDKzHpaMpU6Go0NRHxoC7/WTEORDVDykPhRAKZoG85NApAsbKQl?=
 =?us-ascii?Q?9/dPvrggi+wIBEHA8OSdHxMSul5dZQFhyEMBYdUVHhh2eSP1nzsH+AqWxWMU?=
 =?us-ascii?Q?fV7IsT5caGA4ctQAHgWiSZzvWHZJYxfkZr1xAmYSl94ODn7QrMNp7N15+ld6?=
 =?us-ascii?Q?PraK/juUGp8UiwF0ekfmu68e5IxFNSC5GO62HIxr/taBk4Ot4H1wec68eBPA?=
 =?us-ascii?Q?hfm/c0HBepjg+mBJEod3NXAlwk8y74/R5zyoG/6ct/Qfb101agxhpblowsqD?=
 =?us-ascii?Q?gQDOpgQJee4JOtse0JmB9A7CuoCXMn0yh3UFj3m/58Py7rxXIo8fztbpVg5X?=
 =?us-ascii?Q?5r7zXUhiZmX/J+0rom46MOiBwEGmCjpXffaTYovg5YsS38joPttt/aCrUsWz?=
 =?us-ascii?Q?9bCXvSMzdz3OJvdOCV3yby3DwTd/IX9rezvcdt2b0eJrDOz/dQnrWtVOxVWD?=
 =?us-ascii?Q?HHHlE7GlTG8wLzlXhCMaZaxtKwdXQwcahdWOidU0DInRgRMdmC2EiWD20wzK?=
 =?us-ascii?Q?1fl4/RvvvNYtsjJb7BZ1eHtgViMPXY7J3xp0SOBAzHkQSjOL9GqHp5jvcsd9?=
 =?us-ascii?Q?H8z4B2y0supnzb0H+31O6Il+YVFJUhvWGZxO3JALhKQPUuUu23tnziYYuvY8?=
 =?us-ascii?Q?26Xu3z/vZE3nMXwy5TqVvPKw5uypKycJWJYPblbDp+NceZ1VaQCQGcPT7UyX?=
 =?us-ascii?Q?W4hSLrU9/PByjOyF39LqMoiyNrs1sDXC4HlEoHd06dmaV4HDsYcgxTqVFAbI?=
 =?us-ascii?Q?TRcG17FilsGHtjtaf3ig8cNMQhzxwyhIJysfU5QfyF/BO4tWgvYeeaPpga8+?=
 =?us-ascii?Q?r60qDAPXYBszbqa+zeshv8zlGn4Untxsh9bl5+B9deqoDuKyXtSraKIl7LGo?=
 =?us-ascii?Q?z3T2kn1pSRe2SyOZNgfWbRQaqW6fkGdtMU1quts4zQsoA+4lHjXWW8clvVKH?=
 =?us-ascii?Q?y4Dh4VLDXLh5Lgs4sJxeHa9CdFc8H/l+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?31tDz/wCO+H0/WEJOY4DVq5Hfx+ZrK7vGwRRMIz1gr+y0tphCAt//8kC7s+L?=
 =?us-ascii?Q?AQfirl+icVv+9DJU7SVpXx7V11dkoVoSZ/c4z7N/bhPpfE9br22TnkylgJUu?=
 =?us-ascii?Q?z/5eFdbAHVQY6RSPyITcZSP89oIcjMyioj302fYwJTwAtHkDV0MIdJXB0cWV?=
 =?us-ascii?Q?XbX1ho450qkzPbyjqaw4+zIhSnYa/nNp8LzmpOHXadysQlGNDrHGcx6EcYDJ?=
 =?us-ascii?Q?qbhtVPewBqTGCL30OlZs4G5P0CrtCjgm1+fEnisKxArInBk7c82mE8Adc9g+?=
 =?us-ascii?Q?AVlQh9HazmY5MjO034EhI3lefkyeUdTmWYfieXiotbUIJLR2vhbFWwHiVsRb?=
 =?us-ascii?Q?D9dfK5j9lv7zUohxTk0Q1aqPkQmYL4SmdlwfIJkocowOQbROhKPRak99U1ST?=
 =?us-ascii?Q?MkKcNUYiVp2gLUA0rq3lu92dkozn0/hk5A1lSRfo7q7DrSXiBF+oW4qBOzhm?=
 =?us-ascii?Q?WUczynrW3N8aaJ3dssTu8mOaGcwNJxuu4+BW9lUuePH72epsNtQnnoqiK+ME?=
 =?us-ascii?Q?vfpkg4wGGA/nMJ1/o6dpiMfH7f2k5IXLgf53rqIgNUINigahT/kJN3uP7FAG?=
 =?us-ascii?Q?ucNteC9eKVvyauRPkqhOKAOxjvxYx/tm4e74rjfkn3BINP/IKPqf2j9nZrdz?=
 =?us-ascii?Q?s8G4hQ0f0RUkt1cm1ISOt4urEje2tWeE1wmbLz7GBrVK70KDNvXlbGS/4Juh?=
 =?us-ascii?Q?6WRJZeB/B+b6JEMpvzFzVuA2F0KRy3ZIhXpCfNoARtD+6M8QbIMRIuyHb72d?=
 =?us-ascii?Q?YxkDaBL20JKbYkvC+xXhTCsH/Ih8B4CB0tlI5eTrMeLzwKKHKVoQIsRgaYmE?=
 =?us-ascii?Q?bZt5G7zhFbIMnNXyhalBOrbmWnt9l3eAkBbmBoeppkD2Cvtq3TuDiOFGKYCf?=
 =?us-ascii?Q?Lf8/O5EL+TnPH3RIy/EZKKwib/xBFIA7gWb9Qe24n6dybsMq1f91MinCzM2x?=
 =?us-ascii?Q?EYWcDINajKQOhfA8v/+Cg7e8aJQFr1ZsiNEqIjL6SEDc8/DNHfeJJ45Hecih?=
 =?us-ascii?Q?yY9sZulpzXsSjP/KAF9nEYTeBHaPYJ9f9RDZ6w3gLOR5/4J8LUq/rP1wVjRD?=
 =?us-ascii?Q?8ZuvAlHRCLEoagxitTwUY6ocB1EdcTA/IYtAwdxcTvbkzeaGrCAqQjF4VGQP?=
 =?us-ascii?Q?7R9LSIEnJXEIDivtwq6huJ7HtncdwXYnstB481nfvxSMIx8CwwHlDENYRq5G?=
 =?us-ascii?Q?c9u6RL+WH7DxE96ZofzCJmyaNECkM99mDF2tTqqWsyzaxfB/C1mYQTtSMq4k?=
 =?us-ascii?Q?NU/VzUanDWCas8TzDzhw2U/I7zL2yeuyHcA9HqTc3s2tlbh1cM43go0vgPrk?=
 =?us-ascii?Q?wxYsLpMETuKm28r8FLmOdI1g1IjlgwYkAQMV1FolfJbCvKczniaUYnilGO4E?=
 =?us-ascii?Q?YHjqrSVZuWEITUK5++LUhA5567zLRL8bBQKs101sctrkl2BRj/QbprR+sMbS?=
 =?us-ascii?Q?sT1GsQXvPqGOklYq1A7b5CMg4xo2Ldbd1GlhoJll0kyERpOfKZDkP2l2APdd?=
 =?us-ascii?Q?ONLxrAdN/z9erOJKqt04PG4gq9AeLLR9ehLtjGTqmnLQJE6QvWEhdz1MjxuS?=
 =?us-ascii?Q?RrQM7Ik8cloKYP6UwPM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc7c794-0a19-42ac-9d5f-08dd558b9e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 11:00:30.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaeTT3CelbFswoNqTVzGbmnqgwSQK/TaikLtrDtqzO+Tf+wRHJgH4E+/uwBUe6LnJSeJuv6aCJN+Y+dpmgOsKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7312

> Subject: [PATCH v2 3/6] soc: imx: imx93-blk-ctrl: Scan subnodes and
> bind drivers to them

Typo: soc->pmdomain

>=20
> This particular block can have DT subnodes describing the LVDS LDB
> bridge. Instead of misusing simple-bus to scan for those nodes, do the
> scan within the driver.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

