Return-Path: <linux-pm+bounces-9367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D11390B953
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F9F1F21243
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E4219A2A3;
	Mon, 17 Jun 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="khEwqy1n"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF961991D7;
	Mon, 17 Jun 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647999; cv=none; b=JQmRPysTRmsHfMOYUBbreKi09N4iFzHrWhNZ3jFfKtzP/BMm90zqhvVTKdMa+/JJ49dbb6zrJmqcxeaoEczC6tkd0YmKfYDbW1IL4BHAOi8bdNTOArbmKuRcYYegcls9kk7KxtZqSiphQ4vei+Tha1uWOxAQdAnjZSkLbN7k3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647999; c=relaxed/simple;
	bh=N4431/dEqcLneJ0L4FqIhI85vfz3NLUuiDXk1AU3+nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fv2Cv2+8/qRGLL9OhRPrnZzFVXvkT0u54ummcQm59YO+NoavvpDFfZPpegUHvzfHRwofQ3Yk0XPUjD4pEozZxeQ0kunM6v/KawQM+DsNDrm8BldXoTR2hLupMLcYniHGu+aMUx445rARWhuxPueKz9UxJXShxonFjKUbt191cEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=khEwqy1n reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 77efd14f6b27b710; Mon, 17 Jun 2024 20:13:15 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 70A071661CEB;
	Mon, 17 Jun 2024 20:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647995;
	bh=N4431/dEqcLneJ0L4FqIhI85vfz3NLUuiDXk1AU3+nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=khEwqy1nEFPglCqAk7bLLJkqxKbyVX0hyvsc4n3Z5I5NmIXpD4wqHFGgIOqEMo+tl
	 SSDuzyjUtm028ZX6ul36c1ntDqEmNZ3vlPe2B8C3DheNPdC/QxXMgPeFC41c6gbwzc
	 79D4tsJf0aYp/V+IrUGeCdgroGt0LqPmQjaOKLRMy+xFoACYL4wiXalD3GHmE5k/0Z
	 +2Nk29y1xvdGr02xr7ww+6KWrJ0I+hiN+74dpmZsimjxPQxYpIuqI6xBqAHAwrtqaS
	 rsItBLw2QjuMJkPquwl0XZNgLPCylkgeeQ0lAwwQuYQFmqiROKnID8vcFQMQiU/9Lt
	 6duBRRNKe38wA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, linux-tegra@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Subject:
 [PATCH v1 02/14] thermal: helpers: Introduce thermal_trip_is_bound_to_cdev()
Date: Mon, 17 Jun 2024 19:49:03 +0200
Message-ID: <2013201.usQuhbGJ8B@kreacher>
In-Reply-To: <8409966.T7Z3S40VBb@kreacher>
References: <8409966.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthgvghhrrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhu
 khgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new helper function thermal_trip_is_bound_to_cdev() for
checking whether or not a given trip point has been bound to a given
cooling device.

The primary user of it will be the Tegra thermal driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c |   47 ++++++++++++++++++++++++++++----------
 include/linux/thermal.h           |    3 ++
 2 files changed, 38 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -39,30 +39,53 @@ int get_tz_trend(struct thermal_zone_dev
 	return trend;
 }
 
+static struct thermal_instance *get_instance(struct thermal_zone_device *tz,
+					     struct thermal_cooling_device *cdev,
+					     const struct thermal_trip *trip)
+{
+	struct thermal_instance *ti;
+
+	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
+		if (ti->trip == trip && ti->cdev == cdev)
+			return ti;
+	}
+
+	return NULL;
+}
+
+bool thermal_trip_is_bound_to_cdev(struct thermal_zone_device *tz,
+				   const struct thermal_trip *trip,
+				   struct thermal_cooling_device *cdev)
+{
+	bool ret;
+
+	mutex_lock(&tz->lock);
+	mutex_lock(&cdev->lock);
+
+	ret = !!get_instance(tz, cdev, trip);
+
+	mutex_unlock(&cdev->lock);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
+
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
 		     struct thermal_cooling_device *cdev, int trip_index)
 {
-	struct thermal_instance *pos = NULL;
-	struct thermal_instance *target_instance = NULL;
-	const struct thermal_trip *trip;
+	struct thermal_instance *ti;
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
-	trip = &tz->trips[trip_index].trip;
-
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
-		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
-			target_instance = pos;
-			break;
-		}
-	}
+	ti = get_instance(tz, cdev, &tz->trips[trip_index].trip);
 
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
 
-	return target_instance;
+	return ti;
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -269,6 +269,9 @@ struct thermal_zone_device *thermal_zone
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
+bool thermal_trip_is_bound_to_cdev(struct thermal_zone_device *tz,
+				   const struct thermal_trip *trip,
+				   struct thermal_cooling_device *cdev);
 
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);




