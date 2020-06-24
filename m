Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9034C207812
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404645AbgFXP4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404351AbgFXP4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:56:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF59DC061573;
        Wed, 24 Jun 2020 08:56:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g18so2818487wrm.2;
        Wed, 24 Jun 2020 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0eRXDu98M9NKV0R7IkrYaYI1Jss3RwntJq8TlK0J3M=;
        b=u1n8/Pfd1zsmvwHOIwFAdpXFBCEJEz99VHTMmmpy89KwouVtNivtqrweIBxKBuQCsO
         TfeoGz26qldEMwNYh9hDI1XnyXYilLL6U0ptbxEfVl9up42fCTL1UGjBlp99ykNFpx7w
         WR8bihnqS1GVLAB0jN3eHsiHq0EffU9ptWUQI5l5gBeCoET5l4BikddXAZ9/oMoLmIQm
         hmr/3JRtg4mi7fhX57Cm5YK93aLY7YvmP9bS2zOzte4yrmGIJN1LhAqnX0wUzaCiVnta
         0GMEcWoaepVf6VL+tZQbgaIel6HA/8POR4oO3k/v2Xm9dimysPK0h/Qp+MQKwInI/PXG
         PttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0eRXDu98M9NKV0R7IkrYaYI1Jss3RwntJq8TlK0J3M=;
        b=Mp6P+LGOrfUol2gr8goA8wq/m9AwjkMsNIm1r03vp+FCQy7ESdQEsWdh810hJzgWpG
         WlIVcdIX3G3ut6yk8ZJi6THGygRt2R/AAIr5xy/T+SxeFI9HJbUFTavi8vSY9wcYHF6m
         Uo9nLjKftLzxoULiqtbkoLYlAv8CyP6Qm84LgN4kw9Lm5TVa1ycs3x8cMr5A25M3CgG6
         kYbmCV36muiZybHwDy2mm+souw3MvRWh6kF7SuTkR8WRy92O2lTGsGnK4pJ/LT6w0w2Z
         p8CgZBH4I2MWbPuvUUzv62/6fcDAhKpyVEOYcWHyQhjKQF1PyndnaQ356Ret0qMQTP2c
         u/Ug==
X-Gm-Message-State: AOAM531mxqjqlkj17RhVJpKEOY7aggP6DBOM9S7TkvwW9I8mAxv8Mv2O
        MfCxs1+UAeMEmokayLttjH8tr3W9lZQ=
X-Google-Smtp-Source: ABdhPJz9fyj06ufYAP3BqfcnXXtQcxvhh9AoXY0nrSORTgtvgbARLxsAqSZqc6LznjMyUA57s6o0sw==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr20373157wro.413.1593014207500;
        Wed, 24 Jun 2020 08:56:47 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id m10sm9398257wru.4.2020.06.24.08.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:56:46 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 1/6] power: supply: max17040: Use regmap i2c
Date:   Wed, 24 Jun 2020 18:56:28 +0300
Message-Id: <20200624155633.3557401-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624155633.3557401-1-iskren.chernev@gmail.com>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rewrite i2c operations from i2c client read/write to regmap i2c. As
a result, most private functions now accept the private driver data
instead of an i2c client pointer.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/power/supply/Kconfig            |   1 +
 drivers/power/supply/max17040_battery.c | 250 +++++++++++-------------
 2 files changed, 110 insertions(+), 141 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 44d3c8512fb8d..12ca79952768f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -367,6 +367,7 @@ config AXP288_FUEL_GAUGE
 config BATTERY_MAX17040
 	tristate "Maxim MAX17040 Fuel Gauge"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
 	  in handheld and portable equipment. The MAX17040 is configured
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 48aa44665e2f1..678241fcc2548 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -16,32 +16,30 @@
 #include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/max17040_battery.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #define MAX17040_VCELL	0x02
 #define MAX17040_SOC	0x04
 #define MAX17040_MODE	0x06
 #define MAX17040_VER	0x08
-#define MAX17040_RCOMP	0x0C
+#define MAX17040_CONFIG	0x0C
 #define MAX17040_CMD	0xFE
 
 
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95
 
-#define MAX17040_ATHD_MASK		0xFFC0
+#define MAX17040_ATHD_MASK		0x3f
 #define MAX17040_ATHD_DEFAULT_POWER_UP	4
 
 struct max17040_chip {
 	struct i2c_client		*client;
+	struct regmap			*regmap;
 	struct delayed_work		work;
 	struct power_supply		*battery;
 	struct max17040_platform_data	*pdata;
 
-	/* State Of Connect */
-	int online;
-	/* battery voltage */
-	int vcell;
 	/* battery capacity */
 	int soc;
 	/* State Of Charge */
@@ -50,135 +48,68 @@ struct max17040_chip {
 	u32 low_soc_alert;
 };
 
-static int max17040_get_property(struct power_supply *psy,
-			    enum power_supply_property psp,
-			    union power_supply_propval *val)
-{
-	struct max17040_chip *chip = power_supply_get_drvdata(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = chip->status;
-		break;
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = chip->online;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = chip->vcell;
-		break;
-	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = chip->soc;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static int max17040_write_reg(struct i2c_client *client, int reg, u16 value)
-{
-	int ret;
-
-	ret = i2c_smbus_write_word_swapped(client, reg, value);
-
-	if (ret < 0)
-		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
-
-	return ret;
-}
-
-static int max17040_read_reg(struct i2c_client *client, int reg)
-{
-	int ret;
-
-	ret = i2c_smbus_read_word_swapped(client, reg);
-
-	if (ret < 0)
-		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
-
-	return ret;
-}
-
-static void max17040_reset(struct i2c_client *client)
+static int max17040_reset(struct max17040_chip *chip)
 {
-	max17040_write_reg(client, MAX17040_CMD, 0x0054);
+	return regmap_write(chip->regmap, MAX17040_CMD, 0x0054);
 }
 
-static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
+static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 level)
 {
-	int ret;
-	u16 data;
-
 	level = 32 - level;
-	data = max17040_read_reg(client, MAX17040_RCOMP);
-	/* clear the alrt bit and set LSb 5 bits */
-	data &= MAX17040_ATHD_MASK;
-	data |= level;
-	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
-
-	return ret;
+	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
+			MAX17040_ATHD_MASK, level);
 }
 
-static void max17040_get_vcell(struct i2c_client *client)
+static int max17040_get_vcell(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-	u16 vcell;
+	u32 vcell;
 
-	vcell = max17040_read_reg(client, MAX17040_VCELL);
+	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
 
-	chip->vcell = (vcell >> 4) * 1250;
+	return (vcell >> 4) * 1250;
 }
 
-static void max17040_get_soc(struct i2c_client *client)
+static int max17040_get_soc(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-	u16 soc;
+	u32 soc;
 
-	soc = max17040_read_reg(client, MAX17040_SOC);
+	regmap_read(chip->regmap, MAX17040_SOC, &soc);
 
-	chip->soc = (soc >> 8);
+	return soc >> 8;
 }
 
-static void max17040_get_version(struct i2c_client *client)
+static int max17040_get_version(struct max17040_chip *chip)
 {
-	u16 version;
+	int ret;
+	u32 version;
 
-	version = max17040_read_reg(client, MAX17040_VER);
+	ret = regmap_read(chip->regmap, MAX17040_VER, &version);
 
-	dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
+	return ret ? ret : version;
 }
 
-static void max17040_get_online(struct i2c_client *client)
+static int max17040_get_online(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-
-	if (chip->pdata && chip->pdata->battery_online)
-		chip->online = chip->pdata->battery_online();
-	else
-		chip->online = 1;
+	return chip->pdata && chip->pdata->battery_online ?
+		chip->pdata->battery_online() : 1;
 }
 
-static void max17040_get_status(struct i2c_client *client)
+static int max17040_get_status(struct max17040_chip *chip)
 {
-	struct max17040_chip *chip = i2c_get_clientdata(client);
-
 	if (!chip->pdata || !chip->pdata->charger_online
-			|| !chip->pdata->charger_enable) {
-		chip->status = POWER_SUPPLY_STATUS_UNKNOWN;
-		return;
-	}
+			|| !chip->pdata->charger_enable)
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+
+	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
+		return POWER_SUPPLY_STATUS_FULL;
 
-	if (chip->pdata->charger_online()) {
+	if (chip->pdata->charger_online())
 		if (chip->pdata->charger_enable())
-			chip->status = POWER_SUPPLY_STATUS_CHARGING;
+			return POWER_SUPPLY_STATUS_CHARGING;
 		else
-			chip->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	} else {
-		chip->status = POWER_SUPPLY_STATUS_DISCHARGING;
-	}
-
-	if (chip->soc > MAX17040_BATTERY_FULL)
-		chip->status = POWER_SUPPLY_STATUS_FULL;
+			return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	else
+		return POWER_SUPPLY_STATUS_DISCHARGING;
 }
 
 static int max17040_get_of_data(struct max17040_chip *chip)
@@ -190,18 +121,31 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 				 "maxim,alert-low-soc-level",
 				 &chip->low_soc_alert);
 
-	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
+	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33) {
+		dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
 		return -EINVAL;
+	}
 
 	return 0;
 }
 
-static void max17040_check_changes(struct i2c_client *client)
+static void max17040_check_changes(struct max17040_chip *chip)
+{
+	chip->soc = max17040_get_soc(chip);
+	chip->status = max17040_get_status(chip);
+}
+
+static void max17040_queue_work(struct max17040_chip *chip)
+{
+	queue_delayed_work(system_power_efficient_wq, &chip->work,
+			   MAX17040_DELAY);
+}
+
+static void max17040_stop_work(void *data)
 {
-	max17040_get_vcell(client);
-	max17040_get_soc(client);
-	max17040_get_online(client);
-	max17040_get_status(client);
+	struct max17040_chip *chip = data;
+
+	cancel_delayed_work_sync(&chip->work);
 }
 
 static void max17040_work(struct work_struct *work)
@@ -214,30 +158,29 @@ static void max17040_work(struct work_struct *work)
 	/* store SOC and status to check changes */
 	last_soc = chip->soc;
 	last_status = chip->status;
-	max17040_check_changes(chip->client);
+	max17040_check_changes(chip);
 
 	/* check changes and send uevent */
 	if (last_soc != chip->soc || last_status != chip->status)
 		power_supply_changed(chip->battery);
 
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
+	max17040_queue_work(chip);
 }
 
 static irqreturn_t max17040_thread_handler(int id, void *dev)
 {
 	struct max17040_chip *chip = dev;
-	struct i2c_client *client = chip->client;
 
-	dev_warn(&client->dev, "IRQ: Alert battery low level");
+	dev_warn(&chip->client->dev, "IRQ: Alert battery low level");
+
 	/* read registers */
-	max17040_check_changes(chip->client);
+	max17040_check_changes(chip);
 
 	/* send uevent */
 	power_supply_changed(chip->battery);
 
 	/* reset alert bit */
-	max17040_set_low_soc_alert(client, chip->low_soc_alert);
+	max17040_set_low_soc_alert(chip, chip->low_soc_alert);
 
 	return IRQ_HANDLED;
 }
@@ -256,6 +199,38 @@ static int max17040_enable_alert_irq(struct max17040_chip *chip)
 	return ret;
 }
 
+static int max17040_get_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    union power_supply_propval *val)
+{
+	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = max17040_get_status(chip);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = max17040_get_online(chip);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = max17040_get_vcell(chip);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = max17040_get_soc(chip);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct regmap_config max17040_regmap = {
+	.reg_bits	= 8,
+	.reg_stride	= 2,
+	.val_bits	= 16,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -287,31 +262,33 @@ static int max17040_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	chip->client = client;
+	chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
 	chip->pdata = client->dev.platform_data;
 	ret = max17040_get_of_data(chip);
-	if (ret) {
-		dev_err(&client->dev,
-			"failed: low SOC alert OF data out of bounds\n");
+	if (ret)
 		return ret;
-	}
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
 
-	chip->battery = power_supply_register(&client->dev,
+	chip->battery = devm_power_supply_register(&client->dev,
 				&max17040_battery_desc, &psy_cfg);
 	if (IS_ERR(chip->battery)) {
 		dev_err(&client->dev, "failed: power supply register\n");
 		return PTR_ERR(chip->battery);
 	}
 
-	max17040_reset(client);
-	max17040_get_version(client);
+	ret = max17040_get_version(chip);
+	if (ret < 0)
+		return ret;
+	dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", ret);
+
+	max17040_reset(chip);
 
 	/* check interrupt */
 	if (client->irq && of_device_is_compatible(client->dev.of_node,
 						   "maxim,max77836-battery")) {
-		ret = max17040_set_low_soc_alert(client, chip->low_soc_alert);
+		ret = max17040_set_low_soc_alert(chip, chip->low_soc_alert);
 		if (ret) {
 			dev_err(&client->dev,
 				"Failed to set low SOC alert: err %d\n", ret);
@@ -327,18 +304,11 @@ static int max17040_probe(struct i2c_client *client,
 	}
 
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
-
-	return 0;
-}
-
-static int max17040_remove(struct i2c_client *client)
-{
-	struct max17040_chip *chip = i2c_get_clientdata(client);
+	ret = devm_add_action(&client->dev, max17040_stop_work, chip);
+	if (ret)
+		return ret;
+	max17040_queue_work(chip);
 
-	power_supply_unregister(chip->battery);
-	cancel_delayed_work(&chip->work);
 	return 0;
 }
 
@@ -362,12 +332,11 @@ static int max17040_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
-	queue_delayed_work(system_power_efficient_wq, &chip->work,
-			   MAX17040_DELAY);
-
 	if (client->irq && device_may_wakeup(dev))
 		disable_irq_wake(client->irq);
 
+	max17040_queue_work(chip);
+
 	return 0;
 }
 
@@ -401,7 +370,6 @@ static struct i2c_driver max17040_i2c_driver = {
 		.pm	= MAX17040_PM_OPS,
 	},
 	.probe		= max17040_probe,
-	.remove		= max17040_remove,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
-- 
2.27.0

