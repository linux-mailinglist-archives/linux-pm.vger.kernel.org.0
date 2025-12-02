Return-Path: <linux-pm+bounces-39081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73813C9BD28
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 15:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBA3A83BF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA20C228C9D;
	Tue,  2 Dec 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gXNSBFzb"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623333F9C5;
	Tue,  2 Dec 2025 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686438; cv=fail; b=YkuYnJ4hU2Fz19vb/aY3J2qAbx6DPVG4z1ew6RKINCJbUE2AGNye/jY4JJ2/aa7ERPx5df8cuwpLDLeVkNbqqNYgRUz5Inz6G2TCbgorT6hjMLSrw5tHw6FXCfIuiR04+w3OFa85eHTPLBO8UbwrNAXRfFpDdshmmbKmGo/CiOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686438; c=relaxed/simple;
	bh=jlwfVKPQKuo9ykF+SpoWsStegTqoMG2uMT3VJf18a5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WqvOdFAZ1YCS6i0u8wnqQe21rbxyZInpGAIlUhGYidnos3NSsLwz8BGJpb1ysoPL8CZQ7LvrQzJ7sF/Pyy8jF2MAG0+KhvYrsQw7tZN+FdDwmPFwN5zVnU618jnvK0q6QYWdSD4q5iC1+KbklTRblM2Tqx7QJvNdcxf13/d87gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gXNSBFzb; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzbZ1UBssbOjdKjrm4qgSKDVZmR6LGpcJKrEctNlQWrSEOz33rhyumwGyZ+ZABipoIqgOpKHWn47fqQwGm4x7OscOSsmSXwld8Q1nxsu2ALflc2riwoev5348oOmJinku8MEWrrg4cSrlV/znLBcQfzLmQ0bW7cmyaGSYNCznyFOFE+RRAJMx7S1AtaZQGgPFcfTC98foWg56Mww9Qs9K0QrWfvI4CBi6GPn6EHw+WkSzYkCGLENbDEsAVu8fdZ6ttzM0C0elOINBIIQ58FSPXpo5eWpu0BGT73DsGpdK6VTQbaK2RdzxNakWscgRgue5W8At+MPwWJmzpPPylpKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/Lb38XWYidCdT+CvuBAcBgo29VVmwLItgbXT50Uyr4=;
 b=Yr1Bm/iK2Tu9Ali0JTqo8agRK/0J7RY51giM84NVL187RQ7HpC0ga91Ot29IuV9WH1oa5S/E1p6+WWZhHLR6tOZXO1fXtq+IwWKrrQQJWgfSaQXosSNV8D1xa4yIdV9vTsAwNBaJYk3T+a0zyVeUNsNW5LchqDaWKC220uCFRXFSuQjP0unpyP2Y3BCIX8QEnWxxS2EROUdfv0OPsykhSVyrVVLefllmnFdj2z/FZFuuXapMHNMUjjUoNNyOneDpe5KypCe+xAZvXVuY/GDW/Pd5C7GcRm45MIHc6qfttG5UFF9FBfHJ4SrLBny60NRK1bcR0esl/os42YFt6J+p6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/Lb38XWYidCdT+CvuBAcBgo29VVmwLItgbXT50Uyr4=;
 b=gXNSBFzbC6JX39GI40xPqQkepUtuwhSM2THt7yKDBxJ106Kg3EyQQJegO8orzDhz/z5hLn8mM5WZcFHU9U9g3dK0jqMTOKsFuKcIrUIEXC2mld7sJA5ctjouvSvlMMwN6Jpk/WgXWyYcGrUHr+1bIKybJdkUbhbhh1rmPNWxZVcMCz90QaOQgJ6PfgG5u4h+N0e/OvAbQN8iApPFjgh2xRss6GtGXam/EX4Cb4kqM4dF3aQS+ZJU0DJKDNhdOAzVebLB++L74KSX+A5mi3o07iKoDAFfeROOqqWCZJcV1lDA/H84nI+MUHqKMtRwG5TH7Vwlz4+CIgDLRQ29lJ16HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS8PR04MB8133.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 14:40:31 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 14:40:31 +0000
Date: Tue, 2 Dec 2025 09:40:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pmdomain: imx93-blk-ctrl: convert to devm_* only
Message-ID: <aS76V3IFDdz9N2E4@lizhi-Precision-Tower-5810>
References: <20251202-v6-18-topic-imx93-blkctrl-v2-0-e73501034adc@pengutronix.de>
 <20251202-v6-18-topic-imx93-blkctrl-v2-2-e73501034adc@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-v6-18-topic-imx93-blkctrl-v2-2-e73501034adc@pengutronix.de>
X-ClientProxiedBy: BY3PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::9) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS8PR04MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bbbdc8-d34d-4279-6d6d-08de31b0be3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HA6+TzOeXviZdAa1eFH1TlmVe1bbBtwraTiL+sEFI+8+AEHIGcSYnjudoz7O?=
 =?us-ascii?Q?QR2DwpjK9p8L998Vx4hHf/ZKqaCBgJnM5ya80gIz3zshwmdPOggAYR3YYrsY?=
 =?us-ascii?Q?cQ1WG7XUcX5daghKdVBqsx7DwKs77Ub7aFc1Ortl+JZoNneD/3pZaZEMjUgj?=
 =?us-ascii?Q?oq41bCHHnuhHzEIFQfWbVEi4NdBBK61WANcT0F0Qg1SAMtlCqoSZC/RR4EiU?=
 =?us-ascii?Q?oYGH0vJ4CjGPwclwBLJApGBNtej9jePSgd3bL+MNW772sUWXWNfkD0T6CuH1?=
 =?us-ascii?Q?Mhgu46ZutCIbxaES9w2oYQ5hRhdXv//0hvBC26BNAuVRs1IF5Ye0FJUssQhT?=
 =?us-ascii?Q?OkKcPNJ9xblXliyL2q+q0kTG//8Dct8SDp99mci0OWGGKKiMQPsccCGxKhDX?=
 =?us-ascii?Q?PlbaQpNE7CIoKBSm5IKjW3dwATjsld+HQp5ehyUmIHQ5jCkJXp0uySfFsoof?=
 =?us-ascii?Q?Lxptt3jyrdTx3spW6Kz1sh4sTCjs6VfGHzwB4AvJikVQmfaj2u0Y3jdM1HSz?=
 =?us-ascii?Q?RzvbFS2wZcHH4SPRQy1U+q65fXTu4sx+OGA1uuXgVUHoQLU1pUUeMZTuEVxE?=
 =?us-ascii?Q?ks9CpTy8cAo+oruWxx8XDguZvk4Y/AylzPoZd0FLHNhT83kr98f94x51qx4j?=
 =?us-ascii?Q?H4kY9Udm39oHocaLWr5jAvJoc1bX4YLpV41c73ZQhH6FNiCWkNOEK/zDl0KC?=
 =?us-ascii?Q?sGFP3lmEHWH6nd4d9kGgx4FAoqkzQLFl/LRbmZSbJAISWrQhjZovAVjigPFk?=
 =?us-ascii?Q?gCAAYdguE3d2OvMS0ni7GDVTAhwFqbBYH723qYK4PYDCtz6cJirW30v7p8LR?=
 =?us-ascii?Q?xO1fuWuAwEPXKrnwnwcns/uMpVTBiH6uJ8jEmRgS5wnPu0w1XUk8u7ppHTs1?=
 =?us-ascii?Q?0E4kVO1vUGxdHuyIuXYprw20gMBd3TeJItPBYaz+axttdK5Y6zvJxnE+yDT9?=
 =?us-ascii?Q?p+En5egpO9y8ZbFpsXFxBkX5CIIpbd/zmgAQofznHLooXnu17cuexG6Lrm2S?=
 =?us-ascii?Q?D48u99YOM5DJTQJlTLM4uNUyIvbBCPJFQhzPPy3XncJMiIg4UxkQgnvdGngg?=
 =?us-ascii?Q?hptNB5AK2+X7/qaRXDaxzx3nUYHYWrcXcbA9mFAq5tKTuYf7bWKMU1z6Vcgb?=
 =?us-ascii?Q?ddMpgfiQ4+oX86gzBo4+WJzsxsevZNrAh3pKMNmlS7G4wSlYJbgH3pvXE/UD?=
 =?us-ascii?Q?YczOjmSixSVZpjHlK1Z2ktcIg+QBnb2DeJrRCple3zGLqh6nR/BPLWBIfZWi?=
 =?us-ascii?Q?1MTFVawc6rOh2IlEciqZgigFPIwbXkQJF9V9NnZRYB4N6cGBg+2N2vt+0wNk?=
 =?us-ascii?Q?SXsMXOT/JwC+IDRDO0yonRy5VV4VKYbJD7GVeMgJ3Q4pttHLoHS+9AT6/1x8?=
 =?us-ascii?Q?cHiRJ3+WpkM/5lzmEOG5G0yth0uRAOreGhMWeHBwOOXGC1HZZaXCG5QoGJEs?=
 =?us-ascii?Q?WJFMQP9jUMPMMQLnrpGv0glghzdwUFhXjW1k1caFEtNNy+wwHp+iAgJ7rME3?=
 =?us-ascii?Q?ia/egqs+cCoqL3D41kfuGG8cOQAZyOFhuVqw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OIFpHvC+14jstG/71KIIktwU72ZImMh8ie5cHk2CSSgmCAbV+jBvlR2CTPpV?=
 =?us-ascii?Q?cbIaZmC7FbUTnZ3XwqGkNmUq5JaZXd0ZR844UXFfcygV4f+jrCqdre/HrXMH?=
 =?us-ascii?Q?6yYT5YWRPiIwK7G/IeLASdcianBPWeyNfllzvdM5yAQnRREQljaik9AtCfSh?=
 =?us-ascii?Q?SG1TVrg/XzilEfusxFT2TpdQAvEb4bcq7wO3lT9qJW5JAAlbzilDGiN3h+O/?=
 =?us-ascii?Q?nQ2I/81E7sRRzMMZ9ucGnCT4+RON7r6+1NHqqo+1G0a1FM+r78+6wIGXqjWJ?=
 =?us-ascii?Q?ZJY6gNbC07sELcjaZZpBXYAe//CnyYCTYuTG0D9fqPqs20pCpVF6dJxRDOU9?=
 =?us-ascii?Q?cTt7NdeqhBqrM0ylle4O114uEghR2gZtHWuIb2hlvRFiSET5+QxDdbRkdqCc?=
 =?us-ascii?Q?g7dYu8sFsBy1GD3WQTaxzj/JvRwA0BVJ840ZiI24xa0IGY/RLSCkxUp8IaEY?=
 =?us-ascii?Q?QdkxEkl0jJm4nMtjSC4XMuQ1Y1Ne8epLc93+IdLC2DQYQpFkNNeVeWQB8B6L?=
 =?us-ascii?Q?buO2gCjqFdGmcf0biwoeXROaQlN5MZCfC9d9DbNNRtb3HFrpz/eCylc9/AvJ?=
 =?us-ascii?Q?b5zlhMJW2moKswR+CwzzDRp2D6j95mj/em2xKruic0nw+4igW1v1qpumgE22?=
 =?us-ascii?Q?JmsgUgq1M2R4O5m2VHhl7RJ1T0KIO8gENsLP6c29ipDB2zKd9KZ0YSehMcKH?=
 =?us-ascii?Q?gKOWtQReAu5JtcLQwSLlZ/gxr+eZ32v0Tn/hZ+9f/x/xRhD2Fqe9/hYgh1D1?=
 =?us-ascii?Q?RosfvGKHJr1FkHG+Nvjg8yxWZK0wkkI9bOWt7oHoCoHhdbuiiwMRdZzvK8v4?=
 =?us-ascii?Q?q+g7zCSuw0aQYzg1RxC0DQhgQqKZjxZh3rHIV63hfMzruNiHopA26Zi4yOtV?=
 =?us-ascii?Q?Nf6OF1KiJHO/vPmsY/cjT66YT5O7uCikAxsqb+Vb12Y1amfFPbksomReqAbv?=
 =?us-ascii?Q?HRg6KLgcDGaEBU/IR7/kVncNtNzHKdroRrKtid6kPLD62O2xzLQHj0k4Q4jC?=
 =?us-ascii?Q?ZM6HY9b6fFYVLFAYprs5jO3yRofg+k5q12GwveW5zEXXWR+e8wKyMrfxy2QG?=
 =?us-ascii?Q?xCFm7TAIjEuK6os9E7Zn99u2IVluWTHVcv/i7FAO+lpcjYb8oKU/enahFBy+?=
 =?us-ascii?Q?jZf/v0J9jt30yxaZNFCnz8guXGl0cT0QBNv5uZvthXslIV85WuqGgf7cxcoJ?=
 =?us-ascii?Q?8O8mC5vlAZjpzAeCZVSpUZS2pP34cfbXU8gsbUxkV6O9xyMjFpju/99KNyV/?=
 =?us-ascii?Q?DgAx9uvVH1gra2ZaLrLoEHmfG/GhOlTcyzcdKjSnsFDY+D8IMjJW/wtjP4mw?=
 =?us-ascii?Q?hoA6SvZoAv7xYXFXP2x0dT26evWk7UNF6+d2lO71j5HfvNw25CvfPIUYXVy9?=
 =?us-ascii?Q?mwPRrvHB0pM83U/WxxDRE/RA8TbKH3KaR/0mT0UmnZt1zAjEyb/x9Tga9CBm?=
 =?us-ascii?Q?Vi23JJsOkRNltDi4WAasr68Dsf09OJmuO1IY4D+XG3eDQ5Esn7Kv5B79LbOe?=
 =?us-ascii?Q?hTdeb8FD3v5eOkabJN/FjjUnPo5mDUvu++Gk0blQLRtrOVaINTi3UVe57kmT?=
 =?us-ascii?Q?K7aHPULKBRqOYDTs788=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bbbdc8-d34d-4279-6d6d-08de31b0be3b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 14:40:31.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3By3v+KRGgqr8KtlIIj78cw2y7dtdPqyck7jukQ0QeJU+slfJoqKEXmQoH5j1RhA7EL9z50LtfUsYi8XBw+4Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8133

On Tue, Dec 02, 2025 at 02:21:03PM +0100, Marco Felsch wrote:
> Convert the driver to devm_ APIs only by making use of
> devm_add_action_or_reset() and devm_pm_runtime_enable() to simplify the
> probe error path and to drop the .remove() callback. This also ensures
> that the device release order equals the device probe error path order.
>
> Furthermore drop the dev_set_drvdata() usage since the only user was the
> .remove() callback which is removed by this commit.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 66 +++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 2aa163aef8de4ee901b9cde76ce2aad246c8c08a..49610f2389c3bbaf4de4133918fbcacb7924f672 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -188,6 +188,20 @@ static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>  	return 0;
>  }
>
> +static void imx93_release_genpd_provider(void *data)
> +{
> +	struct device_node *of_node = data;
> +
> +	of_genpd_del_provider(of_node);
> +}
> +
> +static void imx93_release_pm_genpd(void *data)
> +{
> +	struct generic_pm_domain *genpd = data;
> +
> +	pm_genpd_remove(genpd);
> +}
> +
>  static struct lock_class_key blk_ctrl_genpd_lock_class;
>
>  static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> @@ -256,10 +270,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  			domain->clks[j].id = data->clk_names[j];
>
>  		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
> -		if (ret) {
> -			dev_err_probe(dev, ret, "failed to get clock\n");
> -			goto cleanup_pds;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get clock\n");
>
>  		domain->genpd.name = data->name;
>  		domain->genpd.power_on = imx93_blk_ctrl_power_on;
> @@ -267,11 +279,12 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  		domain->bc = bc;
>
>  		ret = pm_genpd_init(&domain->genpd, NULL, true);
> -		if (ret) {
> -			dev_err_probe(dev, ret, "failed to init power domain\n");
> -			goto cleanup_pds;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to init power domain\n");
>
> +		ret = devm_add_action_or_reset(dev, imx93_release_pm_genpd, &domain->genpd);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to add pm_genpd release callback\n");
>  		/*
>  		 * We use runtime PM to trigger power on/off of the upstream GPC
>  		 * domain, as a strict hierarchical parent/child power domain
> @@ -288,39 +301,19 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  		bc->onecell_data.domains[i] = &domain->genpd;
>  	}
>
> -	pm_runtime_enable(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
>
>  	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "failed to add power domain provider\n");
> -		goto cleanup_pds;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add power domain provider\n");
>
> -	dev_set_drvdata(dev, bc);
> +	ret = devm_add_action_or_reset(dev, imx93_release_genpd_provider, dev->of_node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add genpd_provider release callback\n");
>
>  	return 0;
> -
> -cleanup_pds:
> -	for (i--; i >= 0; i--)
> -		pm_genpd_remove(&bc->domains[i].genpd);
> -
> -	return ret;
> -}
> -
> -static void imx93_blk_ctrl_remove(struct platform_device *pdev)
> -{
> -	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
> -	int i;
> -
> -	of_genpd_del_provider(pdev->dev.of_node);
> -
> -	pm_runtime_disable(&pdev->dev);
> -
> -	for (i = 0; i < bc->onecell_data.num_domains; i++) {
> -		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
> -
> -		pm_genpd_remove(&domain->genpd);
> -	}
>  }
>
>  static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
> @@ -455,7 +448,6 @@ MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
>
>  static struct platform_driver imx93_blk_ctrl_driver = {
>  	.probe = imx93_blk_ctrl_probe,
> -	.remove = imx93_blk_ctrl_remove,
>  	.driver = {
>  		.name = "imx93-blk-ctrl",
>  		.of_match_table = imx93_blk_ctrl_of_match,
>
> --
> 2.47.3
>

