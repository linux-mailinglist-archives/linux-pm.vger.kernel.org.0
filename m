Return-Path: <linux-pm+bounces-20581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD567A14251
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA73A07F7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE901F37B0;
	Thu, 16 Jan 2025 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XYHOViTU"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F02159596;
	Thu, 16 Jan 2025 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055931; cv=none; b=gD68Jv+uE8k8CwSiA5cLjIpkBThHrU9bF0ntmZx6TdrkCsduG9Ix5U6/u6dzZKfS06fJhxQp1iaER7VRyvtB9i0UNEId7fOmOzT+qxWkHYvdifBE5dIjma8lxr1HC20HYwk08yOiHiFvSJh7bSZfKOrVcuPVnDQKMG+FSro0jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055931; c=relaxed/simple;
	bh=7tXj09p8hK0yKi8DNdzUjjuozDFAuKv6sSxiGgSLqv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPuLaeDWi8urdFMdXhUMGVB8hpGGimgMZrCE3Zh4EumZD3IK33c+8K42P6ddW264EF8EJ3y9u6+xch+X1fPH6U9RjKubDvEIoWI38uB6NIPrigDAwyq1wOPcyO8vfv4BNjC5KJLkY/kMXscoJvrpNTlMatWtnBtd0zSJnKrIW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XYHOViTU; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id cffb33421e741747; Thu, 16 Jan 2025 20:32:06 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 23B958E0B71;
	Thu, 16 Jan 2025 20:32:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737055926;
	bh=7tXj09p8hK0yKi8DNdzUjjuozDFAuKv6sSxiGgSLqv4=;
	h=From:Subject:Date;
	b=XYHOViTU9xaTAYbTDYol8DaMxWL61icxfIWxEjRXKnWoTYDkVyrB8K0wtdZ3qmM7y
	 ITPekfYOApfdVKp4TdQsDA91VP3btuzBf0iEG6Bk0M1Qqq7z+QF5Nz6/gMrAVC9wya
	 Kcvc9YLpmZEqiPJalpeN7StRBO2JBvfyoN79PeV9AuwFWAB/IUs4nF/fHFMovjzSAK
	 nUjbcwyuIEXtL/ss0iBwfC9X96/cmbs9VQiaji+lLW3W6yqbEXooITrT/1eQUTYQ0r
	 9qXB8BoDEFHeKrwh3KKeWSaGaidhCUBtoHr0qOFWih1o7L+OTheCyqy5TQFBJXdmVL
	 nPddiuswkcgIA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 3/3] thermal: core: Rename function argument related to trip
 crossing
Date: Thu, 16 Jan 2025 20:31:56 +0100
Message-ID: <2360961.ElGaqSPkdT@rjwysocki.net>
In-Reply-To: <2772026.mvXUDI8C0e@rjwysocki.net>
References: <2772026.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename the 'crossed_up' function argument to 'upward', which is more
proper English and a better match for representing temperature change
direction, everywhere in the code.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c  |    6 +++---
 drivers/thermal/gov_user_space.c |    4 ++--
 drivers/thermal/thermal_core.c   |   10 +++++-----
 drivers/thermal/thermal_core.h   |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -58,11 +58,11 @@
  * bang_bang_trip_crossed - controls devices associated with the given zone
  * @tz: thermal_zone_device
  * @trip: the trip point
- * @crossed_up: whether or not the trip has been crossed on the way up
+ * @upward: whether or not the trip has been crossed on the way up
  */
 static void bang_bang_trip_crossed(struct thermal_zone_device *tz,
 				   const struct thermal_trip *trip,
-				   bool crossed_up)
+				   bool upward)
 {
 	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *instance;
@@ -74,7 +74,7 @@
 		tz->temperature, trip->hysteresis);
 
 	list_for_each_entry(instance, &td->thermal_instances, trip_node)
-		bang_bang_set_instance_target(instance, crossed_up);
+		bang_bang_set_instance_target(instance, upward);
 }
 
 static void bang_bang_manage(struct thermal_zone_device *tz)
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -26,13 +26,13 @@
  * user_space_trip_crossed - Notify user space about trip crossing events
  * @tz: thermal_zone_device
  * @trip: trip point
- * @crossed_up: whether or not the trip has been crossed on the way up
+ * @upward: whether or not the trip has been crossed on the way up
  *
  * This function notifies the user space through UEvents.
  */
 static void user_space_trip_crossed(struct thermal_zone_device *tz,
 				    const struct thermal_trip *trip,
-				    bool crossed_up)
+				    bool upward)
 {
 	char *thermal_prop[5];
 	int i;
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -454,23 +454,23 @@
 static void thermal_governor_trip_crossed(struct thermal_governor *governor,
 					  struct thermal_zone_device *tz,
 					  const struct thermal_trip *trip,
-					  bool crossed_up)
+					  bool upward)
 {
 	if (trip->type == THERMAL_TRIP_HOT || trip->type == THERMAL_TRIP_CRITICAL)
 		return;
 
 	if (governor->trip_crossed)
-		governor->trip_crossed(tz, trip, crossed_up);
+		governor->trip_crossed(tz, trip, upward);
 }
 
 static void thermal_trip_crossed(struct thermal_zone_device *tz,
 				 struct thermal_trip_desc *td,
 				 struct thermal_governor *governor,
-				 bool crossed_up)
+				 bool upward)
 {
 	const struct thermal_trip *trip = &td->trip;
 
-	if (crossed_up) {
+	if (upward) {
 		if (trip->type == THERMAL_TRIP_PASSIVE)
 			tz->passive++;
 		else if (trip->type == THERMAL_TRIP_CRITICAL ||
@@ -493,7 +493,7 @@
 		dev_info(&tz->device, "Trip crossed down: %d\n",
 			 trip->temperature - trip->hysteresis);
 	}
-	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
+	thermal_governor_trip_crossed(governor, tz, trip, upward);
 }
 
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -56,7 +56,7 @@
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	void (*trip_crossed)(struct thermal_zone_device *tz,
 			     const struct thermal_trip *trip,
-			     bool crossed_up);
+			     bool upward);
 	void (*manage)(struct thermal_zone_device *tz);
 	void (*update_tz)(struct thermal_zone_device *tz,
 			  enum thermal_notify_event reason);




