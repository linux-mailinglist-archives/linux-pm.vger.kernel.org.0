Return-Path: <linux-pm+bounces-14275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0EA979049
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DE81F234BA
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6C1CF288;
	Sat, 14 Sep 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dV6U00Me"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848E1CEE87;
	Sat, 14 Sep 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312152; cv=none; b=n0VGMmjYkB7MWboH2o14f9sLBIRYJIPrGNKT7wWzRgc9+GOEQzi6zmOcmXXZd1EE0kdObEHIKBrzkbg/HrvX7n1kgTDv5nycW5yhhN+TO1T5GE0u4UivfFdOtB1cf2T0wZxbm7AQSLpEtVTgadOKl/nPULNktAWtepkbzLU5/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312152; c=relaxed/simple;
	bh=w8kkdEpj36L90ciznlhiK8sldUmkY+C4hInsCITqYWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Est2dlChIaluwEPdHKtL73Bl/Kcj+vc+9hdIYvv6kKqmdz//ME/fTObS0X26VgjKbDSvaQ7ThGUqY5sYQ8+ibwmFS5swnHrXwayMbhbvr9bcTZwk5SVAKojw0iKeIyH3V/2pS6Y6RWAo7YNIgVgEqX/DYU7SwF9yhmscmc21iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dV6U00Me reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e52e580cb7d3fbf3; Sat, 14 Sep 2024 13:09:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4DF918532AE;
	Sat, 14 Sep 2024 13:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1726312148;
	bh=w8kkdEpj36L90ciznlhiK8sldUmkY+C4hInsCITqYWg=;
	h=From:Subject:Date;
	b=dV6U00MeRxkvTex/wF/NTmcthJps7rv4EozLHbeb63VWw8IhAN4tl2P+dJkuKkY4h
	 S64WQrJGTK+81uXuFS7+6oBzOB4Ben5ORZ8QxD9urRNih3yc2AsD6HqQsiZ28jCw4A
	 fkyiUxzyKw7/R4oDu4kScaDDkCvchdCWL+goCPoxH5rQVO9E2OdbDaWh4bLhiyIGvW
	 VcEmg9K3ttkXJe9hbxci7xrywkf2gb0aZIecOf7o5qOeGLFao5+IzjgS+S24yc1pwr
	 AMBX9ZGgP3HZ4QXjoUmyg1IOIllkWZvgOXkv/JMuBy0wur3LfunwQ8dqFpWRsBQE98
	 WS3qeSuJBhpCQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [RFC PATCH for 6.13 v1 05/20] thermal: core: Fix race between zone
 registration and system suspend
Date: Sat, 14 Sep 2024 12:31:28 +0200
Message-ID: <3335807.44csPzL39Z@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdr
 tghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=35 Fuz1=35 Fuz2=35

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the registration of a thermal zone takes place at the same time when
system suspend is started, thermal_pm_notify() can run before the new
thermal zone is added to thermal_tz_list and its "suspended" flag will
not be set.  Consequently, if __thermal_zone_device_update() is called
for that thermal zone, it will not return early as expected which may
cause some destructive interference with the system suspend or resume
flow to occur.

To avoid that, make thermal_zone_init_complete() introduced previously
set the "suspended" flag for new thermal zones if it runs during system
suspend or resume.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -39,6 +39,8 @@ static DEFINE_MUTEX(thermal_governor_loc
 
 static struct thermal_governor *def_governor;
 
+static bool thermal_pm_suspended;
+
 /*
  * Governor section: set of functions to handle thermal governors
  *
@@ -1323,6 +1325,14 @@ static void thermal_zone_init_complete(s
 	guard(thermal_zone)(tz);
 
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
 }
 
@@ -1494,10 +1504,10 @@ thermal_zone_device_register_with_trips(
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
 		thermal_zone_cdev_bind(tz, cdev);
 
-	mutex_unlock(&thermal_list_lock);
-
 	thermal_zone_init_complete(tz);
 
+	mutex_unlock(&thermal_list_lock);
+
 	thermal_notify_tz_create(tz);
 
 	thermal_debug_tz_add(tz);
@@ -1718,6 +1728,8 @@ static int thermal_pm_notify(struct noti
 	case PM_SUSPEND_PREPARE:
 		mutex_lock(&thermal_list_lock);
 
+		thermal_pm_suspended = true;
+
 		list_for_each_entry(tz, &thermal_tz_list, node)
 			thermal_zone_pm_prepare(tz);
 
@@ -1728,6 +1740,8 @@ static int thermal_pm_notify(struct noti
 	case PM_POST_SUSPEND:
 		mutex_lock(&thermal_list_lock);
 
+		thermal_pm_suspended = false;
+
 		list_for_each_entry(tz, &thermal_tz_list, node)
 			thermal_zone_pm_complete(tz);
 




