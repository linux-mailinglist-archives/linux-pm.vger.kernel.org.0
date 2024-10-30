Return-Path: <linux-pm+bounces-16778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D589B6F04
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 22:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB65CB22961
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4921B446;
	Wed, 30 Oct 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnyLaqha"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230421892A;
	Wed, 30 Oct 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323867; cv=none; b=hIXzrkuiiPFAIr12Nmh6ePUZ/z/0RI9qfo76a0NJSC2iIGwFmpS/08sqxJmAJZU01M/gvdIe43wHiKC8igzqIXI/GPqkq723iZBxY2SZjbJqFI1LtWn3qPuY8NcMNteofgNN/BmOMvigUCsnSEqdVwZ8FrNJOGUn/buJJ1MzvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323867; c=relaxed/simple;
	bh=LDcJs/S/HZMhqvDO6tymsbjZuvQpjDiUW1vyZoButho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAam7HMphfZ2lG2SzBD9WCcV4MU5Kg6S2Wq0s+zgxkiHjrflUJWzRp2406yvqYaJXFiMCb9JLHyDt1/qCvpAcrOoo2dKlwEfx1FtwsNjddPvotYDsFa7CiX1weCYnxGCi8B6ZOrmhhB/qNQC3tvFBTauNiamvNPrrW6X8oRexBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnyLaqha; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99e3b3a411so216202466b.0;
        Wed, 30 Oct 2024 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323863; x=1730928663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xutnGVubPY9FW6YovNGudI/vIksc2qUk6oKLjYM/WsA=;
        b=hnyLaqha0VEFsC6MysBQtio69VwnjxSzzQe0LBVlFmKJdpKp+lua6sXxx1/FyKBFXV
         mUgqmqLDmKkY6eCWCaf1k7IxUo27+bEU2YmBTR7Ld3rg5dBAD3cVgIW5xaHDq2GS0gkb
         THkF6e/bvvm0ILkT7BtwkdOKIX7mWBhibjrGnnWqIKlvzq+ol8QbrdNCZ+Ij2lxA1rlR
         +tiaydp9qaIusrIpcAzFW4qtuGT5bzmnKfvJE/R7Y8HcXZWG0ZtuIVoxvMvjuwJnMonu
         SQYBSwAsfIraGHBjUYO/CBe3SBqwkjgCoyErEoL7ySv8k2V1XKnD+Xoaw2t7/7T4/+h2
         i5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323863; x=1730928663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xutnGVubPY9FW6YovNGudI/vIksc2qUk6oKLjYM/WsA=;
        b=o0ZBpne1eHdT8FIyY/W0LblRZgT/oULkP4tGJpWSY4d3PHT1jZ0Asg8EQlqXDZhUmS
         oJmkrWNh/NneU2ecvl7soI+R93bSnaFyF4dqa1pZLTq4lL4iChWIaPfyl3ONAafMAWZ3
         zwJflXMwhBZMb4zmIUtkbENAW/d87r75d1bZGk+Pjeoxsa7qDmYocXq/laqfFmZdZ4Wp
         pjbe47bS9aNEdYa2+lBFctim5Zpoct6eMbEyYV0jLzOr597fZpcEiVNuqpRcsa8bA03O
         PUIUM6u0UnZU8N5LHhhUENiZFeqZDOuDjx+f8gKThRpgi9JUWAipQex6AYgsgFiWAWAL
         IC5A==
X-Forwarded-Encrypted: i=1; AJvYcCU/Lp8cP7bBHMHBXXB3M7vxbuGus5Q+0Zyj2ENtXn4q3RYt8OeUXmiYAuvjlgRJQMAf399wRi4+ZD4rmqLl@vger.kernel.org, AJvYcCUbsKHCFtrkxJt8XBmFzECLbwTl4CTM3P5VIgHyp+BaeOqxIxSzFVGtcgcd0/T3EvX+cWp5q4KV5mDy@vger.kernel.org, AJvYcCVpBZHz0b7S8vjGwWhQPywKq5t8FSRFqXMbiMJoU/rH40i0TaePZNNri29IlMw1nwR6G61Yj0+foIeT2g==@vger.kernel.org, AJvYcCXo+Dm40rp4qPafVzoDKY0rcdat5m7Idb/CzCQbSqEtGXeopl8vKTTHinBut68VqkxKqf7VvAmAlfhnEiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGVqobjkeoAQehSZVOcieKEugq3wV0NONkdYR0BuU9/rOW+V5
	R490GffDQlYL/aU+kTAMYfT6fz+Zl6EmOECCU5T4cSCTDqrXW8Bk
X-Google-Smtp-Source: AGHT+IGgY+CXoyPC+PnGIcWDGXxubI+PXzQoDZV4TWAjnfr7l3Vzq+KHxEoDGeM1XnjBzf1ghTx+iQ==
X-Received: by 2002:a17:906:dacd:b0:a9a:a3a:6c48 with SMTP id a640c23a62f3a-a9e559b498dmr17624566b.2.1730323862220;
        Wed, 30 Oct 2024 14:31:02 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e564c5410sm687266b.57.2024.10.30.14.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:31:01 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 31 Oct 2024 00:30:42 +0300
Subject: [PATCH v8 7/7] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-starqltechn_integration_upstream-v8-7-2fa666c2330e@gmail.com>
References: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
In-Reply-To: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730323840; l=9372;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=LDcJs/S/HZMhqvDO6tymsbjZuvQpjDiUW1vyZoButho=;
 b=vVmd3XngUfpTavHnsEUGMYVN8la17Msrck5JkywHPxxYQOJIDur1HWuEmEechF+wJtSfDl03Z
 Dj7J1SNoMqfCUVNlsnGzuNqnegV6bt42/z3gRbM5hE9HmdZGZWU0DtD
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
index 126f2fef0a6d..2416d8faa2d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14134,6 +14134,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
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
2.39.2


