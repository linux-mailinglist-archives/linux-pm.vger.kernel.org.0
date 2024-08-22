Return-Path: <linux-pm+bounces-12771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9484C95BF1C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 21:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EF01C22F95
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575061D0498;
	Thu, 22 Aug 2024 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YqDV/5LS"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327991CDA2E;
	Thu, 22 Aug 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356154; cv=none; b=jR84XjGIK64bjVUVKDHWDGE+1mffOC+ZuEk8rKVI9+aclzYPFBsC8B3pE/dhfB5AZl5rwa3qk1bDLoLtAkECPbLWEwVEkVymr+9EBCjZ3H6WmW4Eql2DJVXDVbCEj2KV4E8LrnffdylWxMjGc7pVG7oGpyDHk0w+lnxHfTsa8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356154; c=relaxed/simple;
	bh=jiMsNXbXbNubMavwUZxO7/LryomRyHYl7eHqfsy7OlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSzd1pON5+TkFcWBEJ6uGbDf9jXQ9zpxfES3MIMT37eqXEQYMkKLROLuYo7OlM2JStypkGMi6iYMhw0ozJIC/f59As06n5QDxLyeIOqb8wZiB8eVNVL4Hb59ZMRJmTtNkMMCXusy+LjtZ0kmIE+a4Cwetl6WLac2z2B7SHTMpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YqDV/5LS reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 14afc297f4c38fac; Thu, 22 Aug 2024 21:49:10 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4690C6F0E2D;
	Thu, 22 Aug 2024 21:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724356148;
	bh=jiMsNXbXbNubMavwUZxO7/LryomRyHYl7eHqfsy7OlI=;
	h=From:Subject:Date;
	b=YqDV/5LSS1u5g3SAepUrO4q6DqWEpQJKjnI+NVz+Rx/dxP+94PAOYtlFDWEsBXG+o
	 c+YprhWPF0mnxXtEgpq2syfJM4yQy/RxUbTm3md1TMFNGyJTNKTpY/MX/EKRPg4JIa
	 j0NyxgNeiDb5yCvtDjxdGRoAmU+QNyg0Rh5y6fbah0eoucjhKDiPHS3ImkWCsYKFl7
	 e62IPi+Yy9qli4H3HNBvBKZUcuYhgp879yGN1UUuiWJCttM6gLYkILATnDFbFr7Kzs
	 63RWJZ3lo/R6WgknFkUf7t9uT5AF4UhdfyPNlj4kfCYBKe+raABOEyQ1ta7cwNOihm
	 5A43D5evbBN7A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject:
 [PATCH v1 2/2] thermal: sysfs: Add sanity checks for trip temperature and
 hysteresis
Date: Thu, 22 Aug 2024 21:48:57 +0200
Message-ID: <7719509.EvYhyI6sBW@rjwysocki.net>
In-Reply-To: <3331194.44csPzL39Z@rjwysocki.net>
References: <3331194.44csPzL39Z@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthho
 pegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghrsehpihhivgdrnhgvth
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add sanity checks for new trip temperature and hysteresis values to
trip_point_temp_store() and trip_point_hyst_store() to prevent trip
point thresholds from falling below THERMAL_TEMP_INVALID.

However, still allow user space to pass THERMAL_TEMP_INVALID as the
new trip temperature value to invalidate the trip if necessary.

Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -111,18 +111,25 @@ trip_point_temp_store(struct device *dev
 
 	mutex_lock(&tz->lock);
 
-	if (temp != trip->temperature) {
-		if (tz->ops.set_trip_temp) {
-			ret = tz->ops.set_trip_temp(tz, trip, temp);
-			if (ret)
-				goto unlock;
-		}
+	if (temp == trip->temperature)
+		goto unlock;
 
-		thermal_zone_set_trip_temp(tz, trip, temp);
+	if (temp != THERMAL_TEMP_INVALID &&
+	    temp <= trip->hysteresis + THERMAL_TEMP_INVALID) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
-		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	if (tz->ops.set_trip_temp) {
+		ret = tz->ops.set_trip_temp(tz, trip, temp);
+		if (ret)
+			goto unlock;
 	}
 
+	thermal_zone_set_trip_temp(tz, trip, temp);
+
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+
 unlock:
 	mutex_unlock(&tz->lock);
 
@@ -152,15 +159,22 @@ trip_point_hyst_store(struct device *dev
 
 	mutex_lock(&tz->lock);
 
-	if (hyst != trip->hysteresis) {
-		thermal_zone_set_trip_hyst(tz, trip, hyst);
+	if (hyst == trip->hysteresis)
+		goto unlock;
 
-		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	if (hyst + THERMAL_TEMP_INVALID >= trip->temperature) {
+		ret = -EINVAL;
+		goto unlock;
 	}
 
+	thermal_zone_set_trip_hyst(tz, trip, hyst);
+
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+
+unlock:
 	mutex_unlock(&tz->lock);
 
-	return count;
+	return ret ? ret : count;
 }
 
 static ssize_t




