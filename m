Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AEB2285C5
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgGUQcc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 12:32:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46632 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGUQcc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 12:32:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LGWSTl005114;
        Tue, 21 Jul 2020 11:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595349148;
        bh=XgJdQKDzmr7dacCgcldlDU/h9LNfFlX28YSFFph/Eqs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zl7ftJpxAhfXxwKbKX4k3qUiVnKbfrE3+lRR3H6rpAcxYz16O/UvmyGlr+MnMnYls
         7sEOILfuhHh50EPtAdQ0pNxG7C9hzHrZTG5dwFIAcLiG4gPPApzzV2jbJ51ikrqb3O
         dYwnAAmI00ZqJ7PIjbf6XaMQfBr5rpIbPl1NuTg8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LGWSMX036020;
        Tue, 21 Jul 2020 11:32:28 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 11:32:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 11:32:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LGWSf0004980;
        Tue, 21 Jul 2020 11:32:28 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 4/4] power: supply: bq27xxx_battery: Add the BQ28z610 Battery monitor
Date:   Tue, 21 Jul 2020 11:32:06 -0500
Message-ID: <20200721163206.25438-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721163206.25438-1-dmurphy@ti.com>
References: <20200721163206.25438-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Texas Instruments BQ28z610 battery monitor.
The register address map is laid out the same as compared to other
devices within the file.

The battery status register bits are similar to the BQ27561 but they
are different compared to other fuel gauge devices within this file.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 42 ++++++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 ++
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 466bbc549799..07b7d01a720d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -44,6 +44,7 @@
  * http://www.ti.com/product/bq27441-g1
  * http://www.ti.com/product/bq27621-g1
  * https://www.ti.com/lit/gpn/bq27z561
+ * https://www.ti.com/lit/gpn/bq28z610
  */
 
 #include <linux/device.h>
@@ -462,6 +463,26 @@ static u8
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
+	},
+	bq28z610_regs[BQ27XXX_REG_MAX] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
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
 	};
 
 static enum power_supply_property bq27000_props[] = {
@@ -717,6 +738,25 @@ static enum power_supply_property bq27561_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq28z610_props[] = {
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
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 struct bq27xxx_dm_reg {
 	u8 subclass_id;
 	u8 offset;
@@ -813,6 +853,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #endif
 
 #define bq27561_dm_regs 0
+#define bq28z610_dm_regs 0
 
 #define BQ27XXX_O_ZERO	0x00000001
 #define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
@@ -865,6 +906,7 @@ static struct {
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27561]   = BQ27XXX_DATA(bq27561,   0         , BQ27561_O_BITS),
+	[BQ28Z610]  = BQ27XXX_DATA(bq28z610,  0         , BQ27561_O_BITS),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index d0d55e0959d5..12cf0c619d6d 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -254,6 +254,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27441", BQ27441 },
 	{ "bq27621", BQ27621 },
 	{ "bq27561", BQ27561 },
+	{ "bq28z610", BQ28Z610 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
@@ -288,6 +289,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27441" },
 	{ .compatible = "ti,bq27621" },
 	{ .compatible = "ti,bq27561" },
+	{ .compatible = "ti,bq28z610" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 4a319950ea22..50f6230f42c4 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -31,6 +31,7 @@ enum bq27xxx_chip {
 	BQ27441,
 	BQ27621,
 	BQ27561,
+	BQ28Z610,
 };
 
 struct bq27xxx_device_info;
-- 
2.27.0

