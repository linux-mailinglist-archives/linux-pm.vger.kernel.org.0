Return-Path: <linux-pm+bounces-35776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E3BC0B44
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 10:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD8A19A0A6F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286082D8DC4;
	Tue,  7 Oct 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKOGJKpy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28922D5923
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826080; cv=none; b=Z/RS+A5K749ZfbAfdp+BgjULhd4FV6c8y/t51fEONqTiSD1iyM38qpoi1uQWvvoZIKWHb8vFtN9tOqfHBefc5AUgwmoGlOxgSj8aoyhkdqjnsSvMtJ9K6L97tPPuEhld36fa7oRE8R7psiuBg0VE54E97ZKUF+3r4Jta0KVe9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826080; c=relaxed/simple;
	bh=R8clJqIWgxqfvV6jstEVcRU6Y5M+f9dOjXk/4CdXbEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slNCLkNYjQT/gtI2CY2npsukcyaWKYSJ+Uw8QZpLBu8OG3gTw5VHXXNQejUQSVmxNfI+0caHd5CTXImOACiRCwyFYqeYk0mVg9NncJmMTxmOCQFRqbclRzJVxh7tZcSdLhLxrrcnSE+80lHtPZpQn5z2LxOXo2AaxX/EUB/l8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKOGJKpy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57a604fecb4so7687877e87.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826075; x=1760430875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYqOhwjmD7QzSDhAXWMY9rlGZsX+SISq8DSEREyGLpc=;
        b=ZKOGJKpy7XckcOzY2xg2mgVcVwsBC2+oKfQoV+z8cWw5PrF9Ontn7f10p9tZskYtf2
         o/sGLylZmrGvsGgW8AC3ToldZsfny8+6rkh/56cidkM24UvOeyYCJlAn7TfxYBeKgWwc
         1bIlfgFoIeYtKOeRTijasgRvdoAWI6rgFFWEsTVrdpTX9DJpWC3lWb80Y6tEwZ3ssiCr
         eGa+sPG1M91kZekK8r0KloA8g5Uf5/hC8F8AQ53rrMk8E5LvYlf9IHIpMpwZQD6JDpq8
         WpdbRhnqde30BVooqFIwFIDVCQvWkbAkcILmUZyLBH8OwWxzEYOwZ72kNCNL7PKB9Uag
         N2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826075; x=1760430875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYqOhwjmD7QzSDhAXWMY9rlGZsX+SISq8DSEREyGLpc=;
        b=G5Kho7YchtpmlTyEusqEXsYK1YvjmnPR0ZE7o/9+IqqHyBnsV79GMqTSq3H+OMfeiO
         GtKy6Gbf5yjbpZMuE0ixJvAnXSiXZKxGM3P4i2erkxIhC9SMzO6+qjEIJ9yPkcJlpZ6c
         Z62mKKnm2kmzcAmrsJgG6bWnhimDWEdssqd4x2XTckrsdxDf+m6+gFpchbipLAW8rId8
         uprewmtcJtjDPCdTilVLc9HKVdv1ThjEHKOY7x+dNHihh4jPfLuE9gMii2MWr1oy95Z6
         An6j9aVacy4WhJP1xwXDT7/PBHsmOn7E79W50xo+tn7fNwvznO0prsNgqdAIOJ3PP4ql
         bdEg==
X-Forwarded-Encrypted: i=1; AJvYcCWrUbjrLd1J7APLsVbgpS+hufua0EBr3G6UIdooHtzqurxvRgH31UO7wpvUfDc9H096EcwWuNC68Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5vC++bqezXKhK0T2HcodOiLoJTIffVHftg9LuYQErCKfwd/C
	QAfvfbzbFMsf4a5XFJUqGCLl7aYS50xhx5hMXi8KLBNu3Gk7i8Eh+2Yy
X-Gm-Gg: ASbGncurY2SnRcGTZBP+pqtFsjGV/6S/bLUhKgtM8Ftns6Dt0LTTYYMuwzzWgMY9J+s
	HLKPcHYZ6BEHX8SGMeTCfoqfXhv4HZLKvcYGPBCcsk+sEj1WEcyVCCpQcK41uQVfhVAAPLloxzf
	73PfRT/EZaaxeOlRYyBhHc/fmQ/G4U8s4n5rnZYoAgin1IP51Rr1NOIFmZ3LsyDu2ufoxzH4fBd
	jP0uzshB74TvOBsDy/PX1V1sB1A7zf9TA1Ttqj1MkCDF8m5OCol5VB8vQI4eOhgwnq3IWplhk2r
	4SeIAXTIZ6ssV5xNH/uqAeZiCMPG0UwGVPPaOnQF07QExvUzACU7Wqyv2c7Q/0OLT/MeWVz3rTH
	so3f/YteuwuXWlH3/s24GtnGj1hvYXHaiIHsVLVqhsrGwq00Ng4wnlQ==
X-Google-Smtp-Source: AGHT+IHsASn0unx/AEqza4jAFGTdIMbVTcQ/sQcaQeucT8a7hY37xmWlyEPjz5QPdJAWskjmEMEQJA==
X-Received: by 2002:a05:6512:b09:b0:560:8b86:75ba with SMTP id 2adb3069b0e04-58cbc680d7dmr4384427e87.52.1759826074944;
        Tue, 07 Oct 2025 01:34:34 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119ed6csm5819943e87.105.2025.10.07.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 01:34:33 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:34:30 +0300
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
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 09/13] gpio: Support ROHM BD72720 gpios
Message-ID: <ed65074dbedaf2b503d789b38bd9710926d08a55.1759824376.git.mazziesaccount@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bPmL0Nc6G4goy3sK"
Content-Disposition: inline
In-Reply-To: <cover.1759824376.git.mazziesaccount@gmail.com>


--bPmL0Nc6G4goy3sK
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
---
 drivers/gpio/Kconfig        |   9 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-bd72720.c | 281 ++++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+)
 create mode 100644 drivers/gpio/gpio-bd72720.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d8ac40d0eb6f..86498c2cb949 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1315,6 +1315,15 @@ config GPIO_BD71828
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
index 379f55e9ed1e..15bdaa680ca7 100644
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


--bPmL0Nc6G4goy3sK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjk0JYACgkQeFA3/03a
ocVRSQgAsGU4yl/v9avbTHL13POxAGZTvz0dBHS8YmZ8iZ0q8NYZf+Rd4mFp6DWC
GFQjV6ttE8VfpKQnD3YYTY/+ZqX2mKpMrJ2EuLHIFGse7VR1pVmpFhnLKgJE9zAw
RsFeeU1ZtnZIy7pmt77VWw+TLGuwfzBt7mY0miRbnu5pQ4RvrX3vc2F7IjfDAjTw
ZsHtEXcfl0TsrQ1IWVKQyP0zei6vt7b/oLLVwPuypd0mMOAzgh+pACtrIMDT4V89
yOtVvjmBITgfgHKhNSF3Vh2AEFne6xWe+8LAJ/lWcRazdpX/J6BK+DWHijSVthjD
nn2oeJ3ecs/2lreA4JD5b8ZqY2ZN0w==
=vhGB
-----END PGP SIGNATURE-----

--bPmL0Nc6G4goy3sK--

