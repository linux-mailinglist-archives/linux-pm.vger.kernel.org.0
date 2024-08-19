Return-Path: <linux-pm+bounces-12465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69F95706B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48A01B26F60
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB755178376;
	Mon, 19 Aug 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="mttiSLoa"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F6175D5D;
	Mon, 19 Aug 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085223; cv=none; b=L/I4/SdjnMRh63Th7jLNkvhvoTStmLhz+L7w3gYL/UEAiOUS/jMMiwYGkBDY1o3QJUhG4fUJqvXTdXP+OikpGYjAE+vbWY27H0KVmnRydK+xQo4PPlFCiorik29leogVw4YHiraF2TLaEeavXAhGwljsM01LPUubXx1NoF+2dnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085223; c=relaxed/simple;
	bh=5VFCrHPQhdvu70cp9nbqtAPwZQZMYLt8PYeKbw+mtag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kL7DRPgRfT9QmI7yGXjCk/JMyFWO+Nc8hDnsKwCd3D/s3Oktcr3BBPE7FW8UD874aRjQ49M29nv8L1OXxkTIzk1FOFN/9OyhIctFbS9IZ/aC6rcabWCN1ygbXwpMNmzM+jRDE6BEcwKwLmqM1nybauLgKH7CpwxaD0WQ8+nYirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=mttiSLoa; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1c01ccf5d5ceffdb; Mon, 19 Aug 2024 18:33:39 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1FD8D73B5D4;
	Mon, 19 Aug 2024 18:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724085219;
	bh=5VFCrHPQhdvu70cp9nbqtAPwZQZMYLt8PYeKbw+mtag=;
	h=From:Subject:Date;
	b=mttiSLoa5mLQG89zv+NSsCvmxn5NXcPjQLQEGMqinX0345x9Tld04YdHj8szsaNEz
	 sbORo2mp1SpGNgKGYGX8HDQFcq83HcV6c/rLxe9NyC9/DvxqfxSBGtoyEIvAdr9uLM
	 jvbIF9uPA1dAuaAtFjGjMb+0JC8Ui9uxGiqK0/hlJab+/IYgyh+GuzH3OY51Z8aE9v
	 gaR2rAAcmnXSegbvcRs7kUPfv1jky0Sb9cw2NS3Kpv8qIPxQi94t/XSn4w0giZbHRS
	 b9N91HVnpW1z634/wiilCyOOaJVdsoMh6/Rzqhb8DIsy+YMgEJbAlgw4cDG5xA3L0y
	 OptJbyWz4Mukw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 14/14] thermal: core: Clean up trip bind/unbind functions
Date: Mon, 19 Aug 2024 18:33:11 +0200
Message-ID: <1831773.TLkxdtWsSY@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdp
 rhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make thermal_bind_cdev_to_trip() take a struct cooling_spec pointer
to reduce the number of its arguments, change the return type of
thermal_unbind_cdev_from_trip() to void and rearrange the code in
thermal_zone_cdev_binding() to reduce the indentation level.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Subject fix

v1-> v2: No changes

---
 drivers/thermal/thermal_core.c |   54 +++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -757,15 +757,7 @@ struct thermal_zone_device *thermal_zone
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
@@ -776,8 +768,7 @@ struct thermal_zone_device *thermal_zone
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 				     const struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
-				     unsigned long upper, unsigned long lower,
-				     unsigned int weight)
+				     struct cooling_spec *c)
 {
 	struct thermal_instance *dev;
 	struct thermal_instance *pos;
@@ -791,17 +782,17 @@ static int thermal_bind_cdev_to_trip(str
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
@@ -810,11 +801,11 @@ static int thermal_bind_cdev_to_trip(str
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
@@ -887,12 +878,10 @@ free_mem:
  * This interface function unbind a thermal cooling device from the certain
  * trip point of a thermal zone device.
  * This function is usually called in the thermal zone device .unbind callback.
- *
- * Return: 0 on success, the proper error value otherwise.
  */
-static int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					 const struct thermal_trip *trip,
-					 struct thermal_cooling_device *cdev)
+static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+					  const struct thermal_trip *trip,
+					  struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *pos, *next;
 
@@ -912,7 +901,7 @@ static int thermal_unbind_cdev_from_trip
 	}
 	mutex_unlock(&cdev->lock);
 
-	return -ENODEV;
+	return;
 
 unbind:
 	device_remove_file(&tz->device, &pos->weight_attr);
@@ -920,7 +909,6 @@ unbind:
 	sysfs_remove_link(&tz->device.kobj, pos->name);
 	ida_free(&tz->ida, pos->id);
 	kfree(pos);
-	return 0;
 }
 
 static void thermal_release(struct device *dev)
@@ -959,7 +947,6 @@ static void thermal_zone_cdev_binding(st
 				      struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
-	int ret;
 
 	if (!tz->ops.should_bind)
 		return;
@@ -973,13 +960,14 @@ static void thermal_zone_cdev_binding(st
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




