Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AF31AB35
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 13:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhBMMNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 07:13:34 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37647 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBMMNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2021 07:13:31 -0500
Received: by mail-lf1-f41.google.com with SMTP id w36so3336521lfu.4;
        Sat, 13 Feb 2021 04:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/wcypx8WYqbd3PbUC8UFQYMrgUAZ57NXVJLZyBANM9Y=;
        b=cBVFYO0qUjH9uM413kRUKE2KEUB2Sfwp7tLeQ75r7hbsMIxVzzJa+zzgWIQQgSUmWE
         9MjnRgux1yvf1QXYsaQCm6z0TJu3Nc6fkWYFm72adRFGsV1at7SKfmWCSeRCwcELmagg
         rYqUArqqZC5czUwYKuM4Xob5RhXjj3YshtUsqglpK+gwAa8BhMUXI1X5q/xdre1aacIJ
         cCbXHZwY7j7hsDmXoMynzRFHDw4+0Os2Jyocrx6JiIQ2Ihfra6JVL+pjzAJA+VDJ9Pca
         JAq8VbEM0OD3h0S6QIn8n7B5Ze78F6QlovUYQmbRWHyA7qZHsVA1aie+IGU1+VGfQyCj
         RU9Q==
X-Gm-Message-State: AOAM532DPySWnpFNvMAPjoLVSNTkE3C4HUywsClIuY8OFZka+KAaapzd
        q0JDKLq3nUTmVn4xA60gqxM=
X-Google-Smtp-Source: ABdhPJxAaQcTXpDiEK33DXA9GI0tISkxAd6AsbAZXMQIapL+WpO5si30vhjIBMHHsT/JEuGBPMUlAg==
X-Received: by 2002:a19:d3:: with SMTP id 202mr3710842lfa.570.1613218367707;
        Sat, 13 Feb 2021 04:12:47 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id m1sm808736ljg.111.2021.02.13.04.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 04:12:47 -0800 (PST)
Date:   Sat, 13 Feb 2021 14:12:41 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Saravana Kannan <saravanak@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH 5/7] power: supply: Clean-up few drivers by using managed
 work init
Message-ID: <a3ca401194012d75725049839a1c210d313f0595.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/power/supply/axp20x_usb_power.c      | 15 ++++-----------
 drivers/power/supply/bq24735-charger.c       | 17 +++++------------
 drivers/power/supply/ltc2941-battery-gauge.c | 19 ++++++-------------
 drivers/power/supply/sbs-battery.c           | 15 ++++-----------
 4 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 70b28b699a80..149119601da3 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -645,22 +645,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		}
 	}
 
-	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
+					   axp20x_usb_power_poll_vbus);
+	if (ret)
+		return ret;
 	if (axp20x_usb_vbus_needs_polling(power))
 		queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
 
 	return 0;
 }
 
-static int axp20x_usb_power_remove(struct platform_device *pdev)
-{
-	struct axp20x_usb_power *power = platform_get_drvdata(pdev);
-
-	cancel_delayed_work_sync(&power->vbus_detect);
-
-	return 0;
-}
-
 static const struct of_device_id axp20x_usb_power_match[] = {
 	{
 		.compatible = "x-powers,axp202-usb-power-supply",
@@ -680,7 +674,6 @@ MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
 
 static struct platform_driver axp20x_usb_power_driver = {
 	.probe = axp20x_usb_power_probe,
-	.remove = axp20x_usb_power_remove,
 	.driver = {
 		.name		= DRVNAME,
 		.of_match_table	= axp20x_usb_power_match,
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index ab2f4bf8f603..eb23a5665664 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -473,7 +473,11 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		if (!charger->poll_interval)
 			return 0;
 
-		INIT_DELAYED_WORK(&charger->poll, bq24735_poll);
+		ret = devm_delayed_work_autocancel(&client->dev, &charger->poll,
+						   bq24735_poll);
+		if (ret)
+			return ret;
+
 		schedule_delayed_work(&charger->poll,
 				      msecs_to_jiffies(charger->poll_interval));
 	}
@@ -481,16 +485,6 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int bq24735_charger_remove(struct i2c_client *client)
-{
-	struct bq24735 *charger = i2c_get_clientdata(client);
-
-	if (charger->poll_interval)
-		cancel_delayed_work_sync(&charger->poll);
-
-	return 0;
-}
-
 static const struct i2c_device_id bq24735_charger_id[] = {
 	{ "bq24735-charger", 0 },
 	{}
@@ -509,7 +503,6 @@ static struct i2c_driver bq24735_charger_driver = {
 		.of_match_table = bq24735_match_ids,
 	},
 	.probe = bq24735_charger_probe,
-	.remove = bq24735_charger_remove,
 	.id_table = bq24735_charger_id,
 };
 
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 10cd617516ec..7eaa0f6115dc 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -445,15 +445,6 @@ static enum power_supply_property ltc294x_properties[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
-static int ltc294x_i2c_remove(struct i2c_client *client)
-{
-	struct ltc294x_info *info = i2c_get_clientdata(client);
-
-	cancel_delayed_work_sync(&info->work);
-	power_supply_unregister(info->supply);
-	return 0;
-}
-
 static int ltc294x_i2c_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
@@ -547,7 +538,10 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 
 	psy_cfg.drv_data = info;
 
-	INIT_DELAYED_WORK(&info->work, ltc294x_work);
+	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
+					   ltc294x_work);
+	if (ret)
+		return ret;
 
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0) {
@@ -555,8 +549,8 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	info->supply = power_supply_register(&client->dev, &info->supply_desc,
-					     &psy_cfg);
+	info->supply = devm_power_supply_register(&client->dev,
+						  &info->supply_desc, &psy_cfg);
 	if (IS_ERR(info->supply)) {
 		dev_err(&client->dev, "failed to register ltc2941\n");
 		return PTR_ERR(info->supply);
@@ -655,7 +649,6 @@ static struct i2c_driver ltc294x_driver = {
 		.pm	= LTC294X_PM_OPS,
 	},
 	.probe		= ltc294x_i2c_probe,
-	.remove		= ltc294x_i2c_remove,
 	.shutdown	= ltc294x_i2c_shutdown,
 	.id_table	= ltc294x_i2c_id,
 };
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index b6a538ebb378..83d894624454 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1165,7 +1165,10 @@ static int sbs_probe(struct i2c_client *client)
 		}
 	}
 
-	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
+	rc = devm_delayed_work_autocancel(&client->dev, &chip->work,
+					  sbs_delayed_work);
+	if (rc)
+		return rc;
 
 	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc,
 						   &psy_cfg);
@@ -1185,15 +1188,6 @@ static int sbs_probe(struct i2c_client *client)
 	return rc;
 }
 
-static int sbs_remove(struct i2c_client *client)
-{
-	struct sbs_info *chip = i2c_get_clientdata(client);
-
-	cancel_delayed_work_sync(&chip->work);
-
-	return 0;
-}
-
 #if defined CONFIG_PM_SLEEP
 
 static int sbs_suspend(struct device *dev)
@@ -1248,7 +1242,6 @@ MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 
 static struct i2c_driver sbs_battery_driver = {
 	.probe_new	= sbs_probe,
-	.remove		= sbs_remove,
 	.alert		= sbs_alert,
 	.id_table	= sbs_id,
 	.driver = {
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
