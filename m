Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1C701DF6
	for <lists+linux-pm@lfdr.de>; Sun, 14 May 2023 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjENPVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 May 2023 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjENPVr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 May 2023 11:21:47 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D61984
        for <linux-pm@vger.kernel.org>; Sun, 14 May 2023 08:21:46 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yDXVp1l1EQj3myDXVpoD0z; Sun, 14 May 2023 17:21:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684077703;
        bh=3UV8m4qvroWJvD9DLw5XhRNq9v27vjHdJQsxv5YLPos=;
        h=From:To:Cc:Subject:Date;
        b=Vogqn6AiRBujoyfjW9ehH9+U4nGrvVaXYQ5nteyOzkSvON3usz08mGUD3gBWsyUXn
         ZdqTgwBJiM63afau72MQnx5MN6O/kodUKFf2Q3yvWkkWlKzkRcFHfVZtuD7rTv7kQM
         c/jtVYQ0G5xq0u2yV/D+Yr4Yky5BbrNTzBSgoczCtFZ2u5DmjBzaSKE0cYVkiTb1J7
         xhMWjFGfCG1jlFfrS6+4JZELJULIRfqMeNZTc1ZOYsPSqxW/3ryVMmCOmx9291FLqQ
         Q5GJjSKq2eEFKEddIJAMFjoC9x2lgxyuGJqrEq19Kr/ZmeJEZ4EUyvU1360GjTI8Nq
         dYBLL4BPCg9BQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 May 2023 17:21:43 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()
Date:   Sun, 14 May 2023 17:21:35 +0200
Message-Id: <26f9e3bb3fcd0c12ea24a44c75b7960da993b68b.1684077651.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Should an error occur after calling sun8i_ths_resource_init() in the probe
function, some resources need to be released, as already done in the
.remove() function.

Switch to the devm_clk_get_enabled() helper and add a new devm_action to
turn sun8i_ths_resource_init() into a fully managed function.

This fixes the issue and removes some LoC at the same time.

Fixes: dccc5c3b6f30 ("thermal/drivers/sun8i: Add thermal driver for H6/H5/H3/A64/A83T/R40")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This changes the order of the release functions, but should be fine.
---
 drivers/thermal/sun8i_thermal.c | 43 +++++++++------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..8f4c29bc85aa 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -319,6 +319,11 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	return ret;
 }
 
+static void sun8i_ths_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int sun8i_ths_resource_init(struct ths_device *tmdev)
 {
 	struct device *dev = tmdev->dev;
@@ -339,13 +344,13 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-		tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
 		if (IS_ERR(tmdev->bus_clk))
 			return PTR_ERR(tmdev->bus_clk);
 	}
 
 	if (tmdev->chip->has_mod_clk) {
-		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");
 		if (IS_ERR(tmdev->mod_clk))
 			return PTR_ERR(tmdev->mod_clk);
 	}
@@ -354,32 +359,20 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(tmdev->bus_clk);
+	ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
+				       tmdev->reset);
 	if (ret)
-		goto assert_reset;
+		return ret;
 
 	ret = clk_set_rate(tmdev->mod_clk, 24000000);
 	if (ret)
-		goto bus_disable;
-
-	ret = clk_prepare_enable(tmdev->mod_clk);
-	if (ret)
-		goto bus_disable;
+		return ret;
 
 	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
-		goto mod_disable;
+		return ret;
 
 	return 0;
-
-mod_disable:
-	clk_disable_unprepare(tmdev->mod_clk);
-bus_disable:
-	clk_disable_unprepare(tmdev->bus_clk);
-assert_reset:
-	reset_control_assert(tmdev->reset);
-
-	return ret;
 }
 
 static int sun8i_h3_thermal_init(struct ths_device *tmdev)
@@ -530,17 +523,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun8i_ths_remove(struct platform_device *pdev)
-{
-	struct ths_device *tmdev = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(tmdev->mod_clk);
-	clk_disable_unprepare(tmdev->bus_clk);
-	reset_control_assert(tmdev->reset);
-
-	return 0;
-}
-
 static const struct ths_thermal_chip sun8i_a83t_ths = {
 	.sensor_num = 3,
 	.scale = 705,
@@ -642,7 +624,6 @@ MODULE_DEVICE_TABLE(of, of_ths_match);
 
 static struct platform_driver ths_driver = {
 	.probe = sun8i_ths_probe,
-	.remove = sun8i_ths_remove,
 	.driver = {
 		.name = "sun8i-thermal",
 		.of_match_table = of_ths_match,
-- 
2.34.1

