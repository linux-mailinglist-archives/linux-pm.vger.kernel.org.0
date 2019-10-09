Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB9D1A68
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2019 23:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfJIVB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Oct 2019 17:01:57 -0400
Received: from muru.com ([72.249.23.125]:36458 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbfJIVB5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Oct 2019 17:01:57 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7FF0B8162;
        Wed,  9 Oct 2019 21:02:29 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/2] power: supply: cpcap-battery: Fix handling of lowered charger voltage
Date:   Wed,  9 Oct 2019 14:01:40 -0700
Message-Id: <20191009210141.10037-2-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009210141.10037-1-tony@atomide.com>
References: <20191009210141.10037-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With cpcap-charger now using 4.2V instead of 4.35V, we never reach
POWER_SUPPLY_CAPACITY_LEVEL_FULL unless we handle the lowered charge
voltage.

Let's do this by implementing POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
and assume anything at that level or higher is a full battery.

Let's also make it configurable for users who may still want to
reconfigure it, and notify the charger if supported by the charger.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-battery.c | 86 +++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -79,6 +79,7 @@ struct cpcap_battery_config {
 	int ccm;
 	int cd_factor;
 	struct power_supply_info info;
+	struct power_supply_battery_info bat;
 };
 
 struct cpcap_coulomb_counter_data {
@@ -369,8 +370,8 @@ static bool cpcap_battery_full(struct cpcap_battery_ddata *ddata)
 {
 	struct cpcap_battery_state_data *state = cpcap_battery_latest(ddata);
 
-	/* Basically anything that measures above 4347000 is full */
-	if (state->voltage >= (ddata->config.info.voltage_max_design - 4000))
+	if (state->voltage >=
+	    (ddata->config.bat.constant_charge_voltage_max_uv - 18000))
 		return true;
 
 	return false;
@@ -417,6 +418,7 @@ static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
@@ -475,6 +477,9 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		val->intval = ddata->config.info.voltage_min_design;
 		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		val->intval = ddata->config.bat.constant_charge_voltage_max_uv;
+		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		sample = latest->cc.sample - previous->cc.sample;
 		if (!sample) {
@@ -540,6 +545,70 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int cpcap_battery_update_charger(struct cpcap_battery_ddata *ddata,
+					int const_charge_voltage)
+{
+	union power_supply_propval prop;
+	union power_supply_propval val;
+	struct power_supply *charger;
+	int error;
+
+	charger = power_supply_get_by_name("usb");
+	if (!charger)
+		return -ENODEV;
+
+	error = power_supply_get_property(charger,
+				POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+				&prop);
+	if (error)
+		return error;
+
+	/* Allow charger const voltage lower than battery const voltage */
+	if (const_charge_voltage > prop.intval)
+		return 0;
+
+	val.intval = const_charge_voltage;
+
+	return power_supply_set_property(charger,
+			POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+			&val);
+}
+
+static int cpcap_battery_set_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      const union power_supply_propval *val)
+{
+	struct cpcap_battery_ddata *ddata = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		if (val->intval < ddata->config.info.voltage_min_design)
+			return -EINVAL;
+		if (val->intval > ddata->config.info.voltage_max_design)
+			return -EINVAL;
+
+		ddata->config.bat.constant_charge_voltage_max_uv = val->intval;
+
+		return cpcap_battery_update_charger(ddata, val->intval);
+	break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpcap_battery_property_is_writeable(struct power_supply *psy,
+					       enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static irqreturn_t cpcap_battery_irq_thread(int irq, void *data)
 {
 	struct cpcap_battery_ddata *ddata = data;
@@ -696,6 +765,7 @@ static const struct cpcap_battery_config cpcap_battery_default_data = {
 	.info.voltage_max_design = 4351000,
 	.info.voltage_min_design = 3100000,
 	.info.charge_full_design = 1740000,
+	.bat.constant_charge_voltage_max_uv = 4200000,
 };
 
 #ifdef CONFIG_OF
@@ -763,11 +833,13 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (!psy_desc)
 		return -ENOMEM;
 
-	psy_desc->name = "battery",
-	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY,
-	psy_desc->properties = cpcap_battery_props,
-	psy_desc->num_properties = ARRAY_SIZE(cpcap_battery_props),
-	psy_desc->get_property = cpcap_battery_get_property,
+	psy_desc->name = "battery";
+	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	psy_desc->properties = cpcap_battery_props;
+	psy_desc->num_properties = ARRAY_SIZE(cpcap_battery_props);
+	psy_desc->get_property = cpcap_battery_get_property;
+	psy_desc->set_property = cpcap_battery_set_property;
+	psy_desc->property_is_writeable = cpcap_battery_property_is_writeable;
 
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = ddata;
-- 
2.23.0
