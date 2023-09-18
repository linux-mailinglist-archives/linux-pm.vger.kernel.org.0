Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7B7A4F2B
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjIRQfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjIRQe4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:34:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AAB21AC0
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:14:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER7-0002Cc-Bz; Mon, 18 Sep 2023 15:37:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-007EZv-Va; Mon, 18 Sep 2023 15:37:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER6-002fXm-MT; Mon, 18 Sep 2023 15:37:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 30/32] power: supply: wm831x_power: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:58 +0200
Message-Id: <20230918133700.1254499-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bryEUPVoOQQ2wo8mmXbRwX9lGUFBv/XUcwjw14lpV20=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJyf+duCL1WMNaTufPnU8hVa47EaXCQIy+9p lEkr0uj8GCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhScgAKCRCPgPtYfRL+ Ttr8B/9hgeMueXh3JJrYmdH1tQKYwbbsJYxUSEVxISl9vV5QDmDM3MYKRpWG+kz6wntz5mYxtgn fr7nEJoSf4BL3PKnrx4tu1z2E326/LS/2LOQ5bQPDBKvonHqkT+zy0q8qhTEkg0zhEj+m8GGXbN lfmffx3xIyFxNs1vfeEjzt8YGrM91uXpI46ZLQxR2lJEAQLe5bWfYAyGbnrXPYRclY20yCXfWnx 8D7l0MJssT9HI2D9JrM3lc1VTSTyHs7TYeUP2GD7JgGpFkjqb+S9GEgpTE3Ru1iy3u7EMLqUGTv iyrT5vBzs2qT+nelQtaI4NRORS9SSb9lqMuRT8BHhRVJE5hF
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
 drivers/power/supply/wm831x_power.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index 82e31066c746..e49b01ee5f3e 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -694,7 +694,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int wm831x_power_remove(struct platform_device *pdev)
+static void wm831x_power_remove(struct platform_device *pdev)
 {
 	struct wm831x_power *wm831x_power = platform_get_drvdata(pdev);
 	struct wm831x *wm831x = wm831x_power->wm831x;
@@ -722,12 +722,11 @@ static int wm831x_power_remove(struct platform_device *pdev)
 		power_supply_unregister(wm831x_power->battery);
 	power_supply_unregister(wm831x_power->wall);
 	power_supply_unregister(wm831x_power->usb);
-	return 0;
 }
 
 static struct platform_driver wm831x_power_driver = {
 	.probe = wm831x_power_probe,
-	.remove = wm831x_power_remove,
+	.remove_new = wm831x_power_remove,
 	.driver = {
 		.name = "wm831x-power",
 	},
-- 
2.40.1

