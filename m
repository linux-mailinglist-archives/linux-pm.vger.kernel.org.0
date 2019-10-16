Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAD8DA1A9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 00:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393215AbfJPWlb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 18:41:31 -0400
Received: from muru.com ([72.249.23.125]:37700 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393080AbfJPWlb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 18:41:31 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C135D8107;
        Wed, 16 Oct 2019 22:42:04 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/2] power: supply: cpcap-charger: Allow changing constant charge voltage
Date:   Wed, 16 Oct 2019 15:41:22 -0700
Message-Id: <20191016224122.10126-3-tony@atomide.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016224122.10126-1-tony@atomide.com>
References: <20191016224122.10126-1-tony@atomide.com>
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
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 83 ++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -172,6 +172,7 @@ struct cpcap_charger_ints_state {
 static enum power_supply_property cpcap_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
@@ -235,6 +236,9 @@ static int cpcap_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = ddata->status;
 		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		val->intval = ddata->voltage;
+		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		if (ddata->status == POWER_SUPPLY_STATUS_CHARGING)
 			val->intval = cpcap_charger_get_charge_voltage(ddata) *
@@ -259,6 +263,83 @@ static int cpcap_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int cpcap_charger_match_voltage(int voltage)
+{
+	switch (voltage) {
+	case 0 ... 4100000 - 1: return 3800000;
+	case 4100000 ... 4120000 - 1: return 4100000;
+	case 4120000 ... 4150000 - 1: return 4120000;
+	case 4150000 ... 4170000 - 1: return 4150000;
+	case 4170000 ... 4200000 - 1: return 4170000;
+	case 4200000 ... 4230000 - 1: return 4200000;
+	case 4230000 ... 4250000 - 1: return 4230000;
+	case 4250000 ... 4270000 - 1: return 4250000;
+	case 4270000 ... 4300000 - 1: return 4270000;
+	case 4300000 ... 4330000 - 1: return 4300000;
+	case 4330000 ... 4350000 - 1: return 4330000;
+	case 4350000 ... 4380000 - 1: return 4350000;
+	case 4380000 ... 4400000 - 1: return 4380000;
+	case 4400000 ... 4420000 - 1: return 4400000;
+	case 4420000 ... 4440000 - 1: return 4420000;
+	case 4440000: return 4440000;
+	default: return 0;
+	}
+}
+
+static int
+cpcap_charger_get_bat_const_charge_voltage(struct cpcap_charger_ddata *ddata)
+{
+	union power_supply_propval prop;
+	struct power_supply *battery;
+	int voltage = ddata->voltage;
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
+	int voltage, batvolt;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		voltage = cpcap_charger_match_voltage(val->intval);
+		batvolt = cpcap_charger_get_bat_const_charge_voltage(ddata);
+		if (voltage > batvolt)
+			voltage = batvolt;
+		ddata->voltage = voltage;
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
@@ -724,6 +805,8 @@ static const struct power_supply_desc cpcap_charger_usb_desc = {
 	.properties	= cpcap_charger_props,
 	.num_properties	= ARRAY_SIZE(cpcap_charger_props),
 	.get_property	= cpcap_charger_get_property,
+	.set_property	= cpcap_charger_set_property,
+	.property_is_writeable = cpcap_charger_property_is_writeable,
 };
 
 #ifdef CONFIG_OF
-- 
2.23.0
