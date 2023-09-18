Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE37A4E7A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjIRQS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjIRQSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7EC2444B
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER7-0002Cy-SC; Mon, 18 Sep 2023 15:37:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER7-007Ea2-FC; Mon, 18 Sep 2023 15:37:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER7-002fXu-67; Mon, 18 Sep 2023 15:37:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 32/32] power: supply: wm97xx_battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:37:00 +0200
Message-Id: <20230918133700.1254499-33-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=86lFsZwJMSgVyKKda596lesvIVZT5K3jttAFwX2tjYQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJ1AGE7iQEINiuQce8oMcgQDY0qB8RaCoEzk Nfh900qMX+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSdQAKCRCPgPtYfRL+ TviDB/0Y2buJBBuPbVkRoR334NcCe+R5/30p6dLEmo+kOEi0+UMDOil+iBQyXGf6TrePxSz9dj6 RvC5t+s+fMZZpGzYOSdyh3UHE0Osb5sNgyEgG1nWkUZZykZuWw5Yk0tUwKdDnLIy5tU0/3oV52Y 8GPdnjnQV+tn4A8k3Ou+9GB7o8Vgg6s7USeFSsa84y5VWOzn5nGYjMODOti5jr8HqR3R9KUUFLA mPKkO/c6cUwGK+JNVuYrzfxqWFuxA9Dh6QzxJYEo2cCxarn7oOlJtKCay4IBcKRuXdLMPEQO+FK BezJzVWcqFy27YT9oaHPiXug69nCDRufM5CHI/3bdxtmfMEV
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
 drivers/power/supply/wm97xx_battery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index f4b190adb335..1cc38d1437d9 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -248,14 +248,13 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int wm97xx_bat_remove(struct platform_device *dev)
+static void wm97xx_bat_remove(struct platform_device *dev)
 {
 	if (charge_gpiod)
 		free_irq(gpiod_to_irq(charge_gpiod), dev);
 	cancel_work_sync(&bat_work);
 	power_supply_unregister(bat_psy);
 	kfree(prop);
-	return 0;
 }
 
 static struct platform_driver wm97xx_bat_driver = {
@@ -266,7 +265,7 @@ static struct platform_driver wm97xx_bat_driver = {
 #endif
 	},
 	.probe		= wm97xx_bat_probe,
-	.remove		= wm97xx_bat_remove,
+	.remove_new	= wm97xx_bat_remove,
 };
 
 module_platform_driver(wm97xx_bat_driver);
-- 
2.40.1

