Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0C7A4EB0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjIRQVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjIRQVQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:21:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762227BA0
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-0001tv-UZ; Mon, 18 Sep 2023 15:37:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-007EYb-Es; Mon, 18 Sep 2023 15:37:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-002fWU-5a; Mon, 18 Sep 2023 15:37:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 10/32] power: supply: da9030_battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:38 +0200
Message-Id: <20230918133700.1254499-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hwZNMSZkop1+SgTyObRP+0cK97gOyPx2nA78664gY1c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJbBW/bPf61DKhYyi9P/VW0uT77iVM88BSnb nVXEpJNcySJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSWwAKCRCPgPtYfRL+ Ts+mCACYrb2MHAMl3sR2nh40u5ZCMapYsWhl+093BLHkR1w5jllHkXK2TZgMqBc3wEFqY6ZbaId i2qA21UpCojw4DuJLsZPyYDTgjCaqS04d9CuDuPMs5G4XTJaQQfLMrYkH7W56b3bHlkc39TLWk7 TrVMj+9IJGfYwCq5mMIm/sC8a9CeJbY+Cln87mNlRyBvdNheMChj/kKYoGrkeWmlzz6juTU2H4a DVc9GbdiqeTujWjSi85LEc6MF5GMGhcBfsI/wmN55W603QqZLJhgiaa+rbelYiahs+7duESjpzG sjhgxnhMrhUqinAIy7KYtnX/3gpL0u967sTU07Wns63uJiGE
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
 drivers/power/supply/da9030_battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 0deba48d22d3..581cf956d2d2 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -552,7 +552,7 @@ static int da9030_battery_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int da9030_battery_remove(struct platform_device *dev)
+static void da9030_battery_remove(struct platform_device *dev)
 {
 	struct da9030_charger *charger = platform_get_drvdata(dev);
 
@@ -564,8 +564,6 @@ static int da9030_battery_remove(struct platform_device *dev)
 	cancel_delayed_work_sync(&charger->work);
 	da9030_set_charge(charger, 0);
 	power_supply_unregister(charger->psy);
-
-	return 0;
 }
 
 static struct platform_driver da903x_battery_driver = {
@@ -573,7 +571,7 @@ static struct platform_driver da903x_battery_driver = {
 		.name	= "da903x-battery",
 	},
 	.probe = da9030_battery_probe,
-	.remove = da9030_battery_remove,
+	.remove_new = da9030_battery_remove,
 };
 
 module_platform_driver(da903x_battery_driver);
-- 
2.40.1

