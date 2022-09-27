Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAEA5EC63B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 16:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiI0Od3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiI0Oc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 10:32:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6AC1B7B2
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:32:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so5584204wmb.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3w6X3JVNiKRT92+QAllo+YG55ME/ZdTJyQvYR7P+Hfw=;
        b=cYwgiJAHe/0IkU2M60Yp+bXKCacT5PgoaC9VTThNoMCWZNB2dQDTlqkY5WqEjTuXBf
         NuGXS53zWl4NHL2deymMefp50WyFJ63YJrSJgGOtRe9g2VQ2MSrr1wHdsZkmzOmZJKpa
         z/BBd9IJq+paC9e29Tf9ScWnisxXLLIfJIvaQnxPesry7HvhkzcdYCXgOqu6v2ukjTyU
         Q47Ew6zD6TMv2vqbXbur2zkAMCi5ST3vDv/LKPoY37qfVm4zH9YX3uZVX7RczhL1Bpnt
         nbjHOxpV1GIQ6Q69foGi1cWd6cmx1W+OWYr44J7Z6LqUG1h01pyY8kdKYQlG61/14BX5
         eDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3w6X3JVNiKRT92+QAllo+YG55ME/ZdTJyQvYR7P+Hfw=;
        b=x0t2tJDjGFVIHkShkk365X1o1FLHa+mh1pEUeMtkMbYaqE+9ZFEOeCB7KvQD7S58++
         iyTrvFV8KuVOneRqF3BrDYbP1qPpK9usTsFsykY5l3Iar1FGs7/8YfUNJxsSzNDkS35J
         XX5kUZMiHypvEdmDawjIIBLmXdvB884ZiDqKgVkLCQn2pxeiujzuWbN2EWgEFFT4KWgn
         nQXOQxdYdOURrO1AQG6oIhSUMSX5KlUDyMeYiDMcQQpY6+Ev6DGwadu5YqM/J3OwFlpW
         /s31Vg7gPLbQo+xUqO22xTyi4GNz1Nzqj+4PY1xksViRlUmmDrFMMuoeY6mtGDJ5Bnyt
         VipQ==
X-Gm-Message-State: ACrzQf0ER1I7bZaa8Tc/cILjjo0CiJYauUxKVa/L+r1cI2OXmaMgbDto
        8poTrrZMFiY2ShOCq1+3ZPRBKUZtl3sB+A==
X-Google-Smtp-Source: AMsMyM7KhIR6hjdotuF7AYhgEcxqJbh67r/Xgo04t90gjlCM9UBbRUsz3EMpm38qQirpl4lRojkb9w==
X-Received: by 2002:a05:600c:1e13:b0:3b4:74c3:620b with SMTP id ay19-20020a05600c1e1300b003b474c3620bmr3025587wmb.168.1664289174593;
        Tue, 27 Sep 2022 07:32:54 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:32:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 03/29] thermal/core: Add a generic thermal_zone_set_trip() function
Date:   Tue, 27 Sep 2022 16:32:13 +0200
Message-Id: <20220927143239.376737-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal zone ops defines a set_trip callback where we can invoke
the backend driver to set an interrupt for the next trip point
temperature being crossed the way up or down, or setting the low level
with the hysteresis.

The ops is only called from the thermal sysfs code where the userspace
has the ability to modify a trip point characteristic.

With the effort of encapsulating the thermal framework core code,
let's create a thermal_zone_set_trip() which is the writable side of
the thermal_zone_get_trip() and put there all the ops encapsulation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c  | 47 +++++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c | 52 +++++++++++----------------------
 include/linux/thermal.h         |  3 ++
 3 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 16ef91dc102f..2675671781cd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1211,6 +1211,53 @@ int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip)
+{
+	struct thermal_trip t;
+	int ret = -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
+		goto out;
+
+	ret = __thermal_zone_get_trip(tz, trip_id, &t);
+	if (ret)
+		goto out;
+
+	if (t.type != trip->type) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
+		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
+		if (ret)
+			goto out;
+	}
+
+	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
+		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
+		if (ret)
+			goto out;
+	}
+
+	if (tz->trips && ((t.temperature != trip->temperature) ||
+			  (t.hysteresis != trip->hysteresis)))
+		tz->trips[trip_id] = *trip;
+out:
+	mutex_unlock(&tz->lock);
+
+	if (!ret) {
+		thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
+					      trip->temperature, trip->hysteresis);
+		thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	}
+
+	return ret;
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 6c45194aaabb..8d7b25ab67c2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -115,32 +115,19 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	struct thermal_trip trip;
 	int trip_id, ret;
 
-	if (!tz->ops->set_trip_temp && !tz->trips)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &trip.temperature))
-		return -EINVAL;
-
-	if (tz->ops->set_trip_temp) {
-		ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
-		if (ret)
-			return ret;
-	}
-
-	if (tz->trips)
-		tz->trips[trip_id].temperature = trip.temperature;
-
 	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
-				      trip.temperature, trip.hysteresis);
+	if (kstrtoint(buf, 10, &trip.temperature))
+		return -EINVAL;
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
 	return count;
 }
@@ -168,29 +155,24 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip, ret;
-	int temperature;
-
-	if (!tz->ops->set_trip_hyst)
-		return -EPERM;
+	struct thermal_trip trip;
+	int trip_id, ret;
 
-	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &temperature))
-		return -EINVAL;
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	/*
-	 * We are not doing any check on the 'temperature' value
-	 * here. The driver implementing 'set_trip_hyst' has to
-	 * take care of this.
-	 */
-	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
+	if (kstrtoint(buf, 10, &trip.hysteresis))
+		return -EINVAL;
 
-	if (!ret)
-		thermal_zone_set_trips(tz);
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index feb8b61df746..66373f872237 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -338,6 +338,9 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip);
+
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
-- 
2.34.1

