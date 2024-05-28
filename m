Return-Path: <linux-pm+bounces-8263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13E8D2205
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A3828934C
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0D2174EDF;
	Tue, 28 May 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="fBRQsmap"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E6173320;
	Tue, 28 May 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915266; cv=none; b=J/5IWkXOZBJUIrQmOx6h/3USWQK4RYdx+nq1b7pxS9gCp+5Mrih8ErjWAJWNj5Ds+hRhB66QYayeJp6b/eNYKKaC7sgLp6/ByNcsqZen+Fsho22n9i/UIhIPXEe+i/IEA8h9BmEcepfcyEEbyRJEj0GgLOO2JMJPSyY3F4HXifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915266; c=relaxed/simple;
	bh=ERK2R1qqQZ6vDmaMYJThtKTcWISqjAhym/ORlWiQoqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UEqQfeg7b9FR/FRRmufwXorhlsai0OHE1AvxFifJSY7ldRQ/AXdO6lx728vBDlca09SAjjpfZrfx8sK3ZLHNbdoywb5wqcfeEnh2qf7Y/gKAasZwtm20A+fUNHUBmN7eZQcr4dCvBrOM63kbXPApTKLBjRcUB4osAhicWzda9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=fBRQsmap reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 46509cfd70e61ec7; Tue, 28 May 2024 18:54:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 392876A5036;
	Tue, 28 May 2024 18:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716915262;
	bh=ERK2R1qqQZ6vDmaMYJThtKTcWISqjAhym/ORlWiQoqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fBRQsmapOYMgPGtEPriXsC1EIS27DXyfua6qTC8QTynlpPXvNNGNrLhd3zbAYu1+G
	 KgeyYWis9TbMOdGwgI9g3YKRBojxb1GOMmJADUbBGiXAjIPeTyYnaINmKEZiICXFaj
	 pEVM/VJqxlowrIC9BONWgPbd1uxRvtppsnfgsOQYTcNhWX/6yMfdlBYFWAd4y1+QMq
	 hKdF/O9VMUwlkK5MrKtNrA85AFnM69J6wvYGhuLRdnPMpsYUnjHhJ+aDG3EG1DkHqr
	 EMPYPTsDIGJr0VobQQ+6xV2aUeBIo5wtqz4F4bmQA3wKKAdwr0gXnIt+9JOpnJV1H4
	 9Bf+KK0VeD84A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2 2/5] thermal: trip: Make thermal_zone_set_trips() use trip
 thresholds
Date: Tue, 28 May 2024 18:51:11 +0200
Message-ID: <2340783.ElGaqSPkdT@kreacher>
In-Reply-To: <12458899.O9o76ZdvQC@kreacher>
References: <12458899.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify thermal_zone_set_trips() to use trip thresholds instead of
computing the low temperature for each trip to avoid deriving both
the high and low temperature levels from the same trip (which may
happen if the zone temperature falls into the hysteresis range of
one trip).

Accordingly, make __thermal_zone_device_update() call
thermal_zone_set_trips() later, when threshold values have been
updated for all trips.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_core.c |    4 ++--
 drivers/thermal/thermal_trip.c |   14 ++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -513,13 +513,13 @@ void __thermal_zone_device_update(struct
 	if (tz->temperature == THERMAL_TEMP_INVALID)
 		return;
 
-	thermal_zone_set_trips(tz);
-
 	tz->notify_event = event;
 
 	for_each_trip_desc(tz, td)
 		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
 
+	thermal_zone_set_trips(tz);
+
 	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, true);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -88,17 +88,11 @@ void thermal_zone_set_trips(struct therm
 		return;
 
 	for_each_trip_desc(tz, td) {
-		const struct thermal_trip *trip = &td->trip;
-		int trip_low;
+		if (td->threshold < tz->temperature && td->threshold > low)
+			low = td->threshold;
 
-		trip_low = trip->temperature - trip->hysteresis;
-
-		if (trip_low < tz->temperature && trip_low > low)
-			low = trip_low;
-
-		if (trip->temperature > tz->temperature &&
-		    trip->temperature < high)
-			high = trip->temperature;
+		if (td->threshold > tz->temperature && td->threshold < high)
+			high = td->threshold;
 	}
 
 	/* No need to change trip points */




