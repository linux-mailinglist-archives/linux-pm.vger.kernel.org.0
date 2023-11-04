Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6697E1121
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjKDVPt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjKDVPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9B5D69
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzb-00081c-8f; Sat, 04 Nov 2023 22:15:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-006e1t-Pi; Sat, 04 Nov 2023 22:15:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-00D1bd-Gk; Sat, 04 Nov 2023 22:15:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 14/14] power: reset: tps65086-restart: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:16 +0100
Message-ID: <20231104211501.3676352-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LSg5gjyDq1wrqMKq1cCWRsWtI99bSUZa0jKD7m2siIM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRmhp2iZHlY+61sJVkE14XGn619lCsTX6VAk tHjL6xK7baJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0ZgAKCRCPgPtYfRL+ ThdrB/4+hU3YOU7qcRffVbSke0Jo7uPa27XKv2AJDbGtNPiRFQsVXtU2tKaneGV7zOp0FeJm7Ja g/WWf7sdhkAUbOA1wPfspSa6M0XkPIEM77Sodq0EaIrKT0sZo5jL+YR1PhvUyGSSKi1vtgNj78C AjCh1yvwmaSMb0qQU3lhkl1UwHJ2xTX3YhXWOR/3kK/zdQJZ3xbsQwtvu508iKmCAXIGAOpLTUz T8c1C3jy/dPkLL2CVNmOfNTW+vqKMQphql3zDSat1rOjjO06zkZlCSxELcpYauwdaJbnpb5g4n6 vFuzUgMbIUFBzqNVMzrHbkzie8qLvJqhhH5IXWamxVwu/a6c
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Returning an error if unregister_restart_handler() failed has no effect
but triggering another error message. So converting this driver to
.remove_new() has no effect but to suppress the duplicated error message.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/reset/tps65086-restart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset/tps65086-restart.c
index 5ec819eac7da..ee8e9f4b837e 100644
--- a/drivers/power/reset/tps65086-restart.c
+++ b/drivers/power/reset/tps65086-restart.c
@@ -62,19 +62,21 @@ static int tps65086_restart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tps65086_restart_remove(struct platform_device *pdev)
+static void tps65086_restart_remove(struct platform_device *pdev)
 {
 	struct tps65086_restart *tps65086_restart = platform_get_drvdata(pdev);
 	int ret;
 
 	ret = unregister_restart_handler(&tps65086_restart->handler);
 	if (ret) {
+		/*
+		 * tps65086_restart_probe() registered the restart handler. So
+		 * unregistering should work fine. Checking the error code
+		 * shouldn't be needed, still doing it for completeness.
+		 */
 		dev_err(&pdev->dev, "%s: cannot unregister restart handler: %d\n",
 			__func__, ret);
-		return -ENODEV;
 	}
-
-	return 0;
 }
 
 static const struct platform_device_id tps65086_restart_id_table[] = {
@@ -88,7 +90,7 @@ static struct platform_driver tps65086_restart_driver = {
 		.name = "tps65086-restart",
 	},
 	.probe = tps65086_restart_probe,
-	.remove = tps65086_restart_remove,
+	.remove_new = tps65086_restart_remove,
 	.id_table = tps65086_restart_id_table,
 };
 module_platform_driver(tps65086_restart_driver);
-- 
2.42.0

