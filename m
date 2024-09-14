Return-Path: <linux-pm+bounces-14271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034DF979040
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F4B22944
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AAD1CEAA9;
	Sat, 14 Sep 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Tq89ZFBa"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A41CF2B1;
	Sat, 14 Sep 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311827; cv=none; b=HQiv2vHcOfLj7bxGilcslCEAnQs2xwsIrAx16tP6bCeOLBlhI7VRPj4/2NAOgsw0vMgjwKcKt59VqUu0zcUnj2J6dns0JpOXoJTbmXO/rEIr6Qxp9Iqi46Lrmm9MCbGPyFbk/T+mNKtFSvjd72/6W1Y5wH08zbZk0jb3P5OhsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311827; c=relaxed/simple;
	bh=9WXyKvAcLO2BMZyBokhszmnjfpwu44G6g4cyK24kuwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3WaN0su0n1crrAPjcn6BENeIax6+uhgpqIet/595jIolCMSOZCOlxp7LSvaI0FywBurmHAJOqNem9z8TCumJZA2sA9D5lhrmYqiJADd9VdMu6QO6vp8NDsxVkQNx+k2ZG+6m5MZEMT4MQ78j1NUdtZcWi1NCMky1taO6YVxL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Tq89ZFBa reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5b635f05774a90d9; Sat, 14 Sep 2024 13:03:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1725F8532AE;
	Sat, 14 Sep 2024 13:03:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311822;
	bh=9WXyKvAcLO2BMZyBokhszmnjfpwu44G6g4cyK24kuwI=;
	h=From:Subject:Date;
	b=Tq89ZFBa9frfgbK0J4wzD807UM9ILLu8Uiki9tGXyiOJJ3gvj8N5m5qpPrXsn7ldY
	 TeoXDhU6BXJs99gqFt9h1S5xNBgHfPm9sUxXm63phvXGRJEH2SgMmnnE7HkXlJWzev
	 TklUPBIJGW8F/hU1YFIbKM+YZVT8og9n5kDJWdGse0WKM7aW2GxaWs7m8fPZvMBcuM
	 driZAi7MsbxnKZ59wL8bbYDpqNOtak5zxpd8IfxsVxJUjrkhezEc9Yg2fzGDYDDR6B
	 BvlNKxceDGVu5kRcCYcIdZ8HAhS1XD6N+xrrgvaxt6H6hSjorPzq4W6KkuRB4ReFxV
	 IZLB1/fQDtHZQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 09/20] thermal: core: Update thermal zones after
 cooling device binding
Date: Sat, 14 Sep 2024 12:36:51 +0200
Message-ID: <3603909.iIbC2pHGDl@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=25 Fuz1=25 Fuz2=25

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a new cooling device is registered and it is bound to at least one
trip point in a given thermal zone, that thermal zone needs to be
updated via __thermal_zone_device_update().

Instead of doing this with the help of the need_update atomic field in
struct thermal_zone_device, which is not particularly straightforward,
make __thermal_zone_cdev_bind() return a bool value indicating whether
or not the given thermal zone needs to be updated because a new cooling
device has been bound to it and update thermal_zone_cdev_bind() to
call __thermal_zone_device_update() when this value is "true".

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -919,13 +919,14 @@ void print_bind_err_msg(struct thermal_z
 		cdev->type, thermal_zone_trip_id(tz, &td->trip), ret);
 }
 
-static void __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
+static bool __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
 				     struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
+	bool update_tz = false;
 
 	if (!tz->ops.should_bind)
-		return;
+		return false;
 
 	for_each_trip_desc(tz, td) {
 		struct cooling_spec c = {
@@ -939,9 +940,15 @@ static void __thermal_zone_cdev_bind(str
 			continue;
 
 		ret = thermal_bind_cdev_to_trip(tz, td, cdev, &c);
-		if (ret)
+		if (ret) {
 			print_bind_err_msg(tz, td, cdev, ret);
+			continue;
+		}
+
+		update_tz = true;
 	}
+
+	return update_tz;
 }
 
 static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
@@ -949,7 +956,8 @@ static void thermal_zone_cdev_bind(struc
 {
 	guard(thermal_zone)(tz);
 
-	__thermal_zone_cdev_bind(tz, cdev);
+	if (__thermal_zone_cdev_bind(tz, cdev))
+		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 }
 
 /**
@@ -974,7 +982,7 @@ __thermal_cooling_device_register(struct
 				  const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos = NULL;
+	struct thermal_zone_device *pos;
 	unsigned long current_state;
 	int id, ret;
 
@@ -1050,11 +1058,6 @@ __thermal_cooling_device_register(struct
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		thermal_zone_cdev_bind(pos, cdev);
 
-	list_for_each_entry(pos, &thermal_tz_list, node)
-		if (atomic_cmpxchg(&pos->need_update, 1, 0))
-			thermal_zone_device_update(pos,
-						   THERMAL_EVENT_UNSPECIFIED);
-
 	mutex_unlock(&thermal_list_lock);
 
 	return cdev;




