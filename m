Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC47E1122
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 22:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjKDVPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 17:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjKDVPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 17:15:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DE0D67
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 14:15:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNzb-000802-2R; Sat, 04 Nov 2023 22:15:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-006e1i-JH; Sat, 04 Nov 2023 22:15:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzNza-00D1bZ-AD; Sat, 04 Nov 2023 22:15:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 13/14] power: reset: syscon-poweroff: Convert to platform remove callback returning void
Date:   Sat,  4 Nov 2023 22:15:15 +0100
Message-ID: <20231104211501.3676352-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=srRqgDebF7NkrOrBEc9PnJLcBA/1azi3DtczUI+cGTw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlRrRkIeQItkrku7yG36o8Rfme+j3461bxs0FJK w1vMYVmHXqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUa0ZAAKCRCPgPtYfRL+ TndSB/9iy+G/v7/Oy+555IMKLtO1ma5A2MCa1Wx/gczjeGo5m//5aVYYpXbJ5Z7npTyTQbGD0MS +XoBrxI5lp4fEOTnEtXRXJ/7t09MsAxTWWauFY+005Za9lOkjb1TdJsKt9vPZKkjmWVmNsofVJ0 kQLSYB3fQjf0yFmOD/qOGiU4IT41uVqfaT/chnEyIvvqB50xmafd2nr+GsGEkS2dcRs/hfFfIf+ dt+QUJEdgHKX5HHEY5W6w02W6b+hhX4DLsF6O2hNg+y4gH6harITIumIr6+DR3YCYSU2Sm7eeoo sCYoTtDA0U7MDHnXJbo/9FTTurZkvwv0Z2NrZ3h7y6tHItST
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
 drivers/power/reset/syscon-poweroff.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index c3aab7f59345..1b2ce7734260 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -76,12 +76,10 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int syscon_poweroff_remove(struct platform_device *pdev)
+static void syscon_poweroff_remove(struct platform_device *pdev)
 {
 	if (pm_power_off == syscon_poweroff)
 		pm_power_off = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id syscon_poweroff_of_match[] = {
@@ -91,7 +89,7 @@ static const struct of_device_id syscon_poweroff_of_match[] = {
 
 static struct platform_driver syscon_poweroff_driver = {
 	.probe = syscon_poweroff_probe,
-	.remove = syscon_poweroff_remove,
+	.remove_new = syscon_poweroff_remove,
 	.driver = {
 		.name = "syscon-poweroff",
 		.of_match_table = syscon_poweroff_of_match,
-- 
2.42.0

