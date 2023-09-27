Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4107B0CAB
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjI0Th5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjI0Th5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF723CC
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-00027H-Qj; Wed, 27 Sep 2023 21:37:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-009PZW-Dm; Wed, 27 Sep 2023 21:37:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-005Rfm-4b; Wed, 27 Sep 2023 21:37:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/31] thermal: hisi: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:12 +0200
Message-Id: <20230927193736.2236447-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QmkKyypbaL25qUAD74DdVSveNBNJDigGxuX69c03uAM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRhdJhjpYZR24BNIW35/To8PLOzEFFmiz3F2 +D1VI4x48WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEYQAKCRCPgPtYfRL+ Tp/JB/wK3cgQw9hHd01JPb1pXOaDv7jLce+nK+2EFd294Lfo8TWbs7HC9gO5mB13YI9F8kGiNMn r8EEiC2/CKjVh43fMEdg4tMpLxHJUWa6utqMfv+t3MX+Nb0LDezyE/7mxcV1nafiMq9a//zaMQb Uqdz2XEboCANOrpmZnrovmnHrXoDk6/IoGJ+W546lRbI4l8q4j4GaJnlRobjng+Q3IGMo+gJcSl FAqd70xhZqeJqVbYSt6pHwquQhyrCrQ1A9okg0/ELCBTSEQXuLSnmvmNY+leGBqsGmHiXB3ealu mScoVkYBeiVmJmfO2+E10+CSnImwzVBQ/Q5p21AO01xcE1/H
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
 drivers/thermal/hisi_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index fb54ed4bf6f0..dd751ae63608 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -597,7 +597,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hisi_thermal_remove(struct platform_device *pdev)
+static void hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
 	int i;
@@ -608,8 +608,6 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 		hisi_thermal_toggle_sensor(sensor, false);
 		data->ops->disable_sensor(sensor);
 	}
-
-	return 0;
 }
 
 static int hisi_thermal_suspend(struct device *dev)
@@ -644,7 +642,7 @@ static struct platform_driver hisi_thermal_driver = {
 		.of_match_table = of_hisi_thermal_match,
 	},
 	.probe	= hisi_thermal_probe,
-	.remove	= hisi_thermal_remove,
+	.remove_new = hisi_thermal_remove,
 };
 
 module_platform_driver(hisi_thermal_driver);
-- 
2.40.1

