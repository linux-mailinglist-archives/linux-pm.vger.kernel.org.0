Return-Path: <linux-pm+bounces-9364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EA990B94B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B6F1C20A5F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB66199E92;
	Mon, 17 Jun 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lqe81IbW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0101990C9;
	Mon, 17 Jun 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647998; cv=none; b=ECcy8S8daV2s0DKrMdNapTr4oRHh8o2xDHOl1sMZjioJOq8mgsS46EhIg9b2mIIb4cHvajFR6ZUMz+GZcmqpwXoCjOO9sRaLCZqD2vvE+kCqprd0o27Na58+wzEJ6AZ5X0HuLBTwGakBMFa4u759G4XtXRHN4iavni6EtbGqmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647998; c=relaxed/simple;
	bh=0EqbKRr78pKBR/LsZY0Hi8foVnymZgGel7l5EDAak44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHtVjAAFOlURJtZeWMO4b7ZARq2XWekxcRVXzoVLfdF/Zg0v7PofvRiT1UIV0cHCAdPs3cpv/egkixMNqHAr2zg+fOLAAUZc3aYycUjfnQfR/kWKXUrVI4Ohx2FzAtTremhBNymcqLw0pM5wUGilKhi5d+a5z2VQzzmQbaNW74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lqe81IbW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d8ebfcda6e69060f; Mon, 17 Jun 2024 20:13:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8F85B16606FD;
	Mon, 17 Jun 2024 20:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647988;
	bh=0EqbKRr78pKBR/LsZY0Hi8foVnymZgGel7l5EDAak44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lqe81IbWjlzayrmgEhUnh7AE8CfedTq5oO6luYYBVS6QCCDt6lCN44PeOQZbBNxQp
	 gehJefYOuxaLnOY4fXtmoFwcsOR0xz1/rmfqPCuCXZSRodSRnOoG3kWUCiSCnDLRPp
	 tE40JE7lDMiPD4ZGuXXbXj3oZ+bzxG30Be/xxu5LSb+D0Ox0AISw75GzWmy4q/M8RA
	 6Mpfmtxl0vxS00KcBfhBh9MgFUCkBZBsDopgZFK8nQkY+MXtej2EHp9RaMFcssfX0C
	 A8zwKI33hyfmQUNfqfzue7oC+oscbOMyggXhlcXpZPoZjZHY3bQYeiOl3VQ/C71Z/F
	 68LNfNjMsTebQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Subject:
 [PATCH v1 10/14] thermal: tegra: Use thermal_zone_for_each_trip() for walking
 trip points
Date: Mon, 17 Jun 2024 20:03:59 +0200
Message-ID: <13999070.RDIVbhacDa@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehthhhivghrrhihrdhrvgguihhnghesghhmrghilhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is generally inefficient to iterate over trip indices and call
thermal_zone_get_trip() every time to get the struct thermal_trip
corresponding to the given trip index, so modify the Tegra thermal
drivers to use thermal_zone_for_each_trip() for walking trips.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/tegra/soctherm.c        |   38 ++++++++++++++++----------------
 drivers/thermal/tegra/tegra30-tsensor.c |   25 ++++++++++-----------
 2 files changed, 33 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/thermal/tegra/soctherm.c
===================================================================
--- linux-pm.orig/drivers/thermal/tegra/soctherm.c
+++ linux-pm/drivers/thermal/tegra/soctherm.c
@@ -683,24 +683,25 @@ static const struct thermal_zone_device_
 	.set_trips = tegra_thermctl_set_trips,
 };
 
-static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
+static int get_hot_trip_cb(struct thermal_trip *trip, void *arg)
 {
-	int i, ret;
-	struct thermal_trip trip;
+	const struct thermal_trip **trip_ret = arg;
 
-	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
+	if (trip->type != THERMAL_TRIP_HOT)
+		return 0;
 
-		ret = thermal_zone_get_trip(tz, i, &trip);
-		if (ret)
-			return -EINVAL;
-
-		if (trip.type == THERMAL_TRIP_HOT) {
-			*trip_id = i;
-			return 0;
-		}
-	}
+	*trip_ret = trip;
+	/* Return nonzero to terminate the search. */
+	return 1;
+}
 
-	return -EINVAL;
+static const struct thermal_trip *get_hot_trip(struct thermal_zone_device *tz)
+{
+	const struct thermal_trip *trip = NULL;
+
+	thermal_zone_for_each_trip(tz, get_hot_trip_cb, &trip);
+
+	return trip;
 }
 
 /**
@@ -732,8 +733,9 @@ static int tegra_soctherm_set_hwtrips(st
 				      struct thermal_zone_device *tz)
 {
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	const struct thermal_trip *hot_trip;
 	struct soctherm_throt_cfg *stc;
-	int i, trip, temperature, ret;
+	int i, temperature, ret;
 
 	/* Get thermtrips. If missing, try to get critical trips. */
 	temperature = tsensor_group_thermtrip_get(ts, sg->id);
@@ -750,8 +752,8 @@ static int tegra_soctherm_set_hwtrips(st
 	dev_info(dev, "thermtrip: will shut down when %s reaches %d mC\n",
 		 sg->name, temperature);
 
-	ret = get_hot_temp(tz, &trip, &temperature);
-	if (ret) {
+	hot_trip = get_hot_trip(tz);
+	if (!hot_trip) {
 		dev_info(dev, "throttrip: %s: missing hot temperature\n",
 			 sg->name);
 		return 0;
@@ -764,7 +766,7 @@ static int tegra_soctherm_set_hwtrips(st
 			continue;
 
 		cdev = ts->throt_cfgs[i].cdev;
-		if (get_thermal_instance(tz, cdev, trip))
+		if (thermal_trip_is_bound_to_cdev(tz, hot_trip, cdev))
 			stc = find_throttle_cfg_by_name(ts, cdev->type);
 		else
 			continue;
Index: linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
===================================================================
--- linux-pm.orig/drivers/thermal/tegra/tegra30-tsensor.c
+++ linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
@@ -308,6 +308,18 @@ struct trip_temps {
 	int crit_trip;
 };
 
+static int tegra_tsensor_get_trips_cb(struct thermal_trip *trip, void *arg)
+{
+	struct trip_temps *temps = arg;
+
+	if (trip->type == THERMAL_TRIP_HOT)
+		temps->hot_trip = trip->temperature;
+	else if (trip->type == THERMAL_TRIP_CRITICAL)
+		temps->crit_trip = trip->temperature;
+
+	return 0;
+}
+
 static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
 					       struct trip_temps *temps)
 {
@@ -320,18 +332,7 @@ static void tegra_tsensor_get_hw_channel
 	temps->hot_trip  = 85000;
 	temps->crit_trip = 90000;
 
-	for (i = 0; i < thermal_zone_get_num_trips(tzd); i++) {
-
-		struct thermal_trip trip;
-
-		thermal_zone_get_trip(tzd, i, &trip);
-
-		if (trip.type == THERMAL_TRIP_HOT)
-			temps->hot_trip = trip.temperature;
-
-		if (trip.type == THERMAL_TRIP_CRITICAL)
-			temps->crit_trip = trip.temperature;
-	}
+	thermal_zone_for_each_trip(tzd, tegra_tsensor_get_trips_cb, temps);
 
 	/* clamp hardware trips to the calibration limits */
 	temps->hot_trip = clamp(temps->hot_trip, 25000, 90000);




