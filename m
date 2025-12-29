Return-Path: <linux-pm+bounces-40005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA84CE6445
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 09:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328F63005191
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B327B352;
	Mon, 29 Dec 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="PFgjl+yS"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF422A7F1;
	Mon, 29 Dec 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766998605; cv=fail; b=p4oci76p/mKTm+attyOaW/GAUjva6PdcseJeLVTcDkn8Cp0/yBHEof+wB5BRVY22qm8MlJK+yBlJCYwUUtZZHZKjEGV9o7U18eqzu2Wk68j+eiY8JctvNEDZGkTdnvMxtLgdYX6Huv78z/m6WwTIP6wD0NfgTcAlaS4umukNZFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766998605; c=relaxed/simple;
	bh=aPgGCYexThHk+ulpML3eDr34TwTthu5VkctPtq1axeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkypGEIplPM3AserzCsY3m26b6vw43akHrTfMB7k4IyMWk4I9LaFtXpUZar75VfdQKSqnRG9PkntiJCmtw7jVsrLU3D4IirRlKvXemxDRpHoX6ilyAl1YmNf6i/IuUdYE6ob6TVckI3Av8q9YiDvXF4zH13oKEREMF3DeOMUpgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=PFgjl+yS; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE7WkEn/CITvxrXLlswXRR/DIcV3DWgSp6HlrCc0rxlKNtqXcr22kdr/7Lyxj+drtpzs4KfM5WSPBHRQsvbuRadGLZEiluzhWMGPqR3zH4sCkBO/VQdLifgRXHke/REhfXGBDRUQTodSKMEP6qz3rytS7OMPMbmkkHaD8csar8QNV8OEftaLB+m195znU8UW0uhsmmd99/95OjvGWk2NYE5JLAW56VT8Uc+7IwrHGGwAT3nan49DFAW3DDrfbHQu3ChVZg6VNHAtsRVvcnjg7XYa8sMTseViEg8srAe6WCI95mQwn2VHUwJUcCbmBjDHx6bpkJxQ2ESgUmCjlFiUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwatQkvEyajAkxzBZVBu1cWEBTUTk+cULvZ1YP8uD+w=;
 b=lW6dLilUA0FXgiGvy7lfhxNeK7zvOD5wJIsHO+TSlsqp1PlGurP52nb5JqDfNhe9Fd9lkIfpq70mp0nVgfHaPe/aXsH2wVCaR79ZkuoHTES1D+IMMZe3nVPyTT8EN/RbZmEMjzDWt5PP+l0rVySMUYQD3YEYIBYSjuXMR/USkt+RFBPDtPwUS8FIY1gz8Xi0dsQqODf0cabQ6yzT+ezTBZY3pFj9HNjxve8k6Eh98EMPdHMwgBoHjUAl3jkvgrQrSW2CP+wFOGZFZ0QRE0TKlVxNbv1iZAQSZ1MsBvHhhS3fxZeve6pzrODrjoq3vabO+K3RpFYg6ryLAJk67LsrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwatQkvEyajAkxzBZVBu1cWEBTUTk+cULvZ1YP8uD+w=;
 b=PFgjl+ySzjGsuutvgCI+LR84DZHsAmCH8/+gbwia/fkQJLWed3hKP+ZYk3i2uVG3uk9qC+iV1XASpwkwvABFwgnCbRTin9UAX9jqW+1lbbs24icvK9zwJj/YTuoeX4SNfIior+NQZOehuUSSgQFGY4orfFv3oBfQPBu0kHOdqWw=
Received: from DU2PR04CA0221.eurprd04.prod.outlook.com (2603:10a6:10:2b1::16)
 by VI0PR06MB10386.eurprd06.prod.outlook.com (2603:10a6:800:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 08:56:39 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::6b) by DU2PR04CA0221.outlook.office365.com
 (2603:10a6:10:2b1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 08:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 29 Dec 2025 08:56:38 +0000
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
Subject: [PATCH V1 1/3] power: supply: sbs-battery: Fix false presence when registers read zero
Date: Mon, 29 Dec 2025 08:56:34 +0000
Message-ID: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Dec 2025 08:56:38.0285 (UTC) FILETIME=[0AF023D0:01DC78A1]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|VI0PR06MB10386:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e70835ed-debe-4942-d729-08de46b82da4
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KXZTaDncOsGb24JxOTZt9zNbqssQyJOi1HcbNIwBZaG3eiFzqcJDjyWkUIfQ?=
 =?us-ascii?Q?yp9myrIXg6FhTgnOqx8AoQuD155GfnGYj/ZI9c/qfg8DXDt4nNCI/K6dhmpf?=
 =?us-ascii?Q?WhB2TZNCq1BPc89w1PawxCBnEI+vvpkidZrdcKrGR1UiymocZ2Fz03tSl8RT?=
 =?us-ascii?Q?zKcGV44FS3HM/WMQR3DETVxdvLMUFgIRhNZtVR4b13/CYBJrxn3zu2btbjvJ?=
 =?us-ascii?Q?7AufWF6s2AUti1NO8RXURQw7XPr9Xxt7xfNCQqIwC/w101JG/hHUK2XCGy6e?=
 =?us-ascii?Q?332niZCaQO7+F09KxRpY458arySPGbHL3iQI13sifeoYxWPwr1TCXMFSyNN6?=
 =?us-ascii?Q?yj9Ijvj71NJPposMDe3K1D6Halx4Cwft5dG8OF9qyKsx/wVbyKMRnbhQPCgI?=
 =?us-ascii?Q?5hQmur8zFlH2cj0Aa7448tEp1gcrPZOLoT1hxSUrqSc4wnJS2epiCtSdV4/B?=
 =?us-ascii?Q?pFDVNzxhmtc8/Io0aXxfocglQQg+e3LXnGRmtMSfpD2wd6Fp/xNR/zQL3yGb?=
 =?us-ascii?Q?2bnEjvPweu1jz1Las2fngTg1lf3n0E4hcX29c/JUoFVlcGizGaj7ModINFsf?=
 =?us-ascii?Q?VAW34pK+o7/UneWhhXMkaGJgAqg8OOQ8OYoHJ9+wHrbD79kqHi9Jd2d4pCiR?=
 =?us-ascii?Q?jaJ3DCG6BeMjN/ry36ykmk7eG5r8wCda3i875VF+7H6wQzJx73P2pya9z3zX?=
 =?us-ascii?Q?svgIpNZfHcyVjGjqgpNMMV2tg5vh7jCOGDpQIHzxmbv0esi64QbKlUCectxn?=
 =?us-ascii?Q?cy1YSpJ2C7z4QlYjE/l46uKmRiYgWnEY/3H4mWO4fQw26XOeIfsusmBcrCv0?=
 =?us-ascii?Q?rypsmhavT85bstNO9cB/9qgEn42Dto2qqDHAtKwMWu/wNedGVql76IZROfCS?=
 =?us-ascii?Q?kyljcO1pu1iEsDrmbVyTuRYXkoxWPhdWpWDi3N/6zGjrk2S4FiNEjXa5RvdA?=
 =?us-ascii?Q?KkIuAb9FTEQUm+x5nbjiPIUSvjYOKWE+gYRTvbFxMlvr7SlCuwV+XWiv+p9U?=
 =?us-ascii?Q?zunE4GiUv7YUQP8+GZq/6BiIHOgX4XjPXoLcPQ/jxqzJxAZeyHP9RS67T9RY?=
 =?us-ascii?Q?MGj7kK1jDbfxutyjGbUxsIexNjzBDBklIhrWTvkDvvZB7IURw3gNHI3z78rQ?=
 =?us-ascii?Q?EwrL37oQhTEBu99etiBf52VbSc+Pa//+Zg9loVb6Rv2aEYJdAXeaPY/JuMC2?=
 =?us-ascii?Q?wQ6IZdCa1+At1teZAf7n921cYj7pBSGcEY4C53ilJO9v6HqWVYblS9Hi4gX6?=
 =?us-ascii?Q?6goBuJvckH2LjIZ0/RhRmFXUe1ZfOXJTl2yLvkjS4cNaCqlt6WyoLvi+UHwT?=
 =?us-ascii?Q?g/zZ7dtdJlPDqZ63sBXsFLpVtwmbuymo9PduRfOkwTdyzD3BGSulv7uceENL?=
 =?us-ascii?Q?MGOvJ+sRb4nWixtfV22H7xgzpFadWMW5gn+aVchOt8A0ofphh/+5KriVFE9H?=
 =?us-ascii?Q?2EG2SUgM7s11sSv90QMb3AX95nS8itgJXchAZCflUAimVhaaLbouVR2AtZoT?=
 =?us-ascii?Q?twHxrIODnMJafcvJlT1mjtLtqnWdXZj6rNuImE1WjF+szkbZkRCD45SHEkHT?=
 =?us-ascii?Q?OTglOu/5o75N/GwPrB0=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 08:56:38.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70835ed-debe-4942-d729-08de46b82da4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB10386

Some platforms return zero for all SBS battery registers when the
battery is physically absent, instead of failing with an I2C error.
This causes the driver to incorrectly report the battery as present.

Add a sanity check: when the status register returns zero, also read
voltage and capacity. Only report the battery as present if at least
one of these is non-zero. This prevents false-positive detection on
systems where unpopulated battery slots return all-zero values.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/power/supply/sbs-battery.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 943c82ee978f..9537b692f9fd 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -594,9 +594,17 @@ static int sbs_get_battery_presence_and_health(
 		return ret;
 	}
 
-	if (psp == POWER_SUPPLY_PROP_PRESENT)
+	if (psp == POWER_SUPPLY_PROP_PRESENT) {
 		val->intval = 1; /* battery present */
-	else { /* POWER_SUPPLY_PROP_HEALTH */
+		if (ret == 0) {
+			int voltage = sbs_read_word_data(
+				client, sbs_data[REG_VOLTAGE].addr);
+			int capacity = sbs_read_word_data(
+				client, sbs_data[REG_CAPACITY].addr);
+			if ((voltage == 0) && (capacity == 0))
+				val->intval = 0;
+		}
+	} else { /* POWER_SUPPLY_PROP_HEALTH */
 		if (sbs_bat_needs_calibration(client)) {
 			val->intval = POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
 		} else {
-- 
2.43.0


