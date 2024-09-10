Return-Path: <linux-pm+bounces-13930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD27972E1B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B561F21E9B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9E518B477;
	Tue, 10 Sep 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RCkOyiCk"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC331891A1;
	Tue, 10 Sep 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961168; cv=none; b=ECcMQE7kMddmAnikqmh6Qt4XQ3A1KQ+OhHOSM39n896j5sbe3a9OsIqwSq0TIXhQHnoZvvVZHmYYu+3OjdpvSW+BHbnnbtCRR4gzom/aTnUpS/1z6PQq9C/RiTUfPai0aGMe2DyQXSs9PNnpKxBmbhI4Ez3SANJu08vv2EfD/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961168; c=relaxed/simple;
	bh=Uj/sl+T25qrRr38QlD3fqLUWWSOsn0W+6LPzNqo0/ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9a9uDr/fpP4W+Jh1RJG/Lb5oljJ9yARye8Kv+An5R7KVdlT9WmUcR2ju4+Jn/capB7pRk3JLn7ausX6Ud6vjZY77/FxaKvogFoHbryNYwT0XTbKE+ajsI+cSG5ME8h73eOABxu8AyTzuzotKtspWGjd6PjLcJfKs37QlU2KOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RCkOyiCk reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id f9c7542ddd4df7b8; Tue, 10 Sep 2024 11:39:23 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 079806B836C;
	Tue, 10 Sep 2024 11:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725961163;
	bh=Uj/sl+T25qrRr38QlD3fqLUWWSOsn0W+6LPzNqo0/ZQ=;
	h=From:Subject:Date;
	b=RCkOyiCklvWugGE3eGLg3GcDvW3YaZa7BJbjLnHkU+bn7C/zOLQIOES8gTLnmvu3Q
	 iiqUEzcEUhJ37ajqv/20ymsSFAfo1wjPn0xRn/P/Gxch6D5pyTxCsmUjeQ8I+4jLhU
	 E9Bnz7Q5ATUBgIfW9+wDeMTSA3jsEs5ZLaE3fHGLA6sfv+7aWr/e2ofArjzvoDrov1
	 v6yH3RUtdZO4r3Ri0n9tkfSEPQOYxnN8+USdX+Duz6Qesu4dbqzd/buw37CPmFeafZ
	 SMboQ6GKploIhqok0M5mTF1RKbPXzdr8gUp5rQHsuKQW7lHvJ1ONV36qT7AfO8IHiY
	 QGM0Ltt4BI3Qg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH for 6.13 v1 3/8] thermal: core: Build sorted lists instead of sorting
 them later
Date: Tue, 10 Sep 2024 11:30:13 +0200
Message-ID: <3316488.44csPzL39Z@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Large numbers of trip points are not expected to be crossed in one go,
so quite likely it is more efficient to build a sorted list of crossed
trip points than to put them on an unsorted list and sort it later.

Moreover, trip points are often provided in ascending temperature order
during thermal zone registration. so they are naturally sorted anyway
and building a sorted list out of them is quite straightforward.

Accordingly, make handle_thermal_trip() maintain list ordering when
adding trip points to the lists and get rid of separate list sorting
in __thermal_zone_device_update().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
-#include <linux/list_sort.h>
 #include <linux/thermal.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -421,6 +420,21 @@ static void handle_critical_trips(struct
 		tz->ops.hot(tz);
 }
 
+static void add_trip_to_sorted_list(struct thermal_trip_desc *td,
+				    struct list_head *list)
+{
+	struct thermal_trip_desc *entry;
+
+	/* Assume that the new entry is likely to be the last one. */
+	list_for_each_entry_reverse(entry, list, notify_list_node) {
+		if (entry->notify_temp <= td->notify_temp) {
+			list_add(&td->notify_list_node, &entry->notify_list_node);
+			return;
+		}
+	}
+	list_add(&td->notify_list_node, list);
+}
+
 static void handle_thermal_trip(struct thermal_zone_device *tz,
 				struct thermal_trip_desc *td,
 				struct list_head *way_up_list,
@@ -450,8 +464,8 @@ static void handle_thermal_trip(struct t
 		 * In that case, the trip temperature becomes the new threshold.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			list_add(&td->notify_list_node, way_down_list);
 			td->notify_temp = trip->temperature - trip->hysteresis;
+			add_trip_to_sorted_list(td, way_down_list);
 
 			if (trip->type == THERMAL_TRIP_PASSIVE) {
 				tz->passive--;
@@ -466,8 +480,9 @@ static void handle_thermal_trip(struct t
 		 * if the zone temperature exceeds the trip one.  The new
 		 * threshold is then set to the low temperature of the trip.
 		 */
-		list_add_tail(&td->notify_list_node, way_up_list);
 		td->notify_temp = trip->temperature;
+		add_trip_to_sorted_list(td, way_up_list);
+
 		td->threshold -= trip->hysteresis;
 
 		if (trip->type == THERMAL_TRIP_PASSIVE)
@@ -531,16 +546,6 @@ static void thermal_trip_crossed(struct
 	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
 }
 
-static int thermal_trip_notify_cmp(void *not_used, const struct list_head *a,
-				   const struct list_head *b)
-{
-	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
-						     notify_list_node);
-	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
-						     notify_list_node);
-	return tda->notify_temp - tdb->notify_temp;
-}
-
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
@@ -591,11 +596,9 @@ void __thermal_zone_device_update(struct
 
 	thermal_zone_set_trips(tz, low, high);
 
-	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, true);
 
-	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
 	list_for_each_entry_reverse(td, &way_down_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, false);
 




