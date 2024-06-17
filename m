Return-Path: <linux-pm+bounces-9370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74C90B95A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D669281877
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A019AD5E;
	Mon, 17 Jun 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Csq0cYDG"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC50199259;
	Mon, 17 Jun 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648000; cv=none; b=lmNWJfbYx07ZlNsA+sZigSsjQdbpmJyzVcPM2rc35uYPce3ieCinH2euLaZqmybp4eUScDvZ32VQ9FrZtNNeKncvgHEG+Gzt+iHsLrAQ/gh5GARSmG6m6akGprZGtSh8qKael7VvbhwFblDgiGyYVWDzvtUlr+mFbH6mB3qJEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648000; c=relaxed/simple;
	bh=GMpY6noSatEwV9A0HB/JNvII77zk0q2g483ov53gPFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5g2sh5A79o1I5Ekj+bJJIyfQWl7nVwntJethTfTtBtwlAmuGYGZ4ipd8LNRLADxqTxChBLPG15J5roRiySBnBYCfPis47mdAZhUGvUr+6UNqhxFpgK62yyCV5ErD3YTXMsfoyVMmFvq+3Y9GAcJKi4N/V5awXpULdGJZAhzTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Csq0cYDG reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 72037722484405de; Mon, 17 Jun 2024 20:13:09 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 236B316606FD;
	Mon, 17 Jun 2024 20:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647989;
	bh=GMpY6noSatEwV9A0HB/JNvII77zk0q2g483ov53gPFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Csq0cYDGtZvTmqKqpvsfext/PPbykb6Nu/wUuLOPh/V3dqXjxgE4JV9pnYah7v/tr
	 ufTj8zLFJ/RmYbwexb14Fu4TMMdwTV2/hmXDMn6pRh7ztJ1frIpcT8t/R6AeC4WfG2
	 h9zNwJGPcO77Tzs0s5MGzNUZX5+6wXdWJYz9S9YORfe+mh0/EGsh6DRDqk2sowBIC2
	 X1KbCVlzBe1HLELagstAuI540he465nKNfL3xqVSstjcqM8C49Drk4Jnkl6HKk7Eg4
	 kYaRsx5IGk2SZisQ5vmww4dQmtkt2N+M2UxM1Yg9B2khCnYNKzaR813c3gmm88kNSP
	 c7b8vIrrCPrjA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thara Gopinath <thara.gopinath@gmail.com>, linux-arm-msm@vger.kernel.org
Subject:
 [PATCH v1 08/14] thermal: qcom: Use thermal_zone_get_crit_temp() in
 qpnp_tm_init()
Date: Mon, 17 Jun 2024 20:00:45 +0200
Message-ID: <3122988.CbtlEUcBR6@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehthhgrrhgrrdhgohhpihhnrghthhesghhmrghilhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify qpnp_tm_init() to use thermal_zone_get_crit_temp() to get the
critical trip temperature instead of iterating over trip indices and
using thermal_zone_get_trip() to get from a trip index to struct
thermal_trip until it finds the critical one.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
 




