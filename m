Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4711C7A4F93
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjIRQqf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjIRQqT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:46:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C671D6A5F
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:11:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-0001y0-73; Mon, 18 Sep 2023 15:37:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-007EYv-IZ; Mon, 18 Sep 2023 15:37:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-002fWo-9X; Mon, 18 Sep 2023 15:37:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 15/32] power: supply: isp1704_charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:43 +0200
Message-Id: <20230918133700.1254499-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wUgZNYjo2rBLlxtBn6e9lMzocGxL0LFh0SBZ40XoaK4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSOoEQJY4UU4xdiGfrCe78GVTpOvOyeP0NFSySCIY7p0 hW9OwKdjMYsDIxcDLJiiiz2jWsyrarkIjvX/rsMM4iVCWQKAxenAEwkM4GDYfayIK/TD7criMix peUs+3FZw03H+PyD/d4M/ZkPOH4dsNWM3lqvd0J5o/TyJCfubUkOreWl0Taii5MXGVhPSfn5hF+ u39Hg3zw2a8sn4tp3p2q+Vih02q8oK702IEN2aWSKTWGxTtSu2SyeLXsrfj5usS5K31KSI5H30c Uuskx53+HqX2dP2rNI7irSfjt5YsmqHI+lwSs9jI6lsMxhDzs26/21P+/y0v/EuJUF9IYcUjziZ T5z29XAvzurjzF2uiX+PTw/ryNvfUhZxJRp9w/qpmf+nNLVXrzdfzX3tyV82s8YC3f0pGRseBQq 2urmNIVblV3KOa3To+X+uZBbfQy3zorxcO63MH/ZXQ4A
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
 drivers/power/supply/isp1704_charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index b6efc454e4f0..860d8614c98f 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -477,15 +477,13 @@ static int isp1704_charger_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int isp1704_charger_remove(struct platform_device *pdev)
+static void isp1704_charger_remove(struct platform_device *pdev)
 {
 	struct isp1704_charger *isp = platform_get_drvdata(pdev);
 
 	usb_unregister_notifier(isp->phy, &isp->nb);
 	power_supply_unregister(isp->psy);
 	isp1704_charger_set_power(isp, 0);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -503,7 +501,7 @@ static struct platform_driver isp1704_charger_driver = {
 		.of_match_table = of_match_ptr(omap_isp1704_of_match),
 	},
 	.probe = isp1704_charger_probe,
-	.remove = isp1704_charger_remove,
+	.remove_new = isp1704_charger_remove,
 };
 
 module_platform_driver(isp1704_charger_driver);
-- 
2.40.1

