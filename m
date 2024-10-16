Return-Path: <linux-pm+bounces-15764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD0E9A0885
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271341F24463
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0E208221;
	Wed, 16 Oct 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RgEyoGPv"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31B206971;
	Wed, 16 Oct 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078632; cv=none; b=m1HJqFssW1zELIxWzqLdZqOXSH9vIPf5PyrzxIp0Y0grZBYzizlxJrWBVIbn9q0cXGIPN3SL+r+y9B4VrmJFiDqf5orIxZ+RpdzLR/R/GqZjkJzWxuwxxO3PI+IWeiKBTivjkmtWBhn1IOnsLNj5By+ymCzQ8NvhWFxzRFtr8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078632; c=relaxed/simple;
	bh=d3FhRqJ/7F7p5ur4zqXt9vObUWT968LgrFQqh3LNnl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0KH4cTjuj/ul2vpS1vGu5n9GWGHPvML5/zoadQevYMsnYHLWldbsnSuE6+CQd7CjyJCJLlcsVaiLqbOPtDfL8dPiKYr1Xrb7B0tY6ycjkZV/V0qLbcawP4aWrQl/p8cb9oRILCRWE6Mh/ssGSDEbN6bZ9u7Z2ApnOu29p5hOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RgEyoGPv reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 619f72629289d303; Wed, 16 Oct 2024 13:37:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 01F1AA93969;
	Wed, 16 Oct 2024 13:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078621;
	bh=d3FhRqJ/7F7p5ur4zqXt9vObUWT968LgrFQqh3LNnl8=;
	h=From:Subject:Date;
	b=RgEyoGPvZcu3TIBpHlzD8Dz0j/aMjMMtbim46Bol6kn6Tm0+0ZYvVFo59wLWdsTPs
	 2tKge3RZ8wovJbMKn2NcbZVQM8SdT1yw0coO4X0D9wHHxjMKsFxTJs6wMXkkXinIVC
	 L/8jdaY2zckMQuQVpojwAty9tssLKDIzKmyhcZsaTos/h4lbwpeB37SafhRiVn6mpw
	 fTjEkjA8TeZxPQWmWfc03y3XGiVByFzURTTNALBtYki6GRV0imVaK47uA01uRFQ9Dm
	 gn8gpQHJk7/S2qr52ykaKNJr0/2jUvErxg5ObwP5XTWrD9majeGkQh/qZV1kTrD57a
	 h4XJ0zQtZOy1g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 06/10] thermal: core: Move some trip processing to
 thermal_trip_crossed()
Date: Wed, 16 Oct 2024 13:29:14 +0200
Message-ID: <1982859.PYKUYFuaPT@rjwysocki.net>
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

Notice that some processing related to trip point crossing carried out
in handle_thermal_trip() and thermal_zone_set_trip_temp() may as well
be done in thermal_trip_crossed(), which allows code duplication to be
reduced, so change the code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   21 ++++++++++-----------
 drivers/thermal/thermal_trip.c |   17 ++++++-----------
 2 files changed, 16 insertions(+), 22 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -460,11 +460,6 @@ static void handle_thermal_trip(struct t
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			td->notify_temp = trip->temperature - trip->hysteresis;
 			move_trip_to_sorted_list(td, way_down_list);
-
-			if (trip->type == THERMAL_TRIP_PASSIVE) {
-				tz->passive--;
-				WARN_ON(tz->passive < 0);
-			}
 		} else {
 			td->threshold -= trip->hysteresis;
 		}
@@ -478,12 +473,6 @@ static void handle_thermal_trip(struct t
 		move_trip_to_sorted_list(td, way_up_list);
 
 		td->threshold -= trip->hysteresis;
-
-		if (trip->type == THERMAL_TRIP_PASSIVE)
-			tz->passive++;
-		else if (trip->type == THERMAL_TRIP_CRITICAL ||
-			 trip->type == THERMAL_TRIP_HOT)
-			handle_critical_trips(tz, trip);
 	}
 }
 
@@ -533,9 +522,19 @@ static void thermal_trip_crossed(struct
 	const struct thermal_trip *trip = &td->trip;
 
 	if (crossed_up) {
+		if (trip->type == THERMAL_TRIP_PASSIVE)
+			tz->passive++;
+		else if (trip->type == THERMAL_TRIP_CRITICAL ||
+			 trip->type == THERMAL_TRIP_HOT)
+			handle_critical_trips(tz, trip);
+
 		thermal_notify_tz_trip_up(tz, trip);
 		thermal_debug_tz_trip_up(tz, trip);
 	} else {
+		if (trip->type == THERMAL_TRIP_PASSIVE) {
+			tz->passive--;
+			WARN_ON(tz->passive < 0);
+		}
 		thermal_notify_tz_trip_down(tz, trip);
 		thermal_debug_tz_trip_down(tz, trip);
 	}
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -108,18 +108,13 @@ void thermal_zone_set_trip_temp(struct t
 	if (temp == THERMAL_TEMP_INVALID) {
 		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 
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
+		/*
+		 * If the trip has been crossed on the way up, some adjustments
+		 * are needed to compensate for the lack of it going forward.
+		 */
+		if (tz->temperature >= td->threshold)
 			thermal_zone_trip_down(tz, td);
-		}
+
 		/*
 		 * Invalidate the threshold to avoid triggering a spurious
 		 * trip crossing notification when the trip becomes valid.




