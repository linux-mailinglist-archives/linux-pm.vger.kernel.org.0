Return-Path: <linux-pm+bounces-11554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CCD93FA5B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63C61F23553
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA15215A85F;
	Mon, 29 Jul 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Z4yZ1g+U"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513E7FBAC;
	Mon, 29 Jul 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269586; cv=none; b=nXcxO18brADzl81WtLvgCGwG3xLLNTVsHuEifIpay7p9tEr9uQcDdDHzjMgjuARmfnT+MKg2QifWORPs7E+R+yHrLrQg+XgrDfNXyM3slI2vZI2RjIVlHvF0SHijyTlf0kUnHxa6+QQeUfO3Fsk/cf/Qr5tZWEpxXnNzjKR3EdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269586; c=relaxed/simple;
	bh=YhOzmfYvlcZjA4hTwOK39buqCfY/OFCyZboei5xPWPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNHwYtsYx5UsSAUz9max9EoAsc6khKTlOJ7djK1jwqCak5WzM3BoPwb2fjFuvZ+amlLW44LWXujbYmQ5vPA7g1SAZSLgRoONX9NEhEspLaICII0odClaA+XG1r1C9UoJv0FEJAkLpDIR/whodgwigK+h06m8kCmDwEhfYgfcGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Z4yZ1g+U reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c1fed086819affd6; Mon, 29 Jul 2024 18:13:01 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2635E77357F;
	Mon, 29 Jul 2024 18:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722269581;
	bh=YhOzmfYvlcZjA4hTwOK39buqCfY/OFCyZboei5xPWPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z4yZ1g+UCTb9UUq+etdxkFtIzne/rob36SC8FyMGyHZ3SblGJH0hHJ6rDATSjyCAg
	 wa8tkzlaJ/k9ahtFpC8u/D2Zz8z5ZcETQ/AySWyWOUO4vPk2DHrIZJMWZIgEa5Zw1a
	 VO7m+zq9f9V1b5bkjhSr5kdrzmFR07dJychs0NFdRNGNRdL04q8mxQjOmruIZ44CjT
	 noNZCT7LfYDtFsSciS+zN7Kpuf8YfoZUO7AdxuFmcyt6pCI4qRaqqGEBttOalinP/m
	 eyT/Gl9soh4uuG8hfDygSqQtTVYKcMtRXLmxAbbmzRwMMHAAvlbGKdCk4nKE7DhVwT
	 PBxj78J+8oYfA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject:
 [RESEND][PATCH v1 1/8] thermal: broadcom: Use thermal_zone_get_crit_temp() in
 bcm2835_thermal_probe()
Date: Mon, 29 Jul 2024 17:53:59 +0200
Message-ID: <3322893.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepfhhlohhr
 ihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprhhjuhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehssghrrghnuggvnhessghrohgruggtohhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the bcm2835 thermal driver to use thermal_zone_get_crit_temp() in
bcm2835_thermal_probe() instead of relying on the assumption that the
critical trip index will always be 0.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/broadcom/bcm2835_thermal.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/broadcom/bcm2835_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/broadcom/bcm2835_thermal.c
+++ linux-pm/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -208,8 +208,7 @@ static int bcm2835_thermal_probe(struct
 	 */
 	val = readl(data->regs + BCM2835_TS_TSENSCTL);
 	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
-		struct thermal_trip trip;
-		int offset, slope;
+		int offset, slope, crit_temp;
 
 		slope = thermal_zone_get_slope(tz);
 		offset = thermal_zone_get_offset(tz);
@@ -217,7 +216,7 @@ static int bcm2835_thermal_probe(struct
 		 * For now we deal only with critical, otherwise
 		 * would need to iterate
 		 */
-		err = thermal_zone_get_trip(tz, 0, &trip);
+		err = thermal_zone_get_crit_temp(tz, &crit_temp);
 		if (err < 0) {
 			dev_err(dev, "Not able to read trip_temp: %d\n", err);
 			return err;
@@ -232,7 +231,7 @@ static int bcm2835_thermal_probe(struct
 		val |= (0xFE << BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
 
 		/*  trip_adc value from info */
-		val |= bcm2835_thermal_temp2adc(trip.temperature,
+		val |= bcm2835_thermal_temp2adc(crit_temp,
 						offset,
 						slope)
 			<< BCM2835_TS_TSENSCTL_THOLD_SHIFT;




