Return-Path: <linux-pm+bounces-12095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B994EF2E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19AB282DB8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600C18308D;
	Mon, 12 Aug 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ckxUKGAu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE117F4F2;
	Mon, 12 Aug 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471776; cv=none; b=BF/ZUe8EuPW02OTM9XXAd0ERM39ZDLukXufhT1pCoAumP15M2fj5Fk1WupT0IF2VU4MLhOC5HeCze7dnrdrS63qGMRpggTiRqAY1yHsD2k1IyXm58S41JlsTKEtWz53bchlxSaK62B1s4e4FGVSV7tIVXD4UNWzDg/DvZWpNbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471776; c=relaxed/simple;
	bh=cKY0anN3ZJZFbMAXGyDYNJKkKnybGeIoM+WSXcqfNeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuXqF//yIxzfKi1+9AHv/Mtt2cKRDQXkpmmQNAKdFcLIiNBQZiJ1UXAo3W6tyiPr2WD91TYJFKHriC39DtqfBU9thgl8aWBwnYOlyvD3qppOFHK6j/YGPsE8NDYNAtPPJo3dzb/g1gt89bKAJ+BOzNUTU2sqPxtVbD6GuIGcny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ckxUKGAu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 01e34b93c51094a0; Mon, 12 Aug 2024 16:09:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EBDA56F0D6A;
	Mon, 12 Aug 2024 16:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723471772;
	bh=cKY0anN3ZJZFbMAXGyDYNJKkKnybGeIoM+WSXcqfNeQ=;
	h=From:Subject:Date;
	b=ckxUKGAuOT/kqe/o7x836A7hWh/PessHF88KZEaPEoujfc4lGvJrDgbx8s6UBezQw
	 R54Q8deIQKIKTkm5+Lfr1wEJi+WLQMLiMzX6Np526QYx8B/Yutnuh4zpzRjaoS3grn
	 lqUBs84whkOIJQ0K4ss0jky3ySZNyy4LyC9at8KIblGIWa0lD/CaoM/08b/W5wXIR5
	 13TpF+c2KMz17vZC2S4JgeZ1fjXAkNrDRwuZKKCeF3e2f1CbJ0vYfHE1zfPWQzF1kx
	 jMZwS75lSyF3WIlmeNrBNSXWLu+76XGQN2Mo10oTUmeYDSCizhAmQWMizHWRItMn6S
	 /kzqoT1E9uCRw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 07/17] thermal: core: Move thermal zone locking out of bind/unbind
 functions
Date: Mon, 12 Aug 2024 16:04:38 +0200
Message-ID: <4611405.cEBGB3zze1@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
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

v1 -> v2: No changes

---
 drivers/acpi/thermal.c         |    2 +-
 drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -789,6 +789,7 @@ int thermal_bind_cdev_to_trip(struct the
 	int result;
 
 	lockdep_assert_held(&thermal_list_lock);
+	lockdep_assert_held(&tz->lock);
 
 	if (list_empty(&tz->node) || list_empty(&cdev->node))
 		return -EINVAL;
@@ -851,7 +852,6 @@ int thermal_bind_cdev_to_trip(struct the
 	if (result)
 		goto remove_trip_file;
 
-	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
 	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
@@ -868,7 +868,6 @@ int thermal_bind_cdev_to_trip(struct the
 	thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 
 	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
 
 	return 0;
 
@@ -892,11 +891,19 @@ int thermal_zone_bind_cooling_device(str
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
 
@@ -919,7 +926,8 @@ int thermal_unbind_cdev_from_trip(struct
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
+
 	mutex_lock(&cdev->lock);
 
 	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
@@ -930,13 +938,11 @@ int thermal_unbind_cdev_from_trip(struct
 			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
 
 			mutex_unlock(&cdev->lock);
-			mutex_unlock(&tz->lock);
 			goto free;
 		}
 	}
 
 	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
 
 	return -ENODEV;
 
@@ -954,10 +960,18 @@ int thermal_zone_unbind_cooling_device(s
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




