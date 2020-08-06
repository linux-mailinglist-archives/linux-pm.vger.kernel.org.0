Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADAB23E119
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgHFSk0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 14:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbgHFSkY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 14:40:24 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA6F22E02;
        Thu,  6 Aug 2020 18:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738264;
        bh=/PTDXeYOWV9QWjTZIHRZoZzyNEJs3+9dKsJcQfHLRYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G//rUJW4asuC/9ZXGjP4OyorW/E6c//1xsUBzMJAkrkvJUPVPp99t5znuqluXNtZY
         0jTUxnH0G3JnmPYD1Aq7Ha9ukgvnjQ0sjmZ2elsYLZdR94IKkTORFgIWzkxUQV1Axp
         /n00cmqUI3M6Ac9m0ocb9w4PzW2Wf8eiqT2qcDIY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 35/41] ARM: s3c: remove cpufreq header dependencies
Date:   Thu,  6 Aug 2020 20:20:52 +0200
Message-Id: <20200806182059.2431-35-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The cpufreq drivers are split between the machine directory
and the drivers/cpufreq directory. In order to share header
files after we convert s3c to multiplatform, those headers
have to live in a different global location.

Move them to linux/soc/samsung/ in lack of a better place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/common.c                         |  1 -
 arch/arm/mach-s3c24xx/cpufreq-utils.c                  |  2 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c               |  2 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c               |  2 +-
 arch/arm/mach-s3c24xx/mach-bast.c                      |  2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c                |  2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                    |  2 +-
 arch/arm/mach-s3c24xx/pll-s3c2410.c                    |  4 ++--
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c           |  4 ++--
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c           |  4 ++--
 arch/arm/mach-s3c24xx/s3c2410.c                        |  1 -
 arch/arm/mach-s3c24xx/s3c2412.c                        |  1 -
 arch/arm/mach-s3c24xx/s3c244x.c                        |  2 --
 arch/arm/mach-s3c64xx/s3c6400.c                        |  1 -
 arch/arm/mach-s3c64xx/s3c6410.c                        |  2 +-
 arch/arm/plat-samsung/include/plat/cpu.h               |  9 ---------
 drivers/cpufreq/s3c2410-cpufreq.c                      |  5 ++---
 drivers/cpufreq/s3c2412-cpufreq.c                      |  5 ++---
 drivers/cpufreq/s3c2440-cpufreq.c                      |  5 ++---
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c              |  2 +-
 drivers/cpufreq/s3c24xx-cpufreq.c                      |  5 ++---
 .../linux/soc/samsung/s3c-cpu-freq.h                   |  4 ++++
 .../linux/soc/samsung/s3c-cpufreq-core.h               |  6 +++++-
 include/linux/soc/samsung/s3c-pm.h                     | 10 ++++++++++
 24 files changed, 41 insertions(+), 42 deletions(-)
 rename arch/arm/plat-samsung/include/plat/cpu-freq.h => include/linux/soc/samsung/s3c-cpu-freq.h (97%)
 rename arch/arm/plat-samsung/include/plat/cpu-freq-core.h => include/linux/soc/samsung/s3c-cpufreq-core.h (98%)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index c476a673d07f..f987de1a61c2 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -37,7 +37,6 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
-#include <plat/cpu-freq.h>
 #include <plat/pwm-core.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c b/arch/arm/mach-s3c24xx/cpufreq-utils.c
index 1a7f38d085dd..43ab714eaa9e 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
@@ -15,7 +15,7 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 
-#include <plat/cpu-freq-core.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
 
 #include "regs-mem.h"
 
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index 39081c41958c..5d85c259f328 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -17,7 +17,7 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 
-#include <plat/cpu-freq-core.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
 
 #include "regs-mem.h"
 
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
index 59356d10fbcf..a22b5611697d 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -24,7 +24,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
 
 #include <mach/s3c2412.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 306891235f73..7e3ce48539c4 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -45,7 +45,7 @@
 #include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-cpu-freq.h>
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 5d819b6ea428..1250520b3bcc 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -14,7 +14,7 @@
 
 #include <linux/mfd/tps65010.h>
 
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-cpu-freq.h>
 #include <mach/gpio-samsung.h>
 
 #define OSIRIS_GPIO_DVS	S3C2410_GPB(5)
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index ed10a32e26b8..258850c1bbb2 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -37,7 +37,7 @@
 #include <linux/mtd/partitions.h>
 
 #include <plat/cpu.h>
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-cpu-freq.h>
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2410.c b/arch/arm/mach-s3c24xx/pll-s3c2410.c
index 0561f79ddce8..3fbc99eaa4a2 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2410.c
@@ -15,8 +15,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 /* This array should be sorted in ascending order of the frequencies */
 static struct cpufreq_frequency_table pll_vals_12MHz[] = {
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
index 2ec3a2f9a6a5..fdb8e8c2fe3b 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
@@ -13,8 +13,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 /* This array should be sorted in ascending order of the frequencies */
 static struct cpufreq_frequency_table s3c2440_plls_12[] = {
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
index 4b3d9e36c6bb..438b6fc099a4 100644
--- a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
+++ b/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
@@ -13,8 +13,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-#include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 /* This array should be sorted in ascending order of the frequencies */
 static struct cpufreq_frequency_table s3c2440_plls_169344[] = {
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 21fd5404bc98..8427c150dd22 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -30,7 +30,6 @@
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
-#include <plat/cpu-freq.h>
 
 #include <mach/regs-clock.h>
 
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index c3fb3e6c0dd8..209f952a6c98 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -34,7 +34,6 @@
 #include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
-#include <plat/cpu-freq.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
 
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index a75f588b9d45..f5bd489bac85 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -28,8 +28,6 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
-#include <plat/cpu-freq.h>
-
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 81233495d548..d18af724c807 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -28,7 +28,6 @@
 
 #include <asm/irq.h>
 
-#include <plat/cpu-freq.h>
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 9465a6e0f068..b1d725e55cd2 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -29,7 +29,7 @@
 
 #include <asm/irq.h>
 
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-pm.h>
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 93ecd7127831..20ff98d05c53 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -123,15 +123,6 @@ extern struct syscore_ops s3c2412_pm_syscore_ops;
 extern struct syscore_ops s3c2416_pm_syscore_ops;
 extern struct syscore_ops s3c244x_pm_syscore_ops;
 
-/* system device subsystems */
-
-extern struct bus_type s3c2410_subsys;
-extern struct bus_type s3c2410a_subsys;
-extern struct bus_type s3c2412_subsys;
-extern struct bus_type s3c2416_subsys;
-extern struct bus_type s3c2440_subsys;
-extern struct bus_type s3c2442_subsys;
-extern struct bus_type s3c2443_subsys;
 extern struct bus_type s3c6410_subsys;
 
 #endif
diff --git a/drivers/cpufreq/s3c2410-cpufreq.c b/drivers/cpufreq/s3c2410-cpufreq.c
index 5c6cb590b63f..9c2f29cacdd0 100644
--- a/drivers/cpufreq/s3c2410-cpufreq.c
+++ b/drivers/cpufreq/s3c2410-cpufreq.c
@@ -16,13 +16,12 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
-
 #include <mach/map.h>
 
 #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index d922d0d47c80..38dc9e6db633 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -19,15 +19,14 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include <mach/s3c2412.h>
 
-#include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
-
 #include <mach/map.h>
 
 #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 5fe7a891fa13..442abdccb9c1 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -20,13 +20,12 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
-
 #include <mach/map.h>
 
 #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
index 290e3539d03e..93971dfe7c75 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
@@ -18,7 +18,7 @@
 #include <linux/seq_file.h>
 #include <linux/err.h>
 
-#include <plat/cpu-freq-core.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
 
 static struct dentry *dbgfs_root;
 static struct dentry *dbgfs_file_io;
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index cf0571e8fafb..27111fbca2ff 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -21,13 +21,12 @@
 #include <linux/device.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
+#include <linux/soc/samsung/s3c-cpufreq-core.h>
+#include <linux/soc/samsung/s3c-pm.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/cpu.h>
-#include <plat/cpu-freq-core.h>
-
 #include <mach/map.h>
 
 /* note, cpufreq support deals in kHz, no Hz */
diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq.h b/include/linux/soc/samsung/s3c-cpu-freq.h
similarity index 97%
rename from arch/arm/plat-samsung/include/plat/cpu-freq.h
rename to include/linux/soc/samsung/s3c-cpu-freq.h
index 558892bcf9b6..63e88fd5dea2 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq.h
+++ b/include/linux/soc/samsung/s3c-cpu-freq.h
@@ -6,6 +6,8 @@
  *
  * S3C CPU frequency scaling support - driver and board
  */
+#ifndef __LINUX_SOC_SAMSUNG_S3C_CPU_FREQ_H
+#define __LINUX_SOC_SAMSUNG_S3C_CPU_FREQ_H
 
 #include <linux/cpufreq.h>
 
@@ -139,3 +141,5 @@ static inline int s3c_cpufreq_setboard(struct s3c_cpufreq_board *board)
 	return 0;
 }
 #endif  /* CONFIG_ARM_S3C_CPUFREQ */
+
+#endif
diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
similarity index 98%
rename from arch/arm/plat-samsung/include/plat/cpu-freq-core.h
rename to include/linux/soc/samsung/s3c-cpufreq-core.h
index 2c7cf2665634..c578b07ccd5d 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
+++ b/include/linux/soc/samsung/s3c-cpufreq-core.h
@@ -6,8 +6,10 @@
  *
  * S3C CPU frequency scaling support - core support
  */
+#ifndef __LINUX_SOC_SAMSUNG_S3C_CPUFREQ_CORE_H
+#define __LINUX_SOC_SAMSUNG_S3C_CPUFREQ_CORE_H
 
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-cpu-freq.h>
 
 struct seq_file;
 
@@ -285,3 +287,5 @@ static inline int s3c_cpufreq_addfreq(struct cpufreq_frequency_table *table,
 
 	return index + 1;
 }
+
+#endif
diff --git a/include/linux/soc/samsung/s3c-pm.h b/include/linux/soc/samsung/s3c-pm.h
index 730bd1d3d09a..f9164559c99f 100644
--- a/include/linux/soc/samsung/s3c-pm.h
+++ b/include/linux/soc/samsung/s3c-pm.h
@@ -81,4 +81,14 @@ extern void s3c_pm_check_store(void);
 #define s3c_pm_check_store()   do { } while (0)
 #endif
 
+/* system device subsystems */
+
+extern struct bus_type s3c2410_subsys;
+extern struct bus_type s3c2410a_subsys;
+extern struct bus_type s3c2412_subsys;
+extern struct bus_type s3c2416_subsys;
+extern struct bus_type s3c2440_subsys;
+extern struct bus_type s3c2442_subsys;
+extern struct bus_type s3c2443_subsys;
+
 #endif
-- 
2.17.1

