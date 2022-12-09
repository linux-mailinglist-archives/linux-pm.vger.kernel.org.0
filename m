Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75F648553
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiLIP1Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiLIP0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC592309
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:38 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/RjYDNpTEn7ZyaS++C9qKWjzlamSTthuIQ3XjIWVyM=;
        b=NOnxNPzAOTxM00RTljaxxS1YeSxbP1X5b64kj0xKsCcLHWsLR8eovnVbzrt5aFbJaXwPeh
        9Ym7zX9M+UWktDh4ElibaESDI906X+0Fj+k3frFcCYNFZRFZtKUP4lz1ejQvljhUsTDPkc
        9RstrQCtGKSwSVjrC/XPAlrme7lTZbqfCmkfo2S4XR/2H7jV29qLKRLdjMh9Y/LiCQJogr
        WnR3osPZjZyLraE9Gpu/H6e0vUdM2AL4H9hguIf+WjPoIY8bKN1AJWCV4oSMvcjA/FCA3f
        Kq1FASNG1I52yeYWmyINEj7czooLdGdMN+aB+qsxkipdZGl9m1FJK9YH0/oX3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/RjYDNpTEn7ZyaS++C9qKWjzlamSTthuIQ3XjIWVyM=;
        b=NsNu0bo0SdddXSN0kZHdmA9e3/ZE+QqqLWOo7ZlymYe/ojGkYZQgQti0Le/2GjCL1b7mj8
        RUa+O9gD1NHhjBDA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/uniphier: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221003092602.1323944-12-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-12-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959489.4906.1914254461678902578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e6f4c0a03fe1a3bdd8b3f48c91d8f8d42fd8dd6e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e6f4c0a03fe1a3bdd8b3f48c91d8f8d42fd8dd6e
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:44 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/drivers/uniphier: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/20221003092602.1323944-12-daniel.lezcano@linaro.org
---
 drivers/thermal/uniphier_thermal.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4111d99..277ae30 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -248,8 +248,7 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct device_node *parent;
 	struct uniphier_tm_dev *tdev;
-	const struct thermal_trip *trips;
-	int i, ret, irq, ntrips, crit_temp = INT_MAX;
+	int i, ret, irq, crit_temp = INT_MAX;
 
 	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
@@ -296,20 +295,18 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
-	/* get trip points */
-	trips = of_thermal_get_trip_points(tdev->tz_dev);
-	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
-	if (ntrips > ALERT_CH_NUM) {
-		dev_err(dev, "thermal zone has too many trips\n");
-		return -E2BIG;
-	}
-
 	/* set alert temperatures */
-	for (i = 0; i < ntrips; i++) {
-		if (trips[i].type == THERMAL_TRIP_CRITICAL &&
-		    trips[i].temperature < crit_temp)
-			crit_temp = trips[i].temperature;
-		uniphier_tm_set_alert(tdev, i, trips[i].temperature);
+	for (i = 0; i < thermal_zone_get_num_trips(tdev->tz_dev); i++) {
+		struct thermal_trip trip;
+
+		ret = thermal_zone_get_trip(tdev->tz_dev, i, &trip);
+		if (ret)
+			return ret;
+
+		if (trip.type == THERMAL_TRIP_CRITICAL &&
+		    trip.temperature < crit_temp)
+			crit_temp = trip.temperature;
+		uniphier_tm_set_alert(tdev, i, trip.temperature);
 		tdev->alert_en[i] = true;
 	}
 	if (crit_temp > CRITICAL_TEMP_LIMIT) {
