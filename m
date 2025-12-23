Return-Path: <linux-pm+bounces-39866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFECD9637
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 14:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E5173012756
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC9C33970C;
	Tue, 23 Dec 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mW6Mh7ER"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09032D0D0;
	Tue, 23 Dec 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494856; cv=fail; b=srBzMTlISp8jNpJ/FkjrT+fyYmxM9fWrjQZxiE/xTZp/h8IQA+D43Y+zEOhp3zuOsdPR4hBVkVVex+K/0rxCG7laHR8BZlWXOTh78v7Kqb8X8K+1JU/2zdYqWc7tQPIVRQyLwt9yAPe/RL4jASvvQh6eec8jyvo+cUpF79d5R7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494856; c=relaxed/simple;
	bh=E+unzPwB9DSXVCvk05NO/YRUrXQiidUPuUFaoi53NjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SifpjosPV9F3HmfluIi1A/8gotw5ukDdQb6bOWP7K19p5/avNpj2Py2zjh9VzqF6l2daU7NXl32TMy/0At7W8hCgIuWm5ZoM+8KyoCfWiTn8a/6PoHQOZ9I4kr+ncj2DHcwQfKQCI31GPqh5F3mxyhzwtgxJJdOWq3rTucdmHXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mW6Mh7ER; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPm/1pkDs1YW2JW3gKF/+aMOhTB/qQJ3/JboiLO8WNXTD+qH6lULK6GkCaL4D8KcZd6xegpN7nK+Y4qH9YDc9Q5SyQaQgblYWbYJ5Ow8E12RhlnavfNdSG9OE8+Ht87KGzVNt8pCk8puWvQq5cbLE+Po6uVTrjS/XjanMRUfMAvvnqjoVwmKJ8TEAWvFrMp9ZKAW0d4osRIne6nYocKW7zs2rni71C2YGYwOOKn8t3eRg01W7WltwQ/AHWiLEHLKtqD0KWYM+DbzOsNOnDHH6z5egxslrT7AJcV7mlpIRDHOsCAr6AeqF4w/FzjJrruBYx2nCa86Nz86whCAl3Ay9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+unzPwB9DSXVCvk05NO/YRUrXQiidUPuUFaoi53NjE=;
 b=rRITHVjwNtdoc1bRPuPHKUruLSnZdSjRlU5fA7zbBAAj1it+jojG/2P6wEYPrg/h37grCD2eG3wphkWrB4/hFP/e5HRCGtwG/OvD70nck3qbb5YQx4tOQxYOHNxBO4s3wXhNCvimQdN29ZwJIkZzKE4bw008NLYH1bJ3+F7huY7+QGp3iI6gesjOXwfmsPcoYGGj15A2ySUgP0878JI90RJVa6FCQrQ/FGPKn7+mFVxJwlku2p7g9Ggf7fqYj30NZRTfhfra00a4nVqQWTgOeH5IM34MN5Za1+NBntQNVjzFI8ECS/OLeRl/NzdgZRvXT62lpktStNplm+Dtq9rTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+unzPwB9DSXVCvk05NO/YRUrXQiidUPuUFaoi53NjE=;
 b=mW6Mh7ERDShqGNOkGW8F71JmAHjqmFPgkVtidOO10q4dKLnFKeuorLQomvJ2ZorL4YvU0N+XbhuxBs4+dyeeRFeNuxWGmJ07y5jU9I+/XWk3b7hSdLS+DwA/N+Ao7u35zyWqxpSpSn1OsPZPqT03TPp1qfSjFRbz68FLy5NUKsjbjPn9OgpxrhIp+LwzK+uflT9OlN2UmkhjxSKxM/pVhq/Zj1tsBAuPpOA8xfZjt9dZAHQg7LqgXFeZ+Bl70R0uQbbP0Lm3I7PwyGrJvCOQ94hpl4SsMm+9g4xWmS48dnw6vxmaXoSTT42vrj2BrceOUJZKvq3UL3mTTwgjrF/EaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10243.eurprd04.prod.outlook.com (2603:10a6:150:17d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 13:00:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 13:00:50 +0000
Date: Tue, 23 Dec 2025 21:02:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev
Subject: Re: [PATCH v1 19/23] pmdomain: imx: gpcv2: Discard pm_runtime_put()
 return value
Message-ID: <aUqSzEyuPgzPyrKo@shlinux89>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <15658107.tv2OnDr8pf@rafael.j.wysocki>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15658107.tv2OnDr8pf@rafael.j.wysocki>
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e28e8a5-48a8-4760-d59e-08de42234c4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oAkSiqDKPvEVNphgjjK27ZWM1nX9cT3bcDbynnl3qhsZM+PoEhOBEPzyL2MF?=
 =?us-ascii?Q?12SI5nEh3bVm2Q2Jq+NxMB43HN2k9dwu7glpbteRLZjLirsGOh/FUWF6OyNE?=
 =?us-ascii?Q?Q1FY4xY435zk0RN925yAAyqgbq9SNifOhl8o991f3xU4LlIFvFaU3s4aGHYR?=
 =?us-ascii?Q?jV3snKu4ZXhJkau6LRgYfVJGgcqGRbWlPh4I2rLKQ47jA6m+Eb1ioBtWephY?=
 =?us-ascii?Q?Zgn5gcW5Bdjy6nUi3I54KjGbQunYQTQGopuAn3aVB0Tz5chJfzqoWfYhlItW?=
 =?us-ascii?Q?mZRDgewO1SBkLVOI7fIII8zL6IE5eMQzR+wFTMwaGi4OKx1vQVwj4oCwHOxA?=
 =?us-ascii?Q?1QzhOuaPdZclDU0yEXdDkQPngjjmf5G6/GumSglbdfq7Y0K9nk5T68mfH3tc?=
 =?us-ascii?Q?yxPd+EtQ4N1olyJJBq63/6YI6MSMcFfBNn23AxG9aU72kbyKEnEQS+l6l5f8?=
 =?us-ascii?Q?AsobglwxWdXDhnIm0VBU70KB3CLiivNO6HqTH1gskRDHaqy0qpa9Y1IgVcNp?=
 =?us-ascii?Q?R2yoR7T6wFVe85MnS3dRbk8R4S2s6fECsRjUpCIKBI0esD0rGOipxiYnYgKY?=
 =?us-ascii?Q?1E9QOg1N5C98m+ngLEAbqQyfHjLv/9CT5VJGQ/DD6kYUOGcBCBM88s8e2zmI?=
 =?us-ascii?Q?XE08NiiQqUowyjpsRWKOEipMOJaBkuqiK/Tt30jBqgS18V2yLf9D7vDTqW8P?=
 =?us-ascii?Q?uVVo6tRD9Vo/keLPEKRBZcPrI94VpsnZnAbmEj2V4iZewfSQF6fjA2oq7fKo?=
 =?us-ascii?Q?/3BJc0JEEYDLBK3ajipCw42/16Ln3AKfPeG6DKxoVSgSfh+ONnJbktSYO0rI?=
 =?us-ascii?Q?276n9tHhSSVA/btG1vpIHmtizig4UhZGGfGnV4XxrQ6hFZXAq3fpuKA9AbRG?=
 =?us-ascii?Q?wvhAgHRx+9ZyX/341IuctJhVwd6wqiMWpdGMUrIvizC9UJjvEECqSDty0ms4?=
 =?us-ascii?Q?fSllX4gnf/NWBIDHEA2mNE4XWk3VvCNIs7Ktln8edFf2oaKSB3ucQpSJk7fK?=
 =?us-ascii?Q?mCpG018FUkf76cf2Y2tu4JzhA5VrpGq+KJHQVO3Y9GErYfhCUCTV8hwXa4Nr?=
 =?us-ascii?Q?amZaH1UMzo7FkdOGbjhqhsLf3HdsQVTqFgsjJBcM8K95AauxEKp/nDLFrD0J?=
 =?us-ascii?Q?yyglfzGFpZDOBaA+6qaVdjn7UZRzmqy+ug/esLICqXlxVIN+5VAqbO2ctX5f?=
 =?us-ascii?Q?JMrWiWj9IBcviEtmJoQoUF/SoDtndVEw7zWXzRkYYPD7crF9PsTUiIJ9Asa8?=
 =?us-ascii?Q?ktlfyPknPM5/hbZg2+vBpmL+UyilE9FOTMrqwAU3orPGK5yt8azc5mW4AY6w?=
 =?us-ascii?Q?dIehWfTLbwT1qqIO0NC0QIES/3MMsxdt758Kg8qY9PK5nUkVp0kC5/TWfUQC?=
 =?us-ascii?Q?K9Lc6ndIlPGQ+T8fnBcqKmL3/i4Fx9ZgkON4Nhk6G0NMjPzVJBJS1+vmrONb?=
 =?us-ascii?Q?aJIO0CxFnMBXstUHMbjFkmW3HzNXePXqychn5h3tUeLqrhQf4Xo9g9+c3+AU?=
 =?us-ascii?Q?yfSW55gAE7exVVsz7ij4qZh+x7qW5QnBV6o7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mr/ktrQDK3Nr57cqArNh+at36ejp/RZgkemN8WDal1o69y5aEbywNecNEyfK?=
 =?us-ascii?Q?sfpuVf7OYE65nswVbqrvNsyYAS1vy4Dvq9Alt0tBkFggbCrmv8Caq+MWAguS?=
 =?us-ascii?Q?oUPctGCVPyom/SC7iA2jy4UfFXkCaKGqIW6OVialN6E2wWFx8P0ibeyYaxlD?=
 =?us-ascii?Q?hDb9rMxTWkRbnoA/bLaUgZ/TPZBm+WbFDBS9z148+FF2/WbS10BNST1F13Mt?=
 =?us-ascii?Q?oeS9W7qkvF8isaZi3raQy6tm4yGo09SUPs8dNy7Rs4wHiipu2XIKoTj3UN61?=
 =?us-ascii?Q?0rAi7AuJS7v1deJboNh0qCzdJqCQkNXWVUEjHptIvhr0dWSDXmVXuSgERmb9?=
 =?us-ascii?Q?7V66d6K4WmMmaQSFHHgxFCfpNqzrFQS1FAHDWo8xYoq+sttL//SLJKPlyC20?=
 =?us-ascii?Q?jEKQabJquHIa9poo9CJSwOR5+gcmH8MzGbwc28SrfGo53LHy4V4tc7mF+ICU?=
 =?us-ascii?Q?xDTuk1pYBVZpQOgvze/MUxnddvggg37vsGssf/1EhU4K3Gga00LX/CqHY8W9?=
 =?us-ascii?Q?SHqfH+Qyp0fIGcSv6xd1cBpJy1ZW0JgxJayLGwr68zw6MmXyg0gHlFtinACm?=
 =?us-ascii?Q?ldSwLiS5ITSltXZvSlM/iI+ZY9jZjMhTFq7G4hFmkA/brgfovRDKxnwLoTs9?=
 =?us-ascii?Q?wEw2WNiPJ1COAI/ctWc4PCtOCdaKSxk+zuJgu1UbYLZ6PDRk18fn3XsvBwZP?=
 =?us-ascii?Q?LaJpReS05I7B2gBnSESosC+90Z+iMiWZVFXLawS52CbsTREz/exiCg9Dn1oM?=
 =?us-ascii?Q?wnHet3rBXLrsdadVxCiNcbH2qf4JzmGSbWMbar2WHmuTmyU+lXvkyyE3cgFq?=
 =?us-ascii?Q?Lo+WpLm8YDhok8ubTSPrw17n71cahpn5TObZjDZiyY1k9UWAfvpn5HWbdr3W?=
 =?us-ascii?Q?Zm9HRQI6xHBXc9GXb8vNXI4RgmEHxaSdpR02ETdb5t0xf2xho6+2TFVs0vF/?=
 =?us-ascii?Q?vKxBa0tAnZ219vX40ayTV/uJhN0dYCz0ka8CqnDngycW5qya61LQi90qpOaQ?=
 =?us-ascii?Q?xWCMiHuFKAHIBPvyZQnnHxtm0J7JKqVxweTn2QXlKsm9pp+GJQulbfUtpERR?=
 =?us-ascii?Q?yFmQpwlXCob85NyX/rOosSlszh/dD04WRRQr29m+ylF3W19tDlcjvvM247HD?=
 =?us-ascii?Q?YXpC5ediFe2eU2nqSJAUoSwj9iaXZEjvOpqAG5FfQDgF9quPds+KLyqueMkt?=
 =?us-ascii?Q?muvvtcXAqEEiueO2S1GuKmuAcu933kqrhm2avl22i8sQGkltkSyQXHaZD21R?=
 =?us-ascii?Q?sULryDN02e4B21B57mavcIQ6qWgu21BjLI7CHyba4CzJ7a44607h5UlcBNN6?=
 =?us-ascii?Q?iYCFCAGXCug0RqpcRuU/a5T+0WHcvkqUDzfyvBDKMDbyhUk/zBn3Vv220oLM?=
 =?us-ascii?Q?Hjv//YN/rb9/b1FWTQs1fRo37rvenx1DWivj1flSW0Q7UeX2EIgSTz32C7fi?=
 =?us-ascii?Q?2lURL6V3t1E2FeE33wECxR2KuqHF6wOxf8lsw8Mak+jt4oj1Ac/nhuEcqZ89?=
 =?us-ascii?Q?9V2rINW3QixeDa/AN01amqu/xYINE1Zb/N8hVfaT7fzq5b/VH+e20Qmh2+VL?=
 =?us-ascii?Q?KgcHK0Ez7uViABFJkswaHOVkNns2qhaDIhZu74CQ8ss7uoLD4S88EfrA8mwi?=
 =?us-ascii?Q?9d5eG8r7cfej+7EBgTljgf/0eMIlF7LX2vddrb/b6XPY1nkxERMmj6OuS4hn?=
 =?us-ascii?Q?3ZAW3OuOU6YEJViViFvgTSybW+O+1XbFCajKq6q+rXxtrWs5WTseQ6lNHhIh?=
 =?us-ascii?Q?7KFIeMMiRA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e28e8a5-48a8-4760-d59e-08de42234c4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 13:00:50.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OORi1503zgjCESkKXQDvjHe+T+b8PmiGIIY/bKGbOJnKfxGNMEh/WNlA3RngJkzSZHM71ESIF8miUqgl9OqsOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10243

On Mon, Dec 22, 2025 at 09:29:41PM +0100, Rafael J. Wysocki wrote:
>From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
>Passing pm_runtime_put() return value to the callers is not particularly
>useful.
>
>Returning an error code from pm_runtime_put() merely means that it has
>not queued up a work item to check whether or not the device can be
>suspended and there are many perfectly valid situations in which that
>can happen, like after writing "on" to the devices' runtime PM "control"
>attribute in sysfs for one example.
>
>Accordingly, update imx_pgc_domain_suspend() to simply discard the
>return value of pm_runtime_put() and always return success to the
>caller.
>
>This will facilitate a planned change of the pm_runtime_put() return
>type to void in the future.
>
>Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Peng Fan <peng.fan@nxp.com>

