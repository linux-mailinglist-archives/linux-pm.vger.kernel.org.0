Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2647A4F19
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjIRQeC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIRQdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:33:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB3B282BC
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-00020T-85; Mon, 18 Sep 2023 15:37:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-007EZF-Mq; Mon, 18 Sep 2023 15:37:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-002fX8-Dr; Mon, 18 Sep 2023 15:37:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 20/32] power: supply: max8925_power: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:48 +0200
Message-Id: <20230918133700.1254499-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=O39TpgR518JvrGhlAmCobiVC+NVkwxXu4+RkO0zKYJ8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJnpsXmCrgGt0a6UCL1H50/XAJwx1OQ4DSQl E/RNhk+TXKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSZwAKCRCPgPtYfRL+ Tg08B/9rycNNttFQsJrZP7qQLblKCwSfzbRNx8FRZmVs8OVAup0HbGm6FHCWKPMWARmV63w/Cjm f809J/mDM/bodydKwqeqIdg3TzmWXPPWDrA2mnf6+6Mkbrr/XSKpVb3tmKsOlrRjrZEdDqEalYZ 3vz58o+zdsTfcoB9R01EJnX8HYjXaQa6Oox+aatd1qD6Dkq5mr4AHAkA48ZC9aiBP+0Nnko9I19 fIZKZ65wvdSQcG/L5esnREeVS28+yfbZB0hLB5v24g50LLOzEPs0Lln5Ed+E0bAhwKqjMNTHmx2 2ynIfwlDomiXSwywZKtS/oINspQP2fdZiDoPvLW+mGLHdJM8
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
 drivers/power/supply/max8925_power.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/max8925_power.c
index 8878f9131184..4a2d6894f94e 100644
--- a/drivers/power/supply/max8925_power.c
+++ b/drivers/power/supply/max8925_power.c
@@ -566,7 +566,7 @@ static int max8925_power_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int max8925_power_remove(struct platform_device *pdev)
+static void max8925_power_remove(struct platform_device *pdev)
 {
 	struct max8925_power_info *info = platform_get_drvdata(pdev);
 
@@ -576,12 +576,11 @@ static int max8925_power_remove(struct platform_device *pdev)
 		power_supply_unregister(info->battery);
 		max8925_deinit_charger(info);
 	}
-	return 0;
 }
 
 static struct platform_driver max8925_power_driver = {
 	.probe	= max8925_power_probe,
-	.remove	= max8925_power_remove,
+	.remove_new = max8925_power_remove,
 	.driver	= {
 		.name	= "max8925-power",
 	},
-- 
2.40.1

