Return-Path: <linux-pm+bounces-27702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208AEAC5D1B
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0733AC3BA
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFA218AAA;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGeRczvc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41477217659;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384785; cv=none; b=SZq9S8TwRzpIr1dwOW5GK+azYJKW6rUVTXjz/tG/fP1Fl9vRrN4tKI2pojqPLCizvIoIqG8RGg1OzhWXNcg/MKfeWJOBZdiN5ywxiPPqBwsJrCAT2LTmWAzcai2uOTc9xsvXHQY4690Hu3cfbfppMaUeiqaD/y3urL8eGK4d2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384785; c=relaxed/simple;
	bh=/s+QbixNc92ZjKCweZkkApeCp7b0Cyl6wFWArJWiwuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJORAL6aVHJ4+Bdw9MVWFjjJzIkUo90fNbYv8GN+xoZ/3ZEo4L9EP8MSm9oG+0ADjmcoOdhwfsi9XFni2UkZd/BWAwdt4g2kzC3/cSzqBURNnc5K/jYep9VihuPSl8JmiVMH91R0MOcFo+14CqJBfHSQ9vCT4/n70DwTXe4nHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGeRczvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA1AAC4CEEE;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384784;
	bh=/s+QbixNc92ZjKCweZkkApeCp7b0Cyl6wFWArJWiwuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RGeRczvcIIjd5qXtDrgKNU90q+5tHPkIQx5Ev6NMtm0AXavEoOzjfztppX591+QWI
	 Ltk7Xlb7XEGwOC656hb3XYb/224+Oju+vDLt4D1BjLvS+FGsrfLhnjV9u2YK7CWSN4
	 KFSccyeYRgTuaNUoo8b4nCY1N3kBI7sIT6WN8gvB7+oHdwsURE16aIsoWnjLpyg2ML
	 LRAowbshLeAJz63ROTACL0ANHZmTvE+FV45S0Chty+g6TZuiH/5daJaC2ppv336RsA
	 KBwLbljZQHoSgM3t7EwDpEGvDaJQHJHrRM42/FM9iwdcND3Nu692zSPLaQt0b8K4j0
	 U/iYuAs8LscPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A14C5B54E;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 27 May 2025 18:25:34 -0400
Subject: [PATCH v3 2/6] mfd: pf1550: add core mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pf1550-v3-2-45f69453cd51@savoirfairelinux.com>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
In-Reply-To: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, eballetbo@gmail.com, 
 abelvesa@linux.com, b38343@freescale.com, yibin.gong@nxp.com, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748384783; l=19024;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=YXKY2FuzZ0SpEiZNrN0xJbTvE6dRwUm5NRk30tearmA=;
 b=AKuuxqae0JmZ5S/yNVOd6HzzFXvW7rvYJOGx6KdW+df40QT4ld3ofiz4hHQTJqez2cLX0zSo/
 mbKRSrCnImxA2F1qxuJeVruFX89GYah/ZmarXnGLDrI3KoCarEYeDA4
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add the core mfd driver for pf1550 PMIC. There are 3 subdevices for
which the drivers will be added in subsequent patches.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v3:
 - Address Dmitry's feedback:
   - Place Table IDs next to each other
   - Drop of_match_ptr
   - Replace dev_err with dev_err_probe in probe method
   - Drop useless log in probe
 - Map all irqs instead of doing it in the sub-devices as recommended by
   Dmitry.
v2:
 - Address feedback from Enric Balletbo Serra
---
 drivers/mfd/Kconfig        |  14 +++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/pf1550.c       | 277 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/pf1550.h | 241 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 534 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 22b93631003943c393d9fe704748bc23f1905397..c43bd7d51955e576a9dc948fabb8cf8420a47d8b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -558,6 +558,20 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_PF1550
+	tristate "Freescale Semiconductor PF1550 PMIC Support"
+	depends on I2C=y && OF
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for Freescale Semiconductor PF1550.
+	  This is a companion Power Management IC with regulators, onkey,
+	  and charger control on chip.
+	  This driver provides common support for accessing the device;
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 948cbdf42a18b22a826f0b17fb8d5796a7ec8ba6..c4f270c5538ac162e3006c6bec9ab8420ebea7f6 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -120,6 +120,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
+obj-$(CONFIG_MFD_PF1550)	+= pf1550.o
+
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o
diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
new file mode 100644
index 0000000000000000000000000000000000000000..7fd5bee7d24e51379562faeba0d3bc255e5f8048
--- /dev/null
+++ b/drivers/mfd/pf1550.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pf1550.c - mfd core driver for the PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * This driver is based on max77693.c
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static const struct mfd_cell pf1550_devs[] = {
+	{
+		.name = "pf1550-regulator",
+	},
+	{
+		.name = "pf1550-onkey",
+	},
+	{
+		.name = "pf1550-charger",
+	},
+};
+
+static const struct regmap_config pf1550_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PF1550_PMIC_REG_END,
+};
+
+static const struct regmap_irq pf1550_regulator_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_LS,         0, PMIC_IRQ_SW1_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_LS,         0, PMIC_IRQ_SW2_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_LS,         0, PMIC_IRQ_SW3_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_HS,         3, PMIC_IRQ_SW1_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_HS,         3, PMIC_IRQ_SW2_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_HS,         3, PMIC_IRQ_SW3_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO1_FAULT,    16, PMIC_IRQ_LDO1_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO2_FAULT,    16, PMIC_IRQ_LDO2_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO3_FAULT,    16, PMIC_IRQ_LDO3_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_110,      22, PMIC_IRQ_TEMP_110),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_125,      22, PMIC_IRQ_TEMP_125),
+};
+
+static const struct regmap_irq_chip pf1550_regulator_irq_chip = {
+	.name			= "pf1550-regulator",
+	.status_base		= PF1550_PMIC_REG_SW_INT_STAT0,
+	.mask_base		= PF1550_PMIC_REG_SW_INT_MASK0,
+	.num_regs		= 23,
+	.irqs			= pf1550_regulator_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_regulator_irqs),
+};
+
+static const struct regmap_irq pf1550_onkey_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_PUSHI,  0, ONKEY_IRQ_PUSHI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_1SI,    0, ONKEY_IRQ_1SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_2SI,    0, ONKEY_IRQ_2SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_3SI,    0, ONKEY_IRQ_3SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_4SI,    0, ONKEY_IRQ_4SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_8SI,    0, ONKEY_IRQ_8SI),
+};
+
+static const struct regmap_irq_chip pf1550_onkey_irq_chip = {
+	.name			= "pf1550-onkey",
+	.status_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
+	.ack_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
+	.mask_base		= PF1550_PMIC_REG_ONKEY_INT_MASK0,
+	.use_ack                = 1,
+	.init_ack_masked	= 1,
+	.num_regs		= 1,
+	.irqs			= pf1550_onkey_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_onkey_irqs),
+};
+
+static const struct regmap_irq pf1550_charger_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BAT2SOCI,	0, CHARG_IRQ_BAT2SOCI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BATI,           0, CHARG_IRQ_BATI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_CHGI,           0, CHARG_IRQ_CHGI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_VBUSI,          0, CHARG_IRQ_VBUSI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_THMI,           0, CHARG_IRQ_THMI),
+};
+
+static const struct regmap_irq_chip pf1550_charger_irq_chip = {
+	.name			= "pf1550-charger",
+	.status_base		= PF1550_CHARG_REG_CHG_INT,
+	.mask_base		= PF1550_CHARG_REG_CHG_INT_MASK,
+	.num_regs		= 1,
+	.irqs			= pf1550_charger_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_charger_irqs),
+};
+
+int pf1550_read_otp(struct pf1550_dev *pf1550, unsigned int index,
+		    unsigned int *val)
+{
+	int ret = 0;
+
+	ret = regmap_write(pf1550->regmap, PF1550_PMIC_REG_KEY, 0x15);
+	if (ret)
+		goto read_err;
+	ret = regmap_write(pf1550->regmap, PF1550_CHARG_REG_CHGR_KEY2, 0x50);
+	if (ret)
+		goto read_err;
+	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_KEY3, 0xAB);
+	if (ret)
+		goto read_err;
+	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_FMRADDR, index);
+	if (ret)
+		goto read_err;
+	ret = regmap_read(pf1550->regmap, PF1550_TEST_REG_FMRDATA, val);
+	if (ret)
+		goto read_err;
+
+	return 0;
+
+read_err:
+	dev_err(pf1550->dev, "read otp reg %x found!\n", index);
+	return ret;
+}
+
+static int pf1550_map_chip_irqs(const struct regmap_irq_chip *chip,
+				struct regmap_irq_chip_data *data)
+{
+	const int num_irqs = chip->num_irqs;
+	int i;
+
+	for (i = 0; i < num_irqs; i++)
+		if (regmap_irq_get_virq(data, i) < 0)
+			return -EINVAL;
+
+	return 0;
+}
+
+static int pf1550_i2c_probe(struct i2c_client *i2c)
+{
+	struct pf1550_dev *pf1550;
+	unsigned int reg_data = 0;
+	int ret = 0;
+
+	pf1550 = devm_kzalloc(&i2c->dev, sizeof(*pf1550), GFP_KERNEL);
+	if (!pf1550)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, pf1550);
+	pf1550->dev = &i2c->dev;
+	pf1550->i2c = i2c;
+	pf1550->irq = i2c->irq;
+
+	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
+	if (IS_ERR(pf1550->regmap))
+		return dev_err_probe(pf1550->dev, PTR_ERR(pf1550->regmap),
+				     "failed to allocate register map\n");
+
+	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
+	if (ret < 0 || reg_data != PF1550_DEVICE_ID)
+		return dev_err_probe(pf1550->dev, ret, "device not found!\n");
+
+	pf1550->type = PF1550;
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
+				       pf1550->irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &pf1550_regulator_irq_chip,
+				       &pf1550->irq_data_regulator);
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret,
+				     "failed to add regulator irq chip\n");
+
+	ret = pf1550_map_chip_irqs(&pf1550_regulator_irq_chip,
+				   pf1550->irq_data_regulator);
+
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret,
+				     "Failed to get parent vIRQ for chip %s\n",
+				     pf1550_regulator_irq_chip.name);
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
+				       pf1550->irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &pf1550_onkey_irq_chip,
+				       &pf1550->irq_data_onkey);
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret,
+				     "failed to add onkey irq chip\n");
+
+	ret = pf1550_map_chip_irqs(&pf1550_onkey_irq_chip,
+				   pf1550->irq_data_onkey);
+
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret,
+				     "Failed to get parent vIRQ for chip %s\n",
+				     pf1550_onkey_irq_chip.name);
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
+				       pf1550->irq,
+				       IRQF_ONESHOT | IRQF_SHARED |
+				       IRQF_TRIGGER_FALLING, 0,
+				       &pf1550_charger_irq_chip,
+				       &pf1550->irq_data_charger);
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret,
+				     "failed to add charger irq chip\n");
+
+	ret = pf1550_map_chip_irqs(&pf1550_charger_irq_chip,
+				   pf1550->irq_data_charger);
+
+	if (ret)
+		return dev_err_probe(pf1550->dev, ret,
+				     "Failed to get parent vIRQ for chip %s\n",
+				     pf1550_charger_irq_chip.name);
+
+	return devm_mfd_add_devices(pf1550->dev, -1, pf1550_devs,
+				    ARRAY_SIZE(pf1550_devs), NULL, 0, NULL);
+}
+
+static int pf1550_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(pf1550->irq);
+		disable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+
+static int pf1550_resume(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(pf1550->irq);
+		enable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_pm, pf1550_suspend, pf1550_resume);
+
+static const struct i2c_device_id pf1550_i2c_id[] = {
+	{ "pf1550", PF1550 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
+
+static const struct of_device_id pf1550_dt_match[] = {
+	{ .compatible = "fsl,pf1550" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pf1550_dt_match);
+
+static struct i2c_driver pf1550_i2c_driver = {
+	.driver = {
+		   .name = "pf1550",
+		   .pm = pm_sleep_ptr(&pf1550_pm),
+		   .of_match_table = pf1550_dt_match,
+	},
+	.probe = pf1550_i2c_probe,
+	.id_table = pf1550_i2c_id,
+};
+module_i2c_driver(pf1550_i2c_driver);
+
+MODULE_DESCRIPTION("Freescale PF1550 multi-function core driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
new file mode 100644
index 0000000000000000000000000000000000000000..915a6dcac52e4c545b56f5ecff8c53176a024f68
--- /dev/null
+++ b/include/linux/mfd/pf1550.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pf1550.h - mfd head file for PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ */
+
+#ifndef __LINUX_MFD_PF1550_H
+#define __LINUX_MFD_PF1550_H
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+enum chips { PF1550 = 1, };
+
+enum pf1550_pmic_reg {
+	/* PMIC regulator part */
+	PF1550_PMIC_REG_DEVICE_ID		= 0x00,
+	PF1550_PMIC_REG_OTP_FLAVOR		= 0x01,
+	PF1550_PMIC_REG_SILICON_REV		= 0x02,
+
+	PF1550_PMIC_REG_INT_CATEGORY		= 0x06,
+	PF1550_PMIC_REG_SW_INT_STAT0		= 0x08,
+	PF1550_PMIC_REG_SW_INT_MASK0		= 0x09,
+	PF1550_PMIC_REG_SW_INT_SENSE0		= 0x0A,
+	PF1550_PMIC_REG_SW_INT_STAT1		= 0x0B,
+	PF1550_PMIC_REG_SW_INT_MASK1		= 0x0C,
+	PF1550_PMIC_REG_SW_INT_SENSE1		= 0x0D,
+	PF1550_PMIC_REG_SW_INT_STAT2		= 0x0E,
+	PF1550_PMIC_REG_SW_INT_MASK2		= 0x0F,
+	PF1550_PMIC_REG_SW_INT_SENSE2		= 0x10,
+	PF1550_PMIC_REG_LDO_INT_STAT0		= 0x18,
+	PF1550_PMIC_REG_LDO_INT_MASK0		= 0x19,
+	PF1550_PMIC_REG_LDO_INT_SENSE0		= 0x1A,
+	PF1550_PMIC_REG_TEMP_INT_STAT0		= 0x20,
+	PF1550_PMIC_REG_TEMP_INT_MASK0		= 0x21,
+	PF1550_PMIC_REG_TEMP_INT_SENSE0		= 0x22,
+	PF1550_PMIC_REG_ONKEY_INT_STAT0		= 0x24,
+	PF1550_PMIC_REG_ONKEY_INT_MASK0		= 0x25,
+	PF1550_PMIC_REG_ONKEY_INT_SENSE0	= 0x26,
+	PF1550_PMIC_REG_MISC_INT_STAT0		= 0x28,
+	PF1550_PMIC_REG_MISC_INT_MASK0		= 0x29,
+	PF1550_PMIC_REG_MISC_INT_SENSE0		= 0x2A,
+
+	PF1550_PMIC_REG_COINCELL_CONTROL	= 0x30,
+
+	PF1550_PMIC_REG_SW1_VOLT		= 0x32,
+	PF1550_PMIC_REG_SW1_STBY_VOLT		= 0x33,
+	PF1550_PMIC_REG_SW1_SLP_VOLT		= 0x34,
+	PF1550_PMIC_REG_SW1_CTRL		= 0x35,
+	PF1550_PMIC_REG_SW1_CTRL1		= 0x36,
+	PF1550_PMIC_REG_SW2_VOLT		= 0x38,
+	PF1550_PMIC_REG_SW2_STBY_VOLT		= 0x39,
+	PF1550_PMIC_REG_SW2_SLP_VOLT		= 0x3A,
+	PF1550_PMIC_REG_SW2_CTRL		= 0x3B,
+	PF1550_PMIC_REG_SW2_CTRL1		= 0x3C,
+	PF1550_PMIC_REG_SW3_VOLT		= 0x3E,
+	PF1550_PMIC_REG_SW3_STBY_VOLT		= 0x3F,
+	PF1550_PMIC_REG_SW3_SLP_VOLT		= 0x40,
+	PF1550_PMIC_REG_SW3_CTRL		= 0x41,
+	PF1550_PMIC_REG_SW3_CTRL1		= 0x42,
+	PF1550_PMIC_REG_VSNVS_CTRL		= 0x48,
+	PF1550_PMIC_REG_VREFDDR_CTRL		= 0x4A,
+	PF1550_PMIC_REG_LDO1_VOLT		= 0x4C,
+	PF1550_PMIC_REG_LDO1_CTRL		= 0x4D,
+	PF1550_PMIC_REG_LDO2_VOLT		= 0x4F,
+	PF1550_PMIC_REG_LDO2_CTRL		= 0x50,
+	PF1550_PMIC_REG_LDO3_VOLT		= 0x52,
+	PF1550_PMIC_REG_LDO3_CTRL		= 0x53,
+	PF1550_PMIC_REG_PWRCTRL0		= 0x58,
+	PF1550_PMIC_REG_PWRCTRL1		= 0x59,
+	PF1550_PMIC_REG_PWRCTRL2		= 0x5A,
+	PF1550_PMIC_REG_PWRCTRL3		= 0x5B,
+	PF1550_PMIC_REG_SW1_PWRDN_SEQ		= 0x5F,
+	PF1550_PMIC_REG_SW2_PWRDN_SEQ		= 0x60,
+	PF1550_PMIC_REG_SW3_PWRDN_SEQ		= 0x61,
+	PF1550_PMIC_REG_LDO1_PWRDN_SEQ		= 0x62,
+	PF1550_PMIC_REG_LDO2_PWRDN_SEQ		= 0x63,
+	PF1550_PMIC_REG_LDO3_PWRDN_SEQ		= 0x64,
+	PF1550_PMIC_REG_VREFDDR_PWRDN_SEQ	= 0x65,
+
+	PF1550_PMIC_REG_STATE_INFO		= 0x67,
+	PF1550_PMIC_REG_I2C_ADDR		= 0x68,
+	PF1550_PMIC_REG_IO_DRV0			= 0x69,
+	PF1550_PMIC_REG_IO_DRV1			= 0x6A,
+	PF1550_PMIC_REG_RC_16MHZ		= 0x6B,
+	PF1550_PMIC_REG_KEY			= 0x6F,
+
+	/* charger part */
+	PF1550_CHARG_REG_CHG_INT		= 0x80,
+	PF1550_CHARG_REG_CHG_INT_MASK		= 0x82,
+	PF1550_CHARG_REG_CHG_INT_OK		= 0x84,
+	PF1550_CHARG_REG_VBUS_SNS		= 0x86,
+	PF1550_CHARG_REG_CHG_SNS		= 0x87,
+	PF1550_CHARG_REG_BATT_SNS		= 0x88,
+	PF1550_CHARG_REG_CHG_OPER		= 0x89,
+	PF1550_CHARG_REG_CHG_TMR		= 0x8A,
+	PF1550_CHARG_REG_CHG_EOC_CNFG		= 0x8D,
+	PF1550_CHARG_REG_CHG_CURR_CNFG		= 0x8E,
+	PF1550_CHARG_REG_BATT_REG		= 0x8F,
+	PF1550_CHARG_REG_BATFET_CNFG		= 0x91,
+	PF1550_CHARG_REG_THM_REG_CNFG		= 0x92,
+	PF1550_CHARG_REG_VBUS_INLIM_CNFG	= 0x94,
+	PF1550_CHARG_REG_VBUS_LIN_DPM		= 0x95,
+	PF1550_CHARG_REG_USB_PHY_LDO_CNFG	= 0x96,
+	PF1550_CHARG_REG_DBNC_DELAY_TIME	= 0x98,
+	PF1550_CHARG_REG_CHG_INT_CNFG		= 0x99,
+	PF1550_CHARG_REG_THM_ADJ_SETTING	= 0x9A,
+	PF1550_CHARG_REG_VBUS2SYS_CNFG		= 0x9B,
+	PF1550_CHARG_REG_LED_PWM		= 0x9C,
+	PF1550_CHARG_REG_FAULT_BATFET_CNFG	= 0x9D,
+	PF1550_CHARG_REG_LED_CNFG		= 0x9E,
+	PF1550_CHARG_REG_CHGR_KEY2		= 0x9F,
+
+	PF1550_TEST_REG_FMRADDR			= 0xC4,
+	PF1550_TEST_REG_FMRDATA			= 0xC5,
+	PF1550_TEST_REG_KEY3			= 0xDF,
+
+	PF1550_PMIC_REG_END			= 0xff,
+};
+
+#define PF1550_DEVICE_ID		0x7c
+
+#define PF1550_CHG_TURNON		0x2
+
+#define PF1550_CHG_PRECHARGE		0
+#define PF1550_CHG_CONSTANT_CURRENT	1
+#define PF1550_CHG_CONSTANT_VOL		2
+#define PF1550_CHG_EOC			3
+#define PF1550_CHG_DONE			4
+#define PF1550_CHG_TIMER_FAULT		6
+#define PF1550_CHG_SUSPEND		7
+#define PF1550_CHG_OFF_INV		8
+#define PF1550_CHG_BAT_OVER		9
+#define PF1550_CHG_OFF_TEMP		10
+#define PF1550_CHG_LINEAR_ONLY		12
+#define PF1550_CHG_SNS_MASK		0xf
+#define PF1550_CHG_INT_MASK             0x51
+
+#define PF1550_BAT_NO_VBUS		0
+#define PF1550_BAT_LOW_THAN_PRECHARG	1
+#define PF1550_BAT_CHARG_FAIL		2
+#define PF1550_BAT_HIGH_THAN_PRECHARG	4
+#define PF1550_BAT_OVER_VOL		5
+#define	PF1550_BAT_NO_DETECT		6
+#define PF1550_BAT_SNS_MASK		0x7
+
+#define PF1550_VBUS_UVLO		BIT(2)
+#define PF1550_VBUS_IN2SYS		BIT(3)
+#define PF1550_VBUS_OVLO		BIT(4)
+#define PF1550_VBUS_VALID		BIT(5)
+
+#define PF1550_CHARG_REG_BATT_REG_CHGCV_MASK		0x3f
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT		6
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK		(0x3 << 6)
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT	2
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK	(0x3 << 2)
+
+#define PMIC_IRQ_SW1_LS		BIT(0)
+#define PMIC_IRQ_SW2_LS		BIT(1)
+#define PMIC_IRQ_SW3_LS		BIT(2)
+#define PMIC_IRQ_SW1_HS		BIT(0)
+#define PMIC_IRQ_SW2_HS		BIT(1)
+#define PMIC_IRQ_SW3_HS		BIT(2)
+#define PMIC_IRQ_LDO1_FAULT	BIT(0)
+#define PMIC_IRQ_LDO2_FAULT	BIT(1)
+#define PMIC_IRQ_LDO3_FAULT	BIT(2)
+#define PMIC_IRQ_TEMP_110	BIT(0)
+#define PMIC_IRQ_TEMP_125	BIT(1)
+
+#define ONKEY_IRQ_PUSHI		BIT(0)
+#define ONKEY_IRQ_1SI		BIT(1)
+#define ONKEY_IRQ_2SI		BIT(2)
+#define ONKEY_IRQ_3SI		BIT(3)
+#define ONKEY_IRQ_4SI		BIT(4)
+#define ONKEY_IRQ_8SI		BIT(5)
+
+#define CHARG_IRQ_BAT2SOCI	BIT(1)
+#define CHARG_IRQ_BATI		BIT(2)
+#define CHARG_IRQ_CHGI		BIT(3)
+#define CHARG_IRQ_VBUSI		BIT(5)
+#define CHARG_IRQ_DPMI		BIT(6)
+#define CHARG_IRQ_THMI		BIT(7)
+
+enum pf1550_pmic_irq {
+	PF1550_PMIC_IRQ_SW1_LS,
+	PF1550_PMIC_IRQ_SW2_LS,
+	PF1550_PMIC_IRQ_SW3_LS,
+	PF1550_PMIC_IRQ_SW1_HS,
+	PF1550_PMIC_IRQ_SW2_HS,
+	PF1550_PMIC_IRQ_SW3_HS,
+	PF1550_PMIC_IRQ_LDO1_FAULT,
+	PF1550_PMIC_IRQ_LDO2_FAULT,
+	PF1550_PMIC_IRQ_LDO3_FAULT,
+	PF1550_PMIC_IRQ_TEMP_110,
+	PF1550_PMIC_IRQ_TEMP_125,
+};
+
+enum pf1550_onkey_irq {
+	PF1550_ONKEY_IRQ_PUSHI,
+	PF1550_ONKEY_IRQ_1SI,
+	PF1550_ONKEY_IRQ_2SI,
+	PF1550_ONKEY_IRQ_3SI,
+	PF1550_ONKEY_IRQ_4SI,
+	PF1550_ONKEY_IRQ_8SI,
+};
+
+enum pf1550_charg_irq {
+	PF1550_CHARG_IRQ_BAT2SOCI,
+	PF1550_CHARG_IRQ_BATI,
+	PF1550_CHARG_IRQ_CHGI,
+	PF1550_CHARG_IRQ_VBUSI,
+	PF1550_CHARG_IRQ_THMI,
+};
+
+enum pf1550_regulators {
+	PF1550_SW1,
+	PF1550_SW2,
+	PF1550_SW3,
+	PF1550_VREFDDR,
+	PF1550_LDO1,
+	PF1550_LDO2,
+	PF1550_LDO3,
+};
+
+struct pf1550_dev {
+	struct device *dev;
+	struct i2c_client *i2c;
+	int type;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data_regulator;
+	struct regmap_irq_chip_data *irq_data_onkey;
+	struct regmap_irq_chip_data *irq_data_charger;
+	int irq;
+};
+
+int pf1550_read_otp(struct pf1550_dev *pf1550, unsigned int index,
+		    unsigned int *val);
+
+#endif /* __LINUX_MFD_PF1550_H */

-- 
2.49.0



