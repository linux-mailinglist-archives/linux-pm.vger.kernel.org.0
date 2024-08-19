Return-Path: <linux-pm+bounces-12455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E2956FEE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480721F261A9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7117622D;
	Mon, 19 Aug 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ilfn3GCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45C16CD25;
	Mon, 19 Aug 2024 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083982; cv=none; b=QogSiBYw4p6AdNyHptNy3IW+geMnObs4RXuWpgXzxX+tOZrX6yNKpJRC9cp8Jop2+f97Nf6oU4HjT4BvICvg+K1wNihlPqXc6r1EvX/GDX6ys4ji3rsxFEVp7zsL6mgUdccYOy/7p1I7Da8pMow2ZdUqwhl6LVQXjf6dsgGbAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083982; c=relaxed/simple;
	bh=Y7bWsV025NYXD3jk9dYoYZH4kcEom9wOJTmyjIRXAgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAlylcXLeTLcL0naIE/EXEEXMKgK1SZP4rTJ4YVQCDodRGzDWsYQ0IxUBr6AaJeJa7R6QiwulnzvGw1+xxxYKzZrLTVufFEjFfdjD4s/yuA68sAcZvxsEBg98gmmkjQe2YA3Vm4n/JwnAIQbmkRP5hYigyqN9TIUXNnf3s5twZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ilfn3GCR reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3c329492ee2d50a5; Mon, 19 Aug 2024 18:12:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9A9AD73B5D4;
	Mon, 19 Aug 2024 18:12:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724083972;
	bh=Y7bWsV025NYXD3jk9dYoYZH4kcEom9wOJTmyjIRXAgA=;
	h=From:Subject:Date;
	b=Ilfn3GCRuxgFHNuROMhsissha3vztRdLuJFfGWDGmbkoySya4EypecFL2kLEn/kIx
	 slCAEI2/51UOaBbwl9KVlHIU4yrIuBhvcCltL5ugGv6oIaXkDcH92XYNiDJGka0AGB
	 8Pc8UADnSHn9PNk2ve+s/hSUCPrH6Prgp5+a1QTKOU6PtQ0pUNwSjk2gFm+q6DddHE
	 6M7EHOhfiyuc9bEGzTHE+8Ha17ITacvR867wRLijrQ0i7Ow+kht7CSwRRG97JU+ZLE
	 ijvqOJa1ubKcISF97Pp59XvuJnAtECXreHO8Ijf+omWDGCVFFJ1jYPLX6yMN+/gJ1s
	 r+LBeF3MH8X0Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 05/14] thermal: core: Move thermal zone locking out of bind/unbind
 functions
Date: Mon, 19 Aug 2024 17:58:27 +0200
Message-ID: <3837835.kQq0lBPeGt@rjwysocki.net>
In-Reply-To: <2205737.irdbgypaU6@rjwysocki.net>
References: <2205737.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
acquire the thermal zone lock, the locking rules for their callers get
complicated.  In particular, the thermal zone lock cannot be acquired
in any code path leading to one of these functions even though it might
be useful to do so.

To address this, remove the thermal zone locking from both these
functions, add lockdep assertions for the thermal zone lock to both
of them and make their callers acquire the thermal zone lock instead.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Rebase after dropping patches [04-05/17] from the series

v1 -> v2: No changes

---
 drivers/acpi/thermal.c         |    2 +-
 drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -785,6 +785,7 @@ int thermal_bind_cdev_to_trip(struct the
 	int result;
 
 	lockdep_assert_held(&thermal_list_lock);
+	lockdep_assert_held(&tz->lock);
 
 	if (list_empty(&tz->node) || list_empty(&cdev->node))
 		return -EINVAL;
@@ -847,7 +848,6 @@ int thermal_bind_cdev_to_trip(struct the
 	if (result)
 		goto remove_trip_file;
 
-	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
 		if (pos->trip == trip && pos->cdev == cdev) {
@@ -862,7 +862,6 @@ int thermal_bind_cdev_to_trip(struct the
 		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 	}
 	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
 
 	if (!result)
 		return 0;
@@ -886,11 +885,19 @@ int thermal_zone_bind_cooling_device(str
 				     unsigned long upper, unsigned long lower,
 				     unsigned int weight)
 {
+	int ret;
+
 	if (trip_index < 0 || trip_index >= tz->num_trips)
 		return -EINVAL;
 
-	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
-					 upper, lower, weight);
+	mutex_lock(&tz->lock);
+
+	ret = thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
+					upper, lower, weight);
+
+	mutex_unlock(&tz->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
 
@@ -912,7 +919,8 @@ int thermal_unbind_cdev_from_trip(struct
 {
 	struct thermal_instance *pos, *next;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
+
 	mutex_lock(&cdev->lock);
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
 		if (pos->trip == trip && pos->cdev == cdev) {
@@ -922,12 +930,10 @@ int thermal_unbind_cdev_from_trip(struct
 			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
 
 			mutex_unlock(&cdev->lock);
-			mutex_unlock(&tz->lock);
 			goto unbind;
 		}
 	}
 	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
 
 	return -ENODEV;
 
@@ -945,10 +951,18 @@ int thermal_zone_unbind_cooling_device(s
 				       int trip_index,
 				       struct thermal_cooling_device *cdev)
 {
+	int ret;
+
 	if (trip_index < 0 || trip_index >= tz->num_trips)
 		return -EINVAL;
 
-	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
+	mutex_lock(&tz->lock);
+
+	ret = thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
+
+	mutex_unlock(&tz->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
 
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -609,7 +609,7 @@ static int acpi_thermal_bind_unbind_cdev
 		.thermal = thermal, .cdev = cdev, .bind = bind
 	};
 
-	return for_each_thermal_trip(thermal, bind_unbind_cdev_cb, &bd);
+	return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb, &bd);
 }
 
 static int




