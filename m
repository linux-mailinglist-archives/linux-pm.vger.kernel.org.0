Return-Path: <linux-pm+bounces-15166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171309910C6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D131B2844F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569A1E2604;
	Fri,  4 Oct 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="emSxUHkO"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F01E049A;
	Fri,  4 Oct 2024 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070994; cv=none; b=rLS83BXy0xwXXFvxxJuh5/HsSi9F2Uz26zBhX/XdZpVszXIoH33EzJUaW+h7LJlfkZPamJzZAppwTiLCGVWNMBUygULGSZZXgzUCwrN30ke2Uvphjccda8fxlkBZD5w+E6D6B+URt6jGiL3LYz/OSgYGOFCK+F7czYHxaBCHGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070994; c=relaxed/simple;
	bh=8ITfIM6Ec9kdNrhJlk2YKl1wKqmsQ5rBxLCWpRIt5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqOsJLt1q1axLTyGpF7WUqyzYop+0E97Wmkyj1x60bosSGtg8S2xVx6+LFbvmuyVn003EHRHG6eqbpjPBS8h/WQxU8U1XZ6I7r0rpR1zVL0BcoAXtmvZCv40ax+/TZ63MSYb5sLZOZZvMr++PnREopUKK1U38/dMeNCoksj8Lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=emSxUHkO reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3f5ef314220bde20; Fri, 4 Oct 2024 21:43:07 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9500A6A9505;
	Fri,  4 Oct 2024 21:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070987;
	bh=8ITfIM6Ec9kdNrhJlk2YKl1wKqmsQ5rBxLCWpRIt5Cg=;
	h=From:Subject:Date;
	b=emSxUHkOYVT3uGd3hrbElDd80xCPBkIFrmW177CPtF7zASBRnG+3zjexTapO4RhCT
	 t3IrwkxHESDgQ6WzTtGPy8Sd+LAWyQVXLubpIo9qqLljIkS6R4ixhQ0NlmZOOIk1GL
	 v9/5bgHRHme+tZC7eoO8T8SldE5Z0bTMhaiql7WnKoEOgnWfRbTPZ5J22sPEZnSfrW
	 G5UAlv+InZnw5XGHHNWHouKW2Y4/VlRF96PL9303uzsitocmgwF4p8Zt1Kw6/L7eCG
	 3lgujA3DPu9wFxMkInLNMbMNEbQldFuhk+ogqjxck53Q2bymr3a9+YIOc09sFdqHRv
	 NL3Cp6YbR/iGQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 03/12] thermal: core: Represent suspend-related thermal zone flags
 as bits
Date: Fri, 04 Oct 2024 21:11:53 +0200
Message-ID: <7733910.EvYhyI6sBW@rjwysocki.net>
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

Instead of using two separate fields in struct thermal_zone_device for
representing flags related to thermal zone suspend, represent them
explicitly as bits in one u8 "state" field.

Subsequently, that field will be used for addressing race conditions
related to thermal zone initialization and exit.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/2215885.irdbgypaU6@rjwysocki.net/

v1 -> v2: The thermal zone guard has not been introduced yet, so adjust for that.

---
 drivers/thermal/thermal_core.c |   11 +++++------
 drivers/thermal/thermal_core.h |   11 +++++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -547,7 +547,7 @@ void __thermal_zone_device_update(struct
 	int low = -INT_MAX, high = INT_MAX;
 	int temp, ret;
 
-	if (tz->suspended || tz->mode != THERMAL_DEVICE_ENABLED)
+	if (tz->state != TZ_STATE_READY || tz->mode != THERMAL_DEVICE_ENABLED)
 		return;
 
 	ret = __thermal_zone_get_temp(tz, &temp);
@@ -1662,7 +1662,7 @@ static void thermal_zone_device_resume(s
 
 	mutex_lock(&tz->lock);
 
-	tz->suspended = false;
+	tz->state &= ~(TZ_STATE_FLAG_SUSPENDED | TZ_STATE_FLAG_RESUMING);
 
 	thermal_debug_tz_resume(tz);
 	thermal_zone_device_init(tz);
@@ -1670,7 +1670,6 @@ static void thermal_zone_device_resume(s
 	__thermal_zone_device_update(tz, THERMAL_TZ_RESUME);
 
 	complete(&tz->resume);
-	tz->resuming = false;
 
 	mutex_unlock(&tz->lock);
 }
@@ -1679,7 +1678,7 @@ static void thermal_zone_pm_prepare(stru
 {
 	mutex_lock(&tz->lock);
 
-	if (tz->resuming) {
+	if (tz->state & TZ_STATE_FLAG_RESUMING) {
 		/*
 		 * thermal_zone_device_resume() queued up for this zone has not
 		 * acquired the lock yet, so release it to let the function run
@@ -1692,7 +1691,7 @@ static void thermal_zone_pm_prepare(stru
 		mutex_lock(&tz->lock);
 	}
 
-	tz->suspended = true;
+	tz->state |= TZ_STATE_FLAG_SUSPENDED;
 
 	mutex_unlock(&tz->lock);
 }
@@ -1704,7 +1703,7 @@ static void thermal_zone_pm_complete(str
 	cancel_delayed_work(&tz->poll_queue);
 
 	reinit_completion(&tz->resume);
-	tz->resuming = true;
+	tz->state |= TZ_STATE_FLAG_RESUMING;
 
 	/*
 	 * Replace the work function with the resume one, which will restore the
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -61,6 +61,11 @@ struct thermal_governor {
 	struct list_head	governor_list;
 };
 
+#define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
+#define	TZ_STATE_FLAG_RESUMING	BIT(1)
+
+#define TZ_STATE_READY		0
+
 /**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
@@ -100,8 +105,7 @@ struct thermal_governor {
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
- * @suspended: thermal zone suspend indicator
- * @resuming:	indicates whether or not thermal zone resume is in progress
+ * @state: 	current state of the thermal zone
  * @trips:	array of struct thermal_trip objects
  */
 struct thermal_zone_device {
@@ -134,8 +138,7 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
-	bool suspended;
-	bool resuming;
+	u8 state;
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif




