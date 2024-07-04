Return-Path: <linux-pm+bounces-10600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0792756B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90531F22098
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807621AB514;
	Thu,  4 Jul 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="OVwS3+J+"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650A15B54F;
	Thu,  4 Jul 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093598; cv=none; b=ieqwQN42vXBI5z/8Bqi6/3A9zes+VhooTgyvBXCUFG0Py9f9Jac8L9alep0omt1/XiRLVEFhlWlGoTRBnAIUUGEFKt8nXiC6Dit5g86K5bHc8QKcIFhwsoUOkzmXpRntNefwpVlIRL6qbHrzy5df81o5gDco/AZxpOQ89jFX2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093598; c=relaxed/simple;
	bh=Dkc9e4ulA+RsHD4AJ3485vUQCI71iUJJHsbJBqCdWPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F1c+1S2qyrmjyAjgW3Sgaq96qxrbbeaoCBYFkdT4AHkwD+FpvzDfftK7iYpdTRrGYRcRKncP475AKQYtrbt2GJfT6WmdLmG+qdDLaK/xwpD8t76lu9YlJCwEXa6kBlX+I9mTGRIOnjjLyhFdh4o3Y31uOQlSBc4Z9QjL8h3MMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=OVwS3+J+ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ef6c16801bd96395; Thu, 4 Jul 2024 13:46:27 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7D5AEA229B3;
	Thu,  4 Jul 2024 13:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720093587;
	bh=Dkc9e4ulA+RsHD4AJ3485vUQCI71iUJJHsbJBqCdWPM=;
	h=From:To:Cc:Subject:Date;
	b=OVwS3+J+9mFelrPnZOCtEaH9jH0gSv5TvMW9JbAmZP4eemzi5MXw255+UugN/Zeut
	 PEKWM6pVG2Ehfln8g1z0XtVCN/Pk3aPZcUSId9Aojy7Zm7bmJDrAomLKRHNh3Rdr/T
	 xKacTnt3BrrbRr3+pC7+OdPTCceR1wilejA1v23tyFU1QFt8ZqllP5ZnVa1Ftrz83N
	 2qZy7h3vMQtzN4AtEzQLUaWkWfup79x49hkJ9ZfZdd3NQI5i1w33M0R1mEkj2uy474
	 b5G956Fj5TNxhLpzTp/VokRp7TxJeRPVWgul/8xlx16uf/jEzv7oZXm3tf+/2BBWzB
	 hRKRlY7VTtLEQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject:
 [PATCH v3] thermal: core: Call monitor_thermal_zone() if zone temperature is
 invalid
Date: Thu, 04 Jul 2024 13:46:26 +0200
Message-ID: <6064157.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudelgdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghr
 mhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

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
interrupts for a thermal zone, it needs to be provided with valid
boundaries and that can only be done if the zone temperature is known.

Accordingly, to ensure that __thermal_zone_device_update() will
run again after a failing zone temperature check, make it call
monitor_thermal_zone() regardless of whether or not the zone
temperature is valid and make the latter schedule a thermal zone
temperature update if the zone temperature is invalid even if
polling is not enabled for the thermal zone (however, if this
continues to fail, give up after some time).

Fixes: 202aa0d4bb53 ("thermal: core: Do not call handle_thermal_trip() if zone temperature is invalid")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/linux-pm/dc1e6cba-352b-4c78-93b5-94dd033fca16@linaro.org
Link: https://lore.kernel.org/linux-pm/2764814.mvXUDI8C0e@rjwysocki.net
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   13 ++++++++++++-
 drivers/thermal/thermal_core.h |    9 +++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -300,6 +300,14 @@ static void monitor_thermal_zone(struct
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
+	else if (tz->temperature == THERMAL_TEMP_INVALID &&
+		 tz->recheck_delay_jiffies <= THERMAL_MAX_RECHECK_DELAY) {
+		thermal_zone_device_set_polling(tz, tz->recheck_delay_jiffies);
+		/* Double the recheck delay for the next attempt. */
+		tz->recheck_delay_jiffies += tz->recheck_delay_jiffies;
+		if (tz->recheck_delay_jiffies > THERMAL_MAX_RECHECK_DELAY)
+			dev_info(&tz->device, "Temperature unknown, giving up\n");
+	}
 }
 
 static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
@@ -430,6 +438,7 @@ static void update_temperature(struct th
 
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
+	tz->recheck_delay_jiffies = 1;
 
 	trace_thermal_temperature(tz);
 
@@ -514,7 +523,7 @@ void __thermal_zone_device_update(struct
 	update_temperature(tz);
 
 	if (tz->temperature == THERMAL_TEMP_INVALID)
-		return;
+		goto monitor;
 
 	tz->notify_event = event;
 
@@ -536,6 +545,7 @@ void __thermal_zone_device_update(struct
 
 	thermal_debug_update_trip_stats(tz);
 
+monitor:
 	monitor_thermal_zone(tz);
 }
 
@@ -1438,6 +1448,7 @@ thermal_zone_device_register_with_trips(
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+	tz->recheck_delay_jiffies = 1;
 
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -67,6 +67,8 @@ struct thermal_governor {
  * @polling_delay_jiffies: number of jiffies to wait between polls when
  *			checking whether trip points have been crossed (0 for
  *			interrupt driven systems)
+ * @recheck_delay_jiffies: delay after a failed thermal zone temperature check
+ * 			before attempting to check it again
  * @temperature:	current temperature.  This is only for core code,
  *			drivers should use thermal_zone_get_temp() to get the
  *			current temperature
@@ -108,6 +110,7 @@ struct thermal_zone_device {
 	int num_trips;
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
+	unsigned long recheck_delay_jiffies;
 	int temperature;
 	int last_temperature;
 	int emul_temperature;
@@ -133,6 +136,12 @@ struct thermal_zone_device {
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
+/*
+ * Maximum delay after a failing thermal zone temperature check before
+ * attempting to check it again (in jiffies).
+ */
+#define THERMAL_MAX_RECHECK_DELAY	(30 * HZ)
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"




