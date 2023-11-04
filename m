Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D27E1124
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjKDVPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjKDVPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A76123
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007yh-Iv; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-006e1a-6M; Sat, 04 Nov 2023 22:15:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzZ-00D1bR-Te; Sat, 04 Nov 2023 22:15:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/14] power: reset: restart-poweroff: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:13 +0100
Message-ID: <20231104211501.3676352-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SmTesM76SqrZqGgxVNzBr8ASOZjpry5x0J8q9JTgRF8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRij/dHQlkhF9hLDeGMVRilmROHUbp3Z0Xnq QsbuHhnvxqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0YgAKCRCPgPtYfRL+ TsL5B/997XjP0cthp1RuuPLY3iNLoU4b9yWSiMenZyGibAewb7GTq2Fez4WOo1PIY3M1j+lUxDh VzBbyTWH90SC4S8MKGTekKmB9UF8cVcgc9Vq+AWZ8eq+t4iQ+qKDt8uNKhlDd7y79ejmZ+Snj3P d0cEAorN4V1F9p0pdK4FOxGsMwUQ+jPdJr8gpg7DJuiAq7VNFp7s8L2/ALu6pAZnlwVcd3JV+LN lNkRBtz7T8mKy/auTEZNtH7SaU385VbFJeS8c+9cB56B3udfVqTyFqJ/5R+BXXq+xBaMm/WeqtB IKTryJqaV3qTTJ6rF2Gcm1m1k308pOIJ7fFbpQkSxDlKxCcR
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
 drivers/power/reset/restart-poweroff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index 28f1822db162..f4d6004793d3 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -33,12 +33,10 @@ static int restart_poweroff_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int restart_poweroff_remove(struct platform_device *pdev)
+static void restart_poweroff_remove(struct platform_device *pdev)
 {
 	if (pm_power_off == &restart_poweroff_do_poweroff)
 		pm_power_off = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id of_restart_poweroff_match[] = {
@@ -49,7 +47,7 @@ MODULE_DEVICE_TABLE(of, of_restart_poweroff_match);
 
 static struct platform_driver restart_poweroff_driver = {
 	.probe = restart_poweroff_probe,
-	.remove = restart_poweroff_remove,
+	.remove_new = restart_poweroff_remove,
 	.driver = {
 		.name = "poweroff-restart",
 		.of_match_table = of_restart_poweroff_match,
-- 
2.42.0

