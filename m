Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545FF24E326
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 00:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgHUWUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHUWT7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 18:19:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254DBC061573;
        Fri, 21 Aug 2020 15:19:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so3629076ejz.0;
        Fri, 21 Aug 2020 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWYvl8CL+VMO+CAThG/bxJJ1OgcVUR94PwgbCjmr5s0=;
        b=R2l+WY3Wx8ckUTEnpoyykPRBLm19xweeS+P9xafvJKXYXGZdIRGVCksNCJm8S8aX1H
         2OH4LAPzIMso7epVyBFeE0ua2sdw/TVodaoAXGtlliNR+YzZW0uKHyjw0T+BaShiSbze
         V+jKw3MIN4DW2C/4Jpho68Opcl1L961r63Qsj3dN9IgtfJKWWdypo7h8jutd46jq8T15
         pTwQilhx38402v0TARpidTsG63JFrH8jaizhDam3txqVIet+Hu/15sFI1qPHeQw0eTn0
         uviuR8bnyA5JGHz+TBhAVjvPoWDjdUN8rDAzazHVQd/4yzNZHHFSe0qL2J62t45wSK7x
         FQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWYvl8CL+VMO+CAThG/bxJJ1OgcVUR94PwgbCjmr5s0=;
        b=WKHi/zcVgEkSh7WmKCMD/LnliGBsE/g4//+yMMW7qNnr0EDMrhEnFSV4UIlp/b0iOr
         Yzz+Tj6xGo/PxkWyir/BD6Pb8vt2015HDyOF2sSLj+Ns5wgqY/SeiOf6zUyro1b41hiR
         p3MVXZZErCQ+OktebpVkoc0DX4Gkn+plzJaU1n2JzDAOrsvhtOSDa3b36OSvMFNLS2HI
         SIHhbB168pj2eXiYcWXqyuEyCEG97z2jGj4amQcQCMrXb01O9Gig9uIIU8aRcb68AnLp
         2U5l+nwz+LIbQhgWkFaKnWeAj01HDPukagUV/fh3wy0TgaHBd64a8nqQISckKGJTCTHx
         lHGg==
X-Gm-Message-State: AOAM532Jiadl+xyHw3RYQLRamv+qXQka6k2RRgyzBQE0HNUpCpvBmkzb
        30bkI7d+sEXMsK5AQzWlBeRzXYh61ZnKCA==
X-Google-Smtp-Source: ABdhPJysVlAfznvwRHFDvIhyeszG/j/iie6/qMI3avVlugCf8fs4n0VuEUrRFLZt1Nho59SPiRNKbA==
X-Received: by 2002:a17:906:35db:: with SMTP id p27mr3553406ejb.257.1598048397608;
        Fri, 21 Aug 2020 15:19:57 -0700 (PDT)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id p23sm1780147edm.31.2020.08.21.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:19:57 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/6] mfd: Add MFD driver for ATC260x PMICs
Date:   Sat, 22 Aug 2020 01:19:48 +0300
Message-Id: <7705c965d82a21571f93f38aeabbd3bcb3d23bac.1598043782.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial MFD driver for Actions Semi ATC260x PMICs. ATC260x series
PMICs integrates Audio Codec, Power management, Clock generation and
GPIO controller blocks.

For the moment this driver only supports Regulator, Poweroff and Onkey
functionalities for the ATC2603C and ATC2609A chip variants.

Since the PMICs can be accessed using both I2C and SPI buses, the
following driver structure has been adopted:

           -----> atc260x-core.c (Implements core functionalities)
          /
ATC260x --------> atc260x-i2c.c (Implements I2C interface)
          \
           -----> atc260x-spi.c (Implements SPI interface - TODO)

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[cristian: add ATC2603C variant, poweroff and onkey features, rework]
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/mfd/Kconfig                  |  18 ++
 drivers/mfd/Makefile                 |   3 +
 drivers/mfd/atc260x-core.c           | 290 +++++++++++++++++++++++++
 drivers/mfd/atc260x-i2c.c            |  73 +++++++
 include/linux/mfd/atc260x/atc2603c.h | 281 ++++++++++++++++++++++++
 include/linux/mfd/atc260x/atc2609a.h | 308 +++++++++++++++++++++++++++
 include/linux/mfd/atc260x/core.h     |  86 ++++++++
 7 files changed, 1059 insertions(+)
 create mode 100644 drivers/mfd/atc260x-core.c
 create mode 100644 drivers/mfd/atc260x-i2c.c
 create mode 100644 include/linux/mfd/atc260x/atc2603c.h
 create mode 100644 include/linux/mfd/atc260x/atc2609a.h
 create mode 100644 include/linux/mfd/atc260x/core.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 33df0837ab41..49cc3c2b46ad 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2041,6 +2041,24 @@ config MFD_WCD934X
 	  This driver provides common support WCD934x audio codec and its
 	  associated Pin Controller, Soundwire Controller and Audio codec.
 
+config MFD_ATC260X
+	tristate
+	select MFD_CORE
+	select REGMAP
+	select REGMAP_IRQ
+
+config MFD_ATC260X_I2C
+	tristate "Actions Semi ATC260x PMICs with I2C"
+	select MFD_ATC260X
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Support for the Actions Semi ATC260x PMICs controlled via I2C.
+
+	  This driver provides common support for accessing the ATC2603C
+	  and ATC2609A chip variants, additional drivers must be enabled
+	  in order to use the functionality of the device.
+
 config MFD_KHADAS_MCU
 	tristate "Support for Khadas System control Microcontroller"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a60e5f835283..508e104b6393 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -264,3 +264,6 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+
+obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
+obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
new file mode 100644
index 000000000000..1c63beda64cd
--- /dev/null
+++ b/drivers/mfd/atc260x-core.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Core MFD support for ATC260x PMICs
+ *
+ * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/mfd/atc260x/core.h>
+#include <linux/mfd/core.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+static void regmap_lock_mutex(void *__mutex)
+{
+	struct mutex *mutex = __mutex;
+
+	/*
+	 * Using regmap within an atomic context (e.g. accessing a PMIC when
+	 * powering system down) is normally allowed only if the regmap type
+	 * is MMIO and the regcache type is either REGCACHE_NONE or
+	 * REGCACHE_FLAT. For slow buses like I2C and SPI, the regmap is
+	 * internally protected by a mutex which is acquired non-atomically.
+	 *
+	 * Let's improve this by using a customized locking scheme inspired
+	 * from I2C atomic transfer. See i2c_in_atomic_xfer_mode() for a
+	 * starting point.
+	 */
+	if (system_state > SYSTEM_RUNNING && irqs_disabled())
+		mutex_trylock(mutex);
+	else
+		mutex_lock(mutex);
+}
+
+static void regmap_unlock_mutex(void *__mutex)
+{
+	struct mutex *mutex = __mutex;
+
+	mutex_unlock(mutex);
+}
+
+static const struct regmap_config atc2603c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = ATC2603C_SADDR,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const struct regmap_config atc2609a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = ATC2609A_SADDR,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const struct regmap_irq atc2603c_regmap_irqs[] = {
+	REGMAP_IRQ_REG(ATC2603C_IRQ_AUDIO,	0, ATC2603C_INTS_MSK_AUDIO),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_OV,		0, ATC2603C_INTS_MSK_OV),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_OC,		0, ATC2603C_INTS_MSK_OC),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_OT,		0, ATC2603C_INTS_MSK_OT),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_UV,		0, ATC2603C_INTS_MSK_UV),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_ALARM,	0, ATC2603C_INTS_MSK_ALARM),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_ONOFF,	0, ATC2603C_INTS_MSK_ONOFF),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_SGPIO,	0, ATC2603C_INTS_MSK_SGPIO),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_IR,		0, ATC2603C_INTS_MSK_IR),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_REMCON,	0, ATC2603C_INTS_MSK_REMCON),
+	REGMAP_IRQ_REG(ATC2603C_IRQ_POWER_IN,	0, ATC2603C_INTS_MSK_POWERIN),
+};
+
+static const struct regmap_irq atc2609a_regmap_irqs[] = {
+	REGMAP_IRQ_REG(ATC2609A_IRQ_AUDIO,	0, ATC2609A_INTS_MSK_AUDIO),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_OV,		0, ATC2609A_INTS_MSK_OV),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_OC,		0, ATC2609A_INTS_MSK_OC),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_OT,		0, ATC2609A_INTS_MSK_OT),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_UV,		0, ATC2609A_INTS_MSK_UV),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_ALARM,	0, ATC2609A_INTS_MSK_ALARM),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_ONOFF,	0, ATC2609A_INTS_MSK_ONOFF),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_WKUP,	0, ATC2609A_INTS_MSK_WKUP),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_IR,		0, ATC2609A_INTS_MSK_IR),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_REMCON,	0, ATC2609A_INTS_MSK_REMCON),
+	REGMAP_IRQ_REG(ATC2609A_IRQ_POWER_IN,	0, ATC2609A_INTS_MSK_POWERIN),
+};
+
+static const struct regmap_irq_chip atc2603c_regmap_irq_chip = {
+	.name = "atc2603c",
+	.irqs = atc2603c_regmap_irqs,
+	.num_irqs = ARRAY_SIZE(atc2603c_regmap_irqs),
+	.num_regs = 1,
+	.status_base = ATC2603C_INTS_PD,
+	.mask_base = ATC2603C_INTS_MSK,
+	.mask_invert = true,
+};
+
+static const struct regmap_irq_chip atc2609a_regmap_irq_chip = {
+	.name = "atc2609a",
+	.irqs = atc2609a_regmap_irqs,
+	.num_irqs = ARRAY_SIZE(atc2609a_regmap_irqs),
+	.num_regs = 1,
+	.status_base = ATC2609A_INTS_PD,
+	.mask_base = ATC2609A_INTS_MSK,
+	.mask_invert = true,
+};
+
+static const struct resource atc2603c_onkey_resources[] = {
+	DEFINE_RES_IRQ(ATC2603C_IRQ_ONOFF),
+};
+
+static const struct resource atc2609a_onkey_resources[] = {
+	DEFINE_RES_IRQ(ATC2609A_IRQ_ONOFF),
+};
+
+static const struct mfd_cell atc2603c_mfd_cells[] = {
+	{
+		.name = "atc260x-regulator",
+		.of_compatible = "actions,atc2603c-regulator"
+	}, {
+		.name = "atc260x-pwrc",
+		.of_compatible = "actions,atc2603c-pwrc"
+	}, {
+		.name = "atc260x-onkey",
+		.of_compatible = "actions,atc2603c-onkey",
+		.num_resources = ARRAY_SIZE(atc2603c_onkey_resources),
+		.resources = atc2603c_onkey_resources,
+	},
+};
+
+static const struct mfd_cell atc2609a_mfd_cells[] = {
+	{
+		.name = "atc260x-regulator",
+		.of_compatible = "actions,atc2609a-regulator"
+	}, {
+		.name = "atc260x-pwrc",
+		.of_compatible = "actions,atc2609a-pwrc"
+	}, {
+		.name = "atc260x-onkey",
+		.of_compatible = "actions,atc2609a-onkey",
+		.num_resources = ARRAY_SIZE(atc2609a_onkey_resources),
+		.resources = atc2609a_onkey_resources,
+	},
+};
+
+static void atc260x_cmu_reset(struct atc260x *atc260x, u32 reg, u8 mask, u32 bit)
+{
+	/* Assert reset */
+	regmap_update_bits(atc260x->regmap, reg, mask, ~bit);
+
+	/* De-assert reset */
+	regmap_update_bits(atc260x->regmap, reg, mask, bit);
+}
+
+static int atc2603c_dev_init(struct atc260x *atc260x)
+{
+	/* Initialize interrupt block */
+	atc260x_cmu_reset(atc260x, ATC2603C_CMU_DEVRST,
+			  ATC2603C_CMU_DEVRST_INTS, ATC2603C_CMU_DEVRST_INTS);
+
+	/* Disable all interrupt sources */
+	regmap_write(atc260x->regmap, ATC2603C_INTS_MSK, 0);
+
+	/* Enable EXTIRQ pad */
+	return regmap_update_bits(atc260x->regmap, ATC2603C_PAD_EN,
+				  ATC2603C_PAD_EN_EXTIRQ, ATC2603C_PAD_EN_EXTIRQ);
+}
+
+static int atc2609a_dev_init(struct atc260x *atc260x)
+{
+	/* Initialize interrupt block */
+	atc260x_cmu_reset(atc260x, ATC2609A_CMU_DEVRST,
+			  ATC2609A_CMU_DEVRST_INTS, ATC2609A_CMU_DEVRST_INTS);
+
+	/* Disable all interrupt sources */
+	regmap_write(atc260x->regmap, ATC2609A_INTS_MSK, 0);
+
+	/* Enable EXTIRQ pad */
+	return regmap_update_bits(atc260x->regmap, ATC2609A_PAD_EN,
+				  ATC2609A_PAD_EN_EXTIRQ, ATC2609A_PAD_EN_EXTIRQ);
+}
+
+int atc260x_match_device(struct atc260x *atc260x, struct regmap_config *regmap_cfg)
+{
+	struct device *dev = atc260x->dev;
+	const void *of_data;
+
+	of_data = of_device_get_match_data(dev);
+	if (!of_data)
+		return -ENODEV;
+
+	atc260x->ic_type = (unsigned long)of_data;
+
+	switch (atc260x->ic_type) {
+	case ATC2603C:
+		*regmap_cfg = atc2603c_regmap_config;
+		atc260x->regmap_irq_chip = &atc2603c_regmap_irq_chip;
+		atc260x->cells = atc2603c_mfd_cells;
+		atc260x->nr_cells = ARRAY_SIZE(atc2603c_mfd_cells);
+		atc260x->type_name = "atc2603c";
+		atc260x->rev_reg = ATC2603C_CHIP_VER;
+		atc260x->dev_init = atc2603c_dev_init;
+		break;
+	case ATC2609A:
+		*regmap_cfg = atc2609a_regmap_config;
+		atc260x->regmap_irq_chip = &atc2609a_regmap_irq_chip;
+		atc260x->cells = atc2609a_mfd_cells;
+		atc260x->nr_cells = ARRAY_SIZE(atc2609a_mfd_cells);
+		atc260x->type_name = "atc2609a";
+		atc260x->rev_reg = ATC2609A_CHIP_VER;
+		atc260x->dev_init = atc2609a_dev_init;
+		break;
+	default:
+		dev_err(dev, "Unsupported ATC260x device type: %u\n",
+			atc260x->ic_type);
+		return -EINVAL;
+	}
+
+	atc260x->regmap_mutex = devm_kzalloc(dev, sizeof(*atc260x->regmap_mutex),
+					     GFP_KERNEL);
+	if (!atc260x->regmap_mutex)
+		return -ENOMEM;
+
+	mutex_init(atc260x->regmap_mutex);
+
+	regmap_cfg->lock = regmap_lock_mutex,
+	regmap_cfg->unlock = regmap_unlock_mutex,
+	regmap_cfg->lock_arg = atc260x->regmap_mutex;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(atc260x_match_device);
+
+int atc260x_device_probe(struct atc260x *atc260x)
+{
+	struct device *dev = atc260x->dev;
+	unsigned int chip_rev;
+	int ret;
+
+	if (!atc260x->irq) {
+		dev_err(dev, "No interrupt support\n");
+		return -EINVAL;
+	}
+
+	/* Initialize the hardware */
+	if (atc260x->dev_init)
+		atc260x->dev_init(atc260x);
+
+	ret = regmap_read(atc260x->regmap, atc260x->rev_reg, &chip_rev);
+	if (ret) {
+		dev_err(dev, "Failed to get chip revision\n");
+		return ret;
+	}
+
+	if (chip_rev < 0 || chip_rev > 31) {
+		dev_err(dev, "Unknown chip revision: %d\n", ret);
+		return -EINVAL;
+	}
+
+	atc260x->ic_ver = __ffs(chip_rev + 1U);
+
+	dev_info(dev, "Detected chip type %s rev.%c\n",
+		 atc260x->type_name, 'A' + atc260x->ic_ver);
+
+	ret = regmap_add_irq_chip(atc260x->regmap, atc260x->irq, IRQF_ONESHOT, -1,
+				  atc260x->regmap_irq_chip, &atc260x->irq_data);
+	if (ret) {
+		dev_err(dev, "Failed to add IRQ chip: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   atc260x->cells, atc260x->nr_cells, NULL, 0,
+				   regmap_irq_get_domain(atc260x->irq_data));
+	if (ret) {
+		dev_err(dev, "Failed to add child devices: %d\n", ret);
+		regmap_del_irq_chip(atc260x->irq, atc260x->irq_data);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(atc260x_device_probe);
+
+int atc260x_device_remove(struct atc260x *atc260x)
+{
+	mfd_remove_devices(atc260x->dev);
+	regmap_del_irq_chip(atc260x->irq, atc260x->irq_data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(atc260x_device_remove);
diff --git a/drivers/mfd/atc260x-i2c.c b/drivers/mfd/atc260x-i2c.c
new file mode 100644
index 000000000000..9795be35dc22
--- /dev/null
+++ b/drivers/mfd/atc260x-i2c.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * I2C bus interface for ATC260x PMICs
+ *
+ * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/mfd/atc260x/core.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static int atc260x_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct atc260x *atc260x;
+	struct regmap_config regmap_cfg;
+	int ret;
+
+	atc260x = devm_kzalloc(&client->dev, sizeof(*atc260x), GFP_KERNEL);
+	if (!atc260x)
+		return -ENOMEM;
+
+	atc260x->dev = &client->dev;
+	atc260x->irq = client->irq;
+
+	ret = atc260x_match_device(atc260x, &regmap_cfg);
+	if (ret)
+		return ret;
+
+	i2c_set_clientdata(client, atc260x);
+
+	atc260x->regmap = devm_regmap_init_i2c(client, &regmap_cfg);
+	if (IS_ERR(atc260x->regmap)) {
+		ret = PTR_ERR(atc260x->regmap);
+		dev_err(&client->dev, "failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	return atc260x_device_probe(atc260x);
+}
+
+static int atc260x_i2c_remove(struct i2c_client *client)
+{
+	struct atc260x *atc260x = i2c_get_clientdata(client);
+
+	return atc260x_device_remove(atc260x);
+}
+
+const struct of_device_id atc260x_i2c_of_match[] = {
+	{ .compatible = "actions,atc2603c", .data = (void *)ATC2603C },
+	{ .compatible = "actions,atc2609a", .data = (void *)ATC2609A },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, atc260x_i2c_of_match);
+
+static struct i2c_driver atc260x_i2c_driver = {
+	.driver = {
+		.name	= "atc260x",
+		.of_match_table	= of_match_ptr(atc260x_i2c_of_match),
+	},
+	.probe		= atc260x_i2c_probe,
+	.remove		= atc260x_i2c_remove,
+};
+
+module_i2c_driver(atc260x_i2c_driver);
+
+MODULE_DESCRIPTION("ATC260x PMICs I2C bus interface");
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/atc260x/atc2603c.h b/include/linux/mfd/atc260x/atc2603c.h
new file mode 100644
index 000000000000..07ac640ef3e1
--- /dev/null
+++ b/include/linux/mfd/atc260x/atc2603c.h
@@ -0,0 +1,281 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * ATC2603C PMIC register definitions
+ *
+ * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#ifndef __LINUX_MFD_ATC260X_ATC2603C_H
+#define __LINUX_MFD_ATC260X_ATC2603C_H
+
+enum atc2603c_irq_def {
+	ATC2603C_IRQ_AUDIO = 0,
+	ATC2603C_IRQ_OV,
+	ATC2603C_IRQ_OC,
+	ATC2603C_IRQ_OT,
+	ATC2603C_IRQ_UV,
+	ATC2603C_IRQ_ALARM,
+	ATC2603C_IRQ_ONOFF,
+	ATC2603C_IRQ_SGPIO,
+	ATC2603C_IRQ_IR,
+	ATC2603C_IRQ_REMCON,
+	ATC2603C_IRQ_POWER_IN,
+};
+
+/* PMU Registers */
+#define ATC2603C_PMU_SYS_CTL0			0x00
+#define ATC2603C_PMU_SYS_CTL1			0x01
+#define ATC2603C_PMU_SYS_CTL2			0x02
+#define ATC2603C_PMU_SYS_CTL3			0x03
+#define ATC2603C_PMU_SYS_CTL4			0x04
+#define ATC2603C_PMU_SYS_CTL5			0x05
+#define ATC2603C_PMU_SYS_CTL6			0x06
+#define ATC2603C_PMU_SYS_CTL7			0x07
+#define ATC2603C_PMU_SYS_CTL8			0x08
+#define ATC2603C_PMU_SYS_CTL9			0x09
+#define ATC2603C_PMU_BAT_CTL0			0x0A
+#define ATC2603C_PMU_BAT_CTL1			0x0B
+#define ATC2603C_PMU_VBUS_CTL0			0x0C
+#define ATC2603C_PMU_VBUS_CTL1			0x0D
+#define ATC2603C_PMU_WALL_CTL0			0x0E
+#define ATC2603C_PMU_WALL_CTL1			0x0F
+#define ATC2603C_PMU_SYS_PENDING		0x10
+#define ATC2603C_PMU_DC1_CTL0			0x11
+#define ATC2603C_PMU_DC1_CTL1			0x12 // Undocumented
+#define ATC2603C_PMU_DC1_CTL2			0x13 // Undocumented
+#define ATC2603C_PMU_DC2_CTL0			0x14
+#define ATC2603C_PMU_DC2_CTL1			0x15 // Undocumented
+#define ATC2603C_PMU_DC2_CTL2			0x16 // Undocumented
+#define ATC2603C_PMU_DC3_CTL0			0x17
+#define ATC2603C_PMU_DC3_CTL1			0x18 // Undocumented
+#define ATC2603C_PMU_DC3_CTL2			0x19 // Undocumented
+#define ATC2603C_PMU_DC4_CTL0			0x1A // Undocumented
+#define ATC2603C_PMU_DC4_CTL1			0x1B // Undocumented
+#define ATC2603C_PMU_DC5_CTL0			0x1C // Undocumented
+#define ATC2603C_PMU_DC5_CTL1			0x1D // Undocumented
+#define ATC2603C_PMU_LDO1_CTL			0x1E
+#define ATC2603C_PMU_LDO2_CTL			0x1F
+#define ATC2603C_PMU_LDO3_CTL			0x20
+#define ATC2603C_PMU_LDO4_CTL			0x21 // Undocumented
+#define ATC2603C_PMU_LDO5_CTL			0x22
+#define ATC2603C_PMU_LDO6_CTL			0x23
+#define ATC2603C_PMU_LDO7_CTL			0x24
+#define ATC2603C_PMU_LDO8_CTL			0x25 // Undocumented
+#define ATC2603C_PMU_LDO9_CTL			0x26 // Undocumented
+#define ATC2603C_PMU_LDO10_CTL			0x27 // Undocumented
+#define ATC2603C_PMU_LDO11_CTL			0x28
+#define ATC2603C_PMU_SWITCH_CTL			0x29
+#define ATC2603C_PMU_OV_CTL0			0x2A
+#define ATC2603C_PMU_OV_CTL1			0x2B
+#define ATC2603C_PMU_OV_STATUS			0x2C
+#define ATC2603C_PMU_OV_EN			0x2D
+#define ATC2603C_PMU_OV_INT_EN			0x2E
+#define ATC2603C_PMU_OC_CTL			0x2F
+#define ATC2603C_PMU_OC_STATUS			0x30
+#define ATC2603C_PMU_OC_EN			0x31
+#define ATC2603C_PMU_OC_INT_EN			0x32
+#define ATC2603C_PMU_UV_CTL0			0x33
+#define ATC2603C_PMU_UV_CTL1			0x34
+#define ATC2603C_PMU_UV_STATUS			0x35
+#define ATC2603C_PMU_UV_EN			0x36
+#define ATC2603C_PMU_UV_INT_EN			0x37
+#define ATC2603C_PMU_OT_CTL			0x38
+#define ATC2603C_PMU_CHARGER_CTL0		0x39
+#define ATC2603C_PMU_CHARGER_CTL1		0x3A
+#define ATC2603C_PMU_CHARGER_CTL2		0x3B
+#define ATC2603C_PMU_BAKCHARGER_CTL		0x3C // Undocumented
+#define ATC2603C_PMU_APDS_CTL			0x3D
+#define ATC2603C_PMU_AUXADC_CTL0		0x3E
+#define ATC2603C_PMU_AUXADC_CTL1		0x3F
+#define ATC2603C_PMU_BATVADC			0x40
+#define ATC2603C_PMU_BATIADC			0x41
+#define ATC2603C_PMU_WALLVADC			0x42
+#define ATC2603C_PMU_WALLIADC			0x43
+#define ATC2603C_PMU_VBUSVADC			0x44
+#define ATC2603C_PMU_VBUSIADC			0x45
+#define ATC2603C_PMU_SYSPWRADC			0x46
+#define ATC2603C_PMU_REMCONADC			0x47
+#define ATC2603C_PMU_SVCCADC			0x48
+#define ATC2603C_PMU_CHGIADC			0x49
+#define ATC2603C_PMU_IREFADC			0x4A
+#define ATC2603C_PMU_BAKBATADC			0x4B
+#define ATC2603C_PMU_ICTEMPADC			0x4C
+#define ATC2603C_PMU_AUXADC0			0x4D
+#define ATC2603C_PMU_AUXADC1			0x4E
+#define ATC2603C_PMU_AUXADC2			0x4F
+#define	ATC2603C_PMU_ICMADC			0x50
+#define ATC2603C_PMU_BDG_CTL			0x51 // Undocumented
+#define ATC2603C_RTC_CTL			0x52
+#define ATC2603C_RTC_MSALM			0x53
+#define ATC2603C_RTC_HALM			0x54
+#define ATC2603C_RTC_YMDALM			0x55
+#define ATC2603C_RTC_MS				0x56
+#define ATC2603C_RTC_H				0x57
+#define ATC2603C_RTC_DC				0x58
+#define ATC2603C_RTC_YMD			0x59
+#define ATC2603C_EFUSE_DAT			0x5A // Undocumented
+#define ATC2603C_EFUSECRTL1			0x5B // Undocumented
+#define ATC2603C_EFUSECRTL2			0x5C // Undocumented
+#define ATC2603C_PMU_FW_USE0			0x5D // Undocumented
+#define ATC2603C_PMU_FW_USE1			0x5E // Undocumented
+#define ATC2603C_PMU_FW_USE2			0x5F // Undocumented
+#define ATC2603C_PMU_FW_USE3			0x60 // Undocumented
+#define ATC2603C_PMU_FW_USE4			0x61 // Undocumented
+#define ATC2603C_PMU_ABNORMAL_STATUS		0x62
+#define ATC2603C_PMU_WALL_APDS_CTL		0x63
+#define ATC2603C_PMU_REMCON_CTL0		0x64
+#define ATC2603C_PMU_REMCON_CTL1		0x65
+#define ATC2603C_PMU_MUX_CTL0			0x66
+#define ATC2603C_PMU_SGPIO_CTL0			0x67
+#define ATC2603C_PMU_SGPIO_CTL1			0x68
+#define ATC2603C_PMU_SGPIO_CTL2			0x69
+#define ATC2603C_PMU_SGPIO_CTL3			0x6A
+#define ATC2603C_PMU_SGPIO_CTL4			0x6B
+#define ATC2603C_PWMCLK_CTL			0x6C
+#define ATC2603C_PWM0_CTL			0x6D
+#define ATC2603C_PWM1_CTL			0x6E
+#define ATC2603C_PMU_ADC_DBG0			0x70
+#define ATC2603C_PMU_ADC_DBG1			0x71
+#define ATC2603C_PMU_ADC_DBG2			0x72
+#define ATC2603C_PMU_ADC_DBG3			0x73
+#define ATC2603C_PMU_ADC_DBG4			0x74
+#define ATC2603C_IRC_CTL			0x80
+#define ATC2603C_IRC_STAT			0x81
+#define ATC2603C_IRC_CC				0x82
+#define ATC2603C_IRC_KDC			0x83
+#define ATC2603C_IRC_WK				0x84
+#define ATC2603C_IRC_RCC			0x85
+#define ATC2603C_IRC_FILTER			0x86
+
+/* AUDIO_OUT Registers */
+#define ATC2603C_AUDIOINOUT_CTL			0xA0
+#define ATC2603C_AUDIO_DEBUGOUTCTL		0xA1
+#define ATC2603C_DAC_DIGITALCTL			0xA2
+#define ATC2603C_DAC_VOLUMECTL0			0xA3
+#define ATC2603C_DAC_ANALOG0			0xA4
+#define ATC2603C_DAC_ANALOG1			0xA5
+#define ATC2603C_DAC_ANALOG2			0xA6
+#define ATC2603C_DAC_ANALOG3			0xA7
+
+/* AUDIO_IN Registers */
+#define ATC2603C_ADC_DIGITALCTL			0xA8
+#define ATC2603C_ADC_HPFCTL			0xA9
+#define ATC2603C_ADC_CTL			0xAA
+#define ATC2603C_AGC_CTL0			0xAB
+#define ATC2603C_AGC_CTL1			0xAC // Undocumented
+#define ATC2603C_AGC_CTL2			0xAD
+#define ATC2603C_ADC_ANALOG0			0xAE
+#define ATC2603C_ADC_ANALOG1			0xAF
+
+/* PCM_IF Registers */
+#define ATC2603C_PCM0_CTL			0xB0 // Undocumented
+#define ATC2603C_PCM1_CTL			0xB1 // Undocumented
+#define ATC2603C_PCM2_CTL			0xB2 // Undocumented
+#define ATC2603C_PCMIF_CTL			0xB3 // Undocumented
+
+/* CMU_CONTROL Registers */
+#define ATC2603C_CMU_DEVRST			0xC1 // Undocumented
+
+/* INTS Registers */
+#define ATC2603C_INTS_PD			0xC8
+#define ATC2603C_INTS_MSK			0xC9
+
+/* MFP Registers */
+#define ATC2603C_MFP_CTL			0xD0
+#define ATC2603C_PAD_VSEL			0xD1 // Undocumented
+#define ATC2603C_GPIO_OUTEN			0xD2
+#define ATC2603C_GPIO_INEN			0xD3
+#define ATC2603C_GPIO_DAT			0xD4
+#define ATC2603C_PAD_DRV			0xD5
+#define ATC2603C_PAD_EN				0xD6
+#define ATC2603C_DEBUG_SEL			0xD7 // Undocumented
+#define ATC2603C_DEBUG_IE			0xD8 // Undocumented
+#define ATC2603C_DEBUG_OE			0xD9 // Undocumented
+#define ATC2603C_BIST_START			0x0A // Undocumented
+#define ATC2603C_BIST_RESULT			0x0B // Undocumented
+#define ATC2603C_CHIP_VER			0xDC
+
+/* TWSI Registers */
+#define ATC2603C_SADDR				0xFF
+
+/* PMU_SYS_CTL0 Register Mask Bits */
+#define ATC2603C_PMU_SYS_CTL0_IR_WK_EN			BIT(5)
+#define ATC2603C_PMU_SYS_CTL0_RESET_WK_EN		BIT(6)
+#define ATC2603C_PMU_SYS_CTL0_HDSW_WK_EN		BIT(7)
+#define ATC2603C_PMU_SYS_CTL0_ALARM_WK_EN		BIT(8)
+#define ATC2603C_PMU_SYS_CTL0_REM_CON_WK_EN		BIT(9)
+#define ATC2603C_PMU_SYS_CTL0_RESTART_EN		BIT(10)
+#define ATC2603C_PMU_SYS_CTL0_SGPIOIRQ_WK_EN		BIT(11)
+#define ATC2603C_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN		BIT(12)
+#define ATC2603C_PMU_SYS_CTL0_ONOFF_LONG_WK_EN		BIT(13)
+#define ATC2603C_PMU_SYS_CTL0_WALL_WK_EN		BIT(14)
+#define ATC2603C_PMU_SYS_CTL0_USB_WK_EN			BIT(15)
+#define ATC2603C_PMU_SYS_CTL0_WK_ALL			(GENMASK(15, 5) & (~BIT(10)))
+
+/* PMU_SYS_CTL1 Register Mask Bits */
+#define ATC2603C_PMU_SYS_CTL1_EN_S1			BIT(0)
+#define ATC2603C_PMU_SYS_CTL1_LB_S4_EN			BIT(2)
+#define ATC2603C_PMU_SYS_CTL1_LB_S4			GENMASK(4, 3)
+#define ATC2603C_PMU_SYS_CTL1_LB_S4_3_1V		BIT(4)
+#define ATC2603C_PMU_SYS_CTL1_IR_WK_FLAG		BIT(5)
+#define ATC2603C_PMU_SYS_CTL1_RESET_WK_FLAG		BIT(6)
+#define ATC2603C_PMU_SYS_CTL1_HDSW_WK_FLAG		BIT(7)
+#define ATC2603C_PMU_SYS_CTL1_ALARM_WK_FLAG		BIT(8)
+#define ATC2603C_PMU_SYS_CTL1_REM_CON_WK_FLAG		BIT(9)
+#define ATC2603C_PMU_SYS_CTL1_ONOFF_PRESS_RESET_IRQ_PD	BIT(10)
+#define ATC2603C_PMU_SYS_CTL1_SGPIOIRQ_WK_FLAG		BIT(11)
+#define ATC2603C_PMU_SYS_CTL1_ONOFF_SHORT_WK_FLAG	BIT(12)
+#define ATC2603C_PMU_SYS_CTL1_ONOFF_LONG_WK_FLAG	BIT(13)
+#define ATC2603C_PMU_SYS_CTL1_WALL_WK_FLAG		BIT(14)
+#define ATC2603C_PMU_SYS_CTL1_USB_WK_FLAG		BIT(15)
+
+/* PMU_SYS_CTL2 Register Mask Bits */
+#define ATC2603C_PMU_SYS_CTL2_PMU_A_EN			BIT(0)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_INT_EN	BIT(1)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_PD		BIT(2)
+#define ATC2603C_PMU_SYS_CTL2_S2TIMER			GENMASK(5, 3)
+#define ATC2603C_PMU_SYS_CTL2_S2_TIMER_EN		BIT(6)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL	GENMASK(8, 7)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_RESET_EN	BIT(9)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS_TIME		GENMASK(11, 10)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_INT_EN		BIT(12)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_LONG_PRESS		BIT(13)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_SHORT_PRESS		BIT(14)
+#define ATC2603C_PMU_SYS_CTL2_ONOFF_PRESS		BIT(15)
+
+/* PMU_SYS_CTL3 Register Mask Bits */
+#define ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER		GENMASK(8, 7)
+#define ATC2603C_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN		BIT(9)
+#define ATC2603C_PMU_SYS_CTL3_S3_TIMER			GENMASK(12, 10)
+#define ATC2603C_PMU_SYS_CTL3_S3_TIMER_EN		BIT(13)
+#define ATC2603C_PMU_SYS_CTL3_EN_S3			BIT(14)
+#define ATC2603C_PMU_SYS_CTL3_EN_S2			BIT(15)
+
+/* PMU_SYS_CTL5 Register Mask Bits */
+#define ATC2603C_PMU_SYS_CTL5_WALLWKDTEN		BIT(7)
+#define ATC2603C_PMU_SYS_CTL5_VBUSWKDTEN		BIT(8)
+#define ATC2603C_PMU_SYS_CTL5_REMCON_DECT_EN		BIT(9)
+#define ATC2603C_PMU_SYS_CTL5_ONOFF_8S_SEL		BIT(10)
+
+/* INTS_MSK Register Mask Bits */
+#define ATC2603C_INTS_MSK_AUDIO				BIT(0)
+#define ATC2603C_INTS_MSK_OV				BIT(1)
+#define ATC2603C_INTS_MSK_OC				BIT(2)
+#define ATC2603C_INTS_MSK_OT				BIT(3)
+#define ATC2603C_INTS_MSK_UV				BIT(4)
+#define ATC2603C_INTS_MSK_ALARM				BIT(5)
+#define ATC2603C_INTS_MSK_ONOFF				BIT(6)
+#define ATC2603C_INTS_MSK_SGPIO				BIT(7)
+#define ATC2603C_INTS_MSK_IR				BIT(8)
+#define ATC2603C_INTS_MSK_REMCON			BIT(9)
+#define ATC2603C_INTS_MSK_POWERIN			BIT(10)
+
+/* CMU_DEVRST Register Mask Bits */
+#define ATC2603C_CMU_DEVRST_MFP				BIT(1)
+#define ATC2603C_CMU_DEVRST_INTS			BIT(2)
+#define ATC2603C_CMU_DEVRST_AUDIO			BIT(4)
+
+/* PAD_EN Register Mask Bits */
+#define ATC2603C_PAD_EN_EXTIRQ				BIT(0)
+
+#endif /* __LINUX_MFD_ATC260X_ATC2603C_H */
diff --git a/include/linux/mfd/atc260x/atc2609a.h b/include/linux/mfd/atc260x/atc2609a.h
new file mode 100644
index 000000000000..b957d7bd73e9
--- /dev/null
+++ b/include/linux/mfd/atc260x/atc2609a.h
@@ -0,0 +1,308 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * ATC2609A PMIC register definitions
+ *
+ * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#ifndef __LINUX_MFD_ATC260X_ATC2609A_H
+#define __LINUX_MFD_ATC260X_ATC2609A_H
+
+enum atc2609a_irq_def {
+	ATC2609A_IRQ_AUDIO = 0,
+	ATC2609A_IRQ_OV,
+	ATC2609A_IRQ_OC,
+	ATC2609A_IRQ_OT,
+	ATC2609A_IRQ_UV,
+	ATC2609A_IRQ_ALARM,
+	ATC2609A_IRQ_ONOFF,
+	ATC2609A_IRQ_WKUP,
+	ATC2609A_IRQ_IR,
+	ATC2609A_IRQ_REMCON,
+	ATC2609A_IRQ_POWER_IN,
+};
+
+/* PMU Registers */
+#define ATC2609A_PMU_SYS_CTL0			0x00
+#define ATC2609A_PMU_SYS_CTL1			0x01
+#define ATC2609A_PMU_SYS_CTL2			0x02
+#define ATC2609A_PMU_SYS_CTL3			0x03
+#define ATC2609A_PMU_SYS_CTL4			0x04
+#define ATC2609A_PMU_SYS_CTL5			0x05
+#define ATC2609A_PMU_SYS_CTL6			0x06
+#define ATC2609A_PMU_SYS_CTL7			0x07
+#define ATC2609A_PMU_SYS_CTL8			0x08
+#define ATC2609A_PMU_SYS_CTL9			0x09
+#define ATC2609A_PMU_BAT_CTL0			0x0A
+#define ATC2609A_PMU_BAT_CTL1			0x0B
+#define ATC2609A_PMU_VBUS_CTL0			0x0C
+#define ATC2609A_PMU_VBUS_CTL1			0x0D
+#define ATC2609A_PMU_WALL_CTL0			0x0E
+#define ATC2609A_PMU_WALL_CTL1			0x0F
+#define ATC2609A_PMU_SYS_PENDING		0x10
+#define ATC2609A_PMU_APDS_CTL0			0x11
+#define ATC2609A_PMU_APDS_CTL1			0x12
+#define ATC2609A_PMU_APDS_CTL2			0x13
+#define ATC2609A_PMU_CHARGER_CTL		0x14
+#define ATC2609A_PMU_BAKCHARGER_CTL		0x15
+#define ATC2609A_PMU_SWCHG_CTL0			0x16
+#define ATC2609A_PMU_SWCHG_CTL1			0x17
+#define ATC2609A_PMU_SWCHG_CTL2			0x18
+#define ATC2609A_PMU_SWCHG_CTL3			0x19
+#define ATC2609A_PMU_SWCHG_CTL4			0x1A
+#define ATC2609A_PMU_DC_OSC			0x1B
+#define ATC2609A_PMU_DC0_CTL0			0x1C
+#define ATC2609A_PMU_DC0_CTL1			0x1D
+#define ATC2609A_PMU_DC0_CTL2			0x1E
+#define ATC2609A_PMU_DC0_CTL3			0x1F
+#define ATC2609A_PMU_DC0_CTL4			0x20
+#define ATC2609A_PMU_DC0_CTL5			0x21
+#define ATC2609A_PMU_DC0_CTL6			0x22
+#define ATC2609A_PMU_DC1_CTL0			0x23
+#define ATC2609A_PMU_DC1_CTL1			0x24
+#define ATC2609A_PMU_DC1_CTL2			0x25
+#define ATC2609A_PMU_DC1_CTL3			0x26
+#define ATC2609A_PMU_DC1_CTL4			0x27
+#define ATC2609A_PMU_DC1_CTL5			0x28
+#define ATC2609A_PMU_DC1_CTL6			0x29
+#define ATC2609A_PMU_DC2_CTL0			0x2A
+#define ATC2609A_PMU_DC2_CTL1			0x2B
+#define ATC2609A_PMU_DC2_CTL2			0x2C
+#define ATC2609A_PMU_DC2_CTL3			0x2D
+#define ATC2609A_PMU_DC2_CTL4			0x2E
+#define ATC2609A_PMU_DC2_CTL5			0x2F
+#define ATC2609A_PMU_DC2_CTL6			0x30
+#define ATC2609A_PMU_DC3_CTL0			0x31
+#define ATC2609A_PMU_DC3_CTL1			0x32
+#define ATC2609A_PMU_DC3_CTL2			0x33
+#define ATC2609A_PMU_DC3_CTL3			0x34
+#define ATC2609A_PMU_DC3_CTL4			0x35
+#define ATC2609A_PMU_DC3_CTL5			0x36
+#define ATC2609A_PMU_DC3_CTL6			0x37
+#define ATC2609A_PMU_DC_ZR			0x38
+#define ATC2609A_PMU_LDO0_CTL0			0x39
+#define ATC2609A_PMU_LDO0_CTL1			0x3A
+#define ATC2609A_PMU_LDO1_CTL0			0x3B
+#define ATC2609A_PMU_LDO1_CTL1			0x3C
+#define ATC2609A_PMU_LDO2_CTL0			0x3D
+#define ATC2609A_PMU_LDO2_CTL1			0x3E
+#define ATC2609A_PMU_LDO3_CTL0			0x3F
+#define ATC2609A_PMU_LDO3_CTL1			0x40
+#define ATC2609A_PMU_LDO4_CTL0			0x41
+#define ATC2609A_PMU_LDO4_CTL1			0x42
+#define ATC2609A_PMU_LDO5_CTL0			0x43
+#define ATC2609A_PMU_LDO5_CTL1			0x44
+#define ATC2609A_PMU_LDO6_CTL0			0x45
+#define ATC2609A_PMU_LDO6_CTL1			0x46
+#define ATC2609A_PMU_LDO7_CTL0			0x47
+#define ATC2609A_PMU_LDO7_CTL1			0x48
+#define ATC2609A_PMU_LDO8_CTL0			0x49
+#define ATC2609A_PMU_LDO8_CTL1			0x4A
+#define ATC2609A_PMU_LDO9_CTL			0x4B
+#define ATC2609A_PMU_OV_INT_EN			0x4C
+#define ATC2609A_PMU_OV_STATUS			0x4D
+#define ATC2609A_PMU_UV_INT_EN			0x4E
+#define ATC2609A_PMU_UV_STATUS			0x4F
+#define ATC2609A_PMU_OC_INT_EN			0x50
+#define ATC2609A_PMU_OC_STATUS			0x51
+#define ATC2609A_PMU_OT_CTL			0x52
+#define ATC2609A_PMU_CM_CTL0			0x53
+#define ATC2609A_PMU_FW_USE0			0x54
+#define ATC2609A_PMU_FW_USE1			0x55
+#define ATC2609A_PMU_ADC12B_I			0x56
+#define ATC2609A_PMU_ADC12B_V			0x57
+#define ATC2609A_PMU_ADC12B_DUMMY		0x58
+#define ATC2609A_PMU_AUXADC_CTL0		0x59
+#define ATC2609A_PMU_AUXADC_CTL1		0x5A
+#define ATC2609A_PMU_BATVADC			0x5B
+#define ATC2609A_PMU_BATIADC			0x5C
+#define ATC2609A_PMU_WALLVADC			0x5D
+#define ATC2609A_PMU_WALLIADC			0x5E
+#define ATC2609A_PMU_VBUSVADC			0x5F
+#define ATC2609A_PMU_VBUSIADC			0x60
+#define ATC2609A_PMU_SYSPWRADC			0x61
+#define ATC2609A_PMU_REMCONADC			0x62
+#define ATC2609A_PMU_SVCCADC			0x63
+#define ATC2609A_PMU_CHGIADC			0x64
+#define ATC2609A_PMU_IREFADC			0x65
+#define ATC2609A_PMU_BAKBATADC			0x66
+#define ATC2609A_PMU_ICTEMPADC			0x67
+#define ATC2609A_PMU_AUXADC0			0x68
+#define ATC2609A_PMU_AUXADC1			0x69
+#define ATC2609A_PMU_AUXADC2			0x6A
+#define ATC2609A_PMU_AUXADC3			0x6B
+#define ATC2609A_PMU_ICTEMPADC_ADJ		0x6C
+#define ATC2609A_PMU_BDG_CTL			0x6D
+#define ATC2609A_RTC_CTL			0x6E
+#define ATC2609A_RTC_MSALM			0x6F
+#define ATC2609A_RTC_HALM			0x70
+#define ATC2609A_RTC_YMDALM			0x71
+#define ATC2609A_RTC_MS				0x72
+#define ATC2609A_RTC_H				0x73
+#define ATC2609A_RTC_DC				0x74
+#define ATC2609A_RTC_YMD			0x75
+#define ATC2609A_EFUSE_DAT			0x76
+#define ATC2609A_EFUSECRTL1			0x77
+#define ATC2609A_EFUSECRTL2			0x78
+#define ATC2609A_PMU_DC4_CTL0			0x79
+#define ATC2609A_PMU_DC4_CTL1			0x7A
+#define ATC2609A_PMU_DC4_CTL2			0x7B
+#define ATC2609A_PMU_DC4_CTL3			0x7C
+#define ATC2609A_PMU_DC4_CTL4			0x7D
+#define ATC2609A_PMU_DC4_CTL5			0x7E
+#define ATC2609A_PMU_DC4_CTL6			0x7F
+#define ATC2609A_PMU_PWR_STATUS			0x80
+#define ATC2609A_PMU_S2_PWR			0x81
+#define ATC2609A_CLMT_CTL0			0x82
+#define ATC2609A_CLMT_DATA0			0x83
+#define ATC2609A_CLMT_DATA1			0x84
+#define ATC2609A_CLMT_DATA2			0x85
+#define ATC2609A_CLMT_DATA3			0x86
+#define ATC2609A_CLMT_ADD0			0x87
+#define ATC2609A_CLMT_ADD1			0x88
+#define ATC2609A_CLMT_OCV_TABLE			0x89
+#define ATC2609A_CLMT_R_TABLE			0x8A
+#define ATC2609A_PMU_PWRON_CTL0			0x8D
+#define ATC2609A_PMU_PWRON_CTL1			0x8E
+#define ATC2609A_PMU_PWRON_CTL2			0x8F
+#define ATC2609A_IRC_CTL			0x90
+#define ATC2609A_IRC_STAT			0x91
+#define ATC2609A_IRC_CC				0x92
+#define ATC2609A_IRC_KDC			0x93
+#define ATC2609A_IRC_WK				0x94
+#define ATC2609A_IRC_RCC			0x95
+
+/* AUDIO_OUT Registers */
+#define ATC2609A_AUDIOINOUT_CTL			0xA0
+#define ATC2609A_AUDIO_DEBUGOUTCTL		0xA1
+#define ATC2609A_DAC_DIGITALCTL			0xA2
+#define ATC2609A_DAC_VOLUMECTL0			0xA3
+#define ATC2609A_DAC_ANALOG0			0xA4
+#define ATC2609A_DAC_ANALOG1			0xA5
+#define ATC2609A_DAC_ANALOG2			0xA6
+#define ATC2609A_DAC_ANALOG3			0xA7
+
+/* AUDIO_IN Registers */
+#define ATC2609A_ADC_DIGITALCTL			0xA8
+#define ATC2609A_ADC_HPFCTL			0xA9
+#define ATC2609A_ADC_CTL			0xAA
+#define ATC2609A_AGC_CTL0			0xAB
+#define ATC2609A_AGC_CTL1			0xAC
+#define ATC2609A_AGC_CTL2			0xAD
+#define ATC2609A_ADC_ANALOG0			0xAE
+#define ATC2609A_ADC_ANALOG1			0xAF
+
+/* PCM_IF Registers */
+#define ATC2609A_PCM0_CTL			0xB0
+#define ATC2609A_PCM1_CTL			0xB1
+#define ATC2609A_PCM2_CTL			0xB2
+#define ATC2609A_PCMIF_CTL			0xB3
+
+/* CMU_CONTROL Registers */
+#define ATC2609A_CMU_DEVRST			0xC1
+
+/* INTS Registers */
+#define ATC2609A_INTS_PD			0xC8
+#define ATC2609A_INTS_MSK			0xC9
+
+/* MFP Registers */
+#define ATC2609A_MFP_CTL			0xD0
+#define ATC2609A_PAD_VSEL			0xD1
+#define ATC2609A_GPIO_OUTEN			0xD2
+#define ATC2609A_GPIO_INEN			0xD3
+#define ATC2609A_GPIO_DAT			0xD4
+#define ATC2609A_PAD_DRV			0xD5
+#define ATC2609A_PAD_EN				0xD6
+#define ATC2609A_DEBUG_SEL			0xD7
+#define ATC2609A_DEBUG_IE			0xD8
+#define ATC2609A_DEBUG_OE			0xD9
+#define ATC2609A_CHIP_VER			0xDC
+
+/* PWSI Registers */
+#define ATC2609A_PWSI_CTL			0xF0
+#define ATC2609A_PWSI_STATUS			0xF1
+
+/* TWSI Registers */
+#define ATC2609A_SADDR				0xFF
+
+/* PMU_SYS_CTL0 Register Mask Bits */
+#define ATC2609A_PMU_SYS_CTL0_IR_WK_EN			BIT(5)
+#define ATC2609A_PMU_SYS_CTL0_RESET_WK_EN		BIT(6)
+#define ATC2609A_PMU_SYS_CTL0_HDSW_WK_EN		BIT(7)
+#define ATC2609A_PMU_SYS_CTL0_ALARM_WK_EN		BIT(8)
+#define ATC2609A_PMU_SYS_CTL0_REM_CON_WK_EN		BIT(9)
+#define ATC2609A_PMU_SYS_CTL0_RESTART_EN		BIT(10)
+#define ATC2609A_PMU_SYS_CTL0_WKIRQ_WK_EN		BIT(11)
+#define ATC2609A_PMU_SYS_CTL0_ONOFF_SHORT_WK_EN		BIT(12)
+#define ATC2609A_PMU_SYS_CTL0_ONOFF_LONG_WK_EN		BIT(13)
+#define ATC2609A_PMU_SYS_CTL0_WALL_WK_EN		BIT(14)
+#define ATC2609A_PMU_SYS_CTL0_USB_WK_EN			BIT(15)
+#define ATC2609A_PMU_SYS_CTL0_WK_ALL			(GENMASK(15, 5) & (~BIT(10)))
+
+/* PMU_SYS_CTL1 Register Mask Bits */
+#define ATC2609A_PMU_SYS_CTL1_EN_S1			BIT(0)
+#define ATC2609A_PMU_SYS_CTL1_LB_S4_EN			BIT(2)
+#define ATC2609A_PMU_SYS_CTL1_LB_S4			GENMASK(4, 3)
+#define ATC2609A_PMU_SYS_CTL1_LB_S4_3_1V		BIT(4)
+#define ATC2609A_PMU_SYS_CTL1_IR_WK_FLAG		BIT(5)
+#define ATC2609A_PMU_SYS_CTL1_RESET_WK_FLAG		BIT(6)
+#define ATC2609A_PMU_SYS_CTL1_HDSW_WK_FLAG		BIT(7)
+#define ATC2609A_PMU_SYS_CTL1_ALARM_WK_FLAG		BIT(8)
+#define ATC2609A_PMU_SYS_CTL1_REM_CON_WK_FLAG		BIT(9)
+#define ATC2609A_PMU_SYS_CTL1_RESTART_WK_FLAG		BIT(10)
+#define ATC2609A_PMU_SYS_CTL1_WKIRQ_WK_FLAG		BIT(11)
+#define ATC2609A_PMU_SYS_CTL1_ONOFF_SHORT_WK_FLAG	BIT(12)
+#define ATC2609A_PMU_SYS_CTL1_ONOFF_LONG_WK_FLAG	BIT(13)
+#define ATC2609A_PMU_SYS_CTL1_WALL_WK_FLAG		BIT(14)
+#define ATC2609A_PMU_SYS_CTL1_USB_WK_FLAG		BIT(15)
+
+/* PMU_SYS_CTL2 Register Mask Bits */
+#define ATC2609A_PMU_SYS_CTL2_PMU_A_EN			BIT(0)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_INT_EN	BIT(1)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_PD		BIT(2)
+#define ATC2609A_PMU_SYS_CTL2_S2TIMER			GENMASK(5, 3)
+#define ATC2609A_PMU_SYS_CTL2_S2_TIMER_EN		BIT(6)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_TIME_SEL	GENMASK(8, 7)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_RESET_EN		BIT(9)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS_TIME		GENMASK(11, 10)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_LSP_INT_EN		BIT(12)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_LONG_PRESS		BIT(13)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_SHORT_PRESS		BIT(14)
+#define ATC2609A_PMU_SYS_CTL2_ONOFF_PRESS		BIT(15)
+
+/* PMU_SYS_CTL3 Register Mask Bits */
+#define ATC2609A_PMU_SYS_CTL3_S2S3TOS1_TIMER		GENMASK(8, 7)
+#define ATC2609A_PMU_SYS_CTL3_S2S3TOS1_TIMER_EN		BIT(9)
+#define ATC2609A_PMU_SYS_CTL3_S3_TIMER			GENMASK(12, 10)
+#define ATC2609A_PMU_SYS_CTL3_S3_TIMER_EN		BIT(13)
+#define ATC2609A_PMU_SYS_CTL3_EN_S3			BIT(14)
+#define ATC2609A_PMU_SYS_CTL3_EN_S2			BIT(15)
+
+/* PMU_SYS_CTL5 Register Mask Bits */
+#define ATC2609A_PMU_SYS_CTL5_WALLWKDTEN		BIT(7)
+#define ATC2609A_PMU_SYS_CTL5_VBUSWKDTEN		BIT(8)
+#define ATC2609A_PMU_SYS_CTL5_REMCON_DECT_EN		BIT(9)
+#define ATC2609A_PMU_SYS_CTL5_ONOFF_8S_SEL		BIT(10)
+
+/* INTS_MSK Register Mask Bits */
+#define ATC2609A_INTS_MSK_AUDIO				BIT(0)
+#define ATC2609A_INTS_MSK_OV				BIT(1)
+#define ATC2609A_INTS_MSK_OC				BIT(2)
+#define ATC2609A_INTS_MSK_OT				BIT(3)
+#define ATC2609A_INTS_MSK_UV				BIT(4)
+#define ATC2609A_INTS_MSK_ALARM				BIT(5)
+#define ATC2609A_INTS_MSK_ONOFF				BIT(6)
+#define ATC2609A_INTS_MSK_WKUP				BIT(7)
+#define ATC2609A_INTS_MSK_IR				BIT(8)
+#define ATC2609A_INTS_MSK_REMCON			BIT(9)
+#define ATC2609A_INTS_MSK_POWERIN			BIT(10)
+
+/* CMU_DEVRST Register Mask Bits */
+#define ATC2609A_CMU_DEVRST_AUDIO			BIT(0)
+#define ATC2609A_CMU_DEVRST_MFP				BIT(1)
+#define ATC2609A_CMU_DEVRST_INTS			BIT(2)
+
+/* PAD_EN Register Mask Bits */
+#define ATC2609A_PAD_EN_EXTIRQ				BIT(0)
+
+#endif /* __LINUX_MFD_ATC260X_ATC2609A_H */
diff --git a/include/linux/mfd/atc260x/core.h b/include/linux/mfd/atc260x/core.h
new file mode 100644
index 000000000000..a87b976f48e3
--- /dev/null
+++ b/include/linux/mfd/atc260x/core.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Core MFD defines for ATC260x PMICs
+ *
+ * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#ifndef __LINUX_MFD_ATC260X_CORE_H
+#define __LINUX_MFD_ATC260X_CORE_H
+
+#include <linux/mfd/atc260x/atc2603c.h>
+#include <linux/mfd/atc260x/atc2609a.h>
+
+enum atc260x_type {
+	ATC2603A = 0,
+	ATC2603C,
+	ATC2609A,
+};
+
+enum atc260x_ver {
+	ATC260X_A = 0,
+	ATC260X_B,
+	ATC260X_C,
+	ATC260X_D,
+	ATC260X_E,
+	ATC260X_F,
+	ATC260X_G,
+	ATC260X_H,
+};
+
+struct atc260x {
+	struct device *dev;
+
+	struct regmap *regmap;
+	const struct regmap_irq_chip *regmap_irq_chip;
+	struct regmap_irq_chip_data *irq_data;
+
+	struct mutex *regmap_mutex;	/* mutex for custom regmap locking */
+
+	const struct mfd_cell *cells;
+	int nr_cells;
+	int irq;
+
+	enum atc260x_type ic_type;
+	enum atc260x_ver ic_ver;
+	const char *type_name;
+	unsigned int rev_reg;
+
+	int (*dev_init)(struct atc260x *atc260x);
+};
+
+struct regmap_config;
+
+/**
+ * atc260x_match_device(): Setup atc260x variant related fields
+ *
+ * @atc260x: atc260x device to setup (.dev field must be set)
+ * @regmap_cfg: regmap config associated with this atc260x device
+ *
+ * This lets the atc260x core configure the mfd cells and register maps
+ * for later use.
+ */
+int atc260x_match_device(struct atc260x *atc260x, struct regmap_config *regmap_cfg);
+
+/**
+ * atc260x_device_probe(): Probe a configured atc260x device
+ *
+ * @atc260x: atc260x device to probe (must be configured)
+ *
+ * This function lets the atc260x core register the atc260x mfd devices
+ * and irqchip. The atc260x device passed in must be fully configured
+ * with atc260x_match_device, its irq set, and regmap created.
+ */
+int atc260x_device_probe(struct atc260x *atc260x);
+
+/**
+ * atc260x_device_remove(): Remove a atc260x device
+ *
+ * @atc260x: atc260x device to remove
+ *
+ * This tells the atc260x core to remove the associated mfd devices
+ */
+int atc260x_device_remove(struct atc260x *atc260x);
+
+#endif /* __LINUX_MFD_ATC260X_CORE_H */
-- 
2.28.0

