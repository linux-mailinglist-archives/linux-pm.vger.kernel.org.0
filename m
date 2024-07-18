Return-Path: <linux-pm+bounces-11230-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1139351F9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 21:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03F5B20C36
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384076F31E;
	Thu, 18 Jul 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qr6c0cCW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01543172;
	Thu, 18 Jul 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329321; cv=none; b=jt42LlvqBQmipX9AS6kojnvpF/YvoKikZpDH5rojRWn34ub64ADpcxv4VjaQ5F+hhRbwA6a/FOEBF4zy9oc/48SyItrmnSFRJv9YqCZ890Tx944XzS1G8x0Z0+nth1YnBmnVtBlXDGqAwQ0q58iD0OTA6Bg6vKpp0lKu//SIu7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329321; c=relaxed/simple;
	bh=t6HcISbdSbHpio86k8aNG8KbThgtbfQ5kG1Z71eD0WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBf0kyLtBdXXbpJC/hTIr/5ahsu2xlYV4Su6GBLmxO8lL+breG0EEUS6IWf5C4HREUzMFxcjfdJ24xnADg4r1WJnyuB79XxkjCOFa6vBAx+RB6jakwrUhTVb4y/G1tve9eEftyTN12xYLrJomhkgJogQBwMZPovvo4YpKLw9/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qr6c0cCW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 38b1ba7d8f8bf3ab; Thu, 18 Jul 2024 21:01:56 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 76E696A1D1C;
	Thu, 18 Jul 2024 21:01:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1721329316;
	bh=t6HcISbdSbHpio86k8aNG8KbThgtbfQ5kG1Z71eD0WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qr6c0cCWCjJTd3lrIwewitqQXBopPKR4LSQFTI3eZcZF3PrIXEDav/pJCYwV7p1Ip
	 lXVK6lzFZFwC20wzN6b3wfDGnjTyhVQIXgudvIyhc9TAAxv9zUOniZqN8t1vLqhjUi
	 QV9R9Suj8/Phr0fBadPOaVX9MlEoq2DhGF0mS5+DG8UDSahoZtzik8INXdaX9Xa5X4
	 tiP1QwGnXrdqOx6QGI65n5u72VFFtXTz3C6fClS8MM19m1fWdy1I2+1M1nsq1fXtKT
	 IRwXkn+a3k7IKlN6S5ze4uKeZMXufqFMdwB1tdZsqfW5LAuWD3Ks5NAQ/w0k+zCIYx
	 rguHu2KRkvlXw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject:
 [PATCH v1 2/2] thermal: core: Back off when polling thermal zones on errors
Date: Thu, 18 Jul 2024 21:01:14 +0200
Message-ID: <2962033.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <2348857.ElGaqSPkdT@rjwysocki.net>
References: <2348857.ElGaqSPkdT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrgeelgddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehnvghi
 lhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit a8a261774466 ("thermal: core: Call monitor_thermal_zone() if zone
temperature is invalid") introduced a polling mechanism by which the
thermal core attampts to get a valid temperature value for thermal zones
where the .get_temp() callback returns errors to start with (for
example, due to initialization ordering woes).  However, this polling is
carried out periodically ad infinitum and every iteration of it causes
a message to be printed to the kernel log which means a lot of log noise
on systems where there are thermal zones that never get ready for some
reason.  It is also not really useful to continuously poll thermal zones
that never respond.

To address this, modify the thermal core to increase the delay between
consecutive thermal zone temperature checks after every check that fails
until it reaches a certain maximum value.  At that point, the thermal
zone in question will be disabled, but user space will be able to
reenable it if it believes that the failure is transient.

Also change the code to print messages regarding failed temperature
checks to the kernel log only twice, once when the thermal zone's
.get_temp() callback returns an error for the first time and once when
disabling the given thermal zone.  In addition, a dev_crit() message
will be printed at that point if the given thermal zone contains a
critical trip point to notify the system operator about the situation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   58 ++++++++++++++++++++++++++++++++++++++---
 drivers/thermal/thermal_core.h |   10 ++++---
 2 files changed, 61 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -288,6 +288,28 @@ static int __thermal_zone_device_set_mod
 	return 0;
 }
 
+static void thermal_zone_broken_disable(struct thermal_zone_device *tz)
+{
+	struct thermal_trip_desc *td;
+
+	dev_err(&tz->device, "Unable to get temperature, disabling!\n");
+	/*
+	 * This function only runs for enabled thermal zones, so no need to
+	 * check for the current mode.
+	 */
+	__thermal_zone_device_set_mode(tz, THERMAL_DEVICE_DISABLED);
+	thermal_notify_tz_disable(tz);
+
+	for_each_trip_desc(tz, td) {
+		if (td->trip.type == THERMAL_TRIP_CRITICAL &&
+		    td->trip.temperature > THERMAL_TEMP_INVALID) {
+			dev_crit(&tz->device,
+				 "Disabled thermal zone with critical trip point\n");
+			return;
+		}
+	}
+}
+
 /*
  * Zone update section: main control loop applied to each zone while monitoring
  * in polling mode. The monitoring is done using a workqueue.
@@ -308,6 +330,34 @@ static void thermal_zone_device_set_poll
 		cancel_delayed_work(&tz->poll_queue);
 }
 
+static void thermal_zone_recheck(struct thermal_zone_device *tz, int error)
+{
+	if (error == -EAGAIN) {
+		thermal_zone_device_set_polling(tz, THERMAL_RECHECK_DELAY);
+		return;
+	}
+
+	/*
+	 * Print the message once to reduce log noise.  It will be followed by
+	 * another one if the temperature cannot be determined after multiple
+	 * attempts.
+	 */
+	if (tz->recheck_delay_jiffies == THERMAL_RECHECK_DELAY)
+		dev_info(&tz->device, "Temperature check failed (%d)\n", error);
+
+	thermal_zone_device_set_polling(tz, tz->recheck_delay_jiffies);
+
+	tz->recheck_delay_jiffies += max(tz->recheck_delay_jiffies >> 1, 1ULL);
+	if (tz->recheck_delay_jiffies > THERMAL_MAX_RECHECK_DELAY) {
+		thermal_zone_broken_disable(tz);
+		/*
+		 * Restore the original recheck delay value to allow the thermal
+		 * zone to try to recover when it is reenabled by user space.
+		 */
+		tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
+	}
+}
+
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
 {
 	if (tz->mode != THERMAL_DEVICE_ENABLED)
@@ -507,10 +557,7 @@ void __thermal_zone_device_update(struct
 
 	ret = __thermal_zone_get_temp(tz, &temp);
 	if (ret) {
-		if (ret != -EAGAIN)
-			dev_info(&tz->device, "Temperature check failed (%d)\n", ret);
-
-		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
+		thermal_zone_recheck(tz, ret);
 		return;
 	} else if (temp <= THERMAL_TEMP_INVALID) {
 		/*
@@ -522,6 +569,8 @@ void __thermal_zone_device_update(struct
 		goto monitor;
 	}
 
+	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
+
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
 
@@ -1462,6 +1511,7 @@ thermal_zone_device_register_with_trips(
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
 
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
+ * @recheck_delay_jiffies: delay after a failed attempt to determine the zone
+ * 			temperature before trying again
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
@@ -137,10 +140,11 @@ struct thermal_zone_device {
 #define THERMAL_TEMP_INIT	INT_MIN
 
 /*
- * Default delay after a failing thermal zone temperature check before
- * attempting to check it again.
+ * Default and maximum delay after a failed thermal zone temperature check
+ * before attempting to check it again (in jiffies).
  */
-#define THERMAL_RECHECK_DELAY_MS	250
+#define THERMAL_RECHECK_DELAY		msecs_to_jiffies(250)
+#define THERMAL_MAX_RECHECK_DELAY	(120 * HZ)
 
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)




