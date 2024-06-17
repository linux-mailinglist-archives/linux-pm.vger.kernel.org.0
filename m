Return-Path: <linux-pm+bounces-9357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B482690B93F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388F21C237F4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC26F196C96;
	Mon, 17 Jun 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="wcQOV/Er"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846461990A1;
	Mon, 17 Jun 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647995; cv=none; b=u02fEA1mX+AnvVIhg5Hpr6RUobO4sXU+WrgylBJvzkNL2lDS2Un2XIBfxhCPYQZtELDRlHIQ1mYToJiMBDvK+8X90wl8/MUXXGVQExtQ7nsptPYqoxkqW3hI+1Rhsi2SpZtuCv/Xz4UoFZgTtoIIqhHp8xONH3oGrqka1TEVyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647995; c=relaxed/simple;
	bh=zVmuXawoZOmGPtzxJ5/umElw4loxnxZuF+TKBzVf3Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugNiXipekVQRwR5RvIsb0GGLU0J1RZUWr9PT+eFGqTApXTmoTjwkCpv1OsNoEwJFZJxYZqbEPj7eLRTVPhNJLkaGqIs9wjD454JVeQUaJe8TouUq9baIvm5lthwg/FplV2U3tx/Hb9kdd20PH7idbKSiEDzB+hprG3nOG2pNpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=wcQOV/Er reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id bb0cfa7e74617a10; Mon, 17 Jun 2024 20:13:06 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0100516606FD;
	Mon, 17 Jun 2024 20:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647986;
	bh=zVmuXawoZOmGPtzxJ5/umElw4loxnxZuF+TKBzVf3Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wcQOV/ErQXbDaI/ph7nHLuS27tLyiNY3MKnDqguW8VaDoQnC0e/CLFXZ9hc62ROlD
	 vYBBdX0UnKTkZHmMQNSmuGH44ynAA5xqjeys3UWBlRGoqvHZXcmulOa2WD90pq7bDV
	 iTTJPO1QJUWT8BT1v7HxLrJQgwbROnstkyO7bPiv7M/Kum8kHRiCQh3yFyvARcYNrc
	 jxo4xYckUQLNaGmj25Y9TKsZTtnSIUOxTMfrw5UGPvQZlZ3mt8e7XmFcEi1imTsFfP
	 mbUW0xzWr785HIJNCtdy5WmBZeA2+11f+gqa+BpGeKCI7OlpYxP00hyZmAbc9/GDSn
	 0JJPMOwbMFG7A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject:
 [PATCH v1 12/14] thermal: uniphier: Use thermal_zone_for_each_trip() for
 walking trip points
Date: Mon, 17 Jun 2024 20:07:35 +0200
Message-ID: <2148114.bB369e8A3T@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehhrgihrghshhhirdhkuhhnihhhihhkohesshhotghiohhnvgigthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is generally inefficient to iterate over trip indices and call
thermal_zone_get_trip() every time to get the struct thermal_trip
corresponding to the given trip index, so modify the uniphier thermal
driver to use thermal_zone_for_each_trip() for walking trips.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/uniphier_thermal.c |   37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/uniphier_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/uniphier_thermal.c
+++ linux-pm/drivers/thermal/uniphier_thermal.c
@@ -239,13 +239,32 @@ static irqreturn_t uniphier_tm_alarm_irq
 	return IRQ_HANDLED;
 }
 
+struct trip_walk_data {
+	struct uniphier_tm_dev *tdev;
+	int crit_temp;
+	int index;
+};
+
+static int uniphier_tm_trip_walk_cb(struct thermal_trip *trip, void *arg)
+{
+	struct trip_walk_data *twd = arg;
+
+	if (trip->type == THERMAL_TRIP_CRITICAL &&
+	    trip->temperature < twd->crit_temp)
+		twd->crit_temp = trip->temperature;
+
+	uniphier_tm_set_alert(twd->tdev, twd->index, trip->temperature);
+	twd->tdev->alert_en[twd->index++] = true;
+}
+
 static int uniphier_tm_probe(struct platform_device *pdev)
 {
+	struct trip_walk_data twd = { .crit_temp = INT_MAX, .index = 0 };
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	struct device_node *parent;
 	struct uniphier_tm_dev *tdev;
-	int i, ret, irq, crit_temp = INT_MAX;
+	int i, ret, irq;
 
 	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
@@ -293,20 +312,10 @@ static int uniphier_tm_probe(struct plat
 	}
 
 	/* set alert temperatures */
-	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
-		struct thermal_trip trip;
+	twd.tdev = tdev;
+	thermal_zone_for_each_trip(tdev->tz_dev, uniphier_tm_trip_walk_cb, &twd);
 
-		ret = thermal_zone_get_trip(tdev->tz_dev, i, &trip);
-		if (ret)
-			return ret;
-
-		if (trip.type == THERMAL_TRIP_CRITICAL &&
-		    trip.temperature < crit_temp)
-			crit_temp = trip.temperature;
-		uniphier_tm_set_alert(tdev, i, trip.temperature);
-		tdev->alert_en[i] = true;
-	}
-	if (crit_temp > CRITICAL_TEMP_LIMIT) {
+	if (twd.crit_temp > CRITICAL_TEMP_LIMIT) {
 		dev_err(dev, "critical trip is over limit(>%d), or not set\n",
 			CRITICAL_TEMP_LIMIT);
 		return -EINVAL;




