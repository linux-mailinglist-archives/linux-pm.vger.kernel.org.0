Return-Path: <linux-pm+bounces-7721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9338C26A4
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863661F21979
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988E170886;
	Fri, 10 May 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GEEQcbXs"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADF12FB39;
	Fri, 10 May 2024 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350845; cv=none; b=fbdjtjaNZlbywN9bmufdyYNjaNDffaOLtubtYSaTVuTmBG5rAJ9YZ4pMVY0rqNfD+Fayf0+qW6tl/fk9xvB5iz7u2OYvKQ9ssGCKkqHn3W3S9CPAXi8Um8VMB9MzxapKayOq84WBWI+mgaUPsH7qmMFj1WCF9EvP54HweAod9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350845; c=relaxed/simple;
	bh=kj0fHUv9hccCyohXhp+3qUh/xZKH1f7iQnqBhqFt5TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aojaQ+FQT2INblqOBIZixuHGnkT1UcOy8XZvBor9xW/PvuUhULuJKXiIqG4B027AfWVJrN9m9T+JtWf3lSeni9TelUb5TyTT2DnhoUlFyMdi2hKSlOF7TUBSiCrmk3eD7dU0iq0IYe71CxJiebvr9x5pwQ/VnnWYYbjsM1MkbYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GEEQcbXs reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id b8b218a2613aa1f1; Fri, 10 May 2024 16:20:41 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6C5912102F3F;
	Fri, 10 May 2024 16:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715350840;
	bh=kj0fHUv9hccCyohXhp+3qUh/xZKH1f7iQnqBhqFt5TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GEEQcbXs9jESdVUXXanIe7JtOdDzKeZihuum5VzN1nBUqYQzTZupbnwfYp0zxh44H
	 ezobRcCEHz2HFaHZMjbF7WE3w1z9vXE7PDINqFT39IGRU3YKu0K6iQY4/A9+RCgDHG
	 VzjlNPGsEQZhEDwXUQZsZNE2JvKzcLbsE45M3qReuKetTtsrJ8CR70xQjP6w2J1xu2
	 5t5sEJduQeENLBcpkaMUruS7+0xjLjMayHo8Ky9+vr1EvJmQiDBQWqVcLxRt6jRYg/
	 8uHXRXva4BGrHvdWbm2y+ZYlfD78sh5SJnPHRnTWR16/JeTV3o95Iz4aS/RnzdJ06a
	 MVmA2Bglf29gQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 3/6] thermal: trip: Make thermal_zone_set_trips() use trip
 thresholds
Date: Fri, 10 May 2024 16:16:52 +0200
Message-ID: <1974336.PYKUYFuaPT@kreacher>
In-Reply-To: <13518388.uLZWGnKmhe@kreacher>
References: <13518388.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify thermal_zone_set_trips() to use trip thresholds instead of
computing the low temperature for each trip to avoid deriving both
the high and low temperature levels from the same trip (which may
happen if the zone temperature falls into the hysteresis range of
one trip).

Accordingly, make __thermal_zone_device_update() call
thermal_zone_set_trips() later, when threshold values have
been updated for all trips.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    4 ++--
 drivers/thermal/thermal_trip.c |   14 ++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -498,13 +498,13 @@ void __thermal_zone_device_update(struct
 	if (tz->temperature == THERMAL_TEMP_INVALID)
 		return;
 
-	thermal_zone_set_trips(tz);
-
 	tz->notify_event = event;
 
 	for_each_trip_desc(tz, td)
 		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
 
+	thermal_zone_set_trips(tz);
+
 	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node) {
 		thermal_notify_tz_trip_up(tz, &td->trip);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -88,17 +88,11 @@ void thermal_zone_set_trips(struct therm
 		return;
 
 	for_each_trip_desc(tz, td) {
-		const struct thermal_trip *trip = &td->trip;
-		int trip_low;
+		if (td->threshold < tz->temperature && td->threshold > low)
+			low = td->threshold;
 
-		trip_low = trip->temperature - trip->hysteresis;
-
-		if (trip_low < tz->temperature && trip_low > low)
-			low = trip_low;
-
-		if (trip->temperature > tz->temperature &&
-		    trip->temperature < high)
-			high = trip->temperature;
+		if (td->threshold > tz->temperature && td->threshold < high)
+			high = td->threshold;
 	}
 
 	/* No need to change trip points */




