Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B107B0CA9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjI0Th5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0Th4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3F510E
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-00027A-Iv; Wed, 27 Sep 2023 21:37:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-009PZT-6B; Wed, 27 Sep 2023 21:37:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-005Rfi-TI; Wed, 27 Sep 2023 21:37:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 06/31] thermal: dove: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:11 +0200
Message-Id: <20230927193736.2236447-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EAkFNl1fc/YmI3QCP9+RtHS7shH8VnrEQhLEqsWWxlk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRguQKEgRCnyw8rFT0coBXVUfE9cID6EoujY n/Hc42M9leJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEYAAKCRCPgPtYfRL+ Toz4B/4lGmiuzTkHx/q+ASJRYpPRsv0QhVGwioVNgg0aY4IF8ML9V9hGrVF+lRU0JNPZEl5ioXx fMHf3AT24w9pFh8WWASfYiy6QBV0yUciRoozbZDjZNsmblvwet0Ds56hs6jBg4VliaIj1ew5JDr akqRRQnQbx9htls4inM7usFx1KUsVRTOvBospjJiHzF2EGlNLw3HxsbnB8Jt2TUghtyGhb5Et9D lgOISHwrM2Mjwx0zpVSqQzo66ZJ/Q1/vrm6Bg+qz9KVIaaIovyXnAaoT3y+RgkkIquid7gIqAWG xPNNXTaDHwpFpWQTs66iOiTn06I/GUQ321kNcf9HyImiL10r
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
 drivers/thermal/dove_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 7a18cb960bee..ac30de3c0a5f 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -158,21 +158,19 @@ static int dove_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int dove_thermal_exit(struct platform_device *pdev)
+static void dove_thermal_exit(struct platform_device *pdev)
 {
 	struct thermal_zone_device *dove_thermal =
 		platform_get_drvdata(pdev);
 
 	thermal_zone_device_unregister(dove_thermal);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, dove_thermal_id_table);
 
 static struct platform_driver dove_thermal_driver = {
 	.probe = dove_thermal_probe,
-	.remove = dove_thermal_exit,
+	.remove_new = dove_thermal_exit,
 	.driver = {
 		.name = "dove_thermal",
 		.of_match_table = dove_thermal_id_table,
-- 
2.40.1

