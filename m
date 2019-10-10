Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2ED3312
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfJJUzD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 16:55:03 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfJJUzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 16:55:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MV2Sk-1ihWPb3Xvi-00SBA4; Thu, 10 Oct 2019 22:54:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 33/36] ARM: s3c: move low-level clk reg access into platform code
Date:   Thu, 10 Oct 2019 22:30:17 +0200
Message-Id: <20191010203043.1241612-33-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bD9sNRXsTKYakre0xRI32jXKWhIKxWw79vY401L6CxcOSZ9Z/vH
 JIDDCF1bhbsakv2QrcQ4cugzpC4dV85dLe5/XBc16I/gcMp/+OroX/GlphJXekeQtvi/++f
 e/p24Ujn5cKdeqMLjZlmN0tx5flJNJBGHH6DViP1OzvWP4d31j69t4gikgzhvl8OPSjzKWy
 0kx6MErKSgquzsh9WPDUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YcSF1edI9mo=:/YL660oxkYpq4Bj4xmawHA
 uuQhR6gtpk86CqqdjD1QWQPfhk+Zd58eyp+5GOrs8YKwWNtrnsROW2kvR3t1M7H4jwUjoc0Y6
 YujYBTeeGwIlChrjl7M+6otwe3fXSBMxD25APb2KUzVzN5FQ+QjuO1YbQjcYp2xbeTyLbcW13
 GnSXZY6d0BoI8pA0r6YcEYG+bC06gfRJRne7CoSETMDlnG0Y9wJf3cn+XH1s5stzrjpkysLQ7
 s+AvOEHaD7T2mpQJ8A4D73uYWH4okbk1h7CMaX7VhWd3HiJMzGpsVj0BGBE7fCD2LXYZmQdIl
 /tj9EEGuxAL825ZVG0D0xhe+jWF9vza9XCffXmHj4bKVDruAHPSmHM/5qKv8uD/5BpNHWEDp+
 XMQGCRehArJBr7cCupMy8cqYUB6FTGnXceP3iHEanwLx5YPrKDv6rsRua60NUVRF1BO4YDSX1
 f2ZFzxsJKC6SAvu+5bpYpLRbfJ5fxnrYMnMgOpqP/nykMx50mD8SRkK6vej17yLEVYtVgIOZn
 kQcR5PzOvLqt3hiRyMOF/6+A3JCZ5rPN9jGAEwzCU8bbNaNrodnSzspSVqtfnEgsDml2lxHVA
 KwWjE1V/9zP0ytO6pAfTqDh1I56mJUT87F9o06LppKDZ3dPOAQMNLeQpcniFaomrFvKOkYjae
 w/VBSwlnZulc0yWAYBVSAcv/epHPV0NGfBPjByu1opqLUvdd7/0VXv5OuOfgekTu++xxt8J0k
 3gjLxCfILWb6I40uIka8gVN9DV937EgokYeX773u7VcfY2suGzz9mC8wkwa/pblWAH1aFnw16
 bZ1ntJS1xI3AUzV8WM2F7bKsTQ9qC9P9ej3Eo1bEmZfI68HycqjARa8TvU2uuULINQNhfsIVD
 uR5b2xV7it50nz16d41g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rather than have the cpufreq drivers touch include the
common headers to get the constants, add a small indirection.
This is still not the proper way that would do this through
the common clk API, but it lets us kill off the header file
usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Makefile               |  2 +-
 arch/arm/mach-s3c24xx/cpufreq-utils.c        | 32 ++++++++++++++++++++
 drivers/cpufreq/s3c2410-cpufreq.c            |  8 +----
 drivers/cpufreq/s3c2412-cpufreq.c            | 10 ++----
 drivers/cpufreq/s3c2440-cpufreq.c            | 16 +++-------
 drivers/cpufreq/s3c24xx-cpufreq.c            | 11 ++-----
 include/linux/soc/samsung/s3c-cpufreq-core.h |  7 +++++
 7 files changed, 51 insertions(+), 35 deletions(-)

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
index 43ab714eaa9e..75c197d59a75 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
@@ -60,3 +60,35 @@ void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg)
 	if (!IS_ERR(cfg->mpll))
 		clk_set_rate(cfg->mpll, cfg->pll.frequency);
 }
+
+#if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
+u32 s3c2440_read_camdivn()
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
+u32 s3c24xx_read_clkdivn()
+{
+	return __raw_readl(S3C2410_CLKDIVN);
+}
+
+void s3c24xx_write_clkdivn(u32 clkdiv)
+{
+	__raw_writel(clkdiv, S3C2410_CLKDIVN);
+}
+
+u32 s3c24xx_read_mpllcon()
+{
+	return __raw_readl(S3C2410_MPLLCON);
+}
+
+void s3c24xx_write_locktime(u32 locktime)
+{
+	return __raw_writel(locktime, S3C2410_LOCKTIME);
+}
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
index 01b1823ea208..37efc0dc3f91 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -27,12 +27,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-
 /* note, cpufreq support deals in kHz, no Hz */
-#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
-#define S3C2410_MPLLCON     S3C2410_CLKREG(0x04)
-
 static struct cpufreq_driver s3c24xx_driver;
 static struct s3c_cpufreq_config cpu_cur;
 static struct s3c_iotimings s3c24xx_iotiming;
@@ -69,7 +64,7 @@ static void s3c_cpufreq_getcur(struct s3c_cpufreq_config *cfg)
 	cfg->freq.pclk = pclk = clk_get_rate(clk_pclk);
 	cfg->freq.armclk = armclk = clk_get_rate(clk_arm);
 
-	cfg->pll.driver_data = __raw_readl(S3C2410_MPLLCON);
+	cfg->pll.driver_data = s3c24xx_read_mpllcon();
 	cfg->pll.frequency = fclk;
 
 	cfg->freq.hclk_tns = 1000000000 / (cfg->freq.hclk / 10);
@@ -387,7 +382,7 @@ static unsigned int suspend_freq;
 static int s3c_cpufreq_suspend(struct cpufreq_policy *policy)
 {
 	suspend_pll.frequency = clk_get_rate(_clk_mpll);
-	suspend_pll.driver_data = __raw_readl(S3C2410_MPLLCON);
+	suspend_pll.driver_data = s3c24xx_read_mpllcon();
 	suspend_freq = clk_get_rate(clk_arm);
 
 	return 0;
@@ -548,7 +543,7 @@ static void s3c_cpufreq_update_loctkime(void)
 	val |= calc_locktime(rate, cpu_cur.info->locktime_m);
 
 	pr_info("%s: new locktime is 0x%08x\n", __func__, val);
-	__raw_writel(val, S3C2410_LOCKTIME);
+	s3c24xx_write_locktime(val);
 }
 
 static int s3c_cpufreq_build_freq(void)
diff --git a/include/linux/soc/samsung/s3c-cpufreq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
index eca942559014..eaee883008a8 100644
--- a/include/linux/soc/samsung/s3c-cpufreq-core.h
+++ b/include/linux/soc/samsung/s3c-cpufreq-core.h
@@ -286,3 +286,10 @@ static inline int s3c_cpufreq_addfreq(struct cpufreq_frequency_table *table,
 
 	return index + 1;
 }
+
+u32 s3c2440_read_camdivn(void);
+void s3c2440_write_camdivn(u32 camdiv);
+u32 s3c24xx_read_clkdivn(void);
+void s3c24xx_write_clkdivn(u32 clkdiv);
+u32 s3c24xx_read_mpllcon(void);
+void s3c24xx_write_locktime(u32 locktime);
-- 
2.20.0

