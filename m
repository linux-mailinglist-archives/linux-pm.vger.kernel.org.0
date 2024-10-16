Return-Path: <linux-pm+bounces-15762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112409A0882
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5716AB2573C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC63207A33;
	Wed, 16 Oct 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="atkJMUOP"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A77206E91;
	Wed, 16 Oct 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078631; cv=none; b=dXXVgbEXVNT2WtsE5h5tnY8Bchh+fi7kPBalbI06L3BGOwE0muj0FrupqxoflcwC1e9p8CECpdrCqAuY+GbymPN2Z7/W3smUaAyX02YbhhRMsDRW+JhaHgI4jeCX8HV2Nw974cIOLzwbcMeFq9Celht/rFpKkwW4m5+nP7lDdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078631; c=relaxed/simple;
	bh=3bGx0GrPWY7h9nQi80dx+5aXyhFQYJaeBZf3Mcw4HnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkPFzfLbU/OhpJ+pSsqNuObs5NSaKs6bIO61+DanD03f/3acYQUd9L/g+OdEYODBFF0bMXVSXT2XKlbCtAmqi/ECr0GbhCAGXLjTduOgnNingA7+i3snZORAwGB9E5kn+SUBMOj3dfVqvIFi90xpY26L+j2SgPaAlOWPu3VLB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=atkJMUOP reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 8e9a74f202b10ce0; Wed, 16 Oct 2024 13:37:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5D5B2A93969;
	Wed, 16 Oct 2024 13:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078622;
	bh=3bGx0GrPWY7h9nQi80dx+5aXyhFQYJaeBZf3Mcw4HnM=;
	h=From:Subject:Date;
	b=atkJMUOPPeRORQlu5PZJTRFgJoqG2l1C+c/FJNHOuGB/VZJNSX05lpf0X22x2yD44
	 wOIfwU4KAlLFUGnOaLUmZxmfP2YwJNBZ/LRW+UJfb6yobf5q6qOy/glCJoRZgFZqPY
	 blRDaSuP//wTIAqeBUcI3YzWYr+vGVdBQzjcT6ue7pPbW4wJBigo0UF2SQfAlBrj0W
	 xoHMHVoUx16I2fMPX0sQJ3a5O40i9kgpkH6ycTaXAKNSr1QTqOgQpkiYX+Iq2K4Np/
	 7MbFEQXXs0A3b0nKIAeWiViyF/Vd9hIn0cUcQUFoMItOsnZHT9euv2D5vMu6xP2a6h
	 SZl7FmCiM8xoA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 03/10] thermal: core: Prepare for moving trips between sorted lists
Date: Wed, 16 Oct 2024 13:24:57 +0200
Message-ID: <2960197.e9J7NaK4W3@rjwysocki.net>
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

Subsequently, trips will be moved between sorted lists in multiple
places, so replace add_trip_to_sorted_list() with an analogous
function, move_trip_to_sorted_list(), that will move a given trip
to a given sorted list.

To allow list_del() used in the new function to work, initialize the
list_node fields in trip descriptors where applicable so they are
always valid.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -408,11 +408,17 @@ static void handle_critical_trips(struct
 		tz->ops.hot(tz);
 }
 
-static void add_trip_to_sorted_list(struct thermal_trip_desc *td,
-				    struct list_head *list)
+static void move_trip_to_sorted_list(struct thermal_trip_desc *td,
+				     struct list_head *list)
 {
 	struct thermal_trip_desc *entry;
 
+	/*
+	 * Delete upfront and then add to make relocation within the same list
+	 * work.
+	 */
+	list_del(&td->list_node);
+
 	/* Assume that the new entry is likely to be the last one. */
 	list_for_each_entry_reverse(entry, list, list_node) {
 		if (entry->notify_temp <= td->notify_temp) {
@@ -453,7 +459,7 @@ static void handle_thermal_trip(struct t
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			td->notify_temp = trip->temperature - trip->hysteresis;
-			add_trip_to_sorted_list(td, way_down_list);
+			move_trip_to_sorted_list(td, way_down_list);
 
 			if (trip->type == THERMAL_TRIP_PASSIVE) {
 				tz->passive--;
@@ -469,7 +475,7 @@ static void handle_thermal_trip(struct t
 		 * threshold is then set to the low temperature of the trip.
 		 */
 		td->notify_temp = trip->temperature;
-		add_trip_to_sorted_list(td, way_up_list);
+		move_trip_to_sorted_list(td, way_up_list);
 
 		td->threshold -= trip->hysteresis;
 
@@ -538,7 +544,7 @@ void __thermal_zone_device_update(struct
 				  enum thermal_notify_event event)
 {
 	struct thermal_governor *governor = thermal_get_tz_governor(tz);
-	struct thermal_trip_desc *td;
+	struct thermal_trip_desc *td, *next;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
 	int low = -INT_MAX, high = INT_MAX;
@@ -586,11 +592,15 @@ void __thermal_zone_device_update(struct
 
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
@@ -1490,6 +1500,7 @@ thermal_zone_device_register_with_trips(
 	for_each_trip_desc(tz, td) {
 		td->trip = *trip++;
 		INIT_LIST_HEAD(&td->thermal_instances);
+		INIT_LIST_HEAD(&td->list_node);
 		/*
 		 * Mark all thresholds as invalid to start with even though
 		 * this only matters for the trips that start as invalid and




