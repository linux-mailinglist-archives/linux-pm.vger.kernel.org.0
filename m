Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14AD7E1127
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKDVPw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjKDVPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892BBB0
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007x9-IB; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzZ-006e1Q-FH; Sat, 04 Nov 2023 22:15:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzZ-00D1bF-6D; Sat, 04 Nov 2023 22:15:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 08/14] power: reset: mt6323-poweroff: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:10 +0100
Message-ID: <20231104211501.3676352-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+ks+08sNas6pRwQOIu9JqI3KzDyMtEsulLgfZXQOgLc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRfbtVNNlwYL9e4IQ3CBHffi67iJXbrWETgo wljmV/D+IeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0XwAKCRCPgPtYfRL+ Tv5UB/9Cyj7hmzhYSg/jRT/T2W3i95PssgWRVEh5CX70+1G/lp2Vkon6fJxXqOQASadNr36iiy+ JETjkP6mjXsqcQs9vwbSXVK1VWPah3sC93rWO+8nBDQPNdksfNccp5R6/vbqZr2d3oIwgdpjxfu LU1Eedx/SSpCa/XvnQ8WstE0J6xQMLXZ7+iT23K2tFkranQkfn5TD1TfW7KYZjsziMncru/dESa gvXn27dj84G3VQW2a2rdGirOxcyQrbus+HiDgJq8tJIYOTlodGxcui5khY6x1S8GzaC0fEa/WFu Is7YBPo+hjgAux4wwm0N2zuVckwFRa5abA4J7QuKwjHSMMoT
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
 drivers/power/reset/mt6323-poweroff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
index 108167f7738b..57a63c0ab7fb 100644
--- a/drivers/power/reset/mt6323-poweroff.c
+++ b/drivers/power/reset/mt6323-poweroff.c
@@ -70,12 +70,10 @@ static int mt6323_pwrc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mt6323_pwrc_remove(struct platform_device *pdev)
+static void mt6323_pwrc_remove(struct platform_device *pdev)
 {
 	if (pm_power_off == &mt6323_do_pwroff)
 		pm_power_off = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id mt6323_pwrc_dt_match[] = {
@@ -86,7 +84,7 @@ MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
 
 static struct platform_driver mt6323_pwrc_driver = {
 	.probe          = mt6323_pwrc_probe,
-	.remove         = mt6323_pwrc_remove,
+	.remove_new     = mt6323_pwrc_remove,
 	.driver         = {
 		.name   = "mt6323-pwrc",
 		.of_match_table = mt6323_pwrc_dt_match,
-- 
2.42.0

