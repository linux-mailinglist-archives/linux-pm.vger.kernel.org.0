Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1631590861
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfHPTmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:42:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15018 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfHPTmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:42:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5707470000>; Fri, 16 Aug 2019 12:43:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 12:42:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Aug 2019 12:42:51 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:51 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Aug
 2019 19:42:51 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 16 Aug 2019 19:42:51 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.166.126]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5707390002>; Fri, 16 Aug 2019 12:42:51 -0700
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
Subject: [PATCH v9 15/22] clk: tegra210: Add suspend and resume support
Date:   Fri, 16 Aug 2019 12:42:00 -0700
Message-ID: <1565984527-5272-16-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565984583; bh=CkeHkeWh/ZWS0MWDew8/6HXvJW/SBA3xu83/vY8itBE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=pWF499jyEX86FMaRZG803q7C+IifD8zAGvTTLf0fRuaGt5Sz/fSsOEYEWZc4Hs+0S
         ijJ+MPbhZz9Y46NWASVmIN3R5qDR6QB8nWG0Y4PLTw6FtML1Qx2NygIncF6QHU6U50
         7w7whCtRYid/Hu/DaOljzK1AApUtlVSe5Tqko6qGyDQH/2aEUecnFIR1mDLCCFIFNn
         ZLbwEbaA/CoZeeRWwo+nAohbJ9MYGQqPI1s6Q00ud2SggGg9yvyvWAS20N2QCkK9Mi
         ikBxbQmEbQX+Ms24z31TbUeGFgo+d6lWZ0YiGSpD3jKjWZTUnuCbg7S2wV9W57VGMY
         TzukBRgmZyaEA==
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
 drivers/clk/tegra/clk-tegra210.c | 96 ++++++++++++++++++++++++++++++++++++++--
 drivers/clk/tegra/clk.c          | 55 +++++++++++++++++++++++
 drivers/clk/tegra/clk.h          | 16 +++++++
 3 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 4c9538bd28ad..d28d99cb0e9c 100644
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
@@ -3287,6 +3297,77 @@ static void tegra210_disable_cpu_clock(u32 cpu)
 }
 
 #ifdef CONFIG_PM_SLEEP
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
+	/*
+	 * Tegra clock programming sequence recommends peripheral clock to
+	 * be enabled prior to changing its clock source and divider to
+	 * prevent glitchless frequency switch.
+	 * So, enable all peripheral clocks before restoring their source
+	 * and dividers.
+	 */
+	writel_relaxed(TEGRA210_CLK_ENB_VLD_MSK_L, clk_base + CLK_OUT_ENB_L);
+	writel_relaxed(TEGRA210_CLK_ENB_VLD_MSK_H, clk_base + CLK_OUT_ENB_H);
+	writel_relaxed(TEGRA210_CLK_ENB_VLD_MSK_U, clk_base + CLK_OUT_ENB_U);
+	writel_relaxed(TEGRA210_CLK_ENB_VLD_MSK_V, clk_base + CLK_OUT_ENB_V);
+	writel_relaxed(TEGRA210_CLK_ENB_VLD_MSK_W, clk_base + CLK_OUT_ENB_W);
+	writel_relaxed(TEGRA210_CLK_ENB_VLD_MSK_X, clk_base + CLK_OUT_ENB_X);
+	writel_relaxed(TEGRA210_CLK_ENB_VLD_MSK_Y, clk_base + CLK_OUT_ENB_Y);
+
+	/* wait for all writes to happen to have all the clocks enabled */
+	fence_udelay(2, clk_base);
+
+	/* restore PLLs and all peripheral clock rates */
+	tegra210_init_pllu();
+	clk_restore_context();
+
+	/* restore saved context of peripheral clocks and reset state */
+	tegra_clk_periph_resume();
+}
+
 static void tegra210_cpu_clock_suspend(void)
 {
 	/* switch coresite to clk_m, save off original source */
@@ -3302,6 +3383,11 @@ static void tegra210_cpu_clock_resume(void)
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
@@ -3586,5 +3672,7 @@ static void __init tegra210_clock_init(struct device_node *np)
 	tegra210_mbist_clk_init();
 
 	tegra_cpu_car_ops = &tegra210_cpu_car_ops;
+
+	register_syscore_ops(&tegra_clk_syscore_ops);
 }
 CLK_OF_DECLARE(tegra210, "nvidia,tegra210-car", tegra210_clock_init);
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index 33ac88ee324a..e6bd6d1ea012 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -22,6 +22,7 @@ struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
 
 int *periph_clk_enb_refcnt;
 static int periph_banks;
+static u32 *periph_state_ctx;
 static struct clk **clks;
 static int clk_num;
 static struct clk_onecell_data clk_data;
@@ -168,6 +169,52 @@ void tegra_clk_set_pllp_out_cpu(bool enable)
 	writel_relaxed(val, clk_base + CLK_OUT_ENB_Y);
 }
 
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
@@ -189,6 +236,14 @@ struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 
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
index ba123ba4a1da..30247b8fe912 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -55,6 +55,20 @@
 #define RST_DEVICES_SET_Y		0x2a8
 #define RST_DEVICES_CLR_Y		0x2ac
 
+/*
+ * Tegra CLK_OUT_ENB registers have some undefined bits which are not used and
+ * any accidental write of 1 to these bits can cause PSLVERR.
+ * So below are the valid mask defines for each CLK_OUT_ENB register used to
+ * turn ON only the valid clocks.
+ */
+#define TEGRA210_CLK_ENB_VLD_MSK_L	0xdcd7dff9
+#define TEGRA210_CLK_ENB_VLD_MSK_H	0x87d1f3e7
+#define TEGRA210_CLK_ENB_VLD_MSK_U	0xf3fed3fa
+#define TEGRA210_CLK_ENB_VLD_MSK_V	0xffc18cfb
+#define TEGRA210_CLK_ENB_VLD_MSK_W	0x793fb7ff
+#define TEGRA210_CLK_ENB_VLD_MSK_X	0x3fe66fff
+#define TEGRA210_CLK_ENB_VLD_MSK_Y	0xfc1fc7ff
+
 /**
  * struct tegra_clk_sync_source - external clock source from codec
  *
@@ -880,6 +894,8 @@ int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
 		 u8 frac_width, u8 flags);
 void tegra_clk_osc_resume(void __iomem *clk_base);
 void tegra_clk_set_pllp_out_cpu(bool enable);
+void tegra_clk_periph_suspend(void);
+void tegra_clk_periph_resume(void);
 
 
 /* Combined read fence with delay */
-- 
2.7.4

