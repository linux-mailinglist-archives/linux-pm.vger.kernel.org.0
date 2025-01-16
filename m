Return-Path: <linux-pm+bounces-20583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62006A14255
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D811D3A237C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E37234D1F;
	Thu, 16 Jan 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gTaEFclF"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DFB22E409;
	Thu, 16 Jan 2025 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055933; cv=none; b=KrF7Aa5v6qudIhw/On2PqeCssZSEYfNUhLkhhWDeVP+najG7OeFt4t6Jv4MjXuxK7FRYcDqsWclu36495pN0aFPL1zENclO+wQPd/4GVp/+yBuOfflr2WpgC4mHqklNxaNcsimsrzxkU/zQ1zB71EFNHTmqKrZvEXWxBJK/Qfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055933; c=relaxed/simple;
	bh=t+ODKSF2lgcrwPyi0CLV5sncFU9+BvQfEWjTtjhtmLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEJL0TI2JbycwyvFsU6AwEoSc/leRu2/nRQW7LzS9Xgm/Hn2aiP0ghJrUBFhZiRqOttNvYwm5lmos/HFK7mGUc5ltYzQL5Ef1ECI3oHIoH/Kmjp/rTklb1fFl2W2Wh9FFwXgroSDzH5Ga9ruzhT3TMZSvFBrnZo8GofFW1wG6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gTaEFclF; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id a793888f2ca5859e; Thu, 16 Jan 2025 20:32:09 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5A1798E0B61;
	Thu, 16 Jan 2025 20:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1737055928;
	bh=t+ODKSF2lgcrwPyi0CLV5sncFU9+BvQfEWjTtjhtmLI=;
	h=From:Subject:Date;
	b=gTaEFclFYZGxVw5y+j0IgDxlCD9PV5DvBjoV3kdYjjKm6ZrJc1enJvLSJZtHBaeiS
	 tmP1NkoCypQwd5MFIsvdi8IbGpUmVKF3wuA6qBj4z/FD6I0jYjqMzEQbXMdIf+pVkZ
	 szJPj0R8pUhLZhUd20z0mJR3epMoX6VBMH1l4Xh9vlHZ07theScQgRfUCjyXoTZl12
	 8wBkYrM1YxTw6fD9ZBY/MQXZ0LdkFS0PNrtDyUKt9yTuOiApLNdW+tnBnQ9QkFso4t
	 mTW99/qJIvO/CmG6/5oS1xwy6qcTPBkgzkiOWxkEBEELDe+jQJCIvvv9ZfU+ztDPVQ
	 hj19kXfR8IKFg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 1/3] thermal: core: Rename callback functions in two governors
Date: Thu, 16 Jan 2025 20:30:27 +0100
Message-ID: <5859084.DvuYhMxLoT@rjwysocki.net>
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

The names of :trip_crossed() callback functions in the Bang-bang and
User-space thermal governors don't match their current purpose any
more after previous changes, so rename them.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c  |   10 +++++-----
 drivers/thermal/gov_user_space.c |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -34,7 +34,7 @@
 }
 
 /**
- * bang_bang_control - controls devices associated with the given zone
+ * bang_bang_trip_crossed - controls devices associated with the given zone
  * @tz: thermal_zone_device
  * @trip: the trip point
  * @crossed_up: whether or not the trip has been crossed on the way up
@@ -61,9 +61,9 @@
  *     (trip_temp - hyst) so that the fan gets turned off again.
  *
  */
-static void bang_bang_control(struct thermal_zone_device *tz,
-			      const struct thermal_trip *trip,
-			      bool crossed_up)
+static void bang_bang_trip_crossed(struct thermal_zone_device *tz,
+				   const struct thermal_trip *trip,
+				   bool crossed_up)
 {
 	const struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *instance;
@@ -123,7 +123,7 @@
 
 static struct thermal_governor thermal_gov_bang_bang = {
 	.name		= "bang_bang",
-	.trip_crossed	= bang_bang_control,
+	.trip_crossed	= bang_bang_trip_crossed,
 	.manage		= bang_bang_manage,
 	.update_tz	= bang_bang_update_tz,
 };
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -23,16 +23,16 @@
 }
 
 /**
- * notify_user_space - Notifies user space about thermal events
+ * user_space_trip_crossed - Notify user space about trip crossing events
  * @tz: thermal_zone_device
  * @trip: trip point
  * @crossed_up: whether or not the trip has been crossed on the way up
  *
  * This function notifies the user space through UEvents.
  */
-static void notify_user_space(struct thermal_zone_device *tz,
-			      const struct thermal_trip *trip,
-			      bool crossed_up)
+static void user_space_trip_crossed(struct thermal_zone_device *tz,
+				    const struct thermal_trip *trip,
+				    bool crossed_up)
 {
 	char *thermal_prop[5];
 	int i;
@@ -52,7 +52,7 @@
 
 static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
-	.trip_crossed	= notify_user_space,
+	.trip_crossed	= user_space_trip_crossed,
 	.bind_to_tz	= user_space_bind,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);




