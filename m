Return-Path: <linux-pm+bounces-39747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C25B4CD3854
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A1F5301EF82
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF32FE595;
	Sat, 20 Dec 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="dzviu8nI"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011352FDC37;
	Sat, 20 Dec 2025 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270168; cv=fail; b=oWfFjEF3KjvMjSst/J6/A1DmjdQbArfVPtnRT4rhRj4ELl9CS7hzKcbxTRV8N0olKUzNicXj6JL5Tz49q0BStHCoEAZ8v4I0feRm79hpcU2S4/L0uIqY/03C6VO+LzQ3gavh10lNPOhLBP5w+2O3ajqI2kS3pO6RMjMxSdCP/ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270168; c=relaxed/simple;
	bh=cnCkPJfykOaRuduk5+gyuuxyCClq8q1zVkBlQSfEP+I=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=A6eJgGfmrwS77VQtN5Wzz8WorHR/8U4OHYA17R3X6HNqVzMpvJbLj7mte5MIulTqnllpgbJ6mSor6ZEkP/XdPZMly6VPIQ3ZHb4rhW7O+8MbJcnLJO70oF3G8pMwaXAqEUmDV8A8HqRxZRY8EONlHKrAG9lU4dQX62ATAiEUpcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=dzviu8nI; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVfgNKJ3H9Qvn9+PEPyMV6AJ9s1AlFQ7Ta0HrirfnxFkMdzi4z10bd43oitxkjB5uNX0rRqljllFSbCGfOdwdRg6S3XbWIqVaZow6JfrrWclpRg8QsvxYth8/GqPhcyIXLphHAUPAqXLPBn/mvZ6rRbOXE3C4YvC/WtPAmQyv+fb1CxQyzQhZlZrY5xAwxTdNeac+4IlXdieLRO2Vc5sFZQHYrQJk+WPZhDycW5rNMWg8QffWag47nNzDwh0JZfc8kMSr/uPbgIBvUGp6Xbw89Xo9S4XcDCULD+eNl3qNMb4s7Y3sPscn+TpEyBFdRLErtmt6MSt+4G3CJn2e/VkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2brA5j7kV2Fxmhqr8RZLIErYkCxb5SgEws6JhjkVFU=;
 b=mECkJHquJupd2nN8jKAsWnkKeHh6x2nPIZf7POaMGcwpTW1pTGj9O3WtcDVTlN/fqwPLTJeT/yzMQqP0QH04B6tQO/YGN+/GgmssQoxFeYiyaVHC2BTimCQBrpbCas+fp292BnfLjQLWX98y8mlKQho+tWwS328xFsZxW9b4XMbbS3GPKYwL0TgaBY7/0yTVjtJZwVcm404jpgPrBejs2nKghyY3ebqVflQBTW4PEeDhNK8KtDSM2c/J24xF0k8GnMhPn7vMYLZpLXNvQUq/tryLrl3IREYDCO6EKNhUllbLXbho+umES4nqcyPDBhR856ESXwsv4LRr4+gbZYwzoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2brA5j7kV2Fxmhqr8RZLIErYkCxb5SgEws6JhjkVFU=;
 b=dzviu8nImNv0sUOcKXwWDVtL9HAcThEmuCafUW3K2lphn6x11M6IvF+8KEkFezPO1yP1e9KFGTyQnhcbV2ZddLd59+onAkPjvyw3AEXqcqAjWmh2z6vTJgXwC2D7AKYVxacvF1BGdLvIGUS8cjjwdIyNbrM2ZBmpgJaVoQwq/+I=
Received: from DU7P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::23)
 by GV1PR02MB10661.eurprd02.prod.outlook.com (2603:10a6:150:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:00 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::a5) by DU7P194CA0026.outlook.office365.com
 (2603:10a6:10:553::23) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:35:59 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:35:59 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Linus Walleij <linusw@kernel.org>, Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] power: supply: ab8500: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <ccf83a09942cb8dda3dff70b2682f2c2e9cb97f2.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:35:58 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|GV1PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: fd108ab0-e5c6-449e-cdc7-08de4018264f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5roHjz/20fZLONogYzqfVLYRxg1jmoE8RDP+WvAeW5IN/Rsl6UcqZkLJ+qP?=
 =?us-ascii?Q?oIQTFYLC78FH9W77HrmRvHJA/ZXorpAlHFC/YWuUzYvC+ufVCVo0L8yIavWQ?=
 =?us-ascii?Q?Weq7UrHS8QlQWxAQfXkpc+xX3N4mqATFdTrid+pouEiYPryVL3Bqiql/C5sQ?=
 =?us-ascii?Q?+xi3I8He2whqy9Y6g7q/DvcQyRy0gTM8ewbeognpYixTyE7Ea86kS5x3CNIT?=
 =?us-ascii?Q?vZezqv3xVLMT3w9um0cjBXaX2sNDHpUvSjrg5PkdsXLbV43TOhf4w7pV4SgA?=
 =?us-ascii?Q?OVikyQfd8AkmBEmfrjQu10KAqYDEo/dhWGV1zBA+9r3UWUqY1xm6/fOK3A9x?=
 =?us-ascii?Q?JvxH4YUD9wNbIQ37LxjJ5z+oMsetXXZl2MiCP+Hq3TDXCwWH9zlptE0rJa5m?=
 =?us-ascii?Q?rmPmZp7N4G6UxjVoNNdV7R+bb3TO8z/xkLjGsNoekYb6Rh4B1N6zNde19l4z?=
 =?us-ascii?Q?KXRGEtoVIDe07m6lJUCPhbnRvi5fS/34HYQb4yws25j8y7psXf9D3a3mF4GD?=
 =?us-ascii?Q?F5tS5bVws6QA3c75qVzgnoM0PzfCWuSk/QxQvUFgBZoJ1YzXXpfce7P4HgCw?=
 =?us-ascii?Q?qSD1y4VZbM+3/nNsJ2IB56F69ibk3tS9l06AMb3MzAWwIIUs2tWMcr3eiX4h?=
 =?us-ascii?Q?E7MevireCIrOoeEP1CGyXM+N9q49oqsZkeL6G+ZLU67OohOEbkOd6c2QHkHK?=
 =?us-ascii?Q?CYio1KXiNZBWHEOAk9OBqM8j02Kg+GW7YXEZjUc0mKWv6uhMs9XkWYq45TiD?=
 =?us-ascii?Q?1OOH8XRIEx2cRddhQHfR/IPLSmyJOzPJ+5h0lmQKx93J5M9JhNX6whWh4LPl?=
 =?us-ascii?Q?YZqC4e66wYUqzewuZdrOB/tTcKalVxKmuMu8AFdlu7EGK9rtU1V4kYCAoM1E?=
 =?us-ascii?Q?alBtd2thj9WvlJLv04UaC1NcjXjAzoY6Yvdvr7pjtSPBWvkGR7JauitLUtng?=
 =?us-ascii?Q?ki70Cs7AjmTWGUPQTW1txx6+jRrJ0Y8RRhXui87TW0rt+EhstJBeRRPdjw0R?=
 =?us-ascii?Q?29s2d5xCE2XvFgVb18NObSxWltejqZgAl9va76XmtPcYPhi9XFple5zoVCT/?=
 =?us-ascii?Q?B4spVVGm3qHY7SFf217l6qbFbgpzzwzdSpIm6Vm1yweoxums3sBPWh6pskXN?=
 =?us-ascii?Q?mOSuWa+idyjglRoO/Sfr14FwwcSeL95wHkYsN7fhPI7ShNOWz9sq/8LMAREM?=
 =?us-ascii?Q?UJ7KYEiWxZsJ+B+ZQH2HjiAe1xJ8tZxlE0+JEcoCg7Obh4oUujGOQ5z63eT/?=
 =?us-ascii?Q?ZQQ84n6HT/UOgwAv9VMvj5lRheD/VkG339oRyDRW0WdoUPS3d8UGf85iULcT?=
 =?us-ascii?Q?armhgzOoGNJcKLoNORrTYo71ZUf09GZipYOLRcR+22ehII5v3YQQBWg7vDC6?=
 =?us-ascii?Q?Hp3iAcG4SyhnURcaWXWid7acPF97ApvU3VOGst7NNg8ZQHfncOoXAGgE6ITO?=
 =?us-ascii?Q?K5V4mgVybRNw8tXB9gTkAti3Ae1sjF4UixqgUij9j1Pq63peG4SQin19CPc9?=
 =?us-ascii?Q?4BENwbKR3pK+oS+NEdA3sBf7ARH2wvrJg9tdDGi6crF4iEOOA87nu0+AUzix?=
 =?us-ascii?Q?4lScxq+G4VTDSn+r5ds=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:35:59.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd108ab0-e5c6-449e-cdc7-08de4018264f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10661

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

Commit 1c1f13a006ed ("power: supply: ab8500: Move to componentized
binding") introduced this issue during a refactorization. Fix this racy
use-after-free by making sure the IRQ is requested _after_ the
registration of the `power_supply` handle.

Fixes: 1c1f13a006ed ("power: supply: ab8500: Move to componentized binding")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/ab8500_charger.c | 40 +++++++++++++--------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 5f4537766e5b9..1813fbdfa1c1f 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3466,26 +3466,6 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Request interrupts */
-	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
-		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
-		if (irq < 0)
-			return irq;
-
-		ret = devm_request_threaded_irq(dev,
-			irq, NULL, ab8500_charger_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
-			ab8500_charger_irq[i].name, di);
-
-		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n"
-				, ab8500_charger_irq[i].name, irq, ret);
-			return ret;
-		}
-		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
-			ab8500_charger_irq[i].name, irq, ret);
-	}
-
 	/* initialize lock */
 	spin_lock_init(&di->usb_state.usb_lock);
 	mutex_init(&di->usb_ipt_crnt_lock);
@@ -3614,6 +3594,26 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(di->usb_chg.psy);
 	}
 
+	/* Request interrupts */
+	for (i = 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
+		irq = platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
+		if (irq < 0)
+			return irq;
+
+		ret = devm_request_threaded_irq(dev,
+			irq, NULL, ab8500_charger_irq[i].isr,
+			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
+			ab8500_charger_irq[i].name, di);
+
+		if (ret != 0) {
+			dev_err(dev, "failed to request %s IRQ %d: %d\n"
+				, ab8500_charger_irq[i].name, irq, ret);
+			return ret;
+		}
+		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
+			ab8500_charger_irq[i].name, irq, ret);
+	}
+
 	/*
 	 * Check what battery we have, since we always have the USB
 	 * psy, use that as a handle.
-- 
2.39.5


