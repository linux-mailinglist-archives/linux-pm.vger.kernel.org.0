Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1787EDFCE
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 12:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjKPL1C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 06:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjKPL07 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 06:26:59 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AC6187
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 03:26:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWH-00084D-AH; Thu, 16 Nov 2023 12:26:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWG-009RE9-PB; Thu, 16 Nov 2023 12:26:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWG-002aLy-G8; Thu, 16 Nov 2023 12:26:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Thu, 16 Nov 2023 12:26:36 +0100
Message-ID: <20231116112633.668826-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
References: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GhV61L6m5250RjClaUhpQ4Ok3kSdHAD+MEd8kv1eWac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVfxsDGe6lAm2SmhswY2cjWZPHW5ajdO34W3Uf Kv+prQDSaWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVX8bAAKCRCPgPtYfRL+ TnCdB/9YsxgNnfWbUb7UCsbX2HAdOY2Yfzz9LNLP1eNaSGSrM0GLE3kQxrg7zMrIPehmoErkHDs 9XYoZiByxH7hVvNKFHJaqNddzvjYKlCU0OZZe67sVdDBzq5yOpmLhAbEFHFrXm24exNVSuJRjjG Df+fILso3vPJl3TcY924K5/t/XnpXA2LJckEdBA/PWEvREucnpsnYFbcVUGDJ2aT7TRploQAa5f VPIHW4vHLSxba5jqFVrHptWosemRr7XFR073svBIEHGdESU19s0m0Izwl7+VFYZRH9cbP9JPYgW +3ERd08m9GEWDOeASyOxedH299LieKW4xNAdpQlGMxOk07Du
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
__maybe_unused can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/amlogic_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 562f63b7bf27..df7a5ed55385 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -296,7 +296,7 @@ static void amlogic_thermal_remove(struct platform_device *pdev)
 	amlogic_thermal_disable(data);
 }
 
-static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
+static int amlogic_thermal_suspend(struct device *dev)
 {
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
 
@@ -305,20 +305,21 @@ static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused amlogic_thermal_resume(struct device *dev)
+static int amlogic_thermal_resume(struct device *dev)
 {
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
 
 	return amlogic_thermal_enable(data);
 }
 
-static SIMPLE_DEV_PM_OPS(amlogic_thermal_pm_ops,
-			 amlogic_thermal_suspend, amlogic_thermal_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(amlogic_thermal_pm_ops,
+				amlogic_thermal_suspend,
+				amlogic_thermal_resume);
 
 static struct platform_driver amlogic_thermal_driver = {
 	.driver = {
 		.name		= "amlogic_thermal",
-		.pm		= &amlogic_thermal_pm_ops,
+		.pm		= pm_ptr(&amlogic_thermal_pm_ops),
 		.of_match_table = of_amlogic_thermal_match,
 	},
 	.probe = amlogic_thermal_probe,
-- 
2.42.0

