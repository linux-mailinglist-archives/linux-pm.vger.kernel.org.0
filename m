Return-Path: <linux-pm+bounces-10780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFFC92A578
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 17:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B02BB20A1F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF7180045;
	Mon,  8 Jul 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cufcPMnW"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362539461;
	Mon,  8 Jul 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451771; cv=none; b=QK+a9qHDpHqSM2K5V94Ecn9RYoplH187A4wdOlbb+8O7yGSDeJ1umwuzrMRdPsfRkkeX+cmdB20BmaMsg4bCutXhh1fm6m/EJ5zX8AMnTtAV+2sZf0Rh4R9WvL7Gu9HeOnVO9RwaSQ7FqtIBJbROMlH9qeCYrOjF3XtjgP5NCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451771; c=relaxed/simple;
	bh=l3v9wn8dWtkx2YVHLV24qtxF1/RBQnC1l9jMiqsoLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hmE0USMEGkLG4ap4thYnn4YC72oRWywpOluA8fJCXOBjuQUQjUfkqVnqhMkmP5GA37rJzeovtorMspCjlFFCI6uhAA3PUGOuK0d/R0DjuNv8fpV1WvodXjASgtLppAv8kltKEFYqkNvfE729OZjPOuy+Zw4jFihpp7vyh7aCkIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cufcPMnW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5fd8f54dc7a77aa8; Mon, 8 Jul 2024 17:16:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B62397F3AB9;
	Mon,  8 Jul 2024 17:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720451761;
	bh=l3v9wn8dWtkx2YVHLV24qtxF1/RBQnC1l9jMiqsoLYU=;
	h=From:To:Cc:Subject:Date;
	b=cufcPMnWmQQpPk8Q8rdMPLR2oSecix1Brypz/utIR8RTgwexlGkS/mbFfOIp1Itkx
	 41ynHIw150s9PBnm0KnEPn9HcIUWSOP+sfSUyR9c4zRZIL88Fqf69j1UoasDADqWxS
	 Zuk8Y/7MQiCNzY9GAzuSAQwDhLWZ0mzN7pQCzEnzYW3Eea5AzSlEp/FQmHD3o7xzR8
	 LkuyYY3s9OS1tRCh7K7fNMpVxacg6vRHEXaHw5myJL6xeol972lT+exLmV09vy98kv
	 H4X+Zntfkapy2EFTz/sm9qFOK6/UUgVDLJJUf9nrHbGo7fIwI+MdUIaYPU4vPvj182
	 9enApLlSpxsbw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v2] thermal: core: Fix list sorting in __thermal_zone_device_update()
Date: Mon, 08 Jul 2024 17:16:00 +0200
Message-ID: <12481676.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
 lhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The order in which lists are sorted in __thermal_zone_device_update()
is reverse with respect to what it should be due to a mistake in
thermal_trip_notify_cmp().

Fix it and observe that it is not necessary to sort the lists in
different orders.  They can both be sorted in ascending order if
way_down_list is walked in reverse order which allows the code to
be slightly more straightforward (and less prone to silly mistakes).

Fixes: 7454f2c42cce ("thermal: core: Sort trip point crossing notifications by temperature")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This supersedes

https://lore.kernel.org/linux-pm/2745398.mvXUDI8C0e@rjwysocki.net/

and hence v2.

It is urgent and I have verified that it actually works, so I'm going to
fast track it to get it into final 6.10.

---
 drivers/thermal/thermal_core.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -487,16 +487,14 @@ static void thermal_trip_crossed(struct
 	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
 }
 
-static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
+static int thermal_trip_notify_cmp(void *not_used, const struct list_head *a,
 				   const struct list_head *b)
 {
 	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
 						     notify_list_node);
 	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
 						     notify_list_node);
-	int ret = tdb->notify_temp - tda->notify_temp;
-
-	return ascending ? ret : -ret;
+	return tda->notify_temp - tdb->notify_temp;
 }
 
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
@@ -525,12 +523,12 @@ void __thermal_zone_device_update(struct
 
 	thermal_zone_set_trips(tz);
 
-	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
+	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, true);
 
 	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
-	list_for_each_entry(td, &way_down_list, notify_list_node)
+	list_for_each_entry_reverse(td, &way_down_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, false);
 
 	if (governor->manage)




