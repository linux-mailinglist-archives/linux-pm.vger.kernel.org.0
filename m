Return-Path: <linux-pm+bounces-15169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A931990FEF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C431C22844
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6491E283F;
	Fri,  4 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eRIrJ7UV"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B331E04AA;
	Fri,  4 Oct 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070994; cv=none; b=GOcuN0P/92Tz/h1podetlIjHJiuMzOEtQ30Sv01tne6NrkYS4v09lFJFRhCsRizP7ZlEpO0WEkVr/iowYkYX8UOYpKTkkPqP+Z2RRFp5Gvcs8bf3c9BpbPaNMaxI67ixEQObNJn6MGeVwGy4on8sZPXEgaCoThjDQK7d/kIk+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070994; c=relaxed/simple;
	bh=r1eo//L6VVctTILFDWgYB4+XSDUQ9la2/czwVaNfpeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0VJ1iT9bh+N1r/Tpvky4LgSpNfwZRq5dRmSV3FesIiKkQdNjhX2pfTkng77CqUXXkSdHIuio6uthkP61YsmaDqJDnGR62ylk74/U5WYDD0ZobGFolxCILf955dmS/RSQEkHmbs+FER1an/K4MCP+r3YLbtatIjvuYRJ/SliDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eRIrJ7UV reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1f4bd3d36c6c5d6a; Fri, 4 Oct 2024 21:43:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 55C7A6A9505;
	Fri,  4 Oct 2024 21:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070985;
	bh=r1eo//L6VVctTILFDWgYB4+XSDUQ9la2/czwVaNfpeA=;
	h=From:Subject:Date;
	b=eRIrJ7UVm8rvLkZbxuISxlmVpY6LECsuyHhafp9E66EwJ7s0ULnryQBc6QFPI5Bpl
	 S2O89h1dNDecayqvDggIuOKyghNiinJHmLWfzV0OkXgrpbv+wvGp1NJrPB/GZtsSiW
	 xkWk4rMOyU9QyZJyG04WA/qC+YCWCgyc9ufdEWkbvMS0ZwJrzK8BHX1JOQEXu0R73w
	 VZcbCKMM2WOH1tYEJnSXkIx5tLlXNwS+x3XRzvY6tOiH+2NqsU5VNzz3gOH4EPe7mK
	 IAvLg24JXEUqs8UPl8DHkytJH+55mIguiKVQfsV9hvVhDJRROrKkp+mLdYl1pQ6KCR
	 LV2WnQV1yOx4Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 06/12] thermal: core: Consolidate thermal zone locking during
 initialization
Date: Fri, 04 Oct 2024 21:23:10 +0200
Message-ID: <1920382.CQOukoFCf9@rjwysocki.net>
In-Reply-To: <2215082.irdbgypaU6@rjwysocki.net>
References: <2215082.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdi
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The part of thermal zone initialization carried out under
thermal_list_lock acquires the thermal zone lock and releases it
multiple times back and forth which is not really necessary.

Instead of doing this, make it acquire the thermal zone lock once after
acquiring thermal_list_lock and release it along with that lock.

For this purpose, move all of the code in question to
thermal_zone_init_complete() introduced previously and provide an
"unlocked" variant of thermal_zone_cdev_bind() to be invoked from
there.

Also notice that a thermal zone does not need to be added to
thermal_tz_list under its own lock, so make the new code acquire
the thermal zone lock after adding it to the list.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/10548633.nUPlyArG6x@rjwysocki.net/

v1 -> v2: Rebase, update the changelog.

---
 drivers/thermal/thermal_core.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -933,16 +933,14 @@ void print_bind_err_msg(struct thermal_z
 		cdev->type, thermal_zone_trip_id(tz, trip), ret);
 }
 
-static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
-				   struct thermal_cooling_device *cdev)
+static void __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
+				     struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
 
 	if (!tz->ops.should_bind)
 		return;
 
-	mutex_lock(&tz->lock);
-
 	for_each_trip_desc(tz, td) {
 		struct thermal_trip *trip = &td->trip;
 		struct cooling_spec c = {
@@ -959,6 +957,14 @@ static void thermal_zone_cdev_bind(struc
 		if (ret)
 			print_bind_err_msg(tz, trip, cdev, ret);
 	}
+}
+
+static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
+				   struct thermal_cooling_device *cdev)
+{
+	mutex_lock(&tz->lock);
+
+	__thermal_zone_cdev_bind(tz, cdev);
 
 	mutex_unlock(&tz->lock);
 }
@@ -1336,8 +1342,18 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
 
 static void thermal_zone_init_complete(struct thermal_zone_device *tz)
 {
+	struct thermal_cooling_device *cdev;
+
+	mutex_lock(&thermal_list_lock);
+
+	list_add_tail(&tz->node, &thermal_tz_list);
+
 	mutex_lock(&tz->lock);
 
+	/* Bind cooling devices for this zone. */
+	list_for_each_entry(cdev, &thermal_cdev_list, node)
+		__thermal_zone_cdev_bind(tz, cdev);
+
 	tz->state &= ~TZ_STATE_FLAG_INIT;
 	/*
 	 * If system suspend or resume is in progress at this point, the
@@ -1350,6 +1366,8 @@ static void thermal_zone_init_complete(s
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_unlock(&tz->lock);
+
+	mutex_unlock(&thermal_list_lock);
 }
 
 /**
@@ -1386,7 +1404,6 @@ thermal_zone_device_register_with_trips(
 					unsigned int polling_delay)
 {
 	const struct thermal_trip *trip = trips;
-	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *tz;
 	struct thermal_trip_desc *td;
 	int id;
@@ -1514,20 +1531,8 @@ thermal_zone_device_register_with_trips(
 			goto unregister;
 	}
 
-	mutex_lock(&thermal_list_lock);
-
-	mutex_lock(&tz->lock);
-	list_add_tail(&tz->node, &thermal_tz_list);
-	mutex_unlock(&tz->lock);
-
-	/* Bind cooling devices for this zone */
-	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		thermal_zone_cdev_bind(tz, cdev);
-
 	thermal_zone_init_complete(tz);
 
-	mutex_unlock(&thermal_list_lock);
-
 	thermal_notify_tz_create(tz);
 
 	thermal_debug_tz_add(tz);




