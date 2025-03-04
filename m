Return-Path: <linux-pm+bounces-23425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA1BA4E6FE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DBF8C67A4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793912D4B51;
	Tue,  4 Mar 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q79mUt17"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AF296158;
	Tue,  4 Mar 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104456; cv=fail; b=W7rD1B0TWzcyNDdSCG4jQ338LHPZDVISaN/fU4+MIwQ0g3AcZnIxENpXHegYaLMGdpYfTi2sSOzUCXMA+DAsC3K2IyVXzvz5PuDSwWUq7M82A4m+nZ0TAHG0HhE1B5ASwfCL0HSXvdn0UzqDZWD74JzVp+LPTJlTevfhtRZY8SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104456; c=relaxed/simple;
	bh=qBxdbQQmsDWLOVUb7d1OWcyDUKkl+N+ioAawD6YgMkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VufENsHR9KSfLYbGbYAYHbsh9sKMn2/lNipaqYjpTAIiBGsiBn4wFDmEHa/sS11m0i5L7lFzET29w0iWC4/R/vJdOxQ07mbzFNtMyjN7yzKw1LiTEKpjN58/KAvtc0k7uGujil/27oJDZsPi5DG/3k1/ZSh7AMLCvWrtE3A7QmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q79mUt17; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYux1mq1JluotPtRBDocKFaO1ywvyeN2tNAio6wjKPAnBmU38zsrX4jSg192535s6R2Ezo5uh53H0f+UV9KPjdOkOXfJuN/xfnq1mCQ3eAB/HvHX/imKGmxedG7a0F4DkS+XXjFiGrjeIOA0ZPMdXTb4FO+YC6OAdfCBjBqCL0O9SN2AUFy6A+wPIS0ggHeEBFxP3YDJ3w//gz3vEnbpqxuAT/Hiuo4kZulMarVtBYo537Z6j6y/cXHcKA+RY9Nta4oB0DHT4EH7g9USDrpgsIDtQz2fj4oVefJxBUkRwtZRWJqX+osuS8GQZjrXLl9jD8djG2A0HMvCay51PmM3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPL7P3gE4dKT671Squ1Yl8aL45NJL7vl2+v1cmuOK1Q=;
 b=vekAiABkroK7xO46cQe0qGcwKmQAbK8/H3sqyDbbWns0djcx4k44VHz2aa0gssO8gnt95x8BrSia5ayk+1CnBjHWfMgIbti42+hJeBZXzfw4sTL7eRZe4O9P+7ntzsMzaRV4JP6iYv6cVCfSEXL4nXY8lF45YzNVh+goU3nPMawKgNF0UZCUXePTFBXAymflOZZ2+U3JjTUCeTRp7qVbTJJeirM5rUc2gucJHP7OwuNAAKrBs6wyPnM0Jwe5pozicnRO6F+bvbwl+EgJGYuYE3YfE02Z6W7C0eBE5Thhkk1a1r8CqOCot+0DIXXR3GKnn28+nQ1a1fn67T/g4eI2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPL7P3gE4dKT671Squ1Yl8aL45NJL7vl2+v1cmuOK1Q=;
 b=Q79mUt17uLWux7d8dtXZkK7775VE5kfD83ZjpDgfDQIDNSxEOBYTRaSpZuZE3NaQJUiYdbmwZdeEoYlLWdJnnjyh3NeteiIFvktwIuPBw0f64j37McEEY8RQtqw/HR0LKRy9rbY3m88yb+1JEIrSu5GXFvBuEt/mkjZY3V+GyCcWog39u7xTc4G79eM/RRgb4EcII+vaENBA/znf41I6X5Zla46RES/ryCIZN0JteM4+c+9Jo6msOjLC1BXiReqPWyPPnjQ1Veb1+7s6qD5iVV5AYMthcAUHoHn/bkoz/zs1daOQZW1HSX4xDBUnO5BiXGLp60SUnhX8Qm8AeKmZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7640.eurprd04.prod.outlook.com (2603:10a6:20b:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 16:07:31 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:07:30 +0000
Date: Tue, 4 Mar 2025 11:07:21 -0500
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
Subject: Re: [PATCH v3 3/6] pmdomain: imx93-blk-ctrl: Scan subnodes and bind
 drivers to them
Message-ID: <Z8clOYhu/ja9/RqK@lizhi-Precision-Tower-5810>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-4-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154929.1785200-4-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f10420-2d31-42d5-1986-08dd5b36aa8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+bSWuOgv06v80jZzwiYUiyUshxediouHu458KRwJGYQYtnrmBbHhSzdhzs6?=
 =?us-ascii?Q?jXcRpp7mYdmUY2H8z0nwqKNx7YlOJl6TslOKUojww0mWpVDdxs8GcUs1iMb/?=
 =?us-ascii?Q?2BuzIOXbBIaKyZZ/cXNa/zfliTGMSgJPlXqv9wOlUSYyaNCOczjNJ3GJWOjs?=
 =?us-ascii?Q?g+WjwXes7dYs/R9oaqLTrlLXlfMigf1/Pi6oes7NRSBbmpDrbwHiZRJD9F1N?=
 =?us-ascii?Q?D1BpqBzCmtIc8u+ZjNtwfNYm2BLDbkeXdUYIDHMBLNA6hyH98axb1Ljvs/JE?=
 =?us-ascii?Q?BF9afPWpRFIh01yTKNHB1jKDajtwz8wCsAMvPGb8w3If80eLB2Xvd+j5pghQ?=
 =?us-ascii?Q?BnHeoasXI4BG388MSlwSjrmCT7t/RxKXnxj+Zc2PyACtGNXMwT1zEja6wDGv?=
 =?us-ascii?Q?Lvg1VjHES4HMY2ru8OFqIOqHLY8yo7c/V0DlhIVpB8h0TviCoIRvQ6K6LyrO?=
 =?us-ascii?Q?tx0ZR/pHkHiTrNP6Bz7bOkr3yAw2NtbduShCoMoRR3rbIMU/chlyZxpfKbfI?=
 =?us-ascii?Q?WNkMKtzez0b4gfF4ZGjYR2mlTlKTWxzpAC5wjttMSNWKunHujTNys+CvgOPd?=
 =?us-ascii?Q?AnkTOuRsL+eOBIpANGO3McsVocTpqjk/b6JsBc37x4fGjds8Q5RYPpmEAaQf?=
 =?us-ascii?Q?ai2jeDa7klQ5w+EnqgZSVl2NNN96T/qfIYkyoyFV7tjNmG4++/Ii6uc1ZBzx?=
 =?us-ascii?Q?GsYu0Ekfx9yGbfL7K9X+2hQ6O752jpdUxLbeL60NWz0aVKSMzfVAomZtDBGh?=
 =?us-ascii?Q?yhqXtc/BJzs+KcxZGou4D4VCysLZ4NKDpm5VLqPA9g1SjLDnN9oQOeTqQZ8v?=
 =?us-ascii?Q?UsWlCiCyx8ra/2urd7VXtsJIFF+oyuR/1Ha6cMzStxXxZdfh6FWYVpUo4oY/?=
 =?us-ascii?Q?/4e1It8QJEVoXbTUwWSh3lFyX4SLs4yTBpR37naiRvuV/WCj3SM7TCYlglxu?=
 =?us-ascii?Q?QK0uM1kiLXg189+gfc0J9jbLIxE32x3xrRq6uN5zqu7udxifZC5C2+NyNv94?=
 =?us-ascii?Q?ETTrD7jbDOsJwKHgxDXis7v+BYg9Oe3PyqdNlqg4mmzCEdfEbtE2Yf76N15z?=
 =?us-ascii?Q?bNoqUu7jW7T3YxeQYL/oFnbEnn6iWrJyzXWDubVkTy2yvuzB9VS4D7OVQ0Ti?=
 =?us-ascii?Q?JBlzvLd4Y/K4tMziIvAdt0Y6ipCQHCtrnr66EjikBkQ7YLaFmK0PiIBX65Rz?=
 =?us-ascii?Q?uab21TK07qC1+eo6N7jmCTlF0Fr6NrL7Cu3mWVv4me8ENQRiIOUb3/Bn2xzF?=
 =?us-ascii?Q?Rrlt9yCGFY0k+H78AE3CiXTReuPkpW3QGtg93+nKsWWxVHUxH1mepKW5Bx8V?=
 =?us-ascii?Q?OmbekjlSwEzOhoevVlYfZW6zoiZX10Malb7XN9JI7SjwE/9DvvKTPJznrLIE?=
 =?us-ascii?Q?dhOXJUfI51qlwtY11h3MH3mgMM07jYuAT4FcPdX89iOcg8bA6X2SE0FM5477?=
 =?us-ascii?Q?UD6pqvw0olLAwHtXH12qbV3ZIl4us+9R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQy+8kuYZa1eOo762Qdd66QLTkiFPMvp6f5OETGXFc58isAENhAmZFUaHxBd?=
 =?us-ascii?Q?yj95KHTP1p85Mr12X1yttlIZ3umBMBFYjSo5VvZpf8DchHnJTojdN0G+GRiq?=
 =?us-ascii?Q?wrqjipE4Q7jU4gqKy7ZWdVgsYrmT/EBvvzxp4T/xrS6PqoUIZhtz/o8FsbYZ?=
 =?us-ascii?Q?N7mSRbUb9eq6DAep61JElBsk3mA8n91t/JL/YJD62gVN++WxVHGUM1OGvCPN?=
 =?us-ascii?Q?ckUQgenz0NeF5gzo7C40++8aIE+T22nJN36JO19wRGyEfpAunFjuAWSknBGu?=
 =?us-ascii?Q?ESAilLTfhJLHbfNJ4PolqKkI2kTD/m6tKMw0+tXSl4JrmFhGrdhhch5pHwxb?=
 =?us-ascii?Q?l9/1kcXJId5VMzjYkpB/9rBXpWjMs14HS2bpw9ha2Iam/WFZXpAL7r92lUEv?=
 =?us-ascii?Q?k67BMALyBSK+DVC1pUvIQSG4h6EjQeptdXonZuheMlEfSAs5tE9YNOKaHvrC?=
 =?us-ascii?Q?FPk4jj2wkq/OD2FOay5hxk5TmTFI6X4a3GLoLuDyA34XdVTvPdZTHH1LansC?=
 =?us-ascii?Q?UQJG5JbrmbpK6HUZP3FDKlrQY1q3N/h3ZyHidsqUxxnR/J6EMvU+rhpafCRx?=
 =?us-ascii?Q?8IhXx1xRjI+QskrRET8dison2AIa0h0UAQJ9YrgBAzmG1sW450QZjl0stZ7B?=
 =?us-ascii?Q?7ZFYscsVj22HFnl7UZhrTv5q4NvD+1tAQJqiutoNkLJn2UydASpOjqqBlDH1?=
 =?us-ascii?Q?Z9AePsMJnm3DOJ/YjIuVm1hAy0o9XZHZmuX3lW8cslvcNh0/dzdsHes1GzR8?=
 =?us-ascii?Q?u2rdL/cytiT3Tah9D5mlTNdmwvLYLbb8ZGZzK+AuqubyMqOLRuio+lXnmWwN?=
 =?us-ascii?Q?9hj+RBXS4g1+2kGYlAQD8f7N+z3rObrWPFEY4W5Uyr6EZaXZUPAcQiUbe7hR?=
 =?us-ascii?Q?j30SjN+ysriOrGaED+zYf2MuKsxL6qqFo6+jPG3vFl1H7+zzeb8FfkO8Pe41?=
 =?us-ascii?Q?ECaAhVvpvfSKCW01V3ahH7yVWtZgIlSx6RKhOix95zcyi1ydnr9gVoxYdiP/?=
 =?us-ascii?Q?GWJOCyAV+Nu1w5GmZetbzg+JdQf+/f5lM8BguDHM4syCwextcbUHJLJjophI?=
 =?us-ascii?Q?dQ+HAfrF+dY4B6a2eu0QrMzYgsKSyqo4CAr4/HkhLQxN3TsB0cKWeNjFAScL?=
 =?us-ascii?Q?nIf5Msj9ABcQ82KSWN1kW0nrJp7cm7niAdPLB4fAXP+od9pWTyESFu0A3PtK?=
 =?us-ascii?Q?KTEuQL3B7Grh6dJECo1RKYSlJUZKGwb+M9nm4YRHjTAwY7ApyWJMHAOzTJaO?=
 =?us-ascii?Q?ORkiWa5mA1Jok/JKYbP8kVPonqSQokCZXTRcqV85hob+c2fB8/YYMiMkeUkB?=
 =?us-ascii?Q?cmRvTQWZV1CwLmgeK7Jdt9fSkOK81ynwyWzJL95dRLMfzTMNpmXCSQLILKVM?=
 =?us-ascii?Q?N2NVu1AxC/xKXMAe+BpWQXRrBWV3rVOvkmfq1IIEkftDXqsGp52VGTw5YtcI?=
 =?us-ascii?Q?17BXtW6FgjyPU0CC2tk4PQ+ehmv/+VaMg8B2V7BGA3+Hs1bMVDUZlSUiVEOt?=
 =?us-ascii?Q?zEtaHMe3t9xseWZB+xw1J2zHx8yS7rgyyofadtZnNEWUSfyaAHzLn9r32cob?=
 =?us-ascii?Q?kUEMbhr+J9Qfb2bsWxmUi9mIc1lhILIJi2mN1gyL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f10420-2d31-42d5-1986-08dd5b36aa8a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:07:30.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkhmUZmxdFULaLuqX74MOwMDGOmZbZGvC/b57pAr+eBeHa8SDFQXBt69y7L/XH1Yyr86jw7nUa6AAk85wSkNaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7640

On Tue, Mar 04, 2025 at 04:49:22PM +0100, Alexander Stein wrote:
> This particular block can have DT subnodes describing the LVDS LDB
> bridge. Instead of misusing simple-bus to scan for those nodes, do
> the scan within the driver.
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 0e2ba8ec55d75..fe2ff7a457502 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -297,8 +298,14 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>
>  	dev_set_drvdata(dev, bc);
>
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		goto cleanup_provider;
> +
>  	return 0;
>
> +cleanup_provider:
> +	of_genpd_del_provider(dev->of_node);
>  cleanup_pds:
>  	for (i--; i >= 0; i--)
>  		pm_genpd_remove(&bc->domains[i].genpd);
> --
> 2.43.0
>

