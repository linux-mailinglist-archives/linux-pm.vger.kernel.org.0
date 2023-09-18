Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504207A4F10
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjIRQdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjIRQd1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:33:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722FE86A1
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:13:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-0001vq-JC; Mon, 18 Sep 2023 15:37:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-007EYk-SX; Mon, 18 Sep 2023 15:37:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-002fWc-JO; Mon, 18 Sep 2023 15:37:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/32] power: supply: da9150-charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:40 +0200
Message-Id: <20230918133700.1254499-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rfRJg6wF+UuCSl+xHxeTBBO5T3UDOwPUJnZS1pr/gpU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJd7QaxM+j15WNYpIpEzD35pn4gZg+Lv4vi1 KDHalAx/M+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSXQAKCRCPgPtYfRL+ TqcLB/9ClgwOP84v7fi6FfdZUSSr4PriuO2y4EkAlIRqji3oTU4MmUjebYl7Q8FdqHXeRlx/ncK JZrPkw4kyJ9LDb0/LO4U1StgvwdzTaZi0/MGkEXjtXnUxcS4qa2MLnRx9ijCaJk2U2xdknk4QUX ypuudZUslVQVykEf5u/vyl/e9dhZxV/pbJliC6/rBHpfXmkVhF0nz+Kjem85kN2vnobyJLX3Cp8 KLkJQf9+s9gNWOk+U1paTURNc9WkU93lVoKO4S0CZ/5FyXtUPb21DHXDR3mlID4uC0NogbLzdsX s324i/Rmy59siJr5AKGPPG1ZXGdxcJv/O2GV33qhr1szqeOB
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
 drivers/power/supply/da9150-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index 27f897067aa3..37db9e4ed7f3 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -635,7 +635,7 @@ static int da9150_charger_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int da9150_charger_remove(struct platform_device *pdev)
+static void da9150_charger_remove(struct platform_device *pdev)
 {
 	struct da9150_charger *charger = platform_get_drvdata(pdev);
 	int irq;
@@ -665,8 +665,6 @@ static int da9150_charger_remove(struct platform_device *pdev)
 	iio_channel_release(charger->vbus_chan);
 	iio_channel_release(charger->tjunc_chan);
 	iio_channel_release(charger->vbat_chan);
-
-	return 0;
 }
 
 static struct platform_driver da9150_charger_driver = {
@@ -674,7 +672,7 @@ static struct platform_driver da9150_charger_driver = {
 		.name = "da9150-charger",
 	},
 	.probe = da9150_charger_probe,
-	.remove = da9150_charger_remove,
+	.remove_new = da9150_charger_remove,
 };
 
 module_platform_driver(da9150_charger_driver);
-- 
2.40.1

