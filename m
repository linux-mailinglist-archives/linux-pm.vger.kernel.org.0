Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E41D4FA2
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEON4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 09:56:52 -0400
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:46066 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEON4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 09:56:52 -0400
X-Halon-ID: dfbcf185-96b3-11ea-a44f-005056917f90
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2392.dip0.t-ipconnect.de [79.202.35.146])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id dfbcf185-96b3-11ea-a44f-005056917f90;
        Fri, 15 May 2020 15:56:49 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] thermal: rcar_gen3_thermal: Do not shadow thcode variable
Date:   Fri, 15 May 2020 15:56:26 +0200
Message-Id: <20200515135626.2554873-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function rcar_gen3_thermal_calc_coefs() takes an argument called
'thcode' which shadows the static global 'thcode' variable. This is not
harmful but bad for readability and is harmful for planed changes to the
driver. The THCODE values should be read from hardware fuses if they are
available and only fallback to the global 'thcode' variable if they are
not fused.

Rename the global 'thcode' variable to 'thcodes' to avoid shadowing the
symbol in functions that takes it as an argument.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_gen3_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 58fe7c1ef00b1270..bb4f5b42beb943e3 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -63,7 +63,7 @@
 #define TSC_MAX_NUM	3
 
 /* default THCODE values if FUSEs are missing */
-static const int thcode[TSC_MAX_NUM][3] = {
+static const int thcodes[TSC_MAX_NUM][3] = {
 	{ 3397, 2800, 2221 },
 	{ 3393, 2795, 2216 },
 	{ 3389, 2805, 2237 },
@@ -172,7 +172,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
-	if (reg <= thcode[tsc->id][1])
+	if (reg <= thcodes[tsc->id][1])
 		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
 				tsc->coef.a1);
 	else
@@ -430,7 +430,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcode[i],
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i],
 					     *rcar_gen3_ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-- 
2.26.2

