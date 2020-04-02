Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887DB19C510
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbgDBO5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:57:08 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1958 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388761AbgDBO5H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:57:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR3z6rSNz1qr;
        Thu,  2 Apr 2020 16:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839424; bh=5+wT1S/f6+XIYE21J3sxG0B2NXkwzq83YHdkRZuZA3A=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Drd19yd9mA+9KMbEU87EADxnygW+ZfNL+9hzJyaDzVlS0c5XVNFNn68KWOg9OK+07
         VIpqSaJ/zkiSuWky/6MKkVB261GpywEnTVyi7FsYCOiEhKAhhJHKRQH1Npc7Q8KFCS
         HmCIF5gUd1lBtTILYOAsX9oNB9FZ+ILfR9AXf0IOf5mh8UCK8Z2jKqKmGRQwYWRspX
         WjI7ixNTx2URbHuuWlBn+9SumnbPvL0GMoKWX9vfdgRXzQCIksfLNw0K4zbRu+MyG5
         oHQQNmloW031v8VbM6TEOQ+2fuQrDn5h+8/2u0B/rH18N5C/aiibT0qtfuuKlWss+O
         vDoJqQFJ+LI0w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:57:03 +0200
Message-Id: <31ac01343ea01957b409d8a244b15cfbf3ab291f.1585837575.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/7] power: supply: core: add input voltage/current
 measurements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce input voltage and current limits and measurements.
This makes room for e.g. VBUS measurements in USB chargers.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/power_supply_hwmon.c | 107 +++++++++++++++++++++-
 drivers/power/supply/power_supply_sysfs.c |   2 +
 include/linux/power_supply.h              |   2 +
 3 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 118d73a2ab4a..c638750e0a18 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -13,7 +13,7 @@ struct power_supply_hwmon {
 	unsigned long *props;
 };
 
-static int power_supply_hwmon_in_to_property(u32 attr)
+static int power_supply_hwmon_in0_to_property(u32 attr)
 {
 	switch (attr) {
 	case hwmon_in_average:
@@ -29,7 +29,31 @@ static int power_supply_hwmon_in_to_property(u32 attr)
 	}
 }
 
-static int power_supply_hwmon_curr_to_property(u32 attr)
+static int power_supply_hwmon_in1_to_property(u32 attr)
+{
+	switch (attr) {
+	case hwmon_in_max:
+		return POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT;
+	case hwmon_in_input:
+		return POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int power_supply_hwmon_in_to_property(u32 attr, int channel)
+{
+	switch (channel) {
+	case 0:
+		return power_supply_hwmon_in0_to_property(attr);
+	case 1:
+		return power_supply_hwmon_in1_to_property(attr);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int power_supply_hwmon_curr0_to_property(u32 attr)
 {
 	switch (attr) {
 	case hwmon_curr_average:
@@ -43,6 +67,35 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
 	}
 }
 
+static int power_supply_hwmon_curr1_to_property(u32 attr)
+{
+	switch (attr) {
+	case hwmon_curr_max:
+		return POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+	case hwmon_curr_input:
+		return POWER_SUPPLY_PROP_INPUT_CURRENT_NOW;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int power_supply_hwmon_curr_to_property(u32 attr, int channel)
+{
+	switch (channel) {
+	case 0:
+		return power_supply_hwmon_curr0_to_property(attr);
+	case 1:
+		return power_supply_hwmon_curr1_to_property(attr);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const char *const ps_input_label[] = {
+	"battery",
+	"external source",
+};
+
 static const char *const ps_temp_label[] = {
 	"temp",
 	"ambient temp",
@@ -87,9 +140,9 @@ power_supply_hwmon_to_property(enum hwmon_sensor_types type,
 {
 	switch (type) {
 	case hwmon_in:
-		return power_supply_hwmon_in_to_property(attr);
+		return power_supply_hwmon_in_to_property(attr, channel);
 	case hwmon_curr:
-		return power_supply_hwmon_curr_to_property(attr);
+		return power_supply_hwmon_curr_to_property(attr, channel);
 	case hwmon_temp:
 		return power_supply_hwmon_temp_to_property(attr, channel);
 	default:
@@ -100,7 +153,9 @@ power_supply_hwmon_to_property(enum hwmon_sensor_types type,
 static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
 					   u32 attr)
 {
-	return type == hwmon_temp && attr == hwmon_temp_label;
+	return (type == hwmon_temp && attr == hwmon_temp_label) ||
+	       (type == hwmon_in && attr == hwmon_in_label) ||
+	       (type == hwmon_curr && attr == hwmon_curr_label);
 }
 
 static bool power_supply_hwmon_has_property(
@@ -116,6 +171,14 @@ static bool power_supply_hwmon_has_input(
 	const struct power_supply_hwmon *psyhw,
 	enum hwmon_sensor_types type, int channel)
 {
+	static const enum hwmon_in_attributes in_attrs[] = {
+		hwmon_in_input, hwmon_in_average,
+		hwmon_in_min, hwmon_in_max,
+	};
+	static const enum hwmon_curr_attributes curr_attrs[] = {
+		hwmon_curr_input, hwmon_curr_average,
+		hwmon_curr_max,
+	};
 	static const enum hwmon_temp_attributes temp_attrs[] = {
 		hwmon_temp_input,
 		hwmon_temp_min, hwmon_temp_max,
@@ -124,6 +187,20 @@ static bool power_supply_hwmon_has_input(
 	size_t i;
 
 	switch (type) {
+	case hwmon_in:
+		for (i = 0; i < ARRAY_SIZE(in_attrs); ++i)
+			if (power_supply_hwmon_has_property(psyhw, type,
+					in_attrs[i], channel))
+				return true;
+		break;
+
+	case hwmon_curr:
+		for (i = 0; i < ARRAY_SIZE(curr_attrs); ++i)
+			if (power_supply_hwmon_has_property(psyhw, type,
+					curr_attrs[i], channel))
+				return true;
+		break;
+
 	case hwmon_temp:
 		for (i = 0; i < ARRAY_SIZE(temp_attrs); ++i)
 			if (power_supply_hwmon_has_property(psyhw, type,
@@ -187,6 +264,11 @@ static int power_supply_hwmon_read_string(struct device *dev,
 					  const char **str)
 {
 	switch (type) {
+	case hwmon_in:
+	case hwmon_curr:
+		*str = ps_input_label[channel];
+		break;
+
 	case hwmon_temp:
 		*str = ps_temp_label[channel];
 		break;
@@ -304,15 +386,26 @@ static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
 			   HWMON_T_MAX_ALARM),
 
 	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_LABEL   |
 			   HWMON_C_AVERAGE |
 			   HWMON_C_MAX     |
+			   HWMON_C_INPUT,
+
+			   HWMON_C_LABEL   |
+			   HWMON_C_MAX     |
 			   HWMON_C_INPUT),
 
 	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_LABEL   |
 			   HWMON_I_AVERAGE |
 			   HWMON_I_MIN     |
 			   HWMON_I_MAX     |
+			   HWMON_I_INPUT,
+
+			   HWMON_I_LABEL   |
+			   HWMON_I_MAX     |
 			   HWMON_I_INPUT),
+
 	NULL
 };
 
@@ -377,6 +470,10 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
 		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
 		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		case POWER_SUPPLY_PROP_INPUT_CURRENT_NOW:
+		case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		case POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW:
+		case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
 			set_bit(prop, psyhw->props);
 			break;
 		default:
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 51de3f47b25d..1d1fb69516a8 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -273,7 +273,9 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(charge_control_limit_max),
 	POWER_SUPPLY_ATTR(charge_control_start_threshold),
 	POWER_SUPPLY_ATTR(charge_control_end_threshold),
+	POWER_SUPPLY_ATTR(input_current_now),
 	POWER_SUPPLY_ATTR(input_current_limit),
+	POWER_SUPPLY_ATTR(input_voltage_now),
 	POWER_SUPPLY_ATTR(input_voltage_limit),
 	POWER_SUPPLY_ATTR(input_power_limit),
 	POWER_SUPPLY_ATTR(energy_full_design),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 6a34df65d4d1..5313d1284aad 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -127,7 +127,9 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
 	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
+	POWER_SUPPLY_PROP_INPUT_CURRENT_NOW,
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
 	POWER_SUPPLY_PROP_INPUT_POWER_LIMIT,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
-- 
2.20.1

