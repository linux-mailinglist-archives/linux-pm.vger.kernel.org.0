Return-Path: <linux-pm+bounces-15507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7199951D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13E71F26612
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962B91E907D;
	Thu, 10 Oct 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="K3HJ8zGL"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37F1E3DC7;
	Thu, 10 Oct 2024 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598959; cv=none; b=lghEdMc8XFfFhL8+fAEO3dNJayikyes42C/wqKPEwpaF0lN+Vg+fmh59YazRIVp6yLCyGK+TT4ZEfZiLVCG7X8OrzkDZbmEQ3z5SQMSxaO4NjOf6uBg2Ff5rd2A9NVOp6rtxi44ZfA1PxdrmRBcWn6CA9XJLfz+Mub3+m8F1JEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598959; c=relaxed/simple;
	bh=sw7PzrW0zbnIeR6peSEV41RYqUoN4NDIPFEnEpVT8X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFj7G29JEOo9YinE3TP7V/bXHdMaG8bevX4I4BaLcW4rxvkrViZdV84vwQkJOESy94xlnVfLOn7ZhG92Jo0hQQWnoqVd/UcUT4/q4HJf8u+c4+2CoXvQB1vG216OuZV121xGORo0P1hn9JsgZRiwR/rprRKdp0+6/Sgd/YgrLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=K3HJ8zGL; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e36d82ff513429d2; Fri, 11 Oct 2024 00:22:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 38BE469EF02;
	Fri, 11 Oct 2024 00:22:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598949;
	bh=sw7PzrW0zbnIeR6peSEV41RYqUoN4NDIPFEnEpVT8X8=;
	h=From:Subject:Date;
	b=K3HJ8zGLp9lfPIVmkFPG8/hNj9Ei948bVxYetK6h5CvBgwLu/vpzPf/JCE6vqIw5X
	 61zWtv3zGHrD0DCnfWqsZmD9r5ZwTviIHMrPcDEWjsurY3OtxNzn/XUB9jbh9OZXkT
	 WEdvYZQVP9hVrHUubTZKXfFQY9LTKcPmWNP02UbV0ndSCfP4izs8nTZCGd01IdnR6V
	 84+FXPv6+IajU2Y9f9E5YMJR8ZxhP0KRE3HCEJ6i0O5aw2TQpWD2fj8l4CEZkFI6M/
	 dZRQVqPjid79ZbbXywW/B0LgaudP2ittF5VJtg1wU9G+5awkYCgnY5MjdttAXQtVlZ
	 etMPAl3kajdCQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 01/11] thermal: core: Add and use thermal zone guard
Date: Fri, 11 Oct 2024 00:05:25 +0200
Message-ID: <1930069.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add and use a guard for thermal zone locking.

This allows quite a few error code paths to be simplified among
other things and brings in a noticeable code size reduction for
a good measure.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/3241904.5fSG56mABF@rjwysocki.net/

that has been combined with

https://lore.kernel.org/linux-pm/4613601.LvFx2qVVIh@rjwysocki.net/

and rebased on top of

https://lore.kernel.org/linux-pm/12549318.O9o76ZdvQC@rjwysocki.net/

and

https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/

---
 drivers/thermal/thermal_core.c    |   61 +++++++---------------------
 drivers/thermal/thermal_core.h    |    4 +
 drivers/thermal/thermal_debugfs.c |   25 +++++++----
 drivers/thermal/thermal_helpers.c |   17 ++-----
 drivers/thermal/thermal_hwmon.c   |    5 --
 drivers/thermal/thermal_netlink.c |   21 ++-------
 drivers/thermal/thermal_sysfs.c   |   81 ++++++++++++++++----------------------
 drivers/thermal/thermal_trip.c    |    8 ---
 8 files changed, 86 insertions(+), 136 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -9,6 +9,7 @@
 #ifndef __THERMAL_CORE_H__
 #define __THERMAL_CORE_H__
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/thermal.h>
 
@@ -144,6 +145,9 @@ struct thermal_zone_device {
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
+DEFINE_GUARD(thermal_zone, struct thermal_zone_device *, mutex_lock(&_T->lock),
+	     mutex_unlock(&_T->lock))
+
 /* Initial thermal zone temperature. */
 #define THERMAL_TEMP_INIT	INT_MIN
 
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -50,13 +50,13 @@ static ssize_t
 mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int enabled;
 
-	mutex_lock(&tz->lock);
-	enabled = tz->mode == THERMAL_DEVICE_ENABLED;
-	mutex_unlock(&tz->lock);
+	guard(thermal_zone)(tz);
 
-	return sprintf(buf, "%s\n", enabled ? "enabled" : "disabled");
+	if (tz->mode == THERMAL_DEVICE_ENABLED)
+		return sprintf(buf, "enabled\n");
+
+	return sprintf(buf, "disabled\n");
 }
 
 static ssize_t
@@ -103,38 +103,34 @@ trip_point_temp_store(struct device *dev
 {
 	struct thermal_trip *trip = thermal_trip_of_attr(attr, temp);
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int ret, temp;
+	int temp;
 
-	ret = kstrtoint(buf, 10, &temp);
-	if (ret)
+	if (kstrtoint(buf, 10, &temp))
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	if (temp == trip->temperature)
-		goto unlock;
+		return count;
 
 	/* Arrange the condition to avoid integer overflows. */
 	if (temp != THERMAL_TEMP_INVALID &&
-	    temp <= trip->hysteresis + THERMAL_TEMP_INVALID) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+	    temp <= trip->hysteresis + THERMAL_TEMP_INVALID)
+		return -EINVAL;
 
 	if (tz->ops.set_trip_temp) {
+		int ret;
+
 		ret = tz->ops.set_trip_temp(tz, trip, temp);
 		if (ret)
-			goto unlock;
+			return ret;
 	}
 
 	thermal_zone_set_trip_temp(tz, trip, temp);
 
 	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 
-unlock:
-	mutex_unlock(&tz->lock);
-
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t
@@ -152,16 +148,15 @@ trip_point_hyst_store(struct device *dev
 {
 	struct thermal_trip *trip = thermal_trip_of_attr(attr, hyst);
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int ret, hyst;
+	int hyst;
 
-	ret = kstrtoint(buf, 10, &hyst);
-	if (ret || hyst < 0)
+	if (kstrtoint(buf, 10, &hyst) || hyst < 0)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	if (hyst == trip->hysteresis)
-		goto unlock;
+		return count;
 
 	/*
 	 * Allow the hysteresis to be updated when the temperature is invalid
@@ -171,22 +166,17 @@ trip_point_hyst_store(struct device *dev
 	 */
 	if (trip->temperature == THERMAL_TEMP_INVALID) {
 		WRITE_ONCE(trip->hysteresis, hyst);
-		goto unlock;
+		return count;
 	}
 
-	if (trip->temperature - hyst <= THERMAL_TEMP_INVALID) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+	if (trip->temperature - hyst <= THERMAL_TEMP_INVALID)
+		return -EINVAL;
 
 	thermal_zone_set_trip_hyst(tz, trip, hyst);
 
 	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 
-unlock:
-	mutex_unlock(&tz->lock);
-
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t
@@ -236,25 +226,26 @@ emul_temp_store(struct device *dev, stru
 		const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int ret = 0;
 	int temperature;
 
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
-	if (!tz->ops.set_emul_temp)
-		tz->emul_temperature = temperature;
-	else
-		ret = tz->ops.set_emul_temp(tz, temperature);
+	if (tz->ops.set_emul_temp) {
+		int ret;
 
-	if (!ret)
-		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		ret = tz->ops.set_emul_temp(tz, temperature);
+		if (ret)
+			return ret;
+	} else {
+		tz->emul_temperature = temperature;
+	}
 
-	mutex_unlock(&tz->lock);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	return ret ? ret : count;
+	return count;
 }
 static DEVICE_ATTR_WO(emul_temp);
 #endif
@@ -894,13 +885,11 @@ ssize_t weight_store(struct device *dev,
 	instance = container_of(attr, struct thermal_instance, weight_attr);
 
 	/* Don't race with governors using the 'weight' value */
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	instance->weight = weight;
 
 	thermal_governor_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);
 
-	mutex_unlock(&tz->lock);
-
 	return count;
 }
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -45,13 +45,9 @@ int thermal_zone_for_each_trip(struct th
 			       int (*cb)(struct thermal_trip *, void *),
 			       void *data)
 {
-	int ret;
+	guard(thermal_zone)(tz);
 
-	mutex_lock(&tz->lock);
-	ret = for_each_thermal_trip(tz, cb, data);
-	mutex_unlock(&tz->lock);
-
-	return ret;
+	return for_each_thermal_trip(tz, cb, data);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
 
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -60,13 +60,13 @@ bool thermal_trip_is_bound_to_cdev(struc
 {
 	bool ret;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
+
 	mutex_lock(&cdev->lock);
 
 	ret = thermal_instance_present(tz, cdev, trip);
 
 	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
 
 	return ret;
 }
@@ -138,19 +138,14 @@ int thermal_zone_get_temp(struct thermal
 	if (IS_ERR_OR_NULL(tz))
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
-	if (!tz->ops.get_temp) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+	if (!tz->ops.get_temp)
+		return -EINVAL;
 
 	ret = __thermal_zone_get_temp(tz, temp);
 	if (!ret && *temp <= THERMAL_TEMP_INVALID)
-		ret = -ENODATA;
-
-unlock:
-	mutex_unlock(&tz->lock);
+		return -ENODATA;
 
 	return ret;
 }
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -202,16 +202,13 @@ int thermal_zone_device_set_policy(struc
 	int ret = -EINVAL;
 
 	mutex_lock(&thermal_governor_lock);
-	mutex_lock(&tz->lock);
 
-	gov = __find_governor(strim(policy));
-	if (!gov)
-		goto exit;
+	guard(thermal_zone)(tz);
 
-	ret = thermal_set_governor(tz, gov);
+	gov = __find_governor(strim(policy));
+	if (gov)
+		ret = thermal_set_governor(tz, gov);
 
-exit:
-	mutex_unlock(&tz->lock);
 	mutex_unlock(&thermal_governor_lock);
 
 	thermal_notify_tz_gov_change(tz, policy);
@@ -615,26 +612,18 @@ static int thermal_zone_device_set_mode(
 {
 	int ret;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	/* do nothing if mode isn't changing */
-	if (mode == tz->mode) {
-		mutex_unlock(&tz->lock);
-
+	if (mode == tz->mode)
 		return 0;
-	}
 
 	ret = __thermal_zone_device_set_mode(tz, mode);
-	if (ret) {
-		mutex_unlock(&tz->lock);
-
+	if (ret)
 		return ret;
-	}
 
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	mutex_unlock(&tz->lock);
-
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz);
 	else
@@ -663,10 +652,10 @@ static bool thermal_zone_is_present(stru
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
+
 	if (thermal_zone_is_present(tz))
 		__thermal_zone_device_update(tz, event);
-	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
@@ -970,12 +959,10 @@ static bool __thermal_zone_cdev_bind(str
 static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
 				   struct thermal_cooling_device *cdev)
 {
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	if (__thermal_zone_cdev_bind(tz, cdev))
 		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -1282,11 +1269,9 @@ static void __thermal_zone_cdev_unbind(s
 static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
 				     struct thermal_cooling_device *cdev)
 {
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	__thermal_zone_cdev_unbind(tz, cdev);
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -1332,7 +1317,7 @@ int thermal_zone_get_crit_temp(struct th
 	if (tz->ops.get_crit_temp)
 		return tz->ops.get_crit_temp(tz, temp);
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
@@ -1344,8 +1329,6 @@ int thermal_zone_get_crit_temp(struct th
 		}
 	}
 
-	mutex_unlock(&tz->lock);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
@@ -1358,7 +1341,7 @@ static void thermal_zone_init_complete(s
 
 	list_add_tail(&tz->node, &thermal_tz_list);
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	/* Bind cooling devices for this zone. */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
@@ -1375,8 +1358,6 @@ static void thermal_zone_init_complete(s
 
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	mutex_unlock(&tz->lock);
-
 	mutex_unlock(&thermal_list_lock);
 }
 
@@ -1607,7 +1588,7 @@ static bool thermal_zone_exit(struct the
 		goto unlock;
 	}
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	tz->state |= TZ_STATE_FLAG_EXIT;
 	list_del_init(&tz->node);
@@ -1616,8 +1597,6 @@ static bool thermal_zone_exit(struct the
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
 		__thermal_zone_cdev_unbind(tz, cdev);
 
-	mutex_unlock(&tz->lock);
-
 unlock:
 	mutex_unlock(&thermal_list_lock);
 
@@ -1701,7 +1680,7 @@ static void thermal_zone_device_resume(s
 
 	tz = container_of(work, struct thermal_zone_device, poll_queue.work);
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
 
@@ -1711,13 +1690,11 @@ static void thermal_zone_device_resume(s
 	__thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
 
 	complete(&tz->resume);
-
-	mutex_unlock(&tz->lock);
 }
 
 static void thermal_zone_pm_prepare(struct thermal_zone_device *tz)
 {
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	if (tz->state & TZ_STATE_FLAG_RESUMING) {
 		/*
@@ -1733,13 +1710,11 @@ static void thermal_zone_pm_prepare(stru
 	}
 
 	tz->state |= TZ_STATE_FLAG_SUSPENDED;
-
-	mutex_unlock(&tz->lock);
 }
 
 static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 {
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	cancel_delayed_work(&tz->poll_queue);
 
@@ -1753,8 +1728,6 @@ static void thermal_zone_pm_complete(str
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_resume);
 	/* Queue up the work without a delay. */
 	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
-
-	mutex_unlock(&tz->lock);
 }
 
 static int thermal_pm_notify(struct notifier_block *nb,
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -885,6 +885,19 @@ void thermal_debug_tz_add(struct thermal
 	tz->debugfs = thermal_dbg;
 }
 
+static struct thermal_debugfs *thermal_debug_tz_clear(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg;
+
+	guard(thermal_zone)(tz);
+
+	thermal_dbg = tz->debugfs;
+	if (thermal_dbg)
+		tz->debugfs = NULL;
+
+	return thermal_dbg;
+}
+
 void thermal_debug_tz_remove(struct thermal_zone_device *tz)
 {
 	struct thermal_debugfs *thermal_dbg;
@@ -892,17 +905,9 @@ void thermal_debug_tz_remove(struct ther
 	struct tz_debugfs *tz_dbg;
 	int *trips_crossed;
 
-	mutex_lock(&tz->lock);
-
-	thermal_dbg = tz->debugfs;
-	if (!thermal_dbg) {
-		mutex_unlock(&tz->lock);
+	thermal_dbg = thermal_debug_tz_clear(tz);
+	if (!thermal_dbg)
 		return;
-	}
-
-	tz->debugfs = NULL;
-
-	mutex_unlock(&tz->lock);
 
 	tz_dbg = &thermal_dbg->tz_dbg;
 
Index: linux-pm/drivers/thermal/thermal_hwmon.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_hwmon.c
+++ linux-pm/drivers/thermal/thermal_hwmon.c
@@ -78,12 +78,9 @@ temp_crit_show(struct device *dev, struc
 	int temperature;
 	int ret;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	ret = tz->ops.get_crit_temp(tz, &temperature);
-
-	mutex_unlock(&tz->lock);
-
 	if (ret)
 		return ret;
 
Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -459,7 +459,7 @@ static int thermal_genl_cmd_tz_get_trip(
 	if (!start_trip)
 		return -EMSGSIZE;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
@@ -469,19 +469,12 @@ static int thermal_genl_cmd_tz_get_trip(
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip->temperature) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip->hysteresis))
-			goto out_cancel_nest;
+			return -EMSGSIZE;
 	}
 
-	mutex_unlock(&tz->lock);
-
 	nla_nest_end(msg, start_trip);
 
 	return 0;
-
-out_cancel_nest:
-	mutex_unlock(&tz->lock);
-
-	return -EMSGSIZE;
 }
 
 static int thermal_genl_cmd_tz_get_temp(struct param *p)
@@ -512,7 +505,7 @@ static int thermal_genl_cmd_tz_get_temp(
 static int thermal_genl_cmd_tz_get_gov(struct param *p)
 {
 	struct sk_buff *msg = p->msg;
-	int id, ret = 0;
+	int id;
 
 	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
 		return -EINVAL;
@@ -523,16 +516,14 @@ static int thermal_genl_cmd_tz_get_gov(s
 	if (!tz)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id) ||
 	    nla_put_string(msg, THERMAL_GENL_ATTR_TZ_GOV_NAME,
 			   tz->governor->name))
-		ret = -EMSGSIZE;
-
-	mutex_unlock(&tz->lock);
+		return -EMSGSIZE;
 
-	return ret;
+	return 0;
 }
 
 static int __thermal_genl_cmd_cdev_get(struct thermal_cooling_device *cdev,





