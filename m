Return-Path: <linux-pm+bounces-15282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26DE99322C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA051F23864
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBE1DB545;
	Mon,  7 Oct 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSzpB5n+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A61DB526;
	Mon,  7 Oct 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316574; cv=none; b=rkgRuKGmUmJ5iWqtY+Nn0TBuFqfFyOjHCWEtilE/ff8VmUUtgDW193ikNnS5LYyAyFLnL8xaq0Gu446VN9eJraHmQs71Xv8+lxJZ1i7MuY6TcA4N7hpf0kKvHTdH7oWytynIOEJCNvRSE3QNGS0y0dWUvSyUd+SYdrZTR8vasyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316574; c=relaxed/simple;
	bh=3GEqv+P+M8q0h647yHzVVgco+uzPPN9QlQLFT8KnM/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wp5IR7DZJKT+Lz95YS21cdhzBx8tO8FgOjXN52aE7SxohVXY2yq7+QVO0umbTYNdpkSl0vFpxth2w45P2m3U9LnvPoV3lMgQcPIXL4s7JRtFkgvVmZqUzRerntmijGWZ1AtP9AgSBJ5GsFksotvDxLBp/sM8bQVOVxSTdxqXQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSzpB5n+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2facf00b0c7so50032501fa.1;
        Mon, 07 Oct 2024 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316570; x=1728921370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/gRgAzSIEhSEoKkDZ28GjB/h6vE6I46ZOTkNoFezYU=;
        b=BSzpB5n+rj9bpEKHVJ0XQPAmMA5kTggV3otpMSjD0R6Q5vw8aWn+FTO8lgnTU5YTzE
         dkN4wqqtei8nrDa/ZKZtXeqwfF89W295wktbHN/tePVHWwsAbiiOqwzh4nH2sq12kDcS
         u4yh3a87RgbUT1h0jH2+oi9uWdB6/SIZiWWCvDn3Fd+0rDBCbGgsH24A/qtFyx0VhSwe
         j9QJwtKyDS8EqtgqIn+SQ9IR63EZz3EW0r9COrOLVnfO4RveDVr8hTx5KSUVxMmAzG+e
         S4n2QplpP80wQRxrupiO8lGc5yDWFieyV63a8yhjMo8lXVnckdGDyIsKruLJjad0vXPq
         w0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316570; x=1728921370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/gRgAzSIEhSEoKkDZ28GjB/h6vE6I46ZOTkNoFezYU=;
        b=DigXGxwpZxwQMsHp2dnyEXrtYQGQ1iaPpZe+jkAu17umrrIFj/1XH7OG5hbDfQyJdH
         xF02zKEOHlC7O+bwW5w9l01TEHxqPEDkuG6G9UtmGhwpJYr8vjG9BrFuo8XnhUGz5jS6
         kRGydmnBys5JQPkVQIP6t6pxTMygTESib/E8UX1lJs/VRpwMgMVM/TIOXIma8PtVr61D
         R4hppBxTu5pieY14NFhH6c5CrR5w9VbRn1IHALwfrN/uDa0xd4qL918tFrylxgS75VQq
         6av+Tzp46+US3Pq65vpwD/fIF+tGj5TiUhx4s5Kqmz+qRFJYb4MZFLsOJfmG6bzJeNDT
         xG+A==
X-Forwarded-Encrypted: i=1; AJvYcCV8PWZVg8dvG+uDRtRQZaxZlzrGqRSYLmA+t/BWUMi1CyWkvGDoRyChOtBgYfEwVBCZDeNOP1n1rbQg@vger.kernel.org, AJvYcCVI37JRH9Sk7N3pjQIfnfmpqgYL+9QAQ0aSjL52+FZd+K+OQAQuPB3eI1Y5EK7RToH8VTXuI1N21gMRpQ==@vger.kernel.org, AJvYcCVnsa/yuszmjqSt6rFX10IkWi1N40C6LyHe5BLskwPk/v7RB8LbG5+hrOEKLNARhhK4sjti1kTy88GtvgdZ@vger.kernel.org, AJvYcCWdLCWcyPFiMIloashYlSwS/kVsoLO2h4J83Z/ZYb0r1Z6F+SSu96z7c936Irtvjf8gzbzxY6AdNRmxiaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3jykT/m7+4Sojf+9P+SGXb3eHQHiDF7fTOmTeIlCwfiB5Cht
	fWwKTiN0uWjvJ/HyrYs/2969k1nhg7tmBMQ4mnHY/r6dOLAQ4PyKkBuU8w==
X-Google-Smtp-Source: AGHT+IFyS/HF1rD6X4sBivuAhLFmI78EtvpJizy4W7o6Iu3I0xCC7n9MAJBWzWbabYZ6GrUT2QSwbA==
X-Received: by 2002:a2e:4c1a:0:b0:2fa:c185:ac4e with SMTP id 38308e7fff4ca-2fb0de9546emr253501fa.13.1728316570122;
        Mon, 07 Oct 2024 08:56:10 -0700 (PDT)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-75.telecom.by. [46.53.210.75])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2faf9b24a22sm8552461fa.93.2024.10.07.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:56:08 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 07 Oct 2024 18:55:51 +0300
Subject: [PATCH v6 3/7] mfd: Add new driver for MAX77705 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-starqltechn_integration_upstream-v6-3-0d38b5090c57@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728316556; l=18816;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=3GEqv+P+M8q0h647yHzVVgco+uzPPN9QlQLFT8KnM/M=;
 b=6jbaNLhKg/c1wi7LwcDgqEBTP54+xDzzkSUdLrytYSFYV3F1dNdYt4p9773uX1UJ13yCS8pke
 tadkjYSy0NlBV1nxjhFDIc5iGVdXLuhVZVO3QiFmnf/sWQoG5nUO1zG
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add the core MFD driver for max77705 PMIC. We define five sub-devices
for which the drivers will be added in subsequent patches.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes for v5:
- license change to 2.0
- use same hardware name in Kconfig and module descriptions
Changes for v4:
- rework driver from scratch
- migrate to regmap_add_irq_chip, remove max77705-irq.c,
  rename max77705-core.c to max77705.c
- cleanup headers
- remove debugfs code
- migrate to use max77693_dev structure
- remove max77705.h
---
 MAINTAINERS                          |   2 ++
 drivers/mfd/Kconfig                  |  12 +++++++
 drivers/mfd/Makefile                 |   2 ++
 drivers/mfd/max77705.c               | 248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77693-common.h  |   6 +++-
 include/linux/mfd/max77705-private.h | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 449 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed8bdaaaca9..4bc9c0da6adb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14078,6 +14078,7 @@ F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
 F:	drivers/*/max77693*.c
+F:	drivers/*/max77705*.c
 F:	drivers/clk/clk-max77686.c
 F:	drivers/extcon/extcon-max14577.c
 F:	drivers/extcon/extcon-max77693.c
@@ -14085,6 +14086,7 @@ F:	drivers/rtc/rtc-max77686.c
 F:	include/linux/mfd/max14577*.h
 F:	include/linux/mfd/max77686*.h
 F:	include/linux/mfd/max77693*.h
+F:	include/linux/mfd/max77705*.h
 
 MAXIRADIO FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f9325bcce1b9..090eb3fb3d67 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -904,6 +904,18 @@ config MFD_MAX77693
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_MAX77705
+	tristate "Maxim MAX77705 PMIC Support"
+	depends on I2C
+	select MFD_CORE
+	help
+	  Say yes here to add support for Maxim Integrated MAX77705.
+	  This is a Power Management IC with Charger, safe LDOs, Flash, Haptic
+	  and MUIC controls on chip.
+	  This driver provides common support for accessing the device;
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 config MFD_MAX77714
 	tristate "Maxim Semiconductor MAX77714 PMIC Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2a9f91e81af8..3dc5742c6aeb 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -167,6 +167,7 @@ obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
 obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
 obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
 obj-$(CONFIG_MFD_MAX77693)	+= max77693.o
+obj-$(CONFIG_MFD_MAX77705)	+= max77705.o
 obj-$(CONFIG_MFD_MAX77714)	+= max77714.o
 obj-$(CONFIG_MFD_MAX77843)	+= max77843.o
 obj-$(CONFIG_MFD_MAX8907)	+= max8907.o
@@ -232,6 +233,7 @@ obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
 obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
 obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
 obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
+obj-$(CONFIG_MFD_S2DOS05)	+= s2dos05.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
 obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
 obj-$(CONFIG_MFD_VEXPRESS_SYSREG)	+= vexpress-sysreg.o
diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
new file mode 100644
index 000000000000..553f20a6cdd5
--- /dev/null
+++ b/drivers/mfd/max77705.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max77705.c - mfd core driver for the MAX77705
+//
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/mfd/max77693-common.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#define I2C_ADDR_CHG    (0xD2 >> 1)
+#define I2C_ADDR_FG     (0x6C >> 1)
+
+static struct mfd_cell max77705_devs[] = {
+	{
+		.name = "leds-max77705-rgb",
+		.of_compatible = "maxim,max77705-led",
+	},
+	{
+		.name = "max77705-fuel-gauge",
+		.of_compatible = "maxim,max77705-fuel-gauge",
+	},
+	{
+		.name = "max77705-charger",
+		.of_compatible = "maxim,max77705-charger",
+	},
+	{
+		.name = "max77705-haptic",
+		.of_compatible = "maxim,max77705-haptic",
+	},
+};
+
+static const struct regmap_range max77705_readable_ranges[] = {
+	regmap_reg_range(MAX77705_PMIC_REG_PMICID1,		MAX77705_PMIC_REG_BSTOUT_MASK),
+	regmap_reg_range(MAX77705_PMIC_REG_INTSRC,		MAX77705_PMIC_REG_RESERVED_29),
+	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
+	regmap_reg_range(MAX77705_PMIC_REG_MCONFIG,		MAX77705_PMIC_REG_MCONFIG2),
+	regmap_reg_range(MAX77705_PMIC_REG_FORCE_EN_MASK,	MAX77705_PMIC_REG_FORCE_EN_MASK),
+	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
+	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL2,	MAX77705_PMIC_REG_BOOSTCONTROL2),
+	regmap_reg_range(MAX77705_PMIC_REG_SW_RESET,		MAX77705_PMIC_REG_USBC_RESET),
+};
+
+static const struct regmap_range max77705_writable_ranges[] = {
+	regmap_reg_range(MAX77705_PMIC_REG_MAINCTRL1,		MAX77705_PMIC_REG_BSTOUT_MASK),
+	regmap_reg_range(MAX77705_PMIC_REG_INTSRC,		MAX77705_PMIC_REG_RESERVED_29),
+	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
+	regmap_reg_range(MAX77705_PMIC_REG_MCONFIG,		MAX77705_PMIC_REG_MCONFIG2),
+	regmap_reg_range(MAX77705_PMIC_REG_FORCE_EN_MASK,	MAX77705_PMIC_REG_FORCE_EN_MASK),
+	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL1,	MAX77705_PMIC_REG_BOOSTCONTROL1),
+	regmap_reg_range(MAX77705_PMIC_REG_BOOSTCONTROL2,	MAX77705_PMIC_REG_BOOSTCONTROL2),
+	regmap_reg_range(MAX77705_PMIC_REG_SW_RESET,		MAX77705_PMIC_REG_USBC_RESET),
+
+};
+
+static const struct regmap_access_table max77705_readable_table = {
+	.yes_ranges = max77705_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max77705_readable_ranges),
+};
+
+static const struct regmap_access_table max77705_writable_table = {
+	.yes_ranges = max77705_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max77705_writable_ranges),
+};
+
+static const struct regmap_config max77705_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &max77705_readable_table,
+	.wr_table = &max77705_writable_table,
+	.max_register = MAX77705_PMIC_REG_USBC_RESET,
+};
+
+static const struct regmap_config max77705_leds_regmap_config = {
+	.reg_base = MAX77705_RGBLED_REG_BASE,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77705_LED_REG_END,
+};
+
+static const struct regmap_config max77705_chg_regmap_config = {
+	.reg_base = MAX77705_CHG_REG_BASE,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77705_CHG_REG_SAFEOUT_CTRL,
+};
+
+static const struct regmap_config max77705_fg_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX77705_FG_END,
+};
+
+static const struct regmap_irq max77705_topsys_irqs[] = {
+	{ .mask = MAX77705_SYSTEM_IRQ_BSTEN_INT,  },
+	{ .mask = MAX77705_SYSTEM_IRQ_SYSUVLO_INT,  },
+	{ .mask = MAX77705_SYSTEM_IRQ_SYSOVLO_INT,  },
+	{ .mask = MAX77705_SYSTEM_IRQ_TSHDN_INT,  },
+	{ .mask = MAX77705_SYSTEM_IRQ_TM_INT,  },
+};
+
+static const struct regmap_irq_chip max77705_topsys_irq_chip = {
+	.name			= "max77705-topsys",
+	.status_base		= MAX77705_PMIC_REG_SYSTEM_INT,
+	.mask_base		= MAX77705_PMIC_REG_SYSTEM_INT_MASK,
+	.num_regs		= 1,
+	.irqs			= max77705_topsys_irqs,
+	.num_irqs		= ARRAY_SIZE(max77705_topsys_irqs),
+};
+
+static int max77705_i2c_probe(struct i2c_client *i2c)
+{
+	struct max77693_dev *max77705;
+	struct i2c_client *i2c_chg;
+	struct i2c_client *i2c_fg;
+	struct regmap_irq_chip_data *irq_data;
+	struct irq_domain *domain;
+	int ret;
+	unsigned int pmic_rev_value;
+	u8 pmic_ver, pmic_rev;
+
+
+	max77705 = devm_kzalloc(&i2c->dev, sizeof(struct max77693_dev),
+				GFP_KERNEL);
+	if (!max77705)
+		return -ENOMEM;
+
+	max77705->dev = &i2c->dev;
+	max77705->irq = i2c->irq;
+	max77705->type = TYPE_MAX77705;
+	i2c_set_clientdata(i2c, max77705);
+
+	max77705->regmap = devm_regmap_init_i2c(i2c, &max77705_regmap_config);
+	if (IS_ERR(max77705->regmap))
+		return PTR_ERR(max77705->regmap);
+
+	if (regmap_read(max77705->regmap, MAX77705_PMIC_REG_PMICREV, &pmic_rev_value) < 0)
+		return -ENODEV;
+
+	pmic_rev = (pmic_rev_value & MAX77705_REVISION_MASK);
+	pmic_ver = ((pmic_rev_value & MAX77705_VERSION_MASK) >> MAX77705_VERSION_SHIFT);
+	dev_dbg(max77705->dev, "device found: rev.0x%x, ver.0x%x\n",
+		pmic_rev, pmic_ver);
+	if (pmic_rev != MAX77705_PASS3) {
+		dev_err(max77705->dev, "rev.0x%x is not tested",
+			pmic_rev);
+		return -ENODEV;
+	}
+
+	max77705->regmap_leds = devm_regmap_init_i2c(i2c, &max77705_leds_regmap_config);
+	if (IS_ERR(max77705->regmap_leds))
+		return PTR_ERR(max77705->regmap_leds);
+
+	i2c_chg = devm_i2c_new_dummy_device(max77705->dev,
+						i2c->adapter, I2C_ADDR_CHG);
+	max77705->regmap_chg = devm_regmap_init_i2c(i2c_chg,
+						    &max77705_chg_regmap_config);
+	if (IS_ERR(max77705->regmap_chg))
+		return PTR_ERR(max77705->regmap_chg);
+
+	i2c_fg = devm_i2c_new_dummy_device(max77705->dev, i2c->adapter,
+						I2C_ADDR_FG);
+	max77705->regmap_fg = devm_regmap_init_i2c(i2c_fg,
+						   &max77705_fg_regmap_config);
+	if (IS_ERR(max77705->regmap_fg))
+		return PTR_ERR(max77705->regmap_fg);
+
+	ret = devm_regmap_add_irq_chip(max77705->dev, max77705->regmap,
+					max77705->irq,
+					IRQF_ONESHOT | IRQF_SHARED, 0,
+					&max77705_topsys_irq_chip,
+					&irq_data);
+	if (ret)
+		dev_err(max77705->dev, "failed to add irq chip: %d\n", ret);
+
+	/* Unmask interrupts from all blocks in interrupt source register */
+	ret = regmap_update_bits(max77705->regmap,
+				 MAX77705_PMIC_REG_INTSRC_MASK,
+				 MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX77705_SRC_IRQ_ALL);
+	if (ret < 0)
+		dev_err(max77705->dev,
+			"Could not unmask interrupts in INTSRC: %d\n", ret);
+
+	domain = regmap_irq_get_domain(irq_data);
+	ret = devm_mfd_add_devices(max77705->dev, PLATFORM_DEVID_NONE,
+				   max77705_devs, ARRAY_SIZE(max77705_devs),
+				   NULL, 0, domain);
+	if (ret) {
+		dev_err(max77705->dev, "failed to add MFD devices: %d\n", ret);
+		return ret;
+	}
+
+	device_init_wakeup(max77705->dev, true);
+
+	return 0;
+}
+
+static int max77705_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct max77693_dev *max77705 = i2c_get_clientdata(i2c);
+
+	disable_irq(max77705->irq);
+	if (device_may_wakeup(dev))
+		enable_irq_wake(max77705->irq);
+
+	return 0;
+}
+
+static int max77705_resume(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct max77693_dev *max77705 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(max77705->irq);
+	enable_irq(max77705->irq);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(max77705_pm_ops, max77705_suspend, max77705_resume);
+
+static const struct of_device_id max77705_i2c_dt_ids[] = {
+	{ .compatible = "maxim,max77705" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, max77705_i2c_dt_ids);
+
+static struct i2c_driver max77705_i2c_driver = {
+	.driver		= {
+		.name		= "max77705",
+		.of_match_table	= max77705_i2c_dt_ids,
+		.pm		= pm_sleep_ptr(&max77705_pm_ops),
+		.suppress_bind_attrs = true,
+	},
+	.probe		= max77705_i2c_probe,
+};
+module_i2c_driver(max77705_i2c_driver);
+
+MODULE_DESCRIPTION("Maxim MAX77705 MFD core driver");
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/max77693-common.h b/include/linux/mfd/max77693-common.h
index a5bce099f1ed..1b87b1ada21c 100644
--- a/include/linux/mfd/max77693-common.h
+++ b/include/linux/mfd/max77693-common.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Common data shared between Maxim 77693 and 77843 drivers
+ * Common data shared between Maxim 77693, 77705 and 77843 drivers
  *
  * Copyright (C) 2015 Samsung Electronics
  */
@@ -11,6 +11,7 @@
 enum max77693_types {
 	TYPE_MAX77693_UNKNOWN,
 	TYPE_MAX77693,
+	TYPE_MAX77705,
 	TYPE_MAX77843,
 
 	TYPE_MAX77693_NUM,
@@ -25,6 +26,7 @@ struct max77693_dev {
 	struct i2c_client *i2c_muic;	/* 0x4A , MUIC */
 	struct i2c_client *i2c_haptic;	/* MAX77693: 0x90 , Haptic */
 	struct i2c_client *i2c_chg;	/* MAX77843: 0xD2, Charger */
+	struct i2c_client *i2c_fg;	/* MAX77843: 0xD2, Charger */
 
 	enum max77693_types type;
 
@@ -32,6 +34,8 @@ struct max77693_dev {
 	struct regmap *regmap_muic;
 	struct regmap *regmap_haptic;	/* Only MAX77693 */
 	struct regmap *regmap_chg;	/* Only MAX77843 */
+	struct regmap *regmap_fg;	/* Only MAX77705 */
+	struct regmap *regmap_leds;	/* Only MAX77705 */
 
 	struct regmap_irq_chip_data *irq_data_led;
 	struct regmap_irq_chip_data *irq_data_topsys;
diff --git a/include/linux/mfd/max77705-private.h b/include/linux/mfd/max77705-private.h
new file mode 100644
index 000000000000..8479d1b6cbe4
--- /dev/null
+++ b/include/linux/mfd/max77705-private.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// Maxim MAX77705 definitions.
+//
+// Copyright (C) 2015 Samsung Electronics, Inc.
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
+
+#ifndef __LINUX_MFD_MAX77705_PRIV_H
+#define __LINUX_MFD_MAX77705_PRIV_H
+
+#include <linux/pm.h>
+
+#define MAX77705_SRC_IRQ_CHG	BIT(0)
+#define MAX77705_SRC_IRQ_TOP	BIT(1)
+#define MAX77705_SRC_IRQ_FG	BIT(2)
+#define MAX77705_SRC_IRQ_USBC	BIT(3)
+#define MAX77705_SRC_IRQ_ALL	(MAX77705_SRC_IRQ_CHG | MAX77705_SRC_IRQ_TOP | \
+				MAX77705_SRC_IRQ_FG | MAX77705_SRC_IRQ_USBC)
+
+// MAX77705_PMIC_REG_PMICREV register
+#define MAX77705_VERSION_SHIFT	3
+#define MAX77705_REVISION_MASK	GENMASK(2, 0)
+#define MAX77705_VERSION_MASK	GENMASK(7, MAX77705_VERSION_SHIFT)
+// MAX77705_PMIC_REG_MAINCTRL1 register
+#define MAX77705_MAINCTRL1_BIASEN_SHIFT	7
+#define MAX77705_MAINCTRL1_BIASEN_MASK	BIT(MAX77705_MAINCTRL1_BIASEN_SHIFT)
+// MAX77705_PMIC_REG_MCONFIG2 (haptics) register
+#define MAX77705_CONFIG2_MEN_SHIFT	6
+#define MAX77705_CONFIG2_MODE_SHIFT	7
+#define MAX77705_CONFIG2_HTYP_SHIFT	5
+// MAX77705_PMIC_REG_SYSTEM_INT_MASK register
+#define MAX77705_SYSTEM_IRQ_BSTEN_INT	BIT(3)
+#define MAX77705_SYSTEM_IRQ_SYSUVLO_INT	BIT(4)
+#define MAX77705_SYSTEM_IRQ_SYSOVLO_INT	BIT(5)
+#define MAX77705_SYSTEM_IRQ_TSHDN_INT	BIT(6)
+#define MAX77705_SYSTEM_IRQ_TM_INT	BIT(7)
+
+enum max77705_hw_rev {
+	MAX77705_PASS1 = 1,
+	MAX77705_PASS2,
+	MAX77705_PASS3,
+};
+
+enum max77705_reg {
+	MAX77705_PMIC_REG_PMICID1		= 0x00,
+	MAX77705_PMIC_REG_PMICREV		= 0x01,
+	MAX77705_PMIC_REG_MAINCTRL1		= 0x02,
+	MAX77705_PMIC_REG_BSTOUT_MASK		= 0x03,
+	MAX77705_PMIC_REG_FORCE_EN_MASK		= 0x08,
+	MAX77705_PMIC_REG_MCONFIG		= 0x10,
+	MAX77705_PMIC_REG_MCONFIG2		= 0x11,
+	MAX77705_PMIC_REG_INTSRC		= 0x22,
+	MAX77705_PMIC_REG_INTSRC_MASK		= 0x23,
+	MAX77705_PMIC_REG_SYSTEM_INT		= 0x24,
+	MAX77705_PMIC_REG_RESERVED_25		= 0x25,
+	MAX77705_PMIC_REG_SYSTEM_INT_MASK	= 0x26,
+	MAX77705_PMIC_REG_RESERVED_27		= 0x27,
+	MAX77705_PMIC_REG_RESERVED_28		= 0x28,
+	MAX77705_PMIC_REG_RESERVED_29		= 0x29,
+	MAX77705_PMIC_REG_BOOSTCONTROL1		= 0x4C,
+	MAX77705_PMIC_REG_BOOSTCONTROL2		= 0x4F,
+	MAX77705_PMIC_REG_SW_RESET		= 0x50,
+	MAX77705_PMIC_REG_USBC_RESET		= 0x51,
+
+	MAX77705_PMIC_REG_END,
+};
+
+enum max77705_chg_reg {
+	MAX77705_CHG_REG_BASE	= 0xB0,
+	MAX77705_CHG_REG_INT	= 0,
+	MAX77705_CHG_REG_INT_MASK,
+	MAX77705_CHG_REG_INT_OK,
+	MAX77705_CHG_REG_DETAILS_00,
+	MAX77705_CHG_REG_DETAILS_01,
+	MAX77705_CHG_REG_DETAILS_02,
+	MAX77705_CHG_REG_DTLS_03,
+	MAX77705_CHG_REG_CNFG_00,
+	MAX77705_CHG_REG_CNFG_01,
+	MAX77705_CHG_REG_CNFG_02,
+	MAX77705_CHG_REG_CNFG_03,
+	MAX77705_CHG_REG_CNFG_04,
+	MAX77705_CHG_REG_CNFG_05,
+	MAX77705_CHG_REG_CNFG_06,
+	MAX77705_CHG_REG_CNFG_07,
+	MAX77705_CHG_REG_CNFG_08,
+	MAX77705_CHG_REG_CNFG_09,
+	MAX77705_CHG_REG_CNFG_10,
+	MAX77705_CHG_REG_CNFG_11,
+	MAX77705_CHG_REG_CNFG_12,
+	MAX77705_CHG_REG_CNFG_13,
+	MAX77705_CHG_REG_CNFG_14,
+	MAX77705_CHG_REG_SAFEOUT_CTRL,
+};
+
+enum max77705_fuelgauge_reg {
+	STATUS_REG				= 0x00,
+	VALRT_THRESHOLD_REG			= 0x01,
+	TALRT_THRESHOLD_REG			= 0x02,
+	SALRT_THRESHOLD_REG			= 0x03,
+	REMCAP_REP_REG				= 0x05,
+	SOCREP_REG				= 0x06,
+	TEMPERATURE_REG				= 0x08,
+	VCELL_REG				= 0x09,
+	TIME_TO_EMPTY_REG			= 0x11,
+	FULLSOCTHR_REG				= 0x13,
+	CURRENT_REG				= 0x0A,
+	AVG_CURRENT_REG				= 0x0B,
+	SOCMIX_REG				= 0x0D,
+	SOCAV_REG				= 0x0E,
+	REMCAP_MIX_REG				= 0x0F,
+	FULLCAP_REG				= 0x10,
+	RFAST_REG				= 0x15,
+	AVR_TEMPERATURE_REG			= 0x16,
+	CYCLES_REG				= 0x17,
+	DESIGNCAP_REG				= 0x18,
+	AVR_VCELL_REG				= 0x19,
+	TIME_TO_FULL_REG			= 0x20,
+	CONFIG_REG				= 0x1D,
+	ICHGTERM_REG				= 0x1E,
+	REMCAP_AV_REG				= 0x1F,
+	FULLCAP_NOM_REG				= 0x23,
+	LEARN_CFG_REG				= 0x28,
+	FILTER_CFG_REG				= 0x29,
+	MISCCFG_REG				= 0x2B,
+	QRTABLE20_REG				= 0x32,
+	FULLCAP_REP_REG				= 0x35,
+	RCOMP_REG				= 0x38,
+	VEMPTY_REG				= 0x3A,
+	FSTAT_REG				= 0x3D,
+	DISCHARGE_THRESHOLD_REG			= 0x40,
+	QRTABLE30_REG				= 0x42,
+	ISYS_REG				= 0x43,
+	DQACC_REG				= 0x45,
+	DPACC_REG				= 0x46,
+	AVGISYS_REG				= 0x4B,
+	QH_REG					= 0x4D,
+	VSYS_REG				= 0xB1,
+	TALRTTH2_REG				= 0xB2,
+	VBYP_REG				= 0xB3,
+	CONFIG2_REG				= 0xBB,
+	IIN_REG					= 0xD0,
+	OCV_REG					= 0xEE,
+	VFOCV_REG				= 0xFB,
+	VFSOC_REG				= 0xFF,
+
+	MAX77705_FG_END,
+};
+
+enum max77705_led_reg {
+	MAX77705_RGBLED_REG_BASE = 0x30,
+	MAX77705_RGBLED_REG_LEDEN = 0,
+	MAX77705_RGBLED_REG_LED0BRT,
+	MAX77705_RGBLED_REG_LED1BRT,
+	MAX77705_RGBLED_REG_LED2BRT,
+	MAX77705_RGBLED_REG_LED3BRT,
+	MAX77705_RGBLED_REG_LEDRMP,
+	MAX77705_RGBLED_REG_LEDBLNK,
+	MAX77705_LED_REG_END
+};
+
+enum max77705_charger_battery_state {
+	MAX77705_BATTERY_NOBAT,
+	MAX77705_BATTERY_PREQUALIFICATION,
+	MAX77705_BATTERY_DEAD,
+	MAX77705_BATTERY_GOOD,
+	MAX77705_BATTERY_LOWVOLTAGE,
+	MAX77705_BATTERY_OVERVOLTAGE,
+	MAX77705_BATTERY_RESERVED,
+};
+
+enum max77705_charger_charge_type {
+	MAX77705_CHARGER_CONSTANT_CURRENT	= 1,
+	MAX77705_CHARGER_CONSTANT_VOLTAGE,
+	MAX77705_CHARGER_END_OF_CHARGE,
+	MAX77705_CHARGER_DONE,
+};
+
+extern const struct dev_pm_ops max77705_pm_ops;
+
+#endif /* __LINUX_MFD_MAX77705_PRIV_H */

-- 
2.39.2


