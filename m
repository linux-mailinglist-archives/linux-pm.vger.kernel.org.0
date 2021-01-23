Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0E3018AB
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbhAWWUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWWUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:01 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6A3C061788
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:21 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 3so10797287ljc.4
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+S3c+wvfRymwP+4pXmUkEQAcVBLlJgeBZ+xbX9vFio=;
        b=r9LFMr/vNV7GKwBKDulhTms1FUaKBqlb9YQAjrj1l1AuH4M/48DNkwNZYypvbcHpof
         iJiGBuPxRrgVWlm43gzNQ/AvPQZmK7exRhEvEa3lHyuAvoVAFmuSdavB/9ViEZDELk4a
         p+K4qbM5KJttpsflA5GWRD3MPBW1xzw5DRLLw72d2HlHuktGhz3Pvnh8xPfbsdPwT5VN
         oo4K7yL41p7UXNV7NZspv3mdfGYVFMRI3dPLJ+8UScla4jzu+tvS9wzhydVBzd4cSccm
         81ziF09qvT0+Gb1yIq4ujJM3j6+bfb8zjwAp7zPU6tKguqpLMbWjEO1kFdAxVE7xUfRp
         0Q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+S3c+wvfRymwP+4pXmUkEQAcVBLlJgeBZ+xbX9vFio=;
        b=tq50a8HCHBdZ7wLSh+rjIRRkJt2wWMqQ198Cia7l7z2eDHBRLEZXqUBEYlm3ADQvaL
         Ml9MpUTB2Riu5vcsQjB569J0To9gaEpG8FnxXQ+SrMy2f8JdRLfJhjGI6JoRKHRUcO5R
         4chZESmIws/C0fEIdxz4pKmZm9iqyzwORPjQeDIs2o65BKq8ZD8qX3IX86M0TbpJevef
         3iQLpTzmemoXRDtab/CsMSTDakx0VKERnt9adfUeIBIfmbGBLo0VdRlJXIQB837IzzYn
         foSTaztRIsFulOGgoOM8vZrL2MbYb68fdiKghWsTNSV8HNGMI+k5X583mK7u7uIZdrjR
         tHVg==
X-Gm-Message-State: AOAM531PFIYy5TKUCBV4YezvImH4tKBPBFfJW4YRMSSMGnIiFaHrkeeh
        poYJeF5gul5DtTTihQD8c7U5NQ==
X-Google-Smtp-Source: ABdhPJxNJJhBpk8iI35bN+dJSqF2iym6/WM+KNMmvzSNbysK90q/5QoCbvhdc9+la44dq3C+8EaQSg==
X-Received: by 2002:a2e:860f:: with SMTP id a15mr686824lji.411.1611440359553;
        Sat, 23 Jan 2021 14:19:19 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:19 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 02/10] power: supply: ab8500: Push data to power supply code
Date:   Sat, 23 Jan 2021 23:19:00 +0100
Message-Id: <20210123221908.2993388-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The global definition of platform data for the battery
management code has no utility after the OF conversion,
move the <linux/mfd/abx500/ab8500-bm.h> to be a local
file in drivers/power/supply and stop defining the
platform data in drivers/power/supply/ab8500_bmdata.c
and broadcast to the kernel only to have it assigned
as platform data to the MFD cells and then picked back
into the same subsystem that defined it in the first
place. This kills off a layer of indirection.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/ab8500-core.c                     | 17 +++++----
 .../power/supply}/ab8500-bm.h                 | 19 ++--------
 drivers/power/supply/ab8500_bmdata.c          |  3 +-
 drivers/power/supply/ab8500_btemp.c           | 35 +++----------------
 drivers/power/supply/ab8500_charger.c         | 10 ++----
 drivers/power/supply/ab8500_fg.c              | 10 ++----
 drivers/power/supply/abx500_chargalg.c        | 10 ++----
 drivers/power/supply/pm2301_charger.c         |  2 +-
 8 files changed, 27 insertions(+), 79 deletions(-)
 rename {include/linux/mfd/abx500 => drivers/power/supply}/ab8500-bm.h (96%)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index ba8da061af0e..82db43b2b6f1 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/regulator/ab8500.h>
 #include <linux/of.h>
@@ -610,14 +609,14 @@ int ab8500_suspend(struct ab8500 *ab8500)
 }
 
 static const struct mfd_cell ab8500_bm_devs[] = {
-	MFD_CELL_OF("ab8500-charger", NULL, &ab8500_bm_data,
-		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-charger"),
-	MFD_CELL_OF("ab8500-btemp", NULL, &ab8500_bm_data,
-		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-btemp"),
-	MFD_CELL_OF("ab8500-fg", NULL, &ab8500_bm_data,
-		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-fg"),
-	MFD_CELL_OF("ab8500-chargalg", NULL, &ab8500_bm_data,
-		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-chargalg"),
+	MFD_CELL_OF("ab8500-charger", NULL, NULL, 0, 0,
+		    "stericsson,ab8500-charger"),
+	MFD_CELL_OF("ab8500-btemp", NULL, NULL, 0, 0,
+		    "stericsson,ab8500-btemp"),
+	MFD_CELL_OF("ab8500-fg", NULL, NULL, 0, 0,
+		    "stericsson,ab8500-fg"),
+	MFD_CELL_OF("ab8500-chargalg", NULL, NULL, 0, 0,
+		    "stericsson,ab8500-chargalg"),
 };
 
 static const struct mfd_cell ab8500_devs[] = {
diff --git a/include/linux/mfd/abx500/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
similarity index 96%
rename from include/linux/mfd/abx500/ab8500-bm.h
rename to drivers/power/supply/ab8500-bm.h
index 903e94c189d8..a1b31c971a45 100644
--- a/include/linux/mfd/abx500/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -1,12 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright ST-Ericsson 2012.
- *
- * Author: Arun Murthy <arun.murthy@stericsson.com>
- */
 
-#ifndef _AB8500_BM_H
-#define _AB8500_BM_H
+#ifndef _AB8500_CHARGER_H_
+#define _AB8500_CHARGER_H_
 
 #include <linux/kernel.h>
 #include <linux/mfd/abx500.h>
@@ -453,16 +448,11 @@ struct ab8500_bm_data {
 };
 
 struct ab8500_btemp;
-struct ab8500_gpadc;
 struct ab8500_fg;
 
-#ifdef CONFIG_AB8500_BM
 extern struct abx500_bm_data ab8500_bm_data;
 
 void ab8500_charger_usb_state_changed(u8 bm_usb_state, u16 mA);
-struct ab8500_btemp *ab8500_btemp_get(void);
-int ab8500_btemp_get_batctrl_temp(struct ab8500_btemp *btemp);
-int ab8500_btemp_get_temp(struct ab8500_btemp *btemp);
 struct ab8500_fg *ab8500_fg_get(void);
 int ab8500_fg_inst_curr_blocking(struct ab8500_fg *dev);
 int ab8500_fg_inst_curr_start(struct ab8500_fg *di);
@@ -470,7 +460,4 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res);
 int ab8500_fg_inst_curr_started(struct ab8500_fg *di);
 int ab8500_fg_inst_curr_done(struct ab8500_fg *di);
 
-#else
-static struct abx500_bm_data ab8500_bm_data;
-#endif
-#endif /* _AB8500_BM_H */
+#endif /* _AB8500_CHARGER_H_ */
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index f6a66979cbb5..c2b8c0bb77e2 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -4,7 +4,8 @@
 #include <linux/of.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
+
+#include "ab8500-bm.h"
 
 /*
  * These are the defined batteries that uses a NTC and ID resistor placed
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 3cec0affd866..fdfcd59fc43e 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -25,9 +25,10 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/iio/consumer.h>
 
+#include "ab8500-bm.h"
+
 #define VTVOUT_V			1800
 
 #define BTEMP_THERMAL_LOW_LIMIT		-10
@@ -119,16 +120,6 @@ static enum power_supply_property ab8500_btemp_props[] = {
 
 static LIST_HEAD(ab8500_btemp_list);
 
-/**
- * ab8500_btemp_get() - returns a reference to the primary AB8500 BTEMP
- * (i.e. the first BTEMP in the instance list)
- */
-struct ab8500_btemp *ab8500_btemp_get(void)
-{
-	return list_first_entry(&ab8500_btemp_list, struct ab8500_btemp, node);
-}
-EXPORT_SYMBOL(ab8500_btemp_get);
-
 /**
  * ab8500_btemp_batctrl_volt_to_res() - convert batctrl voltage to resistance
  * @di:		pointer to the ab8500_btemp structure
@@ -754,7 +745,7 @@ static void ab8500_btemp_periodic(struct ab8500_btemp *di,
  *
  * Returns battery temperature
  */
-int ab8500_btemp_get_temp(struct ab8500_btemp *di)
+static int ab8500_btemp_get_temp(struct ab8500_btemp *di)
 {
 	int temp = 0;
 
@@ -790,19 +781,6 @@ int ab8500_btemp_get_temp(struct ab8500_btemp *di)
 	}
 	return temp;
 }
-EXPORT_SYMBOL(ab8500_btemp_get_temp);
-
-/**
- * ab8500_btemp_get_batctrl_temp() - get the temperature
- * @btemp:      pointer to the btemp structure
- *
- * Returns the batctrl temperature in millidegrees
- */
-int ab8500_btemp_get_batctrl_temp(struct ab8500_btemp *btemp)
-{
-	return btemp->bat_temp * 1000;
-}
-EXPORT_SYMBOL(ab8500_btemp_get_batctrl_temp);
 
 /**
  * ab8500_btemp_get_property() - get the btemp properties
@@ -991,7 +969,6 @@ static const struct power_supply_desc ab8500_btemp_desc = {
 static int ab8500_btemp_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct abx500_bm_data *plat = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
 	struct device *dev = &pdev->dev;
 	struct ab8500_btemp *di;
@@ -1002,11 +979,7 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	if (!di)
 		return -ENOMEM;
 
-	if (!plat) {
-		dev_err(dev, "no battery management data supplied\n");
-		return -EINVAL;
-	}
-	di->bm = plat;
+	di->bm = &ab8500_bm_data;
 
 	ret = ab8500_bm_of_probe(dev, np, di->bm);
 	if (ret) {
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index aa573cd299e2..50989a5ec95c 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -28,12 +28,13 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/usb/otg.h>
 #include <linux/mutex.h>
 #include <linux/iio/consumer.h>
 
+#include "ab8500-bm.h"
+
 /* Charger constants */
 #define NO_PW_CONN			0
 #define AC_PW_CONN			1
@@ -3344,7 +3345,6 @@ static const struct power_supply_desc ab8500_usb_chg_desc = {
 static int ab8500_charger_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct abx500_bm_data *plat = pdev->dev.platform_data;
 	struct power_supply_config ac_psy_cfg = {}, usb_psy_cfg = {};
 	struct ab8500_charger *di;
 	int irq, i, charger_status, ret = 0, ch_stat;
@@ -3354,11 +3354,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	if (!di)
 		return -ENOMEM;
 
-	if (!plat) {
-		dev_err(dev, "no battery management data supplied\n");
-		return -EINVAL;
-	}
-	di->bm = plat;
+	di->bm = &ab8500_bm_data;
 
 	ret = ab8500_bm_of_probe(dev, np, di->bm);
 	if (ret) {
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 9d734fd2b48f..8a6d40623731 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -31,10 +31,11 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/iio/consumer.h>
 #include <linux/kernel.h>
 
+#include "ab8500-bm.h"
+
 #define MILLI_TO_MICRO			1000
 #define FG_LSB_IN_MA			1627
 #define QLSB_NANO_AMP_HOURS_X10		1071
@@ -3026,7 +3027,6 @@ static const struct power_supply_desc ab8500_fg_desc = {
 static int ab8500_fg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct abx500_bm_data *plat = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
 	struct device *dev = &pdev->dev;
 	struct ab8500_fg *di;
@@ -3037,11 +3037,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	if (!di)
 		return -ENOMEM;
 
-	if (!plat) {
-		dev_err(dev, "no battery management data supplied\n");
-		return -EINVAL;
-	}
-	di->bm = plat;
+	di->bm = &ab8500_bm_data;
 
 	ret = ab8500_bm_of_probe(dev, np, di->bm);
 	if (ret) {
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index 591ddd2987a3..5b28d58041b4 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -29,9 +29,10 @@
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500/ux500_chargalg.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/notifier.h>
 
+#include "ab8500-bm.h"
+
 /* Watchdog kick interval */
 #define CHG_WD_INTERVAL			(6 * HZ)
 
@@ -1980,7 +1981,6 @@ static const struct power_supply_desc abx500_chargalg_desc = {
 static int abx500_chargalg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct abx500_bm_data *plat = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
 	struct abx500_chargalg *di;
 	int ret = 0;
@@ -1991,11 +1991,7 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (!plat) {
-		dev_err(&pdev->dev, "no battery management data supplied\n");
-		return -EINVAL;
-	}
-	di->bm = plat;
+	di->bm = &ab8500_bm_data;
 
 	ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
 	if (ret) {
diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index ac06ecf7fc9c..5aeff75db33b 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -18,13 +18,13 @@
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/mfd/abx500/ux500_chargalg.h>
 #include <linux/pm2301_charger.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm.h>
 
+#include "ab8500-bm.h"
 #include "pm2301_charger.h"
 
 #define to_pm2xxx_charger_ac_device_info(x) container_of((x), \
-- 
2.29.2

