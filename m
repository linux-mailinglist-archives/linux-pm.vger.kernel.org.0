Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29242098AC
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389489AbgFYC4T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 22:56:19 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:45600 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388930AbgFYC4T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 22:56:19 -0400
X-IronPort-AV: E=Sophos;i="5.75,277,1589209200"; 
   d="scan'208";a="50534979"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jun 2020 11:56:17 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 24BE04006DF5;
        Thu, 25 Jun 2020 11:56:17 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     niklas.soderlund+renesas@ragnatech.se, van.do.xw@renesas.com,
        dien.pham.ry@renesas.com, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3] thermal: rcar_gen3_thermal: Fix undefined temperature if negative
Date:   Thu, 25 Jun 2020 11:56:08 +0900
Message-Id: <1593053768-31016-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
and fix bug too. Note that the variable name "reg" is not good
because it should be the same type as rcar_gen3_thermal_read().
However, there is better to rename it in a further patch as
cleanup.

Signed-off-by: Van Do <van.do.xw@renesas.com>
Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[shimoda: minor fixes, add Fixes tag]
Fixes: 564e73d283af ("thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>
---
 Changes from v2:
 - Add Niklas-san's Reviewed-by and Tested-by.
 - Keep the variable name "reg" and revise the commit description for it.
 https://patchwork.kernel.org/patch/11595327/

 Changes from v1:
 - Use int instead of long.
 - Rename "reg" with "ctemp".
 https://patchwork.kernel.org/patch/11593051/

 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 58fe7c1..c48c5e9 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -167,7 +167,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = devdata;
 	int mcelsius, val;
-	u32 reg;
+	int reg;
 
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
-- 
2.7.4

