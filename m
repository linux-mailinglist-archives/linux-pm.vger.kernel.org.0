Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586C97B0CB4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjI0TiB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjI0Th6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CBE126
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-0002Fs-E2; Wed, 27 Sep 2023 21:37:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLx-009Pa5-1S; Wed, 27 Sep 2023 21:37:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-005RgI-OS; Wed, 27 Sep 2023 21:37:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 15/31] thermal: k3_bandgap: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:20 +0200
Message-Id: <20230927193736.2236447-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SyG9lEoEJ5Y7nBQv0324s5IbOFIPmCoox+ucvRaLCC4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSRliylGx+62XIVaxSYc5cmHBa3ePp/25nd+0psg3ckX Vp5+5JIJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQAT8X7J/r/Qd2+Uk2F3Lk/v 3xKvtXsNbzmImLLyanIyrfjasNu3MS170y7FyfIzpDQe9m1wOX1csXzdvuLfYY+nf2nLvFyh0nl h42wFcy6liHVa9T2TDbYI57JI6ifGNn3O3nvgz4dVL76XfXUR/LiiM4fj9aV38b92sRsxOEi6LF rWN9NQ98KaGqYli16LqWcdM/O8kqbOkWB19vPbNzz/wyVNX218kiKjIapU8lXI7mHntOkd8kebk 58LxYuwZN5Y4vKzz27hvpxfHK4z/uxUrl2XXKacVlJlraKgxTZ1w6ftvAms1uaJVWzmfPXCXypS V4WuturTjY477LXs8BfTxaknEiJ1i776VIe13N81Zb44AA==
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
 drivers/thermal/k3_bandgap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 4a918c1e92f9..e88192d2afea 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -235,12 +235,10 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int k3_bandgap_remove(struct platform_device *pdev)
+static void k3_bandgap_remove(struct platform_device *pdev)
 {
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id of_k3_bandgap_match[] = {
@@ -253,7 +251,7 @@ MODULE_DEVICE_TABLE(of, of_k3_bandgap_match);
 
 static struct platform_driver k3_bandgap_sensor_driver = {
 	.probe = k3_bandgap_probe,
-	.remove = k3_bandgap_remove,
+	.remove_new = k3_bandgap_remove,
 	.driver = {
 		.name = "k3-soc-thermal",
 		.of_match_table	= of_k3_bandgap_match,
-- 
2.40.1

