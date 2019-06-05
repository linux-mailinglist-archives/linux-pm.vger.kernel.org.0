Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761DD3579F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFEHXq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 03:23:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34671 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEHXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 03:23:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so5027031plt.1;
        Wed, 05 Jun 2019 00:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6AizvKQ1Y8TruPfcFY9yaE6FqwESZeHoinUgO4FE3E=;
        b=a9hSCM0pTrG8GxsSancV/aJ4hr0gZA8rlXbRuscF7hCkLbD08BZONDij10AsuoreIo
         Xh39I7cBl/BOGpgUFYu+WBfspktNYhqB7YyAh7uZZYYMRnr0LrLiBXJR//qXI4S7riGk
         gq2ImX8fwhK4XiXu2GN0X80Bx/UDl35li/SeNUGYySbGYwCAtkr/0YTqfQjBYMN1/Ftl
         mjIizLNHTpdRZ2qBm0wr8t6QoOMqpI89k5Bcev74Cu9IeGZqwwwwtPU/N7cDIh0mufon
         bmCpCIMmX3oZLqkboDobh75Ge5/10v462k7TorP8XgnHhh4gaxxzNnQfN5UlFTi95C9Y
         T75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6AizvKQ1Y8TruPfcFY9yaE6FqwESZeHoinUgO4FE3E=;
        b=YxxEv9C1PPnW7tSOvpGumlU1TotjtClef28lEA37uAhRmIQu4C9DT5/YD6eCL2zTJ5
         854YnH0NR0b2LqBtq2eVgn8oUk8k3ufdMbiXh3ozvQsmPfxcX7sx2le6HYuvO5WURpz9
         5bEFujPpWZYXlTqgZKndnsRJ/EoT07zSdZBh+6TOi8NTqUuLAMcKWbKVdfsBCqn+lm5Z
         opBpeKiZUnkRMm6htAu9CA6KpDdTgqIVubSgeiparLlLg9XXbVTnFhNY2Z/f992e9CmM
         8UcZWawrI9OFt/IPGYiMFpRGA9zKOCMUkAny+6yv9QgB37R/aio4QA7ItPTeGMudBWev
         /ddQ==
X-Gm-Message-State: APjAAAX+dVCa+5k37BP/9sm+qscvTJdgX0fSE3plbPC5rIisLRM6xBk0
        CINpOs5huR7xU5GL3FxYUuczAnDXZkc=
X-Google-Smtp-Source: APXvYqwDGOkbb01UyFhtjflmCFKWZH6s+UBC/pVDQKNrRpzs6hY51djfvJsvM4CktJx+DiMd1HcN/Q==
X-Received: by 2002:a17:902:7295:: with SMTP id d21mr28616612pll.299.1559719423240;
        Wed, 05 Jun 2019 00:23:43 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i4sm1027404pjd.31.2019.06.05.00.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:23:42 -0700 (PDT)
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
Subject: [PATCH v3 1/2] power: supply: Add HWMON compatibility layer
Date:   Wed,  5 Jun 2019 00:23:22 -0700
Message-Id: <20190605072323.21990-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605072323.21990-1-andrew.smirnov@gmail.com>
References: <20190605072323.21990-1-andrew.smirnov@gmail.com>
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
 drivers/power/supply/power_supply_hwmon.c | 349 ++++++++++++++++++++++
 include/linux/power_supply.h              |   9 +
 4 files changed, 373 insertions(+)
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
diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
new file mode 100644
index 000000000000..3451b997367d
--- /dev/null
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -0,0 +1,349 @@
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
+int devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
+{
+	const struct power_supply_desc *desc = psy->desc;
+	struct power_supply_hwmon *psyhw;
+	struct device *dev = &psy->dev;
+	struct device *hwmon;
+	int ret, i;
+
+	if (!devres_open_group(dev, NULL, GFP_KERNEL))
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
+	devres_remove_group(dev, NULL);
+	return 0;
+error:
+	devres_release_group(dev, NULL);
+	return ret;
+}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index bdab14c7ca4d..39343bc4a3f8 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -475,4 +475,13 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
 	return 0;
 }
 
+#ifdef CONFIG_POWER_SUPPLY_HWMON
+int devm_power_supply_add_hwmon_sysfs(struct power_supply *psy);
+#else
+static int devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
+{
+	return 0;
+}
+#endif
+
 #endif /* __LINUX_POWER_SUPPLY_H__ */
-- 
2.21.0

