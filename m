Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D842A3751
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 00:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKBXuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 18:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgKBXuv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 18:50:51 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD8C061A47
        for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2020 15:50:49 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id f9so19789092lfq.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2020 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRhVAyGxamkXMTZVwBvqaH1guNz2K3S+XuNI42B/nPk=;
        b=qaI7B3njeyPGT52AKe4jbsXQJKF5Sumuem5E62IJYk2x8Wa0oELLhwKALZHw0byg8P
         TwmsomD2d2Sv5ilz9vxnqBojV7YvLfmY9NT8CR93nrw7oKDY1SamYFVqA0FaumQHXfcQ
         rJ5FhOBc3J/s9ayUoT/4d+MbASpv1wyecxWpG23j5TzSeSSMWlR6u6ACuLQyx824dvEl
         eEZaXDltgwl3LFePSOY/tGQMcFNbrdrlfnOJB4UBo/z2s9C3o+9YvQAUv7hN+velRDUu
         XHAVIQ8ojQRZ97u9wa8A8KkX04EyMk+ptWoJSnmto7tn2t+PCi1mEp0VDX+xPjbPi9n/
         WrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pRhVAyGxamkXMTZVwBvqaH1guNz2K3S+XuNI42B/nPk=;
        b=rKdrFTy7aWzAeUjpklNQDH5pjN/Xrn++SZ7kUL7BZiqh/vXVHNd5HwNqnmy9sGZrBh
         +mUIvL298WX5m+aIg9lNVwN6QJHztMWDuNEGAugzz2hOCQfsbYGm4HQC/2GXe8p8bzcZ
         Miq+oqzZOz9xkhdPix64EqHVrV6ndjgnCtKpe3bIdE27o7rGslNy92icAWfXhg1rX38n
         RuMD37aUQhTLU5LQoiK24g6wMZ5ZQ0LHZvXiQebmy9D/wBh4kZ0oADVP9ABro9p1MQ26
         ubbsQfU8njM7+w3bqLcfqu+Z2V4iYG7IWzw0up17uBeqpuzgLCtPv0LtvZ95bkuoppJq
         nUBQ==
X-Gm-Message-State: AOAM533tWtxBKii63sOTidOEjA3r5pTSq6Bxyf1iDik4vvIFWwOIvwsv
        f/zK9eD1Su6dFXsQncHKu7atgQ==
X-Google-Smtp-Source: ABdhPJzcmnKoAu5O1rHAbuP8IUyrLFn85G4ut17ogJSuDEFLxBer1UEBE1TszBvd909Jsbq2CDMIkw==
X-Received: by 2002:ac2:5b52:: with SMTP id i18mr7017461lfp.227.1604361047733;
        Mon, 02 Nov 2020 15:50:47 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id v9sm2894410lfb.203.2020.11.02.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:50:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Sergiy Kibrik <sakib@darkstar.site>
Subject: [PATCH] power: supply: s3c-adc-battery: Convert to GPIO descriptors
Date:   Tue,  3 Nov 2020 00:48:44 +0100
Message-Id: <20201102234844.322939-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This converts the S3C ADC battery to use GPIO descriptors
instead of a global GPIO number for the charging completed
GPIO. Using the pattern from the GPIO charger we name this
GPIO line "charge-status" in the board file.

Cc: linux-samsung-soc@vger.kernel.org
Cc: Sergiy Kibrik <sakib@darkstar.site>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-s3c/mach-h1940.c         | 12 +++++-
 arch/arm/mach-s3c/mach-rx1950.c        | 11 ++++-
 drivers/power/supply/s3c_adc_battery.c | 57 +++++++++++++-------------
 include/linux/s3c_adc_battery.h        |  3 --
 4 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-s3c/mach-h1940.c b/arch/arm/mach-s3c/mach-h1940.c
index 53d51aa83200..8a43ed1c4c4d 100644
--- a/arch/arm/mach-s3c/mach-h1940.c
+++ b/arch/arm/mach-s3c/mach-h1940.c
@@ -297,6 +297,15 @@ static const struct s3c_adc_bat_thresh bat_lut_acin[] = {
 	{ .volt = 3841, .cur = 0, .level = 0},
 };
 
+static struct gpiod_lookup_table h1940_bat_gpio_table = {
+	.dev_id = "s3c-adc-battery",
+	.table = {
+		/* Charge status S3C2410_GPF(3) */
+		GPIO_LOOKUP("GPIOF", 3, "charge-status", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 static int h1940_bat_init(void)
 {
 	int ret;
@@ -330,8 +339,6 @@ static struct s3c_adc_bat_pdata h1940_bat_cfg = {
 	.exit = h1940_bat_exit,
 	.enable_charger = h1940_enable_charger,
 	.disable_charger = h1940_disable_charger,
-	.gpio_charge_finished = S3C2410_GPF(3),
-	.gpio_inverted = 1,
 	.lut_noac = bat_lut_noac,
 	.lut_noac_cnt = ARRAY_SIZE(bat_lut_noac),
 	.lut_acin = bat_lut_acin,
@@ -720,6 +727,7 @@ static void __init h1940_init(void)
 	s3c24xx_fb_set_platdata(&h1940_fb_info);
 	gpiod_add_lookup_table(&h1940_mmc_gpio_table);
 	gpiod_add_lookup_table(&h1940_audio_gpio_table);
+	gpiod_add_lookup_table(&h1940_bat_gpio_table);
 	/* Configure the I2S pins (GPE0...GPE4) in correct mode */
 	s3c_gpio_cfgall_range(S3C2410_GPE(0), 5, S3C_GPIO_SFN(2),
 			      S3C_GPIO_PULL_NONE);
diff --git a/arch/arm/mach-s3c/mach-rx1950.c b/arch/arm/mach-s3c/mach-rx1950.c
index b9758f0a9a14..6e19add158a9 100644
--- a/arch/arm/mach-s3c/mach-rx1950.c
+++ b/arch/arm/mach-s3c/mach-rx1950.c
@@ -206,6 +206,15 @@ static const struct s3c_adc_bat_thresh bat_lut_acin[] = {
 	{ .volt = 3820, .cur = 0, .level = 0},
 };
 
+static struct gpiod_lookup_table rx1950_bat_gpio_table = {
+	.dev_id = "s3c-adc-battery",
+	.table = {
+		/* Charge status S3C2410_GPF(3) */
+		GPIO_LOOKUP("GPIOF", 3, "charge-status", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static int rx1950_bat_init(void)
 {
 	int ret;
@@ -331,7 +340,6 @@ static struct s3c_adc_bat_pdata rx1950_bat_cfg = {
 	.exit = rx1950_bat_exit,
 	.enable_charger = rx1950_enable_charger,
 	.disable_charger = rx1950_disable_charger,
-	.gpio_charge_finished = S3C2410_GPF(3),
 	.lut_noac = bat_lut_noac,
 	.lut_noac_cnt = ARRAY_SIZE(bat_lut_noac),
 	.lut_acin = bat_lut_acin,
@@ -840,6 +848,7 @@ static void __init rx1950_init_machine(void)
 
 	pwm_add_table(rx1950_pwm_lookup, ARRAY_SIZE(rx1950_pwm_lookup));
 	gpiod_add_lookup_table(&rx1950_audio_gpio_table);
+	gpiod_add_lookup_table(&rx1950_bat_gpio_table);
 	/* Configure the I2S pins (GPE0...GPE4) in correct mode */
 	s3c_gpio_cfgall_range(S3C2410_GPE(0), 5, S3C_GPIO_SFN(2),
 			      S3C_GPIO_PULL_NONE);
diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
index 60b7f41ab063..a2addc24ee8b 100644
--- a/drivers/power/supply/s3c_adc_battery.c
+++ b/drivers/power/supply/s3c_adc_battery.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/leds.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
@@ -31,6 +31,7 @@ struct s3c_adc_bat {
 	struct power_supply		*psy;
 	struct s3c_adc_client		*client;
 	struct s3c_adc_bat_pdata	*pdata;
+	struct gpio_desc		*charge_finished;
 	int				volt_value;
 	int				cur_value;
 	unsigned int			timestamp;
@@ -132,9 +133,7 @@ static int calc_full_volt(int volt_val, int cur_val, int impedance)
 
 static int charge_finished(struct s3c_adc_bat *bat)
 {
-	return bat->pdata->gpio_inverted ?
-		!gpio_get_value(bat->pdata->gpio_charge_finished) :
-		gpio_get_value(bat->pdata->gpio_charge_finished);
+	return gpiod_get_value(bat->charge_finished);
 }
 
 static int s3c_adc_bat_get_property(struct power_supply *psy,
@@ -169,7 +168,7 @@ static int s3c_adc_bat_get_property(struct power_supply *psy,
 	}
 
 	if (bat->cable_plugged &&
-		((bat->pdata->gpio_charge_finished < 0) ||
+		(!bat->charge_finished ||
 		!charge_finished(bat))) {
 		lut = bat->pdata->lut_acin;
 		lut_size = bat->pdata->lut_acin_cnt;
@@ -206,7 +205,7 @@ static int s3c_adc_bat_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (bat->pdata->gpio_charge_finished < 0)
+		if (!bat->charge_finished)
 			val->intval = bat->level == 100000 ?
 				POWER_SUPPLY_STATUS_FULL : bat->status;
 		else
@@ -265,7 +264,7 @@ static void s3c_adc_bat_work(struct work_struct *work)
 			bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
 		}
 	} else {
-		if ((bat->pdata->gpio_charge_finished >= 0) && is_plugged) {
+		if (bat->charge_finished && is_plugged) {
 			is_charged = charge_finished(&main_bat);
 			if (is_charged) {
 				if (bat->pdata->disable_charger)
@@ -294,6 +293,7 @@ static int s3c_adc_bat_probe(struct platform_device *pdev)
 	struct s3c_adc_client	*client;
 	struct s3c_adc_bat_pdata *pdata = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
+	struct gpio_desc *gpiod;
 	int ret;
 
 	client = s3c_adc_register(pdev, NULL, NULL, 0);
@@ -304,8 +304,17 @@ static int s3c_adc_bat_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, client);
 
+	gpiod = devm_gpiod_get_optional(&pdev->dev, "charge-status", GPIOD_IN);
+	if (IS_ERR(gpiod)) {
+		/* Could be probe deferral etc */
+		ret = PTR_ERR(gpiod);
+		dev_err(&pdev->dev, "no GPIO %d\n", ret);
+		return ret;
+	}
+
 	main_bat.client = client;
 	main_bat.pdata = pdata;
+	main_bat.charge_finished = gpiod;
 	main_bat.volt_value = -1;
 	main_bat.cur_value = -1;
 	main_bat.cable_plugged = 0;
@@ -323,6 +332,7 @@ static int s3c_adc_bat_probe(struct platform_device *pdev)
 
 		backup_bat.client = client;
 		backup_bat.pdata = pdev->dev.platform_data;
+		backup_bat.charge_finished = gpiod;
 		backup_bat.volt_value = -1;
 		backup_bat.psy = power_supply_register(&pdev->dev,
 						       &backup_bat_desc,
@@ -335,12 +345,8 @@ static int s3c_adc_bat_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&bat_work, s3c_adc_bat_work);
 
-	if (pdata->gpio_charge_finished >= 0) {
-		ret = gpio_request(pdata->gpio_charge_finished, "charged");
-		if (ret)
-			goto err_gpio;
-
-		ret = request_irq(gpio_to_irq(pdata->gpio_charge_finished),
+	if (gpiod) {
+		ret = request_irq(gpiod_to_irq(gpiod),
 				s3c_adc_bat_charged,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 				"battery charged", NULL);
@@ -364,12 +370,9 @@ static int s3c_adc_bat_probe(struct platform_device *pdev)
 	return 0;
 
 err_platform:
-	if (pdata->gpio_charge_finished >= 0)
-		free_irq(gpio_to_irq(pdata->gpio_charge_finished), NULL);
+	if (gpiod)
+		free_irq(gpiod_to_irq(gpiod), NULL);
 err_irq:
-	if (pdata->gpio_charge_finished >= 0)
-		gpio_free(pdata->gpio_charge_finished);
-err_gpio:
 	if (pdata->backup_volt_mult)
 		power_supply_unregister(backup_bat.psy);
 err_reg_backup:
@@ -389,10 +392,8 @@ static int s3c_adc_bat_remove(struct platform_device *pdev)
 
 	s3c_adc_release(client);
 
-	if (pdata->gpio_charge_finished >= 0) {
-		free_irq(gpio_to_irq(pdata->gpio_charge_finished), NULL);
-		gpio_free(pdata->gpio_charge_finished);
-	}
+	if (main_bat.charge_finished)
+		free_irq(gpiod_to_irq(main_bat.charge_finished), NULL);
 
 	cancel_delayed_work(&bat_work);
 
@@ -408,12 +409,12 @@ static int s3c_adc_bat_suspend(struct platform_device *pdev,
 {
 	struct s3c_adc_bat_pdata *pdata = pdev->dev.platform_data;
 
-	if (pdata->gpio_charge_finished >= 0) {
+	if (main_bat.charge_finished) {
 		if (device_may_wakeup(&pdev->dev))
 			enable_irq_wake(
-				gpio_to_irq(pdata->gpio_charge_finished));
+				gpiod_to_irq(main_bat.charge_finished));
 		else {
-			disable_irq(gpio_to_irq(pdata->gpio_charge_finished));
+			disable_irq(gpiod_to_irq(main_bat.charge_finished));
 			main_bat.pdata->disable_charger();
 		}
 	}
@@ -425,12 +426,12 @@ static int s3c_adc_bat_resume(struct platform_device *pdev)
 {
 	struct s3c_adc_bat_pdata *pdata = pdev->dev.platform_data;
 
-	if (pdata->gpio_charge_finished >= 0) {
+	if (main_bat.charge_finished) {
 		if (device_may_wakeup(&pdev->dev))
 			disable_irq_wake(
-				gpio_to_irq(pdata->gpio_charge_finished));
+				gpiod_to_irq(main_bat.charge_finished));
 		else
-			enable_irq(gpio_to_irq(pdata->gpio_charge_finished));
+			enable_irq(gpiod_to_irq(main_bat.charge_finished));
 	}
 
 	/* Schedule timer to check current status */
diff --git a/include/linux/s3c_adc_battery.h b/include/linux/s3c_adc_battery.h
index 833871dcf6fd..57f982c375f8 100644
--- a/include/linux/s3c_adc_battery.h
+++ b/include/linux/s3c_adc_battery.h
@@ -14,9 +14,6 @@ struct s3c_adc_bat_pdata {
 	void (*enable_charger)(void);
 	void (*disable_charger)(void);
 
-	int gpio_charge_finished;
-	int gpio_inverted;
-
 	const struct s3c_adc_bat_thresh *lut_noac;
 	unsigned int lut_noac_cnt;
 	const struct s3c_adc_bat_thresh *lut_acin;
-- 
2.26.2

