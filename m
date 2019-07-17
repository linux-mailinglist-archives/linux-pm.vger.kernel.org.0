Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79CF6B6B0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfGQGec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 02:34:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45856 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQGec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 02:34:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so22371614lje.12
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdTuAwcR0u0VlWAQfuFI6gqYTICpVN50inAUBoWJs68=;
        b=t6c8a36Q2Ba+G930npkP6KlAS1fHxoQy3qlfmFzOx2BpouOAwM/BIh6c+YH/LYD0zd
         oMccTQGiIanWYORFTXUlRKHQKmYImqZWcsSVcxYBeMg4MPzSeF0yF8j0TeykS8pFn0zQ
         VJqejOhWjQfF2Llj8jB50THjsZeZ9g8OYJDrjuoZydM4PipKwrl1AYICZFeKjaeXF8ZC
         QrZPC9WFcAcZBmqx717R2WcbzimVdABK22JLakj21sk7335yEKlhLInNcoxqMmVShMP0
         QgSsAICHoN3bK1M0otupn0R1gFcBQgsrEkYo/pyNIuB5SlzkPumSbs91A86e3IsTE+m1
         +9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdTuAwcR0u0VlWAQfuFI6gqYTICpVN50inAUBoWJs68=;
        b=VM98CydZT6Gx2hm4+2FnICY4FLmTxP+RRZf/hs8lkLHHQcts/pqlbOskxDgmXNvRZE
         5MQbsJw4Vxx+kw8tzO5aC0lVWpeeX/MYjNiVdVYOY6YJHDVrTcwVMfb9MW4ROrTv3KNG
         WmSK3Gx86zhhxwHGQOoGPDTSV7/dU7AF4ugJmbQqKkj7Bgrvz651wXgW/eCRsYVm4cmr
         7Ym1UMzPn0VzxbP3bx7jjdKZ66OJSh5eZKj9HVjvQy8zubGGAcQlBM1ifiAGIFX2w8tW
         QQFoeUVH4xNYV+rSzzTlUJrIp6/V4uG5Cq+YMM/hc8Jv0Z0Cz32lEoiKKG+N9pR30TMM
         mCJA==
X-Gm-Message-State: APjAAAWOJGEAkfgzlG5Ltz8tOA+TGWTPQOVLi4xQ9z0BO5SEDptM28wl
        ZWLeb0CmUz0s9DcgXyzo6rB+jJLgFJE=
X-Google-Smtp-Source: APXvYqyv3mE/rUE8pqdRfDu1p14XbdCAD6q6cvO5zdbI77ZKZmjDMtQsLo7VjAQGESqOS/pTep5kAQ==
X-Received: by 2002:a2e:8801:: with SMTP id x1mr19635239ljh.1.1563345269573;
        Tue, 16 Jul 2019 23:34:29 -0700 (PDT)
Received: from localhost.localdomain (c-22cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.34])
        by smtp.gmail.com with ESMTPSA id z22sm4277827ljz.20.2019.07.16.23.34.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 23:34:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
Date:   Wed, 17 Jul 2019 08:32:21 +0200
Message-Id: <20190717063222.5902-1-linus.walleij@linaro.org>
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

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Lee: it'd be great if you could ACK this, it is a file
with low change rate so we should likely not see any
collisions.
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

