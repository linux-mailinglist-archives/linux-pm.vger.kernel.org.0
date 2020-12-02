Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CDD2CBC6A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 13:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgLBMH7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 07:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLBMH6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 07:07:58 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A78C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 04:07:18 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so3638736wrt.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 04:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N0N1NFLUe7mxMhyhl9qWKG4HrWaDY+W8Cz0CyGfPy4Y=;
        b=hSy6vvc42xNZgz4wWHl4kIJ+4OtfVSy0bjNkPEsCHY7lkrmWhUTff/ezw9mjHlNCKr
         t+rkZjQqnEiCo5wNH+vr5CldwI8jrVbaAMmnQeTL1q7lHyCx4KDEQsZlY2ZE/Omw9NH/
         tHC/ZmcGiInHlFExLX5uGdEma5XwrG0JKZgzxTdYn7kDvHTOB5NKE+YYxU9UMAJsPi/1
         ELCm3Jd8nXlmbb7qnJIUYxnz29vzWVaVt1MF4ORXtIWv1mfi4GFFw5SwhtqfK+xJzXic
         fEku5zdiQpniSw8ymr+vP1JJjUJvC5JIRAhvdYWBFkO4JFd1Aef0rEf8/W0TgXpPtqOj
         nh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N0N1NFLUe7mxMhyhl9qWKG4HrWaDY+W8Cz0CyGfPy4Y=;
        b=RuIcf7tQyFVIQVynv9QpFU+Nq13qWZofEhnXtuiHazcfWfGTh+iInklj2OOWXpglak
         PWzhNEbaWrTjNgY8+7yoHW0peow86OCQDYYkJwptuX8R5dUptmnuYGh5QvHr7iGMQ7RD
         XHVneFk3UFh7GTVEoz5gMLIzrhSIeXbZyIolHMl1ISWTdtMGU7JGcdRkmZW3SwtmU3Ps
         Q3uReqIEHE0LC0lZLrITL/RFC8NJ2fXXUxAtJJuWhZMK4htojyt7cqLlrhw6f8sauWC0
         kh16IhpajcHMCxogSYa8yDlz37jWi5IOr7NYRdlRFL4JOo9lEpxVlMzQkHX1wvhGtXtN
         GKNw==
X-Gm-Message-State: AOAM530fUrujgWxjwo/yFRnVDha41aWo2k+oLwNefrS1k2CWFu0mAo3S
        jrrwi5P7s3p62WgnZdnHprlEaw==
X-Google-Smtp-Source: ABdhPJx86cxBM9BKeDFB0Z8T50befSXGthi4QGt1wI9arwTytWwW982hrDf9Cob/3fi6dEhpP37FxA==
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr3036168wrs.75.1606910836890;
        Wed, 02 Dec 2020 04:07:16 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id c1sm1755132wml.8.2020.12.02.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:07:16 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/4] thermal/core: Rename passive_delay and polling_delay with units
Date:   Wed,  2 Dec 2020 13:06:54 +0100
Message-Id: <20201202120657.1969-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the scene to directly store the delays under their jiffies
form. Add to the variable name the 'ms' suffix.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c  | 10 +++++-----
 drivers/thermal/thermal_of.c    |  8 ++++----
 drivers/thermal/thermal_sysfs.c |  6 +++---
 include/linux/thermal.h         |  8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 90e38cc199f4..53f55ceca220 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -317,9 +317,9 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 	mutex_lock(&tz->lock);
 
 	if (!stop && tz->passive)
-		thermal_zone_device_set_polling(tz, tz->passive_delay);
-	else if (!stop && tz->polling_delay)
-		thermal_zone_device_set_polling(tz, tz->polling_delay);
+		thermal_zone_device_set_polling(tz, tz->passive_delay_ms);
+	else if (!stop && tz->polling_delay_ms)
+		thermal_zone_device_set_polling(tz, tz->polling_delay_ms);
 	else
 		thermal_zone_device_set_polling(tz, 0);
 
@@ -1340,8 +1340,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->device.class = &thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
-	tz->passive_delay = passive_delay;
-	tz->polling_delay = polling_delay;
+	tz->passive_delay_ms = passive_delay;
+	tz->polling_delay_ms = polling_delay;
 
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 69ef12f852b7..ebec4a8a8b5a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -865,14 +865,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 		pr_err("%pOFn: missing polling-delay-passive property\n", np);
 		goto free_tz;
 	}
-	tz->passive_delay = prop;
+	tz->passive_delay_ms = prop;
 
 	ret = of_property_read_u32(np, "polling-delay", &prop);
 	if (ret < 0) {
 		pr_err("%pOFn: missing polling-delay property\n", np);
 		goto free_tz;
 	}
-	tz->polling_delay = prop;
+	tz->polling_delay_ms = prop;
 
 	/*
 	 * REVIST: for now, the thermal framework supports only
@@ -1085,8 +1085,8 @@ int __init of_parse_thermal_zones(void)
 		zone = thermal_zone_device_register(child->name, tz->ntrips,
 						    mask, tz,
 						    ops, tzp,
-						    tz->passive_delay,
-						    tz->polling_delay);
+						    tz->passive_delay_ms,
+						    tz->polling_delay_ms);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 0866e949339b..f465462d8aa1 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -233,12 +233,12 @@ passive_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (state && !tz->forced_passive) {
-		if (!tz->passive_delay)
-			tz->passive_delay = 1000;
+		if (!tz->passive_delay_ms)
+			tz->passive_delay_ms = 1000;
 		thermal_zone_device_rebind_exception(tz, "Processor",
 						     sizeof("Processor"));
 	} else if (!state && tz->forced_passive) {
-		tz->passive_delay = 0;
+		tz->passive_delay_ms = 0;
 		thermal_zone_device_unbind_exception(tz, "Processor",
 						     sizeof("Processor"));
 	}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d07ea27e72a9..230d451bf335 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -116,9 +116,9 @@ struct thermal_cooling_device {
  * @devdata:	private pointer for device private data
  * @trips:	number of trip points the thermal zone supports
  * @trips_disabled;	bitmap for disabled trips
- * @passive_delay:	number of milliseconds to wait between polls when
+ * @passive_delay_ms:	number of milliseconds to wait between polls when
  *			performing passive cooling.
- * @polling_delay:	number of milliseconds to wait between polls when
+ * @polling_delay_ms:	number of milliseconds to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
  * @temperature:	current temperature.  This is only for core code,
@@ -159,8 +159,8 @@ struct thermal_zone_device {
 	void *devdata;
 	int trips;
 	unsigned long trips_disabled;	/* bitmap for disabled trips */
-	int passive_delay;
-	int polling_delay;
+	int passive_delay_ms;
+	int polling_delay_ms;
 	int temperature;
 	int last_temperature;
 	int emul_temperature;
-- 
2.17.1

