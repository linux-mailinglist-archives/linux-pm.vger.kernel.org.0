Return-Path: <linux-pm+bounces-31487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E12B13D44
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A875A170294
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62B826E140;
	Mon, 28 Jul 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W4NB6OIY"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0726773C;
	Mon, 28 Jul 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713311; cv=fail; b=sSu+YRx6riMK0x5Igh6VpovlM8WtuWOAMdLjLNb/q0OuzKM2ENy61zuUhCDykDFCWvvxipXzx/s05Bcud1mRHZhXKybGF/vTjF3pxFtsCfF/m3dMwNlOcq1ixGh6B7IqxNV59/npPI9rzaU1bsQ1u1coRxts5flxp3L+2LpB0o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713311; c=relaxed/simple;
	bh=iYG3ZCtgRoamHlmrqUHHvVW7gAiXmc/3b9IJJNrY1h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cHgPyVdJKpf65UQbzFZ87YoYCFC4MQULPQPdV2HrQuVTmuY+3WJNLZoxuV0gmkFXPF8Y2Ufzh0lFmly2+CZTb39WsGWdv2uBYsOpeyZCuILq8O7i8097qb8xB+EzhJjkrPLs1uPTQzUFEFJRR1goELweEEbuWz5ef/o0l5VYoFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W4NB6OIY; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w55/JxJgHcTHAh+3PkRgSiaSxd7gIZ0RhLU0U1H/+HoWlKnwwbfNqU/WFFyjBQE4giHPzwTSwvv++PT9yYNRJYuOFMD9cJOb8EkEVgFzq5LZmfTAD2Ku9ZLKum8cwxrIFk73B4EKgdlw+HdBrd6+tZ8O+O9FCEraUv4V8e82CDXQ6LBnKMGLm4iD97UdX0jBPJdMNxgfs0tNR1n2mxeBq85X3r746cNPJpSrzNXqwfUfVwGQuXcUdoX4nLevFPnUpLYOaNSRIZRDJJorFJ4hs407BAO+bfjuUJCX8AijMwHoUqR5wgDUhB1e9Gd5oS/UxT7x0kE3mKKP/+t2ufcHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h0WiBF2wZgCwjmkVpnAxbPC3ivGeO5d+0D2J9EZkiQ=;
 b=BY34prbe3fM4MhQSNaa+hSCp5I3zi3CfrjUjFNAzcWyk7PimQWN7Ve5/U1mYfJIH+F62xKERyxKq3OC0sxSmxvXTR410RYaoLBjb9ZdYjV2a8pFtlVcmFFRytwJVvnP5wssbuzFlCO2Qiz/zq3VqZSt0AevSNQiI4O8aj3SDQNN26IHydDCMxCQu0E4U895mr4/QNUMxXUuLYXoBu/xaMAymise7xdjPKxhDZXM54uSsc3w8ICbE09Hbc+GQbAFLFbMAY9paRwjgg672I6DXTO0vu2cpKlGchuGPKj1NUOpAbWg7dj4tF2HICYklXJooAepP8+59zMknDKCQc3cAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h0WiBF2wZgCwjmkVpnAxbPC3ivGeO5d+0D2J9EZkiQ=;
 b=W4NB6OIYOWzsnz4rG60WTucL/i1FYaZhTBkO22tBvOf7f3IOj3di1+EQKfHdr77Bqua9g2M5/YnBjqazzZNpEnfvePzelvUGMa0mx5SsPytqVu4kAWwNjowj9SEfxYq+3PWqqIwTmqWpo7eCoTl60eONKn6NtSrzfOmi2utEQL/7h7jcE8JwGF6OMB/kpLBDSI6dEaZziKvYGDIxiWJiwU9kncKGsx1NN/0MEUBMlWAvv27+e3F8V+h4l5NZU+8Gnf5dlAQBymUnbTxLi0On/DlXINWUN6wwQI3ZydQONSKKY1K6JI8Jl227ZUxXRFwI1uIb91NROMSRDa7K12I69A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:35:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:35:05 +0000
Date: Mon, 28 Jul 2025 10:34:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 06/11] arm64: dts: freescale: add i.MX91 11x11 EVK
 basic support
Message-ID: <aIeKjX8rVtV6ZbWR@lizhi-Precision-Tower-5810>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-7-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728071438.2332382-7-joy.zou@nxp.com>
X-ClientProxiedBy: PH7P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f0d112-2764-4a56-45bb-08ddcde3f153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+F/LakfHEbOZW5chSWMFaYe6zal19+CKPoaat5Kt4vP6XywdzoZNHBzmai4?=
 =?us-ascii?Q?GqStALBHEwB+wKqrHiip0M8vE5+Z++gc/87R+xcPb2sza1Zln/xHu7nXrHvM?=
 =?us-ascii?Q?StNXjLvWKB1CZfXmVpeWWT6VXe9/dUg9VhRz6k+LeC8qZNSAaMrarQDF15/n?=
 =?us-ascii?Q?q9bhIeYXk4Q3oK4ahsE86Ip/0m27VmyX1sIkUZ38hcBBCwwpHCKq3lVctS4x?=
 =?us-ascii?Q?lTz5EHMbjxyPLdcboROJnF/5AjThXA5/oQTAifPBMRZn2q1Sb3su1r3fOQ/r?=
 =?us-ascii?Q?B7HVFBaZUUPwWGQ/t65mpl01MWnTe8iM443pS4vBYEz2mtf42WmmNRs7PgaD?=
 =?us-ascii?Q?2CcgxyWBc5eUue+claNHIkbdORbjoBbenj0m+dnPtM3ETosJYxN+gC0SEzL2?=
 =?us-ascii?Q?HGtXsVST0YLWEI+fww0Sjrw1mcET3PfexqFWVX5NH95impWr1U0X1wyBkf5S?=
 =?us-ascii?Q?PJrCSSp2yklDjm8mOrer3LwHU4tK4T2n/9bxBQ7gQm0hJtqD1CjEKgL/Rp+/?=
 =?us-ascii?Q?oyV5J6iJDBxgHKDu8Cr5a4IVTc9tbJrHm9rW32UMp/N4mYhfvqoQ2V7spMSj?=
 =?us-ascii?Q?MhsjeU0rJWdcGisi+nuS25hO79ZqFsx8hV+nwNsxVIVAWozTBtBrUPYnJZLO?=
 =?us-ascii?Q?kAR+/MCxA7jeRSCOawu8LvosXLwddGriwGf3CFwu5BFFeGEazEu8XFQUjWHs?=
 =?us-ascii?Q?xuemAokFAdHhyhmbxJHUmnSzisgQ0Z0YziSN3fLP6OFqJHsYr1G7KojGP9uf?=
 =?us-ascii?Q?zcfCdQzXtz12GlYf5V6hsIOz86m3u0oMQVx8IQ358uD2/cX24GopLXVbp5fS?=
 =?us-ascii?Q?LBm0OC3GXoimMobRFmQD1/Xm6ifc2iHQ2h7x3HnMKWEcgNV0l3fGayYmxmKt?=
 =?us-ascii?Q?Iw1Zzy/0PkosxjITzBNXosww/nc/TegflnfEafkNrizLF6ALcQivLLffnmrw?=
 =?us-ascii?Q?+unjmSc4SyQ6sJICzqr/mlvJzNIDHCfbUMpKd42dPb+ATIQlXqKzdLiOKADU?=
 =?us-ascii?Q?EOqTZsRwTBNv7an9CcD/QW0rZccXF+tthSdsxmLlE35KbN7HsGYt1ISnEhTM?=
 =?us-ascii?Q?TgGhGXgee4t7h9MstPldLUJH8JNwems73V95Nd/dhQrxyJQBo2lEtKNazZnb?=
 =?us-ascii?Q?JaxoUDcwUi28Hjm6OmSWe+M+V2gsFMrsgtaS0r/AExO05DsE3WoZ92Nft2V2?=
 =?us-ascii?Q?N3wWze4psY3TgnO4/nGXO+kYtyNnmeqJlABP0OidVHx4iDdX3rl33IJA0r0u?=
 =?us-ascii?Q?gx2Ekerb2zkbbm4VIO7SvPVjjWRkWp9RmsJKikLkJUsHM4+A7upxq/wT5ITg?=
 =?us-ascii?Q?P6Jf+npNlgHsFsHOmMudOkUdrx+Sfqiu6bnOw0DnvvzIxnIqfrB/5E1R/IHc?=
 =?us-ascii?Q?dxSEX+BNUdg1wBHE7pS/BqWTI6S38OPRdLSDupXocV/kw1C8w4Uz+Z+tg/yS?=
 =?us-ascii?Q?gMHCN6JRBlK8C+D2ddn4TRoC7dR5QlNP6afersKYd3NQ6SX2NyGqHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLx8Tox6Buf3jXhhbTJO8m4CG0MyeXnCC8XI9lNThm22DmH8aveUdsi0EjZu?=
 =?us-ascii?Q?EoRvEK11bXXPk9V7rAt1tFZ1xbsciDxat693eQo61Md4zv+XKo9lr9RqYnoQ?=
 =?us-ascii?Q?3t1ONX5EHpUYuJOm01PiqPiAgB6c9rre5UctCLi7LzH9v/UrJbqu3SYouDVe?=
 =?us-ascii?Q?wASluhVrmjGD9xsXtYH4EV8L2bHLTBdSEdI/8qpHGar5SM5cIknt4r8NAGIE?=
 =?us-ascii?Q?6ewEX+snFPHunwZengse5I1TWMKk0JkiB03djBxqBjDjfzw6wAvRGiEl7HnL?=
 =?us-ascii?Q?aRCeh3MeDUsSkzqvzAtVbMLnTpOHSt/IlmSdVNtrf2nzD9gPZ2iHYb77DMrZ?=
 =?us-ascii?Q?EPXhW2HxQSC8PUGv3IrGY6lqL4RxMgwhq06CU6qSBexfsbTLFeNMaD9ghnB7?=
 =?us-ascii?Q?UM7OTrLBigob+H5Y1CNLwjQoWRKBCAhZNXQlX4NLyImPXKHd0HDNWVYS736c?=
 =?us-ascii?Q?rcNzRzA2+xwP++vTnl0twbElRIvvG9aYyP2gO9o/bxGVOlQqY6AqiBpNSRCS?=
 =?us-ascii?Q?hEchW9DajmC6Fwx9cclxv4g6zqv735zq6eW/H9d5tpQBV+2ZUQLoqDIrECGr?=
 =?us-ascii?Q?KcuUXl7aDR5HIqOkmLZZYZB1sLt1crRIycGPphU9NcEzcvdSrzfS9Vu2I74V?=
 =?us-ascii?Q?jnVpV9tb0+URjHe/3chDB4L5sVQ1N70lIiuv4ME6txhJfe0SsK/wUYD/5obl?=
 =?us-ascii?Q?r6gNDDhshClP+s0gxFolwRB5/ilUkY2UEOpsMk8Jb9Rg2xKE3vfja5yawVSe?=
 =?us-ascii?Q?oGEMtJaEwzdsWZ9noA0iYgE2wgJqiwIUBmPLFJmTruGEU4DkmhDXPLFxwHbJ?=
 =?us-ascii?Q?8tGzYjpWlaczlRcUYVuQPIlz/vJQDMp8iUOmM0o1bf+Zx5vfTp7xxUh/9PVG?=
 =?us-ascii?Q?iqAGHT7ZOkbJsLkoT1AzFkjGGPwJBVI5X89eptkQjtV4EM9jhElmAyF84TyA?=
 =?us-ascii?Q?i8WAeJoTyWymoJHgwkm46iqx2c+aVTdNcqgErk8N49r+wmYBXSCzeM79NIMK?=
 =?us-ascii?Q?7zJaVVna/6RH4O2lnkaFxncnUIpg6SHmg7BS+N+vrtM9tR0qQTPL2eoSuqev?=
 =?us-ascii?Q?+y+PI9eMG2y3HHOyDD3hDvXoCOnBoOTyM67/WxGGYIPmIc2j4AHRhX2Gglmv?=
 =?us-ascii?Q?B93TegHjD0H4Q8Y9/YNc/sTccbnypuyVMxgUz0r00kdCRUC49qGLwEQivyko?=
 =?us-ascii?Q?VJ3BJafD/bijXxpx2vBIQtBxhs75TvVB0GVvHVqA2Yj0SqheZP0PHUvy965M?=
 =?us-ascii?Q?4nX6aQ+Mj9keA/rOkseJRUPz1hOuerDSqHCW68BlWy8efhpklReQJs9yRc5y?=
 =?us-ascii?Q?TjWZ1fFzs0xQ+q5jZeIFaDIEkbrXnvTM54nOuAB7Y6pd6rTw4XoeoyHUG9tp?=
 =?us-ascii?Q?eotlZAXn6F9yyjXE5fKjZxdqXED+XdGpd+Hh2fI+klkwElj9VCrvQrwvFKJ9?=
 =?us-ascii?Q?iGGthDQ6aWgJrYGurxoZHztkmetHbjZjqGiBmgQ0bmdAQQgL32g8sH4+XIhQ?=
 =?us-ascii?Q?d5L36fXerXF278SqAomfMARv7vu/UwsGN7RXmJH1DXe5kMKc7GpiO04PrvIY?=
 =?us-ascii?Q?akEaFgFPGBQpCr/hMjo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f0d112-2764-4a56-45bb-08ddcde3f153
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:35:04.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K87zQB86LW4Vv/AZlf80mk8aGDDWGl0jOKsl6TOOUbjguM5IXN9bVzpEP6h+8lSOJTq//Dz2Kkyws5al0FXpNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185

On Mon, Jul 28, 2025 at 03:14:33PM +0800, Joy Zou wrote:
> Add i.MX91 11x11 EVK board support.
> - Enable ADC1.
> - Enable lpuart1 and lpuart5.
> - Enable network eqos and fec.
> - Enable I2C bus and children nodes under I2C bus.
> - Enable USB and related nodes.
> - Enable uSDHC1 and uSDHC2.
> - Enable Watchdog3.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for v7:
> 1. remove this unused comments, there are not imx91-11x11-evk-i3c.dts.
> 2. align all pinctrl value to the same column.
> 3. add aliases because remove aliases from common dtsi.
> 4. The 'eee-broken-1000t' flag disables Energy-Efficient Ethernet (EEE) on 1G
>    links as a workaround for PTP sync issues on older i.MX6 platforms.
>    Remove it since the i.MX91 have not such issue.
>
> Changes for v6:
> 1. remove unused regulators and pinctrl settings.
>
> Changes for v5:
> 1. change node name codec and lsm6dsm into common name audio-codec and
>    inertial-meter, and add BT compatible string.
>
> Changes for v4:
> 1. remove pmic node unused newline.
> 2. delete the tcpc@50 status property.
> 3. align pad hex values.
>
> Changes for v3:
> 1. format imx91-11x11-evk.dts with the dt-format tool.
> 2. add lpi2c1 node.
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 674 ++++++++++++++++++
>  2 files changed, 675 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 0b473a23d120..fbedb3493c09 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -315,6 +315,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
>
>  imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> new file mode 100644
> index 000000000000..aca78768dbd4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -0,0 +1,674 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx91.dtsi"
> +
> +/ {
> +	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
> +	model = "NXP i.MX91 11X11 EVK board";
> +
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		rtc0 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "vref_1v8";
> +	};
> +
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "audio-pwr";
> +		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		off-on-delay-us = <12000>;
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "VSD_3V3";
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0 0x80000000 0 0x40000000>;
> +			reusable;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&eqos {
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-1 = <&pinctrl_eqos_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +&fec {
> +	phy-handle = <&ethphy2>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-1 = <&pinctrl_fec_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg = <2>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +&lpi2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	audio_codec: wm8962@1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX93_CLK_SAI3_GATE>;
> +		AVDD-supply = <&reg_audio_pwr>;
> +		CPVDD-supply = <&reg_audio_pwr>;
> +		DBVDD-supply = <&reg_audio_pwr>;
> +		DCVDD-supply = <&reg_audio_pwr>;
> +		MICVDD-supply = <&reg_audio_pwr>;
> +		PLLVDD-supply = <&reg_audio_pwr>;
> +		SPKVDD1-supply = <&reg_audio_pwr>;
> +		SPKVDD2-supply = <&reg_audio_pwr>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +
> +	inertial-meter@6a {
> +		compatible = "st,lsm6dso";
> +		reg = <0x6a>;
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-parent = <&gpio3>;
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		pinctrl-names = "default";
> +	};
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&pcal6524>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <2237500>;
> +				regulator-min-microvolt = <650000>;
> +				regulator-name = "BUCK1";
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK2";
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK4";
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK5";
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK6";
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1600000>;
> +				regulator-name = "LDO1";
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <800000>;
> +				regulator-name = "LDO4";
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "LDO5";
> +			};
> +		};
> +	};
> +
> +	adp5585: io-expander@34 {
> +		compatible = "adi,adp5585-00", "adi,adp5585";
> +		reg = <0x34>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		#pwm-cells = <3>;
> +		gpio-reserved-ranges = <5 1>;
> +
> +		exp-sel-hog {
> +			gpio-hog;
> +			gpios = <4 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
> +	};
> +};
> +
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x50>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio3>;
> +
> +		typec1_con: connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			op-sink-microwatt = <15000000>;
> +			power-role = "dual";
> +			self-powered;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role = "sink";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec1_dr_sw: endpoint {
> +						remote-endpoint = <&usb1_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ptn5110_2: tcpc@51 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x51>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio3>;
> +		status = "okay";
> +
> +		typec2_con: connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			op-sink-microwatt = <15000000>;
> +			power-role = "dual";
> +			self-powered;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role = "sink";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec2_dr_sw: endpoint {
> +						remote-endpoint = <&usb2_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	pcf2131: rtc@53 {
> +		compatible = "nxp,pcf2131";
> +		reg = <0x53>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&pcal6524>;
> +		status = "okay";
> +	};
> +};
> +
> +&lpuart1 {
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&lpuart5 {
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "nxp,88w8987-bt";
> +	};
> +};
> +
> +&usbotg1 {
> +	adp-disable;
> +	disable-over-current;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	usb-role-switch;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	status = "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	adp-disable;
> +	disable-over-current;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	usb-role-switch;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	status = "okay";
> +
> +	port {
> +		usb2_drd_sw: endpoint {
> +			remote-endpoint = <&typec2_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	bus-width = <8>;
> +	non-removable;
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__ENET1_MDC                           0x57e
> +			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x57e
> +			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x57e
> +			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x57e
> +			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x57e
> +			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x57e
> +			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                  0x5fe
> +			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x57e
> +			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x57e
> +			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                     0x57e
> +			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x57e
> +			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x57e
> +			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x5fe
> +			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x57e
> +		>;
> +	};
> +
> +	pinctrl_eqos_sleep: eqossleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__GPIO4_IO0                           0x31e
> +			MX91_PAD_ENET1_MDIO__GPIO4_IO1                          0x31e
> +			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
> +			MX91_PAD_ENET1_RD1__GPIO4_IO11                          0x31e
> +			MX91_PAD_ENET1_RD2__GPIO4_IO12                          0x31e
> +			MX91_PAD_ENET1_RD3__GPIO4_IO13                          0x31e
> +			MX91_PAD_ENET1_RXC__GPIO4_IO9                           0x31e
> +			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                        0x31e
> +			MX91_PAD_ENET1_TD0__GPIO4_IO5                           0x31e
> +			MX91_PAD_ENET1_TD1__GPIO4_IO4                           0x31e
> +			MX91_PAD_ENET1_TD2__GPIO4_IO3                           0x31e
> +			MX91_PAD_ENET1_TD3__GPIO4_IO2                           0x31e
> +			MX91_PAD_ENET1_TXC__GPIO4_IO7                           0x31e
> +			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                        0x31e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__ENET2_MDC                           0x57e
> +			MX91_PAD_ENET2_MDIO__ENET2_MDIO                         0x57e
> +			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                     0x57e
> +			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                     0x57e
> +			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                     0x57e
> +			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                     0x57e
> +			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                     0x5fe
> +			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL               0x57e
> +			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                     0x57e
> +			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                     0x57e
> +			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                     0x57e
> +			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                     0x57e
> +			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                     0x5fe
> +			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL               0x57e
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__GPIO4_IO14                          0x51e
> +			MX91_PAD_ENET2_MDIO__GPIO4_IO15                         0x51e
> +			MX91_PAD_ENET2_RD0__GPIO4_IO24                          0x51e
> +			MX91_PAD_ENET2_RD1__GPIO4_IO25                          0x51e
> +			MX91_PAD_ENET2_RD2__GPIO4_IO26                          0x51e
> +			MX91_PAD_ENET2_RD3__GPIO4_IO27                          0x51e
> +			MX91_PAD_ENET2_RXC__GPIO4_IO23                          0x51e
> +			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                       0x51e
> +			MX91_PAD_ENET2_TD0__GPIO4_IO19                          0x51e
> +			MX91_PAD_ENET2_TD1__GPIO4_IO18                          0x51e
> +			MX91_PAD_ENET2_TD2__GPIO4_IO17                          0x51e
> +			MX91_PAD_ENET2_TD3__GPIO4_IO16                          0x51e
> +			MX91_PAD_ENET2_TXC__GPIO4_IO21                          0x51e
> +			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                       0x51e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C1_SCL__LPI2C1_SCL                           0x40000b9e
> +			MX91_PAD_I2C1_SDA__LPI2C1_SDA                           0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C2_SCL__LPI2C2_SCL                           0x40000b9e
> +			MX91_PAD_I2C2_SDA__LPI2C2_SDA                           0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO28__LPI2C3_SDA                          0x40000b9e
> +			MX91_PAD_GPIO_IO29__LPI2C3_SCL                          0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO2__GPIO3_IO27                          0x31e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_RESET_B__GPIO3_IO7                         0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX91_PAD_UART1_RXD__LPUART1_RX                          0x31e
> +			MX91_PAD_UART1_TXD__LPUART1_TX                          0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                   0x31e
> +			MX91_PAD_DAP_TDI__LPUART5_RX                            0x31e
> +			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                   0x31e
> +			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                  0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x158e
> +			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x138e
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x138e
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x138e
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x138e
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x138e
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x138e
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x138e
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x138e
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x138e
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x15fe
> +			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x13fe
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x13fe
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x13fe
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x13fe
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x13fe
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x13fe
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x13fe
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x13fe
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x13fe
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK                            0x1582
> +			MX91_PAD_SD1_CMD__USDHC1_CMD                            0x1382
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0                        0x1382
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1                        0x1382
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2                        0x1382
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3                        0x1382
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4                        0x1382
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5                        0x1382
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6                        0x1382
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7                        0x1382
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE                      0x1582
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x158e
> +			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x138e
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x138e
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x138e
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x138e
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x138e
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x15fe
> +			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x13fe
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x13fe
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x13fe
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x13fe
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x13fe
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0                            0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK                            0x1582
> +			MX91_PAD_SD2_CMD__USDHC2_CMD                            0x1382
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0                        0x1382
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1                        0x1382
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2                        0x1382
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3                        0x1382
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                    0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__GPIO3_IO1                             0x51e
> +			MX91_PAD_SD2_CMD__GPIO3_IO2                             0x51e
> +			MX91_PAD_SD2_DATA0__GPIO3_IO3                           0x51e
> +			MX91_PAD_SD2_DATA1__GPIO3_IO4                           0x51e
> +			MX91_PAD_SD2_DATA2__GPIO3_IO5                           0x51e
> +			MX91_PAD_SD2_DATA3__GPIO3_IO6                           0x51e
> +			MX91_PAD_SD2_VSELECT__GPIO3_IO19                        0x51e
> +		>;
> +	};
> +
> +};
> --
> 2.37.1
>

