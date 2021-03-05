Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4462532E284
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 07:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCEGuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 01:50:04 -0500
Received: from mail-am6eur05on2112.outbound.protection.outlook.com ([40.107.22.112]:50529
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229552AbhCEGuD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 01:50:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecuL6yRGxCbi1XXZIJjHmurYszMQsoIcH1oFdrKlXXTjv6sKnLw0xB78Je5ncgDtEfDamxCzxvc/WudBpet57R77l5/MfGSpLpSX0UxV8QIr8xKB5ozi09tE5s+aM61aoP1mU9MIUbdaUeGU86LjwOjETA0vvqsOX1D0i0VLHPDBjnQqwe/M4XoXnizntqkHjJ8gxc086wlP5IRSmwNnWMZ/mgl/xEAnfvBmUnmaY53EFVPklla6TNYBYZ3wK1j8X3U197KxiM8JD4fXBudjHIIx09cwYghQ17NBaCuvzFD/agQxefVM6OnNZd1pS6X1bWOAEeGyIMBPo2OVPSZP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V79pWocA1uCjldcYkDGTm9KWV15CrgZamZOa3zdwiCE=;
 b=NOQGCMEeOnwrfgqHfeey3K4ftRohCbxjY60HcxQV6ASQWcmkEQ/5R5duI+1Y6nUZmum8MDt2upvqYOpagHvMHaX2VjdLav93ChojnXlcGo6UOHTgK93RWrU7acaStkBem7zJIt1TpkzkmuRGAhQQATY2tisBV/oa0m/VJWtJ7c+mAirED9l0I2Bbj0nnttGQY6strG82X6smcqOPAqPBCWxQd4lESZclvug/w3+mA/34sD38zKtyqLbnGdh6yTVNtLN07VRgv0DnVf4Cf1k8oP0UlSTk0+g8aQ5cgguaiByLanwCJA+oggAKhv9dNzkPpfFtQHOZI2Ex4RkqQOoh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V79pWocA1uCjldcYkDGTm9KWV15CrgZamZOa3zdwiCE=;
 b=Um3YyZW8yHpNkHrCZChmYWWxpon6PLYde97q4yK5cVaSgxSatDT/MAWwDMOQEg9/wiay3zvsiGXr+uV58wijTdudTFcAjEH1FZTCoxd59RGl7/gp2myiR6qgAHROp5tIPw2eAny8xHKp7FV9AktqKHtxwxyHcbF7pFQu2jPO/AY=
Received: from AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15)
 by AM0PR06MB5906.eurprd06.prod.outlook.com (2603:10a6:208:117::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 06:50:00 +0000
Received: from HE1EUR02FT024.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:17c:cafe::95) by AM0PR10CA0005.outlook.office365.com
 (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 06:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 HE1EUR02FT024.mail.protection.outlook.com (10.152.10.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 06:50:00 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, afd@ti.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.reichel@collabora.com
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V5 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Date:   Fri,  5 Mar 2021 06:49:49 +0000
Message-Id: <20210305064949.2680-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210305064949.2680-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09903a6d-6e0d-46b6-9f7c-08d8dfa2e5bd
X-MS-TrafficTypeDiagnostic: AM0PR06MB5906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR06MB5906955D0D445433F0883D33D7969@AM0PR06MB5906.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43i3Ih4ElsnzeYhQj/qVTQgZDJY70Fk605Vh6MdStQ1erDKoZ7i9p9TV3aNQbeof8diTANG1qcHhUQBNTKBFVYmVqCnQ0sjYkeSeWhmpjtjwlix+RQ/LvRgazvRfQGaZjF3MfBjWpui8xJTSvyIqrGtDrrwHPM1md6SlYEb/RqF91SZDrhFzoys8JKVvOP5pTovRh0NwkfSZMXPNSKhWMQUhqYkLg1/78gObKFbEVmUQ3ig9Zwl56QHEBxKwGEZpPbzZcLEYw+fin1qYamWzoPO7j6JWn+amj169TDv1WF73YyMzLtjxGwpvvme3PVb3r858sTCWlolMBIDEbXvkalCyJCQXrsDVbKyV/O7/aGP5gmucvCSA5JQw9f+3B5ynKSEjeKf//4mPKmpi0PsvK5r0GXhYoOMR3igGIcmoxxfd6PMtKl2oHPPnJi/BIW8plUSnv0HZ3L8Eu3l4BhdJruC8bxDyDQb9qtTm6NHQJTTda1DVNJvBl4IH6DRMlH3pF4GfeGQ8Kjilt+z7zJM8PSaO/ft3UlAkZW5gJhJee48OWmMgxt9LU4Kj3fed0E66WmNH5rjUi3MjA73E6NGYwHXbNjnKhjZXt4a1lhph4iJauNtmwxyuHQal82SRa1YRU4OfQaAX5+olqVvnpus3Ab3gTsOHM3aeamKTATEsoqSqqXATjqY3d+hxuoFNb9g8EBEhKI4SXsfXlPr8s1O+TatNnt3ypP+i8sA4Unom8i1K6NikmUEvrUdcHTZ09MJq3WW4R8llrjQ7MKxhjwxFyg==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(36756003)(36860700001)(5660300002)(8936002)(316002)(478600001)(118246002)(186003)(82740400003)(82310400003)(36736006)(83380400001)(34020700004)(70586007)(6512007)(336012)(107886003)(956004)(356005)(26005)(4326008)(1076003)(2906002)(6486002)(6666004)(6506007)(2616005)(966005)(47076005)(8676002)(70206006)(86362001)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 06:50:00.0123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09903a6d-6e0d-46b6-9f7c-08d8dfa2e5bd
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT024.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB5906
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
 drivers/power/supply/bq27xxx_battery.c     | 44 ++++++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 47 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4c4a7b1c64c5..05a4f9190160 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -39,6 +39,7 @@
  * https://www.ti.com/product/bq27z561
  * https://www.ti.com/product/bq28z610
  * https://www.ti.com/product/bq34z100-g1
+ * https://www.ti.com/product/bq78z100
  */
 
 #include <linux/device.h>
@@ -515,6 +516,27 @@ static u8
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
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
+		[BQ27XXX_REG_TTES] = 0x1c,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_RC] = 0x10,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x22,
+		BQ27XXX_DM_REG_ROWS,
 	};
 
 static enum power_supply_property bq27000_props[] = {
@@ -813,6 +835,26 @@ static enum power_supply_property bq34z100_props[] = {
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
@@ -911,6 +953,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #define bq27z561_dm_regs 0
 #define bq28z610_dm_regs 0
 #define bq34z100_dm_regs 0
+#define bq78z100_dm_regs 0
 
 #define BQ27XXX_O_ZERO		BIT(0)
 #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
@@ -969,6 +1012,7 @@ static struct {
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

