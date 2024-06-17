Return-Path: <linux-pm+bounces-9369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E62190B958
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820F31F217DD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376EE19AA75;
	Mon, 17 Jun 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="m/c7VQbS"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB88199255;
	Mon, 17 Jun 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648000; cv=none; b=QluGghzfV/JWdhZVvfQicgmbuAHIsuyzmsyd9hn6FTYYrkcBkZRNrYv8eFhrhhs6aq8XE44QGQSJMqy/b8rpZlfM/6MWEq++lQkbHcrQuVojrSpVG6jDRJbsWeRbcCJmrMLn4b/Nq5Mr9Gc8+mmgxIMKVA45AuK8/clP/M1ABhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648000; c=relaxed/simple;
	bh=1Ns3A/oFMcDFR+MHREDV9DRSTxw55uaCpacsS/xEzMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEMbB7T9kwfUFBUCfqnHigyuzejQfvBjZlF9ZqzwJe+5J8HibCIsPUFN5lABGF/W4YnkacRHjotoJ+JDhXAfXSBtti72qq5aNV+59OSetTEc5Yyvx5kkfzKIEf+qjzp0lM6C/wpYj8Ec8G7wMJim6i86cvUynL4HdZ5Yf2FFv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=m/c7VQbS reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 82daa9038d1cb02e; Mon, 17 Jun 2024 20:13:10 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EFB0A16606FD;
	Mon, 17 Jun 2024 20:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647990;
	bh=1Ns3A/oFMcDFR+MHREDV9DRSTxw55uaCpacsS/xEzMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/c7VQbS6N1LSnN0Pz5a94onEN7z8d573yrT8UygktNWbkvREF+zab0iySwUOXE7w
	 YbYS3EyP0etUL9rZTehc9GBrlCBbS1sxiBzmgfRzw6kNGPYkyMSkkDUz2Bvkjswu9N
	 c1H3aOwVcTGtFSZZY/2R18o06m4RfU2j2CSVuEC9TyTO9DpOYphALGr5t7nGZqkgSH
	 r4I/MK9qamavkKypoZj3/IPThVOS7h2skl4Zj5KKE1rXGOw8EccRwSOC8mHForUxJM
	 GhV7KwdlEralYc9gwJNGac7dRZY1DIEiE8iwDNVlY7Ioe+D2NQ61f9dvAZeBXh9gAd
	 se3NoUUG8XUFA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 07/14] thermal: hisi: Use thermal_zone_for_each_trip() in
 hisi_thermal_register_sensor()
Date: Mon, 17 Jun 2024 19:58:41 +0200
Message-ID: <1837335.TLkxdtWsSY@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify hisi_thermal_register_sensor() to use thermal_zone_for_each_trip()
for walking trip points instead of iterating over trip indices and using
thermal_zone_get_trip() to get from a trip index to struct thermal_trip.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/hisi_thermal.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/hisi_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/hisi_thermal.c
+++ linux-pm/drivers/thermal/hisi_thermal.c
@@ -470,6 +470,18 @@ static irqreturn_t hisi_thermal_alarm_ir
 	return IRQ_HANDLED;
 }
 
+static int hisi_trip_walk_cb(struct thermal_trip *trip, void *arg)
+{
+	struct hisi_thermal_sensor *sensor = arg;
+
+	if (trip->type != THERMAL_TRIP_PASSIVE)
+		return 0;
+
+	sensor->thres_temp = trip->temperature;
+	/* Return nonzero to terminate the search. */
+	return 1;
+}
+
 static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
@@ -487,15 +499,7 @@ static int hisi_thermal_register_sensor(
 		return ret;
 	}
 
-	for (i = 0; i < thermal_zone_get_num_trips(sensor->tzd); i++) {
-
-		thermal_zone_get_trip(sensor->tzd, i, &trip);
-
-		if (trip.type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = trip.temperature;
-			break;
-		}
-	}
+	thermal_zone_for_each_trip(sensor->tzd, hisi_trip_walk_cb, sensor);
 
 	return 0;
 }




