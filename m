Return-Path: <linux-pm+bounces-41352-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMcSJq83c2lItAAAu9opvQ
	(envelope-from <linux-pm+bounces-41352-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:56:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374E72C60
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5699E3016D07
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC033343A;
	Fri, 23 Jan 2026 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="j/288ZdW"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9C3242CE;
	Fri, 23 Jan 2026 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158550; cv=fail; b=lwRSqAPf4Vi3/chPnpFhnnrfyE1AOR8gREqIul35Plj4yJPF+sI/bCKBbXWXi9eOgW3vOgHqtoew3L6Ky+Ez3X7dX4GVc84D7E3bcFs0ueY05fh4/GQXF7oO/NcvzVBpmejisNXQRPO3EiybsRuI5Od1Wi4OzBeR8LE1XaOIlfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158550; c=relaxed/simple;
	bh=LUiLiDbi5DE+ztV80oTkBrxzUN65ZdBQK4qEirH0Te4=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=VTBwTeQ7t26MEvOFtSOEQ/3TwtAZmZ8OVX2tB1mDt3NkvRWB7r1dtehIsHSO4HJDLqVTF5DAI9PfqH1Cot/3Qym2i3JxmeBc5htPVa+v+tUOXIXE8APxDhdVjJY6rDGwWnsp8ffLzlM5AJRTdUGLLNoLhmWkBFSHsqVwygAHt1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=j/288ZdW; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhvhMKJqcaR+CAinWHrTgFVlPfcHGtVrBsF3JfpNFzpoXAPDJ8KnbTjgCdngAey0tY9DLc68l9RdOVW+HyP2k288eyO6gQIrZNjptlvHdNqONpEwQ3iZtMQcyAVyjUn9HPbyLZwmeLsMOLoX3tMCK0oJYEVT1X4aEVfL+yHgplBk7Px90JGgsuwr69EuT/uE4fcOCzoA5hTcVc+JrwKSh4sXd9/FiQbZbCEZG9+ILVp1HO2/8KaJ3Ssnn+tiAFNg/FAqorelsaXw5niU4iK71AzFi0BRbDkHbHvXJ6MhzQbOJylblt8Fqf3Zp1qYq3p+bydBzeWSmoqropW6ArSiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ltHu0nNmVrn/la/oLgSFfRyOU8aT+BqSYxtYirJMyE=;
 b=lwB25VucM3IQSaJCM71s3o3s2edgCnRZz+ZAMYJvtVcqHZDKjwRyu/wnl0gB0GpDldqaK2JvI64DmFiJPw1Y+LS/AD0JxjK2xonARpJsbtOtElULnCoxyx/T/Ks75DXsUmZNM9NuR0A0XLARUAfM5yWVZmyxP3r5wNI6mz+VL2I3xtNFsoxQ2x3evux8V71fiXmB33Mzn6YbfDBhr5ElpI6JmV8z5Kp9ECWhFyTHjub8ekF8vlHDozAZ2t9/HDv8lrUQv25cwqffa4vgwmPip796BpR3TpQyEaNIehgqPrAO54d5GYwK2LDS1rX4pkNKw/+dls6NJIAqVxZx7SLrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ltHu0nNmVrn/la/oLgSFfRyOU8aT+BqSYxtYirJMyE=;
 b=j/288ZdWDSIVRGk10rtcz8D9r5z6/7NFkKsxuGpnziNgcDGl9L1TmcFkpLd7ds+PGMRLX/qLq4CqnHWLcPs1iFM1GzixMy1aWmxyvEynBgKiYDmiGx/8+Eq8qvXKEG53m+oFhi07gAxWSumePL+YA9R37uhAIJFmJM15ahqgYtE=
Received: from DU7PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::6) by AM7PR02MB5829.eurprd02.prod.outlook.com
 (2603:10a6:20b:10f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 08:55:45 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::1e) by DU7PR01CA0006.outlook.office365.com
 (2603:10a6:10:50f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 08:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 08:55:45 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 23 Jan
 2026 09:55:43 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] power: supply: wm97xx: Use devm_power_supply_register()
In-Reply-To: <cover.1769158280.git.waqar.hameed@axis.com>
References: <cover.1769158280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <b0b366d302f0605c8555dd68ed32973959f133bb.1769158280.git.waqar.hameed@axis.com>
Date: Fri, 23 Jan 2026 09:55:43 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|AM7PR02MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f8f7fc-24ab-4bf5-adc6-08de5a5d323d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEMm67G0SsQhGwQcDwA/4+wwXasFGS+oLcwD3HHbbHaKlyjN7GNdM5e2l1cV?=
 =?us-ascii?Q?0Kry3hv+OyutlAG2txf6Yz6FabVRbK3mBXKV4pBGYoyn325dZJ9xrDcKpYWf?=
 =?us-ascii?Q?qczaPvqKELZX+/xw5TSLxkIs8GkWQYxvnu2AaNJbphaVE7UCTbQdaPnNn/50?=
 =?us-ascii?Q?nFyM1Dq4OGD1H8WB/KKl9yWmVTWhpI5BvXUy/XF+ZTcYIAvkDKh+Gz/j9uqU?=
 =?us-ascii?Q?QtgtwYYC25gd92x/TADP8BrihI1l3+OL889wGrDdKKP1GYzcS196Kgjjl+nD?=
 =?us-ascii?Q?pJ7c4NGTOVczAghWlKN19EotacoHUFP2ZKiRUyiMxEmfp3B9F0JaS4teLnbp?=
 =?us-ascii?Q?l/0uMz0Q77C2vz178rtGaW6WDdMH4mij4YpSjXQ2uCXJYeB/Q2Bi33v8REwR?=
 =?us-ascii?Q?7jROt+sTIrQLaWNkqU/MRCDQVtIzdo0d4Hjo2yTZkcdy5LN3Q5aEFE8IDGEd?=
 =?us-ascii?Q?62YUeGPX0WopuFvVyKHbeR30wneGIf+rt6/wHvNemihzd/YIpraOR7hVOB9n?=
 =?us-ascii?Q?k3lrZglRTcqyEjlWiEhJQdITjcEXqeNGgZBRfhUgy9pFIDM8JLH/j6vNOs8p?=
 =?us-ascii?Q?IxORzUtDTvlF86tKVbdPL51c+wMjX0hP0yiBrYYePW2brebbJT0Hz13wBni3?=
 =?us-ascii?Q?7Q6DUs8K9J3jJNtDxLKCuPJNV9BoSseiYKxjNWp5If86vOtvW4MznK1LJ46C?=
 =?us-ascii?Q?bEpqEJDGL0rM3NMBraX710XYapJvQvKM6JThlK9UgbryZFYym1RSZrXWUQst?=
 =?us-ascii?Q?Q/Y9hPziQvMedP6U68xGvjdN2w+k8Ov1zSZcV1y9qnlxZBK7J0fqODJwUWnc?=
 =?us-ascii?Q?qfZ7LvQYowTRuOrNcKBecvzBaEJjmw+A5PsvI7X+6C++NqrX9asQd/hUT1Cp?=
 =?us-ascii?Q?H5ek5zG5j6v3GUodshILfslidLkpMwzCkkhwZ0jaPqCXMzqlzrqP0cJIYBnn?=
 =?us-ascii?Q?UUIelrYIii8VB9quQpzVQCg1Pzy4EngEKuVvLSD3mvRNptuORISkDPlMrU/d?=
 =?us-ascii?Q?dWenmhZcs2tPyDBkIeTIovAyT2TnQs5j2mAe0Kdp17LQiVfwydybg4K/aeCg?=
 =?us-ascii?Q?zIrDoU6hiWD3afdE1hi1YhBI5T89jME13sYtMr2IZjKGFqFMHCVBswuspmch?=
 =?us-ascii?Q?eZiZy6JWM6ptYRhDp9W6edCUuHPi52HTgOqGgGmmbnrz2WNTuiEKhout03qo?=
 =?us-ascii?Q?xjrrJezIR1sqBti6dqlwE5aSPDzLiIK49NR0PexuWEuW5ObX/OoFMONynMe3?=
 =?us-ascii?Q?vJfBpjpiDmaUiCxyhpYfl2ikw4V//prWkuCGoZS5F6fas18cKYEcC6n7L1ae?=
 =?us-ascii?Q?XsuPJ98FNgV5jLnwbxD72LABuOa9X6IMiGi6U64pR++agRR1f9mUPDWV3+Fz?=
 =?us-ascii?Q?o6dCe/coTPlZXLf/ZL7pRAJzIG3JMjmKPCOo67w0geMRky2ENBzU+jIoWtB5?=
 =?us-ascii?Q?MOYM+rCLT0xMdrW5Y9MGvh/JQHrQsMm3aDjynZJrKDxkZ6pS7YiPTChkIzIG?=
 =?us-ascii?Q?V/dYPiVkVeHZ9m69CkUMoeKXiKd2a1YUkJEU8XE4CDxqYMRKQ6CT6UvKbWqS?=
 =?us-ascii?Q?30O13U2kZf3Eh6c+EJOjW5YptrdBJeQA2VCirMdm06WwklktvHrrJxXQ41Xw?=
 =?us-ascii?Q?DWGZP7ssEOIsSKApikOrhOJ6XtKlKW2706H1B9C3lV8zWvZxyxs0esdxkPgS?=
 =?us-ascii?Q?bv6oOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 08:55:45.4055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f8f7fc-24ab-4bf5-adc6-08de5a5d323d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5829
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.35 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41352-lists,linux-pm=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axis.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,axis.com:email,axis.com:dkim,axis.com:mid];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3374E72C60
X-Rspamd-Action: no action

Instead of handling the registration manually, use the automatic
`devres` variant `devm_power_supply_register()`. This is less error
prone and cleaner.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/wm97xx_battery.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index c30c347b48f99..a6c55b1e02863 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -223,7 +223,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	bat_psy_desc.properties = prop;
 	bat_psy_desc.num_properties = props;
 
-	bat_psy = power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
+	bat_psy = devm_power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
 	if (IS_ERR(bat_psy))
 		return PTR_ERR(bat_psy);
 
@@ -232,19 +232,12 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	if (charge_gpiod) {
 		ret = request_irq(gpiod_to_irq(charge_gpiod), wm97xx_chrg_irq,
 				  0, "AC Detect", dev);
-		if (ret) {
-			dev_err_probe(&dev->dev, ret,
-				      "failed to request GPIO irq\n");
-			goto unregister;
-		}
+		if (ret)
+			return dev_err_probe(&dev->dev, ret,
+					     "failed to request GPIO irq\n");
 	}
 
 	return 0;
-
-unregister:
-	power_supply_unregister(bat_psy);
-
-	return ret;
 }
 
 static void wm97xx_bat_remove(struct platform_device *dev)
@@ -252,7 +245,6 @@ static void wm97xx_bat_remove(struct platform_device *dev)
 	if (charge_gpiod)
 		free_irq(gpiod_to_irq(charge_gpiod), dev);
 	cancel_work_sync(&bat_work);
-	power_supply_unregister(bat_psy);
 }
 
 static struct platform_driver wm97xx_bat_driver = {
-- 
2.39.5


