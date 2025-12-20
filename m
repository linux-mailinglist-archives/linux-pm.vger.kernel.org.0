Return-Path: <linux-pm+bounces-39755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD95CD3872
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589FF301B2E1
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D3306480;
	Sat, 20 Dec 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hhSz9J5w"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70795302CD5;
	Sat, 20 Dec 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270179; cv=fail; b=PZljvs2vWAb1k8dMsMA6KcDb2UjoU6BVx8aDvaDTrFHCazEe7F6bGQ5gI5wcG5o5zSxOZ63x6bhiq+yAPodGOy+Vl4wgU4xOSQDLGw4WL8zVRQHgh3csPn/zESogv+J1Zt6U1hpm6uSQ0ByxzY/6jt/8N0DwGcU+6qrdybcHwtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270179; c=relaxed/simple;
	bh=Pt77Jxs1O+ts9BVpkv7Qg37UDVx9p84vulpEAXMIdWk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=P2C9TYce3cVDDhx8hBMwG40IFW3a9bgdQ9A3+a14uW/TMLvv5N8HnUY/rDTHykl2M7Ti6Tvqacx6/XjOJAf4VgSNsp6JP8IU0fkjo4C3EEDRaJtmF6TbHThs76P1vd7634N+/Sw89Kw91OY9MIZ9X8Mx/epeTOH6QfeBRQ8wYJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hhSz9J5w; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFLduYZf4wn9B8kVb0TSeyh1I/WoLOubawbSQnEtjQ9V3AZlPoTL/3OUnjIXzqsLfZr757rw+1g6c9r0wFgQiXVDZE9VzbuG2mBvq7v109OY1Hnx+e6Q/tfs1qYL0as3DgDTUoOAay8ca3M8eNP8hCWzFNbl9TemKtXV4XmurTm3ipgovEUQUV0IxptMYvCGhQHn2lbgYYrbyVoNEV7bVEN4ubowiIMImf0Evjg8wPHIhjYV0ZrqJM6CP56t9c8qEKN0kkBYi8xO0ebmnFh17SdO67akso0KA9FDYGNyJrHdGgHzvoTp8cdUmpaNTXHw6vhWT1WV3DT8FRUWqvLqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFbfp/NRro8dwa8pMSb4r7Vnhrs+YaQBSBddEa06iRQ=;
 b=wJc0uCEei5scGWbpIugo0SoKWeo+SeooZpwiW9T/oksO/qCrmwpbNIC+gWB/Mtp3x7QOD2l1o1i53q6FXHuohAdadqdV6T/b0ucV3H1hT7pG7VS2Rcq6GDDj5l9Zx5ltIWGXejIv2lXDx4X8Ir/OZjkfkMuHNIo7UfZ1GJZVSh+cn9GpX3ROX/TnZTWfRV8A6vFiNJXM+GpFow56Rxq4JY/EjlU579eAa1Sx1i9od6iuukY8JfbwTze9g+/ntUszSWsAGEUJci0aD6LebLno9ltMxOm6pLTmsbBZ00MB4yvRtyw9EMJIgEGbp4Z5dJcNNz7xq+qDZ+f7DTXFVqIljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFbfp/NRro8dwa8pMSb4r7Vnhrs+YaQBSBddEa06iRQ=;
 b=hhSz9J5wrSQEdjt22sGZhJNsRInsKML3HOBbZJgCzkptRujGokjjD6BAxRtmCkPA3hhXfn6cUK73Op0BK1hZGyHz8hPxFcv8iNMuyzddecnMWwEkSW9jfmPGZ4oxePzvqkZ12X5xfkGDMYng+qJH+L8n2eSxO0+W5CzchNOr3fg=
Received: from DUZPR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::17) by VI1PR02MB10265.eurprd02.prod.outlook.com
 (2603:10a6:800:1c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 22:36:10 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::a6) by DUZPR01CA0104.outlook.office365.com
 (2603:10a6:10:4bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:10 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:02 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Phil Reid <preid@electromag.com.au>
CC: <kernel@axis.com>, Sebastian Reichel <sre@kernel.org>, Phil Reid
	<preid@electromag.com.au>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] power: supply: sbs-battery: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <0ef896e002495e615157b482d18a437af19ddcd0.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:36:02 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|VI1PR02MB10265:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a14ca6e-9750-4d66-dffd-08de40182c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AaI7PIB4Y8UfHGCwdoB+Q/+vqLpgVL7kHBjTYFG5QXRFU5fMfsSViR2qPyEU?=
 =?us-ascii?Q?uOSG/e+V38yZzgMb/HWH3m5Qitw9dQpPQc9FqHaKtEn0WvC9PXN0/LchGoT2?=
 =?us-ascii?Q?M/RZjfn1cIvApD1snHsjRZnB9L0WmXaOXCIDL2EpFRnJU2OsquqjUAbiEg9/?=
 =?us-ascii?Q?VfJnIiE0LQenFRXhlERye46CzDQ16KhbQ9qBUbsld82DgEncp/asiEpoLspY?=
 =?us-ascii?Q?PB7DmZWj4Y5/ITCfNmu5UU1R2SAdkNhk++hAm7B8KmEpNRwN626pEvwSeaq4?=
 =?us-ascii?Q?dV/Frqz0Qt0whRSo6ft4aKkh3jbX9zS/fy9mVFW94MITrw02fxMEa3arljqk?=
 =?us-ascii?Q?5rg9YX+O6atsZKE4/UgUMpRHkDRcPq1s2fZZnSQbleKKcPSfPRzTWCXY5UEs?=
 =?us-ascii?Q?8ifgXKC3ohIA+1apA849yd8fIP86WhB+JE5KaUwPAnnW16NJaCG1RMAiUE3h?=
 =?us-ascii?Q?z2ceNAC+DScyzZbGGOaY0A3gLsMXKN4e8Ho706Hv5jJUaBUNlxKxkxIClzvl?=
 =?us-ascii?Q?qA1bQV7uLwUY/4gEQ5Yy/zoK4J/KTS/ZWoGFtsEXvW47b/PxyNH7xbUSup12?=
 =?us-ascii?Q?UHsPbAn2jxpPzYmRkFkQSV5pm+3KYPJLULgcEHO0ooXnINhRpMYBDaIAyR4L?=
 =?us-ascii?Q?HlU6IRdRQfMNJ6AiMMpHg8FxL0BHjlo8XTRzY9jsN1xtVg7h/OEx3c+/2PW+?=
 =?us-ascii?Q?rkYNp8gdfnCtuFAdvB1fANH0nipdIX2RJwM81DvJN+MutbEnEf0eUV2FrQWC?=
 =?us-ascii?Q?FJThc1FF7BunnlKAphyPT6CzFii6Oyezy+lCRzKUOi+E4WfRcY/IW6T22dqD?=
 =?us-ascii?Q?LO4Fz+gn5TT2bgSyILmGyRRDPewuXPSGeee1ALttZ07m9e2QnxlWp5W1BDi1?=
 =?us-ascii?Q?RAu0vwi319raoetETbol2c28eQil3BejypeyA4zRXvqJA6rjbuLsTsCauFVJ?=
 =?us-ascii?Q?r748T6dSs8/TKPFxSxFCfPz7h0VSwg3Bq4zki1kQbxe6E56ODna3XFxOyCMp?=
 =?us-ascii?Q?EXKUnyd4ofWSq3FV7PujYzQ20CI44y607i/I6KIfHmCf64SSnxwBCg4guSiT?=
 =?us-ascii?Q?7LItu0hxaTwqrRfMZU83m2WLqzMkOLn/1pLTvOOr1W9EMxyDPSoQqHBH+6HK?=
 =?us-ascii?Q?GqLtzqdIQoyoEfA8qvekA6OiNtoewPhMFfRGFiRi+/epnj9W1n87uKn0IAri?=
 =?us-ascii?Q?w9joQrTg4HWRXKWcR7CWHUG+COfwFAMNsm5AMv96Iw3L+/t+lVX9YD6SqHjx?=
 =?us-ascii?Q?FN9I63CLMJGZuhO0+vyDPxcBJQpbq5kvlMfUn+7LG/I0obGM74DDwFI/gIUW?=
 =?us-ascii?Q?bI+cn/0p4igSOyuSHkLWRr4nA0LQQFbc3+KJQeQd6DsAIxPwY169IQ45THAC?=
 =?us-ascii?Q?6cIUdWZkpHp/y6j0JrRH+IVbw8oKYCL1yBMl/n1/wuJWtdkSRhjb/PRbBAOB?=
 =?us-ascii?Q?mRfdaCWXf7TjTrjQiprdCazarGXMKznB1cwZfBcZ954yMLdt4ObG0m8sVtVW?=
 =?us-ascii?Q?p+mCgWRAe+wKjsRIz1NOdtM0UXdah9HsALM0HTYKMRs0SunRRTjLCndSyBWY?=
 =?us-ascii?Q?E7Fjx+NgspYQiKbLGrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:10.1011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a14ca6e-9750-4d66-dffd-08de40182c66
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10265

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
the registration of the `power_supply` handle. Keep the old behavior of
just printing a warning in case of any failures during the IRQ request
and finishing the probe successfully.

Fixes: d2cec82c2880 ("power: sbs-battery: Request threaded irq and fix dev callback cookie")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/sbs-battery.c | 36 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 943c82ee978f4..43c48196c1674 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1174,24 +1174,6 @@ static int sbs_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, chip);
 
-	if (!chip->gpio_detect)
-		goto skip_gpio;
-
-	irq = gpiod_to_irq(chip->gpio_detect);
-	if (irq <= 0) {
-		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
-		goto skip_gpio;
-	}
-
-	rc = devm_request_threaded_irq(&client->dev, irq, NULL, sbs_irq,
-		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-		dev_name(&client->dev), chip);
-	if (rc) {
-		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
-		goto skip_gpio;
-	}
-
-skip_gpio:
 	/*
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
@@ -1217,6 +1199,24 @@ static int sbs_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
 				     "Failed to register power supply\n");
 
+	if (!chip->gpio_detect)
+		goto out;
+
+	irq = gpiod_to_irq(chip->gpio_detect);
+	if (irq <= 0) {
+		dev_warn(&client->dev, "Failed to get gpio as irq: %d\n", irq);
+		goto out;
+	}
+
+	rc = devm_request_threaded_irq(&client->dev, irq, NULL, sbs_irq,
+		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+		dev_name(&client->dev), chip);
+	if (rc) {
+		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
+		goto out;
+	}
+
+out:
 	dev_info(&client->dev,
 		"%s: battery gas gauge device registered\n", client->name);
 
-- 
2.39.5


