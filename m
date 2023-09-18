Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E370E7A4F3E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjIRQgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjIRQgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:36:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F226D01
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-0001vJ-C6; Mon, 18 Sep 2023 15:37:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-007EYf-LJ; Mon, 18 Sep 2023 15:37:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-002fWY-CB; Mon, 18 Sep 2023 15:37:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/32] power: supply: da9052-battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:39 +0200
Message-Id: <20230918133700.1254499-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4lxqRDdb3quCiuhhOyQrGTC7aVig9wuBPxjLCQR+PZE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSOoJhbl7sOiFw9FFm6fZrJ+xUfppxMSTljFZDe9zTq9 EPtTVPFOxmNWRgYuRhkxRRZ7BvXZFpVyUV2rv13GWYQKxPIFAYuTgGYyFR29n92Wvvt395W+9bm ommUl/L3Rn7h5tQZEdbyRkWbPTkFJzS0/OWOu8b2onJltyEPM0+M5tKelhIens7cZZz7phWXLvm gsCcyN1YgVUjzDd/WzAe68/hyb6mlFb8oaH/AEVP2MO2Q6Mnmmdkb+hkU5jrMUnpbvTaqR7I5fs Hycxe0XKLlDzQlS+90CHsl9aDt/tey2dPU3OZ8velzdH3m7Oq56nt38JakXBL8qiJlwFB6RPac9 fmqtV9YVvw2V+ur+CNa6F2yooxnR0ZQSern/PMbuW1+PJjCuTZdu6FnkrjP9YCfpV0vtmkd0dwZ wdufFtLJE1x91WBv9+ovx+qf79NjsJaZKdZmXv51wh4mAA==
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
 drivers/power/supply/da9052-battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/da9052-battery.c b/drivers/power/supply/da9052-battery.c
index d87bdecc9501..6f7c58a41e91 100644
--- a/drivers/power/supply/da9052-battery.c
+++ b/drivers/power/supply/da9052-battery.c
@@ -637,7 +637,7 @@ static s32 da9052_bat_probe(struct platform_device *pdev)
 
 	return ret;
 }
-static int da9052_bat_remove(struct platform_device *pdev)
+static void da9052_bat_remove(struct platform_device *pdev)
 {
 	int i;
 	struct da9052_battery *bat = platform_get_drvdata(pdev);
@@ -646,13 +646,11 @@ static int da9052_bat_remove(struct platform_device *pdev)
 		da9052_free_irq(bat->da9052, da9052_bat_irq_bits[i], bat);
 
 	power_supply_unregister(bat->psy);
-
-	return 0;
 }
 
 static struct platform_driver da9052_bat_driver = {
 	.probe = da9052_bat_probe,
-	.remove = da9052_bat_remove,
+	.remove_new = da9052_bat_remove,
 	.driver = {
 		.name = "da9052-bat",
 	},
-- 
2.40.1

