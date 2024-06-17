Return-Path: <linux-pm+bounces-9365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B751590B94E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3827D1F21994
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4FC19A281;
	Mon, 17 Jun 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="tluoamCu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B71991BA;
	Mon, 17 Jun 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647999; cv=none; b=XzZDexAOOuknQSUusDE+TyxJz/fFrfLEH9lLyqziIaZhma+Q2Ei/VSrRsUYPzxAZyEeYlYB2FDB9H7bBHDgmSXnY4IEWSnkIKsoe/VvIRk8aFapCbq/Ml5kfrgFFDGj0z3dtISiCn4x26yAYgii73mipPoY21yRzmYM6ljZsl28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647999; c=relaxed/simple;
	bh=7mdftKfiva4yGQi7egcP+5WH/goOfxgEbPUdP8Gm38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t413cva7PBFKcaHMyleRtmqyhCTu5MrRGUiZB/zf/VMXyLM6vibSlWCbTSJ7L+16j4ovivdv6/VwNLsePklGkekGbz1ytzwYSwdE/BxCQmN34PPtqx3xLiI4eq+3J01Rx2vw/Hw/9sJ8vVVyfZcrNqTjzGI+aWVOf6GxWqWO9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=tluoamCu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 2802260fd3be30fa; Mon, 17 Jun 2024 20:13:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5D93F16606FD;
	Mon, 17 Jun 2024 20:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647988;
	bh=7mdftKfiva4yGQi7egcP+5WH/goOfxgEbPUdP8Gm38A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tluoamCuWUD0K/C0A7uy6JSXNF6o752y8UYiX6jVTIOo9Nl+kvgckzX/dw4VTizVL
	 cuBG4COwRWM9cS1oYnFU+3S1OhboFbzgZd68PDikfT0O1J7sqMOq5tVSuigAbCXMdF
	 JM+fec0o0wZ5iwBsNgeno5qnmZsn721IPnOQhqDObscwCS6Q3L4sDVyWXUr4Z8YURz
	 n33H3M9NsUHxM8XY1FB1QK7EOTKTeO4ojk8Vj8z8WW1J6aaB5lkEP9KXTK9ptd64B+
	 oU7vg+4F9SxQ3flRtNK4xN9zdqr6kfmePZ8fda/ie9ydcu8/3K0yZyav5DypD2CPwd
	 deNofIc6Uoevg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Subject:
 [PATCH v1 09/14] thermal: tegra: Introduce struct trip_temps for critical and
 hot trips
Date: Mon, 17 Jun 2024 20:02:50 +0200
Message-ID: <5022394.0VBMTVartN@kreacher>
In-Reply-To: <8409966.T7Z3S40VBb@kreacher>
References: <8409966.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehthhhivghrrhihrdhrvgguihhnghesghhmrghilhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a helper structure, struct trip_temps, for storing the
temperatures of the critical and hot trip points.

This helps to make the code in tegra_tsensor_get_hw_channel_trips()
somewhat cleaner and will be useful subsequently in eliminating
iteration over trip indices from the driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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




