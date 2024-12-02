Return-Path: <linux-pm+bounces-18331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E89DFDB9
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9534B163680
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218C1FDE3D;
	Mon,  2 Dec 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7BCR6/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245021FDE1A;
	Mon,  2 Dec 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132900; cv=none; b=lOaQ7PuO7kGPCestd4iu+m1UiIJGaG9nmduxdH9WgWhLtPBgQ+2FdT94uGzk0VZKBYAMxGyGNRo65RYP0YpBhghCZY6SFp6wRvoXVtVXS4/VcctDOEXuHtmCaLxLmqmUAJCI5sKr7wfyRiuw7ZvItKUzSuSSeVxGg4b4kAMSl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132900; c=relaxed/simple;
	bh=nNKdt6aAQ4O8gBwlr5BJKCp3j+YjqzXknQ+peKB2yLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jp3nJaISAMrp5WxDVa75wwEB3FQm0NsL93KCtPcR42624cctiflqjxozYX+96BRvpff2yACn1J5qR+X97K/E5GywIWKjQOb1NMrqIeitvDdyMPfQ0jzAArwSUQIbh9GheouuqWQHa51cJTHz1YXCo0pHhfFkaEjBKCXM9CUmpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7BCR6/J; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5366d3b47so658983666b.0;
        Mon, 02 Dec 2024 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132896; x=1733737696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LBTuoCDOxxqO2y3YAKj2vln0gXaFFLFmx9hGGgry74=;
        b=I7BCR6/JorJiUQBCeQOLi9aerEJyRZPtO2yg74ByHkP/zrFkojUiBPjdO6VxdGZlyt
         Zv22/G392VPKV7knFn2f8Xkl7G4VpL4Lps/gJ7K2UGPQL8u4FxXEHcnjM1/fod7IAnie
         ijPV9+DynSMcK/UOi4c14LZcxncNhLW2djQrRkKkbnCIow5xW6yPPKcG8vJNxBbn/uG4
         waxCEziGUc3Pyrj4nK/aVxY23VfIY6cg1Lgt1VwPQ1oiMCtCrFJqLgsCSaOkPuLO2ae7
         a9oS4ryGs0rVMd+7GJzbJyDYSL/6pnMhqe0E7liCI/fq1bBwTD3qoY6I6K9KZCgEh8KI
         L9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132896; x=1733737696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LBTuoCDOxxqO2y3YAKj2vln0gXaFFLFmx9hGGgry74=;
        b=TxHTRn/TsrRYk6/wlodrYzobX6oFUFs/MupgfpSJ0keMHEKOgRF3eHkgLWCaeHruLX
         FqbHKp1WIPGCjTq1XLFRXRDdAFwFE7A14wckzaSiAfNXkRRTDB+v2ZI+M1A/jbwVZYyA
         7hw6HO7Cy6dRcI+8Q0CCljwNGXvrIwJ3zhUqli3sswCGEuQGYFM/zU1RakCjrmXGWdHX
         eyoWI7G3Xlb5KYI09Perkh9/Nw4boOnRVFMlrI8iXe6sAHtrRH1WaiRV0jkRlgjNKDAe
         teoFjQ45n1xj7e35m7qiq6T665cPnZtT3/Nz/roN4tSBWjbm0vB27enMQT3ChOcl2SHU
         6Zwg==
X-Forwarded-Encrypted: i=1; AJvYcCUO+e8Fs5Ozk3u3DOp1u/jWti4bwQJ3XxDjXU7MqGCtdNGVgZi53nGGuM6RNwzKDIow8XVnyEpZ7CUB@vger.kernel.org, AJvYcCUmFSaICuR2uLg1jzFlCzIUep7T553g3bLTMo1ddGXRuJh2/ht5Y6SME2++vxE8sMLK5EtkWioBTAEzFw==@vger.kernel.org, AJvYcCUvmyMlYl9pf1+Gr95rxVcfouJCCZNcTcztw7+iRLz5nOz18BailVwstSBuLhfUQ1grOMf2gk+nEnmJXjgN@vger.kernel.org, AJvYcCXvZw5kseB8T6fkP88ktw05K+i4yZEF9ee+VQeBF8hN5gY/FF5jIy3CUvkQPW9OCBt+fdhEyY3VSyQ7+BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkob99VrBUDWqNavejnHRn4u+hahEgqLySrXqbOhUlXaEs4Yn
	+dMVmCFMKCgn0iRM1ncUdDAani8GQPWbjBlmAo0n0NPJSOe0EwGrYraZMJGw
X-Gm-Gg: ASbGncsaVI4fHIHL1qUlKdIfv1vbuUeViwUPwuqWXuCBygwblq1wnz4jG8TFlIkr6ce
	GJ1sqjDB4Kl6z0LPJmWkFaUQYYSgaERXERM2gWYHArq8R8/ddP3MZvx9OU2oIjyUdZrPll5lDzn
	D8Gnsu1m1EYv9+rl6c8mcCDYGzvoRsOxLuiMOhfNaBdW2ui06BSg11mmM/lXZfRMXLz79v4OW4H
	xfx1cQ3VrlHqzrmKCLg5wD1m+ErrMTjyiJB5UcwoHX8HfiX
X-Google-Smtp-Source: AGHT+IHsaeJj8mT7GOA42WhtBau+dDuXWqOnDvfQuTAh9WNbaNkUzyrQhibpZTRFojC5RUS0VNNy/Q==
X-Received: by 2002:a17:906:329b:b0:aa5:241a:dc75 with SMTP id a640c23a62f3a-aa58103b03amr2068889466b.41.1733132896299;
        Mon, 02 Dec 2024 01:48:16 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:15 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 02 Dec 2024 12:48:02 +0300
Subject: [PATCH v9 9/9] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-starqltechn_integration_upstream-v9-9-a1adc3bae2b8@gmail.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=9372;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=nNKdt6aAQ4O8gBwlr5BJKCp3j+YjqzXknQ+peKB2yLI=;
 b=lqOL710ADYdroNvivLFtJqxDW/B2k0YIEfUdTW1AoSgfn6y4OztdCSKy404OknY/71n9B739U
 SmwXihpZKFcDE83MuGFeiDdNsMETjse/ldrlO+TaBki7RoBzSq0Vn3i
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This adds basic support for LEDs for the max77705 PMIC.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
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
 drivers/leds/Kconfig                 |   6 ++++++
 drivers/leds/Makefile                |   1 +
 drivers/leds/leds-max77705.c         | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77705-private.h |  18 ++++++++++++++++
 5 files changed, 193 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b269d0456da3..7a21e871ba7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14188,6 +14188,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
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
index 000000000000..29db23702231
--- /dev/null
+++ b/drivers/leds/leds-max77705.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Based on leds-max77650 driver
+ *
+ * LED driver for MAXIM 77705 PMIC.
+ * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
+ */
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77705_LED_NUM_LEDS		4
+#define MAX77705_LED_EN_MASK		GENMASK(1, 0)
+#define MAX77705_LED_MAX_BRIGHTNESS	0xff
+
+struct max77705_led {
+	struct led_classdev cdev;
+	struct regmap *regmap;
+	unsigned int en_shift;
+	unsigned int reg_brightness;
+};
+
+static struct max77705_led *max77705_to_led(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct max77705_led, cdev);
+}
+
+static int max77705_rgb_blink(struct led_classdev *cdev,
+				unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	struct max77705_led *led = max77705_to_led(cdev);
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
+static int max77705_led_brightness_set(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct max77705_led *led = max77705_to_led(cdev);
+	unsigned long blink_default = 0;
+	int ret;
+
+	if (brightness == LED_OFF) {
+		/* Flash OFF */
+		ret = regmap_update_bits(led->regmap,
+					MAX77705_RGBLED_REG_LEDEN,
+					MAX77705_LED_EN_MASK << led->en_shift, 0);
+		max77705_rgb_blink(cdev, &blink_default, &blink_default);
+	} else {
+		/* Set current */
+		ret = regmap_write(led->regmap, led->reg_brightness, brightness);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_update_bits(led->regmap,
+					MAX77705_RGBLED_REG_LEDEN, LED_ON << led->en_shift,
+					MAX77705_LED_EN_MASK << led->en_shift);
+	}
+
+	return ret;
+}
+
+static int max77705_led_probe(struct platform_device *pdev)
+{
+	struct max77705_led *leds, *led;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int ret, num_leds;
+	u32 reg;
+
+	leds = devm_kcalloc(dev, sizeof(*leds), MAX77705_LED_NUM_LEDS, GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	num_leds = device_get_child_node_count(dev);
+	if (num_leds < 0 || num_leds > MAX77705_LED_NUM_LEDS)
+		return -ENODEV;
+
+	device_for_each_child_node_scoped(dev, child) {
+		struct led_init_data init_data = {};
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret || reg >= MAX77705_LED_NUM_LEDS)
+			ret = -EINVAL;
+
+		led = &leds[reg];
+		led->regmap = regmap;
+		led->reg_brightness = MAX77705_RGBLED_REG_LED0BRT + reg;
+		led->en_shift = MAX77705_RGBLED_EN_WIDTH * reg;
+		led->cdev.brightness_set_blocking = max77705_led_brightness_set;
+		led->cdev.blink_set = max77705_rgb_blink;
+		led->cdev.max_brightness = MAX77705_LED_MAX_BRIGHTNESS;
+
+		init_data.fwnode = child;
+
+		ret = devm_led_classdev_register_ext(dev, &led->cdev,
+							&init_data);
+		if (ret)
+			return ret;
+
+		ret = max77705_led_brightness_set(&led->cdev, LED_OFF);
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
index be781a0f9802..2140693ce747 100644
--- a/include/linux/mfd/max77705-private.h
+++ b/include/linux/mfd/max77705-private.h
@@ -35,6 +35,24 @@
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
+
 
 enum max77705_hw_rev {
 	MAX77705_PASS1 = 1,

-- 
2.39.5


