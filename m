Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79197B0CB0
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjI0Th7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjI0Th6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF9D121
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLy-0002GP-5C; Wed, 27 Sep 2023 21:37:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-009PaD-K3; Wed, 27 Sep 2023 21:37:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-005RgQ-AS; Wed, 27 Sep 2023 21:37:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 17/31] thermal: kirkwood: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:22 +0200
Message-Id: <20230927193736.2236447-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tVq2dAYs4tf1+BIyTEw2zU/ZuuOoCmGqN0zw0lsXsA8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRsgTYHyXBp7i9fQo7xL4uEN2IpHz6sbowTj N8GBeQPU6aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEbAAKCRCPgPtYfRL+ TlpyB/wJ+nm1kpsI/Snx1m9E2l05gXJ4DP+4gtrScvIgmusZ68ErxrnDxss4o7eHvRFVmzX+2nZ 9IyJCu9YqBAG0XhnNtvI+bcogsEqGuqklLepllJtY0AvQ4mB7aHTuMxuVy+/PBmYQ2npUfxWJ6n 7NuHFq9D3/1KWpiq3ZbgHG2Kem7CCY6ph/D3he+TF8q0X5TjyPlwymEwEu7wqPxaO3ruYds8UE8 q3BCeHVMR+XkGmfoDFxoxqFun3eN46l/V9SrovPH08ZkpbFoWzV8qVRm3H5Ux2ZlscgQfGTPs7e mAX638YhkEUFdKqe3YuAlRDoTfc0KfC2GLMKR77VyZOGnPff
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
 drivers/thermal/kirkwood_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index acb10d24256d..a18158ebe65f 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -90,21 +90,19 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int kirkwood_thermal_exit(struct platform_device *pdev)
+static void kirkwood_thermal_exit(struct platform_device *pdev)
 {
 	struct thermal_zone_device *kirkwood_thermal =
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(kirkwood_thermal);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, kirkwood_thermal_id_table);
 
 static struct platform_driver kirkwood_thermal_driver = {
 	.probe = kirkwood_thermal_probe,
-	.remove = kirkwood_thermal_exit,
+	.remove_new = kirkwood_thermal_exit,
 	.driver = {
 		.name = "kirkwood_thermal",
 		.of_match_table = kirkwood_thermal_id_table,
-- 
2.40.1

