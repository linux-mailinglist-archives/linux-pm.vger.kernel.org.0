Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591FE7B0CB8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjI0TiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjI0Th7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A910E
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM0-0002T6-Kb; Wed, 27 Sep 2023 21:37:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-009Paa-D5; Wed, 27 Sep 2023 21:37:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-005Rgo-3N; Wed, 27 Sep 2023 21:37:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 23/31] thermal: rzg2l: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:28 +0200
Message-Id: <20230927193736.2236447-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Up1lglqpfdf9VLmMWd7Hmz7cVMwrd6pIZicDU3lYJx8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRzy2F6EAlRnmDM7iCbG+GETqZS/kSe4yYUM /yjH+Pr8UOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEcwAKCRCPgPtYfRL+ TlreB/40HEcyLNwWYoFLiX8jB9eDuzrqb3Fo/LSLd3ysFgl/4H927kth6MY9SDQ1uGYupMa4+ea xlxcswOHhKwNVRhOqaBStcurxXiPdt4lAiebRxj4XvDJlL0UN40L5XOdd9ZeUOqH3prcksjg27g 4JZeESW2ryN8x11Kw5EkkT/CQTKyBJPmvYVDLM82ZUnSuuxvzYYyw3wRIxZeKh9Z2c4FgqlhJkz qRUtDw635aFEhjDxxdjHcqSlr3Im6534CGM/MJKF0OaajEOy+Ts+ZrWVo1ATgUoweYDnpFdoCcD e56zG01Q0FqUPhWFgMdINsBkhxEqfO9kXhPJROTsDgJ/OkKE
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
 drivers/thermal/rzg2l_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 6b2bf3426f52..04efd824ac4c 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -150,14 +150,12 @@ static void rzg2l_thermal_reset_assert_pm_disable_put(struct platform_device *pd
 	reset_control_assert(priv->rstc);
 }
 
-static int rzg2l_thermal_remove(struct platform_device *pdev)
+static void rzg2l_thermal_remove(struct platform_device *pdev)
 {
 	struct rzg2l_thermal_priv *priv = dev_get_drvdata(&pdev->dev);
 
 	thermal_remove_hwmon_sysfs(priv->zone);
 	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
-
-	return 0;
 }
 
 static int rzg2l_thermal_probe(struct platform_device *pdev)
@@ -242,7 +240,7 @@ static struct platform_driver rzg2l_thermal_driver = {
 		.of_match_table = rzg2l_thermal_dt_ids,
 	},
 	.probe = rzg2l_thermal_probe,
-	.remove = rzg2l_thermal_remove,
+	.remove_new = rzg2l_thermal_remove,
 };
 module_platform_driver(rzg2l_thermal_driver);
 
-- 
2.40.1

