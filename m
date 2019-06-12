Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFEF41F81
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfFLIoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 04:44:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44530 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbfFLIoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 04:44:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so9224069pfe.11;
        Wed, 12 Jun 2019 01:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sG4UIU5EhIvS7Paz0Cs/sqxuGuvFaBENycwzU6hdp/g=;
        b=ED/xiIBcTRqNRfntDBVbyz8D6MzROJJ2OZteWj32ygsTlJwUrGuu14ZQWhNa9bL6NO
         Kvk/YWL8S+pedoWms1WS4cA9wB91rR0Hsjcjy1WmLOKF29Z7RrVzZV8JW+T4VL0o9nCP
         hWwTK4D9KMwq0+VC0hDlqxXBQHYct3ZQTrIfThieTQEu3f+1ZfdRJLPacyqVobm8q002
         NNS6RxnWnmLgjWpdTB3Aye51r6PeEOoVrownMGZUYbqG/VZ/6CRKJHx2j7KX82XvvFkY
         pPDBj6/XX9pOx3E3H09PAxV9d/wNOWxIVpt/TVSCwVvbabUxKPAtVGKayPlgMVA3jgly
         qMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sG4UIU5EhIvS7Paz0Cs/sqxuGuvFaBENycwzU6hdp/g=;
        b=trDarYdgGMCdlgrZQccilATw00JOSYoMZg35QXplRMkTo5AFrvJDFN5YMjQuW0kTUW
         WKAryd/HsV2BsPLiQ7KFCggQdle7C0F5rEFvsScUlK0ByOc5Lys1fQU4jYinm66daV+6
         0ZT1vixOrX9B7/riXbe6ArfgJzTtIe0/5y769l0CNcUqbOMGkMhXqk5suelhscMmjKmX
         Dt7ltkJ47CABpejCgEA2R/EmGOPvEWXmu4tHGbta0QI82tHW0Z5qQDlT9mxf093++C/G
         660f5XTPD35+ab5VNILKJmZXUJvNRRaqzK7M/gmHdgQWEU23CzwG0XBANEgbPH14+SFN
         978w==
X-Gm-Message-State: APjAAAW7ucgka0gQFjdm7Zh5U8uLRmK65SkmtGUU4Jwbh3lZ2WgGQvmc
        3codCGx5p8WRlUfhWQNe+LhKAQcKVNk=
X-Google-Smtp-Source: APXvYqzFVPTgUdMc4nRLsHtjpORubXJrcgOk6KKmEZsQR1k8aO+YdYlAVCst9kHCn+8bH1lh1fB5cA==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr85359892pfn.92.1560329059284;
        Wed, 12 Jun 2019 01:44:19 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v9sm16372124pfm.34.2019.06.12.01.44.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:44:18 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] power: supply: Add HWMON compatibility layer
Date:   Wed, 12 Jun 2019 01:44:04 -0700
Message-Id: <20190612084404.21685-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612084404.21685-1-andrew.smirnov@gmail.com>
References: <20190612084404.21685-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add code implementing HWMON adapter/compatibility layer to allow
expositing various sensors present on power supply devices via HWMON
subsystem. This is done in order to allow userspace to use single
ABI/library(libsensors) to access/manipulate all of the sensors of the
system.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Chris Healy <cphealy@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/Kconfig              |  14 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/power_supply_core.c  |   7 +
 drivers/power/supply/power_supply_hwmon.c | 355 ++++++++++++++++++++++
 include/linux/power_supply.h              |  13 +
 5 files changed, 390 insertions(+)
 create mode 100644 drivers/power/supply/power_supply_hwmon.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index c614c8a196f3..0550cedb53c9 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -14,6 +14,20 @@ config POWER_SUPPLY_DEBUG
 	  Say Y here to enable debugging messages for power supply class
 	  and drivers.
 
+config POWER_SUPPLY_HWMON
+	bool
+	prompt "Expose power supply sensors as hwmon device"
+	depends on HWMON=y || HWMON=POWER_SUPPLY
+	default y
+	help
+	  This options enables API that allows sensors found on a
+	  power supply device (current, voltage, temperature) to be
+	  exposed as a hwmon device.
+
+	  Say 'Y' here if you want power supplies to
+	  have hwmon sysfs interface too.
+
+
 config PDA_POWER
 	tristate "Generic PDA/phone power driver"
 	depends on !S390
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index c56803a9e4fe..0a87cfe49b21 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -6,6 +6,7 @@ power_supply-$(CONFIG_SYSFS)		+= power_supply_sysfs.o
 power_supply-$(CONFIG_LEDS_TRIGGERS)	+= power_supply_leds.o
 
 obj-$(CONFIG_POWER_SUPPLY)	+= power_supply.o
+obj-$(CONFIG_POWER_SUPPLY_HWMON) += power_supply_hwmon.o
 obj-$(CONFIG_GENERIC_ADC_BATTERY)	+= generic-adc-battery.o
 
 obj-$(CONFIG_PDA_POWER)		+= pda_power.o
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c917a8b43b2b..67e78538bb9c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1062,6 +1062,10 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto create_triggers_failed;
 
+	rc = power_supply_add_hwmon_sysfs(psy);
+	if (rc)
+		goto add_hwmon_sysfs_failed;
+
 	/*
 	 * Update use_cnt after any uevents (most notably from device_add()).
 	 * We are here still during driver's probe but
@@ -1080,6 +1084,8 @@ __power_supply_register(struct device *parent,
 
 	return psy;
 
+add_hwmon_sysfs_failed:
+	power_supply_remove_triggers(psy);
 create_triggers_failed:
 	psy_unregister_cooler(psy);
 register_cooler_failed:
@@ -1232,6 +1238,7 @@ void power_supply_unregister(struct power_supply *psy)
 	cancel_work_sync(&psy->changed_work);
 	cancel_delayed_work_sync(&psy->deferred_register_work);
 	sysfs_remove_link(&psy->dev.kobj, "powers");
+	power_supply_remove_hwmon_sysfs(psy);
 	power_supply_remove_triggers(psy);
 	psy_unregister_cooler(psy);
 	psy_unregister_thermal(psy);
diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
new file mode 100644
index 000000000000..51fe60440d12
--- /dev/null
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  power_supply_hwmon.c - power supply hwmon support.
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+
+struct power_supply_hwmon {
+	struct power_supply *psy;
+	unsigned long *props;
+};
+
+static int power_supply_hwmon_in_to_property(u32 attr)
+{
+	switch (attr) {
+	case hwmon_in_average:
+		return POWER_SUPPLY_PROP_VOLTAGE_AVG;
+	case hwmon_in_min:
+		return POWER_SUPPLY_PROP_VOLTAGE_MIN;
+	case hwmon_in_max:
+		return POWER_SUPPLY_PROP_VOLTAGE_MAX;
+	case hwmon_in_input:
+		return POWER_SUPPLY_PROP_VOLTAGE_NOW;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int power_supply_hwmon_curr_to_property(u32 attr)
+{
+	switch (attr) {
+	case hwmon_curr_average:
+		return POWER_SUPPLY_PROP_CURRENT_AVG;
+	case hwmon_curr_max:
+		return POWER_SUPPLY_PROP_CURRENT_MAX;
+	case hwmon_curr_input:
+		return POWER_SUPPLY_PROP_CURRENT_NOW;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
+{
+	if (channel) {
+		switch (attr) {
+		case hwmon_temp_input:
+			return POWER_SUPPLY_PROP_TEMP_AMBIENT;
+		case hwmon_temp_min_alarm:
+			return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN;
+		case hwmon_temp_max_alarm:
+			return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX;
+		default:
+			break;
+		}
+	} else {
+		switch (attr) {
+		case hwmon_temp_input:
+			return POWER_SUPPLY_PROP_TEMP;
+		case hwmon_temp_max:
+			return POWER_SUPPLY_PROP_TEMP_MAX;
+		case hwmon_temp_min:
+			return POWER_SUPPLY_PROP_TEMP_MIN;
+		case hwmon_temp_min_alarm:
+			return POWER_SUPPLY_PROP_TEMP_ALERT_MIN;
+		case hwmon_temp_max_alarm:
+			return POWER_SUPPLY_PROP_TEMP_ALERT_MAX;
+		default:
+			break;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int
+power_supply_hwmon_to_property(enum hwmon_sensor_types type,
+			       u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_in:
+		return power_supply_hwmon_in_to_property(attr);
+	case hwmon_curr:
+		return power_supply_hwmon_curr_to_property(attr);
+	case hwmon_temp:
+		return power_supply_hwmon_temp_to_property(attr, channel);
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
+					   u32 attr)
+{
+	return type == hwmon_temp && attr == hwmon_temp_label;
+}
+
+static bool power_supply_hwmon_is_writable(enum hwmon_sensor_types type,
+					   u32 attr)
+{
+	switch (type) {
+	case hwmon_in:
+		return attr == hwmon_in_min ||
+		       attr == hwmon_in_max;
+	case hwmon_curr:
+		return attr == hwmon_curr_max;
+	case hwmon_temp:
+		return attr == hwmon_temp_max ||
+		       attr == hwmon_temp_min ||
+		       attr == hwmon_temp_min_alarm ||
+		       attr == hwmon_temp_max_alarm;
+	default:
+		return false;
+	}
+}
+
+static umode_t power_supply_hwmon_is_visible(const void *data,
+					     enum hwmon_sensor_types type,
+					     u32 attr, int channel)
+{
+	const struct power_supply_hwmon *psyhw = data;
+	int prop;
+
+
+	if (power_supply_hwmon_is_a_label(type, attr))
+		return 0444;
+
+	prop = power_supply_hwmon_to_property(type, attr, channel);
+	if (prop < 0 || !test_bit(prop, psyhw->props))
+		return 0;
+
+	if (power_supply_property_is_writeable(psyhw->psy, prop) > 0 &&
+	    power_supply_hwmon_is_writable(type, attr))
+		return 0644;
+
+	return 0444;
+}
+
+static int power_supply_hwmon_read_string(struct device *dev,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel,
+					  const char **str)
+{
+	*str = channel ? "temp" : "temp ambient";
+	return 0;
+}
+
+static int
+power_supply_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
+	struct power_supply *psy = psyhw->psy;
+	union power_supply_propval pspval;
+	int ret, prop;
+
+	prop = power_supply_hwmon_to_property(type, attr, channel);
+	if (prop < 0)
+		return prop;
+
+	ret  = power_supply_get_property(psy, prop, &pspval);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	/*
+	 * Both voltage and current is reported in units of
+	 * microvolts/microamps, so we need to adjust it to
+	 * milliamps(volts)
+	 */
+	case hwmon_curr:
+	case hwmon_in:
+		pspval.intval = DIV_ROUND_CLOSEST(pspval.intval, 1000);
+		break;
+	/*
+	 * Temp needs to be converted from 1/10 C to milli-C
+	 */
+	case hwmon_temp:
+		if (check_mul_overflow(pspval.intval, 100,
+				       &pspval.intval))
+			return -EOVERFLOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*val = pspval.intval;
+
+	return 0;
+}
+
+static int
+power_supply_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
+	struct power_supply *psy = psyhw->psy;
+	union power_supply_propval pspval;
+	int prop;
+
+	prop = power_supply_hwmon_to_property(type, attr, channel);
+	if (prop < 0)
+		return prop;
+
+	pspval.intval = val;
+
+	switch (type) {
+	/*
+	 * Both voltage and current is reported in units of
+	 * microvolts/microamps, so we need to adjust it to
+	 * milliamps(volts)
+	 */
+	case hwmon_curr:
+	case hwmon_in:
+		if (check_mul_overflow(pspval.intval, 1000,
+				       &pspval.intval))
+			return -EOVERFLOW;
+		break;
+	/*
+	 * Temp needs to be converted from 1/10 C to milli-C
+	 */
+	case hwmon_temp:
+		pspval.intval = DIV_ROUND_CLOSEST(pspval.intval, 100);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return power_supply_set_property(psy, prop, &pspval);
+}
+
+static const struct hwmon_ops power_supply_hwmon_ops = {
+	.is_visible	= power_supply_hwmon_is_visible,
+	.read		= power_supply_hwmon_read,
+	.write		= power_supply_hwmon_write,
+	.read_string	= power_supply_hwmon_read_string,
+};
+
+static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_LABEL     |
+			   HWMON_T_INPUT     |
+			   HWMON_T_MAX       |
+			   HWMON_T_MIN       |
+			   HWMON_T_MIN_ALARM |
+			   HWMON_T_MIN_ALARM,
+
+			   HWMON_T_LABEL     |
+			   HWMON_T_INPUT     |
+			   HWMON_T_MIN_ALARM |
+			   HWMON_T_LABEL     |
+			   HWMON_T_MAX_ALARM),
+
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_AVERAGE |
+			   HWMON_C_MAX     |
+			   HWMON_C_INPUT),
+
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_AVERAGE |
+			   HWMON_I_MIN     |
+			   HWMON_I_MAX     |
+			   HWMON_I_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
+	.ops = &power_supply_hwmon_ops,
+	.info = power_supply_hwmon_info,
+};
+
+static void power_supply_hwmon_bitmap_free(void *data)
+{
+	bitmap_free(data);
+}
+
+int power_supply_add_hwmon_sysfs(struct power_supply *psy)
+{
+	const struct power_supply_desc *desc = psy->desc;
+	struct power_supply_hwmon *psyhw;
+	struct device *dev = &psy->dev;
+	struct device *hwmon;
+	int ret, i;
+
+	if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
+			       GFP_KERNEL))
+		return -ENOMEM;
+
+	psyhw = devm_kzalloc(dev, sizeof(*psyhw), GFP_KERNEL);
+	if (!psyhw) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	psyhw->psy = psy;
+	psyhw->props = bitmap_zalloc(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
+				     GFP_KERNEL);
+	if (!psyhw->props) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
+			      psyhw->props);
+	if (ret)
+		goto error;
+
+	for (i = 0; i < desc->num_properties; i++) {
+		const enum power_supply_property prop = desc->properties[i];
+
+		switch (prop) {
+		case POWER_SUPPLY_PROP_CURRENT_AVG:
+		case POWER_SUPPLY_PROP_CURRENT_MAX:
+		case POWER_SUPPLY_PROP_CURRENT_NOW:
+		case POWER_SUPPLY_PROP_TEMP:
+		case POWER_SUPPLY_PROP_TEMP_MAX:
+		case POWER_SUPPLY_PROP_TEMP_MIN:
+		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
+		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
+		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
+		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+			set_bit(prop, psyhw->props);
+			break;
+		default:
+			break;
+		}
+	}
+
+	hwmon = devm_hwmon_device_register_with_info(dev, psy->desc->name,
+						psyhw,
+						&power_supply_hwmon_chip_info,
+						NULL);
+	ret = PTR_ERR_OR_ZERO(hwmon);
+	if (ret)
+		goto error;
+
+	devres_close_group(dev, power_supply_add_hwmon_sysfs);
+	return 0;
+error:
+	devres_release_group(dev, NULL);
+	return ret;
+}
+
+void power_supply_remove_hwmon_sysfs(struct power_supply *psy)
+{
+	devres_release_group(&psy->dev, power_supply_add_hwmon_sysfs);
+}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index bdab14c7ca4d..f850d4110935 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -475,4 +475,17 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
 	return 0;
 }
 
+#ifdef CONFIG_POWER_SUPPLY_HWMON
+int power_supply_add_hwmon_sysfs(struct power_supply *psy);
+void power_supply_remove_hwmon_sysfs(struct power_supply *psy);
+#else
+static inline int power_supply_add_hwmon_sysfs(struct power_supply *psy)
+{
+	return 0;
+}
+
+static inline
+void power_supply_remove_hwmon_sysfs(struct power_supply *psy) {}
+#endif
+
 #endif /* __LINUX_POWER_SUPPLY_H__ */
-- 
2.21.0

