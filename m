Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB82123E125
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgHFSlI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 14:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgHFSkX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 14:40:23 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C1022E00;
        Thu,  6 Aug 2020 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738277;
        bh=+oPAXSXGyEyQWXKKAwZUaBU75sxosxO6wve4tCGPEDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2y0iC6Hq3ahZm7Wp6ogjUBBHUZUqck/JJjzAi/lMAO9mpKEM7dNAzeXuXv9RhbDd
         8HHVC2bYQQVDDRydsslvqSMU6VKY3kyNStUYUl3TV8MGW4MLKRbRqzNUA16tVYzD6Z
         CGYET/C46D1/DYrHeQGgKgPbrdghqKu2n8PoLiJE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 37/41] cpufreq: s3c24xx: move low-level clk reg access into platform code
Date:   Thu,  6 Aug 2020 20:20:54 +0200
Message-Id: <20200806182059.2431-37-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Rather than have the cpufreq drivers touch include the
common headers to get the constants, add a small indirection.
This is still not the proper way that would do this through
the common clk API, but it lets us kill off the header file
usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[krzk: Rebase and fix -Wold-style-definition]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add 'void' argument to fix -Wold-style-definition warning.
---
 arch/arm/mach-s3c24xx/Kconfig                |  7 -----
 arch/arm/mach-s3c24xx/Makefile               |  2 +-
 arch/arm/mach-s3c24xx/cpufreq-utils.c        | 32 ++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                  |  2 --
 drivers/cpufreq/s3c2410-cpufreq.c            |  8 +----
 drivers/cpufreq/s3c2412-cpufreq.c            | 10 ++----
 drivers/cpufreq/s3c2440-cpufreq.c            | 16 +++-------
 drivers/cpufreq/s3c24xx-cpufreq.c            | 12 ++------
 include/linux/soc/samsung/s3c-cpufreq-core.h |  7 +++++
 9 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 7673dde9671a..3a4b050b46a1 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -137,13 +137,6 @@ config S3C2410_IOTIMING
 	  Internal node to select io timing code that is common to the s3c2410
 	  and s3c2440/s3c2442 cpu frequency support.
 
-config S3C2410_CPUFREQ_UTILS
-       bool
-       depends on ARM_S3C24XX_CPUFREQ
-       help
-         Internal node to select timing code that is common to the s3c2410
-         and s3c2440/s3c244 cpu frequency support.
-
 # cpu frequency support common to s3c2412, s3c2413 and s3c2442
 
 config S3C2412_IOTIMING
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 695573df00b1..195a4cb23ecb 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PM_SLEEP)		+= irq-pm.o sleep.o
 
 # common code
 
-obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += cpufreq-utils.o
+obj-$(CONFIG_ARM_S3C24XX_CPUFREQ) += cpufreq-utils.o
 
 obj-$(CONFIG_S3C2410_IOTIMING)	+= iotiming-s3c2410.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= iotiming-s3c2412.o
diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c b/arch/arm/mach-s3c24xx/cpufreq-utils.c
index 43ab714eaa9e..3bc374dd0b2d 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
@@ -60,3 +60,35 @@ void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg)
 	if (!IS_ERR(cfg->mpll))
 		clk_set_rate(cfg->mpll, cfg->pll.frequency);
 }
+
+#if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
+u32 s3c2440_read_camdivn(void)
+{
+	return __raw_readl(S3C2440_CAMDIVN);
+}
+
+void s3c2440_write_camdivn(u32 camdiv)
+{
+	__raw_writel(camdiv, S3C2440_CAMDIVN);
+}
+#endif
+
+u32 s3c24xx_read_clkdivn(void)
+{
+	return __raw_readl(S3C2410_CLKDIVN);
+}
+
+void s3c24xx_write_clkdivn(u32 clkdiv)
+{
+	__raw_writel(clkdiv, S3C2410_CLKDIVN);
+}
+
+u32 s3c24xx_read_mpllcon(void)
+{
+	return __raw_readl(S3C2410_MPLLCON);
+}
+
+void s3c24xx_write_locktime(u32 locktime)
+{
+	return __raw_writel(locktime, S3C2410_LOCKTIME);
+}
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index cb72fb507d57..6514a39981e1 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -196,7 +196,6 @@ config ARM_S3C24XX_CPUFREQ_DEBUGFS
 config ARM_S3C2410_CPUFREQ
 	bool
 	depends on ARM_S3C24XX_CPUFREQ && CPU_S3C2410
-	select S3C2410_CPUFREQ_UTILS
 	help
 	  CPU Frequency scaling support for S3C2410
 
@@ -233,7 +232,6 @@ config ARM_S3C2416_CPUFREQ_VCORESCALE
 config ARM_S3C2440_CPUFREQ
 	bool "S3C2440/S3C2442 CPU Frequency scaling support"
 	depends on ARM_S3C24XX_CPUFREQ && (CPU_S3C2440 || CPU_S3C2442)
-	select S3C2410_CPUFREQ_UTILS
 	default y
 	help
 	  CPU Frequency scaling support for S3C2440 and S3C2442 SoC CPUs.
diff --git a/drivers/cpufreq/s3c2410-cpufreq.c b/drivers/cpufreq/s3c2410-cpufreq.c
index 9c2f29cacdd0..5dcfbf0bfb74 100644
--- a/drivers/cpufreq/s3c2410-cpufreq.c
+++ b/drivers/cpufreq/s3c2410-cpufreq.c
@@ -22,12 +22,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-
-#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
-
-#define S3C2410_CLKDIVN	    S3C2410_CLKREG(0x14)
-
 #define S3C2410_CLKDIVN_PDIVN	     (1<<0)
 #define S3C2410_CLKDIVN_HDIVN	     (1<<1)
 
@@ -43,7 +37,7 @@ static void s3c2410_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 	if (cfg->divs.p_divisor != cfg->divs.h_divisor)
 		clkdiv |= S3C2410_CLKDIVN_PDIVN;
 
-	__raw_writel(clkdiv, S3C2410_CLKDIVN);
+	s3c24xx_write_clkdivn(clkdiv);
 }
 
 static int s3c2410_cpufreq_calcdivs(struct s3c_cpufreq_config *cfg)
diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index a77c63e92e1a..5945945ead7c 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -25,12 +25,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-
-#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
-
-#define S3C2410_CLKDIVN	    S3C2410_CLKREG(0x14)
-
 #define S3C2412_CLKDIVN_PDIVN		(1<<2)
 #define S3C2412_CLKDIVN_HDIVN_MASK	(3<<0)
 #define S3C2412_CLKDIVN_ARMDIVN		(1<<3)
@@ -132,7 +126,7 @@ static void s3c2412_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 	unsigned long clkdiv;
 	unsigned long olddiv;
 
-	olddiv = clkdiv = __raw_readl(S3C2410_CLKDIVN);
+	olddiv = clkdiv = s3c24xx_read_clkdivn();
 
 	/* clear off current clock info */
 
@@ -149,7 +143,7 @@ static void s3c2412_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 		clkdiv |= S3C2412_CLKDIVN_PDIVN;
 
 	s3c_freq_dbg("%s: div %08lx => %08lx\n", __func__, olddiv, clkdiv);
-	__raw_writel(clkdiv, S3C2410_CLKDIVN);
+	s3c24xx_write_clkdivn(clkdiv);
 
 	clk_set_parent(armclk, cfg->divs.dvs ? hclk : fclk);
 }
diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 442abdccb9c1..148e8aedefa9 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -26,12 +26,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-
-#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
-#define S3C2410_CLKDIVN	    S3C2410_CLKREG(0x14)
-#define S3C2440_CAMDIVN	    S3C2410_CLKREG(0x18)
-
 #define S3C2440_CLKDIVN_PDIVN	     (1<<0)
 #define S3C2440_CLKDIVN_HDIVN_MASK   (3<<1)
 #define S3C2440_CLKDIVN_HDIVN_1      (0<<1)
@@ -162,8 +156,8 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 	s3c_freq_dbg("%s: divisors: h=%d, p=%d\n", __func__,
 		     cfg->divs.h_divisor, cfg->divs.p_divisor);
 
-	clkdiv = __raw_readl(S3C2410_CLKDIVN);
-	camdiv = __raw_readl(S3C2440_CAMDIVN);
+	clkdiv = s3c24xx_read_clkdivn();
+	camdiv = s3c2440_read_camdivn();
 
 	clkdiv &= ~(S3C2440_CLKDIVN_HDIVN_MASK | S3C2440_CLKDIVN_PDIVN);
 	camdiv &= ~CAMDIVN_HCLK_HALF;
@@ -203,11 +197,11 @@ static void s3c2440_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
 	 * then make a short delay and remove the hclk halving if necessary.
 	 */
 
-	__raw_writel(camdiv | CAMDIVN_HCLK_HALF, S3C2440_CAMDIVN);
-	__raw_writel(clkdiv, S3C2410_CLKDIVN);
+	s3c2440_write_camdivn(camdiv | CAMDIVN_HCLK_HALF);
+	s3c24xx_write_clkdivn(clkdiv);
 
 	ndelay(20);
-	__raw_writel(camdiv, S3C2440_CAMDIVN);
+	s3c2440_write_camdivn(camdiv);
 
 	clk_set_parent(armclk, cfg->divs.dvs ? hclk : fclk);
 }
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 27111fbca2ff..37efc0dc3f91 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -27,13 +27,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-
 /* note, cpufreq support deals in kHz, no Hz */
-#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
-#define S3C2410_LOCKTIME    S3C2410_CLKREG(0x00)
-#define S3C2410_MPLLCON     S3C2410_CLKREG(0x04)
-
 static struct cpufreq_driver s3c24xx_driver;
 static struct s3c_cpufreq_config cpu_cur;
 static struct s3c_iotimings s3c24xx_iotiming;
@@ -70,7 +64,7 @@ static void s3c_cpufreq_getcur(struct s3c_cpufreq_config *cfg)
 	cfg->freq.pclk = pclk = clk_get_rate(clk_pclk);
 	cfg->freq.armclk = armclk = clk_get_rate(clk_arm);
 
-	cfg->pll.driver_data = __raw_readl(S3C2410_MPLLCON);
+	cfg->pll.driver_data = s3c24xx_read_mpllcon();
 	cfg->pll.frequency = fclk;
 
 	cfg->freq.hclk_tns = 1000000000 / (cfg->freq.hclk / 10);
@@ -388,7 +382,7 @@ static unsigned int suspend_freq;
 static int s3c_cpufreq_suspend(struct cpufreq_policy *policy)
 {
 	suspend_pll.frequency = clk_get_rate(_clk_mpll);
-	suspend_pll.driver_data = __raw_readl(S3C2410_MPLLCON);
+	suspend_pll.driver_data = s3c24xx_read_mpllcon();
 	suspend_freq = clk_get_rate(clk_arm);
 
 	return 0;
@@ -549,7 +543,7 @@ static void s3c_cpufreq_update_loctkime(void)
 	val |= calc_locktime(rate, cpu_cur.info->locktime_m);
 
 	pr_info("%s: new locktime is 0x%08x\n", __func__, val);
-	__raw_writel(val, S3C2410_LOCKTIME);
+	s3c24xx_write_locktime(val);
 }
 
 static int s3c_cpufreq_build_freq(void)
diff --git a/include/linux/soc/samsung/s3c-cpufreq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
index e0c7217a0f53..3b278afb769b 100644
--- a/include/linux/soc/samsung/s3c-cpufreq-core.h
+++ b/include/linux/soc/samsung/s3c-cpufreq-core.h
@@ -289,4 +289,11 @@ static inline int s3c_cpufreq_addfreq(struct cpufreq_frequency_table *table,
 	return index + 1;
 }
 
+u32 s3c2440_read_camdivn(void);
+void s3c2440_write_camdivn(u32 camdiv);
+u32 s3c24xx_read_clkdivn(void);
+void s3c24xx_write_clkdivn(u32 clkdiv);
+u32 s3c24xx_read_mpllcon(void);
+void s3c24xx_write_locktime(u32 locktime);
+
 #endif
-- 
2.17.1

