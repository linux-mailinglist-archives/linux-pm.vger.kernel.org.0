Return-Path: <linux-pm+bounces-10305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5241691EBA7
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 01:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1D41F22965
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86947173335;
	Mon,  1 Jul 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lAOdnz5m"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C18173323;
	Mon,  1 Jul 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878378; cv=fail; b=G5cWKiusc8WV3L/rPUs031WW+8gSeG6+JwWCSsEHwikT37A/meROp8jBRUxwbO7aYktpcdvoYxJzbfH0KbNoSewbK8Hh3FPBxonxg/ly2/zAtNBMBloCgjYQfefHfNzeLVbLqyVkWrCChBK8ydqF6c40oqSH7UBM4Zo8+b5RLkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878378; c=relaxed/simple;
	bh=h7cJLxpWU3zmjQU/LaIdrw6V5pMTGsgH8QRXbaVzJX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdIa15My0xgDNdla0IinrtSbVDJwI2fbXPK5vtPC2e5Gf/1dO1jdr/BLBVKlRN+tWiPwm1XJCpH1nM0KASqRQVNMFTq+1bIieTlBOhM+8Ypbsuqr3+lUrhKFEaBClgBSpkzl576tYebIVraBAZdj+2rRMzDXeFl+H1+wDj//iRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lAOdnz5m; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTMP0jbgNhxpmPMy2IrcAHaj7PWnBSicihH9RPTAiJ2gBf2wrw6JBhKzW7kae7u0PGLkNcDro4jnUVQk32k/JrBKaAyF/mEwW3S/3GdX7xia2FuC4qx7BvXK+SNl5DHIob1tLgZHuk/2VNM67IgoWcQJHEEO7oTl0E2+B0EgaLeCfZhEYLx/lQxoP5fwHGMafKW+AqqtlSKsgWzF6HXD/lGRxfGDOK0CB84y0me5sFdwjuxvLUrrijzCn8wDgwMzkPoGcElTLT+HYNArUmRMQwhe+YCv7XJ8kpmrRHmwOi0rlMCkWZiU5Ns7kljBfPhxPLsOG1p5fLNqkc2odUIfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoODcZEbPyXo66y670iaMP0bI8/nnP2vsklOAffkOcc=;
 b=krXtw1RFacKG8sRX4yNSJlNFHqvVNZlSrRED1IB8el0MojsG/zJ1CozWJeOPvbm6xzo99D8cUVWygf5u+dmX7hAL+ZT6FMDphFD4F/8GCNZeg5lEmNj4QKXYNtJ3H6MFSfNFoL62j9MiiiJITCAy8HL3jy/U2a2RzgSRGUa4HSBiFDynZK+4sKVC/HLx3dSYS6+mBxK7QkFUjhzJIfdwQ7XdKbXPNYm26zzAZu34NCLBS59BbWzzSp69bASUR+cAw8yMCMYUMbY3BVC7UPmnzzwambOgWzx5xZj7n0gBmA1Q4+633qZ7JQt16VTnvXoGX8+13+PEHUTQnJ4B9m9UiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoODcZEbPyXo66y670iaMP0bI8/nnP2vsklOAffkOcc=;
 b=lAOdnz5mjDVCv87ticdhHv5efG3swoZ6BMeXGS6ZWptTTYIOc2YdqmqwWX/6cBOsPLiOWhTuj/xAuSnckh88gRy0BoqY7/KEVwxxLRSTvORCfLQ///SnZrIy6L+rmCb0AlaPA6fcuVwW2HnPhiv/IYJxmMBgA6/m3dSXD2lX8HY=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 23:59:32 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 23:59:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Vitor Soares <ivitro@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Ulf
 Hansson <ulf.hansson@linaro.org>
CC: Vitor Soares <vitor.soares@toradex.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Subject: RE: [PATCH v1] arm64: dts: imx8mp: Fix VPU PGC power-domain parents
Thread-Topic: [PATCH v1] arm64: dts: imx8mp: Fix VPU PGC power-domain parents
Thread-Index: AQHay7RnqvlULVweU028rz18QXS9U7HijW9g
Date: Mon, 1 Jul 2024 23:59:32 +0000
Message-ID:
 <AM6PR04MB5941E53A5742E95EF1579C6688D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240701124302.16520-1-ivitro@gmail.com>
In-Reply-To: <20240701124302.16520-1-ivitro@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DB9PR04MB8364:EE_
x-ms-office365-filtering-correlation-id: b5c546ea-e0d7-4f18-2870-08dc9a29da25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WF5lj+xyP1iWStmfAiqdFkqhSPGi+UAg0TYxbdt2GWam6S0NtFIXYuQuNnQf?=
 =?us-ascii?Q?CLh6sZvfGjLP+xEW31YridMStuQmCeW1Xv69o7/l/Vzq6w9OHFsnFAXFrj6B?=
 =?us-ascii?Q?FzqgQv8hMbyw/0K5ne4JMVe+igj8qEG5wGdAylx9xgRAT12XRQ/lSkpQdAVu?=
 =?us-ascii?Q?Ls9ewtIG1B/I1PqyLADdcyUBOatfxMKbmsMxm8sZKo2UhJwiv8ybq71MvwFI?=
 =?us-ascii?Q?jaPc1f5AUgF90mx6bYc+8osobgMyOu36OJHSZL730ltTjF0J2oswUh+iGqp4?=
 =?us-ascii?Q?A4efFN/0f2HeCy4Twkv+t2DYEHc6tTuMbmyOfPhNjRqbgmmVhYqRlIajPg/W?=
 =?us-ascii?Q?mqpsm/gqOvMentHyiM68gcCK/I9QeVqWdS0IxnGVwKb2B+rhXCjbjtDgOTAr?=
 =?us-ascii?Q?FjGIjxIi5tUAlBCRtlD+af+oB+M2LT2Euog0jKVoqnJUh9FQsEIaxmupKTlr?=
 =?us-ascii?Q?O5djyPuH0txsJ/9HUzVpsuW0KyuqdznxpMaVyg0n3RBunYejW3Q5EjAz+8Ty?=
 =?us-ascii?Q?kbM6FhaAePahuwhpAoxXLKyuzYc35fqbjA4BV4bQK63zVCaWv359ud8mVb6Z?=
 =?us-ascii?Q?LNP+w3RxDKJMY5hIwXtlEH77MKzz/QhjIs0+yDOO6JzTmxhRE7vyK4ss6Vag?=
 =?us-ascii?Q?CSec/ExxELnTDGnsXW47brmdoyS4tcpvGGriT3sodr/srSgTkDsA/AYUAXqH?=
 =?us-ascii?Q?K83DLfgvDgE6z1ia9C6rYPafvm3rtKxxf+kJGoDXY+yiEqk6duMcpyRwBi3C?=
 =?us-ascii?Q?t6HLUoREJy2fd8arCopFVn8lH9AjmBLuMlwQ77X7ruDOx5VzCWb4+drwwMXW?=
 =?us-ascii?Q?JHtRWvlBDNAxAS5JBgKy5EXaSxPZ3UjoHWvYxP4vUP7fmbxEWEsRJ8eI3U4r?=
 =?us-ascii?Q?taEz8a8ZXoEjmsZggwL1+bcLw8OEHt8DBpdVWiwp4FSRWC5Xfji3JFPyfV3D?=
 =?us-ascii?Q?YaTPtaVTHfwl+NQRPhgn1cBCpqHYmBLCp6ul0suMA9zhxkBggoO3I+dZZVEs?=
 =?us-ascii?Q?UbizvG1yg7XRoToauuaZgdkyu2Nvcxc1/+utYNI57VU4MghJA/GmEQ+3ZICC?=
 =?us-ascii?Q?6uJd0OQIhUAF+9xHC7I0x09oz2Hg26GxM2tXaEKUgIzVIoNZKshxDXvIU1G7?=
 =?us-ascii?Q?jiQbhcrtyQ2jAZAs6ihCiW2EywzJRBgiuhGiyj6HRIFjOOb+RLHKERILoj+g?=
 =?us-ascii?Q?bP/IC2qKnOA4O53efu9v/PC6AGraNCa6kaalgY1Lq96R0ZUi7fk6C15SOicV?=
 =?us-ascii?Q?E9TGac6exnvl9OAFf6HV5sDrx6n4Gxs2dv6DBqFjXgoVDbini7IIUI8ku8q7?=
 =?us-ascii?Q?jXiISnnfKwz7eEInjjf5Y+mNmNPmyUvV8tQDWPUYpNuDgRk2q/fAyYIozXgu?=
 =?us-ascii?Q?Bpz3gX7kpAfenbxDKAmgnhYyb8+bQx3AJr0GriwiyL8LUBuUqA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0LDBiFuFNG/gJ0YRr6DsPYPQj43zwLUd5r16GSzsI5UVbABRc1GB093i+PCj?=
 =?us-ascii?Q?Sl/LHMcrf9pULmK2QVdg1LGMoMkcHb1IKS3cJuHJqtgKULxy1tnP6Ey4QXP/?=
 =?us-ascii?Q?e0xsHulxD+8GU4QdZtqK8Bfg15ovdwsFqxeCtvTSIpbKpmpTVYUWqeuAkMDY?=
 =?us-ascii?Q?idxtECv+ODu4bqVfOqisTLmsOnhYqdGIrZI/ityRmYYXUYBveHPnqGFqUoAI?=
 =?us-ascii?Q?IIHyguOzYNMVwCtUTYk4+eMnfFF4U6yyDI1M2ZpOS3IEZYmEkEF1l/p3ywuI?=
 =?us-ascii?Q?n+k7M/ANgSoQBbF05b19X9It5K3usTUKIHD5xcQ/scdvZajqbazrQeb9t1Nm?=
 =?us-ascii?Q?NMiW6vUnP3hifv78lWpqlgt8LgvaQMKkwKJVNxbeMw4LYhSj9DFL7QF2hDU5?=
 =?us-ascii?Q?hcVttrSUQGaS56aT9KH6fndFFKDj/w9bnrhNHG9pAzMvYyWR4VfKd35mL9qZ?=
 =?us-ascii?Q?9hZCp0kqyy6UPDhC02XoyafAdcT1Rv+PFon01f1zsMD1+mAdAHPGtGYwsGZX?=
 =?us-ascii?Q?WJVWng04vgrDwUNINyN32nWJF5HtCdhs5p1+nFbRBSDRM6CIUmXrGKOW6BFj?=
 =?us-ascii?Q?IKWBZ99uP1zyWIQIk7uuUeey2gMaBvg8h7FBS7DtJfkIG+yy9CXJVMYcKzN+?=
 =?us-ascii?Q?o1MOyxi/G9TNQosP1j1RAaKzlJLfFMev92tq9VfMve4syJBrHlKMjLcb2ixx?=
 =?us-ascii?Q?0IR6OtjI2XYAjb1F/ByYNvaBlb3El4WmAtF38fXKHHCAxLUEG0+9f/zb2FVz?=
 =?us-ascii?Q?yR6U+Xl7EE2ejAObr771aUH05Ph4gj1s8k+FXspaPvBwPMwELXApbfNT/Gd4?=
 =?us-ascii?Q?Wv3OvLI2LiDpFUpVCKkOTqZ396MUk6e+EwuxX8nwldTJpBE6lMk0DZx8BEQf?=
 =?us-ascii?Q?gI+cOUX+67F2SXdTul9mjUA7aExNjqXYSvk7geX8KmBNyzMIayc1QOwCvMOB?=
 =?us-ascii?Q?cLTWc/7BxfxdPQ6e9g8Z1rN1oprv3M2U9vlxZ3oB2l75lk5M8lLYsp9urEsB?=
 =?us-ascii?Q?xwsY+1bJHBzuXkyM4VjjOYhHt0PBwrXVn0bWwI73IbXR1fUOomVcrAd8QQ8f?=
 =?us-ascii?Q?afCHga9h4+EQ8A2kD6pvjGLkpb4F8ZnhFOfnwl+8HfgxNdp8w/qXftThhHvE?=
 =?us-ascii?Q?uYtdJEYpAMdmE/E+nQh7Ca+CBaq9KuL9yKJqDmX1vfkr+FMr5+EMX/GOTAqx?=
 =?us-ascii?Q?YilWB+ppqhvSqHdPCClj91a7X9ZMcWzDfFQ+gSb+JBLRp57lOoUtPjjd104C?=
 =?us-ascii?Q?mUOnFIY+p/0BFcE8iJqw06w4nGtPa1ZmlaWyNh/7ELRCTZq6YlHEh2H0z/NT?=
 =?us-ascii?Q?ZvdwqCdFIRJsex0Li3S1k4o70urFqtw3w3KoZ0QSnsN99szsvnQ2fGoiWa7a?=
 =?us-ascii?Q?QIA6H/1N/TlXDmEjxp8Y812UqCb4DicFsnytwjWHGvJIl1b87LHB9OqxKrsu?=
 =?us-ascii?Q?v2uFXtk8o5hER7XY7bZxAHADdJ5g83GgmFminHBMgSmgLqt4AG6rzSqnYEbF?=
 =?us-ascii?Q?zIuzNWyXvN0RIYiFG9fWAyd1lMEWS9UuqzEvnhYg1/bMy1LWZuMZpssUCZ2B?=
 =?us-ascii?Q?r3ogwuZ7kcmxVk1OCa4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c546ea-e0d7-4f18-2870-08dc9a29da25
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 23:59:32.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdBnF2ICxlJeDikeRe4A+3EcNP00B7rZEFGSIX38GgxQnIH3u/nhVMKhHM5wgwIwLhT5+44GIL6D5Ko1rkR4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364

> Subject: [PATCH v1] arm64: dts: imx8mp: Fix VPU PGC power-domain
> parents
>=20
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> On iMX8M Plus QuadLite (VPU-less SoC), the dependency between
> VPU power domains lead to a deferred probe error during boot:
> [   17.140195] imx-pgc imx-pgc-domain.8: failed to command PGC
> [   17.147183] platform imx-pgc-domain.11: deferred probe pending:
> (reason unknown)
> [   17.147200] platform imx-pgc-domain.12: deferred probe pending:
> (reason unknown)
> [   17.147207] platform imx-pgc-domain.13: deferred probe pending:
> (reason unknown)
>=20
> This is incorrect and should be the VPU blk-ctrl controlling these power
> domains, which is already doing it.
>=20
> After removing the `power-domain` property from the VPU PGC nodes,
> both iMX8M Plus w/ and w/out VPU boot correctly. However, it breaks
> the suspend/resume functionality. A fix for this is pending, see Links.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: df680992dd62 ("arm64: dts: imx8mp: add vpu pgc nodes")
> Link:
> Suggested-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

For VPU-Less 8MP, all the VPU PGC nodes should be dropped,
right?

Why not use bootloader to update the device tree based on fuse
settings?

Regards,
Peng.

> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index b92abb5a5c53..12548336b736 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -882,21 +882,18 @@ pgc_vpumix: power-domain@19 {
>=20
>  					pgc_vpu_g1: power-
> domain@20 {
>  						#power-domain-
> cells =3D <0>;
> -						power-domains =3D
> <&pgc_vpumix>;
>  						reg =3D
> <IMX8MP_POWER_DOMAIN_VPU_G1>;
>  						clocks =3D <&clk
> IMX8MP_CLK_VPU_G1_ROOT>;
>  					};
>=20
>  					pgc_vpu_g2: power-
> domain@21 {
>  						#power-domain-
> cells =3D <0>;
> -						power-domains =3D
> <&pgc_vpumix>;
>  						reg =3D
> <IMX8MP_POWER_DOMAIN_VPU_G2>;
>  						clocks =3D <&clk
> IMX8MP_CLK_VPU_G2_ROOT>;
>  					};
>=20
>  					pgc_vpu_vc8000e: power-
> domain@22 {
>  						#power-domain-
> cells =3D <0>;
> -						power-domains =3D
> <&pgc_vpumix>;
>  						reg =3D
> <IMX8MP_POWER_DOMAIN_VPU_VC8000E>;
>  						clocks =3D <&clk
> IMX8MP_CLK_VPU_VC8KE_ROOT>;
>  					};
> --
> 2.34.1


