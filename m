Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27C19FDBD
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfH1JAI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 05:00:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40256 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1JAH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 05:00:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id u29so1467773lfk.7
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 02:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o6/WQ8OyBRP6X3I/ZtBD+hIUAEwLu2Ivn3M2czCngrU=;
        b=jOhJ+LW0AlXZCOi9+dlW1A5t220ThekSlY01z/TTaOIxpGotcmjjpX0zpGTnZ7488v
         wnMKLjfFAkdSXvEyo2nqQDI+hU/yvHDAvZQStY8dCqzv3K3zt+HVtA5+FMU0MQ57VEg2
         dGrSmJaQf1KkvHB3OyZcHIjMwcm0uOEn95ipPyRuD0H5xGCK79t+q7aLSCAuwBv09UpB
         zpZobkbRpEyAtzx9zHvJAjpAJe1zUeRgeNLFAJHcRkJhySpXm+zn+v+shhVNJvNXsJjk
         N4Tu4o/9ok5rc1IqNtwPognHXXmQ8wnehAgzKG1Y1kYIyDcEb1bHX8wyL/3hxGw80cEz
         bErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o6/WQ8OyBRP6X3I/ZtBD+hIUAEwLu2Ivn3M2czCngrU=;
        b=cYwMJr1YoPgtEtzZ0fCPntkW/RqKV4b5lznenN3xRD5g7d8gxKrUKy/tKiOzbARNU3
         Nv2cHCB70BjdCucatM7LJ4vwTj5ErbN29IgEtkxPvh3TZh73dU+T7aZ/zoYVWE6p3ECf
         25vvEqOowktf2k1ItKcFGT8g8AcX1I17vUViTTr94lyQcaF0J0M88tttejQF+iUsjHvy
         N9EU9HSwVxPh5sYhxROe7pnudejrYQqB58qYM2lsMQeUeO47D4QyplPCmx61nOo7z2Ob
         zbdmd2VpXXGznMWQEyHjAOUZD15+pi4zC+TsipHoztjxkxLQ1IcBavCiDN8T7+5im1BS
         2mXw==
X-Gm-Message-State: APjAAAVzPQX3ZRwIvel5Cj7MkWeyu/gS+B4VXvTPfjY9JZ22xsvKE7Kp
        4/Vx7G+Tqwp0+qD3FHyF8ZUEgwZVj+4=
X-Google-Smtp-Source: APXvYqx0pcIwAQo5dgSrzR3zwF4yE4Y/qlczam7OfZGVPVf61amcqRZ1+JuAD9rOz88VFV+zpT5nlg==
X-Received: by 2002:a19:8017:: with SMTP id b23mr1853821lfd.132.1566982804638;
        Wed, 28 Aug 2019 02:00:04 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id c23sm449653ljf.105.2019.08.28.02.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 02:00:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/3 v2] thermal: db8500: Finalize device tree conversion
Date:   Wed, 28 Aug 2019 10:59:57 +0200
Message-Id: <20190828085959.11510-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

At some point there was an attempt to convert the DB8500
thermal sensor to device tree: a probe path was added
and the device tree was augmented for the Snowball board.
The switchover was never completed: instead the thermal
devices came from from the PRCMU MFD device and the probe
on the Snowball was confused as another set of configuration
appeared from the device tree.

Move over to a device-tree only approach, as we fixed up
the device trees.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No change, resending with the rest of the patches
---
 drivers/mfd/db8500-prcmu.c                   | 53 +-------------------
 drivers/thermal/Kconfig                      |  2 +-
 drivers/thermal/db8500_thermal.c             | 30 +++++------
 include/linux/platform_data/db8500_thermal.h | 29 -----------
 4 files changed, 17 insertions(+), 97 deletions(-)
 delete mode 100644 include/linux/platform_data/db8500_thermal.h

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3f21e26b8d36..a1e09bf06977 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -36,7 +36,6 @@
 #include <linux/regulator/db8500-prcmu.h>
 #include <linux/regulator/machine.h>
 #include <linux/platform_data/ux500_wdt.h>
-#include <linux/platform_data/db8500_thermal.h>
 #include "dbx500-prcmu-regs.h"
 
 /* Index of different voltages to be used when accessing AVSData */
@@ -2982,53 +2981,6 @@ static struct ux500_wdt_data db8500_wdt_pdata = {
 	.timeout = 600, /* 10 minutes */
 	.has_28_bits_resolution = true,
 };
-/*
- * Thermal Sensor
- */
-
-static struct resource db8500_thsens_resources[] = {
-	{
-		.name = "IRQ_HOTMON_LOW",
-		.start  = IRQ_PRCMU_HOTMON_LOW,
-		.end    = IRQ_PRCMU_HOTMON_LOW,
-		.flags  = IORESOURCE_IRQ,
-	},
-	{
-		.name = "IRQ_HOTMON_HIGH",
-		.start  = IRQ_PRCMU_HOTMON_HIGH,
-		.end    = IRQ_PRCMU_HOTMON_HIGH,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct db8500_thsens_platform_data db8500_thsens_data = {
-	.trip_points[0] = {
-		.temp = 70000,
-		.type = THERMAL_TRIP_ACTIVE,
-		.cdev_name = {
-			[0] = "thermal-cpufreq-0",
-		},
-	},
-	.trip_points[1] = {
-		.temp = 75000,
-		.type = THERMAL_TRIP_ACTIVE,
-		.cdev_name = {
-			[0] = "thermal-cpufreq-0",
-		},
-	},
-	.trip_points[2] = {
-		.temp = 80000,
-		.type = THERMAL_TRIP_ACTIVE,
-		.cdev_name = {
-			[0] = "thermal-cpufreq-0",
-		},
-	},
-	.trip_points[3] = {
-		.temp = 85000,
-		.type = THERMAL_TRIP_CRITICAL,
-	},
-	.num_trips = 4,
-};
 
 static const struct mfd_cell common_prcmu_devs[] = {
 	{
@@ -3052,10 +3004,7 @@ static const struct mfd_cell db8500_prcmu_devs[] = {
 	},
 	{
 		.name = "db8500-thermal",
-		.num_resources = ARRAY_SIZE(db8500_thsens_resources),
-		.resources = db8500_thsens_resources,
-		.platform_data = &db8500_thsens_data,
-		.pdata_size = sizeof(db8500_thsens_data),
+		.of_compatible = "stericsson,db8500-thermal",
 	},
 };
 
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 9966364a6deb..001a21abcc28 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -310,7 +310,7 @@ config DOVE_THERMAL
 
 config DB8500_THERMAL
 	tristate "DB8500 thermal management"
-	depends on MFD_DB8500_PRCMU
+	depends on MFD_DB8500_PRCMU && OF
 	default y
 	help
 	  Adds DB8500 thermal management implementation according to the thermal
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index b71a999d17d6..d650ae5fdf2a 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -13,13 +13,24 @@
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_data/db8500_thermal.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 
 #define PRCMU_DEFAULT_MEASURE_TIME	0xFFF
 #define PRCMU_DEFAULT_LOW_TEMP		0
+#define COOLING_DEV_MAX 8
+
+struct db8500_trip_point {
+	unsigned long temp;
+	enum thermal_trip_type type;
+	char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
+};
+
+struct db8500_thsens_platform_data {
+	struct db8500_trip_point trip_points[THERMAL_MAX_TRIPS];
+	int num_trips;
+};
 
 struct db8500_thermal_zone {
 	struct thermal_zone_device *therm_dev;
@@ -301,7 +312,6 @@ static void db8500_thermal_work(struct work_struct *work)
 	dev_dbg(&pzone->therm_dev->device, "thermal work finished.\n");
 }
 
-#ifdef CONFIG_OF
 static struct db8500_thsens_platform_data*
 		db8500_thermal_parse_dt(struct platform_device *pdev)
 {
@@ -370,13 +380,6 @@ static struct db8500_thsens_platform_data*
 	dev_err(&pdev->dev, "Parsing device tree data error.\n");
 	return NULL;
 }
-#else
-static inline struct db8500_thsens_platform_data*
-		db8500_thermal_parse_dt(struct platform_device *pdev)
-{
-	return NULL;
-}
-#endif
 
 static int db8500_thermal_probe(struct platform_device *pdev)
 {
@@ -386,11 +389,10 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	int low_irq, high_irq, ret = 0;
 	unsigned long dft_low, dft_high;
 
-	if (np)
-		ptrips = db8500_thermal_parse_dt(pdev);
-	else
-		ptrips = dev_get_platdata(&pdev->dev);
+	if (!np)
+		return -EINVAL;
 
+	ptrips = db8500_thermal_parse_dt(pdev);
 	if (!ptrips)
 		return -EINVAL;
 
@@ -498,13 +500,11 @@ static int db8500_thermal_resume(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id db8500_thermal_match[] = {
 	{ .compatible = "stericsson,db8500-thermal" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, db8500_thermal_match);
-#endif
 
 static struct platform_driver db8500_thermal_driver = {
 	.driver = {
diff --git a/include/linux/platform_data/db8500_thermal.h b/include/linux/platform_data/db8500_thermal.h
deleted file mode 100644
index 55e55750a165..000000000000
--- a/include/linux/platform_data/db8500_thermal.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * db8500_thermal.h - DB8500 Thermal Management Implementation
- *
- * Copyright (C) 2012 ST-Ericsson
- * Copyright (C) 2012 Linaro Ltd.
- *
- * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
- */
-
-#ifndef _DB8500_THERMAL_H_
-#define _DB8500_THERMAL_H_
-
-#include <linux/thermal.h>
-
-#define COOLING_DEV_MAX 8
-
-struct db8500_trip_point {
-	unsigned long temp;
-	enum thermal_trip_type type;
-	char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
-};
-
-struct db8500_thsens_platform_data {
-	struct db8500_trip_point trip_points[THERMAL_MAX_TRIPS];
-	int num_trips;
-};
-
-#endif /* _DB8500_THERMAL_H_ */
-- 
2.21.0

