Return-Path: <linux-pm+bounces-15759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D339A087B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B5F288D66
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00282076D3;
	Wed, 16 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="afIj5sK6"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AB1C07EA;
	Wed, 16 Oct 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078630; cv=none; b=W4sevt4EBcxTh185UM2eo7P6iJd4b22ZUUNTYsV7tD60nPs7HCrwsFuVtbDhl6YlLGfUg4O8SX0ErLCmPsjXv2+qHU/REfElJxWkTt2/Qnvz0i0bghbkYkpdUZ2NPVV6Kwa/1f+wS7uMl6INDQph2w/kEgQJEI7KS1/i19g9/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078630; c=relaxed/simple;
	bh=W6ms6IB5xPz9+aEODY9WwV/YTEgoMBDqfCiU9w2ssEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lnjb1i1d7Z2qS5xdamdFRf/OkoEUvZYS7X3sO1h1oDXsrus64W0ghv1PnH/E24hOEeOO6UEb5tN8TvM0tCUCtlzVv8PmlFhPGGMlG89w8g60H1Vl2jonQH02Lzi0otlcYC/yw/a8ShMUQu5zmiiUwf/cPiZ9JWkWnjNpuysao+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=afIj5sK6 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 732c7bb1b8c2d880; Wed, 16 Oct 2024 13:36:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 467A1A93969;
	Wed, 16 Oct 2024 13:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078619;
	bh=W6ms6IB5xPz9+aEODY9WwV/YTEgoMBDqfCiU9w2ssEY=;
	h=From:Subject:Date;
	b=afIj5sK6ov7QxGjuty+dkRxWMF9HpgunHEgRu/Y5LODsVD/ANQH+Q0SgwPWzCIynA
	 DQ5S5TyAlrn09nkDlS2c8yOUQNKUuLcV2NkVKPaQgxlf3PWHGwFOXuk8xtXcdQVWnK
	 cY1/zAs4cUjwWuWfLozn5ilFQkLuqOGdtHpS3+CWxT91OvJhQjbDHrKH79RlwVHd3a
	 waMTkv4g1aPKv1A88Asp1Bdmb8uCpx4LhqboM+aIQQdSOtmSvi2DZGSC+68VFQQVVa
	 vgGlYeni9hDzqcaoeV/dKMZUruRsYDRGrO8GYiXz/G+qACmLxJm08GbeiSvcsvyqQS
	 3C2gBbQre3oow==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 10/10] thermal: core: Relocate thermal zone initialization routine
Date: Wed, 16 Oct 2024 13:36:03 +0200
Message-ID: <1906685.CQOukoFCf9@rjwysocki.net>
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

Move thermal_zone_device_init() along with thermal_zone_device_check()
closer to the callers of the former, where they fit better together.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   82 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -429,14 +429,6 @@ static void move_trip_to_sorted_list(str
 	list_add(&td->list_node, list);
 }
 
-static void thermal_zone_device_check(struct work_struct *work)
-{
-	struct thermal_zone_device *tz = container_of(work, struct
-						      thermal_zone_device,
-						      poll_queue.work);
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-}
-
 static void move_to_trips_high(struct thermal_zone_device *tz,
 			       struct thermal_trip_desc *td)
 {
@@ -458,39 +450,6 @@ static void move_to_trips_invalid(struct
 	list_move(&td->list_node, &tz->trips_invalid);
 }
 
-static void thermal_zone_device_init(struct thermal_zone_device *tz)
-{
-	struct thermal_trip_desc *td, *next;
-
-	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
-
-	tz->temperature = THERMAL_TEMP_INIT;
-	tz->passive = 0;
-	tz->prev_low_trip = -INT_MAX;
-	tz->prev_high_trip = INT_MAX;
-	for_each_trip_desc(tz, td) {
-		struct thermal_instance *instance;
-
-		list_for_each_entry(instance, &td->thermal_instances, trip_node)
-			instance->initialized = false;
-	}
-	/*
-	 * At this point, all valid trips need to be moved to trips_high so that
-	 * mitigation can be started if the zone temperature is above them.
-	 */
-	list_for_each_entry_safe(td, next, &tz->trips_invalid, list_node) {
-		if (td->trip.temperature != THERMAL_TEMP_INVALID)
-			move_to_trips_high(tz, td);
-	}
-	/* The trips_reached list may not be empty during system resume. */
-	list_for_each_entry_safe(td, next, &tz->trips_reached, list_node) {
-		if (td->trip.temperature == THERMAL_TEMP_INVALID)
-			move_to_trips_invalid(tz, td);
-		else
-			move_to_trips_high(tz, td);
-	}
-}
-
 static void thermal_governor_trip_crossed(struct thermal_governor *governor,
 					  struct thermal_zone_device *tz,
 					  const struct thermal_trip *trip,
@@ -1425,6 +1384,47 @@ int thermal_zone_get_crit_temp(struct th
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
+static void thermal_zone_device_check(struct work_struct *work)
+{
+	struct thermal_zone_device *tz = container_of(work, struct
+						      thermal_zone_device,
+						      poll_queue.work);
+	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+}
+
+static void thermal_zone_device_init(struct thermal_zone_device *tz)
+{
+	struct thermal_trip_desc *td, *next;
+
+	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
+
+	tz->temperature = THERMAL_TEMP_INIT;
+	tz->passive = 0;
+	tz->prev_low_trip = -INT_MAX;
+	tz->prev_high_trip = INT_MAX;
+	for_each_trip_desc(tz, td) {
+		struct thermal_instance *instance;
+
+		list_for_each_entry(instance, &td->thermal_instances, trip_node)
+			instance->initialized = false;
+	}
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
+}
+
 static int thermal_zone_init_governor(struct thermal_zone_device *tz)
 {
 	struct thermal_governor *governor;




