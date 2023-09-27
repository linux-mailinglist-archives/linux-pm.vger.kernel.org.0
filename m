Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624ED7B0CCA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjI0TiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjI0TiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E410A
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:38:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-0002CW-J0; Wed, 27 Sep 2023 21:37:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-009PZf-51; Wed, 27 Sep 2023 21:37:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLu-005Rfu-Rv; Wed, 27 Sep 2023 21:37:42 +0200
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
Subject: [PATCH 09/31] thermal: imx: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:14 +0200
Message-Id: <20230927193736.2236447-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JIWgWjgQcxgcUmIkvSyFyRNOcjLHVmKSuDCyFZytSL8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRj/ojjGoHgLu5uTEzEedFMFbaMLXPjjc+N+ yB48Vp94meJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEYwAKCRCPgPtYfRL+ TseECACK1Dapmfvvg61W64yGE8V/OV71ykkTIYQ4QW3nV4wqwLhS4e47wl++3nX/YXPxJO9VfZt 2ciwZQBLjMgFc+1LZpshvjOdd7ZZxa7lmxXenvegURTs9vrGUFpW95VmsxgUlbMdtA3jEgqKxLn Ek14ocbZuVQZUoS56kYB2H4c6GpjK7iYasLmAmHVsvGI/GYP/qlDQrCVo5fILlxXDygJiuC7DQp JT3zRtU1K5fmH+WSJoXUJhLjLzen44rw5I6w5LPu5S6TwisAMm9Uxv+hXPfR++ypy9CfUFFlxd1 SMzlh+SWhHoAfjY6hxn1FNs3JlvyqXWygmFaN6OdZ6Ksm5m6
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
 drivers/thermal/imx_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 826358cbe810..7019c4fdd549 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -771,7 +771,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_thermal_remove(struct platform_device *pdev)
+static void imx_thermal_remove(struct platform_device *pdev)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
 
@@ -780,8 +780,6 @@ static int imx_thermal_remove(struct platform_device *pdev)
 
 	thermal_zone_device_unregister(data->tz);
 	imx_thermal_unregister_legacy_cooling(data);
-
-	return 0;
 }
 
 static int __maybe_unused imx_thermal_suspend(struct device *dev)
@@ -880,7 +878,7 @@ static struct platform_driver imx_thermal = {
 		.of_match_table = of_imx_thermal_match,
 	},
 	.probe		= imx_thermal_probe,
-	.remove		= imx_thermal_remove,
+	.remove_new	= imx_thermal_remove,
 };
 module_platform_driver(imx_thermal);
 
-- 
2.40.1

