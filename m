Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5E2620A7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 22:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgIHUOK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 16:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbgIHUNn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 16:13:43 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C82221919;
        Tue,  8 Sep 2020 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599596022;
        bh=wJ87e8T7EOYIHG2r7VdfUWG50zR+zTU8CzrQ6amSZO0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rIewicuzRpS0zihYsf461TwPuRaI/rMi41Si3bjy37M+K7TXipdMwstz6xMMMFMY6
         Mz1xdAvMhsO2idev9YqdV/n8qq18B4HWKCfiDzNm5bVsUC8SQqSyUnWTwFjH07OQ1Y
         KVJ18b6C/nEN+aXaF+9kavK3hT3m8bmQEtgO6GA0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] power: supply: bq27xxx: add support for TI bq34z100
Date:   Tue,  8 Sep 2020 22:13:19 +0200
Message-Id: <20200908201319.3567-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908201319.3567-1-krzk@kernel.org>
References: <20200908201319.3567-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for new device: the TI bq34z100-G1, a Wide Range Fuel Gauge
for Li-Ion, PbA, NiMH, and NiCd batteries.  The device shares a lot with
other models, although it has its own differences requiring new quirks.

This patch was tested on a system equipped with NiMH batteries.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c     | 50 +++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index cda03e1f9586..315e0909e6a4 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -38,6 +38,7 @@
  * https://www.ti.com/product/bq27621-g1
  * https://www.ti.com/product/bq27z561
  * https://www.ti.com/product/bq28z610
+ * https://www.ti.com/product/bq34z100-g1
  */
 
 #include <linux/device.h>
@@ -476,6 +477,26 @@ static u8
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
+	},
+	bq34z100_regs[BQ27XXX_REG_MAX] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x0c,
+		[BQ27XXX_REG_INT_TEMP] = 0x2a,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x0a,
+		[BQ27XXX_REG_FLAGS] = 0x0e,
+		[BQ27XXX_REG_TTE] = 0x18,
+		[BQ27XXX_REG_TTF] = 0x1a,
+		[BQ27XXX_REG_TTES] = 0x1e,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_FCC] = 0x06,
+		[BQ27XXX_REG_CYCT] = 0x2c,
+		[BQ27XXX_REG_AE] = 0x24,
+		[BQ27XXX_REG_SOC] = 0x02,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x22,
+		BQ27XXX_DM_REG_ROWS,
 	};
 
 static enum power_supply_property bq27000_props[] = {
@@ -750,6 +771,27 @@ static enum power_supply_property bq28z610_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq34z100_props[] = {
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
@@ -857,6 +899,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #define BQ27Z561_O_BITS		BIT(5)
 #define BQ27XXX_O_SOC_SI	BIT(6) /* SoC is single register */
 #define BQ27XXX_O_HAS_CI	BIT(7) /* has Capacity Inaccurate flag */
+#define BQ27XXX_O_MUL_CHEM	BIT(8) /* multiple chemistries supported */
 
 #define BQ27XXX_DATA(ref, key, opt) {		\
 	.opts = (opt),				\
@@ -903,6 +946,8 @@ static struct {
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
 	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
+	[BQ34Z100]  = BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ27XXX_O_SOC_SI | \
+							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -1914,7 +1959,10 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_simple_value(di->cache.time_to_full, val);
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		if (di->opts & BQ27XXX_O_MUL_CHEM)
+			val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+		else
+			val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 765873dfc495..eb4f4284982f 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -247,6 +247,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27621", BQ27621 },
 	{ "bq27z561", BQ27Z561 },
 	{ "bq28z610", BQ28Z610 },
+	{ "bq34z100", BQ34Z100 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
@@ -282,6 +283,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27621" },
 	{ .compatible = "ti,bq27z561" },
 	{ .compatible = "ti,bq28z610" },
+	{ .compatible = "ti,bq34z100" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 987d9652aa4e..111a40d0d3d5 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -32,6 +32,7 @@ enum bq27xxx_chip {
 	BQ27621,
 	BQ27Z561,
 	BQ28Z610,
+	BQ34Z100,
 };
 
 struct bq27xxx_device_info;
-- 
2.17.1

