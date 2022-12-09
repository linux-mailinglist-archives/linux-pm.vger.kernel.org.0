Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81D648559
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLIP1c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLIP0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3B9231A
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:39 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFsGnHFj/6ZUZMF9En/4gYOsnSi3JmPA4cCryaKuJ5o=;
        b=1ipkJF5biWY7RaC3vs64/qlrZ5czXGLsiJRk6zkvgBSXo2B1FYGEW5WAb8V17tTgJZ+hfK
        O68M6BM6+gTgZnNlM5WI5rNQMBl7BhleUMOmhV+jAHfhBx+15brk5f/DHJuQwWWBHEx4Of
        od3lf4Z7ll9vjW6LPJijiUzqGmK6slp4/MqOHOHevJOQiH/9T8cHSNNSy8QS5Nj5zDIEpv
        /rwroN67+9N35hV13NLPajrCTfWvCNLot6Ak5HuygLrc8cFALIW/uV3P4k2bSMRVnE8vpb
        6XXeYbeUZ4V8VhjUTTyGNfChH1NJ6/xdr8nuEKQxHIPu7v8JGs+NSZ0ZqzaD2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFsGnHFj/6ZUZMF9En/4gYOsnSi3JmPA4cCryaKuJ5o=;
        b=odBPn6C1e+UU7XMK/HWDVX/QPg0LBt6xLvC6LBNvOS1CElj+Zv++xXItSWkPv+/ZiLnHM6
        8pmDtErpfomhF/Dg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Add a generic
 thermal_zone_set_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221003092602.1323944-4-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959620.4906.5493009691754502824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3ab3c603e6dd30b9ff4d73e4b48b68dff1b82163
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3ab3c603e6dd30b9ff4d73e4b48b68dff1b82163
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:36 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/core: Add a generic thermal_zone_set_trip() function

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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20221003092602.1323944-4-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_core.c  | 39 ++++++++++++++++++++++-
 drivers/thermal/thermal_sysfs.c | 56 ++++++++------------------------
 include/linux/thermal.h         |  3 ++-
 3 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b043c31..c24c9ef 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1228,6 +1228,45 @@ int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip)
+{
+	struct thermal_trip t;
+	int ret;
+
+	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
+		return -EINVAL;
+
+	ret = __thermal_zone_get_trip(tz, trip_id, &t);
+	if (ret)
+		return ret;
+
+	if (t.type != trip->type)
+		return -EINVAL;
+
+	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
+		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
+		if (ret)
+			return ret;
+	}
+
+	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
+		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
+		if (ret)
+			return ret;
+	}
+
+	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
+		tz->trips[trip_id] = *trip;
+
+	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
+				      trip->temperature, trip->hysteresis);
+
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	
+	return 0;
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d2d4500..cef860d 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -123,15 +123,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
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
 	mutex_lock(&tz->lock);
 
 	if (!device_is_registered(dev)) {
@@ -139,31 +133,19 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 		goto unlock;
 	}
 
-	if (tz->ops->set_trip_temp) {
-		ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
-		if (ret)
-			goto unlock;
-	}
-
-	if (tz->trips)
-		tz->trips[trip_id].temperature = trip.temperature;
-
 	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		goto unlock;
 
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
-				      trip.temperature, trip.hysteresis);
-
-	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	ret = kstrtoint(buf, 10, &trip.temperature);
+	if (ret)
+		goto unlock;
 
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 unlock:
 	mutex_unlock(&tz->lock);
-
-	if (ret)
-		return ret;
-
-	return count;
+	
+	return ret ? ret : count;
 }
 
 static ssize_t
@@ -197,16 +179,13 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
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
+	if (kstrtoint(buf, 10, &trip.hysteresis))
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
@@ -216,16 +195,11 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 		goto unlock;
 	}
 
-	/*
-	 * We are not doing any check on the 'temperature' value
-	 * here. The driver implementing 'set_trip_hyst' has to
-	 * take care of this.
-	 */
-	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
-
-	if (!ret)
-		__thermal_zone_set_trips(tz);
-
+	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		goto unlock;
+	
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 unlock:
 	mutex_unlock(&tz->lock);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2198b36..e2797f3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -337,6 +337,9 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip);
+
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
