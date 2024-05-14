Return-Path: <linux-pm+bounces-7833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876098C4F72
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB991C2098E
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00698126F1B;
	Tue, 14 May 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FibAS4Cy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZUk0/i4k"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3F1272BF
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681944; cv=none; b=onOrNKWDR8vtTbB+LK1AiX2pSOahJwKmnPxSwod2yjTFXYw2+7gDS910mWrjKmEJSP9NBDiN2ZdRta2R89aQhAk7dnuf9SqFVny5XLPMedB7+bOkY5JmlD5yh2G4Q//7Sc5PPJPTkNJgHLtkIMK9q93pHTX8SkZ6ooL6+XJ4QM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681944; c=relaxed/simple;
	bh=5uOhe7A0rul2JmJSX0LfGSXlTr/YjBXplzopA+pBc/o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uOD0ypyj6CfXiE9frJSIuHFzkmA99/VZ/CGCmPzMBrMwqFLJ+5yQnYJQHAStfFhqs8Dy+eB+AO1ph3jFBg6IGeQuiz+ohgL+EXDgr5HfcwaMvnxJWM1lv+Sjhw97TLOiQA2o3We5BseRPT/LfnpfWhD1vKXh7DOA0m5a1Erx3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FibAS4Cy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZUk0/i4k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 May 2024 10:18:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sk/mWX53ip/AalnrSwwP6JJiVR4qnQdOwxxinHNpW7g=;
	b=FibAS4CysD6F4MV0j4Cx6JlMc3diba3xZVqF1cmIEL1EbQQEh0Xuy1XtwxChSvwfaSGRZ3
	nmOTPT+jx1JmyMG+tBTfQLyleTs+yPQe5UARHFiPPxVHzrQZaMGFMkkLKCyt4WbQ5d4gs7
	vkkRCamr+S3cvq2g0rVTWHDu/ZN9GwczhRW4Dwcy7nsG+txdV9JFPI70UnNcBFcJXk5GoA
	MnfyYbUU+Fyo9S/lqlzfyQuVtqKBXbP0Rqr2c/TUWsYPJHv6oG1WePi/vowF5fDU4gaJih
	SHnj1Cko8xel5tv7JE1+2SjvRycKung8tKXwlbl5GOE16QBWjsST5gnJ7ohRIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715681936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=sk/mWX53ip/AalnrSwwP6JJiVR4qnQdOwxxinHNpW7g=;
	b=ZUk0/i4kFOGPgFnHxoLQelF3GlpAx9QLGps8F7qlNWNftkzRxYT7GH/8qm9LR0Uqk7Lf4O
	cN9Dl78BzEHjL0BQ==
From: "thermal-bot for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/fixes] thermal: core: Sort trip point crossing
 notifications by temperature
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com, amitk@kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171568193638.10875.10094563066195335218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the thermal/fixes branch of thermal:

Commit-ID:     7454f2c42cce10a74312343b66aa2c3dee05d868
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//7454f2c42cce10a74312343b66aa2c3dee05d868
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Tue, 02 Apr 2024 21:03:36 +02:00
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Mon, 08 Apr 2024 16:01:20 +02:00

thermal: core: Sort trip point crossing notifications by temperature

If multiple trip points are crossed in one go and the trips table in
the thermal zone device object is not sorted, the corresponding trip
point crossing notifications sent to user space will not be ordered
either.

Moreover, if the trips table is sorted by trip temperature in ascending
order, the trip crossing notifications on the way up will be sent in that
order too, but the trip crossing notifications on the way down will be
sent in the reverse order.

This is generally confusing and it is better to make the kernel send the
notifications in the order of growing (on the way up) or falling (on the
way down) trip temperature.

To achieve that, instead of sending a trip crossing notification and
recording a trip crossing event in the statistics right away from
handle_thermal_trip(), put the trip in question on a list that will be
sorted by __thermal_zone_device_update() after processing all of the trips
and before sending the notifications and recording trip crossing events.

Link: https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 41 ++++++++++++++++++++++++++++-----
 drivers/thermal/thermal_core.h |  2 ++-
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 28f5d9b..58e60bc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
+#include <linux/list_sort.h>
 #include <linux/thermal.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
@@ -361,7 +362,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz,
-				struct thermal_trip_desc *td)
+				struct thermal_trip_desc *td,
+				struct list_head *way_up_list,
+				struct list_head *way_down_list)
 {
 	const struct thermal_trip *trip = &td->trip;
 	int old_threshold;
@@ -387,8 +390,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 		 * In that case, the trip temperature becomes the new threshold.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			thermal_notify_tz_trip_down(tz, trip);
-			thermal_debug_tz_trip_down(tz, trip);
+			list_add(&td->notify_list_node, way_down_list);
+			td->notify_temp = trip->temperature - trip->hysteresis;
 		} else {
 			td->threshold -= trip->hysteresis;
 		}
@@ -398,8 +401,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 		 * if the zone temperature exceeds the trip one.  The new
 		 * threshold is then set to the low temperature of the trip.
 		 */
-		thermal_notify_tz_trip_up(tz, trip);
-		thermal_debug_tz_trip_up(tz, trip);
+		list_add_tail(&td->notify_list_node, way_up_list);
+		td->notify_temp = trip->temperature;
 		td->threshold -= trip->hysteresis;
 	}
 
@@ -452,10 +455,24 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
+static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
+				   const struct list_head *b)
+{
+	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
+						     notify_list_node);
+	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
+						     notify_list_node);
+	int ret = tdb->notify_temp - tda->notify_temp;
+
+	return ascending ? ret : -ret;
+}
+
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
 	struct thermal_trip_desc *td;
+	LIST_HEAD(way_down_list);
+	LIST_HEAD(way_up_list);
 
 	if (tz->suspended)
 		return;
@@ -470,7 +487,19 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	tz->notify_event = event;
 
 	for_each_trip_desc(tz, td)
-		handle_thermal_trip(tz, td);
+		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
+
+	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
+	list_for_each_entry(td, &way_up_list, notify_list_node) {
+		thermal_notify_tz_trip_up(tz, &td->trip);
+		thermal_debug_tz_trip_up(tz, &td->trip);
+	}
+
+	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
+	list_for_each_entry(td, &way_down_list, notify_list_node) {
+		thermal_notify_tz_trip_down(tz, &td->trip);
+		thermal_debug_tz_trip_down(tz, &td->trip);
+	}
 
 	monitor_thermal_zone(tz);
 }
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 5dd3be5..9d3ef1e 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -17,6 +17,8 @@
 
 struct thermal_trip_desc {
 	struct thermal_trip trip;
+	struct list_head notify_list_node;
+	int notify_temp;
 	int threshold;
 };
 

