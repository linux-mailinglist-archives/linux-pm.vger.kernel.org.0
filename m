Return-Path: <linux-pm+bounces-12468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4B957068
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3A7283580
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FDB183CDE;
	Mon, 19 Aug 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sQWSJ66h"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB7178383;
	Mon, 19 Aug 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085226; cv=none; b=ik714ULGsbcdDJRW4/1Pj6AvFSb0CcdEq3nzGRqbExQOK1vXv61dOpWA1ZHqmYFGuaQlzEE2zR5Aaeb93ob9+RCNbcSeMtPigRnofPWckzSO6yPE4nLDc+Tx7cngYNRahQ/rFb7aylYq97KiXuEhyS1KWmMrkj/C2rkKRC80rTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085226; c=relaxed/simple;
	bh=tNCLPwbPy7+NsUUokWUM2yzFgCxZGieU4fH+AzMUAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGE7YqBN47G17T+iZGWDedPCkryn9AiYwQE4H4n1WUnytdjriomPCiKHiVv94zG31/U3m+HkrBKuyFMqMjG1uR/tFV26nP/JF8UsjvrXQv+RM5QNdCHxa1L+ENTUywrmE4dkuc65X8YvF/pRpB/cgz2sezCte19ZszG1NV+O+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sQWSJ66h reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 445e84939f0383d5; Mon, 19 Aug 2024 18:33:42 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B3CA973B5D4;
	Mon, 19 Aug 2024 18:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724085222;
	bh=tNCLPwbPy7+NsUUokWUM2yzFgCxZGieU4fH+AzMUAuc=;
	h=From:Subject:Date;
	b=sQWSJ66hLBULiIXQGLdyKiclFQYAnXp/aCesOCperDVAGNVckTl/oPmaWBQQumiCo
	 ej6yoR1ocmG1yJlDzDumMPsGGV4entdH+fICmaMXVBKgAdlgZkPYR2n1Y1Qhd0sXjT
	 daNGMd2XF2fIsIzinQ97D/SodE+AR2thXQmlVf6tW+boAHbWkJGpM9HcwFqnvghQyb
	 31p3ED72LfKQhhKKfd/zxyS90yfkWFuqgTylqQtG6fEDBlQdrOp6jSwBMT8MrB0dQt
	 66+PhH8WT5XCGpDeLlF8Wvy/w9+M0dNVk+Wzn59Ia1BB6G95U8Y9LcEqEHuhzE8cRy
	 fLiWB13rBOa3A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3 11/14] thermal: imx: Use the .should_bind() thermal zone callback
Date: Mon, 19 Aug 2024 18:26:20 +0200
Message-ID: <2485070.jE0xQCEvom@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdr
 lhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the imx_thermal driver use the .should_bind() thermal zone callback
to provide the thermal core with the information on whether or not to
bind the given cooling device to the given trip point in the given
thermal zone.  If it returns 'true', the thermal core will bind the
cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

In the imx_thermal case, it only needs to return 'true' for the passive
trip point and it will match any cooling device passed to it, in
analogy with the old-style imx_bind() callback function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes

This patch only depends on the [06/14] introducing the .should_bind()
thermal zone callback:

https://lore.kernel.org/linux-pm/9334403.CDJkKcVGEf@rjwysocki.net/

---
 drivers/thermal/imx_thermal.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/imx_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/imx_thermal.c
+++ linux-pm/drivers/thermal/imx_thermal.c
@@ -353,24 +353,16 @@ static int imx_set_trip_temp(struct ther
 	return 0;
 }
 
-static int imx_bind(struct thermal_zone_device *tz,
-		    struct thermal_cooling_device *cdev)
+static bool imx_should_bind(struct thermal_zone_device *tz,
+			    const struct thermal_trip *trip,
+			    struct thermal_cooling_device *cdev,
+			    struct cooling_spec *c)
 {
-	return thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
-						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT,
-						THERMAL_WEIGHT_DEFAULT);
-}
-
-static int imx_unbind(struct thermal_zone_device *tz,
-		      struct thermal_cooling_device *cdev)
-{
-	return thermal_zone_unbind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev);
+	return trip->type == THERMAL_TRIP_PASSIVE;
 }
 
 static struct thermal_zone_device_ops imx_tz_ops = {
-	.bind = imx_bind,
-	.unbind = imx_unbind,
+	.should_bind = imx_should_bind,
 	.get_temp = imx_get_temp,
 	.change_mode = imx_change_mode,
 	.set_trip_temp = imx_set_trip_temp,




