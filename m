Return-Path: <linux-pm+bounces-14816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F551987140
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99204288593
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A41AED27;
	Thu, 26 Sep 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfn4ISVQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0F1AE870;
	Thu, 26 Sep 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346062; cv=none; b=lFkebC/6IrAOpD4BM7pr6uqxJJA2iDsMUe4cQ82ZGsVa4hGbsrKUf6C5kqYvNqB62yAsVa5k/9NEGRaP6r8n1452iuyngNdE6d652KDFqDPT2+UQDjZitqQkKEiv+c1M1ijUWtdkJNYlRwhoJQzYvtkiAHnJvdANHI+su4cXP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346062; c=relaxed/simple;
	bh=p5Y/lJbvoOrfKkfFr0ukcPnq2d08db9jYAi3DPZm75E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNUGPtT3dvR9hIrCWZMt9qdk4ZzKWNB3JU5wZxLq4MHZs1XkpHMf71XNUph4QR//PE0D/N6P/2z+GeeswKPt8wyuVc4pm0Y6q2AkuWieO3NlSDDdzHmTH1XlKtRBpuYEX3QwGfM0erxIMR++JsDaR7Hoj3K/KJIfmU69D08bSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfn4ISVQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so1082840e87.0;
        Thu, 26 Sep 2024 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346058; x=1727950858; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+NEpZH6KLuRAYhtDzOt7H1iFZ18nnrB83Qbm6BxXHc=;
        b=Gfn4ISVQsRvBHVcBgrrsB5geRaka977cP5zwGujnJT0eTldZcAyaWXCC5QJQcmi/iB
         g39QZ6FazQs8mAD+489v698qvT2GAfBYwP6OfoOBnuDm5xja00NKetyQBF804Sit7pcZ
         rmWGmTOdsqYokwMdrHEc6YcZAJOGrOhOfEoUOXOb1an3WxRVRlRYvT2R3yEGP/hGj/Qy
         frAgi/9yYJxYtOj/xa5X6yrFhpW7fVck8sQ/xFvO8wmCSsPBn9HqToeBJIsSsSrBGgcK
         GvQdV9NvWNcGDwb7zpchFtduj7HsGLR+qJe0XRoc5WmyBDB67f4F4k+o1o/xrjV3uR4P
         yisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346058; x=1727950858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+NEpZH6KLuRAYhtDzOt7H1iFZ18nnrB83Qbm6BxXHc=;
        b=bHwHgfKdbzSRzrjnbN8JwG36iLB5360KQQSLF/lI3ipZf7Q7nYfnEhgKpohhZYVo85
         hjxMB9Pm6+DbgbTHF36xmg6Xu2gDdKOwM4/yYZYIDWgSivNV424zxV4q52Pe7plxjmtJ
         xBmg2GAmYYC2ooh3kVn29Bo3HC4ajsfLplStyu5I+e7850vbGR24MhPJdo3ilMqUK031
         G3Kb70Kz3/OAtwbIsw5qnwc/7ure83z+BT2ZshMmEHYMkboEtjFVWF0Mv66uygABFTqV
         0qpyLqQLEGSC6E2UOuayMbq90n6sF5vFqs5jsS+2oKJ1gtNmda21sD/rvezWbAcUbn4K
         4I3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0nZsVjpqW+95OLGDpQOp+X1ftdwC1bUQWzD/WkWQKrhOBaIc4jY8mebbcQDdbvr0ekFej3H0fB4mKwbs=@vger.kernel.org, AJvYcCWv6nXlB8dkCl1+zq1fpe//hsLpNuGVhpUuw/SeHE4iPA5gevS1K0y1fi8zM6lowIKN6yIIzihqImO14Q==@vger.kernel.org, AJvYcCXAIaeD6VmSefZlnsv1MPpJHdEP8QDekvo+VcZvibdlWhrqANqbg2DNdVU3kP3I1LFK6BUgpLPqO1i/@vger.kernel.org, AJvYcCXMfYeaLSEj9wqbrPrElBmLTInBgRcfPVjmxajvN2ZNucHJEQXwpWVlBBw4Z2MRwd05g2T3p6JhpTM+pVfq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7rmma67ZiHCGy4oTPouzSHZI6Vl5x6WwHhhUyu2jQVYVv7zw6
	x4Tq3m6DBsXBmHbBEkM76fMFNTYAm9GBhdvVCOAVq8CHHb4rfIjY
X-Google-Smtp-Source: AGHT+IHFwxKFglzO85v4o2K8jgzMeUhIowxK5dvxbhCGGnB5jrPP51vTZlwrqz4uH0Jfk8LMyZYp5g==
X-Received: by 2002:a05:6512:281f:b0:530:aa3f:7889 with SMTP id 2adb3069b0e04-5387c590f37mr3897058e87.56.1727346057358;
        Thu, 26 Sep 2024 03:20:57 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee54esm759071e87.96.2024.09.26.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:20:56 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 13:20:20 +0300
Subject: [PATCH v5 3/7] mfd: Add new driver for MAX77705 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-starqltechn_integration_upstream-v5-3-e0033f141d17@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727346045; l=18747;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=p5Y/lJbvoOrfKkfFr0ukcPnq2d08db9jYAi3DPZm75E=;
 b=72mECttBpL75wb2LxXKj8dTzJH6PMfPjnWisPlzsAtsW3i/C/64q5HDuV7Elh0NvQM57X4rwd
 ZBB0gkP8y2LBSgsqxMZFleLD6Y08BynDaMnbmJrxVrsgxCp54ssFpFK
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
 MAINTAINERS                          |   2 +
 drivers/mfd/Kconfig                  |  12 +++++
 drivers/mfd/Makefile                 |   2 +
 drivers/mfd/max77705.c               | 248 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77693-common.h  |   6 ++-
 include/linux/mfd/max77705-private.h | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 449 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5829f28631..e45bbafbb938 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14076,6 +14076,7 @@ F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
 F:	drivers/*/max77693*.c
+F:	drivers/*/max77705*.c
 F:	drivers/clk/clk-max77686.c
 F:	drivers/extcon/extcon-max14577.c
 F:	drivers/extcon/extcon-max77693.c
@@ -14083,6 +14084,7 @@ F:	drivers/rtc/rtc-max77686.c
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


