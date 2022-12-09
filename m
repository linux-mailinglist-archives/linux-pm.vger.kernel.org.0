Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B3648542
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiLIP1N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiLIP0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597308E590
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5x7r75E+ABGECTh1rtddWlWWmlfNludr6wbIV2arWic=;
        b=K9gApkGsnUHbGodj53gw5fXgsRbxcbS6zGH77b2RucrGp3O6BiWQkghJGIZzZ4MkLG7uBX
        26zqmgl8mB4DvlXp5jX+u/VIm6VGrInYlO0XORwA4+qSKsiG4bco4NZbmL/0iuUcfTE9nG
        uLhUDw5OKsp+3WkNeIFTEldwdhFtJha0tBxzIBx8PKsoirPheLwleShj2ue5DOHixE/Tf7
        rqBlVQuzolRht3Fp6w/RrMKzjjBOUNgHUuvuRlF6xej1RGOQ09iE46FuKpWXqtLmlQLUyJ
        ThZDsviAyb+meg+rW+9957HMjmc1IpA1+4JbP+zPvyK8fe9jo2nfJB/DtvpgYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5x7r75E+ABGECTh1rtddWlWWmlfNludr6wbIV2arWic=;
        b=d0kxEXpActsJsIgUb7QgJvUxPEuY/8AweOuMTFTNzOvibV6Kk7HWe+DJSlok0PhZGgouDV
        nOdX/8r8dqerTJDg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/da9062: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221003092602.1323944-25-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-25-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959283.4906.9441930628949485343.tip-bot2@tip-bot2>
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

Commit-ID:     401445435b3fc4a65834f0d69fbeef4aff104329
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//401445435b3fc4a65834f0d69fbeef4aff104329
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:57 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/da9062: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Link: https://lore.kernel.org/r/20221003092602.1323944-25-daniel.lezcano@linaro.org
---
 drivers/thermal/da9062-thermal.c | 52 ++++---------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 7dcfde7..a805a66 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -120,44 +120,6 @@ static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
-					int trip,
-					enum thermal_trip_type *type)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*type = THERMAL_TRIP_HOT;
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
-					int trip,
-					int *temp)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*temp = DA9062_MILLI_CELSIUS(125);
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 				   int *temp)
 {
@@ -172,8 +134,10 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 
 static struct thermal_zone_device_ops da9062_thermal_ops = {
 	.get_temp	= da9062_thermal_get_temp,
-	.get_trip_type	= da9062_thermal_get_trip_type,
-	.get_trip_temp	= da9062_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .temperature = DA9062_MILLI_CELSIUS(125), .type = THERMAL_TRIP_HOT },
 };
 
 static const struct da9062_thermal_config da9062_config = {
@@ -228,10 +192,10 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
 	mutex_init(&thermal->lock);
 
-	thermal->zone = thermal_zone_device_register(thermal->config->name,
-					1, 0, thermal,
-					&da9062_thermal_ops, NULL, pp_tmp,
-					0);
+	thermal->zone = thermal_zone_device_register_with_trips(thermal->config->name,
+								trips, ARRAY_SIZE(trips), 0, thermal,
+								&da9062_thermal_ops, NULL, pp_tmp,
+								0);
 	if (IS_ERR(thermal->zone)) {
 		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
 		ret = PTR_ERR(thermal->zone);
