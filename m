Return-Path: <linux-pm+bounces-32562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E8B2AD51
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C357A5F8B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5D3322C73;
	Mon, 18 Aug 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Huftrv74"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E2322DA4;
	Mon, 18 Aug 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532318; cv=fail; b=f0++tXmrEjQlYf1S9X436vIdkmJ1S09Q/Hs9zCsJ8mSVJ/c3JjbhrswXymBwR0PWKn8Ce9t+cDxmq75t51xfURJ1MD5LXrkmEXKmIqTKL000RMfULKkOWY/7/dfHXWc0T1glH0OIiam+yo5uHZ/DMqSPfF/3qtuJAgJksPvCPKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532318; c=relaxed/simple;
	bh=hd3hDuj+W/pesq8DdjsPHeqYT5Z9nhB0lTyKsqWk8mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AOuUWNQbh2BKd8dDaXwW2EqN4tz1ztmVHIa66rDGFdDeBHE9yP7MM6zFU1JE2OiMuyfqS5YUWInzkdGvRu3+lJ2HsT3qxUvlP/jgvKg7y1mYEEwDvdPNQ48ZqwRHimUlSk9gLG58gXOI8+7CsYJhSXfo/wpxeGMLifU/jqODRBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Huftrv74; arc=fail smtp.client-ip=52.101.84.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P28mvCJfXV2puMVPdxTmylCQ5mIY6BkmOldC3eD3voU+xmfISoHXBkqL1/eBtv3+bcsqmfv3tBvegYTG8TK2TUFrjtTfwM2JBwD+FfPXCEsHk7urbB6AIkHUtX0aESNaLSUwKKkg/fGOatW51Ff0l+QF4rP8hn00KdAkcYJ3dvpbjLUQ3r/hTe24xiksaVyinR4/NWRbatPHfMnSTP8V4U8SqC+VItNtALwrpE/AcBO+E9KE4KMyECQu4YWvtc8ewil97EUFkc2z9cS2p/laFCcwL6+thOvnH/HXMb0LvvetTg5AcxmxbTNrM0IOVaTat1hAxcTn3RbeNZ1+aRhTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l4T3hlyvkl5KEwR9rHnCdg+KpcaOhgb/Q1FbQYXkdE=;
 b=R9Y7xz+GGIUY36r3Wz6O/eiblV67jopsb1jpdyd8dyGjVdmLnsMq789tfYErM8gxPQ4StLbrg/QX9M0X9LerTJmOrHqGlFo/B6FsNqZL7u6+tyE4Chx8OC6+5Lu7jTLsz3aA7hBOJxcOLWV/EiQlHQaZlk09H5Qc+42KalUBOvXCR7irKTpeLAkkeWGp83MQPwJh53ZSKESWzeQywkySHE1psVtCkuHmhxx0NNITPDc9ZTINBNjmhKk0CgSE07Ojg/sdgQUwFs5Nw2QHVDmM+wpkPddiejFcW+vVGk2a5nwNyYN/jvEeRcintW+FLUxs07NUvIi6dqpWk80ilnKQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/l4T3hlyvkl5KEwR9rHnCdg+KpcaOhgb/Q1FbQYXkdE=;
 b=Huftrv743zc20wDJoyHZuRaBseXfCM4LSbDITnml4FYm+28pyt/5LTWtQ4U+N4572OSadnqmlqgtrED01lm1/kD1Zmi12SeEDCq2Bwt0NYGczErTh9vgXNi1hgWpM1vZNpiqiVTohk5OX3/ar7VMspkx3JZQBvzrBd7x7i4Z2BG8qWwg6Z4PnyUILG/q0pXJhMqh8Nzyku6LSi0A4VTKn0csA8aoTrNpis+wxj6tEmJN8lU6JwLKMo9L0343ddsKL5YCd1xEgtl/M0xIDbSwe7dKIGChMdSFpPaBVNZQzXx0r/GWvI8fCwLb7GaTnHxbQJocZ584Ky2OYI7jBn6jCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10078.eurprd04.prod.outlook.com (2603:10a6:150:1af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:51:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:51:53 +0000
Date: Mon, 18 Aug 2025 11:51:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: imx93: update the tmu compatible
 string
Message-ID: <aKNMELFFI/qX3MLT@lizhi-Precision-Tower-5810>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
 <20250818-imx93_tmu-v3-4-35f79a86c072@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-imx93_tmu-v3-4-35f79a86c072@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10078:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cb7e3b-ce14-41e6-77b3-08ddde6f26ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NbzxodIQ09qraGQfi25xZ1VoXTbSswyj0H70SpYAZoaSh2W5ZNCYOaQQYXN8?=
 =?us-ascii?Q?XG6vrWbdPHmu70ufDJ9lkbyqqaOpKMlN89gTpcJldbOoCnkBurfye/XesJft?=
 =?us-ascii?Q?qKyioUKSl8WwzZ0k++tN0Z5Qq7Ji0q1BbOIn/3YblqjTr+KdgaAasSBCmiXF?=
 =?us-ascii?Q?jtRdXAAELi4yx08YUm+Aj8d7Updi5z1YG5b9XJHHrwipZ4NcD5ALCwdhMmUy?=
 =?us-ascii?Q?BN59J86EdhuaNuaB2PhyV/VMnkRWic3WN8jNdGpP3xAftMrB4xawxSVF8GX8?=
 =?us-ascii?Q?Esb7ZCTRvT93a1UD6th/WBrRIWgXtpjSvTpsNt2P8ag6s04lOSnHRrqHUGMR?=
 =?us-ascii?Q?0GJ7BPLO6HO3uHrCRCCVw0GSL95ZrFxH9vAa8vcikvujriP46a9CIDjKxUyR?=
 =?us-ascii?Q?eglBcalekMsjjs7Pgw5HbCsL/0vx+fM7tAqDV6/usRgRqxc9K1GI4X9CArgs?=
 =?us-ascii?Q?TsJ9iayLX5fF63/GnRwyn9xLugJ2hyhWNkhFcZTXj3AJdJ6JMUCEHdEKF7b4?=
 =?us-ascii?Q?u0yvXeouD43CK46SR67BNHYNfns4z9dOZwS9Bm7DozqKoM7+jv0tESFlGOMt?=
 =?us-ascii?Q?Ng/6gZTSD5lP/PFRueCgQ/3cno4IUACSC25h83cwBoAcW8U4PPa3yWC1T54R?=
 =?us-ascii?Q?+JTDYMD7D1/qPh92KDvYnl+lTjzlKMZ+f8GbZn/GryEB2g3WezZ2XXKDqlXi?=
 =?us-ascii?Q?1l5Xn0QpTrg6FZyKzdM3zwsA3ezwpl0uwbY0ecChUgoQQrkmsFGnN+oAFVnq?=
 =?us-ascii?Q?G8j57pWHHtNAKhmFmyF6IC2FJ4Ia7SnuxXSh6+2YvFixpSG6DZlyIS26w2//?=
 =?us-ascii?Q?o3Q9J6LwsUPAjem+HDSvFpjnINNdorR0m0soSk4+0oYkK+1z0DbkNYvI/yG3?=
 =?us-ascii?Q?5EhLGNGf32CclLt7+pOscqQMXwXxcw7veNZnJJxJbjt/XP7FC059GVzAMcO9?=
 =?us-ascii?Q?tv2VbqsMnA/JcjBbBf0a91t5g99xSG3pjk/f+K9LbVg/ii8nZLoSqkMb+mlb?=
 =?us-ascii?Q?Gijs3pgSTJOoxUKbu6piY6BjBu8QoOYBqlmtgM7hW5Xm0widFmq0s6ARpAqh?=
 =?us-ascii?Q?AMkYCboQ7vhebsD8xCYWHP9r0LVJim31Qc9OjPpVtYxKvTGtidvdyYbo8sMC?=
 =?us-ascii?Q?MQ4+luieRwDdm9GFij7HFgxuoG0CLdTooWlcFBznMMLLbxvmYLBo+GARnXkn?=
 =?us-ascii?Q?jcvW3lmWwUj9656AeabsW71Q15KxiW9S0uNuUMXH4xJGgpKkaPPPGUcSiYbm?=
 =?us-ascii?Q?jH3P69xqeWztQmZBpyvUsfoZuS6QIZ2CM8ODKhLMAwD8nZR+tKjukl1Chf2k?=
 =?us-ascii?Q?3f2w+KNs3DxCs1fH0Y53bunEQy3H2oAvErbSPUdHK7H6XiJaViv64fCL3nZc?=
 =?us-ascii?Q?zjFJH6eOY4HpDqPXJ4Z2b7RBiDyUZCDWMV+APO/jMEVoS90N7YqBacG+etIU?=
 =?us-ascii?Q?9IHf5jMmoMNJg2DmgTOKq+agGRhG7e3nARZkdXBcGxHHsej+NwMiPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AuCkOZy9d+popBP2nITYeVWjHlt1DhDI27uJNJxN+gFAPrKyO2cqY9v7uZnz?=
 =?us-ascii?Q?yLqBID4UpBsOUulGl8nCaidEvnoOlnHDQ0lygYmIsixZCBVfG6Ac2jemfubR?=
 =?us-ascii?Q?lAU3eEiA2TWmNWHYiWjjj9LjqdQpKnENBdlqd1NrnhwtZ37U05Se10h0PIEZ?=
 =?us-ascii?Q?NRpH11a6n62cW64U/kc74zM8RQ/tu39f6NKWC6lmbXX9+KjI8Uvd5+yq8M1R?=
 =?us-ascii?Q?qtjJ+7pUY6XmI9muN0ZUiVfdcArm/UV6goB01h2ip9RDwHDnhBPSDdJ/o3C+?=
 =?us-ascii?Q?Un4qtTcIGfLAm1Jtrq/VuYSGliB+21hrnkD8q0KrOljqOPUkaLVIRwHp/Xj5?=
 =?us-ascii?Q?FlK5iIQTHyJijg2BY5ppEYUxEqdObKZS5OrfhOy4bc/th2GZOCvNLwaU9ImO?=
 =?us-ascii?Q?gXOz1Bg0c30UnQS/mASGUxsX8jRT/D7x1pTUUdIv0ACjZLoBQyRcF0zS7F8a?=
 =?us-ascii?Q?g9Ij0O89XsQOtLAOYeLivrTKgsuAAHIYmPbb4GQfInbCbSZk1VqPDUciPhuN?=
 =?us-ascii?Q?s2G0QdCbk9CMeprvcwRnIXGax54pb7boEoxPZam1AxBmkaY/O50Chlzb7/mW?=
 =?us-ascii?Q?QptuQD7lKmDEyvcAvL79SrhILlO4PqILyUZXlvJczMvEkZzVLfKa0IaElzGu?=
 =?us-ascii?Q?xxQ3Tr7B66cms1y1+webYcmbFzlBbi7eo/XIke4BnpSF+87Nnoj4Lw8Tc/q7?=
 =?us-ascii?Q?cPCMsXJPQmkonMySrldqiyNfBiBLI4CSbxPQfTK8fjWrUUPLiAtv5/J9Wftb?=
 =?us-ascii?Q?rLm3dCMTsBhuYgf6tTKwIx2dy46LEekseFuWTjeN+/45MXN2wI2VRNX9OWZ1?=
 =?us-ascii?Q?K7OkFi24p1fbA4aNwGmN9U7hFXDVHSzLI4NThsWHKPfDxmEKbEh5IEv1x5eY?=
 =?us-ascii?Q?gCACd+Pcm6zZMxy83IdnwVj0n6eHO/PzLtZCNrZQhXQv8gjjKdwQGWVtA4Yb?=
 =?us-ascii?Q?mIpUd5DWhAPZfFhNkmy2EUatxROskGc+8Om1/qCSA8jGxmeQdtoEDXtDmpIW?=
 =?us-ascii?Q?JS6NmpUoL/xllJb2gZ4i+KkdK2JPGIVuF5UROD/MMnBlBW7pTW7S0asY21bM?=
 =?us-ascii?Q?cTa7HLfh+JLh1X3miOYgsKedZ7+u8HvXVGOeYgyYx0rU8IaO7c27ZbunNy8v?=
 =?us-ascii?Q?T3HWFwh/aKB+zHAmwYVjT/p7hjQ/pRIq4q2E07TuS81oFo7B3QaQ2W3SuItj?=
 =?us-ascii?Q?hFgwrev2h7Dds7a4r1e3tFN8rBIuEYO8i573AdKuwCdHH7iY/l6fJQjuh7i0?=
 =?us-ascii?Q?aF2NnXh22ciCXGWn+Da0QndOwdNkxgSMeQXi8bV4zHc0/37AEHkmMsEemMx7?=
 =?us-ascii?Q?m+gt1s1XlqwpYOHYjdA9NXO5FR9QvQ0/OdHBzaALDkmNXsV2dWzLZRl0rThU?=
 =?us-ascii?Q?diAzhCUlaFi+teyyy7Dn4BigHJMsBTds/v8aYEXlN66zzLBLICYNT2BJMiLO?=
 =?us-ascii?Q?psaJP5W2iQcEv77YIT2542oetR6svMZ8yCk+2qVZnIPZXsuUiLGUHa/IFruG?=
 =?us-ascii?Q?iSGFeISDPMylGVZHX/lXfDLDtmUwk5NdupYQQ4RDSEntKXdFG+daaIL1LXGv?=
 =?us-ascii?Q?dBFH5pGHh+Fuj190AG+WYSeOO35YY3KOhFneF0Sp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cb7e3b-ce14-41e6-77b3-08ddde6f26ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:51:53.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXJnsyi+puhPLtRDptujyCOocnICELWs29soflUhTttY0tifkZtSsutVOnc3M+YAy2c5TIN1yFnk8RD4s0Rarw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10078

On Mon, Aug 18, 2025 at 05:33:14PM +0800, Jacky Bai wrote:
> The i.MX93 TMU node compatible need to be updated to apply the SoC
> specific configuration and TMU errata workaround.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  - v3 changes:
>   - drop the qoriq compatible
>
>  - v2 changes:
>   - no
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 8a7f1cd76c766ab558acf5176022a4c42e648548..8ae9a81678bd37f394b437f1dd6ebe67cd1ce439 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -544,7 +544,7 @@ clock-controller@44480000 {
>  			};
>
>  			tmu: tmu@44482000 {
> -				compatible = "fsl,qoriq-tmu";
> +				compatible = "fsl,imx93-tmu";
>  				reg = <0x44482000 0x1000>;
>  				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_TMC_GATE>;
>
> --
> 2.34.1
>

