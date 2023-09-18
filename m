Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAF7A4E89
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjIRQSw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjIRQSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34C2828D
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-0002BX-7Z; Mon, 18 Sep 2023 15:37:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-007EZa-RH; Mon, 18 Sep 2023 15:37:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-002fXS-G6; Mon, 18 Sep 2023 15:37:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 25/32] power: supply: tps65090-charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:53 +0200
Message-Id: <20230918133700.1254499-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=c/R0iiWKUAuxhbZs2UzVuSv3IZQ7onqB4kRUXrgixZg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJt6hBvNJ8nhvTmdZltrD5zsq2rHUjgxzBBT 34N0pmWYa2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSbQAKCRCPgPtYfRL+ TtRlB/9a6P7/6oCcuJ5ewpHApIvsckogDp5vyXYg/1Vdd7wRyz7KWk9hsfAd1uzql8U3DEZ9PyJ YhzCiRTkTola3un5zE7tkwpPUHzIoTzNdAuvJm1bzcxiRJyxjyPaRMlzj+hw/p/5Xqzc1h6qFI/ gkF15XnsQ7luj9QvB+Q30hrylniD5q0J59t42h31Oza5yRA0mpmdH0ZkhgSvL4eZUGG1GyCGiKf yJzeCvtLBF4aWTuWWmUu6dAK/Y7Ens5y1Yc/sBZjZhP3Pf3VCMlOzB+ITA7whrfyfuRUpKDZRN9 pVNN60e340eIFj7ksb68n694QoRK4mGFqJ6zMcg04yeTZszI
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
 drivers/power/supply/tps65090-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index f96c705e0a9f..c59197d2aa87 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -328,15 +328,13 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tps65090_charger_remove(struct platform_device *pdev)
+static void tps65090_charger_remove(struct platform_device *pdev)
 {
 	struct tps65090_charger *cdata = platform_get_drvdata(pdev);
 
 	if (cdata->irq == -ENXIO)
 		kthread_stop(cdata->poll_task);
 	power_supply_unregister(cdata->ac);
-
-	return 0;
 }
 
 static const struct of_device_id of_tps65090_charger_match[] = {
@@ -351,7 +349,7 @@ static struct platform_driver tps65090_charger_driver = {
 		.of_match_table = of_tps65090_charger_match,
 	},
 	.probe	= tps65090_charger_probe,
-	.remove = tps65090_charger_remove,
+	.remove_new = tps65090_charger_remove,
 };
 module_platform_driver(tps65090_charger_driver);
 
-- 
2.40.1

