Return-Path: <linux-pm+bounces-7720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45268C26A2
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217701C21FFE
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C9016FF5B;
	Fri, 10 May 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eh/ONn3v"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5412CDBE;
	Fri, 10 May 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350844; cv=none; b=AVhZj2ZQkCZO5tKIZK8cWcL0UV3icjocVmOyJYoqYCfhh8xKdt4+67YuANL5aLwlrjU69wJY6WQAAx/t/wMioC5RkPoiIA4ZxuFngpNfcjet+PAMqUWV0DKk6ewjhxFoMq5m2dORraq9IAdrhOOfjHguWfnNVo9KH7lAleE52FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350844; c=relaxed/simple;
	bh=IwYvx7AdtUSAnjVTaqdebSTKuEJtx9fGzXya37uUCEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF644H840KQVeF9SxYOTKYxJFEFrq7S08UlothPSAfXK3jAYjgzPXyVjdaPtZ79rWU2KMDJ19bxCTioMZcBppHwzERhIwwknEgf6bHyWS/yeZJPHTKgCn7acK8RaUwvr7Cq/EvejX8vO5Db3JCvHrjhLdHmY7Gah8PIUoqFQf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eh/ONn3v reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id b7e5f4da9462ce13; Fri, 10 May 2024 16:20:40 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A52BF2102F3F;
	Fri, 10 May 2024 16:20:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715350840;
	bh=IwYvx7AdtUSAnjVTaqdebSTKuEJtx9fGzXya37uUCEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eh/ONn3vkXsWfE2na/k8K7j4khJ5TlszDyqNR7FP09lDV1dr15b9ZINflAt3jo1mt
	 5HNjnPBeZHAo57+5eDuKrU7dPdhpew1uPusMAlCS/arockxsZSdwTQ4Xz8UB7j6eCe
	 JCc/6srfOMkAqfh/KdpyeYrLcKGVXD3k5s6vMDnqkUWceYrv4GJ6U5GZz+KS44f9Sz
	 DKqSzjpFJXTD2sjZSRreeduXUdJUD3psAyUPlhtw0VI0GGsAvVvnOSS80B16wgO6oK
	 81WUbGLOmIJttvw2srUIhTBiR8Ihwug21gJoSmcstloKtt36CJDloPRWyJdWdpIYKP
	 WmMtpOR+DfERw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 4/6] thermal: trip: Use READ_ONCE() for lockless access to trip
 properties
Date: Fri, 10 May 2024 16:18:19 +0200
Message-ID: <7669508.EvYhyI6sBW@kreacher>
In-Reply-To: <13518388.uLZWGnKmhe@kreacher>
References: <13518388.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When accessing trip temperature and hysteresis without locking, it is
better to use READ_ONCE() to prevent compiler optimizations possibly
affecting the read from being applied.

Of course, for the READ_ONCE() to be effective, WRITE_ONCE() needs to
be used when updating their values.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c |    6 +++---
 drivers/thermal/thermal_trip.c  |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -141,7 +141,7 @@ trip_point_temp_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.temperature);
+	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.temperature));
 }
 
 static ssize_t
@@ -165,7 +165,7 @@ trip_point_hyst_store(struct device *dev
 	trip = &tz->trips[trip_id].trip;
 
 	if (hyst != trip->hysteresis) {
-		trip->hysteresis = hyst;
+		WRITE_ONCE(trip->hysteresis, hyst);
 
 		thermal_zone_trip_updated(tz, trip);
 	}
@@ -185,7 +185,7 @@ trip_point_hyst_show(struct device *dev,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].trip.hysteresis);
+	return sprintf(buf, "%d\n", READ_ONCE(tz->trips[trip_id].trip.hysteresis));
 }
 
 static ssize_t
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -161,7 +161,7 @@ void thermal_zone_set_trip_temp(struct t
 	if (trip->temperature == temp)
 		return;
 
-	trip->temperature = temp;
+	WRITE_ONCE(trip->temperature, temp);
 	thermal_notify_tz_trip_change(tz, trip);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);




