Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F61262062E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 02:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiKHBf5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 20:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiKHBfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 20:35:48 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA11B791;
        Mon,  7 Nov 2022 17:35:40 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CBC1184EC7;
        Tue,  8 Nov 2022 02:35:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667871338;
        bh=kU4FGbS7/Tk0OfhvxTBr4MZprgUfQjdp0Gn5ygDXIlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgqIKHdERpjHYfh0sN2T5VwZ0LvKMzevCxfeB3lo3g5YCiazQ+dahnUNpwVJz5TKu
         MfoJkQF4zhPdeBKJt2JhHHNwdv8DOhxAR3GejL3MkWT8bWQ2MqFk9+fMVdtl59bxoN
         wILE/txKWrqnBjip7TrQx8j3iYF2wSd0zR5Nc4knTY15E9UDWqf6RqMb+xGPAB8ZEN
         zuZqWzaVurOzztJ3JNbkf4A7iK/JvyIFDvvgFx7hhtujKsBPzsCXlTHBY3ayV6CKzK
         8RhHohAVuuf2VRSA7uDJkVJGPOi5JvLo7BiaFwdt9Rq/DmYqkRpi6/FwSRrxJiCMD0
         kdzPt5aX4zg1A==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 2/3] [RFC] soc: imx: gpcv2: Split clock prepare from clock enable in the domain
Date:   Tue,  8 Nov 2022 02:35:16 +0100
Message-Id: <20221108013517.749665-2-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108013517.749665-1-marex@denx.de>
References: <20221108013517.749665-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible for clk_disable_unused() to trigger lockdep warning
regarding lock ordering in this driver. This happens in case of the
following conditions:

A) clock core clk_disable_unused() triggers the following sequence in a
   driver which also uses GPCv2 domain:
   - clk_prepare_lock() -> obtains clock core prepare_lock
   - pm_runtime_get*() -> obtains &blk_ctrl_genpd_lock_class

B) driver powers up a power domain and triggers the following sequence
   in GPCv2:
   - pm_runtime_get_sync() -> obtains &blk_ctrl_genpd_lock_class
   - clk_bulk_prepare_enable() -> obtains clock core prepare_lock

This can lead to a deadlock in case A and B runs on separate CPUs.

To avoid the deadlock, split clk_*prepare() from clk_*enable() and call
the former in power_pre_on() callback, before pm_runtime_get_sync(). The
reverse is implemented in the power_off_post() callback in the same way.
This way, the GPCv2 driver always claims the prepare_lock before
blk_ctrl_genpd_lock_class and the deadlock is avoided.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Martin Kepplinger <martink@posteo.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/soc/imx/gpcv2.c | 74 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 7a47d14fde445..8d27a227ba02d 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -298,6 +298,8 @@ struct imx_pgc_domain {
 
 	unsigned int pgc_sw_pup_reg;
 	unsigned int pgc_sw_pdn_reg;
+
+	int enabled;
 };
 
 struct imx_pgc_domain_data {
@@ -313,6 +315,52 @@ to_imx_pgc_domain(struct generic_pm_domain *genpd)
 	return container_of(genpd, struct imx_pgc_domain, genpd);
 }
 
+static int imx_pgc_power_pre_up(struct generic_pm_domain *genpd)
+{
+	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+	int ret;
+
+	ret = clk_bulk_prepare(domain->num_clks, domain->clks);
+	if (ret)
+		dev_err(domain->dev, "failed to prepare reset clocks\n");
+
+	return ret;
+}
+
+static int imx_pgc_power_post_up(struct generic_pm_domain *genpd)
+{
+	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+
+	if (!domain->keep_clocks && domain->enabled)
+		clk_bulk_unprepare(domain->num_clks, domain->clks);
+
+	return 0;
+}
+
+static int imx_pgc_power_down_pre(struct generic_pm_domain *genpd)
+{
+	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+	int ret;
+
+	if (!domain->keep_clocks || !domain->enabled) {
+		ret = clk_bulk_prepare(domain->num_clks, domain->clks);
+		if (ret)
+			dev_err(domain->dev, "failed to prepare reset clocks\n");
+	}
+
+	return ret;
+}
+
+static int imx_pgc_power_down_post(struct generic_pm_domain *genpd)
+{
+	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
+
+	if (!domain->keep_clocks || !domain->enabled)
+		clk_bulk_unprepare(domain->num_clks, domain->clks);
+
+	return 0;
+}
+
 static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 {
 	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
@@ -338,7 +386,7 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	reset_control_assert(domain->reset);
 
 	/* Enable reset clocks for all devices in the domain */
-	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	ret = clk_bulk_enable(domain->num_clks, domain->clks);
 	if (ret) {
 		dev_err(domain->dev, "failed to enable reset clocks\n");
 		goto out_regulator_disable;
@@ -397,12 +445,14 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 
 	/* Disable reset clocks for all devices in the domain */
 	if (!domain->keep_clocks)
-		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+		clk_bulk_disable(domain->num_clks, domain->clks);
+
+	domain->enabled++;
 
 	return 0;
 
 out_clk_disable:
-	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+	clk_bulk_disable(domain->num_clks, domain->clks);
 out_regulator_disable:
 	if (!IS_ERR(domain->regulator))
 		regulator_disable(domain->regulator);
@@ -420,7 +470,7 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 
 	/* Enable reset clocks for all devices in the domain */
 	if (!domain->keep_clocks) {
-		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+		ret = clk_bulk_enable(domain->num_clks, domain->clks);
 		if (ret) {
 			dev_err(domain->dev, "failed to enable reset clocks\n");
 			return ret;
@@ -467,7 +517,7 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 	}
 
 	/* Disable reset clocks for all devices in the domain */
-	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+	clk_bulk_disable(domain->num_clks, domain->clks);
 
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_disable(domain->regulator);
@@ -479,13 +529,17 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		}
 	}
 
+	domain->enabled--;
+
 	pm_runtime_put_sync_suspend(domain->dev);
 
 	return 0;
 
 out_clk_disable:
 	if (!domain->keep_clocks)
-		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+		clk_bulk_disable(domain->num_clks, domain->clks);
+
+	domain->enabled--;
 
 	return ret;
 }
@@ -1514,8 +1568,12 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		domain->regmap = regmap;
 		domain->regs = domain_data->pgc_regs;
 
-		domain->genpd.power_on  = imx_pgc_power_up;
-		domain->genpd.power_off = imx_pgc_power_down;
+		domain->genpd.power_pre_on	= imx_pgc_power_pre_up;
+		domain->genpd.power_on		= imx_pgc_power_up;
+		domain->genpd.power_post_on	= imx_pgc_power_post_up;
+		domain->genpd.power_off_pre	= imx_pgc_power_down_pre;
+		domain->genpd.power_off		= imx_pgc_power_down;
+		domain->genpd.power_off_post	= imx_pgc_power_down_post;
 
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
-- 
2.35.1

