Return-Path: <linux-pm+bounces-11758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF52D94328D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFAB276B8
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A71BC067;
	Wed, 31 Jul 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jcRQBvEQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A01BBBD5;
	Wed, 31 Jul 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722437964; cv=none; b=Cv9DCWF5YNfOxwkLmeZQykoiaeAELEFLj165qu0/ZrpDzVS1O6IIskojBBjdJZuKGZA+F+r3i681//xjYOyeOCZamUhPAjJTVqy8kLQjXY++l9xys5unctBkQhGZRw9tCUu7tt/IQJBs33tpbF23u7amLdqVOxEetbjDmuQD+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722437964; c=relaxed/simple;
	bh=E065Ck6GUBrsYWiWB7xcCSVZIrTf+Ha1iwGZYGyeWCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=raC7uyIlv9htMVRPZJvV+ikNha7bK6DMcaqhz0ZLLd0fj68IyaCkn/IeQJomM6rADkMxp2gTz3QS+QsrmwkKO2Wt4OFdXhmoL7GV3VMEBtYzywhZqHNYfIm/enfztfY1BKut9d6R460JMPyzfQoUQBFcq66jkKT60YvRsmSqfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jcRQBvEQ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 0fda7cedc9ad476f; Wed, 31 Jul 2024 16:59:16 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 19526955FDE;
	Wed, 31 Jul 2024 16:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722437956;
	bh=E065Ck6GUBrsYWiWB7xcCSVZIrTf+Ha1iwGZYGyeWCk=;
	h=From:To:Cc:Subject:Date;
	b=jcRQBvEQMr/ua0nd22hR79mB7pqZp9BDSp5UqmnEmirBrCDetoDY/+NiQkPwq10fK
	 yDrBcrosAtSkXKQYn0Klp1oZ6jYJ+NTpP0uHxp/W1bwyW7ZUIS+4vHqn4Yo2loW0+I
	 +WpMeT7r28/NPj3UsP6P/R0zrnsJ7I9cmXxdc4BfNCfZSBgKUezApxSSvHoBJYefJ5
	 Qq1pGTTF1BDrQiCge27JTPdMmpuDLwN4R24NBCgftaCLCTl8i4Nz9jCewaPP7yFCdq
	 ww2TxkOGmwcSwR2cPo6K5EQLbxI2JXhg4S+eA3L3c80zj/dAvub9AJOiCNuf8PdQkA
	 VjHI27ndJuEkA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject:
 [PATCH v1] thermal: core: Update thermal zone registration documentation
Date: Wed, 31 Jul 2024 16:59:15 +0200
Message-ID: <2767845.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidq
 ughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The thermal sysfs API document is outdated.  One of the problems with
it is that is still documents thermal_zone_device_register() which
does not exit any more and it does not reflect the current thermal
zone operations definition.

Replace the thermal_zone_device_register() description in it with
a thermal_zone_device_register_with_trips() description, including
an update of the thermal zone operations list.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/thermal/sysfs-api.rst |   65 +++++++++++--------------
 1 file changed, 30 insertions(+), 35 deletions(-)

Index: linux-pm/Documentation/driver-api/thermal/sysfs-api.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/thermal/sysfs-api.rst
+++ linux-pm/Documentation/driver-api/thermal/sysfs-api.rst
@@ -4,8 +4,6 @@ Generic Thermal Sysfs driver How To
 
 Written by Sujith Thomas <sujith.thomas@intel.com>, Zhang Rui <rui.zhang@intel.com>
 
-Updated: 2 January 2008
-
 Copyright (c)  2008 Intel Corporation
 
 
@@ -38,23 +36,23 @@ temperature) and throttle appropriate de
 
     ::
 
-	struct thermal_zone_device
-	*thermal_zone_device_register(char *type,
-				      int trips, int mask, void *devdata,
-				      struct thermal_zone_device_ops *ops,
-				      const struct thermal_zone_params *tzp,
-				      int passive_delay, int polling_delay))
+	struct thermal_zone_device *
+	thermal_zone_device_register_with_trips(const char *type,
+					const struct thermal_trip *trips,
+					int num_trips, void *devdata,
+					const struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp,
+					unsigned int passive_delay,
+					unsigned int polling_delay)
 
-    This interface function adds a new thermal zone device (sensor) to
+    This interface function adds a new thermal zone device (sensor) to the
     /sys/class/thermal folder as `thermal_zone[0-*]`. It tries to bind all the
-    thermal cooling devices registered at the same time.
+    thermal cooling devices registered to it at the same time.
 
     type:
 	the thermal zone type.
     trips:
-	the total number of trip points this thermal zone supports.
-    mask:
-	Bit string: If 'n'th bit is set, then trip point 'n' is writable.
+	the table of trip points for this thermal zone.
     devdata:
 	device private data
     ops:
@@ -67,32 +65,29 @@ temperature) and throttle appropriate de
 	.get_temp:
 		get the current temperature of the thermal zone.
 	.set_trips:
-		    set the trip points window. Whenever the current temperature
-		    is updated, the trip points immediately below and above the
-		    current temperature are found.
-	.get_mode:
-		   get the current mode (enabled/disabled) of the thermal zone.
-
-			- "enabled" means the kernel thermal management is
-			  enabled.
-			- "disabled" will prevent kernel thermal driver action
-			  upon trip points so that user applications can take
-			  charge of thermal management.
-	.set_mode:
-		set the mode (enabled/disabled) of the thermal zone.
-	.get_trip_type:
-		get the type of certain trip point.
-	.get_trip_temp:
-			get the temperature above which the certain trip point
-			will be fired.
+		set the trip points window. Whenever the current temperature
+		is updated, the trip points immediately below and above the
+		current temperature are found.
+	.change_mode:
+		change the mode (enabled/disabled) of the thermal zone.
+	.set_trip_temp:
+		set the temperature of a given trip point.
+	.get_crit_temp:
+		get the critical temperature for this thermal zone.
 	.set_emul_temp:
-			set the emulation temperature which helps in debugging
-			different threshold temperature points.
+		set the emulation temperature which helps in debugging
+		different threshold temperature points.
+	.get_trend:
+		get the trend of most recent zone temperature changes.
+	.hot:
+		hot trip point crossing handler.
+	.critical:
+		critical trip point crossing handler.
     tzp:
 	thermal zone platform parameters.
     passive_delay:
-	number of milliseconds to wait between polls when
-	performing passive cooling.
+	number of milliseconds to wait between polls when performing passive
+	cooling.
     polling_delay:
 	number of milliseconds to wait between polls when checking
 	whether trip points have been crossed (0 for interrupt driven systems).




