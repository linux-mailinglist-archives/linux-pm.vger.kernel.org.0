Return-Path: <linux-pm+bounces-9358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C473E90B9C9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 999E6B29A9D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E01991A3;
	Mon, 17 Jun 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="W21lgjk+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E931990AA;
	Mon, 17 Jun 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647996; cv=none; b=BF9agGcw/BkfsmUf6XS7QdRVA9KhS0p8LrGGDlFcytBgzAZ7ydSIIRuhH3Xlu26wPjHXrjtO29Tb7YaTRAGeNgzB3OpubV1T3s3bZk5t2n2A/tBdSZF/AupF0TSsdwBo6SWHAXYyEnf8pI8RsybSwlEKDZU5ZkNvXkYP6UKQFaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647996; c=relaxed/simple;
	bh=hylGUm911e4WMhiZzXuDXft7cF0yyM6IgOOX8pQZKto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XH9m3QCejodguJb1zaQxYCpD7uHQ95zWWmWiIE2xfPU26kb+drsEEkyuzKW+IHAEYnxih4VFWphtaIkpH44pEA8VZBgj93uB4xyHjKX8aetgEDXc/hDuU1JMM3V8sQCt8Z/5cHOZL9D7hAiz93izHgNln0UzEbfvSXX6yXMQfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=W21lgjk+ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 71486d43f21c0390; Mon, 17 Jun 2024 20:13:12 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8C5BC16606FD;
	Mon, 17 Jun 2024 20:13:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647992;
	bh=hylGUm911e4WMhiZzXuDXft7cF0yyM6IgOOX8pQZKto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W21lgjk+5q8mS16Bsv0+uU66y8QwKujLCyIz1NSdRVvCUyicOHvb1ROXXNiU9NDew
	 OeoFxvtz5a98wucErTPuU+ea7x/9XxtPiI5Uz9X3pZeybPEGPoTYgFkQQ1hZgH6rkf
	 +qW1DNZmJQNZSzrS2URfh5rAuxEHAA1eczFcmaIT9lIFrtlz2P66ep4jSmGCuNTJXn
	 6kYsa745i83+jNqmDcPylZsJhzVwm2FBNRJaD3/EQAa/ScRlAX+eNxUT0fqNB0y0JA
	 WsNhHY5oSuSJzspj+a1b6adrdDab3ZkX2Qt/yjFoPCC10pSnfbhpCnPg1wJ+zIcear
	 VflhOPxRry6bQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 05/14] thermal: trip: Fold __thermal_zone_get_trip() into its
 caller
Date: Mon, 17 Jun 2024 19:56:58 +0200
Message-ID: <2834573.BEx9A2HvPv@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because __thermal_zone_get_trip() is only called by thermal_zone_get_trip()
now, fold the former into the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_trip.c |   18 ++++--------------
 include/linux/thermal.h        |    2 --
 2 files changed, 4 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -114,27 +114,17 @@ void thermal_zone_set_trips(struct therm
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
 
-int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			    struct thermal_trip *trip)
-{
-	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
-		return -EINVAL;
-
-	*trip = tz->trips[trip_id].trip;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
-
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip)
 {
-	int ret;
+	if (!tz || !trip || trip_id < 0 || trip_id >= tz->num_trips)
+		return -EINVAL;
 
 	mutex_lock(&tz->lock);
-	ret = __thermal_zone_get_trip(tz, trip_id, trip);
+	*trip = tz->trips[trip_id].trip;
 	mutex_unlock(&tz->lock);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -202,8 +202,6 @@ static inline void devm_thermal_of_zone_
 }
 #endif
 
-int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 int for_each_thermal_trip(struct thermal_zone_device *tz,




