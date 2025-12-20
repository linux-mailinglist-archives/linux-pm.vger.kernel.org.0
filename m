Return-Path: <linux-pm+bounces-39757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD8CD388D
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 766853003863
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139142F90D8;
	Sat, 20 Dec 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GqQc3Msx"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415062F83DE;
	Sat, 20 Dec 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270793; cv=fail; b=TEkMm0yCJQnkfOydblqBoiNfhNd2ffsCKclxO967MR/mK4GL5o9DWeoktSZP1DvZ6qC5kFxrg2G+q/h/Te+Puf0xBw68wftTC9l6DoRjqEl/a7cbyOG4/9gXBWygHK+SWQtQZaTdYJjeWDt1KK69nVuKWpdSpNtRI2ZTkIXLK5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270793; c=relaxed/simple;
	bh=c6aCRUx6V5cCGHTJIe0H35hD162EHgH7CrgCZDwLqNE=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=Z05O3nASYBrqvJ6oiUpwAJ2BKrfbZpaes4L+fCcRb/XS2fY9mavpACedqSYbo/aicaqlUYSx8sRqVt3pqY4yBlg9TUmHpUYU7sqdl5vnLGBq9t+7iM+9We1LahTUdPZFtep2G9L8W0qKoH9xcfGp7PQYJjhETQXnb+CzBVZvZnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GqQc3Msx; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK2zncsAvHmb1dNMdZpDn7cl3IJUCCirqqZqwTDLms2HS5h55HDjAXEW8HeUyeMVt29eIUw6SFrXijdpzgmiTAYQ0HoLHMomIxqZBxdaZiMXZ0i5Gu/tzzN5pNEx+90ujGy5C3Od8/kFU9X9EBkAP7tsDLIJc5T6lZGpsRb0khx6YZt4P+fACGBmSiAuQbZYRUpXPqTfwrriDz5TLeQeCAqGmxSYZ/koTB/fQa099X2IiqUCKng4uSlLKdkfxDZWGQshnySOCTzDoXTjTEx46rZbIw4J5Z11J9t+n8Y0LjFycf1VzQLVa4NXG8xasNX3Lo51AQi0AegkRaCguEQbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMIy+HcAgKF9/c6lOvj8IBslPNhRns1bU9mJJYYFdKc=;
 b=K+yTzBU5J4TQFuublnKDFCIlzzfHV5ejlHX7R7hGJDsUBpp+CW5HC/C2to1DNmvYpUL2PjFlP9IAYSuSoSESwScP2AK5v7bVn75FswICV4keo06DZpJ1dDD9HMqiIJ+JknfZvu/hTVEN2yjNPxtK5mYfO5pQldSSG38Y7CoXnNS4qrSX1GTRtVkLpHXqNWEA768T/Ko4O3jm3XkNxItoNEGmFHw+2/XxvuBtozWMkjSl6KTl4Z9vHQlhC21EIYTPcUTuyP8Ibj1eNJBCRK8hfdNV2oLPjhGdTdlejp/PVTvWJ7BZEcOZq5akidf9gpzJch4sU4s581JAYlD3i4Z2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMIy+HcAgKF9/c6lOvj8IBslPNhRns1bU9mJJYYFdKc=;
 b=GqQc3MsxixJOrfFvmyuJwoRlNmEMVshMkprfhDiwCY3Mc+joTaeXMxjQKLrvlwwjR9w20BR7xK+Cc5IA2/pLw2/3bGmG1Ob8FiWDNpL1wPY+ncz8IQEfADOCK0LgRIgX0bmGpC7j+LqXcqzU/CVb2sLJdzmHf4Zfj8L5NEiZB+w=
Received: from CWLP265CA0409.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::8)
 by PAWPR02MB9757.eurprd02.prod.outlook.com (2603:10a6:102:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:46:28 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:400:1b6:cafe::1c) by CWLP265CA0409.outlook.office365.com
 (2603:10a6:400:1b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:46:27 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:46:25 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] power: supply: wm97xx: Use devm_power_supply_register()
In-Reply-To: <cover.1766270196.git.waqar.hameed@axis.com>
References: <cover.1766270196.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <883bfa991f977dcda20f9ee6b82782850a0ab100.1766270196.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:46:24 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|PAWPR02MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b0a2c4-43f5-459b-e9b4-08de40199cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftaWgpcWWk4TvDgLjDD+f1cBlx/d7Z3e8LtS1y8+JTmNEUE28sp6pe5l0bdk?=
 =?us-ascii?Q?TQULYSPrN4V3k7rBb2+G8BQy+vVMmoZ3TBtqXqHARIiH5NzU3ukn9I0PnTEG?=
 =?us-ascii?Q?IPWi/iQNTs/T3wOSI+q7GesYmTjb5n0YWcTsnSrgGyHJzmQebvLtbF+KE5bb?=
 =?us-ascii?Q?VLM3jJbvTViGIZs2+BTHB9B6+TlsqYDbx9XW61ND/vTUNZ0RSQ0n1jCqzKkp?=
 =?us-ascii?Q?14BiIR/AYY0FZ9cgh2XBtoN1SygR0jSgksCJcajUqEAlrmfoIHqMXuz8yNex?=
 =?us-ascii?Q?+TZc86H8AXuAdHQGVBc9P5JJgIHvvnf5fsy5GhyRaUqil4jelTofQJpIRKoo?=
 =?us-ascii?Q?xKmX9NrxqAr70E5skmD5Y6+kXDxLAkfda7La2GOb4brqwgys54igRpmPygG/?=
 =?us-ascii?Q?xE0Ao6X6f8Ck+UrYsewFrt9Gz6Z9JBIC0dLlJZqg81r6DP0JT9SQPk8ZbhD2?=
 =?us-ascii?Q?usekiwrT4bxmlZta7wek/aSLl9LV5Fkx/PFJaPCMALk+AfYi1x4byWzZiE67?=
 =?us-ascii?Q?DgWkTkr4on3TUjLJkEd1WqIw1HdhtKlnl7QhT0+CvCuDa6EaI8VE0x8ckd0m?=
 =?us-ascii?Q?bqLV+IXempLfzXxf2KnrAUfnffjObtFGrtY3JXkPUR1nZ+WFO/Ng6olhk2ln?=
 =?us-ascii?Q?SqiDSx5xQsKaTWm5XvQEJbJU7aKBou/bD8VLtBAucQaKHLcqAMBpXv2+dsQf?=
 =?us-ascii?Q?IA5w3NKwN7Jgp/thCS3yVd23UDpCdIo8tcErrRBfVBZ7VKEvq8w6kP3S1BHN?=
 =?us-ascii?Q?DSiZIM15/kOHbhD1bZqQSv06jeaozQZqt9wP6WINZG1qNhPx4Yp2vT3bMbJA?=
 =?us-ascii?Q?Eedy/AyIK+qhwMDgsnpqBQdYoe6i0GNQuKGmfyoxwqJKdtN0/RX9jNtckgdu?=
 =?us-ascii?Q?hRXcoRWc3h17GfhkGNQMZUF7da+n8BGiIBjPaNnOgumvbJV/OcoiPfoMw/xi?=
 =?us-ascii?Q?LNaexDo0ZMLvxwHxBP1DC6anzbd5LOuMmy3CMS31Z0wkYIKK1kHdqp4UilDH?=
 =?us-ascii?Q?2Mafo5KFLsQM1Nz7ikiH8yXA0jDPPF9mxe65DtTq8WEwUE/xdlTa9rPgFzgx?=
 =?us-ascii?Q?6dnT9EOrUCGAOXJN0IQFtRWusGDYXn6V+bCZz+88BK+ROmptTr8jaFlacLqm?=
 =?us-ascii?Q?o6riEhYYWcS8FKVqILqfTQ/VlAT6TZCPs7yygwqq3ZlkWKKnyajiFm53o0jQ?=
 =?us-ascii?Q?xtTQiYRIbaGtIC5hORDovV38EzdsyRAdtDzYBjoVM4ABkSph/YBFTr9oxAPW?=
 =?us-ascii?Q?0U1f1cwLEcs6Xqx8T3nEU//KtCIYvcqcrdDtD0I5kLC2RZWUKWH4H4JcHN50?=
 =?us-ascii?Q?Zqc9MknSIepV9iy9w75B7Htlr+j2zUAZSP95S+W6GEa+eUO30aFqZJNPnK7I?=
 =?us-ascii?Q?5cvFUSUzpe0hbACKKUZvsyY5Js/ef/0GH5LJMQsGxVYRFtcD25RA5iMoGnXa?=
 =?us-ascii?Q?Z5zjb+mhFDmDIhjH0j3tTNQtemPX5OA+jqhH3kut+ed4rOgm7PRpznPRAvlm?=
 =?us-ascii?Q?yb5vEsMOjxi72vhLIr/7FRWWy6pUqOXECcwnoI3WyALpDV0lh1XrBEou4h9I?=
 =?us-ascii?Q?AyYg/UJpQq1N58nQNBw=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:46:27.9968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b0a2c4-43f5-459b-e9b4-08de40199cb1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9757

Instead of handling the registration manually, use the automatic
`devres` variant `devm_power_supply_register()`. This is less error
prone and cleaner.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/wm97xx_battery.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index f00722c88c6fe..e91467dcab19c 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -223,7 +223,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	bat_psy_desc.properties = prop;
 	bat_psy_desc.num_properties = props;
 
-	bat_psy = power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
+	bat_psy = devm_power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
 	if (!IS_ERR(bat_psy)) {
 		schedule_work(&bat_work);
 	} else {
@@ -237,15 +237,12 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 		if (ret) {
 			dev_err_probe(&dev->dev, ret,
 				      "failed to request GPIO irq\n");
-			goto unregister;
+			goto free;
 		}
 	}
 
 	return 0;
 
-unregister:
-	power_supply_unregister(bat_psy);
-
 free:
 	kfree(prop);
 
@@ -257,7 +254,6 @@ static void wm97xx_bat_remove(struct platform_device *dev)
 	if (charge_gpiod)
 		free_irq(gpiod_to_irq(charge_gpiod), dev);
 	cancel_work_sync(&bat_work);
-	power_supply_unregister(bat_psy);
 	kfree(prop);
 }
 
-- 
2.39.5


