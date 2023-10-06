Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C07BBDFA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Oct 2023 19:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjJFRvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Oct 2023 13:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjJFRvb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 13:51:31 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A782FB6;
        Fri,  6 Oct 2023 10:51:30 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 6f63dadd0b78c61c; Fri, 6 Oct 2023 19:51:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9AD47665D08;
        Fri,  6 Oct 2023 19:51:28 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 3/6] thermal: gov_fair_share: Rearrange get_trip_level()
Date:   Fri, 06 Oct 2023 19:42:48 +0200
Message-ID: <2244940.iZASKD2KPV@kreacher>
In-Reply-To: <13365827.uLZWGnKmhe@kreacher>
References: <13365827.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make get_trip_level() use for_each_trip() to iterate over trip points
and make it call thermal_zone_trip_id() to obtain the integer ID of a
given trip point so as to avoid relying on the knowledge of struct
thermal_zone_device internals.

The general functionality is not expected to be changed.

This change causes the governor to use trip pointers instead of trip
indices everywhere except for the fair_share_throttle() second argument
that will be modified subsequently along with the definition of the
governor .throttle() callback.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_fair_share.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -15,29 +15,27 @@
 
 #include "thermal_core.h"
 
-/**
- * get_trip_level: - obtains the current trip level for a zone
- * @tz:		thermal zone device
- */
 static int get_trip_level(struct thermal_zone_device *tz)
 {
-	struct thermal_trip trip;
-	int count;
+	const struct thermal_trip *trip, *level_trip = NULL;
+	int trip_level;
 
-	for (count = 0; count < tz->num_trips; count++) {
-		__thermal_zone_get_trip(tz, count, &trip);
-		if (tz->temperature < trip.temperature)
+	for_each_trip(tz, trip) {
+		if (level_trip && trip->temperature >= tz->temperature)
 			break;
+
+		level_trip = trip;
 	}
 
-	/*
-	 * count > 0 only if temperature is greater than first trip
-	 * point, in which case, trip_point = count - 1
-	 */
-	if (count > 0)
-		trace_thermal_zone_trip(tz, count - 1, trip.type);
+	/*  Bail out if the temperature is not greater than any trips. */
+	if (level_trip->temperature >= tz->temperature)
+		return 0;
+
+	trip_level = thermal_zone_trip_id(tz, level_trip);
+
+	trace_thermal_zone_trip(tz, trip_level, level_trip->type);
 
-	return count;
+	return trip_level;
 }
 
 static long get_target_state(struct thermal_zone_device *tz,



