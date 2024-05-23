Return-Path: <linux-pm+bounces-8082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0C68CD80E
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641952844C5
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9817C8B;
	Thu, 23 May 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="aRNA7dy9"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D017721;
	Thu, 23 May 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480322; cv=none; b=TyzVJMzNXo3XB10UpRvUAsjfKshiCFB3iy5CK2BzLtRaua0bLtEZiMahvc8khbIDZtyltDphw2FtH34RX6Lny0ca0EPrb7uJmG2wYWFEVgK5KkpsQNQ11NS9jg0pODP8MbAHqXfyuK5QjkVgUmjxLaa0f88dhKk7bVPOM1dpF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480322; c=relaxed/simple;
	bh=BW8ZRAvg7winXbGv3+W42E4pM+Ypuxrczu98PJwQ2LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8vp13v1gC/FaImbrk2PaWUMg5KLYtV6OlaoB4RCSNveLIv0MzuOZWF2uMaJkjwUps16NTgikVdCGY6wxLXzlHecNYFMyF5xJOsXHPo/N6KUF3tCl+Bk6UqEeJLTcFmXqSDM+P7JO554yk/i1ISg0TOhhNeV1Uvr0MBosZUrC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=aRNA7dy9 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 8adf61c6dd926fb5; Thu, 23 May 2024 18:05:10 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 451796A4927;
	Thu, 23 May 2024 18:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716480310;
	bh=BW8ZRAvg7winXbGv3+W42E4pM+Ypuxrczu98PJwQ2LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRNA7dy9K5X7a30LTIV+F0Cf6kbmXM0IQiCSfTwblg9qYnP5ycKtvatMAbTDKIjqv
	 QbJF0Nb/Bp68Es9gmYz5AI9qSIVnsgDzI4kDhMokf60dLbW6cCgjrHL7V/yiSpDXNU
	 plM8i+NQKwQjk6owqgQrqq9TmkxQmhnAsiqkgowo2hVnyEHPG7/7Hc+SUCTX844081
	 S5yzdO6YFgDm0o7tn7VipW5C8xXSyuDjlZCfNUhxquVxV6e03jgH2DS43nltylERQ1
	 KFpHanVgfdDTRABS+XG4PQhbb9al7Htc2M1GKWyOE5u55jVj6GaiQzw1ThtTDa6MN9
	 s7x5eLpVDc5wQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 4/4] thermal: trip: Trigger trip down notifications when trips
 involved in mitigation become invalid
Date: Thu, 23 May 2024 18:05:03 +0200
Message-ID: <8373757.T7Z3S40VBb@kreacher>
In-Reply-To: <12438941.O9o76ZdvQC@kreacher>
References: <12438941.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When a trip point becomes invalid after being crossed on the way up,
it is involved in a mitigation episode that needs to be adjusted to
compensate for the trip going away.

For this reason, introduce thermal_zone_trip_down() as a wrapper
around thermal_trip_crossed() and make thermal_zone_set_trip_temp()
call it if the new temperature of the trip at hand is equal to
THERMAL_TEMP_INVALID and it has been crossed on the way up to trigger
all of the necessary adjustments in user space, the thermal debug
code and the zone governor.

Fixes: 8c69a777e480 ("thermal: core: Fix the handling of invalid trip points")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Initially, I had thought that this would be a cleanup rather than a fix, but
then I realized that there was the Bang-bang governor that needed to undo
mitigation when the trip that triggered it became invalid before getting
crossed on the way down.

---
 drivers/thermal/thermal_core.c |    6 ++++++
 drivers/thermal/thermal_core.h |    2 ++
 drivers/thermal/thermal_trip.c |   20 ++++++++++++--------
 3 files changed, 20 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -602,6 +602,12 @@ void thermal_zone_device_update(struct t
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
+void thermal_zone_trip_down(struct thermal_zone_device *tz,
+			    const struct thermal_trip *trip)
+{
+	thermal_trip_crossed(tz, trip, thermal_get_tz_governor(tz), false);
+}
+
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *data)
 {
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -246,6 +246,8 @@ int thermal_zone_trip_id(const struct th
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
+void thermal_zone_trip_down(struct thermal_zone_device *tz,
+			    const struct thermal_trip *trip);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *tz);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -152,17 +152,23 @@ void thermal_zone_set_trip_temp(struct t
 	if (trip->temperature == temp)
 		return;
 
+	trip->temperature = temp;
+	thermal_notify_tz_trip_change(tz, trip);
+
 	if (temp == THERMAL_TEMP_INVALID) {
 		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 
-		if (trip->type == THERMAL_TRIP_PASSIVE &&
-		    tz->temperature >= td->threshold) {
+		if (tz->temperature >= td->threshold) {
 			/*
-			 * The trip has been crossed, so the thermal zone's
-			 * passive count needs to be adjusted.
+			 * The trip has been crossed on the way up, so some
+			 * adjustments are needed to compensate for the lack
+			 * of it going forward.
 			 */
-			tz->passive--;
-			WARN_ON_ONCE(tz->passive < 0);
+			if (trip->type == THERMAL_TRIP_PASSIVE) {
+				tz->passive--;
+				WARN_ON_ONCE(tz->passive < 0);
+			}
+			thermal_zone_trip_down(tz, trip);
 		}
 		/*
 		 * Invalidate the threshold to avoid triggering a spurious
@@ -170,7 +176,5 @@ void thermal_zone_set_trip_temp(struct t
 		 */
 		td->threshold = INT_MAX;
 	}
-	trip->temperature = temp;
-	thermal_notify_tz_trip_change(tz, trip);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);




