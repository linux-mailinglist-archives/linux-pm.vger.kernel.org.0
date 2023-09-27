Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A597B0CC7
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjI0TiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjI0TiB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB213A
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM2-0002cr-Hw; Wed, 27 Sep 2023 21:37:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM1-009Pb5-KP; Wed, 27 Sep 2023 21:37:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM1-005RhK-B7; Wed, 27 Sep 2023 21:37:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 31/31] thermal: uniphier: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:36 +0200
Message-Id: <20230927193736.2236447-32-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=z/ClpKnPyFge+NWzcPB577xRCQuThx5vjaDx/3YvIhM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSRlhqecs8PHu6iv8133+Cv3WK+r65HLHnpbNsKJYayq 7zBdnydjMYsDIxcDLJiiiz2jWsyrarkIjvX/rsMM4iVCWQKAxenAExk+3r2/56nzvDnf6l5kTw7 qMTbgcG/pmbHab/pc+eZbOPWmbI8U0X1Wq/yws0vWYIuHopeuff48b4FM/4xMx3Prs+Qyffx+3k rV9VCPozv0mvGWnv/r89uy3717IxxlV/AERYn7H9JKlvXNrnx+aa5wfPznaIf3Jzm7xvfev+pVX Ke5zQ5/T9JM+Vyr7Ub8pZ+vlWzwUnOpXuWF1f+Xp+rotmZ3Bv5rhwUuBWyytt+zaTLl/m0u5e0a D/tKT/FpGzSqnWr781y0YyIltBNPVZ/1r836EoyMQvamPZp0o/6sxmZnp61q0u7VS5K32t44rwt s2Pum3yxKzlyvKLTn1x/qfvFRCXisn/chdlrCnW1tj0EAA==
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/uniphier_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 6f32ab61d174..274f36358b21 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -317,14 +317,12 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int uniphier_tm_remove(struct platform_device *pdev)
+static void uniphier_tm_remove(struct platform_device *pdev)
 {
 	struct uniphier_tm_dev *tdev = platform_get_drvdata(pdev);
 
 	/* disable sensor */
 	uniphier_tm_disable_sensor(tdev);
-
-	return 0;
 }
 
 static const struct uniphier_tm_soc_data uniphier_pxs2_tm_data = {
@@ -362,7 +360,7 @@ MODULE_DEVICE_TABLE(of, uniphier_tm_dt_ids);
 
 static struct platform_driver uniphier_tm_driver = {
 	.probe = uniphier_tm_probe,
-	.remove = uniphier_tm_remove,
+	.remove_new = uniphier_tm_remove,
 	.driver = {
 		.name = "uniphier-thermal",
 		.of_match_table = uniphier_tm_dt_ids,
-- 
2.40.1

