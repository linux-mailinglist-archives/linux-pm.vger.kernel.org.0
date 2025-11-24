Return-Path: <linux-pm+bounces-38506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 362ACC82951
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 22:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 766C54E3927
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 21:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F032FA20;
	Mon, 24 Nov 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAFVTOAz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C432F774;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021218; cv=none; b=DLLDStsHM2VOyj91+ab97D3gsCY4RaUyqUiqNIXU42SLxxXrbDqT4r68JP7zvK0aPx7+GwyTCjWir2GWLBuAYd5r8bRhhinWAGklEstJkcdSIZq/s3m1dxCIl5hOPw3WZDq2QRAAvZ5mN9ISHpON5O88U6TeeMqFay0GTndoQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021218; c=relaxed/simple;
	bh=U75tQfB+CxqTIxiXtul6BfWuCrZpHiWDngPIkL1yXtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RdFvYTqYpBWr1Z/KdIH1H0zbdyW//yo9wB3pTJklW3CnkxWgG5JOGpJ2poQcadPNA5PezHyBqou5SeXgaTFyVEDcY0ey9HRc2jBOWNp9ltTzF7cbCB57xDj+PfPN/AqPPF8GUA4T7OTE4BHkau2+PIucTDv6+vNrkNvlnecxE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAFVTOAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DF0FC4CEFB;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021218;
	bh=U75tQfB+CxqTIxiXtul6BfWuCrZpHiWDngPIkL1yXtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tAFVTOAzfh/0RQpbua9xIxWw8d2pzZEuq2jFuK6AIbpxIAm2w4R4h4qX4gjOFyXeV
	 tXEStwanewM5at4jjGf3NEJ8cS4SFbR+egZeiIrRyiXmMcprv6u2f/3gIUG8C06HU3
	 DRpPB9zDCvDD7+cP9P5rWZ8UmgIfXfGnCRh2nmzLdyNS+Yr2qWEJzPeuOaU4+pOb4U
	 jqkisZzjbHpVfygCcy6cUEWFm6YsmivOOOd1QDnC4NhJS1HmAEV9kSr1iMt+HP926A
	 1EEtEDd9G7daZUFvmcOE53nIbofzCIlw40r0B/7kqsZ3gHspwtpz+rbpCauNs1Gc81
	 XnEOfyAIcxQbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3647ACFD360;
	Mon, 24 Nov 2025 21:53:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 24 Nov 2025 22:53:35 +0100
Subject: [PATCH RFC 2/8] power: supply: Add driver for Qualcomm PMI8998
 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251124-pmi8998_fuel_gauge-v1-2-dd3791f61478@ixit.cz>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
In-Reply-To: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Casey Connolly <casey@connolly.tech>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Richard Acayan <mailingradian@gmail.com>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20973; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=3EhOp7+1Mtoxk6hc41aMmLn59WiI2Nd6Xzcmx2ZWgq4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpJNPgbs48fzQOzVvnGSO01F6Od9LxUTyDmXEOb
 MFD9FqfOl2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaSTT4AAKCRBgAj/E00kg
 cmhxEADSlWUQm7y79kgVwNIpUbh5iphIWtrABTZMqXLSR98TaYsibZLPgS4mhpwOTE9LwaNeuJG
 jAKzwvu2mtuYZgDZG8sWxhBapiwQdNB3NdN08rDpV+u9OZ8ZTC+D8AnNI/fPefuDE4f/ehEux7l
 VseTt/E7NPBDxhySv8QDqbFZblDMq66XTe5bYuZWyoGdquY1auupzKkC58faG6+PWL2xI9NnA3d
 GQxZty9cABax2pI0G6ZmLQBTO4+vUQdFn9n6QjwxLbyE6gs4js0MeTZO+iQDyJJ9z3FU75Kyai1
 2hwJLfYDCaZTpWML+S++4Fwsf0wMRHIff2J6Q4HkzOEYG1VG88XZK8iaZRyeuNfpuP6BUhuCKnh
 7+5vRK/QV3M2sdYBoEUYhE4jdQDXg/g9RtPMpjl+rTSQhhjU8tCnZWXRtKVhpw+4r14XY1HYv/K
 L4tDuXAlVtPnkuddhj0U6M8OJR7ynqT6IciVsQUYtQPqqPx5y7qvPMcyPCRA/5gTtI5yCMlUEeb
 F5CSkLtLUiZWL28V0ysXbshabvMjHq2EaeE6+fMVP7Wu4LI4jM6LYfmMvVnwfwjbcnpaAQxAKmc
 4yOwfc6iZZ8c3ZcnYmNMGr227y3iZ9YtKZ08U6dFumSm2eMmxJYYSCezjsryms0hBngBuNtsCxr
 6RTI4Z0MNilXXxA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Joel Selvaraj <foss@joelselvaraj.com>

Ths driver supports the fuel gauge hardware available on PMICs known as
3rd generation fuel gauge hardware available on PMI8998.

Co-developed-by: Casey Connolly <casey@connolly.tech>
Co-developed-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Co-developed-by: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/Kconfig      |   8 +
 drivers/power/supply/Makefile     |   1 +
 drivers/power/supply/pmi8998_fg.c | 687 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 696 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 92f9f7aae92f2..4024c6fe3fef2 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -746,6 +746,14 @@ config CHARGER_PM8916_LBC
 	  To compile this driver as module, choose M here: the
 	  module will be called pm8916_lbc.
 
+config BATTERY_PMI8998_FG
+	tristate "Qualcomm PMI8998 PMIC fuel gauge driver"
+	depends on MFD_SPMI_PMIC
+	help
+	  Say Y here to enable the Qualcomm PMI8998 PMIC Fuel Gauge driver.
+	  This adds support for battery fuel gauging and state of charge of
+	  battery connected to the fuel gauge.
+
 config CHARGER_BQ2415X
 	tristate "TI BQ2415x battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4b79d5abc49a7..03584efa2b1b0 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_CHARGER_MT6370)	+= mt6370-charger.o
 obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
 obj-$(CONFIG_BATTERY_PM8916_BMS_VM)	+= pm8916_bms_vm.o
 obj-$(CONFIG_CHARGER_PM8916_LBC)	+= pm8916_lbc.o
+obj-$(CONFIG_BATTERY_PMI8998_FG)	+= pmi8998_fg.o
 obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
 obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
 obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
diff --git a/drivers/power/supply/pmi8998_fg.c b/drivers/power/supply/pmi8998_fg.c
new file mode 100644
index 0000000000000..d5fccd16a013b
--- /dev/null
+++ b/drivers/power/supply/pmi8998_fg.c
@@ -0,0 +1,687 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2020, The Linux Foundation. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+/* SOC */
+#define BATT_MONOTONIC_SOC		0x009
+
+/* BATT */
+#define PARAM_ADDR_BATT_TEMP		0x150
+#define BATT_INFO_JEITA_COLD		0x162
+#define BATT_INFO_JEITA_COOL		0x163
+#define BATT_INFO_JEITA_WARM		0x164
+#define BATT_INFO_JEITA_HOT		0x165
+#define PARAM_ADDR_BATT_VOLTAGE		0x1a0
+#define PARAM_ADDR_BATT_CURRENT		0x1a2
+
+/* MEMIF */
+#define MEM_INTF_IMA_CFG		0x452
+#define MEM_INTF_IMA_EXP_STS		0x455
+#define MEM_INTF_IMA_HW_STS		0x456
+#define MEM_INTF_IMA_ERR_STS		0x45f
+#define MEM_INTF_ADDR_LSB		0x461
+#define MEM_INTF_RD_DATA0		0x467
+#define MEM_INTF_WR_DATA0		0x463
+#define MEM_IF_DMA_STS			0x470
+#define MEM_IF_DMA_CTL			0x471
+
+#define BATT_TEMP_LSB_MASK		GENMASK(7, 0)
+#define BATT_TEMP_MSB_MASK		GENMASK(2, 0)
+
+struct pmi8998_fg_chip {
+	struct device *dev;
+	unsigned int base;
+	struct regmap *regmap;
+	struct notifier_block nb;
+
+	struct power_supply *batt_psy;
+	struct power_supply *chg_psy;
+	int status;
+	struct delayed_work status_changed_work;
+};
+
+/*
+ * IO functions
+ */
+
+/**
+ * @brief pmi8998_fg_read() - Read multiple registers with regmap_bulk_read
+ *
+ * @param chip Pointer to chip
+ * @param val Pointer to read values into
+ * @param addr Address to read from
+ * @param len Number of registers (bytes) to read
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_read(struct pmi8998_fg_chip *chip, u8 *val, u16 addr, int len)
+{
+	if (((chip->base + addr) & 0xff00) == 0)
+		return -EINVAL;
+
+	dev_vdbg(chip->dev, "%s: Reading 0x%x bytes from 0x%x", __func__, len, addr);
+
+	return regmap_bulk_read(chip->regmap, chip->base + addr, val, len);
+}
+
+/**
+ * @brief pmi8998_fg_write() - Write multiple registers with regmap_bulk_write
+ *
+ * @param chip Pointer to chip
+ * @param val Pointer to write values from
+ * @param addr Address to write to
+ * @param len Number of registers (bytes) to write
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_write(struct pmi8998_fg_chip *chip, u8 *val, u16 addr, int len)
+{
+	bool sec_access = (addr & 0xff) > 0xd0;
+	u8 sec_addr_val = 0xa5;
+	int ret;
+
+	if (((chip->base + addr) & 0xff00) == 0)
+		return -EINVAL;
+
+	dev_vdbg(chip->dev, "%s: Writing 0x%x to 0x%x", __func__, *val, addr);
+
+	if (sec_access) {
+		ret = regmap_bulk_write(chip->regmap,
+					((chip->base + addr) & 0xff00) | 0xd0,
+				&sec_addr_val, 1);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_bulk_write(chip->regmap, chip->base + addr, val, len);
+}
+
+/**
+ * @brief pmi8998_fg_masked_write() - like pmi8998_fg_write but applies
+ * a mask first.
+ *
+ * @param chip Pointer to chip
+ * @param val Pointer to write values from
+ * @param addr Address to write to
+ * @param len Number of registers (bytes) to write
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_masked_write(struct pmi8998_fg_chip *chip, u16 addr, u8 mask, u8 val)
+{
+	u8 reg;
+	int ret;
+
+	ret = pmi8998_fg_read(chip, &reg, addr, 1);
+	if (ret)
+		return ret;
+
+	reg &= ~mask;
+	reg |= val & mask;
+
+	return pmi8998_fg_write(chip, &reg, addr, 1);
+}
+
+/*
+ * Battery status
+ */
+
+/**
+ * @brief pmi8998_fg_get_capacity() - Get remaining capacity of battery
+ *
+ * @param chip Pointer to chip
+ * @param val Pointer to store value at
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_get_capacity(struct pmi8998_fg_chip *chip, int *val)
+{
+	u8 cap[2];
+	int ret;
+
+	ret = pmi8998_fg_read(chip, cap, BATT_MONOTONIC_SOC, 2);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read capacity: %d", ret);
+		return ret;
+	}
+
+	if (cap[0] != cap[1])
+		cap[0] = cap[0] < cap[1] ? cap[0] : cap[1];
+
+	*val = DIV_ROUND_CLOSEST((cap[0] - 1) * 98, 0xff - 2) + 1;
+
+	return 0;
+}
+
+/**
+ * @brief pmi8998_fg_get_temperature() - Get temperature of battery
+ *
+ * @param chip Pointer to chip
+ * @param val Pointer to store value at
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_get_temperature(struct pmi8998_fg_chip *chip, int *val)
+{
+	int ret, temp;
+	u8 readval[2];
+
+	ret = pmi8998_fg_read(chip, readval, PARAM_ADDR_BATT_TEMP, 2);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read temperature: %d\n", ret);
+		return ret;
+	}
+
+	temp = ((readval[1] & BATT_TEMP_MSB_MASK) << 8) |
+		(readval[0] & BATT_TEMP_LSB_MASK);
+	temp = DIV_ROUND_CLOSEST(temp * 10, 4);
+
+	*val = temp - 2730;
+
+	return 0;
+}
+
+/**
+ * @brief pmi8998_fg_get_current() - Get current being drawn from battery
+ *
+ * @param chip Pointer to chip
+ * @param val Pointer to store value at
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_get_current(struct pmi8998_fg_chip *chip, int *val)
+{
+	s16 temp;
+	u8 readval[2];
+	int ret;
+
+	ret = pmi8998_fg_read(chip, readval, PARAM_ADDR_BATT_CURRENT, 2);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read current: %d\n", ret);
+		return ret;
+	}
+
+	/* handle rev 1 too */
+	temp = (s16)(readval[1] << 8 | readval[0]);
+	*val = div_s64((s64)temp * 488281, 1000);
+
+	/*
+	 * PSY API expects charging batteries to report a positive current, which is inverted
+	 * to what the PMIC reports.
+	 */
+	*val = -*val;
+
+	return 0;
+}
+
+/**
+ * @brief pmi8998_fg_get_voltage() - Get voltage of battery
+ *
+ * @param chip Pointer to chip
+ * @param val Pointer to store value at
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_get_voltage(struct pmi8998_fg_chip *chip, int *val)
+{
+	int temp;
+	u8 readval[2];
+	int ret;
+
+	ret = pmi8998_fg_read(chip, readval, PARAM_ADDR_BATT_VOLTAGE, 2);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read voltage: %d\n", ret);
+		return ret;
+	}
+
+	/* handle rev 1 too */
+	temp = readval[1] << 8 | readval[0];
+	*val = div_u64((u64)temp * 122070, 1000);
+
+	return 0;
+}
+
+/**
+ * @brief pmi8998_fg_get_temp_threshold() - Get configured temperature thresholds
+ *
+ * @param chip Pointer to chip
+ * @param psp Power supply property of temperature limit
+ * @param val Pointer to store value at
+ * @return int 0 on success, negative errno on error
+ */
+static int pmi8998_fg_get_temp_threshold(struct pmi8998_fg_chip *chip,
+					 enum power_supply_property psp, int *val)
+{
+	u8 temp;
+	u16 reg;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		reg = BATT_INFO_JEITA_COLD;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		reg = BATT_INFO_JEITA_HOT;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+		reg = BATT_INFO_JEITA_COOL;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		reg = BATT_INFO_JEITA_WARM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = pmi8998_fg_read(chip, &temp, reg, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read JEITA property %d level: %d\n", psp, ret);
+		return ret;
+	}
+
+	/* Resolution is 0.5C. Base is -30C. */
+	*val = (((5 * temp) / 10) - 30) * 10;
+
+	return 0;
+}
+
+/*
+ * Battery power supply
+ */
+
+static enum power_supply_property pmi8998_fg_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_TEMP_MAX,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
+	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+};
+
+static int pmi8998_fg_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct pmi8998_fg_chip *chip = power_supply_get_drvdata(psy);
+	int temp, ret = 0;
+
+	dev_dbg(chip->dev, "Getting property: %d", psp);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		/* Get status from charger if available */
+		if (chip->chg_psy &&
+		    chip->status != POWER_SUPPLY_STATUS_UNKNOWN) {
+			val->intval = chip->status;
+		} else {
+			/*
+			 * Fall back to capacity and current-based
+			 * status checking
+			 */
+			ret = pmi8998_fg_get_capacity(chip, &temp);
+			if (ret) {
+				val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+				break;
+			}
+			if (temp == 100) {
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+				break;
+			}
+
+			ret = pmi8998_fg_get_current(chip, &temp);
+			if (ret) {
+				val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+				break;
+			}
+			if (temp < 0)
+				val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			else if (temp > 0)
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			else
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		}
+
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = pmi8998_fg_get_capacity(chip, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = pmi8998_fg_get_current(chip, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = pmi8998_fg_get_voltage(chip, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = pmi8998_fg_get_temperature(chip, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
+	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
+		ret = pmi8998_fg_get_temp_threshold(chip, psp, &val->intval);
+		break;
+	default:
+		dev_err(chip->dev, "invalid property: %d\n", psp);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct power_supply_desc batt_psy_desc = {
+	.name = "qcom-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = pmi8998_fg_props,
+	.num_properties = ARRAY_SIZE(pmi8998_fg_props),
+	.get_property = pmi8998_fg_get_property,
+};
+
+/*
+ * Init functions
+ */
+
+static int pmi8998_fg_iacs_clear_sequence(struct pmi8998_fg_chip *chip)
+{
+	u8 temp;
+	int ret;
+
+	/* clear the error */
+	ret = pmi8998_fg_masked_write(chip, MEM_INTF_IMA_CFG, BIT(2), BIT(2));
+	if (ret) {
+		dev_err(chip->dev, "Failed to write IMA_CFG: %d\n", ret);
+		return ret;
+	}
+
+	temp = 0x4;
+	ret = pmi8998_fg_write(chip, &temp, MEM_INTF_ADDR_LSB + 1, 1);
+	if (ret) {
+		dev_err(chip->dev, "Failed to write MEM_INTF_ADDR_MSB: %d\n", ret);
+		return ret;
+	}
+
+	temp = 0x0;
+	ret = pmi8998_fg_write(chip, &temp, MEM_INTF_WR_DATA0 + 3, 1);
+	if (ret) {
+		dev_err(chip->dev, "Failed to write WR_DATA3: %d\n", ret);
+		return ret;
+	}
+
+	ret = pmi8998_fg_read(chip, &temp, MEM_INTF_RD_DATA0 + 3, 1);
+	if (ret) {
+		dev_err(chip->dev, "Failed to write RD_DATA3: %d\n", ret);
+		return ret;
+	}
+
+	ret = pmi8998_fg_masked_write(chip, MEM_INTF_IMA_CFG, BIT(2), 0);
+	if (ret) {
+		dev_err(chip->dev, "Failed to write IMA_CFG: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pmi8998_fg_clear_ima(struct pmi8998_fg_chip *chip, bool check_hw_sts)
+{
+	u8 err_sts, exp_sts, hw_sts;
+	bool run_err_clr_seq = false;
+	int ret;
+
+	ret = pmi8998_fg_read(chip, &err_sts, MEM_INTF_IMA_ERR_STS, 1);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read IMA_ERR_STS: %d\n", ret);
+		return ret;
+	}
+
+	ret = pmi8998_fg_read(chip, &exp_sts,
+			      MEM_INTF_IMA_EXP_STS, 1);
+	if (ret) {
+		dev_err(chip->dev, "Failed to read IMA_EXP_STS: %d\n", ret);
+		return ret;
+	}
+
+	if (check_hw_sts) {
+		ret = pmi8998_fg_read(chip, &hw_sts,
+				      MEM_INTF_IMA_HW_STS, 1);
+		if (ret) {
+			dev_err(chip->dev, "Failed to read IMA_HW_STS: %d\n", ret);
+			return ret;
+		}
+		/*
+		 * Lower nibble should be equal to upper nibble before SRAM
+		 * transactions begins from SW side.
+		 */
+		if ((hw_sts & 0x0f) != hw_sts >> 4) {
+			dev_dbg(chip->dev, "IMA HW not in correct state, hw_sts=%x\n",
+				hw_sts);
+			run_err_clr_seq = true;
+		}
+	}
+
+	if (exp_sts & (BIT(0) | BIT(1) | BIT(3) |
+		BIT(4) | BIT(5) | BIT(6) |
+		BIT(7))) {
+		dev_dbg(chip->dev, "IMA exception bit set, exp_sts=%x\n", exp_sts);
+		run_err_clr_seq = true;
+	}
+
+	if (run_err_clr_seq) {
+		ret = pmi8998_fg_iacs_clear_sequence(chip);
+		if (!ret)
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static irqreturn_t pmi8998_fg_handle_soc_delta(int irq, void *data)
+{
+	struct pmi8998_fg_chip *chip = data;
+
+	/* Signal change in state of charge */
+	power_supply_changed(chip->batt_psy);
+	dev_dbg(chip->dev, "SOC changed");
+
+	return IRQ_HANDLED;
+}
+
+static void pmi8998_fg_status_changed_worker(struct work_struct *work)
+{
+	struct pmi8998_fg_chip *chip = container_of(work, struct pmi8998_fg_chip,
+						    status_changed_work.work);
+
+	power_supply_changed(chip->batt_psy);
+}
+
+static int pmi8998_fg_notifier_call(struct notifier_block *nb, unsigned long val, void *v)
+{
+	struct pmi8998_fg_chip *chip = container_of(nb, struct pmi8998_fg_chip, nb);
+	struct power_supply *psy = v;
+	union power_supply_propval propval;
+	int ret;
+
+	if (psy == chip->chg_psy) {
+		ret = power_supply_get_property(psy,
+						POWER_SUPPLY_PROP_STATUS, &propval);
+		if (ret)
+			chip->status = POWER_SUPPLY_STATUS_UNKNOWN;
+
+		chip->status = propval.intval;
+
+		power_supply_changed(chip->batt_psy);
+
+		if (chip->status == POWER_SUPPLY_STATUS_UNKNOWN) {
+			/*
+			 * REVISIT: Find better solution or remove current-based
+			 * status checking once checking is properly implemented
+			 * in charger drivers
+
+			 * Sometimes it take a while for current to stabilize,
+			 * so signal property change again later to make sure
+			 * current-based status is properly detected.
+			 */
+			cancel_delayed_work_sync(&chip->status_changed_work);
+			schedule_delayed_work(&chip->status_changed_work,
+					      msecs_to_jiffies(1000));
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int pmi8998_fg_probe(struct platform_device *pdev)
+{
+	struct power_supply_config supply_config = {};
+	struct pmi8998_fg_chip *chip;
+	const __be32 *prop_addr;
+	int irq;
+	u8 dma_status;
+	bool error_present;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &pdev->dev;
+
+	chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!chip->regmap) {
+		dev_err(chip->dev, "Failed to locate the regmap\n");
+		return -ENODEV;
+	}
+
+	/* Get base address */
+	prop_addr = of_get_address(pdev->dev.of_node, 0, NULL, NULL);
+	if (!prop_addr) {
+		dev_err(chip->dev, "Failed to read SOC base address from dt\n");
+		return -EINVAL;
+	}
+	chip->base = be32_to_cpu(*prop_addr);
+
+	/*
+	 * Change the FG_MEM_INT interrupt to track IACS_READY
+	 * condition instead of end-of-transaction. This makes sure
+	 * that the next transaction starts only after the hw is ready.
+	 * IACS_INTR_SRC_SLCT is BIT(3)
+	 */
+	ret = pmi8998_fg_masked_write(chip, MEM_INTF_IMA_CFG, BIT(3), BIT(3));
+	if (ret) {
+		dev_err(chip->dev,
+			"Failed to configure interrupt sourete: %d\n", ret);
+		return ret;
+	}
+
+	ret = pmi8998_fg_clear_ima(chip, true);
+	if (ret && ret != -EAGAIN) {
+		dev_err(chip->dev, "Failed to clear IMA exception: %d\n", ret);
+		return ret;
+	}
+
+	/* Check and clear DMA errors */
+	ret = pmi8998_fg_read(chip, &dma_status, MEM_IF_DMA_STS, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read dma_status: %d\n", ret);
+		return ret;
+	}
+
+	error_present = dma_status & (BIT(1) | BIT(2));
+	ret = pmi8998_fg_masked_write(chip, MEM_IF_DMA_CTL, BIT(0),
+				      error_present ? BIT(0) : 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to write dma_ctl: %d\n", ret);
+		return ret;
+	}
+
+	supply_config.drv_data = chip;
+	supply_config.fwnode = dev_fwnode(&pdev->dev);
+
+	chip->batt_psy = devm_power_supply_register(chip->dev,
+						    &batt_psy_desc, &supply_config);
+	if (IS_ERR(chip->batt_psy)) {
+		if (PTR_ERR(chip->batt_psy) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to register battery\n");
+		return PTR_ERR(chip->batt_psy);
+	}
+
+	platform_set_drvdata(pdev, chip);
+
+	/* Get soc-delta IRQ */
+	irq = of_irq_get_byname(pdev->dev.of_node, "soc-delta");
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq soc-delta byname: %d\n",
+			irq);
+		return irq;
+	}
+
+	ret = devm_request_threaded_irq(chip->dev, irq, NULL,
+					pmi8998_fg_handle_soc_delta,
+					IRQF_ONESHOT, "soc-delta", chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request soc-delta IRQ: %d\n", ret);
+		return ret;
+	}
+
+	/* Optional: Get charger power supply for status checking */
+	chip->chg_psy = power_supply_get_by_reference(of_fwnode_handle(chip->dev->of_node),
+						      "power-supplies");
+	if (IS_ERR(chip->chg_psy)) {
+		ret = PTR_ERR(chip->chg_psy);
+		dev_warn(chip->dev, "Failed to get charger supply: %d\n", ret);
+		chip->chg_psy = NULL;
+	}
+
+	if (chip->chg_psy) {
+		INIT_DELAYED_WORK(&chip->status_changed_work,
+				  pmi8998_fg_status_changed_worker);
+
+		chip->nb.notifier_call = pmi8998_fg_notifier_call;
+		ret = power_supply_reg_notifier(&chip->nb);
+		if (ret) {
+			dev_err(chip->dev,
+				"Failed to register notifier: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id fg_match_id_table[] = {
+	{ .compatible = "qcom,pmi8998-fg" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fg_match_id_table);
+
+static struct platform_driver pmi8998_fg_driver = {
+	.probe = pmi8998_fg_probe,
+	.driver = {
+		.name = "pmi8998-fg",
+		.of_match_table = fg_match_id_table,
+	},
+};
+
+module_platform_driver(pmi8998_fg_driver);
+
+MODULE_AUTHOR("Casey Connolly <casey@connolly.tech>");
+MODULE_AUTHOR("Joel Selvaraj <foss@joelselvaraj.com>");
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Qualcomm PMI8998 Fuel Gauge Driver");
+MODULE_LICENSE("GPL");

-- 
2.51.0



