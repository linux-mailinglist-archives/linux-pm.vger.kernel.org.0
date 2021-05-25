Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2EF38FEDE
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhEYKRw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:17:52 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36526 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEYKRp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:17:45 -0400
Received: by mail-lj1-f177.google.com with SMTP id 131so37390107ljj.3;
        Tue, 25 May 2021 03:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JL4IJVzm5KHowf4eCBdWFH2M44vnSepZBYsIAzvfOxY=;
        b=qcV58gLlE0q2hQ6dRB7vo/bIQCzwgW6mh23ZmM4wExMnCm3jwE7WNbuJ1AooZh40MQ
         89d+HIfFohJzHvi2ZxJzXMHRwBemz12KY20FHEQ5Q1VsFQjB+By7JdiINPy9gckiHNcB
         91rC4G/ujURXSVev138Fm0/RdJrt0Ua13LK7xTjCnxQTjEkXGqkq/sLfuT40j3P419Oh
         H2IVhoZVMpap2qcOtclKicxsBVE8Tu/bVKneNBYNuv3fMElRBKGOn1gnUNo9ifjnINy9
         p3fOxQ8bGI0yVyfe8bdKItyW5mklXxYyVqBfsVwyQpBjBq1Uf6kFNLqGLJat1GOdCW9z
         XLQA==
X-Gm-Message-State: AOAM531A+OB+xUuvw6xmakDR5Y96YoBz5f9c277VcBuJK0AWtm8e3dKz
        LcS7BBA8DLm1kHfINRYUOdY=
X-Google-Smtp-Source: ABdhPJxF8aK4j6MgUubt+r7vzKWdS1Io7l3Ig0HKpM2m/RzQOxoEtPRtwWy8IONghHJKTj47RWzueA==
X-Received: by 2002:a2e:2f09:: with SMTP id v9mr19796341ljv.152.1621937772552;
        Tue, 25 May 2021 03:16:12 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id w2sm987173ljo.62.2021.05.25.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:16:11 -0700 (PDT)
Date:   Tue, 25 May 2021 13:16:05 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 8/9] mfd: bd70528: Drop BD70528 support
Message-ID: <d4e4213ffea09525814e4b55518fd689b5c3bf87.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only known BD70528 use-cases are such that the PMIC is controlled
=66rom separate MCU which is not running Linux. I am not aware of
any Linux driver users. Furthermore, it seems there is no demand for
this IC. Let's ease the maintenance burden and drop the driver. We can
always add it back if there is sudden need for it.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

---
Please let me know if some of you think the driver is needed.
---
 drivers/mfd/Kconfig              |  17 --
 drivers/mfd/Makefile             |   1 -
 drivers/mfd/rohm-bd70528.c       | 314 -------------------------
 include/linux/mfd/rohm-bd70528.h | 391 -------------------------------
 include/linux/mfd/rohm-generic.h |   1 -
 5 files changed, 724 deletions(-)
 delete mode 100644 drivers/mfd/rohm-bd70528.c
 delete mode 100644 include/linux/mfd/rohm-bd70528.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5c7f2b100191..810f2ef9eba9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1945,23 +1945,6 @@ config MFD_ROHM_BD718XX
 	  NXP i.MX8. It contains 8 BUCK outputs and 7 LDOs, voltage monitoring
 	  and emergency shut down as well as 32,768KHz clock output.
=20
-config MFD_ROHM_BD70528
-	tristate "ROHM BD70528 Power Management IC"
-	depends on I2C=3Dy
-	depends on OF
-	select REGMAP_I2C
-	select REGMAP_IRQ
-	select MFD_CORE
-	help
-	  Select this option to get support for the ROHM BD70528 Power
-	  Management IC. BD71837 is general purpose single-chip power
-	  management IC for battery-powered portable devices. It contains
-	  3 ultra-low current consumption buck converters, 3 LDOs and 2 LED
-	  drivers. Also included are 4 GPIOs, a real-time clock (RTC), a 32kHz
-	  crystal oscillator, high-accuracy VREF for use with an external ADC,
-	  10 bits SAR ADC for battery temperature monitor and 1S battery
-	  charger.
-
 config MFD_ROHM_BD71828
 	tristate "ROHM BD71828 and BD71815 Power Management IC"
 	depends on I2C=3Dy
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4f6d2b8a5f76..2ce5436bb8d4 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -257,7 +257,6 @@ obj-$(CONFIG_MFD_STM32_TIMERS) 	+=3D stm32-timers.o
 obj-$(CONFIG_MFD_MXS_LRADC)     +=3D mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+=3D sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+=3D rave-sp.o
-obj-$(CONFIG_MFD_ROHM_BD70528)	+=3D rohm-bd70528.o
 obj-$(CONFIG_MFD_ROHM_BD71828)	+=3D rohm-bd71828.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+=3D rohm-bd718x7.o
 obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+=3D rohm-bd9576.o
diff --git a/drivers/mfd/rohm-bd70528.c b/drivers/mfd/rohm-bd70528.c
deleted file mode 100644
index 5c44d3b77b3e..000000000000
--- a/drivers/mfd/rohm-bd70528.c
+++ /dev/null
@@ -1,314 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-//
-// Copyright (C) 2019 ROHM Semiconductors
-//
-// ROHM BD70528 PMIC driver
-
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/irq.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/rohm-bd70528.h>
-#include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/regmap.h>
-#include <linux/types.h>
-
-#define BD70528_NUM_OF_GPIOS 4
-
-static const struct resource rtc_irqs[] =3D {
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_RTC_ALARM, "bd70528-rtc-alm"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_ELPS_TIM, "bd70528-elapsed-timer"),
-};
-
-static const struct resource charger_irqs[] =3D {
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BAT_OV_RES, "bd70528-bat-ov-res"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BAT_OV_DET, "bd70528-bat-ov-det"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_DBAT_DET, "bd70528-bat-dead"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BATTSD_COLD_RES, "bd70528-bat-warmed"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BATTSD_COLD_DET, "bd70528-bat-cold"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BATTSD_HOT_RES, "bd70528-bat-cooled"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BATTSD_HOT_DET, "bd70528-bat-hot"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_CHG_TSD, "bd70528-chg-tshd"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BAT_RMV, "bd70528-bat-removed"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_BAT_DET, "bd70528-bat-detected"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_DCIN2_OV_RES, "bd70528-dcin2-ov-res"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_DCIN2_OV_DET, "bd70528-dcin2-ov-det"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_DCIN2_RMV, "bd70528-dcin2-removed"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_DCIN2_DET, "bd70528-dcin2-detected"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_DCIN1_RMV, "bd70528-dcin1-removed"),
-	DEFINE_RES_IRQ_NAMED(BD70528_INT_DCIN1_DET, "bd70528-dcin1-detected"),
-};
-
-static struct mfd_cell bd70528_mfd_cells[] =3D {
-	{ .name =3D "bd70528-pmic", },
-	{ .name =3D "bd70528-gpio", },
-	/*
-	 * We use BD71837 driver to drive the clock block. Only differences to
-	 * BD70528 clock gate are the register address and mask.
-	 */
-	{ .name =3D "bd70528-clk", },
-	{ .name =3D "bd70528-wdt", },
-	{
-		.name =3D "bd70528-power",
-		.resources =3D charger_irqs,
-		.num_resources =3D ARRAY_SIZE(charger_irqs),
-	}, {
-		.name =3D "bd70528-rtc",
-		.resources =3D rtc_irqs,
-		.num_resources =3D ARRAY_SIZE(rtc_irqs),
-	},
-};
-
-static const struct regmap_range volatile_ranges[] =3D {
-	{
-		.range_min =3D BD70528_REG_INT_MAIN,
-		.range_max =3D BD70528_REG_INT_OP_FAIL,
-	}, {
-		.range_min =3D BD70528_REG_RTC_COUNT_H,
-		.range_max =3D BD70528_REG_RTC_ALM_REPEAT,
-	}, {
-		/*
-		 * WDT control reg is special. Magic values must be written to
-		 * it in order to change the control. Should not be cached.
-		 */
-		.range_min =3D BD70528_REG_WDT_CTRL,
-		.range_max =3D BD70528_REG_WDT_CTRL,
-	}, {
-		/*
-		 * BD70528 also contains a few other registers which require
-		 * magic sequences to be written in order to update the value.
-		 * At least SHIPMODE, HWRESET, WARMRESET,and STANDBY
-		 */
-		.range_min =3D BD70528_REG_SHIPMODE,
-		.range_max =3D BD70528_REG_STANDBY,
-	},
-};
-
-static const struct regmap_access_table volatile_regs =3D {
-	.yes_ranges =3D &volatile_ranges[0],
-	.n_yes_ranges =3D ARRAY_SIZE(volatile_ranges),
-};
-
-static struct regmap_config bd70528_regmap =3D {
-	.reg_bits =3D 8,
-	.val_bits =3D 8,
-	.volatile_table =3D &volatile_regs,
-	.max_register =3D BD70528_MAX_REGISTER,
-	.cache_type =3D REGCACHE_RBTREE,
-};
-
-/*
- * Mapping of main IRQ register bits to sub-IRQ register offsets so that w=
e can
- * access corect sub-IRQ registers based on bits that are set in main IRQ
- * register.
- */
-
-static unsigned int bit0_offsets[] =3D {0};	/* Shutdown */
-static unsigned int bit1_offsets[] =3D {1};	/* Power failure */
-static unsigned int bit2_offsets[] =3D {2};	/* VR FAULT */
-static unsigned int bit3_offsets[] =3D {3};	/* PMU interrupts */
-static unsigned int bit4_offsets[] =3D {4, 5};	/* Charger 1 and Charger 2 =
*/
-static unsigned int bit5_offsets[] =3D {6};	/* RTC */
-static unsigned int bit6_offsets[] =3D {7};	/* GPIO */
-static unsigned int bit7_offsets[] =3D {8};	/* Invalid operation */
-
-static struct regmap_irq_sub_irq_map bd70528_sub_irq_offsets[] =3D {
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
-	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
-};
-
-static struct regmap_irq bd70528_irqs[] =3D {
-	REGMAP_IRQ_REG(BD70528_INT_LONGPUSH, 0, BD70528_INT_LONGPUSH_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_WDT, 0, BD70528_INT_WDT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_HWRESET, 0, BD70528_INT_HWRESET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_RSTB_FAULT, 0, BD70528_INT_RSTB_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_VBAT_UVLO, 0, BD70528_INT_VBAT_UVLO_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_TSD, 0, BD70528_INT_TSD_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_RSTIN, 0, BD70528_INT_RSTIN_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK1_FAULT, 1,
-		       BD70528_INT_BUCK1_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK2_FAULT, 1,
-		       BD70528_INT_BUCK2_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK3_FAULT, 1,
-		       BD70528_INT_BUCK3_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LDO1_FAULT, 1, BD70528_INT_LDO1_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LDO2_FAULT, 1, BD70528_INT_LDO2_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LDO3_FAULT, 1, BD70528_INT_LDO3_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LED1_FAULT, 1, BD70528_INT_LED1_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LED2_FAULT, 1, BD70528_INT_LED2_FAULT_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK1_OCP, 2, BD70528_INT_BUCK1_OCP_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK2_OCP, 2, BD70528_INT_BUCK2_OCP_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK3_OCP, 2, BD70528_INT_BUCK3_OCP_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LED1_OCP, 2, BD70528_INT_LED1_OCP_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LED2_OCP, 2, BD70528_INT_LED2_OCP_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK1_FULLON, 2,
-		       BD70528_INT_BUCK1_FULLON_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK2_FULLON, 2,
-		       BD70528_INT_BUCK2_FULLON_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_SHORTPUSH, 3, BD70528_INT_SHORTPUSH_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_AUTO_WAKEUP, 3,
-		       BD70528_INT_AUTO_WAKEUP_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_STATE_CHANGE, 3,
-		       BD70528_INT_STATE_CHANGE_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BAT_OV_RES, 4, BD70528_INT_BAT_OV_RES_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BAT_OV_DET, 4, BD70528_INT_BAT_OV_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_DBAT_DET, 4, BD70528_INT_DBAT_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BATTSD_COLD_RES, 4,
-		       BD70528_INT_BATTSD_COLD_RES_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BATTSD_COLD_DET, 4,
-		       BD70528_INT_BATTSD_COLD_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BATTSD_HOT_RES, 4,
-		       BD70528_INT_BATTSD_HOT_RES_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BATTSD_HOT_DET, 4,
-		       BD70528_INT_BATTSD_HOT_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_CHG_TSD, 4, BD70528_INT_CHG_TSD_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BAT_RMV, 5, BD70528_INT_BAT_RMV_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BAT_DET, 5, BD70528_INT_BAT_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_DCIN2_OV_RES, 5,
-		       BD70528_INT_DCIN2_OV_RES_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_DCIN2_OV_DET, 5,
-		       BD70528_INT_DCIN2_OV_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_DCIN2_RMV, 5, BD70528_INT_DCIN2_RMV_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_DCIN2_DET, 5, BD70528_INT_DCIN2_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_DCIN1_RMV, 5, BD70528_INT_DCIN1_RMV_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_DCIN1_DET, 5, BD70528_INT_DCIN1_DET_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_RTC_ALARM, 6, BD70528_INT_RTC_ALARM_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_ELPS_TIM, 6, BD70528_INT_ELPS_TIM_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_GPIO0, 7, BD70528_INT_GPIO0_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_GPIO1, 7, BD70528_INT_GPIO1_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_GPIO2, 7, BD70528_INT_GPIO2_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_GPIO3, 7, BD70528_INT_GPIO3_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK1_DVS_OPFAIL, 8,
-		       BD70528_INT_BUCK1_DVS_OPFAIL_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK2_DVS_OPFAIL, 8,
-		       BD70528_INT_BUCK2_DVS_OPFAIL_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_BUCK3_DVS_OPFAIL, 8,
-		       BD70528_INT_BUCK3_DVS_OPFAIL_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LED1_VOLT_OPFAIL, 8,
-		       BD70528_INT_LED1_VOLT_OPFAIL_MASK),
-	REGMAP_IRQ_REG(BD70528_INT_LED2_VOLT_OPFAIL, 8,
-		       BD70528_INT_LED2_VOLT_OPFAIL_MASK),
-};
-
-static struct regmap_irq_chip bd70528_irq_chip =3D {
-	.name =3D "bd70528_irq",
-	.main_status =3D BD70528_REG_INT_MAIN,
-	.irqs =3D &bd70528_irqs[0],
-	.num_irqs =3D ARRAY_SIZE(bd70528_irqs),
-	.status_base =3D BD70528_REG_INT_SHDN,
-	.mask_base =3D BD70528_REG_INT_SHDN_MASK,
-	.ack_base =3D BD70528_REG_INT_SHDN,
-	.type_base =3D BD70528_REG_GPIO1_IN,
-	.init_ack_masked =3D true,
-	.num_regs =3D 9,
-	.num_main_regs =3D 1,
-	.num_type_reg =3D 4,
-	.sub_reg_offsets =3D &bd70528_sub_irq_offsets[0],
-	.num_main_status_bits =3D 8,
-	.irq_reg_stride =3D 1,
-};
-
-static int bd70528_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
-{
-	struct bd70528_data *bd70528;
-	struct regmap_irq_chip_data *irq_data;
-	int ret, i;
-
-	if (!i2c->irq) {
-		dev_err(&i2c->dev, "No IRQ configured\n");
-		return -EINVAL;
-	}
-
-	bd70528 =3D devm_kzalloc(&i2c->dev, sizeof(*bd70528), GFP_KERNEL);
-	if (!bd70528)
-		return -ENOMEM;
-
-	mutex_init(&bd70528->rtc_timer_lock);
-
-	dev_set_drvdata(&i2c->dev, &bd70528->chip);
-
-	bd70528->chip.regmap =3D devm_regmap_init_i2c(i2c, &bd70528_regmap);
-	if (IS_ERR(bd70528->chip.regmap)) {
-		dev_err(&i2c->dev, "Failed to initialize Regmap\n");
-		return PTR_ERR(bd70528->chip.regmap);
-	}
-
-	/*
-	 * Disallow type setting for all IRQs by default as most of them do not
-	 * support setting type.
-	 */
-	for (i =3D 0; i < ARRAY_SIZE(bd70528_irqs); i++)
-		bd70528_irqs[i].type.types_supported =3D 0;
-
-	/* Set IRQ typesetting information for GPIO pins 0 - 3 */
-	for (i =3D 0; i < BD70528_NUM_OF_GPIOS; i++) {
-		struct regmap_irq_type *type;
-
-		type =3D &bd70528_irqs[BD70528_INT_GPIO0 + i].type;
-		type->type_reg_offset =3D 2 * i;
-		type->type_rising_val =3D 0x20;
-		type->type_falling_val =3D 0x10;
-		type->type_level_high_val =3D 0x40;
-		type->type_level_low_val =3D 0x50;
-		type->types_supported =3D (IRQ_TYPE_EDGE_BOTH |
-				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
-	}
-
-	ret =3D devm_regmap_add_irq_chip(&i2c->dev, bd70528->chip.regmap,
-				       i2c->irq, IRQF_ONESHOT, 0,
-				       &bd70528_irq_chip, &irq_data);
-	if (ret) {
-		dev_err(&i2c->dev, "Failed to add IRQ chip\n");
-		return ret;
-	}
-	dev_dbg(&i2c->dev, "Registered %d IRQs for chip\n",
-		bd70528_irq_chip.num_irqs);
-
-	/*
-	 * BD70528 IRQ controller is not touching the main mask register.
-	 * So enable the GPIO block interrupts at main level. We can just leave
-	 * them enabled as the IRQ controller should disable IRQs from
-	 * sub-registers when IRQ is disabled or freed.
-	 */
-	ret =3D regmap_update_bits(bd70528->chip.regmap,
-				 BD70528_REG_INT_MAIN_MASK,
-				 BD70528_INT_GPIO_MASK, 0);
-
-	ret =3D devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
-				   bd70528_mfd_cells,
-				   ARRAY_SIZE(bd70528_mfd_cells), NULL, 0,
-				   regmap_irq_get_domain(irq_data));
-	if (ret)
-		dev_err(&i2c->dev, "Failed to create subdevices\n");
-
-	return ret;
-}
-
-static const struct of_device_id bd70528_of_match[] =3D {
-	{ .compatible =3D "rohm,bd70528", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, bd70528_of_match);
-
-static struct i2c_driver bd70528_drv =3D {
-	.driver =3D {
-		.name =3D "rohm-bd70528",
-		.of_match_table =3D bd70528_of_match,
-	},
-	.probe =3D &bd70528_i2c_probe,
-};
-
-module_i2c_driver(bd70528_drv);
-
-MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("ROHM BD70528 Power Management IC driver");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/rohm-bd70528.h b/include/linux/mfd/rohm-bd70=
528.h
deleted file mode 100644
index a57af878fd0c..000000000000
--- a/include/linux/mfd/rohm-bd70528.h
+++ /dev/null
@@ -1,391 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* Copyright (C) 2018 ROHM Semiconductors */
-
-#ifndef __LINUX_MFD_BD70528_H__
-#define __LINUX_MFD_BD70528_H__
-
-#include <linux/bits.h>
-#include <linux/device.h>
-#include <linux/mfd/rohm-generic.h>
-#include <linux/mfd/rohm-shared.h>
-#include <linux/regmap.h>
-
-enum {
-	BD70528_BUCK1,
-	BD70528_BUCK2,
-	BD70528_BUCK3,
-	BD70528_LDO1,
-	BD70528_LDO2,
-	BD70528_LDO3,
-	BD70528_LED1,
-	BD70528_LED2,
-};
-
-struct bd70528_data {
-	struct rohm_regmap_dev chip;
-	struct mutex rtc_timer_lock;
-};
-
-#define BD70528_BUCK_VOLTS 17
-#define BD70528_BUCK_VOLTS 17
-#define BD70528_BUCK_VOLTS 17
-#define BD70528_LDO_VOLTS 0x20
-
-#define BD70528_REG_BUCK1_EN	0x0F
-#define BD70528_REG_BUCK1_VOLT	0x15
-#define BD70528_REG_BUCK2_EN	0x10
-#define BD70528_REG_BUCK2_VOLT	0x16
-#define BD70528_REG_BUCK3_EN	0x11
-#define BD70528_REG_BUCK3_VOLT	0x17
-#define BD70528_REG_LDO1_EN	0x1b
-#define BD70528_REG_LDO1_VOLT	0x1e
-#define BD70528_REG_LDO2_EN	0x1c
-#define BD70528_REG_LDO2_VOLT	0x1f
-#define BD70528_REG_LDO3_EN	0x1d
-#define BD70528_REG_LDO3_VOLT	0x20
-#define BD70528_REG_LED_CTRL	0x2b
-#define BD70528_REG_LED_VOLT	0x29
-#define BD70528_REG_LED_EN	0x2a
-
-/* main irq registers */
-#define BD70528_REG_INT_MAIN	0x7E
-#define BD70528_REG_INT_MAIN_MASK 0x74
-
-/* 'sub irq' registers */
-#define BD70528_REG_INT_SHDN	0x7F
-#define BD70528_REG_INT_PWR_FLT	0x80
-#define BD70528_REG_INT_VR_FLT	0x81
-#define BD70528_REG_INT_MISC	0x82
-#define BD70528_REG_INT_BAT1	0x83
-#define BD70528_REG_INT_BAT2	0x84
-#define BD70528_REG_INT_RTC	0x85
-#define BD70528_REG_INT_GPIO	0x86
-#define BD70528_REG_INT_OP_FAIL	0x87
-
-#define BD70528_REG_INT_SHDN_MASK	0x75
-#define BD70528_REG_INT_PWR_FLT_MASK	0x76
-#define BD70528_REG_INT_VR_FLT_MASK	0x77
-#define BD70528_REG_INT_MISC_MASK	0x78
-#define BD70528_REG_INT_BAT1_MASK	0x79
-#define BD70528_REG_INT_BAT2_MASK	0x7a
-#define BD70528_REG_INT_RTC_MASK	0x7b
-#define BD70528_REG_INT_GPIO_MASK	0x7c
-#define BD70528_REG_INT_OP_FAIL_MASK	0x7d
-
-/* Reset related 'magic' registers */
-#define BD70528_REG_SHIPMODE	0x03
-#define BD70528_REG_HWRESET	0x04
-#define BD70528_REG_WARMRESET	0x05
-#define BD70528_REG_STANDBY	0x06
-
-/* GPIO registers */
-#define BD70528_REG_GPIO_STATE	0x8F
-
-#define BD70528_REG_GPIO1_IN	0x4d
-#define BD70528_REG_GPIO2_IN	0x4f
-#define BD70528_REG_GPIO3_IN	0x51
-#define BD70528_REG_GPIO4_IN	0x53
-#define BD70528_REG_GPIO1_OUT	0x4e
-#define BD70528_REG_GPIO2_OUT	0x50
-#define BD70528_REG_GPIO3_OUT	0x52
-#define BD70528_REG_GPIO4_OUT	0x54
-
-/* RTC */
-
-#define BD70528_REG_RTC_COUNT_H		0x2d
-#define BD70528_REG_RTC_COUNT_L		0x2e
-#define BD70528_REG_RTC_SEC		0x2f
-#define BD70528_REG_RTC_MINUTE		0x30
-#define BD70528_REG_RTC_HOUR		0x31
-#define BD70528_REG_RTC_WEEK		0x32
-#define BD70528_REG_RTC_DAY		0x33
-#define BD70528_REG_RTC_MONTH		0x34
-#define BD70528_REG_RTC_YEAR		0x35
-
-#define BD70528_REG_RTC_ALM_SEC		0x36
-#define BD70528_REG_RTC_ALM_START	BD70528_REG_RTC_ALM_SEC
-#define BD70528_REG_RTC_ALM_MINUTE	0x37
-#define BD70528_REG_RTC_ALM_HOUR	0x38
-#define BD70528_REG_RTC_ALM_WEEK	0x39
-#define BD70528_REG_RTC_ALM_DAY		0x3a
-#define BD70528_REG_RTC_ALM_MONTH	0x3b
-#define BD70528_REG_RTC_ALM_YEAR	0x3c
-#define BD70528_REG_RTC_ALM_MASK	0x3d
-#define BD70528_REG_RTC_ALM_REPEAT	0x3e
-#define BD70528_REG_RTC_START		BD70528_REG_RTC_SEC
-
-#define BD70528_REG_RTC_WAKE_SEC	0x43
-#define BD70528_REG_RTC_WAKE_START	BD70528_REG_RTC_WAKE_SEC
-#define BD70528_REG_RTC_WAKE_MIN	0x44
-#define BD70528_REG_RTC_WAKE_HOUR	0x45
-#define BD70528_REG_RTC_WAKE_CTRL	0x46
-
-#define BD70528_REG_ELAPSED_TIMER_EN	0x42
-#define BD70528_REG_WAKE_EN		0x46
-
-/* WDT registers */
-#define BD70528_REG_WDT_CTRL		0x4A
-#define BD70528_REG_WDT_HOUR		0x49
-#define BD70528_REG_WDT_MINUTE		0x48
-#define BD70528_REG_WDT_SEC		0x47
-
-/* Charger / Battery */
-#define BD70528_REG_CHG_CURR_STAT	0x59
-#define BD70528_REG_CHG_BAT_STAT	0x57
-#define BD70528_REG_CHG_BAT_TEMP	0x58
-#define BD70528_REG_CHG_IN_STAT		0x56
-#define BD70528_REG_CHG_DCIN_ILIM	0x5d
-#define BD70528_REG_CHG_CHG_CURR_WARM	0x61
-#define BD70528_REG_CHG_CHG_CURR_COLD	0x62
-
-/* Masks for main IRQ register bits */
-enum {
-	BD70528_INT_SHDN,
-#define BD70528_INT_SHDN_MASK BIT(BD70528_INT_SHDN)
-	BD70528_INT_PWR_FLT,
-#define BD70528_INT_PWR_FLT_MASK BIT(BD70528_INT_PWR_FLT)
-	BD70528_INT_VR_FLT,
-#define BD70528_INT_VR_FLT_MASK BIT(BD70528_INT_VR_FLT)
-	BD70528_INT_MISC,
-#define BD70528_INT_MISC_MASK BIT(BD70528_INT_MISC)
-	BD70528_INT_BAT1,
-#define BD70528_INT_BAT1_MASK BIT(BD70528_INT_BAT1)
-	BD70528_INT_RTC,
-#define BD70528_INT_RTC_MASK BIT(BD70528_INT_RTC)
-	BD70528_INT_GPIO,
-#define BD70528_INT_GPIO_MASK BIT(BD70528_INT_GPIO)
-	BD70528_INT_OP_FAIL,
-#define BD70528_INT_OP_FAIL_MASK BIT(BD70528_INT_OP_FAIL)
-};
-
-/* IRQs */
-enum {
-	/* Shutdown register IRQs */
-	BD70528_INT_LONGPUSH,
-	BD70528_INT_WDT,
-	BD70528_INT_HWRESET,
-	BD70528_INT_RSTB_FAULT,
-	BD70528_INT_VBAT_UVLO,
-	BD70528_INT_TSD,
-	BD70528_INT_RSTIN,
-	/* Power failure register IRQs */
-	BD70528_INT_BUCK1_FAULT,
-	BD70528_INT_BUCK2_FAULT,
-	BD70528_INT_BUCK3_FAULT,
-	BD70528_INT_LDO1_FAULT,
-	BD70528_INT_LDO2_FAULT,
-	BD70528_INT_LDO3_FAULT,
-	BD70528_INT_LED1_FAULT,
-	BD70528_INT_LED2_FAULT,
-	/* VR FAULT register IRQs */
-	BD70528_INT_BUCK1_OCP,
-	BD70528_INT_BUCK2_OCP,
-	BD70528_INT_BUCK3_OCP,
-	BD70528_INT_LED1_OCP,
-	BD70528_INT_LED2_OCP,
-	BD70528_INT_BUCK1_FULLON,
-	BD70528_INT_BUCK2_FULLON,
-	/* PMU register interrupts */
-	BD70528_INT_SHORTPUSH,
-	BD70528_INT_AUTO_WAKEUP,
-	BD70528_INT_STATE_CHANGE,
-	/* Charger 1 register IRQs */
-	BD70528_INT_BAT_OV_RES,
-	BD70528_INT_BAT_OV_DET,
-	BD70528_INT_DBAT_DET,
-	BD70528_INT_BATTSD_COLD_RES,
-	BD70528_INT_BATTSD_COLD_DET,
-	BD70528_INT_BATTSD_HOT_RES,
-	BD70528_INT_BATTSD_HOT_DET,
-	BD70528_INT_CHG_TSD,
-	/* Charger 2 register IRQs */
-	BD70528_INT_BAT_RMV,
-	BD70528_INT_BAT_DET,
-	BD70528_INT_DCIN2_OV_RES,
-	BD70528_INT_DCIN2_OV_DET,
-	BD70528_INT_DCIN2_RMV,
-	BD70528_INT_DCIN2_DET,
-	BD70528_INT_DCIN1_RMV,
-	BD70528_INT_DCIN1_DET,
-	/* RTC register IRQs */
-	BD70528_INT_RTC_ALARM,
-	BD70528_INT_ELPS_TIM,
-	/* GPIO register IRQs */
-	BD70528_INT_GPIO0,
-	BD70528_INT_GPIO1,
-	BD70528_INT_GPIO2,
-	BD70528_INT_GPIO3,
-	/* Invalid operation register IRQs */
-	BD70528_INT_BUCK1_DVS_OPFAIL,
-	BD70528_INT_BUCK2_DVS_OPFAIL,
-	BD70528_INT_BUCK3_DVS_OPFAIL,
-	BD70528_INT_LED1_VOLT_OPFAIL,
-	BD70528_INT_LED2_VOLT_OPFAIL,
-};
-
-/* Masks */
-#define BD70528_INT_LONGPUSH_MASK 0x1
-#define BD70528_INT_WDT_MASK 0x2
-#define BD70528_INT_HWRESET_MASK 0x4
-#define BD70528_INT_RSTB_FAULT_MASK 0x8
-#define BD70528_INT_VBAT_UVLO_MASK 0x10
-#define BD70528_INT_TSD_MASK 0x20
-#define BD70528_INT_RSTIN_MASK 0x40
-
-#define BD70528_INT_BUCK1_FAULT_MASK 0x1
-#define BD70528_INT_BUCK2_FAULT_MASK 0x2
-#define BD70528_INT_BUCK3_FAULT_MASK 0x4
-#define BD70528_INT_LDO1_FAULT_MASK 0x8
-#define BD70528_INT_LDO2_FAULT_MASK 0x10
-#define BD70528_INT_LDO3_FAULT_MASK 0x20
-#define BD70528_INT_LED1_FAULT_MASK 0x40
-#define BD70528_INT_LED2_FAULT_MASK 0x80
-
-#define BD70528_INT_BUCK1_OCP_MASK 0x1
-#define BD70528_INT_BUCK2_OCP_MASK 0x2
-#define BD70528_INT_BUCK3_OCP_MASK 0x4
-#define BD70528_INT_LED1_OCP_MASK 0x8
-#define BD70528_INT_LED2_OCP_MASK 0x10
-#define BD70528_INT_BUCK1_FULLON_MASK 0x20
-#define BD70528_INT_BUCK2_FULLON_MASK 0x40
-
-#define BD70528_INT_SHORTPUSH_MASK 0x1
-#define BD70528_INT_AUTO_WAKEUP_MASK 0x2
-#define BD70528_INT_STATE_CHANGE_MASK 0x10
-
-#define BD70528_INT_BAT_OV_RES_MASK 0x1
-#define BD70528_INT_BAT_OV_DET_MASK 0x2
-#define BD70528_INT_DBAT_DET_MASK 0x4
-#define BD70528_INT_BATTSD_COLD_RES_MASK 0x8
-#define BD70528_INT_BATTSD_COLD_DET_MASK 0x10
-#define BD70528_INT_BATTSD_HOT_RES_MASK 0x20
-#define BD70528_INT_BATTSD_HOT_DET_MASK 0x40
-#define BD70528_INT_CHG_TSD_MASK 0x80
-
-#define BD70528_INT_BAT_RMV_MASK 0x1
-#define BD70528_INT_BAT_DET_MASK 0x2
-#define BD70528_INT_DCIN2_OV_RES_MASK 0x4
-#define BD70528_INT_DCIN2_OV_DET_MASK 0x8
-#define BD70528_INT_DCIN2_RMV_MASK 0x10
-#define BD70528_INT_DCIN2_DET_MASK 0x20
-#define BD70528_INT_DCIN1_RMV_MASK 0x40
-#define BD70528_INT_DCIN1_DET_MASK 0x80
-
-#define BD70528_INT_RTC_ALARM_MASK 0x1
-#define BD70528_INT_ELPS_TIM_MASK 0x2
-
-#define BD70528_INT_GPIO0_MASK 0x1
-#define BD70528_INT_GPIO1_MASK 0x2
-#define BD70528_INT_GPIO2_MASK 0x4
-#define BD70528_INT_GPIO3_MASK 0x8
-
-#define BD70528_INT_BUCK1_DVS_OPFAIL_MASK 0x1
-#define BD70528_INT_BUCK2_DVS_OPFAIL_MASK 0x2
-#define BD70528_INT_BUCK3_DVS_OPFAIL_MASK 0x4
-#define BD70528_INT_LED1_VOLT_OPFAIL_MASK 0x10
-#define BD70528_INT_LED2_VOLT_OPFAIL_MASK 0x20
-
-#define BD70528_DEBOUNCE_MASK 0x3
-
-#define BD70528_DEBOUNCE_DISABLE 0
-#define BD70528_DEBOUNCE_15MS 1
-#define BD70528_DEBOUNCE_30MS 2
-#define BD70528_DEBOUNCE_50MS 3
-
-#define BD70528_GPIO_DRIVE_MASK 0x2
-#define BD70528_GPIO_PUSH_PULL 0x0
-#define BD70528_GPIO_OPEN_DRAIN 0x2
-
-#define BD70528_GPIO_OUT_EN_MASK 0x80
-#define BD70528_GPIO_OUT_ENABLE 0x80
-#define BD70528_GPIO_OUT_DISABLE 0x0
-
-#define BD70528_GPIO_OUT_HI 0x1
-#define BD70528_GPIO_OUT_LO 0x0
-#define BD70528_GPIO_OUT_MASK 0x1
-
-#define BD70528_GPIO_IN_STATE_BASE 1
-
-/* RTC masks to mask out reserved bits */
-
-#define BD70528_MASK_ELAPSED_TIMER_EN	0x1
-/* Mask second, min and hour fields
- * HW would support ALM irq for over 24h
- * (by setting day, month and year too)
- * but as we wish to keep this same as for
- * wake-up we limit ALM to 24H and only
- * unmask sec, min and hour
- */
-#define BD70528_MASK_WAKE_EN		0x1
-
-/* WDT masks */
-#define BD70528_MASK_WDT_EN		0x1
-#define BD70528_MASK_WDT_HOUR		0x1
-#define BD70528_MASK_WDT_MINUTE		0x7f
-#define BD70528_MASK_WDT_SEC		0x7f
-
-#define BD70528_WDT_STATE_BIT		0x1
-#define BD70528_ELAPSED_STATE_BIT	0x2
-#define BD70528_WAKE_STATE_BIT		0x4
-
-/* Charger masks */
-#define BD70528_MASK_CHG_STAT		0x7f
-#define BD70528_MASK_CHG_BAT_TIMER	0x20
-#define BD70528_MASK_CHG_BAT_OVERVOLT	0x10
-#define BD70528_MASK_CHG_BAT_DETECT	0x1
-#define BD70528_MASK_CHG_DCIN1_UVLO	0x1
-#define BD70528_MASK_CHG_DCIN_ILIM	0x3f
-#define BD70528_MASK_CHG_CHG_CURR	0x1f
-#define BD70528_MASK_CHG_TRICKLE_CURR	0x10
-
-/*
- * Note, external battery register is the lonely rider at
- * address 0xc5. See how to stuff that in the regmap
- */
-#define BD70528_MAX_REGISTER 0x94
-
-/* Buck control masks */
-#define BD70528_MASK_RUN_EN	0x4
-#define BD70528_MASK_STBY_EN	0x2
-#define BD70528_MASK_IDLE_EN	0x1
-#define BD70528_MASK_LED1_EN	0x1
-#define BD70528_MASK_LED2_EN	0x10
-
-#define BD70528_MASK_BUCK_VOLT	0xf
-#define BD70528_MASK_LDO_VOLT	0x1f
-#define BD70528_MASK_LED1_VOLT	0x1
-#define BD70528_MASK_LED2_VOLT	0x10
-
-/* Misc irq masks */
-#define BD70528_INT_MASK_SHORT_PUSH	1
-#define BD70528_INT_MASK_AUTO_WAKE	2
-#define BD70528_INT_MASK_POWER_STATE	4
-
-#define BD70528_MASK_BUCK_RAMP 0x10
-#define BD70528_SIFT_BUCK_RAMP 4
-
-#if IS_ENABLED(CONFIG_BD70528_WATCHDOG)
-
-int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable, int *old_sta=
te);
-void bd70528_wdt_lock(struct rohm_regmap_dev *data);
-void bd70528_wdt_unlock(struct rohm_regmap_dev *data);
-
-#else /* CONFIG_BD70528_WATCHDOG */
-
-static inline int bd70528_wdt_set(struct rohm_regmap_dev *data, int enable,
-				  int *old_state)
-{
-	return 0;
-}
-
-static inline void bd70528_wdt_lock(struct rohm_regmap_dev *data)
-{
-}
-
-static inline void bd70528_wdt_unlock(struct rohm_regmap_dev *data)
-{
-}
-
-#endif /* CONFIG_BD70528_WATCHDOG */
-
-#endif /* __LINUX_MFD_BD70528_H__ */
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index 35b392a0d73a..8fb763a2265a 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -12,7 +12,6 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD9573,
 	ROHM_CHIP_TYPE_BD9574,
 	ROHM_CHIP_TYPE_BD9576,
-	ROHM_CHIP_TYPE_BD70528,
 	ROHM_CHIP_TYPE_BD71815,
 	ROHM_CHIP_TYPE_BD71828,
 	ROHM_CHIP_TYPE_BD71837,
--=20
2.25.4


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCszmUACgkQeFA3/03a
ocWonwf/ZN4EmWSIrHfP09GnYPNBc3OLP7WZBd5ii4Wdl5uy5uevhai822SInz9a
SrwcW8AEES6zXiwnrgWWXtEmb7FgRb2bYmlgnD5mpToeQRZgrw5PQLOUKaBWzDlI
uRhXKm9WAmguj9r0MxqWnExIFpXTuEFbFvTw0kzPPUWcedua9OlbFu/JINacyog8
1whSVqvHB7K9DRAnLIVF2EC/8qTxaAz5lTkP0otJcC8ipWLz8Rxs2/VnAa9w/ymc
6N7blziCpOc6SFRZHTSw8IOEN8JgrQUBXmb80yVPJX1RtaZCyCxPsF7ZppteMEOw
HOLtGPPjte+sAhVHtm5uI0AOqs+IHg==
=JmNF
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
