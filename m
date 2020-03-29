Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428C9196E64
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgC2QW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:22:59 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52594 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgC2QW7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:22:59 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 4C3D7249A1;
        Sun, 29 Mar 2020 18:22:55 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 7/9] power: supply: smb347-charger: Remove virtual smb347-battery
Date:   Sun, 29 Mar 2020 18:21:26 +0200
Message-Id: <20200329162128.218584-8-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

smb347 is a charger and not a battery driver, and that power-supply core
now supports monitored-battery. So the 'fake' battery doesn't do anything
useful for us, and thus, it should be removed.

Transfer this functionality into smb347-mains and smb347-usb.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 212 ++++++++------------------
 1 file changed, 60 insertions(+), 152 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 0cbd0743fd91..ce2ebfe601d6 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -127,7 +127,6 @@
  * @regmap: pointer to driver regmap
  * @mains: power_supply instance for AC/DC power
  * @usb: power_supply instance for USB power
- * @battery: power_supply instance for battery
  * @id: SMB charger ID
  * @mains_online: is AC/DC input connected
  * @usb_online: is USB input connected
@@ -140,7 +139,6 @@ struct smb347_charger {
 	struct regmap		*regmap;
 	struct power_supply	*mains;
 	struct power_supply	*usb;
-	struct power_supply	*battery;
 	unsigned int		id;
 	bool			mains_online;
 	bool			usb_online;
@@ -743,7 +741,10 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	 */
 	if (stat_c & STAT_C_CHARGER_ERROR) {
 		dev_err(smb->dev, "charging stopped due to charger error\n");
-		power_supply_changed(smb->battery);
+		if (smb->pdata->use_mains)
+			power_supply_changed(smb->mains);
+		if (smb->pdata->use_usb)
+			power_supply_changed(smb->usb);
 		handled = true;
 	}
 
@@ -753,8 +754,12 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	 * disabled by the hardware.
 	 */
 	if (irqstat_c & (IRQSTAT_C_TERMINATION_IRQ | IRQSTAT_C_TAPER_IRQ)) {
-		if (irqstat_c & IRQSTAT_C_TERMINATION_STAT)
-			power_supply_changed(smb->battery);
+		if (irqstat_c & IRQSTAT_C_TERMINATION_STAT) {
+			if (smb->pdata->use_mains)
+				power_supply_changed(smb->mains);
+			if (smb->pdata->use_usb)
+				power_supply_changed(smb->usb);
+		}
 		dev_dbg(smb->dev, "going to HW maintenance mode\n");
 		handled = true;
 	}
@@ -768,7 +773,10 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 
 		if (irqstat_d & IRQSTAT_D_CHARGE_TIMEOUT_STAT)
 			dev_warn(smb->dev, "charging stopped due to timeout\n");
-		power_supply_changed(smb->battery);
+		if (smb->pdata->use_mains)
+			power_supply_changed(smb->mains);
+		if (smb->pdata->use_usb)
+			power_supply_changed(smb->usb);
 		handled = true;
 	}
 
@@ -936,95 +944,19 @@ static int get_const_charge_voltage(struct smb347_charger *smb)
 	return intval;
 }
 
-static int smb347_mains_get_property(struct power_supply *psy,
-				     enum power_supply_property prop,
-				     union power_supply_propval *val)
-{
-	struct smb347_charger *smb = power_supply_get_drvdata(psy);
-	int ret;
-
-	switch (prop) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = smb->mains_online;
-		break;
-
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		ret = get_const_charge_voltage(smb);
-		if (ret < 0)
-			return ret;
-		else
-			val->intval = ret;
-		break;
-
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		ret = get_const_charge_current(smb);
-		if (ret < 0)
-			return ret;
-		else
-			val->intval = ret;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static enum power_supply_property smb347_mains_properties[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
-};
-
-static int smb347_usb_get_property(struct power_supply *psy,
-				   enum power_supply_property prop,
-				   union power_supply_propval *val)
-{
-	struct smb347_charger *smb = power_supply_get_drvdata(psy);
-	int ret;
-
-	switch (prop) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = smb->usb_online;
-		break;
-
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		ret = get_const_charge_voltage(smb);
-		if (ret < 0)
-			return ret;
-		else
-			val->intval = ret;
-		break;
-
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		ret = get_const_charge_current(smb);
-		if (ret < 0)
-			return ret;
-		else
-			val->intval = ret;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static enum power_supply_property smb347_usb_properties[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
-};
-
-static int smb347_get_charging_status(struct smb347_charger *smb)
+static int smb347_get_charging_status(struct smb347_charger *smb,
+				      struct power_supply *psy)
 {
 	int ret, status;
 	unsigned int val;
 
-	if (!smb347_is_ps_online(smb))
-		return POWER_SUPPLY_STATUS_DISCHARGING;
+	if (psy->desc->type == POWER_SUPPLY_TYPE_USB) {
+		if (!smb->usb_online)
+			return POWER_SUPPLY_STATUS_DISCHARGING;
+	} else {
+		if (!smb->mains_online)
+			return POWER_SUPPLY_STATUS_DISCHARGING;
+	}
 
 	ret = regmap_read(smb->regmap, STAT_C, &val);
 	if (ret < 0)
@@ -1063,29 +995,29 @@ static int smb347_get_charging_status(struct smb347_charger *smb)
 	return status;
 }
 
-static int smb347_battery_get_property(struct power_supply *psy,
-				       enum power_supply_property prop,
-				       union power_supply_propval *val)
+static int smb347_get_property(struct power_supply *psy,
+			       enum power_supply_property prop,
+			       union power_supply_propval *val)
 {
 	struct smb347_charger *smb = power_supply_get_drvdata(psy);
-	const struct smb347_charger_platform_data *pdata = smb->pdata;
 	int ret;
 
-	ret = smb347_update_ps_status(smb);
-	if (ret < 0)
-		return ret;
-
 	switch (prop) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = smb347_get_charging_status(smb);
+		ret = smb347_get_charging_status(smb, psy);
 		if (ret < 0)
 			return ret;
 		val->intval = ret;
 		break;
 
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		if (!smb347_is_ps_online(smb))
-			return -ENODATA;
+		if (psy->desc->type == POWER_SUPPLY_TYPE_USB) {
+			if (!smb->usb_online)
+				return -ENODATA;
+		} else {
+			if (!smb->mains_online)
+				return -ENODATA;
+		}
 
 		/*
 		 * We handle trickle and pre-charging the same, and taper
@@ -1104,24 +1036,25 @@ static int smb347_battery_get_property(struct power_supply *psy,
 		}
 		break;
 
-	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = pdata->battery_info.technology;
-		break;
-
-	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		val->intval = pdata->battery_info.voltage_min_design;
-		break;
-
-	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
-		val->intval = pdata->battery_info.voltage_max_design;
+	case POWER_SUPPLY_PROP_ONLINE:
+		if (psy->desc->type == POWER_SUPPLY_TYPE_USB)
+			val->intval = smb->usb_online;
+		else
+			val->intval = smb->mains_online;
 		break;
 
-	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
-		val->intval = pdata->battery_info.charge_full_design;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = get_const_charge_voltage(smb);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 
-	case POWER_SUPPLY_PROP_MODEL_NAME:
-		val->strval = pdata->battery_info.name;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = get_const_charge_current(smb);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 
 	default:
@@ -1131,14 +1064,12 @@ static int smb347_battery_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static enum power_supply_property smb347_battery_properties[] = {
+static enum power_supply_property smb347_properties[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
-	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 };
 
 static bool smb347_volatile_reg(struct device *dev, unsigned int reg)
@@ -1276,32 +1207,23 @@ static const struct regmap_config smb347_regmap = {
 static const struct power_supply_desc smb347_mains_desc = {
 	.name		= "smb347-mains",
 	.type		= POWER_SUPPLY_TYPE_MAINS,
-	.get_property	= smb347_mains_get_property,
-	.properties	= smb347_mains_properties,
-	.num_properties	= ARRAY_SIZE(smb347_mains_properties),
+	.get_property	= smb347_get_property,
+	.properties	= smb347_properties,
+	.num_properties	= ARRAY_SIZE(smb347_properties),
 };
 
 static const struct power_supply_desc smb347_usb_desc = {
 	.name		= "smb347-usb",
 	.type		= POWER_SUPPLY_TYPE_USB,
-	.get_property	= smb347_usb_get_property,
-	.properties	= smb347_usb_properties,
-	.num_properties	= ARRAY_SIZE(smb347_usb_properties),
-};
-
-static const struct power_supply_desc smb347_battery_desc = {
-	.name		= "smb347-battery",
-	.type		= POWER_SUPPLY_TYPE_BATTERY,
-	.get_property	= smb347_battery_get_property,
-	.properties	= smb347_battery_properties,
-	.num_properties	= ARRAY_SIZE(smb347_battery_properties),
+	.get_property	= smb347_get_property,
+	.properties	= smb347_properties,
+	.num_properties	= ARRAY_SIZE(smb347_properties),
 };
 
 static int smb347_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	static char *battery[] = { "smb347-battery" };
-	struct power_supply_config mains_usb_cfg = {}, battery_cfg = {};
+	struct power_supply_config mains_usb_cfg = {};
 	struct device *dev = &client->dev;
 	struct smb347_charger *smb;
 	int ret;
@@ -1331,8 +1253,6 @@ static int smb347_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	mains_usb_cfg.supplied_to = battery;
-	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
 	mains_usb_cfg.drv_data = smb;
 	mains_usb_cfg.of_node = dev->of_node;
 	if (smb->pdata->use_mains) {
@@ -1352,17 +1272,6 @@ static int smb347_probe(struct i2c_client *client,
 		}
 	}
 
-	battery_cfg.drv_data = smb;
-	smb->battery = power_supply_register(dev, &smb347_battery_desc,
-					     &battery_cfg);
-	if (IS_ERR(smb->battery)) {
-		if (smb->pdata->use_usb)
-			power_supply_unregister(smb->usb);
-		if (smb->pdata->use_mains)
-			power_supply_unregister(smb->mains);
-		return PTR_ERR(smb->battery);
-	}
-
 	/*
 	 * Interrupt pin is optional. If it is connected, we setup the
 	 * interrupt support here.
@@ -1387,7 +1296,6 @@ static int smb347_remove(struct i2c_client *client)
 	if (client->irq)
 		smb347_irq_disable(smb);
 
-	power_supply_unregister(smb->battery);
 	if (smb->pdata->use_usb)
 		power_supply_unregister(smb->usb);
 	if (smb->pdata->use_mains)
-- 
2.25.0

