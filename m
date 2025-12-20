Return-Path: <linux-pm+bounces-39750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FCECD3863
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7050302B10F
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795A2FF143;
	Sat, 20 Dec 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dkt0hN65"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8622F9D83;
	Sat, 20 Dec 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270171; cv=fail; b=AkXcNl6l+nGKBfiz/Z97ps98yp67YM7Ga/6/rnnh3oHAxUivDkAKzcUyjszkZdpFwhEcP7STDPp7NOiMbsNfZPT3rBUT45X3blBwghLsL9QQrh+7FY1ZCXJevjY5jt8SuorwsRS9twAwRc+PGAqal6UtVwcIddczkZSKjL4pQvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270171; c=relaxed/simple;
	bh=GT0kkl2Rv2En0DYnXvk5lhBfUeK5lR7OULeFpgZByrQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Sihq0xJtGHhi2q+CAJ0WoTZOjOepcmFHXUmcc7hUW8FqgIw0mOTFjp0DIlmMRco91k1cv4W3R1Oz54KrE+hhVRiSa2CSuOAMf0vDy2EyYU76oJeXIjrm2Y8LwSHqj3eptzGxHHnq43OYYPtQqAqiBGV9yhCsu9RDM85staIu3l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dkt0hN65; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1K8EhzIOFeWGdSEQfcYwBUaulCUWizt8NoXNWY4hnBJL3zvROJ8jXajo5xbKWl300nBtWzFUxb441LXS7miEDXfVHNRlKRCsAHscbsAwcOHkA5MPRUMDBiyZRFAKCWbIjUBSLRZTnoQrlzoNsqliIqfQXEPhylPktKgbxWNMCoBk0NwaOSyEqI40fAUR+48LwAgphDDSzGixm7DJpW9Ltn9cKJq5U5yL9UmN5FxvYpMZqlZGdubp226OT4moJDccwboGO1kPTk5OHajF9/d3Y+UP+neKW3pQ5BgAwwz/DlpvGe/Mdjn2XWgLZYXioCCAfQYY9AEbdte34oagCRbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTvEtgIKI4saeJmZe4WQqc3gLG8/0jgpLp90NFrLFew=;
 b=ae0s/m/zLQ0Q8v+2cc5mq7YlJUQKJikuFAttFAjHN3ifnxGHVJdyxpunDdmMU8SezbNEP8IJGJE4HVfw2eP1nhQlxGGq+Qb1j2HrVbO309Mkn1iLtt5ewIP5ZLRceje231m366DNbVeSXwVT7qe7QxmPD6gnNOG5xZV+jM93oScu4zalfVz0goXBKEqX9r9OpGkNxScMhstCFK5lJuHgpTIcCGiAiD7+tA538iRixa5l7spNEx+mx9QDv0H2CVgo4JmKPyw+obVEmMKWEBSVbuVRsYM7zqeyVenwWctk/kBiMrHrGkK6uAhSC0w3Wp8WOxS3NEFz6UJlWHc2Pur0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTvEtgIKI4saeJmZe4WQqc3gLG8/0jgpLp90NFrLFew=;
 b=dkt0hN65Y3sc1ncPTMeGS95bZm2EUi7nUzXgTJokeOkFAbFTnv6P9meGwK6fDbj0rVk6jB35dPDsRbWh3jZlC59bhf+LWw/2T1+vAEenDFt9cqBDGqUnqkfPwTX763EiYGpijmyOrEoXIA5LGso5DIaaKyGi9AoJdfQZ7Ta0CLk=
Received: from DU7P194CA0013.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::29)
 by PAWPR02MB9904.eurprd02.prod.outlook.com (2603:10a6:102:2ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:05 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::6d) by DU7P194CA0013.outlook.office365.com
 (2603:10a6:10:553::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:05 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:00 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, "Mike A. Chan" <mikechan@google.com>,
	Alan Cox <alan@linux.intel.com>, Tom Keel <thomas.keel@intel.com>, "Yunhong
 Jiang" <yunhong.jiang@intel.com>, Sheng Yang <sheng@linux.intel.com>
CC: <kernel@axis.com>, Bruce Beare <bruce.j.beare@intel.com>, Anton Vorontsov
	<anton@enomsg.org>, Jun Nakajima <jun.nakajima@intel.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] power: supply: goldfish: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <500a606bb6fb6f2bb8d797e19a00cea9dd7b03c1.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:36:00 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|PAWPR02MB9904:EE_
X-MS-Office365-Filtering-Correlation-Id: bd459934-7888-4315-abb1-08de40182961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7ylEGsDSMq2+IEylpwnNxH+l6tEcBcks7e9ss4K90JO1rljs9eye/6bCWjV?=
 =?us-ascii?Q?MQiWAKydZNAd+pxVFh2el7iaXLOpjfXdhB8/nbjgKW7W8HOzboVSAPaICe8/?=
 =?us-ascii?Q?JhPCmRAtUFeDdy5NTstOKIblCjeFiaiRLe+JoDTy9N5J1TEIm+zFg8BeB7ek?=
 =?us-ascii?Q?M0miGxrV0H2hktA7BB7VN3MMjSpUQVW1xkFrTtu64iPtTEnolc2NDlVozh+p?=
 =?us-ascii?Q?I9gW48Z2cY+pOmUB19a9p9XQwoo2rXV68PQc+Zx9V9YeSc4xoOwRKuD8luOW?=
 =?us-ascii?Q?ous7Oh90GapdTD6WsOCm8U4kNznHembaL7TCu4KNUdwq621+ZN2wRFKxd/DF?=
 =?us-ascii?Q?nRdx3n8kOJcoWtr1vpQEeSlV/jQOSvHdeQBVF9qa5F1ObNBCBnOQ5iFX5atB?=
 =?us-ascii?Q?7e3KJNUksYhk19nrrGygKXjBJEtvB51SCYgq4Nh3pHz8qQRDB5+U3z6xw5Oc?=
 =?us-ascii?Q?l+eGgAy+0MzKXvcISOU26OsUKe9CJoFmVkvyI4z3EVTDQ3puiR6nStZ3gagj?=
 =?us-ascii?Q?pW9UR5Ez1Z1IrNy4IOTJriw8/Nltb7raDD0k4CTWnbWhHXUCzwUoCla2dhux?=
 =?us-ascii?Q?L1e7BvBekEZvu1mAKa/ZbNE4FH0x8hScrqe67G66sQ30/vYga2bmx8aBDz+5?=
 =?us-ascii?Q?BxdwRN19qtPKmeAnBgTv5Pea8c0ohAS7TYSKy2eX9k5ugacG9JPMWGLHsjX5?=
 =?us-ascii?Q?51hR2OoqpnwiGHgs4D/ThlP7XoZu0GkQ6yHI6xsQTahfyeVquj94q8hMRauq?=
 =?us-ascii?Q?2tNr7kDRbfZFS5h4lDJoBNq5FDlohN08x/vueLq0b84aibXZVk5VGm2I5IIZ?=
 =?us-ascii?Q?Z49k41+TcB11aYi5vUtyS9dHCWvvi5Ov+A3hn7DUIkhh2C3j75IteXaOIPj6?=
 =?us-ascii?Q?QFUgLhZriw/PmDI1K9kq3bq9F8tb2uq1sqHGQmb/3U4L/mUcRF8krlScEttO?=
 =?us-ascii?Q?w37nYz1Pqhfmy4PIYNsNoEgIugwfM1i30IUri05xvpgTjG22XsFEguKdIeSx?=
 =?us-ascii?Q?f1czzW2DhDc9ENZuExJ7Cq2sx8gK/+9nH0XBop4XVhdIESnIYgSExBMAOPag?=
 =?us-ascii?Q?DPpApP1umaNc8cznRsQQIuZmCZNt/HZlApIFoKjSKE4Z8AN8km0InuzVv36A?=
 =?us-ascii?Q?qaKfK2Clu0XLlHVSY0qQArT2HJdoOy9r55RJxfmedLaGZGdjdfHk/J7dIijU?=
 =?us-ascii?Q?IaGykXlaL6qNNQ0sHPqWRduWXJ3mFHAF6hREugNCJNuKyFEuOjkCEDS7Q2SU?=
 =?us-ascii?Q?9lk60E0mj73mRCjmndic3pmFJuxXyRrmLY0H0Il9QLJp8R9swbXtG2BuX6J7?=
 =?us-ascii?Q?j9RCbCnbHQN9P9BtvkoS4Me7hLU/Fg8Wkf5ObGfSpsU/JLI8ccg8Wv6+PWB+?=
 =?us-ascii?Q?kSN8+cXP4Ny0fbglyMdT/Jd82nLDV7mWfgKGZDfRAhPPM1Xq4VN2TT0ZyG5e?=
 =?us-ascii?Q?yYeYyWHZulqMD53RjdtLmb/hhw/eusOt9l/otwMSnZhHHEMTSsy4M1/xD/qF?=
 =?us-ascii?Q?cwiQ74uhwuHZQh58SkYXJsKoRnaPWI2Nj1JZ4HH/gc+Gh7sMkpxqicYKiAK4?=
 =?us-ascii?Q?89aUb/iDiiKS7TKUnO0=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:05.0324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd459934-7888-4315-abb1-08de40182961
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9904

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

Fixes: 84d7b7687489 ("power: Add battery driver for goldfish emulator")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/goldfish_battery.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index 479195e35d734..5aa24e4dc4455 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -224,12 +224,6 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return -ENODEV;
 
-	ret = devm_request_irq(&pdev->dev, data->irq,
-			       goldfish_battery_interrupt,
-			       IRQF_SHARED, pdev->name, data);
-	if (ret)
-		return ret;
-
 	psy_cfg.drv_data = data;
 
 	data->ac = devm_power_supply_register(&pdev->dev,
@@ -244,6 +238,12 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	if (IS_ERR(data->battery))
 		return PTR_ERR(data->battery);
 
+	ret = devm_request_irq(&pdev->dev, data->irq,
+			       goldfish_battery_interrupt,
+			       IRQF_SHARED, pdev->name, data);
+	if (ret)
+		return ret;
+
 	GOLDFISH_BATTERY_WRITE(data, BATTERY_INT_ENABLE, BATTERY_INT_MASK);
 	return 0;
 }
-- 
2.39.5


