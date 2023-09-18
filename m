Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8FF7A4E78
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjIRQS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjIRQSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1956426680
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-0001p3-HZ; Mon, 18 Sep 2023 15:37:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-007EYC-4q; Mon, 18 Sep 2023 15:37:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER0-002fW6-Rt; Mon, 18 Sep 2023 15:37:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/32] power: supply: ab8500_fg: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:32 +0200
Message-Id: <20230918133700.1254499-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ADtUmThe7B/F65ZTLF4xh3VmKB7oYD/CHASvC6+n88Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJUTJUC+4ZdUHl4I3O5O3nX+SZhnkxScZVkY m94Y2OAtj2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSVAAKCRCPgPtYfRL+ Tu7rCAC29GVvunBFfaHiqiU3Y0ie0vyzL9MF857j5rJoTjIfW8jt6Ie8tJHaUWgWY3i4dfsnuS6 E41JKSreZZXHjIz7wLtmlvYJ/sgyTid8AK6WqrT83agUPWsthVuJTlwo6RA/hQNMf0WICTd+PdH XKcKLV9V49psYMcsAI/R3zUOvk1Iukud5UzRrnJOfZwcz7IyV51KLly2Tff3P6KXCRiWy1a2dir awlqtHbisepLWvjJ4BRnbvc00PZB3kRVsy/eu5lur52i32gk1VVMyPSxceLTBRhTpDPmuVPpCR5 G8yLd2J6Tq3zSdQE+5cUczXQhbLiybhMyYDc8jUE70q1AnIZ
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
 drivers/power/supply/ab8500_fg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 53560fbb6dcd..8c593fbdd45a 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3227,7 +3227,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	return component_add(dev, &ab8500_fg_component_ops);
 }
 
-static int ab8500_fg_remove(struct platform_device *pdev)
+static void ab8500_fg_remove(struct platform_device *pdev)
 {
 	struct ab8500_fg *di = platform_get_drvdata(pdev);
 
@@ -3236,8 +3236,6 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 	list_del(&di->node);
 	ab8500_fg_sysfs_exit(di);
 	ab8500_fg_sysfs_psy_remove_attrs(di);
-
-	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(ab8500_fg_pm_ops, ab8500_fg_suspend, ab8500_fg_resume);
@@ -3250,7 +3248,7 @@ MODULE_DEVICE_TABLE(of, ab8500_fg_match);
 
 struct platform_driver ab8500_fg_driver = {
 	.probe = ab8500_fg_probe,
-	.remove = ab8500_fg_remove,
+	.remove_new = ab8500_fg_remove,
 	.driver = {
 		.name = "ab8500-fg",
 		.of_match_table = ab8500_fg_match,
-- 
2.40.1

