Return-Path: <linux-pm+bounces-16330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5474F9AD51E
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 21:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C531F20588
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7B71FF036;
	Wed, 23 Oct 2024 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAX/WA5/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79041FE101;
	Wed, 23 Oct 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712597; cv=none; b=pfoNYfzA6qVJnwYCcg+ssKb/n2unZIuDWoJgJgWBKuwpkL3YBv6uTh9ulgTmAlkR+GgYBHJksfXXLY0nk245p9ZquImRIYLCkayt7uzGiw5QxprYyPugyK8noI82jsUogTt7m/ShQvtqlDhMraw0MDJHUk2lXMp1ilXCoJCsRg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712597; c=relaxed/simple;
	bh=9WJ8S/uipIPxiGfe4mLyTfT2gjVM59K76l71woFhhQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MegZO4wWvX+Ll+h476FZTQg7YPYhHEu++KnFuG9QTTmSa6nVEMnke9KdjphQjLRPvh0kOkJ3Vj1i1EfFMvL5ZfS5RR1uj3hKbY5Wa7mfS3mMXH6r0Xkhs73+jFDaxhfcnTi5OX9ewZZMvvllqvJQJiJDt+8PcGGiQrc4vV29/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAX/WA5/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso177191a12.3;
        Wed, 23 Oct 2024 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729712594; x=1730317394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8/q+z6hhLbXUdIRPd60V3PEMOvkNSPl6LwIAH68oig=;
        b=NAX/WA5/FOJbxDP42hPlRf8Igh9JIM+rzI7X3V9dvS924H2+qopBkrivm5bNaOATaz
         sKZfXpSC1X8K7AyAOlL5574e7yMKcoK9857VQ/OPlYYUaFfep9HTaT2bLDOzs1/X6+Wp
         Y3T+mqg2A222k7NlXBXwFYyQOEuWwOm7qqoQ0YDT8+u3AxdrE6R8LWyPt/Z00hBGhVZR
         kCHe80gmZy5Oply35+bYN1rAf+PUnbNUp40YEwt4mRWQ+sEPCtH8l8rgzUxrZOKcqqh6
         Nvjda5joe1hXmDSi2hwvFSHCj1kTCUIkJQD9RFS4RGRgxrTe/5EY6wUZjCkfOWpitMTK
         HPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712594; x=1730317394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8/q+z6hhLbXUdIRPd60V3PEMOvkNSPl6LwIAH68oig=;
        b=QVUmnYNzIu5u0DSC15UgsvGEl3yiimu3ixBzMWtVT3yw98Kt/+Igs5toqiPVQNGATp
         yPD8JQ07Tp4LXqGUY4fwWN0RJot1c1yxJhxp+jJ4Q0FG3ImaV5nZHDgdPP2V4mp+DGYR
         kbjifp30Agiu37KIqpMUjrtW/IZUzPJTo+Y94TrFe97QKKJe49PPeOHmhIlTib610BHZ
         sqg9GODkRC1/w/u3wJ+zbv4gbgKq/c08XSxX7HnFUi+0dBOyMA271/A1n0HMrALtJWJZ
         vZnR+RJgpQMEwUqhxPxXZa9L0Ag2rmhSDh8LIdAxZu9Oo7Y6inkHrYD7JsIWuxhYCY4F
         0uqg==
X-Forwarded-Encrypted: i=1; AJvYcCUNGFlC7JsFdmWbt2Euo+aiJULw6J6eTDTP8bUd59kvXO7bDLcfJTN00mtMmNHMvEWtu25N1snx/pkJ0A==@vger.kernel.org, AJvYcCVVV9cBfUyfHQnr80XpZFd0WNooaUlo1gM7LhVmPC6E6ES+Q6bH3B+1raj4XdQLCx3+L5Z5gYFiA1B5jJQ=@vger.kernel.org, AJvYcCWE/07yuuLzGMRdmnCDZbr3fPNc/DrCfi7U3zf37uOOlNZEzZO3PfMpkR8cKmWDh2ODQS+1P1TVWVlJ@vger.kernel.org, AJvYcCXjXpyv+J+yQZKOk+yFvaK06eZbf2DwF9P7hnZi22h6ClQGs/rwdkHUjjD6VbQBcCVhwuIBO2xbw87KFPb7@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZccDkbU7clEPH0sZmz/JyO2A3dkrzXEmoElVkDPahGfzNHHg
	3IE83B0ojcKuSWhaen5cJbAqJPUwfojnqhhUxtUYh143Tb//8bWkQzTbGA==
X-Google-Smtp-Source: AGHT+IER2XZUJhVGUdudfWO/Wrth3J7SPV44qWzz9VwYrcI37W7IfZTEjLibiPy9nuwD+fJkoRpDTg==
X-Received: by 2002:a05:6402:280d:b0:5c9:62c3:e7fd with SMTP id 4fb4d7f45d1cf-5cb8acecbbamr3476697a12.16.1729712593623;
        Wed, 23 Oct 2024 12:43:13 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.244.166])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1d8sm4803940a12.72.2024.10.23.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:43:12 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 23 Oct 2024 22:42:55 +0300
Subject: [PATCH v7 7/7] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-starqltechn_integration_upstream-v7-7-9bfaa3f4a1a0@gmail.com>
References: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
In-Reply-To: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729712576; l=9269;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=9WJ8S/uipIPxiGfe4mLyTfT2gjVM59K76l71woFhhQQ=;
 b=Shp9+oGRxlUY10hJIajAquV7LpNsxWJov6kwPtlCjf+dtnZegEeNYfoHAS0sX2YGNenN4FO/L
 psq/cDjVtpUDk0DGLJBxQ7pxSpoErOIE/HaCWjF/50bxYYwGmJ5bAI5
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This adds basic support for LEDs for the max77705 PMIC.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
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
 drivers/leds/leds-max77705.c         | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77705-private.h |  18 ++++++++++++++++
 5 files changed, 194 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92700fc71db1..b3076fa66d30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14119,6 +14119,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
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
index 000000000000..f0762216c4a7
--- /dev/null
+++ b/drivers/leds/leds-max77705.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Based on leds-max77650 driver
+//
+// LED driver for MAXIM 77705 PMIC.
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
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
+		// Flash OFF
+		ret = regmap_update_bits(led->regmap,
+					MAX77705_RGBLED_REG_LEDEN,
+					MAX77705_LED_EN_MASK << led->en_shift, 0);
+		max77705_rgb_blink(cdev, &blink_default, &blink_default);
+	} else {
+		// Set current
+		ret = regmap_write(led->regmap,
+				   led->reg_brightness, brightness);
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
+	leds = devm_kcalloc(dev, sizeof(*leds),
+				MAX77705_LED_NUM_LEDS, GFP_KERNEL);
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
index 6eb2b2e07c12..3a9a0a3bd97e 100644
--- a/include/linux/mfd/max77705-private.h
+++ b/include/linux/mfd/max77705-private.h
@@ -34,6 +34,24 @@
 #define MAX77705_SYSTEM_IRQ_SYSOVLO_INT	BIT(5)
 #define MAX77705_SYSTEM_IRQ_TSHDN_INT	BIT(6)
 #define MAX77705_SYSTEM_IRQ_TM_INT	BIT(7)
+// MAX77705_RGBLED_REG_LEDEN register
+#define MAX77705_RGBLED_EN_WIDTH	2
+// MAX77705_RGBLED_REG_LEDBLNK register
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
2.39.2


