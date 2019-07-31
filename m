Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA27CF71
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfGaVLK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:11:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10569 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfGaVLJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203eb0002>; Wed, 31 Jul 2019 14:11:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 31 Jul 2019 14:11:07 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:07 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203ea0001>; Wed, 31 Jul 2019 14:11:06 -0700
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
Subject: [PATCH v7 04/20] clk: tegra: pllout: Save and restore pllout context
Date:   Wed, 31 Jul 2019 14:10:47 -0700
Message-ID: <1564607463-28802-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607467; bh=gmpyRLDLg2IvNU52Z9/8lv6Z/RyFHiSrtLLnefPSW+c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=q3bO7m8mUNPdWOCx0+oCa61oJbZYtP17z0GNuBt/dEIPXXAE3v6HR5bTJIbnbZbpO
         vRjVVwxor2qNwSPx5MvjosRhA0ikg3ZvmfHhmIE5+nJgU8VeCisl0M8xaY3QJUx/Le
         Wva1u9iozPmIBzCiIan6P887jFIdvJYmT9xn2RnMdXd8WleDkuSW6o69OmkfKb6vnf
         +JwEcbM6KJkrID0uSgehegI1jtLzCsqX2wvbOF21op+glMviZDB76Is6dnPQpkbaAG
         x4bZc2ohP0DAGGDq9CxgLc82NVYK4LhVI49vJEefgfJDUrVj0u+ckuxvhOViZENmeg
         tEFeeOmFqhFJA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch implements save and restore of pllout context.

During system suspend, core power goes off and looses the settings
of the Tegra CAR controller registers.

So during suspend entry the state of pllout is saved and on resume
it is restored back to have pllout in same state as before suspend.

pllout rate is saved and restore in clock divider so it will be at
same rate as before suspend when pllout state is restored.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-pll-out.c  | 26 ++++++++++++++++++++++++++
 drivers/clk/tegra/clk-tegra210.c |  3 ++-
 drivers/clk/tegra/clk.h          |  9 +++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-pll-out.c b/drivers/clk/tegra/clk-pll-out.c
index 35f2bf00e1e6..312a3e8ef398 100644
--- a/drivers/clk/tegra/clk-pll-out.c
+++ b/drivers/clk/tegra/clk-pll-out.c
@@ -69,10 +69,36 @@ static void clk_pll_out_disable(struct clk_hw *hw)
 		spin_unlock_irqrestore(pll_out->lock, flags);
 }
 
+static int tegra_clk_pll_out_save_context(struct clk_hw *hw)
+{
+	struct tegra_clk_pll_out *pll_out = to_clk_pll_out(hw);
+
+	if (pll_out->flags & TEGRA_PLLRE_OUT)
+		pll_out->pllout_ctx = readl_relaxed(pll_out->reg);
+
+	return 0;
+}
+
+static void tegra_clk_pll_out_restore_context(struct clk_hw *hw)
+{
+	struct tegra_clk_pll_out *pll_out = to_clk_pll_out(hw);
+
+	if (pll_out->flags & TEGRA_PLLRE_OUT) {
+		writel_relaxed(pll_out->pllout_ctx, pll_out->reg);
+	} else {
+		if (!__clk_get_enable_count(hw->clk))
+			clk_pll_out_disable(hw);
+		else
+			clk_pll_out_enable(hw);
+	}
+}
+
 const struct clk_ops tegra_clk_pll_out_ops = {
 	.is_enabled = clk_pll_out_is_enabled,
 	.enable = clk_pll_out_enable,
 	.disable = clk_pll_out_disable,
+	.save_context = tegra_clk_pll_out_save_context,
+	.restore_context = tegra_clk_pll_out_restore_context,
 };
 
 struct clk *tegra_clk_register_pll_out(const char *name,
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index df172d5772d7..4721ee030d1c 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3200,7 +3200,8 @@ static void __init tegra210_pll_init(void __iomem *clk_base,
 					 8, 8, 1, NULL);
 	clk = tegra_clk_register_pll_out("pll_re_out1", "pll_re_out1_div",
 					 clk_base + PLLRE_OUT1, 1, 0,
-					 CLK_SET_RATE_PARENT, 0, NULL);
+					 CLK_SET_RATE_PARENT, TEGRA_PLLRE_OUT,
+					 NULL);
 	clks[TEGRA210_CLK_PLL_RE_OUT1] = clk;
 
 	/* PLLE */
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 905bf1096558..230c05d8eef0 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -437,6 +437,12 @@ struct clk *tegra_clk_register_pllu_tegra210(const char *name,
  * @rst_bit_idx:	bit to reset PLL divider
  * @lock:		register lock
  * @flags:		hardware-specific flags
+ * @pllout_ctx:		pllout context to save and restore during suspend
+ *			and resume
+ *
+ * Flags:
+ * TEGRA_PLLRE_OUT - This flag indicates that it is PLLRE_OUT and is used to
+ *		     identify PLLRE_OUT during clk_pll_out save and restore.
  */
 struct tegra_clk_pll_out {
 	struct clk_hw	hw;
@@ -445,8 +451,11 @@ struct tegra_clk_pll_out {
 	u8		rst_bit_idx;
 	spinlock_t	*lock;
 	u8		flags;
+	u32		pllout_ctx;
 };
 
+#define TEGRA_PLLRE_OUT BIT(0)
+
 #define to_clk_pll_out(_hw) container_of(_hw, struct tegra_clk_pll_out, hw)
 
 extern const struct clk_ops tegra_clk_pll_out_ops;
-- 
2.7.4

