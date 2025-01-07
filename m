Return-Path: <linux-pm+bounces-20025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B597BA03DD2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0307A265F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B7E1DB951;
	Tue,  7 Jan 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPX9G/S6"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5F1DF73A
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249637; cv=none; b=lEE3afGkRwBw9WJLo5hvXEe6fPL2Qr8+8OJPHrZE8PC8pZmn9JUTr3jCPMdSm5La308LgYIzZXluZBfShSvamX16CgQgYnoHWiW02A6S0RxQxwMqHEDjRPs8Ci5y/Jq8VLaZxevuhlZSLljSB0B+Zme0kqMl0cigXWfzZFon7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249637; c=relaxed/simple;
	bh=T6qPv0Z2cVXWveUwMWBug7xqsc0VMrwbPw7boBD/cvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oH8pzaZ4SQsZUiV+gdDji/iUkTqxxsxOpzDscTteR4JCHscZJNH8dkOCW4VFMIjleH8LeQdHdPqyfuaHeffbi2yeQMuqk2n31h2xFJBAdmZrv89XD4qYfJa3mIK4gzJNRi4IPX9+i/GkVuClPdiCP+9gQU7dm60h+glmFx++LwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPX9G/S6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736249633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI04Sl7fDp33wVzGC6ufAmU1v9xasBNcVEwSo3ttx9A=;
	b=CPX9G/S6Y0U/JDqeQl26YiuOTPhmfDHTw++kSXX00LE2yL0BeRTzoLRRNWhZsI/LoBV28B
	nRUEGyw6VsNmCCcNdpfm3/b7G0ZHH+T/jMYn/Wv7jsMgir51aO0UR1eA7zNZkqW3RyM8uM
	SKwrRlhGk+7VKlk3j/pJl8YFXWz4ZHc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-Dxh1JmhvNpCGKYtUf1rCMw-1; Tue,
 07 Jan 2025 06:33:51 -0500
X-MC-Unique: Dxh1JmhvNpCGKYtUf1rCMw-1
X-Mimecast-MFC-AGG-ID: Dxh1JmhvNpCGKYtUf1rCMw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC72719560A6;
	Tue,  7 Jan 2025 11:33:50 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.144])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADFDC3000197;
	Tue,  7 Jan 2025 11:33:49 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/6] power: supply: Add adc-battery-helper
Date: Tue,  7 Jan 2025 12:33:41 +0100
Message-ID: <20250107113346.170612-2-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-1-hdegoede@redhat.com>
References: <20250107113346.170612-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The TI PMIC used on some Intel Bay/Cherry Trail systems has some builtin
fuel-gauge functionality which just like the UG3105 fuel-gauge is not
a full featured autonomous fuel-gauge.

These fuel-gauges offer accurate current and voltage measurements but
their coulomb-counters are intended to work together with an always on
micro-controller monitoring the fuel-gauge.

Add an adc-battery-helper offering capacity estimation for devices where
such limited functionality fuel-gauges are exposed directly to Linux.

This is a copy of the existing UG3105 capacity estimating code, generalized
so that it can be re-used in other drivers.

The next commit will replace the UG3105 driver's version of this code with
using the adc-battery-helper.

The API has been designed for easy integration into existing power-supply
drivers. For example this functionality might also be a useful addition
to the generic-adc-battery driver.

The requirement of needing the adc_battery_helper struct to be the first
member of a battery driver's data struct is not ideal. This is a compromise
which is necessary to allow directly using the helper's get_property(),
external_power_changed() and suspend()/resume() functions as power-supply /
suspend-resume callbacks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add missing MODULE_DESCRIPTION()
---
 drivers/power/supply/Kconfig              |   3 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/adc-battery-helper.c | 360 ++++++++++++++++++++++
 drivers/power/supply/adc-battery-helper.h |  58 ++++
 4 files changed, 422 insertions(+)
 create mode 100644 drivers/power/supply/adc-battery-helper.c
 create mode 100644 drivers/power/supply/adc-battery-helper.h

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 7b18358f194a..f4833ee567aa 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -35,6 +35,9 @@ config APM_POWER
 	  Say Y here to enable support APM status emulation using
 	  battery class devices.
 
+config ADC_BATTERY_HELPER
+	tristate
+
 config GENERIC_ADC_BATTERY
 	tristate "Generic battery support using IIO"
 	depends on IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b55cc48a4c86..d80390e2749c 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -7,6 +7,7 @@ power_supply-$(CONFIG_LEDS_TRIGGERS)	+= power_supply_leds.o
 
 obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
 obj-$(CONFIG_POWER_SUPPLY_HWMON) += power_supply_hwmon.o
+obj-$(CONFIG_ADC_BATTERY_HELPER) += adc-battery-helper.o
 obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
 
 obj-$(CONFIG_APM_POWER)		+= apm_power.o
diff --git a/drivers/power/supply/adc-battery-helper.c b/drivers/power/supply/adc-battery-helper.c
new file mode 100644
index 000000000000..089ed919410c
--- /dev/null
+++ b/drivers/power/supply/adc-battery-helper.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Helper to add capacity estimation to batteries with current and voltage measurement
+ *
+ * Some fuel-gauges are not full-featured autonomous fuel-gauges.
+ * These fuel-gauges offer accurate current and voltage measurements but
+ * their coulomb-counters are intended to work together with an always on
+ * micro-controller monitoring the fuel-gauge.
+ *
+ * This adc-battery-helper code offers capacity estimation for devices where
+ * such limited functionality fuel-gauges are exposed directly to Linux.
+ * This helper requires the hw to provide accurate battery current_now and
+ * voltage_now measurement and this helper the provides the following properties
+ * based on top of those readings:
+ *
+ *	POWER_SUPPLY_PROP_STATUS
+ *	POWER_SUPPLY_PROP_VOLTAGE_OCV
+ *	POWER_SUPPLY_PROP_VOLTAGE_NOW
+ *	POWER_SUPPLY_PROP_CURRENT_NOW
+ *	POWER_SUPPLY_PROP_CAPACITY
+ *
+ * As well as optional the following properties assuming an always present
+ * system-scope battery, allowing direct use of adc_battery_helper_get_prop()
+ * in this common case:
+ *	POWER_SUPPLY_PROP_PRESENT
+ *	POWER_SUPPLY_PROP_SCOPE
+ *
+ * Using this helper is as simple as:
+ *
+ * 1. Embed a struct adc_battery_helper this MUST be the first member of
+ *    the battery driver's data struct.
+ * 2. Use adc_battery_helper_props[] or add the above properties to
+ *    the list of properties in power_supply_desc
+ * 3. Call adc_battery_helper_init() after registering the power_supply and
+ *    before returning from the probe() function
+ * 4. Use adc_battery_helper_get_prop() as the power-supply's get_property()
+ *    method, or call it for the above properties.
+ * 5. Use adc_battery_helper_external_power_changed() as the power-supply's
+ *    external_power_changed() method or call it from that method.
+ * 6. Use adc_battery_helper_[suspend|resume]() as suspend-resume methods or
+ *    call them from the driver's suspend-resume methods.
+ *
+ * The provided get_voltage_and_current_now() method will be called by this
+ * helper at adc_battery_helper_init() time and later.
+ *
+ * Copyright (c) 2021-2024 Hans de Goede <hansg@kernel.org>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/devm-helpers.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <linux/workqueue.h>
+
+#include "adc-battery-helper.h"
+
+#define MOV_AVG_WINDOW						8
+#define INIT_POLL_TIME						(5 * HZ)
+#define POLL_TIME						(30 * HZ)
+#define SETTLE_TIME						(1 * HZ)
+
+#define INIT_POLL_COUNT						30
+
+#define CURR_HYST_UA						65000
+
+#define LOW_BAT_UV						3700000
+#define FULL_BAT_HYST_UV					38000
+
+static int adc_battery_helper_get_status(struct adc_battery_helper *help)
+{
+	int full_uv =
+		help->psy->battery_info->constant_charge_voltage_max_uv - FULL_BAT_HYST_UV;
+
+	if (help->curr_ua > CURR_HYST_UA)
+		return POWER_SUPPLY_STATUS_CHARGING;
+
+	if (help->curr_ua < -CURR_HYST_UA)
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+
+	if (help->supplied && help->ocv_avg_uv > full_uv)
+		return POWER_SUPPLY_STATUS_FULL;
+
+	return POWER_SUPPLY_STATUS_NOT_CHARGING;
+}
+
+static int adc_battery_helper_get_capacity(struct adc_battery_helper *help)
+{
+	/*
+	 * OCV voltages in uV for 0-110% in 5% increments, the 100-110% is
+	 * for LiPo HV (High-Voltage) bateries which can go up to 4.35V
+	 * instead of the usual 4.2V.
+	 */
+	static const int ocv_capacity_tbl[23] = {
+		3350000,
+		3610000,
+		3690000,
+		3710000,
+		3730000,
+		3750000,
+		3770000,
+		3786667,
+		3803333,
+		3820000,
+		3836667,
+		3853333,
+		3870000,
+		3907500,
+		3945000,
+		3982500,
+		4020000,
+		4075000,
+		4110000,
+		4150000,
+		4200000,
+		4250000,
+		4300000,
+	};
+	int i, ocv_diff, ocv_step;
+
+	if (help->ocv_avg_uv < ocv_capacity_tbl[0])
+		return 0;
+
+	if (help->status == POWER_SUPPLY_STATUS_FULL)
+		return 100;
+
+	for (i = 1; i < ARRAY_SIZE(ocv_capacity_tbl); i++) {
+		if (help->ocv_avg_uv > ocv_capacity_tbl[i])
+			continue;
+
+		ocv_diff = ocv_capacity_tbl[i] - help->ocv_avg_uv;
+		ocv_step = ocv_capacity_tbl[i] - ocv_capacity_tbl[i - 1];
+		/* scale 0-110% down to 0-100% for LiPo HV */
+		if (help->psy->battery_info->constant_charge_voltage_max_uv >= 4300000)
+			return (i * 500 - ocv_diff * 500 / ocv_step) / 110;
+		else
+			return i * 5 - ocv_diff * 5 / ocv_step;
+	}
+
+	return 100;
+}
+
+static void adc_battery_helper_work(struct work_struct *work)
+{
+	struct adc_battery_helper *help = container_of(work, struct adc_battery_helper,
+						       work.work);
+	int i, curr_diff_ua, volt_diff_uv, res, ret, win_size;
+	struct device *dev = help->psy->dev.parent;
+	int volt_uv, prev_volt_uv = help->volt_uv;
+	int curr_ua, prev_curr_ua = help->curr_ua;
+	bool prev_supplied = help->supplied;
+	int prev_status = help->status;
+
+	guard(mutex)(&help->lock);
+
+	ret = help->get_voltage_and_current_now(help->psy, &volt_uv, &curr_ua);
+	if (ret)
+		goto out;
+
+	help->volt_uv = volt_uv;
+	help->curr_ua = curr_ua;
+
+	help->ocv_uv[help->ocv_avg_index] =
+		help->volt_uv - help->curr_ua * help->intern_res_avg_mohm / 1000;
+	dev_dbg(dev, "volt-now: %d, curr-now: %d, volt-ocv: %d\n",
+		help->volt_uv, help->curr_ua, help->ocv_uv[help->ocv_avg_index]);
+	help->ocv_avg_index = (help->ocv_avg_index + 1) % MOV_AVG_WINDOW;
+	help->poll_count++;
+
+	help->ocv_avg_uv = 0;
+	win_size = min(help->poll_count, MOV_AVG_WINDOW);
+	for (i = 0; i < win_size; i++)
+		help->ocv_avg_uv += help->ocv_uv[i];
+	help->ocv_avg_uv /= win_size;
+
+	help->supplied = power_supply_am_i_supplied(help->psy);
+	help->status = adc_battery_helper_get_status(help);
+	help->capacity = adc_battery_helper_get_capacity(help);
+
+	/*
+	 * Skip internal resistance calc on charger [un]plug and
+	 * when the battery is almost empty (voltage low).
+	 */
+	if (help->supplied != prev_supplied ||
+	    help->volt_uv < LOW_BAT_UV ||
+	    help->poll_count < 2)
+		goto out;
+
+	/*
+	 * Assuming that the OCV voltage does not change significantly
+	 * between 2 polls, then we can calculate the internal resistance
+	 * on a significant current change by attributing all voltage
+	 * change between the 2 readings to the internal resistance.
+	 */
+	curr_diff_ua = abs(help->curr_ua - prev_curr_ua);
+	if (curr_diff_ua < CURR_HYST_UA)
+		goto out;
+
+	volt_diff_uv = abs(help->volt_uv - prev_volt_uv);
+	res = volt_diff_uv * 1000 / curr_diff_ua;
+
+	if ((res < (help->intern_res_avg_mohm * 2 / 3)) ||
+	    (res > (help->intern_res_avg_mohm * 4 / 3))) {
+		dev_dbg(dev, "Ignoring outlier internal resistance %d mOhm\n", res);
+		goto out;
+	}
+
+	dev_dbg(dev, "Internal resistance %d mOhm\n", res);
+
+	help->intern_res_mohm[help->intern_res_avg_index] = res;
+	help->intern_res_avg_index = (help->intern_res_avg_index + 1) % MOV_AVG_WINDOW;
+	help->intern_res_poll_count++;
+
+	help->intern_res_avg_mohm = 0;
+	win_size = min(help->intern_res_poll_count, MOV_AVG_WINDOW);
+	for (i = 0; i < win_size; i++)
+		help->intern_res_avg_mohm += help->intern_res_mohm[i];
+	help->intern_res_avg_mohm /= win_size;
+
+out:
+	queue_delayed_work(system_wq, &help->work,
+			   (help->poll_count <= INIT_POLL_COUNT) ?
+					INIT_POLL_TIME : POLL_TIME);
+
+	if (help->status != prev_status)
+		power_supply_changed(help->psy);
+}
+
+const enum power_supply_property adc_battery_helper_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_SCOPE,
+};
+EXPORT_SYMBOL_GPL(adc_battery_helper_properties);
+
+static_assert(ARRAY_SIZE(adc_battery_helper_properties) ==
+	      ADC_HELPER_NUM_PROPERTIES);
+
+int adc_battery_helper_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct adc_battery_helper *help = power_supply_get_drvdata(psy);
+	int dummy, ret = 0;
+
+	/*
+	 * Avoid racing with adc_battery_helper_work() while it is updating
+	 * variables and avoid calling get_voltage_and_current_now() reentrantly.
+	 */
+	guard(mutex)(&help->lock);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = help->status;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = help->get_voltage_and_current_now(psy, &val->intval, &dummy);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = help->ocv_avg_uv;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = help->get_voltage_and_current_now(psy, &dummy, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = help->capacity;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(adc_battery_helper_get_property);
+
+void adc_battery_helper_external_power_changed(struct power_supply *psy)
+{
+	struct adc_battery_helper *help = power_supply_get_drvdata(psy);
+
+	dev_dbg(help->psy->dev.parent, "external power changed\n");
+	mod_delayed_work(system_wq, &help->work, SETTLE_TIME);
+}
+EXPORT_SYMBOL_GPL(adc_battery_helper_external_power_changed);
+
+static void adc_battery_helper_start_work(struct adc_battery_helper *help)
+{
+	help->poll_count = 0;
+	help->ocv_avg_index = 0;
+
+	queue_delayed_work(system_wq, &help->work, 0);
+	flush_delayed_work(&help->work);
+}
+
+int adc_battery_helper_init(struct adc_battery_helper *help, struct power_supply *psy,
+			    adc_battery_helper_get_func get_voltage_and_current_now)
+{
+	struct device *dev = psy->dev.parent;
+	int ret;
+
+	help->psy = psy;
+	help->get_voltage_and_current_now = get_voltage_and_current_now;
+
+	ret = devm_mutex_init(dev, &help->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_delayed_work_autocancel(dev, &help->work, adc_battery_helper_work);
+	if (ret)
+		return ret;
+
+	if (!help->psy->battery_info ||
+	    help->psy->battery_info->factory_internal_resistance_uohm == -EINVAL ||
+	    help->psy->battery_info->constant_charge_voltage_max_uv == -EINVAL) {
+		dev_err(dev, "error required properties are missing\n");
+		return -ENODEV;
+	}
+
+	/* Use provided internal resistance as start point (in milli-ohm) */
+	help->intern_res_avg_mohm =
+		help->psy->battery_info->factory_internal_resistance_uohm / 1000;
+	/* Also add it to the internal resistance moving average window */
+	help->intern_res_mohm[0] = help->intern_res_avg_mohm;
+	help->intern_res_avg_index = 1;
+	help->intern_res_poll_count = 1;
+
+	adc_battery_helper_start_work(help);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adc_battery_helper_init);
+
+int adc_battery_helper_suspend(struct device *dev)
+{
+	struct adc_battery_helper *help = dev_get_drvdata(dev);
+
+	cancel_delayed_work_sync(&help->work);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adc_battery_helper_suspend);
+
+int adc_battery_helper_resume(struct device *dev)
+{
+	struct adc_battery_helper *help = dev_get_drvdata(dev);
+
+	adc_battery_helper_start_work(help);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adc_battery_helper_resume);
+
+MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
+MODULE_DESCRIPTION("ADC battery capacity estimation helper");
+MODULE_LICENSE("GPL");
diff --git a/drivers/power/supply/adc-battery-helper.h b/drivers/power/supply/adc-battery-helper.h
new file mode 100644
index 000000000000..2a13c64eadf1
--- /dev/null
+++ b/drivers/power/supply/adc-battery-helper.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Helper to add capacity estimation to batteries with current and voltage measurement
+ * Copyright (c) 2021-2024 Hans de Goede <hansg@kernel.org>
+ */
+
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+
+#define ADC_BAT_HELPER_MOV_AVG_WINDOW				8
+
+struct power_supply;
+
+/*
+ * The adc battery helper code needs voltage- and current-now to be sampled as
+ * close to each other (in sample-time) as possible. A single getter function is
+ * used to allow the battery driver to handle this in the best way possible.
+ */
+typedef int (*adc_battery_helper_get_func)(struct power_supply *psy, int *volt, int *curr);
+
+struct adc_battery_helper {
+	struct power_supply *psy;
+	struct delayed_work work;
+	struct mutex lock;
+	adc_battery_helper_get_func get_voltage_and_current_now;
+	int ocv_uv[ADC_BAT_HELPER_MOV_AVG_WINDOW];		/* micro-volt */
+	int intern_res_mohm[ADC_BAT_HELPER_MOV_AVG_WINDOW];	/* milli-ohm */
+	int poll_count;
+	int ocv_avg_index;
+	int ocv_avg_uv;						/* micro-volt */
+	int intern_res_poll_count;
+	int intern_res_avg_index;
+	int intern_res_avg_mohm;				/* milli-ohm */
+	int volt_uv;						/* micro-volt */
+	int curr_ua;						/* micro-ampere */
+	int capacity;						/* procent */
+	int status;
+	bool supplied;
+};
+
+extern const enum power_supply_property adc_battery_helper_properties[];
+/* Must be const cannot be an external. Asserted in adc-battery-helper.c */
+#define ADC_HELPER_NUM_PROPERTIES 7
+
+int adc_battery_helper_init(struct adc_battery_helper *help, struct power_supply *psy,
+			    adc_battery_helper_get_func get_voltage_and_current_now);
+/*
+ * The below functions can be directly used as power-supply / suspend-resume
+ * callbacks. They cast the power_supply_get_drvdata() / dev_get_drvdata() data
+ * directly to struct adc_battery_helper. Therefor struct adc_battery_helper
+ * MUST be the first member of the battery driver's data struct.
+ */
+int adc_battery_helper_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val);
+void adc_battery_helper_external_power_changed(struct power_supply *psy);
+int adc_battery_helper_suspend(struct device *dev);
+int adc_battery_helper_resume(struct device *dev);
-- 
2.47.1


