Return-Path: <linux-pm+bounces-11569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6169593FC25
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932401C225AE
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26218757C;
	Mon, 29 Jul 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vtjKYPT7"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC9186E25;
	Mon, 29 Jul 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273183; cv=none; b=EO6Ti7HTGb6f9WYXI6Eb63hg/LmrCk5tr4avB2qnA44bpNaReZwKVE0kVWLvLObnPe3sWEhl3n1roc3NrY6IS55vi3oK6+ye3rdET2T87Dnw/9JKd20aLJtZF01wfs3b0SgdJ+Q8DiACd71bfY5kbX81vCljEWskX7LKq0KSMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273183; c=relaxed/simple;
	bh=ZZKCTLMFaqW5qBxAc1zMCNcho/0TG2FZHdzOjo/7dMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL1C8vQFKb8vzBrofJ7NjkOnmXdFalZrNsaV6jZGondGbwJkdyTsTJrbkDupE/jGIEzpHSr9p+1Ocm0EkTWxdBn9/ti72/O2Tr2QmFwjSohFVMsjD/iXy3N8fI+tVOlkC6ODnTb8DuwnU6wkTDcJUCCL1ydYAxrlm4I20xyWfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vtjKYPT7 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 87802f5981a8ec7d; Mon, 29 Jul 2024 18:13:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3043B77357F;
	Mon, 29 Jul 2024 18:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269580;
	bh=ZZKCTLMFaqW5qBxAc1zMCNcho/0TG2FZHdzOjo/7dMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vtjKYPT7S39ixFQNj1eBjBzzblns6ywb1ETEu36xW8gM0lZVTIB5vN7f79uPJIH3K
	 THww4F6g6035YBsF+z6EErkXC5jTq3MgWbPcFH5Dbb2fCPgDWTpQa4X7tzksFjrNl2
	 o+Cw1k4akKm/ARji8dBeqUPdtQ+Vo1CZSQjoqxGQgXm7HkkkdQ0uNkKcxSDXnN+9aL
	 v+9KjJYqEd4jKS8svtSLdqanYMDYQN3jZme/+B3cZ+m3DOUC1E20OyObmH7pZDAJlN
	 uaW5y8D9cM/e1Z2/itDwHhvNMFi90abf9V6Gf2Q5n6TZwk7FaGNzv9iy19q/FcUox6
	 PyUhsfAe7Hwsg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [RESEND][PATCH v1 2/8] thermal: hisi: Use thermal_zone_for_each_trip() in
 hisi_thermal_register_sensor()
Date: Mon, 29 Jul 2024 17:56:25 +0200
Message-ID: <1994088.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <2211925.irdbgypaU6@rjwysocki.net>
References: <2211925.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify hisi_thermal_register_sensor() to use thermal_zone_for_each_trip()
for walking trip points instead of iterating over trip indices and using
thermal_zone_get_trip() to get a struct thermal_trip pointer from a trip
index.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch does not depend on the previous patch(es) in the series.

---
 drivers/thermal/hisi_thermal.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/hisi_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/hisi_thermal.c
+++ linux-pm/drivers/thermal/hisi_thermal.c
@@ -465,6 +465,18 @@ static irqreturn_t hisi_thermal_alarm_ir
 	return IRQ_HANDLED;
 }
 
+static int hisi_trip_walk_cb(struct thermal_trip *trip, void *arg)
+{
+	struct hisi_thermal_sensor *sensor = arg;
+
+	if (trip->type != THERMAL_TRIP_PASSIVE)
+		return 0;
+
+	sensor->thres_temp = trip->temperature;
+	/* Return nonzero to terminate the search. */
+	return 1;
+}
+
 static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
@@ -482,15 +494,7 @@ static int hisi_thermal_register_sensor(
 		return ret;
 	}
 
-	for (i = 0; i < thermal_zone_get_num_trips(sensor->tzd); i++) {
-
-		thermal_zone_get_trip(sensor->tzd, i, &trip);
-
-		if (trip.type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = trip.temperature;
-			break;
-		}
-	}
+	thermal_zone_for_each_trip(sensor->tzd, hisi_trip_walk_cb, sensor);
 
 	return 0;
 }




