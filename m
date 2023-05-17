Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590DF706ED6
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjEQQz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQQzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 12:55:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AD30FE
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 09:55:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzKQp-000563-MQ; Wed, 17 May 2023 18:55:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzKQo-000tK3-TY; Wed, 17 May 2023 18:55:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pzKQo-005PpU-2s; Wed, 17 May 2023 18:55:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] power: supply: Switch i2c drivers back to use .probe()
Date:   Wed, 17 May 2023 18:55:14 +0200
Message-Id: <20230517165514.163216-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=18556; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=egc4K4jpLdhfo9cbKkDBH/K7j4w/VI6boCwJHEt44h0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkZQbxhhu3vu1qdbAcDyZJC5S1mHn9MHGx3lrga bWyc0mktQmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZGUG8QAKCRCPgPtYfRL+ ThfBB/4xcnCv4KbWKbpy0XxuvB4xb83wrshh8SwmgWKOFvX9O1Tp5EsEZp2oJ14LhUtKbADdnnu CaKr0DVJLpDhHMVLiNGvavarPNiVMUWI6yCtFQTp5GLYV+fj2vR3EP5kaavedi930146MCQcOp2 uRA7ja84PmaNy842/bSOjIbHECsEvz0P16039lMEuAj6MTNDSR2ps/eCmasZBHuYksAQOM6KhLO ECszBQBYasoJAcghI5vbzBuSOV7G19CrCfvVRDwnbqWoXfYg6272FCNVarAHUjG2wZpsvoR7y8T d7OpOd2VH/9TSKIAq1nl+jZuivDqRPsD4pYSqHlT1GhguW3g
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
back to (the new) .probe() to be able to eventually drop .probe_new() from
struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I used v6.4-rc1 as base for this patch, but it also fits on top of
today's next master. If there are some conflicts when you apply it, feel
free to just drop all conflicting hunks, I'll care about the fallout
later.

I chose to do this in a single patch for all drivers below
drivers/power/supply. If you want me to split it, just tell me.

Also note I didn't Cc: all the individual maintainers to not exceed the
allowed length of To: and Cc:. If this patch will be split I can extend
the audience accordingly.

Best regards
Uwe

 drivers/power/supply/adp5061.c                   | 2 +-
 drivers/power/supply/bd99954-charger.c           | 2 +-
 drivers/power/supply/bq2415x_charger.c           | 2 +-
 drivers/power/supply/bq24190_charger.c           | 2 +-
 drivers/power/supply/bq24257_charger.c           | 2 +-
 drivers/power/supply/bq24735-charger.c           | 2 +-
 drivers/power/supply/bq2515x_charger.c           | 2 +-
 drivers/power/supply/bq256xx_charger.c           | 2 +-
 drivers/power/supply/bq25890_charger.c           | 2 +-
 drivers/power/supply/bq25980_charger.c           | 2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c       | 2 +-
 drivers/power/supply/cw2015_battery.c            | 2 +-
 drivers/power/supply/ds2782_battery.c            | 2 +-
 drivers/power/supply/ip5xxx_power.c              | 2 +-
 drivers/power/supply/lp8727_charger.c            | 2 +-
 drivers/power/supply/ltc2941-battery-gauge.c     | 2 +-
 drivers/power/supply/ltc4162-l-charger.c         | 2 +-
 drivers/power/supply/max14656_charger_detector.c | 2 +-
 drivers/power/supply/max17040_battery.c          | 2 +-
 drivers/power/supply/max17042_battery.c          | 2 +-
 drivers/power/supply/max77976_charger.c          | 2 +-
 drivers/power/supply/rt5033_battery.c            | 2 +-
 drivers/power/supply/rt9455_charger.c            | 2 +-
 drivers/power/supply/rt9467-charger.c            | 2 +-
 drivers/power/supply/rt9471.c                    | 2 +-
 drivers/power/supply/sbs-battery.c               | 2 +-
 drivers/power/supply/sbs-charger.c               | 2 +-
 drivers/power/supply/sbs-manager.c               | 2 +-
 drivers/power/supply/smb347-charger.c            | 2 +-
 drivers/power/supply/ucs1002_power.c             | 2 +-
 drivers/power/supply/ug3105_battery.c            | 2 +-
 31 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index 840db629a46c..3e3a0d118ce5 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -736,7 +736,7 @@ static struct i2c_driver adp5061_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
-	.probe_new = adp5061_probe,
+	.probe = adp5061_probe,
 	.id_table = adp5061_id,
 };
 module_i2c_driver(adp5061_driver);
diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
index 250362e15c98..086dcf4033c1 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -1077,7 +1077,7 @@ static struct i2c_driver bd9995x_driver = {
 		.name = "bd9995x-charger",
 		.of_match_table = bd9995x_of_match,
 	},
-	.probe_new = bd9995x_probe,
+	.probe = bd9995x_probe,
 };
 module_i2c_driver(bd9995x_driver);
 
diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 349b69d634e6..6a4798a62588 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1780,7 +1780,7 @@ static struct i2c_driver bq2415x_driver = {
 		.of_match_table = of_match_ptr(bq2415x_of_match_table),
 		.acpi_match_table = ACPI_PTR(bq2415x_i2c_acpi_match),
 	},
-	.probe_new = bq2415x_probe,
+	.probe = bq2415x_probe,
 	.remove = bq2415x_remove,
 	.id_table = bq2415x_i2c_id_table,
 };
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index de67b985f0a9..baa4c9395bc8 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -2033,7 +2033,7 @@ static const struct of_device_id bq24190_of_match[] = {
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
 
 static struct i2c_driver bq24190_driver = {
-	.probe_new	= bq24190_probe,
+	.probe		= bq24190_probe,
 	.remove		= bq24190_remove,
 	.shutdown	= bq24190_shutdown,
 	.id_table	= bq24190_i2c_ids,
diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 45e4ba30da98..2852860abf86 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -1165,7 +1165,7 @@ static struct i2c_driver bq24257_driver = {
 		.acpi_match_table = ACPI_PTR(bq24257_acpi_match),
 		.pm = &bq24257_pm,
 	},
-	.probe_new = bq24257_probe,
+	.probe = bq24257_probe,
 	.remove = bq24257_remove,
 	.id_table = bq24257_i2c_ids,
 };
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index cfca3a82d5a8..8efceeae864c 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -505,7 +505,7 @@ static struct i2c_driver bq24735_charger_driver = {
 		.name = "bq24735-charger",
 		.of_match_table = bq24735_match_ids,
 	},
-	.probe_new = bq24735_charger_probe,
+	.probe = bq24735_charger_probe,
 	.id_table = bq24735_charger_id,
 };
 
diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index da224ae8dc61..1dbacc9b015d 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -1158,7 +1158,7 @@ static struct i2c_driver bq2515x_driver = {
 		.name = "bq2515x-charger",
 		.of_match_table = bq2515x_of_match,
 	},
-	.probe_new = bq2515x_probe,
+	.probe = bq2515x_probe,
 	.id_table = bq2515x_i2c_ids,
 };
 module_i2c_driver(bq2515x_driver);
diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index e624834ae66c..1a18aba8d4b3 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1784,7 +1784,7 @@ static struct i2c_driver bq256xx_driver = {
 		.of_match_table = bq256xx_of_match,
 		.acpi_match_table = bq256xx_acpi_match,
 	},
-	.probe_new = bq256xx_probe,
+	.probe = bq256xx_probe,
 	.id_table = bq256xx_i2c_ids,
 };
 module_i2c_driver(bq256xx_driver);
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 22cde35eb144..b82e702adced 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1646,7 +1646,7 @@ static struct i2c_driver bq25890_driver = {
 		.acpi_match_table = ACPI_PTR(bq25890_acpi_match),
 		.pm = &bq25890_pm,
 	},
-	.probe_new = bq25890_probe,
+	.probe = bq25890_probe,
 	.remove = bq25890_remove,
 	.shutdown = bq25890_shutdown,
 	.id_table = bq25890_i2c_ids,
diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index a59d9762bc91..d8411722266f 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1287,7 +1287,7 @@ static struct i2c_driver bq25980_driver = {
 		.name = "bq25980-charger",
 		.of_match_table = bq25980_of_match,
 	},
-	.probe_new = bq25980_probe,
+	.probe = bq25980_probe,
 	.id_table = bq25980_i2c_ids,
 };
 module_i2c_driver(bq25980_driver);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index f8768997333b..08643154f2f5 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -295,7 +295,7 @@ static struct i2c_driver bq27xxx_battery_i2c_driver = {
 		.name = "bq27xxx-battery",
 		.of_match_table = of_match_ptr(bq27xxx_battery_i2c_of_match_table),
 	},
-	.probe_new = bq27xxx_battery_i2c_probe,
+	.probe = bq27xxx_battery_i2c_probe,
 	.remove = bq27xxx_battery_i2c_remove,
 	.id_table = bq27xxx_i2c_id_table,
 };
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 473522b4326a..bb29e9ebd24a 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -747,7 +747,7 @@ static struct i2c_driver cw_bat_driver = {
 		.of_match_table = cw2015_of_match,
 		.pm = &cw_bat_pm_ops,
 	},
-	.probe_new = cw_bat_probe,
+	.probe = cw_bat_probe,
 	.id_table = cw_bat_id_table,
 };
 
diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index 9b9619246902..85aa9c465aa4 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -458,7 +458,7 @@ static struct i2c_driver ds278x_battery_driver = {
 		.name	= "ds2782-battery",
 		.pm	= &ds278x_battery_pm_ops,
 	},
-	.probe_new	= ds278x_battery_probe,
+	.probe		= ds278x_battery_probe,
 	.remove		= ds278x_battery_remove,
 	.id_table	= ds278x_id,
 };
diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 00221e9c0bfc..82263646ddc6 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -625,7 +625,7 @@ static const struct of_device_id ip5xxx_power_of_match[] = {
 MODULE_DEVICE_TABLE(of, ip5xxx_power_of_match);
 
 static struct i2c_driver ip5xxx_power_driver = {
-	.probe_new	= ip5xxx_power_probe,
+	.probe		= ip5xxx_power_probe,
 	.driver		= {
 		.name		= "ip5xxx-power",
 		.of_match_table	= ip5xxx_power_of_match,
diff --git a/drivers/power/supply/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
index dc42d354b892..0875391f7ac6 100644
--- a/drivers/power/supply/lp8727_charger.c
+++ b/drivers/power/supply/lp8727_charger.c
@@ -615,7 +615,7 @@ static struct i2c_driver lp8727_driver = {
 		   .name = "lp8727",
 		   .of_match_table = of_match_ptr(lp8727_dt_ids),
 		   },
-	.probe_new = lp8727_probe,
+	.probe = lp8727_probe,
 	.remove = lp8727_remove,
 	.id_table = lp8727_ids,
 };
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index d3fb42825983..cad39a8f829d 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -635,7 +635,7 @@ static struct i2c_driver ltc294x_driver = {
 		.of_match_table = ltc294x_i2c_of_match,
 		.pm	= LTC294X_PM_OPS,
 	},
-	.probe_new	= ltc294x_i2c_probe,
+	.probe		= ltc294x_i2c_probe,
 	.shutdown	= ltc294x_i2c_shutdown,
 	.id_table	= ltc294x_i2c_id,
 };
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 285580845e2f..ec5b4a20ad43 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -915,7 +915,7 @@ static const struct of_device_id ltc4162l_of_match[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, ltc4162l_of_match);
 
 static struct i2c_driver ltc4162l_driver = {
-	.probe_new	= ltc4162l_probe,
+	.probe		= ltc4162l_probe,
 	.alert		= ltc4162l_alert,
 	.id_table	= ltc4162l_i2c_id_table,
 	.driver = {
diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 0d0180fcfa63..fbdf12cf64eb 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -316,7 +316,7 @@ static struct i2c_driver max14656_i2c_driver = {
 		.name	= "max14656",
 		.of_match_table = max14656_match_table,
 	},
-	.probe_new	= max14656_probe,
+	.probe		= max14656_probe,
 	.id_table	= max14656_id,
 };
 module_i2c_driver(max14656_i2c_driver);
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d1075959dd46..22ea7de47a53 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -599,7 +599,7 @@ static struct i2c_driver max17040_i2c_driver = {
 		.of_match_table = max17040_of_match,
 		.pm	= MAX17040_PM_OPS,
 	},
-	.probe_new	= max17040_probe,
+	.probe		= max17040_probe,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 89cabe8ed3b0..daacf73a874a 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1220,7 +1220,7 @@ static struct i2c_driver max17042_i2c_driver = {
 		.of_match_table = of_match_ptr(max17042_dt_match),
 		.pm	= &max17042_pm_ops,
 	},
-	.probe_new	= max17042_probe,
+	.probe		= max17042_probe,
 	.id_table	= max17042_id,
 };
 module_i2c_driver(max17042_i2c_driver);
diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index 4fed74511931..99659dc8f5a6 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -499,7 +499,7 @@ static struct i2c_driver max77976_driver = {
 		.name		= MAX77976_DRIVER_NAME,
 		.of_match_table	= max77976_of_id,
 	},
-	.probe_new	= max77976_probe,
+	.probe		= max77976_probe,
 	.id_table	= max77976_i2c_id,
 };
 module_i2c_driver(max77976_driver);
diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 5c04cf305219..465c1a9c6a89 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -172,7 +172,7 @@ static struct i2c_driver rt5033_battery_driver = {
 		.name = "rt5033-battery",
 		.of_match_table = rt5033_battery_of_match,
 	},
-	.probe_new = rt5033_battery_probe,
+	.probe = rt5033_battery_probe,
 	.remove = rt5033_battery_remove,
 	.id_table = rt5033_battery_id,
 };
diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 0149e00f2bf8..ff4dcf77c788 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1737,7 +1737,7 @@ MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
 #endif
 
 static struct i2c_driver rt9455_driver = {
-	.probe_new	= rt9455_probe,
+	.probe		= rt9455_probe,
 	.remove		= rt9455_remove,
 	.id_table	= rt9455_i2c_id_table,
 	.driver = {
diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index 73f744a3155d..9ef759a9eb2e 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -1272,7 +1272,7 @@ static struct i2c_driver rt9467_charger_driver = {
 		.name = "rt9467-charger",
 		.of_match_table = rt9467_charger_of_match_table,
 	},
-	.probe_new = rt9467_charger_probe,
+	.probe = rt9467_charger_probe,
 };
 module_i2c_driver(rt9467_charger_driver);
 
diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index 1ea40876494b..868b0703d15c 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -919,7 +919,7 @@ static struct i2c_driver rt9471_driver = {
 		.name = "rt9471",
 		.of_match_table = rt9471_of_device_id,
 	},
-	.probe_new = rt9471_probe,
+	.probe = rt9471_probe,
 	.shutdown = rt9471_shutdown,
 };
 module_i2c_driver(rt9471_driver);
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index c4a95b01463a..62a354e01204 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1275,7 +1275,7 @@ static const struct of_device_id sbs_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 
 static struct i2c_driver sbs_battery_driver = {
-	.probe_new	= sbs_probe,
+	.probe		= sbs_probe,
 	.alert		= sbs_alert,
 	.id_table	= sbs_id,
 	.driver = {
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 75ebcbf0a788..3fd7145acb0d 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -240,7 +240,7 @@ static const struct i2c_device_id sbs_id[] = {
 MODULE_DEVICE_TABLE(i2c, sbs_id);
 
 static struct i2c_driver sbs_driver = {
-	.probe_new	= sbs_probe,
+	.probe		= sbs_probe,
 	.id_table	= sbs_id,
 	.driver = {
 		.name	= "sbs-charger",
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index bde977391fd4..9e4141cffbf9 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -409,7 +409,7 @@ static struct i2c_driver sbsm_driver = {
 		.name = "sbsm",
 		.of_match_table = of_match_ptr(sbsm_dt_ids),
 	},
-	.probe_new	= sbsm_probe,
+	.probe		= sbsm_probe,
 	.alert		= sbsm_alert,
 	.id_table	= sbsm_ids
 };
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index b5f038310282..c8392933ee28 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1629,7 +1629,7 @@ static struct i2c_driver smb347_driver = {
 		.name = "smb347",
 		.of_match_table = smb3xx_of_match,
 	},
-	.probe_new = smb347_probe,
+	.probe = smb347_probe,
 	.remove = smb347_remove,
 	.shutdown = smb347_shutdown,
 	.id_table = smb347_id,
diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 836d44c9fb74..954feba6600b 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -680,7 +680,7 @@ static struct i2c_driver ucs1002_driver = {
 		   .name = "ucs1002",
 		   .of_match_table = ucs1002_of_match,
 	},
-	.probe_new = ucs1002_probe,
+	.probe = ucs1002_probe,
 };
 module_i2c_driver(ucs1002_driver);
 
diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index fbc966842509..ccc5c4d2e230 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -476,7 +476,7 @@ static struct i2c_driver ug3105_i2c_driver = {
 		.name = "ug3105",
 		.pm = &ug3105_pm_ops,
 	},
-	.probe_new = ug3105_probe,
+	.probe = ug3105_probe,
 	.id_table = ug3105_id,
 };
 module_i2c_driver(ug3105_i2c_driver);

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

