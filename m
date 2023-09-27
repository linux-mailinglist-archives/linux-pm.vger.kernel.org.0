Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650977B0CAF
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjI0Th7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjI0Th5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AE110E
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-0002FY-U3; Wed, 27 Sep 2023 21:37:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-009PZw-H0; Wed, 27 Sep 2023 21:37:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-005RgA-7r; Wed, 27 Sep 2023 21:37:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 13/31] thermal: int3403: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:18 +0200
Message-Id: <20230927193736.2236447-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0MerhQGmDalitZpdulcdstr9gjkd2p4h+XjoTEa6GN0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRoUOsjQ5pl73YSi1sV0vZM8JZK1SdtZ644i /MVv8RdhFeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEaAAKCRCPgPtYfRL+ TqiGB/9tige5jRnAmDkMWylbI6qJUnAkD6Fe5/+B44s70pI8tvdxtwooZClOjyrBKBcj2vUjdJ+ s2uIaKopgwDplg5Sxu1taTQwvE57B6JHR45O52a0bREUKhq7Njj8gaB4PlXJjq56svYcSlpT3jH vuCwU3gl8K8WWXshB7Beedm0QkueExXNK8HhQSCzcWOr3lM82BL3Bi+71Z/tuWTwyF5yVU0m7n/ CyNl0haQXTH/bpamOVxwRQUaWAMOBiDGceHEiR8wGosdwTJ1gBBGwwiurCP0e+hnOqxwX51D7Q6 usLb7LMX1pbnIJb7Z+ilv12hP4Yhv0ZXBYN37CkuVURJGbj/
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
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
index e418d270bc76..9b33fd3a66da 100644
--- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
@@ -262,7 +262,7 @@ static int int3403_add(struct platform_device *pdev)
 	return result;
 }
 
-static int int3403_remove(struct platform_device *pdev)
+static void int3403_remove(struct platform_device *pdev)
 {
 	struct int3403_priv *priv = platform_get_drvdata(pdev);
 
@@ -277,8 +277,6 @@ static int int3403_remove(struct platform_device *pdev)
 	default:
 		break;
 	}
-
-	return 0;
 }
 
 static const struct acpi_device_id int3403_device_ids[] = {
@@ -293,7 +291,7 @@ MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
 
 static struct platform_driver int3403_driver = {
 	.probe = int3403_add,
-	.remove = int3403_remove,
+	.remove_new = int3403_remove,
 	.driver = {
 		.name = "int3403 thermal",
 		.acpi_match_table = int3403_device_ids,
-- 
2.40.1

