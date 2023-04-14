Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4070C6E2906
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDNRMn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDNRMl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 13:12:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA5A422F
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2023 10:12:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnMyU-00038R-2n; Fri, 14 Apr 2023 19:12:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnMyT-00BFRA-CU; Fri, 14 Apr 2023 19:12:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnMyS-00DDlA-MH; Fri, 14 Apr 2023 19:12:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] power: reset: gpio-restart: Convert to platform remove callback returning void
Date:   Fri, 14 Apr 2023 19:12:35 +0200
Message-Id: <20230414171235.3670639-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EgeEC2SEMp7ElwOwajFbe1ymLTTXJtLEpjuU/Mpl2Eg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkOYmC2xuLeV7EWXerVqiy0dwjmrpbHOhgzow8G CTStFfBRwqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZDmJggAKCRCPgPtYfRL+ TvFIB/9zQnxSVQGU7XH35axD2DXZjPmL+rWhQJb04660W9yJtN5vdyIi+7MNVXUyR8uGYdDaA/z Sm6TdlVx4Br8Kv8+/7WwoMVK83SC6/HeonN9VrGitR9y9lxc3xhOcbdykf7+tBIxeIQWj3cJYqF pKawzipfcmFMa7eox7SECPeY9kiDL4hk6NxQ77dqnWYrqZY33L6WV7++lUd9VsZuT3wwEplDTWY Hf7vTKmUgY/gE1Jtcno/TaBKAgfI5H9eRJFygMFeamx4J9zuMRyo7ZUBJ7RgQxJwYXbx7F5yCUy YqhpucLtD7X2T1Z2sZBI11ha4qPSkHKhjyhC/yfH9eDD7WDW
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Returning an error code from a remove callback makes the driver core
emit a generic (and so little helpful) error message and after that the
error code is ignored and the device unbound.

As gpio_restart_remove() already emits an error message, suppressing the
generic error is no loss.

Then convert to .remove_new() which is equivalent to returning 0
unconditionally in .remove(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for its rational.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/reset/gpio-restart.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index 5466eeea261c..28aa152c4869 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -105,7 +105,7 @@ static int gpio_restart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpio_restart_remove(struct platform_device *pdev)
+static void gpio_restart_remove(struct platform_device *pdev)
 {
 	struct gpio_restart *gpio_restart = platform_get_drvdata(pdev);
 	int ret;
@@ -115,10 +115,7 @@ static int gpio_restart_remove(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 				"%s: cannot unregister restart handler, %d\n",
 				__func__, ret);
-		return -ENODEV;
 	}
-
-	return 0;
 }
 
 static const struct of_device_id of_gpio_restart_match[] = {
@@ -128,7 +125,7 @@ static const struct of_device_id of_gpio_restart_match[] = {
 
 static struct platform_driver gpio_restart_driver = {
 	.probe = gpio_restart_probe,
-	.remove = gpio_restart_remove,
+	.remove_new = gpio_restart_remove,
 	.driver = {
 		.name = "restart-gpio",
 		.of_match_table = of_gpio_restart_match,

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

