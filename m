Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68607A4E80
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjIRQSp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjIRQSc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:32 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252FB21EA0
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:14:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-0001on-9c; Mon, 18 Sep 2023 15:37:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER0-007EY6-Mv; Mon, 18 Sep 2023 15:37:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER0-002fVw-Da; Mon, 18 Sep 2023 15:37:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/32] power: supply: ab8500_chargalg: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:30 +0200
Message-Id: <20230918133700.1254499-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=p2JgJPao1VX1HaXnHaunh6Rgmqpd1W8otqx7WXjs1gk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJSsdD+zNZ0ZBSFyT/S7YhQDOgZFtRmzwSku 1lPA1Il3kiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSUgAKCRCPgPtYfRL+ TgtJCACyR3LF6scCNnj2qvxCmiroaxtsP7173Hbvse9Dzbki4fqO2xXa4h+ebdqFhlUEbVhrG7F wCCHlQlNs8IRILh4KLE1kEZr0kIhYCEKSC+gLCM24B+Ln8S5lF9U4RXVbRP0Ie44jr9EIprTDo4 lBWYQIUUzpsS+LCvo/tu/OJziyGeO1NF1xqiDbz2KY9nlKvtQpkBYyNqXk+tuSHVjyuzWDwA4RH pJp8mgz7GzIM6QZ1XPw6ZCQzNuoY0U5frupQaPx31XDBONBVojW8/1AVpX1wrVx6xVkFWUl74QE oRANT/L/RpMA2FXq3fpPyziLNGd9L/rWs/Y6Cn55+XyhLs0g
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
 drivers/power/supply/ab8500_chargalg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 2205ea0834a6..de912658facb 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -1824,11 +1824,9 @@ static int ab8500_chargalg_probe(struct platform_device *pdev)
 	return component_add(dev, &ab8500_chargalg_component_ops);
 }
 
-static int ab8500_chargalg_remove(struct platform_device *pdev)
+static void ab8500_chargalg_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &ab8500_chargalg_component_ops);
-
-	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(ab8500_chargalg_pm_ops, ab8500_chargalg_suspend, ab8500_chargalg_resume);
@@ -1840,7 +1838,7 @@ static const struct of_device_id ab8500_chargalg_match[] = {
 
 struct platform_driver ab8500_chargalg_driver = {
 	.probe = ab8500_chargalg_probe,
-	.remove = ab8500_chargalg_remove,
+	.remove_new = ab8500_chargalg_remove,
 	.driver = {
 		.name = "ab8500_chargalg",
 		.of_match_table = ab8500_chargalg_match,
-- 
2.40.1

