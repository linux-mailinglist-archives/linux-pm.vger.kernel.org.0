Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC31E1029
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbgEYOMN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 10:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388862AbgEYOMM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 10:12:12 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73951208A7;
        Mon, 25 May 2020 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590415932;
        bh=4J38MidBihyKODDqhruO+ael6y9jTfLnvI1Z4aDlbFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9o7RA9oI5Kye0q9iCchyRyIL21EWhvh6bv/rY761ReIRig06ZaRi8rubQpI91ZRV
         9pykULK5id5wU0m0wRpqZTyItnDTVuc7tETrW9cTANnku1CKeQZWfjJLdhRNqLzoWT
         qQvmud0/LxMUoLJA7h/lDhaJZ1VuGZ8+r0VriZPo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@proceq.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] power: supply: bq27xxx_battery: Notify about voltage and current changes
Date:   Mon, 25 May 2020 16:12:00 +0200
Message-Id: <20200525141200.17199-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525141200.17199-1-krzk@kernel.org>
References: <20200525141200.17199-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Read voltage and current and store them in the cache (like other
properties).  This has benefits:
1. User-space will be notified on voltage or current change.  These
   are important properties of charging so user-space might be
   interested in getting them.
2. Closes possible resource exhaustion attack through continuous I2C
   reads triggered by unprivileged power supply sysfs API.  User could
   just keep reading voltage_now or current_now sysfs entries leading
   to excessive I2C transfers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 97 ++++++++++++--------------
 include/linux/power/bq27xxx_battery.h  |  2 +
 2 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 33c26d42cd02..048618c13e17 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1520,6 +1520,48 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
 		return tval;
 }
 
+/*
+ * Return the battery average current in µA
+ * Note that current can be negative signed as well
+ * Or 0 if something fails.
+ */
+static int bq27xxx_battery_read_current(struct bq27xxx_device_info *di,
+					int flags)
+{
+	int curr;
+
+	curr = bq27xxx_read(di, BQ27XXX_REG_AI, false);
+	if (curr < 0) {
+		dev_err(di->dev, "error reading current\n");
+		return 0;
+	}
+
+	if (di->opts & BQ27XXX_O_ZERO) {
+		if (flags & BQ27000_FLAG_CHGS) {
+			dev_dbg(di->dev, "negative current!\n");
+			curr = -curr;
+		}
+
+		return curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
+	}
+
+	/* else: Other gauges return signed value */
+	return (int)((s16)curr) * 1000;
+}
+
+static int bq27xxx_battery_read_voltage(struct bq27xxx_device_info *di)
+{
+	int volt;
+
+	volt = bq27xxx_read(di, BQ27XXX_REG_VOLT, false);
+	if (volt < 0) {
+		dev_err(di->dev, "error reading voltage\n");
+		return volt;
+	}
+
+	return volt * 1000;
+}
+
 /*
  * Returns true if a battery over temperature condition is detected
  */
@@ -1606,6 +1648,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 		if (di->regs[BQ27XXX_REG_AP] != INVALID_REG_ADDR)
 			cache.power_avg = bq27xxx_battery_read_pwr_avg(di);
+		cache.curr = bq27xxx_battery_read_current(di, cache.flags);
+		cache.voltage = bq27xxx_battery_read_voltage(di);
 
 		/* We only have to read charge design full once */
 		if (di->charge_design_full <= 0)
@@ -1633,39 +1677,6 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 		schedule_delayed_work(&di->work, poll_interval * HZ);
 }
 
-/*
- * Return the battery average current in µA
- * Note that current can be negative signed as well
- * Or 0 if something fails.
- */
-static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
-				   union power_supply_propval *val)
-{
-	int curr;
-	int flags;
-
-	curr = bq27xxx_read(di, BQ27XXX_REG_AI, false);
-	if (curr < 0) {
-		dev_err(di->dev, "error reading current\n");
-		return curr;
-	}
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
-		if (flags & BQ27000_FLAG_CHGS) {
-			dev_dbg(di->dev, "negative current!\n");
-			curr = -curr;
-		}
-
-		val->intval = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
-	} else {
-		/* Other gauges return signed value */
-		val->intval = (int)((s16)curr) * 1000;
-	}
-
-	return 0;
-}
-
 static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
 				  union power_supply_propval *val)
 {
@@ -1728,22 +1739,6 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
  * Return the battery Voltage in millivolts
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_voltage(struct bq27xxx_device_info *di,
-				   union power_supply_propval *val)
-{
-	int volt;
-
-	volt = bq27xxx_read(di, BQ27XXX_REG_VOLT, false);
-	if (volt < 0) {
-		dev_err(di->dev, "error reading voltage\n");
-		return volt;
-	}
-
-	val->intval = volt * 1000;
-
-	return 0;
-}
-
 static int bq27xxx_simple_value(int value,
 				union power_supply_propval *val)
 {
@@ -1777,13 +1772,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_status(di, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = bq27xxx_battery_voltage(di, val);
+		ret = bq27xxx_simple_value(di->cache.voltage, val);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = bq27xxx_battery_current(di, val);
+		val->intval = di->cache.curr; /* Can be negative */
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 507c5e214c42..418ba5e4029a 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -49,6 +49,8 @@ struct bq27xxx_reg_cache {
 	int cycle_count;
 	int capacity;
 	int energy;
+	int curr;
+	int voltage;
 	int flags;
 	int power_avg;
 	int health;
-- 
2.17.1

