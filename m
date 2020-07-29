Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969FF2324AD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 20:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgG2Sb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 14:31:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36706 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgG2Sb6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 14:31:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06TIVukj124902;
        Wed, 29 Jul 2020 13:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596047516;
        bh=y1iSsLun5D7LlKgpca2k9aBlfGQ8Zn/nCnvBysNfNDE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NBZenCfTwxy9LNU+wuKjFDenlhWjWgfcpnIA0XVYdl6FfzTiv2w0FkfYYibrgk/qp
         a5eYD9rcVPs8HrDoHUOOyYGqe+rTOcewWGq4Fml9pMYtBQwhGZF4coRWbEEID4Ev3S
         GZxCEZnoJd8mH9eMxMNm9qD6niroBjLV5k+Cer6w=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06TIVuku049424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 13:31:56 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Jul 2020 13:31:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Jul 2020 13:31:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06TIVuJP098482;
        Wed, 29 Jul 2020 13:31:56 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <afd@ti.com>, <pali@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v6 2/4] power: supply: bq27xxx_battery: Add the BQ27Z561 Battery monitor
Date:   Wed, 29 Jul 2020 13:31:43 -0500
Message-ID: <20200729183145.6066-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729183145.6066-1-dmurphy@ti.com>
References: <20200729183145.6066-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the Texas Instruments BQ27Z561 battery monitor.  The register address
map is laid out the same as compared to other devices within the file.
The battery status register has differing bits to determine if the
battery is full, discharging or dead.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 68 +++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index acaafed037be..a05b9a2d112d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -43,6 +43,7 @@
  * https://www.ti.com/product/bq27411-g1
  * https://www.ti.com/product/bq27441-g1
  * https://www.ti.com/product/bq27621-g1
+ * https://www.ti.com/product/bq27z561
  */
 
 #include <linux/device.h>
@@ -79,6 +80,11 @@
 #define BQ27000_FLAG_FC		BIT(5)
 #define BQ27000_FLAG_CHGS	BIT(7) /* Charge state flag */
 
+/* BQ27Z561 has different layout for Flags register */
+#define BQ27Z561_FLAG_FDC	BIT(4) /* Battery fully discharged */
+#define BQ27Z561_FLAG_FC		BIT(5) /* Battery fully charged */
+#define BQ27Z561_FLAG_DIS_CH	BIT(6) /* Battery is discharging */
+
 /* control register params */
 #define BQ27XXX_SEALED			0x20
 #define BQ27XXX_SET_CFGUPDATE		0x13
@@ -431,12 +437,32 @@ static u8
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x18,
 		BQ27XXX_DM_REG_ROWS,
-	};
+	},
 #define bq27411_regs bq27421_regs
 #define bq27425_regs bq27421_regs
 #define bq27426_regs bq27421_regs
 #define bq27441_regs bq27421_regs
 #define bq27621_regs bq27421_regs
+	bq27z561_regs[BQ27XXX_REG_MAX] = {
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
+	};
 
 static enum power_supply_property bq27000_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -672,6 +698,25 @@ static enum power_supply_property bq27421_props[] = {
 #define bq27441_props bq27421_props
 #define bq27621_props bq27421_props
 
+static enum power_supply_property bq27z561_props[] = {
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
@@ -767,11 +812,14 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 #define bq27621_dm_regs 0
 #endif
 
+#define bq27z561_dm_regs 0
+
 #define BQ27XXX_O_ZERO	0x00000001
 #define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
 #define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */
 #define BQ27XXX_O_CFGUP	0x00000008
 #define BQ27XXX_O_RAM	0x00000010
+#define BQ27Z561_O_BITS	0x00000020
 
 #define BQ27XXX_DATA(ref, key, opt) {		\
 	.opts = (opt),				\
@@ -816,6 +864,7 @@ static struct {
 	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
+	[BQ27Z561]  = BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -1551,6 +1600,8 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
 {
 	if (di->opts & BQ27XXX_O_ZERO)
 		return flags & (BQ27000_FLAG_EDV1 | BQ27000_FLAG_EDVF);
+	else if (di->opts & BQ27Z561_O_BITS)
+		return flags & BQ27Z561_FLAG_FDC;
 	else
 		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
@@ -1595,6 +1646,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 				cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
 			if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
 				cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+
 			cache.charge_full = bq27xxx_battery_read_fcc(di);
 			cache.capacity = bq27xxx_battery_read_soc(di);
 			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
@@ -1682,6 +1734,13 @@ static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
 			status = POWER_SUPPLY_STATUS_DISCHARGING;
+	} else if (di->opts & BQ27Z561_O_BITS) {
+		if (di->cache.flags & BQ27Z561_FLAG_FC)
+			status = POWER_SUPPLY_STATUS_FULL;
+		else if (di->cache.flags & BQ27Z561_FLAG_DIS_CH)
+			status = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			status = POWER_SUPPLY_STATUS_CHARGING;
 	} else {
 		if (di->cache.flags & BQ27XXX_FLAG_FC)
 			status = POWER_SUPPLY_STATUS_FULL;
@@ -1710,6 +1769,13 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 		else
 			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+	} else if (di->opts & BQ27Z561_O_BITS) {
+		if (di->cache.flags & BQ27Z561_FLAG_FC)
+			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+		else if (di->cache.flags & BQ27Z561_FLAG_FDC)
+			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		else
+			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 	} else {
 		if (di->cache.flags & BQ27XXX_FLAG_FC)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 8e114a7abfc9..15f4e75786ab 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -253,6 +253,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27426", BQ27426 },
 	{ "bq27441", BQ27441 },
 	{ "bq27621", BQ27621 },
+	{ "bq27z561", BQ27Z561 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
@@ -286,6 +287,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27426" },
 	{ .compatible = "ti,bq27441" },
 	{ .compatible = "ti,bq27621" },
+	{ .compatible = "ti,bq27z561" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 507c5e214c42..1f6ea5d5063d 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -30,6 +30,7 @@ enum bq27xxx_chip {
 	BQ27426,
 	BQ27441,
 	BQ27621,
+	BQ27Z561,
 };
 
 struct bq27xxx_device_info;
-- 
2.28.0

