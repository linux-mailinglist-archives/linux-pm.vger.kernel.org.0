Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B627B0CBA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjI0TiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI0TiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4B7114
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-0002OM-LC; Wed, 27 Sep 2023 21:37:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLy-009PaS-Os; Wed, 27 Sep 2023 21:37:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLy-005Rgg-Ff; Wed, 27 Sep 2023 21:37:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 21/31] thermal: rcar: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:26 +0200
Message-Id: <20230927193736.2236447-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MHKv/28ZnDSs6uYa+MjbkeIeuh0ZUJZusecVTIYcnKU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRxh9fubDtTFTH4kW0IjUOVF52b9nhLkZxwp FPKptJwZXyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEcQAKCRCPgPtYfRL+ TiE+B/0d6EBbM3BtHYzSj1FyzSyGPA9x5p83905SQWro7lqSh7IitvUCz6RKvvOu4tmPdXn/mK5 rzHlujPUwp8mshSICKdUR+98zADb72CJUztMg7dRh5YzcimrsOtqwadP7RlXMV/QNT/xcLljQYA 64cyPn07r1oJqrdrhzk7YoDoicBbOStCfLGeU4u3rwksSK2i2dQxC/XwRvWVc3SA+gwbJnaiH9U Boqd64XIsvtTN2pLL9rI6ZUICHYYW9thWKIRJvvyNQWP5KAFcJ0s6FhMBa0+NvBC/Tzn/WVi/5T Jdh27dudsnMNWtKQ0LnWkOp+q7GoSQv9X3slEhaq7+5Fzdkq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 drivers/thermal/rcar_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 293f8dd9fe0a..feb848d595fa 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -371,7 +371,7 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 /*
  *		platform functions
  */
-static int rcar_thermal_remove(struct platform_device *pdev)
+static void rcar_thermal_remove(struct platform_device *pdev)
 {
 	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -388,8 +388,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 static int rcar_thermal_probe(struct platform_device *pdev)
@@ -581,7 +579,7 @@ static struct platform_driver rcar_thermal_driver = {
 		.of_match_table = rcar_thermal_dt_ids,
 	},
 	.probe		= rcar_thermal_probe,
-	.remove		= rcar_thermal_remove,
+	.remove_new	= rcar_thermal_remove,
 };
 module_platform_driver(rcar_thermal_driver);
 
-- 
2.40.1

