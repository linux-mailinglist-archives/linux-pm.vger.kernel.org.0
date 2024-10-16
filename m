Return-Path: <linux-pm+bounces-15758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A1C9A087C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB387B24B42
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B345A2076C4;
	Wed, 16 Oct 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="WzqzqSl3"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2395C15C147;
	Wed, 16 Oct 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729078630; cv=none; b=iOVatQ1v7L5a9IkU/q3DG6sAzBGsLPiM9yIJpxlXgAgZKJ7tcVv2UcEG5x+6Q+otsM5Aobb4Hh56sGrUyJ89XIHUYM9XsGmBQrHI2X/S8DSB5rGSJWNoVtQQl6lMgMsNT41vRlWaYr8NCywo0TJR88JtWdwDnwbQlh2ye3tqvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729078630; c=relaxed/simple;
	bh=qCU084GYS1VrCYFQf8e+tB+oEPIBJ40QscA3anRgR9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=un0x40cYBifN0x/0i3pKiFUfKkU8YoKPVtNo9b03Uw6j8jcXwf9+UQvXKcX1fL2lvYer6CnsHiBQI48sZNbrSJfIdQwmWPzzzM8YIog+i6bY+f/7sKWe1E3ZmaQiBNHJRBuRzPKKyBGvq6uyAMYGrTYABbkHgaLjAt10IFietGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=WzqzqSl3; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id b85c8fbfce650e62; Wed, 16 Oct 2024 13:37:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 52667A93969;
	Wed, 16 Oct 2024 13:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1729078620;
	bh=qCU084GYS1VrCYFQf8e+tB+oEPIBJ40QscA3anRgR9c=;
	h=From:Subject:Date;
	b=WzqzqSl3v1ByVcNUmSCYPx+VsCAjD07uZoCB2ToEigMPe6izdumN5cohdzJZYPSll
	 9b37oCgnJ4pusOfraRJr1drIljiRZuGXzjdDJTGfKTIJcoERRoaoFQEiy4VxZJhDza
	 s1fWNHpFxPf+QfGT6y2u65oErp0/u/RzHwoBukeps92TeA4VPiCj5bfRDA1v05nL9a
	 VJwTib9jnuWEAGyONh4aBt+sE8/zPta2CsR/CYYsIyece15zAm2TXYee+HqcfmIpej
	 IXBM7QvsRanTaAAPOhiw5ju9vgmysbYd6MJUwhrriF3SPEJ/Fz/jNPVGan9ZN0CHZg
	 6T1VEggW/0JnA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 08/10] thermal: core: Eliminate thermal_zone_trip_down()
Date: Wed, 16 Oct 2024 13:33:43 +0200
Message-ID: <1807510.VLH7GnMWUR@rjwysocki.net>
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

Since thermal_zone_set_trip_temp() is not located in the same file
as thermal_trip_crossed(), it can invoke the latter directly without
using the thermal_zone_trip_down() wrapper that has no other users.

Update thermal_zone_set_trip_temp() accordingly and drop
thermal_zone_trip_down().

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    8 +-------
 drivers/thermal/thermal_core.h |    2 --
 2 files changed, 1 insertion(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -565,7 +565,7 @@ void thermal_zone_set_trip_temp(struct t
 		 * are needed to compensate for the lack of it going forward.
 		 */
 		if (tz->temperature >= td->threshold)
-			thermal_zone_trip_down(tz, td);
+			thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
 
 		/*
 		 * Invalidate the threshold to avoid triggering a spurious
@@ -699,12 +699,6 @@ void thermal_zone_device_update(struct t
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
-void thermal_zone_trip_down(struct thermal_zone_device *tz,
-			    struct thermal_trip_desc *td)
-{
-	thermal_trip_crossed(tz, td, thermal_get_tz_governor(tz), false);
-}
-
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *data)
 {
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -273,8 +273,6 @@ void thermal_zone_set_trips(struct therm
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
-void thermal_zone_trip_down(struct thermal_zone_device *tz,
-			    struct thermal_trip_desc *td);
 void thermal_zone_set_trip_hyst(struct thermal_zone_device *tz,
 				struct thermal_trip *trip, int hyst);
 




