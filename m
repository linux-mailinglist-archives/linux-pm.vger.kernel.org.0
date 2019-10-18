Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD83DC920
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505342AbfJRPn1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 11:43:27 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505232AbfJRPmv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 11:42:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MJV5K-1iaoKF3RSi-00JvoD; Fri, 18 Oct 2019 17:42:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 35/46] cpufreq: pxa3: move clk register access to clk driver
Date:   Fri, 18 Oct 2019 17:41:50 +0200
Message-Id: <20191018154201.1276638-35-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o6X2GiFCPtFxV5PV4sLe6Tx6xb21oUZGUcOOgBZYSAWwgzC/jUs
 abp20CFjc8Gs/k0Su9brUxTD84fcvVQQtcJavFiUOTjyGSzT8fasOvVv8Ys2yjSE3K+myed
 BaKW+CywNxsRd3Xs2rFhVUAEZYNQVoYpLtdLwYDSjD/9vnWLsl+IRnJCb3oPXk/U1Jbvg/e
 hftOaj3iY8ausiGmW7uCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ueaPjGNhuIE=:1FLilwW1vyaKgPnng20RZ1
 ZlaSi7S7KKZuUfLe2WmUHUFJT105z4pBScav2My1yCieflkzBq6JBUJkQyrkxs9BlobMjdbXf
 DyEBUREJzUSqA66Vf2xBip4NIFIEE6NY8vGV6rGo1m2wHovva0XLuilzAfWQiSrSfDMvUFTU4
 nhlFbbwN1kkfqPxt4dQ7APxGUF4BO0Tpu9O3uqSNhW22FM06WrS5I0e3aPECBG7cjnUGvo2F7
 CqUDR8/QKOr+ca8lNWJ8L34kwK7rPr7/CfKplj9U7s6rZAQKhAb16s26aen+hsEmiNoekHfqf
 02q9grZ2vie9X6dQnyray55I6GTsiprURnSn9w/4XI1FA4PH8WETdpUJyuoT+B4Teg7Zx56ob
 mNqSA5Xo4Lbmyiz3/z90lQf/pJWllUVW3bGhnvFfA41uE0Ln6Qvyius0UT+bXceqFwr6LQ0xf
 npfdsSFK0wVy2+3aQGt0h53pSwFAOctARLf5FLTpJOmqb075Pn5tGyQp+H2k7uZmjxIFQmcu0
 s1NYlBSRvBYmF16WO7L58LqJ3FoCzcYnXYeKaFLF9WdDaPFYl6HJPktvZFbfwwyoOAWad3v66
 chZJWSv4YvuGXzUw+8zlkQotHIzVjX+V4Q61vvGr4phijW6etbDjnUSx3ECfrcnJd7kxpWP/J
 l2Pis0BC69MqQuzSGgaPRlw4clxbgl7BipVLt+BiR5hdAH43Q2LYzpf/Qa7qoiLcAUc2yOuQ3
 sXOah/cqonxg+s/w0x3FSoFPVvmkyFhlN99Kai+WCVABHEa8OoAVR5iVW8IsvCMM4ONdL7mHA
 /LhQGDt9twu7pbBdKvSYX+0t7gq4B5U18tLMKVUmoddNow58+unq4dMVcV2gHwSB4DgT7WnQS
 ukpLbvjVKENo67/dCcOQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver needs some low-level register access for setting
the core and bus frequencies. These registers are owned
by the clk driver, so move the low-level access into that
driver with a slightly higher-level interface and avoid
any machine header file dependencies.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/generic.h              |  1 -
 arch/arm/mach-pxa/include/mach/generic.h |  5 --
 arch/arm/mach-pxa/pxa3xx.c               |  1 +
 drivers/clk/pxa/clk-pxa3xx.c             | 16 ++++++
 drivers/cpufreq/pxa2xx-cpufreq.c         |  3 --
 drivers/cpufreq/pxa3xx-cpufreq.c         | 64 +++++++++++++-----------
 include/linux/clk/pxa.h                  |  9 ++++
 7 files changed, 62 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/generic.h
 create mode 100644 include/linux/clk/pxa.h

diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 2f706ef97357..487eadb0fc2a 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -7,7 +7,6 @@
  */
 
 #include <linux/reboot.h>
-#include <mach/generic.h>
 
 struct irq_data;
 
diff --git a/arch/arm/mach-pxa/include/mach/generic.h b/arch/arm/mach-pxa/include/mach/generic.h
deleted file mode 100644
index 613f6a299d0d..000000000000
--- a/arch/arm/mach-pxa/include/mach/generic.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifdef CONFIG_PXA3xx
-extern unsigned	pxa3xx_get_clk_frequency_khz(int);
-#else
-#define pxa3xx_get_clk_frequency_khz(x)		(0)
-#endif
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 7881888107c7..f4657f4edb3b 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -25,6 +25,7 @@
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/soc/pxa/cpu.h>
+#include <linux/clk/pxa.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 027b78183565..60a0db4f3790 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/soc/pxa/cpu.h>
 #include <mach/smemc.h>
+#include <linux/clk/pxa.h>
 #include <mach/pxa3xx-regs.h>
 
 #include <dt-bindings/clock/pxa-clock.h>
@@ -79,6 +80,21 @@ unsigned int pxa3xx_get_clk_frequency_khz(int info)
 	return (unsigned int)clks[0] / KHz;
 }
 
+void pxa3xx_clk_update_accr(u32 disable, u32 enable, u32 xclkcfg, u32 mask)
+{
+	u32 accr = ACCR;
+
+	accr &= ~disable;
+	accr |= enable;
+
+	ACCR = accr;
+	if (xclkcfg)
+		__asm__("mcr p14, 0, %0, c6, c0, 0\n" : : "r"(xclkcfg));
+
+	while ((ACSR & mask) != (accr & mask))
+		cpu_relax();
+}
+
 static unsigned long clk_pxa3xx_ac97_get_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index e74d36d6f78d..ed1ae061a687 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -27,9 +27,6 @@
 #include <linux/soc/pxa/cpu.h>
 #include <linux/io.h>
 
-#include <mach/pxa2xx-regs.h>
-#include <mach/smemc.h>
-
 #ifdef DEBUG
 static unsigned int freq_debug;
 module_param(freq_debug, uint, 0);
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index d3b398b4aa6a..4afa48d172db 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -9,12 +9,10 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/soc/pxa/cpu.h>
+#include <linux/clk/pxa.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 
-#include <mach/generic.h>
-#include <mach/pxa3xx-regs.h>
-
 #define HSS_104M	(0)
 #define HSS_156M	(1)
 #define HSS_208M	(2)
@@ -35,6 +33,28 @@
 #define DMCFS_26M	(0)
 #define DMCFS_260M	(3)
 
+#define ACCR_XPDIS		(1 << 31)	/* Core PLL Output Disable */
+#define ACCR_SPDIS		(1 << 30)	/* System PLL Output Disable */
+#define ACCR_D0CS		(1 << 26)	/* D0 Mode Clock Select */
+#define ACCR_PCCE		(1 << 11)	/* Power Mode Change Clock Enable */
+#define ACCR_DDR_D0CS		(1 << 7)	/* DDR SDRAM clock frequency in D0CS (PXA31x only) */
+
+#define ACCR_SMCFS_MASK		(0x7 << 23)	/* Static Memory Controller Frequency Select */
+#define ACCR_SFLFS_MASK		(0x3 << 18)	/* Frequency Select for Internal Memory Controller */
+#define ACCR_XSPCLK_MASK	(0x3 << 16)	/* Core Frequency during Frequency Change */
+#define ACCR_HSS_MASK		(0x3 << 14)	/* System Bus-Clock Frequency Select */
+#define ACCR_DMCFS_MASK		(0x3 << 12)	/* Dynamic Memory Controller Clock Frequency Select */
+#define ACCR_XN_MASK		(0x7 << 8)	/* Core PLL Turbo-Mode-to-Run-Mode Ratio */
+#define ACCR_XL_MASK		(0x1f)		/* Core PLL Run-Mode-to-Oscillator Ratio */
+
+#define ACCR_SMCFS(x)		(((x) & 0x7) << 23)
+#define ACCR_SFLFS(x)		(((x) & 0x3) << 18)
+#define ACCR_XSPCLK(x)		(((x) & 0x3) << 16)
+#define ACCR_HSS(x)		(((x) & 0x3) << 14)
+#define ACCR_DMCFS(x)		(((x) & 0x3) << 12)
+#define ACCR_XN(x)		(((x) & 0x7) << 8)
+#define ACCR_XL(x)		((x) & 0x1f)
+
 struct pxa3xx_freq_info {
 	unsigned int cpufreq_mhz;
 	unsigned int core_xl : 5;
@@ -112,41 +132,29 @@ static int setup_freqs_table(struct cpufreq_policy *policy,
 
 static void __update_core_freq(struct pxa3xx_freq_info *info)
 {
-	uint32_t mask = ACCR_XN_MASK | ACCR_XL_MASK;
-	uint32_t accr = ACCR;
-	uint32_t xclkcfg;
-
-	accr &= ~(ACCR_XN_MASK | ACCR_XL_MASK | ACCR_XSPCLK_MASK);
-	accr |= ACCR_XN(info->core_xn) | ACCR_XL(info->core_xl);
+	u32 mask, disable, enable, xclkcfg;
 
+	mask	= ACCR_XN_MASK | ACCR_XL_MASK;
+	disable = mask | ACCR_XSPCLK_MASK;
+	enable  = ACCR_XN(info->core_xn) | ACCR_XL(info->core_xl);
 	/* No clock until core PLL is re-locked */
-	accr |= ACCR_XSPCLK(XSPCLK_NONE);
-
+	enable |= ACCR_XSPCLK(XSPCLK_NONE);
 	xclkcfg = (info->core_xn == 2) ? 0x3 : 0x2;	/* turbo bit */
 
-	ACCR = accr;
-	__asm__("mcr p14, 0, %0, c6, c0, 0\n" : : "r"(xclkcfg));
-
-	while ((ACSR & mask) != (accr & mask))
-		cpu_relax();
+	pxa3xx_clk_update_accr(disable, enable, xclkcfg, mask);
 }
 
 static void __update_bus_freq(struct pxa3xx_freq_info *info)
 {
-	uint32_t mask;
-	uint32_t accr = ACCR;
-
-	mask = ACCR_SMCFS_MASK | ACCR_SFLFS_MASK | ACCR_HSS_MASK |
-		ACCR_DMCFS_MASK;
-
-	accr &= ~mask;
-	accr |= ACCR_SMCFS(info->smcfs) | ACCR_SFLFS(info->sflfs) |
-		ACCR_HSS(info->hss) | ACCR_DMCFS(info->dmcfs);
+	u32 mask, disable, enable;
 
-	ACCR = accr;
+	mask	= ACCR_SMCFS_MASK | ACCR_SFLFS_MASK | ACCR_HSS_MASK |
+		  ACCR_DMCFS_MASK;
+	disable = mask;
+	enable	= ACCR_SMCFS(info->smcfs) | ACCR_SFLFS(info->sflfs) |
+		  ACCR_HSS(info->hss) | ACCR_DMCFS(info->dmcfs);
 
-	while ((ACSR & mask) != (accr & mask))
-		cpu_relax();
+	pxa3xx_clk_update_accr(disable, enable, 0, mask);
 }
 
 static unsigned int pxa3xx_cpufreq_get(unsigned int cpu)
diff --git a/include/linux/clk/pxa.h b/include/linux/clk/pxa.h
new file mode 100644
index 000000000000..e5516c608c99
--- /dev/null
+++ b/include/linux/clk/pxa.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifdef CONFIG_PXA3xx
+extern unsigned	pxa3xx_get_clk_frequency_khz(int);
+extern void pxa3xx_clk_update_accr(u32 disable, u32 enable, u32 xclkcfg, u32 mask);
+#else
+#define pxa3xx_get_clk_frequency_khz(x)		(0)
+#define pxa3xx_clk_update_accr(disable, enable, xclkcfg, mask) do { } while (0)
+#endif
-- 
2.20.0

