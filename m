Return-Path: <linux-pm+bounces-14276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0F2979051
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6D21F235B7
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406B61CEEB0;
	Sat, 14 Sep 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="JILsk8L7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE07A15A;
	Sat, 14 Sep 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312286; cv=none; b=SfmUPGAnM2/+Al2bVsDSpbfJzlHrybRYl9KFUwewOsMdPoYwk/avH5kDLkZfxcSsl6P0MwFyenQmnsE5lzxY7FrKtER8Cm8CTh29Ag3rQch5h86ndkh9RTmBRfUUvDXudsK673Mtk14azzKajh+p6BBQAwaMQQeYUmSK7yZ/p44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312286; c=relaxed/simple;
	bh=3Eqp5JGnLDAKSgWRuFCqtDwNpNy+yiRTaOr7QY81dJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6EgHCDJvjwOQHiisixThnGNLTRb80kCXZ9Ul9wGfNjpem1cRaTMDAP6F7EK52GgB2F/p/M3oij5bF8BnE3v2VChBTLYtc9oA/ozYFs91f6ZfLbwY86TqnbOYIgLmfJHx8SvHXmx4ta3lAw6Vwa3BZzhMPgUQdTYJAMNIRqVp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=JILsk8L7 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 549c2bad012402de; Sat, 14 Sep 2024 13:11:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B61D38532AE;
	Sat, 14 Sep 2024 13:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312282;
	bh=3Eqp5JGnLDAKSgWRuFCqtDwNpNy+yiRTaOr7QY81dJI=;
	h=From:Subject:Date;
	b=JILsk8L7jBsEwqBMFDZEPONCXvJZ7FvG9//aZ/raj37+Cd4k/Y6nRwQlT2X+umf5x
	 L7DRr3pwVIlDFBgUGShXGBNeQRNhsAE+bs7lkPMUD6UaqeTdQmI47O7UcbLc4TfY2h
	 CRcH475VbtYKMYADJqmF25g9QOrDJen2q0JAVNF9d+x2PdGRsFCfXBvi1UByz0RZIk
	 m1V1EfYzbmGMV3um6+Hct3EaG0Y6/9jYzMV3+8fSQrlhFZcIWnIVLa+mA8/5+O6Dcu
	 JpgxWEDSLSupFfz4T8ESUbNGe4HQOF3P8XdOYWheno6R0PGgIlofbeHngBmc1KuLAa
	 z0JiKAPdzlElw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 04/20] thermal: core: Mark thermal zones as
 initializing to start with
Date: Sat, 14 Sep 2024 12:30:27 +0200
Message-ID: <2973309.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <6100907.lOV4Wx5bFT@rjwysocki.net>
References: <6100907.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=40 Fuz1=40 Fuz2=40

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After thermal_zone_device_register_with_trips() has called
device_register() and it has registered the new thermal zone device
with the driver core, user space may access its sysfs attributes and,
among other things, it may enable the thermal zone before it is ready.

To address this, introduce a new thermal zone state flag for
initialization and set it before calling device_register() in
thermal_zone_device_register_with_trips().  This causes
__thermal_zone_device_update() to return early until the new flag
is cleared.

To clear it when the thermal zone is ready, introduce a new
function called thermal_zone_init_complete() that will also invoke
__thermal_zone_device_update() after clearing that flag (both under the
thernal zone lock) and make thermal_zone_device_register_with_trips()
call the new function instead of checking need_update and calling
thermal_zone_device_update() when it is set.

After this change, if user space enables the thermal zone prematurely,
__thermal_zone_device_update() will return early for it until
thermal_zone_init_complete() is called.  In turn, if the thermal zone
is not enabled by user space before thermal_zone_init_complete() is
called, the __thermal_zone_device_update() call in it will return early
because the thermal zone has not been enabled yet, but that function
will be invoked again by thermal_zone_device_set_mode() when the thermal
zone is enabled and it will not return early this time.

The checking of need_update is not necessary any more because the
__thermal_zone_device_update() calls potentially triggered by cooling
device binding take place before calling thermal_zone_init_complete(),
so they all will return early, which means that
thermal_zone_init_complete() must call __thermal_zone_device_update()
in case the thermal zone is enabled prematurely by user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   14 +++++++++++---
 drivers/thermal/thermal_core.h |    1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1318,6 +1318,14 @@ static void thermal_zone_add_to_list(str
 	list_add_tail(&tz->node, &thermal_tz_list);
 }
 
+static void thermal_zone_init_complete(struct thermal_zone_device *tz)
+{
+	guard(thermal_zone)(tz);
+
+	tz->state &= ~TZ_STATE_FLAG_INIT;
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1435,6 +1443,8 @@ thermal_zone_device_register_with_trips(
 	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
 	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
 
+	tz->state = TZ_STATE_FLAG_INIT;
+
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
@@ -1486,9 +1496,7 @@ thermal_zone_device_register_with_trips(
 
 	mutex_unlock(&thermal_list_lock);
 
-	/* Update the new thermal zone and mark it as already updated. */
-	if (atomic_cmpxchg(&tz->need_update, 1, 0))
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_init_complete(tz);
 
 	thermal_notify_tz_create(tz);
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -64,6 +64,7 @@ struct thermal_governor {
 
 #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
 #define	TZ_STATE_FLAG_RESUMING	BIT(1)
+#define	TZ_STATE_FLAG_INIT	BIT(2)
 
 #define TZ_STATE_READY		0
 




