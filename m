Return-Path: <linux-pm+bounces-7699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BD8C1558
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D1C1C21BE5
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA637F49A;
	Thu,  9 May 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qfSfNs0k"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43380604;
	Thu,  9 May 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282275; cv=none; b=T+kTv2vZZKOAXa5AZTZdhwawiJDiGosslYuxR042T8hvn3dyEd4NeayWPdm3qsejsr8oOpfK4lhjaVSt68wWGckpvAgfveI5HS9o0yswsaBLWoT5Y4yMhY30Ky23qKMEgKPTtponQHFwp2t6rqDfIvdxhhNMjfMdGElS7TvAqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282275; c=relaxed/simple;
	bh=gyTf0mMiLoT/1Ze1j88d+hcLga2cI0BYwKUz0zqJIdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP8kkvLTMMqq5RAsBd8Dr0BJkag2DWkOwK8be4H1OZfrQ0Nk9AQ3GTnCx+DwTwIATyAdmiEsW6OMsCEsDs0zrLo3c4V8/ZdpIBnBnr4lois9c07ba8KmgCJftgPdgIMsWXDq0FbmK44DQ7IjDK8S5eViaP5HBFj1ggtTr68P11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qfSfNs0k reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id efbe846cf3d5481b; Thu, 9 May 2024 21:17:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B788DA524E7;
	Thu,  9 May 2024 21:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282265;
	bh=gyTf0mMiLoT/1Ze1j88d+hcLga2cI0BYwKUz0zqJIdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qfSfNs0kJ+GuMqFx7Vq9boJKfTRyZq7Kvd1D6hssL4ZdzOoxKho+/ruYcjrUDYRo/
	 T14R+V6qrJ6O29ZyXbPkRUMadInZTMb3INLT4C+awyvx212R/WyYrBkhzRn+sp7/bZ
	 t9Ne+9/JhA2If6jUxuFl3DrPy+My/5tVeQ15Xs/l70YzVzhn1bmEz8Fs/d/vW80rvO
	 zic7JGRxY7vSOQ5n6aCgI7W/1exN0rJUHl94vXxkiG+SpwHrSETWVYKYhCb6caR7fv
	 TYA3TkT2KRWJt1JKGMyKK0QI4LiVQf5bBzHtvgdOEWId4QPOl5m4sgeb/4cSApASc5
	 z+wFKhmOoQf2A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 2/7] thermal/debugfs: Do not extend mitigation episodes beyond
 system resume
Date: Thu, 09 May 2024 21:12:01 +0200
Message-ID: <2330375.ElGaqSPkdT@kreacher>
In-Reply-To: <12438864.O9o76ZdvQC@kreacher>
References: <12438864.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because thermal zone handling by the thermal core is started from
scratch during resume from system-wide suspend, prevent the debug
code from extending mitigation episodes beyond that point by ending
the mitigation episode currently in progress, if any, for each thermal
zone.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    1 +
 drivers/thermal/thermal_debugfs.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h |    2 ++
 3 files changed, 39 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1619,6 +1619,7 @@ static void thermal_zone_device_resume(s
 
 	tz->suspended = false;
 
+	thermal_debug_tz_resume(tz);
 	thermal_zone_device_init(tz);
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -922,3 +922,39 @@ void thermal_debug_tz_remove(struct ther
 	thermal_debugfs_remove_id(thermal_dbg);
 	kfree(trips_crossed);
 }
+
+void thermal_debug_tz_resume(struct thermal_zone_device *tz)
+{
+	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	ktime_t now = ktime_get();
+	struct tz_debugfs *tz_dbg;
+	struct tz_episode *tze;
+	int i;
+
+	if (!thermal_dbg)
+		return;
+
+	mutex_lock(&thermal_dbg->lock);
+
+	tz_dbg = &thermal_dbg->tz_dbg;
+
+	if (!tz_dbg->nr_trips)
+		goto out;
+
+	/*
+	 * A mitigation episode was in progress before the preceding system
+	 * suspend transition, so close it because the zone handling is starting
+	 * over from scratch.
+	 */
+	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
+
+	for (i = 0; i < tz_dbg->nr_trips; i++)
+		tz_episode_close_trip(tze, tz_dbg->trips_crossed[i], now);
+
+	tze->duration = ktime_sub(now, tze->timestamp);
+
+	tz_dbg->nr_trips = 0;
+
+out:
+	mutex_unlock(&thermal_dbg->lock);
+}
Index: linux-pm/drivers/thermal/thermal_debugfs.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.h
+++ linux-pm/drivers/thermal/thermal_debugfs.h
@@ -7,6 +7,7 @@ void thermal_debug_cdev_remove(struct th
 void thermal_debug_cdev_state_update(const struct thermal_cooling_device *cdev, int state);
 void thermal_debug_tz_add(struct thermal_zone_device *tz);
 void thermal_debug_tz_remove(struct thermal_zone_device *tz);
+void thermal_debug_tz_resume(struct thermal_zone_device *tz);
 void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 			      const struct thermal_trip *trip);
 void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
@@ -20,6 +21,7 @@ static inline void thermal_debug_cdev_st
 						   int state) {}
 static inline void thermal_debug_tz_add(struct thermal_zone_device *tz) {}
 static inline void thermal_debug_tz_remove(struct thermal_zone_device *tz) {}
+static inline void thermal_debug_tz_resume(struct thermal_zone_device *tz) {}
 static inline void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 					    const struct thermal_trip *trip) {};
 static inline void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,




