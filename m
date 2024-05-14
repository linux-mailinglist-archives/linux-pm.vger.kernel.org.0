Return-Path: <linux-pm+bounces-7834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B68C4F75
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011D3B20D08
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7CA13FD88;
	Tue, 14 May 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkdCsbva";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKH0f5P5"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146F127B73
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=L5vi5lOJVRyIQ1SNLQnkfLrFgHvqxYwJj++Ag26n+5txPMYJ4AesN9tw1BzgAW4KA8RC8P+Ur0WYWPUTn13Lqq1FW67YoEzBYVu5AqKx4kMP2Qs4j3xfOYKK2O+oulAxRtivTkkTN7brNS09KSLeJaCLOglD4Ka6RfK+/DwR2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=TtAMb0W8nXdHBa5KVp0Y+Fc2GpO5/QkLf4Z20dUqIBc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qZhWQNoMOULBjHs/dzAffV78XhoTlXXnB7XtPtQ0rmFvMGAJdTQCy5zfXQCYJe5haIpTkAaqakZfO499MoqSGtjhyu7Ia8NtD1yRhcQDFzs05LkvzZ9TcBLKz9Pq1b09DuIpZxdfFQY1A1kWWOgBP3Mr2x8gPXBVIhl+kqhQiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkdCsbva; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKH0f5P5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UYfGhPtP15SMyjr18jaec5dX69N0pClZ4si8UU4d5xc=;
	b=WkdCsbvabe//D0sXwRiPcAqcSqcu/2n+N0Ny4WdkVmFzRMK9m/ELvOJOu+ptS+zeARdVfy
	nSip+TAsnCBzHEtkkl3CHzw2stXsJbRo47P6/DybSzCHr1176B1Ny9/zu6c5DmOWDme1yP
	V0oL+vCJLTdPz8e53Sw24J+j77CX4szRIZ180eABowLlmdtrtUH1GLV7NtXcLfb4pm+v3H
	+Eq7s3EbvDMGheibjPr8kaO8YDK6+jtQI6+TziORq+AaZ8iUzSxQ3L+RYlRiV6vlBx8HxK
	FaJoY+rhglk6nCErOjBrnP/Ia2vH8zUNdypG91TtkMBhWDTnp1Knqr5a93GUKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UYfGhPtP15SMyjr18jaec5dX69N0pClZ4si8UU4d5xc=;
	b=ZKH0f5P52CAy/ryv8lcDqkIevoHl9Nh770C4/K91iDbAAUKJMa1UunEhGbNxojmnNB4Jrd
	cr1AWxas1a4eP0AA==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: core: Send trip crossing
 notifications at init time if needed
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
 daniel.lezcano@linaro.org, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193652.10875.3576256474516014171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     9ad18043fb35feb1d82c1e594575346f16d47dc7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//9ad18043fb35feb1d82c1e594575346f16d47dc7
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Tue, 02 Apr 2024 21:02:10 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 16:01:20 +02:00

thermal: core: Send trip crossing notifications at init time if needed

If a trip point is already exceeded by the zone temperature at the
initialization time, no trip crossing notification is send regarding
this even though mitigation should be started then.

Address this by rearranging the code in handle_thermal_trip() to
send a trip crossing notification for trip points already exceeded
by the zone temperature initially which also allows to reduce its
size by using the observation that the initialization and regular
trip crossing on the way up become the same case then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 37 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index c4bc797..28f5d9b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -364,6 +364,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 				struct thermal_trip_desc *td)
 {
 	const struct thermal_trip *trip = &td->trip;
+	int old_threshold;
 
 	if (trip->temperature == THERMAL_TEMP_INVALID)
 		return;
@@ -375,25 +376,11 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 	 * is what needs to be compared with the previous zone temperature
 	 * to decide which action to take.
 	 */
-	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
-		/* Initialization. */
-		td->threshold = trip->temperature;
-		if (tz->temperature >= td->threshold)
-			td->threshold -= trip->hysteresis;
-	} else if (tz->last_temperature < td->threshold) {
-		/*
-		 * There is no mitigation under way, so it needs to be started
-		 * if the zone temperature exceeds the trip one.  The new
-		 * threshold is then set to the low temperature of the trip.
-		 */
-		if (tz->temperature >= trip->temperature) {
-			thermal_notify_tz_trip_up(tz, trip);
-			thermal_debug_tz_trip_up(tz, trip);
-			td->threshold = trip->temperature - trip->hysteresis;
-		} else {
-			td->threshold = trip->temperature;
-		}
-	} else {
+	old_threshold = td->threshold;
+	td->threshold = trip->temperature;
+
+	if (tz->last_temperature >= old_threshold &&
+	    tz->last_temperature != THERMAL_TEMP_INVALID) {
 		/*
 		 * Mitigation is under way, so it needs to stop if the zone
 		 * temperature falls below the low temperature of the trip.
@@ -402,10 +389,18 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz, trip);
 			thermal_debug_tz_trip_down(tz, trip);
-			td->threshold = trip->temperature;
 		} else {
-			td->threshold = trip->temperature - trip->hysteresis;
+			td->threshold -= trip->hysteresis;
 		}
+	} else if (tz->temperature >= trip->temperature) {
+		/*
+		 * There is no mitigation under way, so it needs to be started
+		 * if the zone temperature exceeds the trip one.  The new
+		 * threshold is then set to the low temperature of the trip.
+		 */
+		thermal_notify_tz_trip_up(tz, trip);
+		thermal_debug_tz_trip_up(tz, trip);
+		td->threshold -= trip->hysteresis;
 	}
 
 	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)

