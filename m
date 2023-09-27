Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607E57B0CAC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjI0Th6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjI0Th5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0A111F
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-00026i-Iw; Wed, 27 Sep 2023 21:37:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-009PZF-3X; Wed, 27 Sep 2023 21:37:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLs-005RfR-QZ; Wed, 27 Sep 2023 21:37:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/31] thermal: armada: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:07 +0200
Message-Id: <20230927193736.2236447-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=k+cR4OPobg88HU9itjRWNVwx8qVomsKJ09hasuCJL0I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRbLarsQFzS63vMzFY/zL8jaFgO498NNYF1z tM2UR06sBaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEWwAKCRCPgPtYfRL+ Tu1sB/4hT8sjotozHbTpWN+m1OB6dz6CUNhst9A1akTsYEJdFn2DgmRjAMQWuEizUFjnE+OGa4m 5uF+kFk99k7pvSpEPxqCBDNlnCfLLWG65c4zgZpCGFtb+xaKE4Yk7eZz/QyGFZ1L61pDjLLAOh0 HnrbmueWh1B1t75Vh9yfZxh1W3Jqtk3sKYa300VVTXV/kF375bnMW7/G1+5Q+5r4YRUaj0Uh26w CHYz6IIe2V5I0GtmZ+GaL3B5kV1Gv16vkfA9eQEyNvrNDIOMNF844l3uw7X8+7ljnauk9J+8Eg+ 735l5jQzMpIV3cJV9DY4AwECAveK/chs1MIBRrJczNJKjN1U
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
 drivers/thermal/armada_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index f00765bfc22e..f783547ef964 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -965,19 +965,17 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int armada_thermal_exit(struct platform_device *pdev)
+static void armada_thermal_exit(struct platform_device *pdev)
 {
 	struct armada_drvdata *drvdata = platform_get_drvdata(pdev);
 
 	if (drvdata->type == LEGACY)
 		thermal_zone_device_unregister(drvdata->data.tz);
-
-	return 0;
 }
 
 static struct platform_driver armada_thermal_driver = {
 	.probe = armada_thermal_probe,
-	.remove = armada_thermal_exit,
+	.remove_new = armada_thermal_exit,
 	.driver = {
 		.name = "armada_thermal",
 		.of_match_table = armada_thermal_id_table,
-- 
2.40.1

