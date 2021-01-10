Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8987C2F0A7D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 00:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhAJXrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jan 2021 18:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAJXrx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jan 2021 18:47:53 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766FCC061786
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 15:47:12 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id w26so1479510ljo.4
        for <linux-pm@vger.kernel.org>; Sun, 10 Jan 2021 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mnvq8yYwsEv7XH1wKWk0SdtodY9C7QYQCMqHT4Hw87Q=;
        b=a/B6j6P4n6FJyDXO2MHRfuPnu+3OcDioOlNlLgCTzKnGyI/0gQ/iShGTHPYfttzmeg
         oD5fuoSo4AAh5KLcAYV498L47HVwWn9ZUHe1o6lUnfK0Qe0VoLWaGrctr6ic6TYqEJoL
         4BVNgwFVCS/i+jRxl+PmchYvUZLaueKbQk799/5v4qzlqUkddmN0tZFx+SBKgGPy2pgR
         vKAlxvPPka+iEJqJHA6x2j0Rk/I6UieCoDbzB1h9mQDcFo2nNGZR1YCU7ckXyxfbreIS
         qcmi/BxWAkGkyhXp3H5Hj1OCx1hHEjl41uupu/JfVQ9WsqH5/61Kn1p4di/AkQET19sX
         OeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mnvq8yYwsEv7XH1wKWk0SdtodY9C7QYQCMqHT4Hw87Q=;
        b=ZPQPqeMl4M9VoSwU5MnbAaknsV2foFiUS1XIn7AaT9z7KrKCMb7kdbeJ+qeDWjIgJc
         qJxCoBFngyWVStEex9nCFnEFNF/d6o2Tb9vjEnGJXEvhttEwrftj1StenHRRcKX/ABVt
         3fp6tRYwc+TrmIozCyITbymShPtAMvxGtc4sWTEsJVVGGh6G/89/7MiXC5xjqnhDHztf
         YI9xSQakcHJBbXUDg2t+fGFly+lpjzDYXaPD6omd4TkVqI355iBqw8C5BeOpczAFd1VG
         QxJcsDd8I/GhIyO19+3SQMkdFHtUMCnE7PJMFCokXaT3zabQ4uKRq6bHWnlJ232bY//a
         s2RQ==
X-Gm-Message-State: AOAM5333mZqPFsHSVxT/8SycuTH56hOSYc0U2zSqStBNpU+0nfQE7bOf
        Awdl9eAS4T+ycbLVbu5KY+AOsGZMptBy0w==
X-Google-Smtp-Source: ABdhPJz5bBSaxyuSWQAbKJXUpGK8piwhR1ounxThbN4psWrE0w53xk8+op/FfikENPysv9Rt5wk42Q==
X-Received: by 2002:a2e:850b:: with SMTP id j11mr6423967lji.84.1610322430799;
        Sun, 10 Jan 2021 15:47:10 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id t14sm2887992lfl.216.2021.01.10.15.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 15:47:10 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] power: supply: wm97xx_battery: Convert to GPIO descriptor
Date:   Mon, 11 Jan 2021 00:45:08 +0100
Message-Id: <20210110234508.218768-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This converts the WM97xx driver to use a GPIO descriptor
instead of passing a GPIO number thru platform data.

Like everything else in the driver, use a simple local
variable for the descriptor, it can only ever appear in
one instance anyway so it should not hurt.

After converting the driver I noticed that none of the
boardfiles actually define a meaningful GPIO line for
this, but hey, it is converted.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-pxa/mioa701.c           |  1 -
 arch/arm/mach-pxa/palm27x.c           |  1 -
 arch/arm/mach-pxa/palmte2.c           |  1 -
 drivers/power/supply/wm97xx_battery.c | 45 +++++++++++----------------
 include/linux/wm97xx.h                |  1 -
 5 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index d3af80317f2d..a79f296e81e0 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -577,7 +577,6 @@ static struct platform_device power_dev = {
 static struct wm97xx_batt_pdata mioa701_battery_data = {
 	.batt_aux	= WM97XX_AUX_ID1,
 	.temp_aux	= -1,
-	.charge_gpio	= -1,
 	.min_voltage	= 0xc00,
 	.max_voltage	= 0xfc0,
 	.batt_tech	= POWER_SUPPLY_TECHNOLOGY_LION,
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 0d246a1aebbc..6230381a7ca0 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -212,7 +212,6 @@ void __init palm27x_irda_init(int pwdn)
 static struct wm97xx_batt_pdata palm27x_batt_pdata = {
 	.batt_aux	= WM97XX_AUX_ID3,
 	.temp_aux	= WM97XX_AUX_ID2,
-	.charge_gpio	= -1,
 	.batt_mult	= 1000,
 	.batt_div	= 414,
 	.temp_mult	= 1,
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index e3bcf58b4e63..a2b10db4aacc 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -273,7 +273,6 @@ static struct platform_device power_supply = {
 static struct wm97xx_batt_pdata palmte2_batt_pdata = {
 	.batt_aux	= WM97XX_AUX_ID3,
 	.temp_aux	= WM97XX_AUX_ID2,
-	.charge_gpio	= -1,
 	.max_voltage	= PALMTE2_BAT_MAX_VOLTAGE,
 	.min_voltage	= PALMTE2_BAT_MIN_VOLTAGE,
 	.batt_mult	= 1000,
diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index 58f01659daa5..a0e1eaa25d93 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -15,11 +15,12 @@
 #include <linux/wm97xx.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
 
 static struct work_struct bat_work;
+static struct gpio_desc *charge_gpiod;
 static DEFINE_MUTEX(work_lock);
 static int bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
 static enum power_supply_property *prop;
@@ -96,12 +97,11 @@ static void wm97xx_bat_external_power_changed(struct power_supply *bat_ps)
 static void wm97xx_bat_update(struct power_supply *bat_ps)
 {
 	int old_status = bat_status;
-	struct wm97xx_batt_pdata *pdata = power_supply_get_drvdata(bat_ps);
 
 	mutex_lock(&work_lock);
 
-	bat_status = (pdata->charge_gpio >= 0) ?
-			(gpio_get_value(pdata->charge_gpio) ?
+	bat_status = (charge_gpiod) ?
+			(gpiod_get_value(charge_gpiod) ?
 			POWER_SUPPLY_STATUS_DISCHARGING :
 			POWER_SUPPLY_STATUS_CHARGING) :
 			POWER_SUPPLY_STATUS_UNKNOWN;
@@ -171,18 +171,19 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	if (dev->id != -1)
 		return -EINVAL;
 
-	if (gpio_is_valid(pdata->charge_gpio)) {
-		ret = gpio_request(pdata->charge_gpio, "BATT CHRG");
-		if (ret)
-			goto err;
-		ret = gpio_direction_input(pdata->charge_gpio);
-		if (ret)
-			goto err2;
-		ret = request_irq(gpio_to_irq(pdata->charge_gpio),
+	charge_gpiod = devm_gpiod_get_optional(&dev->dev, NULL, GPIOD_IN);
+	if (IS_ERR(charge_gpiod))
+		return dev_err_probe(&dev->dev,
+				     PTR_ERR(charge_gpiod),
+				     "failed to get charge GPIO\n");
+	if (charge_gpiod) {
+		gpiod_set_consumer_name(charge_gpiod, "BATT CHRG");
+		ret = request_irq(gpiod_to_irq(charge_gpiod),
 				wm97xx_chrg_irq, 0,
 				"AC Detect", dev);
 		if (ret)
-			goto err2;
+			return dev_err_probe(&dev->dev, ret,
+					     "failed to request GPIO irq\n");
 		props++;	/* POWER_SUPPLY_PROP_STATUS */
 	}
 
@@ -204,7 +205,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	}
 
 	prop[i++] = POWER_SUPPLY_PROP_PRESENT;
-	if (pdata->charge_gpio >= 0)
+	if (charge_gpiod)
 		prop[i++] = POWER_SUPPLY_PROP_STATUS;
 	if (pdata->batt_tech >= 0)
 		prop[i++] = POWER_SUPPLY_PROP_TECHNOLOGY;
@@ -242,23 +243,15 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 err4:
 	kfree(prop);
 err3:
-	if (gpio_is_valid(pdata->charge_gpio))
-		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
-err2:
-	if (gpio_is_valid(pdata->charge_gpio))
-		gpio_free(pdata->charge_gpio);
-err:
+	if (charge_gpiod)
+		free_irq(gpiod_to_irq(charge_gpiod), dev);
 	return ret;
 }
 
 static int wm97xx_bat_remove(struct platform_device *dev)
 {
-	struct wm97xx_batt_pdata *pdata = dev->dev.platform_data;
-
-	if (pdata && gpio_is_valid(pdata->charge_gpio)) {
-		free_irq(gpio_to_irq(pdata->charge_gpio), dev);
-		gpio_free(pdata->charge_gpio);
-	}
+	if (charge_gpiod)
+		free_irq(gpiod_to_irq(charge_gpiod), dev);
 	cancel_work_sync(&bat_work);
 	power_supply_unregister(bat_psy);
 	kfree(prop);
diff --git a/include/linux/wm97xx.h b/include/linux/wm97xx.h
index 58e082dadc68..462854f4f286 100644
--- a/include/linux/wm97xx.h
+++ b/include/linux/wm97xx.h
@@ -294,7 +294,6 @@ struct wm97xx {
 struct wm97xx_batt_pdata {
 	int	batt_aux;
 	int	temp_aux;
-	int	charge_gpio;
 	int	min_voltage;
 	int	max_voltage;
 	int	batt_div;
-- 
2.29.2

