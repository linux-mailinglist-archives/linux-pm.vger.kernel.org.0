Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A17B0CA8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjI0Th4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjI0Thz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A143610A
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-00026h-H9; Wed, 27 Sep 2023 21:37:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLs-009PZC-RF; Wed, 27 Sep 2023 21:37:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLs-005RfO-Ht; Wed, 27 Sep 2023 21:37:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 01/31] thermal: amlogic: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:06 +0200
Message-Id: <20230927193736.2236447-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2461; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KxL8aBbxeG861TkwND8mWyXQYKx1VJQ+ig1ZgxFPaLE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRalZDbOoWWsVvgInsGRLaQoIOvEjn79XJqE Owea3jLoz+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEWgAKCRCPgPtYfRL+ Tui2CACKbQGRijUIxoCyJCojT3AqP+lOQDd9LzPQ/2t6lYKyiESE/O/CO7WzHbxyWh7XJWr0FpG 3SQS5HOXhfVXGggOqdQSdEERNpKZgdp+6m8KMbejXJwM3DZJdsvTOrF69Gq4akfa7onMCP/XfsW RyqQ0axmobLx7Ez7vKVFWK1eR9zgyjCC4daAytV1Wyc/YzecAB4a0Kw5wDPcdzF+XDHKAenZa4R X/GvYke2HN/ffw4f1OgiRtkdkDo9DVuOk3CWN0vxFIH3E0BAthid87UZImtjwuVtnrydzWDAyL8 1ACUuqRXEazp9lD2/dFtqKj1Ga0t0H5Jp+EIMr3JwATUfF4h
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

amlogic_thermal_disable() always returned zero. Change it to return no
value and then trivially convert the driver to .remove_new() and fix a
whitespace inconsitency en passant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/amlogic_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 81ebbf6de0de..1426f1eb4ac6 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -167,13 +167,11 @@ static int amlogic_thermal_enable(struct amlogic_thermal *data)
 	return 0;
 }
 
-static int amlogic_thermal_disable(struct amlogic_thermal *data)
+static void amlogic_thermal_disable(struct amlogic_thermal *data)
 {
 	regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
 			   TSENSOR_CFG_REG1_ENABLE, 0);
 	clk_disable_unprepare(data->clk);
-
-	return 0;
 }
 
 static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
@@ -291,11 +289,11 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int amlogic_thermal_remove(struct platform_device *pdev)
+static void amlogic_thermal_remove(struct platform_device *pdev)
 {
 	struct amlogic_thermal *data = platform_get_drvdata(pdev);
 
-	return amlogic_thermal_disable(data);
+	amlogic_thermal_disable(data);
 }
 
 static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
@@ -321,8 +319,8 @@ static struct platform_driver amlogic_thermal_driver = {
 		.pm		= &amlogic_thermal_pm_ops,
 		.of_match_table = of_amlogic_thermal_match,
 	},
-	.probe	= amlogic_thermal_probe,
-	.remove	= amlogic_thermal_remove,
+	.probe = amlogic_thermal_probe,
+	.remove_new = amlogic_thermal_remove,
 };
 
 module_platform_driver(amlogic_thermal_driver);
-- 
2.40.1

