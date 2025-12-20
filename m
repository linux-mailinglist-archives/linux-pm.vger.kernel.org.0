Return-Path: <linux-pm+bounces-39759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D5CD3899
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65296302049D
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753FB2FE577;
	Sat, 20 Dec 2025 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="CUrVnVSP"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626D242D83;
	Sat, 20 Dec 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270795; cv=fail; b=LtrCImEcc3vBeSViz5ACDrVkm0C2KZjr/DY3jpQOQ+7m7IHNuelc0AtGIJqt9Fzm0J7deR8qx3hquoWUTsLA4c7047gQr9ERXK1tmsN5hY1RDMl4V0kUpyMrLMrhC0xeyApHM/2ehGI4Jg18bwNcZdt68MZjwl0r9xnWd4MGOac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270795; c=relaxed/simple;
	bh=O5R0pcxJQWdR0JEZQ6CJNmZq46O1Uejtp1O2rsmxkdU=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=lbdDp+s+PjVJqp3lseq/tlbIDv9E48FAS99X8GeUz9a4ZfFFaJmKbW+oEL2fLDcj6Jpn7/c0jnxdduneWzFHDq8cUmzlMejb6xuQXDoU3JtII6b9zKyBjBPkg+WRr75Z666UTEbD+sHZ841G7GgQDL+EwffcHUolFfAGRYFKc1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=CUrVnVSP; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj9SqFgcDQmRe7Nc2gIKE9diDY651mJ8PeIZKp87VtDYty8hY5VojSCNm5geWNh05laTDg1Kr45vq3GsoPA/hGycIe1DdIwqgQmkacp4WQ7Dt2ELwYq+HuA+pNXT6Mkr4C02DqZYDQlRtbFFwsgkKwq9Spu4oPzuJitzW0BemlX6DR+kWHMfTGuj29YqfaEF2QEi75A7QR+bTn5lEO9lb9n5WD0OLghA1/WZD+BF9w2zaoH5YriFDjwYsNus8JXhyHdJDWOtwRb6ugJulvmZUy21v4G4O7wpCCVQTTC8Rhaj8Qn2Dsz+GM4QJ7eC2uA0FpR/NAdskDWkb5qbV0yO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTqQORzIvekHwnGbQdHZVI+EJPJ4q6S/rIv+yCJ43gA=;
 b=hcYifOG18bGaxTgVm3V/YaporNWAi2GD2lKkD7oTc/jXgSYmCOd4LxseIqNLRyafKuT8Rp+JbbRmXkpfVrHekDv81riCqzIjCk4ZC1cEtCTDSE6ygn9rcw0uXnVFGih4vR6JLUvJPNyqXIkwOFmrmwgpKV/4ZSGVFSdoYDxlIOs6iq1/kpePVjDsLn7UubZpmuynh56Vf7ztrfJmPNuQ2ilfjkoFgMagTJXfMX4/wBaIXtFQ/5PV+jRONZYnXB5IXnqWoj+io44XYF529bmIoQimRrniIjFIsOsN2uvZIz+L/dW86bXZ0wfAFIgguFPhH8KEZpQscYgVx44ROJJ73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTqQORzIvekHwnGbQdHZVI+EJPJ4q6S/rIv+yCJ43gA=;
 b=CUrVnVSPACZ1Vj/MbHdt6LVCQMqW0Mj7/zFR4HTPXmFlXjFbcESlw1fkfE8o0LS+3Qsde79gzuFP2zXhwsNdnWISajjwNB7H4L07eTLjj9eXuEvE7SFAsAtw2kCTUWDNmNsOFm2g6U0U4qvpZiqCCKqE2VdKWWaIt/YIHLFFyxM=
Received: from CWLP265CA0415.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::10)
 by AMDPR02MB11197.eurprd02.prod.outlook.com (2603:10a6:20b:6cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:46:29 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:400:1b6:cafe::cf) by CWLP265CA0415.outlook.office365.com
 (2603:10a6:400:1b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:46:28 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:46:25 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] power: supply: wm97xx: Use devm_kcalloc()
In-Reply-To: <cover.1766270196.git.waqar.hameed@axis.com>
References: <cover.1766270196.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <c6379b2fc6a766221664d26d4a29a3960c1c1c1e.1766270196.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:46:25 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|AMDPR02MB11197:EE_
X-MS-Office365-Filtering-Correlation-Id: 78315d30-c9f6-43d4-6d4f-08de40199d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bRyz2fgvzI+HtUTig9EBlARrx0J3wPFrdDPHBY+Fh47IpOopx41JyyzXdAEO?=
 =?us-ascii?Q?WKZhQGV5BA+cJ3ySfwzIcxl+21ifEoqi5rlsFevgHInOK8C2eHf1yK1QhlJA?=
 =?us-ascii?Q?CoKug83zzda0jvU0HYX8xGb8gzW10C0Jw4sMxTMaevy6IFIwrPpUrBOPMVUp?=
 =?us-ascii?Q?z5tlJVLifWUL+0bHXGGaHkq7qrAZHxXDDhrpQeATWw+SwyZdYPwwIZ82ILnA?=
 =?us-ascii?Q?hjwDhT3xmd7laaP11SvgXJbg61eXnX8S8Xnds43/RlpLTG/yW8w9uld2qpJG?=
 =?us-ascii?Q?8Yq2C7uWK92GY2GT2wtCFOvo309Dy7WjfV1U355L3UHmnLy0Hzrx6mt/YTo+?=
 =?us-ascii?Q?Eamwyahc2GYcMtw5M2sN/tkPoXd0MBUXJt7rM04wowm19yA1ko2ci84PQnwU?=
 =?us-ascii?Q?blnEdJebeo0uZ36D3tF+1YLzaVvZF/SoOPHcKABmovb1hu7ndxBIN/iFPcK2?=
 =?us-ascii?Q?/h+T985OrRL4F4KbmT+LoA8NmFkgIvfhKdivgZltMFoCm1X7+T6d/M5qF2RP?=
 =?us-ascii?Q?3lB0VkO/uENd9GNR2bc2+6ro29OxoZTGOQDiMq+hJCtzZo+p2bkilvhFp7zv?=
 =?us-ascii?Q?BxpG9S6I07TjeYs9NU8hrjiK8kMXk0Nn7qNc4pRGowehvW2N4Pva3dI0jKiY?=
 =?us-ascii?Q?7FvKWxjh5GgWF4GmkMu0CGRqXs+/XtI247hky5JN4T0Wn93+eEfMOuwqkXqm?=
 =?us-ascii?Q?ItG/6pQ1LPjsax7bTRAujex796IWx50WedOGy5shPL1i6RYgdvM6nfuwUu0Y?=
 =?us-ascii?Q?dRzRZCFK630Z2kqdeCTVmB9kEM//lQRZcgOe7VWTNpp/PbZnFB4aCujeTJwM?=
 =?us-ascii?Q?zoUCGtQTv+G0KKrnRNWCsayDFG7EK5mjkYlEQmu7CBOGL7IsvLx3cXQIcpEu?=
 =?us-ascii?Q?J9sWDpD51/LVDqxH/gXeX0GWZUR95bgPMjpaWdouxP9vi1dwX2pck4nkGzkd?=
 =?us-ascii?Q?yqIDsWRaoS9+C/WDvjV0PB4qBBpt3Choqwf0a07B/enr0OiZ4KBjDbr4IcZk?=
 =?us-ascii?Q?7rxLUJfo6liqD0A+ft1oc5RHhf8FUmJJbRs++7LAhhE8ETYRwf72yCdmDcmd?=
 =?us-ascii?Q?xYtvE3PB1UPXQB559K9JieoIkq9GU406BGWVywSqiXTuiMSko2FQwyOa+y+G?=
 =?us-ascii?Q?bL9HBcwKfHqnRYR9up9N2zk0idCkG92NRsD7aUD67UfntQZseo+3fDs7cSUv?=
 =?us-ascii?Q?kfnNFMsovoffvGomAW+vIwtyDTW4kFPRJl65iRyddI6laXqbeLEFyJfbc/h2?=
 =?us-ascii?Q?ozjGMEET6uozDrXwLaN2S0JZLuLRhMlOrEBIfaKNQozGO/FnN+LtriOYxZEO?=
 =?us-ascii?Q?8KWT8cFx1EUg7gRojRBqbtLMHp6Eb3i/eBwKapvKGVCPJl5GGtQPyXCXvqum?=
 =?us-ascii?Q?XPT7qiEbeSgjtXsg62EP93giRQyWyhdGhZHNmOM7ou1pFO0CF9GBVXUnG6Jf?=
 =?us-ascii?Q?CVNORenn0RJs86QNsbePbYFyKfUQ8i5UAe9J8wL2h4ItrA+CfqOILdqNupLu?=
 =?us-ascii?Q?MYQERNAElKyrIrnB1Ora6U/Hwr1EMwxte6NS1HHDlNznBE6yDdx/7LymimPN?=
 =?us-ascii?Q?hZLTDaeuSv1teoRj2es=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:46:28.8956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78315d30-c9f6-43d4-6d4f-08de40199d3a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR02MB11197

Instead of handling the memory allocation manually, use the automatic
`devres` variant `devm_kcalloc()`. This is less error prone and
eliminates the `goto`-path.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/wm97xx_battery.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index e91467dcab19c..a6c55b1e02863 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -192,7 +192,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	if (pdata->min_voltage >= 0)
 		props++;	/* POWER_SUPPLY_PROP_VOLTAGE_MIN */
 
-	prop = kcalloc(props, sizeof(*prop), GFP_KERNEL);
+	prop = devm_kcalloc(&dev->dev, props, sizeof(*prop), GFP_KERNEL);
 	if (!prop)
 		return -ENOMEM;
 
@@ -224,29 +224,20 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	bat_psy_desc.num_properties = props;
 
 	bat_psy = devm_power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
-	if (!IS_ERR(bat_psy)) {
-		schedule_work(&bat_work);
-	} else {
-		ret = PTR_ERR(bat_psy);
-		goto free;
-	}
+	if (IS_ERR(bat_psy))
+		return PTR_ERR(bat_psy);
+
+	schedule_work(&bat_work);
 
 	if (charge_gpiod) {
 		ret = request_irq(gpiod_to_irq(charge_gpiod), wm97xx_chrg_irq,
 				  0, "AC Detect", dev);
-		if (ret) {
-			dev_err_probe(&dev->dev, ret,
-				      "failed to request GPIO irq\n");
-			goto free;
-		}
+		if (ret)
+			return dev_err_probe(&dev->dev, ret,
+					     "failed to request GPIO irq\n");
 	}
 
 	return 0;
-
-free:
-	kfree(prop);
-
-	return ret;
 }
 
 static void wm97xx_bat_remove(struct platform_device *dev)
@@ -254,7 +245,6 @@ static void wm97xx_bat_remove(struct platform_device *dev)
 	if (charge_gpiod)
 		free_irq(gpiod_to_irq(charge_gpiod), dev);
 	cancel_work_sync(&bat_work);
-	kfree(prop);
 }
 
 static struct platform_driver wm97xx_bat_driver = {
-- 
2.39.5


