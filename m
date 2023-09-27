Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271A7B0CBD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjI0TiD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjI0TiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84E136
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM0-0002Ug-SM; Wed, 27 Sep 2023 21:37:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-009Pae-KJ; Wed, 27 Sep 2023 21:37:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-005Rgs-Al; Wed, 27 Sep 2023 21:37:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 24/31] thermal: exynos_tmu: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:29 +0200
Message-Id: <20230927193736.2236447-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dsnoZztErRYNWr2jU7eLRLQsZSepGY3S0hl8c5LtKzA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIR0TaGGXeMoBxWYJ1msvYfy3UomoULeWg05x o4x+QoASn6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEdAAKCRCPgPtYfRL+ TtvGCACfmjjCslXNoNAEjTNPuJidBY+JAYOn9VRADLcP46dCsssoj6+L1IipPI+RMzpGPG/e0y4 56ncD423YD1HsRiGbXpRFGK8gaz5M1WMrNM8LNq6I2d5k1H73pF3mZqNrv48JgqgPXNluPo6ucv vIVumXOSzZqTAcT8aPnRHD5Gt9iL5ioYrYVqAcmIVHeq5f4jOL1TZzW/7JMZeWzRmUzgqFhJeG0 4FGA0BWU0pobgS75av4ftclcgKJN4QFZT6hsWvoeDAnNp6+YWEUThxGW9MJsSHlPQygpirBW9U/ IOPPHiP4Xlebq1YX2Co52t8yqBgiTCg33fsGe4a+59bt/Eu4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index e5bc2c82010f..123ec81e1943 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1124,7 +1124,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_tmu_remove(struct platform_device *pdev)
+static void exynos_tmu_remove(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 
@@ -1137,8 +1137,6 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1173,7 +1171,7 @@ static struct platform_driver exynos_tmu_driver = {
 		.of_match_table = exynos_tmu_match,
 	},
 	.probe = exynos_tmu_probe,
-	.remove	= exynos_tmu_remove,
+	.remove_new = exynos_tmu_remove,
 };
 
 module_platform_driver(exynos_tmu_driver);
-- 
2.40.1

