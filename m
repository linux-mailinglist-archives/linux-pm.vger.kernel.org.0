Return-Path: <linux-pm+bounces-19263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7679F24FC
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885701885876
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512D1B4138;
	Sun, 15 Dec 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRL7VjzO"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614D4C80
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283314; cv=none; b=X5wByRJ5KUhzEApFOojbDYzjzT4iUjY3/ENh/Xce7MSFD++I4XcyQPbKJm31e9wk+bTkBHdeJHLK4Gk8fopcHMHCjFYYAREMl1VA1OEpQvcFnn9RgVGcmBp1hJfJOV/ieWxjNzMk0FyXUESdRnpRHfy0farmr4bEmERKK2qkyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283314; c=relaxed/simple;
	bh=BuH1simZDs3fuGORY7/Oi+jp2g4HWIJGMiVy+fw1PQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vmgq3YuFhvuov2SQmENl8oDDknHsdkhdOX8p3wbEpXlOa2Fyzc6P8pPHgDH9Wn5qfDC964uRqW58eiNh2f20SGeGENhqpS19rCAbM/PSuYOmU6pbyM6dqeBryhtPtXzMDsh8ASw6+6RZ/606MsLtJpn27C3+LkjcHI6JUWn6uPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRL7VjzO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734283311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJJ7f2Q8sadvowiHFao/zRbWGKF04WbV41w3+6C9oBQ=;
	b=hRL7VjzODFO6CzwCgzA4MIkXGWjGU6b5n+lidaSk5+EleYJ7bKZR0J10UqKIllBCX+GcwT
	W6X3VZVCz3GLD78zStEaNi+EwolUBBcYSO9c7d6CHrGWJCyh+tRgzMVH+7c3PqbP+5mz7H
	hgKydkRosJOnhRUUCeZvDgLVKDgWhtU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-d5r1E4h7MBmihN-IKWV0ig-1; Sun,
 15 Dec 2024 12:21:48 -0500
X-MC-Unique: d5r1E4h7MBmihN-IKWV0ig-1
X-Mimecast-MFC-AGG-ID: d5r1E4h7MBmihN-IKWV0ig
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C9DC19560A2;
	Sun, 15 Dec 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F1CE195605A;
	Sun, 15 Dec 2024 17:21:45 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/8] power: supply: ug3105_battery: Switch to adc-battery-helper
Date: Sun, 15 Dec 2024 18:21:27 +0100
Message-ID: <20241215172133.178460-5-hdegoede@redhat.com>
In-Reply-To: <20241215172133.178460-1-hdegoede@redhat.com>
References: <20241215172133.178460-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Switch ug3105_battery to using the new adc-battery-helper, since the
helper's algorithms are a copy of the replaced ug3105_battery code
this should not cause any functional differences.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/Kconfig          |   1 +
 drivers/power/supply/ug3105_battery.c | 391 ++++----------------------
 2 files changed, 63 insertions(+), 329 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3f780aafbbab..6705808b0ec0 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -1000,6 +1000,7 @@ config CHARGER_SURFACE
 config BATTERY_UG3105
 	tristate "uPI uG3105 battery monitor driver"
 	depends on I2C
+	select ADC_BATTERY_HELPER
 	help
 	  Battery monitor driver for the uPI uG3105 battery monitor.
 
diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 38e23bdd4603..3cd0c6944750 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -10,7 +10,22 @@
  * is off or suspended, the coulomb counter is not used atm.
  *
  * Possible improvements:
- * 1. Activate commented out total_coulomb_count code
+ * 1. Add coulumb counter reading, e.g. something like this:
+ * Read + reset coulomb counter every 10 polls (every 300 seconds)
+ *
+ * if ((chip->poll_count % 10) == 0) {
+ *	val = ug3105_read_word(chip->client, UG3105_REG_COULOMB_CNT);
+ *	if (val < 0)
+ *		goto out;
+ *
+ *	i2c_smbus_write_byte_data(chip->client, UG3105_REG_CTRL1,
+ *				  UG3105_CTRL1_RESET_COULOMB_CNT);
+ *
+ *	chip->total_coulomb_count += (s16)val;
+ *	dev_dbg(&chip->client->dev, "coulomb count %d total %d\n",
+ *		(s16)val, chip->total_coulomb_count);
+ * }
+ *
  * 2. Reset total_coulomb_count val to 0 when the battery is as good as empty
  *    and remember that we did this (and clear the flag for this on susp/resume)
  * 3. When the battery is full check if the flag that we set total_coulomb_count
@@ -34,21 +49,13 @@
  * Copyright (C) 2021 Hans de Goede <hdegoede@redhat.com>
  */
 
-#include <linux/devm-helpers.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/power_supply.h>
-#include <linux/workqueue.h>
 
-#define UG3105_MOV_AVG_WINDOW					8
-#define UG3105_INIT_POLL_TIME					(5 * HZ)
-#define UG3105_POLL_TIME					(30 * HZ)
-#define UG3105_SETTLE_TIME					(1 * HZ)
-
-#define UG3105_INIT_POLL_COUNT					30
+#include "adc-battery-helper.h"
 
 #define UG3105_REG_MODE						0x00
 #define UG3105_REG_CTRL1					0x01
@@ -61,33 +68,13 @@
 
 #define UG3105_CTRL1_RESET_COULOMB_CNT				0x03
 
-#define UG3105_CURR_HYST_UA					65000
-
-#define UG3105_LOW_BAT_UV					3700000
-#define UG3105_FULL_BAT_HYST_UV					38000
-
 struct ug3105_chip {
+	/* Must be the first member see adc-battery-helper documentation */
+	struct adc_battery_helper helper;
 	struct i2c_client *client;
 	struct power_supply *psy;
-	struct power_supply_battery_info *info;
-	struct delayed_work work;
-	struct mutex lock;
-	int ocv[UG3105_MOV_AVG_WINDOW];		/* micro-volt */
-	int intern_res[UG3105_MOV_AVG_WINDOW];	/* milli-ohm */
-	int poll_count;
-	int ocv_avg_index;
-	int ocv_avg;				/* micro-volt */
-	int intern_res_poll_count;
-	int intern_res_avg_index;
-	int intern_res_avg;			/* milli-ohm */
-	int volt;				/* micro-volt */
-	int curr;				/* micro-ampere */
-	int total_coulomb_count;
 	int uv_per_unit;
 	int ua_per_unit;
-	int status;
-	int capacity;
-	bool supplied;
 };
 
 static int ug3105_read_word(struct i2c_client *client, u8 reg)
@@ -101,280 +88,43 @@ static int ug3105_read_word(struct i2c_client *client, u8 reg)
 	return val;
 }
 
-static int ug3105_get_status(struct ug3105_chip *chip)
-{
-	int full = chip->info->constant_charge_voltage_max_uv - UG3105_FULL_BAT_HYST_UV;
-
-	if (chip->curr > UG3105_CURR_HYST_UA)
-		return POWER_SUPPLY_STATUS_CHARGING;
-
-	if (chip->curr < -UG3105_CURR_HYST_UA)
-		return POWER_SUPPLY_STATUS_DISCHARGING;
-
-	if (chip->supplied && chip->ocv_avg > full)
-		return POWER_SUPPLY_STATUS_FULL;
-
-	return POWER_SUPPLY_STATUS_NOT_CHARGING;
-}
-
-static int ug3105_get_capacity(struct ug3105_chip *chip)
-{
-	/*
-	 * OCV voltages in uV for 0-110% in 5% increments, the 100-110% is
-	 * for LiPo HV (High-Voltage) bateries which can go up to 4.35V
-	 * instead of the usual 4.2V.
-	 */
-	static const int ocv_capacity_tbl[23] = {
-		3350000,
-		3610000,
-		3690000,
-		3710000,
-		3730000,
-		3750000,
-		3770000,
-		3786667,
-		3803333,
-		3820000,
-		3836667,
-		3853333,
-		3870000,
-		3907500,
-		3945000,
-		3982500,
-		4020000,
-		4075000,
-		4110000,
-		4150000,
-		4200000,
-		4250000,
-		4300000,
-	};
-	int i, ocv_diff, ocv_step;
-
-	if (chip->ocv_avg < ocv_capacity_tbl[0])
-		return 0;
-
-	if (chip->status == POWER_SUPPLY_STATUS_FULL)
-		return 100;
-
-	for (i = 1; i < ARRAY_SIZE(ocv_capacity_tbl); i++) {
-		if (chip->ocv_avg > ocv_capacity_tbl[i])
-			continue;
-
-		ocv_diff = ocv_capacity_tbl[i] - chip->ocv_avg;
-		ocv_step = ocv_capacity_tbl[i] - ocv_capacity_tbl[i - 1];
-		/* scale 0-110% down to 0-100% for LiPo HV */
-		if (chip->info->constant_charge_voltage_max_uv >= 4300000)
-			return (i * 500 - ocv_diff * 500 / ocv_step) / 110;
-		else
-			return i * 5 - ocv_diff * 5 / ocv_step;
-	}
-
-	return 100;
-}
-
-static void ug3105_work(struct work_struct *work)
-{
-	struct ug3105_chip *chip = container_of(work, struct ug3105_chip,
-						work.work);
-	int i, val, curr_diff, volt_diff, res, win_size;
-	bool prev_supplied = chip->supplied;
-	int prev_status = chip->status;
-	int prev_volt = chip->volt;
-	int prev_curr = chip->curr;
-	struct power_supply *psy;
-
-	mutex_lock(&chip->lock);
-
-	psy = chip->psy;
-	if (!psy)
-		goto out;
-
-	val = ug3105_read_word(chip->client, UG3105_REG_BAT_VOLT);
-	if (val < 0)
-		goto out;
-	chip->volt = val * chip->uv_per_unit;
-
-	val = ug3105_read_word(chip->client, UG3105_REG_BAT_CURR);
-	if (val < 0)
-		goto out;
-	chip->curr = (s16)val * chip->ua_per_unit;
-
-	chip->ocv[chip->ocv_avg_index] =
-		chip->volt - chip->curr * chip->intern_res_avg / 1000;
-	chip->ocv_avg_index = (chip->ocv_avg_index + 1) % UG3105_MOV_AVG_WINDOW;
-	chip->poll_count++;
-
-	/*
-	 * See possible improvements comment above.
-	 *
-	 * Read + reset coulomb counter every 10 polls (every 300 seconds)
-	 * if ((chip->poll_count % 10) == 0) {
-	 *	val = ug3105_read_word(chip->client, UG3105_REG_COULOMB_CNT);
-	 *	if (val < 0)
-	 *		goto out;
-	 *
-	 *	i2c_smbus_write_byte_data(chip->client, UG3105_REG_CTRL1,
-	 *				  UG3105_CTRL1_RESET_COULOMB_CNT);
-	 *
-	 *	chip->total_coulomb_count += (s16)val;
-	 *	dev_dbg(&chip->client->dev, "coulomb count %d total %d\n",
-	 *		(s16)val, chip->total_coulomb_count);
-	 * }
-	 */
-
-	chip->ocv_avg = 0;
-	win_size = min(chip->poll_count, UG3105_MOV_AVG_WINDOW);
-	for (i = 0; i < win_size; i++)
-		chip->ocv_avg += chip->ocv[i];
-	chip->ocv_avg /= win_size;
-
-	chip->supplied = power_supply_am_i_supplied(psy);
-	chip->status = ug3105_get_status(chip);
-	chip->capacity = ug3105_get_capacity(chip);
-
-	/*
-	 * Skip internal resistance calc on charger [un]plug and
-	 * when the battery is almost empty (voltage low).
-	 */
-	if (chip->supplied != prev_supplied ||
-	    chip->volt < UG3105_LOW_BAT_UV ||
-	    chip->poll_count < 2)
-		goto out;
-
-	/*
-	 * Assuming that the OCV voltage does not change significantly
-	 * between 2 polls, then we can calculate the internal resistance
-	 * on a significant current change by attributing all voltage
-	 * change between the 2 readings to the internal resistance.
-	 */
-	curr_diff = abs(chip->curr - prev_curr);
-	if (curr_diff < UG3105_CURR_HYST_UA)
-		goto out;
-
-	volt_diff = abs(chip->volt - prev_volt);
-	res = volt_diff * 1000 / curr_diff;
-
-	if ((res < (chip->intern_res_avg * 2 / 3)) ||
-	    (res > (chip->intern_res_avg * 4 / 3))) {
-		dev_dbg(&chip->client->dev, "Ignoring outlier internal resistance %d mOhm\n", res);
-		goto out;
-	}
-
-	dev_dbg(&chip->client->dev, "Internal resistance %d mOhm\n", res);
-
-	chip->intern_res[chip->intern_res_avg_index] = res;
-	chip->intern_res_avg_index = (chip->intern_res_avg_index + 1) % UG3105_MOV_AVG_WINDOW;
-	chip->intern_res_poll_count++;
-
-	chip->intern_res_avg = 0;
-	win_size = min(chip->intern_res_poll_count, UG3105_MOV_AVG_WINDOW);
-	for (i = 0; i < win_size; i++)
-		chip->intern_res_avg += chip->intern_res[i];
-	chip->intern_res_avg /= win_size;
-
-out:
-	mutex_unlock(&chip->lock);
-
-	queue_delayed_work(system_wq, &chip->work,
-			   (chip->poll_count <= UG3105_INIT_POLL_COUNT) ?
-					UG3105_INIT_POLL_TIME : UG3105_POLL_TIME);
-
-	if (chip->status != prev_status && psy)
-		power_supply_changed(psy);
-}
-
-static enum power_supply_property ug3105_battery_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_SCOPE,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_VOLTAGE_OCV,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CAPACITY,
-};
-
-static int ug3105_get_property(struct power_supply *psy,
-			       enum power_supply_property psp,
-			       union power_supply_propval *val)
+static int ug3105_get_voltage_and_current_now(struct power_supply *psy, int *volt, int *curr)
 {
 	struct ug3105_chip *chip = power_supply_get_drvdata(psy);
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&chip->lock);
+	ret = ug3105_read_word(chip->client, UG3105_REG_BAT_VOLT);
+	if (ret < 0)
+		return ret;
 
-	if (!chip->psy) {
-		ret = -EAGAIN;
-		goto out;
-	}
+	*volt = ret * chip->uv_per_unit;
 
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = chip->status;
-		break;
-	case POWER_SUPPLY_PROP_PRESENT:
-		val->intval = 1;
-		break;
-	case POWER_SUPPLY_PROP_SCOPE:
-		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = ug3105_read_word(chip->client, UG3105_REG_BAT_VOLT);
-		if (ret < 0)
-			break;
-		val->intval = ret * chip->uv_per_unit;
-		ret = 0;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
-		val->intval = chip->ocv_avg;
-		break;
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = ug3105_read_word(chip->client, UG3105_REG_BAT_CURR);
-		if (ret < 0)
-			break;
-		val->intval = (s16)ret * chip->ua_per_unit;
-		ret = 0;
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = chip->capacity;
-		break;
-	default:
-		ret = -EINVAL;
-	}
+	ret = ug3105_read_word(chip->client, UG3105_REG_BAT_CURR);
+	if (ret < 0)
+		return ret;
 
-out:
-	mutex_unlock(&chip->lock);
-	return ret;
-}
-
-static void ug3105_external_power_changed(struct power_supply *psy)
-{
-	struct ug3105_chip *chip = power_supply_get_drvdata(psy);
-
-	dev_dbg(&chip->client->dev, "external power changed\n");
-	mod_delayed_work(system_wq, &chip->work, UG3105_SETTLE_TIME);
+	*curr = (s16)ret * chip->ua_per_unit;
+	return 0;
 }
 
 static const struct power_supply_desc ug3105_psy_desc = {
 	.name		= "ug3105_battery",
 	.type		= POWER_SUPPLY_TYPE_BATTERY,
-	.get_property	= ug3105_get_property,
-	.external_power_changed	= ug3105_external_power_changed,
-	.properties	= ug3105_battery_props,
-	.num_properties	= ARRAY_SIZE(ug3105_battery_props),
+	.get_property	= adc_battery_helper_get_property,
+	.external_power_changed	= adc_battery_helper_external_power_changed,
+	.properties	= adc_battery_helper_properties,
+	.num_properties	= ADC_HELPER_NUM_PROPERTIES,
 };
 
-static void ug3105_init(struct ug3105_chip *chip)
+static void ug3105_start(struct i2c_client *client)
 {
-	chip->poll_count = 0;
-	chip->ocv_avg_index = 0;
-	chip->total_coulomb_count = 0;
-	i2c_smbus_write_byte_data(chip->client, UG3105_REG_MODE,
-				  UG3105_MODE_RUN);
-	i2c_smbus_write_byte_data(chip->client, UG3105_REG_CTRL1,
-				  UG3105_CTRL1_RESET_COULOMB_CNT);
-	queue_delayed_work(system_wq, &chip->work, 0);
-	flush_delayed_work(&chip->work);
+	i2c_smbus_write_byte_data(client, UG3105_REG_MODE, UG3105_MODE_RUN);
+	i2c_smbus_write_byte_data(client, UG3105_REG_CTRL1, UG3105_CTRL1_RESET_COULOMB_CNT);
+}
+
+static void ug3105_stop(struct i2c_client *client)
+{
+	i2c_smbus_write_byte_data(client, UG3105_REG_MODE, UG3105_MODE_STANDBY);
 }
 
 static int ug3105_probe(struct i2c_client *client)
@@ -382,7 +132,6 @@ static int ug3105_probe(struct i2c_client *client)
 	struct power_supply_config psy_cfg = {};
 	struct device *dev = &client->dev;
 	u32 curr_sense_res_uohm = 10000;
-	struct power_supply *psy;
 	struct ug3105_chip *chip;
 	int ret;
 
@@ -391,25 +140,8 @@ static int ug3105_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	chip->client = client;
-	mutex_init(&chip->lock);
-	ret = devm_delayed_work_autocancel(dev, &chip->work, ug3105_work);
-	if (ret)
-		return ret;
 
-	psy_cfg.drv_data = chip;
-	psy = devm_power_supply_register(dev, &ug3105_psy_desc, &psy_cfg);
-	if (IS_ERR(psy))
-		return PTR_ERR(psy);
-
-	ret = power_supply_get_battery_info(psy, &chip->info);
-	if (ret)
-		return ret;
-
-	if (chip->info->factory_internal_resistance_uohm == -EINVAL ||
-	    chip->info->constant_charge_voltage_max_uv == -EINVAL) {
-		dev_err(dev, "error required properties are missing\n");
-		return -ENODEV;
-	}
+	ug3105_start(client);
 
 	device_property_read_u32(dev, "upisemi,rsns-microohm", &curr_sense_res_uohm);
 
@@ -417,35 +149,36 @@ static int ug3105_probe(struct i2c_client *client)
 	 * DAC maximum is 4.5V divided by 65536 steps + an unknown factor of 10
 	 * coming from somewhere for some reason (verified with a volt-meter).
 	 */
-	chip->uv_per_unit = 45000000/65536;
+	chip->uv_per_unit = 45000000 / 65536;
 	/* Datasheet says 8.1 uV per unit for the current ADC */
 	chip->ua_per_unit = 8100000 / curr_sense_res_uohm;
 
-	/* Use provided internal resistance as start point (in milli-ohm) */
-	chip->intern_res_avg = chip->info->factory_internal_resistance_uohm / 1000;
-	/* Also add it to the internal resistance moving average window */
-	chip->intern_res[0] = chip->intern_res_avg;
-	chip->intern_res_avg_index = 1;
-	chip->intern_res_poll_count = 1;
+	psy_cfg.drv_data = chip;
+	chip->psy = devm_power_supply_register(dev, &ug3105_psy_desc, &psy_cfg);
+	if (IS_ERR(chip->psy)) {
+		ret = PTR_ERR(chip->psy);
+		goto stop;
+	}
 
-	mutex_lock(&chip->lock);
-	chip->psy = psy;
-	mutex_unlock(&chip->lock);
-
-	ug3105_init(chip);
+	ret = adc_battery_helper_init(&chip->helper, chip->psy,
+				      ug3105_get_voltage_and_current_now);
+	if (ret)
+		goto stop;
 
 	i2c_set_clientdata(client, chip);
 	return 0;
+
+stop:
+	ug3105_stop(client);
+	return ret;
 }
 
 static int __maybe_unused ug3105_suspend(struct device *dev)
 {
 	struct ug3105_chip *chip = dev_get_drvdata(dev);
 
-	cancel_delayed_work_sync(&chip->work);
-	i2c_smbus_write_byte_data(chip->client, UG3105_REG_MODE,
-				  UG3105_MODE_STANDBY);
-
+	adc_battery_helper_suspend(dev);
+	ug3105_stop(chip->client);
 	return 0;
 }
 
@@ -453,8 +186,8 @@ static int __maybe_unused ug3105_resume(struct device *dev)
 {
 	struct ug3105_chip *chip = dev_get_drvdata(dev);
 
-	ug3105_init(chip);
-
+	ug3105_start(chip->client);
+	adc_battery_helper_resume(dev);
 	return 0;
 }
 
-- 
2.47.1


