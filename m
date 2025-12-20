Return-Path: <linux-pm+bounces-39758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87783CD3893
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1138730184C5
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730D2FC881;
	Sat, 20 Dec 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="e8Nd5jFT"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203C2F90DB;
	Sat, 20 Dec 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270794; cv=fail; b=qwLNBQlNzviyblXxUiTgDrvO4fnXfb26ar2ARbmPqGBkuqiDkiJx/uaeKMs67ksVToU53K4c3mMS9Hld9ZTJ33Xv9WYM1qZLUhI6majoDl0C3+/hlbWd1Vq5DL43Sn2TDBRmZJu+na2xZJu/RNCPS6NSgd1PIMNujN5c9wFbwJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270794; c=relaxed/simple;
	bh=+D5uVDKyg3+LZZZ9XjonfzWqYdd06GvPS64al6NWBF4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=WX9ISLBwyuZwjzQMSRwEGoBusl6FTE2mDy5/T160viIwooUN8yljSj0RVZkHpKcNAgqifIm0I19V0gK/fq9hVfrb88rEP02oqDEfBs6ie55D7ZrgP6zM9TeazWJKaOMuD9yj8uylXSRpwbUWZopkjm5G1FI8jrPySB0nmqsR+Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=e8Nd5jFT; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWHvLCi4J64ybwIgGRkL5mBaS3bJpmj48jot4GoFONsRvbNQFBVW//SGYT3xpKpl+2tvPAmTe8fTSy6tpxc3bXljFTRZT6iXFIclEcKaXm3djX54sr3c96LE3nJETD2kq/zgubahL4xpiSBtHXiT9rsCXJMAcaiWps+3Cn6s1MKh/xuXh0X1Rve3JHYuIMohuZOCAqkEg23u9ethoOQJ3QT0xRhU9S8Yw0FSzLOjzqtnf8hMWX/NfS2OzEiuxWg575l+JrU0ak4Udp/6PZ0RjAMhfiQnN3+KdBlGmpdxm8yj4LpxUTbrsB3YH9KVXAyVUtfNT5MAOCWUptvQOZnQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JgNPkojs4XaiY+MPoFDHDAj2eNoxy9+dNFnPO9z3NM=;
 b=Hj9wksqvdpQmb1XBq8a+FXKJcjANNsV4Zsu6qUuUwsZPR70LGpJkZmxcfMkMZo6Y2A1BLIEacL03Aqq1nC5ZbWbPbqy9gMa+VHehyq1J9k3RSic7M9KbsS/j1grhkD7XQ6rS3fAK7pFP1OITHmWUbTiaKVBMFgAIw1hIUIsyOb/dWgXsNbPMERJNjazGgIMZD+htSVJfBr9wCkwibuIj2SUF4BJ6ugzk9PGnlJTgRqkAQYVs69qob//rPF4robAL5AcpfUYfJ0JCixUVdoqUkZGzfY3gSZUMAflRO99US3gOC72BquofnCmF95Yl5KvHhTeeI+AJ3x0JRhSxnNY4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JgNPkojs4XaiY+MPoFDHDAj2eNoxy9+dNFnPO9z3NM=;
 b=e8Nd5jFTvez/iOw9ITK1FBUFYjMqkmr89cVyYwYI7EgXq9M9G2tbrF6t1W/uDpe1uVDTHmwFR6c2Ogb/G9k79bHOVTtu9i/IHIK1IWEbRrUlPEtTXxMNlAPSJ//vZzLEbUplzM2kZFioE5ImH7UuvMsDRCaQdufUSaD3g5+f8SE=
Received: from CWLP265CA0406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::9)
 by GV1PR02MB10663.eurprd02.prod.outlook.com (2603:10a6:150:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:46:27 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:400:1b6:cafe::38) by CWLP265CA0406.outlook.office365.com
 (2603:10a6:400:1b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Sat,
 20 Dec 2025 22:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:46:26 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:46:24 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Anton Vorontsov
	<avorontsov@ru.mvista.com>, Marek Vasut <marek.vasut@gmail.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] power: supply: wm97xx: Fix NULL pointer dereference in
 power_supply_changed()
In-Reply-To: <cover.1766270196.git.waqar.hameed@axis.com>
References: <cover.1766270196.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <97b55f0479a932eea7213844bf66f28a974e27a2.1766270196.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:46:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|GV1PR02MB10663:EE_
X-MS-Office365-Filtering-Correlation-Id: 69eeee14-16ac-4032-92e7-08de40199bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G0SEpwym5l78tJf9+ULQcC3fOt3vb4FTYtE33vJ9u+tm/6JCBEtpct9HB+To?=
 =?us-ascii?Q?n4GNwJxVvFqqS50eRoGmwNBneNWueADkvKclR7ZyVwlL9RCxc3a8HyI6v1HH?=
 =?us-ascii?Q?CESF5s/O3JEv5P50JgeOb8YP7ehyqyBRFi9HCEg4Hfdcb+RE64LQ9Y1tJ8my?=
 =?us-ascii?Q?kFaNaQju5IAOfNwp9OL4ZUHLgcotY1WIEnucrFIn2Ex3S2mfgWhsdfUfwPkV?=
 =?us-ascii?Q?KR44lWlnr8X6xwqd7r0I8OvUUchKvY3HEE9FSfKnpQbRHio82UYJOxElEm+2?=
 =?us-ascii?Q?lX1LT0NZV4vwM3ek1Ydokg9PpZ2JQsCbaBVvT5wIF5w2rrT0f81Nk9ROHLwJ?=
 =?us-ascii?Q?J8onNZDjHJY5mu4ndesh4jNFcE9CfeaGmSI8l3yQyyBdWwSYAu3eLkLJeM15?=
 =?us-ascii?Q?16cXgeMz0IB+Tb2kJyImICc7rtNohenoKX8IrxdzsWQAGbivYlajd9MqJWZ8?=
 =?us-ascii?Q?cltsoj8FpLFxo7AEXp8EbEopBOaWiQeT/huiuDgO8dzzbUXrzQgClyXmi/OL?=
 =?us-ascii?Q?fNh5NFhmjLnDH+mpkl3hzzZ8lcOjgunqXYYv943ZIojIIcAm9JEiwK2+lkQA?=
 =?us-ascii?Q?Kdx5MVScGH+N2Tc9Dbu95Ly/5wIEyc5I8psbX1F6wUZ71G84g0rOM3hYU30x?=
 =?us-ascii?Q?ms1ByiWhoCR7J9k6TtARj82ZIpA89/xN6V01OXVj3aS0fV9u3LHp+2tTERDi?=
 =?us-ascii?Q?RYf1z98m3BjaxWTp2Th2cyn1JzfH58KTEBtdb8L1pevKNMwKqIlZgZiH2Moi?=
 =?us-ascii?Q?WlgWM+Hb6Kf1LyEfFJ/BslzUs5dgK7CAJycZ8iiGBedOpqfJPZ+LmrujdoOo?=
 =?us-ascii?Q?G3cj5Cz7QBFTRfegCwy9ZZCdBP4ylwFidA69UO1U9vAgKdpvq3B/LhRmzBnF?=
 =?us-ascii?Q?48+5iKzFR67wRzPdy0XG+zTi10UYF+EReeuyznMOsdv4ZPXdRwYaZhbSwxHU?=
 =?us-ascii?Q?KGUS/4gqFXq/qMyxVlQbG9hjqurBp7CunmjwvhLhX5cG5OV0RcMoVgtW3Pfi?=
 =?us-ascii?Q?8L3bb8M0+cTXLJRhUbxtVZllDRySLIaYYccyiAU6hGi6iom6+uXpQGbg7fOG?=
 =?us-ascii?Q?YES1P7TRrLnA4Hlhh3pMm6cf+11M85Xhyf/UgcUEBxI3VSyI9wABVL1Qe4oU?=
 =?us-ascii?Q?Ifkrudnl9oeqG5CV4QjdF8jCXtrxPE5/K2UUoRQ4St+XnMbNQ3FD4AhCND1x?=
 =?us-ascii?Q?pWrBYdoMy3ydCZHCzLrsViHdNsQUbjxpAPV04vuLHmOj+Js0ROr2zzceWzM4?=
 =?us-ascii?Q?5lNCNTmoQgEX7yN1Iuc+ixlSNnezcjPJY7IAvLmMKXuElvRY6xi5tYm+Q0Vm?=
 =?us-ascii?Q?RcWk1R8MZ90AjOtcn3KQNBqH/xLtgoJC+SRcM/8dPTFBmurtME695RdYVhP9?=
 =?us-ascii?Q?wMiciGX7TTG3gc7jOYIrDeFfou0j7tFEnnoLWmDRbKwIWnPu2nSw9RsQM2OW?=
 =?us-ascii?Q?BYVNNTzMrpswwKDmfMdkQNYq0walaiRnnERwu874e+efyXMkz4Trp5/5ruQS?=
 =?us-ascii?Q?gCHK0RbTJayHlQYGQehDH15F/Shq2aHz3guOudlmVFo4M9I587Z6DSzdC1fG?=
 =?us-ascii?Q?NYeCBTbBoikvp6MxTm0=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:46:26.7477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eeee14-16ac-4032-92e7-08de40199bf2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10663

In `probe()`, `request_irq()` is called before allocating/registering a
`power_supply` handle. If an interrupt is fired between the call to
`request_irq()` and `power_supply_register()`, the `power_supply` handle
will be used uninitialized in `power_supply_changed()` in
`wm97xx_bat_update()` (triggered from the interrupt handler). This will
lead to a `NULL` pointer dereference since

Fix this racy `NULL` pointer dereference by making sure the IRQ is
requested _after_ the registration of the `power_supply` handle. Since
the IRQ is the last thing requests in the `probe()` now, remove the
error path for freeing it. Instead add one for unregistering the
`power_supply` handle when IRQ request fails.

Fixes: 7c87942aef52 ("wm97xx_battery: Use irq to detect charger state")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/wm97xx_battery.c | 34 +++++++++++++++------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index b3b0c37a9dd2d..f00722c88c6fe 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -178,12 +178,6 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 				     "failed to get charge GPIO\n");
 	if (charge_gpiod) {
 		gpiod_set_consumer_name(charge_gpiod, "BATT CHRG");
-		ret = request_irq(gpiod_to_irq(charge_gpiod),
-				wm97xx_chrg_irq, 0,
-				"AC Detect", dev);
-		if (ret)
-			return dev_err_probe(&dev->dev, ret,
-					     "failed to request GPIO irq\n");
 		props++;	/* POWER_SUPPLY_PROP_STATUS */
 	}
 
@@ -199,10 +193,8 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 		props++;	/* POWER_SUPPLY_PROP_VOLTAGE_MIN */
 
 	prop = kcalloc(props, sizeof(*prop), GFP_KERNEL);
-	if (!prop) {
-		ret = -ENOMEM;
-		goto err3;
-	}
+	if (!prop)
+		return -ENOMEM;
 
 	prop[i++] = POWER_SUPPLY_PROP_PRESENT;
 	if (charge_gpiod)
@@ -236,15 +228,27 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 		schedule_work(&bat_work);
 	} else {
 		ret = PTR_ERR(bat_psy);
-		goto err4;
+		goto free;
+	}
+
+	if (charge_gpiod) {
+		ret = request_irq(gpiod_to_irq(charge_gpiod), wm97xx_chrg_irq,
+				  0, "AC Detect", dev);
+		if (ret) {
+			dev_err_probe(&dev->dev, ret,
+				      "failed to request GPIO irq\n");
+			goto unregister;
+		}
 	}
 
 	return 0;
-err4:
+
+unregister:
+	power_supply_unregister(bat_psy);
+
+free:
 	kfree(prop);
-err3:
-	if (charge_gpiod)
-		free_irq(gpiod_to_irq(charge_gpiod), dev);
+
 	return ret;
 }
 
-- 
2.39.5


