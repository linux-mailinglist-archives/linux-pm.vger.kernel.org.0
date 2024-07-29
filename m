Return-Path: <linux-pm+bounces-11567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB5F93FC1F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 19:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43986283408
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53301186E39;
	Mon, 29 Jul 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YXFoVlyK"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EB16C874;
	Mon, 29 Jul 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273182; cv=none; b=H1gOr3c99INYSSChKDNYNelQd2JQP2rqquHaPDOhk/ST5UqZZzFgToet6O3wFSkf8o0eYPF6o1uioSyiIVnn8sDO5a+a8zS4lHNeN/LzKNru1m937pce/djzJVW0A1IHLMBQQF4RUVwwpVLl5IhI+AHvW7i7Zy9DE6eg8O6WU4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273182; c=relaxed/simple;
	bh=3tq0jW6brYY3/HGAO1RtDy2uMyLGqloBMMnB3QkGNgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTzSFwr7Fm/q9tEuvuapZAFKNWB/XLKs3BMfGT1XnX6muYAKJAfvysZT2ZYoMz58jQeOpU2f+gbQBuY7qMKGSaqs5TF7EfeQ2ZV/K1BUCOC6Lw8Fe4m2+lbXAaubPVA2Qr+Y6UEDIppIvexPfvJ28he3JV5t/skuB0yaUXACh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YXFoVlyK reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id abcc63eda9c4f667; Mon, 29 Jul 2024 18:12:58 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 11A4077357F;
	Mon, 29 Jul 2024 18:12:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269578;
	bh=3tq0jW6brYY3/HGAO1RtDy2uMyLGqloBMMnB3QkGNgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXFoVlyKpzjZYTlrKoOKzzPrVe7z4+oLi3Vb3NRMf+EvemadDeVVwUo1MVMMMjPKs
	 vwfudqmVRDi0QpXi7DWtG8jfA5JQG6vWgak3y7BCj3u2rBse/QTvADCcQnOossQdit
	 Gk6MlKlv38VBCWZ5GYLwyEQv5R2H6GonO1Wj+ggtlvETpN1gOQS8kRwAaCtqLtBMQa
	 3BDSDSyAY8FJZhJdpbz5VJa63+VY7fkzWnp0yKjz+p/qHfCJFFEOiURCWHWcycGWNl
	 W8BETbU++tMm7uTvaoXMMnvBgR/FRhxJP6lX65mApf/dAcgw9zWr9gD/lt2CeQM0lS
	 fU+4fFK2SJcCA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Subject:
 [RESEND][PATCH v1 4/8] thermal: tegra: Introduce struct trip_temps for
 critical and hot trips
Date: Mon, 29 Jul 2024 18:02:22 +0200
Message-ID: <9333090.CDJkKcVGEf@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepthhhihgv
 rhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnhhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqthgvghhrrgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a helper structure, struct trip_temps, for storing the
temperatures of the critical and hot trip points.

This helps to make the code in tegra_tsensor_get_hw_channel_trips()
somewhat cleaner and will be useful subsequently in eliminating
iteration over trip indices from the driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch does not depend on the previous patch(es) in the series.

---
 drivers/thermal/tegra/tegra30-tsensor.c |   34 ++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
===================================================================
--- linux-pm.orig/drivers/thermal/tegra/tegra30-tsensor.c
+++ linux-pm/drivers/thermal/tegra/tegra30-tsensor.c
@@ -303,8 +303,13 @@ stop_channel:
 	return 0;
 }
 
+struct trip_temps {
+	int hot_trip;
+	int crit_trip;
+};
+
 static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
-					       int *hot_trip, int *crit_trip)
+					       struct trip_temps *temps)
 {
 	unsigned int i;
 
@@ -312,8 +317,8 @@ static void tegra_tsensor_get_hw_channel
 	 * 90C is the maximal critical temperature of all Tegra30 SoC variants,
 	 * use it for the default trip if unspecified in a device-tree.
 	 */
-	*hot_trip  = 85000;
-	*crit_trip = 90000;
+	temps->hot_trip  = 85000;
+	temps->crit_trip = 90000;
 
 	for (i = 0; i < thermal_zone_get_num_trips(tzd); i++) {
 
@@ -322,14 +327,14 @@ static void tegra_tsensor_get_hw_channel
 		thermal_zone_get_trip(tzd, i, &trip);
 
 		if (trip.type == THERMAL_TRIP_HOT)
-			*hot_trip = trip.temperature;
+			temps->hot_trip = trip.temperature;
 
 		if (trip.type == THERMAL_TRIP_CRITICAL)
-			*crit_trip = trip.temperature;
+			temps->crit_trip = trip.temperature;
 	}
 
 	/* clamp hardware trips to the calibration limits */
-	*hot_trip = clamp(*hot_trip, 25000, 90000);
+	temps->hot_trip = clamp(temps->hot_trip, 25000, 90000);
 
 	/*
 	 * Kernel will perform a normal system shut down if it will
@@ -338,7 +343,7 @@ static void tegra_tsensor_get_hw_channel
 	 * shut down gracefully before sending signal to the Power
 	 * Management controller.
 	 */
-	*crit_trip = clamp(*crit_trip + 5000, 25000, 90000);
+	temps->crit_trip = clamp(temps->crit_trip + 5000, 25000, 90000);
 }
 
 static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
@@ -346,7 +351,8 @@ static int tegra_tsensor_enable_hw_chann
 {
 	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
 	struct thermal_zone_device *tzd = tsc->tzd;
-	int err, hot_trip = 0, crit_trip = 0;
+	struct trip_temps temps = { 0 };
+	int err;
 	u32 val;
 
 	if (!tzd) {
@@ -357,24 +363,24 @@ static int tegra_tsensor_enable_hw_chann
 		return 0;
 	}
 
-	tegra_tsensor_get_hw_channel_trips(tzd, &hot_trip, &crit_trip);
+	tegra_tsensor_get_hw_channel_trips(tzd, &temps);
 
 	dev_info_once(ts->dev, "ch%u: PMC emergency shutdown trip set to %dC\n",
-		      id, DIV_ROUND_CLOSEST(crit_trip, 1000));
+		      id, DIV_ROUND_CLOSEST(temps.crit_trip, 1000));
 
-	hot_trip  = tegra_tsensor_temp_to_counter(ts, hot_trip);
-	crit_trip = tegra_tsensor_temp_to_counter(ts, crit_trip);
+	temps.hot_trip  = tegra_tsensor_temp_to_counter(ts, temps.hot_trip);
+	temps.crit_trip = tegra_tsensor_temp_to_counter(ts, temps.crit_trip);
 
 	/* program LEVEL2 counter threshold */
 	val = readl_relaxed(tsc->regs + TSENSOR_SENSOR0_CONFIG1);
 	val &= ~TSENSOR_SENSOR0_CONFIG1_TH2;
-	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG1_TH2, hot_trip);
+	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG1_TH2, temps.hot_trip);
 	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG1);
 
 	/* program LEVEL3 counter threshold */
 	val = readl_relaxed(tsc->regs + TSENSOR_SENSOR0_CONFIG2);
 	val &= ~TSENSOR_SENSOR0_CONFIG2_TH3;
-	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG2_TH3, crit_trip);
+	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG2_TH3, temps.crit_trip);
 	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG2);
 
 	/*




