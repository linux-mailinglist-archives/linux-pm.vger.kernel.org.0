Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F931FF5C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfD3SFs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 14:05:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfD3SFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 14:05:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id A31AB28336F
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Derek Basehore <dbasehore@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        kernel@collabora.com
Subject: [RFC 3/4] clk: rockchip: merge clk-ddr in dmc devfreq driver
Date:   Tue, 30 Apr 2019 14:05:23 -0400
Message-Id: <20190430180524.22710-4-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430180524.22710-1-gael.portay@collabora.com>
References: <20190430180524.22710-1-gael.portay@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Rockchip DMC devfreq driver is the only user of the Rockchip DDR
clock.

Both drivers perform SMC calls to the Trusted-Firmware A to run SiP
services related to the DDR memory.

This commit centralizes the SiP services in the DMC devfreq driver and
removes the DDR clock which becomes useless.

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---
 drivers/clk/rockchip/Makefile     |   1 -
 drivers/clk/rockchip/clk-ddr.c    | 147 ------------------------------
 drivers/clk/rockchip/clk-rk3399.c |   2 -
 drivers/clk/rockchip/clk.c        |   9 --
 drivers/clk/rockchip/clk.h        |  33 -------
 drivers/devfreq/rk3399_dmc.c      |  42 ++++++---
 6 files changed, 28 insertions(+), 206 deletions(-)
 delete mode 100644 drivers/clk/rockchip/clk-ddr.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index ff35ab463a6f..25014216c6d7 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -10,7 +10,6 @@ obj-y	+= clk-half-divider.o
 obj-y	+= clk-inverter.o
 obj-y	+= clk-mmc-phase.o
 obj-y	+= clk-muxgrf.o
-obj-y	+= clk-ddr.o
 obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
 
 obj-y	+= clk-px30.o
diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
deleted file mode 100644
index ebce5260068b..000000000000
--- a/drivers/clk/rockchip/clk-ddr.c
+++ /dev/null
@@ -1,147 +0,0 @@
-/*
- * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
- * Author: Lin Huang <hl@rock-chips.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/arm-smccc.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <soc/rockchip/rockchip_sip.h>
-#include "clk.h"
-
-struct rockchip_ddrclk {
-	struct clk_hw	hw;
-	void __iomem	*reg_base;
-	int		mux_offset;
-	int		mux_shift;
-	int		mux_width;
-	int		div_shift;
-	int		div_width;
-	int		ddr_flag;
-	spinlock_t	*lock;
-};
-
-#define to_rockchip_ddrclk_hw(hw) container_of(hw, struct rockchip_ddrclk, hw)
-
-static int rockchip_ddrclk_sip_set_rate(struct clk_hw *hw, unsigned long drate,
-					unsigned long prate)
-{
-	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
-	unsigned long flags;
-	struct arm_smccc_res res;
-
-	spin_lock_irqsave(ddrclk->lock, flags);
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, drate, 0,
-		      ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE,
-		      0, 0, 0, 0, &res);
-	spin_unlock_irqrestore(ddrclk->lock, flags);
-
-	return res.a0;
-}
-
-static unsigned long
-rockchip_ddrclk_sip_recalc_rate(struct clk_hw *hw,
-				unsigned long parent_rate)
-{
-	struct arm_smccc_res res;
-
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
-		      ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE,
-		      0, 0, 0, 0, &res);
-
-	return res.a0;
-}
-
-static long rockchip_ddrclk_sip_round_rate(struct clk_hw *hw,
-					   unsigned long rate,
-					   unsigned long *prate)
-{
-	struct arm_smccc_res res;
-
-	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, rate, 0,
-		      ROCKCHIP_SIP_CONFIG_DRAM_ROUND_RATE,
-		      0, 0, 0, 0, &res);
-
-	return res.a0;
-}
-
-static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
-{
-	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
-	u32 val;
-
-	val = clk_readl(ddrclk->reg_base +
-			ddrclk->mux_offset) >> ddrclk->mux_shift;
-	val &= GENMASK(ddrclk->mux_width - 1, 0);
-
-	return val;
-}
-
-static const struct clk_ops rockchip_ddrclk_sip_ops = {
-	.recalc_rate = rockchip_ddrclk_sip_recalc_rate,
-	.set_rate = rockchip_ddrclk_sip_set_rate,
-	.round_rate = rockchip_ddrclk_sip_round_rate,
-	.get_parent = rockchip_ddrclk_get_parent,
-};
-
-struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
-					 const char *const *parent_names,
-					 u8 num_parents, int mux_offset,
-					 int mux_shift, int mux_width,
-					 int div_shift, int div_width,
-					 int ddr_flag, void __iomem *reg_base,
-					 spinlock_t *lock)
-{
-	struct rockchip_ddrclk *ddrclk;
-	struct clk_init_data init;
-	struct clk *clk;
-
-	ddrclk = kzalloc(sizeof(*ddrclk), GFP_KERNEL);
-	if (!ddrclk)
-		return ERR_PTR(-ENOMEM);
-
-	init.name = name;
-	init.parent_names = parent_names;
-	init.num_parents = num_parents;
-
-	init.flags = flags;
-	init.flags |= CLK_SET_RATE_NO_REPARENT;
-
-	switch (ddr_flag) {
-	case ROCKCHIP_DDRCLK_SIP:
-		init.ops = &rockchip_ddrclk_sip_ops;
-		break;
-	default:
-		pr_err("%s: unsupported ddrclk type %d\n", __func__, ddr_flag);
-		kfree(ddrclk);
-		return ERR_PTR(-EINVAL);
-	}
-
-	ddrclk->reg_base = reg_base;
-	ddrclk->lock = lock;
-	ddrclk->hw.init = &init;
-	ddrclk->mux_offset = mux_offset;
-	ddrclk->mux_shift = mux_shift;
-	ddrclk->mux_width = mux_width;
-	ddrclk->div_shift = div_shift;
-	ddrclk->div_width = div_width;
-	ddrclk->ddr_flag = ddr_flag;
-
-	clk = clk_register(NULL, &ddrclk->hw);
-	if (IS_ERR(clk))
-		kfree(ddrclk);
-
-	return clk;
-}
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 5a628148f3f0..9f01463ad62e 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1396,8 +1396,6 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	     2, GFLAGS),
 	GATE(0, "clk_ddrc_gpll_src", "gpll", 0, RK3399_CLKGATE_CON(3),
 	     3, GFLAGS),
-	COMPOSITE_DDRCLK(SCLK_DDRC, "sclk_ddrc", mux_ddrclk_p, 0,
-		       RK3399_CLKSEL_CON(6), 4, 2, 0, 0, ROCKCHIP_DDRCLK_SIP),
 };
 
 static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index c3ad92965823..971fdda693f7 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -544,15 +544,6 @@ void __init rockchip_clk_register_branches(
 				list->gate_offset, list->gate_shift,
 				list->gate_flags, flags, &ctx->lock);
 			break;
-		case branch_ddrclk:
-			clk = rockchip_clk_register_ddrclk(
-				list->name, list->flags,
-				list->parent_names, list->num_parents,
-				list->muxdiv_offset, list->mux_shift,
-				list->mux_width, list->div_shift,
-				list->div_width, list->div_flags,
-				ctx->reg_base, &ctx->lock);
-			break;
 		}
 
 		/* none of the cases above matched */
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 6b53fff4cc96..0a486fdffa6a 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -354,20 +354,6 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg, int shift);
 
-/*
- * DDRCLK flags, including method of setting the rate
- * ROCKCHIP_DDRCLK_SIP: use SIP call to bl31 to change ddrclk rate.
- */
-#define ROCKCHIP_DDRCLK_SIP		BIT(0)
-
-struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
-					 const char *const *parent_names,
-					 u8 num_parents, int mux_offset,
-					 int mux_shift, int mux_width,
-					 int div_shift, int div_width,
-					 int ddr_flags, void __iomem *reg_base,
-					 spinlock_t *lock);
-
 #define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
 
 struct clk *rockchip_clk_register_inverter(const char *name,
@@ -392,7 +378,6 @@ enum rockchip_clk_branch_type {
 	branch_mmc,
 	branch_inverter,
 	branch_factor,
-	branch_ddrclk,
 	branch_half_divider,
 };
 
@@ -583,24 +568,6 @@ struct rockchip_clk_branch {
 		.child		= ch,				\
 	}
 
-#define COMPOSITE_DDRCLK(_id, cname, pnames, f, mo, ms, mw,	\
-			 ds, dw, df)				\
-	{							\
-		.id		= _id,				\
-		.branch_type	= branch_ddrclk,		\
-		.name		= cname,			\
-		.parent_names	= pnames,			\
-		.num_parents	= ARRAY_SIZE(pnames),		\
-		.flags		= f,				\
-		.muxdiv_offset  = mo,                           \
-		.mux_shift      = ms,                           \
-		.mux_width      = mw,                           \
-		.div_shift      = ds,                           \
-		.div_width      = dw,                           \
-		.div_flags	= df,				\
-		.gate_offset    = -1,                           \
-	}
-
 #define MUX(_id, cname, pnames, f, o, s, w, mf)			\
 	{							\
 		.id		= _id,				\
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index daf19e121c99..7f9c8c0cf45d 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/arm-smccc.h>
-#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq-event.h>
@@ -67,7 +66,6 @@ struct rk3399_dmcfreq {
 	struct device *dev;
 	struct devfreq *devfreq;
 	struct devfreq_simple_ondemand_data ondemand_data;
-	struct clk *dmc_clk;
 	struct devfreq_event_dev *edev;
 	struct mutex lock;
 	struct dram_timing timing;
@@ -79,6 +77,31 @@ struct rk3399_dmcfreq {
 	int odt_pd_arg0, odt_pd_arg1;
 };
 
+static int rk3399_ddrclk_set_rate(unsigned long rate)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, rate, 0,
+		      ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE,
+		      0, 0, 0, 0, &res);
+
+	if (rate != res.a0 * 1000000L)
+		return -1; /* TODO which errno?*/
+
+	return 0;
+}
+
+static unsigned long rk3399_ddrclk_get_rate(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
+		      ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE,
+		      0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
 static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 				 u32 flags)
 {
@@ -130,7 +153,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		}
 	}
 
-	err = clk_set_rate(dmcfreq->dmc_clk, target_rate);
+	err = rk3399_ddrclk_set_rate(target_rate);
 	if (err) {
 		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
 			err);
@@ -145,7 +168,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	 * 1. Ddr frequency scaling fail, we still get the old rate.
 	 * 2. Ddr frequency scaling sucessful, we get the rate we set.
 	 */
-	dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);
+	dmcfreq->rate = rk3399_ddrclk_get_rate();
 
 	/* If get the incorrect rate, set voltage to old value. */
 	if (dmcfreq->rate != target_rate) {
@@ -338,15 +361,6 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(data->vdd_center);
 	}
 
-	data->dmc_clk = devm_clk_get(dev, "dmc_clk");
-	if (IS_ERR(data->dmc_clk)) {
-		if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(dev, "Cannot get the clk dmc_clk\n");
-		return PTR_ERR(data->dmc_clk);
-	};
-
 	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(data->edev))
 		return -EPROBE_DEFER;
@@ -441,7 +455,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	of_property_read_u32(np, "downdifferential",
 			     &data->ondemand_data.downdifferential);
 
-	data->rate = clk_get_rate(data->dmc_clk);
+	data->rate = rk3399_ddrclk_get_rate();
 
 	opp = devfreq_recommended_opp(dev, &data->rate, 0);
 	if (IS_ERR(opp)) {
-- 
2.21.0

