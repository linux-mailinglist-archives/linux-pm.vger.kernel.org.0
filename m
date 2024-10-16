Return-Path: <linux-pm+bounces-15760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF99A087D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3D91F225A0
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932F207A09;
	Wed, 16 Oct 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ZEEhhb6Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A04206051;
	Wed, 16 Oct 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078630; cv=none; b=rpBFj1LjGrhvsWhaa3maUcxWiGJ1J9KC9dOG/S/oNSM9ar+QNFzWEQ7yuK9pA1+BiC4xNkhf5lfZPTTE1tx3TCp9PTBP0qhNasXZjdOd3duhB4ds860FIUKFdOfxJKI35DP55j/Frut+gpPxPJEqsxpATLW9FIlgzePt6bAt9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078630; c=relaxed/simple;
	bh=B2fHSVo2XtIWOgoZGQpkPGJd8Q+1PaDkqB1156N9SEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgBvJO+33Po9cU/DB8iXsMj5L+ReLwqCaiaEf70hdvqh2ow/VqlJRj+kGxL3dGTSTUc5Tmk7oQrlKwjKk9i8OIgL/3QrgZbGmOP342txvOAVF/T2V4SkoS54Q6YO3/oZBUKI9l8NmA59W17LYPhtx1O/JVYJWhU8Tm4pL5LqNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ZEEhhb6Z reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 78062438f3f9e55c; Wed, 16 Oct 2024 13:37:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EE60EA9396A;
	Wed, 16 Oct 2024 13:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078620;
	bh=B2fHSVo2XtIWOgoZGQpkPGJd8Q+1PaDkqB1156N9SEY=;
	h=From:Subject:Date;
	b=ZEEhhb6ZNXQGEyjGgrVRbYVfvTb5B+Z9bqa3HarpOvpkEG5bDZazINgBaNpgWl98p
	 6IxgurIk4+m6Zoita6fESSNBtHgCJc/X+jP/lqy6aA044Upz4dO2Vs+JuKKooiN9eT
	 1SAl21BHa7llp+vFjQMurhGXnMs7k78JoMyr+qKjnEvvdobJsArMoUrLncbofNYvOo
	 wGkNKs2+KU6laOumyD6THbwPrPceMZwt+dNvRbXoGcgByPrWC7fAGkxcywOPHzhx62
	 4ge17N5Xjsg4nXvsVpKx3PY1DgQxGfMrDyqA3tO6NiUU+epuGsDGPX8rh54fPrlRtD
	 yyX24kCnz0rRQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 09/10] thermal: core: Use trip lists for trip crossing detection
Date: Wed, 16 Oct 2024 13:35:11 +0200
Message-ID: <2003443.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <4958885.31r3eYUQgx@rjwysocki.net>
References: <4958885.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the thermal core to use three lists of trip points:

 trips_high, containing trips with thresholds strictly above the current
 thermal zone temperature,

 trips_reached, containing trips with thresholds at or below the current
 zone temperature,

 trips_invalid, containing trips with temperature equal to
 THERMAL_ZONE_INVALID,

where the first two lists are always sorted by the current trip
threshold.

For each trip in trips_high, there is no mitigation under way and
the trip threshold is equal to its temperature.  In turn, for each
trip in trips_reached, there is mitigation under way and the trip
threshold is equal to its low temperature.  The trips in trips_invalid,
of course, need not be taken into consideration.

The idea is to make __thermal_zone_device_update() walk trips_high and
trips_reached instead of walking the entire table of trip points in a
thermal zone.  Usually, it will only need to walk a few entries in one
of the lists and check one entry in the other list, depending on the
direction of the zone temperature changes, because crossing many trips
by the zone temperature in one go between two consecutive temperature
checks should be unlikely (if it occurs often, the thermal zone
temperature should probably be checked more often either or there
are too many trips).

This also helps to eliminate one temporary trip list used for trip
crossing notification (only one temporary list is needed for this
purpose instead of two) and the remaining temporary list may be sorted
by the current trip threshold value, like the trips_reached list, so
the additional notify_temp field in struct thermal_trip_desc is not
necessary any more.

Moreover, since the trips_reached and trips_high lists are sorted,
the "low" and "high" values needed by thermal_zone_set_trips() can be
determined in a straightforward way by looking at one end of each list.

Of course, additional work is needed in some places in order to
maintain the ordering of the lists, but it is limited to situations
that should be rare, like updating a trip point temperature or
hysteresis, thermal zone initialization, or system resume.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |  211 +++++++++++++++++++++++++----------------
 drivers/thermal/thermal_core.h |    7 +
 2 files changed, 136 insertions(+), 82 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -33,7 +33,6 @@ struct thermal_trip_desc {
 	struct thermal_trip_attrs trip_attrs;
 	struct list_head list_node;
 	struct list_head thermal_instances;
-	int notify_temp;
 	int threshold;
 };
 
@@ -78,6 +77,9 @@ struct thermal_governor {
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
  * @resume:	resume completion
+ * @trips_high:	trips above the current zone temperature
+ * @trips_reached:	trips below or at the current zone temperature
+ * @trips_invalid:	trips with invalid temperature
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
  * @num_trips:	number of trip points the thermal zone supports
@@ -118,6 +120,9 @@ struct thermal_zone_device {
 	struct completion removal;
 	struct completion resume;
 	struct attribute_group trips_attribute_group;
+	struct list_head trips_high;
+	struct list_head trips_reached;
+	struct list_head trips_invalid;
 	enum thermal_device_mode mode;
 	void *devdata;
 	int num_trips;
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -421,7 +421,7 @@ static void move_trip_to_sorted_list(str
 
 	/* Assume that the new entry is likely to be the last one. */
 	list_for_each_entry_reverse(entry, list, list_node) {
-		if (entry->notify_temp <= td->notify_temp) {
+		if (entry->threshold <= td->threshold) {
 			list_add(&td->list_node, &entry->list_node);
 			return;
 		}
@@ -429,53 +429,6 @@ static void move_trip_to_sorted_list(str
 	list_add(&td->list_node, list);
 }
 
-static void handle_thermal_trip(struct thermal_zone_device *tz,
-				struct thermal_trip_desc *td,
-				struct list_head *way_up_list,
-				struct list_head *way_down_list)
-{
-	const struct thermal_trip *trip = &td->trip;
-	int old_threshold;
-
-	if (trip->temperature == THERMAL_TEMP_INVALID)
-		return;
-
-	/*
-	 * If the trip temperature or hysteresis has been updated recently,
-	 * the threshold needs to be computed again using the new values.
-	 * However, its initial value still reflects the old ones and that
-	 * is what needs to be compared with the previous zone temperature
-	 * to decide which action to take.
-	 */
-	old_threshold = td->threshold;
-	td->threshold = trip->temperature;
-
-	if (tz->last_temperature >= old_threshold &&
-	    tz->last_temperature != THERMAL_TEMP_INIT) {
-		/*
-		 * Mitigation is under way, so it needs to stop if the zone
-		 * temperature falls below the low temperature of the trip.
-		 * In that case, the trip temperature becomes the new threshold.
-		 */
-		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			td->notify_temp = trip->temperature - trip->hysteresis;
-			move_trip_to_sorted_list(td, way_down_list);
-		} else {
-			td->threshold -= trip->hysteresis;
-		}
-	} else if (tz->temperature >= trip->temperature) {
-		/*
-		 * There is no mitigation under way, so it needs to be started
-		 * if the zone temperature exceeds the trip one.  The new
-		 * threshold is then set to the low temperature of the trip.
-		 */
-		td->notify_temp = trip->temperature;
-		move_trip_to_sorted_list(td, way_up_list);
-
-		td->threshold -= trip->hysteresis;
-	}
-}
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -484,9 +437,30 @@ static void thermal_zone_device_check(st
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
+static void move_to_trips_high(struct thermal_zone_device *tz,
+			       struct thermal_trip_desc *td)
+{
+	td->threshold = td->trip.temperature;
+	move_trip_to_sorted_list(td, &tz->trips_high);
+}
+
+static void move_to_trips_reached(struct thermal_zone_device *tz,
+				  struct thermal_trip_desc *td)
+{
+	td->threshold = td->trip.temperature - td->trip.hysteresis;
+	move_trip_to_sorted_list(td, &tz->trips_reached);
+}
+
+static void move_to_trips_invalid(struct thermal_zone_device *tz,
+				  struct thermal_trip_desc *td)
+{
+	td->threshold = INT_MAX;
+	list_move(&td->list_node, &tz->trips_invalid);
+}
+
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
-	struct thermal_trip_desc *td;
+	struct thermal_trip_desc *td, *next;
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
@@ -500,6 +474,21 @@ static void thermal_zone_device_init(str
 		list_for_each_entry(instance, &td->thermal_instances, trip_node)
 			instance->initialized = false;
 	}
+	/*
+	 * At this point, all valid trips need to be moved to trips_high so that
+	 * mitigation can be started if the zone temperature is above them.
+	 */
+	list_for_each_entry_safe(td, next, &tz->trips_invalid, list_node) {
+		if (td->trip.temperature != THERMAL_TEMP_INVALID)
+			move_to_trips_high(tz, td);
+	}
+	/* The trips_reached list may not be empty during system resume. */
+	list_for_each_entry_safe(td, next, &tz->trips_reached, list_node) {
+		if (td->trip.temperature == THERMAL_TEMP_INVALID)
+			move_to_trips_invalid(tz, td);
+		else
+			move_to_trips_high(tz, td);
+	}
 }
 
 static void thermal_governor_trip_crossed(struct thermal_governor *governor,
@@ -544,45 +533,120 @@ static void thermal_trip_crossed(struct
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int hyst)
 {
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+
 	WRITE_ONCE(trip->hysteresis, hyst);
 	thermal_notify_tz_trip_change(tz, trip);
+	/*
+	 * If the zone temperature is above or at the trip tmperature, the trip
+	 * is in the trips_reached list and its threshold is equal to its low
+	 * temperature.  It needs to stay in that list, but its threshold needs
+	 * to be updated and the list ordering may need to be restored.
+	 */
+	if (tz->temperature >= td->threshold)
+		move_to_trips_reached(tz, td);
 }
 
 void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int temp)
 {
-	if (trip->temperature == temp)
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+	int old_temp = trip->temperature;
+
+	if (old_temp == temp)
 		return;
 
 	WRITE_ONCE(trip->temperature, temp);
 	thermal_notify_tz_trip_change(tz, trip);
 
-	if (temp == THERMAL_TEMP_INVALID) {
-		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+	if (old_temp == THERMAL_TEMP_INVALID) {
+		/*
+		 * The trip was invalid before the change, so move it to the
+		 * trips_high list regardless of the new temperature value
+		 * because there is no mitigation under way for it.  If a
+		 * mitigation needs to be started, the trip will be moved to the
+		 * trips_reached list later.
+		 */
+		move_to_trips_high(tz, td);
+		return;
+	}
 
+	if (temp == THERMAL_TEMP_INVALID) {
 		/*
-		 * If the trip has been crossed on the way up, some adjustments
-		 * are needed to compensate for the lack of it going forward.
+		 * If the trip is in the trips_reached list, mitigation is under
+		 * way for it and it needs to be stopped because the trip is
+		 * effectively going away.
 		 */
 		if (tz->temperature >= td->threshold)
 			thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
 
+		move_to_trips_invalid(tz, td);
+		return;
+	}
+
+	/*
+	 * The trip stays on its current list, but its threshold needs to be
+	 * updated due to the temperature change and the list ordering may need
+	 * to be restored.
+	 */
+	if (tz->temperature >= td->threshold)
+		move_to_trips_reached(tz, td);
+	else
+		move_to_trips_high(tz, td);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
+
+static void thermal_zone_handle_trips(struct thermal_zone_device *tz,
+				      struct thermal_governor *governor,
+				      int *low, int *high)
+{
+	struct thermal_trip_desc *td, *next;
+	LIST_HEAD(way_down_list);
+
+	/* Check the trips that were below or at the zone temperature. */
+	list_for_each_entry_safe_reverse(td, next, &tz->trips_reached, list_node) {
+		if (td->threshold <= tz->temperature)
+			break;
+
+		thermal_trip_crossed(tz, td, governor, false);
 		/*
-		 * Invalidate the threshold to avoid triggering a spurious
-		 * trip crossing notification when the trip becomes valid.
+		 * The current trips_high list needs to be processed before
+		 * adding new entries to it, so put them on a temporary list.
 		 */
-		td->threshold = INT_MAX;
+		list_move(&td->list_node, &way_down_list);
+	}
+	/* Check the trips that were previously above the zone temperature. */
+	list_for_each_entry_safe(td, next, &tz->trips_high, list_node) {
+		if (td->threshold > tz->temperature)
+			break;
+
+		thermal_trip_crossed(tz, td, governor, true);
+		move_to_trips_reached(tz, td);
+	}
+	list_for_each_entry_safe(td, next, &way_down_list, list_node)
+		move_to_trips_high(tz, td);
+
+	if (!list_empty(&tz->trips_reached)) {
+		td = list_last_entry(&tz->trips_reached,
+				     struct thermal_trip_desc, list_node);
+		/*
+		 * Set the "low" value below the current trip threshold in case
+		 * the zone temperature is at that threshold and stays there,
+		 * which would trigger a new interrupt immediately in vain.
+		 */
+		*low = td->threshold - 1;
+	}
+	if (!list_empty(&tz->trips_high)) {
+		td = list_first_entry(&tz->trips_high,
+				      struct thermal_trip_desc, list_node);
+		*high = td->threshold;
 	}
 }
-EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
 
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
 	struct thermal_governor *governor = thermal_get_tz_governor(tz);
-	struct thermal_trip_desc *td, *next;
-	LIST_HEAD(way_down_list);
-	LIST_HEAD(way_up_list);
 	int low = -INT_MAX, high = INT_MAX;
 	int temp, ret;
 
@@ -614,25 +678,7 @@ void __thermal_zone_device_update(struct
 
 	tz->notify_event = event;
 
-	for_each_trip_desc(tz, td) {
-		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
-
-		if (td->threshold <= tz->temperature && td->threshold > low)
-			low = td->threshold;
-
-		if (td->threshold >= tz->temperature && td->threshold < high)
-			high = td->threshold;
-	}
-
-	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
-		thermal_trip_crossed(tz, td, governor, true);
-		list_del_init(&td->list_node);
-	}
-
-	list_for_each_entry_safe_reverse(td, next, &way_down_list, list_node) {
-		thermal_trip_crossed(tz, td, governor, false);
-		list_del_init(&td->list_node);
-	}
+	thermal_zone_handle_trips(tz, governor, &low, &high);
 
 	thermal_thresholds_handle(tz, &low, &high);
 
@@ -1507,6 +1553,9 @@ thermal_zone_device_register_with_trips(
 	}
 
 	INIT_LIST_HEAD(&tz->node);
+	INIT_LIST_HEAD(&tz->trips_high);
+	INIT_LIST_HEAD(&tz->trips_reached);
+	INIT_LIST_HEAD(&tz->trips_invalid);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
 	init_completion(&tz->removal);
@@ -1536,7 +1585,7 @@ thermal_zone_device_register_with_trips(
 		 * this only matters for the trips that start as invalid and
 		 * become valid later.
 		 */
-		td->threshold = INT_MAX;
+		move_to_trips_invalid(tz, td);
 	}
 
 	tz->polling_delay_jiffies = msecs_to_jiffies(polling_delay);




