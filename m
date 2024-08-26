Return-Path: <linux-pm+bounces-12889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5B95F680
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2321F25B5C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07486194C6E;
	Mon, 26 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="gDQYR0FO"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D11195805;
	Mon, 26 Aug 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689530; cv=none; b=nCQWkwLq5RPdaXM3uOiMPURHmqilQWixscaQkpyCfeDttR/WT2ACNI2RuSxzcbOGVe8zUVOzxFTp5bZOWr90DRskthMFmYcJ3x+Tj0LeXSqmuq1vldU93fN+QaLPlTJIqxmGGsNsp3r/Tpe8tZ7jJZfIgvOk0vUbQnVzTkPhwDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689530; c=relaxed/simple;
	bh=GJcNBEl2AxPHc1nSFkToequ7kGw85FNTrJWiiYSEZgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PmW4Kmv4GoTEjmkyD1zAqa0WRPjGz0reUITl6Mv4liXrl1EYy0bwk5LFtPZ9EsTribjwXbaoP2dOyZW7751t7/KbrVsjHvha9qbvtLUN4sbLp3oSYf1iBPUGhMLBE2asrYM+cYjwZNQza5n+HvgK4JixFeItLK4RulGvg61w6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=gDQYR0FO reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 806dba96419cd69b; Mon, 26 Aug 2024 18:25:26 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EE30992159D;
	Mon, 26 Aug 2024 18:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724689526;
	bh=GJcNBEl2AxPHc1nSFkToequ7kGw85FNTrJWiiYSEZgo=;
	h=From:Subject:Date;
	b=gDQYR0FO/hz8pXDOMF6j5/zs+TqjXACQmM4F7jFYqYn/Q2UrRfFppGg6Ju06UxyDk
	 vvX7v6g7Mrdv0TlVxI7xkeDNbeyJb5zVt7WaYOHc4e45tOl46DebEaJPET0wD6uKGT
	 y/+wTZPP/I9fyHDdJxo49cPG9vbCuz6Zl7C+WQvEYybRB7qnqfmZVVEu84TizGTxeY
	 vuNyOs53NJkEzPoSnKYDpyG/rfMr05AKVRAaQCsNTRxt9k1XR/jSkKsSPAvsJ8/3vb
	 tl3wDnwdb9Hgsspa0q3HB4Qa2n4K34f9KbTGnwKjWeLClwBIvieJC0r7ThXtm7bkUU
	 dFhlVrDvg8IAg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Peter =?ISO-8859-1?Q?K=E4stle?= <peter@piie.net>
Subject:
 [PATCH v1] thermal: gov_bang_bang: Adjust states of all uninitialized
 instances
Date: Mon, 26 Aug 2024 18:23:49 +0200
Message-ID: <6103874.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhesphhiihgvrdhnvght
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a cooling device is registered after a thermal zone it should be
bound to and the trip point it should be bound to has already been
crossed by the zone temperature on the way up, the cooling device's
state may need to be adjusted, but the Bang-bang governor will not
do that because its .manage() callback only looks at thermal instances
for trip points whose thresholds are below or at the zone temperature.

Address this by updating bang_bang_manage() to look at all of the
uninitialized thermal instances and setting their target states in
accordance with the position of the zone temperature with respect to
the threshold of the given trip point.

Fixes: 5f64b4a1ab1b ("thermal: gov_bang_bang: Add .manage() callback")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Found by code inspection while considering a related change.

I don't thik it is super-urgent, but it qualifies as 6.12 material IMV.

---
 drivers/thermal/gov_bang_bang.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -92,23 +92,21 @@ static void bang_bang_manage(struct ther
 
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip = &td->trip;
+		bool turn_on;
 
-		if (tz->temperature >= td->threshold ||
-		    trip->temperature == THERMAL_TEMP_INVALID ||
+		if (trip->temperature == THERMAL_TEMP_INVALID ||
 		    trip->type == THERMAL_TRIP_CRITICAL ||
 		    trip->type == THERMAL_TRIP_HOT)
 			continue;
 
 		/*
-		 * If the initial cooling device state is "on", but the zone
-		 * temperature is not above the trip point, the core will not
-		 * call bang_bang_control() until the zone temperature reaches
-		 * the trip point temperature which may be never.  In those
-		 * cases, set the initial state of the cooling device to 0.
+		 * Adjust the target states for uninitialized thermal instances
+		 * to the thermal zone temperature and the trip point threshold.
 		 */
+		turn_on = tz->temperature >= td->threshold;
 		list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 			if (!instance->initialized && instance->trip == trip)
-				bang_bang_set_instance_target(instance, 0);
+				bang_bang_set_instance_target(instance, turn_on);
 		}
 	}
 




