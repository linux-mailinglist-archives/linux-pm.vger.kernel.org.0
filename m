Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1908B23E100
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgHFSjt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 14:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgHFS34 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 14:29:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916D922CBB;
        Thu,  6 Aug 2020 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738186;
        bh=msjJ9dPDN0Y/EID8M3/b0UU21TuitT2pnikvDbyHE2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5HIa1FWzUMOhPyfIDYDI25KWmtk1D7XH6Z79jaL17bIBByHjnR6f8OuI9p2xO/Y3
         89Nw//ycbSIyAIeNCAPkamI44NO299QkJWU0nz36vWUsChudZzxos81ecEdxXQezpJ
         N6ssZyc4M6ezes6C03+BpUu065M0AknG0cwdI5Yc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 22/41] ARM: s3c: adc: move header to linux/soc/samsung
Date:   Thu,  6 Aug 2020 20:20:39 +0200
Message-Id: <20200806182059.2431-22-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are multiple drivers using the private adc interface.
It seems unlikely that they would ever get converted to iio,
so make the current state official by making the header file
global.

The s3c2410_ts driver needs a couple of register definitions
as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c         |  2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c         |  2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c         |  2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |  2 +-
 arch/arm/plat-samsung/adc.c                   |  2 +-
 arch/arm/plat-samsung/devs.c                  |  2 +-
 drivers/hwmon/s3c-hwmon.c                     |  2 +-
 drivers/input/touchscreen/s3c2410_ts.c        | 37 ++++++++++++++++++-
 drivers/power/supply/s3c_adc_battery.c        |  2 +-
 .../linux/soc/samsung/s3c-adc.h               |  6 +--
 10 files changed, 46 insertions(+), 13 deletions(-)
 rename arch/arm/plat-samsung/include/plat/adc.h => include/linux/soc/samsung/s3c-adc.h (85%)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index a2fefb2609e7..ca9a346056ed 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -57,7 +57,7 @@
 #include <plat/keypad.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/pm.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 636d312add81..cbf6a1696a6d 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -27,7 +27,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 56fc21f02c7b..e2aa7c0998bd 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -29,7 +29,7 @@
 #include <mach/gpio-samsung.h>
 #include <mach/irqs.h>
 
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/fb.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 7b931e7a7913..febeacc476c8 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -60,7 +60,7 @@
 
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <plat/keypad.h>
 
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index 55b1925f65d7..e35e04417cce 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -20,7 +20,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <plat/regs-adc.h>
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 
 /* This driver is designed to control the usage of the ADC block between
  * the touchscreen and any other drivers that may need to use it, such as
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 0ed3a4b9fc12..c42e4a272cc7 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -46,7 +46,7 @@
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <plat/fb.h>
 #include <plat/fb-s3c2410.h>
diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index b490fe3d2ee8..f2703c5460d0 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -20,7 +20,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/hwmon-s3c.h>
 
 struct s3c_hwmon_attr {
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 82920ff46f72..2e70c0b79444 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -20,10 +20,43 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/adc.h>
-#include <plat/regs-adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 
+#define	S3C2410_ADCCON			(0x00)
+#define	S3C2410_ADCTSC			(0x04)
+#define	S3C2410_ADCDLY			(0x08)
+#define	S3C2410_ADCDAT0			(0x0C)
+#define	S3C2410_ADCDAT1			(0x10)
+#define	S3C64XX_ADCUPDN			(0x14)
+#define	S3C2443_ADCMUX			(0x18)
+#define	S3C64XX_ADCCLRINT		(0x18)
+#define	S5P_ADCMUX			(0x1C)
+#define	S3C64XX_ADCCLRINTPNDNUP		(0x20)
+
+/* ADCTSC Register Bits */
+#define S3C2443_ADCTSC_UD_SEN		(1 << 8)
+#define S3C2410_ADCTSC_YM_SEN		(1<<7)
+#define S3C2410_ADCTSC_YP_SEN		(1<<6)
+#define S3C2410_ADCTSC_XM_SEN		(1<<5)
+#define S3C2410_ADCTSC_XP_SEN		(1<<4)
+#define S3C2410_ADCTSC_PULL_UP_DISABLE	(1<<3)
+#define S3C2410_ADCTSC_AUTO_PST		(1<<2)
+#define S3C2410_ADCTSC_XY_PST(x)	(((x)&0x3)<<0)
+
+/* ADCDAT0 Bits */
+#define S3C2410_ADCDAT0_UPDOWN		(1<<15)
+#define S3C2410_ADCDAT0_AUTO_PST	(1<<14)
+#define S3C2410_ADCDAT0_XY_PST		(0x3<<12)
+#define S3C2410_ADCDAT0_XPDATA_MASK	(0x03FF)
+
+/* ADCDAT1 Bits */
+#define S3C2410_ADCDAT1_UPDOWN		(1<<15)
+#define S3C2410_ADCDAT1_AUTO_PST	(1<<14)
+#define S3C2410_ADCDAT1_XY_PST		(0x3<<12)
+#define S3C2410_ADCDAT1_YPDATA_MASK	(0x03FF)
+
+
 #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
 
 #define INT_DOWN	(0)
diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
index 3d00b35cafc9..60b7f41ab063 100644
--- a/drivers/power/supply/s3c_adc_battery.c
+++ b/drivers/power/supply/s3c_adc_battery.c
@@ -22,7 +22,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 
 #define BAT_POLL_INTERVAL		10000 /* ms */
 #define JITTER_DELAY			500 /* ms */
diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/include/linux/soc/samsung/s3c-adc.h
similarity index 85%
rename from arch/arm/plat-samsung/include/plat/adc.h
rename to include/linux/soc/samsung/s3c-adc.h
index 74d1a46408c1..591c94ef957d 100644
--- a/arch/arm/plat-samsung/include/plat/adc.h
+++ b/include/linux/soc/samsung/s3c-adc.h
@@ -7,8 +7,8 @@
  * S3C ADC driver information
  */
 
-#ifndef __ASM_PLAT_ADC_H
-#define __ASM_PLAT_ADC_H __FILE__
+#ifndef __LINUX_SOC_SAMSUNG_S3C_ADC_H
+#define __LINUX_SOC_SAMSUNG_S3C_ADC_H __FILE__
 
 struct s3c_adc_client;
 struct platform_device;
@@ -29,4 +29,4 @@ extern struct s3c_adc_client *
 
 extern void s3c_adc_release(struct s3c_adc_client *client);
 
-#endif /* __ASM_PLAT_ADC_H */
+#endif /* __LINUX_SOC_SAMSUNG_S3C_ADC_H */
-- 
2.17.1

