Return-Path: <linux-pm+bounces-9362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A3990B945
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644B01F21010
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE519922C;
	Mon, 17 Jun 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="WnipqxKu"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56831195F13;
	Mon, 17 Jun 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647997; cv=none; b=PWwV7b6cGLZBTRVqHVJBYNwdTKPDDJbvSRjFVNYakafbxFau9Ui07HzE3RHGEpUgNm3JAm5o9C16b35PCOKrrwUPSZokaczBHDd0JIyfeYq3hIZ+5CCS6rFUnpGJ2FC8iGm1pkyjo/AYr6xc2fB6LFEQ3nK10ENGtOisFwmjj6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647997; c=relaxed/simple;
	bh=0o8quFNl+snzTw/PrNw2zVv7v7xQJODcSUW7Bp1SmSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiYdsLkPJPuz+yGSWfBtlGLke8MoH7mI/aYmQ9tkIXwFK+4wzoJU7Mp3j+ADQMKGmzxKzsSHZawmQcO1CedBGFEH87XXzUe7qrPPCLGo869tLy+8OX3cWhYYrWzNqEkQEY23ganUVz/h3k1r0FVud+2N6Q1cSDxTCk0B/GLIlCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=WnipqxKu reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 50f3cb3e75eff61e; Mon, 17 Jun 2024 20:13:11 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B836F16606FD;
	Mon, 17 Jun 2024 20:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647991;
	bh=0o8quFNl+snzTw/PrNw2zVv7v7xQJODcSUW7Bp1SmSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnipqxKuEB1X+sNosxj0N4y5jdpwVG6x5ojlKEBEiw2fGnFWFbcGC9BfbSVVSnv5s
	 /jO+gJv9fqOvJpGZdChvvKaEL16DTeRuDoLmYpIyqMMc58Y5QDYLODbrl1ODJGW8wf
	 nvnMDyY6q3OzlwrTsToxApqX+cKX7OhS3W+uJjYiwIHH/kWDStjJsXgg6MSeQtsa9W
	 Bnlyg+Zp0fXiMBMvXy6AXVbFKDyu8cEKDicBGh8vPnsxisoyHSgJi5kC3uJ78Q29wM
	 QumRSH4ls4Dw2TrKULEOE2XAtprCcP5bqoFg9yDZB9oWSThiA2+OkRElQ9sJeEvW5S
	 u5Wh+r5N7nNxg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, linux-rpi-kernel@lists.infradead.org
Subject:
 [PATCH v1 06/14] thermal: broadcom: Use thermal_zone_get_crit_temp() in
 bcm2835_thermal_probe()
Date: Mon, 17 Jun 2024 19:57:04 +0200
Message-ID: <4249046.1IzOArtZ34@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 lhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

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
@@ -222,8 +222,7 @@ static int bcm2835_thermal_probe(struct
 	 */
 	val = readl(data->regs + BCM2835_TS_TSENSCTL);
 	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
-		struct thermal_trip trip;
-		int offset, slope;
+		int offset, slope, crit_temp;
 
 		slope = thermal_zone_get_slope(tz);
 		offset = thermal_zone_get_offset(tz);
@@ -231,7 +230,7 @@ static int bcm2835_thermal_probe(struct
 		 * For now we deal only with critical, otherwise
 		 * would need to iterate
 		 */
-		err = thermal_zone_get_trip(tz, 0, &trip);
+		err = thermal_zone_get_crit_temp(tz, &crit_temp);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Not able to read trip_temp: %d\n",
@@ -248,7 +247,7 @@ static int bcm2835_thermal_probe(struct
 		val |= (0xFE << BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
 
 		/*  trip_adc value from info */
-		val |= bcm2835_thermal_temp2adc(trip.temperature,
+		val |= bcm2835_thermal_temp2adc(crit_temp,
 						offset,
 						slope)
 			<< BCM2835_TS_TSENSCTL_THOLD_SHIFT;




