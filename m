Return-Path: <linux-pm+bounces-10190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE64291BE35
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 14:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1182B1F24F7E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFD51581F3;
	Fri, 28 Jun 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jJsZNUIZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A11E492;
	Fri, 28 Jun 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576614; cv=none; b=g6K6KGGCubusfea3HG1ts0e3OKnA6SdCq3ZY35bcETyjucJQZOnkqV0ZlUcUx4L9krWIfLCF9dP4u2civGeBzokbGHNRakTB4HpgQaNpCOJLvMEaL3zHhc46s/Cbom/2g6RxqnCoGuwLn1gPOetyMMW/EEjBakTKDEgGpKmfQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576614; c=relaxed/simple;
	bh=zMLRRZP9wfLE3lVdkubb3rFIBsBc+tdqcAt5bkXMZSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQf+d7fPNgSSnySeCS2zrMqmgey3Q2Q5sASOg0e/efAUbIPT2HGx0uVYKTh4mVGQHpRMRf3yBV5p6ws9Fuo6EyH4h5xufXDAshMUtuPqJcAIPUAWti9XtlBWRwfPa1FwBtK1/p5Q+poKc90czWgGem5HWnGZ+EEQOjKWfCqEM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jJsZNUIZ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5abed22abdc8bb9b; Fri, 28 Jun 2024 14:10:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AEB70933B0F;
	Fri, 28 Jun 2024 14:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719576604;
	bh=zMLRRZP9wfLE3lVdkubb3rFIBsBc+tdqcAt5bkXMZSs=;
	h=From:To:Cc:Subject:Date;
	b=jJsZNUIZQaDJOjWbtzIGBFIq587exLAu7kqo2/FvPNyaXnmqGHwOyBYC0ihb7C2kZ
	 5vYRBq402+8cPbYMxvEhcyh9lNLdgnMeUO5zsLMQYwOrI0o1Zspu+3daJG/lBkqPIC
	 TLkvelnTm2WLaJyJwqSdD5Yd0QKTvGBZZ8TUHN/jqNGDpxsOPH/YKAKSRJqDXbwxEX
	 EJ/qe9UXQRLPD9GMavcRxiYFw2HL4Jc0yGj6ta9qN9wuztYkMZiRdXOODlZ+Ajh+sX
	 cd8/faq8UEKIWUkeQBt/7apkp8V9SpQ8QMlnnNldzes6Rb3L0ayg2HdocMO+04uOEJ
	 0w7XVBaH+lZKg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2] thermal: core: Call monitor_thermal_zone() if zone temperature is
 invalid
Date: Fri, 28 Jun 2024 14:10:03 +0200
Message-ID: <2764814.mvXUDI8C0e@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeigdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepshhrihhnihhv
 rghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip()
if zone temperature is invalid") caused __thermal_zone_device_update()
to return early if the current thermal zone temperature was invalid.

This was done to avoid running handle_thermal_trip() and governor
callbacks in that case which led to confusion.  However, it went too
far because monitor_thermal_zone() still needs to be called even when
the zone temperature is invalid to ensure that it will be updated
eventually in case thermal polling is enabled and the driver has no
other means to notify the core of zone temperature changes (for example,
it does not register an interrupt handler or ACPI notifier).

Also if the .set_trips() zone callback is expected to set up monitoring
interrupts for a thermal zone, it has to be provided with valid
boundaries and that can only happen if the zone temperature is known.

Accordingly, to ensure that __thermal_zone_device_update() will
run again after a failing zone temperature check, make it call
monitor_thermal_zone() regardless of whether or not the zone
temperature is valid and make the latter schedule a thermal zone
temperature update if the zone temperature is invalid even if
polling is not enabled for the thermal zone.

Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    5 ++++-
 drivers/thermal/thermal_core.h |    6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -300,6 +300,8 @@ static void monitor_thermal_zone(struct
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
+	else if (tz->temperature == THERMAL_TEMP_INVALID)
+		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
 }
 
 static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
@@ -514,7 +516,7 @@ void __thermal_zone_device_update(struct
 	update_temperature(tz);
 
 	if (tz->temperature == THERMAL_TEMP_INVALID)
-		return;
+		goto monitor;
 
 	tz->notify_event = event;
 
@@ -536,6 +538,7 @@ void __thermal_zone_device_update(struct
 
 	thermal_debug_update_trip_stats(tz);
 
+monitor:
 	monitor_thermal_zone(tz);
 }
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -133,6 +133,12 @@ struct thermal_zone_device {
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
+/*
+ * Default delay after a failing thermal zone temperature check before
+ * attempting to check it again.
+ */
+#define THERMAL_RECHECK_DELAY_MS	100
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"




