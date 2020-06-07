Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3601F0C0E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgFGOpe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgFGOp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1D8C08C5C5;
        Sun,  7 Jun 2020 07:45:25 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so6363719ljb.12;
        Sun, 07 Jun 2020 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXE4lBOODapYr9LH1elDIiR9HeDoap/PYoJe31d+vUI=;
        b=trHAMxcEajrBshFTId0H92JS1zkovwJgK/8iZ7GEbkCCTmsOmDg+1OV5mg1tS1RBUQ
         T170v1fKY9Yu+h0qItT86SEr70aD/fdaF3uu03PxSTXN5CVoZAAc87vbyqHLit1MwZma
         JMcD9ukXp2jYHeO8D09zY3ARwR+RzU4jXlDpmefBNPptcXvCdLc8QR6P12EgjjTRKTM7
         cnt8E29R6sc35kZT98Vsi789ctBnaZS7aWIyBBQdAY06TJ/+R96Bkb7je0TWT+DPmaH1
         kq9GO6D/M95nl8eYoDHfO4DGieugwv9vHFUVRrOitHznc+i12O7mEVi780DR2q7vAJmY
         Ub9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXE4lBOODapYr9LH1elDIiR9HeDoap/PYoJe31d+vUI=;
        b=f/RTJSKFReih7R4bazrnn1nWREIdXWRlnx2QcDqMj6+ENgn0er/lyiM+iOQkPdrAa7
         nCh+gDI9PAtvcLw1UWjDjJvQOtkavVfbfkB63uvxhFbXMklAlzO20ZG+vtLfaIYftkvk
         gqPmZmnhlcqt6hpKrj928qoEEKaDWBwxjVUHVOQElhMd2H5MqjsFdCVNlLCyl4C5TAVU
         pWzA/TsANofgMADcfWt/F5uyJNEqatunRlv954GV5HiHQ0KBM9zYIEvlmgOVG3gD+t7f
         fLcyuf2Q6hChPFJ0jUOoyrrdYp7mEn+wWd6c7VC1zqfC5si9O3XjAKGDMBfNEYH8NMwO
         pw/w==
X-Gm-Message-State: AOAM532MrxRVcMsEG+dav0Co3iPg2AOIs2pHBDlQEqOkHYa6S1afUTx9
        TQc3VCFiMf7qUoamTZXmRaU=
X-Google-Smtp-Source: ABdhPJwTHL/+8wo5bG0EF7b2WX1RNAOmgsy4PE8lQnd/mdNmas7mJRxbIqHuG78oZAQtoviLrSUvMw==
X-Received: by 2002:a2e:81d4:: with SMTP id s20mr9116331ljg.184.1591541124437;
        Sun, 07 Jun 2020 07:45:24 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 7/9] power: supply: smb347-charger: Remove virtual smb347-battery
Date:   Sun,  7 Jun 2020 17:41:11 +0300
Message-Id: <20200607144113.10202-8-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

SMB347 is a charger and not a battery driver. Secondly, power-supply core
now supports monitored-battery. So the 'fake' battery doesn't do anything
useful for us, and thus, it should be removed.

Transfer smb347-battery functionality into smb347-mains and smb347-usb.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 206 ++++++++------------------
 1 file changed, 60 insertions(+), 146 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 90a87e0624a6..335b6ee494e4 100644
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
@@ -1308,32 +1239,23 @@ static const struct regmap_config smb347_regmap = {
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
@@ -1359,8 +1281,6 @@ static int smb347_probe(struct i2c_client *client,
 	if (IS_ERR(smb->regmap))
 		return PTR_ERR(smb->regmap);
 
-	mains_usb_cfg.supplied_to = battery;
-	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
 	mains_usb_cfg.drv_data = smb;
 	mains_usb_cfg.of_node = dev->of_node;
 	if (smb->pdata->use_mains) {
@@ -1377,12 +1297,6 @@ static int smb347_probe(struct i2c_client *client,
 			return PTR_ERR(smb->usb);
 	}
 
-	battery_cfg.drv_data = smb;
-	smb->battery = devm_power_supply_register(dev, &smb347_battery_desc,
-						  &battery_cfg);
-	if (IS_ERR(smb->battery))
-		return PTR_ERR(smb->battery);
-
 	ret = smb347_get_battery_info(smb);
 	if (ret)
 		return ret;
-- 
2.26.0

