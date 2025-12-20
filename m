Return-Path: <linux-pm+bounces-39751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D2CD384B
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70258300386C
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B93009E4;
	Sat, 20 Dec 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="G0OwIC9c"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1542FDC52;
	Sat, 20 Dec 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270172; cv=fail; b=HiC0G+C8sdL3s5FwsJryYgLfRqZ49FPLuJLMZILyW1eZF0q7CbyufQcHT4Tl+RZRZh2RAHYyA3NVbWwNYAxpeXBG7ZvUncODfT4Aduqo54TfqunLxPWGU1cLGniChyo8vQY1RuGrYLFEUx9/NbPZMD5ZRR0bAIRWNfk7E4A7MeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270172; c=relaxed/simple;
	bh=isMg+jyBfjD6keBTuSxBaDzHKtzqQrEWUA29U62WUsM=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=fAicqhOI6dqv0FjpunSjXZjlHuRu/vJg3cOcK26q/Wl3JBxfTO1ayUJKA6wKzPUMBeJj75d10Ll+lomad31j9X2yuT8zwV7sXmSKUakTVwXS+tDPgunvLGb25lZezsBKLdJn2kvtJTiCLWGH3GtL87+N1faWyuOR1LrjxiB54W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=G0OwIC9c; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUG23iwU89wJWKE2BNwKccp7t3pUJ9a0+Y3pMlvvFS7YQ7gh20/ApQzNQok7xNmlYy83KbFBBBhXDH2+Z5J9RYW9lVkQp9ejTgXgTuDiAPbNxd9x05rTqbCx8OsXgV0ToSNV9FNKN/ayp9IdkkoiGySM/ipo3JbryABzDam9oNoKaSXWs3ZHpeM2Iqh56wUMN/yPr9g0lNvaSXnhkqEkgIZN+U4XpvYZvVz6pC8MAee+2slL4IVWEbJa+RWiOEh876SjRZXmikddVu+/xrw0sBw/tCjzl9KXiN/6UZ+Nz8EcAhNDUWiGCoQZpofJcm14KvU/z2aZzKTwJ0zsSC5TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcD6Lobb4vxzCnhh086hQoR1Lf9dMaS24w3glWIvXrA=;
 b=PdKwcT5WOGgMz4Zm0ikgDnmtCPVr5YZOoAmN7isLWUA71c7WSE1eZ9qVnuShkdHAXjWw3l+P7dCB/U0podiJwpEZ1l5fhBp8jNLU2kQgXzt1n4i7vJGudQoeIWUC4cuzN5odV2eIP5w5PU9yTvhUgA6BcGigSE9VrqgSnjOKLdkxUSvCkaHli/gGfkEBNw90YVCDbfT2+nweMcRZLHoS3p6cLaarTjzlcdDmH+AZ9msR0474acd8N9LdbbZjbqv/J4CaCQ9emWJYTPyE6CRD8EX3VRp4YFQxhBPV+k5UveVfpmlIGVGsqGpK93uIDAyxHQkmDh12BwFFgAADQbT3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcD6Lobb4vxzCnhh086hQoR1Lf9dMaS24w3glWIvXrA=;
 b=G0OwIC9c3pyjr156KEJDeDK+o97kALADOHKNTze5+CL7fAJfRuhQ4IMJKBqfUvFm8Fbp4Uyx3Y3Zi8OB51UXcxJxc+3n6xkbIrWgtiQnel/a8IHLlmXQlXm1quDDTsQb1dyv4tHIoqmlxgXrpyZbhEVPcv2UuduxeLcx0Fe7jcM=
Received: from DU7P194CA0022.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::26)
 by PR3PR02MB6220.eurprd02.prod.outlook.com (2603:10a6:102:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:06 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::9) by DU7P194CA0022.outlook.office365.com
 (2603:10a6:10:553::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:06 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:01 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Samuel Kayode <samkay014@gmail.com>, Sebastian Reichel <sre@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>
CC: <kernel@axis.com>, <imx@lists.linux.dev>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] power: supply: pf1550: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <ae5a71b7e4dd2967d8fdcc531065cc71b17c86f5.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:36:01 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|PR3PR02MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a8b81e-453d-44e0-47f3-08de401829fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rh/1nv0Po1b7uhMEwJQh5Ks8fZF2CfFtsCFmlp1Dw93WWBwBHjvXRPBIQztz?=
 =?us-ascii?Q?g1+tmmu/SVl1emt78CfO/tH9d0etpI6X9oaTX84EsFOtcdGvUGwK1ezTH/WF?=
 =?us-ascii?Q?/u0cmk55Af78FjEqBrY472cuQjYpxCDBPNGGlNGU2bBeuc6gaW2mEVLrSzSE?=
 =?us-ascii?Q?/kYuu9ELjVMRINwI8oIWHKRqDD0Px8UMI8kkykqjC2OPPF+x2LVuz/LPgRDu?=
 =?us-ascii?Q?2qcjcHnXkPUGL5BW5QmeY4q4mPf2B2fRzWjdeBQ2Yl70EZeI6a0EUqtwIANv?=
 =?us-ascii?Q?bw4l8g2FGZJz6B5PsLvZZbxI1RNPCWfiHwoI3ZU3FS7/lWm+qIyFb4gw44Ju?=
 =?us-ascii?Q?mV4GsJ0QVsDgjTQU7O6rWqmw9WnnMFR6sQZSVBdp6BIZI7oNutF72LOz6Jzk?=
 =?us-ascii?Q?sXogH6u8UIPCIx+hi+Q8T+TBHhar4+IytBXr7shvQQa3RKa/C/rg0SItO6l8?=
 =?us-ascii?Q?bvIyTh+JkpY5XD4nw6hYW76FRF/O4CwSrSf0f70MTqO6G/OuWTde48etTD1W?=
 =?us-ascii?Q?yYyFCCaM2oFFXPHUfupT3UZORzRaelwlmkDjn5HSrTScI1TCOejMe865dkTZ?=
 =?us-ascii?Q?1X0NpjzvK8zcOlDLv+ae0as3u5Xhp1hxvt4KyDc3+fmI69VoqMB86fXaOJY5?=
 =?us-ascii?Q?kUJ+p1NHmT4jQw5+j5ohEoezJOqXsCslsRbCr3GblgkYpza5+01M6Adfpgb8?=
 =?us-ascii?Q?oc8JHU6CM8UCxAhm2z7cgeru+7jJD2uV/af0qCqNvOAKP+4DdROByKzohFw3?=
 =?us-ascii?Q?YQ4fQFMwVvkkkrCWWHIfm0DkSNSTRGaCLyi0E9vElN3g+4zCaztCIqklh4qc?=
 =?us-ascii?Q?Z0m8M8WOtUBaYVsyNOrndAd/+HVev/BQgDo3+yV+pjilg3j6KMybrBzQRBIM?=
 =?us-ascii?Q?T5WZfLHtwaK9uih5B4RSywI7PUgllLVc/a9TzR1rCyp8tAsyfBK16SaMo9dg?=
 =?us-ascii?Q?RETzn1OvoUtpmagSzUjEVVm2OCtaBnhets0TMKhRqWrs9uj40J0wjwFgPR1D?=
 =?us-ascii?Q?OpHTl9Tu++iDXb3tqdb1irt1Z1nCDStIY3OjvvvDiI+oCgY2tWwaWZiGBAHS?=
 =?us-ascii?Q?NP79W3IaISIhSgBBiJCpV6T8N+7bK5SHKLCRKdZQt4HtMZxgyc/js5qsvIw2?=
 =?us-ascii?Q?pysWm3GDUc+qoasd7+2EyTVdd1Vh8wZ/mAMICaUIKCSltsLLUyqna1BXDkVN?=
 =?us-ascii?Q?/3W15gZ1CoRQJDuaivmFzaoJTcT/H5KQnv1ldDTRBoqTzUWpQfsVwRTY0489?=
 =?us-ascii?Q?WY12Gge8T5HFIff27yJb1E3yDWYO4Mswhy7VWtzhxWOE+xWDv4wgvWEr7SKV?=
 =?us-ascii?Q?Y+AGuP7dirEeAfV0mn5BTdedGhg3s/q/Unoph1zFmJPMcNXgp+UquuGlVdrY?=
 =?us-ascii?Q?/v4OMTVbHGPlL2drXOy2Xvz8BtRIZALTyoE2P5E6tGR7tw7W5UxMdcZgKyL2?=
 =?us-ascii?Q?+L7soFMgreaMOKFDAvPL8HvtVBiRvtaCnkqJfdgS2WN47aIZy2r4XaGB4w0n?=
 =?us-ascii?Q?HUziVWqBA/P4Qcj64vRnfsNOdqC+RGw9X8aYpY9jtaXyNMnmtkpgGBfWX3iY?=
 =?us-ascii?Q?QtEch9MZ/cF+kgLgf2w=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:06.0445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a8b81e-453d-44e0-47f3-08de401829fc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6220

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

Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/pf1550-charger.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
index 98f1ee8eca3bc..a457862ef4610 100644
--- a/drivers/power/supply/pf1550-charger.c
+++ b/drivers/power/supply/pf1550-charger.c
@@ -584,22 +584,6 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(chg->dev, ret,
 				     "failed to add battery sense work\n");
 
-	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq < 0)
-			return irq;
-
-		chg->virqs[i] = irq;
-
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						pf1550_charger_irq_handler,
-						IRQF_NO_SUSPEND,
-						"pf1550-charger", chg);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret,
-					     "failed irq request\n");
-	}
-
 	psy_cfg.drv_data = chg;
 
 	chg->charger = devm_power_supply_register(&pdev->dev,
@@ -616,6 +600,22 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
 				     "failed: power supply register\n");
 
+	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		chg->virqs[i] = irq;
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						pf1550_charger_irq_handler,
+						IRQF_NO_SUSPEND,
+						"pf1550-charger", chg);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed irq request\n");
+	}
+
 	pf1550_dt_parse_dev_info(chg);
 
 	return pf1550_reg_init(chg);
-- 
2.39.5


