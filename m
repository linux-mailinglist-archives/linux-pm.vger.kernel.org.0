Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55D512FBA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiD1Jtr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiD1JhI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 05:37:08 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B6A95486;
        Thu, 28 Apr 2022 02:33:53 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,295,1643641200"; 
   d="scan'208";a="118308451"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Apr 2022 18:33:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.182])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AB39D40065BC;
        Thu, 28 Apr 2022 18:33:49 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] thermal/drivers/rz2gl: Fix OTP Calibration Register values
Date:   Thu, 28 Apr 2022 10:33:46 +0100
Message-Id: <20220428093346.7552-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As per the latest RZ/G2L Hardware User's Manual (Rev.1.10 Apr, 2022),
the bit 31 of TSU OTP Calibration Register(OTPTSUTRIM) indicates
whether bit [11:0] of OTPTSUTRIM is valid or invalid.

This patch updates the code to reflect this change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rzg2l_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 7a9cdc1f37ca..be07e04c6926 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -32,6 +32,8 @@
 #define TSU_SS		0x10
 
 #define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
+#define OTPTSUTRIM_EN_MASK	BIT(31)
+#define OTPTSUTRIM_MASK		GENMASK(11, 0)
 
 /* Sensor Mode Register(TSU_SM) */
 #define TSU_SM_EN_TS		BIT(0)
@@ -183,11 +185,15 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	priv->calib0 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
-	if (!priv->calib0)
+	if (priv->calib0 & OTPTSUTRIM_EN_MASK)
+		priv->calib0 &= OTPTSUTRIM_MASK;
+	else
 		priv->calib0 = SW_CALIB0_VAL;
 
 	priv->calib1 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
-	if (!priv->calib1)
+	if (priv->calib1 & OTPTSUTRIM_EN_MASK)
+		priv->calib1 &= OTPTSUTRIM_MASK;
+	else
 		priv->calib1 = SW_CALIB1_VAL;
 
 	platform_set_drvdata(pdev, priv);
-- 
2.25.1

