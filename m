Return-Path: <linux-pm+bounces-11565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6899693FC1A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0C22836C9
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315E16EC1E;
	Mon, 29 Jul 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="C2HCkAKc"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A315EFC8;
	Mon, 29 Jul 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273180; cv=none; b=Asf6ZlNyFJcEpTAtQp2tGTg8V8PJsXWm8HAJz09ixcm6NewrVnqt7HQbLea5a1CudOrF3/2w0k3gFLQgJlnaHkHa4PDLHSjc9cS2YTMt1kXonkPnq/e3Ol1PUlPj4UQl1DgRYlzI1EP/OBtvWfmca91BPEosnyiQqODa6OvEnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273180; c=relaxed/simple;
	bh=+J6fCUlFbCOWFS0I/4EbrDjyy1zjuKwPfOy9pdbQIig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Il3PglOujQ6Yk7aIaFWO8e1VTaf+G3TUTnPLCbYPhmAgIWyxhwoaNwdEo+X85zcCePpKVFmn7GJV/TexfP7cQ2+RuKpjDG4hjFlzg/tXlntTh3pb1ZVAktMmvT5oLB6wJqMFeFQCuzF6GHlFZmmV0O6uR9qbtD8QOQtxV5K0odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=C2HCkAKc; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a2ff056e6a2cd53f; Mon, 29 Jul 2024 18:12:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 27F7B77357F;
	Mon, 29 Jul 2024 18:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269576;
	bh=+J6fCUlFbCOWFS0I/4EbrDjyy1zjuKwPfOy9pdbQIig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2HCkAKcLC65oU9UKzIPq2v7omC5UL9trL7x7juksAo8rqNC3CiQkjFW0AgqCFlzS
	 /yHeDbldu+rhqUHY62DVRKlRZZQgpLxtbGSR7d3iN4acXK+buhB3QT5x8uhUBVwoiI
	 e51OyQru6+gXYdXO38Acjt35DvbkdyNQQ4EXKJh8nZRuUU+GRul97wdHZnSowKRyAP
	 RyqzM9+jhzILQvFfAcn6POemhjNG31ech8LgHozayngV9KX4W5atqICWOoEi6FnlK8
	 4BAYjfL8FhuHLzowRw4HaoZtFhz5/je6TjMEkAg41uzEWpck2pqsrnp3MktIb3QnQf
	 7Px3YAJoeSQDA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [RESEND][PATCH v1 6/8] thermal: helpers: Drop get_thermal_instance()
Date: Mon, 29 Jul 2024 18:06:55 +0200
Message-ID: <2014591.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <2211925.irdbgypaU6@rjwysocki.net>
References: <2211925.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no more users of get_thermal_instance(), so drop it.

While at it, replace get_instance() returning a pointer to struct
thermal_instance with thermal_instance_present() returning a bool
which is more straightforward.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.h    |    5 -----
 drivers/thermal/thermal_helpers.c |   30 ++++++------------------------
 2 files changed, 6 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -204,11 +204,6 @@ void __thermal_cdev_update(struct therma
 
 int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip);
 
-struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
-		     struct thermal_cooling_device *cdev,
-		     int trip);
-
 /*
  * This structure is used to describe the behavior of
  * a certain cooling device on a certain trip point
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -39,18 +39,18 @@ int get_tz_trend(struct thermal_zone_dev
 	return trend;
 }
 
-static struct thermal_instance *get_instance(struct thermal_zone_device *tz,
-					     struct thermal_cooling_device *cdev,
-					     const struct thermal_trip *trip)
+static bool thermal_instance_present(struct thermal_zone_device *tz,
+				     struct thermal_cooling_device *cdev,
+				     const struct thermal_trip *trip)
 {
 	struct thermal_instance *ti;
 
 	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
 		if (ti->trip == trip && ti->cdev == cdev)
-			return ti;
+			return true;
 	}
 
-	return NULL;
+	return false;
 }
 
 bool thermal_trip_is_bound_to_cdev(struct thermal_zone_device *tz,
@@ -62,7 +62,7 @@ bool thermal_trip_is_bound_to_cdev(struc
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
-	ret = !!get_instance(tz, cdev, trip);
+	ret = thermal_instance_present(tz, cdev, trip);
 
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
@@ -71,24 +71,6 @@ bool thermal_trip_is_bound_to_cdev(struc
 }
 EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
 
-struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
-		     struct thermal_cooling_device *cdev, int trip_index)
-{
-	struct thermal_instance *ti;
-
-	mutex_lock(&tz->lock);
-	mutex_lock(&cdev->lock);
-
-	ti = get_instance(tz, cdev, &tz->trips[trip_index].trip);
-
-	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
-
-	return ti;
-}
-EXPORT_SYMBOL(get_thermal_instance);
-
 /**
  * __thermal_zone_get_temp() - returns the temperature of a thermal zone
  * @tz: a valid pointer to a struct thermal_zone_device




