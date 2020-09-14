Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26242268589
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 09:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgINHLq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 03:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgINHLp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 03:11:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D22C06174A;
        Mon, 14 Sep 2020 00:11:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so11843062pfi.4;
        Mon, 14 Sep 2020 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7N/PmwNPxp4BkLvHmN/1LOiA1C9sbfjSm26pD91k4wc=;
        b=maLgvjwkaubbSe4eJOjAnPDyEOw5DnQdjhL8v5Z9oCWMVDDl0uriBZmzG6Z5cgcijC
         EbrZHOZXU9DsDGIqyaWQF0E4zVQJDY9QBm7oRhY9fTJT0fZSLBj+n/KXuihk5293QFeO
         otDHf0Djhmmi80h5xXzYRRggi0iXIsfQXXJaOIb6RsqGeWpkTRpauzcrgGkIPzXHQVJ5
         ukjeFVOqbiyD6PZWLlFFEV7SUARmJSB905ntJHkO5LX0VbS6QRV7UTRtpe5wppJwVeG9
         vSHgC5Zx3jTaTEH7osfdJLBGg1O7/WryNW2HifmnXMZ6DJ2ADs+wL2SQN9s7BqpWfDEv
         mS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7N/PmwNPxp4BkLvHmN/1LOiA1C9sbfjSm26pD91k4wc=;
        b=hWSebScvfNIe2v7ZY38dDuBbBKGf6+CfOFmXH5sbpN0/JXvl5OBmWNyGMOjiysgfZ1
         l1BYHinlhgPo+bUKRAVrXEnkpu3LhlcVjkQlaqYfSNoT0SFHUzL6OOi4Fa5BjexVd43e
         GD79+7j+AW0+hIv32EGDLrudzWg7yGs4SYIMq5f2+fEe86jAK41V0uGJGJ86+yHI0nWy
         /WRLWppfeTDLwodXbs85oc324t+rcRer2/PAUpRNTG09G/l2u9v/eymXTDIhCAQm1RCs
         aCdmuZYRzUDBSz+p3Z6YX4UCU3W1ADiwYssJHAkGzb0a6d75PgUh+95sOzd3F2FcUPD3
         c/Cg==
X-Gm-Message-State: AOAM531JIy0dCngB6aOGXhnwkac0t4dP/ESE7JQNCeo31HIr6Qgaf3b+
        mes3lbzqhs2kLrk/RCQq9HI=
X-Google-Smtp-Source: ABdhPJxz09lA1lAoBVoLLzEQCHG5/2e1h3CH2m/duUKF1bISI9RjjtPDZC/h+aaDBOmAMZvcMS0QXg==
X-Received: by 2002:a17:902:8491:b029:d1:9bd3:6653 with SMTP id c17-20020a1709028491b02900d19bd36653mr13449959plo.1.1600067504696;
        Mon, 14 Sep 2020 00:11:44 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id l7sm7518885pjz.56.2020.09.14.00.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 00:11:44 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, lukasz.luba@arm.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing@xiaomi.com
Subject: [PATCH] thermal: cooling: Remove unused variable *tz
Date:   Mon, 14 Sep 2020 15:11:01 +0800
Message-Id: <20200914071101.13575-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zhuguangqing <zhuguangqing@xiaomi.com>

1. devfreq_cooling.c: The variable *tz is not used in
devfreq_cooling_get_requested_power(), devfreq_cooling_state2power()
and devfreq_cooling_power2state().

2. cpufreq_cooling.c: After 84fe2cab48590, the variable *tz is not used
anymore in cpufreq_get_requested_power(), cpufreq_state2power() and
cpufreq_power2state().

Remove the variable *tz.

Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
---
 drivers/thermal/cpufreq_cooling.c     |  8 +-------
 drivers/thermal/devfreq_cooling.c     |  3 ---
 drivers/thermal/gov_power_allocator.c |  6 +++---
 drivers/thermal/thermal_core.c        | 12 +++++-------
 drivers/thermal/thermal_core.h        |  4 ++--
 include/linux/thermal.h               |  9 +++------
 6 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 6cf23a54e853..cc2959f22f01 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -182,7 +182,6 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
 /**
  * cpufreq_get_requested_power() - get the current power
  * @cdev:	&thermal_cooling_device pointer
- * @tz:		a valid thermal zone device pointer
  * @power:	pointer in which to store the resulting power
  *
  * Calculate the current power consumption of the cpus in milliwatts
@@ -203,7 +202,6 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
  * Return: 0 on success, -E* if getting the static power failed.
  */
 static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
-				       struct thermal_zone_device *tz,
 				       u32 *power)
 {
 	unsigned long freq;
@@ -253,7 +251,6 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 /**
  * cpufreq_state2power() - convert a cpu cdev state to power consumed
  * @cdev:	&thermal_cooling_device pointer
- * @tz:		a valid thermal zone device pointer
  * @state:	cooling device state to be converted
  * @power:	pointer in which to store the resulting power
  *
@@ -266,7 +263,6 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
  * when calculating the static power.
  */
 static int cpufreq_state2power(struct thermal_cooling_device *cdev,
-			       struct thermal_zone_device *tz,
 			       unsigned long state, u32 *power)
 {
 	unsigned int freq, num_cpus, idx;
@@ -288,7 +284,6 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 /**
  * cpufreq_power2state() - convert power to a cooling device state
  * @cdev:	&thermal_cooling_device pointer
- * @tz:		a valid thermal zone device pointer
  * @power:	power in milliwatts to be converted
  * @state:	pointer in which to store the resulting state
  *
@@ -306,8 +301,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
  * device.
  */
 static int cpufreq_power2state(struct thermal_cooling_device *cdev,
-			       struct thermal_zone_device *tz, u32 power,
-			       unsigned long *state)
+			       u32 power, unsigned long *state)
 {
 	unsigned int target_freq;
 	u32 last_load, normalised_power;
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index a12d29096229..dfab49a67252 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -229,7 +229,6 @@ static inline unsigned long get_total_power(struct devfreq_cooling_device *dfc,
 
 
 static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cdev,
-					       struct thermal_zone_device *tz,
 					       u32 *power)
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
@@ -289,7 +288,6 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 }
 
 static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
-				       struct thermal_zone_device *tz,
 				       unsigned long state,
 				       u32 *power)
 {
@@ -308,7 +306,6 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
 }
 
 static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
-				       struct thermal_zone_device *tz,
 				       u32 power, unsigned long *state)
 {
 	struct devfreq_cooling_device *dfc = cdev->devdata;
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 5cb518d8f156..ab0be26f0816 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -96,7 +96,7 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 		if (instance->trip != params->trip_max_desired_temperature)
 			continue;
 
-		if (power_actor_get_min_power(cdev, tz, &min_power))
+		if (power_actor_get_min_power(cdev, &min_power))
 			continue;
 
 		sustainable_power += min_power;
@@ -388,7 +388,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 		if (!cdev_is_power_actor(cdev))
 			continue;
 
-		if (cdev->ops->get_requested_power(cdev, tz, &req_power[i]))
+		if (cdev->ops->get_requested_power(cdev, &req_power[i]))
 			continue;
 
 		if (!total_weight)
@@ -398,7 +398,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 
 		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
 
-		if (power_actor_get_max_power(cdev, tz, &max_power[i]))
+		if (power_actor_get_max_power(cdev, &max_power[i]))
 			continue;
 
 		total_req_power += req_power[i];
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a6616e530a84..85cdba7f7b3e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -603,7 +603,6 @@ static void thermal_zone_device_check(struct work_struct *work)
 /**
  * power_actor_get_max_power() - get the maximum power that a cdev can consume
  * @cdev:	pointer to &thermal_cooling_device
- * @tz:		a valid thermal zone device pointer
  * @max_power:	pointer in which to store the maximum power
  *
  * Calculate the maximum power consumption in milliwats that the
@@ -613,18 +612,17 @@ static void thermal_zone_device_check(struct work_struct *work)
  * power_actor API or -E* on other error.
  */
 int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *max_power)
+			      u32 *max_power)
 {
 	if (!cdev_is_power_actor(cdev))
 		return -EINVAL;
 
-	return cdev->ops->state2power(cdev, tz, 0, max_power);
+	return cdev->ops->state2power(cdev, 0, max_power);
 }
 
 /**
  * power_actor_get_min_power() - get the mainimum power that a cdev can consume
  * @cdev:	pointer to &thermal_cooling_device
- * @tz:		a valid thermal zone device pointer
  * @min_power:	pointer in which to store the minimum power
  *
  * Calculate the minimum power consumption in milliwatts that the
@@ -634,7 +632,7 @@ int power_actor_get_max_power(struct thermal_cooling_device *cdev,
  * power_actor API or -E* on other error.
  */
 int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *min_power)
+			      u32 *min_power)
 {
 	unsigned long max_state;
 	int ret;
@@ -646,7 +644,7 @@ int power_actor_get_min_power(struct thermal_cooling_device *cdev,
 	if (ret)
 		return ret;
 
-	return cdev->ops->state2power(cdev, tz, max_state, min_power);
+	return cdev->ops->state2power(cdev, max_state, min_power);
 }
 
 /**
@@ -670,7 +668,7 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	if (!cdev_is_power_actor(cdev))
 		return -EINVAL;
 
-	ret = cdev->ops->power2state(cdev, instance->tz, power, &state);
+	ret = cdev->ops->power2state(cdev, power, &state);
 	if (ret)
 		return ret;
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index e00fc5585ea8..764c2de31771 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -66,9 +66,9 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 }
 
 int power_actor_get_max_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *max_power);
+			      u32 *max_power);
 int power_actor_get_min_power(struct thermal_cooling_device *cdev,
-			      struct thermal_zone_device *tz, u32 *min_power);
+			      u32 *min_power);
 int power_actor_set_power(struct thermal_cooling_device *cdev,
 			  struct thermal_instance *ti, u32 power);
 /**
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 42ef807e5d84..00612e233d20 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -84,12 +84,9 @@ struct thermal_cooling_device_ops {
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
-	int (*get_requested_power)(struct thermal_cooling_device *,
-				   struct thermal_zone_device *, u32 *);
-	int (*state2power)(struct thermal_cooling_device *,
-			   struct thermal_zone_device *, unsigned long, u32 *);
-	int (*power2state)(struct thermal_cooling_device *,
-			   struct thermal_zone_device *, u32, unsigned long *);
+	int (*get_requested_power)(struct thermal_cooling_device *, u32 *);
+	int (*state2power)(struct thermal_cooling_device *, unsigned long, u32 *);
+	int (*power2state)(struct thermal_cooling_device *, u32, unsigned long *);
 };
 
 struct thermal_cooling_device {
-- 
2.17.1

