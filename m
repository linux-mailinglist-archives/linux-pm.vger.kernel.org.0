Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643632974
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfFCH1C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 03:27:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39909 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFCH1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 03:27:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so11914433ljf.6;
        Mon, 03 Jun 2019 00:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFyxduXnbY7SIA82GtnRidm/PysbW69UgImcJp3ziGU=;
        b=i/pshGum1H2h30+xIFE55+3jr2IxlLht9Byft6fgi5QvPA2yX2FdsligzX6UDTTvzf
         e5slNAaxbj/mNsGwtFSciSlu1JriYxvtmv8tFhM3EaS+lmL8GRyMtDUk28El72hOZFBA
         OK5F2GP72FDbaQUaSFhd3+iPkhNGhOcN6wg9jmmEcfUs1ROQBKEElRbfa4aiaP+qVjcy
         2zhX8YyhrO4O43RBnrrmXKsrOUwJEIhLu4f4uNWth0wuflp1FJUoWczeqn44DY/sb9Uv
         /CwqCaB2wbDV+pJtK03t0QwLGFkYgLGkmnmPeefyukc1EvAk/qMlQxxx8/Xb4GSky8sy
         bwnw==
X-Gm-Message-State: APjAAAV4AamrcpuPjEh/WawBTrTsSFygxt0OYLCt5vcoALOJF6J9OCYE
        vW9SBjDkhq3SHzgbMGCbh24=
X-Google-Smtp-Source: APXvYqxkDkuoD1WiaDtEdArEsxb/2WFyEqZtJHNOpEK+GsRQxaOlN9hQLnrCMc+DXNuFw3FlxfSttA==
X-Received: by 2002:a2e:5b52:: with SMTP id p79mr13092362ljb.208.1559546818466;
        Mon, 03 Jun 2019 00:26:58 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c5sm2992449lfm.7.2019.06.03.00.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 00:26:57 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:26:45 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v15 5/7] gpio: Initial support for ROHM bd70528 GPIO block
Message-ID: <d094ec315e08f6b25b38b285763bebf24b147433.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
controlled by GPIO framework.

IRQs are handled by regmap-irq and GPIO driver is not
aware of the irq usage.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Unchanged from v14

 drivers/gpio/Kconfig        |  11 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-bd70528.c | 232 ++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/gpio/gpio-bd70528.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index acd40eb51c46..cc2f2e495925 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -979,6 +979,17 @@ config GPIO_ARIZONA
 	help
 	  Support for GPIOs on Wolfson Arizona class devices.
 
+config GPIO_BD70528
+	tristate "ROHM BD70528 GPIO support"
+	depends on MFD_ROHM_BD70528
+	help
+	  Support for GPIOs on ROHM BD70528 PMIC. There are four GPIOs
+	  available on the ROHM PMIC in total. The GPIOs can also
+	  generate interrupts.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called gpio-bd70528.
+
 config GPIO_BD9571MWV
 	tristate "ROHM BD9571 GPIO support"
 	depends on MFD_BD9571MWV
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 6700eee860b7..10efc4f743fe 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
 obj-$(CONFIG_GPIO_RASPBERRYPI_EXP)	+= gpio-raspberrypi-exp.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
+obj-$(CONFIG_GPIO_BD70528) 	+= gpio-bd70528.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
diff --git a/drivers/gpio/gpio-bd70528.c b/drivers/gpio/gpio-bd70528.c
new file mode 100644
index 000000000000..fd85605d2dab
--- /dev/null
+++ b/drivers/gpio/gpio-bd70528.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// gpio-bd70528.c ROHM BD70528MWV gpio driver
+
+#include <linux/gpio/driver.h>
+#include <linux/mfd/rohm-bd70528.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define GPIO_IN_REG(offset) (BD70528_REG_GPIO1_IN + (offset) * 2)
+#define GPIO_OUT_REG(offset) (BD70528_REG_GPIO1_OUT + (offset) * 2)
+
+struct bd70528_gpio {
+	struct rohm_regmap_dev chip;
+	struct gpio_chip gpio;
+};
+
+static int bd70528_set_debounce(struct bd70528_gpio *bdgpio,
+				unsigned int offset, unsigned int debounce)
+{
+	u8 val;
+
+	switch (debounce) {
+	case 0:
+		val = BD70528_DEBOUNCE_DISABLE;
+		break;
+	case 1 ... 15:
+		val = BD70528_DEBOUNCE_15MS;
+		break;
+	case 16 ... 30:
+		val = BD70528_DEBOUNCE_30MS;
+		break;
+	case 31 ... 50:
+		val = BD70528_DEBOUNCE_50MS;
+		break;
+	default:
+		dev_err(bdgpio->chip.dev,
+			"Invalid debouce value %u\n", debounce);
+		return -EINVAL;
+	}
+	return regmap_update_bits(bdgpio->chip.regmap, GPIO_IN_REG(offset),
+				 BD70528_DEBOUNCE_MASK, val);
+}
+
+static int bd70528_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+	int val, ret;
+
+	/* Do we need to do something to IRQs here? */
+	ret = regmap_read(bdgpio->chip.regmap, GPIO_OUT_REG(offset), &val);
+	if (ret) {
+		dev_err(bdgpio->chip.dev, "Could not read gpio direction\n");
+		return ret;
+	}
+
+	return !(val & BD70528_GPIO_OUT_EN_MASK);
+}
+
+static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+				   unsigned long config)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return regmap_update_bits(bdgpio->chip.regmap,
+					  GPIO_OUT_REG(offset),
+					  BD70528_GPIO_DRIVE_MASK,
+					  BD70528_GPIO_OPEN_DRAIN);
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return regmap_update_bits(bdgpio->chip.regmap,
+					  GPIO_OUT_REG(offset),
+					  BD70528_GPIO_DRIVE_MASK,
+					  BD70528_GPIO_PUSH_PULL);
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		return bd70528_set_debounce(bdgpio, offset,
+					    pinconf_to_config_argument(config));
+		break;
+	default:
+		break;
+	}
+	return -ENOTSUPP;
+}
+
+static int bd70528_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	/* Do we need to do something to IRQs here? */
+	return regmap_update_bits(bdgpio->chip.regmap, GPIO_OUT_REG(offset),
+				 BD70528_GPIO_OUT_EN_MASK,
+				 BD70528_GPIO_OUT_DISABLE);
+}
+
+static void bd70528_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			     int value)
+{
+	int ret;
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+	u8 val = (value) ? BD70528_GPIO_OUT_HI : BD70528_GPIO_OUT_LO;
+
+	ret = regmap_update_bits(bdgpio->chip.regmap, GPIO_OUT_REG(offset),
+				 BD70528_GPIO_OUT_MASK, val);
+	if (ret)
+		dev_err(bdgpio->chip.dev, "Could not set gpio to %d\n", value);
+}
+
+static int bd70528_direction_output(struct gpio_chip *chip, unsigned int offset,
+				    int value)
+{
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	bd70528_gpio_set(chip, offset, value);
+	return regmap_update_bits(bdgpio->chip.regmap, GPIO_OUT_REG(offset),
+				 BD70528_GPIO_OUT_EN_MASK,
+				 BD70528_GPIO_OUT_ENABLE);
+}
+
+#define GPIO_IN_STATE_MASK(offset) (BD70528_GPIO_IN_STATE_BASE << (offset))
+
+static int bd70528_gpio_get_o(struct bd70528_gpio *bdgpio, unsigned int offset)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(bdgpio->chip.regmap, GPIO_OUT_REG(offset), &val);
+	if (!ret)
+		ret = !!(val & BD70528_GPIO_OUT_MASK);
+	else
+		dev_err(bdgpio->chip.dev, "GPIO (out) state read failed\n");
+
+	return ret;
+}
+
+static int bd70528_gpio_get_i(struct bd70528_gpio *bdgpio, unsigned int offset)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(bdgpio->chip.regmap, BD70528_REG_GPIO_STATE, &val);
+
+	if (!ret)
+		ret = !(val & GPIO_IN_STATE_MASK(offset));
+	else
+		dev_err(bdgpio->chip.dev, "GPIO (in) state read failed\n");
+
+	return ret;
+}
+
+static int bd70528_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	int ret = -EINVAL;
+	struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
+
+	/*
+	 * There is a race condition where someone might be changing the
+	 * GPIO direction after we get it but before we read the value. But
+	 * application design where GPIO direction may be changed just when
+	 * we read GPIO value would be pointless as reader could not know
+	 * whether the returned high/low state is caused by input or output.
+	 * Or then there must be other ways to mitigate the issue. Thus
+	 * locking would make no sense.
+	 */
+	ret = bd70528_get_direction(chip, offset);
+	if (ret == 0)
+		ret = bd70528_gpio_get_o(bdgpio, offset);
+	else if (ret == 1)
+		ret = bd70528_gpio_get_i(bdgpio, offset);
+	else
+		dev_err(bdgpio->chip.dev, "failed to read GPIO direction\n");
+
+	return ret;
+}
+
+static int bd70528_probe(struct platform_device *pdev)
+{
+	struct bd70528_gpio *bdgpio;
+	struct rohm_regmap_dev *bd70528;
+	int ret;
+
+	bd70528 = dev_get_drvdata(pdev->dev.parent);
+	if (!bd70528) {
+		dev_err(&pdev->dev, "No MFD driver data\n");
+		return -EINVAL;
+	}
+
+	bdgpio = devm_kzalloc(&pdev->dev, sizeof(*bdgpio),
+			      GFP_KERNEL);
+	if (!bdgpio)
+		return -ENOMEM;
+	bdgpio->chip.dev = &pdev->dev;
+	bdgpio->gpio.parent = pdev->dev.parent;
+	bdgpio->gpio.label = "bd70528-gpio";
+	bdgpio->gpio.owner = THIS_MODULE;
+	bdgpio->gpio.get_direction = bd70528_get_direction;
+	bdgpio->gpio.direction_input = bd70528_direction_input;
+	bdgpio->gpio.direction_output = bd70528_direction_output;
+	bdgpio->gpio.set_config = bd70528_gpio_set_config;
+	bdgpio->gpio.can_sleep = true;
+	bdgpio->gpio.get = bd70528_gpio_get;
+	bdgpio->gpio.set = bd70528_gpio_set;
+	bdgpio->gpio.ngpio = 4;
+	bdgpio->gpio.base = -1;
+#ifdef CONFIG_OF_GPIO
+	bdgpio->gpio.of_node = pdev->dev.parent->of_node;
+#endif
+	bdgpio->chip.regmap = bd70528->regmap;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &bdgpio->gpio,
+				     bdgpio);
+	if (ret)
+		dev_err(&pdev->dev, "gpio_init: Failed to add bd70528-gpio\n");
+
+	return ret;
+}
+
+static struct platform_driver bd70528_gpio = {
+	.driver = {
+		.name = "bd70528-gpio"
+	},
+	.probe = bd70528_probe,
+};
+
+module_platform_driver(bd70528_gpio);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD70528 voltage regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.17.2


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
