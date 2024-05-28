Return-Path: <linux-pm+bounces-8256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0268D1F87
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C4E28398E
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0FE173324;
	Tue, 28 May 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="R/EZWHZH"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182B171E5A;
	Tue, 28 May 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908476; cv=none; b=WQShctUmjjrzMy5L8ekOA48nxlRtMSZ2G+u8Ux92VV8IfAd/7/zWeZ7jzysl5Re0hriHJPXwlT3JwDJ6MyP/0HCsL61FLAM6O9cNtT0GWaLePS+9WiC2A5+xX9R2zMRi77qOf6pjtOxrUT/mlYjD/Ml0QRWYOfv+7mEpu/Om9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908476; c=relaxed/simple;
	bh=FSNgCECoeipF7QJrKj0OQsIro4RU4GPgTuHQfjCTmdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ghwr9SqeT60UCBNdSk2oq8BqVEoDNEgUpz5zaPE4Yja92yKKSnJBDJYc1uK1aFYUlXFPA+kddR8a3apMLuGv4T58tWREf/ntavo0E1LaVI+GVmUi7JdB52b8mATK94/Jxic7MuGSp8BNdP5ppkl8DAE1U2zNY5qbXl3kPJIwKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=R/EZWHZH reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 4b9514b018a67f6a; Tue, 28 May 2024 17:01:06 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3EF996A5015;
	Tue, 28 May 2024 17:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908466;
	bh=FSNgCECoeipF7QJrKj0OQsIro4RU4GPgTuHQfjCTmdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/EZWHZHf6ejzo2gyftXS9K4ildPLTfkd8YoNdpusaqlm0xQVf4nmDJ1yKWlTs9FN
	 eNGGI1Jd702nVdpys2NsD8Am10d38qPUVMFCh7qN5zCT0BFb4xpEqFj2d/VthvDo5a
	 PdQFV2r1hunZ14uI+Cus3l47a4dSk7GS8U7SKteS5dgQ2+BNgy4n6IIMmW7hNRiI90
	 mHMHq8etAoJFjS8Y3FVtr3YpDmTVuDDaIWeRFfQh//Il5nfixKesQ0i91qdKc7N+Fb
	 SjXxCTQyWDEIzPK793E5x351rZFsSp2VzudkFvcnQ+9/ISkGLUB8+vgurSYEVHIdC1
	 EabAYVHLPIgqw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 1/8] thermal/debugfs: Use helper to update trip point overstepping
 duration
Date: Tue, 28 May 2024 16:52:50 +0200
Message-ID: <4933647.31r3eYUQgx@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a helper for updating trip point overstepping duration to be called
from thermal_debug_tz_trip_down().

Subsequently, it will also be used during resume from system-wide
suspend.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_debugfs.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -653,14 +653,24 @@ unlock:
 	mutex_unlock(&thermal_dbg->lock);
 }
 
+static void tz_episode_close_trip(struct tz_episode *tze, int trip_id, ktime_t now)
+{
+	struct trip_stats *trip_stats = &tze->trip_stats[trip_id];
+	ktime_t delta = ktime_sub(now, trip_stats->timestamp);
+
+	trip_stats->duration = ktime_add(delta, trip_stats->duration);
+	/* Mark the end of mitigation for this trip point. */
+	trip_stats->timestamp = KTIME_MAX;
+}
+
 void thermal_debug_tz_trip_down(struct thermal_zone_device *tz,
 				const struct thermal_trip *trip)
 {
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
+	int trip_id = thermal_zone_trip_id(tz, trip);
+	ktime_t now = ktime_get();
 	struct tz_episode *tze;
 	struct tz_debugfs *tz_dbg;
-	ktime_t delta, now = ktime_get();
-	int trip_id = thermal_zone_trip_id(tz, trip);
 	int i;
 
 	if (!thermal_dbg)
@@ -695,13 +705,7 @@ void thermal_debug_tz_trip_down(struct t
 
 	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
 
-	delta = ktime_sub(now, tze->trip_stats[trip_id].timestamp);
-
-	tze->trip_stats[trip_id].duration =
-		ktime_add(delta, tze->trip_stats[trip_id].duration);
-
-	/* Mark the end of mitigation for this trip point. */
-	tze->trip_stats[trip_id].timestamp = KTIME_MAX;
+	tz_episode_close_trip(tze, trip_id, now);
 
 	/*
 	 * This event closes the mitigation as we are crossing the




