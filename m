Return-Path: <linux-pm+bounces-7695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79EE8C154C
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 21:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AA9B220E7
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FA7FBBE;
	Thu,  9 May 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jtddYvtT"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0427EEE7;
	Thu,  9 May 2024 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282271; cv=none; b=vBVb9UPJIiiVUzAOuYTklh/1gHBIRKCwdb+uz42OOlQBKoveX5H6Ydbt2CTR1cBm6snMIN8K2vGUN70EugmWhn3ONnYxXN81Dn9HrlMRuzpep5mFUqkYiDarwd9JRGy6tJLrutaI3vJ0JsZ2nodMhKX0u4pjSKuxA6hnlvgYXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282271; c=relaxed/simple;
	bh=IZfPLcRxXHmj113Atg8plIho0l7kxPY7n+YKdJVy0Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e60pz6kzxfFtuaoKQfBIwBUbhKJbKxZwwUCOrb1lRFB5aij4b4s7L/F8uEjOt1HlHILj3R3QvoGU3YcT9EJVytFl3Zr4tGQ81Kj/Srbl/ouoQz7s3XNlaVvchsQhAEgBzGO7oWEv0CmcAUX/n4rUUyxiQ7G6FioIJZtVaD6yZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jtddYvtT reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id c48abd1f18dfa5b3; Thu, 9 May 2024 21:17:42 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A3333A524E7;
	Thu,  9 May 2024 21:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715282262;
	bh=IZfPLcRxXHmj113Atg8plIho0l7kxPY7n+YKdJVy0Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jtddYvtTWV8Zm3UP/CV42APo3S+UakPAIG0iHaSmZMh+WYA7EiL3jaQb/bIoDyIoH
	 jxTxufoHTnWmYbM43QbRgmPIyoL1pV5nY+7GKb65laXW0RgCsC2oTIMLPCTFm6TtqH
	 Q3rK/QJNjMWYA+3VXveS7XBkI8ONsKF1drTEa+UiBgIa5OKPht352HuMW+giKaMs+L
	 NVa+SWnG/Adxf3DZqDKGNUZG6Uyf1QFXKiI9XN1Cf9KW8FU1hU7XNpMrkuh9NRuevv
	 K1Lr5gCGeZjPa75TJf6nHwYSy4MTDX24bbVP5NVoM6h7+IT7Z0Lzg0VSRldFXgbPn9
	 ibfBTHNUWxGJA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 6/7] thermal/debugfs: Move some statements from under
 thermal_dbg->lock
Date: Thu, 09 May 2024 21:16:22 +0200
Message-ID: <8376520.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefvddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The tz_dbg local variable assignments in thermal_debug_tz_trip_up(),
thermal_debug_tz_trip_down(), and thermal_debug_update_trip_stats()
need not be carried out under thermal_dbg->lock, so move them from
under that lock (to avoid possible future confusion).

While at it, reorder local variable definitions in
thermal_debug_tz_trip_up() for more clarity.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_debugfs.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -568,19 +568,19 @@ static struct tz_episode *thermal_debugf
 void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 			      const struct thermal_trip *trip)
 {
-	struct tz_episode *tze;
-	struct tz_debugfs *tz_dbg;
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	ktime_t now = ktime_get();
+	struct tz_debugfs *tz_dbg;
+	struct tz_episode *tze;
 
 	if (!thermal_dbg)
 		return;
 
-	mutex_lock(&thermal_dbg->lock);
-
 	tz_dbg = &thermal_dbg->tz_dbg;
 
+	mutex_lock(&thermal_dbg->lock);
+
 	/*
 	 * The mitigation is starting. A mitigation can contain
 	 * several episodes where each of them is related to a
@@ -667,10 +667,10 @@ void thermal_debug_tz_trip_down(struct t
 	if (!thermal_dbg)
 		return;
 
-	mutex_lock(&thermal_dbg->lock);
-
 	tz_dbg = &thermal_dbg->tz_dbg;
 
+	mutex_lock(&thermal_dbg->lock);
+
 	/*
 	 * The temperature crosses the way down but there was not
 	 * mitigation detected before. That may happen when the
@@ -719,10 +719,10 @@ void thermal_debug_update_trip_stats(str
 	if (!thermal_dbg)
 		return;
 
-	mutex_lock(&thermal_dbg->lock);
-
 	tz_dbg = &thermal_dbg->tz_dbg;
 
+	mutex_lock(&thermal_dbg->lock);
+
 	if (!tz_dbg->nr_trips)
 		goto out;
 




