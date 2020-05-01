Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB11C191A
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgEAPLX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:11:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:40556 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgEAPLV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 11:11:21 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DG131GJdzMP;
        Fri,  1 May 2020 17:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588345879; bh=Rr1sgFgpBY5Dzp/xQT/OHr8QvEUKh1pOriOrWBGo57w=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=FtbU93syoutg/e0584JkTGy6LI/ajWp3W78WjO3uVQlJpQLXbEaIoazXDppihK7BA
         lRp3y6olO5HLQqRoURxo2XEnufunYNW3ZlVJKzL/lHqSgoG/qTNJwa4qnWoiIldUKE
         mFjUwBUViZoNQVySp64+e4z8pO9bRDw+cpY6+BwmYiQ530TTwbdd52jKxY4pN5SWTn
         FxUPhSmCvtXrAE6EcS6GYtUTpfde14qHeYPzJv6GgLAldOStOpmXj06CBPgE2ux3m2
         J1afhmjYg6V18+5PlyLU3BcmiLB1LHRWgYYVNn31MV6dePp09nHARCEyMEvmnIARKL
         6GHozG3BCryTA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 01 May 2020 17:11:18 +0200
Message-Id: <249d7ad42b02bfeb8c31c49a64ee92b3e745086d.1588345420.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588345420.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 2/4] power: supply: core: add input voltage/current
 measurements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce input voltage and current limits and measurements.
This makes room for e.g. VBUS measurements in USB chargers.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: add parameter checking in power_supply_hwmon_read_string()
v3: remove power_supply_hwmon_read_string() parameter checks
    as it is internal API (suggested by Guenter Roeck)
---
 drivers/power/supply/power_supply_hwmon.c | 97 +++++++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c |  2 +
 include/linux/power_supply.h              |  2 +
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index f5d538485aaa..3863b2a73ecf 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -13,12 +13,17 @@ struct power_supply_hwmon {
 	unsigned long *props;
 };
 
+static const char *const ps_input_label[] = {
+	"battery",
+	"external source",
+};
+
 static const char *const ps_temp_label[] = {
 	"temp",
 	"ambient temp",
 };
 
-static int power_supply_hwmon_in_to_property(u32 attr)
+static int power_supply_hwmon_in0_to_property(u32 attr)
 {
 	switch (attr) {
 	case hwmon_in_average:
@@ -34,7 +39,31 @@ static int power_supply_hwmon_in_to_property(u32 attr)
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
@@ -48,6 +77,30 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
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
 static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
 {
 	if (channel) {
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
 
 struct hwmon_type_attr_list {
@@ -114,7 +169,19 @@ static const u32 ps_temp_attrs[] = {
 	hwmon_temp_min_alarm, hwmon_temp_max_alarm,
 };
 
+static const u32 ps_in_attrs[] = {
+	hwmon_in_input, hwmon_in_average,
+	hwmon_in_min, hwmon_in_max,
+};
+
+static const u32 ps_curr_attrs[] = {
+	hwmon_curr_input, hwmon_curr_average,
+	hwmon_curr_max,
+};
+
 static const struct hwmon_type_attr_list ps_type_attrs[hwmon_max] = {
+	[hwmon_in] = { ps_in_attrs, ARRAY_SIZE(ps_in_attrs) },
+	[hwmon_curr] = { ps_curr_attrs, ARRAY_SIZE(ps_curr_attrs) },
 	[hwmon_temp] = { ps_temp_attrs, ARRAY_SIZE(ps_temp_attrs) },
 };
 
@@ -186,6 +253,11 @@ static int power_supply_hwmon_read_string(struct device *dev,
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
@@ -309,15 +381,26 @@ static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
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
 
@@ -382,6 +465,10 @@ int power_supply_add_hwmon_sysfs(struct power_supply *psy)
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

