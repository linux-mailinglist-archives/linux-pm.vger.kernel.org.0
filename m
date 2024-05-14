Return-Path: <linux-pm+bounces-7839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314298C4F7A
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998F6B20F6A
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D95B140378;
	Tue, 14 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faYG1S5H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="quEfw2XF"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558B13F458
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681946; cv=none; b=ufdsDADuYq92iDZRekiavdOwZ8hmvGmNQVEXU5RiW0U5EG/tsXAyKpwKTaRd1WWaSHANaAd3oAWVLNnwPvYiJh2Wh8RgdAeuE7jRk3k+EfQ5FzUKFaiFcA95850eb1PePsUTJmxS4WzXGXMCdQw7ZBZeP5fine+rYreqvwmbKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681946; c=relaxed/simple;
	bh=IixxeaOx/oyi1fviu8OMRvkGKaLhQnFYSHTS274+S84=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DykJ5R0xIGFtxE+i6yknZhvJgwSZgP7pKm/s/HWEgO5vsge78X5VQlpm/aA1RBnFvRTn+UUm7+eBby80TNujoEKLPJjdSFnVSQ0BJyqp6Q0PU+VHz/oWL/qX+io5AxjJjKNlJOPFWtyNGqQFItIu5ui+Mv2lmFOzFIRktTjkj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faYG1S5H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=quEfw2XF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=n+KjMYAZLGEDJxI3B3i6sbn1UtVOk5NyH0khJa1KYiw=;
	b=faYG1S5H3K8aLw/XnDhDiPpNvA6UCw+fhPYjX6LBWRKb40vVXypHhSFDFfMMAQ+V6ACp/s
	KkbNOWFTCDaqfPXZWW+ZNtUEp0CxlnBvQFQBei+xh8ovHJuc9Wfbcl4q3wuck0VGGw++d4
	N11DKqNWHErlw5T16Pc/GyZ7aYbjVmAjRSfqnruS8CvotKkiAnyZxFLDE9BDCtZufU2nFD
	WcPcYLVLo6rYMNOXv3o9HVYeDbYjB0KTlHuKXplY9jCVUCaAPykeuS3nlIcvKSDMacqDs9
	QHNwAah072D6KlZOkZLWb8rrm3Jn2HVI7TQSgctddMm4i2uUOElTosl9Dvbayg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=n+KjMYAZLGEDJxI3B3i6sbn1UtVOk5NyH0khJa1KYiw=;
	b=quEfw2XFsWRtlTh5sAVc4LT7Ph1xbsUxJTNBvIUUsIpDSjheVmIO7Gn7L5UHAsqbt3DIdM
	4Q8SyUdUvJJ2MwCg==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: core: Move threshold out of struct
 thermal_trip
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193695.10875.11508915625266450964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     daeeb032f42d066a49e07b7f6effc9f51b7a5479
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//daeeb032f42d066a49e07b7f6effc9f51b7a5479
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Tue, 02 Apr 2024 20:56:43 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 16:01:20 +02:00

thermal: core: Move threshold out of struct thermal_trip

The threshold field in struct thermal_trip is only used internally by
the thermal core and it is better to prevent drivers from misusing it.
It also takes some space unnecessarily in the trip tables passed by
drivers to the core during thermal zone registration.

For this reason, introduce struct thermal_trip_desc as a wrapper around
struct thermal_trip, move the threshold field directly into it and make
the thermal core store struct thermal_trip_desc objects in the internal
thermal zone trip tables.  Adjust all of the code using trip tables in
the thermal core accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_fair_share.c      |  7 ++--
 drivers/thermal/gov_power_allocator.c |  6 ++-
 drivers/thermal/thermal_core.c        | 46 +++++++++++++++-----------
 drivers/thermal/thermal_core.h        |  7 ++--
 drivers/thermal/thermal_debugfs.c     |  6 ++-
 drivers/thermal/thermal_helpers.c     |  8 +++--
 drivers/thermal/thermal_netlink.c     |  6 ++-
 drivers/thermal/thermal_sysfs.c       | 20 +++++------
 drivers/thermal/thermal_trip.c        | 15 ++++----
 include/linux/thermal.h               |  9 +++--
 10 files changed, 78 insertions(+), 52 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_shar=
e.c
index 4da25a0..6ef8cfd 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -17,10 +17,13 @@
=20
 static int get_trip_level(struct thermal_zone_device *tz)
 {
-	const struct thermal_trip *trip, *level_trip =3D NULL;
+	const struct thermal_trip *level_trip =3D NULL;
+	const struct thermal_trip_desc *td;
 	int trip_level =3D -1;
=20
-	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		if (trip->temperature >=3D tz->temperature)
 			continue;
=20
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_powe=
r_allocator.c
index e25e48d..ac1d021 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -496,9 +496,11 @@ static void get_governor_trips(struct thermal_zone_devic=
e *tz,
 	const struct thermal_trip *first_passive =3D NULL;
 	const struct thermal_trip *last_passive =3D NULL;
 	const struct thermal_trip *last_active =3D NULL;
-	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
+
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
=20
-	for_each_trip(tz, trip) {
 		switch (trip->type) {
 		case THERMAL_TRIP_PASSIVE:
 			if (!first_passive) {
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 34a31bc..fc6ff0a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -361,17 +361,19 @@ static void handle_critical_trips(struct thermal_zone_d=
evice *tz,
 }
=20
 static void handle_thermal_trip(struct thermal_zone_device *tz,
-				struct thermal_trip *trip)
+				struct thermal_trip_desc *td)
 {
+	const struct thermal_trip *trip =3D &td->trip;
+
 	if (trip->temperature =3D=3D THERMAL_TEMP_INVALID)
 		return;
=20
 	if (tz->last_temperature =3D=3D THERMAL_TEMP_INVALID) {
 		/* Initialization. */
-		trip->threshold =3D trip->temperature;
-		if (tz->temperature >=3D trip->threshold)
-			trip->threshold -=3D trip->hysteresis;
-	} else if (tz->last_temperature < trip->threshold) {
+		td->threshold =3D trip->temperature;
+		if (tz->temperature >=3D td->threshold)
+			td->threshold -=3D trip->hysteresis;
+	} else if (tz->last_temperature < td->threshold) {
 		/*
 		 * The trip threshold is equal to the trip temperature, unless
 		 * the latter has changed in the meantime.  In either case,
@@ -382,9 +384,9 @@ static void handle_thermal_trip(struct thermal_zone_devic=
e *tz,
 		if (tz->temperature >=3D trip->temperature) {
 			thermal_notify_tz_trip_up(tz, trip);
 			thermal_debug_tz_trip_up(tz, trip);
-			trip->threshold =3D trip->temperature - trip->hysteresis;
+			td->threshold =3D trip->temperature - trip->hysteresis;
 		} else {
-			trip->threshold =3D trip->temperature;
+			td->threshold =3D trip->temperature;
 		}
 	} else {
 		/*
@@ -400,9 +402,9 @@ static void handle_thermal_trip(struct thermal_zone_devic=
e *tz,
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz, trip);
 			thermal_debug_tz_trip_down(tz, trip);
-			trip->threshold =3D trip->temperature;
+			td->threshold =3D trip->temperature;
 		} else {
-			trip->threshold =3D trip->temperature - trip->hysteresis;
+			td->threshold =3D trip->temperature - trip->hysteresis;
 		}
 	}
=20
@@ -458,7 +460,7 @@ static void thermal_zone_device_init(struct thermal_zone_=
device *tz)
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
-	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
=20
 	if (tz->suspended)
 		return;
@@ -472,8 +474,8 @@ void __thermal_zone_device_update(struct thermal_zone_dev=
ice *tz,
=20
 	tz->notify_event =3D event;
=20
-	for_each_trip(tz, trip)
-		handle_thermal_trip(tz, trip);
+	for_each_trip_desc(tz, td)
+		handle_thermal_trip(tz, td);
=20
 	monitor_thermal_zone(tz);
 }
@@ -766,7 +768,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_=
device *tz,
 	if (trip_index < 0 || trip_index >=3D tz->num_trips)
 		return -EINVAL;
=20
-	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index], cdev,
+	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
 					 upper, lower, weight);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
@@ -825,7 +827,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zon=
e_device *tz,
 	if (trip_index < 0 || trip_index >=3D tz->num_trips)
 		return -EINVAL;
=20
-	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index], cdev);
+	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
=20
@@ -1221,16 +1223,19 @@ static void thermal_set_delay_jiffies(unsigned long *=
delay_jiffies, int delay_ms
=20
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
-	int i, ret =3D -EINVAL;
+	const struct thermal_trip_desc *td;
+	int ret =3D -EINVAL;
=20
 	if (tz->ops.get_crit_temp)
 		return tz->ops.get_crit_temp(tz, temp);
=20
 	mutex_lock(&tz->lock);
=20
-	for (i =3D 0; i < tz->num_trips; i++) {
-		if (tz->trips[i].type =3D=3D THERMAL_TRIP_CRITICAL) {
-			*temp =3D tz->trips[i].temperature;
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
+		if (trip->type =3D=3D THERMAL_TRIP_CRITICAL) {
+			*temp =3D trip->temperature;
 			ret =3D 0;
 			break;
 		}
@@ -1274,7 +1279,9 @@ thermal_zone_device_register_with_trips(const char *typ=
e,
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay)
 {
+	const struct thermal_trip *trip =3D trips;
 	struct thermal_zone_device *tz;
+	struct thermal_trip_desc *td;
 	int id;
 	int result;
 	struct thermal_governor *governor;
@@ -1339,7 +1346,8 @@ thermal_zone_device_register_with_trips(const char *typ=
e,
 	tz->device.class =3D thermal_class;
 	tz->devdata =3D devdata;
 	tz->num_trips =3D num_trips;
-	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
+	for_each_trip_desc(tz, td)
+		td->trip =3D *trip++;
=20
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0d8a42b..4ad9c67 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -120,8 +120,11 @@ void thermal_governor_update_tz(struct thermal_zone_devi=
ce *tz,
 				enum thermal_notify_event reason);
=20
 /* Helpers */
-#define for_each_trip(__tz, __trip)	\
-	for (__trip =3D __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip=
++)
+#define for_each_trip_desc(__tz, __td)	\
+	for (__td =3D __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
+
+#define trip_to_trip_desc(__trip)	\
+	container_of(__trip, struct thermal_trip_desc, trip)
=20
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_debu=
gfs.c
index c617e8b..78c4cb3 100644
--- a/drivers/thermal/thermal_debugfs.c
+++ b/drivers/thermal/thermal_debugfs.c
@@ -744,7 +744,7 @@ static void tze_seq_stop(struct seq_file *s, void *v)
 static int tze_seq_show(struct seq_file *s, void *v)
 {
 	struct thermal_zone_device *tz =3D s->private;
-	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
 	struct tz_episode *tze;
 	const char *type;
 	int trip_id;
@@ -757,7 +757,9 @@ static int tze_seq_show(struct seq_file *s, void *v)
=20
 	seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  durat=
ion  |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
=20
-	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		/*
 		 * There is no possible mitigation happening at the
 		 * critical trip point, so the stats will be always
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_help=
ers.c
index c5a057b..d9f4e26 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -50,7 +50,7 @@ get_thermal_instance(struct thermal_zone_device *tz,
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
=20
-	trip =3D &tz->trips[trip_index];
+	trip =3D &tz->trips[trip_index].trip;
=20
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
 		if (pos->tz =3D=3D tz && pos->trip =3D=3D trip && pos->cdev =3D=3D cdev) {
@@ -82,7 +82,7 @@ EXPORT_SYMBOL(get_thermal_instance);
  */
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	int crit_temp =3D INT_MAX;
 	int ret =3D -EINVAL;
=20
@@ -91,7 +91,9 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz,=
 int *temp)
 	ret =3D tz->ops.get_temp(tz, temp);
=20
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
-		for_each_trip(tz, trip) {
+		for_each_trip_desc(tz, td) {
+			const struct thermal_trip *trip =3D &td->trip;
+
 			if (trip->type =3D=3D THERMAL_TRIP_CRITICAL) {
 				crit_temp =3D trip->temperature;
 				break;
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netl=
ink.c
index 76a231a..0ef6368 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -445,7 +445,7 @@ out_cancel_nest:
 static int thermal_genl_cmd_tz_get_trip(struct param *p)
 {
 	struct sk_buff *msg =3D p->msg;
-	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	struct thermal_zone_device *tz;
 	struct nlattr *start_trip;
 	int id;
@@ -465,7 +465,9 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
=20
 	mutex_lock(&tz->lock);
=20
-	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
+
 		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
 				thermal_zone_trip_id(tz, trip)) ||
 		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip->type) ||
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5b533fa..88211cc 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -88,7 +88,7 @@ trip_point_type_show(struct device *dev, struct device_attr=
ibute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) !=3D 1)
 		return -EINVAL;
=20
-	switch (tz->trips[trip_id].type) {
+	switch (tz->trips[trip_id].trip.type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -120,7 +120,7 @@ trip_point_temp_store(struct device *dev, struct device_a=
ttribute *attr,
=20
 	mutex_lock(&tz->lock);
=20
-	trip =3D &tz->trips[trip_id];
+	trip =3D &tz->trips[trip_id].trip;
=20
 	if (temp !=3D trip->temperature) {
 		if (tz->ops.set_trip_temp) {
@@ -150,7 +150,7 @@ trip_point_temp_show(struct device *dev, struct device_at=
tribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) !=3D 1)
 		return -EINVAL;
=20
-	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
 }
=20
 static ssize_t
@@ -171,7 +171,7 @@ trip_point_hyst_store(struct device *dev, struct device_a=
ttribute *attr,
=20
 	mutex_lock(&tz->lock);
=20
-	trip =3D &tz->trips[trip_id];
+	trip =3D &tz->trips[trip_id].trip;
=20
 	if (hyst !=3D trip->hysteresis) {
 		trip->hysteresis =3D hyst;
@@ -194,7 +194,7 @@ trip_point_hyst_show(struct device *dev, struct device_at=
tribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) !=3D 1)
 		return -EINVAL;
=20
-	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
+	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
 }
=20
 static ssize_t
@@ -393,7 +393,7 @@ static const struct attribute_group *thermal_zone_attribu=
te_groups[] =3D {
  */
 static int create_trip_attrs(struct thermal_zone_device *tz)
 {
-	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	struct attribute **attrs;
=20
 	/* This function works only for zones with at least one trip */
@@ -429,8 +429,8 @@ static int create_trip_attrs(struct thermal_zone_device *=
tz)
 		return -ENOMEM;
 	}
=20
-	for_each_trip(tz, trip) {
-		int indx =3D thermal_zone_trip_id(tz, trip);
+	for_each_trip_desc(tz, td) {
+		int indx =3D thermal_zone_trip_id(tz, &td->trip);
=20
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
@@ -452,7 +452,7 @@ static int create_trip_attrs(struct thermal_zone_device *=
tz)
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show =3D trip_point_temp_show;
-		if (trip->flags & THERMAL_TRIP_FLAG_RW_TEMP) {
+		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_TEMP) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =3D
 							trip_point_temp_store;
@@ -467,7 +467,7 @@ static int create_trip_attrs(struct thermal_zone_device *=
tz)
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_show;
-		if (trip->flags & THERMAL_TRIP_FLAG_RW_HYST) {
+		if (td->trip.flags & THERMAL_TRIP_FLAG_RW_HYST) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =3D
 					trip_point_hyst_store;
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 497abf0..7cf43b6 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -13,11 +13,11 @@ int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data)
 {
-	struct thermal_trip *trip;
+	struct thermal_trip_desc *td;
 	int ret;
=20
-	for_each_trip(tz, trip) {
-		ret =3D cb(trip, data);
+	for_each_trip_desc(tz, td) {
+		ret =3D cb(&td->trip, data);
 		if (ret)
 			return ret;
 	}
@@ -63,7 +63,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
  */
 void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
-	const struct thermal_trip *trip;
+	const struct thermal_trip_desc *td;
 	int low =3D -INT_MAX, high =3D INT_MAX;
 	int ret;
=20
@@ -72,7 +72,8 @@ void __thermal_zone_set_trips(struct thermal_zone_device *t=
z)
 	if (!tz->ops.set_trips)
 		return;
=20
-	for_each_trip(tz, trip) {
+	for_each_trip_desc(tz, td) {
+		const struct thermal_trip *trip =3D &td->trip;
 		int trip_low;
=20
 		trip_low =3D trip->temperature - trip->hysteresis;
@@ -110,7 +111,7 @@ int __thermal_zone_get_trip(struct thermal_zone_device *t=
z, int trip_id,
 	if (!tz || trip_id < 0 || trip_id >=3D tz->num_trips || !trip)
 		return -EINVAL;
=20
-	*trip =3D tz->trips[trip_id];
+	*trip =3D tz->trips[trip_id].trip;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
@@ -135,7 +136,7 @@ int thermal_zone_trip_id(const struct thermal_zone_device=
 *tz,
 	 * Assume the trip to be located within the bounds of the thermal
 	 * zone's trips[] table.
 	 */
-	return trip - tz->trips;
+	return trip_to_trip_desc(trip) - tz->trips;
 }
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c33f501..67bd133 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -61,7 +61,6 @@ enum thermal_notify_event {
  * struct thermal_trip - representation of a point in temperature domain
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
- * @threshold: trip crossing notification threshold miliCelsius
  * @type: trip point type
  * @priv: pointer to driver data associated with this trip
  * @flags: flags representing binary properties of the trip
@@ -69,12 +68,16 @@ enum thermal_notify_event {
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
-	int threshold;
 	enum thermal_trip_type type;
 	u8 flags;
 	void *priv;
 };
=20
+struct thermal_trip_desc {
+	struct thermal_trip trip;
+	int threshold;
+};
+
 #define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
 #define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
=20
@@ -203,7 +206,7 @@ struct thermal_zone_device {
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
-	struct thermal_trip trips[] __counted_by(num_trips);
+	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
=20
 /**

