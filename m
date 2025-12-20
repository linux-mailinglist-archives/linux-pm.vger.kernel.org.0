Return-Path: <linux-pm+bounces-39753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25978CD3857
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3B143005F3A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24468303A12;
	Sat, 20 Dec 2025 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Mw599/sh"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4397301026;
	Sat, 20 Dec 2025 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270176; cv=fail; b=f/nCcXBhNJNYaJZDrAL3g60CROJIhlSFbmjbNx1n2axU6/Kl3Cy550PmmITCKeQcojNg1xxZRU/urBhBY+VKcHJBLwkCsbP52h3/yeAQ193VQTsQUkq9c3QyccQzdliC3heMj3HGIIexg2vxn4iGq9eqnT8RptsFBP5s3sRgNYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270176; c=relaxed/simple;
	bh=GBu2Rpp/m557lHhs0V5AlaO9eyCxvaJJ/sbCA9ocdSg=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=uK0TU48KeFjJ6z/R/HNQpQyzIC+qQfnVclwe6LTY/1cTOjfsVzZzEvWf9M1rMolkMhdxp19zooLxwemyg1b6CxYFIP8971mviHMqsGp6mRbj9xcwBwkSqMCRe33Tjta74sPEQ6yiBhD5eOqHseGQhcGNmMYCn7jjpZsNGuUT4mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Mw599/sh; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIpOpCTKwvX8084ebyRNnf/iZdECSXmCfxxQWGv8rycIKjIJZA4E4sG5GIsdqOayk5YIBWGzRdOYY8WIeULsfYk+d6+l7otv/l8AjmWWrh2BXIdiSzwETA1ofzTg062JqeGCj9wRLU85Q09MDIYOFuyAhWowRQPCtzWiPUpq/0+Px/Bd2uRC1fPxa3OOuSSGqgW8xnb4OXQvei5632KhPyHDoVvAeaFqhK4LxfMpmVE+e0F2RLyqbkOdz80OBfPwRDWMvK5Qy0l/x5RDkED5+xZhTD1OvN2UVcWXdweiTWyb3O0v6SaOLUkP6INkjNvL6HA5XuSWM/vBvY3k5z9kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EixoFflCSiLPms/qWvBi3qc8gClGNRYy7y6N0PFhnNM=;
 b=P8wZWe4eUdEeafYY7lMzn+u9jJA0Mg1fNZEDAc6cr4s06BHew2nasomBwJv5AXHP/ZRdFOQ2c1xunpa2e3p0tDPEB/lAjY41JaQCjr0Ot7q0a8jsHun/JHKv6K0j6B+iyzP/KDyBAaqR9Arkl98FBoRH6CR7geHsXJUhhUP75KCRN8Rku8IwkrSzH3P/pUMssemXS51cNP7lo7WXlo3mLEWkh491eukBCnwH+TIqbQhAC+TFg4YzW0xT3R0YRiKXw8yXZw5or86NjUGI8Eth7C6cZcwX8SMNlbzxVjqcrD45L3D2ODB/lcEgqmrDprsi8tzXYh9VsmdyiMjPKVTPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EixoFflCSiLPms/qWvBi3qc8gClGNRYy7y6N0PFhnNM=;
 b=Mw599/shhogvd+7phVGXn+tv8+WLouMtEG8vI3PUAFMaRqaUy4f2GunMrF9OKFA1aqq2dGw2l0vqmxs+W2GW8rHWSEgFtn45PRDwTs37U8YqJtCordBpL77amOx0706tEu+M8l5gN/ZrTS9UEEKW5/lz06hI9xHIV81NT6XEe7o=
Received: from DU7P194CA0021.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::27)
 by MRWPR02MB11799.eurprd02.prod.outlook.com (2603:10a6:501:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:08 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::ff) by DU7P194CA0021.outlook.office365.com
 (2603:10a6:10:553::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:07 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:02 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Nikita Travkin <nikita@trvn.ru>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] power: supply: pm8916_lbc: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:36:01 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|MRWPR02MB11799:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e291b70-4749-45f1-8d3f-08de40182b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ooduLO5Uzn7KpgfnUGY9+FqzeHG+PxZXc3/6ql72C4sj9jK7+w8qqyi48EAl?=
 =?us-ascii?Q?LO6ipZIfpK58rkrxKeCv54PiHDfwBCJEGZym43pRk/2T/Pdb1Yztl9YLYn2u?=
 =?us-ascii?Q?lkAnPZ7/Zy7WMbWgBbUF6PgPa2KqICckMJ73I9bmB4LATBGyqXutyedVxq1c?=
 =?us-ascii?Q?A1TOQCeJ0/Duc1JgofjSFxlfpQpijKY4LlWyC3SPkSUbYhia1xhcRKDt5IEZ?=
 =?us-ascii?Q?yuI6+MN2zHsdwxztQ6YH+8pspCHdHzmbIO6z5zH8oMumyfuQ3EU42iuHup7G?=
 =?us-ascii?Q?8/+IkbL0Fzg+XU0jijIhtmDNdsJhlcjDV9FyM7G/RFrbPAnJVByhYZ20kOYU?=
 =?us-ascii?Q?ZG5Xo/wHLzz7ytoXGHbf5/q0dgm6QV9Lx+uy17pxpmDNF2nL1Vrmr62fo50x?=
 =?us-ascii?Q?gOocji+3RNGgtouxc0p1XJ0S3qtBpBwOehzouLXFFVIqOflHoUueaDhYhY/e?=
 =?us-ascii?Q?eiadrLUGAsCq61MBuIa8hlyHGyAtoTxFU/Gc7HTSxSYoROLHPfwCBbTvv0oE?=
 =?us-ascii?Q?b3I/RSDMbqD9AfZWGQn1CmXMkgl8LlIgMYFzoRc10QRKjSlEnwaf+bM/94Dj?=
 =?us-ascii?Q?LdylrhUOuqNtDnbDnArRV370KbumCiWsOQoxqczFZRAmjoNbbO24JFmCBec2?=
 =?us-ascii?Q?Z1XXJRDBGndEkBX4ih2TR6c9XSK1vTywQTJmzjDAozdszVWjuo8Vraw0UCT6?=
 =?us-ascii?Q?wHvLAhH7TRwfm35v0tcYNrW1DThkrwKSBXPDWrYQyOfYcFobhPpqJ4PQvpCo?=
 =?us-ascii?Q?T9/ZGht/iu3mtBbe0Oh3BLj9Nu3E4UL5sHTT8j8uVRKZV0yurMgsnglnHv03?=
 =?us-ascii?Q?QVaZJFH62DgxVDEa9smj/p91cTqz6o6mQIKOI8BACIj1FVa7Yz86GAz3Ucin?=
 =?us-ascii?Q?tbemsvODxLoh1iHsltm0qLUGvMwiuxWCt5C07oCr/HaBlDh5kONa92NVQ8l5?=
 =?us-ascii?Q?gCObMPtvgqAUn9uWDnSf2ugv5RFLAdWkj12As1hvCDXKw7jZ3xFk+6CjC6TM?=
 =?us-ascii?Q?wqR0xFwa371mOanUzl4ZnizL+Me6P/nQO65ByiyvGyRZAIGqYTvv4mBEUq1j?=
 =?us-ascii?Q?774AswpiHIZqajKoPk+Vi3cGvStxTPwr6t4sfZTCiKcNW2bIydkVo3I6vE7c?=
 =?us-ascii?Q?cf2pn4GNV47Yv+IBd7apQ+W5l1TQyxLWhp78pYD0n22PmAEIuQyEe9VqXZmX?=
 =?us-ascii?Q?5fxxJwMOJE4atgiIGitGwy60VrOH29qaHmYQjrk8sQrVR43XDsd/Ph/R/yCO?=
 =?us-ascii?Q?GHzjYbAGgeBm2pL82vlE5RIMlqqC2Dy1xhg+KIAtKhqn9MgPy+ezEyQo/P69?=
 =?us-ascii?Q?o2inzBICNXLqh3xCCjv07AUKxCWSLvh0cWlvFwD/q24qHIESZzQX8k9MG5lC?=
 =?us-ascii?Q?S4Or+bDvRY6gI/FwR5+UH5Km0mtp3LGSGKge/+JchcM/cK5AoqiuoX5lcJOC?=
 =?us-ascii?Q?pV9vNBPXGx42DZ3cU+0IbSbf3XNsY90Xr7Byf/bhzTY5UHT/1vEjzpMEFnth?=
 =?us-ascii?Q?WyjRf5gphkxSYr+KFLXMIIACCJXOf5i8oj+Bw5EaFAfJiogv5CVHd1s7aA60?=
 =?us-ascii?Q?jT3/iqGLinaas5P2m7U=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:07.7635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e291b70-4749-45f1-8d3f-08de40182b02
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR02MB11799

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

Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/pm8916_lbc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
index c74b75b1b2676..3ca717d84aade 100644
--- a/drivers/power/supply/pm8916_lbc.c
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -274,15 +274,6 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL,
 				     "Wrong amount of reg values: %d (4 expected)\n", len);
 
-	irq = platform_get_irq_byname(pdev, "usb_vbus");
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
-					IRQF_ONESHOT, "pm8916_lbc", chg);
-	if (ret)
-		return ret;
-
 	ret = device_property_read_u32_array(dev, "reg", chg->reg, len);
 	if (ret)
 		return ret;
@@ -332,6 +323,15 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to get battery info\n");
 
+	irq = platform_get_irq_byname(pdev, "usb_vbus");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
+					IRQF_ONESHOT, "pm8916_lbc", chg);
+	if (ret)
+		return ret;
+
 	chg->edev = devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
 	if (IS_ERR(chg->edev))
 		return PTR_ERR(chg->edev);
-- 
2.39.5


