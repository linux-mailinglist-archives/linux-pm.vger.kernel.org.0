Return-Path: <linux-pm+bounces-12102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A96F94EF9B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 16:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD6EB22322
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4438C183094;
	Mon, 12 Aug 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="uTb13sjO"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080D17E44F;
	Mon, 12 Aug 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473118; cv=none; b=OwkkN3h7kvyaySSMI7f/KkrjZq23YOKaeFgzxQU/dUjUTMxzA1pKS/pmbUcwY2mm71EJ9EfBT1Pd2aLxfWO9mnJzgmrY4apRE4/6utVqoguluIPGyThwOwyEGUk5NpQ2SQAHQKwx+kax1+aeTegE2xLYhChkYbT/zmSpLkal3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473118; c=relaxed/simple;
	bh=SLCV7npOSjAfEtZPfY3a4gPdLhaG1kYyg0XlHxTO7pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxPYMU1soIMyV3uvrDRcireRhBCppdHxSLKS089RYeRv1xBuI70004JykoagAkBRlwM+f5jL02+wGZlsIeeOmeBBZobE2xwZZgXnt6rsgyEsaJYBbeekwyw3uHTlb8HJv1iqdCCcIhRJcUHr8oRBF9vt9JfdlZBG1Ey5nOX2zPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=uTb13sjO reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 6a0f8b6e6c7b953e; Mon, 12 Aug 2024 16:31:54 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7089E6F0D9D;
	Mon, 12 Aug 2024 16:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1723473113;
	bh=SLCV7npOSjAfEtZPfY3a4gPdLhaG1kYyg0XlHxTO7pk=;
	h=From:Subject:Date;
	b=uTb13sjOQFwdmSry/+O2BAP3n578N55unYxkNfZ8xh6Z8IxAU/FMyUK19Q8b9Jt+Z
	 SEZwsq0SH2gzmVRMo+Yg2fLWQCG8CybGdD9OwNoQzysHkuy5zunS4OHyh9bgHkct1K
	 Arj79Rwmfi4E0s1wiylWe5yMOQc4+5RlhyxNuDw8newAXdPdPzItHxiOCHZ6bRUxnL
	 NNsovnk1Y71hqMWochUb/y6MNu/LP9USjER7sI8DrSySo8re1FqprxI75iHgbGxRhd
	 arXgVopJ78HdpW+Ii3BdSCRY2PcnCPWM0SuDKAAY8Mej35QAJtRRb2HYWbtdAIMVmJ
	 U8/GvdrVj65aA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Peter Kaestle <peter@piie.net>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v2 12/17] platform/x86: acerhdf: Use the .should_bind() thermal zone
 callback
Date: Mon, 12 Aug 2024 16:19:55 +0200
Message-ID: <6709311.4vTCxPXJkl@rjwysocki.net>
In-Reply-To: <114901234.nniJfEyVGO@rjwysocki.net>
References: <114901234.nniJfEyVGO@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucfuphgrmhfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhl
 vgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehpvghtvghrsehpihhivgdrnhgvthdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

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
---

v1 -> v2: No changes

This patch only depends on patch [08/17] introducing .should_bind():

https://lore.kernel.org/linux-pm/2696117.X9hSmTKtgW@rjwysocki.net/

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




