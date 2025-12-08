Return-Path: <linux-pm+bounces-39314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9BCCAD99D
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 16:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B050B3005C5F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20518DB35;
	Mon,  8 Dec 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ya8t6iNq"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75D1DD889;
	Mon,  8 Dec 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207982; cv=fail; b=mz+SlfLJgfy8rvd5saXGirNLPz9zHp6gUZT8QHB1IAFzXl6yeTh7tSHfaTMk50PVoJBmQmkziqQzxDVBuhZVn2we3yUGGY+/vlAEJYRzj2MHAAEyCx5WSumDrX+JW1oxg5oRvMjLVwsHgLj5u4KzHTYV2+/xi7at0W0ufvzrumg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207982; c=relaxed/simple;
	bh=x/60ZY6yEjbvUjUhrLjLRLtEZeKtzAouLIyHnRi1XS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hBdj8/+pGBTOvqMHWideDY9YFKxODVdzrrl+3pseFlzywMSMsZzI2J6N9xhcqNLyFb7znaDxY3LFPK1y3sJChMOsxfosbOm8z9TMNupXsl6zECW6+aOral0Y3Cy0l8ipQUgX2ET7wSSYxtvFwiw1n3CWALxjBLZhKFzSVxUJVzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ya8t6iNq; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9KpUJWNKN3wrtANcPg0gAgZKjqCIYDfONuubvsILQ2OSBBWeKEZbbSEb5Gh1czdb6MfYhBW8AuJK9Au7UEAd/y6Q5WzddDgT2G6wAi8bAJgdhV9I6Py0fcbYDQvHwTCBOoSYspMrmanDaAVhQ9IxaDlku629uJL+ZCpe5iLjkK3hwXlj9cjZP7+azq7LP/K7NzYMQOFh/uGpvh0biv9tv+/sqZEWBYmrTPURl8fGWFNLdAQ4pwMD87/RqvEeIUlOK9nlsJrgtx/vfaRxrej9nk04AkoR6bJv4kkajhO/UIrWk8gGWGwwAYgJqDja3nl8dC/q78PI/NCFG6oZE4nOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEBN3GKdEH/UakX/9nvhn/IXdMPRpK0Ph8BVHyvjDS8=;
 b=jb7N90eNO48pMHWPjDPrdDK8rO+BDOXr0In+KITQHsGgFTcsKRkdwlAWkspAO38f1MGO5lFbtEM0VaeilZNdkJnQkFztTfFRpW+zlCft1ZRK2W866TMiz4p4nu1No48fsfvAa4bwoRYyBy28bYDf2Z/Fr5xgvseg/KBVhLYxj/d5wRNdbJ37he5BeYUyhaZadzge6BNzN/XgMGT2m57qWt0qBbjmlc4fjloohNGCAg5Ah1ZtsU7Yml5y42Vs/NaCC5KLsNI1N5PFcjjrcL+/mIWChzQuYW3OK7l2UATOs929iGiyPMtWEHFaTl9oXWT+5bx+l8gG2nztoel6zS+xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEBN3GKdEH/UakX/9nvhn/IXdMPRpK0Ph8BVHyvjDS8=;
 b=Ya8t6iNqlqoCU/GLfUewKBqsSwqyr35AMw9hcs92Z1ZznfhKw5IYnsDeXvKPyq0f5UedfUWmZZESlyWu5p5R7fXXGL0K6szyaRDy481fOiyeeBIa9uRcgtokHb/dO+cea4cy5f1Zscev8Clxg4e9uD7PbO4KRrgkWOit4xh/eZ9Yo4YgsDax3dmCZr7a/MavORqcA3xgbNLmOeZlxBlgUeF6cg9WcnirYuLotLYSRNJ+HhPaL2BjiszTXkE053Z2peey+JL1009J+ILMNn2G2/rLNCu43IdbmQRQVbR+65r4L7EcMKEAQ5foLkEKUDe96UrkJNMsnVTxNFWfjr3WBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA6PR04MB11870.eurprd04.prod.outlook.com (2603:10a6:102:518::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Mon, 8 Dec
 2025 15:32:55 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:32:55 +0000
Date: Mon, 8 Dec 2025 10:32:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: imx: Fix reference count leak in
 imx_gpc_probe()
Message-ID: <aTbvntH908diTJ9U@lizhi-Precision-Tower-5810>
References: <20251208094242.17821-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208094242.17821-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA6PR04MB11870:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc92f17-4c4b-4c6a-f713-08de366f0e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O4zKJKA3UIxt0dSMh91f88fdyxdqBGDgicmZSjvGihvoaXW8u6GI98OpYl+O?=
 =?us-ascii?Q?YnewD8511lnbfGo6yy90pYI3jGKrEhklFuzi8L2rv2xAvAdCRnPZj+WgrgJI?=
 =?us-ascii?Q?PqkGTXc3H50Wfrda1POAO7LZit+ZPWCvdJLHcQBvSLpQhbcWhXwjuLMLmjOT?=
 =?us-ascii?Q?+rZSR+LGDHQUMtQQiUJo8joHH2MCV7Zd9pGEKuYE4ZQBoq15qXXHVCMSx2oe?=
 =?us-ascii?Q?dHCUHqrhFMWtKMcFBhAlkmhG4lYU+pOxaeKmuuPase7/mBaIWiV1cg9DYYq1?=
 =?us-ascii?Q?kRU1ZEg4lBeESWQ1whahaWpYUGrW4osx5LBFbJ0yg4wDosAIDaIDR+TExnwJ?=
 =?us-ascii?Q?7qxcpJRC3Pk8N5X2OmF+0IyU08d2sNgGNcBtQfIi4ILnWaZ0PyWYv/hXWdoR?=
 =?us-ascii?Q?Nz2IfV+6tuUf14QDIel3iZxK+/DGYe0rExNkq0G0nkZkPtYSU9cBuZJsS/MV?=
 =?us-ascii?Q?l84cDlykHONJueIZaDrueiDzI5TNKsNJiLpgB8sS9HcOC6TNIF65rzXqM3fH?=
 =?us-ascii?Q?u5j6FNEwqHjFG05jk3obzrm41Ih59ajIWfc77+0BZ5PofKhXhvoHSVG75NBW?=
 =?us-ascii?Q?Ews0AnAhvkZcOqcY+BtIIDR0z8Z4giA8C1AXmJ5JbmmCTtAzfmr2hTo9zQde?=
 =?us-ascii?Q?DjFGE9ziYZTyIEqT3eJveijdEx5L/mOHLm1CEeswcM3TOG+VXTmAXkqBWvtW?=
 =?us-ascii?Q?lBd8QKoaZUXn49X0Zeh7ck5iOyidp5BTO74NQVxCTIKvIthyjrQjkkfVww/8?=
 =?us-ascii?Q?J9hAeDg1Ss3BFb68zv+gktOoyX5z6hdv+p0hE2zjqmOFqu1OOC+gOTyIhT2B?=
 =?us-ascii?Q?02eIvuGn5tp9IJxv/ZhJ5hFB8yNJpAPEu7WD23yJnmgQLx8DmhxUJ3IL7zwN?=
 =?us-ascii?Q?x5kT3oYpC6VzSNiqmw66w/CJy628pCNQ1noq8OMeWu58DTwh5/bVnnpbOH4M?=
 =?us-ascii?Q?ApU9gmQ/nauWNoA5ug015nF7sH2B+rxXpjoKgEBrkIj9cKQYUHxPKeFgbTcl?=
 =?us-ascii?Q?YWeTDJt3kpQejORQVmEwtYD9B9dw20A+pG/Z9Ubzw6Dz6XZsNPl7VwaQIIQK?=
 =?us-ascii?Q?WoxX1KiPdHEMsQPzUssa4KCzaDu4oZ5J0rdQbhtfMwO/3yoGVzPXNYn62xi2?=
 =?us-ascii?Q?N9f3zGy7Y8jhkAD+u9Dy+XhdXWUZC+1ISYAIZ8GY6xDRXPWLTNL0b2NGn/4n?=
 =?us-ascii?Q?nINBsZEwouQ1AZ05EMiY2FGhZjUl34TtKd0TK6j5eilv0A4cvINmw9UJst0e?=
 =?us-ascii?Q?Fug3LWxDmvSI0l3clcexgDf4k4bqnvcA4yyWvbtwPWCuVxkb21Gz1s/IqIjM?=
 =?us-ascii?Q?JcMd6xCVygA7kONFneyn9HJUoXbQcU5pwRY9nRMLiwMr9Jn5BL//AVgkY4k3?=
 =?us-ascii?Q?M6leBS5SSk0bQ/kFUo0tB4xVh9kQVp/YsoXWX62C4kHMY+eXEk5ynm+SZqve?=
 =?us-ascii?Q?h8HTmhnudJatT09Veio0QHQoYGuN/pimStie00rXaWqfS5SOIclFuoPHCYaw?=
 =?us-ascii?Q?R+/DkwhQd/HFCA4uxnZn2qqpOUnLvp+fkQK9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MQWqAZWlw8MieCGjqa7UQTfl4AbERJ/hDFYGIaX0PU0jjFR8Vx6zUAQdt1kv?=
 =?us-ascii?Q?D49FY4hAoM1SJF5yte+1b/jmTmGUlyfmyUMP7k3Zrn8sotVz187f3kIIHBj7?=
 =?us-ascii?Q?QZ4ptxtOnsdnbv8LWBvu35IuXVnI1u5lt6mB8m70I3gGom8R75L/h1G+VRZk?=
 =?us-ascii?Q?6Ow1f3H6vCUsJ50gpwaFoMhHCflqaLtBd3z+MUiUtZxR07y0o6AR0iIHkHBK?=
 =?us-ascii?Q?AibOuXJL5b4mLAdEyzhEB6Hi6X8Ikw+BASKI+50SaNjrXaMrjwG6guAEKYVB?=
 =?us-ascii?Q?QwLvjGXTeIvi0ZPg9gWPFjHmDwpylRn6AoM1nwfVdyLBJ3+NCm72nl+s10lq?=
 =?us-ascii?Q?l0ejcmYoEfYIaeXqqQjM+S2kkWB6UgRLuJc5EKTG51gGGDNz/NL/yGO8UU8a?=
 =?us-ascii?Q?7GAEKoFjy0JNWlHhEi6UpeUryNXh/8UTl6xiuVtfTSToLTG6yLQyb6j+GMoW?=
 =?us-ascii?Q?Px6f+ZeQmhKsVeb/MYOPFzw2Nr4QiHY5cYSIDrVX8MA4bQMv8oy29dtSfGf7?=
 =?us-ascii?Q?oEyp5oXd9n9Oa6HQIq/Qc6vg/QS7Quy0NX9Xr4n9KLM05h6t2F+cpt++QwH9?=
 =?us-ascii?Q?yIArukn1oNIhjcmRG3NATwPoDcyNmjVgp1A2NlCNSRYrmpkkM3vkrtw3WKQ9?=
 =?us-ascii?Q?lWd5MMlu3/Rr3Jv0/OtD6RKWx3gq1aJpE4wcztw9U/of8cM4he9mSQTl+P/Z?=
 =?us-ascii?Q?t7oGHHDNT0XyaQ+YKTlOcnNA+xvuAIIRReZytt17QD8EQ8y6L9a+Hna05Agf?=
 =?us-ascii?Q?LPv05RmIHL/CYi7KcG2IknCRNvnl2lfEkgiWg/SgKDqJfXn/OE6vnY4MB66a?=
 =?us-ascii?Q?A+dU7UEzoR0E+qi1QWEDNw9+dWqKOdtd8G0I19zUGlorwWnNQhWPpOEzeEVm?=
 =?us-ascii?Q?JOCn7y5fyuIStVOfYsuZD+AEq7BO6GEnStMhp7mUVmEcxQmpDyW81HnJmc28?=
 =?us-ascii?Q?iPJ3HBytKIpCnuNgJkyuMNRnE5ZYYxoXoDuzKEizuHP+7c8KLWl2bbvk+GTL?=
 =?us-ascii?Q?thN40vSbL4AkbAO7QNrg9kVk0ia+/PHUCv3scYX6oFO1XgSjDjtWODH4Rr6W?=
 =?us-ascii?Q?4LLwsFC7F8CCwALnQsVach9JuUvaDNPGlFyzJLwtAyPl8MG9jdXOai5kD0Yt?=
 =?us-ascii?Q?HPGAyCdkKNiu2uEcJCp7M3x5DL4tx8IiUD+WDM1g3bwitUzbYlGTErZ7gJhH?=
 =?us-ascii?Q?ZU2TMxx8jsAUu4EENtIrqriiVEMo39jplmzVabNOzmZRBcpj244FICFGGuB/?=
 =?us-ascii?Q?2KIpq/UwgSax9DkF/kUDsSY1K3k5ziH99Jj9qIy6T1UAMl/YFeSOpUpr3JZ8?=
 =?us-ascii?Q?MuBMNWQmcgeeMcBD4GMyCzU24HP5SvCX/eejiDIgeRxm2/NXRTzAK05QncrE?=
 =?us-ascii?Q?4rh2X7RsxrLM4eZxIVlmnIYCr3Mg8JPRF0VsQN0Hq8vHej8Paphg9pM0R6/k?=
 =?us-ascii?Q?PfOsjDKPNBgfzMSZuU3LvG6H+KgKKyScnd10/sJ4flU+C4hMg9LOjpEVwnjP?=
 =?us-ascii?Q?du+ja2WPz8WQINhurKd0He1E7pavm9kJMTvrviSx7eZAcMAaigd3pMI1VKV+?=
 =?us-ascii?Q?qSmRpHX3PeIqtHfq0UE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc92f17-4c4b-4c6a-f713-08de366f0e9c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:32:55.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtYSnb4bV/M5oZAlJbuecyRkHy59K0SXDTgxYaTHJwC+02wsy34AyfYeGH50+gZPt7SzdxUpGqCOleOaTAESDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11870

On Mon, Dec 08, 2025 at 09:42:42AM +0000, Wentao Liang wrote:
> of_get_child_by_name() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not needed anymore. Add missing
> of_node_put() calls in imx_gpc_probe() to avoid reference count leak.
>
> This commit fixes the following issues:
> 1. Add of_node_put(pgc_node) before returning from imx_gpc_probe()
> 2. Use goto pattern to consolidate error handling
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/pmdomain/imx/gpc.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)


Just need one line change

struct device_node *pgc_node __free(pgc_node) pgc_node =
	of_get_child_by_name(pdev->dev.of_node, "pgc");


Frank

>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index f18c7e6e75dd..754c60effc8a 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -416,8 +416,10 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  		return 0;
>
>  	base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	if (IS_ERR(base)) {
> +		ret = PTR_ERR(base);
> +		goto err_free;
> +	}
>
>  	regmap = devm_regmap_init_mmio_clk(&pdev->dev, NULL, base,
>  					   &imx_gpc_regmap_config);
> @@ -425,7 +427,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(regmap);
>  		dev_err(&pdev->dev, "failed to init regmap: %d\n",
>  			ret);
> -		return ret;
> +		goto err_free;
>  	}
>
>  	/*
> @@ -460,29 +462,33 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  		int domain_index;
>
>  		ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> -		if (IS_ERR(ipg_clk))
> -			return PTR_ERR(ipg_clk);
> +		if (IS_ERR(ipg_clk)) {
> +			ret = PTR_ERR(ipg_clk);
> +			goto err_free;
> +		}
>  		ipg_rate_mhz = clk_get_rate(ipg_clk) / 1000000;
>
>  		for_each_child_of_node_scoped(pgc_node, np) {
>  			ret = of_property_read_u32(np, "reg", &domain_index);
>  			if (ret)
> -				return ret;
> +				goto err_free;
>
>  			if (domain_index >= of_id_data->num_domains)
>  				continue;
>
>  			pd_pdev = platform_device_alloc("imx-pgc-power-domain",
>  							domain_index);
> -			if (!pd_pdev)
> -				return -ENOMEM;
> +			if (!pd_pdev) {
> +				ret = -ENOMEM;
> +				goto err_free;
> +			}
>
>  			ret = platform_device_add_data(pd_pdev,
>  						       &imx_gpc_domains[domain_index],
>  						       sizeof(imx_gpc_domains[domain_index]));
>  			if (ret) {
>  				platform_device_put(pd_pdev);
> -				return ret;
> +				goto err_free;
>  			}
>  			domain = pd_pdev->dev.platform_data;
>  			domain->regmap = regmap;
> @@ -495,12 +501,17 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  			ret = platform_device_add(pd_pdev);
>  			if (ret) {
>  				platform_device_put(pd_pdev);
> -				return ret;
> +				goto err_free;
>  			}
>  		}
>  	}
>
> +	of_node_put(pgc_node);
>  	return 0;
> +
> +err_free:
> +	of_node_put(pgc_node);
> +	return ret;
>  }
>
>  static void imx_gpc_remove(struct platform_device *pdev)
> --
> 2.34.1
>

