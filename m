Return-Path: <linux-pm+bounces-39746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AACD384E
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2465301A1FB
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789C2FE566;
	Sat, 20 Dec 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MWRkV7HA"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8992FE067;
	Sat, 20 Dec 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270168; cv=fail; b=O8F/SvBUoSm3vlCOUE8PmZAhSgvaTtnhNLZuff2h520OKEaaDTxzQa5LYIKGkkSqrbyNqNoR+XdOmOAfE6/VCXKRbuFH/i00eo31H4jSidqCfmqb9kqkjHqMsz9qrJIJNyipuQa3Pu3/HHJtMzhkrYI6Y2Bl7cMF/8MZDL7M/d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270168; c=relaxed/simple;
	bh=mz/Vai5FEqNy+SiNArgYQY0J7wv6Kf8F70NxYIjmm1I=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=C1Dih11vbYoyF+C2i9aCcIfzTxBnOEe52bYTS6Y8nWVgRgLLhI7r0e/x3NZ3+W92Sd9HAq4qcqkS+ytM5QZtiHDR7Ghvycr/6lSBHTniMQ1mmMcYQHRfP/ySImTAmlkEPfKBn11lnQq+SQAbp0elod09rmKBSEvKTQuXkln/ANU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MWRkV7HA; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCqpcRlmyr4LtDDGBYwvl5KbMiuUhjU8dv78GlyQDhkfpBEl5iUizY7LafRXVILWRMHVAfxTg0xKq0mljK4P4XVOevuD2sdxw5/e9uiBTWtvf2n6rOWUxpMpr6uRpp8KndH6YlTkhwvBrakBF6c1mrlA9K/15aLjqOLsLHoJVmgykRjokfyHzxyvj0QeCQjkCLLH9Nr+MXi3lhVEVN77EyuYsvbt4nEEuSoxPkj/UUy8XnD2lcEa6a/amzWL96WUY0OqWNw+KUHJG28rHR9fSDxH06crYINS3wGR94qiLsj47gQ/PwcOpJe/DpouXxE3zpjw6LlMIehDbvmkEIvrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JTJaU0H8TuDwtJe6thYxcfY/qHGWdx3ptEgDyfBiK4=;
 b=LXuJ6bL9rKZSGBNLw05UYgfD53SQuXPoWCHhyBi2Apaz/j7ujvKU4AQ1HevVxCnUWn0tAkcNrfDwXaDXVSmEHM0M/SQd5M1icVyC5ADQ1pQqdvfGdEH+OmajYGpbHjwboa+b4y5dis9N69PcpaqN7eWfJ1FuGdaije4HOQtCmSgRcTOfOmxdvMBiLrlyzxM55Q7uaeMY4cPK6S2K19H/DSgvQulemArS2RvM50d2CfmsFk09cYuq1Hlup0lOUGLDjrXnoJZJlPVko848+zP/YzrdO7a+Gd9aBsji/sQjBPwCec1jAP/Sg17rQbUY/ne0ZZEr9gPypNHprJ+wXtmtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JTJaU0H8TuDwtJe6thYxcfY/qHGWdx3ptEgDyfBiK4=;
 b=MWRkV7HAsOx/+mWF4Prx8i6YviHWtf4AUIJdsnkOcm19lK/ou6S0+XsM4s71eKEa+vy2ja5kBDPH7MUmgaJ71RKEPbitveTKQo430BJpdRCLolbFbQBwTsdRseNiJLIlsT+s9y8GkH1YvXZXOZd2RXMR9SR0CmjZL65B1rNKFC0=
Received: from DU7P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::18)
 by PA1PR02MB11211.eurprd02.prod.outlook.com (2603:10a6:102:4f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 22:36:03 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::83) by DU7P194CA0012.outlook.office365.com
 (2603:10a6:10:553::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:03 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:00 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Dan Murphy <dmurphy@ti.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 04/11] power: supply: bq25980: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <8763035cadb959e14787b3837f2d3db61f6e1c34.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:35:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|PA1PR02MB11211:EE_
X-MS-Office365-Filtering-Correlation-Id: df24dfef-4902-49e5-d5d2-08de40182847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gDd5vB/p+BC07wwOJWA70sBSa0ZUwrVQ1nEtxY+gJXvIJ2sNO73z8PqY18tF?=
 =?us-ascii?Q?gjFmn8ReK5/wNqNPCELK6NmeWMh3R52uzpz4s92eyao/QSPwMcEpXNSaPBtc?=
 =?us-ascii?Q?z1eAPQXaRYJlCZVCkSrdsg2hTHOQ1rDRxTvzTEDbwbBoJltFaehSQXcvgije?=
 =?us-ascii?Q?pYUgRjbKQmOF2+06uZIapcBzb8ttkVoqexDLhLgsHJxj+m1460FlZaAPxbnA?=
 =?us-ascii?Q?mR87UPPB0Ymztt0uqHBR+Dl7gTSrBCepJXDDju8n45iKII8WGEbZh+bSmlt/?=
 =?us-ascii?Q?f1BfeVvXeKGgPOa/HpgIP16hXBv7TPVx046b8VwdZqQP0YSKOGgQraFmeshI?=
 =?us-ascii?Q?1b6Q7p2oEEd7H4EcE8Z7WjUpLNlgpG7/O27RbAKHF+QxexSeDG5HEWuhiury?=
 =?us-ascii?Q?Lq/FXu7MeCtLabKYxne6qnFJrl6j2xHxspnc9oudvkeutjx5ZH+zoB+lG0e9?=
 =?us-ascii?Q?RlHt7sP5jH8mzxHQFg/uBnQG0PbxMLJWj2M9q+DmHOUtzDP22G60ltGydefj?=
 =?us-ascii?Q?efhEAkIsyNYcTo6plvbOjLiVtUE+PvmlBNYUopIz3TChldEWvvZnmFmRiMvv?=
 =?us-ascii?Q?qxwe8CBOOkhBG/c71P6P7RyD4VxnJ+0wI1nicICCxdUDEwyooKBSpucWV3RS?=
 =?us-ascii?Q?rC9zg9DAPexhj2+pE3nuC2iNQipi6B5icpqGEztqJ1iLHw3q6Une7pzVzA5U?=
 =?us-ascii?Q?ZnITp0N3KqjaUB93N+pq43eIunNeEczFgiKjNHlYnvcx8fflUj56QvhTrAYd?=
 =?us-ascii?Q?1jANOuJso6uH/KwmLM03Ce2tY9wIUGDhBtsHyn5umy5lHNkj3C44MUccRpZG?=
 =?us-ascii?Q?3StlnvJpKYPGNQJ5BZombwjpKu7jjucvtiFR4dqVl6LIgE481sZpSkCtZHWY?=
 =?us-ascii?Q?VZ3oU5XdrEB5hK2GiK0emGfxOCqGM81cqPKOT/61xgZ5dCTvPPNqopEKriRg?=
 =?us-ascii?Q?g68G7kFRDDWHtP630Eu4mHJeuj0+6jT53eG1LtbifsCZQHJFTM1m5GbHG36M?=
 =?us-ascii?Q?U2EBOAozjsy+fnQlGEpyWBJiMr+1Cm5/b5FeNM28dLN5f3LwKpk2sRaNRnQZ?=
 =?us-ascii?Q?uUqHpBv+K8yc6a/+HK0Nra2KxsH2QqLEcDMhS8tQt0fZk+0NLNFZ1Cp/EALH?=
 =?us-ascii?Q?KFd8fZi2C15m7EWiJCbjH0kBAsMI+O1uV327qcXA6Wt6aVDQATglR4Gm0zLM?=
 =?us-ascii?Q?8j6FMt4VSkRaK2h2l1D02cbAKYCJGPyj0/9CyvAwrmbJBvCm/uNNB4TwAEfg?=
 =?us-ascii?Q?67mLqnuSryXgKAyNhK6LGBkc8xFXqwyQRuEIwGgH/uE6ElgljN/QygfH6oWN?=
 =?us-ascii?Q?e3WiFK/GqdNDsUClmtNRDXrv0ZiQt9xBR4ezv81Qg9r5mAiI13nft/dcsKIF?=
 =?us-ascii?Q?JrngeSh4F0UM1wEiAJSdJ01GotaX3neX5BNruvVdqhOz8OwL/tRhVKJStWPp?=
 =?us-ascii?Q?jVaNG8TYsdv9OOP5V392ofdHys2xmdxR/yfBawRyKNqYutvA/V3uGSWkGaG3?=
 =?us-ascii?Q?R0XUvV0D0AE0HnLOWbWl/4k9Ej/AUmpoM9e+KMylk+82OUmezWx6yjZ9dz1Y?=
 =?us-ascii?Q?AAioPYhHZmaOBupVXco=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:03.1853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df24dfef-4902-49e5-d5d2-08de40182847
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11211

Using the `devm_` variant for requesting IRQ _before_ the `devm_`
variant for allocating/registering the `power_supply` handle, means that
the `power_supply` handle will be deallocated/unregistered _before_ the
interrupt handler (since `devm_` naturally deallocates in reverse
allocation order). This means that during removal, there is a race
condition where an interrupt can fire just _after_ the `power_supply`
handle has been freed, *but* just _before_ the corresponding
unregistration of the IRQ handler has run.

This will lead to the IRQ handler calling `power_supply_changed()` with
a freed `power_supply` handle. Which usually crashes the system or
otherwise silently corrupts the memory...

Note that there is a similar situation which can also happen during
`probe()`; the possibility of an interrupt firing _before_ registering
the `power_supply` handle. This would then lead to the nasty situation
of using the `power_supply` handle *uninitialized* in
`power_supply_changed()`.

Fix this racy use-after-free by making sure the IRQ is requested _after_
the registration of the `power_supply` handle.

Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq25980_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 723858d62d141..73f06f09f134c 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1241,6 +1241,12 @@ static int bq25980_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = bq25980_power_supply_init(bq, dev);
+	if (ret) {
+		dev_err(dev, "Failed to register power supply\n");
+		return ret;
+	}
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						bq25980_irq_handler_thread,
@@ -1251,12 +1257,6 @@ static int bq25980_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = bq25980_power_supply_init(bq, dev);
-	if (ret) {
-		dev_err(dev, "Failed to register power supply\n");
-		return ret;
-	}
-
 	ret = bq25980_hw_init(bq);
 	if (ret) {
 		dev_err(dev, "Cannot initialize the chip.\n");
-- 
2.39.5


