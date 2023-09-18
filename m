Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0067A4E70
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjIRQR7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIRQRu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:17:50 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6647EC7
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:12:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-0001rv-OV; Mon, 18 Sep 2023 15:37:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-007EYX-7x; Mon, 18 Sep 2023 15:37:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-002fWQ-Uz; Mon, 18 Sep 2023 15:37:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/32] power: supply: cpcap-charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:37 +0200
Message-Id: <20230918133700.1254499-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kWIuKkcEOY/YuvtSZPWzQr8KtYlwW0QvkJgYDYl6Kqc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJaQWpmWbSVxRlKqzPjI9Ff76c8yLetU6T7h H1XLymr0cWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSWgAKCRCPgPtYfRL+ TuZKCAClm9WnRs1+dbGtK7OxoPg/A8GA2N3C6LIhF9m04Kdex3E+3pi/4Fad4E9fajd15Co7jmI Zy2NoHrStgcwR0DtO8ZHn2JUr3PINziOGeTXQDgbvn2NmGhTqajT8VIlg1Csr/WxHK/2IAZXNqC aV4zHT21mUjPkZrADTxw6gK5aLuPrh7bkEl7Da5SQDtsoV/f2DAuWl9wB5SgkBn0UIF+PtXc2KM 2Z+gF/ZfZGccej/eJPJNKkxLsKpNrzy0t7v4GORdCxiI7LL5s/NI4/xzt6buZJNnJsUFz7SDsxI HnUmtxx5Q7xyXM8plityb9B3UFe8LPHERGX04Q56wKUaovpS
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
 drivers/power/supply/cpcap-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index be9764541d52..431e951cccf0 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -966,11 +966,9 @@ static void cpcap_charger_shutdown(struct platform_device *pdev)
 	cancel_delayed_work_sync(&ddata->detect_work);
 }
 
-static int cpcap_charger_remove(struct platform_device *pdev)
+static void cpcap_charger_remove(struct platform_device *pdev)
 {
 	cpcap_charger_shutdown(pdev);
-
-	return 0;
 }
 
 static struct platform_driver cpcap_charger_driver = {
@@ -980,7 +978,7 @@ static struct platform_driver cpcap_charger_driver = {
 		.of_match_table = of_match_ptr(cpcap_charger_id_table),
 	},
 	.shutdown = cpcap_charger_shutdown,
-	.remove	= cpcap_charger_remove,
+	.remove_new = cpcap_charger_remove,
 };
 module_platform_driver(cpcap_charger_driver);
 
-- 
2.40.1

