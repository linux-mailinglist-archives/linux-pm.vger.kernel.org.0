Return-Path: <linux-pm+bounces-16866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD79B8E82
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 11:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8786280C97
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651B14D70F;
	Fri,  1 Nov 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wGU+26bn"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14564143C72;
	Fri,  1 Nov 2024 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455375; cv=fail; b=HnDuYEGk9Gk5u/p+AkZD2YLXPHc0G7dUkJPXI2OUpFYxGoyl0KaOj3RmaRY5HkRWe4vwg51PeeVFZmilbgvgpqjd6SSzPM1oZM/OXx/d6i9kXi8JogxdKKNEXX+mBlDNSlp5TjaI3bvhBal8cKcVZUWnY+1WF3DC/MhaKHZ6CIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455375; c=relaxed/simple;
	bh=RlcMXrfB8Ei1VQEPipObzLniHUeuH8JBQplJnCwhj3k=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=srCreH5CKt4EwOCs4Tqyr1sKeHLShNxIxnElcQSXQJComzLoVF0xZZ2AFs3l6y+ikloPGqNSFWNNrhIpv6/n9RyN/24OmCRitsh3a08/IwE5xQ01mjw9YEDHBJq85/WfaB+CIbFiDOR4NZquhBNYCLKdGORminpfAFzWz2e8qmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wGU+26bn; arc=fail smtp.client-ip=40.107.105.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIbl7iRwXb6Q40Jd5e+/7vYQtKA6E4OlDqH9xtjGRJAfqawO7k4O+IHKRmZuJpNldvH5QKo71RcvduLzYZsbA7irqgVh41y7QZIShevD6kWIi3clXGDVpQxcKcNQaO4AmRvRmab7u03Vjb3c5YHHLyLgsyyy/mLKtV/UtWUBkpbsFuEpXgyGlt6Jgh4o+hxVUNMXBBh/Llmsqodap/126Mx6+/tHqssEJpngHAJJGy/6l5SC6KwGTF/5SO/fnePjGXeseOYar8AtKiH2hfZrz8IZ7tWJi9UfKZ9r0BZXTgwNQHsgOZmv6FnOWKedPSuR8QFaktiNSU3U7zHM96MZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIU2ZaS4nLmZHkDkonFZmnunZVFNb6KNBJYkhNR6408=;
 b=XHqHwvK6QMpDEjfSeSj8V/CIY908WGNaL81Ia214086LWNHDCxslTsXzmNe4WWBz5EL2voW98Y+cQ5ZYCawhtciNYLCzv2tMieVtiGp8KU7I9eOF9vUZsc+ET3h+BRGpxT7jFkx8mNy6BQaXBSjqSSuXwIWMcdFPUC1onqaB9NPITqYV7zbzWvIEAPIPs+gh65Sg2YaWLh2ILKXdVaWeqoQkaONSd71b/2bqDtIv7YEmPDVKODy8zeEkwsA7Y/s5+21fDtmmcGTnVacGpkQlqrLHhYMADt/z7fI3EHvWW9NoN594Sa8Jy8x3l3L7hR0tH1Jo0W1FGmhvKb774vBG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIU2ZaS4nLmZHkDkonFZmnunZVFNb6KNBJYkhNR6408=;
 b=wGU+26bnSif6XPzXmyi7yTjtv98aF9hXuAP3OamxqcN9ewm04UeyNkKgqDg/XaZnnkXQAz6FQXtAtlVaQdHhBkjfPbQY/pb6OhhpgC5LJAhNIAyO6qxsCNxtUrmH4iHVfGsHuo9oyCPZotdS7CEpdCR9Y6cJswyikKHcfqzx9CnQz3JUNO3b+4Smgu2bYUQFegRM/zYleEfhmXGREH8xvGGwmdohnQmRwY9BRIoo3K+TYMXKOeA0mvU0kjgGHg4TJTWx5wDJsW2hDUdurVIiW0+3lYbQCWszGfk1gUkAhZHQzUklTXnXAobtV4InRLJa4EVcqojE1QHqBHL9xmykUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7200.eurprd04.prod.outlook.com (2603:10a6:800:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 10:02:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 10:02:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pm@vger.kernel.org (open list:GENERIC PM DOMAINS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pmdomain: imx93-blk-ctrl: correct remove path
Date: Fri,  1 Nov 2024 18:12:51 +0800
Message-Id: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be43985-741a-4d45-4ba3-08dcfa5c57e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d7PK6XJxJ3ZuVwIeN4boK7LBwVHNmLej5z6QvEixVr3FUpb+UErJj4eJAuRV?=
 =?us-ascii?Q?U5WYFdL46N1Zku8RevNDdEdjw2dbKV1M5jx+DlKnvkGa3x8uNn7PDBVpfQPX?=
 =?us-ascii?Q?+nF5CDNWqv8ZX8mDAXGOt4Tc+GJJXZwUd+NXAvoaZejsnc/HZt9Pj7tNZto8?=
 =?us-ascii?Q?1V5mS7Ps5HG+EMXitGDbXEufGtaYJc+UsVJX4pw+aL3nlrBNgPj5l68i9lSv?=
 =?us-ascii?Q?qy7oaLllS+Uu8mzr3mV/dkKj6ur4Dvd5uefgaU0XJ8kc2ufm/b1p3EjuK4fg?=
 =?us-ascii?Q?qNv7H6vhpnrWSBk2MnkVJ5c+vkeeGpxsh1RqnLJ4+87NePuOx662eYsCcFN+?=
 =?us-ascii?Q?T9KgEKdmlVrPTUHOCQvsbKl58EbHCfJ51I9y4U0V7DSqqkS2NtEhUXrmrFWK?=
 =?us-ascii?Q?ljh2u7H+qkrS1IxQZK1AI3HP+f9b95nWRNRLd1driiDWMHKBF251LMiePryl?=
 =?us-ascii?Q?IAjxlKF6laaJrOI0xkn6nuB7SoIe9ItLQe7ibVzS4Rn9fEY6SwM+O2pdY07g?=
 =?us-ascii?Q?/2BHU3eYyNhrvijykTuNA/Jr2foW4aA2uqtlhovH5x6gncio29oGeUzgLK1I?=
 =?us-ascii?Q?1dKYjLmbNs7hofXWtarXcxQAxb4asX0StXdTIlgEcK4yfkRPzHh+258JzSWc?=
 =?us-ascii?Q?z2JWfQrDU3c6/VvQKdkZqw1a1g0sTb0SLbro2rQr8fRfy8c8cAKUBAT2lUfN?=
 =?us-ascii?Q?yZVx9LhakuDCkFvx0qCXWpJ2tudDyUepKyYkIVeLVatyLfmeHXiqDe22HmXb?=
 =?us-ascii?Q?csjJJiUTS24T2cqX74AHdn18z8rJhuYyztHwyd1RfWYyMxfFw42NFgSERjiO?=
 =?us-ascii?Q?JEstS7G2i0rB+1n9cZwtKwaxx3377bcvXuOXnatXDR8xahQHsV2qNg4Ag18O?=
 =?us-ascii?Q?kHt9Q8C5ajsw1+VpnpmQqOWwSYk17piMd0vLE/YjopoqOfAuWTeNmdHuN9RR?=
 =?us-ascii?Q?xQXA5QMhkLZngZEZLzEsw7/xv/1kCAGGSO1jhC2cFs+YPecsX/LmBK3HJwAA?=
 =?us-ascii?Q?ipcrsd2DnhrpACJX6O8fu3U4juGTFqh5Mn4SfsIAwolO9Iig/u0bkc9jOIox?=
 =?us-ascii?Q?ApO89GRLfCLo4ea5YzxZSWlYYIEQPkG7FFoywYWvizxH/wjYojMp5IoYbVAW?=
 =?us-ascii?Q?Ue0eEH6246ro6bZnr3YWrM0/gP5ONGWEkwVayskNNOS1m7tQHnLtCwxtvHi3?=
 =?us-ascii?Q?fpWKJFWI9mOZODezHTRsEug/RbhVspanCehKay2aBuviqWSQpQ3P93xIB/e7?=
 =?us-ascii?Q?TvtcmFUCXCkQH0sNlBHa8BjGZo7Avrj9AtIbOVo95b+gn1UGOLhmEFFpLIsD?=
 =?us-ascii?Q?oBtEzFop7CIYzu+Bv2YWZabBrAHflzKVGE7Qf/NoQCrYkCk8ambzzuEj5x8m?=
 =?us-ascii?Q?FU7NsqdZA931r23EoJBBoe+cULS4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWmp0M3IQmucATG+BzMWm82JdBqw1dvjmG6IStaILW0rpYygIBpHMh+cHxsB?=
 =?us-ascii?Q?XX6dbLcg2wx91N7A63PgMJxdoNgZ3opLtlmmQN8p89S//wXbTfux8Y9ahH3+?=
 =?us-ascii?Q?zhLA7tTp1ZNDmgpmAmH0oDnAdpN4D1mgSCHZMfC/p0j7u2yMlLOvAf/Nsjk5?=
 =?us-ascii?Q?r2SvNUapV0uMN0YAGbFBQxDxkfUQZp+QX8Za0sgOOhbb87E48NbtHSNV4NMw?=
 =?us-ascii?Q?Mb8t2IKYsJP0bkoSvjbEkJXyKfbbaUI24KS32tZhAJ0jyhUfnxt2RNJc0oRK?=
 =?us-ascii?Q?5X+LvKMdG6rVl2+MSpbot87uAkGDV7LLdowCzAiUM45JdpTexhaFFi0Kuj5r?=
 =?us-ascii?Q?Iw60YaHG0pU3p/Q9MREZV0280oBGno0h9wVgs/LYsUYmG6p20mKa7n0d/bng?=
 =?us-ascii?Q?pm/E5f3H1pCQsMqKWnmB1l/Xa/1kO7se0COJ0KvBeO841eUVx3n07Jhoom6D?=
 =?us-ascii?Q?l2evnt/Yi9NFtaDjgfZnIU0QA83h+NGXmmZF/QEB5IhwsY3A87ST9fTYONHL?=
 =?us-ascii?Q?Y+HivNRLkZ7Ng7M2lMjr7FF0oa5de1usuoy3OZOEdIwLzTU09EcCN9RF4JbX?=
 =?us-ascii?Q?jTTkiWqB5BRuabhM9AlyblFGUbhFww/k4HP1DPMFj8K4pPhUfKrEh6kNqvlO?=
 =?us-ascii?Q?YGrbSvhgwWXda7CYpyIwEqPRQqlbKfHYij+YUnZF/iqaolLKc02v90Ke+qEZ?=
 =?us-ascii?Q?hbRkmohfMQSGQqe2ENKHS/Eo7v1h1KQ8jLnsy/A+Ml+KQ+8ZlrT0D/M3sQHF?=
 =?us-ascii?Q?KT7ujHajCWCP1Jjw5iHwVOGeRNdYTunC+xMb3OmwQaYEHPoTFcdfqbJUv89u?=
 =?us-ascii?Q?fgg9mAie9IXGULayezNNBzGqVNN8DGcT/JSoBpBYYeQDra3WuAJlgVEkek0q?=
 =?us-ascii?Q?HHUX+bljwYeXkFuVQlwZ9wDrab2Lthh/dhkOOHnfnLCG99otWVhKv0GPhMN3?=
 =?us-ascii?Q?uzSqx4HBX5GKX4uPgRjQW9JeS3FXx4AdDd2X2569wN2ShCPTOQSdsdx4bWux?=
 =?us-ascii?Q?l+J87R9Z7HjXaKgeTGACSk4OmADsTAWLyRL5xfK7TMJWhGJyabB5kRQspVgV?=
 =?us-ascii?Q?Du31Joy+WDQ8YWjUfFvaXKtUaLdmNP47zbRP7OR1Fc4tWQJOf6Nat2OLQlZr?=
 =?us-ascii?Q?zQd7MzUhFL5S6LW9hp63rqqxLwGzDB7R/3gsuSLBLT3U+vMqWoc3C7XdbxzC?=
 =?us-ascii?Q?fZNEtfsEOcc+BYiICvJR2BIz4GIwJkAKTkHpr4PJfYz0AV/kSXcC/JzgQAs0?=
 =?us-ascii?Q?laHv6S0aX5rYlqzmXCPXG1argHx9khYY5iL0uxHebV6+3GvOpaV9wkq8flLn?=
 =?us-ascii?Q?bKn3RQ0WeeCAA6qMP+ZXfI+lr7SLshPOUTegeImiAhTJMT4cQIRaP8PlRFzc?=
 =?us-ascii?Q?ZB03ZJckxkrMGKvZkiDlLfNluCtqmy4JoJUDak6OTOtuSBAF5kLnBG55fxHC?=
 =?us-ascii?Q?q/2jVi8o1rYRav6GfmGkTVABramVYQB2u85DjzG2zmFzEmxyhsR+s1v1gFh+?=
 =?us-ascii?Q?LMrjbFNYuo5tJBQwGSr858yXn5a5eZkcInZeTs2ciicHfrDNX/8Mck9JK+nf?=
 =?us-ascii?Q?pk9nWHNlxSEEDrfO3fDv0qYdhb9+BdO5WBj3GH7V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be43985-741a-4d45-4ba3-08dcfa5c57e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 10:02:50.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCcZD2InWv37niYAq9+q16dYniDKsKO9QmXhgPYKtFqnd4yBvZm763U2ELuNNL0AwyjGQNZ4/t0xOUtR1n5pyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7200

From: Peng Fan <peng.fan@nxp.com>

The check condition should be 'i < bc->onecell_data.num_domains', not
'bc->onecell_data.num_domains' which will make the look never finish
and cause kernel panic.

Also disable runtime to address
"imx93-blk-ctrl 4ac10000.system-controller: Unbalanced pm_runtime_enable!"

Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 904ffa55b8f4..b10348ac10f0 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -313,7 +313,9 @@ static void imx93_blk_ctrl_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(pdev->dev.of_node);
 
-	for (i = 0; bc->onecell_data.num_domains; i++) {
+	pm_runtime_disable(&pdev->dev);
+
+	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
-- 
2.37.1


