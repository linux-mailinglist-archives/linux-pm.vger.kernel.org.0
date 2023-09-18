Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F697A4F1F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjIRQeV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjIRQeL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:34:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8889325ACD
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-0001yT-Ci; Mon, 18 Sep 2023 15:37:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-007EYz-Pb; Mon, 18 Sep 2023 15:37:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-002fWs-Gf; Mon, 18 Sep 2023 15:37:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 16/32] power: supply: lp8788-charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:44 +0200
Message-Id: <20230918133700.1254499-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vruG3hHwLNuGO+rhcyQSr1FrN2aCzwC5edWfN4UfJA0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJib33hVw1j0LE8NR7CK3SnDOi+72DKg5Zzz pdaavJhg/iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSYgAKCRCPgPtYfRL+ Tj8dCACSmI4t0sfgPoBYznDxinSngThl3zShC87Cw/C+gnV3NbOLI3luQA+M2+ObVFoE6Gi3CDI hRfN+kfxJoRs8D5/85i76Mq8g+ve6XQqy8ycQj6hDKbvZNuoqZT1B2ii3Z+tozQ7m7rtc4xzCHK YJ9gkRjEWcNqDS5pDWCm5UJ2H/QibAdwMDlUc5FF0Y5BJnYM76GiLSm7WN9UL7BuOU15fzeMTB+ YdeLRKGfWL2nfJ+3DNe7a/WbQgyAWvmRvHZjBnWFYvd0q8fTkup7Qf2mrygwkrgfYyw8c/8sVXP ZtTWtMSQ6QvlENuslok+YqwNMzxXBS4v+K4QhBcqfL1jO1s3
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
 drivers/power/supply/lp8788-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 755b6a4379b8..2c81be82a41a 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -714,20 +714,18 @@ static int lp8788_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lp8788_charger_remove(struct platform_device *pdev)
+static void lp8788_charger_remove(struct platform_device *pdev)
 {
 	struct lp8788_charger *pchg = platform_get_drvdata(pdev);
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
 	lp8788_psy_unregister(pchg);
-
-	return 0;
 }
 
 static struct platform_driver lp8788_charger_driver = {
 	.probe = lp8788_charger_probe,
-	.remove = lp8788_charger_remove,
+	.remove_new = lp8788_charger_remove,
 	.driver = {
 		.name = LP8788_DEV_CHARGER,
 	},
-- 
2.40.1

