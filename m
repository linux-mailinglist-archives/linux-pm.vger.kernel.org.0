Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE257231D05
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgG2K4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 06:56:11 -0400
Received: from outbound.soverin.net ([116.202.65.218]:56213 "EHLO
        outbound.soverin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2K4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 06:56:11 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 06:56:10 EDT
Received: from smtp.soverin.net (unknown [10.10.3.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id C67E86017B;
        Wed, 29 Jul 2020 10:49:44 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [159.69.232.138]) by soverin.net
From:   Jack Mitchell <ml@embed.me.uk>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Jack Mitchell <ml@embed.me.uk>
Subject: [PATCH] drivers: power: axp20x-battery: support setting charge_full_design
Date:   Wed, 29 Jul 2020 11:49:13 +0100
Message-Id: <20200729104913.627242-1-ml@embed.me.uk>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at c03mi01
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Jack Mitchell <ml@embed.me.uk>
---
 drivers/power/supply/axp20x_battery.c | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index fe96f77bffa7..8ce4ebe7ccd5 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -60,6 +60,7 @@
 
 #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
 
+#define AXP20X_BAT_MAX_CAP_VALID	BIT(7)
 
 struct axp20x_batt_ps;
 
@@ -86,6 +87,7 @@ struct axp20x_batt_ps {
 	struct axp20x_thermal_sensor sensor;
 	/* Maximum constant charge current */
 	unsigned int max_ccc;
+	unsigned int charge_full_design;
 	const struct axp_data	*data;
 };
 
@@ -260,6 +262,10 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		val->intval = POWER_SUPPLY_HEALTH_GOOD;
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = axp20x_batt->charge_full_design;
+		break;
+
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = axp20x_get_constant_charge_current(axp20x_batt,
 							 &val->intval);
@@ -401,6 +407,30 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
 }
 
+static int axp20x_set_charge_full_design(struct axp20x_batt_ps *axp_batt,
+					      int charge_full_uah)
+{
+	/* (Unit: 1.456mAh) */
+	int max_capacity_units = charge_full_uah / 1456;
+	int ret;
+
+	u8 max_capacity_msb = (max_capacity_units & 0x7F00) >> 8;
+	u8 max_capacity_lsb = (max_capacity_units & 0xFF);
+
+	axp_batt->charge_full_design = max_capacity_units * 1456;
+
+	max_capacity_msb |= AXP20X_BAT_MAX_CAP_VALID;
+
+	ret = regmap_write(axp_batt->regmap, AXP288_FG_DES_CAP0_REG,
+			   max_capacity_lsb);
+
+	if (ret)
+		return ret;
+
+	return regmap_write(axp_batt->regmap, AXP288_FG_DES_CAP1_REG,
+			    max_capacity_msb);
+}
+
 static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 					      int charge_current)
 {
@@ -492,6 +522,7 @@ static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -675,6 +706,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
 		int vmin = info.voltage_min_design_uv;
 		int ccc = info.constant_charge_current_max_ua;
+		int cfd = info.charge_full_design_uah;
 
 		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
 							      vmin))
@@ -692,6 +724,13 @@ static int axp20x_power_probe(struct platform_device *pdev)
 			axp20x_batt->max_ccc = ccc;
 			axp20x_set_constant_charge_current(axp20x_batt, ccc);
 		}
+
+		if (cfd > 0 && axp20x_set_charge_full_design(axp20x_batt,
+							       cfd)) {
+			dev_err(&pdev->dev,
+				"couldn't set charge_full_design\n");
+			axp20x_batt->charge_full_design = 0;
+		}
 	}
 
 	error = axp20x_thermal_register_sensor(pdev, axp20x_batt);
-- 
2.28.0

