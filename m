Return-Path: <linux-pm+bounces-15172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16156990FF3
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2916282D7F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C21FB3D5;
	Fri,  4 Oct 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ilmKNxCo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C701E25EF;
	Fri,  4 Oct 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070996; cv=none; b=aCuAo8SMN1KLlOTBqwx7YYj3+AHzhQgnairQKTE1gTPmdk1qZ5BW/EYP5ssF4xVxlIFq7R0kk2ajTkFbAJm0y5cjghUc4iJOSmk6xb6vnHkHoBAqPizv3FnY93MOghMLGM/Ga9/Js9ml/Zep6C7vAwZse83TEXDNspRqYG3Slyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070996; c=relaxed/simple;
	bh=140pHCdKnsVyPWmjFYFklYH1T5pXhEHTWMhrqpvI+eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMUw6WPKJLW8SmUatdYJRKC3fcX89JKuIkIwj0Zl9lb9YC48/RaiDwwUXMaIlrCcNxF8Vb3e2cKjaBzJsS4Z2r97WbVpuYbEbMzEdS2RiKSmy8DGZtWcUej8NURInVdJXyxTzG7bmHPGExBWCkrTsohQ7P8HX5fuZchHLl4sICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ilmKNxCo reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 0224cdf6660a5cb0; Fri, 4 Oct 2024 21:43:06 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 692386A9505;
	Fri,  4 Oct 2024 21:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070986;
	bh=140pHCdKnsVyPWmjFYFklYH1T5pXhEHTWMhrqpvI+eI=;
	h=From:Subject:Date;
	b=ilmKNxCoYvMLKDS/WXxrAOSe+LE1iYqM9nFABakaxE5QRrHKXBgLtLc0dpZRmVgpz
	 kkyc5IMfJl2iHVty620iwTsg2ovzb8k1Nwl5yJqzdHzytntmkDuvZb5etxSH8gB8x3
	 gQsWKOwGKHe+IhkQlr9I2pgdZFX9s0vMRbhXUjkXsJx7+yDDKY6ERrbCzP28Wrkcit
	 FweMlK6ytSsdKTbhPYWipc2iAJrSV62APGEfT26Xd3sWyxTyxbX9rivPTdHkldW8WS
	 VJtf0w46wAAztV6OBBi2EVKw2OYF840VnKopxp5yxyVt4QaoqOdoUrYB6WCfH6lJkU
	 3lEyL9AO60fcA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 05/12] thermal: core: Fix race between zone registration and system
 suspend
Date: Fri, 04 Oct 2024 21:19:21 +0200
Message-ID: <8490245.NyiUUSuA9g@rjwysocki.net>
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

If the registration of a thermal zone takes place at the time when
system suspend is started, thermal_pm_notify() can run before the new
thermal zone is added to thermal_tz_list and its "suspended" flag will
not be set.  Consequently, if __thermal_zone_device_update() is called
for that thermal zone, it will not return early as expected which may
cause some destructive interference with the system suspend or resume
flow to occur.

To avoid that, make thermal_zone_init_complete() introduced previously
set the "suspended" flag for new thermal zones if it runs during system
suspend or resume.

Fixes: 4e814173a8c4 ("thermal: core: Fix thermal zone suspend-resume synchronization")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/3335807.44csPzL39Z@rjwysocki.net/

v1 -> v2: Rebase and add a fixes tag.

---
 drivers/thermal/thermal_core.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -40,6 +40,8 @@ static DEFINE_MUTEX(thermal_governor_loc
 
 static struct thermal_governor *def_governor;
 
+static bool thermal_pm_suspended;
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -1337,6 +1339,14 @@ static void thermal_zone_init_complete(s
 	mutex_lock(&tz->lock);
 
 	tz->state &= ~TZ_STATE_FLAG_INIT;
+	/*
+	 * If system suspend or resume is in progress at this point, the
+	 * new thermal zone needs to be marked as suspended because
+	 * thermal_pm_notify() has run already.
+	 */
+	if (thermal_pm_suspended)
+		tz->state |= TZ_STATE_FLAG_SUSPENDED;
+
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_unlock(&tz->lock);
@@ -1514,10 +1524,10 @@ thermal_zone_device_register_with_trips(
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
 		thermal_zone_cdev_bind(tz, cdev);
 
-	mutex_unlock(&thermal_list_lock);
-
 	thermal_zone_init_complete(tz);
 
+	mutex_unlock(&thermal_list_lock);
+
 	thermal_notify_tz_create(tz);
 
 	thermal_debug_tz_add(tz);
@@ -1737,6 +1747,8 @@ static int thermal_pm_notify(struct noti
 	case PM_SUSPEND_PREPARE:
 		mutex_lock(&thermal_list_lock);
 
+		thermal_pm_suspended = true;
+
 		list_for_each_entry(tz, &thermal_tz_list, node)
 			thermal_zone_pm_prepare(tz);
 
@@ -1747,6 +1759,8 @@ static int thermal_pm_notify(struct noti
 	case PM_POST_SUSPEND:
 		mutex_lock(&thermal_list_lock);
 
+		thermal_pm_suspended = false;
+
 		list_for_each_entry(tz, &thermal_tz_list, node)
 			thermal_zone_pm_complete(tz);
 




