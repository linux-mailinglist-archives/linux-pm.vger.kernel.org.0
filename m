Return-Path: <linux-pm+bounces-39748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E45CD3859
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29BFB30221B8
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7992FF150;
	Sat, 20 Dec 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="R6YS+R6D"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7612F619A;
	Sat, 20 Dec 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270169; cv=fail; b=YJ1llsihZN/RNCs90TfCuMTIFiVc9dKC6ZbIOiiiKvXY1SzdjI7hJ3QEAw4zwVbUs0iWmlSnQ0dbJkUGUL/F/jTTD+vs8NDtXNFm0JDGuQ9JTyxiZPHTcXttCuhXkcSZt5somyCUd8wbfXkhGnsJixKJqODuoHT4scFj58ouTHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270169; c=relaxed/simple;
	bh=6ygtsOzel7GzUOGXkaHy9TPnEMEcDWSZTOMza6PieGY=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=t4JLLVUZqzXqqlY+DY6pMVdxk1bzgGHuXzTcO54IKHuD87kMxHh0gaLgfCIZbMOFLVhjMxuA6NFzH8b4u9XUgbwepFE3LcttRWyKNksUfALxYBl4KqnBcGxWDoZz8FGqgB0DbNJ+4FPxd6tv2irJeIAztmryblo9ChImXYD441E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=R6YS+R6D; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT5GOwEKqzpLFsfdAytcabKAsd/MFyHgZ3RShZ+arDWRubKi08q92dPTIh6aIBaFlb2cMq4DRulA5/gGnhN0pHC1RqRaCP4koi6+EYbZOXp0rO1a80xzleITVxSQuU+oON6ZptAfvHKcJuXLJqaV1jKJcqE0mAdFHB4yE5T+lx2ySrIM6SBdnNFp+A7q2DHcHnOIADQOxLA9zg+ZK1SRidpr2BOttUGDRVGeWF4frwRHrhN7a6WSvrv0RraImLHLIYL9JB+dqv8lWI1vlzrl6NxiuSjqzIwO0zzAZ1YfnbBB727tPNKBs81HYiUCfjIcfrv9BTBxERw8X3tBBYHDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mR+GElbgIMfwvq7wV8WtP2X5vrcxQ3sl5Np1770ny8=;
 b=eAZ93vtkEnEvzDX04RTqBmzlGIFEm94rsHaPDlpwAUD1YXX1nozayXwrtlMoH0d4Vaq4pUDD4P/Q/QfxB46x7SDRQB3O4/TgjTJUKfI8bnPEWAT02vxD8a21AtfjYm1ONRKYtsRNMk/2PX/sdQ+ok6MWzbdH6gE6zcx7IxzbF47xyDg4kXbaLkTIqAh825N4Gkm4JEXiy/kxQsrP1BoXCsPWLh/Hj2fM99IfOeQ7U9hNAAIYeS4bWemj0PnbMqwcrAjB+1b3b/JhceU2Ma4/jktIzLYt/1JgzsFzpz877IlAejVMsmzx08xuH3DmpBCCbC1ZZrSKVJmpY4Il1C0Z0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mR+GElbgIMfwvq7wV8WtP2X5vrcxQ3sl5Np1770ny8=;
 b=R6YS+R6DqKz5fSbDRklTIMUAgYKBFSBYnJB1ipOh4SojYRZclD4bWjS4R9dh2Cv4G5nn6JsLSvQcixTa2BcRZoHbmX+bYvNYZM68wR28cuAdM4EDAhN291ffTlAh+HABFnfAsLgmOa44byRjfUViRdLAN/BCn0hwU98wDsZLc6Q=
Received: from DU7P194CA0005.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::32)
 by VI1PR02MB6208.eurprd02.prod.outlook.com (2603:10a6:800:18a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:02 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::1d) by DU7P194CA0005.outlook.office365.com
 (2603:10a6:10:553::32) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:02 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:35:59 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Ricardo Rivera-Matos
	<r-rivera-matos@ti.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] power: supply: bq256xx: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <39da6da8cc060fa0382ca859f65071e791cb6119.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:35:59 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|VI1PR02MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7d90ad-b936-413c-3903-08de4018279d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cwYeCajceJON/QfsXVKy7QUKfNYDcfiwVv2dEFIJ6tqoz/MEKwhD6hH/ABKk?=
 =?us-ascii?Q?vL2wsXHkDzAw5VRJ0LhfO6rKPMr9G0VumJ1OV1W5MmV1oX0hpAdfVBerZuJs?=
 =?us-ascii?Q?TY4JqVNMXbCT36KjIsJyvRppOq2lrCSLuo/A89Z9T43PgZgQI3G2fFNOioVP?=
 =?us-ascii?Q?aC0mR4zSXhAIzqX48FcUH0jwDZKIeZgF8cMhTezbUAGBqKc7k51q+JgP8imf?=
 =?us-ascii?Q?P6gVU3Qn/zT9FEgP5RIRWRvS7AuKM1aTQmu+tm5ccW2CzALTGUFKUsnintP+?=
 =?us-ascii?Q?itN+gCvC0jMfxMD4A66MVFUZ4NbDxArgGdcuMcQOk0pLAzeQXbxrgrMjNj8s?=
 =?us-ascii?Q?2Gxa6xGk6gtkxwYGD9B1hLJFwyzkTL+7qe/kw7/0r6C3eFVWGTi+WF4EGNXt?=
 =?us-ascii?Q?OFlOtcG45Vn3laTORt7Xfjpl27MN/j0RzQNEVUZNm2+lpTqJ9fK8YUC5zUe6?=
 =?us-ascii?Q?dTJM1NY2dWsGaxxo+knIqqIWGSH/276NATGHsF9INPEJldH1nSFN+kPRqDjl?=
 =?us-ascii?Q?VcVngq1DIGIv250uI3PJ9Skebc0CVtFV+Ar57CnRuUCqeZ/ElGUtHcY2jdPr?=
 =?us-ascii?Q?QAlEd51/pW58qk4nrwLOjwG1z/juOI/dH73ZrdTQWu84hip9Zho1iaPlVeta?=
 =?us-ascii?Q?vfCyAseTR4KOoBjvRJf6ejkmVVNlDU/qtm5GT46c8a1brGuR7VhGP6is6ATn?=
 =?us-ascii?Q?psGLX5vn+65gkLs7EK3m9XlPWIkvNG1Jkn9t8IIZYeVyAUyP9yC13a/uK/66?=
 =?us-ascii?Q?sn2HCs3gfBHHIN7NwSu64jYMZ4haOYgVI2xZJ1rm0ZmKha0sxGI5x+00OJB6?=
 =?us-ascii?Q?XRNoDOVE9cwSE+2Kyvj0SDCpVpKyfQ3FYO4EwmgV1wlTrAtoc41jVHTvOpoQ?=
 =?us-ascii?Q?qlvt52KXOhCbmigwiJXBTEcHkTHOIoUhcWTtujbbhUGwMg3Ir0T7i0Mcupey?=
 =?us-ascii?Q?aZ9eG2CtEw0u/4aVfZuQl8yVGfPTG2JstO/zYyVGt4Q3OxBmpL8sWOs5V/hY?=
 =?us-ascii?Q?smlW4zyKnaZIYe9oAGhYeiC6QNk4yts8kdOxcyDakZZzKDhERQnaym6qEe0t?=
 =?us-ascii?Q?fgwi9VK6GgwFMYXrKdCwDOxKofBpwZubTrlEkq+PVNhcGEGiL1nnA/V3JeB2?=
 =?us-ascii?Q?Pu9wR9KPq1CjbN0WJh2B1LYiGrSUjjihxW8g3pF4vad6TPTb/YXQcdCvULt5?=
 =?us-ascii?Q?6H5jW6KSGibABjq5cvN9P/WJ6S0hjHEU3GthtlsK7af0LocqAPBLX14biaAU?=
 =?us-ascii?Q?MSmW9lRGzVPoZMIXJOQXv7/Pmq27k4Uamf3SUhSLRV16DHF4qJpGR9GQGOD0?=
 =?us-ascii?Q?Se43QYI982xlhOpEtQ5z0hvQEDD1hD3jamvp/DAB60qZ3bVwE0KJWqZnJrSr?=
 =?us-ascii?Q?Y1uTkVKiiPrqh/UUky3Xzr3CCcq7BcqerCy26Okamh/YNwv1UMBFZ1DSS5o3?=
 =?us-ascii?Q?qHKEf0nFukNpCqfwofEUy+d1hx9Dqxo8S6OMW2+FoUHxWO1U2k0BhPRlFuek?=
 =?us-ascii?Q?0eKYAcaeA++r0Efpg++3uL8y5LdSLN08BiVnDmq5dg+Q66dj4qWTCOsCqctj?=
 =?us-ascii?Q?qgLSv8hLHApjPPd6AHc=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:02.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7d90ad-b936-413c-3903-08de4018279d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6208

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

Fixes: 32e4978bb920 ("power: supply: bq256xx: Introduce the BQ256XX charger driver")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq256xx_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index ae14162f017a9..d3de4f8b80db1 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1741,6 +1741,12 @@ static int bq256xx_probe(struct i2c_client *client)
 		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
 	}
 
+	ret = bq256xx_power_supply_init(bq, &psy_cfg, dev);
+	if (ret) {
+		dev_err(dev, "Failed to register power supply\n");
+		return ret;
+	}
+
 	if (client->irq) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						bq256xx_irq_handler_thread,
@@ -1753,12 +1759,6 @@ static int bq256xx_probe(struct i2c_client *client)
 		}
 	}
 
-	ret = bq256xx_power_supply_init(bq, &psy_cfg, dev);
-	if (ret) {
-		dev_err(dev, "Failed to register power supply\n");
-		return ret;
-	}
-
 	ret = bq256xx_hw_init(bq);
 	if (ret) {
 		dev_err(dev, "Cannot initialize the chip.\n");
-- 
2.39.5


