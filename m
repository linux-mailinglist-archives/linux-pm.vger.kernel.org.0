Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C47B0CC9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjI0TiH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjI0TiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230411D
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:38:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-0002K5-5N; Wed, 27 Sep 2023 21:37:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLy-009PaL-8o; Wed, 27 Sep 2023 21:37:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-005RgY-Vi; Wed, 27 Sep 2023 21:37:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 19/31] thermal: tsens: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:24 +0200
Message-Id: <20230927193736.2236447-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wF38ePXpycGwnKKTrEJouU6XGgd+HM2PK8shpxqnqOc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSRlrznDNfEn1+8ukv8Tr/CPr+nqs5yYktqbUOyZ1o/S +7+0dPZyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEvGs5GDbHydjNPfJ0yaOs fh+eaYq3tvBPNlL8//tAtmOFqb9W6JmyBT82tfjrBToHW0Vwm91VfTdxlo6A5v7/mZZ/zCL2Bz6 P1t+pK2PZ9PuNo9L9/gLPeRarCiJj46YW8AU+3WR2c4ZsRuljxu+fhO3fLV+3d3ZNzZZ7DwNTxS ZsWDhlY8Xvna33v84014iK/XLk4tFs/Skn0+dF/Gr1Lf3NN42hPUKj1SEyX9qNKUNjhm2hi6xud 4Tdr/uhQgveSht5Cc+xq3itVRXIuqp7Z1ySk2dG7l+3yZ4secebSwXfX1ZPveV5x0zndqXMmdU5 NRt3/NUIl9wbfqLFwFLjg6FaZo5AWXYfb9msp183LzQAAA==
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
 drivers/thermal/qcom/tsens.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 98c356acfe98..6d7c16ccb44d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1319,7 +1319,7 @@ static int tsens_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tsens_remove(struct platform_device *pdev)
+static void tsens_remove(struct platform_device *pdev)
 {
 	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
@@ -1327,13 +1327,11 @@ static int tsens_remove(struct platform_device *pdev)
 	tsens_disable_irq(priv);
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
-
-	return 0;
 }
 
 static struct platform_driver tsens_driver = {
 	.probe = tsens_probe,
-	.remove = tsens_remove,
+	.remove_new = tsens_remove,
 	.driver = {
 		.name = "qcom-tsens",
 		.pm	= &tsens_pm_ops,
-- 
2.40.1

