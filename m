Return-Path: <linux-pm+bounces-11568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8493FC21
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57B81C21964
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70FD18732C;
	Mon, 29 Jul 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ANtMhLSo"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D417F394;
	Mon, 29 Jul 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273182; cv=none; b=TA8QcFxEErAqRMLZJo3QRyI7DyN1gRgsBSU9UGdEaVutEVbCoby7vixvGrP/gJrJsYOCSlYCxYgGRTls305ZkLKXRMmhF8D95m64O7QKZQvR3eZ1biC3humiuxOksK5ZjDRItEqkXC/FyN3ul9EBgAk/xUbP9f+elk5DuV0W5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273182; c=relaxed/simple;
	bh=W9fxztWsY8J/qfCGKxRWZcy5TPOKWcH2KjAkhuUjsuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+ROkmsAVuWbpIEhFFWWBRj5WjSipBTGEmLc8prOZdqyLeBwUbLf4waO/f9qx/fb0OyDyGRHKXi8AXVzQ2ANkywRL0k9I4OcBYsOoPXjv6Xrqa0lsChJ2zuFFnc3I8cPGybAyyb0PN4UqBCwniu3RH5TBDRRhnKdq+C628jCPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ANtMhLSo reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3d90b8d4e605a3e6; Mon, 29 Jul 2024 18:12:59 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2233E77357F;
	Mon, 29 Jul 2024 18:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269579;
	bh=W9fxztWsY8J/qfCGKxRWZcy5TPOKWcH2KjAkhuUjsuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANtMhLSoPiWkIt2DQJy6WWHeSS/ix0qM4jikJrFVYExarcGtv2NMTrNiB3fn1qZ3H
	 fnDmAWEpKmola6w7sodaGUQNmvsX9eDCdoAdz55c0JxzXxKxXv4gq4LAJgRfgYa19v
	 rVUHgj8HsZ3oYy6cy4yI7hNKhc3EnWfCTV6ikcgSvqMJHL4yHZv9k8Ckf1thU6TRS3
	 +4LYZIB/kqOYBZ3cPDyt4hZcOxDdhGyWBLjFHobGQKB+YNxdd7OhjNUAk51eWCTwkT
	 UbMGWoTrYZ53hQx+QPu5ZOyUQcWnuvRwVqrjeUeoL4yVhr6KAjLm6fOjOQU+2iElOk
	 8YnQ0A5grk3Ug==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 linux-arm-msm@vger.kernel.org
Subject:
 [RESEND][PATCH v1 3/8] thermal: qcom: Use thermal_zone_get_crit_temp() in
 qpnp_tm_init()
Date: Mon, 29 Jul 2024 17:58:56 +0200
Message-ID: <7712228.EvYhyI6sBW@rjwysocki.net>
In-Reply-To: <2211925.irdbgypaU6@rjwysocki.net>
References: <2211925.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprghmihht
 kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhrghrrgdrghhophhinhgrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqmhhsmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify qpnp_tm_init() to use thermal_zone_get_crit_temp() to get the
critical trip temperature instead of iterating over trip indices and
using thermal_zone_get_trip() to get a struct thermal_trip pointer
from a trip index until it finds the critical one.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch does not depend on the previous patch(es) in the series.

---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
===================================================================
--- linux-pm.orig/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -291,24 +291,6 @@ static irqreturn_t qpnp_tm_isr(int irq,
 	return IRQ_HANDLED;
 }
 
-static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
-{
-	struct thermal_trip trip;
-	int i, ret;
-
-	for (i = 0; i < thermal_zone_get_num_trips(chip->tz_dev); i++) {
-
-		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
-		if (ret)
-			continue;
-
-		if (trip.type == THERMAL_TRIP_CRITICAL)
-			return trip.temperature;
-	}
-
-	return THERMAL_TEMP_INVALID;
-}
-
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -343,7 +325,9 @@ static int qpnp_tm_init(struct qpnp_tm_c
 
 	mutex_unlock(&chip->lock);
 
-	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
+	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
+	if (ret)
+		crit_temp = THERMAL_TEMP_INVALID;
 
 	mutex_lock(&chip->lock);
 




