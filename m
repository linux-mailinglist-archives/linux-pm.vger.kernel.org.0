Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885C37A4EA0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIRQUd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjIRQUS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:20:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF47216D7
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:14:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-0002Bw-MF; Mon, 18 Sep 2023 15:37:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-007EZi-9f; Mon, 18 Sep 2023 15:37:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-002fXa-0d; Mon, 18 Sep 2023 15:37:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 27/32] power: supply: twl4030_charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:55 +0200
Message-Id: <20230918133700.1254499-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=85UwmSf+vOQeEPfWwSLPmM3+kPkAsNcqdfQSv9IJGuk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJvyf2xr1r4LVWPQpcD3cPr8OxEc3ULvymU4 fF6W4Pe8TmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSbwAKCRCPgPtYfRL+ Tm8QB/4m2QPcD0SxPUIAGsCaRuplQVlcrpJ9jhK61jg8tjlUQc/H/aG14PTQx7s+V1APQ5mKTnE f7htpwcsKYwvmL7Uu8Un/f+j5fO2cdTV/i3YQbIOn2M5DV96S8aOiwM2TD6Ay5Lb+AiN+vj0G/x iOXcDG7MYLVa9DY+JVqRlQhEyXOGbM8cw6cuHMQiH56Yp8NvjpWMPttvfATvK/NRcGBLvQVQ/ZN 35w671aJB5q/LpcDW9O4/xmqfsoguvTUIlTs0/I7JCs+9BEgt7Bq0YAOsmmTeBx13Y5ZRdf8dt5 yeYtbJNaI8YeqEqpzBUbAJS6sYmmJ2rmE1epl4WFtx65spPZ
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
 drivers/power/supply/twl4030_charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index e78d061d8d32..7b9b0b3e164e 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1108,7 +1108,7 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int twl4030_bci_remove(struct platform_device *pdev)
+static void twl4030_bci_remove(struct platform_device *pdev)
 {
 	struct twl4030_bci *bci = platform_get_drvdata(pdev);
 
@@ -1123,8 +1123,6 @@ static int twl4030_bci_remove(struct platform_device *pdev)
 			 TWL4030_INTERRUPTS_BCIIMR1A);
 	twl_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xff,
 			 TWL4030_INTERRUPTS_BCIIMR2A);
-
-	return 0;
 }
 
 static const struct of_device_id twl_bci_of_match[] __maybe_unused = {
@@ -1135,7 +1133,7 @@ MODULE_DEVICE_TABLE(of, twl_bci_of_match);
 
 static struct platform_driver twl4030_bci_driver = {
 	.probe = twl4030_bci_probe,
-	.remove	= twl4030_bci_remove,
+	.remove_new = twl4030_bci_remove,
 	.driver	= {
 		.name	= "twl4030_bci",
 		.of_match_table = of_match_ptr(twl_bci_of_match),
-- 
2.40.1

