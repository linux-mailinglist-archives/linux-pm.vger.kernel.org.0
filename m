Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F827E12D9
	for <lists+linux-pm@lfdr.de>; Sun,  5 Nov 2023 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKEJr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Nov 2023 04:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJr2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Nov 2023 04:47:28 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A80CC
        for <linux-pm@vger.kernel.org>; Sun,  5 Nov 2023 01:47:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzZiy-0001rh-Da; Sun, 05 Nov 2023 10:47:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzZix-006l8r-94; Sun, 05 Nov 2023 10:47:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzZiw-00D8pc-WA; Sun, 05 Nov 2023 10:47:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 15/14] power: reset: at91-reset: Convert to platform remove callback returning void
Date:   Sun,  5 Nov 2023 10:47:13 +0100
Message-ID: <20231105094712.3706799-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6UWhnWW61ztRtwRXW5D84OEckBe5riPHvZo+S4I26io=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlR2SgCzO5BgRShJV6toxvCArqHUBKxly1VlOP8 0yYhWjQ67eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUdkoAAKCRCPgPtYfRL+ Tt4dCACdqHfejsCGMKbgm/RrArvl5B1pH2IMRQ4rf71aqk1/ROfPAP+TgBFhaFZfR3fZ89miQKK 5dttjtIij+C8oDmdEsCufjyMJ6XV63BXfA6cr6b4wkErRWqn9eoQtt0Gz2NIPvx9XxwZe7AMMGW lrS56tiwnGzWdZpQNPd/0w+1nyb9qT8/tcb1pK/oEtCJMsQxcCMPkO9GIE7618MKICrEYqpYLyb FkjkBNLxrEfXFDtIJEYuQEEAU1nhXCo7t92xwcWStnjvCH7WhcMwZmwpSXvn/sTUf+F1fv9htxD N4e0xgB3K341gkNU0/RuwKjxT12fc9PZp9btYRtR8OGOdqaF
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
 drivers/power/reset/at91-reset.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index af85f2f929ba..16512654295f 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -417,19 +417,17 @@ static int at91_reset_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int at91_reset_remove(struct platform_device *pdev)
+static void at91_reset_remove(struct platform_device *pdev)
 {
 	struct at91_reset *reset = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&reset->nb);
 	clk_disable_unprepare(reset->sclk);
-
-	return 0;
 }
 
 static struct platform_driver at91_reset_driver = {
 	.probe = at91_reset_probe,
-	.remove = at91_reset_remove,
+	.remove_new = at91_reset_remove,
 	.driver = {
 		.name = "at91-reset",
 		.of_match_table = at91_reset_of_match,
-- 
2.42.0

