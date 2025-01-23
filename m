Return-Path: <linux-pm+bounces-20884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED33A1A6A2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB437A1969
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B939214A95;
	Thu, 23 Jan 2025 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3QKYlFf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6032144CC;
	Thu, 23 Jan 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644697; cv=none; b=ZhZavnAjXeBDRrR0i2XRQ1e0hw2SAm2T/N4vXX0qhMYe/G34YMdrOX09nyeTwxkpFx2FPCQewPaOt+AJtW1o+ASDriRCMJ3poDi6BbnOY6Wp7wclAypAgbOFk5ctWcOrOuSYFVBeK9F9ZOJdW6UnTN7cBdGtvsjRAIkLU+aXZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644697; c=relaxed/simple;
	bh=xHVOQuVrnIRMzXOeho4OvpujtLf75fYxc7TGc+UguQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iekc/0OnKefJBvaqJI1n3nbkS7GyDBrPWejo3kVzbK9Wwvfw5/Qm4V8mO6fSKn1+eoRn4sKDxMepz6lgQ3pHLaVt7xf9TfofiPGb+JprPKgk8qrImzvx1FaybL2X3Ok6v8/+8Fsbx0duYTF5X7GFSSc3VLgyir5imFzd3lhS9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3QKYlFf; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aab925654d9so186976366b.2;
        Thu, 23 Jan 2025 07:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737644693; x=1738249493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyHR+UAJXoB3B0bRGYfmtipp2NMrI6ZoaTGC5DF80Yc=;
        b=Q3QKYlFfXAtsGdt2aD3UQ98bq5KWMxBQ2MOT6y3E5+2ccLGcn3uVLjkcwbzAWtAN0Z
         BrT+QBy/3CebhUFJpOnwstEsObXJvR/pDZwqsKFoUauCgLIoptIvGEqsxNHmT2KHxYiM
         FVuDqqF/H7IWrl7aa8jRwO2vsIVyGtVWcrmleXAu/J69cKXKUL85FOlEwEwvXuU3LgGi
         1e/xSQ+r1/3ycEj5ERaRO/m3KD+Sp8el4WHF/nkkE/XE/wXO4QS8kxJDBpcaMBbjSfMn
         VSr0EOLVi8yZgaPXdgeKBQwI9rdLjQbwGLpn/MVEe7myP/D74JXIiTlrS/z4l52KjzH+
         bvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644693; x=1738249493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyHR+UAJXoB3B0bRGYfmtipp2NMrI6ZoaTGC5DF80Yc=;
        b=HvOviSi0n6PvfsDf8mbUVHsClvw8oyrFz4t0xhOq4aJqgxqyPqv7YumoVJB/SAKxNI
         XbZzBu7UAMxknvzzRKM85iwHHuJ44SHA7pdoQMEjdTivVGdSCjV9Hy1DOFINwdyXsqhM
         bzUoAnV0+ZgyZF2G8sAsptU4eY5zksgBF++GDC282fWO9gBu0cEIDEXS1foKi5bwBAir
         0FUq4SF3nF9gWjNJNZFg2q3lur/toOTcJJs5me3i5BHV3L+C8+EbWvnOauU5bo6BG7WI
         sBHfedCRvY+RY7eN66M9J8j5n7ORP9OP6cNXk+pBP3awT6qDz/TaxiGGZlOK0WLLxBaC
         oGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4d6GjEUjl+OQhC7AVAFM2BjyU3u5q9BQR+LjpPfS7OUkTzo+IH+z6XsUrCXScXkfdqy0tsIwzAURjxw==@vger.kernel.org, AJvYcCVnJUkx9Gf8hCKnrME5SDt73DAAggceNyP1HdLUU2hx1ut+K+EHjo0o+sL2tfwSkeqow8M+nhhSWkE+Qbg=@vger.kernel.org, AJvYcCWACVkpjpNDyDKDQhlecpi7964Wu/LZb/BRNy+JW9hdrMDJbN4R3rIKMbYr0yrIWnLGu1QWw3jpczqdwq1i@vger.kernel.org, AJvYcCX3+lWqBPdKAH0NFAx9+fWIaSZMTOpHav2IwLr+FXno+uIUDWZCZzPu9iX41m7z37U5eeThwL/0g7Ls@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/WTi1zFhPKYpWtS9/V4w/XA/0eXz4CYVlkNTfbjyo+juB/YF
	Oy765JDob3/ygReB3UTVRIXtlDWi3aN5V1EfTgpC9KC7T2sN9vTA
X-Gm-Gg: ASbGncsHynfM46JyyxNEUQMOiu2434VG7iek0w5lPzJgq8NulG7PzK1EUQ+dWCz446Z
	z+wE4/r9NN2lbdVtsqPJonuOGjbKKxObacUYRL/f0gt73Y44Ua5GiTWwlPc/VKB2w3s8K1kBqbN
	HDUwAQmoG6Q4P6V3za55a25n0Btf+WxslN3Ixbgk8UvDvG9lr2rawVnKfRQkxPNMb/Vy84mZQv9
	q8PPUJ4H2JiR8Zk1ns82jT7ed6Ad/KNZFYorU/aSoPS9nEikwn5HGwKhU+X+Y3YhelvMZK5vl+1
	QyA=
X-Google-Smtp-Source: AGHT+IGUfPosknVn5VgU9f2LcctH3soo31TrfXh0WM/0YjddpY65aFx8Buh2smL4I2qM0/x5HEolLg==
X-Received: by 2002:a17:907:7f17:b0:ab2:b5f1:5698 with SMTP id a640c23a62f3a-ab38b44e10emr2697494866b.38.1737644692415;
        Thu, 23 Jan 2025 07:04:52 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm1084727266b.109.2025.01.23.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:04:52 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 23 Jan 2025 18:04:32 +0300
Subject: [PATCH v17 7/7] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-starqltechn_integration_upstream-v17-7-8b06685b6612@gmail.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737644677; l=13657;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=xHVOQuVrnIRMzXOeho4OvpujtLf75fYxc7TGc+UguQE=;
 b=vgPE0M3Gcs6RNn3k8e6qQdqaufORvcFfbsdX5ZA1TyiY0hdYhMSVB6hlhWSlsxUO3lgUhvZUG
 kJ5+dD6YYhDDqJWP0kNKf75k4TSMHpH4NDHMQqsymZmPuSai6NNR8ZU
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This adds basic support for LEDs for the max77705 PMIC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v17:
- delete regmap reassign
- fetch i2c_client from parent device (this needed to provide valid
  i2c_client for devm_regmap_init_i2c call)
- add Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Changes for v14:
- s/led/LED
- move led regmap creation to LED driver
- update copyright year

Changes for v11:
- add dependency on led multicolor class

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
 drivers/leds/Kconfig                 |   8 ++++++++
 drivers/leds/Makefile                |   1 +
 drivers/leds/leds-max77705.c         | 275 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77705-private.h |  17 +++++++++++++++++
 5 files changed, 302 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 705458b6e0ad..b3a894ddbf27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14187,6 +14187,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
+F:	drivers/leds/leds-max77705.c
 F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b784bb74a837..4b69676d8206 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -753,6 +753,14 @@ config LEDS_MAX77650
 	help
 	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated.
 
+config LEDS_MAX77705
+	tristate "LED support for Maxim MAX77705 PMIC"
+	depends on MFD_MAX77705
+	depends on LEDS_CLASS
+	depends on LEDS_CLASS_MULTICOLOR
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
index 000000000000..933cb4f19be9
--- /dev/null
+++ b/drivers/leds/leds-max77705.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Based on leds-max77650 driver
+ *
+ * LED driver for MAXIM 77705 PMIC.
+ * Copyright (C) 2025 Dzmitry Sankouski <dsankouski@gmail.org>
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
+static const struct regmap_config max77705_leds_regmap_config = {
+	.reg_base = MAX77705_RGBLED_REG_BASE,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77705_LED_REG_END,
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
+	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &max77705_leds_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to register LEDs regmap\n");
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
index 0c8b07abfb9d..214de7feeb8c 100644
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


