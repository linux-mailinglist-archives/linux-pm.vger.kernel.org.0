Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB27B0CC1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjI0TiE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjI0TiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CC10A
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM1-0002a1-Tt; Wed, 27 Sep 2023 21:37:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM0-009Pat-VH; Wed, 27 Sep 2023 21:37:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM0-005Rh8-Lj; Wed, 27 Sep 2023 21:37:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 28/31] thermal: soctherm: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:33 +0200
Message-Id: <20230927193736.2236447-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uHVcHD4muj48wU7dFB0AW5fmvDkHoBh8EbeZlIdklcc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIR4xNQwDwkSqNP7b56y0F7eEi1bDNdpRSghz NJgZg2wpVmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEeAAKCRCPgPtYfRL+ TrFmB/9BVMH7cwlUzWiCs3E/AO0ZbkTeUc/Hba5ZmDaXAk2Gj9mL3vN/R3YTC2VmBxrbvEuNUei kwt8uqP6X20RpF1gt5v1/oZj6xad5EOV/r714xDPOXGWvA6HmUUc+HtAkceK/BfuIlnkV+4aUPw CSiAjZ4rcS9z0l95D6PgMRk5jbkpeWe+cG/e8DlQUOybEqpR6wCbC1URj6tPNaVdCG10A1m/qGb Z3X57BFZKwjfnqnZNBq4UwZPytqYO3X5odTjnuIlYgluIJXiu50i0btXQw34wjWgYj6CJwYP3oq UeOAIgS3ys5F0M/585zfX281+ZdiUBelwLlVZhQFIFpf8p7Z
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
 drivers/thermal/tegra/soctherm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ea66cba09e56..e7fe8683bfc5 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -2219,15 +2219,13 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra_soctherm_remove(struct platform_device *pdev)
+static void tegra_soctherm_remove(struct platform_device *pdev)
 {
 	struct tegra_soctherm *tegra = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(tegra->debugfs_dir);
 
 	soctherm_clk_enable(pdev, false);
-
-	return 0;
 }
 
 static int __maybe_unused soctherm_suspend(struct device *dev)
@@ -2274,7 +2272,7 @@ static SIMPLE_DEV_PM_OPS(tegra_soctherm_pm, soctherm_suspend, soctherm_resume);
 
 static struct platform_driver tegra_soctherm_driver = {
 	.probe = tegra_soctherm_probe,
-	.remove = tegra_soctherm_remove,
+	.remove_new = tegra_soctherm_remove,
 	.driver = {
 		.name = "tegra_soctherm",
 		.pm = &tegra_soctherm_pm,
-- 
2.40.1

