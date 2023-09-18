Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434BB7A50C1
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjIRROy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjIRROx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 13:14:53 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651E1FED
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:10:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-0001wC-Pt; Mon, 18 Sep 2023 15:37:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER3-007EYo-55; Mon, 18 Sep 2023 15:37:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER2-002fWg-SA; Mon, 18 Sep 2023 15:37:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 13/32] power: supply: goldfish_battery: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:41 +0200
Message-Id: <20230918133700.1254499-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=y72EgNf7ctYp9lWq0PeLJDCgY7D5jVZUxz3iBX7F2jk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJf3yS00YSrK648+vECAajvRAkSVYCEXyZ39 vb40PQmF3CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSXwAKCRCPgPtYfRL+ TrPyCAC0nrKtPc6swKT6BLF/PQg2Wn50MgNiHvV4YQIG0jN01xJQVeg1bknBD7iJ/WV0bsTGcMi f5Run/7woOiMzKYh9GfYSL72Ifzxa7fbCEshHtxSgrymCe8xPkb6wCoqf8us165pQIFhsc9Zy64 SqfdbmN49WDbSiGRhMQZtB1Q3gS9g7PdkIu90zeCsynWoKYK2cI0DAFd+PE5+EZUWumTJihwTpP oWfO38LiDKNiWDi6UQuxXC30XinBx0dKySJtHjfNaMxIIR2Bx75ke6v1Kz4iRiXH67p01n75L5x kriB8KnDq+0L4qAJmqFFh7J4aiPDwTedHH0refic8vPqCW4j
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
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
 drivers/power/supply/goldfish_battery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index a58d713d75ce..8bb645ad1e5d 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -249,13 +249,12 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int goldfish_battery_remove(struct platform_device *pdev)
+static void goldfish_battery_remove(struct platform_device *pdev)
 {
 	struct goldfish_battery_data *data = platform_get_drvdata(pdev);
 
 	power_supply_unregister(data->battery);
 	power_supply_unregister(data->ac);
-	return 0;
 }
 
 static const struct of_device_id goldfish_battery_of_match[] = {
@@ -274,7 +273,7 @@ MODULE_DEVICE_TABLE(acpi, goldfish_battery_acpi_match);
 
 static struct platform_driver goldfish_battery_device = {
 	.probe		= goldfish_battery_probe,
-	.remove		= goldfish_battery_remove,
+	.remove_new	= goldfish_battery_remove,
 	.driver = {
 		.name = "goldfish-battery",
 		.of_match_table = goldfish_battery_of_match,
-- 
2.40.1

