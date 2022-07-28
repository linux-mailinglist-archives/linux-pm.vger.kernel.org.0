Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76E0584356
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiG1Pl5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiG1Pl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085C468DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:56 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqn2BrhshjUeCi875dEucc4Cn69MISEXOC+QHeSMyiU=;
        b=FNBqLPuR08TUQefb+XPVZMORqL0TJFexF2jNVyNir6ds8iu8wya3Btq6xlziT1GScl1W5q
        d8qLAj/IHnVLast7P1Q93pT1f8jTUykuOcZFonmq8phxUdiLzr49w2hgSJbfGpxVVdl6fX
        F0LU3YeZJO/00TRfzQEUgmML6fHJQPHtqGDZrrP+nrAeb4sux3QH1NTgOT/V9KiaWco5Gp
        xQQoW5x0CyVDVoqDKqdKQEGAtcw1G2vqkzXcgiJXg9huHxq9ZqT5wA/AKS6aiFCb/iBDq3
        mlAS40GLB4u20RGLN1Hpfcomu8DVIDrOlh7PV/SFKh32XWBGjEgWnxwqichZlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022914;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqn2BrhshjUeCi875dEucc4Cn69MISEXOC+QHeSMyiU=;
        b=j594XFxA/N4NXJjiasRAFH9Bekg9lEFISg5XMMusoaYQWL90Fho1bHgYMxKqPI60aX/08U
        65rDdTQIe9t6DPAg==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/u8500: Remove the get_trend function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20220616202537.303655-3-daniel.lezcano@linaro.org>
References: <20220616202537.303655-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165902291348.15455.7980934224505888475.tip-bot2@tip-bot2>
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

Commit-ID:     66a0b101efca70097a14aece9c76bc24cd0da119
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//66a0b101efca70097a14aece9c76bc24cd0da119
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 16 Jun 2022 22:25:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:46 +02:00

thermal/drivers/u8500: Remove the get_trend function

The get_trend function relies on the interrupt to set the raising or
dropping trend. However the interpolated temperature is already giving
the temperature information to the thermal framework which is able to
deduce the trend.

Remove the trend code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220616202537.303655-3-daniel.lezcano@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/db8500_thermal.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 21d4d6e..ed40cfd 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -53,7 +53,6 @@ static const unsigned long db8500_thermal_points[] = {
 
 struct db8500_thermal_zone {
 	struct thermal_zone_device *tz;
-	enum thermal_trend trend;
 	unsigned long interpolated_temp;
 	unsigned int cur_index;
 };
@@ -73,24 +72,12 @@ static int db8500_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-/* Callback to get temperature changing trend */
-static int db8500_thermal_get_trend(void *data, int trip, enum thermal_trend *trend)
-{
-	struct db8500_thermal_zone *th = data;
-
-	*trend = th->trend;
-
-	return 0;
-}
-
 static struct thermal_zone_of_device_ops thdev_ops = {
 	.get_temp = db8500_thermal_get_temp,
-	.get_trend = db8500_thermal_get_trend,
 };
 
 static void db8500_thermal_update_config(struct db8500_thermal_zone *th,
 					 unsigned int idx,
-					 enum thermal_trend trend,
 					 unsigned long next_low,
 					 unsigned long next_high)
 {
@@ -98,7 +85,6 @@ static void db8500_thermal_update_config(struct db8500_thermal_zone *th,
 
 	th->cur_index = idx;
 	th->interpolated_temp = (next_low + next_high)/2;
-	th->trend = trend;
 
 	/*
 	 * The PRCMU accept absolute temperatures in celsius so divide
@@ -127,8 +113,7 @@ static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)
 	}
 	idx -= 1;
 
-	db8500_thermal_update_config(th, idx, THERMAL_TREND_DROPPING,
-				     next_low, next_high);
+	db8500_thermal_update_config(th, idx, next_low, next_high);
 	dev_dbg(&th->tz->device,
 		"PRCMU set max %ld, min %ld\n", next_high, next_low);
 
@@ -149,8 +134,7 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 		next_low = db8500_thermal_points[idx];
 		idx += 1;
 
-		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
-					     next_low, next_high);
+		db8500_thermal_update_config(th, idx, next_low, next_high);
 
 		dev_dbg(&th->tz->device,
 			"PRCMU set max %ld, min %ld\n", next_high, next_low);
@@ -210,8 +194,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	dev_info(dev, "thermal zone sensor registered\n");
 
 	/* Start measuring at the lowest point */
-	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
-				     PRCMU_DEFAULT_LOW_TEMP,
+	db8500_thermal_update_config(th, 0, PRCMU_DEFAULT_LOW_TEMP,
 				     db8500_thermal_points[0]);
 
 	platform_set_drvdata(pdev, th);
@@ -232,8 +215,7 @@ static int db8500_thermal_resume(struct platform_device *pdev)
 	struct db8500_thermal_zone *th = platform_get_drvdata(pdev);
 
 	/* Resume and start measuring at the lowest point */
-	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
-				     PRCMU_DEFAULT_LOW_TEMP,
+	db8500_thermal_update_config(th, 0, PRCMU_DEFAULT_LOW_TEMP,
 				     db8500_thermal_points[0]);
 
 	return 0;
