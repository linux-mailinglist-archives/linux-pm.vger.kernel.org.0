Return-Path: <linux-pm+bounces-14272-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19E3979042
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F92285613
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9C1CEE84;
	Sat, 14 Sep 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LmWW5tGq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCF7A15A;
	Sat, 14 Sep 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312029; cv=none; b=akeNquf/Y74iIv6X2SlbUg2B/KSZloivvz0FD8sDtQ3DwvGRLi20I/bc7M80QFuFmPu7rp9fNcX/1lf3Nn1gr7JGF6o+xq+NOwcrcK0Ro6HYUfoie8k3q1BCYsDyAVvAOg0Xdz2If2IJ1mF05h+xH29bZCGLA3ck+siX0XLcBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312029; c=relaxed/simple;
	bh=PtnD5ql8uhjYjbo53dvYode4Eg5InbMjg9FywYZMa/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcN8pOaVaFnXhM49s9r2PM3K2e9S+05zR/t4rcm0uYQRjXscRmalBpV4nPv1nbAHHcsTpfcbu5P8p/0qnqfWSikoE4MDkHUbe73k8P0h84XVGepf38E3pFhDMGWUSpArZxNXz4bMFe+yvlWZvXiFAP9BcC+RoF62Hc43al6hfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LmWW5tGq reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b54674465a1ca381; Sat, 14 Sep 2024 13:07:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9BC2C8532AE;
	Sat, 14 Sep 2024 13:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312025;
	bh=PtnD5ql8uhjYjbo53dvYode4Eg5InbMjg9FywYZMa/w=;
	h=From:Subject:Date;
	b=LmWW5tGqQH549cIqM5GW3fAW1fGKJJxFtdgx06dqnTJylZ0nZC/Azu3B9bS5CmWDT
	 VFXvrYOU7FbLGnVuCT1O8r65poztnbZjYURBESIQ2OeDO8RgiIQCAz+r5JTm+RySnN
	 q3ZJAZCPltq0PX5BLdAyq25oIgk8qCTZhru9Bpa9zyFcqTSUTqu6yzkeYaOYnphx9I
	 yuKm2xIqq57543cICNvj82mtTvDKHnP2PpcWTKHVAws7qfyfF3ubdpM7F8sRhyMGo9
	 Qh3oe50J5cM5LX7+EDKFB84oqj8WVD6PlP32C/cG3f7PCvz4WtqfZjyEUa4SBtxeVj
	 KUw+bmboIchlg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 08/20] thermal: core: Consolidate thermal zone locking
 in the exit path
Date: Sat, 14 Sep 2024 12:35:20 +0200
Message-ID: <7729094.EvYhyI6sBW@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=30 Fuz1=30 Fuz2=30

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with a previous change in the thermal zone initialization
path, to avoid acquiring the thermal zone lock and releasing it multiple
times back-to-back unnecessarily, move all of the code running under
thermal_list_lock in thermal_zone_device_unregister() into
thermal_zone_exit() and make the latter acquire the thermal zone lock
only once and release it along with thermal_list_lock.

For this purpose, provide an "unlocked" variant of
thermal_zone_cdev_unbind() to be called by thermal_zone_exit()
under the thermal zone lock.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   53 +++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1249,17 +1249,23 @@ unlock_list:
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
-static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
+static void __thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
 				     struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
 
-	guard(thermal_zone)(tz);
-
 	for_each_trip_desc(tz, td)
 		thermal_unbind_cdev_from_trip(tz, td, cdev);
 }
 
+static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
+				     struct thermal_cooling_device *cdev)
+{
+	guard(thermal_zone)(tz);
+
+	__thermal_zone_cdev_unbind(tz, cdev);
+}
+
 /**
  * thermal_cooling_device_unregister - removes a thermal cooling device
  * @cdev:	the thermal cooling device to remove.
@@ -1563,12 +1569,31 @@ struct device *thermal_zone_device(struc
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device);
 
-static void thermal_zone_exit(struct thermal_zone_device *tz)
+static bool thermal_zone_exit(struct thermal_zone_device *tz)
 {
+	struct thermal_cooling_device *cdev;
+	bool ret = true;
+
+	mutex_lock(&thermal_list_lock);
+
+	if (list_empty(&tz->node)) {
+		ret = false;
+		goto unlock;
+	}
+
 	guard(thermal_zone)(tz);
 
 	tz->state |= TZ_STATE_FLAG_EXIT;
 	list_del(&tz->node);
+
+	/* Unbind all cdevs associated with this thermal zone. */
+	list_for_each_entry(cdev, &thermal_cdev_list, node)
+		__thermal_zone_cdev_unbind(tz, cdev);
+
+unlock:
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
 }
 
 /**
@@ -1577,31 +1602,13 @@ static void thermal_zone_exit(struct the
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 {
-	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos = NULL;
-
 	if (!tz)
 		return;
 
 	thermal_debug_tz_remove(tz);
 
-	mutex_lock(&thermal_list_lock);
-	list_for_each_entry(pos, &thermal_tz_list, node)
-		if (pos == tz)
-			break;
-	if (pos != tz) {
-		/* thermal zone device not found */
-		mutex_unlock(&thermal_list_lock);
+	if (!thermal_zone_exit(tz))
 		return;
-	}
-
-	thermal_zone_exit(tz);
-
-	/* Unbind all cdevs associated with 'this' thermal zone */
-	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		thermal_zone_cdev_unbind(tz, cdev);
-
-	mutex_unlock(&thermal_list_lock);
 
 	cancel_delayed_work_sync(&tz->poll_queue);
 




