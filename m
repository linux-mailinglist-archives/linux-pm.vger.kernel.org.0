Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC623E123
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgHFSlG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 14:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgHFSkX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 14:40:23 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E9422EBD;
        Thu,  6 Aug 2020 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738259;
        bh=jrfTfMqqNK4Bu08uryiHCRmAlSmR+sRWLonChf0RUVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1m6Niw69C99kV9/wFls7VY3aooYZo58lNSDxmPoeT3N05Ac+qqHtOwpvIBmwewtn
         Cj0y+jDgdQWZHi/wwx3p+oGGdAhCGVXSKu00oIsXJS+eFZM+uuSesef27ST3Tv3tui
         l0XEBnV9iSiieJK6h+8Yr7I8B0YTwNKWidMKHhGk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 34/41] cpufreq: s3c24xx: split out registers
Date:   Thu,  6 Aug 2020 20:20:51 +0200
Message-Id: <20200806182059.2431-34-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Each of the cpufreq drivers uses a fixed set of register
bits, copy those definitions into the drivers to avoid
including mach/regs-clock.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[krzk: Fix build by copying also S3C2410_LOCKTIME]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Copy also S3C2410_LOCKTIME to the driver.
---
 drivers/cpufreq/s3c2410-cpufreq.c | 11 +++++++++--
 drivers/cpufreq/s3c2412-cpufreq.c | 20 +++++++++++++++++++-
 drivers/cpufreq/s3c2440-cpufreq.c | 24 ++++++++++++++++++++++--
 drivers/cpufreq/s3c24xx-cpufreq.c |  5 ++++-
 4 files changed, 54 insertions(+), 6 deletions(-)

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
index ed0e713b1b57..cf0571e8fafb 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -28,9 +28,12 @@
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
 
-#include <mach/regs-clock.h>
+#include <mach/map.h>
 
 /* note, cpufreq support deals in kHz, no Hz */
+#define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
+#define S3C2410_LOCKTIME    S3C2410_CLKREG(0x00)
+#define S3C2410_MPLLCON     S3C2410_CLKREG(0x04)
 
 static struct cpufreq_driver s3c24xx_driver;
 static struct s3c_cpufreq_config cpu_cur;
-- 
2.17.1

