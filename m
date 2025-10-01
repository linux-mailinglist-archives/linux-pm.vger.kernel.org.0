Return-Path: <linux-pm+bounces-35645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C97BB1250
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BB189C192
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC127F000;
	Wed,  1 Oct 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM0usz2K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B4284896;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333363; cv=none; b=GrWiuKmxp65RjK3wtVVjlhee7yoAxcrOsrcVRV8jrK3zkN9Hc/qHrhgj5UK3LzwedZ7RLBcPWIHX23NK1VssVe/3djqmjNyYEJHGih4ZxHSAmBWRNE2IUpeV0C5CxJMCDu7J5/eHtZNztB4CkA+rIc5OsF4NjUPNbbzhKG30ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333363; c=relaxed/simple;
	bh=269VpJs12CT1ez9gXnAgQRqbApvzgybdIVEvkXbcr+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZIeTWC0+/LJ0dQJK/u0B0TA5UKlD7tuVAopzSo+WFpidkGiTZyFwG9E/F8JmLs1P9N+SIpUJPjoiMZw3+JLpIyc3ypcjBHh+cyxv/Do6D6P5hbBkC6gH5wX47i/18rRBUKFJ+4W1IhsFinkkSmXgpdf0YIl8iX3z2El1F3tokc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM0usz2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E7C9C19425;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333362;
	bh=269VpJs12CT1ez9gXnAgQRqbApvzgybdIVEvkXbcr+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HM0usz2KOH/VlIM8OdCmkjtdAy7xjydP1vAMht+a80WFSVAq+6ALVwDegzB2Qqg/Z
	 FIA2VR2XRbDCXxNyBKZBcd+vpTpgTaA/jJKYWExZL+0ZdgKy7m5DdZVXXYZggLZGKX
	 dPZud4whIRElvmaulOGL3ulcxZjGhDeg7KWbNSkZUSOKt2fVJkPlSebuvFXWb0Oz3b
	 sj1WVKTfyLv+AWGu1eRiM/vl2XLl+ktjC5gFzSS9aQgyVfQpkfMeuVF1HefCxqBpP9
	 y3ZO6myMEaS41NDJh3lqRBNSyvA6Etk2zUb5dNt9pT2wXtz/HUnqdgYYjNq+t+fhjX
	 lE5gztUZ0lb1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510E3CCD182;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 01 Oct 2025 11:42:41 -0400
Subject: [PATCH v12 5/6] power: supply: pf1550: add battery charger support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-pf1550-v12-5-a3302aa41687@savoirfairelinux.com>
References: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
In-Reply-To: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
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
 Abel Vesa <abelvesa@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759333360; l=21233;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=SkR1D2E6DB6LiKYv7egZAQkkY/1Yjfpv2Rv84j9oQqM=;
 b=MzbRXCnKK0gB4pgxiSAgMhIqbrTDp8DHUbRCtRINNkwYoK7RF7MJBa0U/RePHj6vhsBV4RqMH
 PllfMMIXpixAulbvP4GpVsBOF8G5vHlkODM4v6yYkB9kJnT/LfGS9KW
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add support for the battery charger for pf1550 PMIC.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v11:
- Seperate the battery properties from the charger properties
v9:
- Fix thermal regulation temperature ranges
- Fix default thermal regulation temperature
- Drop unused `data` variable in reg_init
- Select charger operation mode based on application - suggested by Sean
v8:
- Drop PF1550_CHARGER_NAME
- Drop unnecessary POWER_SUPPLY_STATUS_CHARGING s
- Replace POWER_SUPPLY_HEALTH_DEAD with POWER_SUPPLY_HEALTH_NO_BATTERY
- Drop check for charger in delayed_work s
- Use dev_warn when battery is over-voltage
- Define two power supplies: charger and battery
- Use devm_delayed_work_autocancel to automate cleanup and fix race
  condition
v7:
- Use reverse christmas tree order
- Drop unecessary 0 in id table's driver data field
- Store virqs to avoid reinvoking platform_get_irq in the interrupt
  service routine
- Drop manufacturer and model global variables
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
 drivers/power/supply/pf1550-charger.c | 641 ++++++++++++++++++++++++++++++++++
 3 files changed, 653 insertions(+)

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
index f943c9150b326d41ff241f82610f70298635eb08..5a177f4884deb79f059cfbfa95466932630a48de 100644
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
index 0000000000000000000000000000000000000000..98f1ee8eca3bc8dff2c3a697d157b9e3da204fe2
--- /dev/null
+++ b/drivers/power/supply/pf1550-charger.c
@@ -0,0 +1,641 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * charger driver for the PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+ * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+ */
+
+#include <linux/devm-helpers.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+
+#define PF1550_DEFAULT_CONSTANT_VOLT	4200000
+#define PF1550_DEFAULT_MIN_SYSTEM_VOLT	3500000
+#define PF1550_DEFAULT_THERMAL_TEMP	95
+#define PF1550_CHARGER_IRQ_NR		5
+
+struct pf1550_charger {
+	struct device *dev;
+	const struct pf1550_ddata *pf1550;
+	struct power_supply *charger;
+	struct power_supply *battery;
+	struct delayed_work vbus_sense_work;
+	struct delayed_work chg_sense_work;
+	struct delayed_work bat_sense_work;
+	int virqs[PF1550_CHARGER_IRQ_NR];
+
+	u32 constant_volt;
+	u32 min_system_volt;
+	u32 thermal_regulation_temp;
+};
+
+static int pf1550_get_charger_state(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
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
+	case PF1550_CHG_CONSTANT_VOL:
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
+	unsigned int data;
+	int ret;
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
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= PF1550_BAT_SNS_MASK;
+
+	switch (data) {
+	case PF1550_BAT_NO_DETECT:
+		*val = POWER_SUPPLY_HEALTH_NO_BATTERY;
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
+		dev_warn(chg->dev, "Battery over-voltage.\n");
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
+
+	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data)) {
+		dev_err(chg->dev, "Read VBUS_SNS error.\n");
+		return;
+	}
+
+	if (data & PF1550_VBUS_UVLO) {
+		dev_dbg(chg->dev, "VBUS detached.\n");
+		power_supply_changed(chg->battery);
+	}
+	if (data & PF1550_VBUS_IN2SYS)
+		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
+	if (data & PF1550_VBUS_OVLO)
+		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
+	if (data & PF1550_VBUS_VALID) {
+		dev_dbg(chg->dev, "VBUS attached.\n");
+		power_supply_changed(chg->charger);
+	}
+}
+
+static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
+{
+	struct pf1550_charger *chg = data;
+	struct device *dev = chg->dev;
+	int i, irq_type = -1;
+
+	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++)
+		if (irq == chg->virqs[i])
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
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static enum power_supply_property pf1550_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
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
+		val->strval = "PF1550";
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "NXP";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct power_supply_desc pf1550_charger_desc = {
+	.name = "pf1550-charger",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = pf1550_charger_props,
+	.num_properties = ARRAY_SIZE(pf1550_charger_props),
+	.get_property = pf1550_charger_get_property,
+};
+
+static const struct power_supply_desc pf1550_battery_desc = {
+	.name = "pf1550-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = pf1550_battery_props,
+	.num_properties = ARRAY_SIZE(pf1550_battery_props),
+	.get_property = pf1550_charger_get_property,
+};
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
+	case 80:
+		data = 0x0;
+		break;
+	case 95:
+		data = 0x1;
+		break;
+	case 110:
+		data = 0x2;
+		break;
+	case 125:
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
+	struct power_supply_battery_info *info;
+	struct device *dev = chg->dev;
+	int ret;
+
+	/* Unmask charger interrupt, mask DPMI and reserved bit */
+	ret =  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MASK,
+			    PF1550_CHG_INT_MASK);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Error unmask charger interrupt\n");
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
+	/*
+	 * The PF1550 charger has 3 modes of operation. By default, the charger
+	 * is in mode 1; it remains off. Appropriate for applications not using
+	 * a battery. The other supported mode is mode 2, the charger is turned
+	 * on to charge a battery when present.
+	 */
+	if (power_supply_get_battery_info(chg->charger, &info)) {
+		ret = regmap_write(chg->pf1550->regmap,
+				   PF1550_CHARG_REG_CHG_OPER,
+				   PF1550_CHG_BAT_ON);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Error turn on charger\n");
+	}
+
+	return 0;
+}
+
+static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
+{
+	struct power_supply_battery_info *info;
+	struct device *dev = chg->dev;
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
+	const struct pf1550_ddata *pf1550 = dev_get_drvdata(pdev->dev.parent);
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
+	ret = devm_delayed_work_autocancel(chg->dev, &chg->vbus_sense_work,
+					   pf1550_chg_vbus_work);
+	if (ret)
+		return dev_err_probe(chg->dev, ret,
+				     "failed to add vbus sense work\n");
+
+	ret = devm_delayed_work_autocancel(chg->dev, &chg->chg_sense_work,
+					   pf1550_chg_chg_work);
+	if (ret)
+		return dev_err_probe(chg->dev, ret,
+				     "failed to add charger sense work\n");
+
+	ret = devm_delayed_work_autocancel(chg->dev, &chg->bat_sense_work,
+					   pf1550_chg_bat_work);
+	if (ret)
+		return dev_err_probe(chg->dev, ret,
+				     "failed to add battery sense work\n");
+
+	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		chg->virqs[i] = irq;
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
+	chg->charger = devm_power_supply_register(&pdev->dev,
+						  &pf1550_charger_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->charger))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
+				     "failed: power supply register\n");
+
+	chg->battery = devm_power_supply_register(&pdev->dev,
+						  &pf1550_battery_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->battery))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
+				     "failed: power supply register\n");
+
+	pf1550_dt_parse_dev_info(chg);
+
+	return pf1550_reg_init(chg);
+}
+
+static const struct platform_device_id pf1550_charger_id[] = {
+	{ "pf1550-charger", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
+
+static struct platform_driver pf1550_charger_driver = {
+	.driver = {
+		.name	= "pf1550-charger",
+	},
+	.probe		= pf1550_charger_probe,
+	.id_table	= pf1550_charger_id,
+};
+module_platform_driver(pf1550_charger_driver);
+
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_DESCRIPTION("PF1550 charger driver");
+MODULE_LICENSE("GPL");

-- 
2.50.1



