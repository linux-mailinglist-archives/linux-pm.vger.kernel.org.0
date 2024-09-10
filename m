Return-Path: <linux-pm+bounces-13942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CE5973435
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1738B1C24EDA
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A418EFEE;
	Tue, 10 Sep 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ifRnyhV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE7193439;
	Tue, 10 Sep 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964543; cv=none; b=TxBfKugHrgjVLlR2uOH2L8R4C4j4gFqOsjZv4mszMPGAmGEal59DoXeCddxvr6H76E2Mdo3VR+xrc/OS7YULHr9R63WpYy2ODAcvwfozY08DDWa4Llxk601jAh1XWEZv7+xVOcSHfWte4yVAp8QLn+rLhcZJ5tAeqJe7RiD3fGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964543; c=relaxed/simple;
	bh=u/7UB3Q5cuqzEscCukI5NdFR2SsbxTFB4sY1UpEhUAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONpzIRXtCNGVlkHY7E81Kl0TRANrPn262UwA0xJQjqus8+WDzhcU9XhryNntk4xUYwSlxrq5UZngDpozUM1Ia8r7wcyqmBe4i8I2p0SxUxOBxeRjCYEtMIZ9yiZAPHyvlo+j+GpNSNl14sr8honSAomQ8JJGaI+zxURfN9cEY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ifRnyhV+; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 113eee69d23d6f90; Tue, 10 Sep 2024 11:35:38 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6D3C46B836C;
	Tue, 10 Sep 2024 11:35:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725960938;
	bh=u/7UB3Q5cuqzEscCukI5NdFR2SsbxTFB4sY1UpEhUAM=;
	h=From:Subject:Date;
	b=ifRnyhV+yIjoHdrIahCzt6HEJxoSqk+B7P84qoPHeKZOSrwi7c1K4ByDPqnHDygso
	 2wj2Frh7FqzXGIUwwKYwAncQcqgP8x2/yBMmkknV1EVM2DVKoX6OcXikPgavQmGMja
	 tXpg4JuqeTGA8x9bQqifQHy8YVF/W8VmlOkJPwJDXPn+HJqiplD6FM4J2OaeJab+0v
	 gX41Wq5O7kI1IRkbnw7q9eK/DfKAT1i4jBb574ofOTIXhjQ930u1XjJK2y+AkcZGwz
	 VQgsiSlJPrUOX7PFZc4gC35PHHaGtIX1W5ax6Q4y2Jxmo408JT8L+4iqeEQ75ioHBa
	 RGOJXHqDbIeoQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH for 6.13 v1 8/8] thermal: core: Add and use thermal zone guard
Date: Tue, 10 Sep 2024 11:35:20 +0200
Message-ID: <3241904.5fSG56mABF@rjwysocki.net>
In-Reply-To: <4920970.GXAFRqVoOG@rjwysocki.net>
References: <4920970.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add and use a special guard for thermal zones.

This allows quite a few error code paths to be simplified among
other things and brings in a noticeable code size reduction for
a good measure.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |   67 +++++++++++++------------------
 drivers/thermal/thermal_core.h    |    4 +
 drivers/thermal/thermal_helpers.c |   17 ++-----
 drivers/thermal/thermal_sysfs.c   |   81 ++++++++++++++++----------------------
 drivers/thermal/thermal_trip.c    |    8 ---
 5 files changed, 76 insertions(+), 101 deletions(-)

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
 
@@ -146,6 +147,9 @@ struct thermal_zone_device {
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
@@ -199,16 +199,13 @@ int thermal_zone_device_set_policy(struc
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
@@ -608,26 +605,18 @@ static int thermal_zone_device_set_mode(
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
@@ -656,10 +645,10 @@ static bool thermal_zone_is_present(stru
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
 
@@ -936,7 +925,7 @@ static void thermal_zone_cdev_bind(struc
 	if (!tz->ops.should_bind)
 		return;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	for_each_trip_desc(tz, td) {
 		struct cooling_spec c = {
@@ -953,8 +942,6 @@ static void thermal_zone_cdev_bind(struc
 		if (ret)
 			print_bind_err_msg(tz, td, cdev, ret);
 	}
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -1259,12 +1246,10 @@ static void thermal_zone_cdev_unbind(str
 {
 	struct thermal_trip_desc *td;
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	for_each_trip_desc(tz, td)
 		thermal_unbind_cdev_from_trip(tz, td, cdev);
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -1310,7 +1295,7 @@ int thermal_zone_get_crit_temp(struct th
 	if (tz->ops.get_crit_temp)
 		return tz->ops.get_crit_temp(tz, temp);
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
@@ -1322,12 +1307,17 @@ int thermal_zone_get_crit_temp(struct th
 		}
 	}
 
-	mutex_unlock(&tz->lock);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
+static void thermal_zone_add_to_list(struct thermal_zone_device *tz)
+{
+	guard(thermal_zone)(tz);
+
+	list_add_tail(&tz->node, &thermal_tz_list);
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1488,9 +1478,7 @@ thermal_zone_device_register_with_trips(
 
 	mutex_lock(&thermal_list_lock);
 
-	mutex_lock(&tz->lock);
-	list_add_tail(&tz->node, &thermal_tz_list);
-	mutex_unlock(&tz->lock);
+	thermal_zone_add_to_list(tz);
 
 	/* Bind cooling devices for this zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
@@ -1557,6 +1545,13 @@ struct device *thermal_zone_device(struc
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device);
 
+static void thermal_zone_del_from_list(struct thermal_zone_device *tz)
+{
+	guard(thermal_zone)(tz);
+
+	list_del(&tz->node);
+}
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
@@ -1581,9 +1576,7 @@ void thermal_zone_device_unregister(stru
 		return;
 	}
 
-	mutex_lock(&tz->lock);
-	list_del(&tz->node);
-	mutex_unlock(&tz->lock);
+	thermal_zone_del_from_list(tz);
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
@@ -1656,7 +1649,7 @@ static void thermal_zone_device_resume(s
 
 	tz = container_of(work, struct thermal_zone_device, poll_queue.work);
 
-	mutex_lock(&tz->lock);
+	guard(thermal_zone)(tz);
 
 	tz->suspended = false;
 
@@ -1667,8 +1660,6 @@ static void thermal_zone_device_resume(s
 
 	complete(&tz->resume);
 	tz->resuming = false;
-
-	mutex_unlock(&tz->lock);
 }
 
 static int thermal_pm_notify(struct notifier_block *nb,




