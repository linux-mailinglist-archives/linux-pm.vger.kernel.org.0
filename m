Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B04FB57D2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfIQVxT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 17:53:19 -0400
Received: from muru.com ([72.249.23.125]:33570 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfIQVxT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Sep 2019 17:53:19 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 39AB581A0;
        Tue, 17 Sep 2019 21:53:49 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/3] power: supply: cpcap-charger: Allow changing constant charge voltage
Date:   Tue, 17 Sep 2019 14:52:52 -0700
Message-Id: <20190917215253.17880-3-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917215253.17880-1-tony@atomide.com>
References: <20190917215253.17880-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's allow reconfiguring the cpcap-charger max charge voltage and
default to 4.2V that should be safe for the known users.

This allows the users to use 4.35V for the extra capacity if really
needed at a cost of probably shorter battery life. We check the
constant charge voltage limit set by the battery.

Some pieces of the property setting code is based on an earlier patch
from Pavel Machek <pavel@ucw.cz> but limited to configuring the charge
voltage for now.

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 143 +++++++++++++++++++++++----
 1 file changed, 126 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -67,23 +67,48 @@
  * Note that these register bits don't match MC13783UG.pdf VCHRG
  * register bits.
  */
+enum {
+	CPCAP_REG_CRM_VCHRG_3V80,
+	CPCAP_REG_CRM_VCHRG_4V10,
+	CPCAP_REG_CRM_VCHRG_4V12,
+	CPCAP_REG_CRM_VCHRG_4V15,
+	CPCAP_REG_CRM_VCHRG_4V17,
+	CPCAP_REG_CRM_VCHRG_4V20,
+	CPCAP_REG_CRM_VCHRG_4V23,
+	CPCAP_REG_CRM_VCHRG_4V25,
+	CPCAP_REG_CRM_VCHRG_4V27,
+	CPCAP_REG_CRM_VCHRG_4V30,
+	CPCAP_REG_CRM_VCHRG_4V33,
+	CPCAP_REG_CRM_VCHRG_4V35,
+	CPCAP_REG_CRM_VCHRG_4V38,
+	CPCAP_REG_CRM_VCHRG_4V40,
+	CPCAP_REG_CRM_VCHRG_4V42,
+	CPCAP_REG_CRM_VCHRG_4V44,
+};
+
+const int cpcap_charge_voltage[] = {
+	[CPCAP_REG_CRM_VCHRG_3V80] = 3800000,
+	[CPCAP_REG_CRM_VCHRG_4V10] = 4100000,
+	[CPCAP_REG_CRM_VCHRG_4V12] = 4120000,
+	[CPCAP_REG_CRM_VCHRG_4V15] = 4150000,
+	[CPCAP_REG_CRM_VCHRG_4V17] = 4170000,
+	[CPCAP_REG_CRM_VCHRG_4V20] = 4200000,
+	[CPCAP_REG_CRM_VCHRG_4V23] = 4230000,
+	[CPCAP_REG_CRM_VCHRG_4V25] = 4250000,
+	[CPCAP_REG_CRM_VCHRG_4V27] = 4270000,
+	[CPCAP_REG_CRM_VCHRG_4V30] = 4300000,
+	[CPCAP_REG_CRM_VCHRG_4V33] = 4330000,
+	[CPCAP_REG_CRM_VCHRG_4V35] = 4350000,
+	[CPCAP_REG_CRM_VCHRG_4V38] = 4380000,
+	[CPCAP_REG_CRM_VCHRG_4V40] = 4400000,
+	[CPCAP_REG_CRM_VCHRG_4V42] = 4420000,
+	[CPCAP_REG_CRM_VCHRG_4V44] = 4440000,
+};
+
 #define CPCAP_REG_CRM_VCHRG(val)	(((val) & 0xf) << 4)
-#define CPCAP_REG_CRM_VCHRG_3V80	CPCAP_REG_CRM_VCHRG(0x0)
-#define CPCAP_REG_CRM_VCHRG_4V10	CPCAP_REG_CRM_VCHRG(0x1)
-#define CPCAP_REG_CRM_VCHRG_4V12	CPCAP_REG_CRM_VCHRG(0x2)
-#define CPCAP_REG_CRM_VCHRG_4V15	CPCAP_REG_CRM_VCHRG(0x3)
-#define CPCAP_REG_CRM_VCHRG_4V17	CPCAP_REG_CRM_VCHRG(0x4)
-#define CPCAP_REG_CRM_VCHRG_4V20	CPCAP_REG_CRM_VCHRG(0x5)
-#define CPCAP_REG_CRM_VCHRG_4V23	CPCAP_REG_CRM_VCHRG(0x6)
-#define CPCAP_REG_CRM_VCHRG_4V25	CPCAP_REG_CRM_VCHRG(0x7)
-#define CPCAP_REG_CRM_VCHRG_4V27	CPCAP_REG_CRM_VCHRG(0x8)
-#define CPCAP_REG_CRM_VCHRG_4V30	CPCAP_REG_CRM_VCHRG(0x9)
-#define CPCAP_REG_CRM_VCHRG_4V33	CPCAP_REG_CRM_VCHRG(0xa)
-#define CPCAP_REG_CRM_VCHRG_4V35	CPCAP_REG_CRM_VCHRG(0xb)
-#define CPCAP_REG_CRM_VCHRG_4V38	CPCAP_REG_CRM_VCHRG(0xc)
-#define CPCAP_REG_CRM_VCHRG_4V40	CPCAP_REG_CRM_VCHRG(0xd)
-#define CPCAP_REG_CRM_VCHRG_4V42	CPCAP_REG_CRM_VCHRG(0xe)
-#define CPCAP_REG_CRM_VCHRG_4V44	CPCAP_REG_CRM_VCHRG(0xf)
+#define CPCAP_REG_CRM_VCHRG_MAX		CPCAP_REG_CRM_VCHRG_4V44
+#define CPCAP_CHARGER_DEFAULT_VOLTAGE	\
+	cpcap_charge_voltage[CPCAP_REG_CRM_VCHRG_4V20]
 
 /*
  * CPCAP_REG_CRM charge currents. These seem to match MC13783UG.pdf
@@ -135,6 +160,7 @@ struct cpcap_charger_ddata {
 	struct phy_companion comparator;	/* For USB VBUS */
 	unsigned int vbus_enabled:1;
 	unsigned int feeding_vbus:1;
+	int const_charge_voltage;
 	atomic_t active;
 
 	int status;
@@ -162,6 +188,7 @@ struct cpcap_charger_ints_state {
 static enum power_supply_property cpcap_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
@@ -225,6 +252,9 @@ static int cpcap_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = ddata->status;
 		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		val->intval = ddata->const_charge_voltage;
+		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		if (ddata->status == POWER_SUPPLY_STATUS_CHARGING)
 			val->intval = cpcap_charger_get_charge_voltage(ddata) *
@@ -249,6 +279,79 @@ static int cpcap_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int cpcap_charger_match_voltage(struct cpcap_charger_ddata *ddata,
+				       int voltage, int *regval)
+{
+	int i, v = 0;
+
+	for (i = CPCAP_REG_CRM_VCHRG_MAX; i >= 0; i--) {
+		v = cpcap_charge_voltage[i];
+		if (voltage >= v) {
+			*regval = i;
+			dev_dbg(ddata->dev, "%s: voltage: %i regval: %02x\n",
+				__func__, v, *regval);
+			break;
+		}
+	}
+
+	return v;
+}
+
+static int
+cpcap_charger_get_bat_const_charge_voltage(struct cpcap_charger_ddata *ddata)
+{
+	union power_supply_propval prop;
+	struct power_supply *battery;
+	int voltage = CPCAP_CHARGER_DEFAULT_VOLTAGE;
+	int error;
+
+	battery = power_supply_get_by_name("battery");
+	if (battery) {
+		error = power_supply_get_property(battery,
+				POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+				&prop);
+		if (!error)
+			voltage = prop.intval;
+	}
+
+	return voltage;
+}
+
+static int cpcap_charger_set_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      const union power_supply_propval *val)
+{
+	struct cpcap_charger_ddata *ddata = dev_get_drvdata(psy->dev.parent);
+	int voltage, batvolt, unused = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		voltage = cpcap_charger_match_voltage(ddata, val->intval,
+						      &unused);
+		batvolt = cpcap_charger_get_bat_const_charge_voltage(ddata);
+		if (voltage > batvolt)
+			voltage = batvolt;
+		ddata->const_charge_voltage = voltage;
+		schedule_delayed_work(&ddata->detect_work, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpcap_charger_property_is_writeable(struct power_supply *psy,
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
 static void cpcap_charger_set_cable_path(struct cpcap_charger_ddata *ddata,
 					 bool enabled)
 {
@@ -451,14 +554,17 @@ static void cpcap_usb_detect(struct work_struct *work)
 	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 	    s.chrgcurr1) {
 		int max_current;
+		int vchrg = 0;
 
 		if (cpcap_charger_battery_found(ddata))
 			max_current = CPCAP_REG_CRM_ICHRG_1A596;
 		else
 			max_current = CPCAP_REG_CRM_ICHRG_0A532;
 
+		cpcap_charger_match_voltage(ddata, ddata->const_charge_voltage,
+					    &vchrg);
 		error = cpcap_charger_set_state(ddata,
-						CPCAP_REG_CRM_VCHRG_4V20,
+						CPCAP_REG_CRM_VCHRG(vchrg),
 						max_current, 0);
 		if (error)
 			goto out_err;
@@ -597,6 +703,8 @@ static const struct power_supply_desc cpcap_charger_usb_desc = {
 	.properties	= cpcap_charger_props,
 	.num_properties	= ARRAY_SIZE(cpcap_charger_props),
 	.get_property	= cpcap_charger_get_property,
+	.set_property	= cpcap_charger_set_property,
+	.property_is_writeable = cpcap_charger_property_is_writeable,
 };
 
 #ifdef CONFIG_OF
@@ -626,6 +734,7 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ddata->dev = &pdev->dev;
+	ddata->const_charge_voltage = CPCAP_CHARGER_DEFAULT_VOLTAGE;
 
 	ddata->reg = dev_get_regmap(ddata->dev->parent, NULL);
 	if (!ddata->reg)
-- 
2.23.0
