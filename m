Return-Path: <linux-pm+bounces-36901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F9C0D488
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CB704F6A7C
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A02FE590;
	Mon, 27 Oct 2025 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Wcb7Uj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3142FE597
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565656; cv=none; b=ln+yE9DGCc/lPVZTo/PK7PEzpzI9EkuZMEQ/LTYGfsVAM7So6ioSaKOZyL1zRVZVSfKoyCZ14p58s0AV2ZUlwYDenq8SWePRUIsUk3vB0xjq0dpMOaLrkTNMZpJpa0YTJwAEOhHUYeSc2zOlTcH72q3aM3Zxtd4+WhsbibzGQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565656; c=relaxed/simple;
	bh=K++ll1VTkwruhtw6iyV0wIyUmmctkkdXBo+Q4QF+560=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlTmPUWs2qWJCtC/1i8ctXgsjJNVhD81a8jtC3T0ToBYJbimMYfD8YTA/t5dOr4t4eKP56O+J4aNI2wdONBSUzMgTAFx2wtogh0ibeRG7uRKCSDkR+EuVs0q9mgfC1q+GBpbjtCiJmDYggvA1/isskDhmuzixCMvYBG/y0a8mf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Wcb7Uj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-591ec7af7a1so4744280e87.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761565651; x=1762170451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGZar//OHB0kzx5ytf2aEh0Z+ClSARP8AL09TkALmmY=;
        b=I2Wcb7Uj7i65om1NvtpTrPgZeWF/TT0LwjVCLtsxm7OTZFjMHSdqEZ0Qje+S5poZn+
         AGe8oS1j5OIeZsHViAe8peUh/e6hpTt9UqC7nXWDTAkLIimIgaRXo1MqxUcUhMFCiUJH
         /DR4qAdRaTyADM/FKGSz/fPBN9jPLpFAplKkIk98Ajj5KXEMH+ml2zuddUdGiCxWkpB1
         tRRY76tA3ef5i2T/X8oiryavJ4nQxkqhKiLn11oaMV/ZLdVyHdTxX/UucmOD1m55kDzF
         dC0hdyjn21iIsvb7Xie+HiGVZtOIea9sISqIBC+TwCJweTZNk8XeDmpKlDrIQo4x5HQk
         6ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761565651; x=1762170451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGZar//OHB0kzx5ytf2aEh0Z+ClSARP8AL09TkALmmY=;
        b=ZQL9r2heQltU5aaPzO/XjYpZN8DmPOpYqByaQsMDBidc+maNjVH+WyPkBoNp7KbGgU
         n7MLzuWEUNCjUi8q1gUBtspcwL2E3uIFG+SelmtuifPh4Ng9CyCuozOcvzqD1Dyhdm5H
         lDWSJwSXigCwTKhZinU37tS3G893aesEWhMoLZZ8yWGWKZL2Tu2AfA8LA2upJZSz5D9D
         Qt2QQTL+sZh29TYY++ts1ELLIIBWQvg8MVlWgwZvlElfm66Qm7BLn9PTbAWcF6gpMQTY
         UPh3n3T0C3XnMeuhxnR6FplsP9kyEFkf55QXv8YqrTzgRaA44eaD/GrAbd2wQo0tEGhP
         M1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW/YxKxKrNpQ4NUswBwt+Mm1l8orfW0dBGSvlQmzstdGBJLfwYtNYbbTDSt50M9AoMdkQL9m/T5Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU90AlBlCFvTiPaT+VeEIutECfsQiUQyxXe42jmVi1zihUPnwK
	Ya8xs4m1o/GpUFZrt8oYOBwSOkcVJEEaOcq05Rokx76fX3UQDtfPTUPk
X-Gm-Gg: ASbGncvaBGUZ/rBA89bzGGrFurrReK5+Vdf4Ef6DYZBY7+U16mEeXY85sj+HsQHzKph
	Fil1mn1PM2cz7z/qkb60LzQ5JIz4LPwSr8Fq0eRPV6+hoJikFSIdfSIie/lzBuEmZX8QTDw5/Gi
	ZnLG+aMra9+w3aCrUfJKshi++6vrIySeX8QcWBx/fpwy7pd1LqMI1MhdoKFfVQIDk4e20OdHtHU
	siMTiiJB9WhIx9+Vy+aj61Wvx7ULTWDiZZVTkOe58IFzfnkdWUPZk7tUBP/Lxt5tuUIlRJJbjbW
	23yYDFDJvkTEWQbIakQh9hjLiVQlFBSlwbYycWjCpX/5bYug395bppo8OXGdV7q0uKJ1nUlI2vC
	TWv9QmkQ5V12jQW0J4QVPnDr3FLzBpadpQ5rZINhaYKwEIAhyUvhnfd8EEFvgGqYIAh0IhQbMxH
	0o+/JpSxY=
X-Google-Smtp-Source: AGHT+IESW+vCWcbsBvRwjY6wYKTNoMW4c6KJC1do8XcYzr9fNstVvSOI+Lz5dXiwbcSJoCgwR7QRrg==
X-Received: by 2002:a05:6512:31d0:b0:58b:23e:249 with SMTP id 2adb3069b0e04-591d8506a26mr11834655e87.18.1761565651150;
        Mon, 27 Oct 2025 04:47:31 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f60cafsm2249289e87.63.2025.10.27.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:47:30 -0700 (PDT)
Date: Mon, 27 Oct 2025 13:47:25 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Kemnade <andreas@kemnade.info>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 10/15] gpio: Support ROHM BD72720 gpios
Message-ID: <a85536d25b9e7a9b02b5fce2db44ee47ac7244b5.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pP44LjMFfDxyfF3H"
Content-Disposition: inline
In-Reply-To: <cover.1761564043.git.mazziesaccount@gmail.com>


--pP44LjMFfDxyfF3H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD72720 has 6 pins which may be configured as GPIOs. The
GPIO1 ... GPIO5 and EPDEN pins. The configuration is done to OTP at the
manufacturing, and it can't be read at runtime. The device-tree is
required to tell the software which of the pins are used as GPIOs.

Keep the pin mapping static regardless the OTP. This way the user-space
can always access the BASE+N for GPIO(N+1) (N =3D 0 to 4), and BASE + 5
for the EPDEN pin. Do this by setting always the number of GPIOs to 6,
and by using the valid-mask to invalidate the pins which aren't configured
as GPIOs.

First two pins can be set to be either input or output by OTP. Direction
can't be changed by software. Rest of the pins can be set as outputs
only. All of the pins support generating interrupts.

Support the Input/Output state getting/setting and the output mode
configuration (open-drain/push-pull).

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

---
Revision history:
 RFCv1 =3D> :
 - No changes
---
 drivers/gpio/Kconfig        |   9 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-bd72720.c | 281 ++++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+)
 create mode 100644 drivers/gpio/gpio-bd72720.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7ee3afbc2b05..0c612c5163c5 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1319,6 +1319,15 @@ config GPIO_BD71828
 	  This driver can also be built as a module. If so, the module
 	  will be called gpio-bd71828.
=20
+config GPIO_BD72720
+	tristate "ROHM BD72720 and BD73900 PMIC GPIO support"
+	depends on MFD_ROHM_BD71828
+	help
+	  Support for GPIO on ROHM BD72720 and BD73900 PMICs. There are two
+	  pins which can be configured to GPI or GPO, and three pins which can
+	  be configured to GPO on the ROHM PMIC. The pin configuration is done
+	  on OTP at manufacturing.
+
 config GPIO_BD9571MWV
 	tristate "ROHM BD9571 GPIO support"
 	depends on MFD_BD9571MWV
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index ec296fa14bfd..7a5d03db3021 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_GPIO_BCM_KONA)		+=3D gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BCM_XGS_IPROC)	+=3D gpio-xgs-iproc.o
 obj-$(CONFIG_GPIO_BD71815)		+=3D gpio-bd71815.o
 obj-$(CONFIG_GPIO_BD71828)		+=3D gpio-bd71828.o
+obj-$(CONFIG_GPIO_BD72720)		+=3D gpio-bd72720.o
 obj-$(CONFIG_GPIO_BD9571MWV)		+=3D gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BLZP1600)		+=3D gpio-blzp1600.o
 obj-$(CONFIG_GPIO_BRCMSTB)		+=3D gpio-brcmstb.o
diff --git a/drivers/gpio/gpio-bd72720.c b/drivers/gpio/gpio-bd72720.c
new file mode 100644
index 000000000000..6549dbf4c7ad
--- /dev/null
+++ b/drivers/gpio/gpio-bd72720.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support to GPIOs on ROHM BD72720 and BD79300
+ * Copyright 2025 ROHM Semiconductors.
+ * Author: Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/rohm-bd72720.h>
+
+#define BD72720_GPIO_OPEN_DRAIN		0
+#define BD72720_GPIO_CMOS		BIT(1)
+#define BD72720_INT_GPIO1_IN_SRC	4
+/*
+ * The BD72720 has several "one time programmable" (OTP) configurations wh=
ich
+ * can be set at manufacturing phase. A set of these options allow using p=
ins
+ * as GPIO. The OTP configuration can't be read at run-time, so drivers re=
ly on
+ * device-tree to advertise the correct options.
+ *
+ * Both DVS[0,1] pins can be configured to be used for:
+ *  - OTP0: regulator RUN state control
+ *  - OTP1: GPI
+ *  - OTP2: GPO
+ *  - OTP3: Power sequencer output
+ *  Data-sheet also states that these PINs can always be used for IRQ but =
the
+ *  driver limits this by allowing them to be used for IRQs with OTP1 only.
+ *
+ * Pins GPIO_EXTEN0 (GPIO3), GPIO_EXTEN1 (GPIO4), GPIO_FAULT_B (GPIO5) hav=
e OTP
+ * options for a specific (non GPIO) purposes, but also an option to confi=
gure
+ * them to be used as a GPO.
+ *
+ * OTP settings can be separately configured for each pin.
+ *
+ * DT properties:
+ * "rohm,pin-dvs0" and "rohm,pin-dvs1" can be set to one of the values:
+ * "dvs-input", "gpi", "gpo".
+ *
+ * "rohm,pin-exten0", "rohm,pin-exten1" and "rohm,pin-fault_b" can be set =
to:
+ * "gpo"
+ */
+
+enum bd72720_gpio_state {
+	BD72720_PIN_UNKNOWN,
+	BD72720_PIN_GPI,
+	BD72720_PIN_GPO,
+};
+
+enum {
+	BD72720_GPIO1,
+	BD72720_GPIO2,
+	BD72720_GPIO3,
+	BD72720_GPIO4,
+	BD72720_GPIO5,
+	BD72720_GPIO_EPDEN,
+	BD72720_NUM_GPIOS
+};
+
+struct bd72720_gpio {
+	/* chip.parent points the MFD which provides DT node and regmap */
+	struct gpio_chip chip;
+	/* dev points to the platform device for devm and prints */
+	struct device *dev;
+	struct regmap *regmap;
+	int gpio_is_input;
+};
+
+static int bd72720gpi_get(struct bd72720_gpio *bdgpio, unsigned int reg_of=
fset)
+{
+	int ret, val, shift;
+
+	ret =3D regmap_read(bdgpio->regmap, BD72720_REG_INT_ETC1_SRC, &val);
+	if (ret)
+		return ret;
+
+	shift =3D BD72720_INT_GPIO1_IN_SRC + reg_offset;
+
+	return (val >> shift) & 1;
+}
+
+static int bd72720gpo_get(struct bd72720_gpio *bdgpio,
+			  unsigned int offset)
+{
+	const int regs[] =3D { BD72720_REG_GPIO1_CTRL, BD72720_REG_GPIO2_CTRL,
+			     BD72720_REG_GPIO3_CTRL, BD72720_REG_GPIO4_CTRL,
+			     BD72720_REG_GPIO5_CTRL, BD72720_REG_EPDEN_CTRL };
+	int ret, val;
+
+	ret =3D regmap_read(bdgpio->regmap, regs[offset], &val);
+	if (ret)
+		return ret;
+
+	return val & BD72720_GPIO_HIGH;
+}
+
+static int bd72720gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct bd72720_gpio *bdgpio =3D gpiochip_get_data(chip);
+
+	if (BIT(offset) & bdgpio->gpio_is_input)
+		return bd72720gpi_get(bdgpio, offset);
+
+	return bd72720gpo_get(bdgpio, offset);
+}
+
+static int bd72720gpo_set(struct gpio_chip *chip, unsigned int offset,
+			  int value)
+{
+	struct bd72720_gpio *bdgpio =3D gpiochip_get_data(chip);
+	const int regs[] =3D { BD72720_REG_GPIO1_CTRL, BD72720_REG_GPIO2_CTRL,
+			     BD72720_REG_GPIO3_CTRL, BD72720_REG_GPIO4_CTRL,
+			     BD72720_REG_GPIO5_CTRL, BD72720_REG_EPDEN_CTRL };
+
+	if (BIT(offset) & bdgpio->gpio_is_input) {
+		dev_dbg(bdgpio->dev, "pin %d not output.\n", offset);
+		return -EINVAL;
+	}
+
+	if (value)
+		return regmap_set_bits(bdgpio->regmap, regs[offset],
+				      BD72720_GPIO_HIGH);
+
+	return regmap_clear_bits(bdgpio->regmap, regs[offset],
+					BD72720_GPIO_HIGH);
+}
+
+static int bd72720_gpio_set_config(struct gpio_chip *chip, unsigned int of=
fset,
+				   unsigned long config)
+{
+	struct bd72720_gpio *bdgpio =3D gpiochip_get_data(chip);
+	const int regs[] =3D { BD72720_REG_GPIO1_CTRL, BD72720_REG_GPIO2_CTRL,
+			     BD72720_REG_GPIO3_CTRL, BD72720_REG_GPIO4_CTRL,
+			     BD72720_REG_GPIO5_CTRL, BD72720_REG_EPDEN_CTRL };
+
+	/*
+	 * We can only set the output mode, which makes sense only when output
+	 * OTP configuration is used.
+	 */
+	if (BIT(offset) & bdgpio->gpio_is_input)
+		return -ENOTSUPP;
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		return regmap_update_bits(bdgpio->regmap,
+					  regs[offset],
+					  BD72720_GPIO_DRIVE_MASK,
+					  BD72720_GPIO_OPEN_DRAIN);
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return regmap_update_bits(bdgpio->regmap,
+					  regs[offset],
+					  BD72720_GPIO_DRIVE_MASK,
+					  BD72720_GPIO_CMOS);
+	default:
+		break;
+	}
+
+	return -ENOTSUPP;
+}
+
+static int bd72720gpo_direction_get(struct gpio_chip *chip,
+				    unsigned int offset)
+{
+	struct bd72720_gpio *bdgpio =3D gpiochip_get_data(chip);
+
+	if (BIT(offset) & bdgpio->gpio_is_input)
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int bd72720_valid_mask(struct gpio_chip *gc,
+			      unsigned long *valid_mask,
+			      unsigned int ngpios)
+{
+	static const char * const properties[] =3D {
+		"rohm,pin-dvs0", "rohm,pin-dvs1", "rohm,pin-exten0",
+		"rohm,pin-exten1", "rohm,pin-fault_b"
+	};
+	struct bd72720_gpio *g =3D gpiochip_get_data(gc);
+	const char *val;
+	int i, ret;
+
+	*valid_mask =3D BIT(BD72720_GPIO_EPDEN);
+
+	if (!gc->parent)
+		return 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(properties); i++) {
+		ret =3D fwnode_property_read_string(dev_fwnode(gc->parent),
+						  properties[i], &val);
+
+		if (ret) {
+			if (ret =3D=3D -EINVAL)
+				continue;
+
+			dev_err(g->dev, "pin %d (%s), bad configuration\n", i,
+				properties[i]);
+
+			return ret;
+		}
+
+		if (strcmp(val, "gpi") =3D=3D 0) {
+			if (i !=3D BD72720_GPIO1 && i !=3D BD72720_GPIO2) {
+				dev_warn(g->dev,
+					 "pin %d (%s) does not support INPUT mode",
+					 i, properties[i]);
+				continue;
+			}
+
+			*valid_mask |=3D BIT(i);
+			g->gpio_is_input |=3D BIT(i);
+		} else if (strcmp(val, "gpo") =3D=3D 0) {
+			*valid_mask |=3D BIT(i);
+		}
+	}
+
+	return 0;
+}
+
+/* Template for GPIO chip */
+static const struct gpio_chip bd72720gpo_chip =3D {
+	.label			=3D "bd72720",
+	.owner			=3D THIS_MODULE,
+	.get			=3D bd72720gpio_get,
+	.get_direction		=3D bd72720gpo_direction_get,
+	.set			=3D bd72720gpo_set,
+	.set_config		=3D bd72720_gpio_set_config,
+	.init_valid_mask	=3D bd72720_valid_mask,
+	.can_sleep		=3D true,
+	.ngpio			=3D BD72720_NUM_GPIOS,
+	.base			=3D -1,
+};
+
+static int gpo_bd72720_probe(struct platform_device *pdev)
+{
+	struct bd72720_gpio *g;
+	struct device *parent, *dev;
+
+	/*
+	 * Bind devm lifetime to this platform device =3D> use dev for devm.
+	 * also the prints should originate from this device.
+	 */
+	dev =3D &pdev->dev;
+	/* The device-tree and regmap come from MFD =3D> use parent for that */
+	parent =3D dev->parent;
+
+	g =3D devm_kzalloc(dev, sizeof(*g), GFP_KERNEL);
+	if (!g)
+		return -ENOMEM;
+
+	g->chip =3D bd72720gpo_chip;
+	g->dev =3D dev;
+	g->chip.parent =3D parent;
+	g->regmap =3D dev_get_regmap(parent, NULL);
+
+	return devm_gpiochip_add_data(dev, &g->chip, g);
+}
+
+static const struct platform_device_id bd72720_gpio_id[] =3D {
+	{ "bd72720-gpio" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, bd72720_gpio_id);
+
+static struct platform_driver gpo_bd72720_driver =3D {
+	.driver =3D {
+		.name =3D "bd72720-gpio",
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe =3D gpo_bd72720_probe,
+	.id_table =3D bd72720_gpio_id,
+};
+module_platform_driver(gpo_bd72720_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("GPIO interface for BD72720 and BD73900");
+MODULE_LICENSE("GPL");
--=20
2.51.0


--pP44LjMFfDxyfF3H
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/W80ACgkQeFA3/03a
ocUp3wf+PFsO2puwfMDS38sf+sWr8uUhdhFKcuuptYbO5oz45sOPu5LiP32iI5jW
1idVX7KNkmLT5CFnF9QnsBIcV//SnvGlrTnGLhCf4U1TaYY/kYXS5gV+kfxExgvJ
CVixnigi1D4pk76eQMgRIlgNdNhHyydMkNqpGl44pyTyXvbn1JeM99rgux4EgGS3
lrPVVIKCwOC8FNmW+gxHlV0LhMOK30TUdbSBfi3aZ9SV9TC596mNM54veWF/vrSK
iV3/Z5MgKRhV1NoTcRO9wO+/TM2PFP/o5VWzfrUkzliyAEFWJTZDKBfsc0rYQwA/
4QWAoBb+ez8GpB4tHp6DYPcZ92I9Gw==
=5BUy
-----END PGP SIGNATURE-----

--pP44LjMFfDxyfF3H--

