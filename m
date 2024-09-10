Return-Path: <linux-pm+bounces-13944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD329973438
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 12:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D50B1C24EEF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1925194137;
	Tue, 10 Sep 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="drATuo+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D917B50F;
	Tue, 10 Sep 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964544; cv=none; b=isSOUurfmJ/6Yst06SocuNF28jUU9cMStIkfHkgCwZOfA/sfpFcsvBDZzQWF8Kr/oF0cyWypx22eYDznsdfnXy0qdh9KvOXjzqJt/gr8wQG9l+yuXdE/sEWCBVs+k56sHIzaUJ1/Z+NuXo6v2zBbgeb0mDDvfiu59me5wNhMw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964544; c=relaxed/simple;
	bh=EjwxqU0E9VB+QozIQiYMMt3UTqBjXmxyMsecopMpiM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEjpmG4DsfKApiRF1g2rIcNo8auLShFDPQR0z4SjChQCRncJUqXCWfo4ZeZ4dVuuvnazdNN4o0YNRLgsVxUBAhm2eyhl+bvkD/1LNvSB0WHp+JH45wyfwVax2LA16NDaT3jhlh2yIo5Qe5uMGJeRqpAo7FgxGMe0wxaDzWq+tfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=drATuo+1 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 13f8732939dc558d; Tue, 10 Sep 2024 11:35:40 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 297646B836A;
	Tue, 10 Sep 2024 11:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725960940;
	bh=EjwxqU0E9VB+QozIQiYMMt3UTqBjXmxyMsecopMpiM4=;
	h=From:Subject:Date;
	b=drATuo+1gRCRizsT/9T1WUeJ35N1sKCStaq4DtL/DKMtsHzDi1ySXrmqgKa+Ja1bC
	 18G4GQHEo74PYvGWIDpuQSGGOqR7BsIs0xRJ+GUFf36KlzPNOXnP/7BUTYCk14BiDf
	 ZmAn2SLXRBz0WYhIQ/gg6Vgs9gfligOnqlCINcJOdqUfRdo+NjQCz7aL+vv2Odom6G
	 3k/F40KDZOHstecf3texTJhF+ob2KVwpalrEzXg3taBVMxZDwhEmlHOB1cHFaX3C+K
	 Fcz6INY43B34QPfogaLd81olhh2mxmzD4t2bC/nfhjbf9IxEZmagqLWPLjLCkY4FLz
	 PYFAaVmauf2lQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH for 6.13 v1 6/8] thermal: core: Add function for moving trips to
 sorted lists
Date: Tue, 10 Sep 2024 11:33:08 +0200
Message-ID: <7708886.EvYhyI6sBW@rjwysocki.net>
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

Subsequently, trips will be moved between sorted lists in multiple
places, so replace add_trip_to_sorted_list() with an analogous function
that will move a given trip to a given sorted list.

Call the new function thermal_trip_move_to_sorted_list() and put it into
the trips-related part of the code.

To allow list_move() used in the new function to work, initialize the
list_node fields of trip descriptors so they are always valid.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   30 ++++++++++--------------------
 drivers/thermal/thermal_core.h |    2 ++
 drivers/thermal/thermal_trip.c |   15 +++++++++++++++
 3 files changed, 27 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -420,21 +420,6 @@ static void handle_critical_trips(struct
 		tz->ops.hot(tz);
 }
 
-static void add_trip_to_sorted_list(struct thermal_trip_desc *td,
-				    struct list_head *list)
-{
-	struct thermal_trip_desc *entry;
-
-	/* Assume that the new entry is likely to be the last one. */
-	list_for_each_entry_reverse(entry, list, list_node) {
-		if (entry->notify_temp <= td->notify_temp) {
-			list_add(&td->list_node, &entry->list_node);
-			return;
-		}
-	}
-	list_add(&td->list_node, list);
-}
-
 static void handle_thermal_trip(struct thermal_zone_device *tz,
 				struct thermal_trip_desc *td,
 				struct list_head *way_up_list,
@@ -465,7 +450,7 @@ static void handle_thermal_trip(struct t
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			td->notify_temp = trip->temperature - trip->hysteresis;
-			add_trip_to_sorted_list(td, way_down_list);
+			thermal_trip_move_to_sorted_list(td, way_down_list);
 
 			if (trip->type == THERMAL_TRIP_PASSIVE) {
 				tz->passive--;
@@ -481,7 +466,7 @@ static void handle_thermal_trip(struct t
 		 * threshold is then set to the low temperature of the trip.
 		 */
 		td->notify_temp = trip->temperature;
-		add_trip_to_sorted_list(td, way_up_list);
+		thermal_trip_move_to_sorted_list(td, way_up_list);
 
 		td->threshold -= trip->hysteresis;
 
@@ -550,7 +535,7 @@ void __thermal_zone_device_update(struct
 				  enum thermal_notify_event event)
 {
 	struct thermal_governor *governor = thermal_get_tz_governor(tz);
-	struct thermal_trip_desc *td;
+	struct thermal_trip_desc *td, *next;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
 	int low = -INT_MAX, high = INT_MAX;
@@ -596,11 +581,15 @@ void __thermal_zone_device_update(struct
 
 	thermal_zone_set_trips(tz, low, high);
 
-	list_for_each_entry(td, &way_up_list, list_node)
+	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
 		thermal_trip_crossed(tz, &td->trip, governor, true);
+		list_del_init(&td->list_node);
+	}
 
-	list_for_each_entry_reverse(td, &way_down_list, list_node)
+	list_for_each_entry_safe_reverse(td, next, &way_down_list, list_node) {
 		thermal_trip_crossed(tz, &td->trip, governor, false);
+		list_del_init(&td->list_node);
+	}
 
 	if (governor->manage)
 		governor->manage(tz);
@@ -1443,6 +1432,7 @@ thermal_zone_device_register_with_trips(
 	for_each_trip_desc(tz, td) {
 		td->trip = *trip++;
 		INIT_LIST_HEAD(&td->thermal_instances);
+		INIT_LIST_HEAD(&td->list_node);
 		/*
 		 * Mark all thresholds as invalid to start with even though
 		 * this only matters for the trips that start as invalid and
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -256,6 +256,8 @@ const char *thermal_trip_type_name(enum
 void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
+void thermal_trip_move_to_sorted_list(struct thermal_trip_desc *td,
+				      struct list_head *list);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 void thermal_zone_trip_down(struct thermal_zone_device *tz,
 			    const struct thermal_trip *trip);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -93,6 +93,21 @@ int thermal_zone_trip_id(const struct th
 	return trip_to_trip_desc(trip) - tz->trips;
 }
 
+void thermal_trip_move_to_sorted_list(struct thermal_trip_desc *td,
+				      struct list_head *list)
+{
+	struct thermal_trip_desc *entry;
+
+	/* Assume that the new entry is likely to be the last one. */
+	list_for_each_entry_reverse(entry, list, list_node) {
+		if (entry->notify_temp <= td->notify_temp) {
+			list_move(&td->list_node, &entry->list_node);
+			return;
+		}
+	}
+	list_move(&td->list_node, list);
+}
+
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int hyst)
 {




