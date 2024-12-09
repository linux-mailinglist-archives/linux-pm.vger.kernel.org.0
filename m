Return-Path: <linux-pm+bounces-18822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DAC9E9260
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3791881BA1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2722489F;
	Mon,  9 Dec 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEQfQTZG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACAA22371E;
	Mon,  9 Dec 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743779; cv=none; b=j+pdQphnr4Akn3bE8tB3J9P0JX6K/J6AvlwaLS9OGam0iktkCa7Vbx5hZc6tidXIyVSW91tMrwr5Jta12rdXyOt+O0JKegN82YxB8saMV3f0gdA8OcwJ74PtezxvggqQ8Km7dPAOuYy4NQ2f64tDucSseZpec/IKTZw4kDgbm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743779; c=relaxed/simple;
	bh=NzOXsoCzbUeQfHUsRZ4NJIWaPxoZJF1J5dkwdApc5FM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlETFYB8e2pKoJKggjxMF4xlHfA5hS6vei3tzWKjkRwUC95+qnArWi9HAQ+fWJuzR37ydeWu8k0O/GFaZl7U9HOFfjRtN0lPwH4HdZFgX1OFMHBBtmzs9Cq6TA6cIebFWwbByRjlKdlWKf1SVRvupFVRPDHVLF68Vc3gABbECZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEQfQTZG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso1682145a12.0;
        Mon, 09 Dec 2024 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743775; x=1734348575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ+/5vhkA7SFa09z69ZqE2BWJsck8tUytuODte0Gx3A=;
        b=OEQfQTZG4X/v6yxwkual0c361fx7g9Z0aAaWd0SR+ob/v8Vwv+XeNo0PDlkafISC0D
         DNki1wzro69Fr3qgmSuRavuqLdJyFMqYcZRbamQUZjsJxvfrfmhqR5GaeRHMY5TUTpOT
         K8SClKXjWTujfB8LCv4mli2SW3MyXrx+UQwivDrkiTgDSf4A7X2K5USWXsIFwt9kV4gd
         6ktGi5vX15b5TYw29XbRSPqlG03MCjcqeB8/+CuQd2nrBObMZlKUP2vzT40BOYXe5eYK
         ewXvVj9/pcGEilEuM2yopjKTDKEfO/K38kvtK/CpXRLJJsJwwnXsXwjpew5Ub4Rk3tLY
         RAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743775; x=1734348575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ+/5vhkA7SFa09z69ZqE2BWJsck8tUytuODte0Gx3A=;
        b=kTG0F6dTAqET8y4abF3QoCqj1dg88jJXqI5z918vLTjtJhv2W1sIADy/usV2LrE6jL
         S6Yj9/2SFfBatxbGv0cIR9zLlTfgNaUvVyzDXqyPZZoajjrMHYEyuwnTeNhVO6XuuzV+
         aa1tqH9q8kWO4fPN57KDktwevGyz7zkVw0NApFpOxUinSoyIa2mkCKj9ORNeTEg8ylG4
         xxp+tB3uo18fuku97T7VNTbroDsHRef49HjRaVpouKV6sfA4lEMHoUW4dBXX6Ra4CvX0
         5Tq2U0WPYrmjzeWLZe+hO2f/ekxKEgYSvsinwRXYLKECah1YyHntoDRH9W43hdGjVHXM
         X0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnPIQvgmLMUtbkQRYbJ1xRM7LB7KblNzE1io5ntkhqaSSyYHsGRaDthy6zNAwjF1/5gm47tMb58GIHaDw=@vger.kernel.org, AJvYcCWVE1ZbseBsa6wzEkKhI5+kFAz14k1XbttlZhUt0Gf1HydFZeRMaLJ6ajyZoMfPxqus+JhtIE80oiuYVBFV@vger.kernel.org, AJvYcCWtbFgfGVv9EA/+KJkkVKuhse6NDsTX9EHaAJpcDfs6ZviEA/jTb4LGcng57reh9qiyqeTVra/QytKszw==@vger.kernel.org, AJvYcCXFmiP4idTjOajy2I297rLhiKJOwdWKa2OIJ/w5tOmBmRfpir03FaPoXiV3ovrOOLtrOe8ydvkan5xx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72B3KAtcbRS8t02XnIFTepr57oHMiJioqHcPtueNzOlnZFUR5
	e/1oDRIf0JG5RFlgGv6fKViGtcPlC9XR3a6MO882fFhSddGV0pWe
X-Gm-Gg: ASbGncvX+LZHhEW4k9soFTzJwfByXT+UGq9qvgbB1xBZ/G2+xEazDgHm6JUnN+cPqJi
	djpfA5T3zppL1vztigZNjOnn3uWrFrWm7TvBiFc4wmsg3SYoff2uiNznL6rslNG5Ed8WiIc2Tdj
	XkqQfYVcMuBcm9IZGPXva4lC9C2FoxSsSCeLbCmMgoSF5PSoPWKd8vhTuIjYMD5xqnVrII0t/N+
	ObzM+RXPWmdWqiO2UJDxwLQPJ5NibEJsYTUTTaSN/GZQKig
X-Google-Smtp-Source: AGHT+IFqNrHxraxk1FWM4T8pzDq0HrzNk+T9GajDD/YiMURQzzhOGHeGpV4A1SOo3nZ+yMA5gF83PA==
X-Received: by 2002:a05:6402:4007:b0:5d2:729f:995f with SMTP id 4fb4d7f45d1cf-5d3be816a47mr10105250a12.29.1733743775134;
        Mon, 09 Dec 2024 03:29:35 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:34 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 09 Dec 2024 14:26:33 +0300
Subject: [PATCH v11 9/9] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-starqltechn_integration_upstream-v11-9-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=12665;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=NzOXsoCzbUeQfHUsRZ4NJIWaPxoZJF1J5dkwdApc5FM=;
 b=o7E91FyqSTCHpJqooBI26yFzbwIuXZN/nW9EhrB53TTaLBm5ADELwn5kvtmWeT7RZXWakhPRk
 6uovyabYk+eD88Y0xiVoZNV2xTzwxuRgknj9XHMsDvJ6Ng94itVHqeC
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This adds basic support for LEDs for the max77705 PMIC.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes for v10:
- remove multiple line break
- replace en_shift, reg_brightness values with macros
- add support for leds-class-multicolor (inspired from leds-qcom-lpg.c):
  - replace max77705_to_led helper with container_of,
    because it's no longer covers all cases
  - add max77705_add_led, max77705_parse_subled functions
    to parse device tree
  - split max77705_led_brightness_set into *multi and *single versions

Changes for v8:
- join line where possible to fit in 100 chars
- change comment style C++ -> C

Changes for v6:
- change compatible suffix to 'rgb'
- remove I2C dependency in Kconfig
- remove copyright and author from 'based on' header statement
- replace MFD abbreviation with PMIC
- MAINTAINERS: alphabetic order
- max77705_rgb_blink: replace ternary operators with if..else if sequence
- max77705_rgb_blink: move hardcoded numbers to constants
- max77705_led_brightness_set: move ret to the bottom
- s/map/regmap
- replace device_for_each_child_node with scoped version
- s/rv/ret
Changes for v5:
- use same hardware name in Kconfig and module descriptions
- remove copyrighter owner from module authors

Changes in v4:
- inline BLINK_(ON|OFF) macro
- remove camel case
- drop backwards compatibility(new driver)
- drop module alias
---
 MAINTAINERS                          |   1 +
 drivers/leds/Kconfig                 |   6 ++++
 drivers/leds/Makefile                |   1 +
 drivers/leds/leds-max77705.c         | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77705-private.h |  17 ++++++++++
 5 files changed, 292 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d6e77bf6593..a43745895f97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14230,6 +14230,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
+F:	drivers/leds/leds-max77705.c
 F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b784bb74a837..27ce55b32543 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -753,6 +753,12 @@ config LEDS_MAX77650
 	help
 	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated.
 
+config LEDS_MAX77705
+	tristate "LED support for Maxim MAX77705 PMIC"
+	depends on MFD_MAX77705 && LEDS_CLASS
+	help
+	  LED driver for MAX77705 PMIC from Maxim Integrated.
+
 config LEDS_MAX8997
 	tristate "LED support for MAX8997 PMIC"
 	depends on LEDS_CLASS && MFD_MAX8997
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 18afbb5a23ee..096bf244527d 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
 obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
 obj-$(CONFIG_LEDS_MAX5970)		+= leds-max5970.o
 obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
+obj-$(CONFIG_LEDS_MAX77705)		+= leds-max77705.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
diff --git a/drivers/leds/leds-max77705.c b/drivers/leds/leds-max77705.c
new file mode 100644
index 000000000000..15fa4b3cbcd6
--- /dev/null
+++ b/drivers/leds/leds-max77705.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Based on leds-max77650 driver
+ *
+ * LED driver for MAXIM 77705 PMIC.
+ * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
+ */
+
+#include <linux/i2c.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77705_LED_NUM_LEDS			4
+#define MAX77705_LED_EN_MASK			GENMASK(1, 0)
+#define MAX77705_LED_MAX_BRIGHTNESS		0xff
+#define MAX77705_LED_EN_SHIFT(reg)		(reg * MAX77705_RGBLED_EN_WIDTH)
+#define MAX77705_LED_REG_BRIGHTNESS(reg)	(reg + MAX77705_RGBLED_REG_LED0BRT)
+
+struct max77705_led {
+	struct led_classdev cdev;
+	struct led_classdev_mc mcdev;
+	struct regmap *regmap;
+
+	struct mc_subled *subled_info;
+};
+
+static int max77705_rgb_blink(struct led_classdev *cdev,
+				unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	struct max77705_led *led = container_of(cdev, struct max77705_led, cdev);
+	int value, on_value, off_value;
+
+	if (*delay_on < MAX77705_RGB_DELAY_100_STEP)
+		on_value = 0;
+	else if (*delay_on < MAX77705_RGB_DELAY_100_STEP_LIM)
+		on_value = *delay_on / MAX77705_RGB_DELAY_100_STEP - 1;
+	else if (*delay_on < MAX77705_RGB_DELAY_250_STEP_LIM)
+		on_value = (*delay_on - MAX77705_RGB_DELAY_100_STEP_LIM) /
+				MAX77705_RGB_DELAY_250_STEP +
+				MAX77705_RGB_DELAY_100_STEP_COUNT;
+	else
+		on_value = 15;
+
+	on_value <<= 4;
+
+	if (*delay_off < 1)
+		off_value = 0;
+	else if (*delay_off < MAX77705_RGB_DELAY_500_STEP)
+		off_value = 1;
+	else if (*delay_off < MAX77705_RGB_DELAY_500_STEP_LIM)
+		off_value = *delay_off / MAX77705_RGB_DELAY_500_STEP;
+	else if (*delay_off < MAX77705_RGB_DELAY_1000_STEP_LIM)
+		off_value = (*delay_off - MAX77705_RGB_DELAY_1000_STEP_LIM) /
+				MAX77705_RGB_DELAY_1000_STEP +
+				MAX77705_RGB_DELAY_500_STEP_COUNT;
+	else if (*delay_off < MAX77705_RGB_DELAY_2000_STEP_LIM)
+		off_value = (*delay_off - MAX77705_RGB_DELAY_2000_STEP_LIM) /
+				MAX77705_RGB_DELAY_2000_STEP +
+				MAX77705_RGB_DELAY_1000_STEP_COUNT;
+	else
+		off_value = 15;
+
+	value = on_value | off_value;
+	return regmap_write(led->regmap, MAX77705_RGBLED_REG_LEDBLNK, value);
+}
+
+static int max77705_led_brightness_set(struct regmap *regmap, struct mc_subled *subled,
+				int num_colors)
+{
+	int ret;
+
+	for (int i = 0; i < num_colors; i++) {
+		unsigned int channel, brightness;
+
+		channel = subled[i].channel;
+		brightness = subled[i].brightness;
+
+		if (brightness == LED_OFF) {
+			/* Flash OFF */
+			ret = regmap_update_bits(regmap,
+					MAX77705_RGBLED_REG_LEDEN,
+					MAX77705_LED_EN_MASK << MAX77705_LED_EN_SHIFT(channel), 0);
+		} else {
+			/* Set current */
+			ret = regmap_write(regmap, MAX77705_LED_REG_BRIGHTNESS(channel),
+					brightness);
+			if (ret < 0)
+				return ret;
+
+			ret = regmap_update_bits(regmap,
+					MAX77705_RGBLED_REG_LEDEN,
+					LED_ON << MAX77705_LED_EN_SHIFT(channel),
+					MAX77705_LED_EN_MASK << MAX77705_LED_EN_SHIFT(channel));
+		}
+	}
+
+	return ret;
+}
+
+static int max77705_led_brightness_set_single(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct max77705_led *led = container_of(cdev, struct max77705_led, cdev);
+
+	led->subled_info->brightness = brightness;
+
+	return max77705_led_brightness_set(led->regmap, led->subled_info, 1);
+}
+
+static int max77705_led_brightness_set_multi(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct led_classdev_mc *mcdev = lcdev_to_mccdev(cdev);
+	struct max77705_led *led = container_of(mcdev, struct max77705_led, mcdev);
+
+	led_mc_calc_color_components(mcdev, brightness);
+
+	return max77705_led_brightness_set(led->regmap, led->mcdev.subled_info, mcdev->num_colors);
+}
+
+static int max77705_parse_subled(struct device *dev, struct fwnode_handle *np,
+				struct mc_subled *info)
+{
+	u32 color = LED_COLOR_ID_GREEN;
+	u32 reg;
+	int ret;
+
+	ret = fwnode_property_read_u32(np, "reg", &reg);
+	if (ret || !reg || reg >= MAX77705_LED_NUM_LEDS)
+		return dev_err_probe(dev, -EINVAL, "invalid \"reg\" of %pOFn\n", np);
+
+	info->channel = reg;
+
+	ret = fwnode_property_read_u32(np, "color", &color);
+	if (ret < 0 && ret != -EINVAL)
+		return dev_err_probe(dev, ret,
+				     "failed to parse \"color\" of %pOF\n", np);
+
+	info->color_index = color;
+
+	return 0;
+}
+
+static int max77705_add_led(struct device *dev, struct regmap *regmap, struct fwnode_handle *np)
+{
+	int ret, i = 0;
+	unsigned int color, reg;
+	struct max77705_led *led;
+	struct led_classdev *cdev;
+	struct mc_subled *info;
+	struct fwnode_handle *child;
+	struct led_init_data init_data = {};
+
+	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_u32(np, "color", &color);
+	if (ret < 0 && ret != -EINVAL)
+		return dev_err_probe(dev, ret,
+			      "failed to parse \"color\" of %pOF\n", np);
+
+	led->regmap = regmap;
+	init_data.fwnode = np;
+
+	if (color == LED_COLOR_ID_RGB) {
+		int num_channels = of_get_available_child_count(to_of_node(np));
+
+		ret = fwnode_property_read_u32(np, "reg", &reg);
+		if (ret || reg >= MAX77705_LED_NUM_LEDS)
+			ret = -EINVAL;
+
+		info = devm_kcalloc(dev, num_channels, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+
+		cdev = &led->mcdev.led_cdev;
+		cdev->max_brightness = MAX77705_LED_MAX_BRIGHTNESS;
+		cdev->brightness_set_blocking = max77705_led_brightness_set_multi;
+		cdev->blink_set = max77705_rgb_blink;
+
+		fwnode_for_each_available_child_node(np, child) {
+			ret = max77705_parse_subled(dev, child, &info[i]);
+			if (ret < 0)
+				return ret;
+
+			info[i].intensity = 0;
+			i++;
+		}
+
+		led->mcdev.subled_info = info;
+		led->mcdev.num_colors = num_channels;
+		led->cdev = *cdev;
+
+		ret = devm_led_classdev_multicolor_register_ext(dev, &led->mcdev, &init_data);
+		if (ret)
+			return ret;
+
+		ret = max77705_led_brightness_set_multi(&led->cdev, LED_OFF);
+		if (ret)
+			return ret;
+	} else {
+		info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+
+		max77705_parse_subled(dev, np, info);
+
+		led->subled_info = info;
+		led->cdev.brightness_set_blocking = max77705_led_brightness_set_single;
+		led->cdev.blink_set = max77705_rgb_blink;
+		led->cdev.max_brightness = MAX77705_LED_MAX_BRIGHTNESS;
+
+		ret = devm_led_classdev_register_ext(dev, &led->cdev, &init_data);
+		if (ret)
+			return ret;
+
+		ret = max77705_led_brightness_set_single(&led->cdev, LED_OFF);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int max77705_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = max77705_add_led(dev, regmap, child);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id max77705_led_of_match[] = {
+	{ .compatible = "maxim,max77705-rgb" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77705_led_of_match);
+
+static struct platform_driver max77705_led_driver = {
+	.driver = {
+		.name = "max77705-led",
+		.of_match_table = max77705_led_of_match,
+	},
+	.probe = max77705_led_probe,
+};
+module_platform_driver(max77705_led_driver);
+
+MODULE_DESCRIPTION("Maxim MAX77705 LED driver");
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max77705-private.h b/include/linux/mfd/max77705-private.h
index cf4184063390..49509c0352b1 100644
--- a/include/linux/mfd/max77705-private.h
+++ b/include/linux/mfd/max77705-private.h
@@ -33,6 +33,23 @@
 #define MAX77705_SYSTEM_IRQ_SYSOVLO_INT	BIT(5)
 #define MAX77705_SYSTEM_IRQ_TSHDN_INT	BIT(6)
 #define MAX77705_SYSTEM_IRQ_TM_INT	BIT(7)
+/* MAX77705_RGBLED_REG_LEDEN register */
+#define MAX77705_RGBLED_EN_WIDTH	2
+/* MAX77705_RGBLED_REG_LEDBLNK register */
+#define MAX77705_RGB_DELAY_100_STEP_LIM 500
+#define MAX77705_RGB_DELAY_100_STEP_COUNT 4
+#define MAX77705_RGB_DELAY_100_STEP 100
+#define MAX77705_RGB_DELAY_250_STEP_LIM 3250
+#define MAX77705_RGB_DELAY_250_STEP 250
+#define MAX77705_RGB_DELAY_500_STEP 500
+#define MAX77705_RGB_DELAY_500_STEP_COUNT 10
+#define MAX77705_RGB_DELAY_500_STEP_LIM 5000
+#define MAX77705_RGB_DELAY_1000_STEP_LIM 8000
+#define MAX77705_RGB_DELAY_1000_STEP_COUNT 13
+#define MAX77705_RGB_DELAY_1000_STEP 1000
+#define MAX77705_RGB_DELAY_2000_STEP 2000
+#define MAX77705_RGB_DELAY_2000_STEP_COUNT 13
+#define MAX77705_RGB_DELAY_2000_STEP_LIM 12000
 
 enum max77705_hw_rev {
 	MAX77705_PASS1 = 1,

-- 
2.39.5


