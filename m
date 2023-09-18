Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CCC7A4F30
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjIRQfc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjIRQfU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:35:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D0216E5
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:14:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-00028K-Py; Mon, 18 Sep 2023 15:37:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-007EZS-Bu; Mon, 18 Sep 2023 15:37:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-002fXK-2y; Mon, 18 Sep 2023 15:37:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 23/32] power: supply: rx51_battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:51 +0200
Message-Id: <20230918133700.1254499-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kt4IFqfKKkCG5RhT/CM6kvvOCQQyrT7zf+d5hrLijmw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJqMwDYLrXWTugpf/tNx+vdtgXDeM1yHvCS2 PH++h7AMEyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSagAKCRCPgPtYfRL+ TqVYCAC1xm4u7aMk163A4dmFDRJuTpoFSquxZKBJXGjZndYVyaF9iA5DVyMcGUqmYBbmUQwGf5k z2vLZddHZHHDUkpi1cLDDBKRaFDwA9PtWsx6y5ZS+aOntudfKR4sw28Ozn+7MtBFlPNfm0dloI7 Oc1W562vgDEGJE6rOxk6HXY6hh4V5yBabqjr8Qg8eR3puVoqgYz4rpVwTIiMie4OWx+3wsRaq2D /cWAGRcR6iV9WiJaUW/SOHtt6PaFFCbVdVh3npDB0FM309IPLx8H9m7nYl/EiKfbAKHL9rQEJfp Fa590jCLg830fzp5Dica5RSklHMO4IKqbvBSBk1jJ1WnGtMI
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
 drivers/power/supply/rx51_battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index 6e488ecf4dcb..e2bfc81f0fd9 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -246,7 +246,7 @@ static int rx51_battery_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rx51_battery_remove(struct platform_device *pdev)
+static void rx51_battery_remove(struct platform_device *pdev)
 {
 	struct rx51_device_info *di = platform_get_drvdata(pdev);
 
@@ -255,8 +255,6 @@ static int rx51_battery_remove(struct platform_device *pdev)
 	iio_channel_release(di->channel_vbat);
 	iio_channel_release(di->channel_bsi);
 	iio_channel_release(di->channel_temp);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -269,7 +267,7 @@ MODULE_DEVICE_TABLE(of, n900_battery_of_match);
 
 static struct platform_driver rx51_battery_driver = {
 	.probe = rx51_battery_probe,
-	.remove = rx51_battery_remove,
+	.remove_new = rx51_battery_remove,
 	.driver = {
 		.name = "rx51-battery",
 		.of_match_table = of_match_ptr(n900_battery_of_match),
-- 
2.40.1

