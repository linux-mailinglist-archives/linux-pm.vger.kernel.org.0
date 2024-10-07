Return-Path: <linux-pm+bounces-15286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665D99323C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A34A1C224E9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ADF1DC072;
	Mon,  7 Oct 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ+r+h+S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119441DC05E;
	Mon,  7 Oct 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316588; cv=none; b=kaJlz5UtSzM2gPVQ/xz+MY4XrgIUyI0vpMw8b5wDIizNJRVkLqDLxfl2vbkNJQAnJQl4A2mwQkQNBy7QfuYEJn0bEfe4KHK04tB3WONnJcaQK1iY2VYt1svNtea7rw92jNt9ajAGUWhhlTdmGRuNu1FloyGW5DD3SiaW3CsdSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316588; c=relaxed/simple;
	bh=2raYLBH737tChg0ri8TsnhxUkUT8QEpTAvSPAfmT/+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MA7tXUn32AZWv6fR8R0u2zHW/otoN3QZ+nUzICkvq8f7Cx4S5LWW/OlO3WafIp5hHaMbCEfsnngG4Xg2ChaaYAghWRhxtYdYg2am9cKmgoKXzm5Ea+X2ga0cp5Cy+5kGoQEJOzAEajo5HDf/NUOMvcXC0tMAXrZaNruqu7Mjssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZ+r+h+S; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso52451591fa.0;
        Mon, 07 Oct 2024 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316584; x=1728921384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QGbEBqhdJ7KHjxxKfMnoNRb6GrNz4SfpC7hS3CQwK8=;
        b=nZ+r+h+S3lm2Nkd7t1PLoVVPOhvl/LU7veM23Zw2iGWggvg1zyNC2sD+bwL9Z4OWtf
         TOlnkHUfq93ogU8z6Txj24xPP/E+UcUvbFhsrsUXheru0wsh/3d5mhtQ1vEiXuVkle13
         v+z4SgLmrhn+0HJYA9Cnau+hl9Yvn2mpRnrcIOMWQJimwoTiln8FHQsPSIpcGrj2icOI
         DBHY5U38M3NfIkomIGfo3ySEX51ZvJito0iB+VMnx/5S8obyYhb3V+S96VRCApWFWSTy
         3gqgUKK+IWZh/nhoISYir9ZS1FpDhU4wj8ipi7j1ic8aPLLY1d57VtkDOrGcOpKRfEC/
         FqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316584; x=1728921384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QGbEBqhdJ7KHjxxKfMnoNRb6GrNz4SfpC7hS3CQwK8=;
        b=epQjxbZVU30LNqj7yp560NFOc0qpdkOZZF6JI4401t7xDocPEQnFzr5LJdrfVhckKf
         BKwl4/BMf1FpDye35pfSXRVbIrUSP6KQXpsIh840miylBzDXCJMgDI1Ensq9lzF1PkZC
         dAf9KKlFUoO0bMfngAalhBMJLyVHsxIVpbuqWQznDyZTQznrRs5NjLWqwAuo83OJFtM1
         RSkkkDwbRXSt6bm/nkT9dAn50/AdOz6sjLptLk88zZ2QTX+qINnA0z+UO5YRFrFSsWgg
         0CCpRhM8UYApvZJGJDw4Xveca+ZORfM3c0SZlIdsVKa1u27QcJYygsQQEDcgX5nRj7VH
         yvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0sV1Ct1iNHweLVXwnT8ClcPeyPdJoq5oHh8r2e17L7E57AKVsLavF+BcQZbNVzDUn1oxjfthyPu7QGA==@vger.kernel.org, AJvYcCV4LTJ3wnVN8tolXKQXf0AyT2e5v0bgZ/eWF6OygJdOT2KYqRqogLgpmDu7KHlyWtWYY0NDQ3ZsVRus@vger.kernel.org, AJvYcCVgxsmGOl8mDUi51tshh2Nw1fKbFG0gXBwjnCHy6iRWfYNGxyPH4PRaMD6KdnMKQkWszozIdQykh1dYMPQ=@vger.kernel.org, AJvYcCWkTjtI3OCoyijiyYba86zuZxytSwXlH6Hz2olYP8rvNKTSI9z2uUm46PBmpKLfPfhpbFAM7pRkCsqKTvkE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zdOlF493jtdlrq2Z2Syb1GeJUEn7m0QYe4kyhBSneoBuge4g
	ISCGXP7TJ1iwWpizfGHihPGqYZMo5kZO44lUboT07vRtdyhO7GFjRIn7Nw==
X-Google-Smtp-Source: AGHT+IFfWayDUn5tUQ+mRWrbN70SLXUubavxgDxHrW6x7pCrIzFSNSZAJv0RmlzertMKEntitW87Cg==
X-Received: by 2002:a2e:b162:0:b0:2f7:6653:8046 with SMTP id 38308e7fff4ca-2faf3c50c27mr48820201fa.25.1728316583754;
        Mon, 07 Oct 2024 08:56:23 -0700 (PDT)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-75.telecom.by. [46.53.210.75])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2faf9b24a22sm8552461fa.93.2024.10.07.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:56:22 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 07 Oct 2024 18:55:55 +0300
Subject: [PATCH v6 7/7] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-starqltechn_integration_upstream-v6-7-0d38b5090c57@gmail.com>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728316556; l=6906;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=2raYLBH737tChg0ri8TsnhxUkUT8QEpTAvSPAfmT/+g=;
 b=CjcQYdRFi0KuMqnwh01K552FLg6Z6+1HkJ7OKGfAObwYYy3Edofm6NCg6DUNVt3gwtFPTGCfW
 PbmDHpURnmBBtkGq2GhJrFbqjfiYkMVglLkh7yf/4aHrlX+HnN33t+s
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
 drivers/leds/Kconfig         |   6 ++++++
 drivers/leds/Makefile        |   1 +
 drivers/leds/leds-max77705.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bc9c0da6adb..66a1dd7577c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14079,6 +14079,7 @@ F:	drivers/*/max14577*.c
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


