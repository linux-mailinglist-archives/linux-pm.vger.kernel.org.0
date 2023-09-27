Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0CC7B0CC2
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjI0TiE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjI0TiB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A37122
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM1-0002WQ-9M; Wed, 27 Sep 2023 21:37:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-009Pai-V0; Wed, 27 Sep 2023 21:37:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLz-005Rgw-Lp; Wed, 27 Sep 2023 21:37:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 25/31] thermal: spear: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:30 +0200
Message-Id: <20230927193736.2236447-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7ZfoAOrL7r9Iqg+bNpE99ULlAAl8RUnI2fFr5kxTDXM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIR1xmkUtGtPVyhnz4rI+z9SHbgbqr6VbIgwr jNYErjqhUOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEdQAKCRCPgPtYfRL+ ThvxB/4ttE4R+sKcJloNwdhPqqmZg78M2JldvYv551oJYo/P4NjOUdQf98znrlgguGiZ+cO7Du1 mDygBUZxdAFHvuYWNjujN0j4KlOyJGvpQzuAQnghiuwdFYzkUGmkmhKNB0S7SlQNkjLDW3lxuYA bLK7hPe5pG3uUd+L9Ju0VtN/V/dvf5OKkI3c9Ydr6RDNkMsVJBJCxz8g25AtlUFe+hkOM8SbYun ISSG6cRhDAtCK4luTnIiayaosYSmm3hGaDXY+2FY5uw3lLSuKuwV/+KUJyV0fqAkI2Xx7BfTuyS 2e6ZUNI7r5/lXbUb2mxpod/Bmxz+PD3hYYS6pqTHO1OWkZvT
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
 drivers/thermal/spear_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 96d99289799a..60a871998b07 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -150,7 +150,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spear_thermal_exit(struct platform_device *pdev)
+static void spear_thermal_exit(struct platform_device *pdev)
 {
 	unsigned int actual_mask = 0;
 	struct thermal_zone_device *spear_thermal = platform_get_drvdata(pdev);
@@ -163,8 +163,6 @@ static int spear_thermal_exit(struct platform_device *pdev)
 	writel_relaxed(actual_mask & ~stdev->flags, stdev->thermal_base);
 
 	clk_disable(stdev->clk);
-
-	return 0;
 }
 
 static const struct of_device_id spear_thermal_id_table[] = {
@@ -175,7 +173,7 @@ MODULE_DEVICE_TABLE(of, spear_thermal_id_table);
 
 static struct platform_driver spear_thermal_driver = {
 	.probe = spear_thermal_probe,
-	.remove = spear_thermal_exit,
+	.remove_new = spear_thermal_exit,
 	.driver = {
 		.name = "spear_thermal",
 		.pm = &spear_thermal_pm_ops,
-- 
2.40.1

