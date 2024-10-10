Return-Path: <linux-pm+bounces-15503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885C999515
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 00:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C7B1F25F33
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542351E7C0C;
	Thu, 10 Oct 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ZjwM/uD9"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F3148301;
	Thu, 10 Oct 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598958; cv=none; b=RiiZ/qSou7mxxKww36s+jAxI83u9K3Pn7ZeLTJ0DXHxQIIPsrO8InCYnH1S8QPqjGvEmSHEpX0HfuRr0XWg7xYkJ2KAFESq9cnF3xiWl7HoovRdP1prz1252WDZEGWIVwwnypoQ2pkFeHvYz6nAlgY60yfIwQL8SzB/alG9N9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598958; c=relaxed/simple;
	bh=FDHAI1QDQ4nSnmYAkIDb0LzljEngBGRbZw6cSI3zLtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQx87HkUnt+LB0Iw9YJfT5ZuEHNtLSe5YcawhiwvdDm/ifjXeJdvHB9EvDokNHm1NRIUL+r4B9jst47KLJX1VSuGjTcOotqxw9ESCug4N8yT7kOIF3tQxZIUu+50AXcJx4s6tpsik00Eby3uV4oG+D5CqxRKt01+j+f6vqyAcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ZjwM/uD9 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id f7b1f3f4d3445cd4; Fri, 11 Oct 2024 00:22:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0D18169EF02;
	Fri, 11 Oct 2024 00:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728598948;
	bh=FDHAI1QDQ4nSnmYAkIDb0LzljEngBGRbZw6cSI3zLtM=;
	h=From:Subject:Date;
	b=ZjwM/uD9cUTzbSs5L+yYW0DB2/ZFGC5BgcPDyPvqUQejU5rD9NHw3f5NEt29IcnYX
	 5Ew7SSOS6WGmXqcsUsOW7LgdRNzVoz+16YtgtGz52Rnog8fiKvIEDNgp4U8NXcrmdd
	 rU1YoO+NMyQuwGQqL4+mQU9YfonEJXFPog9mWBxzrFlhTOXjJHcWWZaP2wD7QdLRNx
	 xI/kpufpgYQyx0Ac328SstpBN9XWu3x8A7M+4DhzGadhVPgHCwkzzHJEEjJlVVKsuP
	 Ww8d9R9Iyqi8ClI4Zxi2coPCzAKh9On/wf+1tCRJlT3ej1yLOaAFDhgG/1qF6u/Ppb
	 HKFcNjAVPIygw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 04/11] thermal: core: Manage thermal_list_lock using a mutex guard
Date: Fri, 11 Oct 2024 00:10:47 +0200
Message-ID: <2010397.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
References: <4985597.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriih
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Switch over the thermal core to using a mutex guard for
thermal_list_lock management.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a resend of

https://lore.kernel.org/linux-pm/2018087.usQuhbGJ8B@rjwysocki.net/

---
 drivers/thermal/thermal_core.c |  148 ++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 80 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -140,7 +140,7 @@ int thermal_register_governor(struct the
 			def_governor = governor;
 	}
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
 		/*
@@ -163,7 +163,6 @@ int thermal_register_governor(struct the
 		}
 	}
 
-	mutex_unlock(&thermal_list_lock);
 	mutex_unlock(&thermal_governor_lock);
 
 	return err;
@@ -181,7 +180,9 @@ void thermal_unregister_governor(struct
 	if (!__find_governor(governor->name))
 		goto exit;
 
-	mutex_lock(&thermal_list_lock);
+	list_del(&governor->governor_list);
+
+	guard(mutex)(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
 		if (!strncasecmp(pos->governor->name, governor->name,
@@ -189,8 +190,6 @@ void thermal_unregister_governor(struct
 			thermal_set_governor(pos, NULL);
 	}
 
-	mutex_unlock(&thermal_list_lock);
-	list_del(&governor->governor_list);
 exit:
 	mutex_unlock(&thermal_governor_lock);
 }
@@ -686,51 +685,52 @@ int for_each_thermal_cooling_device(int
 					      void *), void *data)
 {
 	struct thermal_cooling_device *cdev;
-	int ret = 0;
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
+
 	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		int ret;
+
 		ret = cb(cdev, data);
 		if (ret)
-			break;
+			return ret;
 	}
-	mutex_unlock(&thermal_list_lock);
 
-	return ret;
+	return 0;
 }
 
 int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 			  void *data)
 {
 	struct thermal_zone_device *tz;
-	int ret = 0;
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
+
 	list_for_each_entry(tz, &thermal_tz_list, node) {
+		int ret;
+
 		ret = cb(tz, data);
 		if (ret)
-			break;
+			return ret;
 	}
-	mutex_unlock(&thermal_list_lock);
 
-	return ret;
+	return 0;
 }
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id)
 {
-	struct thermal_zone_device *tz, *match = NULL;
+	struct thermal_zone_device *tz;
+
+	guard(mutex)(&thermal_list_lock);
 
-	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(tz, &thermal_tz_list, node) {
 		if (tz->id == id) {
 			get_device(&tz->device);
-			match = tz;
-			break;
+			return tz;
 		}
 	}
-	mutex_unlock(&thermal_list_lock);
 
-	return match;
+	return NULL;
 }
 
 /*
@@ -969,14 +969,12 @@ static void thermal_cooling_device_init_
 {
 	struct thermal_zone_device *tz;
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
 	list_add(&cdev->node, &thermal_cdev_list);
 
 	list_for_each_entry(tz, &thermal_tz_list, node)
 		thermal_zone_cdev_bind(tz, cdev);
-
-	mutex_unlock(&thermal_list_lock);
 }
 
 /**
@@ -1210,10 +1208,10 @@ void thermal_cooling_device_update(struc
 	 * Hold thermal_list_lock throughout the update to prevent the device
 	 * from going away while being updated.
 	 */
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
 	if (!thermal_cooling_device_present(cdev))
-		goto unlock_list;
+		return;
 
 	/*
 	 * Update under the cdev lock to prevent the state from being set beyond
@@ -1255,9 +1253,6 @@ void thermal_cooling_device_update(struc
 
 unlock:
 	mutex_unlock(&cdev->lock);
-
-unlock_list:
-	mutex_unlock(&thermal_list_lock);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
@@ -1281,24 +1276,18 @@ static void thermal_zone_cdev_unbind(str
 static bool thermal_cooling_device_exit(struct thermal_cooling_device *cdev)
 {
 	struct thermal_zone_device *tz;
-	bool ret = true;
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
-	if (!thermal_cooling_device_present(cdev)) {
-		ret = false;
-		goto unlock;
-	}
+	if (!thermal_cooling_device_present(cdev))
+		return false;
 
 	list_del(&cdev->node);
 
 	list_for_each_entry(tz, &thermal_tz_list, node)
 		thermal_zone_cdev_unbind(tz, cdev);
 
-unlock:
-	mutex_unlock(&thermal_list_lock);
-
-	return ret;
+	return true;
 }
 
 /**
@@ -1345,7 +1334,7 @@ static void thermal_zone_init_complete(s
 {
 	struct thermal_cooling_device *cdev;
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
 	list_add_tail(&tz->node, &thermal_tz_list);
 
@@ -1365,8 +1354,6 @@ static void thermal_zone_init_complete(s
 		tz->state |= TZ_STATE_FLAG_SUSPENDED;
 
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
-	mutex_unlock(&thermal_list_lock);
 }
 
 /**
@@ -1587,14 +1574,11 @@ EXPORT_SYMBOL_GPL(thermal_zone_device);
 static bool thermal_zone_exit(struct thermal_zone_device *tz)
 {
 	struct thermal_cooling_device *cdev;
-	bool ret = true;
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
-	if (list_empty(&tz->node)) {
-		ret = false;
-		goto unlock;
-	}
+	if (list_empty(&tz->node))
+		return false;
 
 	guard(thermal_zone)(tz);
 
@@ -1605,10 +1589,7 @@ static bool thermal_zone_exit(struct the
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
 		__thermal_zone_cdev_unbind(tz, cdev);
 
-unlock:
-	mutex_unlock(&thermal_list_lock);
-
-	return ret;
+	return true;
 }
 
 /**
@@ -1660,24 +1641,23 @@ struct thermal_zone_device *thermal_zone
 	unsigned int found = 0;
 
 	if (!name)
-		goto exit;
+		return ERR_PTR(-EINVAL);
+
+	guard(mutex)(&thermal_list_lock);
 
-	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (!strncasecmp(name, pos->type, THERMAL_NAME_LENGTH)) {
 			found++;
 			ref = pos;
 		}
-	mutex_unlock(&thermal_list_lock);
 
-	/* nothing has been found, thus an error code for it */
-	if (found == 0)
-		ref = ERR_PTR(-ENODEV);
-	else if (found > 1)
-	/* Success only when an unique zone is found */
-		ref = ERR_PTR(-EEXIST);
+	if (!found)
+		return ERR_PTR(-ENODEV);
+
+	/* Success only when one zone is found. */
+	if (found > 1)
+		return ERR_PTR(-EEXIST);
 
-exit:
 	return ref;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
@@ -1718,6 +1698,18 @@ static void thermal_zone_pm_prepare(stru
 	tz->state |= TZ_STATE_FLAG_SUSPENDED;
 }
 
+static void thermal_pm_notify_prepare(void)
+{
+	struct thermal_zone_device *tz;
+
+	guard(mutex)(&thermal_list_lock);
+
+	thermal_pm_suspended = true;
+
+	list_for_each_entry(tz, &thermal_tz_list, node)
+		thermal_zone_pm_prepare(tz);
+}
+
 static void thermal_zone_pm_complete(struct thermal_zone_device *tz)
 {
 	guard(thermal_zone)(tz);
@@ -1736,35 +1728,31 @@ static void thermal_zone_pm_complete(str
 	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, 0);
 }
 
-static int thermal_pm_notify(struct notifier_block *nb,
-			     unsigned long mode, void *_unused)
+static void thermal_pm_notify_complete(void)
 {
 	struct thermal_zone_device *tz;
 
+	guard(mutex)(&thermal_list_lock);
+
+	thermal_pm_suspended = false;
+
+	list_for_each_entry(tz, &thermal_tz_list, node)
+		thermal_zone_pm_complete(tz);
+}
+
+static int thermal_pm_notify(struct notifier_block *nb,
+			     unsigned long mode, void *_unused)
+{
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_RESTORE_PREPARE:
 	case PM_SUSPEND_PREPARE:
-		mutex_lock(&thermal_list_lock);
-
-		thermal_pm_suspended = true;
-
-		list_for_each_entry(tz, &thermal_tz_list, node)
-			thermal_zone_pm_prepare(tz);
-
-		mutex_unlock(&thermal_list_lock);
+		thermal_pm_notify_prepare();
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
 	case PM_POST_SUSPEND:
-		mutex_lock(&thermal_list_lock);
-
-		thermal_pm_suspended = false;
-
-		list_for_each_entry(tz, &thermal_tz_list, node)
-			thermal_zone_pm_complete(tz);
-
-		mutex_unlock(&thermal_list_lock);
+		thermal_pm_notify_complete();
 		break;
 	default:
 		break;




