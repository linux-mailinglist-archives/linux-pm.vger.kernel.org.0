Return-Path: <linux-pm+bounces-14274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5174979047
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778012856B7
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28521CEEAF;
	Sat, 14 Sep 2024 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eRGuhE01"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDF61CEAA9;
	Sat, 14 Sep 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312151; cv=none; b=cvRdaEE1Oq2idzLZJDl8ZhNm4rraNLMNhKMezfPojw0kMUFPDcJ7ai/RWEhFuCewm3L93rOwKFsDjm4DCfYlPQ+cnqTLSVZhfGIt7YzDv6T4t2TMO0+TviMV6mU216trJeQevXOpETV6YHzhGSL7SOO1U84JAKxw8oXI+SsIf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312151; c=relaxed/simple;
	bh=sq2UmYbbnOGBr85+l3Ku3qnhEozpZ2jyvuuLubWqfKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5kI0IFb4DYtMW7x+2wRdW1yp1cyT5QnQr8ltnG/CrlUNoRDKZqzNNXHDHv3jOFRluPn+O85eatz18a5Ey6ULqHs7bLiwf+c3vNUuKWgg9/J+UhTcKvLDyFocW7Z+iBzM+k///gsla8y3CMr5dO+pP69aYwSLQlNNxKRhiCQxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eRGuhE01 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d45f49d283229167; Sat, 14 Sep 2024 13:09:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 442BF853358;
	Sat, 14 Sep 2024 13:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312147;
	bh=sq2UmYbbnOGBr85+l3Ku3qnhEozpZ2jyvuuLubWqfKQ=;
	h=From:Subject:Date;
	b=eRGuhE01zhmibwHIvieYYdaLcSFQid7rGN2ag/5mfi8jiiX342yrdaWjPfNhwFexl
	 7zlj1rrMlXJASmyjCPk7RlnUJKP4B/N+VNTbrr7cTcHkPSRR63T66ydUQTdQ9d15og
	 Q7FLdzfBAZH2L2eik3AFnu/kndqwlYEaXkZPg5/Ue5VW3xQvWpop0LafJWGpICC6oC
	 btUrqUL2Ge1Cn+WS7V6F9d6n3KfN7YUvSsQgG1m9aMrsb23VN/BaDZWpNp5yQaJ0FQ
	 sBcuXCI49muP2wiqWg5yZyfWPsgcjwgBkg4zW4MiO2gKdHgKDLwuK40joyoUkq05p0
	 6BXrkacORofBA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 06/20] thermal: core: Consolidate thermal zone locking
 during initialization
Date: Sat, 14 Sep 2024 12:32:45 +0200
Message-ID: <10548633.nUPlyArG6x@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=35 Fuz1=35 Fuz2=35

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The part of thermal zone initialization carried out under
thermal_list_lock acquires the thermal zone lock and releases it
multiple times back-to-back which is not really necessary.

Instead of doing this, acquire the thermal zone lock once after
acquiring thermal_list_lock and release it along with that lock.

For this purpose, move all of the code in question to
thermal_zone_init_complete() introduced previously and provide an
"unloacked" variant of thermal_zone_cdev_bind() to be invoked from
there.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -919,16 +919,14 @@ void print_bind_err_msg(struct thermal_z
 		cdev->type, thermal_zone_trip_id(tz, &td->trip), ret);
 }
 
-static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
-				   struct thermal_cooling_device *cdev)
+static void __thermal_zone_cdev_bind(struct thermal_zone_device *tz,
+				     struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
 
 	if (!tz->ops.should_bind)
 		return;
 
-	guard(thermal_zone)(tz);
-
 	for_each_trip_desc(tz, td) {
 		struct cooling_spec c = {
 			.upper = THERMAL_NO_LIMIT,
@@ -946,6 +944,14 @@ static void thermal_zone_cdev_bind(struc
 	}
 }
 
+static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
+				   struct thermal_cooling_device *cdev)
+{
+	guard(thermal_zone)(tz);
+
+	__thermal_zone_cdev_bind(tz, cdev);
+}
+
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -1313,17 +1319,20 @@ int thermal_zone_get_crit_temp(struct th
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
-static void thermal_zone_add_to_list(struct thermal_zone_device *tz)
+static void thermal_zone_init_complete(struct thermal_zone_device *tz)
 {
-	guard(thermal_zone)(tz);
+	struct thermal_cooling_device *cdev;
+
+	mutex_lock(&thermal_list_lock);
 
 	list_add_tail(&tz->node, &thermal_tz_list);
-}
 
-static void thermal_zone_init_complete(struct thermal_zone_device *tz)
-{
 	guard(thermal_zone)(tz);
 
+	/* Bind cooling devices for this zone. */
+	list_for_each_entry(cdev, &thermal_cdev_list, node)
+		__thermal_zone_cdev_bind(tz, cdev);
+
 	tz->state &= ~TZ_STATE_FLAG_INIT;
 	/*
 	 * If system suspend or resume is in progress at this point, the
@@ -1334,6 +1343,8 @@ static void thermal_zone_init_complete(s
 		tz->state |= TZ_STATE_FLAG_SUSPENDED;
 
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	mutex_unlock(&thermal_list_lock);
 }
 
 /**
@@ -1370,7 +1381,6 @@ thermal_zone_device_register_with_trips(
 					unsigned int polling_delay)
 {
 	const struct thermal_trip *trip = trips;
-	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *tz;
 	struct thermal_trip_desc *td;
 	int id;
@@ -1496,18 +1506,8 @@ thermal_zone_device_register_with_trips(
 			goto unregister;
 	}
 
-	mutex_lock(&thermal_list_lock);
-
-	thermal_zone_add_to_list(tz);
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




