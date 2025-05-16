Return-Path: <linux-pm+bounces-27243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C76ABA345
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CE47AF7CD
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494B27F4C9;
	Fri, 16 May 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="yKghKIlT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4E27D781;
	Fri, 16 May 2025 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421763; cv=none; b=MeJ54VHyPWo5qisqQM29XqGswpEjClbTUaVUNAv3HAsz6E/ZzjSZ5cs9ylZLrwzeSYGQoNOFetmWAwcHmCer+7uV8GT0ma98jvMfwfWpL7qJKtboFVoj2ukyVRS3aIxr3gqlUYYrNeeX3YRRSt4Bwm/jGRGS3hfb/szhar9QqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421763; c=relaxed/simple;
	bh=YcSBNtTWEN+1Njluqvk1eZewsWgnA+YCrAVwP6mP6GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSEvgLAiHpjG8mEX+hYYh+0nJjLg5cT4l3H+SSX8lld3PW1P5KdoWCZgq3UCW0CYlJFPQYYFibo+pXGvNJ3wJeGotex5Eqs/1bXmBEO1tvYwKjx8UC4E4R+TlgcGnuULmXa+m+GN9g5t+jpDjTpIhgBbGqizUNcS4nvm+vlYmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=yKghKIlT; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2E0C89C6885;
	Fri, 16 May 2025 14:56:00 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5WF-8qgso41Z; Fri, 16 May 2025 14:55:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 086E29C8AFC;
	Fri, 16 May 2025 14:55:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 086E29C8AFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421759; bh=LElRp6m8b2exy8+zvoLctFh6JXMrdYfI5BTl1vyDZcM=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=yKghKIlTPPYXI0ms9hk2RHV8vE3QsJWQvQnTEN68lGRvwjAZJpzDBuGCrOZwGtNEk
	 UO6Q/58qj/OFbAfHGdKB8g/qhbCPqd25VBpOiIRNFcnVo3l+5r3jnL3q5gBU81wEhT
	 9FM33TYF6f9TApPsifwP623umACoHmrwwF26NHFubVjtGlnX/FwUaStZoujBYB34Qn
	 5XCek1XjxBODRaVPqoIDC7Jjo2CoQS4mylCbAwzNW7BY6IihoCaLwNk4PaR0wLNhdC
	 NzeRAwCGC1Mp+M6TsCCF/UTaGpoK2a8nXJoywM8ACjLAVkIiHCvj1WWTmmaiWU9lSY
	 j2x6hbUFDH53g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MvNcu0qfzPEy; Fri, 16 May 2025 14:55:58 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CD9DF9C6885;
	Fri, 16 May 2025 14:55:58 -0400 (EDT)
Date: Fri, 16 May 2025 14:55:57 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, linux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH v2 6/9] regulator: pf1550: add support for regulator
Message-ID: <4dd316e06a66634b5af13f1faedc985753b061bc.1747409892.git.samuel.kayode@savoirfairelinux.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>

Add regulator support for the pf1550 PMIC.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 drivers/regulator/Kconfig  |   7 +
 drivers/regulator/Makefile |   1 +
 drivers/regulator/pf1550.c | 380 +++++++++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 drivers/regulator/pf1550.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 05e32d764028..cdce1658957f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1038,6 +1038,13 @@ config REGULATOR_PV88090
 	  Say y here to support the voltage regulators and convertors
 	  on PV88090
 
+config REGULATOR_PF1550
+	tristate "Freescale PF1550 regulator"
+	depends on MFD_PF1550
+	help
+	  This driver controls a PF1550 regulator via I2C bus.
+	  The regulators include three switch and three ldo.
+
 config REGULATOR_PWM
 	tristate "PWM voltage regulator"
 	depends on PWM
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 524e026c0273..2d11c069b0ca 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
 obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
+obj-$(CONFIG_REGULATOR_PF1550) += pf1550.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf1550.c b/drivers/regulator/pf1550.c
new file mode 100644
index 000000000000..e7a9c3b43c12
--- /dev/null
+++ b/drivers/regulator/pf1550.c
@@ -0,0 +1,380 @@
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
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regulator/machine.h>
+#include <linux/platform_device.h>
+
+#define PF1550_MAX_REGULATOR 7
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
+static struct pf1550_irq_info pf1550_regulator_irqs[] = {
+	{ PF1550_PMIC_IRQ_SW1_LS,		"sw1-lowside" },
+	{ PF1550_PMIC_IRQ_SW2_LS,		"sw2-lowside" },
+	{ PF1550_PMIC_IRQ_SW3_LS,		"sw3-lowside" },
+
+	{ PF1550_PMIC_IRQ_SW1_HS,		"sw1-highside" },
+	{ PF1550_PMIC_IRQ_SW2_HS,		"sw2-highside" },
+	{ PF1550_PMIC_IRQ_SW3_HS,		"sw3-highside" },
+
+	{ PF1550_PMIC_IRQ_LDO1_FAULT,		"ldo1-fault" },
+	{ PF1550_PMIC_IRQ_LDO2_FAULT,		"ldo2-fault" },
+	{ PF1550_PMIC_IRQ_LDO3_FAULT,		"ldo3-fault" },
+
+	{ PF1550_PMIC_IRQ_TEMP_110,		"temp-110" },
+	{ PF1550_PMIC_IRQ_TEMP_125,		"temp-125" },
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
+#define PF_VREF(_chip, _name, voltage)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(#_name),	\
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
+#define PF_SW1(_chip, _name, mask, voltages)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(#_name),	\
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
+#define PF_SW3(_chip, _name, min, max, mask, step)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(#_name),	\
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
+#define PF_LDO1(_chip, _name, mask, voltages)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(#_name),	\
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
+#define PF_LDO2(_chip, _name, mask, min, max, step)	{	\
+	.desc = {	\
+		.name = #_name,	\
+		.of_match = of_match_ptr(#_name),	\
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
+	PF_SW3(PF1550, SW1, 600000, 1387500, 0x3f, 12500),
+	PF_SW3(PF1550, SW2, 600000, 1387500, 0x3f, 12500),
+	PF_SW3(PF1550, SW3, 1800000, 3300000, 0xf, 100000),
+	PF_VREF(PF1550, VREFDDR, 1200000),
+	PF_LDO1(PF1550, LDO1, 0x1f, pf1550_ldo13_volts),
+	PF_LDO2(PF1550, LDO2, 0xf, 1800000, 3300000, 100000),
+	PF_LDO1(PF1550, LDO3, 0x1f, pf1550_ldo13_volts),
+};
+
+static irqreturn_t pf1550_regulator_irq_handler(int irq, void *data)
+{
+	struct pf1550_regulator_info *info = data;
+	int i, irq_type = -1;
+
+	info->irq = irq;
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_regulator_irqs); i++)
+		if (info->irq == pf1550_regulator_irqs[i].virq)
+			irq_type = pf1550_regulator_irqs[i].irq;
+
+	switch (irq_type) {
+	case PF1550_PMIC_IRQ_SW1_LS:
+	case PF1550_PMIC_IRQ_SW2_LS:
+	case PF1550_PMIC_IRQ_SW3_LS:
+		dev_info(info->dev, "lowside interrupt triggered! irq_type=%d\n",
+			 irq_type);
+		break;
+	case PF1550_PMIC_IRQ_SW1_HS:
+	case PF1550_PMIC_IRQ_SW2_HS:
+	case PF1550_PMIC_IRQ_SW3_HS:
+		dev_info(info->dev, "highside interrupt triggered! irq_type=%d\n",
+			 irq_type);
+		break;
+	case PF1550_PMIC_IRQ_LDO1_FAULT:
+	case PF1550_PMIC_IRQ_LDO2_FAULT:
+	case PF1550_PMIC_IRQ_LDO3_FAULT:
+		dev_info(info->dev, "ldo fault triggered! irq_type=%d\n",
+			 irq_type);
+		break;
+	case PF1550_PMIC_IRQ_TEMP_110:
+	case PF1550_PMIC_IRQ_TEMP_125:
+		dev_info(info->dev, "thermal exception triggered! irq_type=%d\n",
+			 irq_type);
+		break;
+	default:
+		dev_err(info->dev, "regulator interrupt: irq %d occurred\n",
+			irq_type);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pf1550_regulator_probe(struct platform_device *pdev)
+{
+	struct pf1550_dev *iodev = dev_get_drvdata(pdev->dev.parent);
+	struct device_node *np = pdev->dev.of_node;
+	struct pf1550_regulator_info *info;
+	int i, ret = 0;
+	struct regulator_config config = { };
+
+	if (!np)
+		return -ENODEV;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(struct pf1550_regulator_info),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
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
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev,
+				"Failed to initialize regulator-%d\n", i);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_regulator_irqs); i++) {
+		struct pf1550_irq_info *regulator_irq =
+						&pf1550_regulator_irqs[i];
+		unsigned int virq = 0;
+
+		virq = regmap_irq_get_virq(iodev->irq_data_regulator,
+					   regulator_irq->irq);
+
+		if (!virq)
+			return -EINVAL;
+		regulator_irq->virq = virq;
+
+		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
+						pf1550_regulator_irq_handler,
+					IRQF_NO_SUSPEND,
+					regulator_irq->name, info);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed: irq request (IRQ: %d, error :%d)\n",
+				regulator_irq->irq, ret);
+			return ret;
+		}
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
+	{"pf1550-regulator", PF1550},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(platform, pf1550_regulator_id);
+
+static struct platform_driver pf1550_regulator_driver = {
+	.driver = {
+		   .name = "pf1550-regulator",
+		   },
+	.probe = pf1550_regulator_probe,
+	.id_table = pf1550_regulator_id,
+};
+
+module_platform_driver(pf1550_regulator_driver);
+
+MODULE_DESCRIPTION("Freescale PF1550 regulator driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.49.0


