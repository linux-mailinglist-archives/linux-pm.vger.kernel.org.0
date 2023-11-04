Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2887E112A
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjKDVQA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjKDVP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13058D61
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007wl-IE; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzX-006e14-Sw; Sat, 04 Nov 2023 22:15:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzX-00D1an-Jv; Sat, 04 Nov 2023 22:15:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kbuild@vger.kernel.org
Subject: [PATCH 01/14] power: reset: at91-poweroff: Stop using module_platform_driver_probe()
Date:   Sat,  4 Nov 2023 22:15:03 +0100
Message-ID: <20231104211501.3676352-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=A3GAxdaP9FxnJQ7rdo3LThGc0DGMFeHVPc7hJP55U5Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRX2ekh/1qZTC0n2BRRtCK1zpqrxzqdE79Ty O7zSdte1x6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0VwAKCRCPgPtYfRL+ TgohB/4ptjt30U5tviUVA9ykdAEiJCC/n+XKyhbI7DvZEqsdM1jiamjhnDbT5HChOF8pkXwThU/ LEFqkDWFI8QcI+dHXz2h8r5s9zHgibuCOappD3TfOTPh6XxTy1rDnqj8kAfy2T0uGRhU89kx0P6 LQL326NRBs3JDvMH9Xl1+jxKexLfzxhj1pAQrDWp7Gy+cNY+kYDma8l5l9Cv1hSmpMH3lQCD0hY pQWiNZylQGRlflUVP2QQoe9qll1RHeIdW9ueCP+3DzQ6B84rPz9GCGbhtu1ncrKJ1CFZb53XPn9 nUxYMBEtDZ9gq9qcdgq3yulGma+tSRJQS6GPi1tjEFTlMO3B
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

On today's platforms the benefit of platform_driver_probe() isn't that
relevant any more. It allows to drop some code after booting (or module
loading) for .probe() and discard the .remove() function completely if
the driver is built-in. This typically saves a few 100k.

The downside of platform_driver_probe() is that the driver cannot be
bound and unbound at runtime which is ancient and so slightly
complicates testing. There are also thoughts to deprecate
platform_driver_probe() because it adds some complexity in the driver
core for little gain. Also many drivers don't use it correctly. This
driver for example misses to mark the driver struct with __ref which is
needed to suppress a (W=1) modpost warning.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/reset/at91-poweroff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index dd5399785b69..83567428ab43 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -149,7 +149,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct platform_device *pdev)
 	writel(wakeup_mode | mode, at91_shdwc.shdwc_base + AT91_SHDW_MR);
 }
 
-static int __init at91_poweroff_probe(struct platform_device *pdev)
+static int at91_poweroff_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	u32 ddr_type;
@@ -202,7 +202,7 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit at91_poweroff_remove(struct platform_device *pdev)
+static int at91_poweroff_remove(struct platform_device *pdev)
 {
 	if (pm_power_off == at91_poweroff)
 		pm_power_off = NULL;
@@ -224,13 +224,14 @@ static const struct of_device_id at91_poweroff_of_match[] = {
 MODULE_DEVICE_TABLE(of, at91_poweroff_of_match);
 
 static struct platform_driver at91_poweroff_driver = {
-	.remove = __exit_p(at91_poweroff_remove),
+	.probe = at91_poweroff_probe,
+	.remove = at91_poweroff_remove,
 	.driver = {
 		.name = "at91-poweroff",
 		.of_match_table = at91_poweroff_of_match,
 	},
 };
-module_platform_driver_probe(at91_poweroff_driver, at91_poweroff_probe);
+module_platform_driver(at91_poweroff_driver);
 
 MODULE_AUTHOR("Atmel Corporation");
 MODULE_DESCRIPTION("Shutdown driver for Atmel SoCs");
-- 
2.42.0

