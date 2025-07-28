Return-Path: <linux-pm+bounces-31488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D72B13D48
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958D716EFED
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB391E573F;
	Mon, 28 Jul 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHbL4NGW"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB21DDC23;
	Mon, 28 Jul 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713345; cv=fail; b=ijAAedV+y6ezA2O06LzjE3AEMPhI4UGuJZASAf0H4H5iv3CAM7TmLo2OLKLQRDj5sB3rmV/ekoDVJCTVxTjDMOeIGOvZE/znsRj/GSaeX2wWl3QKa67GHqJr2RHoOnW8u7lUBSQxAXuxH+AHSfqEDUr8N7Us2RfoWbYsmTEkX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713345; c=relaxed/simple;
	bh=8uzLi1P/ayymgBYVig4IeY5vBD9Iq8cyvMiNSbanGrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=me9JsmNO/UCtyHNbM2Kepnf8ciZGc6VkDcmetaffeSTV/W/my4A8T6ujWxPjdNOX7fmhC0dheSu2Z3xeR4m/7fHk2lFyYZgkbsYANxIbf5oo/6Tvg1FyF5YsVDUkbhg/n90Us5ZXkvRYB8BciO0Cll+AiqYJuuAAJkHt3D8Dgbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IHbL4NGW; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbNKXMR1j2H+uDc4RJ3X2iMBGhTruuwZIgw+cW4MYWzJaFL/QxXzD+8FBApkDLHkidWLc9JzAr1myboOIEFvtCeL7qiVD2FBw/GQO0Fj//tptD8HZwXL5axcio7Vu5Iz6muqZEaAs00ztzToC4GqgYdgF2Nj1qgHO6HSRc9Fka+YTlvdS0wABOu3Udl+2n+wOXTXY/7ahanpTCPhCIyCIRZrZTpw2IsTmnPcjaHu+vHCfreoSZPRr5KQ+R0XO1Py4N7Sxm3JY3uRlInF+qe7sMw8tXIP5EBjc2q6kodGjC25Z/DGFJWvPJsaZaCpEH0+P1COA4qxCiqJ02nz9VsyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PtSS5L5W6nLeXvIobkSMRcxTnob8gmfCIFSfsdWGcs=;
 b=le7t7MrBcoplWYQQtJc4GZorLbsr8CwgGAxMFZndUq3hDrHWOc4MZDnbNZhaTdqmVLcLzmsm/RoPa8Mjcns3jhW3Wgqrw3Qh0gDkOn0mTvd/LdkbWUYQRbspwry3ZZntnuSyIUSyJw8GvD/Sl9KZ5hVXeBscGyeScwLJbzbUwcR40BUKWNR3RtgAquU34Xf7T2marDoBoCzw159eKELI4X/qk4yUfeBxESkSlvfc+ondzojg1ZWoCvTL3FDa+c/G9JhTCihRtyDG2oxBXXaPWNBdPetIHNIA9ifjQ8PP0NsFDIsgJrJo3119p6E0OYlAVS/l4/WLf3EOaQ1DZXzQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PtSS5L5W6nLeXvIobkSMRcxTnob8gmfCIFSfsdWGcs=;
 b=IHbL4NGWDBlceRSuYXTuEyo8T7zRltonYUYd30cfKggRxGYcKHsjpuZ2xYkIJL7wo13iHLtohKb57q5EOifc6YI9nzIUK8Ds5acLjbDE0Tl6SlAtZXAymRFsyzyRrkFQKAP5rOw0Y5LaQxlpfRRP99q8oWkqSj8OSeoRxe+R/824xJSA1n4ULTobniBdpbuhZRAJ0swEd5C84HdrEAR1NZqzI9kt7f3D+NElmoWINWh6v7Hwho9pyCjJ1EjgVzDV/crCmskgl3doutR+T57VWmUPkMImO1o2N4Dlo8wb3am3wNQT0HAHuSlDQfavkV0yEpuMpWP2Mh/uakQz7vhBbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:35:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:35:40 +0000
Date: Mon, 28 Jul 2025 10:35:30 -0400
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
Subject: Re: [PATCH v7 07/11] arm64: dts: imx93-11x11-evk: remove fec
 property eee-broken-1000t
Message-ID: <aIeKsuiDM5kaa084@lizhi-Precision-Tower-5810>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-8-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728071438.2332382-8-joy.zou@nxp.com>
X-ClientProxiedBy: PH8PR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a9b88c-f70b-4eb5-3d1b-08ddcde406af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q4GoWneb72d+i82gK0i/k6VTDs9DGvVe0BoK70rGQocZU6DsbTPblYPiW7+M?=
 =?us-ascii?Q?duDlb0hPl06OwN1jHF4+NbEFCDogq6mD6h+Biv5YCvdvC3Gw8k4CS0ciB0mo?=
 =?us-ascii?Q?4jVNocHd5ymUsN+4Y7a5VNfFZwe6jfAe6R5KZV3845RHgZTO77YssOqEsPQH?=
 =?us-ascii?Q?L/3fE5Cet1ebIckJLb+TmZ77mM9/3iL74sV/ZwN9P6/Q2AsojXEMTIN/oD/X?=
 =?us-ascii?Q?x6JMyOLu8DYC1yLqopoSH8w11UAVLs1YYHZA96Vo3YHpcAWvPpoLxvj8W0UJ?=
 =?us-ascii?Q?OMLKFZhAaTq860nnDQx6hPOwtspJ1PBFiz2VK5g4pvpZS1IFQjOvkXxaXFL9?=
 =?us-ascii?Q?Cx7rvKGqbMSJQo5zvoYNariwkdng5eR63SYVWFDCRvxejayNQ76xMc5U33gf?=
 =?us-ascii?Q?xCKVfzB8H5+yxuk78ysGogYI5jY1HJYeSIc5ATyXjh8hvzwATfPU1I+HYSBV?=
 =?us-ascii?Q?cp/vVIWA4fShVccfhOzHIajPlrjB+v61xqEfsG4RGzIYDcdUrzojhwF28zRp?=
 =?us-ascii?Q?/HrzUyU7NuGbMTTgiUTuDGBZk3dW+FdoKtF1aKBzOX+6Kxtr93DUKrt0DTOt?=
 =?us-ascii?Q?Lr21kQe9WcFg6qSheCaVTvN4lBL+tvS5WE7EPB9RSw5Qmzy1Lb2DqeUwUgAI?=
 =?us-ascii?Q?kmpUCd0NXYTguEHcq5xXiUzjdTlQshFKcYc6UHNZblIqvDgurKzJh6dLcrBE?=
 =?us-ascii?Q?KLRvir6C8XHjVxf/t5RbEbehvKEPrqjJ1ZxDr2R+0Nh1s7RWQAAfTqoKUXpL?=
 =?us-ascii?Q?OiM2VL/KKqgJDB7iJbWhQ57gOdwcdIR5H5bVOhFoOP4hiIxCK3vc/vF64SqG?=
 =?us-ascii?Q?dw+MiQnn3bEuRS4H/arbNhVw3F2iIhbEoNmnZ+1Mo7FXuox2CMN/Uw1TS8QR?=
 =?us-ascii?Q?hvUtQOqlxFqCNYSXbp2XnzHrHOq22bYQlk93QdGsjFBKrOrDngVOKbDUFWUX?=
 =?us-ascii?Q?pB2OngAX31N90HhlCGG19/By84fMo07xeor44cXe+Uf6Wka75j28+f4+EAB8?=
 =?us-ascii?Q?v8ZnghXXw0aCBMDJ5Ve534sYTU4RJnYDY2ckruJmeOdYUJEqLtmC5RthmLzd?=
 =?us-ascii?Q?VyZhldDn9pj8BnVaBznxGnG+rKEcHs/nAXSz60LbdDv1wmI56MUKwMk4ZQax?=
 =?us-ascii?Q?VpNIAzMwOG/otZFtsMDF4jaMNhUlQDUSNrDAbZYrGB59cRiuhz+wAB8L8+pt?=
 =?us-ascii?Q?IJye55DxylMfWYpcMw7Kq8IBU6OuoNqVQbrJ6SSZB8uaIrEuuW+LiSyqPlMQ?=
 =?us-ascii?Q?lERPKOLLI/SoSOPXmm2dfigsy0I3p0yFxYb+Sw9GFfO+E0tyky1uu9nLlEE/?=
 =?us-ascii?Q?zPw6dTpLpZfvk0gx/0LJAY4lpPolqrK2YGox2L0krWOIq5/QOK4StUZJgZlH?=
 =?us-ascii?Q?WXHXfezYRJchX7Z2DeAaOtkC8BZ2brKmdrrcL1mDP+IHVuEj7etYHKS2IOIG?=
 =?us-ascii?Q?qAg6YXZzdaxpd/V1PdAUytYTgDoc+xrYwdtzCofl7BdJL4S+I/pkgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CAJzfTa+GwJ4LVZZW9ORVqIY0X1VOdfZo8clFVs4cqmlLHZhALpFlQsPHOV?=
 =?us-ascii?Q?zDw9lgrgM5OIOkIA6Dxe57AhEE22Z7BhJCHDOK1X7FEu7NozOE2d75Tb98kK?=
 =?us-ascii?Q?F8R8D2Q6U2gGcmF0oAhgbIxGLfVKEd+8sn4Fm1eXUfeU92b8GVMdUSYEDK4z?=
 =?us-ascii?Q?MrOuyk0GanqJR9HwxF2KDLdPAVjveLCE4ObaGkO379hyhk0j/XVE2xIWUw7L?=
 =?us-ascii?Q?hG/MtPmwo3E3eoxc/cCO0JL97dtrTniBTnRT+8YL0pZnbXfLiMOMq3LAGG0Q?=
 =?us-ascii?Q?Oz6L6zFRg1mCRF9w+wdkayBZdzmROjwy0U4ov09T1U12dkgLSat3bQrXAFP2?=
 =?us-ascii?Q?EnMTpQBRMf2MVu12RFIlb38cpADBPgQ/rzY3Oxu7LcFu41CeR3ofmKnqxuhi?=
 =?us-ascii?Q?8ckhnHSHM0nDIvzYhtju75MoPOurW8I92qyBPhpLtL+S/ufJ8FJRzwwXydkZ?=
 =?us-ascii?Q?GtaL+/8mdpGGPR8irHMZvHIJUstQiiiDKeQ5n3z+BUR1qaW6wegTb8dFmZjM?=
 =?us-ascii?Q?3VEwdYy93hr9+HJ8+Y8p6R0knRHLsjA1I23NpmmaAL699qs/bIqoFUjtubM0?=
 =?us-ascii?Q?on8sAzx9wsAtYd7pQnjafMe/QvOPLFAJGOQ3588v44el7Z+CB+oHaHTaocwV?=
 =?us-ascii?Q?SFsDvOa61socP+jSxRL6UjzbC/nn6rw69dPuqNdXe+xINBi2iddQTJMgbWz0?=
 =?us-ascii?Q?EZpSho4tz4pplA4BQI13ko5eN7djpUIeZV4z7yICl4vaJQAOeswTOFHkasoO?=
 =?us-ascii?Q?emDy0fVigLa0UEUbOFkxr2f8Vo8ZCBohmm0cfrQM0a23G1IEj/J5T5aMUfBZ?=
 =?us-ascii?Q?0sxL/wuXMBjw9q3pFunawfp2mhuMZmHPweYYX0cM88L5XFKb5Y6YgiDY8ZK3?=
 =?us-ascii?Q?v8WSokRVdd2j/4Cf0tQbM+q7Ppz0z4rqZJ6oThXY3sr6SGim00zeHDfZyp33?=
 =?us-ascii?Q?ccSPwaXWMnAdI3kCKJIom5dP7SJf480JE1p8KEf/hzJJAxBAddgyh+B/5DK0?=
 =?us-ascii?Q?3CDt2khFkjBBKlikBST2vXDh0cYgCBMYE4+z7ajR+hNGt+IKMWJSVk4Q/Zz+?=
 =?us-ascii?Q?qPjKrbW4vtjXC2Jvscyp/GaJdZfKDZsOEGsvdilcXK8wAe/jf/5LCzLmsqm3?=
 =?us-ascii?Q?OSEzEI1/O50azHrLDKqBlxgzhkGeN2/BQDuL9wCkJNgs4pHUuobhh++zSrk1?=
 =?us-ascii?Q?PAtkzr7RKA5HqLxsFy4XMACXsJIvoO6BqzyVuJfoZ09qEJaKks/PK1EUdCz9?=
 =?us-ascii?Q?5ZNRoJ+eMhxYjHNz6wORRCAeSM0bYQTjvknCmJH6Jgo6aXAz+2vwtyHCVCFl?=
 =?us-ascii?Q?ruLcuT6/Osr070v6mOZ31dfhKEkQacg6ghoC29WOszjFnpJaLhCUNOb++f85?=
 =?us-ascii?Q?QLzsfArLk6Zv7oQnDmT4uIlN1XWKYnM5U98hjqmqGRzA32MwnOQIWpvOXsTw?=
 =?us-ascii?Q?kFyj1AiWHKe1bzam3OiNCc6e0oV3w7MIVT1aGHgU2zXM2vnUpiEJETXhQdqu?=
 =?us-ascii?Q?Yh/f04F0MbZ59zRFDS2PXOjH6qgSJFkYkyMou/MsDC0VDq/5727Y3HLbFbrC?=
 =?us-ascii?Q?M65SLIUO4QApYatQWog=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a9b88c-f70b-4eb5-3d1b-08ddcde406af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:35:40.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voXT9jxCRWIS1l0PUgxkM6hHQtfqz1nDXG3NKEC33pC6YvQ79/0ubhRGgQa7o11jK5AyCOTfamnKnmzx6mh7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185

On Mon, Jul 28, 2025 at 03:14:34PM +0800, Joy Zou wrote:
> The 'eee-broken-1000t' flag disables Energy-Efficient Ethernet (EEE) on 1G
> links as a workaround for PTP sync issues on older i.MX6 platforms.
>
> Remove it since the i.MX93 have not such issue.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes for v7:
> 1. add new patch to remove fec property eee-broken-1000t.
> 2. The property was added as a workaround for FEC to avoid issue of PTP sync.
>    Remove it since the i.MX93 have not such issue.
> ---
>  arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 674b2be900e6..5c26d96e421e 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -260,7 +260,6 @@ mdio {
>
>  		ethphy2: ethernet-phy@2 {
>  			reg = <2>;
> -			eee-broken-1000t;
>  			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
>  			reset-assert-us = <10000>;
>  			reset-deassert-us = <80000>;
> --
> 2.37.1
>

