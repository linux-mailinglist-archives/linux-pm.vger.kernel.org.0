Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8F7B0CBF
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjI0TiE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjI0TiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC85E11F
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-0002GC-Mi; Wed, 27 Sep 2023 21:37:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-009Pa8-9z; Wed, 27 Sep 2023 21:37:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-005RgM-0q; Wed, 27 Sep 2023 21:37:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 16/31] thermal: k3_j72xx_bandgap: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:21 +0200
Message-Id: <20230927193736.2236447-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Ai3M3oHtDNp/HL9j7aRsJaftufMla/CdkvmDRQgEQQI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRrCWmgKpKJt4xE47KYpPfMzC4xYYQtt8vJ5 wgLNd6WmLyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEawAKCRCPgPtYfRL+ TiZ2B/wKOwtdAizLf3j0MPniA0eUtXEYahRGBmimzR0Xr9SUhI4OxkYuVbZGTRMvou92aVPfhBz pb1/JcvXF+Vm8c91vgsJXcOsOyuiVr5Jr915Ob3W3X9PqQX3zL/P39X+hczYgLAqroes9XAKYjI 5Z/2mQp1J+wmTcetGNsyXGWMQqmj8IQlryVJDoSlMyq7GQQdQeQAF2w338kseCrY4b5jPXvC3mb kmN74dM8IHI8zqI63L3oU2Qdb1nuk1usTNqslBNRXilTmghcKD8s3p9vWCbRma7QDeooQSwfQh5 XMY4FDzfHqx+OMUA+cBppb6o3NFVeeUGNfzoPnVu5/A40Cfu
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
 drivers/thermal/k3_j72xx_bandgap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 2fc799b07b90..c74094a86982 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -521,12 +521,10 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int k3_j72xx_bandgap_remove(struct platform_device *pdev)
+static void k3_j72xx_bandgap_remove(struct platform_device *pdev)
 {
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct k3_j72xx_bandgap_data k3_j72xx_bandgap_j721e_data = {
@@ -552,7 +550,7 @@ MODULE_DEVICE_TABLE(of, of_k3_j72xx_bandgap_match);
 
 static struct platform_driver k3_j72xx_bandgap_sensor_driver = {
 	.probe = k3_j72xx_bandgap_probe,
-	.remove = k3_j72xx_bandgap_remove,
+	.remove_new = k3_j72xx_bandgap_remove,
 	.driver = {
 		.name = "k3-j72xx-soc-thermal",
 		.of_match_table	= of_k3_j72xx_bandgap_match,
-- 
2.40.1

