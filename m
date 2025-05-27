Return-Path: <linux-pm+bounces-27705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F300FAC5D20
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7C13B16A7
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 22:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDE21A43B;
	Tue, 27 May 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1augIJ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9C218AD2;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384785; cv=none; b=PGijxTWUbUP1H3DRjiMH8Qcs55qmYWdbBT7j93qC98vK/clVuN+woXleEO3+vsKDDAqBP4GKKvxPjfk/in1oyVKpv3fIaTneefnYmMpUJwjASvLoYCEAcljdPYNHRGejMn7/N+qUrc4TKz60NhhGyiX5Oo0HI7IvGC7AO446paU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384785; c=relaxed/simple;
	bh=Eux9xrBUXlNsVUmBgroNk8YVwBcjHrhqiMJGrjkR+Eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5OuPuPPZ2S0907lYve622do5YYzhy6gyYhSslUZUpH1ROxGvuHbzAhBghVbYwKcKTo20nxlLGbsBei4HUef+AHG3eWPIRtDtpXwgSfJunp49aHERKk4u6kTQN9K0SFyaKiZaqB+ojJEzH3QMaqiE5r6noQgEmzKzIJgLOAKgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1augIJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AC43C4CEF6;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384785;
	bh=Eux9xrBUXlNsVUmBgroNk8YVwBcjHrhqiMJGrjkR+Eg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R1augIJ0GkGF6i1RiwXqtPPmcsrDrH/wg2hRJ3Sn3UUq8skY1LqSAFDwYpN35VQc7
	 t6FRoTwJjI38Sr43bI0wCjuBsfZB0Vl+731yxsDaoyT7IQB1EItsW5hj/G5c/TAoW6
	 oAGwqr7K1ca9yKV5OziVzz6OkIc7EcZdG1n/NlpFzWNLGxxzO+wNotFshNHLsZ8GZa
	 ZU0FpJoM9WkPUlJGimQdAse7x1LwNm7L9IqgXTGac0EFXXcdgVVS4pgO7I504oS8nK
	 DMNCVmHAv4ZwvEnyGlsExZ8vQRLB3TIKsr9galrVlv0cJpXMLUjtdRMI+N6JThKrsm
	 82PfJHIu48bLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F290AC5B54E;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 27 May 2025 18:25:37 -0400
Subject: [PATCH v3 5/6] power: supply: pf1550: add battery charger support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pf1550-v3-5-45f69453cd51@savoirfairelinux.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748384783; l=19262;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=k/4Ly5H3ZRPVpfqWACRQHqDlpoKzXxlNvJysLFqCHnU=;
 b=R2wAriOOhsMfHVj4I6Cwxelggfp6AGT52e3Ou9qFBqvl3uyRuTEfIjijQLIM2u1nRCRP4dlg7
 WdoUOAGLAY+CiO+GRtPogq+8+PolFZsngNKWUSwuDDWw2Ywd1+DMWng
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
v3:
- Use struct power_supply_get_battery_info to get constant charge
  voltage if specified
- Use virqs mapped in MFD driver
v2:
- Address feedback from Enric Balletbo Serra
---
 drivers/power/supply/Kconfig          |  11 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/pf1550-charger.c | 639 ++++++++++++++++++++++++++++++++++
 3 files changed, 651 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 8dbd39afa43cba67cddb0e8ca62e6e44d4864434..c262452dcecda5e1708bcc1290f67ca5dd19628a 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -449,6 +449,17 @@ config CHARGER_88PM860X
 	help
 	  Say Y here to enable charger for Marvell 88PM860x chip.
 
+config CHARGER_PF1550
+	tristate "Freescale PF1550 battery charger driver"
+	depends on MFD_PF1550
+	help
+	  Say Y to enable support for the Freescale PF1550 battery charger.
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
index 61677be328b0cb1d31440a54b06e201dadfcda7b..6c6f1535bea7aeb7db159a268ff088e24ec617c4 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_CHARGER_RT9467)	+= rt9467-charger.o
 obj-$(CONFIG_CHARGER_RT9471)	+= rt9471.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
+obj-$(CONFIG_CHARGER_PF1550)	+= pf1550-charger.o
 obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
 obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o ab8500_chargalg.o
 obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
new file mode 100644
index 0000000000000000000000000000000000000000..2827b0321e266370aaa37ee697d45eeb63428c3f
--- /dev/null
+++ b/drivers/power/supply/pf1550-charger.c
@@ -0,0 +1,639 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pf1550_charger.c - regulator driver for the PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ */
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
+static const char *pf1550_charger_manufacturer	= "Freescale";
+
+struct pf1550_charger {
+	struct device *dev;
+	struct pf1550_dev *pf1550;
+	struct power_supply *charger;
+	struct power_supply_desc psy_desc;
+	int irq;
+	struct delayed_work irq_work;
+	struct mutex mutex;
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
+static void pf1550_chg_bat_isr(struct pf1550_charger *chg)
+{
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
+static void pf1550_chg_chg_isr(struct pf1550_charger *chg)
+{
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
+static void pf1550_chg_vbus_isr(struct pf1550_charger *chg)
+{
+	enum power_supply_type old_type;
+	unsigned int data;
+
+	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data)) {
+		dev_err(chg->dev, "Read VBUS_SNS error.\n");
+		return;
+	}
+
+	old_type = chg->psy_desc.type;
+
+	if (data & PF1550_VBUS_UVLO) {
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+		dev_dbg(chg->dev, "VBUS deattached.\n");
+	}
+	if (data & PF1550_VBUS_IN2SYS)
+		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
+	if (data & PF1550_VBUS_OVLO)
+		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
+	if (data & PF1550_VBUS_VALID) {
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+		dev_dbg(chg->dev, "VBUS attached.\n");
+	}
+
+	if (old_type != chg->psy_desc.type)
+		power_supply_changed(chg->charger);
+}
+
+static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
+{
+	struct pf1550_charger *chg = data;
+
+	chg->irq = irq;
+
+	schedule_delayed_work(&chg->irq_work,  msecs_to_jiffies(10));
+
+	return IRQ_HANDLED;
+}
+
+static void pf1550_charger_irq_work(struct work_struct *work)
+{
+	struct pf1550_charger *chg = container_of(to_delayed_work(work),
+						  struct pf1550_charger,
+						  irq_work);
+	struct irq_domain *domain;
+	int i, irq_type = -1;
+	unsigned int virq;
+	unsigned int status;
+
+	if (!chg->charger)
+		return;
+
+	domain = regmap_irq_get_domain(chg->pf1550->irq_data_charger);
+	if (!domain)
+		return;
+
+	mutex_lock(&chg->mutex);
+
+	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
+		virq = irq_find_mapping(domain, i);
+		if (chg->irq == virq)
+			irq_type = i;
+	}
+
+	switch (irq_type) {
+	case PF1550_CHARG_IRQ_BAT2SOCI:
+		dev_info(chg->dev, "BAT to SYS Overcurrent interrupt.\n");
+		break;
+	case PF1550_CHARG_IRQ_BATI:
+		pf1550_chg_bat_isr(chg);
+		break;
+	case PF1550_CHARG_IRQ_CHGI:
+		pf1550_chg_chg_isr(chg);
+		break;
+	case PF1550_CHARG_IRQ_VBUSI:
+		pf1550_chg_vbus_isr(chg);
+		break;
+	case PF1550_CHARG_IRQ_THMI:
+		dev_info(chg->dev, "Thermal interrupt.\n");
+		break;
+	default:
+		dev_err(chg->dev, "unknown interrupt occurred.\n");
+	}
+
+	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT, &status))
+		dev_err(chg->dev, "Read CHG_INT error.\n");
+	if (regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT, status))
+		dev_err(chg->dev, "clear CHG_INT error.\n");
+
+	mutex_unlock(&chg->mutex);
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
+			    union power_supply_propval *val)
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
+					      unsigned int cels)
+{
+	unsigned int data;
+
+	switch (cels) {
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
+		cels, data);
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
+	power_supply_get_battery_info(chg->charger, &info);
+
+	if (!info || !info->constant_charge_voltage_max_uv)
+		chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
+
+	if (device_property_read_u32(dev->parent, "fsl,min-system-microvolt",
+				     &chg->min_system_volt))
+		chg->min_system_volt = PF1550_DEFAULT_MIN_SYSTEM_VOLT;
+
+	if (device_property_read_u32(dev->parent, "fsl,thermal-regulation",
+				     &chg->thermal_regulation_temp))
+		chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;
+}
+
+static int pf1550_charger_probe(struct platform_device *pdev)
+{
+	struct pf1550_charger *chg;
+	struct power_supply_config psy_cfg = {};
+	struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
+	struct irq_domain *domain;
+	int i, ret;
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
+	mutex_init(&chg->mutex);
+
+	INIT_DELAYED_WORK(&chg->irq_work, pf1550_charger_irq_work);
+
+	domain = regmap_irq_get_domain(pf1550->irq_data_charger);
+
+	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
+		unsigned int virq = irq_find_mapping(domain, i);
+
+		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
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
+	ret = pf1550_reg_init(chg);
+
+	return ret;
+}
+
+static void pf1550_charger_remove(struct platform_device *pdev)
+{
+	struct pf1550_charger *chg = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&chg->irq_work);
+}
+
+static const struct platform_device_id pf1550_charger_id[] = {
+	{ "pf1550-charger", PF1550 },
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



