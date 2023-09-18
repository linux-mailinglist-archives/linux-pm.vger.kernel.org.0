Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE82C7A4E8A
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjIRQSw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjIRQSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77F28B55
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:16:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-0002Bi-G0; Mon, 18 Sep 2023 15:37:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-007EZf-3O; Mon, 18 Sep 2023 15:37:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-002fXW-Qo; Mon, 18 Sep 2023 15:37:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 26/32] power: supply: tps65217_charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:54 +0200
Message-Id: <20230918133700.1254499-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hxLVxo1RDsCupUrRyCdIqyE5U8lnxZsJiBUnX7hsWtg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJurxLHNRfvvKcumNeZ+8+VZev5Xs1OgBQ5x Ele3ZvBizyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSbgAKCRCPgPtYfRL+ TlZJB/45LQrki28CSvL/Nz1r2KbXfFQvOI5E2fBtIo92tPI5yD0LqxXiUsW6b+WdCngTW/0p5yX 6Uzw9m55IH0w5hbY2cKzn4+84R5IIeRJAFjKD6tcSKAedCDQB5rkDc/3OnkS1TyheSpS7Giq+id u+9tu0eBW5gDEkVSQi88pQ6pOgHOUvHPNvGbiGCnHr0r5QhK0YCP35didlsWtHiRF2d6ZLfS4fl K/blHs0NanbsDYX4JXfk6Io9QFsR9UgUFonrXZiJrqHOl63ySF3OpPm0TvPIkm1oH6qaTbcI0Xw dW7oupK9S5ZjV+5jQsRnFMljx81pWosx4bABiv8XyGHxhZsw
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
 drivers/power/supply/tps65217_charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 96341cbde4fa..b3a1ba326a3e 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -253,14 +253,12 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tps65217_charger_remove(struct platform_device *pdev)
+static void tps65217_charger_remove(struct platform_device *pdev)
 {
 	struct tps65217_charger *charger = platform_get_drvdata(pdev);
 
 	if (charger->poll_task)
 		kthread_stop(charger->poll_task);
-
-	return 0;
 }
 
 static const struct of_device_id tps65217_charger_match_table[] = {
@@ -271,7 +269,7 @@ MODULE_DEVICE_TABLE(of, tps65217_charger_match_table);
 
 static struct platform_driver tps65217_charger_driver = {
 	.probe	= tps65217_charger_probe,
-	.remove = tps65217_charger_remove,
+	.remove_new = tps65217_charger_remove,
 	.driver	= {
 		.name	= "tps65217-charger",
 		.of_match_table = of_match_ptr(tps65217_charger_match_table),
-- 
2.40.1

