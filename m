Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFAC732751
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 08:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbjFPGWX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 02:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFPGWQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 02:22:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3449B2D65
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 23:22:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q7-0006nc-VV; Fri, 16 Jun 2023 08:21:44 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q6-007kxk-SO; Fri, 16 Jun 2023 08:21:42 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q4-003FUA-GA; Fri, 16 Jun 2023 08:21:40 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 04/26] PM / devfreq: rockchip-dfi: Add SoC specific init function
Date:   Fri, 16 Jun 2023 08:20:39 +0200
Message-Id: <20230616062101.601837-5-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616062101.601837-1-s.hauer@pengutronix.de>
References: <20230616062101.601837-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the RK3399 specifics to a SoC specific init function to make
the way free for supporting other SoCs later.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20230524083153.2046084-5-s.hauer@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v4:
    - use of_device_get_match_data()
    - use a callback rather than a struct type as driver data

 drivers/devfreq/event/rockchip-dfi.c | 48 +++++++++++++++++++---------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index e19e5acaa362c..6b1ef29df7048 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <soc/rockchip/rk3399_grf.h>
 
@@ -55,27 +56,21 @@ struct rockchip_dfi {
 	void __iomem *regs;
 	struct regmap *regmap_pmu;
 	struct clk *clk;
+	u32 ddr_type;
 };
 
 static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 {
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	void __iomem *dfi_regs = dfi->regs;
-	u32 val;
-	u32 ddr_type;
-
-	/* get ddr type */
-	regmap_read(dfi->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
-	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
-		    RK3399_PMUGRF_DDRTYPE_MASK;
 
 	/* clear DDRMON_CTRL setting */
 	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
 
 	/* set ddr type to dfi */
-	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
+	if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
 		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
-	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
+	else if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
 		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
 
 	/* enable count, use software mode */
@@ -167,8 +162,26 @@ static const struct devfreq_event_ops rockchip_dfi_ops = {
 	.set_event = rockchip_dfi_set_event,
 };
 
+static int rk3399_dfi_init(struct rockchip_dfi *dfi)
+{
+	struct regmap *regmap_pmu = dfi->regmap_pmu;
+	u32 val;
+
+	dfi->clk = devm_clk_get(dfi->dev, "pclk_ddr_mon");
+	if (IS_ERR(dfi->clk))
+		return dev_err_probe(dfi->dev, PTR_ERR(dfi->clk),
+				     "Cannot get the clk pclk_ddr_mon\n");
+
+	/* get ddr type */
+	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
+	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
+			RK3399_PMUGRF_DDRTYPE_MASK;
+
+	return 0;
+};
+
 static const struct of_device_id rockchip_dfi_id_match[] = {
-	{ .compatible = "rockchip,rk3399-dfi" },
+	{ .compatible = "rockchip,rk3399-dfi", .data = rk3399_dfi_init },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_dfi_id_match);
@@ -179,6 +192,12 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	struct rockchip_dfi *dfi;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
+	int (*soc_init)(struct rockchip_dfi *dfi);
+	int ret;
+
+	soc_init = of_device_get_match_data(&pdev->dev);
+	if (!soc_init)
+		return -EINVAL;
 
 	dfi = devm_kzalloc(dev, sizeof(*dfi), GFP_KERNEL);
 	if (!dfi)
@@ -188,11 +207,6 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	if (IS_ERR(dfi->regs))
 		return PTR_ERR(dfi->regs);
 
-	dfi->clk = devm_clk_get(dev, "pclk_ddr_mon");
-	if (IS_ERR(dfi->clk))
-		return dev_err_probe(dev, PTR_ERR(dfi->clk),
-				     "Cannot get the clk pclk_ddr_mon\n");
-
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
 	if (!node)
 		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf registers\n");
@@ -209,6 +223,10 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	desc->driver_data = dfi;
 	desc->name = np->name;
 
+	ret = soc_init(dfi);
+	if (ret)
+		return ret;
+
 	dfi->edev = devm_devfreq_event_add_edev(&pdev->dev, desc);
 	if (IS_ERR(dfi->edev)) {
 		dev_err(&pdev->dev,
-- 
2.39.2

