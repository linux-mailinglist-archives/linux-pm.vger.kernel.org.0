Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A141433EEBD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 11:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCQKty (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 06:49:54 -0400
Received: from mail-eopbgr30119.outbound.protection.outlook.com ([40.107.3.119]:60995
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230252AbhCQKtY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 06:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4/ixGeIjltZ8Oux83Mopr2P0yaYo/c3ZTmDS67eaYiEn7A72RlyKwe7s/ICtD6YNLajWZiZXJlNb/rwRs1NyMzSPb3SQ8GJv4ghzI3Bz6RyGUSqfwlr4mS/1gYNF3D8N09M+kZI4/YlW1DttLdmMuF2fl1k0aP8kskLq/fnRObwodQHS5UqIjFvUasst9F2BD9peqwY9ERb9KL21JyRIhgvDWMjaSiDyLjWVhuuRuVenSk+jGSYPST1hGXdREFImc6uRW6MC2l47n/vppp/VmEaTKn6t/UCCQlDpfGn3YAm2GD+6eWv/ypkTt8f3NkKoT1KULpp0LZZMX0rzVfwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G7JvOzCNsTuacG/CoZr/l0X1ZD+uMhaSEALtb/dSPw=;
 b=LcgxG/FKUBTKPRTCcUXD4BBF1veuCv8U3Ya5XtLHFYxu1i2BtNwXCYg+SPuVSJVdO27lVAFZCTc6oSaQuP9IcrU9imc/Jf8v23U0ubAE+4CQw0Eje/G2ygWFkXrTpP3Zt7Ub11bnx/ojNsQZSjGbj3Ae/q3hf5CyEydtVS008IEEjfKczDG6wFlMBamQ5QFlJy1M99AIIx1bllD41IGIxJVxHEEsBOS6M4CQCelws8TctT8sVXuKSjNilYCQcAA0XhbVFjAsovOZY5Lb89ljqoi22VogmQ+cdRciApr/OgFmDfUdDqLF2bBGZ3FLN8JzlD9Zxd/R+Rfx6OROLDpWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G7JvOzCNsTuacG/CoZr/l0X1ZD+uMhaSEALtb/dSPw=;
 b=A2yj+R5Wjzu9/GKB5blsJm3Gm8KyBfMlC3IjXvyCuxWW7M88AoAqhHba+q6TIaRnkLvokUW0BofbXeyVeunSre8A0wRRKX5jehZjwPDTpIVHbKcxAPXaC2nc4iQIWEQlhu4g20K+9+FpG2bS874d+j+16dBsv5GLr6OjlKN9eoY=
Received: from AM3PR07CA0084.eurprd07.prod.outlook.com (2603:10a6:207:6::18)
 by PR3PR06MB7066.eurprd06.prod.outlook.com (2603:10a6:102:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 10:49:22 +0000
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:207:6:cafe::ae) by AM3PR07CA0084.outlook.office365.com
 (2603:10a6:207:6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend
 Transport; Wed, 17 Mar 2021 10:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=pass action=none
 header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.99) by
 AM5EUR02FT064.mail.protection.outlook.com (10.152.9.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Wed, 17 Mar 2021 10:49:22 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     sre@kernel.org, robh+dt@kernel.org, pali@kernel.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V6 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Date:   Wed, 17 Mar 2021 10:49:18 +0000
Message-Id: <20210317104918.12323-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: de31a72f-24b7-4b6c-da37-08d8e9325340
X-MS-TrafficTypeDiagnostic: PR3PR06MB7066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR06MB70663A46BA5BA38211CB37FBD76A9@PR3PR06MB7066.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYknFD8040GNVDFG9/O497gT48MdhSzFKLQFG8iE5bfCWrTh2ktsZXpsnpcqIVHU8v62ryCGAi5jMlMx8m/1iaZtwS12Q1j0bSmlxfS/LuYaWveIG9yZQ4w82dvxIxBiyafTA4BLxVqphuX3/oNikUMFvFY0rqMgIzsTbJb0MnH6ck7YIqc9wLdnVMQNHZNBivd/dxiNTsEfxgNqC2jc35Lne7GL1e0UYrO6hBxJGrMw/mVZYCczJqeiebTsRMIax4DPAMNdBV8TeSHwkRheZoIGiskGZTDk/sbhDPngNuWzoIvtIHjzutSgyj9ZNUNIv9RI8EaDBLl7FN2boCtHdiPess3L1NB6Y8Qu+iqaTjb3ZewujcXTO1E2ydUsDS+jLGQYvLoSn2rmKot6PeD7818yGahnUKZd8a0f+K+Z5CciPO19aT9SwaeUEmgwQhy8+xHNy2rByhBrsUkTv57COUJnpvOA3I87nLh5zp+feFiBPq/jSbwVlXlddFR6Iqn/Ni/aSWaJpUYJouKuBW26SdMXPm3/is1lDizELcV8JgUtQphqBMyfEm86DgTdX/WNYFrxjM8mIV+BLoVnfuCgRVGziT7mTZ86J/vj9q5ZE0ieT1kZL91Iyiz6Me7eiVb0X/M+XBlTwLjnbXZR0oxSTiswT6xIkdLPonzIdmYdr8ZMCAAALQczOZEiE5mQah8XIiWt8WvPjxLTmCGRBn8kWnBPUOO2XGYr8kVnO9gT0Ik=
X-Forefront-Antispam-Report: CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(81166007)(6512007)(70586007)(8676002)(8936002)(966005)(82740400003)(47076005)(86362001)(26005)(6506007)(36860700001)(5660300002)(118246002)(4326008)(70206006)(1076003)(36756003)(356005)(107886003)(6666004)(6486002)(36736006)(82310400003)(83380400001)(336012)(186003)(478600001)(2906002)(956004)(2616005)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 10:49:22.5191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de31a72f-24b7-4b6c-da37-08d8e9325340
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7066
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for TI BQ78Z100, I2C interface gas gauge.
It provides a fully integrated safety protection
and authentication for 1 to 2-series cell Li-Ion and
Li-Polymer battery packs.

The patch was tested with BQ78Z100 equipment.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

result of cat "/sys/class/power_supply/<bat_name>/uevent"

CASE I:  Discharging current>0:
    POWER_SUPPLY_NAME=bq78z100-0
    POWER_SUPPLY_STATUS=Discharging
    POWER_SUPPLY_PRESENT=1
    POWER_SUPPLY_VOLTAGE_NOW=3405000
    POWER_SUPPLY_CURRENT_NOW=4000
    POWER_SUPPLY_CAPACITY=28
    POWER_SUPPLY_CAPACITY_LEVEL=Normal
    POWER_SUPPLY_TEMP=259
    POWER_SUPPLY_TIME_TO_EMPTY_NOW=1611000
    POWER_SUPPLY_TECHNOLOGY=Li-ion
    POWER_SUPPLY_CHARGE_FULL=6494000
    POWER_SUPPLY_CHARGE_FULL_DESIGN=6000000
    POWER_SUPPLY_CYCLE_COUNT=1
    POWER_SUPPLY_ENERGY_NOW=0
    POWER_SUPPLY_POWER_AVG=65535
    POWER_SUPPLY_HEALTH=Good
    POWER_SUPPLY_MANUFACTURER=Texas Instruments

CASE II : No discharging current:
    POWER_SUPPLY_NAME=bq78z100-0
    POWER_SUPPLY_STATUS=Discharging
    POWER_SUPPLY_PRESENT=1
    POWER_SUPPLY_VOLTAGE_NOW=3405000
    POWER_SUPPLY_CURRENT_NOW=0
    POWER_SUPPLY_CAPACITY=28
    POWER_SUPPLY_CAPACITY_LEVEL=Normal
    POWER_SUPPLY_TEMP=260
    POWER_SUPPLY_TECHNOLOGY=Li-ion
    POWER_SUPPLY_CHARGE_FULL=6494000
    POWER_SUPPLY_CHARGE_FULL_DESIGN=6000000
    POWER_SUPPLY_CYCLE_COUNT=1
    POWER_SUPPLY_ENERGY_NOW=0
    POWER_SUPPLY_POWER_AVG=0
    POWER_SUPPLY_HEALTH=Good
    POWER_SUPPLY_MANUFACTURER=Texas Instruments
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

