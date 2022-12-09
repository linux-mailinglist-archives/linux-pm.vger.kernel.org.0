Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231EC648568
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiLIP1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiLIP0s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1668D195
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:41 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N6ppYlM8LNw0f7kGBIy27Fc0Po5JViwaGk3Ei9mJ9+c=;
        b=NbCQ2R+4apjTgqAr3hCTS1sTJtdjn/LCCZUqDPK36hYJf8noUOyO5W/z6n4SQb5JyFv5EE
        6hsfLkYssR/5zCqkNJ0acZLR0Mugvbo3cgjGxt9KXkawotZyHM7aY7iTx/foqbc6fBbLuK
        eBNNEP89AzdP9G1QoU9bFwJ9HtRkiYRnT6PCj3km1M1NO5BxlJKCKFqHbMfG2FReqNyrhH
        A2+CQOLHDVTlfjBynfiTbqEkiyES7yYPZutAGxVpfTCXLoIni3usxKee9ugshjSjt2kWkZ
        4O4HJQaXOR3UuqLZbFhreD7t8mzEh0IHOFr/j0NyDResNIbKtxOT5aZc6F+Eww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N6ppYlM8LNw0f7kGBIy27Fc0Po5JViwaGk3Ei9mJ9+c=;
        b=a5B+FWJKlUpAso3fOInttXdNbZj4JNYNkHN07U2n6UYOI8d5dicYaiQvgdcANLZ7i1VWix
        fpsDxdNdfgtwtYDg==
From:   "thermal-bot for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Protect sysfs accesses to
 thermal operations with thermal zone mutex
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959778.4906.16808499021846178033.tip-bot2@tip-bot2>
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

Commit-ID:     05eeee2b51b44c7ba5f1b8e5c41362020513f163
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//05eeee2b51b44c7ba5f1b8e5c41362020513f163
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Thu, 10 Nov 2022 07:24:58 -08:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 14 Nov 2022 19:04:37 +01:00

thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex

Protect access to thermal operations against thermal zone removal by
acquiring the thermal zone device mutex. After acquiring the mutex, check
if the thermal zone device is registered and abort the operation if not.

With this change, we can call __thermal_zone_device_update() instead of
thermal_zone_device_update() from trip_point_temp_store() and from
emul_temp_store(). Similar, we can call __thermal_zone_set_trips() instead
of thermal_zone_set_trips() from trip_point_hyst_store().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c  |  4 +-
 drivers/thermal/thermal_core.h  |  2 +-
 drivers/thermal/thermal_sysfs.c | 79 ++++++++++++++++++++++++++------
 3 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0657e4b..173b049 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,8 +403,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
-static void __thermal_zone_device_update(struct thermal_zone_device *tz,
-					 enum thermal_notify_event event)
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event)
 {
 	int count;
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 1571917..7b51b9a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -109,6 +109,8 @@ int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index febf9e7..d97f0bc 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -92,7 +92,14 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
-	result = tz->ops->get_trip_type(tz, trip, &type);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(dev))
+		result = tz->ops->get_trip_type(tz, trip, &type);
+	else
+		result = -ENODEV;
+
+	mutex_unlock(&tz->lock);
 	if (result)
 		return result;
 
@@ -128,10 +135,17 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	if (tz->ops->set_trip_temp) {
 		ret = tz->ops->set_trip_temp(tz, trip, temperature);
 		if (ret)
-			return ret;
+			goto unlock;
 	}
 
 	if (tz->trips)
@@ -140,16 +154,22 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (tz->ops->get_trip_hyst) {
 		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
-			return ret;
+			goto unlock;
 	}
 
 	ret = tz->ops->get_trip_type(tz, trip, &type);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+unlock:
+	mutex_unlock(&tz->lock);
+
+	if (ret)
+		return ret;
 
 	return count;
 }
@@ -168,7 +188,14 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(dev))
+		ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	else
+		ret = -ENODEV;
+
+	mutex_unlock(&tz->lock);
 
 	if (ret)
 		return ret;
@@ -193,6 +220,13 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	/*
 	 * We are not doing any check on the 'temperature' value
 	 * here. The driver implementing 'set_trip_hyst' has to
@@ -201,7 +235,10 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
 
 	if (!ret)
-		thermal_zone_set_trips(tz);
+		__thermal_zone_set_trips(tz);
+
+unlock:
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
 }
@@ -220,7 +257,14 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(dev))
+		ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+	else
+		ret = -ENODEV;
+
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
@@ -269,16 +313,23 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	if (!tz->ops->set_emul_temp) {
-		mutex_lock(&tz->lock);
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (!tz->ops->set_emul_temp)
 		tz->emul_temperature = temperature;
-		mutex_unlock(&tz->lock);
-	} else {
+	else
 		ret = tz->ops->set_emul_temp(tz, temperature);
-	}
 
 	if (!ret)
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+unlock:
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
 }
