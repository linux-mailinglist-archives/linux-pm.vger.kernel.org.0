Return-Path: <linux-pm+bounces-679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB6803799
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 15:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF23B20A96
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771C28E01;
	Mon,  4 Dec 2023 14:53:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6844BB3;
	Mon,  4 Dec 2023 06:52:56 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id c1a7933d2ff66a7c; Mon, 4 Dec 2023 15:52:54 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6F9EC66875B;
	Mon,  4 Dec 2023 15:52:54 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 1/2] thermal: sysfs: Rework the handling of trip point updates
Date: Mon, 04 Dec 2023 15:50:11 +0100
Message-ID: <4883151.31r3eYUQgx@kreacher>
In-Reply-To: <12338384.O9o76ZdvQC@kreacher>
References: <12338384.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhi
 nhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
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

Moreover, input processing need not be done under the thermal zone lock
in any of these functions.

Rework trip_point_temp_store() and trip_point_hyst_store() to address
the above, move the part of thermal_zone_set_trip() that is still
useful to a new function called thermal_zone_trip_updated() and drop
the rest of it.

While at it, make trip_point_hyst_store() reject negative hysteresis
values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: No changes

v1 -> v2: Still check device_is_registered() under the zone lock

---
 drivers/thermal/thermal_core.h  |    2 +
 drivers/thermal/thermal_sysfs.c |   75 ++++++++++++++++++++++++++++------------
 drivers/thermal/thermal_trip.c  |   45 ++++--------------------
 include/linux/thermal.h         |    4 --
 4 files changed, 64 insertions(+), 62 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -78,6 +78,19 @@ mode_store(struct device *dev, struct de
 	return count;
 }
 
+static int check_thermal_zone_and_trip_id(struct device *dev,
+					  struct thermal_zone_device *tz,
+					  int trip_id)
+{
+	if (!device_is_registered(dev))
+		return -ENODEV;
+
+	if (trip_id < 0 || trip_id >= tz->num_trips)
+		return -EINVAL;
+
+	return 0;
+}
+
 static ssize_t
 trip_point_type_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
@@ -120,28 +133,37 @@ trip_point_temp_store(struct device *dev
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
+	struct thermal_trip *trip;
 	int trip_id, ret;
+	int temp;
+
+	ret = kstrtoint(buf, 10, &temp);
+	if (ret)
+		return -EINVAL;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (!device_is_registered(dev)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
+	ret = check_thermal_zone_and_trip_id(dev, tz, trip_id);
 	if (ret)
 		goto unlock;
 
-	ret = kstrtoint(buf, 10, &trip.temperature);
-	if (ret)
-		goto unlock;
+	trip = &tz->trips[trip_id];
+
+	if (temp != trip->temperature) {
+		if (tz->ops->set_trip_temp) {
+			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
+			if (ret)
+				goto unlock;
+		}
+
+		trip->temperature = temp;
+
+		thermal_zone_trip_updated(tz, trip);
+	}
 
-	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 unlock:
 	mutex_unlock(&tz->lock);
 	
@@ -179,28 +201,37 @@ trip_point_hyst_store(struct device *dev
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
+	struct thermal_trip *trip;
 	int trip_id, ret;
+	int hyst;
+
+	ret = kstrtoint(buf, 10, &hyst);
+	if (ret || hyst < 0)
+		return -EINVAL;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (!device_is_registered(dev)) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
+	ret = check_thermal_zone_and_trip_id(dev, tz, trip_id);
 	if (ret)
 		goto unlock;
 
-	ret = kstrtoint(buf, 10, &trip.hysteresis);
-	if (ret)
-		goto unlock;
+	trip = &tz->trips[trip_id];
+
+	if (hyst != trip->hysteresis) {
+		if (tz->ops->set_trip_hyst) {
+			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
+			if (ret)
+				goto unlock;
+		}
+
+		trip->hysteresis = hyst;
+
+		thermal_zone_trip_updated(tz, trip);
+	}
 
-	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 unlock:
 	mutex_unlock(&tz->lock);
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -124,6 +124,8 @@ int __thermal_zone_get_trip(struct therm
 			    struct thermal_trip *trip);
 int thermal_zone_trip_id(struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
+void thermal_zone_trip_updated(struct thermal_zone_device *tz,
+			       const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -147,42 +147,6 @@ int thermal_zone_get_trip(struct thermal
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
-int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
-			  const struct thermal_trip *trip)
-{
-	struct thermal_trip t;
-	int ret;
-
-	ret = __thermal_zone_get_trip(tz, trip_id, &t);
-	if (ret)
-		return ret;
-
-	if (t.type != trip->type)
-		return -EINVAL;
-
-	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
-		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
-		if (ret)
-			return ret;
-	}
-
-	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
-		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
-		if (ret)
-			return ret;
-	}
-
-	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
-		tz->trips[trip_id] = *trip;
-
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
-				      trip->temperature, trip->hysteresis);
-
-	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
-
-	return 0;
-}
-
 int thermal_zone_trip_id(struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip)
 {
@@ -192,3 +156,12 @@ int thermal_zone_trip_id(struct thermal_
 	 */
 	return trip - tz->trips;
 }
+
+void thermal_zone_trip_updated(struct thermal_zone_device *tz,
+			       const struct thermal_trip *trip)
+{
+	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
+				      trip->type, trip->temperature,
+				      trip->hysteresis);
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+}
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -282,10 +282,6 @@ int __thermal_zone_get_trip(struct therm
 			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
-
-int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
-			  const struct thermal_trip *trip);
-
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data);




