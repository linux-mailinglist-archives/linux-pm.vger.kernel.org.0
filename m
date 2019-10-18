Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1E8DC972
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 17:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505175AbfJRPn6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 11:43:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505176AbfJRPmn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 11:42:43 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MbAUg-1hjwif2ieu-00bbDZ; Fri, 18 Oct 2019 17:42:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 40/46] ARM: pxa: tosa: use gpio lookup for battery
Date:   Fri, 18 Oct 2019 17:41:55 +0200
Message-Id: <20191018154201.1276638-40-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vGkbVXC2rTpnIcpMcBy/b3uxL1GV7eQNHJm+ed84O3kfbMVUawC
 XkhgZyqpcHs2RyU67aI8zijBGmnlxenzL4l/LnzxgZtUlbk7S0seTyjXNhdMTZkZsx8aPCH
 bceYedycFn5Ud2xQWQn3sxG7oAV3X4UxMidmHLhFYdhQUvZTIacWG5iuk+dAgMiiPRMRmc9
 sZ+9pyba3lPqOVnQHf5IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BSgjsuIcgl4=:9jRpG4nRNvZyu3DiLObmw+
 I9+MaKE2rtjTmnJqiG0+FMfYTp+KLiSooSWwnj8dmK4KUG40moln+VuQaiBU5ov/NoN7c/0qW
 CabwCT9/fEIH6/BOkE/XG1o1IfnvJ3eRj0Ty91cR3i8SvMwIXhLg7NQaH9X4QDm+reXmSmx0b
 mp6oLQmHq6Xnfmbw2Ka7Rv9846nSAlNa55MlKgYs4OgekGwJLIX+AKG3uHUlKbNq0Y3MnxUXS
 gmh64owYx3mpJbjqzV6LVNIapKHa21/If0YcnowMxmqBdwog+j2NAr96Z2//Tf6cOwZOCSopM
 qSFqVJ1SXCez0fhFtY3BHUuoufr1B9uXjDUJmL8fhJXowrxjbXbYqwa/hgeA+dj3OjLFhynqX
 /X8X8pWzQfMAQimpvHFPkK1QJ/yPcPOYwSI9ouBn/8Yvc7g8CiaLkk8JNrN3Pc+UsovoeJ2ZY
 +EsuOIpEKrrKonfKoNt7ZXW0jZ6VmH7BzFkKdf99ksUIN35+Bilp/5BsCiViMqNX7EPMuUK03
 XbJtz/yTMVno0i/gyQdryCGFuT1LYhT7O8Z3X5LNz+1xwovjDyMhHXeEBHJriQuCGoZcmH0PS
 WOGl8k46XXEoVLDY4v15hzDZrUXYXBnfjKWHpXmloh9LmJF6cf8VhF1ce4ZVbWe1IkH5hI3Kg
 OUZUvQxGvaVce0yIOf47QoyTGs7zmEGgCtQ37zv4Li/ArU8YYyVxcDqb2iI1qXOQnPrrxY+PD
 6N0L2bajYpFmKgdpe3HboYJ7cX9Jh2hPAOIZXezFv1VHIC7RgWxOxHfKzo32eSkICE/RkM/KW
 GhX9rwqqBe8vTiN3EBbX/adr/8G2kVWxV7ykH8wFMlyyVOWVZ3CmCfM2oxWy0a8P7eDANtK45
 4QBPXqbcP2Bu6vj4bpQA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The battery driver uses a lot of GPIO lines, hardcoded from a
machine header file.

Change it to use a gpiod lookup table instead.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/tosa.c            |  23 +++++
 drivers/power/supply/tosa_battery.c | 147 ++++++++++++++++------------
 2 files changed, 109 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 8329a2969b2b..ef3bbf6d158e 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -365,6 +365,28 @@ static struct pxaficp_platform_data tosa_ficp_platform_data = {
 	.shutdown		= tosa_irda_shutdown,
 };
 
+static struct gpiod_lookup_table tosa_battery_gpio_table = {
+	.dev_id = "wm97xx-battery",
+	.table = {
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_CHARGE_OFF - TOSA_TC6393XB_GPIO_BASE,    "main charge off", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_CHARGE_OFF_JC - TOSA_TC6393XB_GPIO_BASE, "jacket charge off", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT_SW_ON - TOSA_TC6393XB_GPIO_BASE,     "battery switch", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT0_V_ON - TOSA_TC6393XB_GPIO_BASE,     "main battery", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT1_V_ON - TOSA_TC6393XB_GPIO_BASE,     "jacket battery", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT1_TH_ON - TOSA_TC6393XB_GPIO_BASE,    "main battery temp", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BAT0_TH_ON - TOSA_TC6393XB_GPIO_BASE,    "jacket battery temp", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("tc6393xb", TOSA_GPIO_BU_CHRG_ON - TOSA_TC6393XB_GPIO_BASE,    "backup battery", GPIO_ACTIVE_HIGH ),
+
+		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT0_CRG,      "main battery full", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT1_CRG,      "jacket battery full", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT0_LOW,      "main battery low", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_BAT1_LOW,      "jacket battery low", GPIO_ACTIVE_HIGH ),
+		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_JACKET_DETECT, "jacket detect", GPIO_ACTIVE_HIGH ),
+		{ },
+	},
+};
+
+
 /*
  * Tosa AC IN
  */
@@ -946,6 +968,7 @@ static void __init tosa_init(void)
 	/* enable batt_fault */
 	PMCR = 0x01;
 
+	gpiod_add_lookup_table(&tosa_battery_gpio_table);
 	gpiod_add_lookup_table(&tosa_mci_gpio_table);
 	gpiod_add_lookup_table(&tosa_audio_gpio_table);
 	pxa_set_mci_info(&tosa_mci_platform_data);
diff --git a/drivers/power/supply/tosa_battery.c b/drivers/power/supply/tosa_battery.c
index b26b0eca33e1..d10320f348d0 100644
--- a/drivers/power/supply/tosa_battery.c
+++ b/drivers/power/supply/tosa_battery.c
@@ -15,11 +15,16 @@
 #include <linux/gpio.h>
 
 #include <asm/mach-types.h>
-#include <mach/tosa.h>
 
 static DEFINE_MUTEX(bat_lock); /* protects gpio pins */
 static struct work_struct bat_work;
 
+struct tosa_gpio {
+	const char *con;
+	enum gpiod_flags flags;
+	struct gpio_desc *desc;
+};
+
 struct tosa_bat {
 	int status;
 	struct power_supply *psy;
@@ -28,38 +33,42 @@ struct tosa_bat {
 	struct mutex work_lock; /* protects data */
 
 	bool (*is_present)(struct tosa_bat *bat);
-	int gpio_full;
-	int gpio_charge_off;
+	struct tosa_gpio gpio_full;
+	struct tosa_gpio gpio_charge_off;
 
 	int technology;
 
-	int gpio_bat;
+	struct tosa_gpio gpio_bat;
 	int adc_bat;
 	int adc_bat_divider;
 	int bat_max;
 	int bat_min;
 
-	int gpio_temp;
+	struct tosa_gpio gpio_temp;
 	int adc_temp;
 	int adc_temp_divider;
 };
 
 static struct tosa_bat tosa_bat_main;
 static struct tosa_bat tosa_bat_jacket;
+static struct tosa_gpio gpiod_jacket_det = { "jacket detect", GPIOD_IN };
+static struct tosa_gpio gpiod_battery_switch = { "battery switch", GPIOD_OUT_LOW };
+static struct tosa_gpio gpiod_main_battery_low = { "main battery low", GPIOD_IN };
+static struct tosa_gpio gpiod_jacket_battery_low = { "jacket battery low", GPIOD_IN };
 
 static unsigned long tosa_read_bat(struct tosa_bat *bat)
 {
 	unsigned long value = 0;
 
-	if (bat->gpio_bat < 0 || bat->adc_bat < 0)
+	if (!bat->gpio_bat.desc || bat->adc_bat < 0)
 		return 0;
 
 	mutex_lock(&bat_lock);
-	gpio_set_value(bat->gpio_bat, 1);
+	gpiod_set_value(bat->gpio_bat.desc, 1);
 	msleep(5);
 	value = wm97xx_read_aux_adc(dev_get_drvdata(bat->psy->dev.parent),
 			bat->adc_bat);
-	gpio_set_value(bat->gpio_bat, 0);
+	gpiod_set_value(bat->gpio_bat.desc, 0);
 	mutex_unlock(&bat_lock);
 
 	value = value * 1000000 / bat->adc_bat_divider;
@@ -71,15 +80,15 @@ static unsigned long tosa_read_temp(struct tosa_bat *bat)
 {
 	unsigned long value = 0;
 
-	if (bat->gpio_temp < 0 || bat->adc_temp < 0)
+	if (!bat->gpio_temp.desc || bat->adc_temp < 0)
 		return 0;
 
 	mutex_lock(&bat_lock);
-	gpio_set_value(bat->gpio_temp, 1);
+	gpiod_set_value(bat->gpio_temp.desc, 1);
 	msleep(5);
 	value = wm97xx_read_aux_adc(dev_get_drvdata(bat->psy->dev.parent),
 			bat->adc_temp);
-	gpio_set_value(bat->gpio_temp, 0);
+	gpiod_set_value(bat->gpio_temp.desc, 0);
 	mutex_unlock(&bat_lock);
 
 	value = value * 10000 / bat->adc_temp_divider;
@@ -136,7 +145,7 @@ static int tosa_bat_get_property(struct power_supply *psy,
 
 static bool tosa_jacket_bat_is_present(struct tosa_bat *bat)
 {
-	return gpio_get_value(TOSA_GPIO_JACKET_DETECT) == 0;
+	return gpiod_get_value(gpiod_jacket_det.desc) == 0;
 }
 
 static void tosa_bat_external_power_changed(struct power_supply *psy)
@@ -166,23 +175,23 @@ static void tosa_bat_update(struct tosa_bat *bat)
 		bat->full_chrg = -1;
 	} else if (power_supply_am_i_supplied(psy)) {
 		if (bat->status == POWER_SUPPLY_STATUS_DISCHARGING) {
-			gpio_set_value(bat->gpio_charge_off, 0);
+			gpiod_set_value(bat->gpio_charge_off.desc, 0);
 			mdelay(15);
 		}
 
-		if (gpio_get_value(bat->gpio_full)) {
+		if (gpiod_get_value(bat->gpio_full.desc)) {
 			if (old == POWER_SUPPLY_STATUS_CHARGING ||
 					bat->full_chrg == -1)
 				bat->full_chrg = tosa_read_bat(bat);
 
-			gpio_set_value(bat->gpio_charge_off, 1);
+			gpiod_set_value(bat->gpio_charge_off.desc, 1);
 			bat->status = POWER_SUPPLY_STATUS_FULL;
 		} else {
-			gpio_set_value(bat->gpio_charge_off, 0);
+			gpiod_set_value(bat->gpio_charge_off.desc, 0);
 			bat->status = POWER_SUPPLY_STATUS_CHARGING;
 		}
 	} else {
-		gpio_set_value(bat->gpio_charge_off, 1);
+		gpiod_set_value(bat->gpio_charge_off.desc, 1);
 		bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
 	}
 
@@ -251,18 +260,18 @@ static struct tosa_bat tosa_bat_main = {
 	.full_chrg = -1,
 	.psy = NULL,
 
-	.gpio_full = TOSA_GPIO_BAT0_CRG,
-	.gpio_charge_off = TOSA_GPIO_CHARGE_OFF,
+	.gpio_full = { "main battery full", GPIOD_IN },
+	.gpio_charge_off = { "main charge off" , GPIOD_OUT_HIGH },
 
 	.technology = POWER_SUPPLY_TECHNOLOGY_LIPO,
 
-	.gpio_bat = TOSA_GPIO_BAT0_V_ON,
+	.gpio_bat = { "main battery", GPIOD_OUT_LOW },
 	.adc_bat = WM97XX_AUX_ID3,
 	.adc_bat_divider = 414,
 	.bat_max = 4310000,
 	.bat_min = 1551 * 1000000 / 414,
 
-	.gpio_temp = TOSA_GPIO_BAT1_TH_ON,
+	.gpio_temp = { "main battery temp", GPIOD_OUT_LOW },
 	.adc_temp = WM97XX_AUX_ID2,
 	.adc_temp_divider = 10000,
 };
@@ -273,18 +282,18 @@ static struct tosa_bat tosa_bat_jacket = {
 	.psy = NULL,
 
 	.is_present = tosa_jacket_bat_is_present,
-	.gpio_full = TOSA_GPIO_BAT1_CRG,
-	.gpio_charge_off = TOSA_GPIO_CHARGE_OFF_JC,
+	.gpio_full = { "jacket battery full", GPIOD_IN },
+	.gpio_charge_off = { "jacket charge off", GPIOD_OUT_HIGH },
 
 	.technology = POWER_SUPPLY_TECHNOLOGY_LIPO,
 
-	.gpio_bat = TOSA_GPIO_BAT1_V_ON,
+	.gpio_bat = { "jacket battery", GPIOD_OUT_LOW },
 	.adc_bat = WM97XX_AUX_ID3,
 	.adc_bat_divider = 414,
 	.bat_max = 4310000,
 	.bat_min = 1551 * 1000000 / 414,
 
-	.gpio_temp = TOSA_GPIO_BAT0_TH_ON,
+	.gpio_temp = { "jacket battery temp", GPIOD_OUT_LOW },
 	.adc_temp = WM97XX_AUX_ID2,
 	.adc_temp_divider = 10000,
 };
@@ -294,36 +303,16 @@ static struct tosa_bat tosa_bat_bu = {
 	.full_chrg = -1,
 	.psy = NULL,
 
-	.gpio_full = -1,
-	.gpio_charge_off = -1,
-
 	.technology = POWER_SUPPLY_TECHNOLOGY_LiMn,
 
-	.gpio_bat = TOSA_GPIO_BU_CHRG_ON,
+	.gpio_bat = { "backup battery", GPIOD_OUT_LOW },
 	.adc_bat = WM97XX_AUX_ID4,
 	.adc_bat_divider = 1266,
 
-	.gpio_temp = -1,
 	.adc_temp = -1,
 	.adc_temp_divider = -1,
 };
 
-static struct gpio tosa_bat_gpios[] = {
-	{ TOSA_GPIO_CHARGE_OFF,	   GPIOF_OUT_INIT_HIGH, "main charge off" },
-	{ TOSA_GPIO_CHARGE_OFF_JC, GPIOF_OUT_INIT_HIGH, "jacket charge off" },
-	{ TOSA_GPIO_BAT_SW_ON,	   GPIOF_OUT_INIT_LOW,	"battery switch" },
-	{ TOSA_GPIO_BAT0_V_ON,	   GPIOF_OUT_INIT_LOW,	"main battery" },
-	{ TOSA_GPIO_BAT1_V_ON,	   GPIOF_OUT_INIT_LOW,	"jacket battery" },
-	{ TOSA_GPIO_BAT1_TH_ON,	   GPIOF_OUT_INIT_LOW,	"main battery temp" },
-	{ TOSA_GPIO_BAT0_TH_ON,	   GPIOF_OUT_INIT_LOW,	"jacket battery temp" },
-	{ TOSA_GPIO_BU_CHRG_ON,	   GPIOF_OUT_INIT_LOW,	"backup battery" },
-	{ TOSA_GPIO_BAT0_CRG,	   GPIOF_IN,		"main battery full" },
-	{ TOSA_GPIO_BAT1_CRG,	   GPIOF_IN,		"jacket battery full" },
-	{ TOSA_GPIO_BAT0_LOW,	   GPIOF_IN,		"main battery low" },
-	{ TOSA_GPIO_BAT1_LOW,	   GPIOF_IN,		"jacket battery low" },
-	{ TOSA_GPIO_JACKET_DETECT, GPIOF_IN,		"jacket detect" },
-};
-
 #ifdef CONFIG_PM
 static int tosa_bat_suspend(struct platform_device *dev, pm_message_t state)
 {
@@ -343,6 +332,21 @@ static int tosa_bat_resume(struct platform_device *dev)
 #define tosa_bat_resume NULL
 #endif
 
+static int tosa_bat_gpio_get(struct device *dev, struct tosa_gpio *gpio)
+{
+	int ret;
+
+	if (!gpio->con)
+		return 0;
+
+	gpio->desc = devm_gpiod_get(dev, gpio->con, gpio->flags);
+	ret = PTR_ERR_OR_ZERO(gpio->desc);
+	if (ret)
+		dev_warn(dev, "failed to get gpio \"%s\"\n", gpio->con);
+
+	return ret;
+}
+
 static int tosa_power_supply_register(struct device *dev,
 			struct tosa_bat *bat,
 			const struct power_supply_desc *desc)
@@ -350,6 +354,23 @@ static int tosa_power_supply_register(struct device *dev,
 	struct power_supply_config cfg = {
 		.drv_data = bat,
 	};
+	int ret;
+
+	ret = tosa_bat_gpio_get(dev, &bat->gpio_full);
+	if (ret)
+		return ret;
+
+	ret = tosa_bat_gpio_get(dev, &bat->gpio_charge_off);
+	if (ret)
+		return ret;
+
+	ret = tosa_bat_gpio_get(dev, &bat->gpio_bat);
+	if (ret)
+		return ret;
+
+	ret = tosa_bat_gpio_get(dev, &bat->gpio_temp);
+	if (ret)
+		return ret;
 
 	mutex_init(&bat->work_lock);
 	bat->psy = power_supply_register(dev, desc, &cfg);
@@ -358,49 +379,55 @@ static int tosa_power_supply_register(struct device *dev,
 }
 
 
-static int tosa_bat_probe(struct platform_device *dev)
+static int tosa_bat_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	if (!machine_is_tosa())
 		return -ENODEV;
 
-	ret = gpio_request_array(tosa_bat_gpios, ARRAY_SIZE(tosa_bat_gpios));
+	ret = tosa_bat_gpio_get(dev, &gpiod_jacket_det);
 	if (ret)
 		return ret;
 
+	/* these are not used anywhere, continue on failure */
+	tosa_bat_gpio_get(dev, &gpiod_battery_switch);
+	tosa_bat_gpio_get(dev, &gpiod_main_battery_low);
+	tosa_bat_gpio_get(dev, &gpiod_jacket_battery_low);
+
 	INIT_WORK(&bat_work, tosa_bat_work);
 
-	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_main,
+	ret = tosa_power_supply_register(dev, &tosa_bat_main,
 					 &tosa_bat_main_desc);
 	if (ret)
 		goto err_psy_reg_main;
 
-	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_jacket,
+	ret = tosa_power_supply_register(dev, &tosa_bat_jacket,
 					 &tosa_bat_jacket_desc);
 	if (ret)
 		goto err_psy_reg_jacket;
 
-	ret = tosa_power_supply_register(&dev->dev, &tosa_bat_bu,
+	ret = tosa_power_supply_register(dev, &tosa_bat_bu,
 					 &tosa_bat_bu_desc);
 	if (ret)
 		goto err_psy_reg_bu;
 
-	ret = request_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG),
+	ret = request_irq(gpiod_to_irq(tosa_bat_main.gpio_full.desc),
 				tosa_bat_gpio_isr,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"main full", &tosa_bat_main);
 	if (ret)
 		goto err_req_main;
 
-	ret = request_irq(gpio_to_irq(TOSA_GPIO_BAT1_CRG),
+	ret = request_irq(gpiod_to_irq(tosa_bat_jacket.gpio_full.desc),
 				tosa_bat_gpio_isr,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"jacket full", &tosa_bat_jacket);
 	if (ret)
 		goto err_req_jacket;
 
-	ret = request_irq(gpio_to_irq(TOSA_GPIO_JACKET_DETECT),
+	ret = request_irq(gpiod_to_irq(gpiod_jacket_det.desc),
 				tosa_bat_gpio_isr,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"jacket detect", &tosa_bat_jacket);
@@ -409,9 +436,9 @@ static int tosa_bat_probe(struct platform_device *dev)
 		return 0;
 	}
 
-	free_irq(gpio_to_irq(TOSA_GPIO_BAT1_CRG), &tosa_bat_jacket);
+	free_irq(gpiod_to_irq(tosa_bat_jacket.gpio_full.desc), &tosa_bat_jacket);
 err_req_jacket:
-	free_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG), &tosa_bat_main);
+	free_irq(gpiod_to_irq(tosa_bat_main.gpio_full.desc), &tosa_bat_main);
 err_req_main:
 	power_supply_unregister(tosa_bat_bu.psy);
 err_psy_reg_bu:
@@ -423,15 +450,14 @@ static int tosa_bat_probe(struct platform_device *dev)
 	/* see comment in tosa_bat_remove */
 	cancel_work_sync(&bat_work);
 
-	gpio_free_array(tosa_bat_gpios, ARRAY_SIZE(tosa_bat_gpios));
 	return ret;
 }
 
 static int tosa_bat_remove(struct platform_device *dev)
 {
-	free_irq(gpio_to_irq(TOSA_GPIO_JACKET_DETECT), &tosa_bat_jacket);
-	free_irq(gpio_to_irq(TOSA_GPIO_BAT1_CRG), &tosa_bat_jacket);
-	free_irq(gpio_to_irq(TOSA_GPIO_BAT0_CRG), &tosa_bat_main);
+	free_irq(gpiod_to_irq(gpiod_jacket_det.desc), &tosa_bat_jacket);
+	free_irq(gpiod_to_irq(tosa_bat_jacket.gpio_full.desc), &tosa_bat_jacket);
+	free_irq(gpiod_to_irq(tosa_bat_main.gpio_full.desc), &tosa_bat_main);
 
 	power_supply_unregister(tosa_bat_bu.psy);
 	power_supply_unregister(tosa_bat_jacket.psy);
@@ -443,7 +469,6 @@ static int tosa_bat_remove(struct platform_device *dev)
 	 * unregistered now.
 	 */
 	cancel_work_sync(&bat_work);
-	gpio_free_array(tosa_bat_gpios, ARRAY_SIZE(tosa_bat_gpios));
 	return 0;
 }
 
-- 
2.20.0

