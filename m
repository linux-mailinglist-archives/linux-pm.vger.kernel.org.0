Return-Path: <linux-pm+bounces-33708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989AB41E7E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074A77AE042
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEEB2C15A3;
	Wed,  3 Sep 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p8+Qb2jf"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012035.outbound.protection.outlook.com [40.107.75.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E080258CE7;
	Wed,  3 Sep 2025 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901565; cv=fail; b=dLpBhE7CUFE0Dg88P9oWCMvcgsTHr0oG+B/oLGYN/MGkm73ZXULTZQakIKPu5GPr3G46grPqks19r9kBLkIUjGRl8R5UcE1GHAo3IKeuCvopEsu5qknq1tkwm6ckl016GXtYw3QQ1nMcIjFWoJLQ1HRpijpOr3tSNKJH2xBWRcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901565; c=relaxed/simple;
	bh=d8zZdk3K1vaoxvlUDuhf4uy272zYbL7NlzQybipG6Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N2X4fOD0gMcgOYeIIg710p/GITz2npvtLDDk/UfLzULGj5q59XxKC0xzEZXlCVJLiMV/ZJuUol+Nf8wxaXScCvJopequcYfvVGWCqY3ZA0GPt3OpR8ynAsgeMSzQRvx2nANnTA6LvEZfGmoAgMnGRKC+okGMXDak4CN6MciXCVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p8+Qb2jf; arc=fail smtp.client-ip=40.107.75.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlQuCrOXNnVAK3Q7F8I625AsLk31ihFqx3kn/b46MRBdm53MS4lwFebdbvy43xEL+m0dORufgh0UXux3qWK09CWOJPszb5JH72KJKREKHHKGcxWsIdaMKhf8qN1dRRTDQirK/RLG+YXj5GXqN94yWUptgsbjvh3UenL6P/DBz29Fiq58/qiy9GtTm24AaQPTsgLZUJqDCEziU7Yejw7/9IsBxPsFf1H8lUz9apFzP2k2dDqNKqJLnHciFyL52WVK6lS51V6D/yUlmoCs4jLo+rKCdBiCAsNt57eZ86+uMPLa2sjDOcQEJzScbxd9zpve6cij6WoHO1kolvHdhpK9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWiTVV6MP3VGFowVvyTvEJEYXA2gpLhA4CpZAd7K4+M=;
 b=W6E5A8f5ch7uqgqxYn0hc/usLAn6sAFvnKJ+U+b2RHvd5e6k18X2VrgH7AkhBZDCIe/UWpraOQnqy7QERgkPlKWto8WTpo+eQNcDYMgj0uT5Ys2A6AggX4fhbJ3J8ymOAlnMUgVK4BVdsB77eesEmyLUwLFMsAwtaz+6CKv+AR1OlAUysHbr6MdacyS9d+VtsOeUvCLRgUOlfdgHP6k95RisFJxcKfd+du0qshLrKj3u2xfRtgaAvTRRKin+3usfC9Ai4xwMr0wDIzvtxRAa308ab72VVJiCSL0iXHSINGt4wx168r9p6wL4ZwJ3FuYwYZLdGDFQo5d8XfrV0k1tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWiTVV6MP3VGFowVvyTvEJEYXA2gpLhA4CpZAd7K4+M=;
 b=p8+Qb2jfh2ghOLICdPC9vcj536inOGqsEQD+Eoai//VyWsTrdiETfrrNsetFLC9AlKcOrMPbR2KRATwSrm7BU0tiBL+kMatzf2XurJkBkZZybvPVDwsTaxy6A3KNALKMX/+EAdO3BIyjU6RKq+Q03UVhHC+kyxTJSVlKELByZva4RGfoCfC6kFeEX6vpDwSpgD2h3g3vVfzRTB2EE+3OlqmpU4snhB4ZT1ps04YQezvdFGxPVhz+CjhGxgiHhCQfNVvOIFkzYzKtc5y128fartvinNsZcMEhqJ3rgTErAehIh/D3dZwNPT+I8ZtWeJDAPqFONG41q8H1P2lTPTUqxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7318.apcprd06.prod.outlook.com (2603:1096:820:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:12:40 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 12:12:40 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] cpufreq: mediatek: avoid redundant conditions
Date: Wed,  3 Sep 2025 20:12:27 +0800
Message-Id: <20250903121228.385766-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 057139bf-1752-4e30-e4ae-08ddeae32ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I9L+jX3iu6bRK/k1gAOlHTyzj33nkY7eVcbh8zNGIPR9iTN0AyXSsGPNO//p?=
 =?us-ascii?Q?G+QLZQ96uboocXlWwnfWk2yofkKyLiNBRZqbk07uu6FJHntVQ1fg89/M4kQg?=
 =?us-ascii?Q?NOp5uQU8yKgCZ4DPRoVxZaPeQsB7Le1s+vlk4eaJgrg8sweNnwmGhEN5Aay5?=
 =?us-ascii?Q?1hiJYhRN28jZBtHxbuk89NOF7ZAVOdH/NaDpZXW5Y3JKNd83+CXaUExVdwNJ?=
 =?us-ascii?Q?FagDLTdy8GtBep2qKhU5LC2o7AKB1gE9CKWtNfQ90MLo6tQEpfZ7b8ivwBda?=
 =?us-ascii?Q?vjfh6CykF9SqZ2rq9y6tKM7jri7ICt6aRbcX1xzIqlKObqdo4xW2p/rdFpxz?=
 =?us-ascii?Q?hnMz18a2AX8+RQLYYNnNNb/oxvrFPIMKgpcxPAmjsSx4EZ/deVOGH00y5o7K?=
 =?us-ascii?Q?gBhWt3hf75ONR/zyPoLZBtYcdbWYpVCts2dTTxbCY8MDYB04GF1EJ+DKB2cu?=
 =?us-ascii?Q?O4EEp7EOshh5D+UqyuZugimNFO6i8L2E7hWXLSF3jtRavPvvz88hXkSRE47q?=
 =?us-ascii?Q?wRTVZ3xoETcDZxCjZTIFAJXx1Xo/YPk4SfVQvKgs/dydTNie9w2sZrV/7Gah?=
 =?us-ascii?Q?+hnVqtAeN9nma5eZxXPCwUMlh2xBLRWfO9Ifgckqxb5z2XNuEBh43GzDcxW4?=
 =?us-ascii?Q?4DnW+KcxlE74tgUdkl0azeSzPHwxyn6lZpu1sajM5Fr+1Rlu9jUppGWky0uf?=
 =?us-ascii?Q?tWkTe+mpcdQ+6cw7Txzd7msmal0EszM4GlfxRwZnbXJHqYsYo36tQjYcMIYv?=
 =?us-ascii?Q?dSq3htOM/dVOsAKqWJ0yIj1TN6aNypcBcpMNOUf1srSCL53Qi5MVrTiaxjvH?=
 =?us-ascii?Q?awpC4Mbd6NOHk6fuz4oTVnc6IDvfifgkQtjCKGGKFULuNqtPJG/3ru8mpyvu?=
 =?us-ascii?Q?ZWjYJcWbXS0//aHZkYRfq7kn4tCu1RvtZPdgIJnS7owTQPQr2Bcdbip0DSs5?=
 =?us-ascii?Q?eSkgktRG84fpNCwlwbXcVbU2X4ZychIgoUEagYgBJGrRT413JVEjeGjAgvBV?=
 =?us-ascii?Q?okMmIy7FLwXupbRHR7rqirBVCalslY0NpTxVSBRMixbmBznApNO4LGpVYXc2?=
 =?us-ascii?Q?ozybE+KkdUFmoRme0kVHg5KOgBFxFhE9wQgvcYG7abAMj+VosXaXsXUMUGp+?=
 =?us-ascii?Q?dI7WCkeNJecB7tZXdOSRzRFv3EqbqPdvsdmMGsHQsZBVyYexDJOtuIm6h0Qt?=
 =?us-ascii?Q?nBLoAIWPT40QQKtzgrZpX4ruhjWJQ22RcBDq7/k5Bc0B3Mzq28X/tVb2pxe/?=
 =?us-ascii?Q?G++jXw+0WegTPoBfbxJjPnAGNKBMF0uk2mTgCregeuHF9M8b1TcldUT+53mw?=
 =?us-ascii?Q?JCcHuA5kwfw2X0id3qzPk8kGP0VJqKW30cPtCvOzjpGfraBIsfue/SD2iwA/?=
 =?us-ascii?Q?uUq9aPEFSkrkg0vc0e2YJu8jmoFDHfWd9t7ahrdvXm9ncWSnvPHN9hE9o0Eg?=
 =?us-ascii?Q?ConioN81q1xhs8O/uBbhCNqtBXPxiJp9SEy00vYNLjQj6aQUXEod+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8L4XFLLMnavDFVqoJ4RrWN7BmOtJhWUJNecKn0nTgKFLG00pEcvqTDNRbflD?=
 =?us-ascii?Q?9Qu7XACIY7oZ8kgothXqBW0tVuizDN+VEV+KjxX1hp8pN9eNt54uZ/AMAdrq?=
 =?us-ascii?Q?U7SoZg11v9/HV0mHQvqpNQQanOkaLfSGqOV6v6SX/lYAnLcHfQReIQ653K/E?=
 =?us-ascii?Q?o3f9AyMIE56bRjvK5FTkWG5srANh3w9+ymT0N1NIO7NwVSCOQ6QZLMsKEBd1?=
 =?us-ascii?Q?GubUp0kv7KH17cVguIqCbhqX1VCcr/49vD7PTgtzCE+hrHijnM2ylMqIt5+4?=
 =?us-ascii?Q?neSmxZwpuKpZpukpfY0LNnH4JmQ2ln+GlHHt8p8qzsk4YJb97uLX7oD+alp8?=
 =?us-ascii?Q?mLvxqj6vKZSsAYNZPZC+UnC+aoiaYLfPSoCHCCDmF6LF/uuWmDmpJZrsMfh8?=
 =?us-ascii?Q?X3HxP07e5U1j54HAv2A2YeXtabDjJGnXyLbz01HSauElo+uaLD431Nk6ljuD?=
 =?us-ascii?Q?zkXm2JCrO/+07tDCDU0QbN6WDHb0c/JurWBDvoRv8e1ItxLw08eSI8vhBdPK?=
 =?us-ascii?Q?YweIvE6MnTqS+wGlpOWOuujYzyOD8AH62mfdkJPvGPH5Y9RpYYPZscLytuJT?=
 =?us-ascii?Q?Codd3oNMQAmri2gWCE6uKFgyHRIpXoiBfzd5PtiedCJXBNq2kjyPhvFkyDXe?=
 =?us-ascii?Q?cCo2/tIi9ZGvvVe/+yS1qWRYhBm3yHU2//ekZdSvcHOg/m3R1EtTmOr3HzLC?=
 =?us-ascii?Q?UoiILw2EPAPPboTdQeDumMYYEngQKAoxR9mjV3Ksznnd1L+cwTKKg2g8HtkX?=
 =?us-ascii?Q?jWSFcFpSSvrX4wZQJwlUM+owZRXvdsiwwxfGlUdDwdPJDoz5VN4GyA2EsE40?=
 =?us-ascii?Q?4t5zgn0WBkFH9TEIAwT0BCUJLuqHvi//AA8WOLVAZLbeXrG+SyQexNUJS7VX?=
 =?us-ascii?Q?ZDzogobKpGQPojWNSdY9HgEKXP4eQ5D+DlFA5KoqrtLGqqSOaFKb1SLNLdp7?=
 =?us-ascii?Q?RSk7Bz+a1DyFqeACP8KH1p7TmxCE+kTGsLana/000RJTy+HzbjQBaB7xpCci?=
 =?us-ascii?Q?bIxT2fOdEiKVSs5G6sA2OlVh4GlpSnnZCrXbk1Exi27S96tFifOXeT4WD8Vw?=
 =?us-ascii?Q?yURHZWE56wLBdF2x7TKXZGfokT+HTutnmmZLJvOxWGw7AR1LTj6mMvZr7zYa?=
 =?us-ascii?Q?OaUo3GlCcE7s4D7I2noL/hFPG8mRW3Z80GynRBNgjK2wTjwButLQDgama0pP?=
 =?us-ascii?Q?SozegIlSailgStvyR8pPsypWGkOUIWC18PuVZgQXDyQUdlPIkbE2MRDbXjak?=
 =?us-ascii?Q?I4/XqmAh1nHIUd8frRKpHlYy+fKqI5/bkRfWIB3DZTFabp8PxEEOaDKFXa7O?=
 =?us-ascii?Q?A7Pera+bVe8FY9QahYetlmuGGXGgxsuTfVx868Cyp/LYbWXEC6gAvHoW7q8x?=
 =?us-ascii?Q?IiwjwLIdxxggEJFFpM/ZHBSlIBv+/Fg2BdekTqYY9AZ4T89+Sy7335dwZ8pT?=
 =?us-ascii?Q?9NQd/bJDzxfR1FAzQABURGv3rMIGjEfuuxEFw3IkXmyrlrEHd59uCU2YUHv/?=
 =?us-ascii?Q?EnHj561sQ0ulRktpa5WL/RI8Ys9BDbPJFdUTXdz5Uj4fhspbtiIgcJZxoaV2?=
 =?us-ascii?Q?L3U4UO0ktqQhuUhthLcNEMIAA+KsmUHYW7b8JlJj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057139bf-1752-4e30-e4ae-08ddeae32ddb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:12:40.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XETLgPYscColwwCzwhc8zpIrFJMuCGw315OYu9kSflBgtW/+A+uBjusHSd6a5m7hVsi5kUBtQCVqOvnzswXPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7318

While 'if (i <= 0) ... else if (i > 0) ...' is technically equivalent to
'if (i <= 0) ... else ...', the latter is vastly easier to read because
it avoids writing out a condition that is unnecessary. Let's drop such
unnecessary conditions.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index fae062a6431f..00de1166188a 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -123,7 +123,7 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
 						      soc_data->sram_max_volt);
 				return ret;
 			}
-		} else if (pre_vproc > new_vproc) {
+		} else {
 			vproc = max(new_vproc,
 				    pre_vsram - soc_data->max_volt_shift);
 			ret = regulator_set_voltage(proc_reg, vproc,
-- 
2.34.1


