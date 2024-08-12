Return-Path: <linux-pm+bounces-12086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E194EF07
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2B61C20AC0
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4C17C7C3;
	Mon, 12 Aug 2024 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ffW/lgyo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47C14D6FE;
	Mon, 12 Aug 2024 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471180; cv=none; b=HVsHBTcQYqfLhmnzT+Z8hAHMihErqchsrBwz6icIQBWG8N7UMKn4oBW+gklVrPeeoMRbIS06CIpatYSMD9iOrqDMdX4DfnZyXVvNp2axX5OKTk43AFzOSHyBoqRO2tPrmqIWgm99Eg4wvPfm+ZuSEjSA16KPcK4J/RUXWqpbAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471180; c=relaxed/simple;
	bh=6dazxTdqRDaxnMfnFIe3JJwYOYmHRGWXxVy/AN2n6nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIaUhvdW695OfqDcrteF532X9AGEuu7hgYgZUbEYx6iUeXX6gfxXPJZWYb4cxWCcvNUYRO13nH57nq6Uw9ic3d259ZN1bOiukLxZ6bwWLmEnxM4GJu5M7Rs5jul7tnA10cmwRK+e3m3xvoS0EkBL5FYt1rIuL+m2fjovIAr5BDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ffW/lgyo reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 80e2f7d5647efa98; Mon, 12 Aug 2024 15:59:36 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 163316F0D63;
	Mon, 12 Aug 2024 15:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723471176;
	bh=6dazxTdqRDaxnMfnFIe3JJwYOYmHRGWXxVy/AN2n6nA=;
	h=From:Subject:Date;
	b=ffW/lgyoVNzEbYAKIq4AKaQBwtdiGtSO+GMruZ3/xiMj+fo1jQowgvNyL+OLDJSUD
	 Y5jACSx9oUlTbzCyXD5kQnE/ESPUaTJregWPrNspX54SxdeUwXy3I5wIT26YZkKUbU
	 YR/2+zxxI4ErqAEd3BD8JueDyp+br5KQs87ZGYC1PUtV7iEaG4zHO254yBaluhtJbL
	 zZrrXpS50ITCDWK1B30Pd77Hkbf4Z4f3XxdC4iQMUDJvfNwWxf5qzDf0zLl+mXHVHh
	 B89gDYj6bK3lGxlXTjJro1PpK94AoZevUlxLumO2q6BWoF96Y557Yta8n6tD6Sq574
	 /M2973tPU0TaA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 04/17] thermal: core: Clean up cdev binding/unbinding functions
Date: Mon, 12 Aug 2024 15:56:23 +0200
Message-ID: <2819322.BEx9A2HvPv@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new label to thermal_bind_cdev_to_trip() and use it to eliminate
two redundant !result check from that function, rename a label in
thermal_unbind_cdev_from_trip() to reflect its actual purpose and
adjust some white space in these functions.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes.

---
 drivers/thermal/thermal_core.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -806,6 +806,7 @@ int thermal_bind_cdev_to_trip(struct the
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
+
 	dev->tz = tz;
 	dev->cdev = cdev;
 	dev->trip = trip;
@@ -821,8 +822,7 @@ int thermal_bind_cdev_to_trip(struct the
 
 	dev->id = result;
 	sprintf(dev->name, "cdev%d", dev->id);
-	result =
-	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
+	result = sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
 	if (result)
 		goto release_ida;
 
@@ -849,24 +849,26 @@ int thermal_bind_cdev_to_trip(struct the
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
+
+	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
 		if (pos->trip == trip && pos->cdev == cdev) {
 			result = -EEXIST;
-			break;
+			goto remove_weight_file;
 		}
-	if (!result) {
-		list_add_tail(&dev->tz_node, &tz->thermal_instances);
-		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
-		atomic_set(&tz->need_update, 1);
-
-		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 	}
+
+	list_add_tail(&dev->tz_node, &tz->thermal_instances);
+	list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
+	atomic_set(&tz->need_update, 1);
+
+	thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
+
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
 
-	if (!result)
-		return 0;
+	return 0;
 
+remove_weight_file:
 	device_remove_file(&tz->device, &dev->weight_attr);
 remove_trip_file:
 	device_remove_file(&tz->device, &dev->attr);
@@ -914,6 +916,7 @@ int thermal_unbind_cdev_from_trip(struct
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
+
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
 		if (pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
@@ -923,15 +926,16 @@ int thermal_unbind_cdev_from_trip(struct
 
 			mutex_unlock(&cdev->lock);
 			mutex_unlock(&tz->lock);
-			goto unbind;
+			goto free;
 		}
 	}
+
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
 
 	return -ENODEV;
 
-unbind:
+free:
 	device_remove_file(&tz->device, &pos->weight_attr);
 	device_remove_file(&tz->device, &pos->attr);
 	sysfs_remove_link(&tz->device.kobj, pos->name);




