Return-Path: <linux-pm+bounces-31953-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C68B1B12C
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 11:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF78117FC53
	for <lists+linux-pm@lfdr.de>; Tue,  5 Aug 2025 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24B271A9A;
	Tue,  5 Aug 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Mni/vm+/"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76D2701AE;
	Tue,  5 Aug 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386429; cv=fail; b=KYrTjDtMiIhTtx22MgP6EH5Z5m7cFrqxBZuGZB6nFNTVocADAeP1N+flph8+PGBFGzvB+UqJQV7I/ZG4AJIXYc08t0kGX6ml4ReCdtrvr0cJotGXjDOKyGfXkpBwGHL6fRLsJuWPktxv9fX0oelwsFKGm3TZY4qSuK4rtFNA1uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386429; c=relaxed/simple;
	bh=nmViPwf/Ukqau2PhacwjGLrAu/3GCAv4gNlL6e5DX9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PULJqnh2n2Ih7Hyq9ZEQ5DIRUsm7yBKk8KBWqyPLkv7dFALwYrtCwLWtulbtBZoq9yS0SmXNQtHuE0OtX8ttgXoI8TSUh88Pm7H62VcRmM9MuioEAFfh38Q26+yapHmdo5yWefSS4uI0Unjai7CHCGdbGQQEN1vq1pjZnq597Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Mni/vm+/; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4w9dJ/V8w4yi7hZX34op9d1LSjAQDuYGJupjxAkbqUxDkuWska2i32b1dY91iHXXKaqg52BDZ6qnfw8C+s9asPXvu0NTHMKY9CLYP3TdPnAj1CDumuDRsgJVWcXq5ByzLXHlkTRoDie0Y9TRLpmQlW6LuJmrd1wlwHzQ+tJ+dU9eK/Q/6pyJzzb2q3S0vH7vo/ehBah+Fc24xO90P8VV/v++D64zFC1qjb/kV7eWZ25ykdofTp6cK19eal9Wy0DNNhyMUoyJbfPAurhVhauJpimyA71ad20H56+qVOBpxfNkzOE3VASCv17XcQumje177IkBsPVdej8VZ8KAlhhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tToxMFVNblhhh6hgXTLQa/jqgprut6FzrRgInYmQjQ=;
 b=Ch/ujzZLL08VGGMu69zSd1UH84va9/8Q/YhaROUNqaNuQyuUrGwcyBtjys3GUoQwBWB7imCnR9+ljLwyF6jFiK7nboUHQ1/Q4nJNcS9gbaZDVza6z7UyLVQCQ+4wTXqhkRI96rRXQCNNpLybccITVwaOiuvIfbMxjYhQwMEaI3c4x3hAbU4Rh0va8xeA+1pA9F0VJ6Muh/aPk5Y/aibFLXAswZie9PLR9CZPg+wy0nTPM7eD/sdEM1517pMN15WERdGQxpvm932WJUf45R3RgV2Cwu5FuinwN6hfps+3ZsAZUdjTJCrIvuAl4WXu8JvXouvEbDkVAOdjWlfOLPm+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tToxMFVNblhhh6hgXTLQa/jqgprut6FzrRgInYmQjQ=;
 b=Mni/vm+/tLzxc72Bciia5jh2QgoDneoLUo5LwJXLwhk1x8LDTSWPz3RkSuhGSRRDtUNe9zSQt2pKvl+M7lkoAfxgfm6VaJJ/hshBx+XMn3sewHDoAl6pcR4iK3yHPpu+KSwGuEfVPGlJ/Fir1zRkjNikMuoqv7jrr8gfRLDfoIE=
Received: from CWLP123CA0022.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::34)
 by DB9PR02MB8000.eurprd02.prod.outlook.com (2603:10a6:10:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:33:44 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:401:56:cafe::e) by CWLP123CA0022.outlook.office365.com
 (2603:10a6:401:56::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 09:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:33:43 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 11:33:35 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] power: supply: Remove error prints for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 5 Aug 2025 11:33:35 +0200
Message-ID: <pndzfcekt8w.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|DB9PR02MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: ea776c04-0951-4ca2-6d0a-08ddd4032ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sA8qN07/WtcGsRTiTl9oMzMv6Ihl+sOX6wwtCXMinaP+O4ltcT4eCvEtCA1y?=
 =?us-ascii?Q?G3F8CStRnKXqYuXrWV0yqpOs2CYMXYevI0bqnPj0pBOztjFyjfTMZHWwj/31?=
 =?us-ascii?Q?3avHQoQiny9M4Nu67eUA6OUmu3GiRxRrTgTlqZGWiygkIz6jpqPtcwru26Jp?=
 =?us-ascii?Q?c4E4lgVhc/yGFTzop+sJlbEx2lw0963qgZBSgo0JZIojKavGiLdBZ0iPWmcx?=
 =?us-ascii?Q?w0u6h65oLdHbm3a9ZjcyeJseUSbiORWaMXQlNtSvgUhiceJMiBLYNsJcN838?=
 =?us-ascii?Q?C9SrU/ZY9YP3guRLD1OzVHuU1l4blTo+xVXHQ78QMP/46WnzPMTTylieHtzA?=
 =?us-ascii?Q?M4EOd357Ml+aSjI1mAHAn+sSPz25+uRQImzzkzQACt+OUSrM7wEdymR7GseY?=
 =?us-ascii?Q?LafWRTdABM0ZSl8DVcktTtMZ/eJaoMQ1ZOv8mKgYdSuLYsrT8yRNoOT8LZxj?=
 =?us-ascii?Q?HDodmD1AAx2ojnAx9BBLnfFrC1BiOAUKSVB+Xd6js1WFoszoDiwrWzbhPKBa?=
 =?us-ascii?Q?I3eQoXhmWcqJkhHANsPv4Kdb94Xmub1+MQ9UDDMHCL4m/eTMZ8R/5mmaTA50?=
 =?us-ascii?Q?Gt7B2+mbWUDhUk1761sALZqVI3tnZWr8WaTXHB6CQmtsfyb/ZIEdr6iOjZ+S?=
 =?us-ascii?Q?G7B3JbVBE1leO+Mb/kRoY/npoojvSRkqZ3iZ7U+64aPExB9z25igJewAOzI5?=
 =?us-ascii?Q?E31oWhsb9g0hunWPNMf56fbiVjTTgM6fWs0/cCmpXYwNgmroshGA3Ar7wavQ?=
 =?us-ascii?Q?iA2N5H7/kLi4ROo2Td/As+GZehuaQ8gtISMuSxw+nyU4FGC+odyHLCnYBiZM?=
 =?us-ascii?Q?A8FIEWQvU8RPqqOsdp5+NN24Gi1XiShXTKNrSBkoNNXU704Z05T+hvH/i5N2?=
 =?us-ascii?Q?iegWg2TDfjyOGeiGTJBGPchyzpkKQfgk0m5NRP8XACLi2K+Wx8fKn1AUV3xQ?=
 =?us-ascii?Q?8lqYzY+lGzvTE6qyAQu6F5N4K4JAOe4Tr4G0fxkDO145IT+eBlW72qftPIV/?=
 =?us-ascii?Q?COFEnUcd41c2HI6OBEkZ4RPedPvi9mUkrlUEIk0zqdUwloPhsiSU9jmTvhQL?=
 =?us-ascii?Q?E2U++LvCHb5QJdlXH6skipxwwMQturw6VHzNOTr2D4rAIfl4HOM9Kaovz175?=
 =?us-ascii?Q?S7VBZ3Y20tn49EpIorpfNWRFyzSEihoT9gt/xS3ZDv2yrT8V4cjXbUy0pPb5?=
 =?us-ascii?Q?qxyz2u4uycWtki+MYLiTNywDl+cmnvaoJT1i7np90hpdTU41VoqjUaJLES35?=
 =?us-ascii?Q?kMziNQLGj/In577e69Ob0nOJbuHiMMqKT5JZL933DdO1diIHG+8J7MRaASKm?=
 =?us-ascii?Q?aMMH/m9RKAZFsHinMjrjFuS3CJDTSEwO4OQS8s0J/SyWULui9POlhRjeub4U?=
 =?us-ascii?Q?kGzgy/QGK4wN+1Stivmm6oA7tsZSaDAX31ei8MdPoCSGpUAVjpc2Vw+gc02W?=
 =?us-ascii?Q?98T6q3biBO2ysU8qL2tActnwfHaZYuKnqooxut1ZZEBAkViq7pI4GQKfxrj7?=
 =?us-ascii?Q?QtMwmfMKu4QXcLOIiIyQa30kJZDYQ1IAbykZ?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:33:43.8309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea776c04-0951-4ca2-6d0a-08ddd4032ba5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8000

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 drivers/power/supply/mt6370-charger.c | 4 ++--
 drivers/power/supply/rt9467-charger.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index 98579998b300..29510af4e595 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -898,7 +898,7 @@ static int mt6370_chg_probe(struct platform_device *pdev)
 	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_attach_lock,
 				       &priv->attach_lock);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to init attach lock\n");
+		return ret;
 
 	priv->attach = MT6370_ATTACH_STAT_DETACH;
 
@@ -909,7 +909,7 @@ static int mt6370_chg_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_wq, priv->wq);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to init wq\n");
+		return ret;
 
 	ret = devm_work_autocancel(dev, &priv->bc12_work, mt6370_chg_bc12_work_func);
 	if (ret)
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index e9aba9ad393c..e2ff9c4609ef 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -1218,25 +1218,25 @@ static int rt9467_charger_probe(struct i2c_client *i2c)
 	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_adc_lock,
 				       &data->adc_lock);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to init ADC lock\n");
+		return ret;
 
 	mutex_init(&data->attach_lock);
 	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_attach_lock,
 				       &data->attach_lock);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to init attach lock\n");
+		return ret;
 
 	mutex_init(&data->ichg_ieoc_lock);
 	ret = devm_add_action_or_reset(dev, rt9467_chg_destroy_ichg_ieoc_lock,
 				       &data->ichg_ieoc_lock);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to init ICHG/IEOC lock\n");
+		return ret;
 
 	init_completion(&data->aicl_done);
 	ret = devm_add_action_or_reset(dev, rt9467_chg_complete_aicl_done,
 				       &data->aicl_done);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to init AICL done completion\n");
+		return ret;
 
 	ret = rt9467_do_charger_init(data);
 	if (ret)

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5


