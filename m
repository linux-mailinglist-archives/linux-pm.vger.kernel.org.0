Return-Path: <linux-pm+bounces-15765-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEEA9A0887
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359F81F246A9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D31208233;
	Wed, 16 Oct 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="g1kG9lJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E32071E9;
	Wed, 16 Oct 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078632; cv=none; b=tJEiAMSYIwfM+/FLiD2a0/l2ELueDDDPCB0E78ehE3V3/i50Fkcec5mArMpzQe3IxgRqBe2h/QJHF+rvg8iXsQyacB81Po1GBg+Gp0GoC8jx5nmaoAIGbiUYonsumvqQcFxf1ylNEgD9Ny3eptCn96RwO0OVuSAZaVaAndTau1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078632; c=relaxed/simple;
	bh=avHBCgyjDjsDv6KLj8yM6hNz9dbOrf4L4s9y8N+/hM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zz9zAFLLgUGRdVpNwEs9c7S+nbeoyE2WO5DYFX3uploOnpqsi6Whfmhzn55nNGCOzoUPAGQMO7Fwx7wAQt5Aq11WM0vFfQcNXezHHj7r9tx5DBqR/4/L10pnoxZtCSD2M6UJ9vCO7+TtejeVBChZphDL6IvYAVo9qwNYfsdw3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=g1kG9lJ3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ae667072fee69325; Wed, 16 Oct 2024 13:37:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 58DF0A93969;
	Wed, 16 Oct 2024 13:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078621;
	bh=avHBCgyjDjsDv6KLj8yM6hNz9dbOrf4L4s9y8N+/hM8=;
	h=From:Subject:Date;
	b=g1kG9lJ3oAMfmiCFfY5BiO1Wn/8M8/KIb0o5zoPp0eLsavs9yjetdMREY/g6BBZih
	 ti3M0TjW0lj0Zwv0+UbcSbn3sQ8M/M5xUvCmHP88nPE0NnMaGwZwTOcancVjOhAJBH
	 4D8aCtci0ytOlSdT87MNjNqZUzRrPnHCf8Tbe0+ZT3UDnjpp0PpoA0OARmsdrHRecG
	 pZgRvQZI05ZtEAx1NmEyq74eZyf8dZKe1d5cXzIQnaroCXtGZvb1IpBOhqdMcdaS5s
	 /z4nfiEoBLkqWbjJ/I92evUp1GonAMoAtr1yJ++Y12Kcyo191XkYzh+Z7qg5bhy/8n
	 oljguSZOmpGfQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 05/10] thermal: core: Pass trip descriptor to
 thermal_trip_crossed()
Date: Wed, 16 Oct 2024 13:27:56 +0200
Message-ID: <10547668.nUPlyArG6x@rjwysocki.net>
In-Reply-To: <4958885.31r3eYUQgx@rjwysocki.net>
References: <4958885.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In preparation for subsequent changes, modify thermal_trip_crossed()
to take a trip descriptor pointer instead of a pointer to struct
thermal_trip and propagate this change to thermal_zone_trip_down().

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   12 +++++++-----
 drivers/thermal/thermal_core.h |    2 +-
 drivers/thermal/thermal_trip.c |    2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -526,10 +526,12 @@ static void thermal_governor_trip_crosse
 }
 
 static void thermal_trip_crossed(struct thermal_zone_device *tz,
-				 const struct thermal_trip *trip,
+				 struct thermal_trip_desc *td,
 				 struct thermal_governor *governor,
 				 bool crossed_up)
 {
+	const struct thermal_trip *trip = &td->trip;
+
 	if (crossed_up) {
 		thermal_notify_tz_trip_up(tz, trip);
 		thermal_debug_tz_trip_up(tz, trip);
@@ -589,12 +591,12 @@ void __thermal_zone_device_update(struct
 	}
 
 	list_for_each_entry_safe(td, next, &way_up_list, list_node) {
-		thermal_trip_crossed(tz, &td->trip, governor, true);
+		thermal_trip_crossed(tz, td, governor, true);
 		list_del_init(&td->list_node);
 	}
 
 	list_for_each_entry_safe_reverse(td, next, &way_down_list, list_node) {
-		thermal_trip_crossed(tz, &td->trip, governor, false);
+		thermal_trip_crossed(tz, td, governor, false);
 		list_del_init(&td->list_node);
 	}
 
@@ -664,9 +666,9 @@ void thermal_zone_device_update(struct t
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
 void thermal_zone_trip_down(struct thermal_zone_device *tz,
-			    const struct thermal_trip *trip)
+			    struct thermal_trip_desc *td)
 {
-	thermal_trip_crossed(tz, trip, thermal_get_tz_governor(tz), false);
+	thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
 }
 
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -274,7 +274,7 @@ int thermal_zone_trip_id(const struct th
 			 const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 void thermal_zone_trip_down(struct thermal_zone_device *tz,
-			    const struct thermal_trip *trip);
+			    struct thermal_trip_desc *td);
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int hyst);
 
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -118,7 +118,7 @@ void thermal_zone_set_trip_temp(struct t
 				tz->passive--;
 				WARN_ON_ONCE(tz->passive < 0);
 			}
-			thermal_zone_trip_down(tz, trip);
+			thermal_zone_trip_down(tz, td);
 		}
 		/*
 		 * Invalidate the threshold to avoid triggering a spurious




