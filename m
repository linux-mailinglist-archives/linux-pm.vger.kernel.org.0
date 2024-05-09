Return-Path: <linux-pm+bounces-7700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0508C155B
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA722283188
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DE85266;
	Thu,  9 May 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="D9U60wo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445880BFA;
	Thu,  9 May 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282275; cv=none; b=EQ9UUO0sML0Y7QievCeAPhBCfTOyyJUybse7kR2r7Xcrc08TuClagTcVY5Xhfb1EdHz1HDj4plmm0XSxMF99a8MwzKDFcaN1Smv1LiZZe39vvL88mu5YoUWTrvu/ezHOX7EIhwRFHVcIKu+wjYzxGaAPj7v8q4EFAcpr93ELH2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282275; c=relaxed/simple;
	bh=ZsUvE8bCFSM2mKEbiGx8vW2UaEuMB+r0WfdCWDI78Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyX+vPbX/BIU9oyzcJshp88n1FQ3ceHbBCueik0V5x6gdICWKMH5hrwQzqOTltU8cLsfolnBWrDXux8gcBBQLxIAP7SGunsJcsG+tVxrdWoQyHShkc1KiEl63Gh2i+DtoUJ7n5XNwBAE/mLzACDe8G02Y+L0Ys/E6hkMdQka6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=D9U60wo3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 1147030c55151564; Thu, 9 May 2024 21:17:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 91F20A524E7;
	Thu,  9 May 2024 21:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282266;
	bh=ZsUvE8bCFSM2mKEbiGx8vW2UaEuMB+r0WfdCWDI78Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9U60wo3wUp6f2xw5u+ffvM0RmHBMAEGdbIaV+ClmIgSRoCtYfDQI55Kq7rkVlwn8
	 obtOvtJKqW92u1BkLQf0C7A9DU6+WjtQ5rIoUtT7OOOI+KOmEXa5eG1+f9AczJ+8QL
	 KbuIoruV/z8m3wkyr0/o21xjMcMLquiAmBMWgtQv0cHOFTB94IO6shrTxWAfQ1vByV
	 3GXhkADOJMRKGPfQN2wEtlvZjHxFrBLHb3+sdnJZVT9/tHaTtK5FHJhrPurlZ6TbNS
	 7TeG1SGrDUc/n+6ks8QiBA3kegPbrBgiJBruD5+wZS0wOd59KnGY+FXeFYxZmcj4fx
	 JQwov6Xh3r0Tg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 1/7] thermal/debugfs: Use helper to update trip point overstepping
 duration
Date: Thu, 09 May 2024 21:09:51 +0200
Message-ID: <4924137.31r3eYUQgx@kreacher>
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

Add a helper for updating trip point overstepping duration to be called
from thermal_debug_tz_trip_down().

Subsequently, it will also be used during resume from system-wide
suspend.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -645,14 +645,24 @@ unlock:
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
@@ -687,13 +697,7 @@ void thermal_debug_tz_trip_down(struct t
 
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




