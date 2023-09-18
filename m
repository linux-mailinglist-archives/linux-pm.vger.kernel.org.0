Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963F7A4F14
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjIRQd7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjIRQdd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:33:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0C25455
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-0001wt-1U; Mon, 18 Sep 2023 15:37:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-007EYr-Bd; Mon, 18 Sep 2023 15:37:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-002fWk-2W; Mon, 18 Sep 2023 15:37:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 14/32] power: supply: ipaq_micro_battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:42 +0200
Message-Id: <20230918133700.1254499-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=10tTuouqM0XxEjfGh5+rhGaANufdmub8QOVolPz9Ac0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJgxPa9j0raRKc9m+G6veBrFGEXqD+KSKby3 sCeycc9TkWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSYAAKCRCPgPtYfRL+ ThRQCACIrZOMqLaw3uRUjVmRHICNZINY2wbuw9Ekjz/t6Ori0Yv7jXfJJ4PcbliI0MhbKf1wQB8 WLFi111zR31IonJQJlTzcXwG2ZjdOwszirihNwyq/uh8eRdOoDirJl5fNok1CMbpsSI9sMNIktf iYabxLGJpUpeVJdXAuwLtFTM4oNlbBxKwQ0+mKFiUNPth4u64fofPjXQZ6+NVgKchvdz75IE6FG Ukl+1ca7TOUdtWibIOzZMwszYICs6nYtT0XswWq6KwiJLlCQ0DITuwX6qzbniYzGt03XcVENLX5 nAcCgHT5HBn8yx9DJoRbVLCRxPhrvaCTpUFNkUwkGXCTq0kU
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
 drivers/power/supply/ipaq_micro_battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/supply/ipaq_micro_battery.c
index 192d9db0fb00..66cc649f702a 100644
--- a/drivers/power/supply/ipaq_micro_battery.c
+++ b/drivers/power/supply/ipaq_micro_battery.c
@@ -265,7 +265,7 @@ static int micro_batt_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int micro_batt_remove(struct platform_device *pdev)
+static void micro_batt_remove(struct platform_device *pdev)
 
 {
 	struct micro_battery *mb = platform_get_drvdata(pdev);
@@ -274,8 +274,6 @@ static int micro_batt_remove(struct platform_device *pdev)
 	power_supply_unregister(micro_batt_power);
 	cancel_delayed_work_sync(&mb->update);
 	destroy_workqueue(mb->wq);
-
-	return 0;
 }
 
 static int __maybe_unused micro_batt_suspend(struct device *dev)
@@ -304,7 +302,7 @@ static struct platform_driver micro_batt_device_driver = {
 		.pm	= &micro_batt_dev_pm_ops,
 	},
 	.probe		= micro_batt_probe,
-	.remove		= micro_batt_remove,
+	.remove_new	= micro_batt_remove,
 };
 module_platform_driver(micro_batt_device_driver);
 
-- 
2.40.1

