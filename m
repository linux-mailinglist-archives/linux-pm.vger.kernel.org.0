Return-Path: <linux-pm+bounces-308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257717FAAC1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 20:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EF51F20EDF
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94345966;
	Mon, 27 Nov 2023 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDDA1;
	Mon, 27 Nov 2023 11:59:23 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id dbc98fb5fa75a51d; Mon, 27 Nov 2023 20:59:21 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 73BCF668204;
	Mon, 27 Nov 2023 20:59:21 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1] thermal: trip: Rework thermal_zone_set_trip() and its callers
Date: Mon, 27 Nov 2023 20:59:21 +0100
Message-ID: <4892163.31r3eYUQgx@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghl
 rdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both trip_point_temp_store() and trip_point_hyst_store() use
thermal_zone_set_trip() to update a given trip point, but none of them
actually needs to change more than one field in struct thermal_trip
representing it.  However, each of them effectively calls
__thermal_zone_get_trip() twice in a row for the same trip index value,
once directly and once via thermal_zone_set_trip(), which is not
particularly efficient, and the way in which thermal_zone_set_trip()
carries out the update is not particularly straightforward.

Moreover, some checks done by them both need not go under the thermal
zone lock and code duplication between them can be reduced quilte a bit
by moving the majority of logic into thermal_zone_set_trip().

Rework all of the above funtcions to address the above.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h  |    9 +++++
 drivers/thermal/thermal_sysfs.c |   52 +++++++---------------------------
 drivers/thermal/thermal_trip.c  |   61 ++++++++++++++++++++++++++--------------
 include/linux/thermal.h         |    3 -
 4 files changed, 61 insertions(+), 64 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -122,6 +122,15 @@ void __thermal_zone_device_update(struct
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
+
+enum thermal_set_trip_target {
+	THERMAL_TRIP_SET_TEMP,
+	THERMAL_TRIP_SET_HYST,
+};
+
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  enum thermal_set_trip_target what, const char *buf);
+
 int thermal_zone_trip_id(struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -120,31 +120,17 @@ trip_point_temp_store(struct device *dev
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id;
+	int ret;
+
+	if (!device_is_registered(dev))
+		return -ENODEV;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (!device_is_registered(dev)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	if (ret)
-		goto unlock;
-
-	ret = kstrtoint(buf, 10, &trip.temperature);
-	if (ret)
-		goto unlock;
+	ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_TEMP, buf);
 
-	ret = thermal_zone_set_trip(tz, trip_id, &trip);
-unlock:
-	mutex_unlock(&tz->lock);
-	
 	return ret ? ret : count;
 }
 
@@ -179,30 +165,16 @@ trip_point_hyst_store(struct device *dev
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id;
+	int ret;
+
+	if (!device_is_registered(dev))
+		return -ENODEV;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (!device_is_registered(dev)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	if (ret)
-		goto unlock;
-
-	ret = kstrtoint(buf, 10, &trip.hysteresis);
-	if (ret)
-		goto unlock;
-
-	ret = thermal_zone_set_trip(tz, trip_id, &trip);
-unlock:
-	mutex_unlock(&tz->lock);
+	ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_HYST, buf);
 
 	return ret ? ret : count;
 }
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -148,42 +148,61 @@ int thermal_zone_get_trip(struct thermal
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
 int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
-			  const struct thermal_trip *trip)
+			  enum thermal_set_trip_target what, const char *buf)
 {
-	struct thermal_trip t;
-	int ret;
+	struct thermal_trip *trip;
+	int val, ret = 0;
 
-	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
-		return -EINVAL;
+	if (trip_id < 0 || trip_id >= tz->num_trips)
+		ret = -EINVAL;
 
-	ret = __thermal_zone_get_trip(tz, trip_id, &t);
+	ret = kstrtoint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (t.type != trip->type)
-		return -EINVAL;
+	mutex_lock(&tz->lock);
 
-	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
-		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
-		if (ret)
-			return ret;
-	}
+	trip = &tz->trips[trip_id];
 
-	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
-		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
-		if (ret)
-			return ret;
+	switch (what) {
+	case THERMAL_TRIP_SET_TEMP:
+		if (val == trip->temperature)
+			goto unlock;
+
+		if (tz->ops->set_trip_temp) {
+			ret = tz->ops->set_trip_temp(tz, trip_id, val);
+			if (ret)
+				goto unlock;
+		}
+		trip->temperature = val;
+		break;
+
+	case THERMAL_TRIP_SET_HYST:
+		if (val == trip->hysteresis)
+			goto unlock;
+
+		if (tz->ops->set_trip_hyst) {
+			ret = tz->ops->set_trip_hyst(tz, trip_id, val);
+			if (ret)
+				goto unlock;
+		}
+		trip->hysteresis = val;
+		break;
+
+	default:
+		ret = -EINVAL;
+		goto unlock;
 	}
 
-	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
-		tz->trips[trip_id] = *trip;
-
 	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
 				      trip->temperature, trip->hysteresis);
 
 	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 
-	return 0;
+unlock:
+	mutex_unlock(&tz->lock);
+
+	return ret;
 }
 
 int thermal_zone_trip_id(struct thermal_zone_device *tz,
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -283,9 +283,6 @@ int __thermal_zone_get_trip(struct therm
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
-int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
-			  const struct thermal_trip *trip);
-
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data);




