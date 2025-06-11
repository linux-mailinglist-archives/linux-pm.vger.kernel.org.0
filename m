Return-Path: <linux-pm+bounces-28506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED35CAD5FB6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 22:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B201BC2BDD
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD32BEC28;
	Wed, 11 Jun 2025 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INFLDrn5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB02BDC2C;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672180; cv=none; b=HfxHFG8k2bVu9nF0kNontFHeBGAvllT61YHtt+xytUOfpx4B+Z2Y1XeAd+SxWqHr0yMkcwTXB/L7l+LPAPYAr9Sw6tcwc0zwA0cvBZg421xIsu3EB4uoDryRrle8O5pmCw9WAxkBQFcaH9len0sqm/C9g/OVEixGu+C9fSaCxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672180; c=relaxed/simple;
	bh=r1nA62oWz+N6EEjGQzdjzsY2XJHCXjKbLuEGLust5tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fv+KFNkpHumZkjOgjW+SQEI3n0+tEMXpV4+jLLj2x7KDANFPrKkVNonRpheoDQfDSbdScpS/QUeS6CgkT9mnHAZ5bUkfN2tvhlHZT/WtfIDbV4JGkul1c099Q8j7LH/p3rjP1Yd7YJkwFeNGmAV4epsJ+Ylte3xqacGJYulD9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INFLDrn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DB0EC4CEF2;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749672180;
	bh=r1nA62oWz+N6EEjGQzdjzsY2XJHCXjKbLuEGLust5tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=INFLDrn5TJUl72n33htX/oQd1U64X/hd1BHiUCD5TxYpmPxSwMsv8FM0pWCGkD7Fi
	 c4ZmSxcgtrsaFD1zhk36ajszYgFXqIc0Q+zWBwvbBX5eeVcwce7KAUr96ez4diooZj
	 fM7X4HnltPc7Az+n8qNV+JycwJ71bydQvOzvDdamK7fv99cTRoFPrQMxm/izTumavM
	 MgivS8eam1n/Bh6pmbRm7xLni0aRn4duadEpoyt9TSKgODwbBMDZd/MyadgOGWuIay
	 HqKY+XtTo5MF4uO+F+7X4KTuQ5NK+asQ7czN3gAkOWajrtX+5ZH1YgXvPCDAI7TRaH
	 9HA9zf4FnmqfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBBBC71135;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 11 Jun 2025 16:03:02 -0400
Subject: [PATCH v6 5/6] power: supply: pf1550: add battery charger support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-pf1550-v6-5-34f2ddfe045e@savoirfairelinux.com>
References: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
In-Reply-To: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
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
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749672178; l=19867;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=4yYkIju5/6JTtXKzI0l2ngqVA1Sk+NA/4Cea/1m4Wjs=;
 b=EHb6XE+ong5mIeFLOGnStKre/zkjY6RvPo/x5QhJMGM2QgRcBrG7MK9tqcuF0ba396Y55fokZ
 DGn/SRN4Th6AxylpKD9R9MjBK7M1590Sx1csTPvlfrpliMzeFXfk0Fg
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add support for the battery charger for pf1550 PMIC.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v6:
- Drop lock entirely
- Reverse christmas tree order for variables defined in probe as
  suggested by Frank
- return pf1550_reg_init
v5:
- Drop lock for battery and charger delayed_work
- More conservative locking in vbus delayed_work
- Apply lock when setting power supply type during register initialization
v4:
- Finish handling of some interrupts in threaded irq handler
- Use platform_get_irq
v3:
- Use struct power_supply_get_battery_info to get constant charge
  voltage if specified
- Use virqs mapped in MFD driver
v2:
- Address feedback from Enric Balletbo Serra
---
 drivers/power/supply/Kconfig          |  11 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/pf1550-charger.c | 633 ++++++++++++++++++++++++++++++++++
 3 files changed, 645 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..6d0c872edac1f45da314632e671af1aeda4c87b8 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -471,6 +471,17 @@ config CHARGER_88PM860X
 	help
 	  Say Y here to enable charger for Marvell 88PM860x chip.
 
+config CHARGER_PF1550
+	tristate "NXP PF1550 battery charger driver"
+	depends on MFD_PF1550
+	help
+	  Say Y to enable support for the NXP PF1550 battery charger.
+	  The device is a single cell Li-Ion/Li-Polymer battery charger for
+	  portable application.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called pf1550-charger.
+
 config BATTERY_RX51
 	tristate "Nokia RX-51 (N900) battery driver"
 	depends on TWL4030_MADC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..7f68380099c59dab71b73120150612a23e16a745 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_CHARGER_RT9467)	+= rt9467-charger.o
 obj-$(CONFIG_CHARGER_RT9471)	+= rt9471.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
+obj-$(CONFIG_CHARGER_PF1550)	+= pf1550-charger.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
 obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o ab8500_chargalg.o
 obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
new file mode 100644
index 0000000000000000000000000000000000000000..3b4cdf4cab9659005f86ffb32e8457c7cb3065f9
--- /dev/null
+++ b/drivers/power/supply/pf1550-charger.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// pf1550_charger.c - charger driver for the PF1550
+//
+// Copyright (C) 2016 Freescale Semiconductor, Inc.
+// Robin Gong <yibin.gong@freescale.com>
+//
+// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+//
+
+#include <linux/interrupt.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+
+#define PF1550_CHARGER_NAME		"pf1550-charger"
+#define PF1550_DEFAULT_CONSTANT_VOLT	4200000
+#define PF1550_DEFAULT_MIN_SYSTEM_VOLT	3500000
+#define PF1550_DEFAULT_THERMAL_TEMP	75
+#define PF1550_CHARGER_IRQ_NR		5
+
+static const char *pf1550_charger_model		= "PF1550";
+static const char *pf1550_charger_manufacturer	= "NXP";
+
+struct pf1550_charger {
+	struct device *dev;
+	const struct pf1550_dev *pf1550;
+	struct power_supply *charger;
+	struct power_supply_desc psy_desc;
+	struct delayed_work vbus_sense_work;
+	struct delayed_work chg_sense_work;
+	struct delayed_work bat_sense_work;
+
+	u32 constant_volt;
+	u32 min_system_volt;
+	u32 thermal_regulation_temp;
+};
+
+static int pf1550_get_charger_state(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_CHG_SNS_MASK;
+
+	switch (data) {
+	case PF1550_CHG_PRECHARGE:
+	case PF1550_CHG_CONSTANT_CURRENT:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case PF1550_CHG_CONSTANT_VOL:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case PF1550_CHG_EOC:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case PF1550_CHG_DONE:
+		*val = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case PF1550_CHG_TIMER_FAULT:
+	case PF1550_CHG_SUSPEND:
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case PF1550_CHG_OFF_INV:
+	case PF1550_CHG_OFF_TEMP:
+	case PF1550_CHG_LINEAR_ONLY:
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int pf1550_get_charge_type(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_CHG_SNS_MASK;
+
+	switch (data) {
+	case PF1550_CHG_SNS_MASK:
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case PF1550_CHG_CONSTANT_CURRENT:
+	case PF1550_CHG_CONSTANT_VOL:
+	case PF1550_CHG_EOC:
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case PF1550_CHG_DONE:
+	case PF1550_CHG_TIMER_FAULT:
+	case PF1550_CHG_SUSPEND:
+	case PF1550_CHG_OFF_INV:
+	case PF1550_CHG_BAT_OVER:
+	case PF1550_CHG_OFF_TEMP:
+	case PF1550_CHG_LINEAR_ONLY:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	default:
+		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+/*
+ * Supported health statuses:
+ *  - POWER_SUPPLY_HEALTH_DEAD
+ *  - POWER_SUPPLY_HEALTH_GOOD
+ *  - POWER_SUPPLY_HEALTH_OVERVOLTAGE
+ *  - POWER_SUPPLY_HEALTH_UNKNOWN
+ */
+static int pf1550_get_battery_health(struct regmap *regmap, int *val)
+{
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_BAT_SNS_MASK;
+
+	switch (data) {
+	case PF1550_BAT_NO_DETECT:
+		*val = POWER_SUPPLY_HEALTH_DEAD;
+		break;
+	case PF1550_BAT_NO_VBUS:
+	case PF1550_BAT_LOW_THAN_PRECHARG:
+	case PF1550_BAT_CHARG_FAIL:
+	case PF1550_BAT_HIGH_THAN_PRECHARG:
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case PF1550_BAT_OVER_VOL:
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		break;
+	default:
+		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+		break;
+	}
+
+	return 0;
+}
+
+static int pf1550_get_present(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_BAT_SNS_MASK;
+	*val = (data == PF1550_BAT_NO_DETECT) ? 0 : 1;
+
+	return 0;
+}
+
+static int pf1550_get_online(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_VBUS_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	*val = (data & PF1550_VBUS_VALID) ? 1 : 0;
+
+	return 0;
+}
+
+static void pf1550_chg_bat_work(struct work_struct *work)
+{
+	struct pf1550_charger *chg = container_of(to_delayed_work(work),
+						  struct pf1550_charger,
+						  bat_sense_work);
+	unsigned int data;
+
+	if (!chg->charger)
+		return;
+
+	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_BATT_SNS, &data)) {
+		dev_err(chg->dev, "Read BATT_SNS error.\n");
+		return;
+	}
+
+	switch (data & PF1550_BAT_SNS_MASK) {
+	case PF1550_BAT_NO_VBUS:
+		dev_dbg(chg->dev, "No valid VBUS input.\n");
+		break;
+	case PF1550_BAT_LOW_THAN_PRECHARG:
+		dev_dbg(chg->dev, "VBAT < VPRECHG.LB.\n");
+		break;
+	case PF1550_BAT_CHARG_FAIL:
+		dev_dbg(chg->dev, "Battery charging failed.\n");
+		break;
+	case PF1550_BAT_HIGH_THAN_PRECHARG:
+		dev_dbg(chg->dev, "VBAT > VPRECHG.LB.\n");
+		break;
+	case PF1550_BAT_OVER_VOL:
+		dev_dbg(chg->dev, "VBAT > VBATOV.\n");
+		break;
+	case PF1550_BAT_NO_DETECT:
+		dev_dbg(chg->dev, "Battery not detected.\n");
+		break;
+	default:
+		dev_err(chg->dev, "Unknown value read:%x\n",
+			data & PF1550_CHG_SNS_MASK);
+	}
+}
+
+static void pf1550_chg_chg_work(struct work_struct *work)
+{
+	struct pf1550_charger *chg = container_of(to_delayed_work(work),
+						  struct pf1550_charger,
+						  chg_sense_work);
+	unsigned int data;
+
+	if (!chg->charger)
+		return;
+
+	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_SNS, &data)) {
+		dev_err(chg->dev, "Read CHG_SNS error.\n");
+		return;
+	}
+
+	switch (data & PF1550_CHG_SNS_MASK) {
+	case PF1550_CHG_PRECHARGE:
+		dev_dbg(chg->dev, "In pre-charger mode.\n");
+		break;
+	case PF1550_CHG_CONSTANT_CURRENT:
+		dev_dbg(chg->dev, "In fast-charge constant current mode.\n");
+		break;
+	case PF1550_CHG_CONSTANT_VOL:
+		dev_dbg(chg->dev, "In fast-charge constant voltage mode.\n");
+		break;
+	case PF1550_CHG_EOC:
+		dev_dbg(chg->dev, "In EOC mode.\n");
+		break;
+	case PF1550_CHG_DONE:
+		dev_dbg(chg->dev, "In DONE mode.\n");
+		break;
+	case PF1550_CHG_TIMER_FAULT:
+		dev_info(chg->dev, "In timer fault mode.\n");
+		break;
+	case PF1550_CHG_SUSPEND:
+		dev_info(chg->dev, "In thermistor suspend mode.\n");
+		break;
+	case PF1550_CHG_OFF_INV:
+		dev_info(chg->dev, "Input invalid, charger off.\n");
+		break;
+	case PF1550_CHG_BAT_OVER:
+		dev_info(chg->dev, "Battery over-voltage.\n");
+		break;
+	case PF1550_CHG_OFF_TEMP:
+		dev_info(chg->dev, "Temp high, charger off.\n");
+		break;
+	case PF1550_CHG_LINEAR_ONLY:
+		dev_dbg(chg->dev, "In Linear mode, not charging.\n");
+		break;
+	default:
+		dev_err(chg->dev, "Unknown value read:%x\n",
+			data & PF1550_CHG_SNS_MASK);
+	}
+}
+
+static void pf1550_chg_vbus_work(struct work_struct *work)
+{
+	struct pf1550_charger *chg = container_of(to_delayed_work(work),
+						  struct pf1550_charger,
+						  vbus_sense_work);
+	unsigned int data;
+	bool psy_changed = false;
+
+	if (!chg->charger)
+		return;
+
+	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data)) {
+		dev_err(chg->dev, "Read VBUS_SNS error.\n");
+		return;
+	}
+
+	if (data & PF1550_VBUS_UVLO) {
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+		psy_changed = true;
+		dev_dbg(chg->dev, "VBUS detached.\n");
+	}
+	if (data & PF1550_VBUS_IN2SYS)
+		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
+	if (data & PF1550_VBUS_OVLO)
+		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
+	if (data & PF1550_VBUS_VALID) {
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+		psy_changed = true;
+		dev_dbg(chg->dev, "VBUS attached.\n");
+	}
+
+	if (psy_changed)
+		power_supply_changed(chg->charger);
+}
+
+static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
+{
+	struct pf1550_charger *chg = data;
+	struct device *dev = chg->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	int i, irq_type = -1;
+
+	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++)
+		if (irq == platform_get_irq(pdev, i))
+			irq_type = i;
+
+	switch (irq_type) {
+	case PF1550_CHARG_IRQ_BAT2SOCI:
+		dev_info(dev, "BAT to SYS Overcurrent interrupt.\n");
+		break;
+	case PF1550_CHARG_IRQ_BATI:
+		schedule_delayed_work(&chg->bat_sense_work,
+				      msecs_to_jiffies(10));
+		break;
+	case PF1550_CHARG_IRQ_CHGI:
+		schedule_delayed_work(&chg->chg_sense_work,
+				      msecs_to_jiffies(10));
+		break;
+	case PF1550_CHARG_IRQ_VBUSI:
+		schedule_delayed_work(&chg->vbus_sense_work,
+				      msecs_to_jiffies(10));
+		break;
+	case PF1550_CHARG_IRQ_THMI:
+		dev_info(dev, "Thermal interrupt.\n");
+		break;
+	default:
+		dev_err(dev, "unknown interrupt occurred.\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static enum power_supply_property pf1550_charger_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static int pf1550_charger_get_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct pf1550_charger *chg = power_supply_get_drvdata(psy);
+	struct regmap *regmap = chg->pf1550->regmap;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = pf1550_get_charger_state(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = pf1550_get_charge_type(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = pf1550_get_battery_health(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = pf1550_get_present(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = pf1550_get_online(regmap, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = pf1550_charger_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = pf1550_charger_manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int pf1550_set_constant_volt(struct pf1550_charger *chg,
+				    unsigned int uvolt)
+{
+	unsigned int data;
+
+	if (uvolt >= 3500000 && uvolt <= 4440000)
+		data = 8 + (uvolt - 3500000) / 20000;
+	else
+		return dev_err_probe(chg->dev, -EINVAL,
+				     "Wrong value for constant voltage\n");
+
+	dev_dbg(chg->dev, "Charging constant voltage: %u (0x%x)\n", uvolt,
+		data);
+
+	return regmap_update_bits(chg->pf1550->regmap,
+				  PF1550_CHARG_REG_BATT_REG,
+				  PF1550_CHARG_REG_BATT_REG_CHGCV_MASK, data);
+}
+
+static int pf1550_set_min_system_volt(struct pf1550_charger *chg,
+				      unsigned int uvolt)
+{
+	unsigned int data;
+
+	switch (uvolt) {
+	case 3500000:
+		data = 0x0;
+		break;
+	case 3700000:
+		data = 0x1;
+		break;
+	case 4300000:
+		data = 0x2;
+		break;
+	default:
+		return dev_err_probe(chg->dev, -EINVAL,
+				     "Wrong value for minimum system voltage\n");
+	}
+
+	data <<= PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT;
+
+	dev_dbg(chg->dev, "Minimum system regulation voltage: %u (0x%x)\n",
+		uvolt, data);
+
+	return regmap_update_bits(chg->pf1550->regmap,
+				  PF1550_CHARG_REG_BATT_REG,
+				  PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK, data);
+}
+
+static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg,
+					      unsigned int cells)
+{
+	unsigned int data;
+
+	switch (cells) {
+	case 60:
+		data = 0x0;
+		break;
+	case 75:
+		data = 0x1;
+		break;
+	case 90:
+		data = 0x2;
+		break;
+	case 105:
+		data = 0x3;
+		break;
+	default:
+		return dev_err_probe(chg->dev, -EINVAL,
+				     "Wrong value for thermal temperature\n");
+	}
+
+	data <<= PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
+
+	dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
+		cells, data);
+
+	return regmap_update_bits(chg->pf1550->regmap,
+				  PF1550_CHARG_REG_THM_REG_CNFG,
+				  PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK,
+				  data);
+}
+
+/*
+ * Sets charger registers to proper and safe default values.
+ */
+static int pf1550_reg_init(struct pf1550_charger *chg)
+{
+	struct device *dev = chg->dev;
+	int ret;
+	unsigned int data;
+
+	/* Unmask charger interrupt, mask DPMI and reserved bit */
+	ret =  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MASK,
+			    PF1550_CHG_INT_MASK);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Error unmask charger interrupt\n");
+
+	ret = regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS,
+			  &data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Read charg vbus_sns error\n");
+
+	if (data & PF1550_VBUS_VALID)
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+
+	ret = pf1550_set_constant_volt(chg, chg->constant_volt);
+	if (ret)
+		return ret;
+
+	ret = pf1550_set_min_system_volt(chg, chg->min_system_volt);
+	if (ret)
+		return ret;
+
+	ret = pf1550_set_thermal_regulation_temp(chg,
+						 chg->thermal_regulation_temp);
+	if (ret)
+		return ret;
+
+	/* Turn on charger */
+	ret = regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_OPER,
+			   PF1550_CHG_TURNON);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error turn on charger\n");
+
+	return 0;
+}
+
+static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
+{
+	struct device *dev = chg->dev;
+	struct power_supply_battery_info *info;
+
+	if (device_property_read_u32(dev->parent, "nxp,min-system-microvolt",
+				     &chg->min_system_volt))
+		chg->min_system_volt = PF1550_DEFAULT_MIN_SYSTEM_VOLT;
+
+	if (device_property_read_u32(dev->parent,
+				     "nxp,thermal-regulation-celsius",
+				     &chg->thermal_regulation_temp))
+		chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;
+
+	if (power_supply_get_battery_info(chg->charger, &info))
+		chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
+	else
+		chg->constant_volt = info->constant_charge_voltage_max_uv;
+}
+
+static int pf1550_charger_probe(struct platform_device *pdev)
+{
+	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
+	struct pf1550_charger *chg;
+	int i, irq, ret;
+
+	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
+	if (!chg)
+		return -ENOMEM;
+
+	chg->dev = &pdev->dev;
+	chg->pf1550 = pf1550;
+
+	if (!chg->pf1550->regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to get regmap\n");
+
+	platform_set_drvdata(pdev, chg);
+
+	INIT_DELAYED_WORK(&chg->vbus_sense_work, pf1550_chg_vbus_work);
+	INIT_DELAYED_WORK(&chg->chg_sense_work, pf1550_chg_chg_work);
+	INIT_DELAYED_WORK(&chg->bat_sense_work, pf1550_chg_bat_work);
+
+	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						pf1550_charger_irq_handler,
+						IRQF_NO_SUSPEND,
+						"pf1550-charger", chg);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed irq request\n");
+	}
+
+	psy_cfg.drv_data = chg;
+
+	chg->psy_desc.name = PF1550_CHARGER_NAME;
+	chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	chg->psy_desc.get_property = pf1550_charger_get_property;
+	chg->psy_desc.properties = pf1550_charger_props;
+	chg->psy_desc.num_properties = ARRAY_SIZE(pf1550_charger_props);
+
+	chg->charger = devm_power_supply_register(&pdev->dev, &chg->psy_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->charger))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
+				     "failed: power supply register\n");
+
+	pf1550_dt_parse_dev_info(chg);
+
+	return pf1550_reg_init(chg);
+}
+
+static void pf1550_charger_remove(struct platform_device *pdev)
+{
+	struct pf1550_charger *chg = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&chg->bat_sense_work);
+	cancel_delayed_work_sync(&chg->chg_sense_work);
+	cancel_delayed_work_sync(&chg->vbus_sense_work);
+}
+
+static const struct platform_device_id pf1550_charger_id[] = {
+	{ "pf1550-charger", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
+
+static struct platform_driver pf1550_charger_driver = {
+	.driver = {
+		.name	= "pf1550-charger",
+	},
+	.probe		= pf1550_charger_probe,
+	.remove		= pf1550_charger_remove,
+	.id_table	= pf1550_charger_id,
+};
+module_platform_driver(pf1550_charger_driver);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_DESCRIPTION("PF1550 charger driver");
+MODULE_LICENSE("GPL");

-- 
2.49.0



