Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97CD7A4EAF
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjIRQVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjIRQVJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:21:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B991627BA1
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-0001zz-13; Mon, 18 Sep 2023 15:37:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-007EZB-Fo; Mon, 18 Sep 2023 15:37:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-002fX4-6i; Mon, 18 Sep 2023 15:37:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 19/32] power: supply: max77693_charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:47 +0200
Message-Id: <20230918133700.1254499-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hP/9uSFJvxgAhTG3pj6HfTvOFbRqa4UMb/e+j3vn7Ls=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJmjCsC9W4TRzBLC8nPGd8UIRbO4KRk6Dwko lhEqn1D//2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSZgAKCRCPgPtYfRL+ Tp5ACACe36zZmQdn/o5Ikt9lrrE0ObpEXIRsn0uv3mmeA2g4KaQ5pArZARKdQjkiFs0k5vkgR8u zzqg0oJmpN+4OrT0Lja8ibI3c77pLlvOMviMv0BhcoTN9SlpCJY/xKJNE/hNfuEj6NZJYVOrDad ND4x15SaPeToIrdNFQJ6sB51dtfCJYfKRpM7WccKMo335lOYeN7anxM7njWjWrOYwym/UH/tOb+ OkeS37ruY1pxZokv7RZAwfMBBqqTehDQxMozG4NnjlYtlv/fj43iqHZh7CtrWcK9DrsrFCDDCWj 46rT+z8qQlpmZ28Czyaaw/DquZ2uccS86YPrNiRgoNEHBm2U
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
 drivers/power/supply/max77693_charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 794c8c054450..d0157e63b8b5 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -728,7 +728,7 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int max77693_charger_remove(struct platform_device *pdev)
+static void max77693_charger_remove(struct platform_device *pdev)
 {
 	struct max77693_charger *chg = platform_get_drvdata(pdev);
 
@@ -737,8 +737,6 @@ static int max77693_charger_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
 
 	power_supply_unregister(chg->charger);
-
-	return 0;
 }
 
 static const struct platform_device_id max77693_charger_id[] = {
@@ -752,7 +750,7 @@ static struct platform_driver max77693_charger_driver = {
 		.name	= "max77693-charger",
 	},
 	.probe		= max77693_charger_probe,
-	.remove		= max77693_charger_remove,
+	.remove_new	= max77693_charger_remove,
 	.id_table	= max77693_charger_id,
 };
 module_platform_driver(max77693_charger_driver);
-- 
2.40.1

