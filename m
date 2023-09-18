Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F7A7A4E77
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjIRQS0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjIRQSL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FD026682
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-0001zC-TD; Mon, 18 Sep 2023 15:37:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-007EZ7-8V; Mon, 18 Sep 2023 15:37:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-002fX0-Vf; Mon, 18 Sep 2023 15:37:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        linux-pm@vger.kernel.org
Subject: [PATCH 18/32] power: supply: max77650-charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:46 +0200
Message-Id: <20230918133700.1254499-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XOybgwAn2tFly982ZUfG7G7frYaU5FokLnhT2ZIRGqc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJkbaQ2jGwLdIztgbOu6o78NJxHmScK5e/aB HQuIVZEFyWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSZAAKCRCPgPtYfRL+ Ts3oB/4wvuXK7l49rvd/6g7injmlrzZNakOQWDj5Q4NWlYTx4P2V3F65Qg6duo4CkrqYiBMmFXx Whn86bvmt3cMZTjlcxy8kZI7bw5dJL6GPeX6e1M+bMJaBl5q4kzfEAHlFF9CLkdsQKiFdlQ5bXe Pqz9byHrojQeSSNBdj6S3dfs+3THmHFfRSf6OnaRpvdR9XmyHwh1DtIfCm5TTjDvD2XqQoyo520 92mYelxHXOV05cK/ssybWD+dfzVcXe1eIEDH98qUopCgomFyS8QHRk8oJBvvZxPVolr1KwjMaOe zQxrGaFiwD9aryKeUboPVgyWlw02oQ44gQBswfkMv3GVyOc2
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
 drivers/power/supply/max77650-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
index e8c25da40ab2..818e13c613e3 100644
--- a/drivers/power/supply/max77650-charger.c
+++ b/drivers/power/supply/max77650-charger.c
@@ -345,13 +345,11 @@ static int max77650_charger_probe(struct platform_device *pdev)
 	return max77650_charger_enable(chg);
 }
 
-static int max77650_charger_remove(struct platform_device *pdev)
+static void max77650_charger_remove(struct platform_device *pdev)
 {
 	struct max77650_charger_data *chg = platform_get_drvdata(pdev);
 
 	max77650_charger_disable(chg);
-
-	return 0;
 }
 
 static const struct of_device_id max77650_charger_of_match[] = {
@@ -366,7 +364,7 @@ static struct platform_driver max77650_charger_driver = {
 		.of_match_table = max77650_charger_of_match,
 	},
 	.probe = max77650_charger_probe,
-	.remove = max77650_charger_remove,
+	.remove_new = max77650_charger_remove,
 };
 module_platform_driver(max77650_charger_driver);
 
-- 
2.40.1

