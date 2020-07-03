Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3492136B9
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGCIxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGCIxd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 04:53:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654BC08C5C1
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 01:53:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so31765971wrj.13
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2020 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PL/penV/ZO3kTU77ykwxWiCiuBlDQW/6RJa7iDr042A=;
        b=LGoRJwoDZmF3GsFEItP6ktcJCoqABrhYcV9q2OzyQQ9UicqU91xKC/uNdYhbM8EHwW
         UhW4VZprObr1W1ycpGSa1AVZdtOAdMZx5ZdVrA385FcW0Io2o7rn6WJTuNR07jyKwnVP
         A+pgKlLTVD3qkkt29LQcy1Uq0Ii8FcbJq9Oeo9e7IzZjhgLOhcFBcpwZZ6akEn9NfJd/
         Yn9flgcJiQACzbk3kRWZyGRjWII0dikw4c6nuG0Sn6Ok0i4b9lrHwp25/PsQWHOWZYrk
         9uGySXekisLidI0QUdTmT0zn6NDIZNK4dnlyplcXepQ3PdVvVJDpgnE49q8YGsGwzcIH
         mM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PL/penV/ZO3kTU77ykwxWiCiuBlDQW/6RJa7iDr042A=;
        b=AzWR19CR2Jgd2t/WpOF5KcPdepJZ979ZroJ3XcWcHOUOBO2gLQS4CFLDA1XUXxBT9C
         hMNfcMh0oUdiwlGTq1ED0uqpOeW7ssjM5gTf3Ds3jT/Z5v1R4vcGc9rHd7hF0XsqDjRV
         pMb94dFkFiRdchUv5v9RBlfZYFrwWquNZdU6MxIo8LO5su9CFANb20FZ7WyL9+u8qO7k
         rNQacvH0JTFnzA7ur1WN4rqUBmuN6267RlpofeVOC+HVYOXGJRDNRMmCPSSLkyzYDIRy
         2ivRs2HW4ylPyEpZUwP8VwsEPmAnfjE5TDeWlfwoOudMw4eEJhDE8RYY1puHFvSs1I44
         rKhg==
X-Gm-Message-State: AOAM533GanwRjv3sH29a8Tti6srfLGmT0MhI81WPcYzx/P1Nin0EUfF0
        zgGwAiJKawIjfM7qfLhwJOW5Jw==
X-Google-Smtp-Source: ABdhPJxG0FB2gS9d2RLx7msGsOfNJuIU9VDmNlRDjcC7yTcpyeKfmSqvfs5pfBpuVKY+3Ape51cgVw==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr34993567wrp.268.1593766412125;
        Fri, 03 Jul 2020 01:53:32 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id z6sm12543611wmf.33.2020.07.03.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:53:31 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 4/4] thermal: core: Add notifications call in the framework
Date:   Fri,  3 Jul 2020 10:53:09 +0200
Message-Id: <20200703085309.32166-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200703085309.32166-1-daniel.lezcano@linaro.org>
References: <20200703085309.32166-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic netlink protocol is implemented but the different
notification functions are not yet connected to the core code.

These changes add the notification calls in the different
corresponding places.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
 drivers/thermal/thermal_helpers.c | 11 +++++++++--
 drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
 3 files changed, 44 insertions(+), 3 deletions(-)

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
index 87b1256fa2f2..53dd92ccfd19 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -175,6 +175,14 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int target)
+{
+	if (cdev->ops->set_cur_state(cdev, target))
+		return;
+	thermal_notify_cdev_update(cdev->id, target);
+	thermal_cooling_device_stats_update(cdev, target);
+}
+
 void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
@@ -197,8 +205,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
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

