Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C81F3A05
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgFILpV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 07:45:21 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:32408 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726395AbgFILpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 07:45:21 -0400
X-IronPort-AV: E=Sophos;i="5.73,491,1583161200"; 
   d="scan'208";a="48999935"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jun 2020 20:45:19 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 66AD84224204;
        Tue,  9 Jun 2020 20:45:19 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     niklas.soderlund+renesas@ragnatech.se, van.do.xw@renesas.com,
        dien.pham.ry@renesas.com, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] thermal: rcar_gen3_thermal: Fix undefined temperature if negative
Date:   Tue,  9 Jun 2020 20:45:10 +0900
Message-Id: <1591703110-14869-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dien Pham <dien.pham.ry@renesas.com>

As description for DIV_ROUND_CLOSEST in file include/linux/kernel.h.
  "Result is undefined for negative divisors if the dividend variable
   type is unsigned and for negative dividends if the divisor variable
   type is unsigned."

In current code, the FIXPT_DIV uses DIV_ROUND_CLOSEST but has not
checked sign of divisor before using. It makes undefined temperature
value in case the value is negative.

This patch fixes to satisfy DIV_ROUND_CLOSEST description
and fix bug too. Note that the name "reg" is not good because it should
be the same type as rcar_gen3_thermal_read(). So, rename it with "ctemp".

Signed-off-by: Van Do <van.do.xw@renesas.com>
Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[shimoda: minor fixes, add Fixes tag]
Fixes: 564e73d283af ("thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v1:
 - Use int instead of long.
 - Rename "reg" with "ctemp".
 https://patchwork.kernel.org/patch/11593051/

 drivers/thermal/rcar_gen3_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 58fe7c1..49ea330 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -167,16 +167,16 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = devdata;
 	int mcelsius, val;
-	u32 reg;
+	int ctemp;
 
 	/* Read register and convert to mili Celsius */
-	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
+	ctemp = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
-	if (reg <= thcode[tsc->id][1])
-		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
+	if (ctemp <= thcode[tsc->id][1])
+		val = FIXPT_DIV(FIXPT_INT(ctemp) - tsc->coef.b1,
 				tsc->coef.a1);
 	else
-		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
+		val = FIXPT_DIV(FIXPT_INT(ctemp) - tsc->coef.b2,
 				tsc->coef.a2);
 	mcelsius = FIXPT_TO_MCELSIUS(val);
 
-- 
2.7.4

