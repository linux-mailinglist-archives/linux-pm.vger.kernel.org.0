Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2944620631
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 02:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiKHBf6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 20:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiKHBfs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 20:35:48 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD94B1B9F0;
        Mon,  7 Nov 2022 17:35:40 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9467C84F1C;
        Tue,  8 Nov 2022 02:35:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667871339;
        bh=aD2mQVPfdWqzQxFkatpPuRDlb/RB7uncjpAoGFchjLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwN2OMmYAami925k9uoqFsKsHFnqHU6UoR0+3A1Q7jCMHgoVlp3ZKsI9LbdO2y0Fi
         FLVkyvmRnEq1uS8MCV416wMmX7TNX5equBQytJSb0ePDrxS7d1tmwtaOvtvJ9vk/w5
         oU2bmkjpSPIjn/TiS67eleNObkAhfOwSpUX27uFlosBXic4fXUMxaWyRn7V4OOBlm1
         /1m9fhqok31zLjToZjWs5gFtMd9e5kqVpIAjwuAYFpfFrqrmvXtBoHrJ4MMdCfy6Vp
         y33s0Fy9leUcQBf6BPsgPuqRkTuYKWo+eaSsAqe9WYaaNyyaYNBqeT1HkF5k3sWEK5
         bw5bRdC15u8og==
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
Subject: [PATCH 3/3] [RFC] soc: imx: imx8m-blk-ctrl: Split clock prepare from clock enable in the domain
Date:   Tue,  8 Nov 2022 02:35:17 +0100
Message-Id: <20221108013517.749665-3-marex@denx.de>
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
   driver which also uses blkctrl domain:
   - clk_prepare_lock() -> obtains clock core prepare_lock
   - pm_runtime_get*() -> obtains &blk_ctrl_genpd_lock_class

B) driver powers up a power domain and triggers the following sequence
   in blkctrl:
   - pm_runtime_get_sync() -> obtains &blk_ctrl_genpd_lock_class
   - clk_bulk_prepare_enable() -> obtains clock core prepare_lock

This can lead to a deadlock in case A and B runs on separate CPUs.

To avoid the deadlock, split clk_*prepare() from clk_*enable() and call
the former in power_pre_on() callback, before pm_runtime_get_sync(). The
reverse is implemented in the power_off_post() callback in the same way.
This way, the blkctrl driver always claims the prepare_lock before
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
 drivers/soc/imx/imx8mp-blk-ctrl.c | 38 +++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index ca4366e264783..844039d4e6bd2 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -408,6 +408,30 @@ static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mp_hdmi_domain_data),
 };
 
+static int imx8mp_blk_ctrl_power_pre_on(struct generic_pm_domain *genpd)
+{
+	struct imx8mp_blk_ctrl_domain *domain = to_imx8mp_blk_ctrl_domain(genpd);
+	const struct imx8mp_blk_ctrl_domain_data *data = domain->data;
+	struct imx8mp_blk_ctrl *bc = domain->bc;
+	int ret;
+
+	ret = clk_bulk_prepare(data->num_clks, domain->clks);
+	if (ret)
+		dev_err(bc->dev, "failed to enable clocks\n");
+
+	return ret;
+}
+
+static int imx8mp_blk_ctrl_power_off_post(struct generic_pm_domain *genpd)
+{
+	struct imx8mp_blk_ctrl_domain *domain = to_imx8mp_blk_ctrl_domain(genpd);
+	const struct imx8mp_blk_ctrl_domain_data *data = domain->data;
+
+	clk_bulk_unprepare(data->num_clks, domain->clks);
+
+	return 0;
+}
+
 static int imx8mp_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 {
 	struct imx8mp_blk_ctrl_domain *domain = to_imx8mp_blk_ctrl_domain(genpd);
@@ -423,7 +447,7 @@ static int imx8mp_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	}
 
 	/* enable upstream clocks */
-	ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
+	ret = clk_bulk_enable(data->num_clks, domain->clks);
 	if (ret) {
 		dev_err(bc->dev, "failed to enable clocks\n");
 		goto bus_put;
@@ -443,12 +467,12 @@ static int imx8mp_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	if (ret)
 		dev_err(bc->dev, "failed to set icc bw\n");
 
-	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
+	clk_bulk_disable(data->num_clks, domain->clks);
 
 	return 0;
 
 clk_disable:
-	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
+	clk_bulk_disable(data->num_clks, domain->clks);
 bus_put:
 	pm_runtime_put(bc->bus_power_dev);
 
@@ -462,7 +486,7 @@ static int imx8mp_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	struct imx8mp_blk_ctrl *bc = domain->bc;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
+	ret = clk_bulk_enable(data->num_clks, domain->clks);
 	if (ret) {
 		dev_err(bc->dev, "failed to enable clocks\n");
 		return ret;
@@ -471,7 +495,7 @@ static int imx8mp_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	/* domain specific blk-ctrl manipulation */
 	bc->power_off(bc, domain);
 
-	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
+	clk_bulk_disable(data->num_clks, domain->clks);
 
 	/* power down upstream GPC domain */
 	pm_runtime_put(domain->power_dev);
@@ -585,8 +609,12 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		dev_set_name(domain->power_dev, "%s", data->name);
 
 		domain->genpd.name = data->name;
+		domain->genpd.power_pre_on = imx8mp_blk_ctrl_power_pre_on;
 		domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
+		domain->genpd.power_post_on = imx8mp_blk_ctrl_power_off_post;
+		domain->genpd.power_off_pre = imx8mp_blk_ctrl_power_pre_on;
 		domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
+		domain->genpd.power_off_post = imx8mp_blk_ctrl_power_off_post;
 		domain->bc = bc;
 		domain->id = i;
 
-- 
2.35.1

