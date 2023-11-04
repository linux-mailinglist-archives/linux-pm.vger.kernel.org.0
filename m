Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6207E1128
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjKDVPx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjKDVPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91BBE
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007wr-I5; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzY-006e1G-R7; Sat, 04 Nov 2023 22:15:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzY-00D1b3-I3; Sat, 04 Nov 2023 22:15:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 05/14] power: reset: at91-poweroff: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:07 +0100
Message-ID: <20231104211501.3676352-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RwiCczqEbLtdO2aF0EtISXUmbXSbx1rbU+RFhJjoe6o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRbDDQyOzgTIjEaYCQcbRMXtzAIt1tOYc4fq Nxn4AKG0+aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0WwAKCRCPgPtYfRL+ TnmjB/9sWF+zrJQupHRVHd6lr2JJVwjol9MXkP9PlxvPg1PRxhClZKS/FZ+/8hh/MmhVrPyL2AV YIdh+cyK/DDfOsUMAmGNIyoIMfF9FrnpPfOb7TpOpxL1eXk6xCBfdhdCyu+xfCrMBLwbZZHGCN/ oO9HrXnu2sC3sOsSOB07iWbbugu6dYrENaiXKoZveGNyDi0jeWXYL+KMT7dOI6fBU1N4svgHY2R aKHsqpNPBX+7kbt4wvt6iYXhot4gE01kQzrA2ljjUrnwkkfVt5GYb9P4BlGvhgr+FXh5eNT0wG8 8gxOZVt2Izl8k4avYa+ys8Psm+9aiBB95Jop6o+aZkksBUmm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/power/reset/at91-poweroff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 83567428ab43..126e774e210c 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -202,7 +202,7 @@ static int at91_poweroff_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int at91_poweroff_remove(struct platform_device *pdev)
+static void at91_poweroff_remove(struct platform_device *pdev)
 {
 	if (pm_power_off == at91_poweroff)
 		pm_power_off = NULL;
@@ -211,8 +211,6 @@ static int at91_poweroff_remove(struct platform_device *pdev)
 		iounmap(at91_shdwc.mpddrc_base);
 
 	clk_disable_unprepare(at91_shdwc.sclk);
-
-	return 0;
 }
 
 static const struct of_device_id at91_poweroff_of_match[] = {
@@ -225,7 +223,7 @@ MODULE_DEVICE_TABLE(of, at91_poweroff_of_match);
 
 static struct platform_driver at91_poweroff_driver = {
 	.probe = at91_poweroff_probe,
-	.remove = at91_poweroff_remove,
+	.remove_new = at91_poweroff_remove,
 	.driver = {
 		.name = "at91-poweroff",
 		.of_match_table = at91_poweroff_of_match,
-- 
2.42.0

