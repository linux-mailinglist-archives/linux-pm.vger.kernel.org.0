Return-Path: <linux-pm+bounces-574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB7D7FF98A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD74F1C20DF8
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C87537EC;
	Thu, 30 Nov 2023 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299FE10E5;
	Thu, 30 Nov 2023 10:38:02 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 1d4465a859ae4881; Thu, 30 Nov 2023 19:38:00 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 61FA366862D;
	Thu, 30 Nov 2023 19:38:00 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 2/2] thermal: sysfs: Eliminate unnecessary zone locking
Date: Thu, 30 Nov 2023 19:37:45 +0100
Message-ID: <2933888.e9J7NaK4W3@kreacher>
In-Reply-To: <5754079.DvuYhMxLoT@kreacher>
References: <5754079.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedguddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhr
 ihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The _show() callback functions of the trip point sysfs attributes,
temperature, hysteresis and type, need not use thermal zone locking,
because the layout of the data structures they access does not change
after the thermal zone registration.

Namely, they all need to access a specific entry in the thermal
zone's trips[] table that is always present for non-tripless thermal
zones and its size cannot change after the thermal zone has been
registered.  Thus it is always safe to access the trips[] table of a
registered thermal zone from each of the sysfs attributes in question.

Moreover, the type of a trip point does not change after registering its
thermal zone, and while its temperature and hysteresis can change, for
example due to a firmware-induced thermal zone update, holding the zone
lock around reading them is pointless, because it does not prevent stale
values from being returned to user space.  For example, a trip point
temperature can always change ater trip_point_temp_show() has read it
and before the function's return statement is executed, regardless of
whether or not zone locking is used.

For this reason, drop the zone locking from trip_point_type_show(),
trip_point_temp_show(), and trip_point_hyst_show().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c |   60 ++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 39 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -83,25 +83,18 @@ trip_point_type_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, result;
+	int trip_id;
+
+	if (!device_is_registered(dev))
+		return -ENODEV;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (device_is_registered(dev))
-		result = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		result = -ENODEV;
-
-	mutex_unlock(&tz->lock);
-
-	if (result)
-		return result;
+	if (trip_id < 0 || trip_id > tz->num_trips)
+		return -EINVAL;
 
-	switch (trip.type) {
+	switch (tz->trips[trip_id].type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -164,25 +157,18 @@ trip_point_temp_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id;
+
+	if (!device_is_registered(dev))
+		return -ENODEV;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (device_is_registered(dev))
-		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		ret = -ENODEV;
-
-	mutex_unlock(&tz->lock);
-
-	if (ret)
-		return ret;
+	if (trip_id < 0 || trip_id > tz->num_trips)
+		return -EINVAL;
 
-	return sprintf(buf, "%d\n", trip.temperature);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
 }
 
 static ssize_t
@@ -234,22 +220,18 @@ trip_point_hyst_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id;
+
+	if (!device_is_registered(dev))
+		return -ENODEV;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	mutex_lock(&tz->lock);
-
-	if (device_is_registered(dev))
-		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		ret = -ENODEV;
-
-	mutex_unlock(&tz->lock);
+	if (trip_id < 0 || trip_id > tz->num_trips)
+		return -EINVAL;
 
-	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
 }
 
 static ssize_t




