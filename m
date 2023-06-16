Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A422B73306D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjFPLuq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344604AbjFPLuq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 07:50:46 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074F8191;
        Fri, 16 Jun 2023 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=USThQHd+r+y3fIZdDT3tkPIUoOuMjXqSY6LcqwbJs08=; b=Nr6oo5pwCggvc3nB7cNoOXqCVe
        RLs7rF7A+zjOX0kqtJVxapS66/IGF9MaO0YtNgktm0kmpeWfSd7/8O4Q0G3i/2oTxBv/AhS4Nhj5H
        Opz62XtBu3Rbnyrqb8gvMOUb2QU2Ul1CxQinhLjHCCfcRCjFt59x2KLGuRaz82vm4TDcdZ7w/khPm
        4EJEXYgYbY+iIasyY+8EOJU51OMMtb4dZ6fvr0TBmXTiYucD684gnk9BN2xxBglkbkqpdSu5en+6A
        hdTCRgyg0KR7GvBPE/tpvu7vOWU2puIx2RVhJ+G0deau+yQH7Dvey1EaV5hu1/wf/5d0VRVftXwKp
        48n6nVjA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48894 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qA7yV-0004y7-8W; Fri, 16 Jun 2023 12:50:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qA7yU-00Ea4u-Je; Fri, 16 Jun 2023 12:50:42 +0100
In-Reply-To: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
References: <ZIxMYXDCTB7IvsDk@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     Amit Kucheria <amitk@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/3] thermal: armada: add support for AP807 thermal data
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qA7yU-00Ea4u-Je@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 16 Jun 2023 12:50:42 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Alex Leibovich <alexl@marvell.com>

Add support for the AP807 die thermal data. This is the same as AP806,
except for the coefficients.

ap807 values taken from TSENSE_ADC_16FFC spec, which says:
	T(in Celsius) = T(code)*TSENE_GAIN+TSENE_OFFSET
where in default:
	TSENE_OFFSET = 128.9
	TSENE_GAIN = 0.394

Signed-off-by: Alex Leibovich <alexl@marvell.com>
Tested-by: sa_ip-sw-jenkins <sa_ip-sw-jenkins@marvell.com>
Reviewed-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/thermal/armada_thermal.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 2efc222a379b..f64c2b508542 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -231,7 +231,7 @@ static void armada380_init(struct platform_device *pdev,
 	regmap_write(priv->syscon, data->syscon_control0_off, reg);
 }
 
-static void armada_ap806_init(struct platform_device *pdev,
+static void armada_ap80x_init(struct platform_device *pdev,
 			      struct armada_thermal_priv *priv)
 {
 	struct armada_thermal_data *data = priv->data;
@@ -620,7 +620,7 @@ static const struct armada_thermal_data armada380_data = {
 };
 
 static const struct armada_thermal_data armada_ap806_data = {
-	.init = armada_ap806_init,
+	.init = armada_ap80x_init,
 	.is_valid_bit = BIT(16),
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
@@ -643,6 +643,30 @@ static const struct armada_thermal_data armada_ap806_data = {
 	.cpu_nr = 4,
 };
 
+static const struct armada_thermal_data armada_ap807_data = {
+	.init = armada_ap80x_init,
+	.is_valid_bit = BIT(16),
+	.temp_shift = 0,
+	.temp_mask = 0x3ff,
+	.thresh_shift = 3,
+	.hyst_shift = 19,
+	.hyst_mask = 0x3,
+	.coef_b = -128900LL,
+	.coef_m = 394ULL,
+	.coef_div = 1,
+	.inverted = true,
+	.signed_sample = true,
+	.syscon_control0_off = 0x84,
+	.syscon_control1_off = 0x88,
+	.syscon_status_off = 0x8C,
+	.dfx_irq_cause_off = 0x108,
+	.dfx_irq_mask_off = 0x10C,
+	.dfx_overheat_irq = BIT(22),
+	.dfx_server_irq_mask_off = 0x104,
+	.dfx_server_irq_en = BIT(1),
+	.cpu_nr = 4,
+};
+
 static const struct armada_thermal_data armada_cp110_data = {
 	.init = armada_cp110_init,
 	.is_valid_bit = BIT(10),
@@ -686,6 +710,10 @@ static const struct of_device_id armada_thermal_id_table[] = {
 		.compatible = "marvell,armada-ap806-thermal",
 		.data       = &armada_ap806_data,
 	},
+	{
+		.compatible = "marvell,armada-ap807-thermal",
+		.data       = &armada_ap807_data,
+	},
 	{
 		.compatible = "marvell,armada-cp110-thermal",
 		.data       = &armada_cp110_data,
-- 
2.30.2

