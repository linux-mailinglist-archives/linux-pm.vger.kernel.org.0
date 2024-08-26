Return-Path: <linux-pm+bounces-12888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0389095F659
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A2A1F21FC2
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C6194A6B;
	Mon, 26 Aug 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JQh07fod"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B17186619;
	Mon, 26 Aug 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689331; cv=none; b=kB8umMIwkNUPgz99SHk5P2JpG4FJol1iSFCD5KouhHvkJIp09w/gGHgj8Vmhq7H7W4+1WC+hE+/evsuuIHDJsST+0Rts87XfRSiH+WoBXUQhrSfOTs5FTumYZmFxFRXLS+DO/g46s9hu5dGGavOBAcvJROKsPHK/PGL9Bjtkqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689331; c=relaxed/simple;
	bh=pTF0GQuq2D3JFH03RRQkEFsAZH/rp+YFHx4WbIXcsnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRmAoQpeSahfiZBf2/eNNTOWIllNtPSTiEj0zT66urY4TIDWus3M0+OGiTFSYtLLcyQGalJ3DQqb+xW0j+RupzpnMyoiK9lkGfgc5abPRzeW2lXV/G5f06MYyozzLJOg4wpZlQ+bsgssLwWm3qjnPC/Faw+/BjM/dvIQtO9RfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JQh07fod reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a059ac823603f2f4; Mon, 26 Aug 2024 18:22:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 90A5292159D;
	Mon, 26 Aug 2024 18:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724689320;
	bh=pTF0GQuq2D3JFH03RRQkEFsAZH/rp+YFHx4WbIXcsnI=;
	h=From:Subject:Date;
	b=JQh07fodmCZxdtGpOgkIQzYqaCooc5wvfBh4VDWarG4jmN79x79e16G2FuqjQFCfp
	 Rm3WARQ3mqk2nSh5CF3vv3T3pELlyaQvqQI9mwPFod/khDJ8ARMWb2heEuXWIRRYA2
	 BJcotqel0rvcz7JY4qh2x0CGbjeHEgDj9KyCMFDULrWbBM5RnXaqI+XkhclhboyRMe
	 rMwiGYWPlN0qIWOp0y6uHlc7RMuW8bykmytY1aNzVCRs2eozUySGxDRMNk0OT3n19V
	 6foCP5fgkvSs0QbrBIb7nM9xdmPrV+Uh8plSoTlzCFDnv7tiK3RZWv6mmPYOcBhYLS
	 aHjy995zmGlVw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v2] thermal: sysfs: Add sanity checks for trip temperature and
 hysteresis
Date: Mon, 26 Aug 2024 18:21:59 +0200
Message-ID: <12528772.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
 vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add sanity checks for new trip temperature and hysteresis values to
trip_point_temp_store() and trip_point_hyst_store() to prevent trip
point threshold from falling below THERMAL_TEMP_INVALID.

However, still allow user space to pass THERMAL_TEMP_INVALID as the
new trip temperature value to invalidate the trip if necessary.

Also allow the hysteresis to be updated when the temperature is invalid
to allow user space to avoid having to adjust hysteresis after a valid
temperature has been set, but in that case just change the value and do
nothing else.

Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
Cc: 6.8+ <stable@vger.kernel.org> # 6.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Reorder the new check in trip_point_hyst_store() to be easier
     to read (Daniel).
   * Add a comment explaining the ordering of the new check in
     trip_point_temp_store().
   * Allow the hysteresis to be updated when the temperature is invalid.

This is an update of

https://lore.kernel.org/linux-pm/7719509.EvYhyI6sBW@rjwysocki.net/

which is being sent separately because patch [1/2] from the original series
has been applied.

---
 drivers/thermal/thermal_sysfs.c |   50 ++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -111,18 +111,26 @@ trip_point_temp_store(struct device *dev
 
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
+	/* Arrange the condition to avoid integer overflows. */
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
 
@@ -152,15 +160,33 @@ trip_point_hyst_store(struct device *dev
 
 	mutex_lock(&tz->lock);
 
-	if (hyst != trip->hysteresis) {
-		thermal_zone_set_trip_hyst(tz, trip, hyst);
+	if (hyst == trip->hysteresis)
+		goto unlock;
+
+	/*
+	 * Allow the hysteresis to be updated when the temperature is invalid
+	 * to allow user space to avoid having to adjust hysteresis after a
+	 * valid temperature has been set, but in that case just change the
+	 * value and do nothing else.
+	 */
+	if (trip->temperature == THERMAL_TEMP_INVALID) {
+		WRITE_ONCE(trip->hysteresis, hyst);
+		goto unlock;
+	}
 
-		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	if (trip->temperature - hyst <= THERMAL_TEMP_INVALID) {
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




