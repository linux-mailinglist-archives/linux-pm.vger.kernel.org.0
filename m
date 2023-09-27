Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF27B0CB1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjI0TiA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjI0Th6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0127122
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-000272-7k; Wed, 27 Sep 2023 21:37:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-009PZM-Lb; Wed, 27 Sep 2023 21:37:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLt-005Rfa-C2; Wed, 27 Sep 2023 21:37:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 04/31] thermal: ns: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:09 +0200
Message-Id: <20230927193736.2236447-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2zYvLzrABKf6jXG7bIZewjyas0BWPRAylGAatEx38xc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRe/J8pIPrn0369YrBYdl3PMV+GqUV5RjvN4 DWTEkPbLNKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEXgAKCRCPgPtYfRL+ TiPEB/9pdVpY2EeyM+V8i4wzexrx2BREcMMzRjevN169UpS2RSUs2vPi/ap0U2TkMRvUn5AMJX1 ziFhH7VkeEutDuDQqPLBRqZs0z1cJCHR54jKrVPSvQvYK7Q4/I6ziMZWPhSgPtSnBogADVLGTJA oCHGJxRZfHbHY/NgiklT/fctn2Af5K6a9e0p8Ouwls4tbZJXbYa6xD56QLdDcJFGcoP5gWwKnor jks8KQrm258wJWXWeZLKTMlcwA2tXxSDRWsek1xIqlirUuakOwyHsZ+TxcMUYY93qas9S7MbYMm kPiVTF7AdR5Gh751OEhg07Ov5bj2GaxHiy6JV+X7vzSjUQLM
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
 drivers/thermal/broadcom/ns-thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index d255aa879fc0..5eaf79c490f0 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -65,13 +65,11 @@ static int ns_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ns_thermal_remove(struct platform_device *pdev)
+static void ns_thermal_remove(struct platform_device *pdev)
 {
 	void __iomem *pvtmon = platform_get_drvdata(pdev);
 
 	iounmap(pvtmon);
-
-	return 0;
 }
 
 static const struct of_device_id ns_thermal_of_match[] = {
@@ -82,7 +80,7 @@ MODULE_DEVICE_TABLE(of, ns_thermal_of_match);
 
 static struct platform_driver ns_thermal_driver = {
 	.probe		= ns_thermal_probe,
-	.remove		= ns_thermal_remove,
+	.remove_new	= ns_thermal_remove,
 	.driver = {
 		.name = "ns-thermal",
 		.of_match_table = ns_thermal_of_match,
-- 
2.40.1

