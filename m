Return-Path: <linux-pm+bounces-7916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB73F8C7B07
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB981C20ECC
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15E1553AA;
	Thu, 16 May 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Y8qaVhEV"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07091E519;
	Thu, 16 May 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880025; cv=none; b=jhBcvAFBMwd2Hf7e5uxjksawkbv12l2GjlWjl9GqzdBW3xYOXqx/Iccwhg6PyHL5uhLcQ8e+4XvjawDBQj8KbBbTH0QJZoVNykwmdgXrgZ0ABx4NxX/3O1otR07A/wRQhKfq7MxsJnAEp6410O5I1S3lNxSibru02xc2pAtIhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880025; c=relaxed/simple;
	bh=jKuBLxLiB/BSzgv0Cf5ZWG6LMDWfkmTlYFjooSwDuIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/4VacIYjGiSguOTcNQdScgkWzRPF6nCjM+yIWwFB6Qnui/XHoAjYlRw+SmBOBTXBQhvUjpAKxWyTFQU7eBYuqxPJpaSif50lRfVBkyegXobhPHxYU1FCYXol6dSizSqWkxZmJmOKqg1f2I5/qrvnenZePGfqfEsalBxNjgVSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Y8qaVhEV; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 361194f984dcb5b6; Thu, 16 May 2024 19:20:20 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B082373AC72;
	Thu, 16 May 2024 19:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715880020;
	bh=jKuBLxLiB/BSzgv0Cf5ZWG6LMDWfkmTlYFjooSwDuIM=;
	h=From:To:Cc:Subject:Date;
	b=Y8qaVhEVO6zoWKJCAlsq1EoIukydxyuFkkcD1IiRnJR2ZjZLjiqaV4PyV1vlH09Ey
	 8tW2Zo74bb7L3klkbzzJwJRbcSNThwmACaj1lI7gEBHKvArkS0B624NoD3e1lGFZFL
	 2WVdaxHfOpdLevMo92/a9UQwe1/syn3UJUEGDSfogHOZuGUrCnYJp+/GskXxZifReG
	 v3nfl6rS5PlvqYUt2sQCAon5LHuHPowIkE3xO4HyfTahm5ygFdYGFdcr+PRBcQV92a
	 WmVoZh8DHjoo7AkXmVj3QIsLJZIjJWx3TYAe5RKaf1f69RlwV59YahocVXEbmd6ArF
	 h4M9D8At2oMjA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1] thermal: core: Fix the handling of invalid trip points
Date: Thu, 16 May 2024 19:20:19 +0200
Message-ID: <12441937.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggr
 nhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 9ad18043fb35 ("thermal: core: Send trip crossing notifications
at init time if needed") overlooked the case when a trip point that
has started as invalid is set to a valid temperature later.  Namely,
the initial threshold value for all trips is zero, so if a previously
invalid trip becomes valid and its (new) low temperature is above the
zone temperature, a spurious trip crossing notification will occur and
it may trigger the WARN_ON() in handle_thermal_trip().

To address this, set the initial threshold for all trips to INT_MAX.

There is also the case when a valid writable trip becomes invalid that
requires special handling.  First, in accordance with the change
mentioned above, the trip's threshold needs to be set to INT_MAX to
avoid the same issue.  Second, if the trip in question is passive and
it has been crossed by the thermal zone temperature on the way up, the
zone's passive count has been incremented and it is in the passive
polling mode, so its passive count needs to be adjusted to allow the
passive polling to be turned off eventually.

Fixes: 9ad18043fb35 ("thermal: core: Send trip crossing notifications at init time if needed")
Fixes: 042a3d80f118 ("thermal: core: Move passive polling management to the core")
Reported-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    9 ++++++++-
 drivers/thermal/thermal_trip.c |   18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1401,8 +1401,15 @@ thermal_zone_device_register_with_trips(
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
 	tz->num_trips = num_trips;
-	for_each_trip_desc(tz, td)
+	for_each_trip_desc(tz, td) {
 		td->trip = *trip++;
+		/*
+		 * Mark all thresholds as invalid to start with even though
+		 * this only matters for the trips that start as invalid and
+		 * become valid later.
+		 */
+		td->threshold = INT_MAX;
+	}
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -137,6 +137,24 @@ void thermal_zone_set_trip_temp(struct t
 	if (trip->temperature == temp)
 		return;
 
+	if (temp == THERMAL_TEMP_INVALID) {
+		struct thermal_trip_desc *td = trip_to_trip_desc(trip);
+
+		if (trip->type == THERMAL_TRIP_PASSIVE &&
+		    tz->temperature >= td->threshold) {
+			/*
+			 * The trip has been crossed, so the thermal zone's
+			 * passive count needs to be adjusted.
+			 */
+			tz->passive--;
+			WARN_ON_ONCE(tz->passive < 0);
+		}
+		/*
+		 * Invalidate the threshold to avoid triggering a spurious
+		 * trip crossing notification when the trip becomes valid.
+		 */
+		td->threshold = INT_MAX;
+	}
 	WRITE_ONCE(trip->temperature, temp);
 	thermal_notify_tz_trip_change(tz, trip);
 }




