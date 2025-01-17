Return-Path: <linux-pm+bounces-20627-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D4A14FF9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BB01885335
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B520127B;
	Fri, 17 Jan 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMyZ9/Al"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC2201022;
	Fri, 17 Jan 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118909; cv=none; b=nlvc3a3wixu0+YKyUPHacIwciY8hA9eyaORV7oc1LTJDSPcgoCp1Gvy+9EP7G1kEkmbDoULzfo97JiLgg2LBDh2Z16+/YHjonfjnKAQiA89JLTnV59kdhpVIvBLbXoWA82w6CEYRJ9y/xluoeQ5/7sTA7mlgA0ahJ3hN8TfKFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118909; c=relaxed/simple;
	bh=xOqBeSBIJwxouVgCQIyYna4a+/oQv9D67CT+l4Jdw+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oszd3Xzp4on+URmBAf+/aPQOPG1Sxe2eYBJugQMz40W6szDYw5lf4aDSfKcpQDdmpr6uziK9cQq25GIWEyWZJyr5bjf8bITVcXTs65TjNhNzR6H5KohWCNZr5h6kByp+7oqThG1g6kdz/s4b9/1a2sROYribyMpL/mO+Re1Rbbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMyZ9/Al; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa66c1345caso119034666b.3;
        Fri, 17 Jan 2025 05:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737118904; x=1737723704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyiorjbF6kcMXz/sUET45sJgYyIj4axNjcybQTsL8To=;
        b=MMyZ9/AlaO2yk5gViHVQiU61+rQlIRlSZapsB3CI9ECS8xl2OzVGvNjCynoV+WmJMt
         TN8VY3+bqHEp9rbN/CQOIwirqyoPmeMwY99zcyfJ71KPn1ybSo2CL1FNHEPfXlhwuSsu
         fbExRQucbAmSQVtxr1biE0j5oFvE+RtIWAyj9dfWoFUnVSn+YgSWThTkPW7TATAUY2RC
         U/u9/9Rr3i2/i1GMv3SgTcGT1biEqHrkClhRmsVGvGrgDlCZOYY0HoACq6FT/DZNIDGH
         RkmP6lGDdc0UO4LIqKAOUzyURGWTGcqrm+0aONYIJQTQpHLewBuCANzqltroZ/WCNGFO
         +Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118904; x=1737723704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyiorjbF6kcMXz/sUET45sJgYyIj4axNjcybQTsL8To=;
        b=f0hhQ5U+yKAGd4inc81ilC8YrxlnIGm7uHtbcHO6wnPZ8onbdq1+ZeXW079BHn66cG
         BkZiXOXt0B531v3fBQHvNi0cLWrYJ94HHEA6qGMsMnPzDI3XkIM8pHPRrRiVCLcsyELl
         AObPyX+V+9kLqZ10JhA8e+h1ag5IlYLQ68KrqF9NU0j7S4+jcq3g6hmHiX2XBSI66vyL
         KrhQTJ3oFQ94vaFdLtjH3PBi09rAc83BwQuBn3i1ODZXabetfPVNE6Fsma8ckoFxMVsc
         G/zWP3CL2p0bvI5JUVCv80O6KFPFBlLlP8DPAlNJLVl156aWkE5QBys6qPBEciF7H3DO
         MXbg==
X-Forwarded-Encrypted: i=1; AJvYcCUAyInDKT378O9RugrR6nvgtLdk/wLxJwv0/X1k1jjz2AlmTQpnOzFZ7aAtB8lt6LkBjMGMb4ve4ktUnp3L@vger.kernel.org, AJvYcCULM9DbjiDzb6aUk9PWYh57r/dmhj+iKb7WSQ3W5D1QUpCbi/A/M/UQEM6YVJ9Ed/o+PkT3YnlQwZrYoN8=@vger.kernel.org, AJvYcCVt64hEdZHzYPe50DLJ/wB50YPfey6t68nv9K46/AGf6tyxthb+D+rR9PDAF584SdU75efJYuBPtzzi2A==@vger.kernel.org, AJvYcCX6CrjEeddbY1ZQl4s/kcr+6+xhQmQ0rSaDK7a9f6G9dv8v7gB3qRmIuhr1RBNbhr4lRHUl1i5QUvVB@vger.kernel.org
X-Gm-Message-State: AOJu0YxhBZf7WmWYh4Rfd790sjdJZBYNGgaggrZsM2pClHVIOKKBKth5
	YiVNKiDq3brVxPCy2FieMZBrbWgAtpusY7/0PGzDuR+vLgi9306u
X-Gm-Gg: ASbGncvNoAOEThjYzm8MpurOYE9GVlQwzbM/RwOGNS9sEP1mTZVsZlx4H4OtfTdFbsM
	0mou0T1wpGxgllD4T1A96Az3mFGjxFgkW4P0Sb5AKUk+GqOIxdGMJ3E45SQg1dtZEwXZHg5Uvy0
	jRnRSOVyUAIv6RHcvWIXpdllmXBkiH7I23YMBhgEmzy59LzuZ958RXUFTU8qoq4IV5kcoBjz3Yv
	mZXa8Jdgq+XMK779GOrQncziUk0iQuySnc8aiS0bLOsaNzpeQyNlVFaMwBjF1QVKQxOahUsy310
	yc2GuOq9i8g3eyWF11/h70Y4iA==
X-Google-Smtp-Source: AGHT+IHMuCdh5KiIXDUE9dey7WQ9OfgGeEkB/d7LiLo6ZhIQcQRogT8ZqKMHoAcg1r1GHNCKHCZ86A==
X-Received: by 2002:a17:907:969f:b0:aae:c159:9e10 with SMTP id a640c23a62f3a-ab38b43bc13mr278955866b.42.1737118904032;
        Fri, 17 Jan 2025 05:01:44 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384d2d69fsm166289166b.79.2025.01.17.05.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:01:43 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 16:01:34 +0300
Subject: [PATCH v16 7/7] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-starqltechn_integration_upstream-v16-7-11afa877276c@gmail.com>
References: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
In-Reply-To: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737118893; l=13442;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=xOqBeSBIJwxouVgCQIyYna4a+/oQv9D67CT+l4Jdw+M=;
 b=LrOxno3wNnQsVbS7MT+CnWvY+r20WiNO6NL1WMp3TWOOqJM0QyTZEMITQZq044iwzTMGkRaOM
 XPkL8xhmWtUCOldK/yv04G6UzbfFKTAiRRLSPuU2k+IY/Gg3FEaIEc6
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

This adds basic support for LEDs for the max77705 PMIC.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
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
 drivers/leds/leds-max77705.c         | 279 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77705-private.h |  17 +++++++++++++++++
 5 files changed, 306 insertions(+)

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
index 000000000000..8be0c455d0a9
--- /dev/null
+++ b/drivers/leds/leds-max77705.c
@@ -0,0 +1,279 @@
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
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &max77705_leds_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to register LEDs regmap\n");
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


