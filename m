Return-Path: <linux-pm+bounces-39960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 946EDCDF2A5
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 01:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 107DC3017389
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17A13AD26;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7bnULHM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495B1BC41;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793899; cv=none; b=U6f/zDOybEQb7LrUrctgMxus9MmRx3GVxrlJG2juP5YWU8Or7Cd5XuGGUSVhkCM8jnJsOzhraNUHMxin1586AkJHsIkW30iMqUvSKE6tXVBkHIbZ8mnxk84+pTLwR7NnuXJScykltEEA0sbz2AIXkUgQ28D68EQAOMNYUh5G1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793899; c=relaxed/simple;
	bh=lTLMHN9fYiWYOgIcelQbP7s4iCYCn14VaX5xgbcMabQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YaaWlgSfi55GNzUxmt9E0OhJiCC246rGQ9pl9K5C7PC41x+t3kflc42fzpnUkJhHnyAt/M64j+rNJUAw0latIx/nS23P+l/Smr+OSkxvhL0dnBXIElOEudwcaP7pi50sIuM6FsRNopB1lTUF634Wz2VBTbd3GqB3oBCm0rU83x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7bnULHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F38EC19425;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766793899;
	bh=lTLMHN9fYiWYOgIcelQbP7s4iCYCn14VaX5xgbcMabQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H7bnULHML+D0HbFOnFpUSHXR3uM9NpQUpHKOvTrtI3noxiXEmwVQoVV8zoKlIPcZL
	 rmuNdtq6AfmC4ExwVTCgnS7Vpi8wUhT6HfVaTanKJk3V/GKP4IsbTwC2ZH4vR1+DAu
	 3+JS1ehOMwfuNWfrJLAqDEt+GPpSZ4sW9YUB30aDL81aXylEvIR64OR0wv63/J6LUx
	 3GxZWbQEUbF+2ZsAeVjDgERy6Lxlr/yHfbXMmCfSLaVVHcGMgSLLrTQe+bjOe1+SwK
	 nUxUWuGlM4HI9lb0bvfsXq4ocqRUdobK3Zk3hgaVgZ/Mv0lOKltX5C5zLFdSQH0aoW
	 2nnCzJD/deKkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C6E8FDC3;
	Sat, 27 Dec 2025 00:04:59 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sat, 27 Dec 2025 00:04:24 +0000
Subject: [PATCH v3 4/5] power: supply: max77759: add charger driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-max77759-charger-v3-4-54e664f5ca92@google.com>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
In-Reply-To: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766793897; l=24293;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=5Yn31u5TNM1gSPQ55gF06NDnNAKuFj8Et7lxotkOHjk=;
 b=w8utABqUarLM/pERluL7xSoj2SVAfeNF84qCb78wPuR1gvOAR9NW+HHfD08sPv2ufv8h1VJY6
 UJhFtTZBENLC7PfMQatjy+9vjHJxH9IkX1VzQvzsFAndyGMETxwsUmp
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
 MAINTAINERS                             |   6 +
 drivers/power/supply/Kconfig            |  11 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max77759_charger.c | 764 ++++++++++++++++++++++++++++++++
 4 files changed, 782 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc731d37c8fe..26a9654ab75e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15539,6 +15539,12 @@ F:	drivers/mfd/max77759.c
 F:	drivers/nvmem/max77759-nvmem.c
 F:	include/linux/mfd/max77759.h
 
+MAXIM MAX77759 BATTERY CHARGER DRIVER
+M:	Amit Sunil Dhamne <amitsd@google.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/power/supply/max77759_charger.c
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 92f9f7aae92f..e172fd980fde 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -1132,4 +1132,15 @@ config FUEL_GAUGE_MM8013
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
index 4b79d5abc49a..6af905875ad5 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
+obj-$(CONFIG_CHARGER_MAX77759)	+= max77759_charger.o
diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
new file mode 100644
index 000000000000..3d255b069fb9
--- /dev/null
+++ b/drivers/power/supply/max77759_charger.c
@@ -0,0 +1,764 @@
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
+	case MAX77759_CHGR_CHG_DTLS_CV:
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
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
+	unsigned long irq_flags;
+	struct irq_data *irqd;
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
+	struct power_supply_battery_info *info;
+	u32 regval, fast_chg_curr, fv;
+	int ret;
+
+	regmap_read(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_00, &regval);
+	chg->mode = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
+	ret = charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+	if (ret)
+		return ret;
+
+	if (power_supply_get_battery_info(chg->psy, &info)) {
+		fv = CHG_FV_DEFAULT_MV;
+		fast_chg_curr = CHG_CC_DEFAULT_UA;
+	} else {
+		fv = info->constant_charge_voltage_max_uv / 1000;
+		fast_chg_curr = info->constant_charge_current_max_ua;
+	}
+
+	ret = set_fast_charge_current_limit(chg, fast_chg_curr);
+	if (ret)
+		return ret;
+
+	ret = set_float_voltage_limit(chg, fv);
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
+	device_set_of_node_from_dev(dev, dev->parent);
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
+	psy_cfg.fwnode = dev_fwnode(dev);
+	psy_cfg.drv_data = chg;
+	chg->psy = devm_power_supply_register(dev, &max77759_charger_desc,
+					      &psy_cfg);
+	if (IS_ERR(chg->psy))
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "Failed to register psy, ret=%ld",
+				     PTR_ERR(chg->psy));
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
+static const struct platform_device_id max77759_charger_id[] = {
+	{"max77759-charger",},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, max77759_charger_id);
+
+static struct platform_driver max77759_charger_driver = {
+	.driver = {
+		.name = "max77759-charger",
+	},
+	.probe = max77759_charger_probe,
+	.id_table = max77759_charger_id,
+};
+module_platform_driver(max77759_charger_driver);
+
+MODULE_AUTHOR("Amit Sunil Dhamne <amitsd@google.com>");
+MODULE_DESCRIPTION("Maxim MAX77759 charger driver");
+MODULE_LICENSE("GPL");

-- 
2.52.0.351.gbe84eed79e-goog



