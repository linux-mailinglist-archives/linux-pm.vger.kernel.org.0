Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9D86E0B
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404965AbfHHXrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 19:47:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17829 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404788AbfHHXrG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 19:47:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb4790000>; Thu, 08 Aug 2019 16:47:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:47:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 16:47:03 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Aug 2019 23:47:03 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.110]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cb4760004>; Thu, 08 Aug 2019 16:47:02 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>,
        <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v8 05/21] clk: tegra: pll: Save and restore pll context
Date:   Thu, 8 Aug 2019 16:46:44 -0700
Message-ID: <1565308020-31952-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565308025; bh=+RrIyyq/a5RwtKD+kltNeSYSPE/V/5yZ63xRpL2sp2c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=f7K97+d5MEzw2ZVyeGqchujaYBj8RJn+G7014wPhqH5hIvdYUXDPeLVfbRvfncGfU
         7PqBQA5jpvW0LaIPxU5mloY+I8j2FAuIj4arghHQPLpMftfGd+lZipmp8HmL2Z7gwI
         NHvY5WXWa3YbBuJYxhktQkf9tnaB6zKl/CAQ7kuz0/O5uPBCVkfurfFZKrRkdRhKPS
         vPs4NsSvpL6JG5oo/IKyK+ntkDKqenqWSTOS1UyZ9o459+2QPRxbXSMeH/6r/Uwg4E
         D0cIkpKPzANq5nBGMvLcEZUuge6W9Xqq2Onsw+phBZ7/XF9d+OAEEQBLgba18hFfkT
         U92652QUO8sjQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements save and restore of PLL context.

During system suspend, core power goes off and looses the settings
of the Tegra CAR controller registers.

So during suspend entry pll context is stored and on resume it is
restored back along with its state.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-pll.c | 88 ++++++++++++++++++++++++++++-----------------
 drivers/clk/tegra/clk.h     |  2 ++
 2 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 1583f5fc992f..e52add2bbdbb 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1008,6 +1008,28 @@ static unsigned long clk_plle_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
+static void tegra_clk_pll_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	unsigned long parent_rate = clk_hw_get_rate(parent);
+	unsigned long rate = clk_hw_get_rate(hw);
+	u32 val;
+
+	if (clk_pll_is_enabled(hw))
+		return;
+
+	if (pll->params->set_defaults)
+		pll->params->set_defaults(pll);
+
+	clk_pll_set_rate(hw, rate, parent_rate);
+
+	if (!__clk_get_enable_count(hw->clk))
+		clk_pll_disable(hw);
+	else
+		clk_pll_enable(hw);
+}
+
 const struct clk_ops tegra_clk_pll_ops = {
 	.is_enabled = clk_pll_is_enabled,
 	.enable = clk_pll_enable,
@@ -1015,6 +1037,7 @@ const struct clk_ops tegra_clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.round_rate = clk_pll_round_rate,
 	.set_rate = clk_pll_set_rate,
+	.restore_context = tegra_clk_pll_restore_context,
 };
 
 const struct clk_ops tegra_clk_plle_ops = {
@@ -1802,6 +1825,27 @@ static int clk_pllu_tegra114_enable(struct clk_hw *hw)
 
 	return ret;
 }
+
+static void _clk_plle_tegra_init_parent(struct tegra_clk_pll *pll)
+{
+	u32 val, val_aux;
+
+	/* ensure parent is set to pll_ref */
+	val = pll_readl_base(pll);
+	val_aux = pll_readl(pll->params->aux_reg, pll);
+
+	if (val & PLL_BASE_ENABLE) {
+		if ((val_aux & PLLE_AUX_PLLRE_SEL) ||
+		    (val_aux & PLLE_AUX_PLLP_SEL))
+			WARN(1, "pll_e enabled with unsupported parent %s\n",
+			     (val_aux & PLLE_AUX_PLLP_SEL) ? "pllp_out0" :
+			     "pll_re_vco");
+	} else {
+		val_aux &= ~(PLLE_AUX_PLLRE_SEL | PLLE_AUX_PLLP_SEL);
+		pll_writel(val_aux, pll->params->aux_reg, pll);
+		fence_udelay(1, pll->clk_base);
+	}
+}
 #endif
 
 static struct tegra_clk_pll *_tegra_init_pll(void __iomem *clk_base,
@@ -2214,27 +2258,12 @@ struct clk *tegra_clk_register_plle_tegra114(const char *name,
 {
 	struct tegra_clk_pll *pll;
 	struct clk *clk;
-	u32 val, val_aux;
 
 	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
 	if (IS_ERR(pll))
 		return ERR_CAST(pll);
 
-	/* ensure parent is set to pll_re_vco */
-
-	val = pll_readl_base(pll);
-	val_aux = pll_readl(pll_params->aux_reg, pll);
-
-	if (val & PLL_BASE_ENABLE) {
-		if ((val_aux & PLLE_AUX_PLLRE_SEL) ||
-			(val_aux & PLLE_AUX_PLLP_SEL))
-			WARN(1, "pll_e enabled with unsupported parent %s\n",
-			  (val_aux & PLLE_AUX_PLLP_SEL) ? "pllp_out0" :
-					"pll_re_vco");
-	} else {
-		val_aux &= ~(PLLE_AUX_PLLRE_SEL | PLLE_AUX_PLLP_SEL);
-		pll_writel(val_aux, pll_params->aux_reg, pll);
-	}
+	_clk_plle_tegra_init_parent(pll);
 
 	clk = _tegra_clk_register_pll(pll, name, parent_name, flags,
 				      &tegra_clk_plle_tegra114_ops);
@@ -2276,6 +2305,7 @@ static const struct clk_ops tegra_clk_pllss_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.round_rate = clk_pll_ramp_round_rate,
 	.set_rate = clk_pllxc_set_rate,
+	.restore_context = tegra_clk_pll_restore_context,
 };
 
 struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
@@ -2375,6 +2405,7 @@ struct clk *tegra_clk_register_pllre_tegra210(const char *name,
 		pll_params->vco_min = pll_params->adjust_vco(pll_params,
 							     parent_rate);
 
+	pll_params->flags |= TEGRA_PLLRE;
 	pll = _tegra_init_pll(clk_base, pmc, pll_params, lock);
 	if (IS_ERR(pll))
 		return ERR_CAST(pll);
@@ -2520,11 +2551,19 @@ static void clk_plle_tegra210_disable(struct clk_hw *hw)
 		spin_unlock_irqrestore(pll->lock, flags);
 }
 
+static void tegra_clk_plle_t210_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_pll *pll = to_clk_pll(hw);
+
+	_clk_plle_tegra_init_parent(pll);
+}
+
 static const struct clk_ops tegra_clk_plle_tegra210_ops = {
 	.is_enabled =  clk_plle_tegra210_is_enabled,
 	.enable = clk_plle_tegra210_enable,
 	.disable = clk_plle_tegra210_disable,
 	.recalc_rate = clk_pll_recalc_rate,
+	.restore_context = tegra_clk_plle_t210_restore_context,
 };
 
 struct clk *tegra_clk_register_plle_tegra210(const char *name,
@@ -2535,27 +2574,12 @@ struct clk *tegra_clk_register_plle_tegra210(const char *name,
 {
 	struct tegra_clk_pll *pll;
 	struct clk *clk;
-	u32 val, val_aux;
 
 	pll = _tegra_init_pll(clk_base, NULL, pll_params, lock);
 	if (IS_ERR(pll))
 		return ERR_CAST(pll);
 
-	/* ensure parent is set to pll_re_vco */
-
-	val = pll_readl_base(pll);
-	val_aux = pll_readl(pll_params->aux_reg, pll);
-
-	if (val & PLLE_BASE_ENABLE) {
-		if ((val_aux & PLLE_AUX_PLLRE_SEL) ||
-			(val_aux & PLLE_AUX_PLLP_SEL))
-			WARN(1, "pll_e enabled with unsupported parent %s\n",
-			  (val_aux & PLLE_AUX_PLLP_SEL) ? "pllp_out0" :
-					"pll_re_vco");
-	} else {
-		val_aux &= ~(PLLE_AUX_PLLRE_SEL | PLLE_AUX_PLLP_SEL);
-		pll_writel(val_aux, pll_params->aux_reg, pll);
-	}
+	_clk_plle_tegra_init_parent(pll);
 
 	clk = _tegra_clk_register_pll(pll, name, parent_name, flags,
 				      &tegra_clk_plle_tegra210_ops);
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index a464524fbc90..dc546292e030 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -233,6 +233,7 @@ struct tegra_clk_pll;
  * TEGRA_PLLMB - PLLMB has should be treated similar to PLLM. This
  *     flag indicated that it is PLLMB.
  * TEGRA_PLL_VCO_OUT - Used to indicate that the PLL has a VCO output
+ * TEGRA_PLLRE - Used to indicate that it is PLLRE
  */
 struct tegra_clk_pll_params {
 	unsigned long	input_min;
@@ -299,6 +300,7 @@ struct tegra_clk_pll_params {
 #define TEGRA_MDIV_NEW BIT(11)
 #define TEGRA_PLLMB BIT(12)
 #define TEGRA_PLL_VCO_OUT BIT(13)
+#define TEGRA_PLLRE BIT(14)
 
 /**
  * struct tegra_clk_pll - Tegra PLL clock
-- 
2.7.4

