Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91928648556
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiLIP13 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiLIP0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D892310
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:38 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlVrI8/3LTPPOL9pwwU+iG8eByH/xQ+6qH8FVuziYB8=;
        b=zrFfeIBEqFWoMs4Q7bNrvNmRtFNeA2fePaRjEGVJL8k60t+djElqKex1uGz/yTyqpThM/r
        S6+R2bY2cYundcigBUOSz4n1XKNjkDc9EshAvOzjEDPX89ae3O7PsxJfEUfgI7FNoMJ0fE
        YXfNa7tGznVWvj+5oeEca2uv2dh4Yzk8t0udwYOJfCWzcxBlisS1QIPQkNcUbwwmSH4JdE
        1dMM6yPdYoEIMd1uCG//fHnxaFesZIV3nR8k/Ia7MpdYOYYkpy+zU/LDIjAekggyIx/GJ1
        DxSUfQyrODipdnkH6HRF0L9svvpJYjSAV/Lz2olV05WrMAGLBtKPB5VyVHYUiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlVrI8/3LTPPOL9pwwU+iG8eByH/xQ+6qH8FVuziYB8=;
        b=tq9derzKvrkrcaDkzh3i+3siEz/OKXPdWJBYWpp6PbEqZDnIhFHpHco+326lTgTWGKJysM
        BuCZhYI3ygIp6DAA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/exynos: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221003092602.1323944-8-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-8-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959554.4906.5362884647423099440.tip-bot2@tip-bot2>
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

Commit-ID:     169865e317f29456c1f7d58dddb6122e1aefbeee
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//169865e317f29456c1f7d58dddb6122e1aefbeee
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:40 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:42 +01:00

thermal/drivers/exynos: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20221003092602.1323944-8-daniel.lezcano@linaro.org
---
 drivers/thermal/samsung/exynos_tmu.c | 41 ++++++++++-----------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 51874d0..7b609bd 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,16 +260,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tzd);
 	unsigned int status;
-	int ret = 0, temp, hyst;
-
-	if (!trips) {
-		dev_err(&pdev->dev,
-			"Cannot get trip points from device tree!\n");
-		return -ENODEV;
-	}
+	int ret = 0, temp;
 
 	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
 		ret = tzd->ops->get_crit_temp(tzd, &temp);
@@ -303,19 +295,16 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 		/* Write temperature code for rising and falling threshold */
 		for (i = 0; i < ntrips; i++) {
-			/* Write temperature code for rising threshold */
-			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
-			if (ret)
-				goto err;
-			temp /= MCELSIUS;
-			data->tmu_set_trip_temp(data, i, temp);
 
-			/* Write temperature code for falling threshold */
-			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			struct thermal_trip trip;
+
+			ret = thermal_zone_get_trip(tzd, i, &trip);
 			if (ret)
 				goto err;
-			hyst /= MCELSIUS;
-			data->tmu_set_trip_hyst(data, i, temp, hyst);
+
+			data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
+			data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
+						trip.hysteresis / MCELSIUS);
 		}
 
 		data->tmu_clear_irqs(data);
@@ -360,21 +349,23 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 }
 
 static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
+					 int trip_id, u8 temp)
 {
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(data->tzd);
+	struct thermal_trip trip;
 	u8 ref, th_code;
 
-	ref = trips[0].temperature / MCELSIUS;
+	if (thermal_zone_get_trip(data->tzd, 0, &trip))
+		return;
+
+	ref = trip.temperature / MCELSIUS;
 
-	if (trip == 0) {
+	if (trip_id == 0) {
 		th_code = temp_to_code(data, ref);
 		writeb(th_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 	}
 
 	temp -= ref;
-	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip * 4);
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
 }
 
 /* failing thresholds are not supported on Exynos4210 */
