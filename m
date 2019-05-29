Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB412D5FC
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 09:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2HLb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 03:11:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35570 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfE2HL3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 03:11:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so665212plo.2;
        Wed, 29 May 2019 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ray55oNe1T3sHn83tx/zmaoCA1rDD8hjIrwtAFH2eUs=;
        b=JSs8T2oGvevGGRMYbzTrFJINZTIB2hsq8myEVTD1clVZi0GEJfAeaVDeAV05qJLUWh
         1dpvW8e34CWHH0rok1lDbOgEts4UCWRA1oJyshC80+OU6n0WiBsjk+q7q4SbkvbMIHsF
         RL0Q/2Hcb6nitrrAKVEYDt334I3hK2FTk+vRYeYCl+IvQ9v5NqpQW1Lt5F+cySf0bGDf
         QFPTemHr7L+3tTJpI4bFS5sYBvVlBShjaFx7LiDZQ1WU+1+0GQDhg1qcQ0IUWv/i0DUC
         OZHWgaTcNhTT24vsKDNl/MFoNxirqoF9s9KjGVwwu9nDgHQ9Mikhx0oXUhjbQaCgViI5
         /PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ray55oNe1T3sHn83tx/zmaoCA1rDD8hjIrwtAFH2eUs=;
        b=p3+if4pR3xGLVvPS6n4jQvpP7w3RUVUXNvxvBqcNMMsJCob8whOM4eYcSiik6CHgwt
         J0DNt2fM35BcjHI3Lv+JlAbMAC9i7GE5EZcO/MkSUcgloVXm8AAmECaf+FZA9Nn/7T0j
         XR5pYhiEHcutCFZIvcgT5Cl+ZEKGMnaWwQSm4MFTufPjTGLrct0u16wDXCtsE4wsOutH
         5Cn9/yA0TUlqWFhns9I5xYYl0R+D0JZzFa6w/WqKV1U2lHmFVONIE2FLuUp7prb2I6Ai
         SqXchjJgEW1m2r398TR79SwTohzLRlePiDXHAfJ9XCwNeHAUVpoOD/OumTUM29bQ/LOF
         QiXQ==
X-Gm-Message-State: APjAAAVyp6f7dAmLkSz7Qqr8pmp0k4qub041UGr/p1EW+2KG+cBUCbpo
        Xj0kq8dZmmgHR1toJw14nMp1FyMidCo=
X-Google-Smtp-Source: APXvYqxaG5kJGFyPIGI/Erunt+tNaXmwJ1Nfwj47wz9Hvo5cAlxqlHwv3LuMSjOc6vYUgKeCaN1UGg==
X-Received: by 2002:a17:902:b195:: with SMTP id s21mr37904851plr.16.1559113888635;
        Wed, 29 May 2019 00:11:28 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u20sm18083307pfm.145.2019.05.29.00.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:11:27 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: Add HWMON compatibility layer
Date:   Wed, 29 May 2019 00:11:11 -0700
Message-Id: <20190529071112.16849-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529071112.16849-1-andrew.smirnov@gmail.com>
References: <20190529071112.16849-1-andrew.smirnov@gmail.com>
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
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/Kconfig              |  14 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/power_supply_hwmon.c | 329 ++++++++++++++++++++++
 include/linux/power_supply.h              |  11 +
 4 files changed, 355 insertions(+)
 create mode 100644 drivers/power/supply/power_supply_hwmon.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 26dacdab03cc..1f2252cb95fd 100644
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
index f208273f9686..c47e88ba16b9 100644
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
index 000000000000..dca7f79fae6e
--- /dev/null
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  power_supply_hwmon.c - power supply hwmon support.
+ */
+
+#include <linux/hwmon.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/power_supply.h>
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
+		break;
+	}
+
+	return -EINVAL;
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
+		break;
+	}
+
+	return -EINVAL;
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
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
+					  u32 attr)
+{
+	return type == hwmon_temp && attr == hwmon_temp_label;
+}
+
+static umode_t power_supply_hwmon_is_visible(const void *data,
+					     enum hwmon_sensor_types type,
+					     u32 attr, int channel)
+{
+	const struct power_supply_hwmon *psyhw = data;
+	int prop, is_writable;
+
+	if (power_supply_hwmon_is_a_label(type, attr))
+		return 0444;
+
+	prop = power_supply_hwmon_to_property(type, attr, channel);
+	if (prop < 0 || !test_bit(prop, psyhw->props))
+		return 0;
+
+	is_writable = power_supply_property_is_writeable(psyhw->psy, prop);
+
+	return (is_writable <= 0) ? 0444 : 0644;
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
+		pspval.intval /= 1000;
+		break;
+	/*
+	 * Temp needs to be converted from 1/10 C to milli-C
+	 */
+	case hwmon_temp:
+		pspval.intval *= 100;
+		break;
+	default:
+		break;
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
+		pspval.intval *= 1000;
+		break;
+	/*
+	 * Temp needs to be converted from 1/10 C to milli-C
+	 */
+	case hwmon_temp:
+		pspval.intval /= 100;
+		break;
+	default:
+		break;
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
+struct device *devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
+{
+	const struct power_supply_desc *desc = psy->desc;
+	struct power_supply_hwmon *psyhw;
+	struct device *dev = &psy->dev;
+	struct device *hwmon;
+	int ret, i;
+
+	if (!devres_open_group(dev, NULL, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
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
+	return hwmon;
+error:
+	devres_release_group(dev, NULL);
+	return ERR_PTR(ret);
+}
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index d9c0c094f8a0..839abfa2c640 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -481,4 +481,15 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
 	return 0;
 }
 
+#ifdef CONFIG_POWER_SUPPLY_HWMON
+extern struct device *
+devm_power_supply_add_hwmon_sysfs(struct power_supply *psy);
+#else
+static struct device *
+devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
+{
+	return 0;
+}
+#endif
+
 #endif /* __LINUX_POWER_SUPPLY_H__ */
-- 
2.21.0

