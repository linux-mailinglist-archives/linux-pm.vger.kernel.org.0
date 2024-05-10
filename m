Return-Path: <linux-pm+bounces-7722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA988C26A6
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3261C2205A
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023411708BE;
	Fri, 10 May 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PZzzd1cS"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63416F0DE;
	Fri, 10 May 2024 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350845; cv=none; b=QThHGwAA2AVvEx3uN1B7lL7SGbW7Wr+DxBeAmA6L+E3vbhjD6n19PoEvcAMVO/dbFj1aoInk9c8bWqhzxv1/EQNz0eLbt13FH4yGR1YV31WcqhN5Wx6j8hYYIGsC7T/o0GPXJH9sG0WmkkhWppyZTXHfnZoESJj4I/N5ORiAseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350845; c=relaxed/simple;
	bh=jH+y4+aBFMO+/Ot7DMk+ZxkiCguefE8lTUs8l4qSb5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rh6/Hrp3IxivTb00NQljPjcBmnRg/choW38zi/4jrhOC000hd2AYcbmAsxcf3vEzlBuU9mh25UOIF+YPWPOsLAVX2EzKTWHOmRMlS17F4htYNxZgO8zaLLqpIKuJI5Y/J1DC7MhyN7iY/yCnDHJk0+IhGOJIGT1cK82JXSlkWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PZzzd1cS reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 6c8e053778ea6915; Fri, 10 May 2024 16:20:41 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 51C342102F3F;
	Fri, 10 May 2024 16:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715350841;
	bh=jH+y4+aBFMO+/Ot7DMk+ZxkiCguefE8lTUs8l4qSb5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZzzd1cSkjK7vAWxFXQ2RU+QTwy0ppzLjryBkB6dv3ILFciFbm42UNAMsxBSXhemJ
	 SFaf+iGGyqySuI+1uP8rLmsjSjZQGWuneMDz/iy7Gwvc6m/+DaNZ18wcPgzTG4eNBE
	 eEMz5FLFr7gw1RFScrk3au8LE2dKkq1mtd5qIpkMJrJrM5vYnAGFxPNDuu7XVfmCp2
	 mgTCYNQl0RWL9P3Dw8aYNazmKLAfC0NTmNZbxqaXMKZOFSbTf5ZxuumM4kp/4fEpQN
	 6dJcVIHOEBh+VmA4d90MHFLa0M50GSpKPpvGAJ0TVI9FsmWppd1gk+b0N2ZH2V5I47
	 BNRJzTnXF4/JA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 2/6] thermal: trip: Rename __thermal_zone_set_trips() to
 thermal_zone_set_trips()
Date: Fri, 10 May 2024 16:14:36 +0200
Message-ID: <10471147.nUPlyArG6x@kreacher>
In-Reply-To: <13518388.uLZWGnKmhe@kreacher>
References: <13518388.uLZWGnKmhe@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop the pointless double underline prefix from the function name as per
the subject.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    2 +-
 drivers/thermal/thermal_core.h |    2 +-
 drivers/thermal/thermal_trip.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -498,7 +498,7 @@ void __thermal_zone_device_update(struct
 	if (tz->temperature == THERMAL_TEMP_INVALID)
 		return;
 
-	__thermal_zone_set_trips(tz);
+	thermal_zone_set_trips(tz);
 
 	tz->notify_event = event;
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -242,7 +242,7 @@ void thermal_governor_update_tz(struct t
 
 const char *thermal_trip_type_name(enum thermal_trip_type trip_type);
 
-void __thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -76,7 +76,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_t
  *
  * It does not return a value
  */
-void __thermal_zone_set_trips(struct thermal_zone_device *tz)
+void thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	const struct thermal_trip_desc *td;
 	int low = -INT_MAX, high = INT_MAX;




