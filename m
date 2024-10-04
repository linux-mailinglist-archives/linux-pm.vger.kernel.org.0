Return-Path: <linux-pm+bounces-15165-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D31990FEB
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438B21C22BBF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8841E2601;
	Fri,  4 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kp9zIl8H"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EC1E04B3;
	Fri,  4 Oct 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070994; cv=none; b=ujBX1CyXfI401YSCst+47hlQF3mUH3RUB58cge1tnwagJfmI5VApyfxHH9EfcG7yNogjesdvIGHxcVPu8WQsYYnWYNDvm1RTHtbV1lrD/9ptJuudCzExiQYotxbFKoxen96HrV2elGAOg4UbTYwi7ka4cxLMJ0EtQEv/b4V9YVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070994; c=relaxed/simple;
	bh=tn6TL0+ouOy1fUAc1oQFrAEeWQWWw6pLIkTVfe05XbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+9p6kZplxXjAj9HaaeRSe7UKItJLSIMtd3XwlIZ9CGUInylg3dTdBIUV2svzYybAA7QDYFlkEliXzXt7zcWU63QP3w+qJzX/4w/Rf44o8Jh8x6tAAn/nLzu857KwPuoqlSkRdPC6+un+l94evuIwCxzNNrr8j7mUjmOF48WfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kp9zIl8H reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9ec35dee432a5ec7; Fri, 4 Oct 2024 21:43:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3403B6A9505;
	Fri,  4 Oct 2024 21:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070984;
	bh=tn6TL0+ouOy1fUAc1oQFrAEeWQWWw6pLIkTVfe05XbI=;
	h=From:Subject:Date;
	b=kp9zIl8HjThuugrCTKUyk3qsM2QazvseZ4f+Kqxszmb/+QFUNOwFX0j2cUEBtLG1r
	 77mnwJWERzaYLAXy/qbeUqbRLdZIYVzKHHAhr6GQVKXRZ3yGfGVfYvr2jkoCGY7252
	 s+6/LFPCiW1VloeJ5bU0DA3HpcY6tFcyg1lvrHuvSi3B8Te34t35iI+DRfcAJ+EFTa
	 rPSJ0Il4BTuEoHni6yonOdoSOajmYyuxexosjYrXjsAzfNBNUQjamri+N3Fmaksjuj
	 NkMxkbAzBbPJRqPwuJk+cnuYVn9mOTaoiE7POlmVka8JZEmYVl+XE6uPhjlouo06ku
	 OMv16VLOf9hsw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 08/12] thermal: core: Consolidate thermal zone locking in the exit
 path
Date: Fri, 04 Oct 2024 21:30:26 +0200
Message-ID: <1963152.taCxCBeP46@rjwysocki.net>
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

In analogy with a previous change in the thermal zone initialization
path, to avoid acquiring the thermal zone lock and releasing it multiple
times back and forth unnecessarily, move all of the code running under
thermal_list_lock in thermal_zone_device_unregister() into a new
function called thermal_zone_exit() and make the latter acquire the
thermal zone lock only once and release it along with thermal_list_lock.

For this purpose, provide an "unlocked" variant of
thermal_zone_cdev_unbind() to be called by thermal_zone_exit() under the
thermal zone lock.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/7729094.EvYhyI6sBW@rjwysocki.net/

v1 -> v2: Rebase, use list_del_init() for removing thermal zones from the
          global list so that the new list_emty() check doesn't blow up.

---
 drivers/thermal/thermal_core.c |   66 ++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1266,15 +1266,21 @@ unlock_list:
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
-static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
-				     struct thermal_cooling_device *cdev)
+static void __thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
+				       struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
 
-	mutex_lock(&tz->lock);
-
 	for_each_trip_desc(tz, td)
 		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
+}
+
+static void thermal_zone_cdev_unbind(struct thermal_zone_device *tz,
+				     struct thermal_cooling_device *cdev)
+{
+	mutex_lock(&tz->lock);
+
+	__thermal_zone_cdev_unbind(tz, cdev);
 
 	mutex_unlock(&tz->lock);
 }
@@ -1588,43 +1594,49 @@ struct device *thermal_zone_device(struc
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device);
 
-/**
- * thermal_zone_device_unregister - removes the registered thermal zone device
- * @tz: the thermal zone device to remove
- */
-void thermal_zone_device_unregister(struct thermal_zone_device *tz)
+static bool thermal_zone_exit(struct thermal_zone_device *tz)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos = NULL;
-
-	if (!tz)
-		return;
-
-	thermal_debug_tz_remove(tz);
+	bool ret = true;
 
 	mutex_lock(&thermal_list_lock);
-	list_for_each_entry(pos, &thermal_tz_list, node)
-		if (pos == tz)
-			break;
-	if (pos != tz) {
-		/* thermal zone device not found */
-		mutex_unlock(&thermal_list_lock);
-		return;
+
+	if (list_empty(&tz->node)) {
+		ret = false;
+		goto unlock;
 	}
 
 	mutex_lock(&tz->lock);
 
 	tz->state |= TZ_STATE_FLAG_EXIT;
-	list_del(&tz->node);
-
-	mutex_unlock(&tz->lock);
+	list_del_init(&tz->node);
 
-	/* Unbind all cdevs associated with 'this' thermal zone */
+	/* Unbind all cdevs associated with this thermal zone. */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		thermal_zone_cdev_unbind(tz, cdev);
+		__thermal_zone_cdev_unbind(tz, cdev);
+
+	mutex_unlock(&tz->lock);
 
+unlock:
 	mutex_unlock(&thermal_list_lock);
 
+	return ret;
+}
+
+/**
+ * thermal_zone_device_unregister - removes the registered thermal zone device
+ * @tz: the thermal zone device to remove
+ */
+void thermal_zone_device_unregister(struct thermal_zone_device *tz)
+{
+	if (!tz)
+		return;
+
+	thermal_debug_tz_remove(tz);
+
+	if (!thermal_zone_exit(tz))
+		return;
+
 	cancel_delayed_work_sync(&tz->poll_queue);
 
 	thermal_set_governor(tz, NULL);




