Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB487A4EA1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjIRQUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjIRQUW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:20:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558A82446C
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-0001pX-Vc; Mon, 18 Sep 2023 15:37:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-007EYL-Ix; Mon, 18 Sep 2023 15:37:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-002fWE-9O; Mon, 18 Sep 2023 15:37:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 06/32] power: supply: act8945a_charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:34 +0200
Message-Id: <20230918133700.1254499-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PrM3ABfp3OcWBml0epzzHjGdmmv7wwl3Zc85DMdKIpc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJWxtNSwtYwdobrM3XIrpAeDDxEqYexugNfu iGvXzGvxi6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSVgAKCRCPgPtYfRL+ Tl9zB/4/lqL9QMmgjMasb+FpyhfmnwVA0UjmpCuuVfnlLM8/gMiyAsvyXhwuxrrGFDxYfOBqujM OrVUugNwoM7CcUVFrUErZc0RdeNBucej22qbYOXQ/pqghAyKhD1D+Ne57HKSV2pMrHsaAoLckuB ktje5bEkXspNq9bapixcZKvr4VjqKafjVAORef2xuoO8m/FpcC7bxsxdwtYtIVpyNuh1zsxeM3G gL2BNF57igd5N/s6hpC8+dDfQrPeMgD9IiZowHwWshO/Gosy+tnhfL68fLng/mhRGr9uwyl/Mxi VGfLoHMwy9g7ZMoJE3SP7s4OXWJXzryBGlDMyfaypYlvcKVO
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
 drivers/power/supply/act8945a_charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c b/drivers/power/supply/act8945a_charger.c
index e9b5f4283772..51122bfbf196 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -638,14 +638,12 @@ static int act8945a_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int act8945a_charger_remove(struct platform_device *pdev)
+static void act8945a_charger_remove(struct platform_device *pdev)
 {
 	struct act8945a_charger *charger = platform_get_drvdata(pdev);
 
 	charger->init_done = false;
 	cancel_work_sync(&charger->work);
-
-	return 0;
 }
 
 static struct platform_driver act8945a_charger_driver = {
@@ -653,7 +651,7 @@ static struct platform_driver act8945a_charger_driver = {
 		.name = "act8945a-charger",
 	},
 	.probe	= act8945a_charger_probe,
-	.remove = act8945a_charger_remove,
+	.remove_new = act8945a_charger_remove,
 };
 module_platform_driver(act8945a_charger_driver);
 
-- 
2.40.1

