Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC937E1129
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjKDVP7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjKDVP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346DDEB
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007wn-IF; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzY-006e1A-BU; Sat, 04 Nov 2023 22:15:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzY-00D1av-2F; Sat, 04 Nov 2023 22:15:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kbuild@vger.kernel.org
Subject: [PATCH 03/14] power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()
Date:   Sat,  4 Nov 2023 22:15:05 +0100
Message-ID: <20231104211501.3676352-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CzfLFzFhdKZJS53HV7olnleoDV2ECmztZSZ0hXx6qvU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRZvSUmVm+Ux2DDRAvxRKgCWmH6x9Tx/AWBs S3Mcf5rWu6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0WQAKCRCPgPtYfRL+ Tld8CACz7r9Zk4EtBHkBDdUVbuoeGgQPmN5+wiA8GgVpHuG7h7S5CNtvi59p2VYTke10Ooq0I3C mf4ZDqQ5I7hm4Htbb7EMc8AtBPljMUsPG/JTKAaxtqkPvt0pIzRpyPGzluwNStGHG4UOzv4puLq o1AzzH6ryb4UyP4qXcbKmdFGrZgnIulWB6F3ZK6vvUdMJjIiCK6Iaf7cw1SEtJLthS0Sqke39+/ SJAZZuMnLz/w+/93LjfPVhYUv+sXK9Vu6XqaPCR5nN3UDJTTjxGy9D9WXqC7rk6olJry5SjGzo6 FLXYgDeBqndSVhrWg7wEVZPcWyj7x2kdAn4glugVboSEkxXk
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
 drivers/power/reset/at91-sama5d2_shdwc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index e76b102b57b1..ef8add623363 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -329,7 +329,7 @@ static const struct of_device_id at91_pmc_ids[] = {
 	{ /* Sentinel. */ }
 };
 
-static int __init at91_shdwc_probe(struct platform_device *pdev)
+static int at91_shdwc_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device_node *np;
@@ -421,7 +421,7 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit at91_shdwc_remove(struct platform_device *pdev)
+static int at91_shdwc_remove(struct platform_device *pdev)
 {
 	struct shdwc *shdw = platform_get_drvdata(pdev);
 
@@ -442,13 +442,14 @@ static int __exit at91_shdwc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver at91_shdwc_driver = {
-	.remove = __exit_p(at91_shdwc_remove),
+	.probe = at91_shdwc_probe,
+	.remove = at91_shdwc_remove,
 	.driver = {
 		.name = "at91-shdwc",
 		.of_match_table = at91_shdwc_of_match,
 	},
 };
-module_platform_driver_probe(at91_shdwc_driver, at91_shdwc_probe);
+module_platform_driver(at91_shdwc_driver);
 
 MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
 MODULE_DESCRIPTION("Atmel shutdown controller driver");
-- 
2.42.0

