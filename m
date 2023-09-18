Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC07A4F37
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjIRQgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjIRQfk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:35:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F724459
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-0002C7-S6; Mon, 18 Sep 2023 15:37:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-007EZm-Fb; Mon, 18 Sep 2023 15:37:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-002fXe-6f; Mon, 18 Sep 2023 15:37:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 28/32] power: supply: twl4030_madc_battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:56 +0200
Message-Id: <20230918133700.1254499-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=c7b6a/yY2cHhQhAalJOkOIPM4z4s53ZS49MhjTzEN3Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJwWoX9w3SzcTHNkAb83mg23R0vf7noeVIDt SczjDeMIXGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhScAAKCRCPgPtYfRL+ Tk7QCACjJLf472fwBGwJcK3X4nuLJoGi4Nr7HLE83jEhwrTleqIkKoEoMXnvht4D5yYL3435BMG c538WpkxgF8sESxvyDAgTww9BRwHVvPKmyOIOqSe01bCEtVU3YZ7ek7HYPdF/glE2ZUitZfHTNl EmkRme6JeyFN6SGWKGvVs3uY/4yVMfzHQSpIH2y6N3PJIQL0iJOo6J1FYEm8yZDNfRIrw3H4WSp pP/pAnDMMREskwvMzpWF+SOirPsRrh+EpbF5GUbo2RbslAvesKHzHH09oD/Hppt0+OchDdjLGS8 rrsFjtFjRLGUpHHIFRZzYD4Z65MG7EjwOGhJaXmPwFMNlkYD
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/supply/twl4030_madc_battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index 7fe029673b22..33106476bea2 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -244,7 +244,7 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int twl4030_madc_battery_remove(struct platform_device *pdev)
+static void twl4030_madc_battery_remove(struct platform_device *pdev)
 {
 	struct twl4030_madc_battery *bat = platform_get_drvdata(pdev);
 
@@ -253,8 +253,6 @@ static int twl4030_madc_battery_remove(struct platform_device *pdev)
 	iio_channel_release(bat->channel_vbat);
 	iio_channel_release(bat->channel_ichg);
 	iio_channel_release(bat->channel_temp);
-
-	return 0;
 }
 
 static struct platform_driver twl4030_madc_battery_driver = {
@@ -262,7 +260,7 @@ static struct platform_driver twl4030_madc_battery_driver = {
 		.name = "twl4030_madc_battery",
 	},
 	.probe  = twl4030_madc_battery_probe,
-	.remove = twl4030_madc_battery_remove,
+	.remove_new = twl4030_madc_battery_remove,
 };
 module_platform_driver(twl4030_madc_battery_driver);
 
-- 
2.40.1

