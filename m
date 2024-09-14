Return-Path: <linux-pm+bounces-14268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5624979037
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93A2B24E26
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A36142E67;
	Sat, 14 Sep 2024 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BiECBGhB"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AD4437;
	Sat, 14 Sep 2024 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311658; cv=none; b=Z89whAgohR1tcePCOMY5cGnNJoNhlgpJDr+C1wh7HC00ExbKcIC6a48akrcWgDrByr/2rHiLNSBPZiwEBPKteVVRv/5BgzCzNAYrLs0mdkTtqad+wuakSm3gbg8jaGvMKVX3bMcljDwK3piVlJ9xOU9F6l9qaCXTnDZ2l7JiyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311658; c=relaxed/simple;
	bh=XeD2NBiKcuqDlEBnEZORpoqYZ56zZ80ch5l4K/gWUtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrxwqMLQfbCecVCqUE2k3xuZwfeT8ok8wRTfvxswAeTURUFIIqEwnc7khPYQzEaR7sQ56RwUo776Sg6AKg9F2H/8NFfLN9qUei+OkljMi7dTmgwhV+TebGlJQMUskDPi6E4eBGM6svjS8eUPQ3qGs38DK8IzyX5U+4Zx6eYH/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BiECBGhB reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 93a2222a13fa375e; Sat, 14 Sep 2024 13:00:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 63BCD8532AE;
	Sat, 14 Sep 2024 13:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726311653;
	bh=XeD2NBiKcuqDlEBnEZORpoqYZ56zZ80ch5l4K/gWUtw=;
	h=From:Subject:Date;
	b=BiECBGhBwS6qv1/kYD8aVjV/6TGmDZsEpjoAJJjdtKdjJAK8d6t+hpSXNaf5W9WUS
	 CxhcEJS84ehP1bfR/abne0+vFMLLe/jxwbJtL4S4kLZDtnpgh5N735F9Xa7jo9YYoH
	 9izkmKIkZ4m67ILdkB1r9IZmhJq/x1OfP1R3YwQhQRBgvvIs3wRWJx9nf3j+MxuWup
	 PmrdUXex/WKKNfFf1hS3/7DXctOwva7CFTSLb1oTSe7ipDoPqbrCS7g2PsO9OH5tnD
	 inElyMXOoLmY8taoDfzSbILrKbakXFWCmRknepHWs13K/gZjQMeGzFdSCzeZr1OAcz
	 CQNSp6Mh+Q//g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 12/20] thermal: core: Manage thermal_list_lock using a
 mutex guard
Date: Sat, 14 Sep 2024 12:40:00 +0200
Message-ID: <2018087.usQuhbGJ8B@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=20 Fuz1=20 Fuz2=20

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Switch over the thermal core to using a mutex guard for
thermal_list_lock management.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |  151 ++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 82 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -139,7 +139,7 @@ int thermal_register_governor(struct the
 			def_governor = governor;
 	}
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
 		/*
@@ -162,7 +162,6 @@ int thermal_register_governor(struct the
 		}
 	}
 
-	mutex_unlock(&thermal_list_lock);
 	mutex_unlock(&thermal_governor_lock);
 
 	return err;
@@ -180,7 +179,9 @@ void thermal_unregister_governor(struct
 	if (!__find_governor(governor->name))
 		goto exit;
 
-	mutex_lock(&thermal_list_lock);
+	list_del(&governor->governor_list);
+
+	guard(mutex)(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
 		if (!strncasecmp(pos->governor->name, governor->name,
@@ -188,8 +189,6 @@ void thermal_unregister_governor(struct
 			thermal_set_governor(pos, NULL);
 	}
 
-	mutex_unlock(&thermal_list_lock);
-	list_del(&governor->governor_list);
 exit:
 	mutex_unlock(&thermal_governor_lock);
 }
@@ -681,50 +680,50 @@ int for_each_thermal_cooling_device(int
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
-		if (tz->id == id) {
-			match = tz;
-			break;
-		}
+		if (tz->id == id)
+			return tz;
 	}
-	mutex_unlock(&thermal_list_lock);
 
-	return match;
+	return NULL;
 }
 
 /*
@@ -963,14 +962,12 @@ static void thermal_cooling_device_init_
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
@@ -1204,10 +1201,10 @@ void thermal_cooling_device_update(struc
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
@@ -1249,9 +1246,6 @@ void thermal_cooling_device_update(struc
 
 unlock:
 	mutex_unlock(&cdev->lock);
-
-unlock_list:
-	mutex_unlock(&thermal_list_lock);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
@@ -1275,24 +1269,18 @@ static void thermal_zone_cdev_unbind(str
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
@@ -1339,7 +1327,7 @@ static void thermal_zone_init_complete(s
 {
 	struct thermal_cooling_device *cdev;
 
-	mutex_lock(&thermal_list_lock);
+	guard(mutex)(&thermal_list_lock);
 
 	list_add_tail(&tz->node, &thermal_tz_list);
 
@@ -1359,8 +1347,6 @@ static void thermal_zone_init_complete(s
 		tz->state |= TZ_STATE_FLAG_SUSPENDED;
 
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
-	mutex_unlock(&thermal_list_lock);
 }
 
 /**
@@ -1579,14 +1565,11 @@ EXPORT_SYMBOL_GPL(thermal_zone_device);
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
 
@@ -1597,10 +1580,7 @@ static bool thermal_zone_exit(struct the
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
 		__thermal_zone_cdev_unbind(tz, cdev);
 
-unlock:
-	mutex_unlock(&thermal_list_lock);
-
-	return ret;
+	return true;
 }
 
 /**
@@ -1654,24 +1634,23 @@ struct thermal_zone_device *thermal_zone
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
@@ -1714,6 +1693,18 @@ static void thermal_zone_pm_prepare(stru
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
@@ -1732,35 +1723,31 @@ static void thermal_zone_pm_complete(str
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




