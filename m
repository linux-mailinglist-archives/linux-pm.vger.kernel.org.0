Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E7B7336EB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbjFPQ7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 12:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbjFPQ6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 12:58:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C94C0D
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 09:56:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qACkd-0000qZ-O5; Fri, 16 Jun 2023 18:56:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qACkc-007rUd-V4; Fri, 16 Jun 2023 18:56:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qACkc-00Eout-4r; Fri, 16 Jun 2023 18:56:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] thermal: stm32: Convert to platform remove callback returning void
Date:   Fri, 16 Jun 2023 18:56:41 +0200
Message-Id: <20230616165641.1055854-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Io5r47Fy66xnYmnYXEj7eBPGn8UdcRZCBtMEpByPJmo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkjJRIZUOqSLsE/L7h8YebYRnf5s1iS7MI5Saa6 TcLzko8k7CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZIyUSAAKCRCPgPtYfRL+ TstYB/9vwvek/4zccTwW0thpmGcpk+bgYNFLC541ttZm/XGG+7BXbYC8EWiCQq8lkhzjiU3m32L q74jdtmDgW8b9+JUIVw2ggYaPUQJWKPGxGbJ4ClfHFYMPFa+Xe1hJYloOAr9T0LGYi1acpsJE+n /GmIque8bvNrPlQZWmaBDJlVhGVGSx3xTKdKO58R7Sy6ZLIY27Gcfz5Kz3rlmo7B0NDXZuxSXkq 4uNGX4PjjB0xtmAd37V5reA2O/1Dq8WzVz4D0iwLOiaLIy9UwJhwQDYKBs9tNav96VENuSadAxv u4fkNbSGE2mYj0UfjwgcGZFrFcjmzRi2cI8qkB6zOfAuDS0T
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code.  However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

st_thermal_unregister() always returned zero, so convert it to return void
without any loss and then just drop the return from st_mmap_remove().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/st/st_thermal.c        | 4 +---
 drivers/thermal/st/st_thermal.h        | 2 +-
 drivers/thermal/st/st_thermal_memmap.c | 6 +++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 2d3042098445..0d6249b36609 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -227,14 +227,12 @@ int st_thermal_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(st_thermal_register);
 
-int st_thermal_unregister(struct platform_device *pdev)
+void st_thermal_unregister(struct platform_device *pdev)
 {
 	struct st_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	st_thermal_sensor_off(sensor);
 	thermal_zone_device_unregister(sensor->thermal_dev);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(st_thermal_unregister);
 
diff --git a/drivers/thermal/st/st_thermal.h b/drivers/thermal/st/st_thermal.h
index d661b2f2ef29..75a84e6ec6a7 100644
--- a/drivers/thermal/st/st_thermal.h
+++ b/drivers/thermal/st/st_thermal.h
@@ -94,7 +94,7 @@ struct st_thermal_sensor {
 
 extern int st_thermal_register(struct platform_device *pdev,
 			       const struct of_device_id *st_thermal_of_match);
-extern int st_thermal_unregister(struct platform_device *pdev);
+extern void st_thermal_unregister(struct platform_device *pdev);
 extern const struct dev_pm_ops st_thermal_pm_ops;
 
 #endif /* __STI_RESET_SYSCFG_H */
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index d68596c40be9..e8cfa83b724a 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -172,9 +172,9 @@ static int st_mmap_probe(struct platform_device *pdev)
 	return st_thermal_register(pdev,  st_mmap_thermal_of_match);
 }
 
-static int st_mmap_remove(struct platform_device *pdev)
+static void st_mmap_remove(struct platform_device *pdev)
 {
-	return st_thermal_unregister(pdev);
+	st_thermal_unregister(pdev);
 }
 
 static struct platform_driver st_mmap_thermal_driver = {
@@ -184,7 +184,7 @@ static struct platform_driver st_mmap_thermal_driver = {
 		.of_match_table = st_mmap_thermal_of_match,
 	},
 	.probe		= st_mmap_probe,
-	.remove		= st_mmap_remove,
+	.remove_new	= st_mmap_remove,
 };
 
 module_platform_driver(st_mmap_thermal_driver);

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

