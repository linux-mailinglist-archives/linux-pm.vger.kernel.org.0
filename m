Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C01C86E27
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404865AbfHHXre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 19:47:34 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17865 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404930AbfHHXrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 19:47:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb47b0000>; Thu, 08 Aug 2019 16:47:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:47:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 16:47:05 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:05 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:47:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Aug 2019 23:47:04 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.110]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cb4780002>; Thu, 08 Aug 2019 16:47:04 -0700
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
Subject: [PATCH v8 14/21] clk: tegra210: Add suspend and resume support
Date:   Thu, 8 Aug 2019 16:46:53 -0700
Message-ID: <1565308020-31952-15-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565308027; bh=oOXci0LTaxeupXCkafbmCNJiqmGwePmC5ieg9XO8iEA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=IN3L/IhA4KLfgewx+tPHxhwu5XddOl9dv+7x+DoFglKKBU+AqIUvx7Pteymi6ySZo
         hMhvP1CRCQDgQKO44RW5w8v3N3MKpNCez6Ailwis4GtKz2+OLoVKeGRZiC6N7cEKpE
         VYSVRTBWaWdY6r2NsJyL2/DPYrPXuB/7xPzYhQRXQWAX8dFflPkAAByjR4633FUX5h
         SfKZlR56imXK9dJR+sN9P9K7DO9yNx2l+U2jCUxASJ7i+IVJDbr4D18+ITNXPFTaKZ
         Dzym7ERtV9oE3tzJe6CvmebiMp5nkS60ZAyC7XyzTVmVmk4wnXV3KEYMRMQPJ9hc1z
         aBGMl84pkPSoQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds support for clk: tegra210: suspend-resume.

All the CAR controller settings are lost on suspend when core
power goes off.

This patch has implementation for saving and restoring all PLLs
and clocks context during system suspend and resume to have the
clocks back to same state for normal operation.

Clock driver suspend and resume are registered as syscore_ops as clocks
restore need to happen before the other drivers resume to have all their
clocks back to the same state as before suspend.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-tegra210.c | 103 +++++++++++++++++++++++++++++++++++++--
 drivers/clk/tegra/clk.c          |  64 ++++++++++++++++++++++++
 drivers/clk/tegra/clk.h          |   3 ++
 3 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 998bf60b219a..8dd6f4f4debb 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -9,13 +9,13 @@
 #include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/syscore_ops.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/clk/tegra.h>
 #include <dt-bindings/clock/tegra210-car.h>
 #include <dt-bindings/reset/tegra210-car.h>
-#include <linux/iopoll.h>
 #include <linux/sizes.h>
 #include <soc/tegra/pmc.h>
 
@@ -220,11 +220,15 @@
 #define CLK_M_DIVISOR_SHIFT 2
 #define CLK_M_DIVISOR_MASK 0x3
 
+#define CLK_MASK_ARM	0x44
+#define MISC_CLK_ENB	0x48
+
 #define RST_DFLL_DVCO 0x2f4
 #define DVFS_DFLL_RESET_SHIFT 0
 
 #define CLK_RST_CONTROLLER_RST_DEV_Y_SET 0x2a8
 #define CLK_RST_CONTROLLER_RST_DEV_Y_CLR 0x2ac
+#define CPU_SOFTRST_CTRL 0x380
 
 #define LVL2_CLK_GATE_OVRA 0xf8
 #define LVL2_CLK_GATE_OVRC 0x3a0
@@ -2825,6 +2829,7 @@ static int tegra210_enable_pllu(void)
 	struct tegra_clk_pll_freq_table *fentry;
 	struct tegra_clk_pll pllu;
 	u32 reg;
+	int ret;
 
 	for (fentry = pll_u_freq_table; fentry->input_rate; fentry++) {
 		if (fentry->input_rate == pll_ref_freq)
@@ -2853,9 +2858,14 @@ static int tegra210_enable_pllu(void)
 	reg |= PLL_ENABLE;
 	writel(reg, clk_base + PLLU_BASE);
 
-	readl_relaxed_poll_timeout_atomic(clk_base + PLLU_BASE, reg,
-					  reg & PLL_BASE_LOCK, 2, 1000);
-	if (!(reg & PLL_BASE_LOCK)) {
+	/*
+	 * During clocks resume, same PLLU init and enable sequence get
+	 * executed. So, readx_poll_timeout_atomic can't be used here as it
+	 * uses ktime_get() and timekeeping resume doesn't happen by that
+	 * time. So, using tegra210_wait_for_mask for PLL LOCK.
+	 */
+	ret = tegra210_wait_for_mask(&pllu, PLLU_BASE, PLL_BASE_LOCK);
+	if (ret) {
 		pr_err("Timed out waiting for PLL_U to lock\n");
 		return -ETIMEDOUT;
 	}
@@ -3288,6 +3298,84 @@ static void tegra210_disable_cpu_clock(u32 cpu)
 }
 
 #ifdef CONFIG_PM_SLEEP
+/*
+ * This array lists mask values for each peripheral clk bank
+ * to mask out reserved bits during the clocks state restore
+ * on SC7 resume to prevent accidental writes to these reserved
+ * bits.
+ */
+static u32 periph_clk_rsvd_mask[TEGRA210_CAR_BANK_COUNT] = {
+	0x23282006,
+	0x782e0c18,
+	0x0c012c05,
+	0x003e7304,
+	0x86c04800,
+	0xc0199000,
+	0x03e03800,
+};
+
+#define car_readl(_base, _off) readl_relaxed(clk_base + (_base) + ((_off) * 4))
+#define car_writel(_val, _base, _off) \
+		writel_relaxed(_val, clk_base + (_base) + ((_off) * 4))
+
+static u32 spare_reg_ctx, misc_clk_enb_ctx, clk_msk_arm_ctx;
+static u32 cpu_softrst_ctx[3];
+
+static int tegra210_clk_suspend(void)
+{
+	unsigned int i;
+
+	clk_save_context();
+
+	/*
+	 * Save the bootloader configured clock registers SPARE_REG0,
+	 * MISC_CLK_ENB, CLK_MASK_ARM, CPU_SOFTRST_CTRL.
+	 */
+	spare_reg_ctx = readl_relaxed(clk_base + SPARE_REG0);
+	misc_clk_enb_ctx = readl_relaxed(clk_base + MISC_CLK_ENB);
+	clk_msk_arm_ctx = readl_relaxed(clk_base + CLK_MASK_ARM);
+
+	for (i = 0; i < ARRAY_SIZE(cpu_softrst_ctx); i++)
+		cpu_softrst_ctx[i] = car_readl(CPU_SOFTRST_CTRL, i);
+
+	tegra_clk_periph_suspend();
+	return 0;
+}
+
+static void tegra210_clk_resume(void)
+{
+	unsigned int i;
+
+	tegra_clk_osc_resume(clk_base);
+
+	/*
+	 * Restore the bootloader configured clock registers SPARE_REG0,
+	 * MISC_CLK_ENB, CLK_MASK_ARM, CPU_SOFTRST_CTRL from saved context.
+	 */
+	writel_relaxed(spare_reg_ctx, clk_base + SPARE_REG0);
+	writel_relaxed(misc_clk_enb_ctx, clk_base + MISC_CLK_ENB);
+	writel_relaxed(clk_msk_arm_ctx, clk_base + CLK_MASK_ARM);
+
+	for (i = 0; i < ARRAY_SIZE(cpu_softrst_ctx); i++)
+		car_writel(cpu_softrst_ctx[i], CPU_SOFTRST_CTRL, i);
+
+	fence_udelay(5, clk_base);
+
+	/* enable all the clocks before changing the clock sources */
+	tegra_clk_periph_force_on(periph_clk_rsvd_mask);
+
+	/* wait for all writes to happen to have all the clocks enabled */
+	wmb();
+	fence_udelay(2, clk_base);
+
+	/* restore PLLs and all peripheral clock rates */
+	tegra210_init_pllu();
+	clk_restore_context();
+
+	/* restore all peripheral clocks enable and reset state */
+	tegra_clk_periph_resume();
+}
+
 static void tegra210_cpu_clock_suspend(void)
 {
 	/* switch coresite to clk_m, save off original source */
@@ -3303,6 +3391,11 @@ static void tegra210_cpu_clock_resume(void)
 }
 #endif
 
+static struct syscore_ops tegra_clk_syscore_ops = {
+	.suspend = tegra210_clk_suspend,
+	.resume = tegra210_clk_resume,
+};
+
 static struct tegra_cpu_car_ops tegra210_cpu_car_ops = {
 	.wait_for_reset	= tegra210_wait_cpu_in_reset,
 	.disable_clock	= tegra210_disable_cpu_clock,
@@ -3587,5 +3680,7 @@ static void __init tegra210_clock_init(struct device_node *np)
 	tegra210_mbist_clk_init();
 
 	tegra_cpu_car_ops = &tegra210_cpu_car_ops;
+
+	register_syscore_ops(&tegra_clk_syscore_ops);
 }
 CLK_OF_DECLARE(tegra210, "nvidia,tegra210-car", tegra210_clock_init);
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index eb08047fd02f..368a576132f6 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -67,6 +67,7 @@ struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
 
 int *periph_clk_enb_refcnt;
 static int periph_banks;
+static u32 *periph_state_ctx;
 static struct clk **clks;
 static int clk_num;
 static struct clk_onecell_data clk_data;
@@ -213,6 +214,61 @@ void tegra_clk_set_pllp_out_cpu(bool enable)
 	writel_relaxed(val, clk_base + CLK_OUT_ENB_Y);
 }
 
+void tegra_clk_periph_force_on(u32 *clks_rsvd_mask)
+{
+	unsigned int i;
+
+	for (i = 0; i < periph_banks; i++)
+		writel_relaxed(~clks_rsvd_mask[i],
+			       clk_base + periph_regs[i].enb_reg);
+}
+
+void tegra_clk_periph_suspend(void)
+{
+	unsigned int i, idx;
+
+	idx = 0;
+	for (i = 0; i < periph_banks; i++, idx++)
+		periph_state_ctx[idx] =
+			readl_relaxed(clk_base + periph_regs[i].enb_reg);
+
+	for (i = 0; i < periph_banks; i++, idx++)
+		periph_state_ctx[idx] =
+			readl_relaxed(clk_base + periph_regs[i].rst_reg);
+}
+
+void tegra_clk_periph_resume(void)
+{
+	unsigned int i, idx;
+
+	idx = 0;
+	for (i = 0; i < periph_banks; i++, idx++)
+		writel_relaxed(periph_state_ctx[idx],
+			       clk_base + periph_regs[i].enb_reg);
+	/*
+	 * All non-boot peripherals will be in reset state on resume.
+	 * Wait for 5us of reset propagation delay before de-asserting
+	 * the peripherals based on the saved context.
+	 */
+	fence_udelay(5, clk_base);
+
+	for (i = 0; i < periph_banks; i++, idx++)
+		writel_relaxed(periph_state_ctx[idx],
+			       clk_base + periph_regs[i].rst_reg);
+
+	fence_udelay(2, clk_base);
+}
+
+static int tegra_clk_periph_ctx_init(int banks)
+{
+	periph_state_ctx = kcalloc(2 * banks, sizeof(*periph_state_ctx),
+				   GFP_KERNEL);
+	if (!periph_state_ctx)
+		return -ENOMEM;
+
+	return 0;
+}
+
 struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 {
 	clk_base = regs;
@@ -234,6 +290,14 @@ struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 
 	clk_num = num;
 
+	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+		if (tegra_clk_periph_ctx_init(banks)) {
+			kfree(periph_clk_enb_refcnt);
+			kfree(clks);
+			return NULL;
+		}
+	}
+
 	return clks;
 }
 
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 560e2bcb3d7d..9a17cad28d72 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -843,6 +843,9 @@ int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
 		 u8 frac_width, u8 flags);
 void tegra_clk_osc_resume(void __iomem *clk_base);
 void tegra_clk_set_pllp_out_cpu(bool enable);
+void tegra_clk_periph_force_on(u32 *clks_rsvd_mask);
+void tegra_clk_periph_suspend(void);
+void tegra_clk_periph_resume(void);
 
 
 /* Combined read fence with delay */
-- 
2.7.4

