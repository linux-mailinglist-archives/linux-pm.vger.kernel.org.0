Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D51F4A66
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 02:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgFJAdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 20:33:21 -0400
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:43038 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgFJAdV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 20:33:21 -0400
X-Halon-ID: f0f30e9c-aab1-11ea-86ee-0050569116f7
Authorized-sender: niklas@soderlund.pp.se
Received: from bismarck.berto.se (p4fca2eca.dip0.t-ipconnect.de [79.202.46.202])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id f0f30e9c-aab1-11ea-86ee-0050569116f7;
        Wed, 10 Jun 2020 02:33:06 +0200 (CEST)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] thermal: rcar_gen3_thermal: Do not shadow thcode variable
Date:   Wed, 10 Jun 2020 02:33:00 +0200
Message-Id: <20200610003300.884258-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function rcar_gen3_thermal_calc_coefs() takes an argument called
'thcode' which shadows the static global 'thcode' variable. This is not
harmful but bad for readability and is harmful for planned changes to
the driver. The THCODE values should be read from hardware fuses if they
are available and only fallback to the global 'thcode' variable if they
are not fused.

Rename the global 'thcode' variable to 'thcodes' to avoid shadowing the
symbol in functions that take it as an argument.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
2.27.0

