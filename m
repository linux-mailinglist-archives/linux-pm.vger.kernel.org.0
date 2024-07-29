Return-Path: <linux-pm+bounces-11556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52293FB42
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F3D284BBA
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF266186E39;
	Mon, 29 Jul 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="aLpAgmYr"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7150038B;
	Mon, 29 Jul 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270467; cv=none; b=GHQ4J4AerBrnAoMMu33EGgunJ8hTMhIe5bTZD+XbIUYyWVqW1UP26H53eOqsdMaSUjaFEMl0QlxU4tIvZ8dXGxIoyFCynzcHgq3ugoEfSv/eG9qh8qnGk71LKwJnZa3/ZDCGKe0harcZH83LfLplkwHCFJWdWmLl7MAkBFpOcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270467; c=relaxed/simple;
	bh=GMOU0nWXi1RZGZDpMeeNhQfdCnLFvO8S3h1WIqsGnV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZ2gMSZN26XSkLk0tH6/hoTs+XSiR6ybOl4b2QKP7CAq+Js3fl+6kfKWKVjXtn9qKqdiTk/tPMT6iamDp+EdtTnAPTQYcWjO5/varU76Cy2srs6GtwxZD0m5UPM/+xmnq3a1zliL/Gsc1PNQM0Wi47wH2vrECDsgyOGKja1/YS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=aLpAgmYr reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 2a6812c7d9d45ca8; Mon, 29 Jul 2024 18:27:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E675E77357F;
	Mon, 29 Jul 2024 18:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722270463;
	bh=GMOU0nWXi1RZGZDpMeeNhQfdCnLFvO8S3h1WIqsGnV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLpAgmYrUj0s5Ulor8+Y1CmjWDCqIQoeLwCBw1bySVEcWRN558/gemYRn/rylH7AX
	 pIHoiDNmP3DORR2/MhJ1rVXgQosI0j9gwSzl4j6Bv1yNZgafd2sTh9Hb6kf0Ulp0QP
	 mEW4T43MHG5bRrg2ie2xRBA3AwB4yJX7vOxmSlfviWLwh69QF8qo+KBuCPLODYCGbQ
	 akRJYSOEu9jYsLQ5YdvhorbQB3wi9LLFl9zEdYuQHZLYo+780WtOwQbV7f+McJ4SEt
	 FoVcKc6wRyWut3sNm/RO/7lgeO10y6FT/Penx3eTjJQPPhuGcvyJ8lBcHb4WsoCJSk
	 wy0YlK/PAx22A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 3/3] thermal: sysfs: Refine the handling of trip hysteresis changes
Date: Mon, 29 Jul 2024 18:27:25 +0200
Message-ID: <5508466.Sb9uPGUboI@rjwysocki.net>
In-Reply-To: <1960840.taCxCBeP46@rjwysocki.net>
References: <1960840.taCxCBeP46@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Change trip_point_hyst_store() and replace thermal_zone_trip_updated()
with thermal_zone_set_trip_hyst() to follow the trip_point_temp_store()
code pattern for more consistency.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h  |    4 ++--
 drivers/thermal/thermal_sysfs.c |    4 ++--
 drivers/thermal/thermal_trip.c  |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -258,11 +258,11 @@ const char *thermal_trip_type_name(enum
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
-void thermal_zone_trip_updated(struct thermal_zone_device *tz,
-			       const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 void thermal_zone_trip_down(struct thermal_zone_device *tz,
 			    const struct thermal_trip *trip);
+void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
+				struct thermal_trip *trip, int hyst);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *tz);
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -153,9 +153,9 @@ trip_point_hyst_store(struct device *dev
 	mutex_lock(&tz->lock);
 
 	if (hyst != trip->hysteresis) {
-		WRITE_ONCE(trip->hysteresis, hyst);
+		thermal_zone_set_trip_hyst(tz, trip, hyst);
 
-		thermal_zone_trip_updated(tz, trip);
+		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 	}
 
 	mutex_unlock(&tz->lock);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -118,11 +118,11 @@ int thermal_zone_trip_id(const struct th
 	return trip_to_trip_desc(trip) - tz->trips;
 }
 
-void thermal_zone_trip_updated(struct thermal_zone_device *tz,
-			       const struct thermal_trip *trip)
+void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
+				struct thermal_trip *trip, int hyst)
 {
+	WRITE_ONCE(trip->hysteresis, hyst);
 	thermal_notify_tz_trip_change(tz, trip);
-	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 }
 
 void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,




