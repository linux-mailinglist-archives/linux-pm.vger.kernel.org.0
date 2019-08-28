Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD5A027B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfH1NDe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 09:03:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44811 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1NDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 09:03:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id v16so2076372lfg.11
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 06:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5r/mkLPM7RnFlcs8Ze35C5xSXkvw0+IMXLdgVIVqSE=;
        b=xjSQmnF4PkWtEfDExKZvSNYX5v1lAh4OXhZ2wjrati7inM0Gu1N64++hSlR9Tfzge0
         bstgadAAi1/QyPfAF70k1Hk31BrBuE5i/jS6Zbis9WeweH5/QgOb8roj6xbSprHtq/4p
         xvFjChaF3BhnnYGVplN7PRcZpRmyiLpaC8hUgj+S3aiEv304V4ILa4n4FnmDW8tu/VP/
         J1fzPriYUISpO3jVoufrNoxLIZPDMgfIqAonIgeGF7tAzmAToJiKySO4TmFqfQvDODGr
         CIiphBHdkdNkGVvSSrQTLMEy7UIpjHsNvhQHWZE/KgJLY7xeXgv3OYBDMGIcQSDIcfs7
         Zffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5r/mkLPM7RnFlcs8Ze35C5xSXkvw0+IMXLdgVIVqSE=;
        b=YMlgPD5B9/YswjfQEzmiFFyNLyyg/seitTarwMZTbwXsonsPeOsgir7duB9sJ9ZUXr
         xy+87HA6QaOd+qUAW3an6vVilwaV+q15BsO9MUS9JFvjzBAlJNmoTFs83TwDzVNlrZHt
         KoOzTAVPY9Glss3Bw7yfYyhy0Zeqx4kivotlJ4ZPoyhGSRWCEDQ27s+TggUfMXg3zhiW
         Gsqtbw0jMwYJUpb+4CrT/b9Oz9mSZFS/AE9IXRdsFVV65aB0IRUexpUsZqvSUkJ+qiLr
         qpUuF0aWbn2qm1cTzpOiOWjc79DU/mx2buqS9+wONoJHOowSGk83wY3sQaDE9oaYnCWB
         BBOA==
X-Gm-Message-State: APjAAAV3q3W59jgzhu7/BB6GsOPHUSeh9EmflTXt3sEXDGra8ZIn08+k
        m8pRthkXYRh+NGmH/ab2BkbkBA==
X-Google-Smtp-Source: APXvYqxuN44v5TWZWDJHuwUFbcrmxJ9O4M44rgCVZchmdXloE82zkAR1S3Goc1WWEHVaBbnse+0QWA==
X-Received: by 2002:ac2:46ce:: with SMTP id p14mr2675705lfo.39.1566997410400;
        Wed, 28 Aug 2019 06:03:30 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id 18sm843611lfy.26.2019.08.28.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:03:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3 v4] thermal: db8500: Rewrite to be a pure OF sensor
Date:   Wed, 28 Aug 2019 15:03:20 +0200
Message-Id: <20190828130320.6174-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828130320.6174-1-linus.walleij@linaro.org>
References: <20190828130320.6174-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch rewrites the DB8500 thermal sensor to be a
pure OF sensor, so that it can be used with thermal zones
defined in the device tree.

This driver was initially merged before we had generic
thermal zone device tree bindings, and now it gets
modernized to the way we do things these days.

The old driver depended on a set of trigger points
provided in the device tree or platform data to
interpolate the current temperature between trigger
points depending on whether the trend was rising or
falling. This was bad because the trigger points should
be used for defining temperature zone policies and
bind to cooling devices.

As the PRCMU (power reset control management unit) can
only issue IRQs when we pass temperature trigger points
upward or downward We instead define a number of
temperature points inside the driver ranging from
15 to 100 degrees celsius. The effect is that when
we register the device we quickly trigger 15, 20 ... up
to the room temperature in succession and then we
get continous event IRQs also under normal operating
conditions, and the temperature of the system is now
reported more accurately (+/- 2.5 degrees celsius)
while in the past the first trigger point was at 70
degrees and the average temperature was simply reported
as 35 degrees celsius (between 70 degrees and 0) until
we passed 70 degrees which didn't accurately represent
the temperature of the system.

As a result of dropping all the trigger points from the
driver and reusing the core DT thermal zone management
code we reduce the code footprint quite a bit.

Cc: Vincent Guittot <vincent.guittot@linaro.org>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Drop the pointless work and update the thermal zone
  directly from the threaded interrupt handler, we are in
  process context already.
ChangeLog v2->v3:
- Drop pointless mode in the state container
- Drop pointless mutex
ChangeLog v1->v2:
- New patch as suggested by Daniel.
---
 drivers/thermal/db8500_thermal.c | 477 +++++++------------------------
 1 file changed, 107 insertions(+), 370 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index d250bcf3c10c..372dbbaaafb8 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -3,9 +3,9 @@
  * db8500_thermal.c - DB8500 Thermal Management Implementation
  *
  * Copyright (C) 2012 ST-Ericsson
- * Copyright (C) 2012 Linaro Ltd.
+ * Copyright (C) 2012-2019 Linaro Ltd.
  *
- * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
+ * Authors: Hongbo Zhang, Linus Walleij
  */
 
 #include <linux/cpu_cooling.h>
@@ -19,458 +19,202 @@
 
 #define PRCMU_DEFAULT_MEASURE_TIME	0xFFF
 #define PRCMU_DEFAULT_LOW_TEMP		0
-#define COOLING_DEV_MAX 8
 
-struct db8500_trip_point {
-	unsigned long temp;
-	enum thermal_trip_type type;
-	char cdev_name[COOLING_DEV_MAX][THERMAL_NAME_LENGTH];
-};
-
-struct db8500_thsens_platform_data {
-	struct db8500_trip_point trip_points[THERMAL_MAX_TRIPS];
-	int num_trips;
+/**
+ * db8500_thermal_points - the interpolation points that trigger
+ * interrupts
+ */
+static const unsigned long db8500_thermal_points[] = {
+	15000,
+	20000,
+	25000,
+	30000,
+	35000,
+	40000,
+	45000,
+	50000,
+	55000,
+	60000,
+	65000,
+	70000,
+	75000,
+	80000,
+	/*
+	 * This is where things start to get really bad for the
+	 * SoC and the thermal zones should be set up to trigger
+	 * critical temperature at 85000 mC so we don't get above
+	 * this point.
+	 */
+	85000,
+	90000,
+	95000,
+	100000,
 };
 
 struct db8500_thermal_zone {
-	struct thermal_zone_device *therm_dev;
-	struct mutex th_lock;
-	struct work_struct therm_work;
-	struct db8500_thsens_platform_data *trip_tab;
-	enum thermal_device_mode mode;
+	struct thermal_zone_device *tz;
 	enum thermal_trend trend;
-	unsigned long cur_temp_pseudo;
+	unsigned long interpolated_temp;
 	unsigned int cur_index;
 };
 
-/* Local function to check if thermal zone matches cooling devices */
-static int db8500_thermal_match_cdev(struct thermal_cooling_device *cdev,
-		struct db8500_trip_point *trip_point)
-{
-	int i;
-
-	if (!strlen(cdev->type))
-		return -EINVAL;
-
-	for (i = 0; i < COOLING_DEV_MAX; i++) {
-		if (!strcmp(trip_point->cdev_name[i], cdev->type))
-			return 0;
-	}
-
-	return -ENODEV;
-}
-
-/* Callback to bind cooling device to thermal zone */
-static int db8500_cdev_bind(struct thermal_zone_device *thermal,
-		struct thermal_cooling_device *cdev)
-{
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-	unsigned long max_state, upper, lower;
-	int i, ret = -EINVAL;
-
-	cdev->ops->get_max_state(cdev, &max_state);
-
-	for (i = 0; i < ptrips->num_trips; i++) {
-		if (db8500_thermal_match_cdev(cdev, &ptrips->trip_points[i]))
-			continue;
-
-		upper = lower = i > max_state ? max_state : i;
-
-		ret = thermal_zone_bind_cooling_device(thermal, i, cdev,
-			upper, lower, THERMAL_WEIGHT_DEFAULT);
-
-		dev_info(&cdev->device, "%s bind to %d: %d-%s\n", cdev->type,
-			i, ret, ret ? "fail" : "succeed");
-	}
-
-	return ret;
-}
-
-/* Callback to unbind cooling device from thermal zone */
-static int db8500_cdev_unbind(struct thermal_zone_device *thermal,
-		struct thermal_cooling_device *cdev)
-{
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-	int i, ret = -EINVAL;
-
-	for (i = 0; i < ptrips->num_trips; i++) {
-		if (db8500_thermal_match_cdev(cdev, &ptrips->trip_points[i]))
-			continue;
-
-		ret = thermal_zone_unbind_cooling_device(thermal, i, cdev);
-
-		dev_info(&cdev->device, "%s unbind from %d: %s\n", cdev->type,
-			i, ret ? "fail" : "succeed");
-	}
-
-	return ret;
-}
-
 /* Callback to get current temperature */
-static int db8500_sys_get_temp(struct thermal_zone_device *thermal, int *temp)
+static int db8500_thermal_get_temp(void *data, int *temp)
 {
-	struct db8500_thermal_zone *pzone = thermal->devdata;
+	struct db8500_thermal_zone *th = data;
 
 	/*
 	 * TODO: There is no PRCMU interface to get temperature data currently,
 	 * so a pseudo temperature is returned , it works for thermal framework
 	 * and this will be fixed when the PRCMU interface is available.
 	 */
-	*temp = pzone->cur_temp_pseudo;
+	*temp = th->interpolated_temp;
 
 	return 0;
 }
 
 /* Callback to get temperature changing trend */
-static int db8500_sys_get_trend(struct thermal_zone_device *thermal,
-		int trip, enum thermal_trend *trend)
-{
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-
-	*trend = pzone->trend;
-
-	return 0;
-}
-
-/* Callback to get thermal zone mode */
-static int db8500_sys_get_mode(struct thermal_zone_device *thermal,
-		enum thermal_device_mode *mode)
-{
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-
-	mutex_lock(&pzone->th_lock);
-	*mode = pzone->mode;
-	mutex_unlock(&pzone->th_lock);
-
-	return 0;
-}
-
-/* Callback to set thermal zone mode */
-static int db8500_sys_set_mode(struct thermal_zone_device *thermal,
-		enum thermal_device_mode mode)
-{
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-
-	mutex_lock(&pzone->th_lock);
-
-	pzone->mode = mode;
-	if (mode == THERMAL_DEVICE_ENABLED)
-		schedule_work(&pzone->therm_work);
-
-	mutex_unlock(&pzone->th_lock);
-
-	return 0;
-}
-
-/* Callback to get trip point type */
-static int db8500_sys_get_trip_type(struct thermal_zone_device *thermal,
-		int trip, enum thermal_trip_type *type)
-{
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-
-	if (trip >= ptrips->num_trips)
-		return -EINVAL;
-
-	*type = ptrips->trip_points[trip].type;
-
-	return 0;
-}
-
-/* Callback to get trip point temperature */
-static int db8500_sys_get_trip_temp(struct thermal_zone_device *thermal,
-		int trip, int *temp)
+static int db8500_thermal_get_trend(void *data, int trip, enum thermal_trend *trend)
 {
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-
-	if (trip >= ptrips->num_trips)
-		return -EINVAL;
+	struct db8500_thermal_zone *th = data;
 
-	*temp = ptrips->trip_points[trip].temp;
+	*trend = th->trend;
 
 	return 0;
 }
 
-/* Callback to get critical trip point temperature */
-static int db8500_sys_get_crit_temp(struct thermal_zone_device *thermal,
-		int *temp)
-{
-	struct db8500_thermal_zone *pzone = thermal->devdata;
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-	int i;
-
-	for (i = ptrips->num_trips - 1; i > 0; i--) {
-		if (ptrips->trip_points[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = ptrips->trip_points[i].temp;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
-static struct thermal_zone_device_ops thdev_ops = {
-	.bind = db8500_cdev_bind,
-	.unbind = db8500_cdev_unbind,
-	.get_temp = db8500_sys_get_temp,
-	.get_trend = db8500_sys_get_trend,
-	.get_mode = db8500_sys_get_mode,
-	.set_mode = db8500_sys_set_mode,
-	.get_trip_type = db8500_sys_get_trip_type,
-	.get_trip_temp = db8500_sys_get_trip_temp,
-	.get_crit_temp = db8500_sys_get_crit_temp,
+static struct thermal_zone_of_device_ops thdev_ops = {
+	.get_temp = db8500_thermal_get_temp,
+	.get_trend = db8500_thermal_get_trend,
 };
 
-static void db8500_thermal_update_config(struct db8500_thermal_zone *pzone,
-		unsigned int idx, enum thermal_trend trend,
-		unsigned long next_low, unsigned long next_high)
+static void db8500_thermal_update_config(struct db8500_thermal_zone *th,
+					 unsigned int idx,
+					 enum thermal_trend trend,
+					 unsigned long next_low,
+					 unsigned long next_high)
 {
 	prcmu_stop_temp_sense();
 
-	pzone->cur_index = idx;
-	pzone->cur_temp_pseudo = (next_low + next_high)/2;
-	pzone->trend = trend;
+	th->cur_index = idx;
+	th->interpolated_temp = (next_low + next_high)/2;
+	th->trend = trend;
 
+	/*
+	 * The PRCMU accept absolute temperatures in celsius so divide
+	 * down the millicelsius with 1000
+	 */
 	prcmu_config_hotmon((u8)(next_low/1000), (u8)(next_high/1000));
 	prcmu_start_temp_sense(PRCMU_DEFAULT_MEASURE_TIME);
 }
 
 static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)
 {
-	struct db8500_thermal_zone *pzone = irq_data;
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-	unsigned int idx = pzone->cur_index;
+	struct db8500_thermal_zone *th = irq_data;
+	unsigned int idx = th->cur_index;
 	unsigned long next_low, next_high;
 
-	if (unlikely(idx == 0))
+	if (idx == 0)
 		/* Meaningless for thermal management, ignoring it */
 		return IRQ_HANDLED;
 
 	if (idx == 1) {
-		next_high = ptrips->trip_points[0].temp;
+		next_high = db8500_thermal_points[0];
 		next_low = PRCMU_DEFAULT_LOW_TEMP;
 	} else {
-		next_high = ptrips->trip_points[idx-1].temp;
-		next_low = ptrips->trip_points[idx-2].temp;
+		next_high = db8500_thermal_points[idx - 1];
+		next_low = db8500_thermal_points[idx - 2];
 	}
 	idx -= 1;
 
-	db8500_thermal_update_config(pzone, idx, THERMAL_TREND_DROPPING,
-		next_low, next_high);
-
-	dev_dbg(&pzone->therm_dev->device,
+	db8500_thermal_update_config(th, idx, THERMAL_TREND_DROPPING,
+				     next_low, next_high);
+	dev_dbg(&th->tz->device,
 		"PRCMU set max %ld, min %ld\n", next_high, next_low);
 
-	schedule_work(&pzone->therm_work);
+	thermal_zone_device_update(th->tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 {
-	struct db8500_thermal_zone *pzone = irq_data;
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-	unsigned int idx = pzone->cur_index;
+	struct db8500_thermal_zone *th = irq_data;
+	unsigned int idx = th->cur_index;
 	unsigned long next_low, next_high;
+	int num_points = ARRAY_SIZE(db8500_thermal_points);
 
-	if (idx < ptrips->num_trips - 1) {
-		next_high = ptrips->trip_points[idx+1].temp;
-		next_low = ptrips->trip_points[idx].temp;
+	if (idx < num_points - 1) {
+		next_high = db8500_thermal_points[idx+1];
+		next_low = db8500_thermal_points[idx];
 		idx += 1;
 
-		db8500_thermal_update_config(pzone, idx, THERMAL_TREND_RAISING,
-			next_low, next_high);
+		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
+					     next_low, next_high);
 
-		dev_dbg(&pzone->therm_dev->device,
-		"PRCMU set max %ld, min %ld\n", next_high, next_low);
-	} else if (idx == ptrips->num_trips - 1)
-		pzone->cur_temp_pseudo = ptrips->trip_points[idx].temp + 1;
+		dev_info(&th->tz->device,
+			 "PRCMU set max %ld, min %ld\n", next_high, next_low);
+	} else if (idx == num_points - 1)
+		/* So we roof out 1 degree over the max point */
+		th->interpolated_temp = db8500_thermal_points[idx] + 1;
 
-	schedule_work(&pzone->therm_work);
+	thermal_zone_device_update(th->tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
 
-static void db8500_thermal_work(struct work_struct *work)
-{
-	enum thermal_device_mode cur_mode;
-	struct db8500_thermal_zone *pzone;
-
-	pzone = container_of(work, struct db8500_thermal_zone, therm_work);
-
-	mutex_lock(&pzone->th_lock);
-	cur_mode = pzone->mode;
-	mutex_unlock(&pzone->th_lock);
-
-	if (cur_mode == THERMAL_DEVICE_DISABLED)
-		return;
-
-	thermal_zone_device_update(pzone->therm_dev, THERMAL_EVENT_UNSPECIFIED);
-	dev_dbg(&pzone->therm_dev->device, "thermal work finished.\n");
-}
-
-static struct db8500_thsens_platform_data*
-		db8500_thermal_parse_dt(struct device *dev)
-{
-	struct db8500_thsens_platform_data *ptrips;
-	struct device_node *np = dev->of_node;
-	char prop_name[32];
-	const char *tmp_str;
-	u32 tmp_data;
-	int i, j;
-
-	ptrips = devm_kzalloc(dev, sizeof(*ptrips), GFP_KERNEL);
-	if (!ptrips)
-		return NULL;
-
-	if (of_property_read_u32(np, "num-trips", &tmp_data))
-		goto err_parse_dt;
-
-	if (tmp_data > THERMAL_MAX_TRIPS)
-		goto err_parse_dt;
-
-	ptrips->num_trips = tmp_data;
-
-	for (i = 0; i < ptrips->num_trips; i++) {
-		sprintf(prop_name, "trip%d-temp", i);
-		if (of_property_read_u32(np, prop_name, &tmp_data))
-			goto err_parse_dt;
-
-		ptrips->trip_points[i].temp = tmp_data;
-
-		sprintf(prop_name, "trip%d-type", i);
-		if (of_property_read_string(np, prop_name, &tmp_str))
-			goto err_parse_dt;
-
-		if (!strcmp(tmp_str, "active"))
-			ptrips->trip_points[i].type = THERMAL_TRIP_ACTIVE;
-		else if (!strcmp(tmp_str, "passive"))
-			ptrips->trip_points[i].type = THERMAL_TRIP_PASSIVE;
-		else if (!strcmp(tmp_str, "hot"))
-			ptrips->trip_points[i].type = THERMAL_TRIP_HOT;
-		else if (!strcmp(tmp_str, "critical"))
-			ptrips->trip_points[i].type = THERMAL_TRIP_CRITICAL;
-		else
-			goto err_parse_dt;
-
-		sprintf(prop_name, "trip%d-cdev-num", i);
-		if (of_property_read_u32(np, prop_name, &tmp_data))
-			goto err_parse_dt;
-
-		if (tmp_data > COOLING_DEV_MAX)
-			goto err_parse_dt;
-
-		for (j = 0; j < tmp_data; j++) {
-			sprintf(prop_name, "trip%d-cdev-name%d", i, j);
-			if (of_property_read_string(np, prop_name, &tmp_str))
-				goto err_parse_dt;
-
-			if (strlen(tmp_str) >= THERMAL_NAME_LENGTH)
-				goto err_parse_dt;
-
-			strcpy(ptrips->trip_points[i].cdev_name[j], tmp_str);
-		}
-	}
-	return ptrips;
-
-err_parse_dt:
-	dev_err(dev, "Parsing device tree data error.\n");
-	return NULL;
-}
-
 static int db8500_thermal_probe(struct platform_device *pdev)
 {
-	struct db8500_thermal_zone *pzone = NULL;
-	struct db8500_thsens_platform_data *ptrips = NULL;
+	struct db8500_thermal_zone *th = NULL;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	int low_irq, high_irq, ret = 0;
-	unsigned long dft_low, dft_high;
-
-	if (!np)
-		return -EINVAL;
 
-	ptrips = db8500_thermal_parse_dt(dev);
-	if (!ptrips)
-		return -EINVAL;
-
-	pzone = devm_kzalloc(dev, sizeof(*pzone), GFP_KERNEL);
-	if (!pzone)
+	th = devm_kzalloc(dev, sizeof(*th), GFP_KERNEL);
+	if (!th)
 		return -ENOMEM;
 
-	mutex_init(&pzone->th_lock);
-	mutex_lock(&pzone->th_lock);
-
-	pzone->mode = THERMAL_DEVICE_DISABLED;
-	pzone->trip_tab = ptrips;
-
-	INIT_WORK(&pzone->therm_work, db8500_thermal_work);
-
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
 	if (low_irq < 0) {
-		dev_err(dev, "Get IRQ_HOTMON_LOW failed.\n");
-		ret = low_irq;
-		goto out_unlock;
+		dev_err(dev, "Get IRQ_HOTMON_LOW failed\n");
+		return low_irq;
 	}
 
 	ret = devm_request_threaded_irq(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_low", pzone);
+		"dbx500_temp_low", th);
 	if (ret < 0) {
-		dev_err(dev, "Failed to allocate temp low irq.\n");
-		goto out_unlock;
+		dev_err(dev, "failed to allocate temp low irq\n");
+		return ret;
 	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0) {
-		dev_err(dev, "Get IRQ_HOTMON_HIGH failed.\n");
-		ret = high_irq;
-		goto out_unlock;
+		dev_err(dev, "Get IRQ_HOTMON_HIGH failed\n");
+		return high_irq;
 	}
 
 	ret = devm_request_threaded_irq(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_high", pzone);
+		"dbx500_temp_high", th);
 	if (ret < 0) {
-		dev_err(dev, "Failed to allocate temp high irq.\n");
-		goto out_unlock;
+		dev_err(dev, "failed to allocate temp high irq\n");
+		return ret;
 	}
 
-	pzone->therm_dev = thermal_zone_device_register("db8500_thermal_zone",
-		ptrips->num_trips, 0, pzone, &thdev_ops, NULL, 0, 0);
-
-	if (IS_ERR(pzone->therm_dev)) {
-		dev_err(dev, "Register thermal zone device failed.\n");
-		ret = PTR_ERR(pzone->therm_dev);
-		goto out_unlock;
+	/* register of thermal sensor and get info from DT */
+	th->tz = devm_thermal_zone_of_sensor_register(dev, 0, th, &thdev_ops);
+	if (IS_ERR(th->tz)) {
+		dev_err(dev, "register thermal zone sensor failed\n");
+		return PTR_ERR(th->tz);
 	}
-	dev_info(dev, "Thermal zone device registered.\n");
-
-	dft_low = PRCMU_DEFAULT_LOW_TEMP;
-	dft_high = ptrips->trip_points[0].temp;
+	dev_info(dev, "thermal zone sensor registered\n");
 
-	db8500_thermal_update_config(pzone, 0, THERMAL_TREND_STABLE,
-		dft_low, dft_high);
+	/* Start measuring at the lowest point */
+	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
+				     PRCMU_DEFAULT_LOW_TEMP,
+				     db8500_thermal_points[0]);
 
-	platform_set_drvdata(pdev, pzone);
-	pzone->mode = THERMAL_DEVICE_ENABLED;
-
-out_unlock:
-	mutex_unlock(&pzone->th_lock);
-
-	return ret;
-}
-
-static int db8500_thermal_remove(struct platform_device *pdev)
-{
-	struct db8500_thermal_zone *pzone = platform_get_drvdata(pdev);
-
-	thermal_zone_device_unregister(pzone->therm_dev);
-	cancel_work_sync(&pzone->therm_work);
-	mutex_destroy(&pzone->th_lock);
+	platform_set_drvdata(pdev, th);
 
 	return 0;
 }
@@ -478,9 +222,6 @@ static int db8500_thermal_remove(struct platform_device *pdev)
 static int db8500_thermal_suspend(struct platform_device *pdev,
 		pm_message_t state)
 {
-	struct db8500_thermal_zone *pzone = platform_get_drvdata(pdev);
-
-	flush_work(&pzone->therm_work);
 	prcmu_stop_temp_sense();
 
 	return 0;
@@ -488,15 +229,12 @@ static int db8500_thermal_suspend(struct platform_device *pdev,
 
 static int db8500_thermal_resume(struct platform_device *pdev)
 {
-	struct db8500_thermal_zone *pzone = platform_get_drvdata(pdev);
-	struct db8500_thsens_platform_data *ptrips = pzone->trip_tab;
-	unsigned long dft_low, dft_high;
-
-	dft_low = PRCMU_DEFAULT_LOW_TEMP;
-	dft_high = ptrips->trip_points[0].temp;
+	struct db8500_thermal_zone *th = platform_get_drvdata(pdev);
 
-	db8500_thermal_update_config(pzone, 0, THERMAL_TREND_STABLE,
-		dft_low, dft_high);
+	/* Resume and start measuring at the lowest point */
+	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
+				     PRCMU_DEFAULT_LOW_TEMP,
+				     db8500_thermal_points[0]);
 
 	return 0;
 }
@@ -515,7 +253,6 @@ static struct platform_driver db8500_thermal_driver = {
 	.probe = db8500_thermal_probe,
 	.suspend = db8500_thermal_suspend,
 	.resume = db8500_thermal_resume,
-	.remove = db8500_thermal_remove,
 };
 
 module_platform_driver(db8500_thermal_driver);
-- 
2.21.0

