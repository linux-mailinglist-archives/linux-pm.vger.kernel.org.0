Return-Path: <linux-pm+bounces-28047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1938ACCCF3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A4D1893E1F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43EB28935D;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPbcvwzr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB0288C86;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975278; cv=none; b=dL4rAgpRvoEe+TcnCSs7bdN1Px7mhaxqi5L8dlsqilqHCG2jGHxTRWfwQtPn1RqdXRFnHBL5XrdazQPnoyXON/o+bhK0vNAuzoGqSRusMAigjBTcIhrrOTy4KdxqMH2Lcv/XdwqbjdZmCyUswkV6LFIbgJigGtjVppsHjsr1UsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975278; c=relaxed/simple;
	bh=lvfJmhHzqfRhiVokgh8fkyPZVe+2w470C/Ow49zz0Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3qJGpjZJbYoXWfl4vrwWp4kSMnevVoentyDuET8dDk0NULiT/heM12rIqu2vXceR/QCAbRZ9Z8eIPhLQDwVYHwE+io+181F+iNdUgKX5V2+w1TA4X3QvXJK3nUXnDEg7nzEj7NmWdi3c3NTm2dTC/nsSe2wljsgSICsue+dEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPbcvwzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19B1FC4CEEE;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975278;
	bh=lvfJmhHzqfRhiVokgh8fkyPZVe+2w470C/Ow49zz0Dw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gPbcvwzrHtDDeE1PiMXynxBs+KHnfjxjw7IYE8kj7ouVtItSB9kPUvmgP8aSmcZQh
	 CeUSRwMmLN/KATMFqapCCuySaAPc3G36bC1vGQueuei3AuGr45AUKl6MDoGTuI8Qgr
	 dbmMtxpgpjilp69+wNJOJTKJ/u9xzjy31h9eZaKNv6j4csKs9LJ9Q5z0VJgY693i6D
	 QxJs+QZpq2H5tQ4iiwTT9CRpJMpGyCJ81U+MonaQZIPZYsRYqbUQ0zAiNMQSEP/uZ1
	 ZnTER+ft++x8o7COKJ3jcNaeqD0AiHDe6AO5CUXXKUDsK5cjc4Q9I5csNE7C1p2Ase
	 mhRb8srcM8prg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06285C5AD49;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 03 Jun 2025 14:27:46 -0400
Subject: [PATCH v4 2/6] mfd: pf1550: add core mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-pf1550-v4-2-bfdf51ee59cc@savoirfairelinux.com>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
In-Reply-To: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
 Robin Gong <b38343@freescale.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748975277; l=20758;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=HsuHsmK3Eflb7SLibimFftzFSzdVO8l8ifuJx5khmmU=;
 b=V36pvRJmuL+rFOpOvgmeUP1O2u/DdGJn3AEJ5GJ22kK9gr9l05uM/eG15RVroZt94X+9HYjLw
 PtQjbVbjGLvBhz+45BBqPjEh8sLbIudZHt86qCFsVz1E4K3iXtpTtRS
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
v4:
 - Use struct resource to define irq so platform_get_irq can be used in
   children as suggested by Dmitry
 - Let mfd_add_devices create the mappings for the interrupts
 - ack_base and init_ack_masked defined for charger and regulator irq
   chips
 - No need to define driver_data in table id
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
 drivers/mfd/pf1550.c       | 305 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/pf1550.h | 244 ++++++++++++++++++++++++++++++++++++
 4 files changed, 565 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 96992af22565205716d72db0494c7bf2567b045e..de3fc9c5e88b5c2a2c7325e2ceeb8f9c3ca057de 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -558,6 +558,20 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_PF1550
+	tristate "NXP PF1550 PMIC Support"
+	depends on I2C=y && OF
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for NXP PF1550.
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
index 5e5cc279af6036a6b3ea1f1f0feeddf45b85f15c..7391d1b81d1ee499507b4ac24ff00eb2e344d60b 100644
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
index 0000000000000000000000000000000000000000..ec9022ce8d45b0d0d041101264d9cdb05b79cb57
--- /dev/null
+++ b/drivers/mfd/pf1550.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// pf1550.c - mfd core driver for the PF1550
+//
+// Copyright (C) 2016 Freescale Semiconductor, Inc.
+// Robin Gong <yibin.gong@freescale.com>
+//
+// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+//
+// This driver is based on max77693.c
+//
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
+	.ack_base		= PF1550_PMIC_REG_SW_INT_STAT0,
+	.mask_base		= PF1550_PMIC_REG_SW_INT_MASK0,
+	.use_ack                = 1,
+	.init_ack_masked	= 1,
+	.num_regs		= 23,
+	.irqs			= pf1550_regulator_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_regulator_irqs),
+};
+
+static const struct resource regulator_resources[] = {
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_LS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_LS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_LS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW1_HS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW2_HS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_SW3_HS),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO1_FAULT),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO2_FAULT),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_LDO3_FAULT),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_110),
+	DEFINE_RES_IRQ(PF1550_PMIC_IRQ_TEMP_125),
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
+static const struct resource onkey_resources[] = {
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_PUSHI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_1SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_2SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_3SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_4SI),
+	DEFINE_RES_IRQ(PF1550_ONKEY_IRQ_8SI),
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
+	.ack_base		= PF1550_CHARG_REG_CHG_INT,
+	.mask_base		= PF1550_CHARG_REG_CHG_INT_MASK,
+	.use_ack                = 1,
+	.init_ack_masked	= 1,
+	.num_regs		= 1,
+	.irqs			= pf1550_charger_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_charger_irqs),
+};
+
+static const struct resource charger_resources[] = {
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BAT2SOCI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_BATI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_CHGI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_VBUSI),
+	DEFINE_RES_IRQ(PF1550_CHARG_IRQ_THMI),
+};
+
+static const struct mfd_cell pf1550_regulator_cell = {
+	.name = "pf1550-regulator",
+	.num_resources = ARRAY_SIZE(regulator_resources),
+	.resources = regulator_resources,
+};
+
+static const struct mfd_cell pf1550_onkey_cell = {
+	.name = "pf1550-onkey",
+	.num_resources = ARRAY_SIZE(onkey_resources),
+	.resources = onkey_resources,
+};
+
+static const struct mfd_cell pf1550_charger_cell = {
+	.name = "pf1550-charger",
+	.num_resources = ARRAY_SIZE(charger_resources),
+	.resources = charger_resources,
+};
+
+int pf1550_read_otp(const struct pf1550_dev *pf1550, unsigned int index,
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
+EXPORT_SYMBOL_GPL(pf1550_read_otp);
+
+static int pf1550_add_child_device(struct pf1550_dev *pmic,
+				   const struct mfd_cell *cell,
+				   struct regmap_irq_chip_data *pdata,
+				   int pirq, int irq_flags,
+				   const struct regmap_irq_chip *chip,
+				   struct regmap_irq_chip_data **data)
+{
+	struct device *dev = pmic->dev;
+	struct irq_domain *domain;
+	int ret;
+
+	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, pirq, irq_flags,
+				       0, chip, data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add %s IRQ chip\n", chip->name);
+
+	domain = regmap_irq_get_domain(*data);
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cell, 1,
+				    NULL, 0, domain);
+}
+
+static int pf1550_i2c_probe(struct i2c_client *i2c)
+{
+	struct pf1550_dev *pf1550;
+	const struct mfd_cell *regulator = &pf1550_regulator_cell;
+	const struct mfd_cell *onkey = &pf1550_onkey_cell;
+	const struct mfd_cell *charger = &pf1550_charger_cell;
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
+		return dev_err_probe(pf1550->dev, ret ?: -EINVAL,
+				     "device not found!\n");
+
+	pf1550->type = PF1550;
+
+	ret = pf1550_add_child_device(pf1550, regulator,
+				      pf1550->irq_data_regulator,
+				      pf1550->irq, IRQF_ONESHOT | IRQF_SHARED |
+				      IRQF_TRIGGER_FALLING,
+				      &pf1550_regulator_irq_chip,
+				      &pf1550->irq_data_regulator);
+	if (ret)
+		return ret;
+
+	ret = pf1550_add_child_device(pf1550, onkey, pf1550->irq_data_onkey,
+				      pf1550->irq, IRQF_ONESHOT | IRQF_SHARED |
+				      IRQF_TRIGGER_FALLING,
+				      &pf1550_onkey_irq_chip,
+				      &pf1550->irq_data_onkey);
+	if (ret)
+		return ret;
+
+	ret = pf1550_add_child_device(pf1550, charger, pf1550->irq_data_charger,
+				      pf1550->irq, IRQF_ONESHOT | IRQF_SHARED |
+				      IRQF_TRIGGER_FALLING,
+				      &pf1550_charger_irq_chip,
+				      &pf1550->irq_data_charger);
+	return ret;
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
+	{ "pf1550", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
+
+static const struct of_device_id pf1550_dt_match[] = {
+	{ .compatible = "nxp,pf1550" },
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
+MODULE_DESCRIPTION("NXP PF1550 multi-function core driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
new file mode 100644
index 0000000000000000000000000000000000000000..bdacaaf69aea8ef6d627629581c3350084c65f86
--- /dev/null
+++ b/include/linux/mfd/pf1550.h
@@ -0,0 +1,244 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pf1550.h - mfd head file for PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+ * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
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
+int pf1550_read_otp(const struct pf1550_dev *pf1550, unsigned int index,
+		    unsigned int *val);
+
+#endif /* __LINUX_MFD_PF1550_H */

-- 
2.49.0



