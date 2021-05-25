Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347DC38FED6
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhEYKRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:17:46 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33320 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhEYKR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:17:27 -0400
Received: by mail-lj1-f182.google.com with SMTP id o8so37448204ljp.0;
        Tue, 25 May 2021 03:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCXj2hFRK4r9qVCDTJqNtXsR+M0GEZxH/E4B0bqbPDQ=;
        b=QZSwoMRHHiUmkewM1c/iS+1iOOshv5c1DmXmfJlFmHK2ZI2r3/JBQlPyjeI05nOCfB
         3WBhNnQKY1MMJSbC1a8NQLvmthCnNydpGk9vws4ukjgGDWXMZ2fRUY+TccogRFGg20yQ
         Z+BAOU/qY+E9cbBtbeU47RLFPSYs1jfaiyMz8Vrrz78Si4T6m9bqBmcij6xXuFUIUOeD
         aBlojIeofZhBNGsbuYNmtqNEdYe1pcKodpWqcxzY6ApEg6Rbre1/Zy9OF7kRyoYvyZLa
         LKkD7dVxNirdPMhg766y6TLUQyixZSYfPEtLNYHzNCN5TmeCbIohw4G8dhouAudrj06i
         EXsA==
X-Gm-Message-State: AOAM531SWbsx7uAzrHP4vwO2MbhhaE4efeZ3kWxEP0qeouG9D7N728Wz
        pvHqIaxelu+jfdRnk7Uiy1I=
X-Google-Smtp-Source: ABdhPJxXZUbqkNTam0NV3p8DCdK6Hg0Wv4OGeGL1bMq1/Gz1sdOXUZXD4YrbVyC2CCRK2t8z7QcUAw==
X-Received: by 2002:a2e:b550:: with SMTP id a16mr17847704ljn.323.1621937754756;
        Tue, 25 May 2021 03:15:54 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id m5sm2051610ljg.118.2021.05.25.03.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:15:54 -0700 (PDT)
Date:   Tue, 25 May 2021 13:15:47 +0300
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
Subject: [PATCH 7/9] power: supply: Drop BD70528 support
Message-ID: <0d9ca725f04fa54521961e1a33e972888c488879.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--/04w6evG8XlLl3ft
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
 drivers/power/supply/Kconfig           |   9 -
 drivers/power/supply/Makefile          |   1 -
 drivers/power/supply/bd70528-charger.c | 710 -------------------------
 3 files changed, 720 deletions(-)
 delete mode 100644 drivers/power/supply/bd70528-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e696364126f1..b99d19f48769 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -760,15 +760,6 @@ config CHARGER_UCS1002
 	  Say Y to enable support for Microchip UCS1002 Programmable
 	  USB Port Power Controller with Charger Emulation.
=20
-config CHARGER_BD70528
-	tristate "ROHM bd70528 charger driver"
-	depends on MFD_ROHM_BD70528
-	select LINEAR_RANGES
-	help
-	  Say Y here to enable support for getting battery status
-	  information and altering charger configurations from charger
-	  block of the ROHM BD70528 Power Management IC.
-
 config CHARGER_BD99954
 	tristate "ROHM bd99954 charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index a7309a3d1a47..7ad7d9a05523 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -96,7 +96,6 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
-obj-$(CONFIG_CHARGER_BD70528)	+=3D bd70528-charger.o
 obj-$(CONFIG_CHARGER_BD99954)	+=3D bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
 obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/=
bd70528-charger.c
deleted file mode 100644
index 7c1f0b99c71b..000000000000
--- a/drivers/power/supply/bd70528-charger.c
+++ /dev/null
@@ -1,710 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-//
-// Copyright (C) 2018 ROHM Semiconductors
-//
-// power-supply driver for ROHM BD70528 PMIC
-
-/*
- * BD70528 charger HW state machine.
- *
- * The thermal shutdown state is not drawn. From any other state but
- * battery error and suspend it is possible to go to TSD/TMP states
- * if temperature is out of bounds.
- *
- *  CHG_RST =3D H
- *  or CHG_EN=3DL
- *  or (DCIN2_UVLO=3DL && DCIN1_UVLO=3DL)
- *  or (DCIN2_OVLO=3DH & DCIN1_UVKLO=3DL)
- *
- *  +--------------+         +--------------+
- *  |              |         |              |
- *  |  Any state   +-------> |    Suspend   |
- *  |              |         |              |
- *  +--------------+         +------+-------+
- *                                  |
- *  CHG_EN =3D H && BAT_DET =3D H &&    |
- *  No errors (temp, bat_ov, UVLO,  |
- *  OVLO...)                        |
- *                                  |
- *  BAT_OV or             +---------v----------+
- *  (DBAT && TTRI)        |                    |
- *      +-----------------+   Trickle Charge   | <---------------+
- *      |                 |                    |                 |
- *      |                 +-------+------------+                 |
- *      |                         |                              |
- *      |                         |     ^                        |
- *      |        V_BAT > VTRI_TH  |     |  VBAT < VTRI_TH - 50mV |
- *      |                         |     |                        |
- *      |                         v     |                        |
- *      |                               |                        |
- *      |     BAT_OV or      +----------+----+                   |
- *      |     (DBAT && TFST) |               |                   |
- *      |   +----------------+  Fast Charge  |                   |
- *      |   |                |               |                   |
- *      v   v                +----+----------+                   |
- *                                |                              |
- *+----------------+   ILIM_DET=3DL |    ^ ILIM_DET                |
- *|                |   & CV_DET=3DH |    | or CV_DET=3DL             |
- *|  Battery Error |   & VBAT >   |    | or VBAT < VRECHG_TH     |
- *|                |   VRECHG_TH  |    | or IBAT  > IFST/x       |
- *+----------------+   & IBAT <   |    |                         |
- *                     IFST/x     v    |                         |
- *       ^                             |                         |
- *       |                   +---------+-+                       |
- *       |                   |           |                       |
- *       +-------------------+  Top OFF  |                       |
- *  BAT_OV =3D H or            |           |                       |
- *  (DBAT && TFST)           +-----+-----+                       |
- *                                 |                             |
- *           Stay top-off for 15s  |                             |
- *                                 v                             |
- *                                                               |
- *                            +--------+                         |
- *                            |        |                         |
- *                            |  Done  +-------------------------+
- *                            |        |
- *                            +--------+   VBAT < VRECHG_TH
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/mfd/rohm-bd70528.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/power_supply.h>
-#include <linux/linear_range.h>
-
-#define CHG_STAT_SUSPEND	0x0
-#define CHG_STAT_TRICKLE	0x1
-#define CHG_STAT_FAST		0x3
-#define CHG_STAT_TOPOFF		0xe
-#define CHG_STAT_DONE		0xf
-#define CHG_STAT_OTP_TRICKLE	0x10
-#define CHG_STAT_OTP_FAST	0x11
-#define CHG_STAT_OTP_DONE	0x12
-#define CHG_STAT_TSD_TRICKLE	0x20
-#define CHG_STAT_TSD_FAST	0x21
-#define CHG_STAT_TSD_TOPOFF	0x22
-#define CHG_STAT_BAT_ERR	0x7f
-
-static const char *bd70528_charger_model =3D "BD70528";
-static const char *bd70528_charger_manufacturer =3D "ROHM Semiconductors";
-
-#define BD_ERR_IRQ_HND(_name_, _wrn_)					\
-static irqreturn_t bd0528_##_name_##_interrupt(int irq, void *arg)	\
-{									\
-	struct power_supply *psy =3D (struct power_supply *)arg;		\
-									\
-	power_supply_changed(psy);					\
-	dev_err(&psy->dev, (_wrn_));					\
-									\
-	return IRQ_HANDLED;						\
-}
-
-#define BD_INFO_IRQ_HND(_name_, _wrn_)					\
-static irqreturn_t bd0528_##_name_##_interrupt(int irq, void *arg)	\
-{									\
-	struct power_supply *psy =3D (struct power_supply *)arg;		\
-									\
-	power_supply_changed(psy);					\
-	dev_dbg(&psy->dev, (_wrn_));					\
-									\
-	return IRQ_HANDLED;						\
-}
-
-#define BD_IRQ_HND(_name_) bd0528_##_name_##_interrupt
-
-struct bd70528_psy {
-	struct regmap *regmap;
-	struct device *dev;
-	struct power_supply *psy;
-};
-
-BD_ERR_IRQ_HND(BAT_OV_DET, "Battery overvoltage detected\n");
-BD_ERR_IRQ_HND(DBAT_DET, "Dead battery detected\n");
-BD_ERR_IRQ_HND(COLD_DET, "Battery cold\n");
-BD_ERR_IRQ_HND(HOT_DET, "Battery hot\n");
-BD_ERR_IRQ_HND(CHG_TSD, "Charger thermal shutdown\n");
-BD_ERR_IRQ_HND(DCIN2_OV_DET, "DCIN2 overvoltage detected\n");
-
-BD_INFO_IRQ_HND(BAT_OV_RES, "Battery voltage back to normal\n");
-BD_INFO_IRQ_HND(COLD_RES, "Battery temperature back to normal\n");
-BD_INFO_IRQ_HND(HOT_RES, "Battery temperature back to normal\n");
-BD_INFO_IRQ_HND(BAT_RMV, "Battery removed\n");
-BD_INFO_IRQ_HND(BAT_DET, "Battery detected\n");
-BD_INFO_IRQ_HND(DCIN2_OV_RES, "DCIN2 voltage back to normal\n");
-BD_INFO_IRQ_HND(DCIN2_RMV, "DCIN2 removed\n");
-BD_INFO_IRQ_HND(DCIN2_DET, "DCIN2 detected\n");
-BD_INFO_IRQ_HND(DCIN1_RMV, "DCIN1 removed\n");
-BD_INFO_IRQ_HND(DCIN1_DET, "DCIN1 detected\n");
-
-struct irq_name_pair {
-	const char *n;
-	irqreturn_t (*h)(int irq, void *arg);
-};
-
-static int bd70528_get_irqs(struct platform_device *pdev,
-			    struct bd70528_psy *bdpsy)
-{
-	int irq, i, ret;
-	unsigned int mask;
-	static const struct irq_name_pair bd70528_chg_irqs[] =3D {
-		{ .n =3D "bd70528-bat-ov-res", .h =3D BD_IRQ_HND(BAT_OV_RES) },
-		{ .n =3D "bd70528-bat-ov-det", .h =3D BD_IRQ_HND(BAT_OV_DET) },
-		{ .n =3D "bd70528-bat-dead", .h =3D BD_IRQ_HND(DBAT_DET) },
-		{ .n =3D "bd70528-bat-warmed", .h =3D BD_IRQ_HND(COLD_RES) },
-		{ .n =3D "bd70528-bat-cold", .h =3D BD_IRQ_HND(COLD_DET) },
-		{ .n =3D "bd70528-bat-cooled", .h =3D BD_IRQ_HND(HOT_RES) },
-		{ .n =3D "bd70528-bat-hot", .h =3D BD_IRQ_HND(HOT_DET) },
-		{ .n =3D "bd70528-chg-tshd", .h =3D BD_IRQ_HND(CHG_TSD) },
-		{ .n =3D "bd70528-bat-removed", .h =3D BD_IRQ_HND(BAT_RMV) },
-		{ .n =3D "bd70528-bat-detected", .h =3D BD_IRQ_HND(BAT_DET) },
-		{ .n =3D "bd70528-dcin2-ov-res", .h =3D BD_IRQ_HND(DCIN2_OV_RES) },
-		{ .n =3D "bd70528-dcin2-ov-det", .h =3D BD_IRQ_HND(DCIN2_OV_DET) },
-		{ .n =3D "bd70528-dcin2-removed", .h =3D BD_IRQ_HND(DCIN2_RMV) },
-		{ .n =3D "bd70528-dcin2-detected", .h =3D BD_IRQ_HND(DCIN2_DET) },
-		{ .n =3D "bd70528-dcin1-removed", .h =3D BD_IRQ_HND(DCIN1_RMV) },
-		{ .n =3D "bd70528-dcin1-detected", .h =3D BD_IRQ_HND(DCIN1_DET) },
-	};
-
-	for (i =3D 0; i < ARRAY_SIZE(bd70528_chg_irqs); i++) {
-		irq =3D platform_get_irq_byname(pdev, bd70528_chg_irqs[i].n);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "Bad IRQ information for %s (%d)\n",
-				bd70528_chg_irqs[i].n, irq);
-			return irq;
-		}
-		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						bd70528_chg_irqs[i].h,
-						IRQF_ONESHOT,
-						bd70528_chg_irqs[i].n,
-						bdpsy->psy);
-
-		if (ret)
-			return ret;
-	}
-	/*
-	 * BD70528 irq controller is not touching the main mask register.
-	 * So enable the charger block interrupts at main level. We can just
-	 * leave them enabled as irq-controller should disable irqs
-	 * from sub-registers when IRQ is disabled or freed.
-	 */
-	mask =3D BD70528_REG_INT_BAT1_MASK | BD70528_REG_INT_BAT2_MASK;
-	ret =3D regmap_update_bits(bdpsy->regmap,
-				 BD70528_REG_INT_MAIN_MASK, mask, 0);
-	if (ret)
-		dev_err(&pdev->dev, "Failed to enable charger IRQs\n");
-
-	return ret;
-}
-
-static int bd70528_get_charger_status(struct bd70528_psy *bdpsy, int *val)
-{
-	int ret;
-	unsigned int v;
-
-	ret =3D regmap_read(bdpsy->regmap, BD70528_REG_CHG_CURR_STAT, &v);
-	if (ret) {
-		dev_err(bdpsy->dev, "Charger state read failure %d\n",
-			ret);
-		return ret;
-	}
-
-	switch (v & BD70528_MASK_CHG_STAT) {
-	case CHG_STAT_SUSPEND:
-	/* Maybe we should check the CHG_TTRI_EN? */
-	case CHG_STAT_OTP_TRICKLE:
-	case CHG_STAT_OTP_FAST:
-	case CHG_STAT_OTP_DONE:
-	case CHG_STAT_TSD_TRICKLE:
-	case CHG_STAT_TSD_FAST:
-	case CHG_STAT_TSD_TOPOFF:
-	case CHG_STAT_BAT_ERR:
-		*val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
-		break;
-	case CHG_STAT_DONE:
-		*val =3D POWER_SUPPLY_STATUS_FULL;
-		break;
-	case CHG_STAT_TRICKLE:
-	case CHG_STAT_FAST:
-	case CHG_STAT_TOPOFF:
-		*val =3D POWER_SUPPLY_STATUS_CHARGING;
-		break;
-	default:
-		*val =3D POWER_SUPPLY_STATUS_UNKNOWN;
-		break;
-	}
-
-	return 0;
-}
-
-static int bd70528_get_charge_type(struct bd70528_psy *bdpsy, int *val)
-{
-	int ret;
-	unsigned int v;
-
-	ret =3D regmap_read(bdpsy->regmap, BD70528_REG_CHG_CURR_STAT, &v);
-	if (ret) {
-		dev_err(bdpsy->dev, "Charger state read failure %d\n",
-			ret);
-		return ret;
-	}
-
-	switch (v & BD70528_MASK_CHG_STAT) {
-	case CHG_STAT_TRICKLE:
-		*val =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
-		break;
-	case CHG_STAT_FAST:
-	case CHG_STAT_TOPOFF:
-		*val =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
-		break;
-	case CHG_STAT_DONE:
-	case CHG_STAT_SUSPEND:
-	/* Maybe we should check the CHG_TTRI_EN? */
-	case CHG_STAT_OTP_TRICKLE:
-	case CHG_STAT_OTP_FAST:
-	case CHG_STAT_OTP_DONE:
-	case CHG_STAT_TSD_TRICKLE:
-	case CHG_STAT_TSD_FAST:
-	case CHG_STAT_TSD_TOPOFF:
-	case CHG_STAT_BAT_ERR:
-		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
-		break;
-	default:
-		*val =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
-		break;
-	}
-
-	return 0;
-}
-
-static int bd70528_get_battery_health(struct bd70528_psy *bdpsy, int *val)
-{
-	int ret;
-	unsigned int v;
-
-	ret =3D regmap_read(bdpsy->regmap, BD70528_REG_CHG_BAT_STAT, &v);
-	if (ret) {
-		dev_err(bdpsy->dev, "Battery state read failure %d\n",
-			ret);
-		return ret;
-	}
-	/* No battery? */
-	if (!(v & BD70528_MASK_CHG_BAT_DETECT))
-		*val =3D POWER_SUPPLY_HEALTH_DEAD;
-	else if (v & BD70528_MASK_CHG_BAT_OVERVOLT)
-		*val =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
-	else if (v & BD70528_MASK_CHG_BAT_TIMER)
-		*val =3D POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
-	else
-		*val =3D POWER_SUPPLY_HEALTH_GOOD;
-
-	return 0;
-}
-
-static int bd70528_get_online(struct bd70528_psy *bdpsy, int *val)
-{
-	int ret;
-	unsigned int v;
-
-	ret =3D regmap_read(bdpsy->regmap, BD70528_REG_CHG_IN_STAT, &v);
-	if (ret) {
-		dev_err(bdpsy->dev, "DC1 IN state read failure %d\n",
-			ret);
-		return ret;
-	}
-
-	*val =3D (v & BD70528_MASK_CHG_DCIN1_UVLO) ? 1 : 0;
-
-	return 0;
-}
-
-static int bd70528_get_present(struct bd70528_psy *bdpsy, int *val)
-{
-	int ret;
-	unsigned int v;
-
-	ret =3D regmap_read(bdpsy->regmap, BD70528_REG_CHG_BAT_STAT, &v);
-	if (ret) {
-		dev_err(bdpsy->dev, "Battery state read failure %d\n",
-			ret);
-		return ret;
-	}
-
-	*val =3D (v & BD70528_MASK_CHG_BAT_DETECT) ? 1 : 0;
-
-	return 0;
-}
-
-static const struct linear_range current_limit_ranges[] =3D {
-	{
-		.min =3D 5,
-		.step =3D 1,
-		.min_sel =3D 0,
-		.max_sel =3D 0x22,
-	},
-	{
-		.min =3D 40,
-		.step =3D 5,
-		.min_sel =3D 0x23,
-		.max_sel =3D 0x26,
-	},
-	{
-		.min =3D 60,
-		.step =3D 20,
-		.min_sel =3D 0x27,
-		.max_sel =3D 0x2d,
-	},
-	{
-		.min =3D 200,
-		.step =3D 50,
-		.min_sel =3D 0x2e,
-		.max_sel =3D 0x34,
-	},
-	{
-		.min =3D 500,
-		.step =3D 0,
-		.min_sel =3D 0x35,
-		.max_sel =3D 0x3f,
-	},
-};
-
-/*
- * BD70528 would support setting and getting own charge current/
- * voltage for low temperatures. The driver currently only reads
- * the charge current at room temperature. We do set both though.
- */
-static const struct linear_range warm_charge_curr[] =3D {
-	{
-		.min =3D 10,
-		.step =3D 10,
-		.min_sel =3D 0,
-		.max_sel =3D 0x12,
-	},
-	{
-		.min =3D 200,
-		.step =3D 25,
-		.min_sel =3D 0x13,
-		.max_sel =3D 0x1f,
-	},
-};
-
-/*
- * Cold charge current selectors are identical to warm charge current
- * selectors. The difference is that only smaller currents are available
- * at cold charge range.
- */
-#define MAX_COLD_CHG_CURR_SEL 0x15
-#define MAX_WARM_CHG_CURR_SEL 0x1f
-#define MIN_CHG_CURR_SEL 0x0
-
-static int get_charge_current(struct bd70528_psy *bdpsy, int *ma)
-{
-	unsigned int sel;
-	int ret;
-
-	ret =3D regmap_read(bdpsy->regmap, BD70528_REG_CHG_CHG_CURR_WARM,
-			  &sel);
-	if (ret) {
-		dev_err(bdpsy->dev,
-			"Charge current reading failed (%d)\n", ret);
-		return ret;
-	}
-
-	sel &=3D BD70528_MASK_CHG_CHG_CURR;
-
-	ret =3D linear_range_get_value_array(&warm_charge_curr[0],
-					   ARRAY_SIZE(warm_charge_curr),
-					   sel, ma);
-	if (ret) {
-		dev_err(bdpsy->dev,
-			"Unknown charge current value 0x%x\n",
-			sel);
-	}
-
-	return ret;
-}
-
-static int get_current_limit(struct bd70528_psy *bdpsy, int *ma)
-{
-	unsigned int sel;
-	int ret;
-
-	ret =3D regmap_read(bdpsy->regmap, BD70528_REG_CHG_DCIN_ILIM,
-			  &sel);
-
-	if (ret) {
-		dev_err(bdpsy->dev,
-			"Input current limit reading failed (%d)\n", ret);
-		return ret;
-	}
-
-	sel &=3D BD70528_MASK_CHG_DCIN_ILIM;
-
-	ret =3D linear_range_get_value_array(&current_limit_ranges[0],
-					   ARRAY_SIZE(current_limit_ranges),
-					   sel, ma);
-	if (ret) {
-		/* Unspecified values mean 500 mA */
-		*ma =3D 500;
-	}
-	return 0;
-}
-
-static enum power_supply_property bd70528_charger_props[] =3D {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_CHARGE_TYPE,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
-	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
-	POWER_SUPPLY_PROP_MODEL_NAME,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-};
-
-static int bd70528_charger_get_property(struct power_supply *psy,
-					enum power_supply_property psp,
-					union power_supply_propval *val)
-{
-	struct bd70528_psy *bdpsy =3D power_supply_get_drvdata(psy);
-	int ret =3D 0;
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		return bd70528_get_charger_status(bdpsy, &val->intval);
-	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		return bd70528_get_charge_type(bdpsy, &val->intval);
-	case POWER_SUPPLY_PROP_HEALTH:
-		return bd70528_get_battery_health(bdpsy, &val->intval);
-	case POWER_SUPPLY_PROP_PRESENT:
-		return bd70528_get_present(bdpsy, &val->intval);
-	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret =3D get_current_limit(bdpsy, &val->intval);
-		val->intval *=3D 1000;
-		return ret;
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		ret =3D get_charge_current(bdpsy, &val->intval);
-		val->intval *=3D 1000;
-		return ret;
-	case POWER_SUPPLY_PROP_ONLINE:
-		return bd70528_get_online(bdpsy, &val->intval);
-	case POWER_SUPPLY_PROP_MODEL_NAME:
-		val->strval =3D bd70528_charger_model;
-		return 0;
-	case POWER_SUPPLY_PROP_MANUFACTURER:
-		val->strval =3D bd70528_charger_manufacturer;
-		return 0;
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
-static int bd70528_prop_is_writable(struct power_supply *psy,
-				    enum power_supply_property psp)
-{
-	switch (psp) {
-	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		return 1;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static int set_charge_current(struct bd70528_psy *bdpsy, int ma)
-{
-	unsigned int reg;
-	int ret =3D 0, tmpret;
-	bool found;
-
-	if (ma > 500) {
-		dev_warn(bdpsy->dev,
-			 "Requested charge current %u exceed maximum (500mA)\n",
-			 ma);
-		reg =3D MAX_WARM_CHG_CURR_SEL;
-		goto set;
-	}
-	if (ma < 10) {
-		dev_err(bdpsy->dev,
-			"Requested charge current %u smaller than min (10mA)\n",
-			 ma);
-		reg =3D MIN_CHG_CURR_SEL;
-		ret =3D -EINVAL;
-		goto set;
-	}
-
-/*
- * For BD70528 voltage/current limits we happily accept any value which
- * belongs the range. We could check if value matching the selector is
- * desired by computing the range min + (sel - sel_low) * range step - but
- * I guess it is enough if we use voltage/current which is closest (below)
- * the requested?
- */
-
-	ret =3D linear_range_get_selector_low_array(warm_charge_curr,
-						  ARRAY_SIZE(warm_charge_curr),
-						  ma, &reg, &found);
-	if (ret) {
-		dev_err(bdpsy->dev,
-			 "Unsupported charge current %u mA\n", ma);
-		reg =3D MIN_CHG_CURR_SEL;
-		goto set;
-	}
-	if (!found) {
-		/*
-		 * There was a gap in supported values and we hit it.
-		 * Yet a smaller value was found so we use it.
-		 */
-		dev_warn(bdpsy->dev,
-			 "Unsupported charge current %u mA\n", ma);
-	}
-set:
-
-	tmpret =3D regmap_update_bits(bdpsy->regmap,
-				    BD70528_REG_CHG_CHG_CURR_WARM,
-				    BD70528_MASK_CHG_CHG_CURR, reg);
-	if (tmpret)
-		dev_err(bdpsy->dev,
-			"Charge current write failure (%d)\n", tmpret);
-
-	if (reg > MAX_COLD_CHG_CURR_SEL)
-		reg =3D MAX_COLD_CHG_CURR_SEL;
-
-	if (!tmpret)
-		tmpret =3D regmap_update_bits(bdpsy->regmap,
-					    BD70528_REG_CHG_CHG_CURR_COLD,
-					    BD70528_MASK_CHG_CHG_CURR, reg);
-
-	if (!ret)
-		ret =3D tmpret;
-
-	return ret;
-}
-
-#define MAX_CURR_LIMIT_SEL 0x34
-#define MIN_CURR_LIMIT_SEL 0x0
-
-static int set_current_limit(struct bd70528_psy *bdpsy, int ma)
-{
-	unsigned int reg;
-	int ret =3D 0, tmpret;
-	bool found;
-
-	if (ma > 500) {
-		dev_warn(bdpsy->dev,
-			 "Requested current limit %u exceed maximum (500mA)\n",
-			 ma);
-		reg =3D MAX_CURR_LIMIT_SEL;
-		goto set;
-	}
-	if (ma < 5) {
-		dev_err(bdpsy->dev,
-			"Requested current limit %u smaller than min (5mA)\n",
-			ma);
-		reg =3D MIN_CURR_LIMIT_SEL;
-		ret =3D -EINVAL;
-		goto set;
-	}
-
-	ret =3D linear_range_get_selector_low_array(current_limit_ranges,
-					ARRAY_SIZE(current_limit_ranges),
-					ma, &reg, &found);
-	if (ret) {
-		dev_err(bdpsy->dev, "Unsupported current limit %umA\n", ma);
-		reg =3D MIN_CURR_LIMIT_SEL;
-		goto set;
-	}
-	if (!found) {
-		/*
-		 * There was a gap in supported values and we hit it.
-		 * We found a smaller value from ranges and use it.
-		 * Warn user though.
-		 */
-		dev_warn(bdpsy->dev, "Unsupported current limit %umA\n", ma);
-	}
-
-set:
-	tmpret =3D regmap_update_bits(bdpsy->regmap,
-				    BD70528_REG_CHG_DCIN_ILIM,
-				    BD70528_MASK_CHG_DCIN_ILIM, reg);
-
-	if (!ret)
-		ret =3D tmpret;
-
-	return ret;
-}
-
-static int bd70528_charger_set_property(struct power_supply *psy,
-					enum power_supply_property psp,
-					const union power_supply_propval *val)
-{
-	struct bd70528_psy *bdpsy =3D power_supply_get_drvdata(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		return set_current_limit(bdpsy, val->intval / 1000);
-	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		return set_charge_current(bdpsy, val->intval / 1000);
-	default:
-		break;
-	}
-	return -EINVAL;
-}
-
-static const struct power_supply_desc bd70528_charger_desc =3D {
-	.name		=3D "bd70528-charger",
-	.type		=3D POWER_SUPPLY_TYPE_MAINS,
-	.properties	=3D bd70528_charger_props,
-	.num_properties	=3D ARRAY_SIZE(bd70528_charger_props),
-	.get_property	=3D bd70528_charger_get_property,
-	.set_property	=3D bd70528_charger_set_property,
-	.property_is_writeable	=3D bd70528_prop_is_writable,
-};
-
-static int bd70528_power_probe(struct platform_device *pdev)
-{
-	struct bd70528_psy *bdpsy;
-	struct power_supply_config cfg =3D {};
-
-	bdpsy =3D devm_kzalloc(&pdev->dev, sizeof(*bdpsy), GFP_KERNEL);
-	if (!bdpsy)
-		return -ENOMEM;
-
-	bdpsy->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
-	if (!bdpsy->regmap) {
-		dev_err(&pdev->dev, "No regmap found for chip\n");
-		return -EINVAL;
-	}
-	bdpsy->dev =3D &pdev->dev;
-
-	platform_set_drvdata(pdev, bdpsy);
-	cfg.drv_data =3D bdpsy;
-	cfg.of_node =3D pdev->dev.parent->of_node;
-
-	bdpsy->psy =3D devm_power_supply_register(&pdev->dev,
-						&bd70528_charger_desc, &cfg);
-	if (IS_ERR(bdpsy->psy)) {
-		dev_err(&pdev->dev, "failed: power supply register\n");
-		return PTR_ERR(bdpsy->psy);
-	}
-
-	return bd70528_get_irqs(pdev, bdpsy);
-}
-
-static struct platform_driver bd70528_power =3D {
-	.driver =3D {
-		.name =3D "bd70528-power"
-	},
-	.probe =3D bd70528_power_probe,
-};
-
-module_platform_driver(bd70528_power);
-
-MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD70528 power-supply driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bd70528-power");
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

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCszlMACgkQeFA3/03a
ocX/nwgAoIcuGRS2L5lm6nRUQWueNfKQOc9qRW11mbbNOICmqsmvgRtJYgBx/3VV
M5eB8D7ji3hWo/LK1ZfQOxiLM+ZIerPnD1kIPCiNxw9wm4TWo4Ug/LxBrnV1Th3S
EOWtxcAtrIZP7HXAc67Czfv+2rzi+RMJbpsFCwji6hKya/tIwplz7pL2maqCZ1tS
JUT3DsA9mnQPBhOQ+Fk3C47cCYLQAjnN3MpdjJjzV3thwoCav2h27aHEfKqq/GwU
VgT6BiNbflZZdwUqybav27t/VwIJ3LhRsntyXF+HauWR7Llju71auX+p8vBsSq69
n8dNMwS0X0SGMJFFrAMKGQVcRb4J0A==
=VlWh
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
