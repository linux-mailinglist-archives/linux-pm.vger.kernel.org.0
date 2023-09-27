Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE907B0CAA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjI0Th5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI0Th4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B0114
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-000273-Lk; Wed, 27 Sep 2023 21:37:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-009PZQ-U1; Wed, 27 Sep 2023 21:37:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-005Rfe-KT; Wed, 27 Sep 2023 21:37:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 05/31] thermal: da9062: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:10 +0200
Message-Id: <20230927193736.2236447-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7YtKZQkT5oSffBLlg7apf/UmsPAwRfzLo7tOsDSSduQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRfm6R5vg+T3vI1QuOBs2yJvM/CHF2/PefT7 l+JIntDIlKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEXwAKCRCPgPtYfRL+ TiLwB/4xlNtIrd4d33pWnvwWOximzbp30nbhhwI27Eo+438wQAJg3B+RIkxXiF9WaIYmqXriz7M DhrdU4p6J+3/iHHHyNtsH4sxPmsRt9U8oNrG1YkGMYMOnbnYsBvs5jLQtfN0BV1Yxd6TOhC86MT AmX9T2oKN8DdpbiczZSmTJR2GSDOx11eKBOBjmqKFuA1JIP8vkVwCpA1/FdC0w0bihru+fMacyX 4XibD+OcrlAgK6I7CgGydr/E1IxhIjeIcV9m5rJ5+bOk6qecihnIzER9aoM5YRdu71R7GXMpuG5 dYisTyX6sBK47FzdtSa9PCLIzAI76lXCf83zEH4Azoiyi66e
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
 drivers/thermal/da9062-thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 2d31b1f73423..160d64913057 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -239,19 +239,18 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int da9062_thermal_remove(struct platform_device *pdev)
+static void da9062_thermal_remove(struct platform_device *pdev)
 {
 	struct	da9062_thermal *thermal = platform_get_drvdata(pdev);
 
 	free_irq(thermal->irq, thermal);
 	cancel_delayed_work_sync(&thermal->work);
 	thermal_zone_device_unregister(thermal->zone);
-	return 0;
 }
 
 static struct platform_driver da9062_thermal_driver = {
 	.probe	= da9062_thermal_probe,
-	.remove	= da9062_thermal_remove,
+	.remove_new = da9062_thermal_remove,
 	.driver	= {
 		.name	= "da9062-thermal",
 		.of_match_table = da9062_compatible_reg_id_table,
-- 
2.40.1

