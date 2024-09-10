Return-Path: <linux-pm+bounces-13933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950DB972E89
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99571C245E3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809818C913;
	Tue, 10 Sep 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sjjzTC2q"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A818C03F;
	Tue, 10 Sep 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961391; cv=none; b=YC5UuEYDeCquK/JGdnED4hHtV2CWip/v1CwUeFeB3OeGq7/4z5ayjmiSDsLlSrPpJrMleAIsHKXAlELnvPjInCBzmRrvbP+EC7+EeBHiqNX+w51RYmPstLzlbLmDb2yp+wYnZgDd1tIF/6o4RKNDYuae1KC4Gt4aQSS3Vfaj/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961391; c=relaxed/simple;
	bh=tWC1x6kWLdZMv3C8z4KWP6WOlEn6zMSc5yL2vkwYUAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll4ouDJHHFq1I2eYbuLZtmWxbpPsLWPGKHOblssgdSNyBIKL4CT2/r2awXXAsDSIKGa+HYN/ZX1ukZ7CEmSNKvnBDANi5K7wmumr5/y7eDxFpuz60vLBordLEBb2pu0d2NT8/Ott/bdZrEQxKuTrxhWiU+OCuh7IYCZj0qWjdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sjjzTC2q reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 190bcde46773db16; Tue, 10 Sep 2024 11:43:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7B2646B836A;
	Tue, 10 Sep 2024 11:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1725961386;
	bh=tWC1x6kWLdZMv3C8z4KWP6WOlEn6zMSc5yL2vkwYUAQ=;
	h=From:Subject:Date;
	b=sjjzTC2qQI8rCtKLT55EKT9YuhwY/omE/1AjkTfU8OVCiq/WPGP2Y7weFu0vP1qbR
	 7qxlMP6m07yTcv0zg/iNui3E1L+sBoY9p+Mr/BoFFPhWs4pXTn+RssWADpKBXQiMyV
	 8sNKstI1Q1llvA733v9pkx6o924aZgELIJAfysFW8DQ5t96iVwQ0/5VPLp6xy4Q23q
	 41TvpB2oLHKtnXSvd6RxNk+cCwuMa9GlhIubDRNiT/MlP4RMHvVWlnsOak05NpE2S4
	 /Vr9u8mCR5sEfmUi1peS87pC+wM+//9Uq76xwtADpPNOpPCjbUIohvNJ3qn5EnhUUO
	 SHCGRYoWk67Dw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH for 6.13 v1 2/8] thermal: core: Pass trip descriptors to trip
 bind/unbind functions
Date: Tue, 10 Sep 2024 11:28:40 +0200
Message-ID: <2954063.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <4920970.GXAFRqVoOG@rjwysocki.net>
References: <4920970.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=20 Fuz1=20 Fuz2=20

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v3] 

The code is somewhat cleaner if struct thermal_trip_desc pointers are
passed to thermal_bind_cdev_to_trip(), thermal_unbind_cdev_from_trip(),
and print_bind_err_msg() instead of struct thermal_trip pointers, so
modify it accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -754,9 +754,9 @@ struct thermal_zone_device *thermal_zone
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to bind @cdev to
  * @cdev:	pointer to struct thermal_cooling_device
- * @cool_spec:	cooling specification for @trip and @cdev
+ * @cool_spec:	cooling specification for the trip point and @cdev
  *
  * This interface function bind a thermal cooling device to the certain trip
  * point of a thermal zone device.
@@ -765,11 +765,10 @@ struct thermal_zone_device *thermal_zone
  * Return: 0 on success, the proper error value otherwise.
  */
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-				     struct thermal_trip *trip,
+				     struct thermal_trip_desc *td,
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *cool_spec)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *dev, *instance;
 	bool upper_no_limit;
 	int result;
@@ -793,7 +792,7 @@ static int thermal_bind_cdev_to_trip(str
 		return -ENOMEM;
 
 	dev->cdev = cdev;
-	dev->trip = trip;
+	dev->trip = &td->trip;
 	dev->upper = cool_spec->upper;
 	dev->upper_no_limit = upper_no_limit;
 	dev->lower = cool_spec->lower;
@@ -865,7 +864,7 @@ free_mem:
 /**
  * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to unbind @cdev from
  * @cdev:	pointer to a struct thermal_cooling_device.
  *
  * This interface function unbind a thermal cooling device from the certain
@@ -873,10 +872,9 @@ free_mem:
  * This function is usually called in the thermal zone device .unbind callback.
  */
 static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					  struct thermal_trip *trip,
+					  struct thermal_trip_desc *td,
 					  struct thermal_cooling_device *cdev)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&cdev->lock);
@@ -928,11 +926,11 @@ static struct class *thermal_class;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
-			const struct thermal_trip *trip,
+			const struct thermal_trip_desc *td,
 			struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
-		cdev->type, thermal_zone_trip_id(tz, trip), ret);
+		cdev->type, thermal_zone_trip_id(tz, &td->trip), ret);
 }
 
 static void thermal_zone_cdev_bind(struct thermal_zone_device *tz,
@@ -946,7 +944,6 @@ static void thermal_zone_cdev_bind(struc
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td) {
-		struct thermal_trip *trip = &td->trip;
 		struct cooling_spec c = {
 			.upper = THERMAL_NO_LIMIT,
 			.lower = THERMAL_NO_LIMIT,
@@ -954,12 +951,12 @@ static void thermal_zone_cdev_bind(struc
 		};
 		int ret;
 
-		if (!tz->ops.should_bind(tz, trip, cdev, &c))
+		if (!tz->ops.should_bind(tz, &td->trip, cdev, &c))
 			continue;
 
-		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
+		ret = thermal_bind_cdev_to_trip(tz, td, cdev, &c);
 		if (ret)
-			print_bind_err_msg(tz, trip, cdev, ret);
+			print_bind_err_msg(tz, td, cdev, ret);
 	}
 
 	mutex_unlock(&tz->lock);
@@ -1270,7 +1267,7 @@ static void thermal_zone_cdev_unbind(str
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td)
-		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
+		thermal_unbind_cdev_from_trip(tz, td, cdev);
 
 	mutex_unlock(&tz->lock);
 }




