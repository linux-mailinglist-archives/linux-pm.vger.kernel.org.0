Return-Path: <linux-pm+bounces-39754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF553CD385D
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E950E3002FCD
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20EA305057;
	Sat, 20 Dec 2025 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Hlp6XmdS"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFE30216D;
	Sat, 20 Dec 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270178; cv=fail; b=iI7qlFvrIyQPXFAf5cREbiSMPsgJE1ivJ547GE/MRz/IpuLUxvOQkaZyhQQiXlQKjG5JBeuAHZYWPpFgESneNWTSmJc4gf4vhYtRgjjtJ+HPKFcqka2/MfmJYvJZfXvenJRXE2aHV0DT1xd2kFsCGys7SbPG/VSdIVKsTczOKrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270178; c=relaxed/simple;
	bh=9eZJDRmKjcHFQyjatkxVXVx0kSyii9XvQ1KvBzJZ8Bk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=HExDjO3hBIsVecuuuehSH+b65O6MX10iuZhJJzQyO2pLpoHkbxHN2/T17yT/S2cCqRJMXp8oeEHVtTX+OMHPNj9S7z4kolRfaBXk3DMZhoekloeusyR06AzbQUp12CNMzSHCkixTLSUGc5QEYh3NcUrpxEwIbbaa4MHvzuLg++4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Hlp6XmdS; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIpGqJ+/DWsaXiMDsRJgqV6gLAgu7VxXwF7BoJ3g74qZcZJQbCbfcYQ+g78BICnPY8LirNy9lX5lZw6Y0WZpRlFYVkeY/9I4Aw+ox+OeRvlMz11sQHyQ7+ABwIGTiAqmtrbHkys8GPTSOIBccIdfMGBLuiRt3HNSr3bvb/w7ixJv770V4UxGZ7sN+lE3LhIuoB4Slj7q4ftfqVx9c0NLluOgyZyD+B40s8+N61DvJtddbXLx2tQPc1DzuH6N8vjcjVIY4aU0QKXrtUoITqwTWu8ETqNKsFLIN+hXVT5rKnH686+thT2dBHYt4Jx1ZKZHN73C+PvxVfQ9kpTe95502A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKN/y/4HZEGhxalWNMzhrrbUAgqlQ+sqNeyCp92bNvQ=;
 b=UoVXlGEyqREM2tktPXgawaKYwFeeM6jUMp0lBknwAX/RO9bGqytY7b4o5esykrG7gKxSdNsiE0jrIbLjRGOzwCfdWjWDKaZ8+sADgY+i/42kPo1IQwZ3bykDgkmMcaovAnUQX1HvyR0Wz9mldeoDW22okMDjQ32mL6uvU/YGA70bDoEUAW8JagKEq/BwMirvNUkWYOcpUrFofgQGz+u8bBqs1Jp2RpjZgyozSJ5Hf4Qst2yeAkPx6nF7jgYJWDAaZgqzv2mmUsahe3rgRWVP9sD/7kuvQPT44xNG+RPhU/ijeYYeBko+hR6oEuRI2V7irDZrnrON9zq1G7lbYMK8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKN/y/4HZEGhxalWNMzhrrbUAgqlQ+sqNeyCp92bNvQ=;
 b=Hlp6XmdSh7PR1px8qTlPvjRWxURh+v83RpLuw8K5VoDQwRNgmO7JGLrImeaawqvovAcWZxT2D1flBmIC7cJrFR2zK5yln2u2mSy78u8/hKGX4VBGzmdz+7Vyl6GvvZPK7qKdpHCGBev3W2zAePv1o9yuYQq49dhBE5ur1LcdNug=
Received: from DUZPR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::10) by GV4PR02MB11208.eurprd02.prod.outlook.com
 (2603:10a6:150:297::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 22:36:09 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::10) by DUZPR01CA0097.outlook.office365.com
 (2603:10a6:10:4bb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:08 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:02 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] power: supply: rt9455: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <1567d831e04c3e2fcb9e18dd36b7bcba4634581a.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:36:02 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|GV4PR02MB11208:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f108994-c88f-46c8-f4b4-08de40182bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FK7ymwGXP9PVFKS2en6oXAzowpT1JmkQDSOYGbPv83CqVQyKG1s6ZH8kHOg8?=
 =?us-ascii?Q?iIvi8LPmKn94WcZwamEhqhI6SxA4IyAwOPBPHI/5w90j03dgCds5adVJj3Rg?=
 =?us-ascii?Q?mtgDkqLHdqmaLnRVYWZNgnHqumuCqDA5hLhd2n21gRg2dfXE+sIuzLoqavkf?=
 =?us-ascii?Q?n2W2tuLnAEKpdaaKUQ3VLSwUvjsvZeyP7dEse7B0Hr9m/2QtnXPZB2/dSUlG?=
 =?us-ascii?Q?7M7YauNokZoOrBqk4xzqYJDNxEmvZgIsNsUv/wnSOk5TwzW9Y65hFAJOGRt1?=
 =?us-ascii?Q?JpkIs7Q//5mrozcWV1MuW5hwvj59ReZpZunsZ55tPCm09SuIoOAKX4cv2kvN?=
 =?us-ascii?Q?TrRdKZCBairiNits7QUGBWUeshkW+CK9HGE3KbVNTlTjCETqowLj5rxd6+6v?=
 =?us-ascii?Q?PvQ9ndZ/mcynwJHTsOUyo57jHull95DOGogRe6QFtW3OkHsNEN9Luw8rFDaG?=
 =?us-ascii?Q?/eVxN4pdEaEn44NKGqbNheWBBilEpVoTr1UL2X8gEwYN+/Tt7metTWZzRvRA?=
 =?us-ascii?Q?C2Q/gdqSdi/t8RS32QpLq4Lna1ptxmBjPqjifMEN9dAevLfXJDop2skHvE8F?=
 =?us-ascii?Q?RnbUyD3edFw4L6C1+UuM6EWlyIdwRIHGMScXmitkpdXf6PwoQt6C4j61I/AX?=
 =?us-ascii?Q?x+eAcrrZssTnhh+d36D3Q7OZ/Ll9btI4CRb2VU4VrGWPZzuSjbiw26Sd51aX?=
 =?us-ascii?Q?LREt2QDQXu+j4RfFXK9zVw5wlCKvQOXS/dzgLAoRtWyWj6+WTrNfaff9yOlg?=
 =?us-ascii?Q?umnZm6QdiuN9q0MLDWe2Z/EQEaOpkK6Bu6mwS1j8Q5ZQTp/WZCUyL7QuYdr7?=
 =?us-ascii?Q?xWmdTq+HIL1H+2kjF9GdrWEkhKlMVAfntx3Een5qjx3OlWf0wkRYd5WO1JPw?=
 =?us-ascii?Q?qFW1zHgHddHBz7mJ6XbiUpCNHcdZOqIGlR4t+06BwCWbYT8+bXH9/BudxHpd?=
 =?us-ascii?Q?PnSLsU/o8m/Ymqo24LSEJlIwpNXlljZG1PcuwsAWXi6wiEsgJ0VAFZKTCQXy?=
 =?us-ascii?Q?sb3nCLQLZ/bF+lk/PVDVFLG3e7Yt3+XpmRg0B32CvkPFiKAAF2hSyRWFxZvJ?=
 =?us-ascii?Q?r1EX4WajDXHB+I++MirpJxwwkKghCF4r9qKIY+/b7diA8AdZAlzqVOB5VZzh?=
 =?us-ascii?Q?J4t8NWEGNPZ7lTFA9GmgvMIT5VkCsZxhq6cRP335Gy6We29BOmixUYzvf144?=
 =?us-ascii?Q?EZpuH0b7L441+bI+9b5sZUiwDv2G336Iv5nA6PM32sWEJRMZW8AxN/Y6p3XQ?=
 =?us-ascii?Q?yakdaXS41A3YssTnjwIDPHTiTaCXvAI+C9buA6qVNEm7uZDqRbxktHBo9f9I?=
 =?us-ascii?Q?0AsJPQajBFG+6RKpYhgthE7ZfMbXkVApsm+zjPI8c/3QB7ADTqdrb6aBQhWX?=
 =?us-ascii?Q?abCyWAx3jT22e9YzaTbtZiA2+RofP/eRCfxA396GUST7UQEoA3+7ytdslBQo?=
 =?us-ascii?Q?3911gFK/83KuqJeL3km2p5Th5nV+DnfbdbsoCEGS3hJpmhyHT+G25/bPwKL2?=
 =?us-ascii?Q?D+VPz+XwJraWH++cyVUTvn6EYKVc83Cy+cmDznaX8Cga80Im1YxibGEMii15?=
 =?us-ascii?Q?VjMcKZ/+VpcF+rU0VLY=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:08.9870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f108994-c88f-46c8-f4b4-08de40182bbc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR02MB11208

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

Fixes: e86d69dd786e ("power_supply: Add support for Richtek RT9455 battery charger")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/rt9455_charger.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 1ffe7f02932f6..5130d2395e88f 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1663,6 +1663,15 @@ static int rt9455_probe(struct i2c_client *client)
 	rt9455_charger_config.supplied_to	= rt9455_charger_supplied_to;
 	rt9455_charger_config.num_supplicants	=
 					ARRAY_SIZE(rt9455_charger_supplied_to);
+
+	info->charger = devm_power_supply_register(dev, &rt9455_charger_desc,
+						   &rt9455_charger_config);
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Failed to register charger\n");
+		ret = PTR_ERR(info->charger);
+		goto put_usb_notifier;
+	}
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					rt9455_irq_handler_thread,
 					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
@@ -1678,14 +1687,6 @@ static int rt9455_probe(struct i2c_client *client)
 		goto put_usb_notifier;
 	}
 
-	info->charger = devm_power_supply_register(dev, &rt9455_charger_desc,
-						   &rt9455_charger_config);
-	if (IS_ERR(info->charger)) {
-		dev_err(dev, "Failed to register charger\n");
-		ret = PTR_ERR(info->charger);
-		goto put_usb_notifier;
-	}
-
 	return 0;
 
 put_usb_notifier:
-- 
2.39.5


