Return-Path: <linux-pm+bounces-15173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51482990FF4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F2728258D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51691FCC6D;
	Fri,  4 Oct 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="v2dArrfn"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DC1E2610;
	Fri,  4 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070996; cv=none; b=pzt6TeZSCPsTwfaGTvnDe6OIcpWAS6QybZHmd4sBo8mEYYAgUD304riG4Nl+DRtat+CQcciwlamQQflPRXK9nL8YZsHaWKxGs75GcDD/S+8i/B8SH8DLr61g/TplrOga7tQqUdRYdG3ZDodDMmjSul18hbid5XUhR39gbflyGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070996; c=relaxed/simple;
	bh=aF/ZafH9fewvu7He3RpxJK2jI/zoWOyt4l+8tCp7+sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/zylLhq1h+kxjBIqLzRj2zDjNcbV9wq46/Moma8Cyy8ME99X2GadsEr+CU4851RGeFzHc2SsI/plf39vjIQHx2VRrPlPLd/cHDgPEmG2IhSAiYaxvZZhuMP2+KXVN1MPrx7sPvkF7taVmnkMPber0hr8Nb+kq3xSKLN39Y5V6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=v2dArrfn reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a25b5504b765ecac; Fri, 4 Oct 2024 21:43:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E776B6A9505;
	Fri,  4 Oct 2024 21:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070987;
	bh=aF/ZafH9fewvu7He3RpxJK2jI/zoWOyt4l+8tCp7+sw=;
	h=From:Subject:Date;
	b=v2dArrfnO2gbPKgCly97lCm8C5CMlFiCxbH0gq2aPr0vIOZUFSBH5g+7/DYDh2LO0
	 XEZZEZ4/klTd+fIDjQSRivGvfegrEhkruWe7+EuT2qfMsUs1nJjBjDkNfkwJN7ajRN
	 u5I1WnhjRCbbFWTVirHdc0e/MRaxping15JuKpiT3Gv13lVX3Anw/JsBOrz+CbD1Un
	 OiZkzzjcPxUDGoik0hJ+HDEQbzKLaa9H+Ob7rgyYyZCQtOCfSB6x1eVuILGPv8RNzc
	 5xPpa9bVXJiMOkmJ183YNrTGFWGBopYtJCZAOqf06OJ6eq4k1dfbFO4QbvjxHs5gLM
	 RfTPpjsTj2Kvw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 04/12] thermal: core: Mark thermal zones as initializing to start
 with
Date: Fri, 04 Oct 2024 21:15:04 +0200
Message-ID: <9360231.CDJkKcVGEf@rjwysocki.net>
In-Reply-To: <2215082.irdbgypaU6@rjwysocki.net>
References: <2215082.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdi
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

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

Fixes: 203d3d4aa482 ("the generic thermal sysfs driver")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/2973309.e9J7NaK4W3@rjwysocki.net/

v1 -> v2: Rebase and add a Fixes tag.

---
 drivers/thermal/thermal_core.c |   16 +++++++++++++---
 drivers/thermal/thermal_core.h |    1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1332,6 +1332,16 @@ int thermal_zone_get_crit_temp(struct th
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
+static void thermal_zone_init_complete(struct thermal_zone_device *tz)
+{
+	mutex_lock(&tz->lock);
+
+	tz->state &= ~TZ_STATE_FLAG_INIT;
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	mutex_unlock(&tz->lock);
+}
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
@@ -1451,6 +1461,8 @@ thermal_zone_device_register_with_trips(
 	tz->passive_delay_jiffies = msecs_to_jiffies(passive_delay);
 	tz->recheck_delay_jiffies = THERMAL_RECHECK_DELAY;
 
+	tz->state = TZ_STATE_FLAG_INIT;
+
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
 	result = thermal_zone_create_device_groups(tz);
@@ -1504,9 +1516,7 @@ thermal_zone_device_register_with_trips(
 
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
@@ -63,6 +63,7 @@ struct thermal_governor {
 
 #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
 #define	TZ_STATE_FLAG_RESUMING	BIT(1)
+#define	TZ_STATE_FLAG_INIT	BIT(2)
 
 #define TZ_STATE_READY		0
 




