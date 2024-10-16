Return-Path: <linux-pm+bounces-15768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A3C9A088C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F6D1F23274
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8852208D76;
	Wed, 16 Oct 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="I1A/R+JG"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECD207A12;
	Wed, 16 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078633; cv=none; b=egk/7xhY51FmC/5cA2dkhfDBJUfTLAOyuuaUeO10k/zSGTra+UVRT9AHJPGQ8tsVTMU0rzW4s3Mm/WR8uosxHT4VtG3g0YByI77BLqBu0Xk3U4llD4ivj2rFfLGPmbriqf7ChqtmvXEZ+Zu2wLlxBdoZuMlhhYijKk2oXzttBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078633; c=relaxed/simple;
	bh=CPib/IepLpYJF0aVL689/AqLexuY6aQ13hrHJTU+VtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPQrz+NlTOhFfw3ZECOsU9s5mmbxWrCKCYzyZIRu7LIVj5SQN+dAIKEP7H6uuhERUrTfeuxrZO+iVZEP9sdyQSoIWIMY/Az7DJHFQBaqz/PP1IT52STvg2XNf8IVRFcYFjTVCxQlNq2PQ4qx2dDcptdGdQ+NKb51MOzLIipiIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=I1A/R+JG reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5651fb6d6094ba8b; Wed, 16 Oct 2024 13:37:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 140ABA93969;
	Wed, 16 Oct 2024 13:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078623;
	bh=CPib/IepLpYJF0aVL689/AqLexuY6aQ13hrHJTU+VtE=;
	h=From:Subject:Date;
	b=I1A/R+JGtVisb+/yKsdfNJz0bas1yQoZbgvXclkQOZrpYot6axdAWyAHay4Zlgpsp
	 ioJ8/U5nmqsFT6k29UBgLPvFOe33TxeuhTE2EDT63thj4dSlOBZc8jQRPQrU7kycCD
	 cJ2+SNqf8hxjCS82ZGbyCIf8jgKfHzXynUyhHa/RqETDaNtCCKZFbhPmRI6yqZb1Sk
	 22k51EWjOTns7ZGh9Cvjex2BKKS4QdIlby5Osne9QPSVumQLvfhVLtsmCQIOsf44qk
	 /LbxgivQaIF73+y0CsmNfMiHyvZzZjir3sZZPjmnFAm/hKWXFnouveR0Yb6A1L9Zbe
	 lPeFuFpIfH8DA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 01/10] thermal: core: Build sorted lists instead of sorting them
 later
Date: Wed, 16 Oct 2024 13:21:42 +0200
Message-ID: <4930656.GXAFRqVoOG@rjwysocki.net>
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

Since it is not expected that multiple trip points will be crossed
in one go very often (if this happens, there are too many trip points
in the given thermal zone or they are checked too rarely), quite likely
it is more efficient to build a sorted list of crossed trip points than
to put them on an unsorted list and sort it later.

Moreover, trip points are often sorted in ascending temperature order
during thermal zone registration. so building a sorted list out of
them is quite straightforward and relatively inexpensive.

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
@@ -409,6 +408,21 @@ static void handle_critical_trips(struct
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
@@ -438,8 +452,8 @@ static void handle_thermal_trip(struct t
 		 * In that case, the trip temperature becomes the new threshold.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			list_add(&td->notify_list_node, way_down_list);
 			td->notify_temp = trip->temperature - trip->hysteresis;
+			add_trip_to_sorted_list(td, way_down_list);
 
 			if (trip->type == THERMAL_TRIP_PASSIVE) {
 				tz->passive--;
@@ -454,8 +468,9 @@ static void handle_thermal_trip(struct t
 		 * if the zone temperature exceeds the trip one.  The new
 		 * threshold is then set to the low temperature of the trip.
 		 */
-		list_add_tail(&td->notify_list_node, way_up_list);
 		td->notify_temp = trip->temperature;
+		add_trip_to_sorted_list(td, way_up_list);
+
 		td->threshold -= trip->hysteresis;
 
 		if (trip->type == THERMAL_TRIP_PASSIVE)
@@ -519,16 +534,6 @@ static void thermal_trip_crossed(struct
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
@@ -581,11 +586,9 @@ void __thermal_zone_device_update(struct
 
 	thermal_zone_set_trips(tz, low, high);
 
-	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, true);
 
-	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
 	list_for_each_entry_reverse(td, &way_down_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, false);
 




