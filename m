Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D167E112E
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjKDVQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjKDVQA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:16:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F57D70
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007x1-I9; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzZ-006e1J-29; Sat, 04 Nov 2023 22:15:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzY-00D1b7-On; Sat, 04 Nov 2023 22:15:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 06/14] power: reset: atc260x-poweroff: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:08 +0100
Message-ID: <20231104211501.3676352-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vpthYUHNJgRLuKmuG467zCM/oTBAufk4NAmVGhamfm8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRc0nWqT1euSit82lnrCC7RDEAM78FAdEbLx gxHKn+aR6yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0XAAKCRCPgPtYfRL+ TkArB/41aZ/7lJSfAA7CBqLo8s2E1SjJQ632UOtBVHQ/h/x+6Gmn3O/LbegqKuXtFo4cUyt6H3I h7Mdk2bqZUFuU/wpOamT41isDBs0kodIaOEs2MLCiJqC8a7UTa15JpkDmYmrIDGd8T0/SQ82BHv mUQADZs5ycVXh+jjgHNM9DNUW5+km4QN2dNQjXxbyPd7MdP+0xrUcls3eXivyvVYZwwiLTDr1uJ 0CZentT1i4lNzNUD5zz60kjAF0zFfUAFwcwqluBI53s81W5V74KO6ZPAWbiB1hNXJK3ZU42An0c lDotcbS4JctDTx33yRdOlABZ5i/dxQWHdo9O3QXIj+v2/uyk
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
 drivers/power/reset/atc260x-poweroff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset/atc260x-poweroff.c
index 98f20251a6d1..b4aa50e9685e 100644
--- a/drivers/power/reset/atc260x-poweroff.c
+++ b/drivers/power/reset/atc260x-poweroff.c
@@ -233,7 +233,7 @@ static int atc260x_pwrc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int atc260x_pwrc_remove(struct platform_device *pdev)
+static void atc260x_pwrc_remove(struct platform_device *pdev)
 {
 	struct atc260x_pwrc *priv = platform_get_drvdata(pdev);
 
@@ -243,13 +243,11 @@ static int atc260x_pwrc_remove(struct platform_device *pdev)
 	}
 
 	unregister_restart_handler(&priv->restart_nb);
-
-	return 0;
 }
 
 static struct platform_driver atc260x_pwrc_driver = {
 	.probe = atc260x_pwrc_probe,
-	.remove = atc260x_pwrc_remove,
+	.remove_new = atc260x_pwrc_remove,
 	.driver = {
 		.name = "atc260x-pwrc",
 	},
-- 
2.42.0

