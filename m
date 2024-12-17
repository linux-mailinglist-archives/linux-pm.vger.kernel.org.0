Return-Path: <linux-pm+bounces-19389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5B79F5439
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC20171261
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562341FA8C4;
	Tue, 17 Dec 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7WS3U6t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182661F8689;
	Tue, 17 Dec 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456655; cv=none; b=OPo2d8TFXGCjknORsWkdsfQbze8PPL0Q/YNoMcJlcYTHjWHpLLos3Ity28gwTrxsB0RbuRc4O8F/a/NYaKzXi5EGwkxKa3Zly8SMNlF0ItkHPgRTCKjnLLtf4jJjscPmrLAvGaI8DXkGdD5BSAnM1BSnVgsEHHi77WVnSF6ipGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456655; c=relaxed/simple;
	bh=TiZMVvm+8UQ1HC3K3CjkDCmPUVFUo1nd7pXVHRqG4oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhoXyawUu+TQaP1pF+E8qcqBl81+T3H+8hZAejFzSSURN9Ieo7vVZuM6gi47DxZjQw5qVSP3+CPLbd+3dpuXKqQNWdeWJQaEsGk05FF8HwGN8L2ckkEiqlL+7YbgqZwPf1zOcfvkhnI6zlUQNbClArEE9/k5a371+CB27nvVK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7WS3U6t; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso8442363a12.2;
        Tue, 17 Dec 2024 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456651; x=1735061451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wz2OSQR8MDKMUuykrxBkoV4TSMXKxe9vrA75hma9NN0=;
        b=f7WS3U6thz4sboIwcjXC6ijr1UXNeAbJjvmYm11dNmnlb4StpzP4YvtmEtf7zT3Ofd
         8724gxeYmY3YMQeILZCLHbLxWtEoarcHCd33+05d7iatV5BGEEs52Jwt2erycBrhP42m
         AFJn/yOI7zQcAuldYQp6/92zR+xG3BmrvW9T4bJ0E852r8poBORAPt/DxXSnzENEL5VA
         qDtG0U/rRr7CUv8fVBKQqGnJcYMvUm8pQSgykVDtECli+KGMpHeS0QlFPs+CWH+ZrjUK
         toAkamgZCXkzCgbDPFmZwjMALCjVVo/cY2mX4gB12zWuqtaelHslv6XZUbijgcm54AEA
         Mvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456651; x=1735061451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz2OSQR8MDKMUuykrxBkoV4TSMXKxe9vrA75hma9NN0=;
        b=hqRxoit6OgEOcGWOhDbpx+xAOerdgTRh29NtL72ji4byVquhEYim4GgblD+bRyq8IM
         7p5V65naJp5qlx7b7efRyP+SA3/h54UdneIW76xMh7IpDpOknBiKKQIF+HISnUbGyeiy
         KqcKlFSeOyBm5KUlE2VeAa51vwsiOv/HNIUcM3lT871SkaCwc2xZQ0mECyNPuP+s8IVe
         miM/2TYjAiAlPPZ33UZERqm9G2yhcaKO39WtRxGdH2Rz1zSFKVdTiX7CwAD+OtQRWW+F
         kMZmN+F3IKrcDxqREPRRRpnDQtGs9dJqzURRsdMiGPMXDxiZctW///PQs9OJoppEKYn1
         E/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5W0pVbEBkL9l5agSHrkT9MqnGuvGMPs4SFThdB1th5fMH9TZnuj8/SBMQ4J5/motSx2pnLA4OiYraw==@vger.kernel.org, AJvYcCVFVCAWTZ9gSYfzz4h7dcac/KsGubAGCEWg6iI8yHD2CLpwIyh5cwVZN68mQ48wmSCxMP9zVHosy4t/dmQ3@vger.kernel.org, AJvYcCVqJeQAOBVDFPsf7TfplC1b/uiFGNJ6B1ul1V7a1ijRqk0VUvb3Rqs10rjJUUi1K+h6tJDO5XfdHQxm@vger.kernel.org, AJvYcCX2alyuO5JhEsdWctvCItjdVwsNY2cmkxE5jiFOnNzrikb78zOLaG0XI2mE8HG1GdIi7l53ZKPe8MTDjoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4IqFy/XSs4S1IovcbofPQtkUYMk9lj2FnctVNIapRUjjxg3T
	X/35SbEQgzUuwTjahfjjLA8n5LoAXOo02DLNUPXwXeqIso4EhR7U3xBN8g==
X-Gm-Gg: ASbGnct9NtDESOxySNTy06W/fT1n0uzaoxA3zTaORmdawW0hdocoDqQKkh/bwSWYqHv
	Zs5CH6I7ujoEyAiIONvnf8SPtKrhrQRLubXARSobP+MHUUm92tPkWLuc9AJmzyp9rQ+to7jDks8
	yIvn6FMGD3X6hvh346ZW0nqWEJmFbx366qz5AQFsxQKGs0NrvQbOPYk85aPp4DQEQS22sHV+ZvV
	7CtHIRhcHuv1gwPrGly5SGBVSwg9OY+6nxf0U8+e/JZSI+gyHwGogM=
X-Google-Smtp-Source: AGHT+IEiS8Z4L4SSyoGV4OrCB9URCPRX2dLT92jICNvvUa5aqi0PzQv3oXCEi7CNW4nfGjlBPwKsPA==
X-Received: by 2002:a17:906:4ca:b0:aa6:a9fe:46dd with SMTP id a640c23a62f3a-aab77ea53d7mr1861991966b.38.1734456649710;
        Tue, 17 Dec 2024 09:30:49 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:48 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:09 +0300
Subject: [PATCH v12 11/11] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-11-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
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
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=12909;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=TiZMVvm+8UQ1HC3K3CjkDCmPUVFUo1nd7pXVHRqG4oo=;
 b=VVoBJT/UHQf9OwsXKlQGMHLYFfkozC3/Cv0W1MXSi5mjz1KH2Zg1EhBQALyDGBVQqRaMQFzmV
 yeaMmaduNwBCkFgkXgF8uI3Y1lVuYj/OIfD5WbKHs8ZkjxzQ2MYDB9U
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This adds basic support for LEDs for the max77705 PMIC.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
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
 drivers/leds/leds-max77705.c         | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77705-private.h |  17 +++++++++++++++++
 5 files changed, 294 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 587570b12306..d21afe41ff6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14237,6 +14237,7 @@ F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
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
index e4309d3b6f2a..41bc9d1188a9 100644
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


