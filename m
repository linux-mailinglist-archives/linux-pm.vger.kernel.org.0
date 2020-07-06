Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67C62155F1
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgGFK4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgGFKz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 06:55:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030A8C08C5E0
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 03:55:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so40289239wru.6
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MVypmi71Dmf+RY1EGrYfGpqxbkUO2RDrxw6hcKGS1N4=;
        b=JaKxMFgyyBkf5gYq0b5/zTBzs94CGV9HlYPx3UA6imzhs8YehgPObqiau2XM4OBdra
         xF3yLgmCxhPZWMqkBCOdf6dE5PqWTZ+5d0XtkVOYrlar0kzmCI+5eddsHfT9l+bt+Jjg
         r7X2KiL+DzBm5wQJtqNMczbKbbxvF3hHEcHTRZYyC0WMgzrpNHaE6kBZFhikLVs833Ws
         TQKVbWG+pqxqHZnDxauqMyWcHhb/fhKaUoG2PmAxAmEx5mNFg1bH1XOGeHW7hVc7pQ2/
         MsOr/01kzdJzz9hFUPLaX9CtyvHjGYDzpTMQFK9K9QfdtscoJO5WzYuThbtr7ExdMIyy
         kiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MVypmi71Dmf+RY1EGrYfGpqxbkUO2RDrxw6hcKGS1N4=;
        b=rz0Vs5h4h2QhvXSShr7stzNUz4XC+vhczFbYUqpiwUkFVFPNs78mIQeQonWdDZn2H5
         0ONrMgh6+h3GSiQ1KNZDRpJDjh59a+Y9P1tn61WukwAIbUbqlzQbJgMhd7wbhgdzA/pO
         3shzlJHAMROY0r/UoaQUXCVW+Y3ekw+T9ylUlkQK8unMRM29YeROyp/0JB1cleNVF7CB
         O4EkCzFgp85dCFLbEITRIRU/KV469RWz0exQw69y+ZfT/p7v0d3+4vogobcV+zs9eEbZ
         vweZrJyXcM+BKWlf55AA15NC9xuMoc555ZxReyz++kQBiq0waOpdFpK4pviBfO8Ifmvz
         PcBQ==
X-Gm-Message-State: AOAM530sqjpJuXcuaKt5SiKbpezJ01EYN2UVtwJNn4Gh0Kw5xzemugjT
        l/ZfVnG9kREnwZSOkkj8VoA3tQ==
X-Google-Smtp-Source: ABdhPJyjRNXV3mKfvPWqqJ2KxN4UYYzFNSF4cDvxbFVOjEGKkug0czLH6xH0HRdBUc7KVrOMIlEAMQ==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr46005945wrv.289.1594032955635;
        Mon, 06 Jul 2020 03:55:55 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id a22sm22931481wmj.9.2020.07.06.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:55:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 4/4] thermal: core: Add notifications call in the framework
Date:   Mon,  6 Jul 2020 12:55:38 +0200
Message-Id: <20200706105538.2159-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706105538.2159-1-daniel.lezcano@linaro.org>
References: <20200706105538.2159-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic netlink protocol is implemented but the different
notification functions are not yet connected to the core code.

These changes add the notification calls in the different
corresponding places.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
  v4:
     - Fixed missing static declaration, reported by kbuild-bot
     - Removed max state notification
---
 drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
 drivers/thermal/thermal_helpers.c | 13 +++++++++++--
 drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5fae1621fb01..25ef29123f72 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 	mutex_unlock(&thermal_governor_lock);
 
+	thermal_notify_tz_gov_change(tz->id, policy);
+
 	return ret;
 }
 
@@ -406,12 +408,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
+	int trip_temp, hyst = 0;
 
 	/* Ignore disabled trip points */
 	if (test_bit(trip, &tz->trips_disabled))
 		return;
 
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 	tz->ops->get_trip_type(tz, trip, &type);
+	if (tz->ops->get_trip_hyst)
+		tz->ops->get_trip_hyst(tz, trip, &hyst);
+
+	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
+		if (tz->last_temperature < trip_temp &&
+		    tz->temperature >= trip_temp)
+			thermal_notify_tz_trip_up(tz->id, trip);
+		if (tz->last_temperature >= trip_temp &&
+		    tz->temperature < (trip_temp - hyst))
+			thermal_notify_tz_trip_down(tz->id, trip);
+	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
@@ -443,6 +458,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
+
+	thermal_genl_sampling_temp(tz->id, temp);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
@@ -1405,6 +1422,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+	thermal_notify_tz_create(tz->id, tz->type);
+
 	return tz;
 
 unregister:
@@ -1476,6 +1495,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
+
+	thermal_notify_tz_delete(tz->id);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 87b1256fa2f2..c94bc824e5d3 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -175,6 +175,16 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
+				       int target)
+{
+	if (cdev->ops->set_cur_state(cdev, target))
+		return;
+
+	thermal_notify_cdev_state_update(cdev->id, target);
+	thermal_cooling_device_stats_update(cdev, target);
+}
+
 void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
@@ -197,8 +207,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 			target = instance->target;
 	}
 
-	if (!cdev->ops->set_cur_state(cdev, target))
-		thermal_cooling_device_stats_update(cdev, target);
+	thermal_cdev_set_cur_state(cdev, target);
 
 	cdev->updated = true;
 	mutex_unlock(&cdev->lock);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb4dff7..ff449943f757 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -124,7 +124,8 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int trip, ret;
-	int temperature;
+	int temperature, hyst = 0;
+	enum thermal_trip_type type;
 
 	if (!tz->ops->set_trip_temp)
 		return -EPERM;
@@ -139,6 +140,18 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	if (tz->ops->get_trip_hyst) {
+		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
+		if (ret)
+			return ret;
+	}
+
+	ret = tz->ops->get_trip_type(tz, trip, &type);
+	if (ret)
+		return ret;
+
+	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
+
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return count;
-- 
2.17.1

