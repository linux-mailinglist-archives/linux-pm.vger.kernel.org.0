Return-Path: <linux-pm+bounces-12098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 058BA94EF87
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811B01F22FD2
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEA8181337;
	Mon, 12 Aug 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fCO9A/I0"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DE17E473;
	Mon, 12 Aug 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472946; cv=none; b=I6mIQd9y/dM49xEIrhI9MoltnInjxSLfAKyxeNZPGOHeU0Id2ZtIbfY+OX5U6vcGbQ5G8dkk+SUMdXkKxrSYhNW/Py77st46s28noLrZeoxm2Nk5fcGERXxwdT7BVJ/WMyh6uzp751PQRS4UrwKu8Z4fS8nu1Yo+L2dDHsUk/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472946; c=relaxed/simple;
	bh=Nln8tsPREM+zS1pSDAxxTK0pVCtZ5sbbG/piLhCB4e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6YivjUwh1mpJqyVSt+BU7IuVyX35G3fjNAftffzz4v7hm6ehUTLuX0ygpKWSutPtcCpeyNsEq3Zoh3Rji8FIUn3OFIUGkqhLdt/khNKTtVwAmHBr2w8eIAKf5CqaTE3b2ACbFc3Qlahava7Pntcs2SY3FVgClh6R0nbza3EoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fCO9A/I0; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d30fa3a69557f8b8; Mon, 12 Aug 2024 16:29:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6C06E6F0D9C;
	Mon, 12 Aug 2024 16:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723472941;
	bh=Nln8tsPREM+zS1pSDAxxTK0pVCtZ5sbbG/piLhCB4e4=;
	h=From:Subject:Date;
	b=fCO9A/I0PAdDp0sMgcSNfYE6Az4G/rvj8hrRjfZwuSUn15ZFqjn10gC5AejvVE4jL
	 xrWPlvTtMIx+feVJoDEBE6pSnRTnUzW6XkUXDnjhCNRNgySaEiMlgqKVDdR5S5wEwX
	 ywp1xTDqaFVuP/CLGujmjNHDmkAi4DgYPOqyqcmwa9eVMXHxU+rJXPvxoJkcAK4JjP
	 SkklH0JZHVydBQ8sEjSoMwXZwWIlH0hMWa/KRKQ+Kwwua7LkiTPm6L4fpGFUkT7Qp2
	 KuRXRTyPozbhTIoYJnjhhCksl9jyErQw6ZtnzAfae6DrBB7WhkjlKfdpi7Sy+ffSQr
	 eICndq2Ah3y1A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 16/17] thermal: code: Clean up trip bind/unbind functions
Date: Mon, 12 Aug 2024 16:27:30 +0200
Message-ID: <3267346.aV6nBDHxoP@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhr
 tghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make thermal_bind_cdev_to_trip() take a struct cooling_spec pointer
to reduce the number of its arguments, change the return type of
thermal_unbind_cdev_from_trip() to void and rearrange the code in
thermal_zone_cdev_binding() to reduce the indentation level.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |   54 +++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -761,15 +761,7 @@ struct thermal_zone_device *thermal_zone
  * @tz:		pointer to struct thermal_zone_device
  * @trip:	trip point the cooling devices is associated with in this zone.
  * @cdev:	pointer to struct thermal_cooling_device
- * @upper:	the Maximum cooling state for this trip point.
- *		THERMAL_NO_LIMIT means no upper limit,
- *		and the cooling device can be in max_state.
- * @lower:	the Minimum cooling state can be used for this trip point.
- *		THERMAL_NO_LIMIT means no lower limit,
- *		and the cooling device can be in cooling state 0.
- * @weight:	The weight of the cooling device to be bound to the
- *		thermal zone. Use THERMAL_WEIGHT_DEFAULT for the
- *		default value
+ * @c:		cooling specification for @trip and @cdev
  *
  * This interface function bind a thermal cooling device to the certain trip
  * point of a thermal zone device.
@@ -780,8 +772,7 @@ struct thermal_zone_device *thermal_zone
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 				     struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
-				     unsigned long upper, unsigned long lower,
-				     unsigned int weight)
+				     struct cooling_spec *c)
 {
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *dev, *instance;
@@ -795,17 +786,17 @@ static int thermal_bind_cdev_to_trip(str
 		return -EINVAL;
 
 	/* lower default 0, upper default max_state */
-	if (lower == THERMAL_NO_LIMIT)
-		lower = 0;
+	if (c->lower == THERMAL_NO_LIMIT)
+		c->lower = 0;
 
-	if (upper == THERMAL_NO_LIMIT) {
-		upper = cdev->max_state;
+	if (c->upper == THERMAL_NO_LIMIT) {
+		c->upper = cdev->max_state;
 		upper_no_limit = true;
 	} else {
 		upper_no_limit = false;
 	}
 
-	if (lower > upper || upper > cdev->max_state)
+	if (c->lower > c->upper || c->upper > cdev->max_state)
 		return -EINVAL;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -815,11 +806,11 @@ static int thermal_bind_cdev_to_trip(str
 	dev->tz = tz;
 	dev->cdev = cdev;
 	dev->trip = trip;
-	dev->upper = upper;
+	dev->upper = c->upper;
 	dev->upper_no_limit = upper_no_limit;
-	dev->lower = lower;
+	dev->lower = c->lower;
 	dev->target = THERMAL_NO_TARGET;
-	dev->weight = weight;
+	dev->weight = c->weight;
 
 	result = ida_alloc(&tz->ida, GFP_KERNEL);
 	if (result < 0)
@@ -893,12 +884,10 @@ free_mem:
  * This interface function unbind a thermal cooling device from the certain
  * trip point of a thermal zone device.
  * This function is usually called in the thermal zone device .unbind callback.
- *
- * Return: 0 on success, the proper error value otherwise.
  */
-static int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					 struct thermal_trip *trip,
-					 struct thermal_cooling_device *cdev)
+static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+					  struct thermal_trip *trip,
+					  struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
@@ -921,7 +910,7 @@ static int thermal_unbind_cdev_from_trip
 
 	mutex_unlock(&cdev->lock);
 
-	return -ENODEV;
+	return;
 
 free:
 	device_remove_file(&tz->device, &pos->weight_attr);
@@ -929,7 +918,6 @@ free:
 	sysfs_remove_link(&tz->device.kobj, pos->name);
 	ida_free(&tz->ida, pos->id);
 	kfree(pos);
-	return 0;
 }
 
 static void thermal_release(struct device *dev)
@@ -968,7 +956,6 @@ static void thermal_zone_cdev_binding(st
 				      struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
-	int ret;
 
 	if (!tz->ops.should_bind)
 		return;
@@ -982,13 +969,14 @@ static void thermal_zone_cdev_binding(st
 			.lower = THERMAL_NO_LIMIT,
 			.weight = THERMAL_WEIGHT_DEFAULT
 		};
+		int ret;
 
-		if (tz->ops.should_bind(tz, trip, cdev, &c)) {
-			ret = thermal_bind_cdev_to_trip(tz, trip, cdev, c.upper,
-							c.lower, c.weight);
-			if (ret)
-				print_bind_err_msg(tz, trip, cdev, ret);
-		}
+		if (!tz->ops.should_bind(tz, trip, cdev, &c))
+			continue;
+
+		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
+		if (ret)
+			print_bind_err_msg(tz, trip, cdev, ret);
 	}
 
 	mutex_unlock(&tz->lock);




