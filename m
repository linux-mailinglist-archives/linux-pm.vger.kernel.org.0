Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58215338781
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 09:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhCLIgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 03:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhCLIgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 03:36:14 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D200FC061761
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 00:36:13 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v9so44455619lfa.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 00:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cfODJJEjoFRdUGp9rV81DDvFDojlqwM2tEeUfbsH3U=;
        b=FZTAyV5iNVoKa24JnfbXZedA1EwbyA2vHOaPGVcMGwRys5cRj6y9wW9N9lzZyeknYa
         l+OAodJlvOOzy3gx2xDHDwBngO1cwUqktp2Wc4JhoA+/jebsvfP/Xpru8u2s4+ZwI2aZ
         QVGFDiASNPGe24XRf2VL8AeJS+2yYnFCTJe/4yDoXMp/a5U6Inxl1VWt86bvujwEm8kt
         zSODOrTHfZxHvYYn8KRW/anz0zOGqvROM82+5jnWs3SlZ+yV2r3cnpg2GiYGOX0mTdml
         OZ356pk3NY49c9VGLpDkdAVb8Arl0YUpoYRjTX3hOOZml3YaMWpEZSO8n4XTlxYjHjmL
         Y77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cfODJJEjoFRdUGp9rV81DDvFDojlqwM2tEeUfbsH3U=;
        b=Z4OEC4kNfl/+mClRWguuJ4rjqQqfdGGEv8YhlS9s5xorvL9op3kN1ueRd/r13aFhLS
         ol8e0IhbXYo49J2rxbZg39AwcM3eQXMBercQdEPhm6GAVpxRavPQ5mlp3x+k6HxqaxgE
         cGkQ9GS327D9XylwdAliDG7IAVCgvAb8d7/PJICA0QgcYjI7GnLmiZXtOIuWCZTTepXw
         M8oBwGvp7LBI1tF+OiYO0SD6Ng5yPdDxy9ONW5Vns8sIl+e5Qrm0qSZfaalfzOyTJE3C
         ++ssWztm2LPTh0PgmJgzp83RQCKnairb6gG0JYgwJ9NuwKN1DpM0GtCl/4mVA2Wyop1R
         FG3A==
X-Gm-Message-State: AOAM530qUE/HKHsic8vv+aS1kUKr1QogkIxOboGceleQJ4p2hp6zMX45
        aMfbWQS9ZSSr/a/I1oyAlsoh6w==
X-Google-Smtp-Source: ABdhPJy5M3fwm9rO4n+GAYkL4nSP6Nao8RG3qjiIccT6g9costF8Fvr6pwnQj5A4vW7cStvOjN8Ziw==
X-Received: by 2002:a19:520b:: with SMTP id m11mr4643801lfb.42.1615538172250;
        Fri, 12 Mar 2021 00:36:12 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id p6sm1617532lfc.71.2021.03.12.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:36:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4] mfd/power: ab8500: Push data to power supply code
Date:   Fri, 12 Mar 2021 09:36:02 +0100
Message-Id: <20210312083604.3708890-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312083604.3708890-1-linus.walleij@linaro.org>
References: <20210312083604.3708890-1-linus.walleij@linaro.org>
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

Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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
index 2dde3a7532c4..7bb23c0d1efd 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -603,14 +602,14 @@ int ab8500_suspend(struct ab8500 *ab8500)
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
index ca5153c82c81..33fb6f65749c 100644
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
index 079e11325a81..0c7c01a0d979 100644
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

