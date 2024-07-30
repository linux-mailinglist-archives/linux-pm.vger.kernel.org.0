Return-Path: <linux-pm+bounces-11674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22394148F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CB71C22E2B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4961A254E;
	Tue, 30 Jul 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nT7jad2G"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC019DF41;
	Tue, 30 Jul 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350485; cv=none; b=LzKgFNffPmzEdunZTOH1d+tbVe9BADwNAeMHC3mlI8YQu9cHMP9nWS+j+tdu4UfMRRfuAIJGAPRx/K5vqjz9PfhCnuVt6Vef/6NbkJZphfYvto09IVrd7hmBB9BO+u8CoghIZ9HZDkSiY3LlN8u922WCtY2Io5N3sOhtJOhXS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350485; c=relaxed/simple;
	bh=XoGns8YSYmXTWpA+GubAi+xVCIyKLpCl6Tp3URp06/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TADTU14qxRAIPhQB53UfV7Hy4nK6YzbG2MWBt0m4voC2ckei6Dn6KfLTAmxnj25jIUcnbOvajw3vIYN+CYIpDUboMHktzS47txqzmMHdaBCEaCwLfULeqN4m4LHSlrZxgdY8U/GyBgHegk6mTB2dcB66CzsT39YLq2YkRhGpjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nT7jad2G reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 92ffbe357cbb50cf; Tue, 30 Jul 2024 16:41:19 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 18B92956FDB;
	Tue, 30 Jul 2024 16:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722350479;
	bh=XoGns8YSYmXTWpA+GubAi+xVCIyKLpCl6Tp3URp06/c=;
	h=From:To:Cc:Subject:Date;
	b=nT7jad2GIMkbRnd8t3tvEenlMXJH9PaCyudcHRHtuXj0eLgNNk+IclqODfIr4OVQP
	 CF7HHsH4fOdPzgamRsZdBhrvkcuRSiclGaW4xIriXsXbbD2BbC4HeGugMilvbeKpJ0
	 xIwETAo9ea9LMpjU+AcM5LkYfvwOv87+ALfIfsSJi5XaxiB3MxEr1rH6K+XhjoRPaQ
	 5uXuoDB0yPn7w7nX/VsHMJv1bxZ7Om9lsWbtFsnSK/DVU+04te8qMxAU9dyqRD8to0
	 KPXD/PU9uZa9s+bVg0QvJHK7tf9qv/Z+4ZLLYo/qEJCCnK6ks4d96QooWPLfBuTz2R
	 +/bbRF81GaeGg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1] thermal: trip: Avoid skipping trips in thermal_zone_set_trips()
Date: Tue, 30 Jul 2024 16:41:18 +0200
Message-ID: <12509184.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
 thhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Say there are 3 trip points A, B, C sorted in ascending temperature
order with no hysteresis.  If the zone temerature is exactly equal to
B, thermal_zone_set_trips() will set the boundaries to A and C and the
hardware will not catch any crossing of B (either way) until either A
or C is crossed and the boundaries are changed.

To avoid that, use non-strict inequalities when comparing the trip
threshold to the zone temperature in thermal_zone_set_trips().

In the example above, it will cause both boundaries to be set to B,
which is desirable because an interrupt will trigger when the zone
temperature becomes different from B regardless of which way it goes.
That will allow a new interval to be set depending on the direction of
the zone temperature change.

Fixes: 893bae92237d ("thermal: trip: Make thermal_zone_set_trips() use trip thresholds")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

6.11-rc material.

---
 drivers/thermal/thermal_trip.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -82,10 +82,10 @@ void thermal_zone_set_trips(struct therm
 		return;
 
 	for_each_trip_desc(tz, td) {
-		if (td->threshold < tz->temperature && td->threshold > low)
+		if (td->threshold <= tz->temperature && td->threshold > low)
 			low = td->threshold;
 
-		if (td->threshold > tz->temperature && td->threshold < high)
+		if (td->threshold >= tz->temperature && td->threshold < high)
 			high = td->threshold;
 	}
 




