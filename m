Return-Path: <linux-pm+bounces-28413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52052AD4336
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A43D3A47CE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE16266568;
	Tue, 10 Jun 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff8C/7se"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67E265CB0;
	Tue, 10 Jun 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584887; cv=none; b=pWtisnTIWX6+5L/M20F/1RgDRtNF3Z8rMSS85ln9iDj6W5jxjJXxA8tQ0ONFolMOA9cI3eTCAg8l0GRHx+cXPlaUmy7Gi9qw7gg3TFFn8aGTAPMgGqY7Yn/NCaoEQ/dVvfMv4cEYAit0YFU1VkppVvrlx4d96Q/iIUzP0bjNnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584887; c=relaxed/simple;
	bh=IOmJ6VisGMOlau6+bJZgnxzZbor6ZhygdvH4yUx8Bx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACDkMpITsouF3HYUzzCqd6LfBujewiw7W4RP95X37GX1njM9xg7qHoM5YT++yGscPrj5hu7kXewxEdECiigf2NoH5SGD0n3Pnvv9z5h8IOmCgRBt9uDIbvIOLZncdPbpstE7isT7sPxeaUkg+KpzjGtGOtaxcrjDrIBEKhfo/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff8C/7se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD427C4AF13;
	Tue, 10 Jun 2025 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749584886;
	bh=IOmJ6VisGMOlau6+bJZgnxzZbor6ZhygdvH4yUx8Bx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ff8C/7ses5U4kuzWIlbf34v+PhjmG2k25n8uLeREgWoQPuPDgyBPI5deQeDN5/7Gu
	 joDTrQ2aH3BWEoh9GNXmtfkNzzKnxZwwa2QherBo4XtU/yw9zOCBSf8vSS+9shHiWB
	 Da10sqLAIpnCIPp21pk9ueogq0VVC++AfPwJSptEQfx4mb3/rfXnbR1hP9oYAwOiAz
	 Ti3QpGuK41SJwpQT9OKWgOkX8RRpxf8SM/5wJau2+WsksZi9eKchgK+H2aiZKhvM/3
	 SNXbYT7Z8lQ3jfplu070W6auzAtjRd32fYQ0ewjx24nuFONHACVo7eunzJDnbF9xHN
	 +dq4intVE+l6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C1C61DB2;
	Tue, 10 Jun 2025 19:48:06 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 10 Jun 2025 15:47:33 -0400
Subject: [PATCH v5 5/6] power: supply: pf1550: add battery charger support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-pf1550-v5-5-ed0d9e3aaac7@savoirfairelinux.com>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
In-Reply-To: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
 Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749584885; l=19928;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=/PicyJH+vtPVprLLCTW+FKVDhhpiu+Q09anuwG9C5KE=;
 b=oE8XTEaiQfkis5cPQla24i7sLcbHP3an4Vk+/Na9R6cfyvP2wChjaFqPzPu69xb4JK4SyMrIr
 pfa6UMora+vAEKi17RSjmXH3Hts6JFAT8vbWmm8vqxETqpy/Vl++Uo6
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
 drivers/power/supply/pf1550-charger.c | 645 ++++++++++++++++++++++++++++++++++
 3 files changed, 657 insertions(+)

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
index 0000000000000000000000000000000000000000..04da5bd115657980c8eac462a9c33a42f6b94be7
--- /dev/null
+++ b/drivers/power/supply/pf1550-charger.c
@@ -0,0 +1,645 @@
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
+	mutex_lock(&chg->mutex);
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
+	mutex_unlock(&chg->mutex);
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
+	if (data & PF1550_VBUS_VALID) {
+		mutex_lock(&chg->mutex);
+		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+		mutex_unlock(&chg->mutex);
+	}
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
+	struct pf1550_charger *chg;
+	struct power_supply_config psy_cfg = {};
+	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
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
+	mutex_init(&chg->mutex);
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
+	ret = pf1550_reg_init(chg);
+
+	return ret;
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



