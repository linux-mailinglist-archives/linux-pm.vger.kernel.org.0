Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8839DEF8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGOn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGOnZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 10:43:25 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D13EC061766
        for <linux-pm@vger.kernel.org>; Mon,  7 Jun 2021 07:41:34 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2826:1cc7:8a57:d8e9])
        by michel.telenet-ops.be with bizsmtp
        id EEhP250012r2Z3l06EhPyK; Mon, 07 Jun 2021 16:41:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lqGRO-00E2qq-I5; Mon, 07 Jun 2021 16:41:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lqGRN-006xAR-RH; Mon, 07 Jun 2021 16:41:21 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: rcar_gen3_thermal: Do not shadow rcar_gen3_ths_tj_1
Date:   Mon,  7 Jun 2021 16:41:20 +0200
Message-Id: <9ea7e65d0331daba96f9a7925cb3d12d2170efb1.1623076804.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With -Wshadow:

    drivers/thermal/rcar_gen3_thermal.c: In function ‘rcar_gen3_thermal_probe’:
    drivers/thermal/rcar_gen3_thermal.c:310:13: warning: declaration of ‘rcar_gen3_ths_tj_1’ shadows a global declaration [-Wshadow]
      310 |  const int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
	  |             ^~~~~~~~~~~~~~~~~~
    drivers/thermal/rcar_gen3_thermal.c:246:18: note: shadowed declaration is here
      246 | static const int rcar_gen3_ths_tj_1 = 126;
	  |                  ^~~~~~~~~~~~~~~~~~

To add to the confusion, the local variable has a different type.

Fix the shadowing by renaming the local variable to ths_tj_1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_gen3_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e1e412348076b2ff..42c079ba0d51e4b3 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -307,7 +307,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	const int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
+	const int *ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	int ret, i;
@@ -352,8 +352,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i],
-					     *rcar_gen3_ths_tj_1);
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
-- 
2.25.1

