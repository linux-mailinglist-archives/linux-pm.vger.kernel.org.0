Return-Path: <linux-pm+bounces-15162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CB990FE6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3236C1F242DD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680041E25E4;
	Fri,  4 Oct 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="h9WBaLHd"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88791DFDBA;
	Fri,  4 Oct 2024 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070993; cv=none; b=EHRoJB7g2cY8hiPCzE4BA55xItermUlygUrmOOlEAJTn2dj5mBznwcQ3LkO9ASpFAlhwp7GUloUkVwZWBM/b2f5sMrNDlFh5tp0AOCnmYClUoHuBpq8csjqBmCe/nfNy6oUdAkkTLQ0aAc0ArSwRJkQ30D4B0P926FPxmL2e5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070993; c=relaxed/simple;
	bh=2E7p4xDIjiqESb8HjztsoX4HPtZwOjx8IWDVhvI2xHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYQbzHpK1lJ7heOfQCVZWbRtCyGRqeNEjh0m6TyhJ3RembVkzjSwIZPXXzvjbqVzY4xGhdh1WS9TBAFqQPAAyoW/yCIALBoU5xVxPQ/QqR+JLic8vkgopMO3x9OIPSeOJaPSIw+fosd2O1Tnjo6L2CYassw9OzUpCffyX4YtKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=h9WBaLHd reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ac159aa11a076184; Fri, 4 Oct 2024 21:43:03 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2CD0E6A9505;
	Fri,  4 Oct 2024 21:43:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1728070983;
	bh=2E7p4xDIjiqESb8HjztsoX4HPtZwOjx8IWDVhvI2xHI=;
	h=From:Subject:Date;
	b=h9WBaLHdxIkBceiEZ3weXYNHdu/axLVNeNpU9VgHm2MseQ/3tPIQds3AAGFWquUyt
	 fQAmCW/NLYsNqlI+ep1XU0YO1wa0ewvifY9IaJk65LwKuOuatHYkW1amh4VEoFQGo0
	 PKbRDirn/4DrX0/w/ARuTbHtGaR+WTEyZnQ6wOhdYVP/1SpmKlMY8VOySJQ7dAko5K
	 Q08fJDfPzbj1buwjV87/LnhZbRIRHv9vc7Vq/rMOXwDPIanr2GGq949kr+3tmEbVz8
	 OKp+naZxIjghTEHQBNqvpaq3oOO0tdrWiEXtKS0CNF8tW2ew4xrX23dHqcCxZnBi7b
	 SztEmxKUap21w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 10/12] thermal: core: Drop need_update field from struct
 thermal_zone_device
Date: Fri, 04 Oct 2024 21:35:16 +0200
Message-ID: <2495061.jE0xQCEvom@rjwysocki.net>
In-Reply-To: <2215082.irdbgypaU6@rjwysocki.net>
References: <2215082.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdi
X-DCC--Metrics: v370.home.net.pl 0; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After previous changes, the need_update field in struct thermal_zone_device
is only set and never read, so drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a new iteration of

https://lore.kernel.org/linux-pm/3261209.5fSG56mABF@rjwysocki.net/

v1 -> v2: Rebase.

---
 drivers/thermal/thermal_core.c |    4 ----
 drivers/thermal/thermal_core.h |    2 --
 2 files changed, 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -840,7 +840,6 @@ static int thermal_bind_cdev_to_trip(str
 	if (!result) {
 		list_add_tail(&dev->tz_node, &tz->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
-		atomic_set(&tz->need_update, 1);
 
 		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 	}
@@ -1505,9 +1504,6 @@ thermal_zone_device_register_with_trips(
 	if (result)
 		goto remove_id;
 
-	/* A new thermal zone needs to be updated anyway. */
-	atomic_set(&tz->need_update, 1);
-
 	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	if (result) {
 		thermal_zone_destroy_device_groups(tz);
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -95,7 +95,6 @@ struct thermal_governor {
 			trip point.
  * @prev_high_trip:	the above current temperature if you've crossed a
 			passive trip point.
- * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
  * @ops:	operations this &thermal_zone_device supports
  * @tzp:	thermal zone parameters
  * @governor:	pointer to the governor for this thermal zone
@@ -129,7 +128,6 @@ struct thermal_zone_device {
 	int passive;
 	int prev_low_trip;
 	int prev_high_trip;
-	atomic_t need_update;
 	struct thermal_zone_device_ops ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;




