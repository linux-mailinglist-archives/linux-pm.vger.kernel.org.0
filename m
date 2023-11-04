Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1977E111E
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjKDVPs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjKDVPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF0DE
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-0007y8-3W; Sat, 04 Nov 2023 22:15:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzZ-006e1T-N2; Sat, 04 Nov 2023 22:15:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzZ-00D1bJ-E9; Sat, 04 Nov 2023 22:15:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/14] power: reset: qnap-poweroff: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:11 +0100
Message-ID: <20231104211501.3676352-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dfaMAPhvxy/mHztWjQrVgLmEuJYDpZlsaR/T2B0PtJo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRgMlKCgw7yxjM4Pw3gUQPlPFNHFcQCDHbQ5 RD0zXFzc0iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0YAAKCRCPgPtYfRL+ TtgWB/9rPG6zaajLDXZ/m0a6LPGJUS9dcWqQZJqNOXIJopK1kuKsJ0Z2W27LhUt0wHtRDOqHlXp GPgyEDkOqsgbKS+9dp1INO3VD/Km/MLcbaT37sJoHrtaDoyeIrLOjrzswg8R0rris3BSK108alY WnUlzl1I7j8+SfQZ3JmXPgAugRMDEZf9Op16sHvXQKTCGvX8BPXw1vBqR49p4GOmXA+L0wKu5MQ GCBgJ0gVXkXuWi8VtbNVcOCvuRhtjAI2jxVZPHT6PIFmpRXwFztMVkjEA4ncDCzmpOztHAZTvxV HDgUhX7mlCRQd+ceRojoN7oF089hiZT5qzgCOXP9htsviez8
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
 drivers/power/reset/qnap-poweroff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
index 0ddf7f25f7b8..e0f2ff6b147c 100644
--- a/drivers/power/reset/qnap-poweroff.c
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -111,15 +111,14 @@ static int qnap_power_off_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qnap_power_off_remove(struct platform_device *pdev)
+static void qnap_power_off_remove(struct platform_device *pdev)
 {
 	pm_power_off = NULL;
-	return 0;
 }
 
 static struct platform_driver qnap_power_off_driver = {
 	.probe	= qnap_power_off_probe,
-	.remove	= qnap_power_off_remove,
+	.remove_new = qnap_power_off_remove,
 	.driver	= {
 		.name	= "qnap_power_off",
 		.of_match_table = of_match_ptr(qnap_power_off_of_match_table),
-- 
2.42.0

