Return-Path: <linux-pm+bounces-39745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2FCD3848
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C3130194E1
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1382FDC40;
	Sat, 20 Dec 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RwS4jmPM"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6F2FE063;
	Sat, 20 Dec 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270168; cv=fail; b=X9H9WZ3BAcsTxamwrdUnJ03R9eEy8+v66kbPtTY1aoQkIyokM0dLbD16XvuLWllRhYCjTUe93Mg78PFUnyZH2EDcpw036/sc66oIQEWnbshDExOlRu51yrNZz2SGglbWNbQJA4jAmqUVJIWLY7p98com/6fj4Rjg0M+8+PyMsko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270168; c=relaxed/simple;
	bh=fz0FiGJ+OZcnB3ZUZEkSKUn7gkznZzeO+LuNHULEIGE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=eS2jqaCiqo9SKah8e8NFu1AAdBcRKth5HMVYmiNCtgyVHh28MgcZAyYN9CRqrakuyOStxc+40kIREacSl2VRzRzY/ZItmy+SWRrLtZv5wWvzStmGxnWHNa9CDLyQyQ1+8tuoxPIoAIigZctDS4f89FslO3/J4OvRcnt11OKbmOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RwS4jmPM; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+qSij0eOHGbWQMITRb8sCl2aHzHGUlZos+uPm1Qs7BCngffRJDqxWNKtouh+/L7OLOaqPHLzBOp3f+zuvPBFaL9eHahy70YJvoTZOjyGrObB8WF+8UzC7q7hKkyjBoaPXNTARaku5I0x5U7GZQmk6l5YbyYfCTI0tojQ/cmWMqw/ODPslIGBwwXGpIKeDtLFaSd5jy0DCiFHaerQRA18n1CfH4kXAWSJzLe0PBkYBQevYRrH9OIcERKe08l4uCenm/PG5ic+xEi1XKfLScdGhDCS1Kfo0U3w+wbRagHZt0lUd+Q5EAxo6aGyUKa9PWEHhQmCMYbIzPrQ72gfKOR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW7NvjH9Daoqc+NGrZtZUjc9SpXSE1plNgvTCkm8Otg=;
 b=O9pX4I0kKb+cIpkUwnSZhJptzEx7vklIxIgrejfQ1+BU+HuYBlXnblKFNiUHLMOiDeQeTScKWIKXXhUWJdE4skRhsGeUTEodl3J5prH6EjtxGffFz9COuBaYRvmmep0GxHfkNqTWGC41g2eFccVX770gNvnLJIhhNL0xTtaOMUg8ZCKhMMrA5Vn/TE8U4IzrJE8y//AiOgg+V1pc8JtZAFlWoig3qDpZIV9hRpqvnkYzMyxNSAZAYkc6mqdAXPhrT7YV2abq5D9kx1Ga4vffCXILu1SifLTmoj/1wUj+ALXuL6b6eKV+Th5SNWzbN7+sCGbw+jAJCDtpUmx/+Xk1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW7NvjH9Daoqc+NGrZtZUjc9SpXSE1plNgvTCkm8Otg=;
 b=RwS4jmPM3LF+FTusoQt7bS/y45pgzLq2g+ZclmmYP6TLzq1s7UZFrVdsVMi1Iy5YlvGm5J9dMvC0jNpaMc59qO4jm2a3kqZap3F8LuQFy+q3sgMimeziQrvLhvXO2kO2uu8ZhXferPjKh7Wa9dWeVg/ow7sz0zZGA5JF0AYxrvQ=
Received: from DU7P194CA0001.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::16)
 by AS4PR02MB8576.eurprd02.prod.outlook.com (2603:10a6:20b:58b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:01 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::98) by DU7P194CA0001.outlook.office365.com
 (2603:10a6:10:553::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:01 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:35:59 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Wenyou Yang <wenyou.yang@atmel.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 02/11] power: supply: act8945a: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <bcf3a23b5187df0bba54a8c8fe09f8b8a0031dee.1766268280.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AS4PR02MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c68d75f-a781-44c9-d1ed-08de40182711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3L+/8M8uPwTWPU603H5B2MGFaNFGn1xO3SQGRFvkU1VWux0/8QfcZbGBYfeX?=
 =?us-ascii?Q?8na+2dACea/an02+2Beeog3W1EuRw9rBzJhLC6wArjivES13bnPF4XfDmOgG?=
 =?us-ascii?Q?cnp7FBWJ5kN/ryqccu+gXlCl6fHYuJijfmMib4TbgXDki4duFov660fFYFK3?=
 =?us-ascii?Q?SW4d1k3Xel/k/YZgs7YMHSmKe26kmZV7ZJ6m5ieh/OxtHfWt0qNkrqGwGmau?=
 =?us-ascii?Q?e0J6kFQ4S1Pb44cc/kWOLoZ6ryOW25TVOuiduX6mMi/P8eOlbSFT+Hjw9PAc?=
 =?us-ascii?Q?vDoSoaoswxfMAONEDIPxJPjY+Lp9x3txvJd8kfj4ylQrTiCEb3vHqjouHFLd?=
 =?us-ascii?Q?yezZWMie3ubYq82sFWo6PwuOxIOs82X9BbkCoAj6HLPx0b8avfXq5+wXXQpd?=
 =?us-ascii?Q?QFk8mHU6MHfhQBS28tkIBIre0i7QbWjwmFJUrz3xQnRpE/LzoaN+kOwCU0uZ?=
 =?us-ascii?Q?Tm9E27zAOIvNC7PQ+x2Ta0ur+4X52EwF3TMUEOfziZeNZvd7+77xrfUM36DD?=
 =?us-ascii?Q?2LhkL5QxqJ8uTZeKlsscGL2ttXZg977EfayYHlJWlU5bRqV9Oa4xteiF3wMX?=
 =?us-ascii?Q?aLMF3ZxCYqhla2QgB0OzoTBVJK2Au/jCkdufPUCJCAuOVUxryoBojx2MLG4I?=
 =?us-ascii?Q?EJ67p/+4MNL9rE+nq2mWXH3cmicRsm82kLo5KDuoX45lbvkl4l+VF0MDsqFD?=
 =?us-ascii?Q?tFtOCJUNqwGjBPbP42HfwVaGkZxra8LaL/1ZiEOb1c+Ve/wgB+nNt8QA3iHi?=
 =?us-ascii?Q?ds7IRj3eKpXfyHV1SI34LFU2sieYRUQrVCn1jmEbLlQH4gSoxuWuYiPARWTM?=
 =?us-ascii?Q?TpzG0w7aAdUk6z3hnbCzegKUD6BjJdlMyR+ZqhUjr1joeujcoW4sjGJL/xsS?=
 =?us-ascii?Q?2JDVVTYeJWwYCENmowBWihSed9Hhfed/M+KfmNe51oMMqZ89GtV/3M1TJsbK?=
 =?us-ascii?Q?fos6vIK/sAs331xxp5SwO6rmztmPLgLphN1G4a4bSKtJbH7V4LZePbrgcA7E?=
 =?us-ascii?Q?b2ADHevYkvBE9WVj1gJTbnG1WAABWMgYzjWsn3nlxQIRfpy1ikVG/gzvvqQX?=
 =?us-ascii?Q?5eSTRIgOY+GMVoRqewLN0lFylLIB52abh9t/ScTdU/9dngft4VHfPN1lB1wP?=
 =?us-ascii?Q?RMBinCXGlQaqtUGVr/1eT2Syp5KOzsbaDpbo3vdCPJIpW4vV9dK240OBC64Q?=
 =?us-ascii?Q?A242pn9uScnB3QX5g27IETEOMFE8aZb85CRId9wFWO1zFPmWdA6VtsWDgNvX?=
 =?us-ascii?Q?ZN86mP7E5k2QYkXXeEybpLMQ5gop9pHbOoTIfEnBEOlhJGV1hTfPcMOYPF/H?=
 =?us-ascii?Q?PX3GYGUTKGaSbVX55ga0kWmwDEety4eUbX6k47P2/AD1fQROMumJKpiuRFr4?=
 =?us-ascii?Q?cyEK8A6K5ZYW4nkYAbEbdsN+Z26F2GylGFJuaNxaPy/x/E/bdlj1YDMu93nD?=
 =?us-ascii?Q?DIV1cZYF2cn6zBWMOJ3sIyntkj+OeiPXQwk0kpy+zmffrILJpfbmPS5+o28B?=
 =?us-ascii?Q?zhEbLkUru6ZyG3/egTk+E48g/U+9kBb4tfqHfg1qDtCv80M7fY09LZktWmzq?=
 =?us-ascii?Q?5aqcHrcaIunmXcF2D/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:01.1536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c68d75f-a781-44c9-d1ed-08de40182711
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8576

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

Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status change update support")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/act8945a_charger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index 3901a02f326a5..9dec4486b1439 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -597,14 +597,6 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 		return irq ?: -ENXIO;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, act8945a_status_changed,
-			       IRQF_TRIGGER_FALLING, "act8945a_interrupt",
-			       charger);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request nIRQ pin IRQ\n");
-		return ret;
-	}
-
 	charger->desc.name = "act8945a-charger";
 	charger->desc.get_property = act8945a_charger_get_property;
 	charger->desc.properties = act8945a_charger_props;
@@ -625,6 +617,14 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->psy);
 	}
 
+	ret = devm_request_irq(&pdev->dev, irq, act8945a_status_changed,
+			       IRQF_TRIGGER_FALLING, "act8945a_interrupt",
+			       charger);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request nIRQ pin IRQ\n");
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, charger);
 
 	INIT_WORK(&charger->work, act8945a_work);
-- 
2.39.5


