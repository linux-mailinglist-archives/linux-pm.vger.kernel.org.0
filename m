Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F703DCBD6
	for <lists+linux-pm@lfdr.de>; Sun,  1 Aug 2021 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhHANbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 09:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232000AbhHANba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 09:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627824680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5l3cfDKg90tsBWnacoftXpz9kWzO1UsDYJ8c5s6XH0=;
        b=VcmmU+wVasvFgmdQvYTjnVzY1gd224W1Uzgc1gg9XM7MYbwto9e8+8HtkIaeGmxHIY7I8t
        6o8QcwJgAauRZbFWUgoNjF+pzwnvgDzg5V+AZuJaA4m1HRKIA68x6JxyXIXR8v0RbZ8Jxl
        b84mHjy4hJikpyk+FFZSFk0zoozIrWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-3ACs-q9OPk-GduFjISw4ow-1; Sun, 01 Aug 2021 09:31:19 -0400
X-MC-Unique: 3ACs-q9OPk-GduFjISw4ow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2DC41006C80;
        Sun,  1 Aug 2021 13:31:17 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6BCB60CC4;
        Sun,  1 Aug 2021 13:31:16 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 08/10] power: supply: axp288_fuel_gauge: Refresh all registers in one go
Date:   Sun,  1 Aug 2021 15:31:03 +0200
Message-Id: <20210801133105.101761-9-hdegoede@redhat.com>
In-Reply-To: <20210801133105.101761-1-hdegoede@redhat.com>
References: <20210801133105.101761-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Andrejus Basovas <cpp@gcc.lt>

The I2C-bus to the XPower AXP288 is shared between the Linux kernel and
the SoCs P-Unit. The P-Unit has a semaphore which the kernel must "lock"
before it may use the bus and while the kernel holds the semaphore the CPU
and GPU power-states must not be changed otherwise the system will freeze.

This is a complex process, which is quite expensive. This is all done by
iosf_mbi_block_punit_i2c_access(). To ensure that no unguarded I2C-bus
accesses happen, iosf_mbi_block_punit_i2c_access() gets called by the
I2C-bus-driver for every I2C transfer. Because this is so expensive it
is allowed to call iosf_mbi_block_punit_i2c_access() in a nested
fashion, so that higher-level code which does multiple I2C-transfers can
call it once for a group of transfers, turning the calls done by the
I2C-bus-driver into no-ops.

Userspace power-supply API users typically will read all provided
properties in one go, refreshing the last read values when
power_supply_changed() is called by the driver and/or periodically
(e.g. every 2 minutes).

The reading of all properties in one go causes the P-Unit semaphore
to quickly be taken and released multiple times in a row. Certain
PMIC registers like AXP20X_FG_RES are even used in multiple properties
so they get read multiple times, leading to a P-Unit take + release
each time the register is read.

As already mentioned the taking of the P-Unit semaphore is a quite
expensive operation and it has also been reported that the
"hammering" of the P-Unit semaphore done by the axp288_fuel_gauge
driver can even cause stability issues with the system as a whole.

Switch over to a scheme where the axp288_fuel_gauge driver keeps
a local copy of all the registers which it uses for properties
and make it only refresh its copy of the registers if the values
are older then 1 minute; or when a fuel-gauge interrupt has
triggered since the last read.

This not only reduces the amount of reads, it also makes the code
do all the reads in one go, rather then reading specific registers
based on which property is being queried. This allows calling
iosf_mbi_block_punit_i2c_access() once before doing all the reads,
so that we now only take the P-Unit semaphore once per update.

Tested-by: Andrejus Basovas <cpp@gcc.lt>
Signed-off-by: Andrejus Basovas <cpp@gcc.lt>
Co-developed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Replace "depends on X86" with "depends on IOSF_MBI" as the new code uses
  symbols which are only defined when IOSF_MBI support is enabled.
  Depending on this is ok since IOSF_MBI support should always be enabled
  on devices which use the AXP288 PMIC.

Changes in v2:
- Add a "depends on X86" to Kconfig since the iosf_mbi functions are X86 only
  (the AXP288 PMIC is only used on X86 devices).
---
 drivers/power/supply/Kconfig             |   2 +-
 drivers/power/supply/axp288_fuel_gauge.c | 201 ++++++++++++-----------
 2 files changed, 106 insertions(+), 97 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 11f5368e810e..eca4ce87bcfc 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -358,7 +358,7 @@ config AXP288_CHARGER
 
 config AXP288_FUEL_GAUGE
 	tristate "X-Powers AXP288 Fuel Gauge"
-	depends on MFD_AXP20X && IIO
+	depends on MFD_AXP20X && IIO && IOSF_MBI
 	help
 	  Say yes here to have support for X-Power power management IC (PMIC)
 	  Fuel Gauge. The device provides battery statistics and status
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 8011628d3704..8db8ab0827e4 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -2,7 +2,8 @@
 /*
  * axp288_fuel_gauge.c - Xpower AXP288 PMIC Fuel Gauge Driver
  *
- * Copyright (C) 2016-2017 Hans de Goede <hdegoede@redhat.com>
+ * Copyright (C) 2020-2021 Andrejus Basovas <xxx@yyy.tld>
+ * Copyright (C) 2016-2021 Hans de Goede <hdegoede@redhat.com>
  * Copyright (C) 2014 Intel Corporation
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -20,6 +21,7 @@
 #include <linux/power_supply.h>
 #include <linux/iio/consumer.h>
 #include <asm/unaligned.h>
+#include <asm/iosf_mbi.h>
 
 #define PS_STAT_VBUS_TRIGGER			(1 << 0)
 #define PS_STAT_BAT_CHRG_DIR			(1 << 2)
@@ -84,6 +86,7 @@
 #define PROP_VOLT(a)				((a) * 1000)
 #define PROP_CURR(a)				((a) * 1000)
 
+#define AXP288_REG_UPDATE_INTERVAL		(60 * HZ)
 #define AXP288_FG_INTR_NUM			6
 enum {
 	QWBTU_IRQ = 0,
@@ -114,6 +117,18 @@ struct axp288_fg_info {
 	int pwr_op;
 	int low_cap;
 	struct dentry *debug_file;
+
+	char valid;                 /* zero until following fields are valid */
+	unsigned long last_updated; /* in jiffies */
+
+	int pwr_stat;
+	int fg_res;
+	int bat_volt;
+	int d_curr;
+	int c_curr;
+	int ocv;
+	int fg_cc_mtr1;
+	int fg_des_cap1;
 };
 
 static enum power_supply_property fuel_gauge_props[] = {
@@ -192,25 +207,78 @@ static int fuel_gauge_read_12bit_word(struct axp288_fg_info *info, int reg)
 	return (buf[0] << 4) | ((buf[1] >> 4) & 0x0f);
 }
 
-static void fuel_gauge_get_status(struct axp288_fg_info *info)
+static int fuel_gauge_update_registers(struct axp288_fg_info *info)
 {
-	int pwr_stat, fg_res, curr, ret;
+	int ret;
 
-	pwr_stat = fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS);
-	if (pwr_stat < 0) {
-		dev_err(info->dev, "PWR STAT read failed: %d\n", pwr_stat);
-		return;
+	if (info->valid && time_before(jiffies, info->last_updated + AXP288_REG_UPDATE_INTERVAL))
+		return 0;
+
+	dev_dbg(info->dev, "Fuel Gauge updating register values...\n");
+
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret < 0)
+		return ret;
+
+	ret = fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS);
+	if (ret < 0)
+		goto out;
+	info->pwr_stat = ret;
+
+	ret = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
+	if (ret < 0)
+		goto out;
+	info->fg_res = ret;
+
+	ret = iio_read_channel_raw(info->iio_channel[BAT_VOLT], &info->bat_volt);
+	if (ret < 0)
+		goto out;
+
+	if (info->pwr_stat & PS_STAT_BAT_CHRG_DIR) {
+		info->d_curr = 0;
+		ret = iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], &info->c_curr);
+		if (ret < 0)
+			goto out;
+	} else {
+		info->c_curr = 0;
+		ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &info->d_curr);
+		if (ret < 0)
+			goto out;
 	}
 
+	ret = fuel_gauge_read_12bit_word(info, AXP288_FG_OCVH_REG);
+	if (ret < 0)
+		goto out;
+	info->ocv = ret;
+
+	ret = fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG);
+	if (ret < 0)
+		goto out;
+	info->fg_cc_mtr1 = ret;
+
+	ret = fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG);
+	if (ret < 0)
+		goto out;
+	info->fg_des_cap1 = ret;
+
+	info->last_updated = jiffies;
+	info->valid = 1;
+	ret = 0;
+out:
+	iosf_mbi_unblock_punit_i2c_access();
+	return ret;
+}
+
+static void fuel_gauge_get_status(struct axp288_fg_info *info)
+{
+	int pwr_stat = info->pwr_stat;
+	int fg_res = info->fg_res;
+	int curr = info->d_curr;
+
 	/* Report full if Vbus is valid and the reported capacity is 100% */
 	if (!(pwr_stat & PS_STAT_VBUS_VALID))
 		goto not_full;
 
-	fg_res = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
-	if (fg_res < 0) {
-		dev_err(info->dev, "FG RES read failed: %d\n", fg_res);
-		return;
-	}
 	if (!(fg_res & FG_REP_CAP_VALID))
 		goto not_full;
 
@@ -228,11 +296,6 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 	if (fg_res < 90 || (pwr_stat & PS_STAT_BAT_CHRG_DIR))
 		goto not_full;
 
-	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &curr);
-	if (ret < 0) {
-		dev_err(info->dev, "FG get current failed: %d\n", ret);
-		return;
-	}
 	if (curr == 0) {
 		info->status = POWER_SUPPLY_STATUS_FULL;
 		return;
@@ -245,61 +308,16 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 		info->status = POWER_SUPPLY_STATUS_DISCHARGING;
 }
 
-static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)
-{
-	int ret = 0, raw_val;
-
-	ret = iio_read_channel_raw(info->iio_channel[BAT_VOLT], &raw_val);
-	if (ret < 0)
-		goto vbatt_read_fail;
-
-	*vbatt = VOLTAGE_FROM_ADC(raw_val);
-vbatt_read_fail:
-	return ret;
-}
-
-static int fuel_gauge_get_current(struct axp288_fg_info *info, int *cur)
-{
-	int ret, discharge;
-
-	/* First check discharge current, so that we do only 1 read on bat. */
-	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &discharge);
-	if (ret < 0)
-		return ret;
-
-	if (discharge > 0) {
-		*cur = -1 * discharge;
-		return 0;
-	}
-
-	return iio_read_channel_raw(info->iio_channel[BAT_CHRG_CURR], cur);
-}
-
-static int fuel_gauge_get_vocv(struct axp288_fg_info *info, int *vocv)
-{
-	int ret;
-
-	ret = fuel_gauge_read_12bit_word(info, AXP288_FG_OCVH_REG);
-	if (ret >= 0)
-		*vocv = VOLTAGE_FROM_ADC(ret);
-
-	return ret;
-}
-
 static int fuel_gauge_battery_health(struct axp288_fg_info *info)
 {
-	int ret, vocv, health = POWER_SUPPLY_HEALTH_UNKNOWN;
-
-	ret = fuel_gauge_get_vocv(info, &vocv);
-	if (ret < 0)
-		goto health_read_fail;
+	int vocv = VOLTAGE_FROM_ADC(info->ocv);
+	int health = POWER_SUPPLY_HEALTH_UNKNOWN;
 
 	if (vocv > info->max_volt)
 		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 	else
 		health = POWER_SUPPLY_HEALTH_GOOD;
 
-health_read_fail:
 	return health;
 }
 
@@ -308,9 +326,14 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 		union power_supply_propval *val)
 {
 	struct axp288_fg_info *info = power_supply_get_drvdata(ps);
-	int ret = 0, value;
+	int ret, value;
 
 	mutex_lock(&info->lock);
+
+	ret = fuel_gauge_update_registers(info);
+	if (ret < 0)
+		goto out;
+
 	switch (prop) {
 	case POWER_SUPPLY_PROP_STATUS:
 		fuel_gauge_get_status(info);
@@ -320,21 +343,19 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 		val->intval = fuel_gauge_battery_health(info);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = fuel_gauge_get_vbatt(info, &value);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
+		value = VOLTAGE_FROM_ADC(info->bat_volt);
 		val->intval = PROP_VOLT(value);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
-		ret = fuel_gauge_get_vocv(info, &value);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
+		value = VOLTAGE_FROM_ADC(info->ocv);
 		val->intval = PROP_VOLT(value);
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = fuel_gauge_get_current(info, &value);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
+		if (info->d_curr > 0)
+			value = -1 * info->d_curr;
+		else
+			value = info->c_curr;
+
 		val->intval = PROP_CURR(value);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -344,13 +365,9 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 			val->intval = 0;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-
-		if (!(ret & FG_REP_CAP_VALID))
+		if (!(info->fg_res & FG_REP_CAP_VALID))
 			dev_err(info->dev, "capacity measurement not valid\n");
-		val->intval = (ret & FG_REP_CAP_VAL_MASK);
+		val->intval = (info->fg_res & FG_REP_CAP_VAL_MASK);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
 		val->intval = (info->low_cap & 0x0f);
@@ -359,31 +376,19 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		ret = fuel_gauge_read_15bit_word(info, AXP288_FG_CC_MTR1_REG);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-
-		val->intval = ret * FG_DES_CAP_RES_LSB;
+		val->intval = info->fg_cc_mtr1 * FG_DES_CAP_RES_LSB;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = fuel_gauge_read_15bit_word(info, AXP288_FG_DES_CAP1_REG);
-		if (ret < 0)
-			goto fuel_gauge_read_err;
-
-		val->intval = ret * FG_DES_CAP_RES_LSB;
+		val->intval = info->fg_des_cap1 * FG_DES_CAP_RES_LSB;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		val->intval = PROP_VOLT(info->max_volt);
 		break;
 	default:
-		mutex_unlock(&info->lock);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	mutex_unlock(&info->lock);
-	return 0;
-
-fuel_gauge_read_err:
+out:
 	mutex_unlock(&info->lock);
 	return ret;
 }
@@ -472,6 +477,8 @@ static irqreturn_t fuel_gauge_thread_handler(int irq, void *dev)
 		dev_warn(info->dev, "Spurious Interrupt!!!\n");
 	}
 
+	info->valid = 0; /* Force updating of the cached registers */
+
 	power_supply_changed(info->bat);
 	return IRQ_HANDLED;
 }
@@ -480,6 +487,7 @@ static void fuel_gauge_external_power_changed(struct power_supply *psy)
 {
 	struct axp288_fg_info *info = power_supply_get_drvdata(psy);
 
+	info->valid = 0; /* Force updating of the cached registers */
 	power_supply_changed(info->bat);
 }
 
@@ -637,6 +645,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
 	info->status = POWER_SUPPLY_STATUS_UNKNOWN;
+	info->valid = 0;
 
 	platform_set_drvdata(pdev, info);
 
-- 
2.31.1

