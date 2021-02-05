Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8671E31059B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 08:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBEHLy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 02:11:54 -0500
Received: from mail-eopbgr50113.outbound.protection.outlook.com ([40.107.5.113]:10918
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231144AbhBEHLG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 02:11:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5DVDvyIeMTis5V37RR0ZlQxDa3qom/8yQEWCdbEX11OidvBKgWPBBZKY4HxickjR7ImOETWizLWCwd6ePpB52px/fqUtiozjsH+xXI0c44TYXe+hhSzPbSFkydLTEnRqnHgfyzG6ZVPiP6bhQZgnuNeBhmaalceruY6yjDbWLO5MF4Ag+tade7bhEgf1Pd0zi6Nq+Ksi+6d/AYRSQVIzhcsy2qnu9GrtaPG6Of//wx+RdJkMBBmfS2S21ZrtEklI9PTEW5shBlJ+1zoSinJpPcT9HsBp29AeY10s+BqsakcHxiIZleK8WwEDioNi1gHWQcMl03U7aeLE3zPV96Pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGFG4hj3UyIS5K5V7leE41pEt3J5EQEx6BogS1e7uQ=;
 b=j/AwKFdBc7ZgFo9F1ck/BrAyp1UFVm8ueEC0uBWl6xEiy4HfvY5ht0sIN3ge+7MnPA9cslg1CiT/y5SdTSU2mXyNHgqAPx8jcEpNJtOTqzQzL2BplaxEd3dbw/Fv0EgEYyiOY63g8toOIo3s2cA4EzfS0CWO13cdQRjMRJC5ZyYJnMaswjzTBWlva8zoFyy2sWkoFCYIpAC6mjFscyePxvPZtr8/Mele4rwNOso3nfjQf38/++RzlCSML5MRWYuyHLeSOPvW5Yts3rTXRTb7KSJ6kWs8COvovZ1NqpzzGrkIw2vT5Zo1j6N72JmyeToB2bMC7A0c6Y7oYAGcpFia8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JGFG4hj3UyIS5K5V7leE41pEt3J5EQEx6BogS1e7uQ=;
 b=gdMlIv1Q6jONZ9iuRvlofN6YqViCqaF/iAwyrYyLiaZAP+BzbBBmvdfh7PLdBB3+/3ATWZ6/RhwVo8l2vNVfHSjPLU3iSQDoWr0/YSH2FeF8XtlwJeK1EMLUjABuLksoiLZBnfqYqdT1BvMHgQbkWzZ1Vl8YCADP999+8JO6HCo=
Received: from AM6P194CA0082.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::23)
 by AM6PR06MB5095.eurprd06.prod.outlook.com (2603:10a6:20b:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 5 Feb
 2021 07:10:14 +0000
Received: from AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::75) by AM6P194CA0082.outlook.office365.com
 (2603:10a6:209:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Fri, 5 Feb 2021 07:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 AM5EUR02FT033.mail.protection.outlook.com (10.152.8.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Fri, 5 Feb 2021 07:10:13 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, dmurphy@ti.com,
        pali@kernel.org, krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Date:   Fri,  5 Feb 2021 07:10:04 +0000
Message-Id: <20210205071004.26317-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9f9bd80e-6c4c-48b2-1f02-08d8c9a5158b
X-MS-TrafficTypeDiagnostic: AM6PR06MB5095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB5095202BF18BD581F3BC4688D7B29@AM6PR06MB5095.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LvdE1ydfKFKZ924uWlIP1KG1luurVGlMU33zq/+bn+xFK2SSNaeZuG81JveddimFpqcnk4RpXcAL6tiCOEKjajchoiIF0yumjhUDBwEreALKzC2w/ABMoR+4TARHMzmnhyvJPWmZU3CXavI2M3lJyQEbohEaeG6TkR+47ULnCaOIjyfecyuCVXzQV1byqiqwXfnjqjRZTqF6qbkcQujA7LLIXNb+wYPq2tuUdHAU0l6kEW7yYGfeU9T4or7v+ugqBXxUi96hymaA4QCR+gixSiQj+rpLt2E7jaYPXHVfJx3UW2ryJSY1ZGRD3acCzqSMB7oeN83mPeCZscqZEL4z5nLv8yczywAvPx0FXH0iHic2Mr5jzO4/s8DKYSBNmgya0R1sfq1dFra1d/Czxg1oxuatst3FXmvI5AIoDOfzm8uJHer/VsuOmsUr/6/3fl5kziwv/ZciRfSPlH6ZjySGMXBEc90Ctzva95+Z62laHsx5x+tNcjJ+ZYYcc1xCURSqqVi1C6c2VSx0yivci6QZztKsMs3fIm4JviiiiDi11H7W3/H1OV9BPsRVi/nmEZzXqFf1v+s0Rw330Kdolc6EkhKzuflu5ZNc+Yr0LTajLqcjiNoTfl8mtHTig2NBLCZrzdLnL7+AHnqeyvbJNSuMtfFik2CNd4A2p4ik2QbLppPmJXvyvjMOVSn4eqAjASLyL/VOCsBpttt4Lm26YOujDuhOufADWE3r1G6mr462+kC07kOdCMqy1E4UwkhUNiz9wmwjmbZEC4sxTqCno2x3Q==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(36736006)(107886003)(6486002)(316002)(36756003)(118246002)(356005)(5660300002)(34020700004)(2906002)(47076005)(26005)(82310400003)(8676002)(8936002)(4326008)(86362001)(336012)(36860700001)(186003)(83380400001)(6512007)(81166007)(1076003)(6506007)(70586007)(478600001)(70206006)(6666004)(956004)(2616005)(82740400003)(966005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 07:10:13.8972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9bd80e-6c4c-48b2-1f02-08d8c9a5158b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT033.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5095
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for TI BQ78Z100, I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

The patch was tested with BQ78Z100 equipment.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/power/supply/bq27xxx_battery.c     | 46 +++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 315e0909e6a4..c8579ec7a4f8 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -39,6 +39,7 @@
  * https://www.ti.com/product/bq27z561
  * https://www.ti.com/product/bq28z610
  * https://www.ti.com/product/bq34z100-g1
+ * https://www.ti.com/product/bq78z100
  */
 
 #include <linux/device.h>
@@ -497,7 +498,27 @@ static u8
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
-	};
+	},
+	bq78z100_regs[BQ27XXX_REG_MAX] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x28,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = 0x18,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = 0x22,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x22,
+		BQ27XXX_DM_REG_ROWS,
+};
 
 static enum power_supply_property bq27000_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -792,6 +813,27 @@ static enum power_supply_property bq34z100_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq78z100_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 struct bq27xxx_dm_reg {
 	u8 subclass_id;
 	u8 offset;
@@ -890,6 +932,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #define bq27z561_dm_regs 0
 #define bq28z610_dm_regs 0
 #define bq34z100_dm_regs 0
+#define bq78z100_dm_regs 0
 
 #define BQ27XXX_O_ZERO		BIT(0)
 #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
@@ -948,6 +991,7 @@ static struct {
 	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
 	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
 							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
+	[BQ78Z100]  = BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index eb4f4284982f..46f078350fd3 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -248,6 +248,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27z561", BQ27Z561 },
 	{ "bq28z610", BQ28Z610 },
 	{ "bq34z100", BQ34Z100 },
+	{ "bq78z100", BQ78Z100 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
@@ -284,6 +285,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27z561" },
 	{ .compatible = "ti,bq28z610" },
 	{ .compatible = "ti,bq34z100" },
+	{ .compatible = "ti,bq78z100" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 111a40d0d3d5..ac17618043b1 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -33,6 +33,7 @@ enum bq27xxx_chip {
 	BQ27Z561,
 	BQ28Z610,
 	BQ34Z100,
+	BQ78Z100,
 };
 
 struct bq27xxx_device_info;
-- 
2.17.1

