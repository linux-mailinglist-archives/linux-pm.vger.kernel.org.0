Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA987A4E79
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjIRQS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIRQSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41328B54
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:16:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-0001pg-61; Mon, 18 Sep 2023 15:37:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-007EYP-Pc; Mon, 18 Sep 2023 15:37:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-002fWI-GV; Mon, 18 Sep 2023 15:37:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/32] power: supply: charger-manager: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:35 +0200
Message-Id: <20230918133700.1254499-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KqEoNkZswna/cW3TF94N+vJqjiKIadMqGZaYqwX2DNU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJYs34AjvWSLcclIIlLStG9lutR2Ye+gbLDX 81C6n2suq2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSWAAKCRCPgPtYfRL+ Tr/OB/4hsMR4YyZ+2Ke0Gn8P2EOUPY0Z9xKeh/K5JvTGezmngdNISbARnZI+RJa0zfES45kw+ke IcdJe/+rMug70JkpQuttFf73Ocu5Hph7Aq7+V+BX7sB7uh6XwANr6HrnLkIhdjwXkhmisf0eI1u /taaGMZXMbrpcn+m0WOgkiUFXCMjFymkvWjVK7TQYC5GMuwMT0gfkVPOm/3pbxHw8HueVhIo3kj cgfyHBiuhQjRaKbw9H+cLKKbs3uLgMWNApcm02jvDdZYnvUGzJ8XV5COeDxjAx+/9nGLmq2ziqc hMR68sUxyK2gpT6OtN6gO1il2tD8f5DABmNxZ8vWjauU4eKb
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
 drivers/power/supply/charger-manager.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 5fa6ba7f41e1..3936ff066600 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1628,7 +1628,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int charger_manager_remove(struct platform_device *pdev)
+static void charger_manager_remove(struct platform_device *pdev)
 {
 	struct charger_manager *cm = platform_get_drvdata(pdev);
 	struct charger_desc *desc = cm->desc;
@@ -1648,8 +1648,6 @@ static int charger_manager_remove(struct platform_device *pdev)
 	power_supply_unregister(cm->charger_psy);
 
 	try_charger_enable(cm, false);
-
-	return 0;
 }
 
 static const struct platform_device_id charger_manager_id[] = {
@@ -1740,7 +1738,7 @@ static struct platform_driver charger_manager_driver = {
 		.of_match_table = charger_manager_match,
 	},
 	.probe = charger_manager_probe,
-	.remove = charger_manager_remove,
+	.remove_new = charger_manager_remove,
 	.id_table = charger_manager_id,
 };
 
-- 
2.40.1

