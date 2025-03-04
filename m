Return-Path: <linux-pm+bounces-23429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8691BA4E75D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 18:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AD38857AC
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802D2C1521;
	Tue,  4 Mar 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1PRIbCm"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEB25F99E;
	Tue,  4 Mar 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104821; cv=fail; b=MW7PBbTdZ5jEMLk3bIja38sPnrHLsxgY86M5UmHSb2kXpNFdaF5TrID5681AoTi44frM/S/76ZWgTqIWZNpGrtZpQXJJ0CPRQjkn/a41K8BdX37T3G3cMBjpIerKfwkPYss+0SDXPqmQSH+nqMOMtAt3C2rcvlwQzDXxFRRjRU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104821; c=relaxed/simple;
	bh=RLUo8swae1tW7ZUJHxGMBMvt12iQeoXWICAX3bANaGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ftyYKPlT8mWg3hLkKGS8i+6UmImI5aPiK6t5pSrSInUfGpV5uR1RzWMYnqGbTC6/Tfs0ne3uIFz6Vkn4QtIarfB41BDGXqhB9QTGfvX7fvwt/C8f/Nr5TiIBo71viKIQ9dK9V2MRNzfNOhaCGCG9T/z5RlomyPsJ10ldsQ4vwxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J1PRIbCm; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pedbYHYbP/hq/SqsJiGA4eugLcJ+uhnchxPiVeK9spLryWaivoj7dKwmXut76YEJPdT8IpNwrubi+kPRH/zbx1v0loAkc9uKgBoki8TdkOoIS0Mp2fJhzYP46dt+v07GGhy4B0EUUDahkNiSdS6Tv/43Bi8xRge5+70k2A9n/VyZ3Z7Anad0zPrvU1RfIfgNa01tJhUS2ulPUKuRztR9U2G515Qsp2qPebOTaVvvvGpWtWBWRZGLOrF6s7nXJ1xzfZQnpOticQfT60ck2mYSRBQSqm9IFI/olbyt+4Nt2aSTAexkdIGKg6cdUgRQnOT2YfGMfdCv0cO4ZpmmtlkbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3jq+K9w/3hF8rR+MY5/EMA4G9TPGh8jF21WmzdkXDM=;
 b=eJJ+4DahYnIQlwOAg1pZL3JxcN4kmpT1nPL7AIll0Ac+lm+NTRYC9Z5W01tkFlvt9hNfguiBg+K6hGjLnvpz95LSofmYodQ0VHvHrPpe+AvC/drsGiUAK0Ght+XHjEFzTuYD/YFi7+HMiCJXnBGqOQHAWXAsmI4PNQpYT5S13OCF/21dCzJ+q56yBnGpjp7guVeiN8KTgCe3130ZekEb4FqO4/hk3A0il7ZCgKqR93E8Mi3TN62jqw9CU4TeEmeKSuFfaA/cQ4Vg1XHFBlWLes+ecnC/l2TW6c2soPsADAqzd9OEH5BSe4AEG7QLgVShX6KMX1qan1EysH2PjmscTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3jq+K9w/3hF8rR+MY5/EMA4G9TPGh8jF21WmzdkXDM=;
 b=J1PRIbCm4nBAdiBgjGh4oCiIHiS6XxhFOxJXHiuQt5x1DI7I3SXIBDhFhkmhMMkAAgtU3d68s17rkuKYPrtENUEvt5k/luG7olhlH6JlCHfT2Ogov9S37Cy3dLcqtAJhrRs1t080j6FDZEy3ay2hGF4mdyMYwN/HNeVanz9zhyssv83w5ot3iSb77VVMlTfYcUKwBPNABbdEFLvFtpaxRCw+uEv6n9WATXB1qX/RaL+NFI7KoDx6h31XzP9OqVeq1Bgy4dsG47TndP3f64eRD3h09fGCmd2pNu7XVqmHk55078fUxRXviT4ybVi6ONfgxu7kg7b5UTLx2/OND3I6HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS1PR04MB9383.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 16:13:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:13:34 +0000
Date: Tue, 4 Mar 2025 11:13:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] arm64: dts: tqma9352-mba93xxca: Add LVDS overlay
Message-ID: <Z8cmpPy40ztL/hA/@lizhi-Precision-Tower-5810>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-7-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154929.1785200-7-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS1PR04MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6ac5b2-07a0-436f-fcfd-08dd5b378360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LmTIIxztn15cA9vLaQcFsaJqxtmnjzFiNjCESWpvOaXCVtnUYr8/G3qw/pMU?=
 =?us-ascii?Q?0bl1V4dycW+esbaV/sIK5YIVUvnC4FcM977tIl/Hm9qqEPw6Bog2KaClcQJE?=
 =?us-ascii?Q?1g8TjhEeXoATD882sMROnRgx9NjTcZgt2jM9a9DCjC+veYc7Hibqyn0JBuk7?=
 =?us-ascii?Q?xjR39msPZ69rBvG67L4velaK0J3AGWNuZU1FJiJVpC7nKtxyGiT+UUisaKsW?=
 =?us-ascii?Q?ZagAxuig55OXX5ZbiGKaEoZYERYlzEvX1UevorpEnPif0ysp+isNL4tlUKvB?=
 =?us-ascii?Q?vClGRqBL/MNC2UfVa7LMVkw7kFKO8eX/yy9/Ow7eeC8bfz382vOqAnurcaMn?=
 =?us-ascii?Q?1Zenb2dK792cN5WsLD/3U7PrnEyGsa5psfEc7mXc9887UaUxRRQqllY29/Rz?=
 =?us-ascii?Q?iEgrn5yeXRpSKRIbCrNhqi2EH+Y+oH57w11iA+2BzrDGb71Hu2h2EHucZxIb?=
 =?us-ascii?Q?cLubkP4xqRWUdyoiSfqh1YcZesIR9GeZtyvAsCZw4Gjo3M2jPDsKU/PTSd9b?=
 =?us-ascii?Q?vK1T62lFPKva1xUQlIxe01SURvoonJIhjX54SVBprYrnroynJ92OimGDIVVx?=
 =?us-ascii?Q?yEgg2yEJnUuyNrQ1emGERzGLUOMu5xzKmjsI+vM8uKbPs0dOo4V0Vhvopofv?=
 =?us-ascii?Q?+754Qnrdwm4s32u8JlWI5mirCvB3d1N5NvED9gxHTbVD1dmkaymGSpNgZnex?=
 =?us-ascii?Q?a3g2IOUKcsK8+/DOvIuhVu0aD1IH6uX04STJ4pAggiBYZapkBF6B7lGsucjc?=
 =?us-ascii?Q?5ARiMD3wy+Jy3FCmvKIM1+QFWRqZe+5ioqV8ewe3+6kRQuq+yxt+z3PH1hEC?=
 =?us-ascii?Q?rWPCa8qfqCUJOz661gERv14Xc3vHYJcGZNN6xOy7bhk74dd9+BosyoFmh10z?=
 =?us-ascii?Q?9WdU1NLJBomV4Tq7i+tLdL7VkztyPw9ibrfBwcQs/M0sw+9yQH5Gj/ELCC6k?=
 =?us-ascii?Q?0g0pH5i6mSsAQqRsPmkZrNsp3kp9+6vdkYUbZpxFFzIFJ9fnOgCY4zONEenF?=
 =?us-ascii?Q?EPHE4LZq8ciPJ7BwL+S7fDZN2EeKE4nt40dLzmehvuSqF2D4v7hsQhI/EhJQ?=
 =?us-ascii?Q?CTKqGqxjf+ac2Vl0NsPlftLrmpO/vMs64iq4oCsiUpi5g2WLK7TVyZYsKHP1?=
 =?us-ascii?Q?xfGStDqUUDWNKypJcymtDvgZQ0F7DZuR1MPE7jcQZ1WXKLM3LFSk2KKx2SwU?=
 =?us-ascii?Q?et3/qddRQwTK1wyPeE1Ss6qd6VfzQgFffg7RcUyaTnU6zS28zw9Fnk8UEOgn?=
 =?us-ascii?Q?IXAfaLDYdnbuRQLba8V3++aSoHcQJyigGv1o6OwNZXbOiiIftKR8GGyz4anx?=
 =?us-ascii?Q?M4l5MhDbyWoYgIjwi5toxCHq2hPhi67f7EBsd3d45yYhc/HlLjdufqNxz6O4?=
 =?us-ascii?Q?znchn9s4815BO4oZcwasy7pGO4D9GPqsJkfER36fHl8aFxij9N55Uj2bt5a4?=
 =?us-ascii?Q?BIbL46XDXnZgk/GgIpJ6TQEKt/Uy7csT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTbGZ0yviVWizCczzHsE8kzpdqZ4OzCyFbTgbjNgjUiC9hTqOND6V0/EqK2s?=
 =?us-ascii?Q?5qCvh/8LguHNBN09KV0v34BNPIkdACj4x/i5q6UsmWZG/sA6/D7YHZUp/6xN?=
 =?us-ascii?Q?J4MXpeNz1OVLNXZKpafVddyPutTVAuP7rZ3pWmMBS7ZbozRs9SeU6s03nYOA?=
 =?us-ascii?Q?DfE8UuWLcGo1tj/hpsCE+K1ld3StnCfQaFWH5IJQDQ/NVdcgG7vdQFsK+JD/?=
 =?us-ascii?Q?sMqlzrFI/PK6sIoYr6h0sJDA108SCX9zateb2kQX4CtnpoxdQPhWMGbWd11O?=
 =?us-ascii?Q?G9P90K57Z82MKlnHTUMnJiLele6KJ8xXjsi99itVUaUcFHCmDWncCk+xB9bG?=
 =?us-ascii?Q?NiRiC3m9xyljTb7IhzGx6Ea/mTmufh8U9LqKrlrYKXAw3tsgxncQT4hlXD1D?=
 =?us-ascii?Q?I/tQT9L4zEwk+UwlDdRAaD87zOEgQei4uqkVFf7Me/SKD48v4RjOR42eao3A?=
 =?us-ascii?Q?bPMCqOKH1b/l7Ne2sQUIl3ZFX4oul8kJ66O7jbUYme7viisQSzoX1uUxQwnx?=
 =?us-ascii?Q?KthT0LD7fmWRiruT5b6xneZZefSD1vL/p26miUEYtwwW/kDqKc5tt00mxGl+?=
 =?us-ascii?Q?xBvrV7StsYNl6GnQMq255xiY5l1cRUC3JSZkhCidr6uZFzi6ifOgm79/gErk?=
 =?us-ascii?Q?dNwiS6iO1OGX9SZhN0OZK2KUM93oKw352APocZXVYqdDXFHa8WLcKw2WCEMR?=
 =?us-ascii?Q?qkRY1ORcZxqtZoVlr+303YdxqGhJk+gkLxNkdwWddmjyCp1rg2j6quqNKk+U?=
 =?us-ascii?Q?OB1o9TkKJAT2tUpfdOAMImuDp0ZYhbREMNixKQnA4sobXUH9rHSliauIAOuo?=
 =?us-ascii?Q?boqbiVeKkoMOX+/JW0ywgI699e1L8xWudb3FZ0T5uAATFB7SnA4SQJeiZcMN?=
 =?us-ascii?Q?6sTDfAD4F9sjgZ+E9gYRsFgxmHGnnC+fm/2uIOjHMK0/mIxvkYxebNOOXUHW?=
 =?us-ascii?Q?eXB7OtPfCRrEprVBLWd7+w8M9Tk5y5p6mgPD17+QmmLAjMfpGgpni5MAOJeA?=
 =?us-ascii?Q?E93sBuo4CzaWCfdjjQ6Ra/Hguc7N3Fy12sBuLvCGOpVJ69mtUY5zkrhvAtz0?=
 =?us-ascii?Q?Q1K04tzuCYTjJ3nbQxap3PhPAKn7Ap5tZXzYZtJh9pKP0srBPjGSvJ/V7IMY?=
 =?us-ascii?Q?L8VBORBpBhsgv6jPBYqzc8cpv5n8qpZ3NatJzDEkkUAkaMVwshece7qtfo89?=
 =?us-ascii?Q?dYcg/XbrBPJXDS9QdNQ+YkpFKNfBeVH5aMbCR47ZeCo2sy/PmCJzMrryUi5a?=
 =?us-ascii?Q?lNYwWRI+9itBOXLh0wWuSJLtZvvT32QiC98nXnffuVwHjXKjcqlRsWdGccx4?=
 =?us-ascii?Q?uVBUQpwIFZubjxGN1LQheUrzoM8I2+2yyDSmnC1PqdGWqzTHy+hOwP6+Vevj?=
 =?us-ascii?Q?A/H/X8B4Ohf1kAMz7wQaPcm/iZrNTn9VM0nBxmu/bEbrvl6totAfZWvq9Cvc?=
 =?us-ascii?Q?3B+uB4tGUbEpyVveec983oCKXKYxKTdY05VRG5n+7hLl3g1yf6dFT9hXZxh+?=
 =?us-ascii?Q?XojNXB9PzbW+v55JTkPX/8ReKW2JMhvdB6N8uceQJ4ut0eOfBwEry+w3RLOl?=
 =?us-ascii?Q?utPACTwpfEOmJmHG66U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6ac5b2-07a0-436f-fcfd-08dd5b378360
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:13:34.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1jQvwqZJIfJMIwys/xhLTogAtR+qDJPqALdxo7bUd84mCKW3qZBNTelv6CZFJbVAC+8WhkxfC2797x91KHiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9383

On Tue, Mar 04, 2025 at 04:49:25PM +0100, Alexander Stein wrote:
> This adds the overlay for the Tianma TM070JVHG33 LVDS display.

Nit: Add the overlay ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  2 +
>  ...3-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso | 40 +++++++++++++++++++
>  .../freescale/imx93-tqma9352-mba93xxca.dts    | 27 +++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index ac4f14c69cdd8..48991e9a9c076 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -300,7 +300,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
>
> +imx93-tqma9352-mba93xxca-lvds-tm070jvhg33-dtbs += imx93-tqma9352-mba93xxca.dtb imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtbo
>  imx93-tqma9352-mba93xxla-lvds-tm070jvhg33-dtbs += imx93-tqma9352-mba93xxla.dtb imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtbo
> +dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla-lvds-tm070jvhg33.dtb
>
>  imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso
> new file mode 100644
> index 0000000000000..d21e5ccca2e93
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca-lvds-tm070jvhg33.dtso
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright (c) 2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
> + * D-82229 Seefeld, Germany.
> + * Author: Alexander Stein
> + */
> +
> +#include <dt-bindings/clock/imx93-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&backlight_lvds {
> +	status = "okay";
> +};
> +
> +&display {
> +	compatible = "tianma,tm070jvhg33";
> +	status = "okay";
> +};
> +
> +&lcdif {
> +	assigned-clocks = <&clk IMX93_CLK_VIDEO_PLL>,
> +			  <&clk IMX93_CLK_MEDIA_DISP_PIX>;
> +	assigned-clock-rates = <477400000>;
> +	status = "okay";
> +};
> +
> +&lvds_bridge {
> +	status = "okay";
> +};
> +
> +&media_blk_ctrl {
> +	status = "okay";
> +};
> +
> +&tpm5 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> index ebbac5f8d2b2d..e70c3995e89da 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> @@ -42,6 +42,23 @@ backlight_lvds: backlight {
>  		status = "disabled";
>  	};
>
> +	display: display {
> +		/*
> +		 * Display is not fixed, so compatible has to be added from
> +		 * DT overlay
> +		 */
> +		power-supply = <&reg_3v3>;
> +		enable-gpios = <&expander2 1 GPIO_ACTIVE_HIGH>;
> +		backlight = <&backlight_lvds>;
> +		status = "disabled";
> +
> +		port {
> +			panel_in_lvds0: endpoint {
> +				remote-endpoint = <&ldb_lvds>;
> +			};
> +		};
> +	};
> +
>  	fan0: pwm-fan {
>  		compatible = "pwm-fan";
>  		pinctrl-names = "default";
> @@ -546,6 +563,16 @@ &lpuart8 {
>  	status = "okay";
>  };
>
> +&lvds_bridge {
> +	ports {
> +		port@1 {
> +			ldb_lvds: endpoint {
> +				remote-endpoint = <&panel_in_lvds0>;
> +			};
> +		};
> +	};
> +};
> +
>  &pcf85063 {
>  	/* RTC_EVENT# from SoM is connected on mainboard */
>  	pinctrl-names = "default";
> --
> 2.43.0
>

