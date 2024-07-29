Return-Path: <linux-pm+bounces-11557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2493FB43
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB091F21BBA
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A61891BC;
	Mon, 29 Jul 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hnaRjpre"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751B150981;
	Mon, 29 Jul 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270468; cv=none; b=ND/SK9VUBt44/bGkQI1P3S669t4y+9h2GryaYxRzmDTGCpmfODWRvC0zCTNeikMrxBnOOjnopMIOPvvw4rOHc7owQpEXsiwrFnI8j9MqZeGqm8x0sxew2gjVQgQ7Xc6rvTyVzS4CWDD42tCLSYkVVdux+aufA7hl8VNeEfe9umw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270468; c=relaxed/simple;
	bh=uKfuRzHuzsSWnz9Sa147hp4RRRVcmefMUcauj9g+Vd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBD0AhvIL8C674+YKKS2sHF+7hsqtKtxW+woggBT1CMCTz99XL1XLw3i7SepcmRvNUKa7ptW8kPRPG/Nxl0y24pbAg2NPJGcoQJiFpG1NmAQmemTjLgTZ0DEeOyuVB3tcVwqoHB4zixByC6zv6dzPpqS2nJtSIV3pzNXhEBTmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hnaRjpre; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 323c54b6339f2873; Mon, 29 Jul 2024 18:27:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C81C677357F;
	Mon, 29 Jul 2024 18:27:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722270464;
	bh=uKfuRzHuzsSWnz9Sa147hp4RRRVcmefMUcauj9g+Vd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnaRjpreHUhKzk9lcErZHnCYpzEXn3YyMxbVye6Zs1eJSPOS4u0xSPagvdAtTvki3
	 nmKaYDo+F9+rPKyt0phYNfUDgoOttq/4UchZH4c/xACJf0zpgXWbhraGcoVKnLQCbT
	 hxJGlQG67/qxY64aP16GgOW+CpZjUyeGxjzQtXXSQn0dgUv8ODUccaQ2tJqlKqw3Sf
	 SwYujM5ipQhYTtDWkv0pjaRCflN6heeo0Yp8qrUE2Uw+/+M9/gFYQMQkBHI2sBJb8r
	 FCGry0FJCPoot8NYLFSF8touNss76RP1s+mHN3DaNoHfkG43NB1fJxBxu8Y5Zy4RMN
	 59Tb6kmEnGDzw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 2/3] thermal: sysfs: Get to trips via attribute pointers
Date: Mon, 29 Jul 2024 18:25:59 +0200
Message-ID: <114841552.nniJfEyVGO@rjwysocki.net>
In-Reply-To: <1960840.taCxCBeP46@rjwysocki.net>
References: <1960840.taCxCBeP46@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The  _store() and _show() functions for sysfs attributes corresponding
to trip point parameters (type, temperature and hysteresis) read the
trip ID from the attribute name and then use the trip ID as the index
in the given thermal zone's trips table to get to the trip object they
want.

Instead of doing this, make them use the attribute pointer they get
as the second argument to get to the trip object embedded in the same
struct thermal_trip_desc as the struct device_attribute pointed to by
it, which is much more straightforward and less overhead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c |   54 ++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/container_of.h>
 #include <linux/sysfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -78,39 +79,38 @@ mode_store(struct device *dev, struct de
 	return count;
 }
 
+#define thermal_trip_of_attr(_ptr_, _attr_)				\
+	({ 								\
+		struct thermal_trip_desc *td;				\
+									\
+		td = container_of(_ptr_, struct thermal_trip_desc,	\
+				  trip_attrs._attr_.attr);		\
+		&td->trip;						\
+	})
+
 static ssize_t
 trip_point_type_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip_id;
-
-	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
-		return -EINVAL;
+	struct thermal_trip *trip = thermal_trip_of_attr(attr, type);
 
-	return sprintf(buf, "%s\n", thermal_trip_type_name(tz->trips[trip_id].trip.type));
+	return sprintf(buf, "%s\n", thermal_trip_type_name(trip->type));
 }
 
 static ssize_t
 trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
+	struct thermal_trip *trip = thermal_trip_of_attr(attr, temp);
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip *trip;
-	int trip_id, ret;
-	int temp;
+	int ret, temp;
 
 	ret = kstrtoint(buf, 10, &temp);
 	if (ret)
 		return -EINVAL;
 
-	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
-		return -EINVAL;
-
 	mutex_lock(&tz->lock);
 
-	trip = &tz->trips[trip_id].trip;
-
 	if (temp != trip->temperature) {
 		if (tz->ops.set_trip_temp) {
 			ret = tz->ops.set_trip_temp(tz, trip, temp);
@@ -133,35 +133,25 @@ static ssize_t
 trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip_id;
+	struct thermal_trip *trip = thermal_trip_of_attr(attr, temp);
 
-	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
-		return -EINVAL;
-
-	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.temperature));
+	return sprintf(buf, "%d\n", READ_ONCE(trip->temperature));
 }
 
 static ssize_t
 trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
+	struct thermal_trip *trip = thermal_trip_of_attr(attr, hyst);
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	struct thermal_trip *trip;
-	int trip_id, ret;
-	int hyst;
+	int ret, hyst;
 
 	ret = kstrtoint(buf, 10, &hyst);
 	if (ret || hyst < 0)
 		return -EINVAL;
 
-	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
-		return -EINVAL;
-
 	mutex_lock(&tz->lock);
 
-	trip = &tz->trips[trip_id].trip;
-
 	if (hyst != trip->hysteresis) {
 		WRITE_ONCE(trip->hysteresis, hyst);
 
@@ -177,13 +167,9 @@ static ssize_t
 trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip_id;
-
-	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
-		return -EINVAL;
+	struct thermal_trip *trip = thermal_trip_of_attr(attr, hyst);
 
-	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.hysteresis));
+	return sprintf(buf, "%d\n", READ_ONCE(trip->hysteresis));
 }
 
 static ssize_t




