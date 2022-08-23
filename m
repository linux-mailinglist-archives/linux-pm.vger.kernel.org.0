Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE059E6F9
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbiHWQWh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiHWQWK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE5610B517
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:02 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:42:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onDgdsBZCrxQSSAzRBa7bVbR0JNVJs1K0I1LgN4nhIA=;
        b=S1H+7bN3GRPbApW1ozjcF4mAuRp5XOKjhzX7cwZThaV8SXoRo5JVHJH2yevslfNiZ4kW5p
        vt7OQBpJPLi/eB0Fugg7CGHbOQG0IkspSTecxh3z3xHbfqvlCNR26NOsLjOn+bwFUkyPHt
        GYaCZSnKzYNa8rNUfU8tmlpxJlumSG1bC4rOEgHUB5IjHaFxUYeDFpNOI1S4kPOJ4bHYhI
        bHugohmmsFkGQe/FafoeZ05rhrw4cpd1gXTx6IRCEgQeNl2BLzZsfILEWv5q7mRAm+brGV
        BSfpgffQUQNUABajF/sY7Rc+I1qvUYuGsjQt9lnVv4ooikfL5QlWuZ06tv63vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=onDgdsBZCrxQSSAzRBa7bVbR0JNVJs1K0I1LgN4nhIA=;
        b=DMBqcge/v5m6DpP6H1MXnIO6AyXemjGab10Em72xFluLqDd4z5CbtorirqQ4MocbjYNeLw
        oi0QwoJsvb6V2eDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/mtk: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-21-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-21-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125857957.401.11503682050712126516.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     ab7e865db9a54abd775327f87f32f4d0e6e24109
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//ab7e865db9a54abd775327f87f32f4d0e6e24109
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:36 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/mtk: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20220804224349.1926752-21-daniel.lezcano@linexp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/mtk_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94ea..8440692 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -679,9 +679,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	return max;
 }
 
-static int mtk_read_temp(void *data, int *temperature)
+static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 {
-	struct mtk_thermal *mt = data;
+	struct mtk_thermal *mt = tz->devdata;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -700,7 +700,7 @@ static int mtk_read_temp(void *data, int *temperature)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
+static const struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
@@ -1082,8 +1082,8 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-						     &mtk_thermal_ops);
+	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
+					      &mtk_thermal_ops);
 	if (IS_ERR(tzdev)) {
 		ret = PTR_ERR(tzdev);
 		goto err_disable_clk_peri_therm;
