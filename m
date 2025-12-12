Return-Path: <linux-pm+bounces-39470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED04CB9749
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E61D2300D004
	for <lists+linux-pm@lfdr.de>; Fri, 12 Dec 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB112DF3D9;
	Fri, 12 Dec 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLMmYSV2"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9502DCBE2;
	Fri, 12 Dec 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765560596; cv=fail; b=fMoBD/whHuxJkyhB25N+H5KLV4Jwg4O+r7T9zT4nHA6jy0FhODLwaxcsBMYp6QAxke4pStQ9n+xc4cstQrHdb46EkwhtFTn8GQ0L71TJ6kjnD+lQhjooIziaQKRVSXqsb9XCh8hrnoMS5l7ogs3hRmRamm47jr8ZOb0+yTpLOBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765560596; c=relaxed/simple;
	bh=Ug38L9GdPPFC9J6zIdBQW6CAuQeAbW/HFEwBHjzStrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AduDOb0L4yVq3d/fbS235zwxfuezoIOhZMCLQgcbzsZ24j6SY0ZV5WnBrqdDnQijceyJmDUEMM+UYYO81O8KiMnQ17RqZN9wFkYfNXiiGcZSmi/gupIzRGaLGVPpp+0aE802iQyNszRGDgN/l3nv0KbNjlfQG8uj2PFYsbq/k6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aLMmYSV2; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeMIZPDdx1DwKbDqObMl0JVihjxBtvR3MoPvKvAOnCQ9gdaFOtf9bSoZ1sm7GunFBtaFT11uI3X4K4VSqsnYiMOI+YxGIau18uE0LutKZM8T9dFuYBb3Se1euyEPJ8fevLm7Na4VgtGfwUub1iuzh1S+oPiEMpa86TvZXvsJRQcZkN39c9OPovp+y+lmrt+t9StZUsbyvBa2gMKJPcdVo3nIsrg/vChTWWNGUagKFl23WzYI5nrsb0lCs9ibQOLeIMdggLysnaj/+JsKp3jylXqUGvnrCW/EwdLZWxhgXiGvQ6qMQVkXGkOuzJVbmRrgrh+y158v0PW81li5rzondw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8lI0xZ8pANuRMAdQI+9vDTYLuRFUVHGMmOaETfwNEw=;
 b=v/S6HaAJLZt8wcfKMhWnK0FweQBYC4rEV/t1hl6/BrQYbuHP7BsxVC5g7SaeuCDRKVpDurLjb6XDKSq1p9GGOrJVPL+PuTOZy1TIVzHyl0GgoFuuxFZUddjBAkDuihV1CL9j84jecafLomuMfcnXccRhe5Ik8b7C4ZjaRlK5Zu6g4JxIA5TrrMxo540t3JlDt5GeNYVV9mSM6wpaat3kuvhM7aPRhMB1U7nstlM+vy5BKe1bybvSGfTGJH8PUg2kji4s15jm5e6yLRkkD8AL3Q1jZWpnmrAZiwCBypgzGYIHwckl/gHmoXbNsgLLEHBNEM71kuRdPDyR+H3n+VS4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8lI0xZ8pANuRMAdQI+9vDTYLuRFUVHGMmOaETfwNEw=;
 b=aLMmYSV2DdgOmK4+Ur84IgWS8aJ0vdANQH0rfNOTUB3ttbDvLG76iiIOcmAFZpD67o0dlG26URv8Df2s33n7KRG+PeUyL9yxP9xwIEUB0lqpcesAll3EnxGeOqc8PHNMgxGJztrYPsVjtYtDrY9KxDJfxiTBiwngy1yd3dp5/nyI559cxFkgAYvQTnailKZ8wvB1FlzszP7UttWDLcWUFwNokurpWNFEQxs/zA1asKzBzcMaS+mWgZgyNVroQhfNaDN0AnouvajkIclnYPrM591CnrDBLV453p8c4HR3zqg/9DpprKF34g3lKsbIRjeibiqFkw24bfQDDhrO3rRHWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB10484.eurprd04.prod.outlook.com (2603:10a6:10:564::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 17:29:51 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 17:29:51 +0000
Date: Fri, 12 Dec 2025 12:29:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] thermal/drivers/imx91: Drop extra spaces
Message-ID: <aTxRBVKuRAs6fCoZ@lizhi-Precision-Tower-5810>
References: <20251212-imx91-thermal-v1-0-c208545b44cb@nxp.com>
 <20251212-imx91-thermal-v1-2-c208545b44cb@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212-imx91-thermal-v1-2-c208545b44cb@nxp.com>
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB10484:EE_
X-MS-Office365-Filtering-Correlation-Id: 1041c08c-0a2a-48bd-3cb4-08de39a40e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OiTjQ42wxwtk5Ja77t9dneRFc1Iyf8bvGJTnljxsJju3FM6386VSKLzEp+kU?=
 =?us-ascii?Q?gHq1Io/3BCS9ZrIaNyFUiC7QZ8/Q9U+W0K+loccj2/cLfwXMWNw8FYLNdC1A?=
 =?us-ascii?Q?u5FTzFcKiMngNDokY6bkk8Mr19uLD9NYBVm7CoXQLk7BLi93ElkcUrUVXxbi?=
 =?us-ascii?Q?600UdCEYQFifhGkAdvNnLTja+1wNZjXIGsPlokv7SvsLCJhrSEPegl4inToJ?=
 =?us-ascii?Q?SGA+TLaMMqmAPC2ICEbZKHNBRwDzQ3i02mYgRD2FLhir2Vsthskzp3mlQGcT?=
 =?us-ascii?Q?DrKlVYhLXvgIY78qztJ2CgqAN/FygE9AVykPpkr4YlYn1B4aUL+gpfbJOaNc?=
 =?us-ascii?Q?OdRT0HRvEq6lOYskd0Kgof+Ho+FfBKR472P+NQqjbsf9QIqQpI1uXomC8170?=
 =?us-ascii?Q?oQqvbP82wATYAiWwjRwQIVhVue3YP8nL2ZBXtzWMYdXWqPEyLWbQndj0MasC?=
 =?us-ascii?Q?7sUmh840nMCQwBEV0qWLkBO7ABDCbTdnp3oZwEZw7R3sLiOhbwlcB3PJjaul?=
 =?us-ascii?Q?ppoRDohmDSWgdR95AfwyulpdCsvmYtvPimkfv2FR/lmyUdOnjJqRQqGqy8y7?=
 =?us-ascii?Q?iL7pS7ki771Ux6KZGrcoAn+I8Q/tVU4UFjg2VAs7GQMI21ezFCQpxbl7TVx7?=
 =?us-ascii?Q?doZ9NwQTXG5mQA15xTRfClhsZNdim84tnFkOBpIxWA+PwZJgfDHHp+6t6HwX?=
 =?us-ascii?Q?8dQjzEfoHVXHItiXlVX4DYyGu4WNMBc77rtK4uxoKNM2KXsnmIPsuTnKaJf8?=
 =?us-ascii?Q?XmuaXH6sQ3AWKyonhZKoS9Wf4nM8Ei5MoMVfoh+BbZH8idKXa1klt/tY+SL6?=
 =?us-ascii?Q?aSdQWxohz5AfsOhgCkPRQW/OGjAK0td2dTEajUH/ypWVf3awR7gDndXewEmA?=
 =?us-ascii?Q?U45YiiphycHZ06BgZLjOJ8EU1O87TpvNTQjfaUn8qvETMH1lyI7lR9GCtpvX?=
 =?us-ascii?Q?uUW+H/Mtvyoy5WYzbFc7Ta2vOnIYztnhxrY+AZ6I4k3NHLBEl7xHWnLSbLm3?=
 =?us-ascii?Q?S17jWs7Iv9JapMTtaf3q06nIgzxEP+cdAwmnPtvoRkLyc5rHPuGBaz5CkL7u?=
 =?us-ascii?Q?Wvxky8yowcnVUeRLxl59VFIb3pCmNvmaGT1qxznLXcO2NynSRNa6ylQK54Rf?=
 =?us-ascii?Q?8pqjdQvcSJDMIFShGkRVxos/vZn1XuZqz7hyDyShNUK5csIP+AueCT6MocPm?=
 =?us-ascii?Q?68SHUymIVsS4/DPB75IkHXYPeW2dEHYxFDR6qmkZ+wWvMC2KHN1jbMZdi5T2?=
 =?us-ascii?Q?L3vpD/UxrN7AoLEQrVfJRPOV7ttbplP4DkEIZbjOWSPLG99VgdesKuYaIAn+?=
 =?us-ascii?Q?Zm4o1MuuVE74fjrblbRDCZCnSLvcPPig4t7xrjLpd2JaWhjj0g1cKLSu43yB?=
 =?us-ascii?Q?Lc9VkbGyjrvf2aNn+BT4EbEGe3iBMZaFvAK978NwXxD2OKnfcD3gC+h/7PPD?=
 =?us-ascii?Q?UEUf4eCbpzfiCQNHcEQ3w1dmqzf4g1p/XrN7Id8nTY5UHTghVYvCticKE/zh?=
 =?us-ascii?Q?SWdxjgELrcIwd+sXVhe1ZAW704PbXEuSvbs7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8CdDfWOL4bOJYXPiz9PB6pKeSXz6xyXshDRZIR0TfaGrZF02sRwKlGrQgj9?=
 =?us-ascii?Q?I6jYVrfGyjZn8S+oYm/ylkyS3XLGe+cjjbhON4KEqELWq57avdNg4+MwSvvL?=
 =?us-ascii?Q?HYcmVkU3SV8BLoj5QKOlQohGbq5Im7rhzyRTTJhrih41jxS848pBbmUQXuvv?=
 =?us-ascii?Q?4Vd/JtI9gpiw3p0ptnRPjJQ1kaKnRfIzA7huQ61wEiUibone2foCbdjgyEkN?=
 =?us-ascii?Q?NRtVKfIBV+0RZKSSyCvQGo2ydVCv20WQlRB9QroiPbbYK8CmJ0lKzdP7npp5?=
 =?us-ascii?Q?H3rRrtxjnsL3h6+jFswe/5c4hbUZNYrjF3GErJVbJ+AsD/yrIpukbshVwKHy?=
 =?us-ascii?Q?0nLdGAURF5ULMeHJCXUfq+tox5ub/G/wKW+7UDEIBhN10hpYvsyl4R2GhHTP?=
 =?us-ascii?Q?I6MheJKMehZiEuiv7jo687FrBkCtVAFNnZZBJTmeT3Rfj8EN8I1vH8zei6c9?=
 =?us-ascii?Q?Jc5wHmxbBsEasV0cq9dy3lG/JsDu1ZaWFZsY1O/0C8lilzj/5JY3d8wgp3hG?=
 =?us-ascii?Q?d4sMn8IC4lslBtSQ+lVi4fh6zWATr/muU7gyenTPzmWErzuFhVob5xm8TnMl?=
 =?us-ascii?Q?UnW42UOSQYcAisA05qI8olCvQ6c8qFDuDPe9GPuYYt5ARFLGjWo5VIMJ9sKE?=
 =?us-ascii?Q?FzYc5BQIqn2y+7+AO14WK4ejZBvKs9IWPZKwxSese491zWTRHTDuSpGZ+nhY?=
 =?us-ascii?Q?kCsX3AuhYcxhjVLvrsUiGYwvkry7k5HQegNBtgFu8qyzCjKp3R5RYXtHQ0CS?=
 =?us-ascii?Q?UMayoTJPKppt1FkzxuQhHGSIITtNEp/naUVFLfv2HAHbDmF9gF/FqwPxFjzQ?=
 =?us-ascii?Q?q+qNA/LZhIFLY6VqdS1jcTBxhBOFphmd06CGdFR9lmtcmDWv8bFDfgqYRm/0?=
 =?us-ascii?Q?3bO6gLCggLbPrxadpLdty3DqFLuUhsxDuV0rndIH4mQq9BwOi5r+vE2c54eQ?=
 =?us-ascii?Q?FtqasruyuEPRW0DZMuzQY6WRMpq06y+xWU3yg8/f52QJwExMfDmBYDCmOkgk?=
 =?us-ascii?Q?4j67C751jEQElqaprPaQxLt0nkyPUcRevatENE9CsUi7df5dx6mNvtMHq09N?=
 =?us-ascii?Q?Gr4/GE8GRP1J1+G/dCsaqs1wWYC/YBEQwWvKKMUKiFB9rYirsuRUiUg6dqkJ?=
 =?us-ascii?Q?Ox/p16w0gk1+M6SXn6cPKKZIhnEI0daJEY0kpw2zD7oN8KcWiJ0e9ZFHJhJJ?=
 =?us-ascii?Q?JHBCAOgBcVtpovmx0wfYyEJJj/B2k/cF0h4q0BsAqsHqbtz6kWxkDmP4XmbE?=
 =?us-ascii?Q?wq7KXnsKofF5D6XhfJ9EWceNVCWm2P6oZ7tQavR8/Z0ij1F+N22JUrZ9z4eD?=
 =?us-ascii?Q?TnL9yART35n9aichVuvWgtOZzvhD0PN2myO8o8L2NdWVe197jhNX1hTgliiE?=
 =?us-ascii?Q?TaItCwj2MCLlKddxRZpAsIdNCH8YvtjkebCZVXMG8klDy4Ye014z77C+PTKl?=
 =?us-ascii?Q?zC3fsAPGc48TxBRygNtgcc6XQUHsL3BkWwuZfEo2FMuYLBCj8Kzy0SCBpkht?=
 =?us-ascii?Q?R4RWo9f66972eXpz5oBYr6bRAP32GFo7FN76pv3tB1K7TUsVFnlsqsQlfdZF?=
 =?us-ascii?Q?thdJHdbgSXeNI/JJxPozwCGzbK5FvjlsFQNvyKXC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1041c08c-0a2a-48bd-3cb4-08de39a40e13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 17:29:50.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iur/t2LPciqSjLHv8Y6uIBHbMJ4CXrz5hrBg85Y9pIEpegTOtubZ3crBOXhCi0mJHwkh2QuxPmLR7EUyVKjvGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10484

On Fri, Dec 12, 2025 at 03:51:15PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Unify the code style, drop extra spaces for the macros.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/thermal/imx91_thermal.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> index 77e8e6a921c6af308b830c36721293c007256ca6..768c5acc384eca1c2203098bd4749628d9ffb8e6 100644
> --- a/drivers/thermal/imx91_thermal.c
> +++ b/drivers/thermal/imx91_thermal.c
> @@ -22,17 +22,17 @@
>  #define REG_TOG					0xc
>
>  #define IMX91_TMU_CTRL0				0x0
> -#define   IMX91_TMU_CTRL0_THR1_IE		BIT(9)
> -#define   IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
> -#define   IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)
> +#define IMX91_TMU_CTRL0_THR1_IE			BIT(9)
> +#define IMX91_TMU_CTRL0_THR1_MASK		GENMASK(3, 2)
> +#define IMX91_TMU_CTRL0_CLR_FLT1		BIT(21)

It is used for register field. Many new driver use this style.

#define REGISTER_NAME
#define   REGISTER_FIELD

So register defination looks like tree. Reader can quick search field and
register name.

Frank


>
>  #define IMX91_TMU_THR_MODE_LE			0
>  #define IMX91_TMU_THR_MODE_GE			1
>
>  #define IMX91_TMU_STAT0				0x10
> -#define   IMX91_TMU_STAT0_THR1_IF		BIT(9)
> -#define   IMX91_TMU_STAT0_THR1_STAT		BIT(13)
> -#define   IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
> +#define IMX91_TMU_STAT0_THR1_IF			BIT(9)
> +#define IMX91_TMU_STAT0_THR1_STAT		BIT(13)
> +#define IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
>
>  #define IMX91_TMU_DATA0				0x20
>
> @@ -42,12 +42,12 @@
>  #define IMX91_TMU_CTRL1_STOP			BIT(29)
>  #define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
>  #define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
> -#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
> -#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
> -#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
> +#define IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
> +#define IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
> +#define IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
>
>  #define IMX91_TMU_THR_CTRL01			0x30
> -#define   IMX91_TMU_THR_CTRL01_THR1_MASK	GENMASK(31, 16)
> +#define IMX91_TMU_THR_CTRL01_THR1_MASK		GENMASK(31, 16)
>
>  #define IMX91_TMU_REF_DIV			0x280
>  #define IMX91_TMU_DIV_EN			BIT(31)
> @@ -67,7 +67,7 @@
>  #define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
>
>  #define IMX91_TMU_PERIOD_CTRL			0x270
> -#define   IMX91_TMU_PERIOD_CTRL_MEAS_MASK	GENMASK(23, 0)
> +#define IMX91_TMU_PERIOD_CTRL_MEAS_MASK		GENMASK(23, 0)
>
>  #define IMX91_TMP_FRAC				64
>
>
> --
> 2.37.1
>

