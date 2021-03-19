Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687A2341AE0
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 12:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCSLC4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 07:02:56 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com ([40.107.13.113]:14343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230241AbhCSLCs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Mar 2021 07:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDXeUxU4N+uTJRg7eyEREWLEv7FBP7Uc5bwbkwgSh6JrttnZvZ/jNhuzNddYTQQMFwlguihv1yDcTEnh4gDuxe+lWhOA6LJtT0XC0fbbTKgjQ30IkiKjhENt02FjXDVDGUsSsZYrdxK2NJEDh+aY7wDnv1tfganKQ+w8VO/06AkKgP+qqljzI8mMtAtJV9pKVhryVlrOp6nRKS71jwu3FwSpnhkzrM8ZS6JzKcmDdCV+wAPM1cs0IR0PJ45mcoq0AwDNUp57iBL/9NUgYmdbASRz8OcGvWhJKauQdIoNXqrw29RRivZ7D/xfCP6M9jUahx7/Dp3Psqla1I7ifBDaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPHpXb9zx0Gtujj1flSI894vA9qm74I7vNVOQLD5NAU=;
 b=kjZKlQ5SWZfSf3Z3lsg/dhIDn11tVuap0MrbpTVQg6kO+KshIC3zrIL1AUxJXNykKAPwNVsuFhL0Jwvnf+I2gnODHzgh9S8anwrlCHPPecE1mwEamZwdTSILX10UN+c5d1CKJxY7elcKCD6TQ0oU01UJw3EIdPiI/KpW/KqFunY8valProBxOLcXPrNFviNO72gri5zWQ1K2IyyInI/je/XJTP2/NfaI4FeIxVo1BAzdiB+hzDYQs9ozM7wq/OfKxSqGFFoyn3hM372yT8VSky7axAD//GyujarDSm77h+/Sth4MSwALQw8QMJRwpd6nXy3qxK+55KGej1S1bz22EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPHpXb9zx0Gtujj1flSI894vA9qm74I7vNVOQLD5NAU=;
 b=VwU5xpNneYurn0OZCmaKJfRk8m53AihUFgCqIIIpeTU+cYeFCfybh4XfACM7T/4lHRmlTOZiTGy7uzRSYNasgpRW4O2cvLeQo2zemEvdu9a1IEHxmwOUPKjNbhyY/Ey5rn9J+ItvL8C9Zd8xigox33y42qPwH36qVRm8Vlo9nEM=
Received: from AM6P193CA0099.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::40)
 by AS8PR06MB7944.eurprd06.prod.outlook.com (2603:10a6:20b:3c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 11:02:46 +0000
Received: from VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::43) by AM6P193CA0099.outlook.office365.com
 (2603:10a6:209:88::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Fri, 19 Mar 2021 11:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 VE1EUR02FT060.mail.protection.outlook.com (10.152.13.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.19 via Frontend Transport; Fri, 19 Mar 2021 11:02:45 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V7 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Date:   Fri, 19 Mar 2021 11:02:36 +0000
Message-Id: <20210319110236.4353-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319110236.4353-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210319110236.4353-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d62271ec-8edb-4166-988b-08d8eac68693
X-MS-TrafficTypeDiagnostic: AS8PR06MB7944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR06MB7944A622D73B7A4BFE65037DD7689@AS8PR06MB7944.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5iDAc/s/Pia5Fc/fXou1RQ66V8vASNRqugUUm3DQJeodgsZmlH6Gpi1r4RPTeu5biuWrhfyueP1mA3VOH7yzC6yH6/4NMds+6khqdSDspOcHLfJ5JVa1ka1ZpXlbtfwMn9AdmDoOlrYHEQXjqLR3f7GB8+5gsp1/kp+2JIBwmjxvQfUuJxK+NG6cUBsbjMD/FIfx0jkRr98eVCL9S8oOBiTMFW/rCUHeOEhQSHUeWOSa48BETcxfjjhuxUyGvOi1alTNJ3BOV4XaJLKN1uH413mBuyun3YuoaI9vY29dZ/IqFxHgcAUGen3SRbGWuY1xdyTyBT1IJ5yjzYIslSTcE6J1yfVN76CAkfFxxunZor39q+hdGavGqYSZB1mngKVZwmgB2CyxMGmMO6+8U5Ms9Ms7vNAEU2HpOHkpZ8dHO858TKSOX0OF2f/ctxZni3VO1+TkWrxeEJf2ENhCllg9CgTFNkfjzvmhbsOpHjtoQrVo4OTrbnu0Q6kuei+dZuBcD/lVK46TO0HC011r2IKS5wy5g/M6kSTc6FhOWlwaHmjUIHrnJKmYa2ioHr/KW2nKWU8S4kyBSUwakyP8yjzXp1yp42BY3n1QOO07D+WM4/kspy3sBW2Iyuhe5OQiAMfJ+SIRkzUEMHUF5zcmxJ5XXnbL6n7cL92i9/f8bHw7KRXXoN6x8uB7cxq4ORY8VlsPJr+GJNf1rRDGUbTHeDUp4qBYlRxA1cu3ZXIHchG0OqH9MydFW0Qh3EkqsWp07vXohZr0w4RQuqfGq4jEv0zWw==
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(6512007)(118246002)(6506007)(2616005)(70206006)(6666004)(36756003)(5660300002)(34020700004)(82310400003)(8936002)(356005)(70586007)(8676002)(2906002)(956004)(1076003)(26005)(336012)(81166007)(186003)(36860700001)(6486002)(4326008)(107886003)(47076005)(86362001)(82740400003)(478600001)(83380400001)(966005)(36736006)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 11:02:45.2850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d62271ec-8edb-4166-988b-08d8eac68693
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT060.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7944
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for TI BQ78Z100, I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

The patch was tested with BQ78Z100 equipment.

CASE I:  Discharging:
	POWER_SUPPLY_NAME=bq78z100-0
	POWER_SUPPLY_STATUS=Discharging
	POWER_SUPPLY_PRESENT=1
	POWER_SUPPLY_VOLTAGE_NOW=3386000
	POWER_SUPPLY_CURRENT_NOW=-5000
	POWER_SUPPLY_CAPACITY=27
	POWER_SUPPLY_CAPACITY_LEVEL=Normal
	POWER_SUPPLY_TEMP=269
	POWER_SUPPLY_TIME_TO_EMPTY_NOW=1249920
	POWER_SUPPLY_TECHNOLOGY=Li-ion
	POWER_SUPPLY_CHARGE_FULL=6494000
	POWER_SUPPLY_CHARGE_NOW=1736000
	POWER_SUPPLY_CHARGE_FULL_DESIGN=6000000
	POWER_SUPPLY_CYCLE_COUNT=1
	POWER_SUPPLY_POWER_AVG=-20000
	POWER_SUPPLY_HEALTH=Good
	POWER_SUPPLY_MANUFACTURER=Texas Instruments

CASE II : No discharging current:
	POWER_SUPPLY_NAME=bq78z100-0
	POWER_SUPPLY_STATUS=Not charging
	POWER_SUPPLY_PRESENT=1
	POWER_SUPPLY_VOLTAGE_NOW=3386000
	POWER_SUPPLY_CURRENT_NOW=0
	POWER_SUPPLY_CAPACITY=27
	POWER_SUPPLY_CAPACITY_LEVEL=Normal
	POWER_SUPPLY_TEMP=270
	POWER_SUPPLY_TECHNOLOGY=Li-ion
	POWER_SUPPLY_CHARGE_FULL=6494000
	POWER_SUPPLY_CHARGE_NOW=1734000
	POWER_SUPPLY_CHARGE_FULL_DESIGN=6000000
	POWER_SUPPLY_CYCLE_COUNT=1
	POWER_SUPPLY_POWER_AVG=0
	POWER_SUPPLY_HEALTH=Good
	POWER_SUPPLY_MANUFACTURER=Texas Instruments

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c     | 44 ++++++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 47 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4c4a7b1c64c5..12cf4a65d65b 100644
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
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
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

