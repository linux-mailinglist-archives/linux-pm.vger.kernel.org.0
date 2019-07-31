Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34E97CFC5
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfGaVMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 17:12:34 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10576 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbfGaVLJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 17:11:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4203ec0000>; Wed, 31 Jul 2019 14:11:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 14:11:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 31 Jul 2019 14:11:08 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 21:11:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 21:11:07 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.102.167]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4203eb0001>; Wed, 31 Jul 2019 14:11:07 -0700
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
Subject: [PATCH v7 08/20] clk: tegra: clk-super: Fix to enable PLLP branches to CPU
Date:   Wed, 31 Jul 2019 14:10:51 -0700
Message-ID: <1564607463-28802-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
References: <1564607463-28802-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564607468; bh=KL6/tuub/E0oXDS5hOgM0iBiE+qywcp7ZA4PIbfJ4uM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=etufhG3xe9A8A2qVjlwltEdS5ptimwtxpy6x2eGsJ3n4oellmjUOTdDU2bh6m6q9f
         uVTGQDOIC7v/8s41eUjik8hJcS9FB241RgLA97j9nq+Tn3JedF8/BbR7FL+e5LjrEJ
         y1rN21CwhqvIIY+Cggn5s09E9+SYCdEHJDTyvZRwyoeCUK7ruMFAz0y4+/X8Fhbxi8
         fZgRH51LIoBKnRKRTSSWXQQZn9/Ddzk795T7FFHu2srWvkxEU93ZRm5ECjDNzPGpLe
         LocuhgzUINax8JGrUzyoNBdS9dUSy+uYyq6eknwDxXpEphqTmCrhT9BI72Va6IrqXQ
         j/CVil3ZqdvPw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch has a fix to enable PLLP branches to CPU before changing
the CPU clusters clock source to PLLP for Gen5 Super clock and
disables PLLP branches to CPU when not in use.

During system suspend entry and exit, CPU source will be switched
to PLLP and this needs PLLP branches to be enabled to CPU prior to
the switch.

On system resume, warmboot code enables PLLP branches to CPU and
powers up the CPU with PLLP clock source.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-super.c            | 14 ++++++++++++++
 drivers/clk/tegra/clk-tegra-super-gen4.c |  2 +-
 drivers/clk/tegra/clk.c                  | 14 ++++++++++++++
 drivers/clk/tegra/clk.h                  |  5 +++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index 39ef31b46df5..e2a1e95a8db7 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -28,6 +28,9 @@
 #define super_state_to_src_shift(m, s) ((m->width * s))
 #define super_state_to_src_mask(m) (((1 << m->width) - 1))
 
+#define CCLK_SRC_PLLP_OUT0 4
+#define CCLK_SRC_PLLP_OUT4 5
+
 static u8 clk_super_get_parent(struct clk_hw *hw)
 {
 	struct tegra_clk_super_mux *mux = to_clk_super_mux(hw);
@@ -97,12 +100,23 @@ static int clk_super_set_parent(struct clk_hw *hw, u8 index)
 		if (index == mux->div2_index)
 			index = mux->pllx_index;
 	}
+
+	/* enable PLLP branches to CPU before selecting PLLP source */
+	if ((mux->flags & TEGRA210_CPU_CLK) &&
+	    (index == CCLK_SRC_PLLP_OUT0 || index == CCLK_SRC_PLLP_OUT4))
+		tegra_clk_set_pllp_out_cpu(true);
+
 	val &= ~((super_state_to_src_mask(mux)) << shift);
 	val |= (index & (super_state_to_src_mask(mux))) << shift;
 
 	writel_relaxed(val, mux->reg);
 	udelay(2);
 
+	/* disable PLLP branches to CPU if not used */
+	if ((mux->flags & TEGRA210_CPU_CLK) &&
+	    index != CCLK_SRC_PLLP_OUT0 && index != CCLK_SRC_PLLP_OUT4)
+		tegra_clk_set_pllp_out_cpu(false);
+
 out:
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
index cdfe7c9697e1..888d76b01c75 100644
--- a/drivers/clk/tegra/clk-tegra-super-gen4.c
+++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
@@ -180,7 +180,7 @@ static void __init tegra_super_clk_init(void __iomem *clk_base,
 					gen_info->num_cclk_g_parents,
 					CLK_SET_RATE_PARENT,
 					clk_base + CCLKG_BURST_POLICY,
-					0, 4, 8, 0, NULL);
+					TEGRA210_CPU_CLK, 4, 8, 0, NULL);
 		} else {
 			clk = tegra_clk_register_super_mux("cclk_g",
 					gen_info->cclk_g_parents,
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 573e3c967ae1..eb08047fd02f 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -23,6 +23,7 @@
 #define CLK_OUT_ENB_W			0x364
 #define CLK_OUT_ENB_X			0x280
 #define CLK_OUT_ENB_Y			0x298
+#define CLK_ENB_PLLP_OUT_CPU		BIT(31)
 #define CLK_OUT_ENB_SET_L		0x320
 #define CLK_OUT_ENB_CLR_L		0x324
 #define CLK_OUT_ENB_SET_H		0x328
@@ -199,6 +200,19 @@ const struct tegra_clk_periph_regs *get_reg_bank(int clkid)
 	}
 }
 
+void tegra_clk_set_pllp_out_cpu(bool enable)
+{
+	u32 val;
+
+	val = readl_relaxed(clk_base + CLK_OUT_ENB_Y);
+	if (enable)
+		val |= CLK_ENB_PLLP_OUT_CPU;
+	else
+		val &= ~CLK_ENB_PLLP_OUT_CPU;
+
+	writel_relaxed(val, clk_base + CLK_OUT_ENB_Y);
+}
+
 struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 {
 	clk_base = regs;
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index d61e61eebf4a..f8de447f505b 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -687,6 +687,9 @@ struct clk *tegra_clk_register_periph_data(void __iomem *clk_base,
  * Flags:
  * TEGRA_DIVIDER_2 - LP cluster has additional divider. This flag indicates
  *     that this is LP cluster clock.
+ * TEGRA210_CPU_CLK - This flag indicates this is CPU cluster clock. To use
+ * PLLP for CPU clock source, need to enable PLLP branches to CPU by setting
+ * additional bit PLLP_OUT_CPU for gen5 super clock.
  */
 struct tegra_clk_super_mux {
 	struct clk_hw	hw;
@@ -703,6 +706,7 @@ struct tegra_clk_super_mux {
 #define to_clk_super_mux(_hw) container_of(_hw, struct tegra_clk_super_mux, hw)
 
 #define TEGRA_DIVIDER_2 BIT(0)
+#define TEGRA210_CPU_CLK BIT(1)
 
 extern const struct clk_ops tegra_clk_super_ops;
 struct clk *tegra_clk_register_super_mux(const char *name,
@@ -849,6 +853,7 @@ int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, u8 p_div);
 int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
 		 u8 frac_width, u8 flags);
 void tegra_clk_osc_resume(void __iomem *clk_base);
+void tegra_clk_set_pllp_out_cpu(bool enable);
 
 
 /* Combined read fence with delay */
-- 
2.7.4

