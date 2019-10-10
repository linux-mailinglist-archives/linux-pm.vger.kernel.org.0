Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82840D32F9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfJJUxk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 16:53:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJJUxk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 16:53:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MuF4v-1hxQE62fgD-00uawx; Thu, 10 Oct 2019 22:53:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 30/36] ARM: s3c: remove cpufreq header dependencies
Date:   Thu, 10 Oct 2019 22:30:14 +0200
Message-Id: <20191010203043.1241612-30-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:98/U/9Tg91m0pejTjnITf7+YWn6BWRd8o2a+Td7NYU+oEG92Ft1
 VSfw8iJk1JjWMMxkm8EgB734As2J83fuIo0sx/eQMOCIl0zIGVVB6HnNK/++qjinW6rYZFN
 3FB7RKsK6HzKOoS8WRFEzcEWS4DohwvEgub0U0RVxapi+QH4LRBHFTUs+wPFRUJl6zDH2ec
 vNRiq/5/Rb9Eo4X7p9MoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fFxOFfWKPEc=:7c1EU7qAizRHjuMaMCVrCL
 IGdteAY/idpBGRRNm5eQJ3hwbJ49IRIxLthkYp1GfEHVjAWHPTd6xbxJztW1bJDOwweJvWpss
 RIUXy6oqaO72b+4RYTx1HezyY7aZ3BTGnQUVZajbZLFtzxcRlO1wC+04E7n0AM7iv9x2HFbsD
 b8slUJsbdPy6ua+SeLtptEKrJzQROPeL6YFZk2POhfIB5lIBxDY2sxyuwbHmtfxDzZL78QKUB
 nCNnr/AsZeE8KQKbrx1KKD2nlzD93Gh2nMRCbDUrL+4zUC/roOWixNIFEgeX9oGjoH6qMgkx9
 KUFuRfDtahzK/mUN7juw2W9f0KDdpyGimvQlgbJmtR5WfzBF0GhSgFV5/lvK7Ayot3b58gWSm
 Y7xBdAElCoBXs48MfJ8Ff1uKugaW72Xx1wXpAChV5keOaJ/Nx3JIIyAcrEEHc5/v71kqMJEWP
 x8IHGCwBRg7gRs4CHzP+EAfY3a7f6p2/QoYmxv8S04iVJFeaR2wlkgOLCiyq23OcXfpbk13CV
 4VipgKBy+cRt+30X64T+No/Pn+hCI5f4NMLJrLhkRhfaSINfGonNfynnUQPxcpdLRGO6NkmCS
 qndLfhZIeWo/jwCiIt81cVyNtjwpPYmcxNVPUhO+luZUVyhpecA3tPtJWHb+kv9rVlzXvV2JK
 uoRPJo5oLpAaommmZEeZTSQQBUTvXyqPmUoz8Mhr62wQH6rQKQEruJxJy0HjnVtOJxksQhOns
 lSmxA+XD1+FDeRKz92DewhFEmFAZg948P1VVuKVL1ShBZrrK1Gzj0Fl2cI0kicTDdbZ587WAW
 SYmsA06FFNXqcDMuA2BzAmPU+TCbcv2pZM4jTLoREmKPMOBsJ+dpQlW7Hb276u/lru0sEZZUO
 LO5E8n0G+3wGCCHE0BJA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq drivers are split between the machine directory
and the drivers/cpufreq directory. In order to share header
files after we convert s3c to multiplatform, those headers
have to live in a different global location.

Move them to linux/soc/samsung/ in lack of a better place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
 .../linux/soc/samsung/s3c-cpu-freq.h                   |  0
 .../linux/soc/samsung/s3c-cpufreq-core.h               |  2 +-
 include/linux/soc/samsung/s3c-pm.h                     | 10 ++++++++++
 24 files changed, 33 insertions(+), 42 deletions(-)
 rename arch/arm/plat-samsung/include/plat/cpu-freq.h => include/linux/soc/samsung/s3c-cpu-freq.h (100%)
 rename arch/arm/plat-samsung/include/plat/cpu-freq-core.h => include/linux/soc/samsung/s3c-cpufreq-core.h (99%)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index ebf6bde67816..d16a164df6c4 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -35,7 +35,6 @@
 
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
index 9f90aaf70bf3..5b3b16dd0ce8 100644
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
index cc941b5030ea..b2f2d036bca2 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -46,7 +46,7 @@
 #include <mach/gpio-samsung.h>
 
 #include <plat/cpu.h>
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-cpu-freq.h>
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 #include <plat/samsung-time.h>
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
index 262e77bd48de..674164264076 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -37,7 +37,7 @@
 #include <linux/mtd/partitions.h>
 
 #include <plat/cpu.h>
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-cpu-freq.h>
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 #include <plat/samsung-time.h>
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
index 02d7f991d5a3..9dfd58bcc03d 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -124,15 +124,6 @@ extern struct syscore_ops s3c2412_pm_syscore_ops;
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
index c786e1197d3c..01b1823ea208 100644
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
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/cpu-freq.h
rename to include/linux/soc/samsung/s3c-cpu-freq.h
diff --git a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h b/include/linux/soc/samsung/s3c-cpufreq-core.h
similarity index 99%
rename from arch/arm/plat-samsung/include/plat/cpu-freq-core.h
rename to include/linux/soc/samsung/s3c-cpufreq-core.h
index 2c7cf2665634..4d22be1031b9 100644
--- a/arch/arm/plat-samsung/include/plat/cpu-freq-core.h
+++ b/include/linux/soc/samsung/s3c-cpufreq-core.h
@@ -7,7 +7,7 @@
  * S3C CPU frequency scaling support - core support
  */
 
-#include <plat/cpu-freq.h>
+#include <linux/soc/samsung/s3c-cpu-freq.h>
 
 struct seq_file;
 
diff --git a/include/linux/soc/samsung/s3c-pm.h b/include/linux/soc/samsung/s3c-pm.h
index d477b314d034..55935993a111 100644
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
2.20.0

