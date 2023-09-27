Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612E37B0CC4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjI0TiF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjI0TiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42973139
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-0002Aw-GC; Wed, 27 Sep 2023 21:37:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-009PZc-Ux; Wed, 27 Sep 2023 21:37:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-005Rfr-LO; Wed, 27 Sep 2023 21:37:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 08/31] thermal: imx8mm: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:13 +0200
Message-Id: <20230927193736.2236447-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mUVyEMnm1z5iVRPYVpjWfXu3Ft1PVpLLqrBfbq28meA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRimN4YY928mB2BDyqjnqj0MdvP+cByGi+40 MxtR705+bSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEYgAKCRCPgPtYfRL+ TibAB/4kXSqElf3s/rvsJAV/HXqK7GgX1K6Qd9U5yi6HdIbIPw95pKlXIzCXGKI1X5Kd67KqwJe tnHyIfuObiJ9gfUiX28z/XzNQpy2HmyMAYRItl21TEPzsQ0H3pLXpZeRA9RBWVsshSIJUdgH1iT Jym7SQvBOnW7RvUdhLlDxACBMvEkiva+1ai1u8a808Qel7gttnjmD9koDeoBksR1bGRXoJvPlHs pz8mLrj1e3Q7UMqaKPymfWzhborzru/uIf4Yi8RYUsdREXIjfzQ/bOZ83Ge0OwI0SqGKE6Q2Xmg hjlanfriowamc5XmpiW6QJkxp1UZ+gJo3Ic6//rFyGSj7rZE
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
 drivers/thermal/imx8mm_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index 14111ccf6e4c..c58fc73c0744 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -363,7 +363,7 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx8mm_tmu_remove(struct platform_device *pdev)
+static void imx8mm_tmu_remove(struct platform_device *pdev)
 {
 	struct imx8mm_tmu *tmu = platform_get_drvdata(pdev);
 
@@ -372,8 +372,6 @@ static int imx8mm_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(tmu->clk);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct thermal_soc_data imx8mm_tmu_data = {
@@ -401,7 +399,7 @@ static struct platform_driver imx8mm_tmu = {
 		.of_match_table = imx8mm_tmu_table,
 	},
 	.probe = imx8mm_tmu_probe,
-	.remove = imx8mm_tmu_remove,
+	.remove_new = imx8mm_tmu_remove,
 };
 module_platform_driver(imx8mm_tmu);
 
-- 
2.40.1

