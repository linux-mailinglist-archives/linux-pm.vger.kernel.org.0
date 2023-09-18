Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA287A4E86
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjIRQSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjIRQSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B38274AB
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-0001q7-E3; Mon, 18 Sep 2023 15:37:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-007EYT-1A; Mon, 18 Sep 2023 15:37:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER1-002fWM-NY; Mon, 18 Sep 2023 15:37:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 08/32] power: supply: cpcap-battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:36 +0200
Message-Id: <20230918133700.1254499-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=W1BPXiZHc1y9UWzOM4V1wlkQL4JKJicHGy1RNjT0lrA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJZJAQpHI3yHQIUs8a6dbf9YlOqnzosFZ1N7 +NceNXnwReJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSWQAKCRCPgPtYfRL+ Tqb8CACVuiy7XcBY7aPhuZmCcK4h5tdDlFr/Kg15fFqy+Bhc41GptCarIWU6Gs/slpKF3lxzo4U TQccGhOLtCaTN/AeArL1Mfyjkxdvg/U2IvKX4MpqqBX7QsvpVVLw8MQbUEjDRC7jWIpNH4yyJe/ v9FwTMcYp1f2eAxlK9MbwPSni5wjz6SP5oS+2Gm9QGhS9mHs0vLQXEfEjbhLWBBsu3gFIK7L/tc Zk8/d8bTNDo3hcqsKprBNAVMU9Na25y8cHPHnF9TAS5ewT9bux/6EDIx2HL24Gq7XvndvusKfXH KFwRBNsODVFMaeVHYgOeNgliLNICKKcGzbAJoRH71RCBfT2E
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
 drivers/power/supply/cpcap-battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 5dd76c0ac98d..30ec76cdf34b 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1151,7 +1151,7 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int cpcap_battery_remove(struct platform_device *pdev)
+static void cpcap_battery_remove(struct platform_device *pdev)
 {
 	struct cpcap_battery_ddata *ddata = platform_get_drvdata(pdev);
 	int error;
@@ -1161,8 +1161,6 @@ static int cpcap_battery_remove(struct platform_device *pdev)
 				   0xffff, 0);
 	if (error)
 		dev_err(&pdev->dev, "could not disable: %i\n", error);
-
-	return 0;
 }
 
 static struct platform_driver cpcap_battery_driver = {
@@ -1171,7 +1169,7 @@ static struct platform_driver cpcap_battery_driver = {
 		.of_match_table = of_match_ptr(cpcap_battery_id_table),
 	},
 	.probe	= cpcap_battery_probe,
-	.remove = cpcap_battery_remove,
+	.remove_new = cpcap_battery_remove,
 };
 module_platform_driver(cpcap_battery_driver);
 
-- 
2.40.1

