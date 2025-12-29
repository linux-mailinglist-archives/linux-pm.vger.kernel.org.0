Return-Path: <linux-pm+bounces-40007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ACDCE645A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 09:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E563010993
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC0527FD7C;
	Mon, 29 Dec 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="wWx6UFfU"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564F2765C4;
	Mon, 29 Dec 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766998605; cv=fail; b=ahdo8nEzkJXF4+p2okSugSKLmkM0Ux0ftbRDckGmRRKwXf9B3nTmqgUFvfJ1HPk2rAffrBOd2FtIK4F+lGSXXLnuQ75TPcYTc3xsWYvRsmtCyIVVd7QlpoaBwNliC000sfi8kP7UaJNGpJO5rQYgKguOblPBRJ3Ms1t8q435KFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766998605; c=relaxed/simple;
	bh=BElNyy/fdh7ccJ5R+OlzNe27kwMkxJ8M+rTSNnTvWNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNr8EtAL0qVeDBB3JKTTjeYLWaEBVEOouu3MJaupyX0i9yTAH7U8rD5IHlKkHtmFjd+AjYH6sxvQXLHwJ0b9g6m65eLoRLG9XBm9ghoHmrooQQMXnzYuZwCEwj/a6yxpAj7fqLcxxkRM+1ijpkzYiI1mfy5XTnLfe0uOwNkiRno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=wWx6UFfU; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IozAtrJl1fu1QIMLA6UzDCYTYu6e4XTKmrxI8tuofCLyTcTDd8OeOg2MH2MUIWAAIG9cZ+h79sv8+KsMpdSVtlL/xfyWAcqlsfKkpwtbhqk/fT/J9h6WT5ese6RCoHdFF6PZ2yih/sEUo2VC84cwZcwvMiRrv6w9jEQt9/Mh6oBn9LeI7juQG5wgPsyxpnE2nNMBVIWcRXhkBonyQ0x+PiEf0qGQeVOCT3JzWY0fClX/iViINc5b5/DhFYEwdKeiCn9JdTkgcDMwzplCIDe7KMDgDTx2SS1mJr7ogdIMy4dGXTs59vNVH8I5GmAYkG5fGM9pzXN5IX0r4vv70t1wZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrxGT//E0c8ssNV3NBmi+E50TVCiFLCpyveZ/wCEgFg=;
 b=lpaxJXFZWdTN5gyX1Q+6kkXBSP/ViT1MoiNFMv/Yha+WSVuVc8Y2kHqjGCjDGJjJrPAf5587QEAKYQERiz20Hc4NOpW1MF0iNxOPyB5vpKrg/iKzqnOhG4pEjTaj0EvWJslOSxGovprS9uQlAlF5MR+n7vMJKwV/MYQjy5300NG9C42pKu7BZ6hkm3YexhWYOB4Ujjw05IIpePN6nis2zTq36rUULsJe1m0CBX5GVgB3xmC5YW0vlu51vgWuyGxCcHN3/Z9l8QFJvLJZ5aJuotQrpEvOX+1MkPIMrHeZ2mmJgk4gex9H72SC6g8906Uv3wnRFaKXkqCnEgdUBiZ5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrxGT//E0c8ssNV3NBmi+E50TVCiFLCpyveZ/wCEgFg=;
 b=wWx6UFfUJuQ0u6hd1BGYcuMbxQ+EiIgOLqUop9UX1AhTeDoUpKPB1PCaJoJ0VRlSPS49tZcy4Xp1YNO+SBihaaWGkvqGFC5j6uGTGxqXoj7QfU06t39pI+FokX6Su7dxLhmxu+1lOsVCSJlGXVeG158F79ER2AqvZPzdGv8iukc=
Received: from DU2PR04CA0225.eurprd04.prod.outlook.com (2603:10a6:10:2b1::20)
 by DU4PR06MB10096.eurprd06.prod.outlook.com (2603:10a6:10:5d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Mon, 29 Dec
 2025 08:56:40 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::d8) by DU2PR04CA0225.outlook.office365.com
 (2603:10a6:10:2b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 08:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 29 Dec 2025 08:56:40 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 29 Dec 2025 09:56:38 +0100
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 3/3] power: supply: sbs-battery: Add optional status monitoring
Date: Mon, 29 Dec 2025 08:56:36 +0000
Message-ID: <20251229085636.4082852-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Dec 2025 08:56:38.0347 (UTC) FILETIME=[0AF999B0:01DC78A1]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|DU4PR06MB10096:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 326f7b3e-dd49-4bfb-03e8-08de46b82eab
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iSF+dBPClVeYhGgCB3Shw1BK3VWFPIcaJnC8GLlDogFigZKKe3zOaqXkGVf8?=
 =?us-ascii?Q?TxhPef0HexwfuvVnDm3gQabmQnRA26eqoOuyD4G+5G9Alz1X+LgvW5sitG/B?=
 =?us-ascii?Q?CWJ66KWXhSHlCcIw48GepUvhaI9ZroDwV4DyejfVTJl4ya/Kzn1VH4DIHQfU?=
 =?us-ascii?Q?0kDR/mZ6qLPnHaqVxMQSGrCYdvwLxBi7X6KjikMukjT/7jJXgDn/RJ7O5qGn?=
 =?us-ascii?Q?r67rXp39JOhnZI2bdZgfbsLtxVa/W4gVFFuNHIpEsZw3UEfWQZSFOZTGvffq?=
 =?us-ascii?Q?TIor9+grOu570jhsT0plLrcYP/u1ToaaQryBQqOwy8X9nTtav6abhvzy10Jq?=
 =?us-ascii?Q?SwW5saS/LUTBpWVSQgenehIIFkfC2zUPXRCYSKGMq7SPq2CZJdFqgQfgGUy4?=
 =?us-ascii?Q?Tt+g/zYi2Wm7g8GITW6HmGi9J92yUcDmcFvxP1zy9uddPTOAWq2jv9dzk3Kl?=
 =?us-ascii?Q?jWvwS8cVpBg1ij8TXaZgujm+kLHPxKZOUtQ89xxRm0dQj5PFcE0ZuRewcJ/t?=
 =?us-ascii?Q?479YFJzyKj65ktsraO+kv6uUta9FmUIxCUFUIwwuvqu8U46bfPqnkVFhsF+/?=
 =?us-ascii?Q?VkktU0R22Yp54Vew1SoDq+/+ztwJ07ppVXvlFRWTqoM5XJRylxW9fe3NUAFU?=
 =?us-ascii?Q?MpjiL2u/29n3sJ/V7qYx5teW+9y8xEoHzSxso06/xgSrbUgy4N4MCb3b/+mr?=
 =?us-ascii?Q?UAnpY0x3QmtcWwmQe+SaMCJt1tSGfmjGlx7DYxrSTxXtmrXWxHgpdVWaN57Z?=
 =?us-ascii?Q?Wm5dKnjE+axaKMZn00nDv17Ch/0vDFOzXLVpck0VyBkRKP9MXRLx1fUnYiaQ?=
 =?us-ascii?Q?UHvLtUfICTkWM+VVse2g2NC/4xWH3fG4WCIA9AdFM0pqvfg/xNwM0h8uLrGV?=
 =?us-ascii?Q?T/D4S6HMnNZ6WUS6HtFXHH+9choz/RT+eTVVCzigBJxWAmL7cVjj8hqifWEv?=
 =?us-ascii?Q?s7b4QAXy7yAivSJaXRT4ilyP/WAIRO77rO+mzLg1lGVHCttKiKSvbljRzK4q?=
 =?us-ascii?Q?CJB7KpZ+Ohx26hIxL22P/e9SAZX+PdIJVP5Cb5kKqQTKeeuqyQgmIxeiO2SO?=
 =?us-ascii?Q?Y90ppXygGd0WicdSJrt0nCwqnJw3winj7C4EkN9SyiZdWGZsZPFnax/d9mje?=
 =?us-ascii?Q?5pAGIALOxr6IGpf8jsa95koPKFAF9x8V3IP2rYHYEgrjpI+muaGUkGZlUx4T?=
 =?us-ascii?Q?CNcWOZLugkS6wg7ZeDtaFhMIq9NjciCLi/Dw/wWpx2ZEw0H+1rIxj2xO4kqV?=
 =?us-ascii?Q?FbmqeyhBvvO1Nql+HYQinIOHgIslM2kjedMuPyQ8WvdKI4T3d04w3c1l9rsl?=
 =?us-ascii?Q?OmkckyqPMRbf+3V8yMpVCQYBhsyoJv8T9Aj2KNvARNUaVG2C7FiIwXkzpShy?=
 =?us-ascii?Q?/Atd19JlPto36/QbDLgvk4bXaJnC20oZL5jVo+fZbVigMunvOlQiGJYqIj1b?=
 =?us-ascii?Q?wpiEIpmbCFhKCv8SPrEp/WJxja5KVyfdF3Z1fr8ghkhvUe81aXvg1KH3zJP/?=
 =?us-ascii?Q?0iElt/ciyo0nHNj/ApViyESKEN/1Aztzet7IHWLGvUhRB7xC48zZmNtuZ6jV?=
 =?us-ascii?Q?fsdRnu5p3zoMooVy/tw=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 08:56:40.2639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326f7b3e-dd49-4bfb-03e8-08de46b82eab
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10096

Some systems do not have GPIO interrupt support for battery detection.
Without GPIO IRQ or SMBus Alert, the driver cannot proactively report
battery status changes.

Add an optional "sbs,monitoring-interval-ms" device property to enable
periodic status checks. When set, the driver polls the SBS status
register at the given interval and calls power_supply_changed() if the
battery state changes.

If a GPIO IRQ is successfully registered, monitoring is automatically
disabled since interrupt-based detection is preferred.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/power/supply/sbs-battery.c | 50 ++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 9537b692f9fd..2874a741c809 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -214,6 +214,7 @@ struct sbs_info {
 	u32				poll_retry_count;
 	struct delayed_work		work;
 	struct mutex			mode_lock;
+	u32				monitoring_interval_ms;
 	u32				flags;
 	int				technology;
 	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
@@ -1089,21 +1090,27 @@ static void sbs_delayed_work(struct work_struct *work)
 	/* if the read failed, give up on this work */
 	if (ret < 0) {
 		chip->poll_time = 0;
-		return;
-	}
-
-	if (ret & BATTERY_FULL_CHARGED)
-		ret = POWER_SUPPLY_STATUS_FULL;
-	else if (ret & BATTERY_DISCHARGING)
-		ret = POWER_SUPPLY_STATUS_DISCHARGING;
-	else
-		ret = POWER_SUPPLY_STATUS_CHARGING;
+		if (!chip->monitoring_interval_ms)
+			return;
+	} else {
+		if (ret & BATTERY_FULL_CHARGED)
+			ret = POWER_SUPPLY_STATUS_FULL;
+		else if (ret & BATTERY_DISCHARGING)
+			ret = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			ret = POWER_SUPPLY_STATUS_CHARGING;
 
-	sbs_status_correct(chip->client, &ret);
+		sbs_status_correct(chip->client, &ret);
 
-	if (chip->last_state != ret) {
-		chip->poll_time = 0;
-		power_supply_changed(chip->power_supply);
+		if (chip->last_state != ret) {
+			chip->poll_time = 0;
+			power_supply_changed(chip->power_supply);
+		}
+	}
+	if (chip->monitoring_interval_ms) {
+		schedule_delayed_work(
+			&chip->work,
+			msecs_to_jiffies(chip->monitoring_interval_ms));
 		return;
 	}
 	if (chip->poll_time > 0) {
@@ -1171,6 +1178,13 @@ static int sbs_probe(struct i2c_client *client)
 	}
 	chip->i2c_retry_count = chip->i2c_retry_count + 1;
 
+	rc = device_property_read_u32(&client->dev, "sbs,monitoring-interval-ms",
+				      &chip->monitoring_interval_ms);
+	if (rc)
+		chip->monitoring_interval_ms = 0;
+	if (chip->monitoring_interval_ms)
+		force_load = true;
+
 	chip->charger_broadcasts = !device_property_read_bool(&client->dev,
 					"sbs,disable-charger-broadcasts");
 
@@ -1198,6 +1212,11 @@ static int sbs_probe(struct i2c_client *client)
 		dev_warn(&client->dev, "Failed to request irq: %d\n", rc);
 		goto skip_gpio;
 	}
+	if (chip->monitoring_interval_ms) {
+		dev_info(&client->dev,
+			 "GPIO IRQ registered, monitoring disabled\n");
+		chip->monitoring_interval_ms = 0;
+	}
 
 skip_gpio:
 	/*
@@ -1228,6 +1247,11 @@ static int sbs_probe(struct i2c_client *client)
 	dev_info(&client->dev,
 		"%s: battery gas gauge device registered\n", client->name);
 
+	if (chip->monitoring_interval_ms > 0)
+		schedule_delayed_work(
+			&chip->work,
+			msecs_to_jiffies(chip->monitoring_interval_ms));
+
 	return 0;
 }
 
-- 
2.43.0


