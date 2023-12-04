Return-Path: <linux-pm+bounces-678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507E803797
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 15:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746BC1C20AF0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A471799E;
	Mon,  4 Dec 2023 14:53:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBF3FD;
	Mon,  4 Dec 2023 06:52:55 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 140b955ce2589623; Mon, 4 Dec 2023 15:52:54 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B702766875B;
	Mon,  4 Dec 2023 15:52:53 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 2/2] thermal: sysfs: Rework the reading of trip point attributes
Date: Mon, 04 Dec 2023 15:52:22 +0100
Message-ID: <4855368.GXAFRqVoOG@kreacher>
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

Rework the _show() callback functions for the trip point temperature,
hysteresis and type attributes to avoid copying the values of struct
thermal_trip fields that they do not use and to make them carry out
validation checks with the help of check_thermal_zone_and_trip_id(),
like the corresponding _store() callback functions.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Drop a redundant 'ret' check at the end of trip_point_hyst_show.

v1 -> v2: Do not drop thermal zone locking from the _store() callback functions.

---
 drivers/thermal/thermal_sysfs.c |   55 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -96,25 +96,25 @@ trip_point_type_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, result;
+	enum thermal_trip_type type;
+	int trip_id, ret;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (device_is_registered(dev))
-		result = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		result = -ENODEV;
+	ret = check_thermal_zone_and_trip_id(dev, tz, trip_id);
+	if (ret) {
+		mutex_unlock(&tz->lock);
+		return ret;
+	}
 
-	mutex_unlock(&tz->lock);
+	type = tz->trips[trip_id].type;
 
-	if (result)
-		return result;
+	mutex_unlock(&tz->lock);
 
-	switch (trip.type) {
+	switch (type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -175,25 +175,24 @@ trip_point_temp_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id, ret, temp;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (device_is_registered(dev))
-		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		ret = -ENODEV;
+	ret = check_thermal_zone_and_trip_id(dev, tz, trip_id);
+	if (ret) {
+		mutex_unlock(&tz->lock);
+		return ret;
+	}
 
-	mutex_unlock(&tz->lock);
+	temp = tz->trips[trip_id].temperature;
 
-	if (ret)
-		return ret;
+	mutex_unlock(&tz->lock);
 
-	return sprintf(buf, "%d\n", trip.temperature);
+	return sprintf(buf, "%d\n", temp);
 }
 
 static ssize_t
@@ -243,22 +242,24 @@ trip_point_hyst_show(struct device *dev,
 		     char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip trip;
-	int trip_id, ret;
+	int trip_id, ret, hyst;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	if (device_is_registered(dev))
-		ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	else
-		ret = -ENODEV;
+	ret = check_thermal_zone_and_trip_id(dev, tz, trip_id);
+	if (ret) {
+		mutex_unlock(&tz->lock);
+		return ret;
+	}
+
+	hyst = tz->trips[trip_id].hysteresis;
 
 	mutex_unlock(&tz->lock);
 
-	return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
+	return sprintf(buf, "%d\n", hyst);
 }
 
 static ssize_t




