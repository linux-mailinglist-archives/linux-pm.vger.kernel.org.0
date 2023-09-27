Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7657B0CC5
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjI0TiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjI0TiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2220A121
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM1-0002XN-BZ; Wed, 27 Sep 2023 21:37:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM0-009Pal-5b; Wed, 27 Sep 2023 21:37:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-005Rh0-Sc; Wed, 27 Sep 2023 21:37:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 26/31] thermal: sprd: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:31 +0200
Message-Id: <20230927193736.2236447-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FJIeMV+NAgsAAlfJhTgA/L0aMWXEPFUJ+GH6vBCQS0c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIR2yp41cxfM9R8chQgwhQsdcNqG+Zydybtnj BvspXNlYAiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEdgAKCRCPgPtYfRL+ Tt+3B/9RswlpH7IU+7Ig3ar36GBEfnlfhJOkeAD+miKmrcHi9o11xi4PMCZ5Opl09kKjz2qQvbp HrgJhfoqu2fXYf//jSwU37hywICi8B0C+Boq1bqrX83pX1vUZaFjl03K6e2ev7Urwb+On2mjHiX m6StrvUlD255/EWmpPp1g6NEsM0xFXGdCAinXT5Ri/+UUlk+zU11DDtltqpnomA4kHdFtbmG7qh b25GyfoozsXJnxNKj5SLCBM+Z9GOUx5350vb3IwHSigrivbvW7Ry0S1TmoIAIXBoUuSi4ziRgrl 2bn5Fq7N4JfRBnFgCV+6e4XxEhHslK3L504mGiG3iad77U6x
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
 drivers/thermal/sprd_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index e27c4bdc8912..874192546548 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -516,7 +516,7 @@ static int sprd_thm_resume(struct device *dev)
 }
 #endif
 
-static int sprd_thm_remove(struct platform_device *pdev)
+static void sprd_thm_remove(struct platform_device *pdev)
 {
 	struct sprd_thermal_data *thm = platform_get_drvdata(pdev);
 	int i;
@@ -528,7 +528,6 @@ static int sprd_thm_remove(struct platform_device *pdev)
 	}
 
 	clk_disable_unprepare(thm->clk);
-	return 0;
 }
 
 static const struct of_device_id sprd_thermal_of_match[] = {
@@ -543,7 +542,7 @@ static const struct dev_pm_ops sprd_thermal_pm_ops = {
 
 static struct platform_driver sprd_thermal_driver = {
 	.probe = sprd_thm_probe,
-	.remove = sprd_thm_remove,
+	.remove_new = sprd_thm_remove,
 	.driver = {
 		.name = "sprd-thermal",
 		.pm = &sprd_thermal_pm_ops,
-- 
2.40.1

