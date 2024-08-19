Return-Path: <linux-pm+bounces-12466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A939B957066
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90201C22F98
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE117BEAB;
	Mon, 19 Aug 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="rgc4PxOX"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689361779B1;
	Mon, 19 Aug 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085224; cv=none; b=OPMM10elSZ1Q3a9Plv61xnWkmOdUMmgIpCmTjD4gDPL83YFCrlM0/02PjmmsoAaDkc79ncvw+yMCkAvdmuDv+8Xvt84GLSOFN3EQuPcvWCnBzmKGIVMlTdJOC2tetYzU4Htb9VQztIV/mINUyDCKaos21qEH16fkFGTETZL/o/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085224; c=relaxed/simple;
	bh=1rmRkOp/G1zw1BTYJ88TooQhz7hpFirwprXdmYNqyaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayjiNCecwrbsfHClUs2q1eWNFYWOv2odsm1TSAZBSACrso1jxlFGk3345O0NGbmNVwaTbJ+H5yRgWYEd0XbO0P4Okd96y/Ksd1CtILrZZRKGQknDR65xvWUCIhzbc8ogcyDFSJSboOc+3lEoS1H4pwDi6Y4W5tHK+IXzHvySQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=rgc4PxOX reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e201a420142ffabc; Mon, 19 Aug 2024 18:33:40 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id ED81573B5D4;
	Mon, 19 Aug 2024 18:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724085220;
	bh=1rmRkOp/G1zw1BTYJ88TooQhz7hpFirwprXdmYNqyaI=;
	h=From:Subject:Date;
	b=rgc4PxOXVPGouUEJ3yGeFumjpFB6LsTB7KTuFxJfE+EW9SuKVWa5zZNvogKnhSI0r
	 tUiwVyVmT9twmwwEzJUiU6ot7v3o21qIC7QzOAfQOrtNtIQFFh15gixqAk23acu4UP
	 9BUj7BjykllFhBCrnhEbd83qSngnhWwdWIU6pJbbOo7oqo7RTKsWk3ybK0deER4XXY
	 xe7eyGqrrQe5rAK3GohvbSGaYoIlnWlaIYZcuyinsI933DnY21lrkY26ZWBKOE8tEs
	 si3mBcHnVubxYNpANvJ8ZvEA0qC9a1IAxwZ0OObt2D70cLnBVmOMWO1Bas1N5cmCMs
	 1gpiyK+5tJrxg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 13/14] thermal: core: Drop unused bind/unbind functions and
 callbacks
Date: Mon, 19 Aug 2024 18:31:33 +0200
Message-ID: <4251116.1IzOArtZ34@rjwysocki.net>
In-Reply-To: <2205737.irdbgypaU6@rjwysocki.net>
References: <2205737.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdp
 rhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no more callers of thermal_zone_bind_cooling_device() and
thermal_zone_unbind_cooling_device(), so drop them along with all of
the corresponding headers, code and documentation.

Moreover, because the .bind() and .unbind() thermal zone callbacks would
only be used when the above functions, respectively, were called, drop
them as well along with all of the code related to them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: No changes

v1 -> v2:
   * Update the list of thermal zone ops in the documentation.

---
 Documentation/driver-api/thermal/sysfs-api.rst |   59 +------------------
 drivers/thermal/thermal_core.c                 |   75 +------------------------
 include/linux/thermal.h                        |   10 ---
 3 files changed, 6 insertions(+), 138 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -878,28 +878,6 @@ free_mem:
 	return result;
 }
 
-int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
-				     int trip_index,
-				     struct thermal_cooling_device *cdev,
-				     unsigned long upper, unsigned long lower,
-				     unsigned int weight)
-{
-	int ret;
-
-	if (trip_index < 0 || trip_index >= tz->num_trips)
-		return -EINVAL;
-
-	mutex_lock(&tz->lock);
-
-	ret = thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
-					upper, lower, weight);
-
-	mutex_unlock(&tz->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
-
 /**
  * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
@@ -945,25 +923,6 @@ unbind:
 	return 0;
 }
 
-int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
-				       int trip_index,
-				       struct thermal_cooling_device *cdev)
-{
-	int ret;
-
-	if (trip_index < 0 || trip_index >= tz->num_trips)
-		return -EINVAL;
-
-	mutex_lock(&tz->lock);
-
-	ret = thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
-
-	mutex_unlock(&tz->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
-
 static void thermal_release(struct device *dev)
 {
 	struct thermal_zone_device *tz;
@@ -992,14 +951,8 @@ void print_bind_err_msg(struct thermal_z
 			const struct thermal_trip *trip,
 			struct thermal_cooling_device *cdev, int ret)
 {
-	if (trip) {
-		dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
-			cdev->type, thermal_zone_trip_id(tz, trip), ret);
-		return;
-	}
-
-	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
-		tz->type, cdev->type, ret);
+	dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
+		cdev->type, thermal_zone_trip_id(tz, trip), ret);
 }
 
 static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
@@ -1008,18 +961,6 @@ static void thermal_zone_cdev_binding(st
 	struct thermal_trip_desc *td;
 	int ret;
 
-	/*
-	 * Old-style binding. The .bind() callback is expected to call
-	 * thermal_bind_cdev_to_trip() under the thermal zone lock.
-	 */
-	if (tz->ops.bind) {
-		ret = tz->ops.bind(tz, cdev);
-		if (ret)
-			print_bind_err_msg(tz, NULL, cdev, ret);
-
-		return;
-	}
-
 	if (!tz->ops.should_bind)
 		return;
 
@@ -1346,15 +1287,6 @@ static void thermal_zone_cdev_unbinding(
 {
 	struct thermal_trip_desc *td;
 
-	/*
-	 * Old-style unbinding.  The .unbind callback is expected to call
-	 * thermal_unbind_cdev_from_trip() under the thermal zone lock.
-	 */
-	if (tz->ops.unbind) {
-		tz->ops.unbind(tz, cdev);
-		return;
-	}
-
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td)
@@ -1488,8 +1420,7 @@ thermal_zone_device_register_with_trips(
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!ops || !ops->get_temp || (ops->should_bind && ops->bind) ||
-	    (ops->should_bind && ops->unbind)) {
+	if (!ops || !ops->get_temp) {
 		pr_err("Thermal zone device ops not defined or invalid\n");
 		return ERR_PTR(-EINVAL);
 	}
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -92,10 +92,6 @@ struct cooling_spec {
 };
 
 struct thermal_zone_device_ops {
-	int (*bind) (struct thermal_zone_device *,
-		     struct thermal_cooling_device *);
-	int (*unbind) (struct thermal_zone_device *,
-		       struct thermal_cooling_device *);
 	bool (*should_bind) (struct thermal_zone_device *,
 			     const struct thermal_trip *,
 			     struct thermal_cooling_device *,
@@ -247,12 +243,6 @@ const char *thermal_zone_device_type(str
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
 struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
-int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
-				     struct thermal_cooling_device *,
-				     unsigned long, unsigned long,
-				     unsigned int);
-int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
-				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
 
Index: linux-pm/Documentation/driver-api/thermal/sysfs-api.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/thermal/sysfs-api.rst
+++ linux-pm/Documentation/driver-api/thermal/sysfs-api.rst
@@ -58,10 +58,9 @@ temperature) and throttle appropriate de
     ops:
 	thermal zone device call-backs.
 
-	.bind:
-		bind the thermal zone device with a thermal cooling device.
-	.unbind:
-		unbind the thermal zone device with a thermal cooling device.
+	.should_bind:
+		check whether or not a given cooling device should be bound to
+		a given trip point in this thermal zone.
 	.get_temp:
 		get the current temperature of the thermal zone.
 	.set_trips:
@@ -246,56 +245,6 @@ temperature) and throttle appropriate de
     It deletes the corresponding entry from /sys/class/thermal folder and
     unbinds itself from all the thermal zone devices using it.
 
-1.3 interface for binding a thermal zone device with a thermal cooling device
------------------------------------------------------------------------------
-
-    ::
-
-	int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
-		int trip, struct thermal_cooling_device *cdev,
-		unsigned long upper, unsigned long lower, unsigned int weight);
-
-    This interface function binds a thermal cooling device to a particular trip
-    point of a thermal zone device.
-
-    This function is usually called in the thermal zone device .bind callback.
-
-    tz:
-	  the thermal zone device
-    cdev:
-	  thermal cooling device
-    trip:
-	  indicates which trip point in this thermal zone the cooling device
-	  is associated with.
-    upper:
-	  the Maximum cooling state for this trip point.
-	  THERMAL_NO_LIMIT means no upper limit,
-	  and the cooling device can be in max_state.
-    lower:
-	  the Minimum cooling state can be used for this trip point.
-	  THERMAL_NO_LIMIT means no lower limit,
-	  and the cooling device can be in cooling state 0.
-    weight:
-	  the influence of this cooling device in this thermal
-	  zone.  See 1.4.1 below for more information.
-
-    ::
-
-	int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
-				int trip, struct thermal_cooling_device *cdev);
-
-    This interface function unbinds a thermal cooling device from a particular
-    trip point of a thermal zone device. This function is usually called in
-    the thermal zone device .unbind callback.
-
-    tz:
-	the thermal zone device
-    cdev:
-	thermal cooling device
-    trip:
-	indicates which trip point in this thermal zone the cooling device
-	is associated with.
-
 1.4 Thermal Zone Parameters
 ---------------------------
 
@@ -366,8 +315,6 @@ Thermal cooling device sys I/F, created
 
 Then next two dynamic attributes are created/removed in pairs. They represent
 the relationship between a thermal zone and its associated cooling device.
-They are created/removed for each successful execution of
-thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device.
 
 ::
 




