Return-Path: <linux-pm+bounces-39019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91711C9964E
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 23:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1734E2C6D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B252848A4;
	Mon,  1 Dec 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n2DaPWIM"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9951284662;
	Mon,  1 Dec 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628632; cv=fail; b=ZED/8fYqHcXNDmHrwUXT5xscgeJdZ7iahsxZUNscdPnBxonWba/vdaqAqfExMKXIat3YaK3GyfzzNMjY8fvw+m9++0VG4iLpPFHK4FuFH8akv20SZBuneY2nqy2lnyoQ5W5VnpbZunoFpTvMkTLqtBziQdRFoHTwtIheAmfpAAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628632; c=relaxed/simple;
	bh=O8vL75NENgyaTcIuJP1wiQUfEpiAG4y6uciIXo14XBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ixC1ZoBVUKyntfGIdaA2l7dbQRke0/MdhWELm6NcHHqmchvxwyP8eCEUqBnn8T5cehNcBBDM+OYq1cHGTTQpWLssJduitT1VwsdeMIVAnCDI+JlDxHgYhk8/tNd7S6oXNkIH5wrGkkh0ju/NssFhQFVwqMkN0T3KaN83rpaiUVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n2DaPWIM; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Adfgt+ri26LGUSJF4j3MNjkEQ8zjAhmsqskzPY5NhWWAyfaWe9PxDAQdGow37ZlfEjYfdfFkbK4JWME9DnC8uINe0ptbvqvMw7knY2MdyfJ/XdylmpDy1OGp9PRoFGUtoF+A0rOYV8WybCo/YGDOBPVa5U8h4ZPX2TIlieMetn+B/ArUd6jZgj3n7TXa3ewMTyGdmQkz3DzuxNgEyoRTvU5xcxc7qnA2t4+JB3ycRzbJssnmgIZb3j44cVkSfjnb5pk5gA2u6m8Ht5QR1tYKpBpmw17y0duHsFRa3TeEWxTWdRN9sKvjTta9SOz3AQAbASfdZe13KfvemBoZvc7q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYSJzlPlCjNF6JnGbrRGBYmMDVxzaxBkK17PUhnKMPk=;
 b=qv+UfMxwM8OGJIFPbi3hvP2JEoQx73i8dCQfN8fXJk8DvUKGFyeE+kG+6ec4IQdXvdbZI1W4BZfGADRxw8UxLBBPLwB7XUcYBZskKm9L6EB4hHwL00k5DiYcNCy3oCETdjw7c7iHvC6m1EfhqsRAfWw3z1opiAM0pA1GlLu0UcKiySo5qaEE1WNeASK1hvHkFSpjYOlGbZQPirhCWc0vw03q7KI04OrQysA3sfGM9v5aoPXAx5X0XF4DfklBjk6ElX8vSd+5wNccz6L2fJuIVKpLjO4SLke5HmKfSOjDk5q9aUEulIT9SKpR2kIJaWhASy84g8ABOh8Nu4PET6bF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYSJzlPlCjNF6JnGbrRGBYmMDVxzaxBkK17PUhnKMPk=;
 b=n2DaPWIMxlLczTpqEuVyFeV7G4NEHJh+KJfjr/EjDO4hnD5GpP9UpgwWDqNTc+LsmeP/6tS+S54gfQc+y80KPLUklv6KH1BnRP3YyfHi8cG+HfwqJGCz6yaAupW7LwEpwvhKaO1PQSL6OExFa7TbPOklIUQds5/hSnHqtSJjLYxCcNWqVP+yLXpuCMs+13O3zIfAL/Tg34TT9jJi5wiLIQvytPBKMUt8Ab5Cb7zMHdjgyD9Jxw9jcbooyZA8iZlaaG8YFng4AHwI8+pVWNrfj39wK4YQGpzzZN9sx0c/Tfg56s4A1yyiVrKkbZCPn1+imtPJLyeOnSUcCzFsXVi3kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBAPR04MB7461.eurprd04.prod.outlook.com (2603:10a6:10:1a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:37:07 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:37:07 +0000
Date: Mon, 1 Dec 2025 17:37:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pmdomain: imx93-blk-ctrl: cleanup error path
Message-ID: <aS4YjQOpvkQSkC6j@lizhi-Precision-Tower-5810>
References: <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
 <20251201-v6-18-topic-imx93-blkctrl-v1-1-b57a72e60105@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-v6-18-topic-imx93-blkctrl-v1-1-b57a72e60105@pengutronix.de>
X-ClientProxiedBy: PH7PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:510:174::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBAPR04MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eded3c0-0973-4678-b056-08de312a2893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnAEyLu6/WG+lo2qQ4mqLypPxEouWyN2NW0zRHnY4sCtacfiS2jvhBC4Hb33?=
 =?us-ascii?Q?QEsxFxf8B+Lk/oGpEp5WTSId2UzxCoCSLwG1imnit0SBQdezhcqTO2UDs6sD?=
 =?us-ascii?Q?p6FFCCAlUcX4+keR5aN9lrDEKU90xAAfg73WFOrA/J33uBVaXFY1ivikFW+M?=
 =?us-ascii?Q?ojam7MN+rdc+dvyc+cZkAV3Y9WXA2FBGu18CODVoGtDtqk3j781juhKmgKom?=
 =?us-ascii?Q?Po7Y822ek0sP6ijyqnYGlCXYGrlF54wHMAy1DDbr6KoEx3yeOf8IGM2K1FLR?=
 =?us-ascii?Q?UwhM7DEF83pCT0Ko8gSaeG2pX6KGa6bDIwD8d3/3XNsYiXYdcgCS2Lt2Du1x?=
 =?us-ascii?Q?7aH6gdO83XAjiOn6vlcmKF2Of6Mt9oLw66/L5G+wlNJBvT/gsQMHcTB1+eAS?=
 =?us-ascii?Q?rH4t0gvFeoldy/wk9Ie/hIy3UF9M7RUrVazxeLxrUEOL0SqNLzSY3mcodynM?=
 =?us-ascii?Q?c55RwiZuOB8R5o76e0U9uMg+DoevOaMPB6ArAiemJxrSmIy8G/QL33iaxZuz?=
 =?us-ascii?Q?RoXv9ZNJBufh/PSmyXhezY0JGVL6bKLaWKEPn+gOS4b82jAcqS//Y7+VvaKA?=
 =?us-ascii?Q?6mBc5mvoeGoE+JOGF0jbsDg3BZnjGoZdAJFVlS5IIFs8PXUGkZ9gCfs6IE+r?=
 =?us-ascii?Q?MliXcunHkutp62Wk68bnNE/nB8bcdLbnLLPYbyOpbecz4/c6DCPn57jL3eiL?=
 =?us-ascii?Q?zQofP8ovd7mT7fszy9DWzDz++ZDvb1cLQU7g+RYRLcPvpLlIXEw8jvTq/I5d?=
 =?us-ascii?Q?1Anav5TeWP0qZYwxCXy2G1Q4jNBw5dn+irFdsYDClO36jbpr0xEDIqOxS28D?=
 =?us-ascii?Q?ZgMU+9ZkcUW6cmJUvTTT72aV0L236TQYrf1sBXHxIaxpDsZdO5hJO8yfJply?=
 =?us-ascii?Q?QhdJKOW57Y+kr/xOngsrtnvztevSUQAeejXrHVeiBRJvPWeILVnNf3RuJ6hz?=
 =?us-ascii?Q?/LqyFfONAK2r7NLXBCQ6bJ/2E7rIpA6ALriyE3k5oHRKqe3o4vu1R15DuBE3?=
 =?us-ascii?Q?gv/rOEYb5iIvRLV+J4CMyu/xnL6MFf4caTIpPbgfAlW+cjTTL2mHIWGqW3Dd?=
 =?us-ascii?Q?2pFinQqxEWwfxncEd/oxX5keDOfFBVfAp8rEjgGS9fgyo/j6cSEIxBX0JLps?=
 =?us-ascii?Q?Hkk35vty95ixdDuHh/j9KhQelcNaA5c+jmXVM4frdb/1XPLeN7BnQT1L7mLQ?=
 =?us-ascii?Q?f7hfrPfbksDJ1w/zPKnSyf3tgCD+q+yq66s6Rnq7GhSt7NtW6ycLv4ttpBiO?=
 =?us-ascii?Q?D3skf4MGVVYdydmoT7XK7IZeWDJWP6YsWblmEyDRCGtnrgDQuHEweyKJ/vMC?=
 =?us-ascii?Q?dOmTfKJAGsv7q/Rr1s6xfbcDYkqAE9VTa7ViHjNPTqfB0uVW8SgA/V0k6Udq?=
 =?us-ascii?Q?xBuxtp7b0s02LikOE3TpiKS3tphUhNwBWECmi6o97tu56Ok6R3QqT/Pi8ZI0?=
 =?us-ascii?Q?ZlksK3wEuolFdPacXpIJHz2EkJJEGfRo9f9xVXPYoknJzLuatUQqLJnS/kVU?=
 =?us-ascii?Q?fodkDJmsoIoHeCJ9Wrr0USMlOfarkHX0Ldgn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2I70uYlP3H+BDlCVt0QxH3uS6PKYjDWPPocthIp6f6/XQQTlxMug7ecLg6Mv?=
 =?us-ascii?Q?0mpRKvuM0p4mU2YN8WWsZJCTYtr4fqmG0zf2fzren4VUXhkno7ddcEqAnURg?=
 =?us-ascii?Q?dWKXsBvtGPoHwOv6UvP+pOjpOtS/MzXBLQKW04tQMlnY9bcARH77ESeUVNF5?=
 =?us-ascii?Q?i9/c5zu8fRvYOtaebH86JABB+ai73k9qz3/q2TjAm7O71uBip79uLxupTroY?=
 =?us-ascii?Q?ly87O1jd4oowOGwuy0lf8pIizwo4RCOYy+BA8KQjC6OXR+X7bEcZehVswQY6?=
 =?us-ascii?Q?ZnrnZoay0sa6GPROjOHQlV/h+LAiyIqPix4wv/pNJ2zpfO9XbMUbcy+JEFuJ?=
 =?us-ascii?Q?vvqZzJmztnhKC0wfZrh+kMpWkh1EXonZfoGqqZ1Dj/OYjWQ5nlHwhoWJCJ1Y?=
 =?us-ascii?Q?PC6cKUK3pP7gMFGQ+eIORiyRaI8ROCbRaXCEi12sMzZlHOFnJPoxSuCJtKBD?=
 =?us-ascii?Q?TSwH/r2+ztKsJ73JSV3nUMdoK8PRdWCeX4Hd1SkfusldnSVa0IAq4m5aTuB7?=
 =?us-ascii?Q?ey3LQ3lGmlADYUSi5gUBhVKzkiMtRzz71Ux20beusIpwq/5ZWLdWavNJcL07?=
 =?us-ascii?Q?1m9R7y7bjVCymBXo6S7akHdzUIIj8Q+Qi8HMbTwFxnoB9jNlL3iZX0YqmpHE?=
 =?us-ascii?Q?co+y+I5im0pE9sEBf1HGA/69Au2DmKZ2CcVc1ctbTdeIlKFvj2uw4g9AnMrh?=
 =?us-ascii?Q?se7wT0gB3LTPxeqZ1NKpRUd3RwN5QubmSNnJvG6WekHVOc0G1Jy38MiBq5Qb?=
 =?us-ascii?Q?MAe9k0E74oJc4M+vbV8el9embhWI5HBuBynKPP6kXvXkWtFun5QZpSy6xvGW?=
 =?us-ascii?Q?U1eRVgrVdBX/cV5bb6eFGGjEdhMubmYAA/jMTur1fTRawTkB7GOLvACXhGAu?=
 =?us-ascii?Q?nXXLIitBIv3pg6fazc3UIGtEBwu4X1ckNGgSstf12FpzxV6Z/p2gdlfLc8rq?=
 =?us-ascii?Q?4yc27tV5SuEUuYM07jmo7U0xfJGF00TePjhx9dEcQyx8ldTtllYB5H8CUuKh?=
 =?us-ascii?Q?R69pm13rGospH7gYqsTU2nLiokDuz57etwRPoAyiC3CauBV/7j0nrgj4soEi?=
 =?us-ascii?Q?dfNgjeqgKJ1/lBmKgDxLQ3VF+yDWjquVd8Zopj7vrkF2A2/8Lo6OwOSpECup?=
 =?us-ascii?Q?nntW2LMgl1mxkgvi2P0inclZ9ZzssJAvUGv44Zu/gVbsSswytTFX0HqVcx8S?=
 =?us-ascii?Q?CAap0/haox0A2h/FpvUNljLoSX6rVdI+0e15E6NxpWU+TSGSChVs4PQH9AFA?=
 =?us-ascii?Q?zxCwn3qCvyDB3yPf4Dgge9hQtYQFIKAaY4MOu4uYJChN7UQ0+9UlHanM3yuh?=
 =?us-ascii?Q?0oRvkmz2ezivdHl0JA+MYIczqEG/XqRaRLtcoU3GieYoCS+qv+jIp2EZUrcg?=
 =?us-ascii?Q?FjTwLytGqP+xXt2Wunw+3JBNkAK96gQjX9Y1mm+Kqz6NEjhX3UBzhv5oX+X9?=
 =?us-ascii?Q?v3NfnrLmzZ77KP05gpAuvIjE7SD6o2vKcU4iwVASYJ2XXdIB4d1VHlJ2vY5Q?=
 =?us-ascii?Q?QjCzUzSqE1mKc59VQblgiSPkWlXUnyD42eRuDrexsdqxVBrnNwjYVACrXebe?=
 =?us-ascii?Q?PUuxqsRrpygH8PTSytRPzaMsn8AImQKr47SoWNac?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eded3c0-0973-4678-b056-08de312a2893
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:37:07.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUxPEcUgV77oaCOT85X+OhXMB3ylQDd80Gi4Yn431MQ1vrAgHXTLwXtTv/8YvhWICC6tdrGv/8LTthiAR9BBMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7461

On Mon, Dec 01, 2025 at 06:12:05PM +0100, Marco Felsch wrote:
> Call dev_err_probe() directly during return to make the code more
> compact.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index e094fe5a42bf646c712f3eca4e66a313fa5a914c..2aa163aef8de4ee901b9cde76ce2aad246c8c08a 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -240,10 +240,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  	bc->num_clks = bc_data->num_clks;
>
>  	ret = devm_clk_bulk_get(dev, bc->num_clks, bc->clks);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "failed to get bus clock\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get bus clock\n");
>
>  	for (i = 0; i < bc_data->num_domains; i++) {
>  		const struct imx93_blk_ctrl_domain_data *data = &bc_data->domains[i];
>
> --
> 2.47.3
>

