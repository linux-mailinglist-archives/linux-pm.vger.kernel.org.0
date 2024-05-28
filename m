Return-Path: <linux-pm+bounces-8254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2058D1F84
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FA0B23707
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D1172BAD;
	Tue, 28 May 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="isNfKZdw"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933217166C;
	Tue, 28 May 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908475; cv=none; b=ncSEakLhtJBIKfQgabvTyPVKtjypj3uzn5cQouALVjsLAUrYKxzYGJo6nnRdxJN7NZbUIm+NsODGSsEmbdzYaGC0pYMZb+gf4tfnsH+0bvMQCJVobquaCQaytOXqRMrye7XTtS3549q1OsCzmFBtSIfpJ+hsjcM1NZVEHi2miOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908475; c=relaxed/simple;
	bh=pENZ82A7dQdj9deo3H0ub5tDzd02tnfp1eYuXbyPaD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snQk1u4zEcZ4fqx6mlJVRcxzxnj6LnePzr5vbQ8RHzyHKSpmdsJP8gT2DO3LFJiYbNqox3Tp5TOGk6I3XbuFeWq2plvoBUEjTOI3BRnEZBDyBKMkLPpq5DzYWvKI4ZlsSMKJ2Tjg60SumTAH2JvHkVKNNAlXhl3U2lZZgqGBbZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=isNfKZdw reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id fe7ef9829d007e61; Tue, 28 May 2024 17:01:06 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8BACA6A5015;
	Tue, 28 May 2024 17:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908466;
	bh=pENZ82A7dQdj9deo3H0ub5tDzd02tnfp1eYuXbyPaD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=isNfKZdw8RNrG8geFjZ0quGP+yq3K/tuSw2z9lhcMuTcsnQgP6MrFyCgMTJv6E+w/
	 IwdrXjQmZ+qGKGfa2A5AmvMtvrnUJzEDhQvRWutD0gjScj9UYR69gnS0IQi2xj20gc
	 8ysB+JL25xqdPFOHtaFmwQ651t9xXPthCCiTuPpDvp7rBhzjnLmAJTMQc+nTmuJ9Ka
	 OTGJVPCY8lRWVaHQEHEyUQ+gfFW/4FdkE235BjcOkHGpVwUMPyBaGaTYRb5C9fjs1J
	 Wsf1JUavUqxiNb9rgh4kAYa4Z8dunSDNczrbn+FBHIFjPrhv27MBdvuR+62N7CBmgi
	 3K6SagdxVR9ug==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 2/8] thermal/debugfs: Do not extend mitigation episodes beyond
 system resume
Date: Tue, 28 May 2024 16:53:47 +0200
Message-ID: <2337425.ElGaqSPkdT@kreacher>
In-Reply-To: <5794974.DvuYhMxLoT@kreacher>
References: <5794974.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because thermal zone handling by the thermal core is started from
scratch during resume from system-wide suspend, prevent the debug
code from extending mitigation episodes beyond that point by ending
the mitigation episode currently in progress, if any, for each thermal
zone.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_core.c    |    1 +
 drivers/thermal/thermal_debugfs.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_debugfs.h |    2 ++
 3 files changed, 39 insertions(+)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1641,6 +1641,7 @@ static void thermal_zone_device_resume(s
 
 	tz->suspended = false;
 
+	thermal_debug_tz_resume(tz);
 	thermal_zone_device_init(tz);
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -926,3 +926,39 @@ void thermal_debug_tz_remove(struct ther
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




