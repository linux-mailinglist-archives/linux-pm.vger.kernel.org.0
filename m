Return-Path: <linux-pm+bounces-15621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E62199D02B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 17:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302C91F23CB9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8ED19F43B;
	Mon, 14 Oct 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UuNZ9T0n"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831D81749;
	Mon, 14 Oct 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917996; cv=none; b=QQqa9JLY9g8y02xh8V58zDSrzmLmEdrR0cDPfOjIuwiE4Zz548ZiWtTfElfbA0/P3hnmDQkmXPO8BYjcYNffPBqIxommuoVcurji3pfAsGgITJLs5EeS5AvwkzXhpigOMKwXjGs8dCJVrGKIIqRgleX9SX6Mmrib3zyOY5qfnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917996; c=relaxed/simple;
	bh=xRNW2O9ugcX7+hnZU3hZJwTYurj5BshIHmpk33yGMTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3WV5SKqcDlzYuFVbFbtC5NzhpxxigZ+f2eKMt5V+e5rlIn9A2JhH3hO+k4I/P0CCu/8Mq6SfXdQLQSmoxywmfwZixDXf43w43QbUu+BhmVO86D9RGvSKi+yeyzT0Xg/q7c0cH9ViFvBzk6rrE56tkjOOYL5XiZKbz2/XB3H6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UuNZ9T0n; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 323abf5bb3fc7085; Mon, 14 Oct 2024 16:59:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 55AFA69EF45;
	Mon, 14 Oct 2024 16:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728917986;
	bh=xRNW2O9ugcX7+hnZU3hZJwTYurj5BshIHmpk33yGMTM=;
	h=From:Subject:Date;
	b=UuNZ9T0nYh9v+Z4y/WKMN0jL3aOdrYnMQ7OdA8iHsutw2OWyIJfnrHGQ4f60AQ9f1
	 tFCar4vQiE+7O+RKWF/8mNuuY60reyWoVo8kmDLFM7W28e/wrXiu2AwDY7oEQIGfJO
	 KHEqYmhlG7WJ8VH8dSWJE53GavJBZ5g9dBDePr+jZ9Cu5Pka+C72au49NJOJNPQfkF
	 hT+F6KuwAvb74+uIVmiqzt72r7XfGUVqay+xxXB1gRw4Uz5NrX0ZPmvRQX6SUIe52s
	 XiMZFpL8FFhvVpF3NSl4KMPGqdZ4rAwGjyr+Osofmq2aKlQRZDqrOArFhWUYhRyEam
	 btZQESuq6nW/g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2.1 09/11] thermal: core: Add and use cooling device guard
Date: Mon, 14 Oct 2024 16:59:46 +0200
Message-ID: <5837621.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add and use a special guard for cooling devices.

This allows quite a few error code paths to be simplified among
other things and brings in code size reduction for a good measure.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/1890654.atdPhlSkOF@rjwysocki.net/

v2 -> v2.1: Add missing hunk in trans_table_show()

v1 -> v2: Rearrange cur_state_store()

---
 drivers/thermal/gov_power_allocator.c |   21 ++++++--------
 drivers/thermal/gov_step_wise.c       |    6 ++--
 drivers/thermal/thermal_core.c        |   17 +++--------
 drivers/thermal/thermal_debugfs.c     |   25 ++++++++++------
 drivers/thermal/thermal_helpers.c     |   19 +++---------
 drivers/thermal/thermal_sysfs.c       |   51 ++++++++++++----------------------
 include/linux/thermal.h               |    3 ++
 7 files changed, 59 insertions(+), 83 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -758,12 +758,10 @@ static int thermal_instance_add(struct t
 
 	list_add_tail(&new_instance->trip_node, &td->thermal_instances);
 
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	list_add_tail(&new_instance->cdev_node, &cdev->thermal_instances);
 
-	mutex_unlock(&cdev->lock);
-
 	return 0;
 }
 
@@ -872,11 +870,9 @@ static void thermal_instance_delete(stru
 {
 	list_del(&instance->trip_node);
 
-	mutex_lock(&instance->cdev->lock);
+	guard(cooling_dev)(instance->cdev);
 
 	list_del(&instance->cdev_node);
-
-	mutex_unlock(&instance->cdev->lock);
 }
 
 /**
@@ -1239,10 +1235,10 @@ void thermal_cooling_device_update(struc
 	 * Update under the cdev lock to prevent the state from being set beyond
 	 * the new limit concurrently.
 	 */
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	if (cdev->ops->get_max_state(cdev, &cdev->max_state))
-		goto unlock;
+		return;
 
 	thermal_cooling_device_stats_reinit(cdev);
 
@@ -1269,12 +1265,9 @@ void thermal_cooling_device_update(struc
 	}
 
 	if (cdev->ops->get_cur_state(cdev, &state) || state > cdev->max_state)
-		goto unlock;
+		return;
 
 	thermal_cooling_device_stats_update(cdev, state);
-
-unlock:
-	mutex_unlock(&cdev->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -140,6 +140,9 @@ struct thermal_cooling_device {
 #endif
 };
 
+DEFINE_GUARD(cooling_dev, struct thermal_cooling_device *, mutex_lock(&_T->lock),
+	     mutex_unlock(&_T->lock))
+
 /* Structure to define Thermal Zone parameters */
 struct thermal_zone_params {
 	const char *governor_name;
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -544,14 +544,15 @@ cur_state_store(struct device *dev, stru
 	if (state > cdev->max_state)
 		return -EINVAL;
 
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	result = cdev->ops->set_cur_state(cdev, state);
-	if (!result)
-		thermal_cooling_device_stats_update(cdev, state);
+	if (result)
+		return result;
 
-	mutex_unlock(&cdev->lock);
-	return result ? result : count;
+	thermal_cooling_device_stats_update(cdev, state);
+
+	return count;
 }
 
 static struct device_attribute
@@ -625,21 +626,18 @@ static ssize_t total_trans_show(struct d
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 	struct cooling_dev_stats *stats;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	stats = cdev->stats;
 	if (!stats)
-		goto unlock;
+		return 0;
 
 	spin_lock(&stats->lock);
 	ret = sprintf(buf, "%u\n", stats->total_trans);
 	spin_unlock(&stats->lock);
 
-unlock:
-	mutex_unlock(&cdev->lock);
-
 	return ret;
 }
 
@@ -652,11 +650,11 @@ time_in_state_ms_show(struct device *dev
 	ssize_t len = 0;
 	int i;
 
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	stats = cdev->stats;
 	if (!stats)
-		goto unlock;
+		return 0;
 
 	spin_lock(&stats->lock);
 
@@ -668,9 +666,6 @@ time_in_state_ms_show(struct device *dev
 	}
 	spin_unlock(&stats->lock);
 
-unlock:
-	mutex_unlock(&cdev->lock);
-
 	return len;
 }
 
@@ -682,11 +677,11 @@ reset_store(struct device *dev, struct d
 	struct cooling_dev_stats *stats;
 	int i, states;
 
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	stats = cdev->stats;
 	if (!stats)
-		goto unlock;
+		return count;
 
 	states = cdev->max_state + 1;
 
@@ -702,9 +697,6 @@ reset_store(struct device *dev, struct d
 
 	spin_unlock(&stats->lock);
 
-unlock:
-	mutex_unlock(&cdev->lock);
-
 	return count;
 }
 
@@ -716,13 +708,11 @@ static ssize_t trans_table_show(struct d
 	ssize_t len = 0;
 	int i, j;
 
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	stats = cdev->stats;
-	if (!stats) {
-		len = -ENODATA;
-		goto unlock;
-	}
+	if (!stats)
+		return -ENODATA;
 
 	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
@@ -731,10 +721,8 @@ static ssize_t trans_table_show(struct d
 			break;
 		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
 	}
-	if (len >= PAGE_SIZE) {
-		len = PAGE_SIZE;
-		goto unlock;
-	}
+	if (len >= PAGE_SIZE)
+		return PAGE_SIZE;
 
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
@@ -760,9 +748,6 @@ static ssize_t trans_table_show(struct d
 		len = -EFBIG;
 	}
 
-unlock:
-	mutex_unlock(&cdev->lock);
-
 	return len;
 }
 
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -58,17 +58,10 @@ bool thermal_trip_is_bound_to_cdev(struc
 				   const struct thermal_trip *trip,
 				   struct thermal_cooling_device *cdev)
 {
-	bool ret;
-
 	guard(thermal_zone)(tz);
+	guard(cooling_dev)(cdev);
 
-	mutex_lock(&cdev->lock);
-
-	ret = thermal_instance_present(tz, cdev, trip);
-
-	mutex_unlock(&cdev->lock);
-
-	return ret;
+	return thermal_instance_present(tz, cdev, trip);
 }
 EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
 
@@ -197,12 +190,12 @@ void __thermal_cdev_update(struct therma
  */
 void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
+
 	if (!cdev->updated) {
 		__thermal_cdev_update(cdev);
 		cdev->updated = true;
 	}
-	mutex_unlock(&cdev->lock);
 }
 
 /**
@@ -211,11 +204,9 @@ void thermal_cdev_update(struct thermal_
  */
 void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev)
 {
-	mutex_lock(&cdev->lock);
+	guard(cooling_dev)(cdev);
 
 	__thermal_cdev_update(cdev);
-
-	mutex_unlock(&cdev->lock);
 }
 
 /**
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -516,6 +516,19 @@ void thermal_debug_cdev_add(struct therm
 	cdev->debugfs = thermal_dbg;
 }
 
+static struct thermal_debugfs *thermal_debug_cdev_clear(struct thermal_cooling_device *cdev)
+{
+	struct thermal_debugfs *thermal_dbg;
+
+	guard(cooling_dev)(cdev);
+
+	thermal_dbg = cdev->debugfs;
+	if (thermal_dbg)
+		cdev->debugfs = NULL;
+
+	return thermal_dbg;
+}
+
 /**
  * thermal_debug_cdev_remove - Remove a cooling device debugfs entry
  *
@@ -527,17 +540,9 @@ void thermal_debug_cdev_remove(struct th
 {
 	struct thermal_debugfs *thermal_dbg;
 
-	mutex_lock(&cdev->lock);
-
-	thermal_dbg = cdev->debugfs;
-	if (!thermal_dbg) {
-		mutex_unlock(&cdev->lock);
+	thermal_dbg = thermal_debug_cdev_clear(cdev);
+	if (!thermal_dbg)
 		return;
-	}
-
-	cdev->debugfs = NULL;
-
-	mutex_unlock(&cdev->lock);
 
 	mutex_lock(&thermal_dbg->lock);
 
Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -549,18 +549,17 @@ static void allow_maximum_power(struct t
 		cdev = instance->cdev;
 
 		instance->target = 0;
-		mutex_lock(&cdev->lock);
-		/*
-		 * Call for updating the cooling devices local stats and avoid
-		 * periods of dozen of seconds when those have not been
-		 * maintained.
-		 */
-		cdev->ops->get_requested_power(cdev, &req_power);
+		scoped_guard(cooling_dev, cdev) {
+			/*
+			 * Call for updating the cooling devices local stats and
+			 * avoid periods of dozen of seconds when those have not
+			 * been maintained.
+			 */
+			cdev->ops->get_requested_power(cdev, &req_power);
 
-		if (params->update_cdevs)
-			__thermal_cdev_update(cdev);
-
-		mutex_unlock(&cdev->lock);
+			if (params->update_cdevs)
+				__thermal_cdev_update(cdev);
+		}
 	}
 }
 
Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -97,9 +97,9 @@ static void thermal_zone_trip_update(str
 
 		instance->initialized = true;
 
-		mutex_lock(&instance->cdev->lock);
-		instance->cdev->updated = false; /* cdev needs update */
-		mutex_unlock(&instance->cdev->lock);
+		scoped_guard(cooling_dev, instance->cdev) {
+			instance->cdev->updated = false; /* cdev needs update */
+		}
 	}
 }
 




