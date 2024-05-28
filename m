Return-Path: <linux-pm+bounces-8249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C018D1F73
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876FD1C22BD3
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 15:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57876171063;
	Tue, 28 May 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ulve7Ep0"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28616D9B2;
	Tue, 28 May 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908472; cv=none; b=Q4d6YHzIAYYxj+cTnL8bcNCpixMsWfKUi/53RtwxBZp8D5FbfW2dGz0gCv5mpOrSqOTdWzoyMsKPJHr9MgvG7gkx/mVtUi0iYEhW7w+KdePfHEmVwsl6jVgwwdo0AFFzTp7sdc/8GEFfhJnIcMIB3kJRGhxXjOt9J7dFgxLPtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908472; c=relaxed/simple;
	bh=XNW4F+x4W/rb3WsrpbO//7YwYaf6y4JTj+CwylfVs1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsqLlM/mqjyciYjVDdNbU3mi5yzQr3hNDNMEqL0Yhva3tqSOTkzHT3ZGAGlnLs8dnO68Ul3+6S+jYDHaTKs8xYYv3b950X50YzmHAy1WWCwucsJFD7De3Sm86hb2yHgKrid1uQjMWR25Fp/6kBh0BV3sSVYJVcmgPGr/Z+mFIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ulve7Ep0 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 345ae4cc075ba586; Tue, 28 May 2024 17:01:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DE96A6A5015;
	Tue, 28 May 2024 17:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716908462;
	bh=XNW4F+x4W/rb3WsrpbO//7YwYaf6y4JTj+CwylfVs1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ulve7Ep0Cidgla+Cvq2UZj/Vo8W72R1ZMiC/5kqlyPP5Bt4PInUINeYSoLvdOJ4HS
	 QTshkIC61dM6RIVPC024n0Um+HKm8RhHm0F3ORI58OwUkvifMYx7LNwFW0W8QooMFd
	 Fo2uXCoByG6yEfZlJVkk3ZX8zH85WJqCVdymIB0UAp+KC97gnKsKEQ14cB3HjEdvPc
	 UcwvBcytrwrVdJevT2pbWYxN+//8aMN67v42ixWOEc3V+36HdQAxY0iV4xBnLCYNlZ
	 nsggHTeUUPl/yj8iPI3R+lHsXfxg19p9LmlDRRr791AcM/pMqDdSFZFFJ+aVZeSAeX
	 RY5Z21ljKB5KA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 7/8] thermal/debugfs: Move some statements from under
 thermal_dbg->lock
Date: Tue, 28 May 2024 16:59:55 +0200
Message-ID: <22311651.EfDdHjke4D@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
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

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_debugfs.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -574,20 +574,20 @@ static struct tz_episode *thermal_debugf
 void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
 			      const struct thermal_trip *trip)
 {
-	struct tz_episode *tze;
-	struct tz_debugfs *tz_dbg;
 	struct thermal_debugfs *thermal_dbg = tz->debugfs;
 	int trip_id = thermal_zone_trip_id(tz, trip);
 	ktime_t now = ktime_get();
 	struct trip_stats *trip_stats;
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
@@ -677,10 +677,10 @@ void thermal_debug_tz_trip_down(struct t
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
@@ -729,10 +729,10 @@ void thermal_debug_update_trip_stats(str
 	if (!thermal_dbg)
 		return;
 
-	mutex_lock(&thermal_dbg->lock);
-
 	tz_dbg = &thermal_dbg->tz_dbg;
 
+	mutex_lock(&thermal_dbg->lock);
+
 	if (!tz_dbg->nr_trips)
 		goto out;
 




