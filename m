Return-Path: <linux-pm+bounces-14820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731DC987161
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956791C23F4E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D221AFB1A;
	Thu, 26 Sep 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6pgX5qs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410F1AF4F2;
	Thu, 26 Sep 2024 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346072; cv=none; b=TvgSW+KqimuiTERNVyB5AnrO8rxIJ3S0QMm9wTpJZx160l3urE+6Mze1HO5SyFKI/F2lMU8f5azvIzUS8EHzZWC0MoIGmtPVUvFPYfcvy2fPL8jV4aFs0cxg33WMNcsnL+r98gsZk2eZrJxgZSHTouUpHeoGXEMMrgN1X3DK1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346072; c=relaxed/simple;
	bh=ggv866krfI3IOdjHfV2G9/rH2G2ucI4aiHOZpBnyZCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+u4/A9QLkvvwH9dPKy5OWJ2o0hyJN4zLeD/8AI79a0yOCGWpwziZuIgnZdeF+hr5ZVb8Rn4Yri8sHkP4AIfaN4h3BzHeuZRmaQHhqDKEdbhKR6Qh/1wyXPiAvZsouuJJP+gpUYVJ1Hfsdu95Ce2eceTSBSfG9LStsiekp9Yh74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6pgX5qs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so9267811fa.1;
        Thu, 26 Sep 2024 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346068; x=1727950868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hctV0d113DynEI0DnnWoIOQtcCpUeJRxl1mrlI4KZWs=;
        b=T6pgX5qsmviT6E3zGlRaPbFQ9lM2lN+O0xyy344m/+kDDC0CUC7FvF9rw/6yMgy4jG
         i4aWuWHwGD8tLm08bQUJHbzuM4lbZExVekm29cIl98eXYjOaGNzX3THbgV6XyA3Y+nkS
         GebDOrgqH0qsVGKhaGapGmPkL5KrvaQFJXP0TUgRoqVK0017/r+S6ie8XfX2+UkUTNC4
         /eWT/dxpsTJ7frXKw444GfHsHfZJEO5/hNbk7en7+hrJQi+RcEGrpyPgSeCcfDpiN+sX
         rRNY4F8FNFWTADJydMmKHnFLAIfOB+F4DejJbxrDUYMaIjLFJqs/cvDvSKN7d9YLWdr9
         0WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346068; x=1727950868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hctV0d113DynEI0DnnWoIOQtcCpUeJRxl1mrlI4KZWs=;
        b=rxwx6HJ0URzg3DNL6kec44sZivWNXdUetM+wSsS21yCMMqljyhG3NejeO27lxo4rre
         dW0okqOd5xhwfNqnr9qx2F6W7CD4R3kr9ulxTJfBBvgljm8sJwDn2mwumHsJHq8InkHj
         vsq9f/ZLl92FK8UtOaV5nkWElQ3VwJn+XVbtdm4Zy7uFxjYuGRCbefpYkzyw0s4K/S59
         c3xZg7a6koTorFFbpwLfu/qTUmnhMkz+KRxqaUrEhi/0G4SNkA60F1XvUytp9XM6s/01
         c5FuONjUOvTMpXG0+/+LhFWnTrBQhZQ9eZEjDc+6NOynw4gDT0lAtWdvnzlB2ZzVD6fY
         drWg==
X-Forwarded-Encrypted: i=1; AJvYcCVa/6SQpA/EJGLpdGvp49wSNcCyOhhqc1kD7Z41/1dIE+9PP7g/IAPeDFZMSjDJ40WUJv3nya0GEljXWw==@vger.kernel.org, AJvYcCVsV2n3fERthcegi7nD4MjwyC/z66LHGYnsv0J7yKgk2EskZezoJMh/mRJPgrefNAfUJJS599EIU3s2h2+t@vger.kernel.org, AJvYcCWbAPGXX2ynsLdY7cXXJZZjBr5ZZaoTMSbmF0WXU9KmAF4kuToYj2XKx9J+7bmEKHj+TWsXVeShstTkG9k=@vger.kernel.org, AJvYcCXguUcx3MrsxCTeRv16qeQlfSBeyoPEJeLsJjeuEipTTLeJkQdp9ceMwV1qSkut7aIL/XfCeD/Q11VQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6MxVRUAicozw1eiktVvnhhSJQb1UfMoPzDSbU2syysA85LHH
	aSX5slNaDotpZLMm/eMiYXfyZzeMqG201sPfFJUJoO/SbCkHB5HSDzJY/Q==
X-Google-Smtp-Source: AGHT+IG6XPSvZPE2s/YeanEABUzbGl4MV75iMai42OiVbePz66YsGF0V3Wbw2X0jmspS4SXFZgfjPw==
X-Received: by 2002:a05:6512:128b:b0:536:54df:bffa with SMTP id 2adb3069b0e04-5387755cc03mr3767539e87.45.1727346068226;
        Thu, 26 Sep 2024 03:21:08 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee54esm759071e87.96.2024.09.26.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:21:06 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 13:20:24 +0300
Subject: [PATCH v5 7/7] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-starqltechn_integration_upstream-v5-7-e0033f141d17@gmail.com>
References: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
In-Reply-To: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727346045; l=6867;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ggv866krfI3IOdjHfV2G9/rH2G2ucI4aiHOZpBnyZCs=;
 b=e9Kp/kKXhBaZIpJZZafLyD334j2QBxRMpGXnVg5em2noLh44KorysHU2oG+7BPIxs19t+cIV/
 0ejLd2uDK3BCZ69xMcNeGAjuQuHvWcqd1VB3n8O06ajSMZ6najNEFHU
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This adds basic support for LEDs for the max77705 PMIC.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes for v5:
- use same hardware name in Kconfig and module descriptions
- remove copyrighter owner from module authors

Changes in v4:
- inline BLINK_(ON|OFF) macro
- remove camel case
- drop backwards compatibility(new driver)
- drop module alias
---
 MAINTAINERS                  |   1 +
 drivers/leds/Kconfig         |   6 ++++
 drivers/leds/Makefile        |   1 +
 drivers/leds/leds-max77705.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e45bbafbb938..8f26416617a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14077,6 +14077,7 @@ F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
 F:	drivers/*/max77693*.c
 F:	drivers/*/max77705*.c
+F:	drivers/leds/leds-max77705.c
 F:	drivers/clk/clk-max77686.c
 F:	drivers/extcon/extcon-max14577.c
 F:	drivers/extcon/extcon-max77693.c
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b784bb74a837..a8492623caa4 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -753,6 +753,12 @@ config LEDS_MAX77650
 	help
 	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated.
 
+config LEDS_MAX77705
+	tristate "LED support for Maxim MAX77705 PMIC"
+	depends on MFD_MAX77705 && LEDS_CLASS && I2C
+	help
+	  LED driver for MAX77705 MFD chip from Maxim Integrated.
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
index 000000000000..50af81fb7324
--- /dev/null
+++ b/drivers/leds/leds-max77705.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Based on leds-max77650 driver:
+//		Copyright (C) 2018 BayLibre SAS
+//		Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// LED driver for MAXIM 77705 MFD.
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
+	on_value = (((*delay_on < 100) ? 0 :
+			(*delay_on < 500) ? *delay_on/100 - 1 :
+			(*delay_on < 3250) ? (*delay_on - 500) / 250 + 4 : 15) << 4);
+	off_value = ((*delay_off < 1) ? 0x00 :
+			(*delay_off < 500) ? 0x01 :
+			(*delay_off < 5000) ? *delay_off / 500 :
+			(*delay_off < 8000) ? (*delay_off - 5000) / 1000 + 10 :
+			(*delay_off < 12000) ? (*delay_off - 8000) / 2000 + 13 : 15);
+	value = on_value | off_value;
+	return regmap_write(led->regmap, MAX77705_RGBLED_REG_LEDBLNK, value);
+}
+
+static int max77705_led_brightness_set(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct max77705_led *led = max77705_to_led(cdev);
+	int ret;
+	unsigned long blink_default = 0;
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
+	struct fwnode_handle *child;
+	struct max77705_led *leds, *led;
+	struct device *dev;
+	struct regmap *map;
+	int rv, num_leds;
+	u32 reg;
+
+	dev = &pdev->dev;
+
+	leds = devm_kcalloc(dev, sizeof(*leds),
+				MAX77705_LED_NUM_LEDS, GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	map = dev_get_regmap(dev->parent, NULL);
+	if (!map)
+		return -ENODEV;
+
+	num_leds = device_get_child_node_count(dev);
+	if (!num_leds || num_leds > MAX77705_LED_NUM_LEDS)
+		return -ENODEV;
+
+	device_for_each_child_node(dev, child) {
+		struct led_init_data init_data = {};
+
+		rv = fwnode_property_read_u32(child, "reg", &reg);
+		if (rv || reg >= MAX77705_LED_NUM_LEDS) {
+			rv = -EINVAL;
+			goto err_node_put;
+		}
+
+		led = &leds[reg];
+		led->regmap = map;
+		led->reg_brightness = MAX77705_RGBLED_REG_LED0BRT + reg;
+		led->en_shift = 2 * reg;
+		led->cdev.brightness_set_blocking = max77705_led_brightness_set;
+		led->cdev.blink_set = max77705_rgb_blink;
+		led->cdev.max_brightness = MAX77705_LED_MAX_BRIGHTNESS;
+
+		init_data.fwnode = child;
+		init_data.devicename = "max77705";
+
+		rv = devm_led_classdev_register_ext(dev, &led->cdev,
+							&init_data);
+		if (rv)
+			goto err_node_put;
+
+		rv = max77705_led_brightness_set(&led->cdev, LED_OFF);
+		if (rv)
+			goto err_node_put;
+	}
+
+	return 0;
+err_node_put:
+	fwnode_handle_put(child);
+	return rv;
+}
+
+static const struct of_device_id max77705_led_of_match[] = {
+	{ .compatible = "maxim,max77705-led" },
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

-- 
2.39.2


