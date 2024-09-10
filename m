Return-Path: <linux-pm+bounces-13943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F01973437
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 12:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F48D1F25ABF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E01940B3;
	Tue, 10 Sep 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fQeQ0hhn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D8194080;
	Tue, 10 Sep 2024 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964544; cv=none; b=gTXN0qpg7qHJODTg6/niYrb9YBX1WbH8vEMFeugZq8pTnW/HK887qBLzQb1knoF8gKwImnkrne+WtxxF+ziz9b2Icn9ZLvUJTCOtaX7SmHvxjgAkHDDP9QwPqwiGYzMVN+0Iq1LoSuJcW7h4yxDVcJchl2nbs3xVk0EhFuzXU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964544; c=relaxed/simple;
	bh=1lMwBCl9f+Yjv3w/UaM4GEROEvfctQuREDnQV9MTNLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VY6bsSX94srQMWOh9jLTeDuDbGgCpuQqXqvzpmU79Ma+zL9PxRcPHWW6aMnYAbwXuvqbZUdbaEbB84PmNguGxV0TX0A59nyUwySW1Lx4K7qgc+TZ/Ja3UKJs9pImRWoAhJwugwPZZ/mw4lmBMExaeHwGBPvn8qO09IzagGmIgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fQeQ0hhn reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 10e21e6ff6389992; Tue, 10 Sep 2024 11:35:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5508B6B836A;
	Tue, 10 Sep 2024 11:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725960939;
	bh=1lMwBCl9f+Yjv3w/UaM4GEROEvfctQuREDnQV9MTNLM=;
	h=From:Subject:Date;
	b=fQeQ0hhnp7iG5PcUOPX9EbFFM0IPZEOWyZYW9EKDPrg65icq5FyjWjUjPItEb6JaB
	 hRsiEKVQPUMgfWSYg4ojubu1/djC6qrwo2eUCJaYdCz73c+iUthdSHZ1nP+F3SOuAq
	 +US7NHesbssyTX2elZEPw9RGIByIkTWXA/zKkkN5uuAksZ2R1CsbyOupgOGHc3zJec
	 I4cdBAUUtCQjNyqbCc3quknQHyHkEUwRztBTG3+ryVyPc/RTIdlPEhqPQuJNimgqpA
	 BEr4YS+7Mq4SoNrFRCZTdP/TRXnikSZKMg5UaOppx/CBLtznZxHLxVD7WsBC1/kUVJ
	 M6AiL5PzGQrwA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH for 6.13 v1 7/8] thermal: core: Use trip lists for trip crossing
 detection
Date: Tue, 10 Sep 2024 11:34:29 +0200
Message-ID: <3584535.iIbC2pHGDl@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the thermal core to use three lists of trip points:

 trips_above containing trips with thresholds strictly above the current
             thermal zone temperature,

 trips_below containing trips with thresholds at or below the current
             zone temperature,

 trips_invalid containing trips with temperature equal to
               THERMAL_ZONE_INVALID,

where the first two lists are always sorted.

For each trip in trips_above, there is no mitigation under way and
the trip threshold is equal to its temperature.  In turn, for each
trip in trips_below, there is mitigation under way and the trip
threshold is equal to its low temperature.  The trips in trips_invalid,
of course, need not be taken into consideration.

The idea is to make __thermal_zone_device_update() walk trips_above
and trips_below instead of walking the entire table of trip points
in the thermal zone.  Usually, it will only need to walk a few entries
in one of the lists and check one entry in the other one, depending
on the direction of the zone temperature changes, because crossing
many trips by the zone temperature in one go between two consecutive
temperature checks should be unlikely (if this happens, the thermal
zone temperature is checked too rarely or not at the right time).

Moreover, because the lists are sorted, the low and high values needed
by thermal_zone_set_trips() can be determined in a straightforward way
by looking at one end of each list.

Of course, additional work is needed in some places in order to
maintain the ordering of the lists, but it happens in situations
that should be rare, like updating a trip point temperature or
hysteresis, at the thermal zone initialization time or during
system resume.

Going forward, the trips_below and trips_above lists can be used
by thermal governors to reduce overhead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |  150 ++++++++++++++++++++---------------------
 drivers/thermal/thermal_core.h |    7 +
 drivers/thermal/thermal_trip.c |   69 +++++++++++++-----
 3 files changed, 132 insertions(+), 94 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -420,64 +420,6 @@ static void handle_critical_trips(struct
 		tz->ops.hot(tz);
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
-			thermal_trip_move_to_sorted_list(td, way_down_list);
-
-			if (trip->type == THERMAL_TRIP_PASSIVE) {
-				tz->passive--;
-				WARN_ON(tz->passive < 0);
-			}
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
-		thermal_trip_move_to_sorted_list(td, way_up_list);
-
-		td->threshold -= trip->hysteresis;
-
-		if (trip->type == THERMAL_TRIP_PASSIVE)
-			tz->passive++;
-		else if (trip->type == THERMAL_TRIP_CRITICAL ||
-			 trip->type == THERMAL_TRIP_HOT)
-			handle_critical_trips(tz, trip);
-	}
-}
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -486,9 +428,16 @@ static void thermal_zone_device_check(st
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
+static void move_trip_to_trips_above(struct thermal_trip_desc *td,
+				     struct thermal_zone_device *tz)
+{
+	td->threshold = td->trip.temperature;
+	thermal_trip_move_to_sorted_list(td, &tz->trips_above);
+}
+
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
-	struct thermal_trip_desc *td;
+	struct thermal_trip_desc *td, *next;
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
@@ -502,6 +451,16 @@ static void thermal_zone_device_init(str
 		list_for_each_entry(instance, &td->thermal_instances, trip_node)
 			instance->initialized = false;
 	}
+	list_for_each_entry_safe(td, next, &tz->trips_invalid, list_node) {
+		if (td->trip.temperature != THERMAL_TEMP_INVALID)
+			move_trip_to_trips_above(td, tz);
+	}
+	list_for_each_entry_safe(td, next, &tz->trips_below, list_node) {
+		if (td->trip.temperature == THERMAL_TEMP_INVALID)
+			list_move(&td->list_node, &tz->trips_invalid);
+		else
+			move_trip_to_trips_above(td, tz);
+	}
 }
 
 static void thermal_governor_trip_crossed(struct thermal_governor *governor,
@@ -569,27 +528,71 @@ void __thermal_zone_device_update(struct
 
 	tz->notify_event = event;
 
-	for_each_trip_desc(tz, td) {
-		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
+	/* Check trips that were previously above the zone temperature. */
+	list_for_each_entry_safe(td, next, &tz->trips_above, list_node) {
+		struct thermal_trip *trip = &td->trip;
 
-		if (td->threshold <= tz->temperature && td->threshold > low)
-			low = td->threshold;
+		if (td->threshold > tz->temperature)
+			break;
+
+		/*
+		 * There is no mitigation under way, so it needs to be started.
+		 * Move the trip to the "crossed on the way up" list (sorted by
+		 * the old threshold) and set the new threshold to the low
+		 * temperature of the trip.
+		 */
+		thermal_trip_move_to_sorted_list(td, &way_up_list);
+		td->threshold = trip->temperature - trip->hysteresis;
 
-		if (td->threshold >= tz->temperature && td->threshold < high)
-			high = td->threshold;
+		if (trip->type == THERMAL_TRIP_PASSIVE)
+			tz->passive++;
+		else if (trip->type == THERMAL_TRIP_CRITICAL ||
+			 trip->type == THERMAL_TRIP_HOT)
+			handle_critical_trips(tz, trip);
 	}
+	/* Check trips that were previously below or at the zone temperature. */
+	list_for_each_entry_safe_reverse(td, next, &tz->trips_below, list_node) {
+		struct thermal_trip *trip = &td->trip;
 
-	thermal_zone_set_trips(tz, low, high);
+		if (td->threshold <= tz->temperature)
+			break;
+
+		/*
+		 * Mitigation is under way, so it needs to stop.  Move the trip
+		 * to the "crossed on the way down" list (sorted by the old
+		 * threshold) and set the new threshold to the trip temperature.
+		 */
+		thermal_trip_move_to_sorted_list(td, &way_down_list);
+		td->threshold = trip->temperature;
+
+		if (trip->type == THERMAL_TRIP_PASSIVE) {
+			tz->passive--;
+			WARN_ON(tz->passive < 0);
+		}
+	}
 
 	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
 		thermal_trip_crossed(tz, &td->trip, governor, true);
-		list_del_init(&td->list_node);
+		thermal_trip_move_to_sorted_list(td, &tz->trips_below);
 	}
 
 	list_for_each_entry_safe_reverse(td, next, &way_down_list, list_node) {
 		thermal_trip_crossed(tz, &td->trip, governor, false);
-		list_del_init(&td->list_node);
+		thermal_trip_move_to_sorted_list(td, &tz->trips_above);
+	}
+
+	if (!list_empty(&tz->trips_below)) {
+		td = list_last_entry(&tz->trips_below, struct thermal_trip_desc,
+				      list_node);
+		/* Avoid checks that don't correspond to trip crossing. */
+		low = td->threshold - 1;
+	}
+	if (!list_empty(&tz->trips_above)) {
+		td = list_first_entry(&tz->trips_above, struct thermal_trip_desc,
+				      list_node);
+		high = td->threshold;
 	}
+	thermal_zone_set_trips(tz, low, high);
 
 	if (governor->manage)
 		governor->manage(tz);
@@ -1409,6 +1412,9 @@ thermal_zone_device_register_with_trips(
 	}
 
 	INIT_LIST_HEAD(&tz->node);
+	INIT_LIST_HEAD(&tz->trips_above);
+	INIT_LIST_HEAD(&tz->trips_below);
+	INIT_LIST_HEAD(&tz->trips_invalid);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
 	init_completion(&tz->removal);
@@ -1432,13 +1438,7 @@ thermal_zone_device_register_with_trips(
 	for_each_trip_desc(tz, td) {
 		td->trip = *trip++;
 		INIT_LIST_HEAD(&td->thermal_instances);
-		INIT_LIST_HEAD(&td->list_node);
-		/*
-		 * Mark all thresholds as invalid to start with even though
-		 * this only matters for the trips that start as invalid and
-		 * become valid later.
-		 */
-		td->threshold = INT_MAX;
+		list_add(&td->list_node, &tz->trips_invalid);
 	}
 
 	tz->polling_delay_jiffies = msecs_to_jiffies(polling_delay);
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -31,7 +31,6 @@ struct thermal_trip_desc {
 	struct thermal_trip_attrs trip_attrs;
 	struct list_head list_node;
 	struct list_head thermal_instances;
-	int notify_temp;
 	int threshold;
 };
 
@@ -69,6 +68,9 @@ struct thermal_governor {
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
  * @resume:	resume completion
+ * @trips_above:	trips above the current zone temperature
+ * @trips_below:	trips equal to or below the current zone temperature
+ * @trips_invalid:	trips with invalid temperature
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
  * @num_trips:	number of trip points the thermal zone supports
@@ -111,6 +113,9 @@ struct thermal_zone_device {
 	struct completion removal;
 	struct completion resume;
 	struct attribute_group trips_attribute_group;
+	struct list_head trips_above;
+	struct list_head trips_below;
+	struct list_head trips_invalid;
 	enum thermal_device_mode mode;
 	void *devdata;
 	int num_trips;
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -100,7 +100,7 @@ void thermal_trip_move_to_sorted_list(st
 
 	/* Assume that the new entry is likely to be the last one. */
 	list_for_each_entry_reverse(entry, list, list_node) {
-		if (entry->notify_temp <= td->notify_temp) {
+		if (entry->threshold <= td->threshold) {
 			list_move(&td->list_node, &entry->list_node);
 			return;
 		}
@@ -111,39 +111,72 @@ void thermal_trip_move_to_sorted_list(st
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int hyst)
 {
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+
 	WRITE_ONCE(trip->hysteresis, hyst);
 	thermal_notify_tz_trip_change(tz, trip);
+	if (tz->temperature >= td->threshold) {
+		/*
+		 * The zone temperature was above or at the trip, so the trip's
+		 * new threshold should be equal to its low temperature.
+		 */
+		td->threshold = trip->temperature - hyst;
+		thermal_trip_move_to_sorted_list(td, &tz->trips_below);
+	}
 }
 
 void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int temp)
 {
+	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+	struct list_head *list;
+
 	if (trip->temperature == temp)
 		return;
 
+	if (trip->temperature == THERMAL_TEMP_INVALID) {
+		td->threshold = temp;
+		/*
+		 * Move the trip to the "trips above" list regardless of the new
+		 * temperature value because there is no mitigation going on for
+		 * it.  If mitigation needs to be started, it will be moved to
+		 * the "trips below" list later.
+		 */
+		thermal_trip_move_to_sorted_list(td, &tz->trips_above);
+		list = NULL;
+	} else if (tz->temperature >= td->threshold) {
+		/* The trip's threshold was below the zone temperature */
+		td->threshold = temp - trip->hysteresis;
+		list = &tz->trips_below;
+	} else {
+		/* The trip's threshold was above the zone temperature */
+		td->threshold = temp;
+		list = &tz->trips_above;
+	}
+
 	WRITE_ONCE(trip->temperature, temp);
 	thermal_notify_tz_trip_change(tz, trip);
 
-	if (temp == THERMAL_TEMP_INVALID) {
-		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+	if (!list)
+		return;
 
-		if (tz->temperature >= td->threshold) {
-			/*
-			 * The trip has been crossed on the way up, so some
-			 * adjustments are needed to compensate for the lack
-			 * of it going forward.
-			 */
-			if (trip->type == THERMAL_TRIP_PASSIVE) {
-				tz->passive--;
-				WARN_ON_ONCE(tz->passive < 0);
-			}
-			thermal_zone_trip_down(tz, trip);
-		}
+	if (temp != THERMAL_TEMP_INVALID) {
+		thermal_trip_move_to_sorted_list(td, list);
+		return;
+	}
+
+	if (tz->temperature >= td->threshold) {
 		/*
-		 * Invalidate the threshold to avoid triggering a spurious
-		 * trip crossing notification when the trip becomes valid.
+		 * The zone temperature was at or above the trip, so some
+		 * adjustments are needed to compensate for the lack of it
+		 * going forward.
 		 */
-		td->threshold = INT_MAX;
+		if (trip->type == THERMAL_TRIP_PASSIVE) {
+			tz->passive--;
+			WARN_ON_ONCE(tz->passive < 0);
+		}
+		thermal_zone_trip_down(tz, trip);
 	}
+	list_move(&td->list_node, &tz->trips_invalid);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);




