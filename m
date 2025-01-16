Return-Path: <linux-pm+bounces-20571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19793A13F76
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7003ABBDF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A32361C3;
	Thu, 16 Jan 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5syAws1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754622FDEC;
	Thu, 16 Jan 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044786; cv=none; b=AqjX/Zsa8pDzp6pbJznmE+72P8TaNSG1ELZm5HXSP6Yq1fy/YViZrA/L9svO4FyN/njo4OERB8o5JT2NS4c8odCdd5Nqyre5JD9AZCVWYBGBOG4mdEoHHxeAfnQ3ZDJjNP6vVLAJictV+3nnSaDHBdm4rLnlcHkB5hCDwfd54kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044786; c=relaxed/simple;
	bh=xOqBeSBIJwxouVgCQIyYna4a+/oQv9D67CT+l4Jdw+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBdsjeyfAkhYlrF2IFdIRWJ58bUApa7a04o3fQd5jPIfGH27bgOzX+f2SeFIx3s+mswWJ78fsO4Zta4hcwygncKf1dQc1hVP0qfvh3+LkNLqaAS2LW5IKhtwQr11BS/131JmH+DHm1Vpu2dwgRbjsZGvnlsPiD58tDp0apnqk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5syAws1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso198516366b.2;
        Thu, 16 Jan 2025 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044782; x=1737649582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyiorjbF6kcMXz/sUET45sJgYyIj4axNjcybQTsL8To=;
        b=G5syAws1LZ+soMzUagAP89qpA8Kz9jumNAbhB6O8K4Wh5mrcIot/j/ybnnUrU4SUnn
         hQGloWMbLJdR7X+bGlVhK0z4x2RmJDP1BIDlhPdRBpsLvX1yn1A2WcPUrnY/fpvZsaPv
         5heQGqPNyW1EftngetTCadb4TvlSkGh7ogVjwi1qAcL+m+ND6dij+yf09PQuhTQ1dYz/
         XNnBbouCcDWF7heIttKs9JllYCVClxf7vhsYj2aDOyQcC5GSiui0ZpN/jYVfX/1KJzVh
         aasWS47/N8jhCnKHzT3+FS205pftiVirKnxvU16YQOlqDtVUkGVOpvGRiV2w4wVGhhXH
         6HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044782; x=1737649582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyiorjbF6kcMXz/sUET45sJgYyIj4axNjcybQTsL8To=;
        b=uygDvyFHw7U7Gu+ZdrYIhUbx/8KhPQ1og0x8KCmfIkMcJUyDXIU8hBlKrNgeUf1l09
         pjrj/er6g7uQ7+cXDTI8bKJcIdoQKVbiOzJC2aOkIkeNBdIUuyKPDfgTOeYV2qA5/AVe
         kv4ZB6YInPJTEGzD4dy73IJ2nPZfldNE4bO3JsfHQW99vWU7KOwkFC+SFWLx8DpdD5JD
         ZS8itOoV0DRhXBzJTes4QqkCp/AQgyBHvOmXxJ8oDAPi8cFshFmYmBIh5/b4aLWSYGyH
         v/2EcuDbnLnF9yIZs5CalX28C23m5CbZpJ/x6ev0xdh/p20BLqfZu+4pskearMMDT/uw
         S/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVteJOwVPPCmH4VkiidJbHZb/wtreflkz2a7RM4kTYf75py5vTUBnl5Te15Zvcf2Q6F1fy5l8gk88Ax4Q==@vger.kernel.org, AJvYcCWK7ZzMvyfITiV1aUCsFONZqb+wEO/bTZ2kRX7UxaKPxeBZyI3GjaslT7OqekETdH2KZ1pGCEcYC1tFxY1A@vger.kernel.org, AJvYcCWM9uXQ8eSgYsVqIeXjSakKVdYpWufIWd+kIEdAVTdmTWuOCTKVhQTQ+Nr85+1OSeZNbd0p+H+0QTZm2ac=@vger.kernel.org, AJvYcCX2RKUSBYBUm9chnndOnYB4DPfd+/0zKGedCF3079C0VvqDtzdGIB+zcBBI0Co5UakPslSpZqtHRPWK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxi7ZUzTlnl8uKbobWzmMgTrmSmpIg2u5bLjaOMGxz/VsXpkGB
	3a+lYC5VR7OgYuKqFa71IvXnx3wNLaHxfG2NLYWeP/USJLmhSNuB
X-Gm-Gg: ASbGnct53IhMIMxiUtdVd/dbC9JfhvXtZbmm/V7FNPbRqD3LArz0LjnDrpedM82hwHC
	ZzHYCWcgEpQYl9W6eSgnDA2TE47xHP6G1UVYcX9UHAHV2NdiadF6lpwvoUp4sfJ0N6AckqnH85k
	JOC4h5YkMJ8isbXrt9rfd2RK5MBD7QFTJGxWNO5jdfmEHNnMwxlN/0K5Ln4HHPfc2lpXj/Z+5OB
	U4wfIDFvd1JmRE16mfJDbCu3Td/Ifj0OtKxWBOi16vFF/oWDsR3cU6W9bDIPH5hjMRUm3A01LsQ
	qHE/rgv1Tf9SVIRdlVIebdPOjQ==
X-Google-Smtp-Source: AGHT+IHDl3mBK+UtrIuJ3WiuUh5uf2HkxMXv7weIoSfF2BjP893cUubSQHqBeJbQ3xunoVfq3vRU1g==
X-Received: by 2002:a17:907:7211:b0:aa6:7881:1e84 with SMTP id a640c23a62f3a-ab2ab6fdebfmr3200425266b.15.1737044781412;
        Thu, 16 Jan 2025 08:26:21 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f29260sm16411666b.94.2025.01.16.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:26:21 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 16 Jan 2025 19:26:09 +0300
Subject: [PATCH v15 7/7] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-starqltechn_integration_upstream-v15-7-cf229de9f758@gmail.com>
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
In-Reply-To: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737044771; l=13442;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=xOqBeSBIJwxouVgCQIyYna4a+/oQv9D67CT+l4Jdw+M=;
 b=O67BM1ve2p+uLiSKKvKvFPiVr5CN0G/Tj+DkbGEmlMIbKFjr8zhwfZ5VXJLXanlBJ2TFLDMV6
 si0/EgGFEqLBuB4kVRO+Jb7HSYX5Uj9SaVKoW3OxerD32p+UqSs9gZp
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


