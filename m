Return-Path: <linux-pm+bounces-11564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60893FC17
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3ECFB22288
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1715FA68;
	Mon, 29 Jul 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="h1UjAmEq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABB8364A0;
	Mon, 29 Jul 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273179; cv=none; b=TGwAjdQWoL5xCl7YXKlsjXspnMKkCWGNlAdcAWm4AaF7vNNGVg/9PYlTHkv4R9jc/xD07igIGNqo9voNSaZqZZbJU32CTHcSG/lKcoOWYDm3v0FG+61BlGo63CwsIawk2nV75k4VtEERpAYd5oqz8LHrQH+fz33ojL8N5un7Rgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273179; c=relaxed/simple;
	bh=HSM4wemtW/CBDc9NeJfBdEcNrjVAUfZQS/Pr3GUvxyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4EFjFpJ6jRL8Co3PtdKfkRb7zY8lVgnq5YcHPPYxH5dhFuyXJpfKGDaIRpLgmQsBJGcEkbyU2/EhTUvC+LzCsLoDpLUiXDve6Mt/oubHILB8TJW+JfhZA2SaQ/8L2AxbyeyncVsUyQd7iIOoN0zR1tU4qqdmkRMYo1KRnSX/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=h1UjAmEq; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 64f424f174ddc5af; Mon, 29 Jul 2024 18:12:55 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1952477357F;
	Mon, 29 Jul 2024 18:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269575;
	bh=HSM4wemtW/CBDc9NeJfBdEcNrjVAUfZQS/Pr3GUvxyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h1UjAmEqxPkX7EgJ77f2852BA6EqK0aJ52LjqDKN9NtcyMu8JYhF4JFo8xgu4bQO2
	 0efSZEYPlHIY08vHXbl9trh4LLAORJx7LdwmJzgOSNmHrxgrVW8HMiWk6dXjldDfTw
	 u69Qryh4ptd1UimSpzelMKEuAWQ7snTJWf1q7f6gOu8mTHFWUnLEDSNw9OzH0r6nkE
	 qFZMn1s6l4/hPDOZmRAR0JruShxBTIL7RTMW0kP/j7CS+SWYVMET+GQH+p8Ad22nw+
	 y51qNCL/YfZspmyux+gft12cBrm/C23ms/38soKH+xh7+RyzGF0435wwHKldFpvkh/
	 waE67bYxr+DEw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 7/8] thermal: trip: Get rid of thermal_zone_get_num_trips()
Date: Mon, 29 Jul 2024 18:11:29 +0200
Message-ID: <2636988.Lt9SDvczpP@rjwysocki.net>
In-Reply-To: <2211925.irdbgypaU6@rjwysocki.net>
References: <2211925.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrges
 rghrmhdrtghomhdprhgtphhtthhopehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhrtghpthhtoheplhhinhhugidqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only existing caller of thermal_zone_get_num_trips(), which is
rcar_gen3_thermal_probe(), uses this function to put the number of
trip points into a kernel log message, but this information is also
available from the thermal sysfs interface.

For this reason, remove the thermal_zone_get_num_trips() call from
rcar_gen3_thermal_probe() and drop the former altogether.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

A new version, based on the discussion following the v1:

https://lore.kernel.org/linux-pm/20240617183949.GO382677@ragnatech.se/

The Renesas driver change does not depend on the previous patches
in the series.

---
 drivers/thermal/renesas/rcar_gen3_thermal.c |    6 +-----
 drivers/thermal/thermal_trip.c              |    6 ------
 include/linux/thermal.h                     |    1 -
 3 files changed, 1 insertion(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ linux-pm/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -563,11 +563,7 @@ static int rcar_gen3_thermal_probe(struc
 		if (ret)
 			goto error_unregister;
 
-		ret = thermal_zone_get_num_trips(tsc->zone);
-		if (ret < 0)
-			goto error_unregister;
-
-		dev_info(dev, "Sensor %u: Loaded %d trip points\n", i, ret);
+		dev_info(dev, "Sensor %u: Loaded\n", i);
 	}
 
 	if (!priv->num_tscs) {
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -55,12 +55,6 @@ int thermal_zone_for_each_trip(struct th
 }
 EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
 
-int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
-{
-	return tz->num_trips;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
-
 /**
  * thermal_zone_set_trips - Computes the next trip points for the driver
  * @tz: a pointer to a thermal zone device structure
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -210,7 +210,6 @@ int for_each_thermal_trip(struct thermal
 int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
 			       int (*cb)(struct thermal_trip *, void *),
 			       void *data);
-int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int temp);
 




