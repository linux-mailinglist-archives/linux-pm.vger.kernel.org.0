Return-Path: <linux-pm+bounces-27703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83B5AC5D0C
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BB34A81C9
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459C218AB9;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETzCgO5B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D321770B;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384785; cv=none; b=Y8vC0HnJeFAAyevhDQUjwRkF9ECWzRT8WHjzWKu+86P0eTRdBoYLf6J2YgyklTUBn6bEyiTcUmHLw8pLJgM+DKd4RbhFbmnOT4K8/w9dFmmdrGwW/w87oyVKb9L5omLNiXmFNBOqzzZMLNIu4AebWnCcOK1ZqrHVEzZ2bURCdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384785; c=relaxed/simple;
	bh=1cYL0CAe/rc9iAEFS8/Gd2jkZuQ9N4GWD4ywhF775cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPYEw93ctpw3ppenw+m9M0JCm9T822LYggL0NcbW2PAO78krdj5ybHbhxzvXXGXEPgA/5Fq3mKX8YSjrOLNXji1ou3X4+PpYxzrhX4UcSb/SZyuGU5b5X/ZzehpbEnhWDYmV0vCf3tIic/rr23bf3s3WGyLK3GJXyfnO2orFxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETzCgO5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDDD6C4CEF2;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384785;
	bh=1cYL0CAe/rc9iAEFS8/Gd2jkZuQ9N4GWD4ywhF775cY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ETzCgO5Bc284VnXfh7VxXocndccqhEgXNRhv1MGOFJ/FVnca6hzH0qUoYf+P11h75
	 AioPAUwFsnuoVZqUs+xtKt1nTTPfefWQ9rYx6YlgBO0bGDPJZFRdcV2elwS8FPY1UK
	 JdcFJUSuac4c9sMco3ySHhL5Sub+MneguqI3qs1y5UqgSqur1c20aEAsHJpIKQfQ0E
	 6VtbgdsaE+1/+ZZdGqzLJkKCfwomA3oSBtLRWAoQfrpHq4wJXdX+FaWNOp5DlOG9Ze
	 dvsfmkJ7BmWWvngnv72AhWwDLT4DCPyurHNrCeF81YWb6iZRgwi8OOuLW19PXyhMYd
	 QO4pDXnG/6Hug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE87BC5B549;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 27 May 2025 18:25:35 -0400
Subject: [PATCH v3 3/6] regulator: pf1550: add support for regulator
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pf1550-v3-3-45f69453cd51@savoirfairelinux.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748384783; l=13458;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=u7ayKFgCUGGEVmXNoXzopos0ex4Uju0ZK84SSc9xqWk=;
 b=gsfgPJZ9FVdF+qpEnqaNGpFgHyxErg51lJNnS7Vyr6JkOnBSkiu1AjXLJGaFsFU6/SlFVfTDf
 dfX2ZRLJVjTCOd51us9/b4Lw04MeVwdeEU4SxFFN38R9r3vFaGW/ghE
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add regulator support for the pf1550 PMIC.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v3:
- Drop duplicate include
- Drop unnecessary includes
- Accept lower case regulator names from devicetree
- Use virqs mapped in core MFD driver
v2:
- Add driver for regulator
---
 drivers/regulator/Kconfig            |   9 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf1550-regulator.c | 353 +++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 05e32d764028307dcbea3cf28c9834f26d70c34b..f888454228b891a635dab8686dcd09a574a17eaa 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1038,6 +1038,15 @@ config REGULATOR_PV88090
 	  Say y here to support the voltage regulators and convertors
 	  on PV88090
 
+config REGULATOR_PF1550
+	tristate "Freescale PF1550 regulator"
+	depends on MFD_PF1550
+	help
+	  Say y here to select this option to enable the regulators on
+	  the PF1550 PMICs.
+	  This driver controls the PF1550 regulators via I2C bus.
+	  The regulators include three bucks and three ldos.
+
 config REGULATOR_PWM
 	tristate "PWM voltage regulator"
 	depends on PWM
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 524e026c02734047021182bec562f903baa44bbc..bbf83fd2c9824858fc6c632c9e7d9ef901363276 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
 obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
+obj-$(CONFIG_REGULATOR_PF1550) += pf1550-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf1550-regulator.c b/drivers/regulator/pf1550-regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..7f2b0a14c1f252fab81a5c50d0b0d769b4dc1ccb
--- /dev/null
+++ b/drivers/regulator/pf1550-regulator.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pf1550.c - regulator driver for the PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * This driver is based on pfuze100-regulator.c
+ */
+
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#define PF1550_REGULATOR_IRQ_NR		11
+#define PF1550_MAX_REGULATOR		7
+
+struct pf1550_desc {
+	struct regulator_desc desc;
+	unsigned char stby_reg;
+	unsigned char stby_mask;
+};
+
+struct pf1550_regulator_info {
+	struct device *dev;
+	struct pf1550_dev *pf1550;
+	struct pf1550_desc regulator_descs[PF1550_MAX_REGULATOR];
+	int irq;
+};
+
+static const int pf1550_sw12_volts[] = {
+	1100000, 1200000, 1350000, 1500000, 1800000, 2500000, 3000000, 3300000,
+};
+
+static const int pf1550_ldo13_volts[] = {
+	750000, 800000, 850000, 900000, 950000, 1000000, 1050000, 1100000,
+	1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000,
+	1800000, 1900000, 2000000, 2100000, 2200000, 2300000, 2400000, 2500000,
+	2600000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
+};
+
+static int pf1550_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
+{
+	int id = rdev_get_id(rdev);
+	unsigned int ramp_bits;
+	int ret;
+
+	if (id > PF1550_VREFDDR)
+		return -EACCES;
+
+	ramp_delay = 6250 / ramp_delay;
+	ramp_bits = ramp_delay >> 1;
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg + 4, 0x10,
+				 ramp_bits << 4);
+	if (ret < 0)
+		dev_err(&rdev->dev, "ramp failed, err %d\n", ret);
+
+	return ret;
+}
+
+static const struct regulator_ops pf1550_sw1_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = pf1550_set_ramp_delay,
+};
+
+static const struct regulator_ops pf1550_sw2_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay = pf1550_set_ramp_delay,
+};
+
+static const struct regulator_ops pf1550_ldo1_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_ops pf1550_ldo2_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_ops pf1550_fixed_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+};
+
+#define PF_VREF(_chip, match, _name, voltage)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("regulators"),	\
+		.n_voltages = 1,	\
+		.ops = &pf1550_fixed_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = _chip ## _ ## _name,	\
+		.owner = THIS_MODULE,	\
+		.min_uV = (voltage),	\
+		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+		.enable_mask = 0x1,	\
+	},	\
+	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+	.stby_mask = 0x2,	\
+}
+
+#define PF_SW1(_chip, match, _name, mask, voltages)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("regulators"),	\
+		.n_voltages = ARRAY_SIZE(voltages),	\
+		.ops = &pf1550_sw1_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = _chip ## _ ## _name,	\
+		.owner = THIS_MODULE,	\
+		.volt_table = voltages,	\
+		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
+		.vsel_mask = (mask),	\
+	},	\
+	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
+	.stby_mask = (mask),	\
+}
+
+#define PF_SW3(_chip, match, _name, min, max, mask, step)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("regulators"),	\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.ops = &pf1550_sw2_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = _chip ## _ ## _name,	\
+		.owner = THIS_MODULE,	\
+		.min_uV = (min),	\
+		.uV_step = (step),	\
+		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
+		.vsel_mask = (mask),	\
+	},	\
+	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
+	.stby_mask = (mask),	\
+}
+
+#define PF_LDO1(_chip, match, _name, mask, voltages)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("regulators"),	\
+		.n_voltages = ARRAY_SIZE(voltages),	\
+		.ops = &pf1550_ldo1_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = _chip ## _ ## _name,	\
+		.owner = THIS_MODULE,	\
+		.volt_table = voltages, \
+		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
+		.vsel_mask = (mask),	\
+		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+		.enable_mask = 0x1,	\
+	},	\
+	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+	.stby_mask = 0x2,	\
+}
+
+#define PF_LDO2(_chip, match, _name, mask, min, max, step)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(match),	\
+		.regulators_node = of_match_ptr("regulators"),	\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.ops = &pf1550_ldo2_ops,	\
+		.type = REGULATOR_VOLTAGE,	\
+		.id = _chip ## _ ## _name,	\
+		.owner = THIS_MODULE,	\
+		.min_uV = (min),	\
+		.uV_step = (step),	\
+		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
+		.vsel_mask = (mask),	\
+		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+		.enable_mask = 0x1,	\
+	},	\
+	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+	.stby_mask = 0x2,	\
+}
+
+static struct pf1550_desc pf1550_regulators[] = {
+	PF_SW3(PF1550, "sw1", SW1, 600000, 1387500, 0x3f, 12500),
+	PF_SW3(PF1550, "sw2", SW2, 600000, 1387500, 0x3f, 12500),
+	PF_SW3(PF1550, "sw3", SW3, 1800000, 3300000, 0xf, 100000),
+	PF_VREF(PF1550, "vrefddr", VREFDDR, 1200000),
+	PF_LDO1(PF1550, "ldo1", LDO1, 0x1f, pf1550_ldo13_volts),
+	PF_LDO2(PF1550, "ldo2", LDO2, 0xf, 1800000, 3300000, 100000),
+	PF_LDO1(PF1550, "ldo3", LDO3, 0x1f, pf1550_ldo13_volts),
+};
+
+static irqreturn_t pf1550_regulator_irq_handler(int irq, void *data)
+{
+	struct pf1550_regulator_info *info = data;
+	struct device *dev = info->dev;
+	struct irq_domain *domain;
+	int i, irq_type = -1;
+	unsigned int virq;
+
+	domain = regmap_irq_get_domain(info->pf1550->irq_data_regulator);
+	info->irq = irq;
+
+	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++) {
+		virq = irq_find_mapping(domain, i);
+		if (info->irq == virq)
+			irq_type = i;
+	}
+
+	switch (irq_type) {
+	case PF1550_PMIC_IRQ_SW1_LS:
+	case PF1550_PMIC_IRQ_SW2_LS:
+	case PF1550_PMIC_IRQ_SW3_LS:
+		dev_info(dev, "lowside interrupt triggered! irq_type=%d\n",
+			 irq_type);
+		break;
+	case PF1550_PMIC_IRQ_SW1_HS:
+	case PF1550_PMIC_IRQ_SW2_HS:
+	case PF1550_PMIC_IRQ_SW3_HS:
+		dev_info(dev, "highside interrupt triggered! irq_type=%d\n",
+			 irq_type);
+		break;
+	case PF1550_PMIC_IRQ_LDO1_FAULT:
+	case PF1550_PMIC_IRQ_LDO2_FAULT:
+	case PF1550_PMIC_IRQ_LDO3_FAULT:
+		dev_info(dev, "ldo fault triggered! irq_type=%d\n", irq_type);
+		break;
+	case PF1550_PMIC_IRQ_TEMP_110:
+	case PF1550_PMIC_IRQ_TEMP_125:
+		dev_info(dev, "thermal exception triggered! irq_type=%d\n",
+			 irq_type);
+		break;
+	default:
+		dev_err(dev, "regulator interrupt: irq %d occurred\n",
+			irq_type);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pf1550_regulator_probe(struct platform_device *pdev)
+{
+	struct pf1550_dev *iodev = dev_get_drvdata(pdev->dev.parent);
+	struct pf1550_regulator_info *info;
+	struct irq_domain *domain;
+	int i, ret = 0;
+	struct regulator_config config = { };
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	config.regmap = dev_get_regmap(iodev->dev, NULL);
+	if (!config.regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to get parent regmap\n");
+
+	config.dev = iodev->dev;
+	config.regmap = iodev->regmap;
+	info->dev = &pdev->dev;
+	info->pf1550 = iodev;
+
+	memcpy(info->regulator_descs, pf1550_regulators,
+	       sizeof(info->regulator_descs));
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
+		struct regulator_dev *rdev;
+		struct regulator_desc *desc;
+		unsigned int val;
+
+		desc = &info->regulator_descs[i].desc;
+
+		if (desc->id == PF1550_SW2) {
+			pf1550_read_otp(info->pf1550, 0x1f, &val);
+			/* OTP_SW2_DVS_ENB == 1? */
+			if ((val & 0x8)) {
+				desc->volt_table = pf1550_sw12_volts;
+				desc->n_voltages = ARRAY_SIZE(pf1550_sw12_volts);
+				desc->ops = &pf1550_sw1_ops;
+			}
+		}
+
+		rdev = devm_regulator_register(&pdev->dev, desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(&pdev->dev, PTR_ERR(rdev),
+					     "failed to initialize regulator-%d\n",
+					     i);
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	domain = regmap_irq_get_domain(iodev->irq_data_regulator);
+
+	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++) {
+		unsigned int virq = irq_find_mapping(domain, i);
+
+		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
+						pf1550_regulator_irq_handler,
+						IRQF_NO_SUSPEND,
+						"pf1550-regulator", info);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed: irq request (IRQ: %d)\n",
+					     i);
+	}
+
+	/* unmask all exception interrupts for regulators */
+	regmap_write(info->pf1550->regmap, PF1550_PMIC_REG_SW_INT_MASK0, 0);
+	regmap_write(info->pf1550->regmap, PF1550_PMIC_REG_SW_INT_MASK1, 0);
+	regmap_write(info->pf1550->regmap, PF1550_PMIC_REG_LDO_INT_MASK0, 0);
+	regmap_write(info->pf1550->regmap, PF1550_PMIC_REG_TEMP_INT_MASK0, 0);
+
+	return 0;
+}
+
+static const struct platform_device_id pf1550_regulator_id[] = {
+	{ "pf1550-regulator", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, pf1550_regulator_id);
+
+static struct platform_driver pf1550_regulator_driver = {
+	.driver = {
+		   .name = "pf1550-regulator",
+		   },
+	.probe = pf1550_regulator_probe,
+	.id_table = pf1550_regulator_id,
+};
+module_platform_driver(pf1550_regulator_driver);
+
+MODULE_DESCRIPTION("Freescale PF1550 regulator driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL");

-- 
2.49.0



