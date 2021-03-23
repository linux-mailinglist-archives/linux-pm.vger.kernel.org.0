Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A53460A6
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhCWN6u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:58:50 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:45848 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhCWN6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 09:58:04 -0400
Received: by mail-lj1-f173.google.com with SMTP id z8so25669750ljm.12;
        Tue, 23 Mar 2021 06:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6WzQFitEwYWDahij8Y3EcNs37zbsvyMuY+B/0bN+oE=;
        b=RbndTCBG03s0EqaurpWjNtyY1a+8Y7uC73JL61UQ7jwur57nksjSraj757PQbkMbTp
         A7MiURlUcTRhv4qdK+B3SWmIb8c8L7X3PXRyOBE3dGbH8lokeQ+Nn/H3Rw5YUnIKVLAe
         JtPE+YvOk7GLsSyQDA5TOQlhfhL6AIM5dBbbKmWgcsWWL77cHFpNEhWl9ikYv4kPoRv/
         vondeWB70bFoosy3ZW464EH9TNA48ukLDuHXd5Vde+juMH7VOVO5lLwa3hil+rzHejhj
         NdeBRq1eVDJYujUG5jNmjuwauzeo/HCsPN7KOWxsDqkYTEFKA5JLiE1KEMdLLnkBMj0u
         /bMA==
X-Gm-Message-State: AOAM530GzXIb0oRYQ0FQ06D+5jQD17X0ks37iRr3USHnQEokWhWP5k9r
        ZsiVVWwwWTlSoySgRB2GIA4gXg64p5I=
X-Google-Smtp-Source: ABdhPJzJsiKUSfDRM+cv7lqIgmOiLcEnEMg0KYJBWC5y6RiQb0GbiuJHmwGsIHQutXxkveQg2HkYLA==
X-Received: by 2002:a2e:9d14:: with SMTP id t20mr3298200lji.76.1616507882002;
        Tue, 23 Mar 2021 06:58:02 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id f23sm1452896lfc.25.2021.03.23.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:58:01 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:57:56 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 6/8] power: supply: Clean-up few drivers by using managed
 work init
Message-ID: <e5b1b0380cdd1aa066c9ac6d7a8b1a86ba1ddbbe.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Few drivers implement remove call-back only for ensuring a delayed
work gets cancelled prior driver removal. Clean-up these by switching
to use devm_delayed_work_autocancel() instead.

This change is compile-tested only. All testing is appreciated.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changelog from RFCv2:
 - RFC dropped. No functional changes.

 drivers/power/supply/axp20x_usb_power.c      | 15 +++++----------
 drivers/power/supply/bq24735-charger.c       | 18 ++++++------------
 drivers/power/supply/ltc2941-battery-gauge.c | 20 +++++++-------------
 drivers/power/supply/sbs-battery.c           | 16 +++++-----------
 4 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 8933ae26c3d6..4259709e3491 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -646,21 +647,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		}
 	}
 
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
@@ -680,7 +676,6 @@ MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
 
 static struct platform_driver axp20x_usb_power_driver = {
 	.probe = axp20x_usb_power_probe,
-	.remove = axp20x_usb_power_remove,
 	.driver = {
 		.name		= DRVNAME,
 		.of_match_table	= axp20x_usb_power_match,
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index ab2f4bf8f603..b5d619db79f6 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -17,6 +17,7 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -473,7 +474,11 @@ static int bq24735_charger_probe(struct i2c_client *client,
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
@@ -481,16 +486,6 @@ static int bq24735_charger_probe(struct i2c_client *client,
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
@@ -509,7 +504,6 @@ static struct i2c_driver bq24735_charger_driver = {
 		.of_match_table = bq24735_match_ids,
 	},
 	.probe = bq24735_charger_probe,
-	.remove = bq24735_charger_remove,
 	.id_table = bq24735_charger_id,
 };
 
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 10cd617516ec..09f3e78af4e0 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -8,6 +8,7 @@
  * Author: Auryn Verwegen
  * Author: Mike Looijmans
  */
+#include <linux/devm-helpers.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -445,15 +446,6 @@ static enum power_supply_property ltc294x_properties[] = {
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
@@ -547,7 +539,10 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 
 	psy_cfg.drv_data = info;
 
-	INIT_DELAYED_WORK(&info->work, ltc294x_work);
+	ret = devm_delayed_work_autocancel(&client->dev, &info->work,
+					   ltc294x_work);
+	if (ret)
+		return ret;
 
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0) {
@@ -555,8 +550,8 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	info->supply = power_supply_register(&client->dev, &info->supply_desc,
-					     &psy_cfg);
+	info->supply = devm_power_supply_register(&client->dev,
+						  &info->supply_desc, &psy_cfg);
 	if (IS_ERR(info->supply)) {
 		dev_err(&client->dev, "failed to register ltc2941\n");
 		return PTR_ERR(info->supply);
@@ -655,7 +650,6 @@ static struct i2c_driver ltc294x_driver = {
 		.pm	= LTC294X_PM_OPS,
 	},
 	.probe		= ltc294x_i2c_probe,
-	.remove		= ltc294x_i2c_remove,
 	.shutdown	= ltc294x_i2c_shutdown,
 	.id_table	= ltc294x_i2c_id,
 };
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index b6a538ebb378..70ea404b2a36 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -1165,7 +1166,10 @@ static int sbs_probe(struct i2c_client *client)
 		}
 	}
 
-	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
+	rc = devm_delayed_work_autocancel(&client->dev, &chip->work,
+					  sbs_delayed_work);
+	if (rc)
+		return rc;
 
 	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc,
 						   &psy_cfg);
@@ -1185,15 +1189,6 @@ static int sbs_probe(struct i2c_client *client)
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
@@ -1248,7 +1243,6 @@ MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 
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
