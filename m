Return-Path: <linux-pm+bounces-31465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1919B135A0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173D93A4E0D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD26D2367D4;
	Mon, 28 Jul 2025 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TJ4+mJJb"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BD22B8A5;
	Mon, 28 Jul 2025 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687144; cv=fail; b=W9MNPSVBTR7JeYZKaLBm/qOFaBvXS2WEvAKiFoRsIzpreKQL8+ZCDdI7ix4A+cfGpVYbzHbz7eGd1IHSw/rw6TlaXAuWe8zE3oEzwFfzw0OgGAaX8YIs6IAsp/gn7U0XeBdjtwAwNgSBNPkuzZDe8erStVb5VskPyOAsaOL5FKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687144; c=relaxed/simple;
	bh=CAF9o6KR8IL6dizjhFyRQiVLcyMX9ncxjaTJ1aybzFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPQzGJouJT4IQCoLzt468+6tg1l5HJBXhrvJKpn7/s62XInu09DC+PDPQfexxPACuEU8tnNKeYMsqqahkCa2as0kOQfePa0O9rmNSnFEA3NAt816fWsJbL442ag4OwWJQTCRa4ZNRNC/2wiAkhXAMYsTIU9UwWWviKMxBHfkEYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TJ4+mJJb; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kzg9iG4Saa3UHSmf0B6T91waLNuT80LWoaKS5R+vVuInWVVKBVPmI5FA62Z8xqHg3Gdj/NAPQaBYxYW7frQEpYzBJB8BaUQLrj5U9R1omzzPvP9no0S2w4Vnbg1EWPlOMeTViAQUqBkOEBuXr4ZJZgTwyIkyq1szkiKM06/gp0yvgkmI0L2T2ddxUHazMAa7QEHUplZEEteBkWyCjr/aFSfrYhZeYtubfXAdjqAllWfULTLmzuLBmbuNYyhfM9p3HMtJKMqLnM44gtJRNi3nlRNtQyb6scFIvi373mfCdSgKQP3BpTauYLBu8cOqeTihlLs5ImoKnhZoUeRifBNjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/ewjz9MSfSgcneQZg2VwqmZsMYvUuwnlFGfk/j/pLA=;
 b=mEE6fZyq2yMjCOcqW2N8BoQtC+nKykIVF+ctyx8/FXR5lLkEn2tlV/smMUe4Y2DCXpc0XUDHEkHaxjvRCkvuh0F5hOPqWkm6vi1vh37YJOCUliBxQAVwzouKQpwIiPSonFmYh+cZhRLlq7VKUE4dGzufR15d4O5CezF9+j9TOazRB1e6BuQEPxSswapkOKk5wYb0vu/w/YmiFfbyx48E56APEDz4cODc73NguLsWDyOEGbwM2u4sWfCd16qyK2ge3z9cTrNvFICRUzhSDzadtlzySFlqDCBpv5NRgk1XqMtfe8PhbhkgDTbdmUkVPPXVdcmH8YPNUyOlO2dW311Iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/ewjz9MSfSgcneQZg2VwqmZsMYvUuwnlFGfk/j/pLA=;
 b=TJ4+mJJbOlKXUN+lSRUJblEspX8+jnUWKeRlz4KQ0BiWFU5zba2ZdrUoYoKzgM0ucx3Dt7+8B4eyvWPwGG3WY+WvXnAx9l1qfvUnvlejw4CWLZJeWA7uRL+j3F+SQVvE4QmG7Xe1lBVcG3/vLRUlREN9LtoCF20ATdHXQpWvaP6u9CcorSjtCLMuFM9icVt2BOuLLZCyn+IWzvnX4vcNvt6f+M/OXNCFu5j8v3WQ5l0hxoOwbGl6LOE6yyBQBvHK6Vlzp0NO9ep56Z5moVYRTzniDFP45alhvVhnjXJ9pcRiSbwA8INQSpBOpqMr/OBNkDORPm5eL/G5qAMOz/ljpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:18:57 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:18:57 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	richardcochran@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	frieder.schrempf@kontron.de,
	primoz.fiser@norik.com,
	othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: [PATCH v7 11/11] net: stmmac: imx: add i.MX91 support
Date: Mon, 28 Jul 2025 15:14:38 +0800
Message-Id: <20250728071438.2332382-12-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250728071438.2332382-1-joy.zou@nxp.com>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6912e6e7-5fd2-4ae6-c3af-08ddcda7042c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOUeTa1aJECcgTRYox2VBRFo38e4K+PBxmN85QR0iGzqxgTmWR+P00uW2NYp?=
 =?us-ascii?Q?2UyipjvBGt1qAiLB9njRSecs3wAOX8JnBB1aKTn5efiE8aesXfJpFS9KW4cs?=
 =?us-ascii?Q?g1uuwXg/kF4y3TuI83rg98ln2G6XpeWRVpWTTyfcthF4P7DAOuHdzadKZM9z?=
 =?us-ascii?Q?3Lw0DZSxFK8O+wJthORXKhxj+qF/E2uLysMV/UH+uya1xvUrDrBAxuPx5fb2?=
 =?us-ascii?Q?CfX0K8WK075px0yow3FOxmEtqN90A4OfGUNcW9cykGKOscqL8f+cW2x/VEei?=
 =?us-ascii?Q?Q5viZ5L+88VUlE/7GyrMlQUnGrUQTVcgQje/ZNqbzuvJfD3X5kwq9F7RPb2i?=
 =?us-ascii?Q?Lqgyl+ZZfonUhkqSNUaaH1Bc7HgGFHjp/rRtnxVLZvNui85TmL0qs9xVZfLO?=
 =?us-ascii?Q?pXILaOArcsn9f2hVOSSuvJrnW2A+3mPnKHMIrLe1PEawQIMi1NeVWV3GfCM8?=
 =?us-ascii?Q?DDLmokYdFPzfURaKRqKDPfQm1ZavT6x1c+2Ozma9iyzatufchDsf9qIjm8HY?=
 =?us-ascii?Q?U+wpjzZEbJxylw6QV5pjuL+Br0EBcYyYe22gihPIMz5PtNvNb+KpWYNVU1ZO?=
 =?us-ascii?Q?45Wcv6vwTVfX7J9lKZK7EqVvrhfIyw3hdMlK2gU/lYebrECbH0ajSKZA5ztP?=
 =?us-ascii?Q?hmIUfzx1XHC+Da1MFKxrAKE8nbrFsCnYaDX89yQ+9WdBNfjNSly91+rRlbb1?=
 =?us-ascii?Q?68ep2xOK+RWWTV6r+7lCOiI8bJjdJhn/UlHgvkfP/VSV1XzJ3I6c/P96Ov9w?=
 =?us-ascii?Q?VAqZNqm5gGR37JNgt2goTNpLSyHyokBNMxRk/WGtp4H3gI9cc9pfV5WkPRq2?=
 =?us-ascii?Q?ui/Q8YJbbtl2Hl+xhta+x+0lrQJrfrvBO2kTY0acAaArDk3XvAmnjocuxtqn?=
 =?us-ascii?Q?lH8sTvxKaU8Ufoft2Tzv/TNaJsJFustoiFepxDB4Lm6dzdgRaQJuYlEPHr/e?=
 =?us-ascii?Q?oVDoC76gWNXyPD5CEwYhSX4Y56xxjpCuVJE50CyVlWEGtAr82YsdmTtYOLx0?=
 =?us-ascii?Q?N1OYTZbkyHruR5wFSDOSXTFWPCZSugLYt1BP29n1eVPlcSS7DyH1vzg0bnVD?=
 =?us-ascii?Q?33yNgOABd5KsdiTwKwXaAAxQMNylAe70LL7SwYENvP+HyUZLazdgvcxIFe2+?=
 =?us-ascii?Q?PBWK+PQY+L7viOeAwwFP/EC6OYpo6P8vd/CXvb4Vv6aHeu152Cj+cKza+bQi?=
 =?us-ascii?Q?cEWwNdCjv1yZNYn8G8/WkcLwsg/f9ZxgQ/k4X1F9ee/eGzWa+t08ENA7nmK2?=
 =?us-ascii?Q?JJxofG8h702a+cuhmUCJAa5CG6rPNSRS/ww5etsJUIJuVrfpG3QZCDbXOA+L?=
 =?us-ascii?Q?Dk1GUirZrxB41z3lkf0QGqX20L5XIt/xX6xhU+EXQL7f9piV5aXqyC2Z3ZBC?=
 =?us-ascii?Q?wqiTiXzgMYc7DfILYPM/nvNkVYtp+8OvNeGSMGGQIl4FaTBSzO0S+e9/qXTY?=
 =?us-ascii?Q?fSsHQCdu4KPx95ca4DzaUMtvGWuRuegLmXSGMR53C8+Fp+sWd4LXODgcSp+Z?=
 =?us-ascii?Q?rz3+PKnilS719Pg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6NOQ2CTkKJflElOdA9OQSwTSSePHn9EM/rAoO0nRsgAKOOz/ouD0MnB5Gim?=
 =?us-ascii?Q?rC9uZvN5F5Zvcp5PpJ1z75xSU+1W5GhTGG7ZP+hs4s4TZzct5biKQvsa3sK2?=
 =?us-ascii?Q?Sw026hx+b/k0ZF2z56QWKIx5X+63pTlGgbTzHA1eJpvpneRn+yJhMGysrPQK?=
 =?us-ascii?Q?vJ0bi/sQuKhsBo4V6ALE2pplb+kJYIJ2GKLjQX9EaqN5ZQ1AEY91BW4NG5gC?=
 =?us-ascii?Q?c8EEJ3kNsFz7yPR20eabztOBY6ZxMd+EvygRVZOrF81HXcpaMyVI39pS3dvF?=
 =?us-ascii?Q?HS5Fj6VeOJdnynt4fU38AXqdaUnYwXVR3y1j8+SnJCFsUNxTYsE0jBa6+XOx?=
 =?us-ascii?Q?GpPMAlGaNvfkDZ2zhhPFV8oATOyVX5sYTVW+C+1tAWLHtrL/dTIapQcL5KaQ?=
 =?us-ascii?Q?R63r+ao1dCPAj5Ur/dCZz8jPU8jnw4fG5s8KMbrB+oa3Xld9O/LBraKhPeLn?=
 =?us-ascii?Q?7d77/ym0y21jbE/zIKumay1s/bs6UZRMYYJsVty9yhHZ4QzFwXCiC7NMyQMQ?=
 =?us-ascii?Q?tSrhGwJOnTmg0U3f4znKtRYTrdwoWuVCf8op9LCXqHP9kD9oAIqRMFqNGtOA?=
 =?us-ascii?Q?Xc494ccN8cHcLslTZxLBZ/7ld+EYLMzDGQ/SOHSNTVZiXP+lrRRO2uFk/1HK?=
 =?us-ascii?Q?OEOy4b4RLjwxZzMNmUyczBRJ+DIwc6UnSVk15ivS1chyb5mpD4GqxAeBE4uy?=
 =?us-ascii?Q?ZA7Uu+51tdKZsG/NtUuGzgP5DYSPANktq1nO0yBHBDut5f9XKcBkupgYiWkU?=
 =?us-ascii?Q?9gPOs4FEtqy3nNfhAjSbqQKXksH3kIw/zZm2BXcZZoq1cIpQd8M7c6k6SD19?=
 =?us-ascii?Q?h4mA4rS7mKYc7NWx4gbUkSjo83y3StEDscjKucGS4UdNxIRTWuAqOMKiVCHr?=
 =?us-ascii?Q?XbO7jYCZQiLzDWKxho66wWgMU5PmZRzIeJKJE67QumIvewUrvTIsPYYHFdOt?=
 =?us-ascii?Q?9N2YL1aJuxrErcW4C+HGqUQf7HbjfquUOP9sEfMueIMNhhTTuyai6jtKFQRp?=
 =?us-ascii?Q?IfhP0bMEDkT7KUe3j04M/oBZLsV0elRrCW5aXZNl866xFnSLsDCHkSx+6l8u?=
 =?us-ascii?Q?RnZFtYNlCYtZ6fB0g/nlgGOAH9eIIJvsMeOttkZC4LNGeVmGn8RJolDq5CfY?=
 =?us-ascii?Q?yDxv53UyHjPeuCCbyOAR4yq0nu0CwVFwWsRmSvDbHl2JmYCubDpNxYuwOMC/?=
 =?us-ascii?Q?C6nPYBpxZEFHV6krg8FHcoBQUl3ZMdX4A9ZCZiix5KkrNg2k81QcgO1SQmh9?=
 =?us-ascii?Q?1o7At5gYlMCgNSA5t5HZTv2CNjCe16bwE6v2vq7ySCjclQeI7GY3XhhvMMXH?=
 =?us-ascii?Q?oL3WVN8pUYre0BlC6Y5u7cj5HUcOQwV1gHdyk5qwgZx2GsAqBEwLNU/Nu3TL?=
 =?us-ascii?Q?JqgbSdrYYb3E1EH4D7l1s0Ke4qApLqTZ1bM1fiDT31NixVkld+zDayAc3nq6?=
 =?us-ascii?Q?clUZZ5WEqinev1hGEyxemyyteBlN+iESRHNRWzwJ8xg3ZtCZUB9CQi5tB0XC?=
 =?us-ascii?Q?s5xrpipiqbAzwrtfg/cVNxXNJe867R2VtUwhVRBeW5VlPdWz9xIz+N1ocwoo?=
 =?us-ascii?Q?MuMzcRw2IT5BpWdlqVREhOZuvyJIqecjT4qbRl+J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6912e6e7-5fd2-4ae6-c3af-08ddcda7042c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:18:57.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOmlQE2G9xgFpTxL1uJaQ+zSYJWp7hMp0LRUEb7ZLQwX6oge8hbfy1TpmDk2Oq+E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Add i.MX91 specific settings for EQoS.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v5:
1. add imx91 support.
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 889e2bb6f7f5..54243bacebfd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -301,6 +301,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	dwmac->clk_mem = NULL;
 
 	if (of_machine_is_compatible("fsl,imx8dxl") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		dwmac->clk_mem = devm_clk_get(dev, "mem");
 		if (IS_ERR(dwmac->clk_mem)) {
@@ -310,6 +311,7 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	}
 
 	if (of_machine_is_compatible("fsl,imx8mp") ||
+	    of_machine_is_compatible("fsl,imx91") ||
 	    of_machine_is_compatible("fsl,imx93")) {
 		/* Binding doc describes the propety:
 		 * is required by i.MX8MP, i.MX93.
-- 
2.37.1


