Return-Path: <linux-pm+bounces-9359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16590B941
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D740B2817A8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF7C1991B3;
	Mon, 17 Jun 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="P1ARBilD"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846961990A5;
	Mon, 17 Jun 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647996; cv=none; b=KzYckvybjGdutMMzKG3ZUCBqqN63289EHLGNR9BuOmaIKPaGGUOukFTbilYfOhsDEAQUa54mtpjzXQP8+GHf0cOrWlRA4/2c3tdGz3Ao7PfEQkokEwMy9jg97jGPd6K70N0l7Z8LTIWNnS/BsdlhMVF/bLdkarO/rZt3bIQdZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647996; c=relaxed/simple;
	bh=RYYhW2+nrqyH+hbaaxSHlbPMZnBVYxxL8AyvgF3OTPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TziiNVo0fCl2IrcUfsfIGZq4rM+LStDhtNtg5OEOPYCmAR1tqEI3iZIdvlAlVH/8R4R3kiWY6tkNPGnsZ6q+XZBaCrSxeAJi+3CtgE2fVLVdFJxNjMwuW+t3mJoMIyTM/+3u0/XbjbYbhKXcA1qQMMl4nvQcB9sr9J6Tnydnm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=P1ARBilD; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3a1c6558c62eea31; Mon, 17 Jun 2024 20:13:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 353E116606FD;
	Mon, 17 Jun 2024 20:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647985;
	bh=RYYhW2+nrqyH+hbaaxSHlbPMZnBVYxxL8AyvgF3OTPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1ARBilDcKnCQMrY+luR4UOnz3bml9djGlLGolDfNptNc0ByjiU6YxP0glK2hYwso
	 3ABsYY4erRmNsqn9LNNdVojDW5eqFzjNsKqU15/z3Dcywd6UasVEKwzAsg6h+v0VV+
	 Z1vbE5ZTq4x6dgnszS2x6/9i/Zg6RpIjsUMObFZ8EFt+l1vFZb7JGN8ELXVE73lEpV
	 w9oCvdTfXJXRvzqRGf9pdSgybIFJcPl2TTqwiyomEFiu+lcwyrxRkl6nUAlaZBaZjU
	 KGx7V6WiZvzHxQ0zG0r4vtlp2TPiFkbrpevbQj6BlDsMImYGzswD+XRKNt9fWORWNj
	 Atk26kAtP77Rw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v1 13/14] thermal: trip: Replace thermal_zone_get_num_trips()
Date: Mon, 17 Jun 2024 20:11:30 +0200
Message-ID: <3312460.oiGErgHkdL@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only existing caller of thermal_zone_get_num_trips(), which is
rcar_gen3_thermal_probe(), uses this function to check whether or
not the number of trips in the given thermal zone is nonzero.

Because it really only needs to know whether or not the given
thermal zone is tripless, replace thermal_zone_get_num_trips() with
thermal_zone_is_tripless() that can tell rcar_gen3_thermal_probe()
exactly what it needs to know and make it call that function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c |    3 +--
 drivers/thermal/thermal_trip.c              |    6 +++---
 include/linux/thermal.h                     |    2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -563,8 +563,7 @@ static int rcar_gen3_thermal_probe(struc
 		if (ret)
 			goto error_unregister;
 
-		ret = thermal_zone_get_num_trips(tsc->zone);
-		if (ret < 0)
+		if (thermal_zone_is_tripless(tsc->zone))
 			goto error_unregister;
 
 		dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -55,11 +55,11 @@ int thermal_zone_for_each_trip(struct th
 }
 EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
 
-int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
+bool thermal_zone_is_tripless(struct thermal_zone_device *tz)
 {
-	return tz->num_trips;
+	return tz->num_trips == 0;
 }
-EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
+EXPORT_SYMBOL_GPL(thermal_zone_is_tripless);
 
 /**
  * thermal_zone_set_trips - Computes the next trip points for the driver
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -210,7 +210,7 @@ int for_each_thermal_trip(struct thermal
 int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
 			       int (*cb)(struct thermal_trip *, void *),
 			       void *data);
-int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
+bool thermal_zone_is_tripless(struct thermal_zone_device *tz);
 void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int temp);
 




