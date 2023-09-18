Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA417A4E87
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjIRQSv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjIRQSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2622828C
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-0001pK-O6; Mon, 18 Sep 2023 15:37:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-007EYF-BT; Mon, 18 Sep 2023 15:37:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-002fWA-2F; Mon, 18 Sep 2023 15:37:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 05/32] power: supply: acer_a500_battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:33 +0200
Message-Id: <20230918133700.1254499-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RVvqO+ymhWgSeh8g6agtGal0Qe2LXfVnXpY96cOmFRI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJVUc6mQe3t+89eg4IqcIjIBtrUxbpMmQ4M2 59hAGAKxMqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSVQAKCRCPgPtYfRL+ Tki6CACt+jpHoZ3YsldR2QCv6sUau6bIX1BpKpysro0cnAEV48PkSjPd3D5CVrHhCtJ2VBp8t0y k+mKibkestjGQQeTMJevfquT6N+HEXgkHONO4aj2rPXUFYv1RvkJIteMv5IbSc0808rO1j597DF j4IEd7N2W5oCRKjH43/BE0WxGSIAZy8G82cc0OE/Wo8Lup/G9nTGNF31NnKkLcq6cTqcm9TCw52 bnqv6mAVsowx9FDKLJmtUHJJBUoXwTsDw+cxXeb0FtyFNYqSvcISmVA85TPb+qrz4TLTEcjAAxc Y7jR2YVMDZ4/32Tk99Qvz0nSsHCpk0HonlPt+8dmnn3YrlR+
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/supply/acer_a500_battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/supply/acer_a500_battery.c
index 32a0bfcac08f..ef5c419b1b7f 100644
--- a/drivers/power/supply/acer_a500_battery.c
+++ b/drivers/power/supply/acer_a500_battery.c
@@ -251,13 +251,11 @@ static int a500_battery_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int a500_battery_remove(struct platform_device *pdev)
+static void a500_battery_remove(struct platform_device *pdev)
 {
 	struct a500_battery *bat = dev_get_drvdata(&pdev->dev);
 
 	cancel_delayed_work_sync(&bat->poll_work);
-
-	return 0;
 }
 
 static int __maybe_unused a500_battery_suspend(struct device *dev)
@@ -287,7 +285,7 @@ static struct platform_driver a500_battery_driver = {
 		.pm = &a500_battery_pm_ops,
 	},
 	.probe = a500_battery_probe,
-	.remove = a500_battery_remove,
+	.remove_new = a500_battery_remove,
 };
 module_platform_driver(a500_battery_driver);
 
-- 
2.40.1

