Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D6C7B0CCB
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjI0TiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjI0TiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C910E
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:38:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM1-0002Z8-Qe; Wed, 27 Sep 2023 21:37:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM0-009Pap-Lt; Wed, 27 Sep 2023 21:37:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaM0-005Rh4-CR; Wed, 27 Sep 2023 21:37:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?utf-8?q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 27/31] thermal: stm: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:32 +0200
Message-Id: <20230927193736.2236447-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wdpMw5JzEvxaXagtk1dsizCUtUbJdxGNcbw4iT5Zf2s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIR3hjV5wMnJA98u7QQq2KRE6NFjbR30iM1Ta LaitesBBjuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEdwAKCRCPgPtYfRL+ Tga3B/489By4Xyjqvz19TcCTf3qVlYoLp1qqBeeSm+U+vlQtQlZ4GcdmT3FP93Dt9cqFDXYkpD5 3DQam1eMaragsy3YpLSolLr7ULjIJbaxiBY1YS3QJoawLArV4j2DVdZKOmy2F4CHxqNDuAmDdCB T177yZYTqsIw8v8ZP8LopiRUpAtGMFiJdMSywzJ/sGM8hM6oGQ0XpUA1Ltrv834pk3OYeTZNDhL SSEgfIDhrn9WiL7xACX7EkWBxX7yuryJ/MFFS4OZfjXmS8+0y03wnRdG1A1jMdSmflegmW+Olv4 oY3u3/aPHlu6xKfmQ7hBkVyXRqPevQlXLpGKdPOyHF3Zfvjp
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
 drivers/thermal/st/stm_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 142a7e5d12f4..34785b9276fc 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -569,14 +569,12 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm_thermal_remove(struct platform_device *pdev)
+static void stm_thermal_remove(struct platform_device *pdev)
 {
 	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
 
 	stm_thermal_sensor_off(sensor);
 	thermal_remove_hwmon_sysfs(sensor->th_dev);
-
-	return 0;
 }
 
 static struct platform_driver stm_thermal_driver = {
@@ -586,7 +584,7 @@ static struct platform_driver stm_thermal_driver = {
 		.of_match_table = stm_thermal_of_match,
 	},
 	.probe		= stm_thermal_probe,
-	.remove		= stm_thermal_remove,
+	.remove_new	= stm_thermal_remove,
 };
 module_platform_driver(stm_thermal_driver);
 
-- 
2.40.1

