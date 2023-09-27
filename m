Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE67B0CCC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjI0TiJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjI0TiD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:03 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E80CC
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:38:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-0002DA-Cg; Wed, 27 Sep 2023 21:37:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-009PZj-C3; Wed, 27 Sep 2023 21:37:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-005Rfy-2g; Wed, 27 Sep 2023 21:37:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 10/31] thermal: int3400: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:15 +0200
Message-Id: <20230927193736.2236447-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=f0MASzDeVV0lv01QW50AMw5AQhSIzo7HQTfPqf3ZhaY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRkLIyiscMczvVQql5OsuUI5jhaUc5Mo7sSf 9mTlfJo5KOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEZAAKCRCPgPtYfRL+ TopJB/9rnPwJgyr5kvkdz6m9plvhiJMgXla6mxdZ8vA4GFqvu8CTIOLqS1wSOoEey7oqKYrMLq/ 3sW1FzUMW0HG9dzagQdJyTbaSCqnueiZ5hvVG1USnCTHdZ3M5oAhwjwmrmjZ0QG+NfCK339WPOC zd4+AtqPkUEiMvO8fh64Uv17EjYgIjvVMzHCWRxW1R88iry9ewKMVlqi8Czh3O4Yw9Z8hIZjt79 LQIAWJ0KlxXBNVitnQW4FriseVYuhqQdysKdnQ9818/s1+XKN5FJk4ZpAmOck9Aav+m0Dc5E5jz ASPX7Oqs1cUA0y6C8st3EudRfyPNW4/xIhc9KqMHIx3D8gOS
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
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index ffc2871a021c..427d370648d5 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -674,7 +674,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	return result;
 }
 
-static int int3400_thermal_remove(struct platform_device *pdev)
+static void int3400_thermal_remove(struct platform_device *pdev)
 {
 	struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
 
@@ -698,7 +698,6 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	kfree(priv->trts);
 	kfree(priv->arts);
 	kfree(priv);
-	return 0;
 }
 
 static const struct acpi_device_id int3400_thermal_match[] = {
@@ -714,7 +713,7 @@ MODULE_DEVICE_TABLE(acpi, int3400_thermal_match);
 
 static struct platform_driver int3400_thermal_driver = {
 	.probe = int3400_thermal_probe,
-	.remove = int3400_thermal_remove,
+	.remove_new = int3400_thermal_remove,
 	.driver = {
 		   .name = "int3400 thermal",
 		   .acpi_match_table = ACPI_PTR(int3400_thermal_match),
-- 
2.40.1

