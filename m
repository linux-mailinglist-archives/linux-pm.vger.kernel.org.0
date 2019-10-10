Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B37D3297
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 22:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfJJUmI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 16:42:08 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfJJUmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 16:42:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1JJC-1iFv9w3tso-002m0W; Thu, 10 Oct 2019 22:41:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 15/36] ARM: s3c: adc: move header to linux/soc/samsung
Date:   Thu, 10 Oct 2019 22:29:59 +0200
Message-Id: <20191010203043.1241612-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FpoNJIc3itWORZoaPFv25Myx/M15oG1YjGqTAt4YFRfspCrSprG
 guybCXrWrn5DkwrIim8Muc6xFZJqDY8H2WUkjdhc2hKBJD/HhrV3FJR1cK/+F3/MY3xZDRs
 sLAxAWd2nFXpNgUgLIyTuHVUUPRKsEDCtc0q2yZyjUrS/S5ERXfJlNHDAk1BCZNchhX2tMr
 VdmRUNgNJjoIWO3yrlYVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:igCCi1hi5O0=:wNKDceOyAM1WB1Zn34ZQdp
 UV1jKwBqIyc07z3xcE54DHVZTJrjbNxuq9Wh6mXT7OPklWo5AsZZpwWUr1PBXXV2UNnsWjzKO
 iocaE4sRUw7Wj96sYq42ZUDaTwg7yz9EvTP69XjPWlq/nKQ0or/Qdl4kBSOMsnP01th8K0nYK
 o08NO8CoQYu+R3Dai6Qp5OYMZwtXTTFqOrzt1EJaqgiklhpo8qjtFX1Q7HYGUGJM/G/8o/3Hg
 LUqnqldNtFfJoCnvzAqDO8UVCMhn30shQkkeayOhuNFoUKUP43WQc1xIp7ihGh9siOksCUWii
 Z5OBhbPZgD31M/uWKFc1R0PSt/PVft+8ZOtg5g2hVKdGOiKYLr7+gANz/Ebu5xnbKpDxv497U
 lgsAh4Nrt/qM9ftwTomvyy9Hgw1HG1WAV69mbeEhEYhsK+4Ni1ebdK/oLuqCnohzB/A9OAC8b
 aMDuTwhTxhAvWWCokFOdJWU7L2I78HqpSu8UyHPe8oNL2fQp+K0D3yqyX938WW5rFliEtFpns
 l1naLMQ2E//wqeXx5yqwDL4odxqHMmpTb0mChd1QgreLoDjz+Mxott7V1d/WQT41oO8Z3qJzR
 hLb8qJBXwNKflHRNnM0fgJOiObczYpZ89ILnWmBXUPNhp3/337ATFa/Xv0Te3Y7Blrxu5Jd1e
 js0U6/loxVpWvJpsO2/JtJkKzZkBDyteKlvqOBGt99tHFxoh3jcHTLYdgFw6eb7vSun3aj3zH
 BtkwI/fjKp5crny1NjvJrvtcWAotPweYvE7lyZZ7zbG4Tpgc5PoauHz2zFqhYp8ibatk6ab2P
 muAkM5IsSkjN8KRxIUHt+pSzTp+5ze6DjRTINrzW4wP6OiL/wuffsPo/3I3XDyaLYPsDYJKSp
 SfP5kAzgidVrbZI3DnNw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are multiple drivers using the private adc interface.
It seems unlikely that they would ever get converted to iio,
so make the current state official by making the header file
global.

The s3c2410_ts driver needs a couple of register definitions
as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
 .../linux/soc/samsung/s3c-adc.h               |  0
 10 files changed, 43 insertions(+), 10 deletions(-)
 rename arch/arm/plat-samsung/include/plat/adc.h => include/linux/soc/samsung/s3c-adc.h (100%)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index da5b50981a14..133453562d23 100644
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
 #include <plat/samsung-time.h>
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 0dd36ae49e6a..c7140300bd3f 100644
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
index 0ff88b6859c4..f55097fde94c 100644
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
index 95bdcfe95a53..3042f6cbffd9 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -60,7 +60,7 @@
 
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/adc.h>
+#include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <plat/keypad.h>
 #include <plat/samsung-time.h>
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index ee3d5c989a76..623a9774cc52 100644
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
index fd94a35e22f8..ddd90f0bb380 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -44,7 +44,7 @@
 
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
index b346e7cafd62..1a5a178ea286 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -21,10 +21,43 @@
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
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/adc.h
rename to include/linux/soc/samsung/s3c-adc.h
-- 
2.20.0

