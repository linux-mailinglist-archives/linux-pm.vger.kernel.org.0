Return-Path: <linux-pm+bounces-15761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BBE9A0880
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F448B2565D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D973207A20;
	Wed, 16 Oct 2024 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="rP5zspe6"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37D206979;
	Wed, 16 Oct 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078631; cv=none; b=T8SUau/OLuFdC5YTifWKDDf/bgwWHSyryjk36zfRSPf1Vjsmj/BJlXjw/Kk57fmhkvuGgz944yBU4xhIS3SzZRmnBJ+czbPXkFwf/NRGf1CjSP1+hK1WpaUXBivzcnhQvkhrbmtavEvaTmZp+XVSZsBaYz9amUXfOmxCvKPJuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078631; c=relaxed/simple;
	bh=9lT857ctfzD/iFRi0G/KTA54Z1OPV5bjQ4s0G3ON6vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCH0xMTsbi5H/Fzd8BM2oeLe5lznF5qkcuThjHd7vI+AjsimVAJlsjCgd21btB+Kd5DPMffuRjClTW1SymQyGrMS0cXxyo/6cKoW/SA1hv1Zqm1w56C4+GlmcIr+tCtJKgmO5cZD112N8k0w8IogoZ9WY+l7FgcViCpTq59+qek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=rP5zspe6 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c44b4993e14fa7d9; Wed, 16 Oct 2024 13:37:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A35ADA9396A;
	Wed, 16 Oct 2024 13:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078620;
	bh=9lT857ctfzD/iFRi0G/KTA54Z1OPV5bjQ4s0G3ON6vU=;
	h=From:Subject:Date;
	b=rP5zspe6ifKmYwTN7/l6fioNJzY8jOnu1PU3QVljYNd4+MVKMAzAQHpHvPlmUCvE4
	 6IcS0M1BCwdPWjE5N8pj8ZkzHSx8g5reKsw98us13SUy+K6anY5h6a120YwJpvUZtB
	 UbCjmywrHcG3R6urBkXr16QigJHuwDEvOgWVFGH783b+2SAvq/nawDDpbIENN+Qo1W
	 x5n4tYZXhdmuf0wsQ8qbgTk9L3qqX5/DqO85J3y40T/hU1oj123DhpDN2etBKeIpB5
	 7owKA3K+D413Gd7HuikJGPUkVQqrrmBWMweynSU0B9eDIXnoXEo59hiODdCBR8ovVe
	 MeL31/3onYG+A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 07/10] thermal: core: Relocate functions that update trip points
Date: Wed, 16 Oct 2024 13:32:13 +0200
Message-ID: <3248558.5fSG56mABF@rjwysocki.net>
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

In preparation for subsequent changes, move two functions used
for updating trip points, thermal_zone_set_trip_temp() and
thermal_zone_set_trip_hyst(), to thermal_core.c.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   35 +++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_trip.c |   35 -----------------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -541,6 +541,41 @@ static void thermal_trip_crossed(struct
 	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
 }
 
+void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
+				struct thermal_trip *trip, int hyst)
+{
+	WRITE_ONCE(trip->hysteresis, hyst);
+	thermal_notify_tz_trip_change(tz, trip);
+}
+
+void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
+				struct thermal_trip *trip, int temp)
+{
+	if (trip->temperature == temp)
+		return;
+
+	WRITE_ONCE(trip->temperature, temp);
+	thermal_notify_tz_trip_change(tz, trip);
+
+	if (temp == THERMAL_TEMP_INVALID) {
+		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+
+		/*
+		 * If the trip has been crossed on the way up, some adjustments
+		 * are needed to compensate for the lack of it going forward.
+		 */
+		if (tz->temperature >= td->threshold)
+			thermal_zone_trip_down(tz, td);
+
+		/*
+		 * Invalidate the threshold to avoid triggering a spurious
+		 * trip crossing notification when the trip becomes valid.
+		 */
+		td->threshold = INT_MAX;
+	}
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
+
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -88,38 +88,3 @@ int thermal_zone_trip_id(const struct th
 	 */
 	return trip_to_trip_desc(trip) - tz->trips;
 }
-
-void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
-				struct thermal_trip *trip, int hyst)
-{
-	WRITE_ONCE(trip->hysteresis, hyst);
-	thermal_notify_tz_trip_change(tz, trip);
-}
-
-void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
-				struct thermal_trip *trip, int temp)
-{
-	if (trip->temperature == temp)
-		return;
-
-	WRITE_ONCE(trip->temperature, temp);
-	thermal_notify_tz_trip_change(tz, trip);
-
-	if (temp == THERMAL_TEMP_INVALID) {
-		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
-
-		/*
-		 * If the trip has been crossed on the way up, some adjustments
-		 * are needed to compensate for the lack of it going forward.
-		 */
-		if (tz->temperature >= td->threshold)
-			thermal_zone_trip_down(tz, td);
-
-		/*
-		 * Invalidate the threshold to avoid triggering a spurious
-		 * trip crossing notification when the trip becomes valid.
-		 */
-		td->threshold = INT_MAX;
-	}
-}
-EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);




