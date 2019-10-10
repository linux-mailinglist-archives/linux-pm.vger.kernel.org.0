Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3115D32EE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 22:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfJJUv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 16:51:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 16:51:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MElhb-1iK3Fg1ttL-00GGXZ; Thu, 10 Oct 2019 22:51:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 29/36] ARM: s3c: cpufreq: split out registers
Date:   Thu, 10 Oct 2019 22:30:13 +0200
Message-Id: <20191010203043.1241612-29-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bYQlhXWih+C+Vcg6wO+eWmRG6N2NRKtj6W4Hj2uqCeTtCslL0ZM
 9F8De2sKc7IKBqRY2Nooec09SugipJalqwYSBuom/M0Q7jMOU80rbBavRj/rupElvHljI9R
 7wVD6N+xlArvPcXU7uItBt/J/DMkMKw+rjtCrZ6Dvks52NCAIf/R/bydDOuefGky+4kj3uG
 5FzyYB+d0Q7IUdCX/eR3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2I5d1BQgx7M=:/O1F8DhCPGZVpo6kO5MbB/
 qMPymzDv9efv3DZA3gPjkQK1K3WnXOpZs8B/HcC7sj9w95ARoeV5v//SqkJ/2bc0oxufpc4uV
 Udphzs7KpKDwHAQaSUw8X7PcsBoIjtBencMvhaDlS0ac+pqCSoHLx81VaNagzEnjlGR466nyo
 Y7BT3EJ3TnYITjiEYYhD9N1ikODxKBNDCopdUAVhSY+ljf5ecCiQf9SM0us40TuIQ8y2k6ENf
 UWacDF3jEYZfZIBnFX1pUOKWQYUA3ogZ22s0JCT9m0RBW6IHejwo9Q3Gl8EGZpoUdFLryWLqU
 Cl1dzvkaQ59rkGl+LgVqZF/67QhRhp1qaZQuJyIcvi4ooCmZ2efq3JY4HMAijLAf4jY9soaAz
 sP9PIhvkudaX1CfiRIjwiovnkg2HtpVt8Z6w9kpEZzQolrzZff/strXT7rRG6OiWa/Qhude6O
 gW3ahYATIlh4MsukJGXTxDN/GdjzuaYyr9pP7OEpMIYPqAldBUXZHH3yRKvbyCII27zAW2SBR
 yjIylHgLS98O67iGjD6hLQLgRWMd4CxH12bJXckcZwwco9rbVtOKblDUlFH3bExyPj+5+bmAq
 LbbUSesRDUasSBaaJcs/R+LOAmGiUjX7tJQQ26drw9NqRu0D3AaB1v1b4KnswjhV63TBmIrqv
 lEeEiEStguiEVr218efJgCJu9BsJAopwwmhq4hh3JYwurzqeXQ2zVd/0DpW48FzAS61Z3IdRs
 NPKMd2BAn+/iM/8I7XmpPAEtQHrgXC9r0f422rSDMG4thRdLPiAFpk66T/cAQuZonxIRLUR86
 vZOOG31X8p5OoyumdQtQIEpd3ef2mVWOHU2KCwOURMkByefla25RlWmrS4bSwVMHFXxAGEhUJ
 1lpOGF9ABUlW1DKygohw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Each of the cpufreq drivers uses a fixed set of register
bits, copy those definitions into the drivers to avoid
including mach/regs-clock.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/s3c2410-cpufreq.c | 11 +++++++++--
 drivers/cpufreq/s3c2412-cpufreq.c | 20 +++++++++++++++++++-
 drivers/cpufreq/s3c2440-cpufreq.c | 24 ++++++++++++++++++++++--
 drivers/cpufreq/s3c24xx-cpufreq.c |  4 +++-
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/s3c2410-cpufreq.c b/drivers/cpufreq/s3c2410-cpufreq.c
index 0c4f2ccd7e22..5c6cb590b63f 100644
--- a/drivers/cpufreq/s3c2410-cpufreq.c
+++ b/drivers/cpufreq/s3c2410-cpufreq.c
@@ -20,11 +20,18 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/regs-clock.h>
-
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
+#include <mach/map.h>
+
+#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
+
+#define S3C2410_CLKDIVN	    S3C2410_CLKREG(0x14)
+
+#define S3C2410_CLKDIVN_PDIVN	     (1<<0)
+#define S3C2410_CLKDIVN_HDIVN	     (1<<1)
+
 /* Note, 2410A has an extra mode for 1:4:4 ratio, bit 2 of CLKDIV */
 
 static void s3c2410_cpufreq_setdivs(struct s3c_cpufreq_config *cfg)
diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index 53385a9ab957..d922d0d47c80 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -23,12 +23,30 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/regs-clock.h>
 #include <mach/s3c2412.h>
 
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
+#include <mach/map.h>
+
+#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
+
+#define S3C2410_CLKDIVN	    S3C2410_CLKREG(0x14)
+
+#define S3C2412_CLKDIVN_PDIVN		(1<<2)
+#define S3C2412_CLKDIVN_HDIVN_MASK	(3<<0)
+#define S3C2412_CLKDIVN_ARMDIVN		(1<<3)
+#define S3C2412_CLKDIVN_DVSEN		(1<<4)
+#define S3C2412_CLKDIVN_HALFHCLK	(1<<5)
+#define S3C2412_CLKDIVN_USB48DIV	(1<<6)
+#define S3C2412_CLKDIVN_UARTDIV_MASK	(15<<8)
+#define S3C2412_CLKDIVN_UARTDIV_SHIFT	(8)
+#define S3C2412_CLKDIVN_I2SDIV_MASK	(15<<12)
+#define S3C2412_CLKDIVN_I2SDIV_SHIFT	(12)
+#define S3C2412_CLKDIVN_CAMDIV_MASK	(15<<16)
+#define S3C2412_CLKDIVN_CAMDIV_SHIFT	(16)
+
 /* our clock resources. */
 static struct clk *xtal;
 static struct clk *fclk;
diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index 3f772ba8896e..5fe7a891fa13 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -24,11 +24,31 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/regs-clock.h>
-
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
+#include <mach/map.h>
+
+#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
+#define S3C2410_CLKDIVN	    S3C2410_CLKREG(0x14)
+#define S3C2440_CAMDIVN	    S3C2410_CLKREG(0x18)
+
+#define S3C2440_CLKDIVN_PDIVN	     (1<<0)
+#define S3C2440_CLKDIVN_HDIVN_MASK   (3<<1)
+#define S3C2440_CLKDIVN_HDIVN_1      (0<<1)
+#define S3C2440_CLKDIVN_HDIVN_2      (1<<1)
+#define S3C2440_CLKDIVN_HDIVN_4_8    (2<<1)
+#define S3C2440_CLKDIVN_HDIVN_3_6    (3<<1)
+#define S3C2440_CLKDIVN_UCLK         (1<<3)
+
+#define S3C2440_CAMDIVN_CAMCLK_MASK  (0xf<<0)
+#define S3C2440_CAMDIVN_CAMCLK_SEL   (1<<4)
+#define S3C2440_CAMDIVN_HCLK3_HALF   (1<<8)
+#define S3C2440_CAMDIVN_HCLK4_HALF   (1<<9)
+#define S3C2440_CAMDIVN_DVSEN        (1<<12)
+
+#define S3C2442_CAMDIVN_CAMCLK_DIV3  (1<<5)
+
 static struct clk *xtal;
 static struct clk *fclk;
 static struct clk *hclk;
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index ed0e713b1b57..c786e1197d3c 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -28,9 +28,11 @@
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
-#include <mach/regs-clock.h>
+#include <mach/map.h>
 
 /* note, cpufreq support deals in kHz, no Hz */
+#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
+#define S3C2410_MPLLCON     S3C2410_CLKREG(0x04)
 
 static struct cpufreq_driver s3c24xx_driver;
 static struct s3c_cpufreq_config cpu_cur;
-- 
2.20.0

