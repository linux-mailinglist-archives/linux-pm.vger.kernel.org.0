Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E897E38FEBC
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhEYKQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 06:16:32 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:37480 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhEYKQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 06:16:30 -0400
Received: by mail-lj1-f171.google.com with SMTP id e2so31045896ljk.4;
        Tue, 25 May 2021 03:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X3Flqbk9N3dsqYLyk7c8Z+BERCBUoCwwVjTZG6SrE5g=;
        b=knJ8AzM7va+2emGjrsf9F3lhgdH74bmDkAIatQQDR3uTpzfkcsYli3U5MmvOSpfcjt
         AHUpkyVpxoclEcwn+KjjyHWdYvnLO1UfUBsnDCXrn+xdmtoeumusQzx7ZBOQht0gyth1
         xD9mRjZg1sQcpKAVMrBF6+DOkqXyaBRBRc95/FS+wwgdVSf5QS9leoxyZNI9ogzyqeXm
         5d9IKROM7z0/Dw+3U6quQgU///uPbsVK3778u9q1qaCP1x/1CKgc/4e+96vUFeRaZKhA
         BOOqSrnx5mzOuNBqSX4kmwqs8IFdT9o1xrEx7STgzd00GK3JqAGZzFiD3H7qPFKILBBu
         qhHA==
X-Gm-Message-State: AOAM531u4c4QyWtWx+iQEJnjl0TpW1sKG6PiEVLs+0QrkU5uCt+4UmF2
        MCN4VhPxFV9/sxRp859k1eY=
X-Google-Smtp-Source: ABdhPJxClozAvfEvrjZBBBjFLXf3qSGrm14mTl1CaV3bTbYFSHrbE+uh8KjlfDkPmRC53djnV0f4OQ==
X-Received: by 2002:a2e:9708:: with SMTP id r8mr20085753lji.126.1621937698514;
        Tue, 25 May 2021 03:14:58 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id b6sm1690762lfb.114.2021.05.25.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:14:57 -0700 (PDT)
Date:   Tue, 25 May 2021 13:14:51 +0300
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
Subject: [PATCH 4/9] regulator: bd70528: Drop BD70528 support
Message-ID: <6b1668099cde29bc6fa958773a1a311df54ab236.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mP3DRpeJDSE+ciuQ
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
 drivers/regulator/Kconfig             |  11 -
 drivers/regulator/Makefile            |   1 -
 drivers/regulator/bd70528-regulator.c | 283 --------------------------
 3 files changed, 295 deletions(-)
 delete mode 100644 drivers/regulator/bd70528-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 9d84d9245490..ebbd9e6207df 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -193,17 +193,6 @@ config REGULATOR_BCM590XX
 	  BCM590xx PMUs. This will enable support for the software
 	  controllable LDO/Switching regulators.
=20
-config REGULATOR_BD70528
-	tristate "ROHM BD70528 Power Regulator"
-	depends on MFD_ROHM_BD70528
-	help
-	  This driver supports voltage regulators on ROHM BD70528 PMIC.
-	  This will enable support for the software controllable buck
-	  and LDO regulators.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called bd70528-regulator.
-
 config REGULATOR_BD71815
 	tristate "ROHM BD71815 Power Regulator"
 	depends on MFD_ROHM_BD71828
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 580b015296ea..6a5d55e209d3 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_REGULATOR_AS3722) +=3D as3722-regulator.o
 obj-$(CONFIG_REGULATOR_ATC260X) +=3D atc260x-regulator.o
 obj-$(CONFIG_REGULATOR_AXP20X) +=3D axp20x-regulator.o
 obj-$(CONFIG_REGULATOR_BCM590XX) +=3D bcm590xx-regulator.o
-obj-$(CONFIG_REGULATOR_BD70528) +=3D bd70528-regulator.o
 obj-$(CONFIG_REGULATOR_BD71815)	+=3D bd71815-regulator.o
 obj-$(CONFIG_REGULATOR_BD71828) +=3D bd71828-regulator.o
 obj-$(CONFIG_REGULATOR_BD718XX) +=3D bd718x7-regulator.o
diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70=
528-regulator.c
deleted file mode 100644
index 1f5f9482b209..000000000000
--- a/drivers/regulator/bd70528-regulator.c
+++ /dev/null
@@ -1,283 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 ROHM Semiconductors
-// bd70528-regulator.c ROHM BD70528MWV regulator driver
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/mfd/rohm-bd70528.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/of_regulator.h>
-#include <linux/slab.h>
-
-#define BUCK_RAMPRATE_250MV 0
-#define BUCK_RAMPRATE_125MV 1
-#define BUCK_RAMP_MAX 250
-
-static const struct linear_range bd70528_buck1_volts[] =3D {
-	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 600000),
-	REGULATOR_LINEAR_RANGE(2750000, 0x2, 0xf, 50000),
-};
-static const struct linear_range bd70528_buck2_volts[] =3D {
-	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 300000),
-	REGULATOR_LINEAR_RANGE(1550000, 0x2, 0xd, 50000),
-	REGULATOR_LINEAR_RANGE(3000000, 0xe, 0xf, 300000),
-};
-static const struct linear_range bd70528_buck3_volts[] =3D {
-	REGULATOR_LINEAR_RANGE(800000, 0x00, 0xd, 50000),
-	REGULATOR_LINEAR_RANGE(1800000, 0xe, 0xf, 0),
-};
-
-/* All LDOs have same voltage ranges */
-static const struct linear_range bd70528_ldo_volts[] =3D {
-	REGULATOR_LINEAR_RANGE(1650000, 0x0, 0x07, 50000),
-	REGULATOR_LINEAR_RANGE(2100000, 0x8, 0x0f, 100000),
-	REGULATOR_LINEAR_RANGE(2850000, 0x10, 0x19, 50000),
-	REGULATOR_LINEAR_RANGE(3300000, 0x19, 0x1f, 0),
-};
-
-/* Also both LEDs support same voltages */
-static const unsigned int led_volts[] =3D {
-	20000, 30000
-};
-
-static int bd70528_set_ramp_delay(struct regulator_dev *rdev, int ramp_del=
ay)
-{
-	if (ramp_delay > 0 && ramp_delay <=3D BUCK_RAMP_MAX) {
-		unsigned int ramp_value =3D BUCK_RAMPRATE_250MV;
-
-		if (ramp_delay <=3D 125)
-			ramp_value =3D BUCK_RAMPRATE_125MV;
-
-		return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
-				  BD70528_MASK_BUCK_RAMP,
-				  ramp_value << BD70528_SIFT_BUCK_RAMP);
-	}
-	dev_err(&rdev->dev, "%s: ramp_delay: %d not supported\n",
-		rdev->desc->name, ramp_delay);
-	return -EINVAL;
-}
-
-static int bd70528_led_set_voltage_sel(struct regulator_dev *rdev,
-				       unsigned int sel)
-{
-	int ret;
-
-	ret =3D regulator_is_enabled_regmap(rdev);
-	if (ret < 0)
-		return ret;
-
-	if (ret =3D=3D 0)
-		return regulator_set_voltage_sel_regmap(rdev, sel);
-
-	dev_err(&rdev->dev,
-		"LED voltage change not allowed when led is enabled\n");
-
-	return -EBUSY;
-}
-
-static const struct regulator_ops bd70528_buck_ops =3D {
-	.enable =3D regulator_enable_regmap,
-	.disable =3D regulator_disable_regmap,
-	.is_enabled =3D regulator_is_enabled_regmap,
-	.list_voltage =3D regulator_list_voltage_linear_range,
-	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
-	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
-	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
-	.set_ramp_delay =3D bd70528_set_ramp_delay,
-};
-
-static const struct regulator_ops bd70528_ldo_ops =3D {
-	.enable =3D regulator_enable_regmap,
-	.disable =3D regulator_disable_regmap,
-	.is_enabled =3D regulator_is_enabled_regmap,
-	.list_voltage =3D regulator_list_voltage_linear_range,
-	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
-	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
-	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
-};
-
-static const struct regulator_ops bd70528_led_ops =3D {
-	.enable =3D regulator_enable_regmap,
-	.disable =3D regulator_disable_regmap,
-	.is_enabled =3D regulator_is_enabled_regmap,
-	.list_voltage =3D regulator_list_voltage_table,
-	.set_voltage_sel =3D bd70528_led_set_voltage_sel,
-	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
-};
-
-static const struct regulator_desc bd70528_desc[] =3D {
-	{
-		.name =3D "buck1",
-		.of_match =3D of_match_ptr("BUCK1"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_BUCK1,
-		.ops =3D &bd70528_buck_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.linear_ranges =3D bd70528_buck1_volts,
-		.n_linear_ranges =3D ARRAY_SIZE(bd70528_buck1_volts),
-		.n_voltages =3D BD70528_BUCK_VOLTS,
-		.enable_reg =3D BD70528_REG_BUCK1_EN,
-		.enable_mask =3D BD70528_MASK_RUN_EN,
-		.vsel_reg =3D BD70528_REG_BUCK1_VOLT,
-		.vsel_mask =3D BD70528_MASK_BUCK_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-	{
-		.name =3D "buck2",
-		.of_match =3D of_match_ptr("BUCK2"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_BUCK2,
-		.ops =3D &bd70528_buck_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.linear_ranges =3D bd70528_buck2_volts,
-		.n_linear_ranges =3D ARRAY_SIZE(bd70528_buck2_volts),
-		.n_voltages =3D BD70528_BUCK_VOLTS,
-		.enable_reg =3D BD70528_REG_BUCK2_EN,
-		.enable_mask =3D BD70528_MASK_RUN_EN,
-		.vsel_reg =3D BD70528_REG_BUCK2_VOLT,
-		.vsel_mask =3D BD70528_MASK_BUCK_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-	{
-		.name =3D "buck3",
-		.of_match =3D of_match_ptr("BUCK3"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_BUCK3,
-		.ops =3D &bd70528_buck_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.linear_ranges =3D bd70528_buck3_volts,
-		.n_linear_ranges =3D ARRAY_SIZE(bd70528_buck3_volts),
-		.n_voltages =3D BD70528_BUCK_VOLTS,
-		.enable_reg =3D BD70528_REG_BUCK3_EN,
-		.enable_mask =3D BD70528_MASK_RUN_EN,
-		.vsel_reg =3D BD70528_REG_BUCK3_VOLT,
-		.vsel_mask =3D BD70528_MASK_BUCK_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-	{
-		.name =3D "ldo1",
-		.of_match =3D of_match_ptr("LDO1"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_LDO1,
-		.ops =3D &bd70528_ldo_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.linear_ranges =3D bd70528_ldo_volts,
-		.n_linear_ranges =3D ARRAY_SIZE(bd70528_ldo_volts),
-		.n_voltages =3D BD70528_LDO_VOLTS,
-		.enable_reg =3D BD70528_REG_LDO1_EN,
-		.enable_mask =3D BD70528_MASK_RUN_EN,
-		.vsel_reg =3D BD70528_REG_LDO1_VOLT,
-		.vsel_mask =3D BD70528_MASK_LDO_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-	{
-		.name =3D "ldo2",
-		.of_match =3D of_match_ptr("LDO2"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_LDO2,
-		.ops =3D &bd70528_ldo_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.linear_ranges =3D bd70528_ldo_volts,
-		.n_linear_ranges =3D ARRAY_SIZE(bd70528_ldo_volts),
-		.n_voltages =3D BD70528_LDO_VOLTS,
-		.enable_reg =3D BD70528_REG_LDO2_EN,
-		.enable_mask =3D BD70528_MASK_RUN_EN,
-		.vsel_reg =3D BD70528_REG_LDO2_VOLT,
-		.vsel_mask =3D BD70528_MASK_LDO_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-	{
-		.name =3D "ldo3",
-		.of_match =3D of_match_ptr("LDO3"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_LDO3,
-		.ops =3D &bd70528_ldo_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.linear_ranges =3D bd70528_ldo_volts,
-		.n_linear_ranges =3D ARRAY_SIZE(bd70528_ldo_volts),
-		.n_voltages =3D BD70528_LDO_VOLTS,
-		.enable_reg =3D BD70528_REG_LDO3_EN,
-		.enable_mask =3D BD70528_MASK_RUN_EN,
-		.vsel_reg =3D BD70528_REG_LDO3_VOLT,
-		.vsel_mask =3D BD70528_MASK_LDO_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-	{
-		.name =3D "ldo_led1",
-		.of_match =3D of_match_ptr("LDO_LED1"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_LED1,
-		.ops =3D &bd70528_led_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.volt_table =3D &led_volts[0],
-		.n_voltages =3D ARRAY_SIZE(led_volts),
-		.enable_reg =3D BD70528_REG_LED_EN,
-		.enable_mask =3D BD70528_MASK_LED1_EN,
-		.vsel_reg =3D BD70528_REG_LED_VOLT,
-		.vsel_mask =3D BD70528_MASK_LED1_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-	{
-		.name =3D "ldo_led2",
-		.of_match =3D of_match_ptr("LDO_LED2"),
-		.regulators_node =3D of_match_ptr("regulators"),
-		.id =3D BD70528_LED2,
-		.ops =3D &bd70528_led_ops,
-		.type =3D REGULATOR_VOLTAGE,
-		.volt_table =3D &led_volts[0],
-		.n_voltages =3D ARRAY_SIZE(led_volts),
-		.enable_reg =3D BD70528_REG_LED_EN,
-		.enable_mask =3D BD70528_MASK_LED2_EN,
-		.vsel_reg =3D BD70528_REG_LED_VOLT,
-		.vsel_mask =3D BD70528_MASK_LED2_VOLT,
-		.owner =3D THIS_MODULE,
-	},
-
-};
-
-static int bd70528_probe(struct platform_device *pdev)
-{
-	int i;
-	struct regulator_config config =3D {
-		.dev =3D pdev->dev.parent,
-	};
-
-	config.regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
-	if (!config.regmap)
-		return -ENODEV;
-
-	for (i =3D 0; i < ARRAY_SIZE(bd70528_desc); i++) {
-		struct regulator_dev *rdev;
-
-		rdev =3D devm_regulator_register(&pdev->dev, &bd70528_desc[i],
-					       &config);
-		if (IS_ERR(rdev)) {
-			dev_err(&pdev->dev,
-				"failed to register %s regulator\n",
-				bd70528_desc[i].name);
-			return PTR_ERR(rdev);
-		}
-	}
-	return 0;
-}
-
-static struct platform_driver bd70528_regulator =3D {
-	.driver =3D {
-		.name =3D "bd70528-pmic"
-	},
-	.probe =3D bd70528_probe,
-};
-
-module_platform_driver(bd70528_regulator);
-
-MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_DESCRIPTION("BD70528 voltage regulator driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bd70528-pmic");
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

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCszhsACgkQeFA3/03a
ocXkUQf+JIw46Hi7fPEjIHJMMJ7+btFycYzQ9fNQLl3X7LKhbJsgJRyZWRhwwQoE
VVw8knnTy+RXY8XrTsW8ZowdrIe3RQLSo9jIkx1XQZvMMA3OF4B3g5h1sPIh8dgZ
SJyTdvOaxLXqI5YovXtQ7NVV1JelY0DoQylOLZ7b9LtCCRUOPzB/RKAV4vD6aQtB
aRlsLEEE978+2E+uLJhm8IwEcVSf/5v4Ox5KJrtxnTFkzoQEQxKkTB5dLKdY2zta
Vuvl8y0fM9UYdNJ7ixwaXD/Q4AC9zXX1on7KXA/jGr9RiEaRER29odsVPHnmm5FF
BVdZzWsl1y6gz+gleWvnixP4eKtG3g==
=AEYx
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
