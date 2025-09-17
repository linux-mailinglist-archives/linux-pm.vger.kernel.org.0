Return-Path: <linux-pm+bounces-34892-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3EB80C71
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152AE1881DEE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A3730C118;
	Wed, 17 Sep 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvb7vK97"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255D2F83C3;
	Wed, 17 Sep 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124470; cv=none; b=Pd2FLwYubjB37RmRrjPZCSAhy2I74x5ok4SxJ09Jd+WXja5WH+7CVxwCYmM814tHzX+gg7Br2kbr21oTWj3vjFqrnEsM9g9I7f47yTbjrJitlHQ1jI9mI+JCWkPG/k/RAfLQ2iMPqwFDZ4x/599/hmczRWlXktp5rnnKH4gANUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124470; c=relaxed/simple;
	bh=w7vs81D3JzEH/b/oM15EAjn+EALSaJVq2GTX3LkCGbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEsuVqSzLzIhIaqA6qTS0S4u92vov8jDygDpy70wPkS+MaECrxQ1PWXkTXYXm7CixXa3CJIh9HGIIQA0VN3kbclcy0BgqEGIe5Tnto6S9p72rgXzO4UZA1JJUbxAgsbcqP8QMaNvzSxOm7N1GVMHptogU4RrORA+9uzt7APkV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvb7vK97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D69B3C113D0;
	Wed, 17 Sep 2025 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124469;
	bh=w7vs81D3JzEH/b/oM15EAjn+EALSaJVq2GTX3LkCGbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jvb7vK97BKrKTDyoNGZJtxWbbpsc1iPAnSF26vPWfuKLEMEbrlYBjSPEDjpcwtA5p
	 erCLFlD1zq2fYGBdoRlqCQ86+mCVI5SwEIcVNL1+WKqRm2G4Owt1OJ1DUW4R4o/Jx8
	 e2Frk0ApOSUZLTA4oJNqgbQX6/ghQUZwAahmDt1D2n9LJCHSnu/DfFgArZVs2JqDdV
	 DCa+i52wFZzltLt2pycOiUHbPwVlBoV5e+c6jZokFRvlPAHaiodsyNdajxKJ5ENYwN
	 vq0oxtHm0MCXyXX803bpQavuCy+sGXeAxP+Gy8M1vVWapwn5W/tjvunCjeCrJwjtyf
	 awGiL5mT9/W8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3384CAC5A9;
	Wed, 17 Sep 2025 15:54:29 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 17 Sep 2025 11:52:36 -0400
Subject: [PATCH v11 3/6] regulator: pf1550: add support for regulator
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-pf1550-v11-3-e0649822fcc9@savoirfairelinux.com>
References: <20250917-pf1550-v11-0-e0649822fcc9@savoirfairelinux.com>
In-Reply-To: <20250917-pf1550-v11-0-e0649822fcc9@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, 
 Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758124466; l=17343;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=nZkgAIuvPkP+P7dQ9JxN56RQdgfiMDJbECyinL4sWVI=;
 b=ZadnC/b8WfaJDPUZkY8a26cAs4QznJAFRjlTt7b8arVFZUen5FD6j6qcLddGz3623NGnZo2y3
 cFlVDO7KeGDDty6OFgNydD5TYUWn+7YWNWNzJMLmeuUvu0dwBegEqrG
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add regulator support for the pf1550 PMIC.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v10:
- Change dvsX_enb to dvsX_enable
v9:
- Requested by Sean:
  - Add support for SW1 DVS enable/disable
  - Add support for standby voltages
- Add map_voltage for all configurable regulators
- Add regulator enable/disable for all regulators
- Fix for DVS activation when meant to be disabled
v7:
- Use reverese christmas tree style
- Drop unecessary 0 in id table's driver data
v6:
- Use dvs_enb variable in pf1550_dev as suggested by Frank Li
v5:
- Address Mark's feedback:
  - Add comments to clarify difference in interrupts
  - Issue warn event for _LS(low side) interrupt
  - Validate maximum ramp_delay
v4:
- Address Mark's feedback:
  - Use C++ comments for SPDX license
  - Add portions copyright to reflect my update
  - Validate ramp_delay
  - Report overcurrent and temperature events
- Use platform_get_irq
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
 drivers/regulator/pf1550-regulator.c | 429 +++++++++++++++++++++++++++++++++++
 3 files changed, 439 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6d8988387da4599633ca9bde2698b9711e34a245..de455887f9aeeada5546e44b8dc9d7ed041618a6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1049,6 +1049,15 @@ config REGULATOR_PV88090
 	  Say y here to support the voltage regulators and convertors
 	  on PV88090
 
+config REGULATOR_PF1550
+	tristate "NXP PF1550 regulator"
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
index c0bc7a0f4e67098c50ac3cf887ae95f46b2eac44..891174b511fc0653bac662c71659498122e8441f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -125,6 +125,7 @@ obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
 obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
+obj-$(CONFIG_REGULATOR_PF1550) += pf1550-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf1550-regulator.c b/drivers/regulator/pf1550-regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..90492609773886343151c2ba40d2d4bf84c37c5e
--- /dev/null
+++ b/drivers/regulator/pf1550-regulator.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// regulator driver for the PF1550
+//
+// Copyright (C) 2016 Freescale Semiconductor, Inc.
+// Robin Gong <yibin.gong@freescale.com>
+//
+// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+//
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
+	unsigned char stby_enable_reg;
+	unsigned char stby_enable_mask;
+};
+
+struct pf1550_regulator_info {
+	struct device *dev;
+	const struct pf1550_ddata *pf1550;
+	struct pf1550_desc regulator_descs[PF1550_MAX_REGULATOR];
+	struct regulator_dev *rdevs[PF1550_MAX_REGULATOR];
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
+	unsigned int ramp_bits = 0;
+	int ret;
+
+	if (id > PF1550_VREFDDR)
+		return -EACCES;
+
+	if (ramp_delay < 0 || ramp_delay > 6250)
+		return -EINVAL;
+
+	ramp_delay = 6250 / ramp_delay;
+	ramp_bits = ramp_delay >> 1;
+
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg + 4, 0x10,
+				 ramp_bits << 4);
+	if (ret < 0)
+		dev_err(&rdev->dev, "ramp failed, err %d\n", ret);
+
+	return ret;
+}
+
+static int pf1550_set_suspend_enable(struct regulator_dev *rdev)
+{
+	const struct pf1550_desc *desc = container_of(rdev->desc,
+						      struct pf1550_desc,
+						      desc);
+	unsigned int val = desc->stby_enable_mask;
+
+	return regmap_update_bits(rdev->regmap, desc->stby_enable_reg,
+				  desc->stby_enable_mask, val);
+}
+
+static int pf1550_set_suspend_disable(struct regulator_dev *rdev)
+{
+	const struct pf1550_desc *desc = container_of(rdev->desc,
+						      struct pf1550_desc,
+						      desc);
+
+	return regmap_update_bits(rdev->regmap, desc->stby_enable_reg,
+				  desc->stby_enable_mask, 0);
+}
+
+static int pf1550_buck_set_table_suspend_voltage(struct regulator_dev *rdev,
+						 int uV)
+{
+	const struct pf1550_desc *desc = container_of(rdev->desc,
+						      struct pf1550_desc,
+						      desc);
+	int ret;
+
+	ret = regulator_map_voltage_ascend(rdev, uV, uV);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev), "failed to map %i uV\n", uV);
+		return ret;
+	}
+
+	return regmap_update_bits(rdev->regmap, desc->stby_reg,
+				  desc->stby_mask, ret);
+}
+
+static int pf1550_buck_set_linear_suspend_voltage(struct regulator_dev *rdev,
+						  int uV)
+{
+	const struct pf1550_desc *desc = container_of(rdev->desc,
+						      struct pf1550_desc,
+						      desc);
+	int ret;
+
+	ret = regulator_map_voltage_linear(rdev, uV, uV);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev), "failed to map %i uV\n", uV);
+		return ret;
+	}
+
+	return regmap_update_bits(rdev->regmap, desc->stby_reg,
+				  desc->stby_mask, ret);
+}
+
+static const struct regulator_ops pf1550_sw1_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_suspend_enable = pf1550_set_suspend_enable,
+	.set_suspend_disable = pf1550_set_suspend_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_suspend_voltage = pf1550_buck_set_table_suspend_voltage,
+	.map_voltage = regulator_map_voltage_ascend,
+	.set_ramp_delay = pf1550_set_ramp_delay,
+};
+
+static const struct regulator_ops pf1550_sw2_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_suspend_enable = pf1550_set_suspend_enable,
+	.set_suspend_disable = pf1550_set_suspend_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_suspend_voltage = pf1550_buck_set_linear_suspend_voltage,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_ramp_delay = pf1550_set_ramp_delay,
+};
+
+static const struct regulator_ops pf1550_ldo1_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_suspend_enable = pf1550_set_suspend_enable,
+	.set_suspend_disable = pf1550_set_suspend_disable,
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
+	.set_suspend_enable = pf1550_set_suspend_enable,
+	.set_suspend_disable = pf1550_set_suspend_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.map_voltage = regulator_map_voltage_linear,
+};
+
+static const struct regulator_ops pf1550_fixed_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_suspend_enable = pf1550_set_suspend_enable,
+	.set_suspend_disable = pf1550_set_suspend_disable,
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
+	.stby_enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+	.stby_enable_mask = 0x2,	\
+}
+
+#define PF_SW(_chip, match, _name, min, max, mask, step)	{	\
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
+		.linear_min_sel = 0,	\
+		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
+		.vsel_mask = (mask),	\
+		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+		.enable_mask = 0x1,	\
+	},	\
+	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
+	.stby_mask = (mask),	\
+	.stby_enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+	.stby_enable_mask = 0x2,	\
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
+	.stby_enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+	.stby_enable_mask = 0x2,	\
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
+		.linear_min_sel = 0,	\
+		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
+		.vsel_mask = (mask),	\
+		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+		.enable_mask = 0x1,	\
+	},	\
+	.stby_enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
+	.stby_enable_mask = 0x2,	\
+}
+
+static struct pf1550_desc pf1550_regulators[] = {
+	PF_SW(PF1550, "sw1", SW1, 600000, 1387500, 0x3f, 12500),
+	PF_SW(PF1550, "sw2", SW2, 600000, 1387500, 0x3f, 12500),
+	PF_SW(PF1550, "sw3", SW3, 1800000, 3300000, 0xf, 100000),
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
+	struct platform_device *pdev = to_platform_device(dev);
+	int i, irq_type = -1;
+	unsigned int event;
+
+	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++)
+		if (irq == platform_get_irq(pdev, i))
+			irq_type = i;
+
+	switch (irq_type) {
+	/* The _LS interrupts indicate over-current event. The _HS interrupts
+	 * which are more accurate and can detect catastrophic faults, issue
+	 * an error event. The current limit FAULT interrupt is similar to the
+	 * _HS'
+	 */
+	case PF1550_PMIC_IRQ_SW1_LS:
+	case PF1550_PMIC_IRQ_SW2_LS:
+	case PF1550_PMIC_IRQ_SW3_LS:
+		event = REGULATOR_EVENT_OVER_CURRENT_WARN;
+		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
+			if (!strcmp(rdev_get_name(info->rdevs[i]), "SW3"))
+				regulator_notifier_call_chain(info->rdevs[i],
+							      event, NULL);
+		break;
+	case PF1550_PMIC_IRQ_SW1_HS:
+	case PF1550_PMIC_IRQ_SW2_HS:
+	case PF1550_PMIC_IRQ_SW3_HS:
+		event = REGULATOR_EVENT_OVER_CURRENT;
+		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
+			if (!strcmp(rdev_get_name(info->rdevs[i]), "SW3"))
+				regulator_notifier_call_chain(info->rdevs[i],
+							      event, NULL);
+		break;
+	case PF1550_PMIC_IRQ_LDO1_FAULT:
+	case PF1550_PMIC_IRQ_LDO2_FAULT:
+	case PF1550_PMIC_IRQ_LDO3_FAULT:
+		event = REGULATOR_EVENT_OVER_CURRENT;
+		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
+			if (!strcmp(rdev_get_name(info->rdevs[i]), "LDO3"))
+				regulator_notifier_call_chain(info->rdevs[i],
+							      event, NULL);
+		break;
+	case PF1550_PMIC_IRQ_TEMP_110:
+	case PF1550_PMIC_IRQ_TEMP_125:
+		event = REGULATOR_EVENT_OVER_TEMP;
+		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
+			regulator_notifier_call_chain(info->rdevs[i],
+						      event, NULL);
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
+	const struct pf1550_ddata *pf1550 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = { };
+	struct pf1550_regulator_info *info;
+	int i, irq = -1, ret = 0;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	config.regmap = dev_get_regmap(pf1550->dev, NULL);
+	if (!config.regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to get parent regmap\n");
+
+	config.dev = pf1550->dev;
+	config.regmap = pf1550->regmap;
+	info->dev = &pdev->dev;
+	info->pf1550 = pf1550;
+
+	memcpy(info->regulator_descs, pf1550_regulators,
+	       sizeof(info->regulator_descs));
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
+		struct regulator_desc *desc;
+
+		desc = &info->regulator_descs[i].desc;
+
+		if ((desc->id == PF1550_SW2 && !pf1550->dvs2_enable) ||
+		    (desc->id == PF1550_SW1 && !pf1550->dvs1_enable)) {
+			/* OTP_SW2_DVS_ENB == 1? or OTP_SW1_DVS_ENB == 1? */
+			desc->volt_table = pf1550_sw12_volts;
+			desc->n_voltages = ARRAY_SIZE(pf1550_sw12_volts);
+			desc->ops = &pf1550_sw1_ops;
+		}
+
+		info->rdevs[i] = devm_regulator_register(&pdev->dev, desc,
+							 &config);
+		if (IS_ERR(info->rdevs[i]))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(info->rdevs[i]),
+					     "failed to initialize regulator-%d\n",
+					     i);
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						pf1550_regulator_irq_handler,
+						IRQF_NO_SUSPEND,
+						"pf1550-regulator", info);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed: irq request (IRQ: %d)\n",
+					     i);
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id pf1550_regulator_id[] = {
+	{ "pf1550-regulator", },
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
+MODULE_DESCRIPTION("NXP PF1550 regulator driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL");

-- 
2.50.1



