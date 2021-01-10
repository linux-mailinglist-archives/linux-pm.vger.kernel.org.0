Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98F2F097A
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jan 2021 20:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbhAJTza (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 14:55:30 -0500
Received: from muru.com ([72.249.23.125]:42500 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbhAJTza (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Jan 2021 14:55:30 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 82DE581D0;
        Sun, 10 Jan 2021 19:54:18 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>
Subject: [PATCH 06/15] power: supply: cpcap-charger: Limiting charge current on Droid 4
Date:   Sun, 10 Jan 2021 21:53:54 +0200
Message-Id: <20210110195403.13758-7-tony@atomide.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

Droid 4 has same problem as N900: it is often necessary to manually
tweak current draw from USB, for example when using thin charging cable.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Pavel Machek <pavel@ucw.cz>
[tony@atomide.com: rebased, cleaned up whitespace issues, updated comments]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 49 ++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -89,6 +89,8 @@
  * CPCAP_REG_CRM charge currents. These seem to match MC13783UG.pdf
  * values in "Table 8-3. Charge Path Regulator Current Limit
  * Characteristics" for the nominal values.
+ *
+ * Except 70mA and 1.596A and unlimited, these are simply 88.7mA / step.
  */
 #define CPCAP_REG_CRM_ICHRG(val)	(((val) & 0xf) << 0)
 #define CPCAP_REG_CRM_ICHRG_0A000	CPCAP_REG_CRM_ICHRG(0x0)
@@ -140,6 +142,7 @@ struct cpcap_charger_ddata {
 	int status;
 	int state;
 	int voltage;
+	int limit_current;
 };
 
 struct cpcap_interrupt_desc {
@@ -166,6 +169,7 @@ static enum power_supply_property cpcap_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
@@ -229,6 +233,9 @@ static int cpcap_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = ddata->status;
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval = ddata->limit_current;
+		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		val->intval = ddata->voltage;
 		break;
@@ -300,6 +307,26 @@ cpcap_charger_get_bat_const_charge_voltage(struct cpcap_charger_ddata *ddata)
 	return voltage;
 }
 
+static int cpcap_charger_current_to_regval(int microamp)
+{
+	int miliamp = microamp / 1000;
+	int res;
+
+	if (miliamp < 0)
+		return -EINVAL;
+	if (miliamp < 70)
+		return CPCAP_REG_CRM_ICHRG(0x0);
+	if (miliamp < 177)
+		return CPCAP_REG_CRM_ICHRG(0x1);
+	if (miliamp > 1596)
+		return CPCAP_REG_CRM_ICHRG(0xe);
+
+	res = microamp / 88666;
+	if (res > 0xd)
+		res = 0xd;
+	return CPCAP_REG_CRM_ICHRG(res);
+}
+
 static int cpcap_charger_set_property(struct power_supply *psy,
 				      enum power_supply_property psp,
 				      const union power_supply_propval *val)
@@ -308,6 +335,12 @@ static int cpcap_charger_set_property(struct power_supply *psy,
 	int voltage, batvolt;
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (cpcap_charger_current_to_regval(val->intval) < 0)
+			return -EINVAL;
+		ddata->limit_current = val->intval;
+		schedule_delayed_work(&ddata->detect_work, 0);
+		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		voltage = cpcap_charger_match_voltage(val->intval);
 		batvolt = cpcap_charger_get_bat_const_charge_voltage(ddata);
@@ -327,6 +360,7 @@ static int cpcap_charger_property_is_writeable(struct power_supply *psy,
 					       enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 		return 1;
 	default:
@@ -652,18 +686,20 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 	    s.chrgcurr1) {
-		int max_current;
-		int vchrg;
+		int max_current = 532000;
+		int vchrg, ichrg;
 
 		if (cpcap_charger_battery_found(ddata))
-			max_current = CPCAP_REG_CRM_ICHRG_1A596;
-		else
-			max_current = CPCAP_REG_CRM_ICHRG_0A532;
+			max_current = 1596000;
+
+		if (max_current > ddata->limit_current)
+			max_current = ddata->limit_current;
 
+		ichrg = cpcap_charger_current_to_regval(max_current);
 		vchrg = cpcap_charger_voltage_to_regval(ddata->voltage);
 		error = cpcap_charger_set_state(ddata,
 						CPCAP_REG_CRM_VCHRG(vchrg),
-						max_current, 0);
+						ichrg, 0);
 		if (error)
 			goto out_err;
 		cpcap_charger_update_state(ddata,
@@ -837,6 +873,7 @@ static int cpcap_charger_probe(struct platform_device *pdev)
 
 	ddata->dev = &pdev->dev;
 	ddata->voltage = 4200000;
+	ddata->limit_current = 532000;
 
 	ddata->reg = dev_get_regmap(ddata->dev->parent, NULL);
 	if (!ddata->reg)
-- 
2.30.0
