Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AD2A0803
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJ3OgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 10:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJ3OgF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 10:36:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CD9C0613D2
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 07:36:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v19so2187763lji.5
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9K65f9R7PTuDuyM+CIyONzu4pEQkMT//FT88XevfA+c=;
        b=L7y4DMXN0B1ZNgiYqga7c0Lu1v90yEMyyc8eYSFjsis/D0/FQtljgUqg5BoQ1exY93
         wyPz25TmMHrg+5OnkK4AmeFuMrGg4w3Fd2dPIMCQ4bEnndGsQD3ZmsP27PMFV2KE2ar/
         cU/KjtH85R+Pzr33lp/c2Xid8I8g30bKp5SFD7/9A+9lNTN761W3wkAVUZwYJZqCdUEo
         EU3WBrUk71hh5ZzF+uQAj7TgOYINqbjFCgBc4gNiGR7xuoxBdEUVRL2dvfOKKMr2BqGT
         VQZ9pJbapvBikDATFDgRhOB1BPN1pi0W8iNplRi31WK0/RgawQoGIvhkLeKIySzSd9e9
         uIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9K65f9R7PTuDuyM+CIyONzu4pEQkMT//FT88XevfA+c=;
        b=gHhUkoGRIjTwsjhv+jrTCzJbIb+D5inOM4DZH+Bjj2aJOBtOqS5lwwb+B574LbB6B+
         u9UUOoc4bUTocYfcorZuJzvaYB+y3o3n7jqnm3N/Sh8c6OdqGuWYCqzkwKxWk6m0IBuo
         QIZA7P985vIb9VxsnrQfdX4kYKWYoZQy7voamcHCqie30WhniL5xuakirE+emM7vYYgK
         Lyjsv2AS8y1PQBJ4cFdiU2I3o2g+eKIucyWKDb0YJa+X1lDHY1jJI+MGtJEUt1lxsj0M
         dv1vtsNA+uUYjMY9F3/G6rYDFwvs0HLZLEqDw3q916pgzoPfzd4NLoqFaqHMUmCua6cc
         9hvg==
X-Gm-Message-State: AOAM5323IVuM+6IxZHk0os7IDyfmxr06rQozq2QDVcaVUTgOtbHpE5eF
        Reh07Th/+yUsS1nw53KzMDgbwA==
X-Google-Smtp-Source: ABdhPJwRNc013d8FQzm/rd4tNBdu8OtG83L/XDQ/jvRzitAhB1OMp2klOEmoKrfCR5YO0C2Tb93a7w==
X-Received: by 2002:a05:651c:291:: with SMTP id b17mr1153188ljo.34.1604068563947;
        Fri, 30 Oct 2020 07:36:03 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j10sm636262lfe.156.2020.10.30.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:36:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] power: supply: collie_battery: Convert to GPIO descriptors
Date:   Fri, 30 Oct 2020 15:34:01 +0100
Message-Id: <20201030143401.141288-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This converts the Collie battery driver to use GPIO descriptors.
We use a mixture of 3 GPIOs defined in the machine and 3
GPIOs requested directly from the ucb1x00 chip.

Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/collie.c         |  21 ++++
 drivers/power/supply/collie_battery.c | 151 +++++++++++++++++++-------
 2 files changed, 130 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index bd3a52fd09ce..d4e89a02c8c8 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -98,6 +98,26 @@ static struct mcp_plat_data collie_mcp_data = {
 	.codec_pdata	= &collie_ucb1x00_data,
 };
 
+/* Battery management GPIOs */
+static struct gpiod_lookup_table collie_battery_gpiod_table = {
+	/* the MCP codec mcp0 has the ucb1x00 as attached device */
+	.dev_id = "ucb1x00",
+	.table = {
+		/* This is found on the main GPIO on the SA1100 */
+		GPIO_LOOKUP("gpio", COLLIE_GPIO_CO,
+			    "main battery full", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", COLLIE_GPIO_MAIN_BAT_LOW,
+			    "main battery low", GPIO_ACTIVE_HIGH),
+		/*
+		 * This is GPIO 0 on the Scoop expander, which is registered
+		 * from common/scoop.c with this gpio chip label.
+		 */
+		GPIO_LOOKUP("sharp-scoop", 0,
+			    "main charge on", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static int collie_ir_startup(struct device *dev)
 {
 	int rc = gpio_request(COLLIE_GPIO_IR_ON, "IrDA");
@@ -395,6 +415,7 @@ static void __init collie_init(void)
 	platform_scoop_config = &collie_pcmcia_config;
 
 	gpiod_add_lookup_table(&collie_power_gpiod_table);
+	gpiod_add_lookup_table(&collie_battery_gpiod_table);
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
diff --git a/drivers/power/supply/collie_battery.c b/drivers/power/supply/collie_battery.c
index cbd588e9e233..7fb9b549f2de 100644
--- a/drivers/power/supply/collie_battery.c
+++ b/drivers/power/supply/collie_battery.c
@@ -12,7 +12,9 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mfd/ucb1x00.h>
 
 #include <asm/mach/sharpsl_param.h>
@@ -31,18 +33,18 @@ struct collie_bat {
 	struct mutex work_lock; /* protects data */
 
 	bool (*is_present)(struct collie_bat *bat);
-	int gpio_full;
-	int gpio_charge_on;
+	struct gpio_desc *gpio_full;
+	struct gpio_desc *gpio_charge_on;
 
 	int technology;
 
-	int gpio_bat;
+	struct gpio_desc *gpio_bat;
 	int adc_bat;
 	int adc_bat_divider;
 	int bat_max;
 	int bat_min;
 
-	int gpio_temp;
+	struct gpio_desc *gpio_temp;
 	int adc_temp;
 	int adc_temp_divider;
 };
@@ -53,15 +55,15 @@ static unsigned long collie_read_bat(struct collie_bat *bat)
 {
 	unsigned long value = 0;
 
-	if (bat->gpio_bat < 0 || bat->adc_bat < 0)
+	if (!bat->gpio_bat || bat->adc_bat < 0)
 		return 0;
 	mutex_lock(&bat_lock);
-	gpio_set_value(bat->gpio_bat, 1);
+	gpiod_set_value(bat->gpio_bat, 1);
 	msleep(5);
 	ucb1x00_adc_enable(ucb);
 	value = ucb1x00_adc_read(ucb, bat->adc_bat, UCB_SYNC);
 	ucb1x00_adc_disable(ucb);
-	gpio_set_value(bat->gpio_bat, 0);
+	gpiod_set_value(bat->gpio_bat, 0);
 	mutex_unlock(&bat_lock);
 	value = value * 1000000 / bat->adc_bat_divider;
 
@@ -71,16 +73,16 @@ static unsigned long collie_read_bat(struct collie_bat *bat)
 static unsigned long collie_read_temp(struct collie_bat *bat)
 {
 	unsigned long value = 0;
-	if (bat->gpio_temp < 0 || bat->adc_temp < 0)
+	if (!bat->gpio_temp || bat->adc_temp < 0)
 		return 0;
 
 	mutex_lock(&bat_lock);
-	gpio_set_value(bat->gpio_temp, 1);
+	gpiod_set_value(bat->gpio_temp, 1);
 	msleep(5);
 	ucb1x00_adc_enable(ucb);
 	value = ucb1x00_adc_read(ucb, bat->adc_temp, UCB_SYNC);
 	ucb1x00_adc_disable(ucb);
-	gpio_set_value(bat->gpio_temp, 0);
+	gpiod_set_value(bat->gpio_temp, 0);
 	mutex_unlock(&bat_lock);
 
 	value = value * 10000 / bat->adc_temp_divider;
@@ -162,23 +164,23 @@ static void collie_bat_update(struct collie_bat *bat)
 		bat->full_chrg = -1;
 	} else if (power_supply_am_i_supplied(psy)) {
 		if (bat->status == POWER_SUPPLY_STATUS_DISCHARGING) {
-			gpio_set_value(bat->gpio_charge_on, 1);
+			gpiod_set_value(bat->gpio_charge_on, 1);
 			mdelay(15);
 		}
 
-		if (gpio_get_value(bat->gpio_full)) {
+		if (gpiod_get_value(bat->gpio_full)) {
 			if (old == POWER_SUPPLY_STATUS_CHARGING ||
 					bat->full_chrg == -1)
 				bat->full_chrg = collie_read_bat(bat);
 
-			gpio_set_value(bat->gpio_charge_on, 0);
+			gpiod_set_value(bat->gpio_charge_on, 0);
 			bat->status = POWER_SUPPLY_STATUS_FULL;
 		} else {
-			gpio_set_value(bat->gpio_charge_on, 1);
+			gpiod_set_value(bat->gpio_charge_on, 1);
 			bat->status = POWER_SUPPLY_STATUS_CHARGING;
 		}
 	} else {
-		gpio_set_value(bat->gpio_charge_on, 0);
+		gpiod_set_value(bat->gpio_charge_on, 0);
 		bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
 	}
 
@@ -230,18 +232,18 @@ static struct collie_bat collie_bat_main = {
 	.full_chrg = -1,
 	.psy = NULL,
 
-	.gpio_full = COLLIE_GPIO_CO,
-	.gpio_charge_on = COLLIE_GPIO_CHARGE_ON,
+	.gpio_full = NULL,
+	.gpio_charge_on = NULL,
 
 	.technology = POWER_SUPPLY_TECHNOLOGY_LIPO,
 
-	.gpio_bat = COLLIE_GPIO_MBAT_ON,
+	.gpio_bat = NULL,
 	.adc_bat = UCB_ADC_INP_AD1,
 	.adc_bat_divider = 155,
 	.bat_max = 4310000,
 	.bat_min = 1551 * 1000000 / 414,
 
-	.gpio_temp = COLLIE_GPIO_TMP_ON,
+	.gpio_temp = NULL,
 	.adc_temp = UCB_ADC_INP_AD0,
 	.adc_temp_divider = 10000,
 };
@@ -260,30 +262,24 @@ static struct collie_bat collie_bat_bu = {
 	.full_chrg = -1,
 	.psy = NULL,
 
-	.gpio_full = -1,
-	.gpio_charge_on = -1,
+	.gpio_full = NULL,
+	.gpio_charge_on = NULL,
 
 	.technology = POWER_SUPPLY_TECHNOLOGY_LiMn,
 
-	.gpio_bat = COLLIE_GPIO_BBAT_ON,
+	.gpio_bat = NULL,
 	.adc_bat = UCB_ADC_INP_AD1,
 	.adc_bat_divider = 155,
 	.bat_max = 3000000,
 	.bat_min = 1900000,
 
-	.gpio_temp = -1,
+	.gpio_temp = NULL,
 	.adc_temp = -1,
 	.adc_temp_divider = -1,
 };
 
-static struct gpio collie_batt_gpios[] = {
-	{ COLLIE_GPIO_CO,	    GPIOF_IN,		"main battery full" },
-	{ COLLIE_GPIO_MAIN_BAT_LOW, GPIOF_IN,		"main battery low" },
-	{ COLLIE_GPIO_CHARGE_ON,    GPIOF_OUT_INIT_LOW,	"main charge on" },
-	{ COLLIE_GPIO_MBAT_ON,	    GPIOF_OUT_INIT_LOW,	"main battery" },
-	{ COLLIE_GPIO_TMP_ON,	    GPIOF_OUT_INIT_LOW,	"main battery temp" },
-	{ COLLIE_GPIO_BBAT_ON,	    GPIOF_OUT_INIT_LOW,	"backup battery" },
-};
+/* Obtained but unused GPIO */
+static struct gpio_desc *collie_mbat_low;
 
 #ifdef CONFIG_PM
 static int wakeup_enabled;
@@ -295,7 +291,7 @@ static int collie_bat_suspend(struct ucb1x00_dev *dev)
 
 	if (device_may_wakeup(&dev->ucb->dev) &&
 	    collie_bat_main.status == POWER_SUPPLY_STATUS_CHARGING)
-		wakeup_enabled = !enable_irq_wake(gpio_to_irq(COLLIE_GPIO_CO));
+		wakeup_enabled = !enable_irq_wake(gpiod_to_irq(collie_bat_main.gpio_full));
 	else
 		wakeup_enabled = 0;
 
@@ -305,7 +301,7 @@ static int collie_bat_suspend(struct ucb1x00_dev *dev)
 static int collie_bat_resume(struct ucb1x00_dev *dev)
 {
 	if (wakeup_enabled)
-		disable_irq_wake(gpio_to_irq(COLLIE_GPIO_CO));
+		disable_irq_wake(gpiod_to_irq(collie_bat_main.gpio_full));
 
 	/* things may have changed while we were away */
 	schedule_work(&bat_work);
@@ -320,16 +316,71 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 {
 	int ret;
 	struct power_supply_config psy_main_cfg = {}, psy_bu_cfg = {};
+	struct gpio_chip *gc = &dev->ucb->gpio;
 
 	if (!machine_is_collie())
 		return -ENODEV;
 
 	ucb = dev->ucb;
 
-	ret = gpio_request_array(collie_batt_gpios,
-				 ARRAY_SIZE(collie_batt_gpios));
-	if (ret)
-		return ret;
+	/* Obtain all the main battery GPIOs */
+	collie_bat_main.gpio_full = gpiod_get(&dev->ucb->dev,
+					      "main battery full",
+					      GPIOD_IN);
+	if (IS_ERR(collie_bat_main.gpio_full))
+		return PTR_ERR(collie_bat_main.gpio_full);
+
+	collie_mbat_low = gpiod_get(&dev->ucb->dev,
+				    "main battery low",
+				    GPIOD_IN);
+	if (IS_ERR(collie_mbat_low)) {
+		ret = PTR_ERR(collie_mbat_low);
+		goto err_put_gpio_full;
+	}
+
+	collie_bat_main.gpio_charge_on = gpiod_get(&dev->ucb->dev,
+						   "main charge on",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(collie_bat_main.gpio_charge_on)) {
+		ret = PTR_ERR(collie_bat_main.gpio_charge_on);
+		goto err_put_mbat_low;
+	}
+
+	/* COLLIE_GPIO_MBAT_ON = GPIO 7 on the UCB (TC35143) */
+	collie_bat_main.gpio_bat = gpiochip_request_own_desc(gc,
+						7,
+						"main battery",
+						GPIO_ACTIVE_HIGH,
+						GPIOD_OUT_LOW);
+	if (IS_ERR(collie_bat_main.gpio_bat)) {
+		ret = PTR_ERR(collie_bat_main.gpio_bat);
+		goto err_put_gpio_charge_on;
+	}
+
+	/* COLLIE_GPIO_TMP_ON = GPIO 9 on the UCB (TC35143) */
+	collie_bat_main.gpio_temp = gpiochip_request_own_desc(gc,
+						9,
+						"main battery temp",
+						GPIO_ACTIVE_HIGH,
+						GPIOD_OUT_LOW);
+	if (IS_ERR(collie_bat_main.gpio_temp)) {
+		ret = PTR_ERR(collie_bat_main.gpio_temp);
+		goto err_free_gpio_bat;
+	}
+
+	/*
+	 * Obtain the backup battery COLLIE_GPIO_BBAT_ON which is
+	 * GPIO 8 on the UCB (TC35143)
+	 */
+	collie_bat_bu.gpio_bat = gpiochip_request_own_desc(gc,
+						8,
+						"backup battery",
+						GPIO_ACTIVE_HIGH,
+						GPIOD_OUT_LOW);
+	if (IS_ERR(collie_bat_bu.gpio_bat)) {
+		ret = PTR_ERR(collie_bat_bu.gpio_bat);
+		goto err_free_gpio_temp;
+	}
 
 	mutex_init(&collie_bat_main.work_lock);
 
@@ -370,27 +421,43 @@ static int collie_bat_probe(struct ucb1x00_dev *dev)
 err_psy_reg_bu:
 	power_supply_unregister(collie_bat_main.psy);
 err_psy_reg_main:
-
 	/* see comment in collie_bat_remove */
 	cancel_work_sync(&bat_work);
-	gpio_free_array(collie_batt_gpios, ARRAY_SIZE(collie_batt_gpios));
+	gpiochip_free_own_desc(collie_bat_bu.gpio_bat);
+err_free_gpio_temp:
+	gpiochip_free_own_desc(collie_bat_main.gpio_temp);
+err_free_gpio_bat:
+	gpiochip_free_own_desc(collie_bat_main.gpio_bat);
+err_put_gpio_charge_on:
+	gpiod_put(collie_bat_main.gpio_charge_on);
+err_put_mbat_low:
+	gpiod_put(collie_mbat_low);
+err_put_gpio_full:
+	gpiod_put(collie_bat_main.gpio_full);
+
 	return ret;
 }
 
 static void collie_bat_remove(struct ucb1x00_dev *dev)
 {
 	free_irq(gpio_to_irq(COLLIE_GPIO_CO), &collie_bat_main);
-
 	power_supply_unregister(collie_bat_bu.psy);
 	power_supply_unregister(collie_bat_main.psy);
 
+	/* These are obtained from the machine */
+	gpiod_put(collie_bat_main.gpio_full);
+	gpiod_put(collie_mbat_low);
+	gpiod_put(collie_bat_main.gpio_charge_on);
+	/* These are directly from the UCB so let's free them */
+	gpiochip_free_own_desc(collie_bat_main.gpio_bat);
+	gpiochip_free_own_desc(collie_bat_main.gpio_temp);
+	gpiochip_free_own_desc(collie_bat_bu.gpio_bat);
 	/*
 	 * Now cancel the bat_work.  We won't get any more schedules,
 	 * since all sources (isr and external_power_changed) are
 	 * unregistered now.
 	 */
 	cancel_work_sync(&bat_work);
-	gpio_free_array(collie_batt_gpios, ARRAY_SIZE(collie_batt_gpios));
 }
 
 static struct ucb1x00_driver collie_bat_driver = {
-- 
2.26.2

