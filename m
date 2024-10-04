Return-Path: <linux-pm+bounces-15171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC40990FF2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD201F24B5A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7721E2856;
	Fri,  4 Oct 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="wGUJLqiI"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16981E04A8;
	Fri,  4 Oct 2024 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070995; cv=none; b=nNRPZDT03J/YwZIzqCvmhmglqKBLBrLDSf584YURSYg/MqQRmGsgBJVpNz4UxemtF/4MHAAfhuhpJDdYQKSF9JgbcnUNjU655bPd04I1dLRgF5rFcL8L5UTbJmZsq/D22dh39zdCaMdde08vPDswaZfURts5pO7aqvRKVAhIEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070995; c=relaxed/simple;
	bh=4pAfbQul88O+wGLg5waluc8OVCGkgwNeqB9CD5lAYhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWJgQv5TVtPam3LgTdtViykop+gOXYBDHSb5Akny6ig2Zb8hF/3rolBRlXHSKDKb6b1sw5KhZo71qzvc5jsoP8Jzjv5oT4GZ2cI296VIMVB0Oee1XXtOUGR57uKYJfZ3MK5XV5hhjybadbEfiMk0DQawhPyCkO3albMjkaQPtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=wGUJLqiI reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 644555929af29ed5; Fri, 4 Oct 2024 21:43:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3918B6A9505;
	Fri,  4 Oct 2024 21:43:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070982;
	bh=4pAfbQul88O+wGLg5waluc8OVCGkgwNeqB9CD5lAYhg=;
	h=From:Subject:Date;
	b=wGUJLqiI3sxwPwhlxe+M5VeIJgC6ZH8tBMKL2s9fnsqj/hWBTEM5n/FcIHDT1jj8B
	 n6/sElIvFDbO63iyQpGu533l4lkz/1N+xmnmxz29k5604EgMwq8+8mhzYXeJzWo7tP
	 ijucRWfSj7URVIAfcH57e70l2U2eM9baz7xaSiSKMuMpXp0MTTCBzqXMR0u7WP0H+U
	 p/WIDpYNXu3pCzbbCQsaAmLg05WvrruN06knzCEnwRuUwT7LpOrvDDtU9gvkUoeHMV
	 ocWiT1jjkTsC2NK4I3cF3N3/2e3xGorpXaa55M34zx4w9YnHHEEFTronspa9ezUxFl
	 3rrPMhpXdOO8A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 12/12] thermal: core: Pass trip descriptors to trip bind/unbind
 functions
Date: Fri, 04 Oct 2024 21:42:19 +0200
Message-ID: <2246211.NgBsaNRSFp@rjwysocki.net>
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

The code is somewhat cleaner if struct thermal_trip_desc pointers are
passed to thermal_bind_cdev_to_trip(), thermal_unbind_cdev_from_trip(),
and print_bind_err_msg() instead of struct thermal_trip pointers, so
modify it accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/2954063.e9J7NaK4W3@rjwysocki.net/

v1 -> v2: Rebase and drop the leftover Subject: field from the preamble.

---
 drivers/thermal/thermal_core.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -757,9 +757,9 @@ struct thermal_zone_device *thermal_zone
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to bind @cdev to
  * @cdev:	pointer to struct thermal_cooling_device
- * @cool_spec:	cooling specification for @trip and @cdev
+ * @cool_spec:	cooling specification for the trip point and @cdev
  *
  * This interface function bind a thermal cooling device to the certain trip
  * point of a thermal zone device.
@@ -768,11 +768,10 @@ struct thermal_zone_device *thermal_zone
  * Return: 0 on success, the proper error value otherwise.
  */
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-				     struct thermal_trip *trip,
+				     struct thermal_trip_desc *td,
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *cool_spec)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *dev, *instance;
 	bool upper_no_limit;
 	int result;
@@ -796,7 +795,7 @@ static int thermal_bind_cdev_to_trip(str
 		return -ENOMEM;
 
 	dev->cdev = cdev;
-	dev->trip = trip;
+	dev->trip = &td->trip;
 	dev->upper = cool_spec->upper;
 	dev->upper_no_limit = upper_no_limit;
 	dev->lower = cool_spec->lower;
@@ -867,7 +866,7 @@ free_mem:
 /**
  * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to unbind @cdev from
  * @cdev:	pointer to a struct thermal_cooling_device.
  *
  * This interface function unbind a thermal cooling device from the certain
@@ -875,10 +874,9 @@ free_mem:
  * This function is usually called in the thermal zone device .unbind callback.
  */
 static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					  struct thermal_trip *trip,
+					  struct thermal_trip_desc *td,
 					  struct thermal_cooling_device *cdev)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&cdev->lock);
@@ -930,11 +928,11 @@ static struct class *thermal_class;
 
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
 
 static bool __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
@@ -947,7 +945,6 @@ static bool __thermal_zone_cdev_bind(str
 		return false;
 
 	for_each_trip_desc(tz, td) {
-		struct thermal_trip *trip = &td->trip;
 		struct cooling_spec c = {
 			.upper = THERMAL_NO_LIMIT,
 			.lower = THERMAL_NO_LIMIT,
@@ -955,12 +952,12 @@ static bool __thermal_zone_cdev_bind(str
 		};
 		int ret;
 
-		if (!tz->ops.should_bind(tz, trip, cdev, &c))
+		if (!tz->ops.should_bind(tz, &td->trip, cdev, &c))
 			continue;
 
-		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
+		ret = thermal_bind_cdev_to_trip(tz, td, cdev, &c);
 		if (ret) {
-			print_bind_err_msg(tz, trip, cdev, ret);
+			print_bind_err_msg(tz, td, cdev, ret);
 			continue;
 		}
 
@@ -1279,7 +1276,7 @@ static void __thermal_zone_cdev_unbind(s
 	struct thermal_trip_desc *td;
 
 	for_each_trip_desc(tz, td)
-		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
+		thermal_unbind_cdev_from_trip(tz, td, cdev);
 }
 
 static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,




