Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344077B0CA7
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjI0Th4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI0Thz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:55 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF5CC
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-0002Fi-Bc; Wed, 27 Sep 2023 21:37:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-009Pa1-QR; Wed, 27 Sep 2023 21:37:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-005RgE-F9; Wed, 27 Sep 2023 21:37:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 14/31] thermal: int3406: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:19 +0200
Message-Id: <20230927193736.2236447-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=38pQq7c1wKdStSvs0CLs7r4P6x0wTD05tIJKtm/oIFw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRplBx8Fvb7CKnsPxN7q8iOHOQGwGYqhpIRu SqVAwAOwUeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEaQAKCRCPgPtYfRL+ Tq3RB/41DFMY7/SVJNrsBUjxV4WP7UpPqPQ4qaDswsAWB3wusNRWigfNFYZwWC0jXWSmXhMiE71 US2J7CUDxxXg9u2Q74CGbMmIiFmAQSR2HCGVMEW+ZTair942U0X+zU/9jJk1xc9+6Plia3HfylT gQ3DnUoUzY0ppREZlU1N83dqSVhcaqckTiysQcYSr9SFKnQKhlmYiPIJ4ZQxPcBnZoTDqbI1P2z swiC6FsQW35+E/UZS+3e4gpIZSroY1QiEe1FpE2IvzukOYQ40oqy/hcFJuLOHnIK8iYtnNKPh+P ta2jbHrSp5nZhN4RYKou8VBnUoHC8X3R5l7r0v/WTOYvjcMd
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
 drivers/thermal/intel/int340x_thermal/int3406_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
index f5e42fc2acc0..1c266493c1aa 100644
--- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
@@ -178,13 +178,12 @@ static int int3406_thermal_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
-static int int3406_thermal_remove(struct platform_device *pdev)
+static void int3406_thermal_remove(struct platform_device *pdev)
 {
 	struct int3406_thermal_data *d = platform_get_drvdata(pdev);
 
 	thermal_cooling_device_unregister(d->cooling_dev);
 	kfree(d->br);
-	return 0;
 }
 
 static const struct acpi_device_id int3406_thermal_match[] = {
@@ -196,7 +195,7 @@ MODULE_DEVICE_TABLE(acpi, int3406_thermal_match);
 
 static struct platform_driver int3406_thermal_driver = {
 	.probe = int3406_thermal_probe,
-	.remove = int3406_thermal_remove,
+	.remove_new = int3406_thermal_remove,
 	.driver = {
 		   .name = "int3406 thermal",
 		   .acpi_match_table = int3406_thermal_match,
-- 
2.40.1

