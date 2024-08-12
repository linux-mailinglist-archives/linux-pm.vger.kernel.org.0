Return-Path: <linux-pm+bounces-12097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3594EF86
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24BF28423E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B30180032;
	Mon, 12 Aug 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UVb8YieB"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73BD16C440;
	Mon, 12 Aug 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472945; cv=none; b=Q0pTPakGyyeRT61afIfEuFiLh0xmJ7fUqx5Y8m/KaMFwB349viJ2+d/9SCyTuk6LcbUVeIqHs3Zn3wj9aYWa2nAntHt1CcIUl5NDQYjtJ1bUOA1TPsJPYjBKQJ4I3N9H5/q8+tgsJldTfsmuuS412+ZQKfWB1vtwCKhy261gQ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472945; c=relaxed/simple;
	bh=zflqJ7QzxDtm71SHFZgn6UPy1CvHUOFuacN5Mn8mrvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9u+OQdnKP3UX8MvDpjVLT86quuKs3AWVlBSUajEXAmHVExvoU9zz+OYY5FwraT9cAhOCCkKtS6j/nsB4MHCOs7FiRHINjIf0WmikO8G58rjZKZOZ3CJr65XEuLxd4VgmVTan2TIja8tAd38KJlcr4lKfx0Ep3f9JQhDMEcjZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UVb8YieB reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 2c6fcd85e02acbee; Mon, 12 Aug 2024 16:29:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7E9F16F0D9D;
	Mon, 12 Aug 2024 16:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723472940;
	bh=zflqJ7QzxDtm71SHFZgn6UPy1CvHUOFuacN5Mn8mrvM=;
	h=From:Subject:Date;
	b=UVb8YieBClh1ax4vRzDg6pcQIOof87NFxZ1L+ytizuSA0peetsiXpu8q4pj9sl0nB
	 KByqwSx5405wZk+CoIZeqiQVQpy0vu0cPCD0w7QqwF+kIdWyvsCuToRwkBBZXgIbz1
	 pgmtkPB14T/XxfR7djPMsTgKNdX/A29b6BYkJAYAJCB9mPkYINhA+2iraqw8Kigo1k
	 VLiggUFIDetSkmAJqKQC386NvH125hfQsss7+BpL9mXrCh/YECCGLo5vB1+iVvVHGo
	 Ip5+wtSMdtImWd30fNz9dOVfPxPNsDv4a672WCgUzoYcuZRcGPxzA/YtIc33EqNIpT
	 gf80ilQ1XATiQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 17/17] thermal: code: Pass trip descriptors to trip bind/unbind
 functions
Date: Mon, 12 Aug 2024 16:28:45 +0200
Message-ID: <2030808.PIDvDuAF1L@rjwysocki.net>
In-Reply-To: <114901234.nniJfEyVGO@rjwysocki.net>
References: <114901234.nniJfEyVGO@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code is somewhat cleaner if struct thermal_trip_desc pointers are
passed to thermal_bind_cdev_to_trip(), thermal_unbind_cdev_from_trip(),
and print_bind_err_msg() instead of struct thermal_trip pointers, so
modify it accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -759,9 +759,9 @@ struct thermal_zone_device *thermal_zone
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to bind @cdev to
  * @cdev:	pointer to struct thermal_cooling_device
- * @c:		cooling specification for @trip and @cdev
+ * @c:		cooling specification for the trip point and @cdev
  *
  * This interface function bind a thermal cooling device to the certain trip
  * point of a thermal zone device.
@@ -770,11 +770,10 @@ struct thermal_zone_device *thermal_zone
  * Return: 0 on success, the proper error value otherwise.
  */
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-				     struct thermal_trip *trip,
+				     struct thermal_trip_desc *td,
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *c)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *dev, *instance;
 	bool upper_no_limit;
 	int result;
@@ -805,7 +804,7 @@ static int thermal_bind_cdev_to_trip(str
 
 	dev->tz = tz;
 	dev->cdev = cdev;
-	dev->trip = trip;
+	dev->trip = &td->trip;
 	dev->upper = c->upper;
 	dev->upper_no_limit = upper_no_limit;
 	dev->lower = c->lower;
@@ -878,7 +877,7 @@ free_mem:
 /**
  * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to unbind @cdev from
  * @cdev:	pointer to a struct thermal_cooling_device.
  *
  * This interface function unbind a thermal cooling device from the certain
@@ -886,10 +885,9 @@ free_mem:
  * This function is usually called in the thermal zone device .unbind callback.
  */
 static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					  struct thermal_trip *trip,
+					  struct thermal_trip_desc *td,
 					  struct thermal_cooling_device *cdev)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
 	lockdep_assert_held(&tz->lock);
@@ -945,11 +943,11 @@ static struct class *thermal_class;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
-			const struct thermal_trip *trip,
+			const struct thermal_trip_desc *td,
 			struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
-		cdev->type, thermal_zone_trip_id(tz, trip), ret);
+		cdev->type, thermal_zone_trip_id(tz, &td->trip), ret);
 }
 
 static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
@@ -963,7 +961,6 @@ static void thermal_zone_cdev_binding(st
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td) {
-		struct thermal_trip *trip = &td->trip;
 		struct cooling_spec c = {
 			.upper = THERMAL_NO_LIMIT,
 			.lower = THERMAL_NO_LIMIT,
@@ -971,12 +968,12 @@ static void thermal_zone_cdev_binding(st
 		};
 		int ret;
 
-		if (!tz->ops.should_bind(tz, trip, cdev, &c))
+		if (!tz->ops.should_bind(tz, &td->trip, cdev, &c))
 			continue;
 
-		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
+		ret = thermal_bind_cdev_to_trip(tz, td, cdev, &c);
 		if (ret)
-			print_bind_err_msg(tz, trip, cdev, ret);
+			print_bind_err_msg(tz, td, cdev, ret);
 	}
 
 	mutex_unlock(&tz->lock);
@@ -1287,7 +1284,7 @@ static void thermal_zone_cdev_unbinding(
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td)
-		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
+		thermal_unbind_cdev_from_trip(tz, td, cdev);
 
 	mutex_unlock(&tz->lock);
 }




