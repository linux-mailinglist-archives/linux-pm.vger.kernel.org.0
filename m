Return-Path: <linux-pm+bounces-8080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BEB8CD80B
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1871F229CB
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF510A0A;
	Thu, 23 May 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="SklltD+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139B175A5;
	Thu, 23 May 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480320; cv=none; b=OCEUJpPcL4XIrRgyvfeH+CX9FhGzY7kDq8mnZlKBzn4e2sk/b/8eEaeh4NzdI/VPqtufrgUD/n/ZO7/CV8YQ69LoV8MByV8znKSKIUnEJC08swt9XfZggYua30bH8/92W0vhciDsbRqQweMPXjZz61svGRz+/p/pCc0sLDf89PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480320; c=relaxed/simple;
	bh=yh2D7SxRwoIh2Kxy8xBKW938ZUwbvuYiqDLDYBdxkIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7gfvh5UKpLHmF75jEGDCTBKQ/AAGRLg8wH4/bkN6O+dviBM5KfuqaQjMfz5n9hNRovQivu+mum5h2ik3AkxM7EVvzWyThn2WdgsDa1Oj3o2trdHt1ZGiddg7zoG6V18u9eIIhpCaKlUfgnqOtWroWO6gmPycEynKPoI0ur+UiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=SklltD+Z; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id b64d348b3109eca7; Thu, 23 May 2024 18:05:11 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 16A3A6A4927;
	Thu, 23 May 2024 18:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1716480311;
	bh=yh2D7SxRwoIh2Kxy8xBKW938ZUwbvuYiqDLDYBdxkIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SklltD+ZV5/GSClo6qnpgcbSIfHqgwvfNidTyR+CJ8kFEcVmoKhseAnmPhxi3DW80
	 Xi0OPrfM3PlKXw/WpHQa1ltca1XhGjKNM690YVaEy8EVG+2LhqywBvTOkOPtstAISo
	 n/ttj+KNV7xjiQxOw9L2hrRlY7i71vh+ftrimpYruyG/M83hsQEsC91RmXmsJ9LMRu
	 wpsmfV4Ir1zu/3vMR3WwIBDHegW9YQhbasF1kvs7nT+WmimOPIloGSiLo0O6D5kqBA
	 oAUMcWUzk+EE60ljsQY6gMxJbZJlKEBGlVX7dPGOSwW74Noc9a5m5AnUZU2CCh2IVF
	 1xAO+NAUHp2CA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 3/4] thermal: core: Introduce thermal_trip_crossed()
Date: Thu, 23 May 2024 18:00:14 +0200
Message-ID: <1884854.tdWV9SEqCh@kreacher>
In-Reply-To: <12438941.O9o76ZdvQC@kreacher>
References: <12438941.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a helper function called thermal_trip_crossed() to be invoked by
__thermal_zone_device_update() in order to notify user space, the
thermal debug code and the zone governor about trip crossing.

Subsequently, this will also be used in the case when a trip point
becomes invalid after being crossed on the way up.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -467,6 +467,21 @@ static void thermal_governor_trip_crosse
 		governor->trip_crossed(tz, trip, crossed_up);
 }
 
+static void thermal_trip_crossed(struct thermal_zone_device *tz,
+				 const struct thermal_trip *trip,
+				 struct thermal_governor *governor,
+				 bool crossed_up)
+{
+	if (crossed_up) {
+		thermal_notify_tz_trip_up(tz, trip);
+		thermal_debug_tz_trip_up(tz, trip);
+	} else {
+		thermal_notify_tz_trip_down(tz, trip);
+		thermal_debug_tz_trip_down(tz, trip);
+	}
+	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
+}
+
 static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
 				   const struct list_head *b)
 {
@@ -506,18 +521,12 @@ void __thermal_zone_device_update(struct
 		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
 
 	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
-	list_for_each_entry(td, &way_up_list, notify_list_node) {
-		thermal_notify_tz_trip_up(tz, &td->trip);
-		thermal_debug_tz_trip_up(tz, &td->trip);
-		thermal_governor_trip_crossed(governor, tz, &td->trip, true);
-	}
+	list_for_each_entry(td, &way_up_list, notify_list_node)
+		thermal_trip_crossed(tz, &td->trip, governor, true);
 
 	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
-	list_for_each_entry(td, &way_down_list, notify_list_node) {
-		thermal_notify_tz_trip_down(tz, &td->trip);
-		thermal_debug_tz_trip_down(tz, &td->trip);
-		thermal_governor_trip_crossed(governor, tz, &td->trip, false);
-	}
+	list_for_each_entry(td, &way_down_list, notify_list_node)
+		thermal_trip_crossed(tz, &td->trip, governor, false);
 
 	if (governor->manage)
 		governor->manage(tz);




