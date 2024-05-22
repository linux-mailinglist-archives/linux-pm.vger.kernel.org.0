Return-Path: <linux-pm+bounces-8053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E68CC51A
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067A7B21E6D
	for <lists+linux-pm@lfdr.de>; Wed, 22 May 2024 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F51420D4;
	Wed, 22 May 2024 16:48:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916C142E64
	for <linux-pm@vger.kernel.org>; Wed, 22 May 2024 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396527; cv=none; b=nDV3T9pVMDFgxf7Q3ouPxE4M+VAaniEyLXv42H/je+HQwRWrS7zBipMjJ21nTHBqLTs0AheynwTnamtPyTu1kbyjJ/y6oGbYpSocdFtwTc9BMS8lWosLlixsZdut5ZptcPV1QXL0vW72eP9hq7bHQHBd8g6IS4UTK+7IEz9SOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396527; c=relaxed/simple;
	bh=z2/WUVcTPQgXX81Jz0hQVzHHWnU93D0MFcTcCZsSK1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQ9G3+A3FIma+7O28t1hXaPSR32qOCD2z33fzHqiYHBsjzoqanPB7Pm/57BmLQy4ucg3sG/LCJBp5TnkwZ7d4qLigquvxekH7MEjMJzwzcJcSC9DsJZwJEXZj3/rQUEQHW3FCpetMW7GhOld0ssjkPZg/7j0/HBwqqfJwa8MQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9p8s-0005g7-Cc; Wed, 22 May 2024 18:48:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9p8r-002YBo-RM; Wed, 22 May 2024 18:48:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9p8r-00A9p8-2U;
	Wed, 22 May 2024 18:48:41 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] power: supply: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed, 22 May 2024 18:48:31 +0200
Message-ID: <20240522164830.61646-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7066; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=z2/WUVcTPQgXX81Jz0hQVzHHWnU93D0MFcTcCZsSK1A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmTiHeOo93OBKH8OtRZZeM6aa5p0JBHz7mwMos2 D1eXjtVpZaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZk4h3gAKCRCPgPtYfRL+ TkBLCAClaBlZ8J1c8ayeqLsS64kot4EXInkT4qUIXRBjw4VaMfoitjG+Xj2bHolRfDPFdAFn+hB 6NajB/kacaoHoYd1iY4WmczNuURswaasU36vZpvEYD7XexwDTI7c6gc+2aiuyhQ3x500RH0r971 Cx//hxhp5lUMaHq9OXFbL6pqb9iF5+ktjJ0C/rFcHvuhP+Y2KFh2DDG9F6PH+xilQ0X2W6ZDK+K Ah1435B7HYEHMDhRKhvP8TYEplHMR9p6s9W4yZJSYbmyF2qfh0Fl38DC+FTktsuQ2JfkZ5duqwz T6HmHAyuYT49fZYquVjpRlQoejx1u55kzPyZ+jsVE6xzWgg7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

While add it, also remove commas after the sentinel entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/supply/adp5061.c                   |  2 +-
 drivers/power/supply/bq24735-charger.c           |  2 +-
 drivers/power/supply/bq25890_charger.c           | 10 +++++-----
 drivers/power/supply/cw2015_battery.c            |  2 +-
 drivers/power/supply/lp8727_charger.c            |  2 +-
 drivers/power/supply/ltc4162-l-charger.c         |  4 ++--
 drivers/power/supply/max14656_charger_detector.c |  2 +-
 drivers/power/supply/max77976_charger.c          |  4 ++--
 drivers/power/supply/mm8013.c                    |  2 +-
 drivers/power/supply/rt9455_charger.c            |  4 ++--
 drivers/power/supply/sbs-charger.c               |  2 +-
 drivers/power/supply/sbs-manager.c               |  4 ++--
 12 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index 3e3a0d118ce5..dac9875d993c 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -727,7 +727,7 @@ static int adp5061_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adp5061_id[] = {
-	{ "adp5061", 0},
+	{ "adp5061" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp5061_id);
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 8efceeae864c..73a7fc867b03 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -489,7 +489,7 @@ static int bq24735_charger_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq24735_charger_id[] = {
-	{ "bq24735-charger", 0 },
+	{ "bq24735-charger" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, bq24735_charger_id);
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 03fa11a1c9b6..2f5ceaf00b94 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1617,11 +1617,11 @@ static const struct dev_pm_ops bq25890_pm = {
 };
 
 static const struct i2c_device_id bq25890_i2c_ids[] = {
-	{ "bq25890", 0 },
-	{ "bq25892", 0 },
-	{ "bq25895", 0 },
-	{ "bq25896", 0 },
-	{},
+	{ "bq25890" },
+	{ "bq25892" },
+	{ "bq25895" },
+	{ "bq25896" },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, bq25890_i2c_ids);
 
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 99f3ccdc30a6..f63c3c410451 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -731,7 +731,7 @@ static int __maybe_unused cw_bat_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cw_bat_pm_ops, cw_bat_suspend, cw_bat_resume);
 
 static const struct i2c_device_id cw_bat_id_table[] = {
-	{ "cw2015", 0 },
+	{ "cw2015" },
 	{ }
 };
 
diff --git a/drivers/power/supply/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
index 34548a4da90b..4186fcd37512 100644
--- a/drivers/power/supply/lp8727_charger.c
+++ b/drivers/power/supply/lp8727_charger.c
@@ -584,7 +584,7 @@ static const struct of_device_id lp8727_dt_ids[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, lp8727_dt_ids);
 
 static const struct i2c_device_id lp8727_ids[] = {
-	{"lp8727", 0},
+	{ "lp8727" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp8727_ids);
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index f0eace731480..2e4bc74e1c4a 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -903,8 +903,8 @@ static void ltc4162l_alert(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ltc4162l_i2c_id_table[] = {
-	{ "ltc4162-l", 0 },
-	{ },
+	{ "ltc4162-l" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc4162l_i2c_id_table);
 
diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index 89f2af72dfcd..a5b42b42d134 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -300,7 +300,7 @@ static int max14656_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max14656_id[] = {
-	{ "max14656", 0 },
+	{ "max14656" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, max14656_id);
diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index 99659dc8f5a6..d7e520da7688 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -483,8 +483,8 @@ static int max77976_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max77976_i2c_id[] = {
-	{ MAX77976_DRIVER_NAME, 0 },
-	{ },
+	{ MAX77976_DRIVER_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max77976_i2c_id);
 
diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index 20c1651ca38e..5bcfaeeda3db 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -284,7 +284,7 @@ static int mm8013_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mm8013_id_table[] = {
-	{ "mm8013", 0 },
+	{ "mm8013" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mm8013_id_table);
diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index e4dbacd50a43..64a23e3d7bb0 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1718,8 +1718,8 @@ static void rt9455_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id rt9455_i2c_id_table[] = {
-	{ RT9455_DRIVER_NAME, 0 },
-	{ },
+	{ RT9455_DRIVER_NAME },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
 
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index f4adde449270..ab3f095d90ea 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -234,7 +234,7 @@ MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 #endif
 
 static const struct i2c_device_id sbs_id[] = {
-	{ "sbs-charger", 0 },
+	{ "sbs-charger" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sbs_id);
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index 933b04806d10..7d2f39f19acb 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -389,8 +389,8 @@ static int sbsm_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sbsm_ids[] = {
-	{ "sbs-manager", 0 },
-	{ "ltc1760",     0 },
+	{ "sbs-manager" },
+	{ "ltc1760" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sbsm_ids);

base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
-- 
2.43.0


