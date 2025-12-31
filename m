Return-Path: <linux-pm+bounces-40086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3D3CEBB1C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 10:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59664300B884
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5B2046BA;
	Wed, 31 Dec 2025 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="Rw216ry3"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011011.outbound.protection.outlook.com [40.107.130.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F864274643;
	Wed, 31 Dec 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767173524; cv=fail; b=bFn5DL8GE95fG7NYLFUL9/WX5JiQ3FG2uxDhHT+yzsUGRb5Vo4o1gJJP+wa5jhcJD5HdXeoZd9NEVX8h099NHCG2yURUGU2iCZEWuGTyASSt9AtG91kNdUSpV0RB060ffXmWf6Zdo6Cy66X5ocHPn1jD6Zi1K+ZEpbvrwaRBYSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767173524; c=relaxed/simple;
	bh=HLfrIqNoj4CvZzGFbOgkBmpFN1siLzizJkjOUTD5g7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KB6W4wf85PawIuagTh4ejwAg16nX2CZxWsI0rAbpjin5+HsOjC+X8QygZKmojgTAp9bI8wtoTk1X3sZ61ZFmI2ek6x5qwJphNdVc7jDfGSlTytuI68lLAp94x80dBwDpd8lpGSN8LsBYDAV5p5Jr3pHS02IJ9xP15vWIBHe4m04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=Rw216ry3; arc=fail smtp.client-ip=40.107.130.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YekfCCWtv+TtF6+gkuCtrOnbGHz+fhT2Td/r3zDOikSGvBvI6m3PGCzcLrEJysIHDTdV0lX93X7TPjChH4qSs0c79VhLKTS/0Z15zH+cpbVIVdS/f9aG8lwbjcbBUZdnIL62tyekYhVclspuJIC4HR8a/T6LYtsL6+OXAimoYRlc8HHjzvy0M9VVI2MLG9EIN4pjaQl60N8ZXVy23NNw0GaAj+5Su46rusJcEDmMIwCQINFcaHgDaId6aTz9CXS3ORt51zQQJW/raRzUabMA2Be1kfBhqjl9cJCJKVfrj8Q1R9vUT6Nm5EHOQ1j7KQnCsgrrKOxr51+DBXSzzolJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWaQYwd76yKAqmkWKwupY2yiCITM1qYtM1IDZ8hxBaA=;
 b=fO1Nh4G1yAGgaq0UJANXCzy2wpzHf/KU/alAY6M2NBxvBRsSEV25syQ1LN/QCLQpUprsYRxi1IXjy8FknJB7Cii2+pjrk0F3d8oz+xkX4ykTsAWDRN3xlhzUL+XAUUBfOFHLo7Egd20YfbfMK3uoo75VywcJPwhi6J3sY6wV5IK6fnGS18xoTnw4MhtxgdEatlpuRPy4eMJl0d0tTUj1HmmQKdJEbQGM+5czby/5xjgbc7UjMWAuP3MQdPnj1hPYnDxnSbwz1BcXl/L79BYdP6qQla1tRPvkj68nxNCaZa8k7VqRaAvcREXX3qcltwYb3spjsG4BQjNZ7dmkD0gdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWaQYwd76yKAqmkWKwupY2yiCITM1qYtM1IDZ8hxBaA=;
 b=Rw216ry37SsXUcAPUJ9W5VMhZs5oz+33haLDxIiF6QI2ESMyuhpvneoniRAmnDl/p6P/ZsUW2nQZWFIqFZfnSBPzoou53qjcD8++nYmSbGQbFa7wNInBjXe0I9D4bKoFrGZjwdBXIA1+Me/YmqkEClyJYnBE4veww3IgMQbci0g=
Received: from DU2PR04CA0258.eurprd04.prod.outlook.com (2603:10a6:10:28e::23)
 by DB8PR06MB6554.eurprd06.prod.outlook.com (2603:10a6:10:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 09:31:58 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::1f) by DU2PR04CA0258.outlook.office365.com
 (2603:10a6:10:28e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 09:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Wed, 31 Dec 2025 09:31:57 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 31 Dec 2025 10:31:57 +0100
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: sre@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH 1/2] power: supply: sbs-battery: Reject all-zero readings as battery absent
Date: Wed, 31 Dec 2025 09:31:51 +0000
Message-ID: <20251231093152.2817579-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 Dec 2025 09:31:57.0634 (UTC) FILETIME=[4EFEA220:01DC7A38]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|DB8PR06MB6554:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b76a5da9-cf02-4d3d-ce9b-08de484f71b5
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MTKsZkgsG2jZGh3OHGYEmKvoeAJdX2CzjalNdfdLUg+Mie9K5gl6ByOjHbny?=
 =?us-ascii?Q?SqBmzEkIH87Wd+F3CNSMOzbopJArEaZHHGI+4iRwPv4k7yVNAssDsJhVmv5X?=
 =?us-ascii?Q?9dTQU4gyKU9q2yEPuSsefjPLnrcvmGEUKVG8vLnLSj2yo9CUUi3G4o1YsgGF?=
 =?us-ascii?Q?BUiGxP/bY89N++cAhIH7ral6vB6gi/KMHDIwBTT3EjP7eYVddHbyncG6KVG9?=
 =?us-ascii?Q?q/DfvBbU5wQQZc6fP87o05pmYfSi7i+PkedGmzQY5qKQErfc6DGk8KaNmOyj?=
 =?us-ascii?Q?9Y7j3SB/AMKULg20UZ/MddLM9kHDIbr6hv/ZT3C5yP+gLUfR33IclIobw9QO?=
 =?us-ascii?Q?rfB/JWC6gwbnsHIXopScyrs9NmDy+sdIeZ/2zKOZ6iTtDnf8BmNnzTsxeeO1?=
 =?us-ascii?Q?kf/bFh86Q0c70rxgDn9WHTsD+jA9wQhpTbP8tJOYLrJh8kCj3xR13mCbW4L2?=
 =?us-ascii?Q?0Ex5CoBEI+1PDfmbQ7I8t9S3t9MN5nV697iJHPNxvQCMa8WsnntTUVRyD525?=
 =?us-ascii?Q?CRSBy9sJCopSxHulAoB0xBsnSTlyQjeEZWX9Up/qQ3tOx0/5hSR1lUmGFgYN?=
 =?us-ascii?Q?A7ic7P7CLdRXC8DRO7SzHwoywrdgrDB9rV97keRfchXKB5x8ZN917Mln7/Cv?=
 =?us-ascii?Q?sLG3L+sHMEfVWXWEx7si5jM05DBsBzfeQ0ihrjiwOkhHEvK/hUx1AP8YDrDO?=
 =?us-ascii?Q?P6M31IolzDjBmDskLph3+8x+WUFONFV+0OEG5COIjhrKXF81vOU/tmHK/9bk?=
 =?us-ascii?Q?SegDaxGsR4U7dhoqHjW6IK86HC0nmT8c4MHkQxg8st9cBBqJpchxmH4dObko?=
 =?us-ascii?Q?iTaPVYrIRly2plp1prNBnlIbGPWTs7LVm7Nk/1wbhwcn5OuYJxtEkIM6P/sC?=
 =?us-ascii?Q?uUxbV/oVaT/bmV7yH9Y34jwHdzgYQaw2NMRDq6f+WLdxNIZSXYz5G+UyOLzJ?=
 =?us-ascii?Q?nNEsocW7ecNIYLlAU4ouUnIZTJJLjNhr2VdS6PV4bbzV3XBe1/mT6TgQcLD0?=
 =?us-ascii?Q?wQAS7jkIiKNa0h9mWhLmRuKPjBXq9NzJ3kjUVNABYLOFM0Hqg/CrZWxMpF+B?=
 =?us-ascii?Q?vpLNcak3pR0o/qtiU4TBoIp1WIF9kYxYlMh8DbXkMnqYRrYjwj1LIzZemNA3?=
 =?us-ascii?Q?V59Xp1S7WuT24wY79YlL1kFUEq9s+qR3f+5XHARS86Th+KYzSmrZNEUTGtje?=
 =?us-ascii?Q?9/LIKio0ezVP/sAYIr0BMluqKkdV8Rvn6iUa9nXZ+FVI0Am/OzyesZk3G5ba?=
 =?us-ascii?Q?NMNT9vsNBdm46bQv7OGH5eUa9t3/ekmI/BDSZLR9/5LI3yVf2wJseGr9hVug?=
 =?us-ascii?Q?ylQSWajd9/gU49WIYvPJomL3S3TOdtb0vMq4ryptFESC/5VpC9Pfi18TxycF?=
 =?us-ascii?Q?VD8HMMIntcccy2vWQpPleL17az8VTxQE9Q+eIDNx+vjzRrS7T1tWvxvRb66R?=
 =?us-ascii?Q?Hr/TtWyLuTgA620B+2S5RSemxfY6Hanq3lcvntMsvNHQuAw2j4VUtAQ1A6YP?=
 =?us-ascii?Q?P3/lepnxNdBnHpHmWZgbtyIX3fe//nQ9Eof5UNsDHy78BBYc0pV2Q8/ntCcj?=
 =?us-ascii?Q?wVrh2EOsZbL+0rs3epE=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 09:31:57.8977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76a5da9-cf02-4d3d-ce9b-08de484f71b5
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6554

The driver reports battery present when status register read succeeds,
without checking the actual register values. Some systems return all
zeros when no battery is connected, causing false presence detection.

Add validation: when status reads zero, cross-check voltage and capacity.
Report battery absent only if all three registers return zero.

Tested on i.MX 8M Plus platform with SBS-compliant battery.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/power/supply/sbs-battery.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 943c82ee978f..0b9ecfc1f3f7 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -594,9 +594,19 @@ static int sbs_get_battery_presence_and_health(
 		return ret;
 	}
 
-	if (psp == POWER_SUPPLY_PROP_PRESENT)
+	if (psp == POWER_SUPPLY_PROP_PRESENT) {
 		val->intval = 1; /* battery present */
-	else { /* POWER_SUPPLY_PROP_HEALTH */
+		if (ret == 0) {
+			int voltage, capacity;
+
+			voltage = sbs_read_word_data(
+				client, sbs_data[REG_VOLTAGE].addr);
+			capacity = sbs_read_word_data(
+				client, sbs_data[REG_CAPACITY].addr);
+			if (voltage == 0 && capacity == 0)
+				val->intval = 0;
+		}
+	} else { /* POWER_SUPPLY_PROP_HEALTH */
 		if (sbs_bat_needs_calibration(client)) {
 			val->intval = POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
 		} else {
-- 
2.43.0


