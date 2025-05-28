Return-Path: <linux-pm+bounces-27742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A2CAC6D53
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 18:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACF04E3BC4
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0B286436;
	Wed, 28 May 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SaHUBoZ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F91C7017;
	Wed, 28 May 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448055; cv=fail; b=gPoELqW7facHnaH9Rra2FgrOlUhlD8+Wo8uMVvaPPI+cNSTxFBAaMyxJi716lImZ4e2m56oGoImBAZXo8i07JBMF5854iBmbPJuP6UYzUOq/R0gFbuxu7Sa2NRuxnHGYNZbsyjmF9Wm8dLNB2v6hP/T4NUfqqgl+SzGwI925cxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448055; c=relaxed/simple;
	bh=FyCQClSquZ+8afQ5m//REJmQvDZ0QJqSKVfkqQIkMUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vDj0ZjCw1fJV8WM5qfykTqd6Nj0W6/OhqiLKaXuLalVshTYnMrzFL52gry4k3xJbbNKrWKw1gkZH/rkfat1brHQ07Z422ON0iGrW6age1bLi+FabqbPtwHDcwxz+2WDaB5zlChHbQjl+3H5xvFsAukX5SxOjKG6//XnUtiQ5k88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SaHUBoZ1; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tyony/jd75CatrPgaRHPPSt18CyThN3/5l/zS6bGKSd0Kg9S/ToqDDa01nFfx4MrE10o+CNbzicFKWeG87cd7AFVx7AmnWlug8wIohFPgGmTckr8dPMFXnjt9HhvS2l7xOVssp0RSpBzBczL2rmQbllQh8e/Kdnuqb9bqM8/viA0Z8yOCRFdtovnPjjFT/nD4+oqRBP2UKKQLH8OO8D6yctKAVaPClTdCEijRleJQx/a6obGkipUho/bWSjNeDFGhwlVQxnE0DDSKOmHwFFLFHXwLPiL6ZnNPy6yPZwoB85R0+cJLizIn1bbk1suKS6N6D8w/5WYhZG+MDijTUyXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQP8e1hOsjMVduH4mUkZVLt+/S7HcZ82dt1IhcMZTQ8=;
 b=JY+QQuNaP2Yw0kRqlybVN1DOdnE0P6K5V6eeIm++zHiLmkEfcVO4SpMpLzcI5aA1NDdzpoNJl/5yLJTeYypA5UVcul0Biplq7MAB7XojdBZnNMsGD6ESBkmd3/n1ZM7ByndZxIBpe9hiyxWWPG/b4oaGrE1S8tS5lNfl2ehMiKkTQNVLk68NuuuT6sidaourM2SJ5Rml96sFdcxxQcwWJrgBbF9rcCvG1IFlsbTt2762HT5NRanaea1Baoy379wGgE1wHjMPsHxUllT19TbhDGPhOuR3R2WbP9jmr2627j44mXKMMywYyCFNP4/Z9Yf7y4/wBhDR9rufzMYlbQ4xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQP8e1hOsjMVduH4mUkZVLt+/S7HcZ82dt1IhcMZTQ8=;
 b=SaHUBoZ1Spm3bjsHhsV18/ArsLdqQCCmKv4Og4GrEiRWmioXVRPyZpUPwj6neIN/rGkE+A5vfTQePVwc/VcSKKat/OmVn9ahGVJnRnk//IfVJT0AS7Gpcu216UTo5oDG5mteZWGMEtNcSVAL06FflJ+MuLxicQxrjQUwQEwAcz4zXMYwUvNXch2hvdq2g+zMONwtNj03Bd9MFqzv7VkE2AVeVK8/3oYU2VLwBUjHxTwgzykrkatlXvBODG4ixfpg34nFghDFADgV80dLrPd1AUOuqNYGfO27n5N/rQRdOom8W4b84OMbCYP0F/uOal9eUfPQCuC++M82BAx2o+uBbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 16:00:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 16:00:50 +0000
Date: Wed, 28 May 2025 12:00:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal: Constify struct thermal_zone_device_ops
Message-ID: <aDczKA71dqJscfUK@lizhi-Precision-Tower-5810>
References: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bba3bf0139e2418b306a0f9a2f1f81ef49e88a6.1748165978.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ea17f3-fe0e-4965-e8dd-08dd9e00d12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbjPqbBDmqgR+EMcagDD4bxA1N6wYw42bUvlHpZREdqObMCvReRNNSC3LYUQ?=
 =?us-ascii?Q?khbymmhlhV3hW0+g0Yd4l0Nu2JV58trFTEzWcNop58v7xvfWjIom+yA63hDL?=
 =?us-ascii?Q?ORW24vQVpoRdFmEo61gdQoKHnR4DlE6lD0dBlxqpMeMKH1WmHrxAnVLjO3ES?=
 =?us-ascii?Q?hKZyB/Uxq5nqX8zaFBtxnzN3K6HFsHggjxq6ovodIckh4OPaRepD6At5aYFm?=
 =?us-ascii?Q?UXqFFFs5F5L4pvfgGQunBmKRJ6WHNBrzgM0Jv0mQIvvOO/tMVmz8B9UXiizs?=
 =?us-ascii?Q?6AgQYxXD9Ve5Br2QnwzIguABCXqyU4TH1i5yCQN6xp7eWaYOHbXSA2ZyOZx8?=
 =?us-ascii?Q?UaompkifKOCQaf/CoJYjIC/JGJw0OBnAguJddAtM2JTOq2wEakBRGdrP1A0o?=
 =?us-ascii?Q?ajrIjp8iS+tp3TY6HsiEnWI5zgZP1TenTjA33Ne9UghkbOjcRbdPyN0Nu90p?=
 =?us-ascii?Q?HkbhdJ9BTFqL0bCKayxeqEXhLmIY0QJUaibQ06ZeVky6SKouwJhiHq1oSRqY?=
 =?us-ascii?Q?+W0Gs6G65zZuhbZLP5/em8fw/tzeyZ+ojSu1xnrnGu+zCAcG1U3EYZyWY3vU?=
 =?us-ascii?Q?29XiMwZw+WvDVoFhvmPMPxlOa7PgCjbNqFo9v6UPXgt+tPJNhxZKd2sE882w?=
 =?us-ascii?Q?zgZwjeptrKUrLgzVuOZZdKlymzCRWHThjeLvTokfMqlVuEFMspt55KE++Eon?=
 =?us-ascii?Q?7CNXMpWzhoHi5kfFuuqFGAnOzDsuEPWPEdb8A7bwhHmCWnWuZVDFPoPHjGAX?=
 =?us-ascii?Q?/X5xWqqe8wD4/6gyDlOJ9otJbUL5Vy3twGJk1VBmfutGN2aYF6OoNWvjrXsR?=
 =?us-ascii?Q?qwfiBkidwjKRLoSHQDOhMvrvrDr+WEuP0F2Ja30ACD4JdIC9zBADZC6ee1l/?=
 =?us-ascii?Q?diHnix0jI83z4v93zbUNm3EvEsg+PZAyxIxmOfFmiZ+2tMWh7jISeqL+pkgP?=
 =?us-ascii?Q?UB8cz3hL0ymD3eSgJkpAGSmSdyDUBPTQ+lz3osDvmQ+YIHpb/RD6y1s0cADj?=
 =?us-ascii?Q?Fu/r8DYX8FCzmprW4S6gC2B1F7MxjgMe1dNB3Sl3WgHRuFrTDq3EnV01GBQ3?=
 =?us-ascii?Q?rs/3TnlwyKOuGWATKspLKXqc30S2rKI81pQFCGnMtXiipHf9q8e0Czs4KwXX?=
 =?us-ascii?Q?WslLRnfOXnwOpgQvrDPdWJchdMfLJIr6hwdshOs/teX30AS8lv8vo/67Nl26?=
 =?us-ascii?Q?W63WsI3BqkY1pNWBdVlvR/rwbmoeI7EJ4ht4etnZE1rCxA5fj5L2Oczl4fr0?=
 =?us-ascii?Q?x8RmxgYOqOvVN+6yCXj35+oEGY3Vmucjuyj1sRAJZ3lqlW7hw9Eq6WlcPnpU?=
 =?us-ascii?Q?eA2cPoe5b7RwXUhAhyBxYiE2CI15PQJOMDOZG0GszOf2zo2XE3QIHfiUOs6i?=
 =?us-ascii?Q?47UTgWPYO62jtwU3pySrj+9vQmyupVe3rGQJSdw68JHjn9TH0XhGEnEw0L6C?=
 =?us-ascii?Q?9/fEAiZ5/cemanyPIGCh9IBPYZC1O5u1QZCu18gN0eC+WznYyxBtnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z37KK/4imPu96DvXJCMMgPBgKiWtScUC8gY8K6eYWOmIPEozj1ejt089M1Nx?=
 =?us-ascii?Q?wOMqGXn5stOjVBEzkuSnEaNiVFfaFKyr/XwvRIkJnGmvIZpHfVUMAlAZ+iGt?=
 =?us-ascii?Q?pNTCSEisZu0mPQOtlxEkGL37KrK5ax3dqzx9YEm7yY4EgfzgwPE+dUveuPt8?=
 =?us-ascii?Q?FnXT8fkYiSdBOEN47CTJCwbXncpSNKDPjMaN2FRpL0m1qY3NmqTKo4GjJmU8?=
 =?us-ascii?Q?paFYKA5c7bwFCQR0y0kPpll4zAMZUUNSLtRnKRM2IuPdxD3Lo0aCjVqSbDbl?=
 =?us-ascii?Q?gKwf0/9PbIwinQhRp9cy7MeUEnGqciKGKBBbwSYV9Vc5BcKvj6TSlnLzVydS?=
 =?us-ascii?Q?sRpSwixI9ntCcslEUijrT3VooWvLYlCdElBBT4RteNRrsArUcJViW6/jijkh?=
 =?us-ascii?Q?IyGPmTY17YqE+1yCtPmIqjtC4UAD0/Ml6APWEHAZSjlEU21ZWuGP/bO+zNME?=
 =?us-ascii?Q?dndx0tmopVH44tQ4e1lGfCwCBSCuURuQcd1mgv1iDY3b45PeT0UOX6ec0rQK?=
 =?us-ascii?Q?mHD1mX1N3HrxO3Rrcnemzsktg3wgXnBs+XCuX8RBbI57YNZm7hhg14Z0QQow?=
 =?us-ascii?Q?pQBRfp7nFS2UGw3tgD9VD2cb7AgCyjVbuUr3Xam5O62zgY9ZOoZ3Gf0WMQqo?=
 =?us-ascii?Q?Tknhhl4oXQohZcL/ufUOMHd2StWtPZaNZGLhUHk8MDajRgMaOKWoJcFurCnS?=
 =?us-ascii?Q?cfbqMh+oXh7ncthE1Qz3W5MdqV12auxGdqJy0MuIiXJFHfmby9EjHPjWQEM0?=
 =?us-ascii?Q?l78nUwE5MEp5XUmyDToEmiOUIlszxiEhcvcm/y8M9VC8yEWljAwYahSaZEW9?=
 =?us-ascii?Q?Uoun3DlWZhqZGqJrWJxJCclRpJ/s0J7MHPavJzGzgYQgM/pANoIuGqoZV9eS?=
 =?us-ascii?Q?wMSOnepkFT64InaGRTdfMlcncESfpiAEXWmzI84sPkBK4prmK0bVdiAEafqX?=
 =?us-ascii?Q?IMV2pwLDN7p/3F1ZRZ4Lx5suViYqtijXKZ8dPRPj9eAduainlcwskJ+R3q9V?=
 =?us-ascii?Q?sSudGEJmowvGmlZhUobhVfQZeu92ea3eXt+4VF3poPvNhcwDmoXjkgqoALLZ?=
 =?us-ascii?Q?8o8cmHmiK32L4rafzJijbp/BwqN2SZYdfAiX9P/L82KSjznYSy9T/p6ZNb0/?=
 =?us-ascii?Q?2n1CDqzyUDzsg1lOiVAySTX+RU3oaIvoKfov1eOgEdEpcOmBC7JFPj4vcfzR?=
 =?us-ascii?Q?0Gf9T9TpAWxD9xNI4qCxPOyfmOFBPsmHaqufOIpD+2CFl81kMNNyTy6SfIXw?=
 =?us-ascii?Q?xt5yV5M0ORF6BbYsF5mbAOacnG4MF9XGn2adjovg0H5tqFvXjeJqhNqiDjnW?=
 =?us-ascii?Q?JQEMrzoJ/yR+bJ46gDBfg7gm3hG9r5kQ1DE1C2Ln4GxPV/Rj5vhXqL1h1rZQ?=
 =?us-ascii?Q?hp6EO4hNtG1p2ASAcVc3KtSEtbWZOd79iOOQuTXVKCq225dYg3gBzrCg8WIg?=
 =?us-ascii?Q?nBhcL6tfklB9lmMy56ak/IVcMl0MOVAFyf8yY89GB/Zt0OxGVDYjgC1E1LWx?=
 =?us-ascii?Q?uDC/S6dfueQS8cxkf/ZcchWJHWSlTtL3DZ3sCM1ySO9ILsY2bed+LFwdtKjw?=
 =?us-ascii?Q?U+iIwBjnJgleK+1cDd81JramJvLjFhukkjYKGwjv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea17f3-fe0e-4965-e8dd-08dd9e00d12c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:00:50.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqMChZdpZB+dQrB+ZfIfYWKLj6iUgk9Ai0TsFcYDCPReEB9Jlepp8//cnp97XmzTaGHH7g3RyCIv5nCaOj690w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128

On Sun, May 25, 2025 at 11:40:04AM +0200, Christophe JAILLET wrote:
> 'struct thermal_zone_device_ops' are not modified in these drivers.
>
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   28116	   5168	    128	  33412	   8284	drivers/thermal/armada_thermal.o
>
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   28244	   5040	    128	  33412	   8284	drivers/thermal/armada_thermal.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/thermal/armada_thermal.c                        | 2 +-
>  drivers/thermal/da9062-thermal.c                        | 2 +-
>  drivers/thermal/dove_thermal.c                          | 2 +-
>  drivers/thermal/imx_thermal.c                           | 2 +-

for imx thermal part

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
>  drivers/thermal/kirkwood_thermal.c                      | 2 +-
>  drivers/thermal/mediatek/lvts_thermal.c                 | 2 +-
>  drivers/thermal/renesas/rcar_thermal.c                  | 2 +-
>  drivers/thermal/spear_thermal.c                         | 2 +-
>  drivers/thermal/st/st_thermal.c                         | 2 +-
>  drivers/thermal/testing/zone.c                          | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 9bff21068721..c2fbdb534f61 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -408,7 +408,7 @@ static int armada_get_temp_legacy(struct thermal_zone_device *thermal,
>  	return ret;
>  }
>
> -static struct thermal_zone_device_ops legacy_ops = {
> +static const struct thermal_zone_device_ops legacy_ops = {
>  	.get_temp = armada_get_temp_legacy,
>  };
>
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index 2077e85ef5ca..a8d4b766ba21 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -137,7 +137,7 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
>  	return 0;
>  }
>
> -static struct thermal_zone_device_ops da9062_thermal_ops = {
> +static const struct thermal_zone_device_ops da9062_thermal_ops = {
>  	.get_temp	= da9062_thermal_get_temp,
>  };
>
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
> index f9157a47156b..723bc72f0626 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -106,7 +106,7 @@ static int dove_get_temp(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>
> -static struct thermal_zone_device_ops ops = {
> +static const struct thermal_zone_device_ops ops = {
>  	.get_temp = dove_get_temp,
>  };
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index bab52e6b3b15..38c993d1bcb3 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -361,7 +361,7 @@ static bool imx_should_bind(struct thermal_zone_device *tz,
>  	return trip->type == THERMAL_TRIP_PASSIVE;
>  }
>
> -static struct thermal_zone_device_ops imx_tz_ops = {
> +static const struct thermal_zone_device_ops imx_tz_ops = {
>  	.should_bind = imx_should_bind,
>  	.get_temp = imx_get_temp,
>  	.change_mode = imx_change_mode,
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0e07693ecf59..5736638c586b 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -515,7 +515,7 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
>  	return result;
>  }
>
> -static struct thermal_zone_device_ops int3400_thermal_ops = {
> +static const struct thermal_zone_device_ops int3400_thermal_ops = {
>  	.get_temp = int3400_thermal_get_temp,
>  	.change_mode = int3400_thermal_change_mode,
>  };
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index 7c2265231668..4619e090f756 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -48,7 +48,7 @@ static int kirkwood_get_temp(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>
> -static struct thermal_zone_device_ops ops = {
> +static const struct thermal_zone_device_ops ops = {
>  	.get_temp = kirkwood_get_temp,
>  };
>
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 985925147ac0..acce8fde2cba 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -571,7 +571,7 @@ static irqreturn_t lvts_irq_handler(int irq, void *data)
>  	return iret;
>  }
>
> -static struct thermal_zone_device_ops lvts_ops = {
> +static const struct thermal_zone_device_ops lvts_ops = {
>  	.get_temp = lvts_get_temp,
>  	.set_trips = lvts_set_trips,
>  };
> diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
> index 00a66ee0a5b0..fdd7afdc4ff6 100644
> --- a/drivers/thermal/renesas/rcar_thermal.c
> +++ b/drivers/thermal/renesas/rcar_thermal.c
> @@ -277,7 +277,7 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
>  	return rcar_thermal_get_current_temp(priv, temp);
>  }
>
> -static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
> +static const struct thermal_zone_device_ops rcar_thermal_zone_ops = {
>  	.get_temp	= rcar_thermal_get_temp,
>  };
>
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
> index bb96be947521..603dadcd3df5 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -41,7 +41,7 @@ static inline int thermal_get_temp(struct thermal_zone_device *thermal,
>  	return 0;
>  }
>
> -static struct thermal_zone_device_ops ops = {
> +static const struct thermal_zone_device_ops ops = {
>  	.get_temp = thermal_get_temp,
>  };
>
> diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
> index a14a37d54698..1470ca519def 100644
> --- a/drivers/thermal/st/st_thermal.c
> +++ b/drivers/thermal/st/st_thermal.c
> @@ -132,7 +132,7 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
>  	return 0;
>  }
>
> -static struct thermal_zone_device_ops st_tz_ops = {
> +static const struct thermal_zone_device_ops st_tz_ops = {
>  	.get_temp	= st_thermal_get_temp,
>  };
>
> diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zone.c
> index 1f4e450100e2..4257d813d572 100644
> --- a/drivers/thermal/testing/zone.c
> +++ b/drivers/thermal/testing/zone.c
> @@ -381,7 +381,7 @@ static int tt_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  	return 0;
>  }
>
> -static struct thermal_zone_device_ops tt_zone_ops = {
> +static const struct thermal_zone_device_ops tt_zone_ops = {
>  	.get_temp = tt_zone_get_temp,
>  };
>
> --
> 2.49.0
>

