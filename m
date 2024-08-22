Return-Path: <linux-pm+bounces-12772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F195BF61
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9241F26DEE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9A13B2B0;
	Thu, 22 Aug 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Vn8jP0Ii"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41E37700;
	Thu, 22 Aug 2024 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724357003; cv=none; b=ljbjSAEfKw7lkOgsztBKWOK51HwHEWuSICb+t/JGV4jowxNYIkUPIlwV/1ZGS9CRunYnhOab+peh8IMZc1GeMgwztlnsk+WomZKt/hbqPtXO0nDPtc4h1tNx2vwBhw0ug4MAulvMOvPPVchon8GEttwlQJ7aU10giDFWadsp7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724357003; c=relaxed/simple;
	bh=hMjv0kTTbhd2cvKuxFBqLRC4XzRw5Tl4Y3UveP6Z2ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUB3Kk20zBh17XjNucwhUXY+Co/Aarek8q5UjcObiU1zOyXj4MPopvmQoD9S8I27gXIQt6H3KHy4xQZlXhhD3d2a0GLUP6LX77q1iBAL3JtvUx2IoDuaIhN80W8o7LirrtUdHxTvkxGwlGyLGTW20oLuqMt4qYS/i8hXNNvGDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Vn8jP0Ii; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 62ed68ab59bf30e8; Thu, 22 Aug 2024 22:03:19 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1838C6F0E2D;
	Thu, 22 Aug 2024 22:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724356999;
	bh=hMjv0kTTbhd2cvKuxFBqLRC4XzRw5Tl4Y3UveP6Z2ys=;
	h=From:Subject:Date;
	b=Vn8jP0IiDiYGt/YdrE+aJuHy7ZVk7bNxDhAX/2oJt4GHmROksTTwC1Dt+MpDFSL4h
	 pVSWu9KEpPrjMTVOTjf1vJAl1zgDwrR/Vo3bqpg8AYD3Alzs3c20eKQEF1txrCu/Os
	 e80NS8IaXG2YG3HsbFZjO8lmjSe8/qaHOoRwo6mpoSwuhPcyXKJd2+cx188b5bAK8Q
	 u6dBn74sgJ5h6DrWlxWJqwrQ0akVf5MBB3NVvuC+u+h8MGQJ1OOB65rS5PG71V07e1
	 l1MEyJ3i8Bv8M1AAxR5HTkfMlDBqd0H4S8LRtwaG1Cr9RaktjNvmYUpPnmEzYCFWcm
	 9cg/IPfl5CnDw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject: [PATCH v1 1/2] thermal: core: Fix rounding of delay jiffies
Date: Thu, 22 Aug 2024 21:47:36 +0200
Message-ID: <1994438.PYKUYFuaPT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthho
 pegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehpvghtvghrsehpihhivgdrnhgvth
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Using round_jiffies() in thermal_set_delay_jiffies() is invalid because
its argument should be time in the future in absolute jiffies and it
computes the result with respect to the current jiffies value at the
invocation time.  Fortunately, in the majority of cases it does not
make any difference due to the time_is_after_jiffies() check in
round_jiffies_common().

While using round_jiffies_relative() instead of round_jiffies() might
reflect the intent a bit better, it still would not be defensible
because that function should be called when the timer is about to be
set and it is not suitable for pre-computation of delay values.

Accordingly, drop thermal_set_delay_jiffies() altogether, simply
convert polling_delay and passive_delay to jiffies during thermal
zone initialization and make thermal_zone_device_set_polling() call
round_jiffies_relative() on the delay if it is greather than 1 second.

Fixes: 17d399cd9c89 ("thermal/core: Precompute the delays from msecs to jiffies")
Fixes: e5f2cda61d06 ("thermal/core: Move thermal_set_delay_jiffies to static")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -323,11 +323,15 @@ static void thermal_zone_broken_disable(
 static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 					    unsigned long delay)
 {
-	if (delay)
-		mod_delayed_work(system_freezable_power_efficient_wq,
-				 &tz->poll_queue, delay);
-	else
+	if (!delay) {
 		cancel_delayed_work(&tz->poll_queue);
+		return;
+	}
+
+	if (delay > HZ)
+		delay = round_jiffies_relative(delay);
+
+	mod_delayed_work(system_freezable_power_efficient_wq, &tz->poll_queue, delay);
 }
 
 static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
@@ -1312,13 +1316,6 @@ void thermal_cooling_device_unregister(s
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
-{
-	*delay_jiffies = msecs_to_jiffies(delay_ms);
-	if (delay_ms > 1000)
-		*delay_jiffies = round_jiffies(*delay_jiffies);
-}
-
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
 	const struct thermal_trip_desc *td;
@@ -1465,8 +1462,8 @@ thermal_zone_device_register_with_trips(
 		td->threshold = INT_MAX;
 	}
 
-	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
-	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+	tz->polling_delay_jiffies = msecs_to_jiffies(polling_delay);
+	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
 	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
 
 	/* sys I/F */




