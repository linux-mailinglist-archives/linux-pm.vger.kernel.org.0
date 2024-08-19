Return-Path: <linux-pm+bounces-12470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D35957076
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E98B21F77
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA1D17D341;
	Mon, 19 Aug 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="A6NN/04F"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A545C1C;
	Mon, 19 Aug 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085318; cv=none; b=Tpu2x204Zc5oylY76VfOqdK24tvrJ2eczhsH0g7YNoRshAJ/1pmyoygz2fauSFWHOHgZoWnOs5bEqtIu/GxHXC2tf6uSjEn40fRy5zn7GcUehcmMczbPwEJ1Mcw/Z5QuC6I6FZsUJLNlSx1064b36J2g2HHe2xFuMj7PV8r2NVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085318; c=relaxed/simple;
	bh=tNgShPjG/03cJgUa4FM7E14llDvoaCpYC/NUf1GVrg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRtl0KS5YQdDJV2tU86ZNQ/K2ZgOdjTvmZI8Q3X+X05oJWQTqICGh4O2ZAxjmy6q1WEfOm5btWT33FG1R0//UMayR7SFfAq/U0kzavicZ3IWKmGkfAZ1BOwLZpm1QD1S3FiscTOOOK5qdlwSoiz9s4bmaZ+GjlYw3upyAuvhnCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=A6NN/04F reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9d20b96aab850120; Mon, 19 Aug 2024 18:35:14 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0879173B5D4;
	Mon, 19 Aug 2024 18:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724085314;
	bh=tNgShPjG/03cJgUa4FM7E14llDvoaCpYC/NUf1GVrg8=;
	h=From:Subject:Date;
	b=A6NN/04Fzh3H1CzUBAfygUSRc8wOx+pOxXX9yueWv7/49AtpI1ojzznM4QFyoKsix
	 22/pLzZn0FYzFj+oPcLJionYhJJtSWUIii5eJzAwDEBWMsBJAgqK5nthvz/eVa/4Pd
	 SfbAFZNIW1HrDz91YWGM42BhutMFT5GIy5RLEzEyGRYoZ8e5HtcrdA4jt+ageIQWJi
	 OeQelv5oL/aq/KEz2ZBfx5Ox/2qbsK7zNRRQteTOT8gwNDQr5HkzlSAnvgtr9WNTKv
	 eCKyw/DBXUNmesomuw1YMJcPA4V+whYk9LkJ8TQBDT83vh+4NIROGonqJ04rGlU6Rh
	 SpdzWI9rbuF+A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Peter Kaestle <peter@piie.net>,
 platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v3 09/14] platform/x86: acerhdf: Use the .should_bind() thermal zone
 callback
Date: Mon, 19 Aug 2024 18:19:35 +0200
Message-ID: <3779411.MHq7AAxBmi@rjwysocki.net>
In-Reply-To: <2205737.irdbgypaU6@rjwysocki.net>
References: <2205737.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdr
 lhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghrsehpihhivgdrnhgvthdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the acerhdf driver use the .should_bind() thermal zone
callback to provide the thermal core with the information on whether or
not to bind the given cooling device to the given trip point in the
given thermal zone.  If it returns 'true', the thermal core will bind
the cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

The previously existing acerhdf_bind() function bound cooling devices
to thermal trip point 0 only, so the new callback needs to return 'true'
for trip point 0.  However, it is straightforward to observe that trip
point 0 is an active trip point and the only other trip point in the
driver's thermal zone is a critical one, so it is sufficient to return
'true' from that callback if the type of the given trip point is
THERMAL_TRIP_ACTIVE.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---

v2 -> v3: Reorder (previously [12/17]) and add the ACK from Hans

v1 -> v2: No changes

This patch only depends on the [06/14] introducing the .should_bind()
thermal zone callback:

https://lore.kernel.org/linux-pm/9334403.CDJkKcVGEf@rjwysocki.net/

---
 drivers/platform/x86/acerhdf.c |   33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/platform/x86/acerhdf.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/acerhdf.c
+++ linux-pm/drivers/platform/x86/acerhdf.c
@@ -378,33 +378,13 @@ static int acerhdf_get_ec_temp(struct th
 	return 0;
 }
 
-static int acerhdf_bind(struct thermal_zone_device *thermal,
-			struct thermal_cooling_device *cdev)
+static bool acerhdf_should_bind(struct thermal_zone_device *thermal,
+				const struct thermal_trip *trip,
+				struct thermal_cooling_device *cdev,
+				struct cooling_spec *c)
 {
 	/* if the cooling device is the one from acerhdf bind it */
-	if (cdev != cl_dev)
-		return 0;
-
-	if (thermal_zone_bind_cooling_device(thermal, 0, cdev,
-			THERMAL_NO_LIMIT, THERMAL_NO_LIMIT,
-			THERMAL_WEIGHT_DEFAULT)) {
-		pr_err("error binding cooling dev\n");
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static int acerhdf_unbind(struct thermal_zone_device *thermal,
-			  struct thermal_cooling_device *cdev)
-{
-	if (cdev != cl_dev)
-		return 0;
-
-	if (thermal_zone_unbind_cooling_device(thermal, 0, cdev)) {
-		pr_err("error unbinding cooling dev\n");
-		return -EINVAL;
-	}
-	return 0;
+	return cdev == cl_dev && trip->type == THERMAL_TRIP_ACTIVE;
 }
 
 static inline void acerhdf_revert_to_bios_mode(void)
@@ -447,8 +427,7 @@ static int acerhdf_get_crit_temp(struct
 
 /* bind callback functions to thermalzone */
 static struct thermal_zone_device_ops acerhdf_dev_ops = {
-	.bind = acerhdf_bind,
-	.unbind = acerhdf_unbind,
+	.should_bind = acerhdf_should_bind,
 	.get_temp = acerhdf_get_ec_temp,
 	.change_mode = acerhdf_change_mode,
 	.get_crit_temp = acerhdf_get_crit_temp,




