Return-Path: <linux-pm+bounces-39692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A7CCDDD7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 23:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A06B302EFF4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907432E14D;
	Thu, 18 Dec 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF45sXpm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E368264628;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766098183; cv=none; b=K6A1UNJbxaM3t7DBZj4ROOr8lG6VFymFGYQfy+cTiocaDSwKwdkRNyhU6/LBATemrN2stXhiJVNjwVERJIzAiQGYVMro/8fcoKo8Qb+SkVG4F5axuN9rK0Zddosg1kbKfiGQUq9kW6u0IIkrgk77IDPrVlnPT0KNrg1DZZd3LsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766098183; c=relaxed/simple;
	bh=Q3E7qQjuyf/D65scpH+c9n3MB+TSVpuWipvWt75BLnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aeOH8Kq0YcwX2NINsbcgcmXu8Fs0V65Yv+g0P/wPrPVmiK8QcjzVcFKnBmwg7HeyhVt6++yjIhBhwAEj3nZ8j/3Dprj+o+W3cQzKWyuCnf6ui+vf/dFUN/NLKxra3DYjyxZlTD8yvQ5Ko0R4PwAAlaxFk13XEJSYIw8lolLewQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF45sXpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA4C8C2BC9E;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766098182;
	bh=Q3E7qQjuyf/D65scpH+c9n3MB+TSVpuWipvWt75BLnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vF45sXpmESRHo4QxrS/hLo5BLixD4VfaaYG85s5pS34P6b5VCjFzga2AXwI551i59
	 PURsm0Gjfyl6Jkz65XUdsZHmOSY+DwgtVBMjB7wO2EW5sGKj/aSGnT4DEjTYVNkoOn
	 Uj9mYwIg3MjSi/YuswtaW1QskPe88wOZZ/kFbb4Wh5bxEl28EncGoicO/3zeMFu/OO
	 yELDqLrUeTgc48FFPjYHBGd5L3JRuVtDdV8QgStPmR6s4igD58Ebk8L1JOH483oiqn
	 aBddEDFrK/d0waohUPxyp87Secwj1LT3ME2N+MZLKdriKInKRqLMVCiSFnzE7Ca493
	 dFtWoTA93pXWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20C2D711CD;
	Thu, 18 Dec 2025 22:49:42 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 18 Dec 2025 22:49:09 +0000
Subject: [PATCH v2 4/5] power: supply: max77759: add charger driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-max77759-charger-v2-4-2b259980a686@google.com>
References: <20251218-max77759-charger-v2-0-2b259980a686@google.com>
In-Reply-To: <20251218-max77759-charger-v2-0-2b259980a686@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766098181; l=24656;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=JR+eObB1l/H0icAKEk4W7EddqNkdJ8OJnbYmpZncZS8=;
 b=iAMK5Dhx17wBQqN0GPdE+cZcrB2+IrM1l3ZkcQgZTdtWNQa4oHrBuYI9FRnfI2Z3s6jtfHplO
 Ms0N4sATWI5C9kDAYHWNupe1m47FkXImd21tDyQKo5m8hXi8YlaLXJe
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add support for MAX77759 battery charger driver. This is a 4A 1-Cell
Li+/LiPoly dual input switch mode charger. While the device can support
USB & wireless charger inputs, this implementation only supports USB
input. This implementation supports both buck and boost modes.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 MAINTAINERS                             |   7 +
 drivers/mfd/max77759.c                  |   3 +-
 drivers/power/supply/Kconfig            |  11 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max77759_charger.c | 754 ++++++++++++++++++++++++++++++++
 5 files changed, 775 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..f1b1015c08b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15053,6 +15053,13 @@ F:	drivers/mfd/max77759.c
 F:	drivers/nvmem/max77759-nvmem.c
 F:	include/linux/mfd/max77759.h
 
+MAXIM MAX77759 BATTERY CHARGER DRIVER
+M:	Amit Sunil Dhamne <amitsd@google.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
+F:	drivers/power/supply/max77759_charger.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/mfd/max77759.c b/drivers/mfd/max77759.c
index a5f7da003edd..368266e2c7f3 100644
--- a/drivers/mfd/max77759.c
+++ b/drivers/mfd/max77759.c
@@ -415,7 +415,8 @@ static const struct mfd_cell max77759_maxq_cells[] = {
 };
 
 static const struct mfd_cell max77759_charger_cells[] = {
-	MFD_CELL_RES("max77759-charger", max77759_charger_resources),
+	MFD_CELL_OF("max77759-charger", max77759_charger_resources, NULL, 0, 0,
+		    "maxim,max77759-charger"),
 };
 
 int max77759_maxq_command(struct max77759 *max77759,
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 79ddb006e2da..4d8685fa3adb 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -1074,4 +1074,15 @@ config FUEL_GAUGE_MM8013
 	  the state of charge, temperature, cycle count, actual and design
 	  capacity, etc.
 
+config CHARGER_MAX77759
+	tristate "MAX77759 Charger Driver"
+	depends on MFD_MAX77759 && REGULATOR
+	default MFD_MAX77759
+	help
+	  Say M or Y here to enable the MAX77759 Charger Driver. MAX77759
+	  charger is a function of the MAX77759 PMIC. This is a dual input
+	  switch-mode charger. This driver supports buck and OTG boost modes.
+
+	  If built as a module, it will be called max77759_charger.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f943c9150b32..12669734cfe3 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -122,3 +122,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
+obj-$(CONFIG_CHARGER_MAX77759)	+= max77759_charger.o
diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
new file mode 100644
index 000000000000..d1b82578aeb9
--- /dev/null
+++ b/drivers/power/supply/max77759_charger.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * max77759_charger.c - Battery charger driver for MAX77759 charger device.
+ *
+ * Copyright 2025 Google LLC.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/devm-helpers.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/math64.h>
+#include <linux/mfd/max77759.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/string_choices.h>
+
+/* Default values for Fast Charge Current & Float Voltage */
+#define CHG_CC_DEFAULT_UA			2266770
+#define CHG_FV_DEFAULT_MV			4300
+
+#define FOREACH_IRQ(S)			\
+	S(AICL),			\
+	S(CHGIN),			\
+	S(CHG),				\
+	S(INLIM),			\
+	S(BAT_OILO),			\
+	S(CHG_STA_CC),			\
+	S(CHG_STA_CV),			\
+	S(CHG_STA_TO),			\
+	S(CHG_STA_DONE)
+
+#define GENERATE_ENUM(e)		e
+#define GENERATE_STRING(s)		#s
+
+enum {
+	FOREACH_IRQ(GENERATE_ENUM)
+};
+
+static const char *const chgr_irqs_str[] = {
+	FOREACH_IRQ(GENERATE_STRING)
+};
+
+static int irqs[ARRAY_SIZE(chgr_irqs_str)];
+
+struct max77759_charger {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy;
+	struct regulator_dev *chgin_otg_rdev;
+	struct notifier_block nb;
+	struct power_supply *tcpm_psy;
+	struct work_struct psy_work;
+	struct mutex lock; /* protects the state below */
+	enum max77759_chgr_mode mode;
+};
+
+static inline int regval_to_val(int reg, int reg_offset, int step, int minval)
+{
+	return ((reg - reg_offset) * step) + minval;
+}
+
+static inline int val_to_regval(int val, int minval, int step, int reg_offset)
+{
+	s64 dividend;
+
+	if (unlikely(step == 0))
+		return reg_offset;
+
+	dividend = (s64)val - minval;
+	return DIV_S64_ROUND_CLOSEST(dividend, step) + reg_offset;
+}
+
+static inline int unlock_prot_regs(struct max77759_charger *chg, bool unlock)
+{
+	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_06,
+				  MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT, unlock
+				  ? MAX77759_CHGR_REG_CHG_CNFG_06_CHGPROT : 0);
+}
+
+static int charger_input_valid(struct max77759_charger *chg)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &val);
+	if (ret)
+		return ret;
+
+	return (val & MAX77759_CHGR_REG_CHG_INT_CHG) &&
+		(val & MAX77759_CHGR_REG_CHG_INT_CHGIN);
+}
+
+static int get_online(struct max77759_charger *chg)
+{
+	u32 val;
+	int ret;
+
+	ret = charger_input_valid(chg);
+	if (ret <= 0)
+		return ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_02, &val);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&chg->lock);
+	return (val & MAX77759_CHGR_REG_CHG_DETAILS_02_CHGIN_STS) &&
+		(chg->mode == MAX77759_CHGR_MODE_CHG_BUCK_ON);
+}
+
+static int get_status(struct max77759_charger *chg)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS, val)) {
+	case MAX77759_CHGR_CHG_DTLS_PREQUAL:
+	case MAX77759_CHGR_CHG_DTLS_CC:
+	case MAX77759_CHGR_CHG_DTLS_CV:
+	case MAX77759_CHGR_CHG_DTLS_TO:
+		return POWER_SUPPLY_STATUS_CHARGING;
+	case MAX77759_CHGR_CHG_DTLS_DONE:
+		return POWER_SUPPLY_STATUS_FULL;
+	case MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:
+	case MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
+	case MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
+	case MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	case MAX77759_CHGR_CHG_DTLS_OFF:
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+	default:
+		break;
+	}
+
+	return POWER_SUPPLY_STATUS_UNKNOWN;
+}
+
+static int get_charge_type(struct max77759_charger *chg)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_CHG_DTLS, val)) {
+	case MAX77759_CHGR_CHG_DTLS_PREQUAL:
+		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+	case MAX77759_CHGR_CHG_DTLS_CC:
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
+	case MAX77759_CHGR_CHG_DTLS_CV:
+	case MAX77759_CHGR_CHG_DTLS_TO:
+		return POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+	case MAX77759_CHGR_CHG_DTLS_DONE:
+	case MAX77759_CHGR_CHG_DTLS_TIMER_FAULT:
+	case MAX77759_CHGR_CHG_DTLS_SUSP_BATT_THM:
+	case MAX77759_CHGR_CHG_DTLS_OFF_WDOG_TIMER:
+	case MAX77759_CHGR_CHG_DTLS_SUSP_JEITA:
+	case MAX77759_CHGR_CHG_DTLS_OFF:
+		return POWER_SUPPLY_CHARGE_TYPE_NONE;
+	default:
+		break;
+	}
+
+	return POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+}
+
+static int get_chg_health(struct max77759_charger *chg)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_00, &val);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_OO_CHGIN_DTLS, val)) {
+	case MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
+	case MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE:
+		return POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
+	case MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE:
+		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	case MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID:
+		return POWER_SUPPLY_HEALTH_GOOD;
+	default:
+		break;
+	}
+
+	return POWER_SUPPLY_HEALTH_UNKNOWN;
+}
+
+static int get_batt_health(struct max77759_charger *chg)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_DETAILS_01, &val);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(MAX77759_CHGR_REG_CHG_DETAILS_01_BAT_DTLS, val)) {
+	case MAX77759_CHGR_BAT_DTLS_NO_BATT_CHG_SUSP:
+		return POWER_SUPPLY_HEALTH_NO_BATTERY;
+	case MAX77759_CHGR_BAT_DTLS_DEAD_BATTERY:
+		return POWER_SUPPLY_HEALTH_DEAD;
+	case MAX77759_CHGR_BAT_DTLS_BAT_CHG_TIMER_FAULT:
+		return POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+	case MAX77759_CHGR_BAT_DTLS_BAT_OKAY:
+	case MAX77759_CHGR_BAT_DTLS_BAT_ONLY_MODE:
+		return POWER_SUPPLY_HEALTH_GOOD;
+	case MAX77759_CHGR_BAT_DTLS_BAT_UNDERVOLTAGE:
+		return POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
+	case MAX77759_CHGR_BAT_DTLS_BAT_OVERVOLTAGE:
+		return POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	case MAX77759_CHGR_BAT_DTLS_BAT_OVERCURRENT:
+		return POWER_SUPPLY_HEALTH_OVERCURRENT;
+	default:
+		break;
+	}
+
+	return POWER_SUPPLY_HEALTH_UNKNOWN;
+}
+
+static int get_health(struct max77759_charger *chg)
+{
+	int ret;
+
+	ret = get_online(chg);
+	if (ret < 0)
+		return ret;
+
+	if (ret) {
+		ret = get_chg_health(chg);
+		if (ret < 0 || ret != POWER_SUPPLY_HEALTH_GOOD)
+			return ret;
+	}
+
+	return get_batt_health(chg);
+}
+
+static int get_fast_charge_current(struct max77759_charger *chg)
+{
+	u32 regval;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_02, &regval);
+	if (ret)
+		return ret;
+
+	ret = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
+	if (ret <= MAX77759_CHGR_CHGCC_REG_OFFSET)
+		return MAX77759_CHGR_CHGCC_MIN_UA;
+
+	return regval_to_val(ret, MAX77759_CHGR_CHGCC_REG_OFFSET,
+			     MAX77759_CHGR_CHGCC_STEP_UA,
+			     MAX77759_CHGR_CHGCC_MIN_UA);
+}
+
+static int set_fast_charge_current_limit(struct max77759_charger *chg,
+					 u32 cc_max_ua)
+{
+	u32 val;
+
+	if (cc_max_ua < MAX77759_CHGR_CHGCC_MIN_UA ||
+	    cc_max_ua > MAX77759_CHGR_CHGCC_MAX_UA)
+		return -EINVAL;
+
+	val = val_to_regval(cc_max_ua, MAX77759_CHGR_CHGCC_MIN_UA,
+			    MAX77759_CHGR_CHGCC_STEP_UA,
+			    MAX77759_CHGR_CHGCC_REG_OFFSET);
+	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_02,
+				  MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, val);
+}
+
+static int get_float_voltage(struct max77759_charger *chg)
+{
+	u32 regval;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_04, &regval);
+	if (ret)
+		return ret;
+
+	ret = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM, regval);
+	switch (ret) {
+	case MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG ... MAX77759_CHGR_CHG_CV_PRM_HI_MAX_REG:
+		return regval_to_val(ret, MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG,
+				     MAX77759_CHGR_CHG_CV_PRM_HI_STEP_MV,
+				     MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV);
+	case MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG ... MAX77759_CHGR_CHG_CV_PRM_LO_MAX_REG:
+		return regval_to_val(ret, MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG,
+				     MAX77759_CHGR_CHG_CV_PRM_LO_STEP_MV,
+				     MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int set_float_voltage_limit(struct max77759_charger *chg, u32 fv_mv)
+{
+	u32 regval;
+
+	if (fv_mv >= MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV &&
+	    fv_mv <= MAX77759_CHGR_CHG_CV_PRM_LO_MAX_MV) {
+		regval = val_to_regval(fv_mv,
+				       MAX77759_CHGR_CHG_CV_PRM_LO_MIN_MV,
+				       MAX77759_CHGR_CHG_CV_PRM_LO_STEP_MV,
+				       MAX77759_CHGR_CHG_CV_PRM_LO_MIN_REG);
+	} else if (fv_mv >= MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV &&
+		   fv_mv <= MAX77759_CHGR_CHG_CV_PRM_HI_MAX_MV) {
+		regval = val_to_regval(fv_mv,
+				       MAX77759_CHGR_CHG_CV_PRM_HI_MIN_MV,
+				       MAX77759_CHGR_CHG_CV_PRM_HI_STEP_MV,
+				       MAX77759_CHGR_CHG_CV_PRM_HI_MIN_REG);
+	} else {
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_04,
+				  MAX77759_CHGR_REG_CHG_CNFG_04_CHG_CV_PRM,
+				  regval);
+}
+
+static int get_input_current_limit(struct max77759_charger *chg)
+{
+	u32 regval;
+	int ret;
+
+	ret = regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09, &regval);
+	if (ret)
+		return ret;
+
+	ret = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM, regval);
+	if (ret <= MAX77759_CHGR_CHGIN_ILIM_REG_OFFSET)
+		return MAX77759_CHGR_CHGIN_ILIM_MIN_UA;
+
+	return regval_to_val(ret, MAX77759_CHGR_CHGIN_ILIM_REG_OFFSET,
+			     MAX77759_CHGR_CHGIN_ILIM_STEP_UA,
+			     MAX77759_CHGR_CHGIN_ILIM_MIN_UA);
+}
+
+static int set_input_current_limit(struct max77759_charger *chg, int ilim_ua)
+{
+	u32 regval;
+
+	if (ilim_ua < 0)
+		return -EINVAL;
+
+	if (ilim_ua == 0)
+		ilim_ua = MAX77759_CHGR_CHGIN_ILIM_MIN_UA;
+	else if (ilim_ua > MAX77759_CHGR_CHGIN_ILIM_MAX_UA)
+		ilim_ua = MAX77759_CHGR_CHGIN_ILIM_MAX_UA;
+
+	regval = val_to_regval(ilim_ua, MAX77759_CHGR_CHGIN_ILIM_MIN_UA,
+			       MAX77759_CHGR_CHGIN_ILIM_STEP_UA,
+			       MAX77759_CHGR_CHGIN_ILIM_REG_OFFSET);
+	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09,
+				  MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
+				  regval);
+}
+
+static const enum power_supply_property max77759_charger_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
+static int max77759_charger_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *pval)
+{
+	struct max77759_charger *chg = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = get_online(chg);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = charger_input_valid(chg);
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = get_status(chg);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = get_charge_type(chg);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = get_health(chg);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		ret = get_fast_charge_current(chg);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		ret = get_float_voltage(chg);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = get_input_current_limit(chg);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	pval->intval = ret;
+	return ret < 0 ? ret : 0;
+}
+
+static const struct power_supply_desc max77759_charger_desc = {
+	.name = "max77759-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = max77759_charger_props,
+	.num_properties = ARRAY_SIZE(max77759_charger_props),
+	.get_property = max77759_charger_get_property,
+};
+
+static int charger_set_mode(struct max77759_charger *chg,
+			    enum max77759_chgr_mode mode)
+{
+	int ret;
+
+	guard(mutex)(&chg->lock);
+
+	if (chg->mode == mode)
+		return 0;
+
+	if ((mode == MAX77759_CHGR_MODE_CHG_BUCK_ON ||
+	     mode == MAX77759_CHGR_MODE_OTG_BOOST_ON) &&
+	    chg->mode != MAX77759_CHGR_MODE_OFF) {
+		dev_err(chg->dev, "Invalid mode transition from %d to %d",
+			chg->mode, mode);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00,
+				 MAX77759_CHGR_REG_CHG_CNFG_00_MODE, mode);
+	if (ret)
+		return ret;
+
+	chg->mode = mode;
+	return 0;
+}
+
+static int enable_chgin_otg(struct regulator_dev *rdev)
+{
+	struct max77759_charger *chg = rdev_get_drvdata(rdev);
+
+	return charger_set_mode(chg, MAX77759_CHGR_MODE_OTG_BOOST_ON);
+}
+
+static int disable_chgin_otg(struct regulator_dev *rdev)
+{
+	struct max77759_charger *chg = rdev_get_drvdata(rdev);
+
+	return charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+}
+
+static int chgin_otg_status(struct regulator_dev *rdev)
+{
+	struct max77759_charger *chg = rdev_get_drvdata(rdev);
+
+	guard(mutex)(&chg->lock);
+	return chg->mode == MAX77759_CHGR_MODE_OTG_BOOST_ON;
+}
+
+static const struct regulator_ops chgin_otg_reg_ops = {
+	.enable = enable_chgin_otg,
+	.disable = disable_chgin_otg,
+	.is_enabled = chgin_otg_status,
+};
+
+static const struct regulator_desc chgin_otg_reg_desc = {
+	.name = "chgin-otg",
+	.of_match = of_match_ptr("chgin-otg-regulator"),
+	.owner = THIS_MODULE,
+	.ops = &chgin_otg_reg_ops,
+	.fixed_uV = 5000000,
+	.n_voltages = 1,
+};
+
+static irqreturn_t irq_handler(int irq, void *data)
+{
+	struct max77759_charger *chg = data;
+	struct device *dev = chg->dev;
+	u32 chgint_ok;
+	int i;
+
+	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_INT_OK, &chgint_ok);
+
+	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
+		if (irqs[i] == irq)
+			break;
+	}
+
+	switch (i) {
+	case AICL:
+		dev_dbg(dev, "AICL mode: %s",
+			str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_AICL));
+		break;
+	case CHGIN:
+		dev_dbg(dev, "CHGIN input valid: %s",
+			str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHGIN));
+		break;
+	case CHG:
+		dev_dbg(dev, "CHG status okay/off: %s",
+			str_yes_no(chgint_ok & MAX77759_CHGR_REG_CHG_INT_CHG));
+		break;
+	case INLIM:
+		dev_dbg(dev, "Current Limit reached: %s",
+			str_no_yes(chgint_ok & MAX77759_CHGR_REG_CHG_INT_INLIM));
+		break;
+	case BAT_OILO:
+		dev_dbg(dev, "Battery over-current threshold crossed");
+		break;
+	case CHG_STA_CC:
+		dev_dbg(dev, "Charger reached CC stage");
+		break;
+	case CHG_STA_CV:
+		dev_dbg(dev, "Charger reached CV stage");
+		break;
+	case CHG_STA_TO:
+		dev_dbg(dev, "Charger reached TO stage");
+		break;
+	case CHG_STA_DONE:
+		dev_dbg(dev, "Charger reached TO stage");
+		break;
+	default:
+		dev_err(dev, "Unrecognized irq: %d", i);
+		return IRQ_HANDLED;
+	}
+
+	power_supply_changed(chg->psy);
+	return IRQ_HANDLED;
+}
+
+static int max77759_init_irqhandler(struct max77759_charger *chg)
+{
+	struct device *dev = chg->dev;
+	struct irq_data *irqd;
+	unsigned long irq_flags;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(chgr_irqs_str); i++) {
+		ret = platform_get_irq_byname(to_platform_device(dev),
+					      chgr_irqs_str[i]);
+		if (ret < 0) {
+			dev_err(dev,
+				"Failed to get irq resource for %s, ret=%d",
+				chgr_irqs_str[i], ret);
+			return ret;
+		}
+
+		irqs[i] = ret;
+		irq_flags = IRQF_ONESHOT;
+		irqd = irq_get_irq_data(irqs[i]);
+		if (irqd)
+			irq_flags |= irqd_get_trigger_type(irqd);
+
+		ret = devm_request_threaded_irq(dev, irqs[i], NULL, irq_handler,
+						irq_flags, dev_name(dev), chg);
+		if (ret) {
+			dev_err(dev,
+				"Unable to register irq handler for %s, ret=%d",
+				chgr_irqs_str[i], ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int max77759_charger_init(struct max77759_charger *chg)
+{
+	int ret;
+	u32 regval;
+
+	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval);
+	chg->mode = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
+	ret = charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+	if (ret)
+		return ret;
+
+	ret = set_fast_charge_current_limit(chg, CHG_CC_DEFAULT_UA);
+	if (ret)
+		return ret;
+
+	ret = set_float_voltage_limit(chg, CHG_FV_DEFAULT_MV);
+	if (ret)
+		return ret;
+
+	ret = unlock_prot_regs(chg, true);
+	if (ret)
+		return ret;
+
+	/* Disable wireless charging input */
+	regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_12,
+			   MAX77759_CHGR_REG_CHG_CNFG_12_WCINSEL, 0);
+
+	regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_18,
+			   MAX77759_CHGR_REG_CHG_CNFG_18_WDTEN, 0);
+
+	return unlock_prot_regs(chg, false);
+}
+
+static void psy_work_item(struct work_struct *work)
+{
+	struct max77759_charger *chg =
+		container_of(work, struct max77759_charger, psy_work);
+	union power_supply_propval current_limit = { 0 }, online = { 0 };
+	int ret;
+
+	power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_CURRENT_MAX,
+				  &current_limit);
+	power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLINE,
+				  &online);
+
+	if (online.intval && current_limit.intval) {
+		ret = set_input_current_limit(chg, current_limit.intval);
+		if (ret)
+			dev_err(chg->dev,
+				"Unable to set current limit, ret=%d", ret);
+
+		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
+	} else {
+		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+	}
+}
+
+static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
+{
+	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
+						    nb);
+	const char *psy_name = "tcpm-source";
+	struct power_supply *psy = data;
+
+	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
+	    evt != PSY_EVENT_PROP_CHANGED)
+		return NOTIFY_OK;
+
+	chg->tcpm_psy = psy;
+	schedule_work(&chg->psy_work);
+	return NOTIFY_OK;
+}
+
+static void max_tcpci_unregister_psy_notifier(void *nb)
+{
+	power_supply_unreg_notifier(nb);
+}
+
+static int max77759_charger_probe(struct platform_device *pdev)
+{
+	struct regulator_config chgin_otg_reg_cfg;
+	struct power_supply_config psy_cfg;
+	struct device *dev = &pdev->dev;
+	struct max77759_charger *chg;
+	int ret;
+
+	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
+	if (!chg)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, chg);
+	chg->dev = dev;
+	chg->regmap = dev_get_regmap(dev->parent, "charger");
+	if (!chg->regmap)
+		return dev_err_probe(dev, -ENODEV, "Missing regmap");
+
+	ret = devm_mutex_init(dev, &chg->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize lock");
+
+	ret = max77759_charger_init(chg);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize max77759 charger");
+
+	chgin_otg_reg_cfg.dev = dev;
+	chgin_otg_reg_cfg.driver_data = chg;
+	chgin_otg_reg_cfg.of_node = dev_of_node(dev);
+	chg->chgin_otg_rdev = devm_regulator_register(dev, &chgin_otg_reg_desc,
+						      &chgin_otg_reg_cfg);
+	if (IS_ERR(chg->chgin_otg_rdev))
+		return dev_err_probe(dev, PTR_ERR(chg->chgin_otg_rdev),
+				     "Failed to register chgin otg regulator");
+
+	psy_cfg.fwnode = dev_fwnode(dev);
+	psy_cfg.drv_data = chg;
+	chg->psy = devm_power_supply_register(dev, &max77759_charger_desc,
+					      &psy_cfg);
+	if (IS_ERR(chg->psy))
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "Failed to register psy, ret=%ld",
+				     PTR_ERR(chg->psy));
+
+	ret = devm_work_autocancel(dev, &chg->psy_work, psy_work_item);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize psy work");
+
+	chg->nb.notifier_call = psy_changed;
+	ret = power_supply_reg_notifier(&chg->nb);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to register psy notifier");
+
+	ret = devm_add_action_or_reset(dev, max_tcpci_unregister_psy_notifier,
+				       &chg->nb);
+	if (ret)
+		return ret;
+
+	ret = max77759_init_irqhandler(chg);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Unable to initialize irq handler");
+	return 0;
+}
+
+static const struct of_device_id max77759_charger_ids[] = {
+	{ .compatible = "maxim,max77759-charger", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, max77759_charger_ids);
+
+static struct platform_driver max77759_charger_driver = {
+	.driver = {
+		.name = "max77759-charger",
+		.of_match_table = max77759_charger_ids,
+	},
+	.probe = max77759_charger_probe,
+};
+module_platform_driver(max77759_charger_driver);
+
+MODULE_AUTHOR("Amit Sunil Dhamne <amitsd@google.com>");
+MODULE_DESCRIPTION("Maxim MAX77759 charger driver");
+MODULE_LICENSE("GPL");

-- 
2.52.0.322.g1dd061c0dc-goog



