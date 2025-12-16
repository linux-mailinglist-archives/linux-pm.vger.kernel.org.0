Return-Path: <linux-pm+bounces-39612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5FCCC094D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 03:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54C2301E582
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 02:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9422DECAA;
	Tue, 16 Dec 2025 02:14:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from silergymicro.com (unknown [218.94.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89802E1726;
	Tue, 16 Dec 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.94.11.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851270; cv=none; b=BJvz8gF3jUiAUkLaIOThf0+1odcLulgHSLXXQoFoaKQXxFKg5UMj7qOq/dVQqKymzZish8AX1oLRN7e21d81VlYD80IaVDsdWPuzskl7LYnXEn0UcOytvOwTPD2SN09lfQGisYOl1w0Vuxb9VRcIY0lP9KPD4WLQjUstxAGDTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851270; c=relaxed/simple;
	bh=K2Jk4FHwXda402CbMNSEmdNszxiQufp70ookB+3uMHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TmHBdHGECFvX5tRDfzB+uZRU2Z1Fwp7mPjOOZg+E4UmdrCV4QBHn7VQErMRdVfZYLvY2d38mvFNbxgyty8gm+EGQCL3BCDGM8k5y3sfH1npK+3viFLtCFnyD+aeggSVmY6tG2HFmErxQbwAFYNfIgEvET1GYtLnpDsqWVLKUlH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silergymicro.com; spf=none smtp.mailfrom=silergymicro.com; arc=none smtp.client-ip=218.94.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silergymicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=silergymicro.com
Received: from getian-VirtualBox.. (unknown [10.2.25.100])
 by mail.silergymicro.com (Postfix) with ESMTPA id CB120182DA808;
 Tue, 16 Dec 2025 10:14:20 +0800 (CST)
From: "tian.ge" <tian.ge@silergymicro.com>
To: sre@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 lei.zhang@silergycorp.com, frank.fan@silergymicro.com,
 "tian.ge" <tian.ge@silergymicro.com>
Subject: [PATCH] power: supply: sy6974b: Add Silergy SY6974B charger driver
Date: Tue, 16 Dec 2025 10:14:08 +0800
Message-Id: <20251216021408.654926-1-tian.ge@silergymicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TraceID: 1765851261yeqxK
Content-Type: text/plain; charset="utf-8"

Add support for the SY6974B 3A 1-Cell Li+ battery charger.

The SY6974B is a highly-integrated 3A switch mode battery charger with
low impedance power path to better optimize the charging efficiency.

Signed-off-by: tian.ge <tian.ge@silergymicro.com>
---
 MAINTAINERS                            |   7 +
 drivers/power/supply/Kconfig           |  10 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/sy6974x_charger.c | 772 +++++++++++++++++++++++++
 4 files changed, 790 insertions(+)
 create mode 100644 drivers/power/supply/sy6974x_charger.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3468f6827b13..482a59c5d80e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23572,6 +23572,13 @@ S:	Maintained
 F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
+SILERGY SY6974B CHARGER DRIVER
+M:	Tian Ge <tian.ge@silergymicro.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/silergy,sy6974b.yaml
+F:	drivers/power/supply/sy6974x_charger.c
+
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index dca4be23ee70..0846bbf8d516 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -832,6 +832,16 @@ config CHARGER_SMB347
 	  Say Y to include support for Summit Microelectronics SMB345,
 	  SMB347 or SMB358 Battery Charger.
 
+config CHARGER_SY6974X
+	tristate "Silergy SY6974X charger driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the Silergy SY6974X charger.
+	  The SY6974B is a highly-integrated 3A switch mode battery
+	  charger with low impedance power path to better optimize the
+	  charging efficiency.
+
 config CHARGER_TPS65090
 	tristate "TPS65090 battery charger driver"
 	depends on MFD_TPS65090
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 99a820d38197..d433939c9e0d 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_CHARGER_BQ25980)	+= bq25980_charger.o
 obj-$(CONFIG_CHARGER_BQ256XX)	+= bq256xx_charger.o
 obj-$(CONFIG_CHARGER_RK817)	+= rk817_charger.o
 obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
+obj-$(CONFIG_CHARGER_SY6974X)	+= sy6974x_charger.o
 obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
diff --git a/drivers/power/supply/sy6974x_charger.c b/drivers/power/supply/sy6974x_charger.c
new file mode 100644
index 000000000000..61701459aabe
--- /dev/null
+++ b/drivers/power/supply/sy6974x_charger.c
@@ -0,0 +1,772 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sy6974x charger driver
+ *
+ * Copyright (c) 2025 Silergy Semiconductor Technology Co., Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+
+#define SY6974X_MANUFACTURER	"Silergy"
+#define SY6974X_IRQ_PIN	"sy6974x_irq"
+
+enum {
+	SY6974X_REG00_CTRL0 = 0,
+	SY6974X_REG01_CTRL1,
+	SY6974X_REG02_CTRL2,
+	SY6974X_REG03_CTRL3,
+	SY6974X_REG04_CTRL4,
+	SY6974X_REG05_CTRL5,
+	SY6974X_REG06_CTRL6,
+	SY6974X_REG07_CTRL7,
+	SY6974X_REG08_STAT0,
+	SY6974X_REG09_FAULT,
+	SY6974X_REG0A_STAT1,
+	SY6974X_REG0B_CTRL8,
+	SY6974X_REG_MAX,
+};
+
+enum sy6974x_fields {
+	/* REG00 */
+	F_EN_HIZ = 0,
+	F_STAT_DIS,
+	F_IINLIM,
+	/* REG01 */
+	F_PFM_DIS,
+	F_WD_RST,
+	F_OTG_CONFIG,
+	F_CHG_CONFIG,
+	F_SYS_MIN,
+	F_OTG_BAT,
+	/* REG02 */
+	F_BOOST_LIM,
+	F_Q1_FULLON,
+	F_ICHG,
+	/* REG03 */
+	F_IPRECHG,
+	F_ITERM,
+	/* REG04 */
+	F_VREG,
+	F_TOPOFF_TIMER,
+	F_VRECHG,
+	/* REG05 */
+	F_EN_TERM,
+	F_WATCHDOG,
+	F_ENTIMER,
+	F_CHG_TIMER,
+	F_TREG,
+	F_JEITA_ISET,
+	/* REG06 */
+	F_OVP,
+	F_BOOSTV,
+	F_VINDPM,
+	/* REG07 */
+	F_FORCE_INDET,
+	F_TMR2X_EN,
+	F_BATFET_DIS,
+	F_JEITA_VSET,
+	F_BATFET_DLY,
+	F_BATFET_RST_EN,
+	F_VDPM_BAT_TRACK,
+	/* REG08 */
+	F_BUS_STAT,
+	F_CHRG_STAT,
+	F_PG_STAT,
+	F_THERM_STAT,
+	F_VSYS_STAT,
+	/* REG09 */
+	F_WATCHDOG_FAULT,
+	F_BOOST_FAULT,
+	F_CHRG_FAULT,
+	F_BAT_FAULT,
+	F_NTC_FAULT,
+	/* REG0A */
+	F_BUS_GD,
+	F_VDPM_STAT,
+	F_IDPM_STAT,
+	F_TOPOFF_ACTIVE,
+	F_ACOV_STAT,
+	F_VINDPM_INT_MASK,
+	F_IINDPM_INT_MASK,
+	/* REG0B */
+	F_REG_RST,
+	F_PN,
+	F_DEV_REV,
+
+	F_MAX_FIELDS,
+};
+
+enum sy6974x_vbus_type {
+	SY6974X_VBUS_TYPE_NO_INPUT = 0,	/* No VBUS input detected */
+	SY6974X_VBUS_TYPE_SDP,		/* Standard Downstream Port */
+	SY6974X_VBUS_TYPE_CDP,		/* Charging Downstream Port */
+	SY6974X_VBUS_TYPE_DCP,		/* Dedicated Charging Port */
+	SY6974X_VBUS_TYPE_NON_STD,	/* Non-standard VBUS source */
+	SY6974X_VBUS_TYPE_OTG = 7,	/* OTG mode (device as power source) */
+};
+
+enum sy6974x_status {
+	STATUS_NOT_CHARGING = 0,	/* Not charging (e.g., VBUS absent) */
+	STATUS_PRE_CHARGING,		/* Pre-charging (low battery voltage) */
+	STATUS_FAST_CHARGING,		/* Constant current fast charging */
+	STATUS_TERMINATION_DONE,	/* Charging complete (terminated) */
+};
+
+enum sy6974x_chrg_fault {
+	CHRG_FAULT_NORMAL = 0,		/* No charging fault */
+	CHRG_FAULT_INPUT,		/* Input voltage fault */
+	CHRG_FAULT_THERMAL_SHUTDOWN,	/* Thermal shutdown (overtemp) */
+	CHRG_FAULT_TIMER_EXPIRED,	/* Charging safety timer expired */
+};
+
+struct sy6974x_init_data {
+	int ichg;	/* charge current */
+	int vreg;	/* regulation voltage */
+	int iterm;	/* termination current */
+	int iprechg;	/* precharge current */
+	int vsysmin;	/* minimum system voltage */
+};
+
+struct sy6974x_state {
+	int vbus_status;
+	int chrg_status;
+	int pg_status;
+	int therm_status;
+	int vsys_status;
+	int chrg_fault;
+	int bat_fault;
+	int ntc_fault;
+};
+
+struct sy6974x_device {
+	struct i2c_client *client;
+	struct device *dev;
+	struct power_supply *charger;
+	struct regmap *rmap;
+	struct regmap_field *rmap_fields[F_MAX_FIELDS];
+	struct sy6974x_init_data init_data;
+	struct sy6974x_state state;
+	struct mutex lock;
+};
+
+static const struct regmap_config sy6974x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = SY6974X_REG0B_CTRL8,
+};
+
+static const struct reg_field sy6974x_reg_fields[] = {
+	/* REG00 */
+	[F_EN_HIZ]		= REG_FIELD(SY6974X_REG00_CTRL0, 7, 7),
+	[F_STAT_DIS]		= REG_FIELD(SY6974X_REG00_CTRL0, 5, 6),
+	[F_IINLIM]		= REG_FIELD(SY6974X_REG00_CTRL0, 0, 4),
+	/* REG01 */
+	[F_PFM_DIS]		= REG_FIELD(SY6974X_REG01_CTRL1, 7, 7),
+	[F_WD_RST]		= REG_FIELD(SY6974X_REG01_CTRL1, 6, 6),
+	[F_OTG_CONFIG]		= REG_FIELD(SY6974X_REG01_CTRL1, 5, 5),
+	[F_CHG_CONFIG]		= REG_FIELD(SY6974X_REG01_CTRL1, 4, 4),
+	[F_SYS_MIN]		= REG_FIELD(SY6974X_REG01_CTRL1, 1, 3),
+	[F_OTG_BAT]		= REG_FIELD(SY6974X_REG01_CTRL1, 0, 0),
+	/* REG02 */
+	[F_BOOST_LIM]		= REG_FIELD(SY6974X_REG02_CTRL2, 7, 7),
+	[F_Q1_FULLON]		= REG_FIELD(SY6974X_REG02_CTRL2, 6, 6),
+	[F_ICHG]		= REG_FIELD(SY6974X_REG02_CTRL2, 0, 5),
+	/* REG03 */
+	[F_IPRECHG]		= REG_FIELD(SY6974X_REG03_CTRL3, 4, 7),
+	[F_ITERM]		= REG_FIELD(SY6974X_REG03_CTRL3, 0, 3),
+	/* REG04 */
+	[F_VREG]		= REG_FIELD(SY6974X_REG04_CTRL4, 3, 7),
+	[F_TOPOFF_TIMER]	= REG_FIELD(SY6974X_REG04_CTRL4, 1, 2),
+	[F_VRECHG]		= REG_FIELD(SY6974X_REG04_CTRL4, 0, 0),
+	/* REG05 */
+	[F_EN_TERM]		= REG_FIELD(SY6974X_REG05_CTRL5, 7, 7),
+	[F_WATCHDOG]		= REG_FIELD(SY6974X_REG05_CTRL5, 4, 5),
+	[F_ENTIMER]		= REG_FIELD(SY6974X_REG05_CTRL5, 3, 3),
+	[F_CHG_TIMER]		= REG_FIELD(SY6974X_REG05_CTRL5, 2, 2),
+	[F_TREG]		= REG_FIELD(SY6974X_REG05_CTRL5, 1, 1),
+	[F_JEITA_ISET]		= REG_FIELD(SY6974X_REG05_CTRL5, 0, 0),
+	/* REG06 */
+	[F_OVP]			= REG_FIELD(SY6974X_REG06_CTRL6, 6, 7),
+	[F_BOOSTV]		= REG_FIELD(SY6974X_REG06_CTRL6, 4, 5),
+	[F_VINDPM]		= REG_FIELD(SY6974X_REG06_CTRL6, 0, 3),
+	/* REG07 */
+	[F_FORCE_INDET]		= REG_FIELD(SY6974X_REG07_CTRL7, 7, 7),
+	[F_TMR2X_EN]		= REG_FIELD(SY6974X_REG07_CTRL7, 6, 6),
+	[F_BATFET_DIS]		= REG_FIELD(SY6974X_REG07_CTRL7, 5, 5),
+	[F_JEITA_VSET]		= REG_FIELD(SY6974X_REG07_CTRL7, 4, 4),
+	[F_BATFET_DLY]		= REG_FIELD(SY6974X_REG07_CTRL7, 3, 3),
+	[F_BATFET_RST_EN]	= REG_FIELD(SY6974X_REG07_CTRL7, 2, 2),
+	[F_VDPM_BAT_TRACK]	= REG_FIELD(SY6974X_REG07_CTRL7, 0, 1),
+	/* REG08 */
+	[F_BUS_STAT]		= REG_FIELD(SY6974X_REG08_STAT0, 5, 7),
+	[F_CHRG_STAT]		= REG_FIELD(SY6974X_REG08_STAT0, 3, 4),
+	[F_PG_STAT]		= REG_FIELD(SY6974X_REG08_STAT0, 2, 2),
+	[F_THERM_STAT]		= REG_FIELD(SY6974X_REG08_STAT0, 1, 1),
+	[F_VSYS_STAT]		= REG_FIELD(SY6974X_REG08_STAT0, 0, 0),
+	/* REG09 */
+	[F_WATCHDOG_FAULT]	= REG_FIELD(SY6974X_REG09_FAULT, 7, 7),
+	[F_BOOST_FAULT]		= REG_FIELD(SY6974X_REG09_FAULT, 6, 6),
+	[F_CHRG_FAULT]		= REG_FIELD(SY6974X_REG09_FAULT, 4, 5),
+	[F_BAT_FAULT]		= REG_FIELD(SY6974X_REG09_FAULT, 3, 3),
+	[F_NTC_FAULT]		= REG_FIELD(SY6974X_REG09_FAULT, 0, 2),
+	/* REG0A */
+	[F_BUS_GD]		= REG_FIELD(SY6974X_REG0A_STAT1, 7, 7),
+	[F_VDPM_STAT]		= REG_FIELD(SY6974X_REG0A_STAT1, 6, 6),
+	[F_IDPM_STAT]		= REG_FIELD(SY6974X_REG0A_STAT1, 5, 5),
+	[F_TOPOFF_ACTIVE]	= REG_FIELD(SY6974X_REG0A_STAT1, 3, 3),
+	[F_ACOV_STAT]		= REG_FIELD(SY6974X_REG0A_STAT1, 2, 2),
+	[F_VINDPM_INT_MASK]	= REG_FIELD(SY6974X_REG0A_STAT1, 1, 1),
+	[F_IINDPM_INT_MASK]	= REG_FIELD(SY6974X_REG0A_STAT1, 0, 0),
+	/* REG0B */
+	[F_REG_RST]		= REG_FIELD(SY6974X_REG0B_CTRL8, 7, 7),
+	[F_PN]			= REG_FIELD(SY6974X_REG0B_CTRL8, 3, 6),
+	[F_DEV_REV]		= REG_FIELD(SY6974X_REG0B_CTRL8, 0, 1),
+};
+
+/*
+ * Convert between value (mA/mV) and index:
+ * - Range tables: compute via min/max/step
+ * - Lookup tables: match via pre-defined value array
+ */
+enum sy6974x_table_ids {
+	/* Range tables (compute by min/max/step) */
+	TBL_ICHG = 0,
+	TBL_IPRECHG,
+	TBL_ITERM,
+	TBL_VREG,
+
+	/* Lookup tables (pre-defined values) */
+	TBL_VSYSMIN,
+
+	TBL_MAX,
+};
+
+static const int sy6974x_vsysmin_tbl[] = {
+	2600, 2800, 3000, 3200, 3400, 3500, 3600, 3700
+};
+
+#define SY6974X_VSYSMIN_SIZE ARRAY_SIZE(sy6974x_vsysmin_tbl)
+
+struct sy6974x_range {
+	int min;
+	int max;
+	int step;
+};
+
+struct sy6974x_lookup {
+	const int *tbl;
+	int size;
+};
+
+static const union {
+	struct sy6974x_range rt;
+	struct sy6974x_lookup lt;
+} sy6974x_tables[] = {
+	[TBL_ICHG]	= { .rt = { 0, 3000, 60 } }, /* mA */
+	[TBL_IPRECHG]	= { .rt = { 60, 780, 60 } }, /* mA */
+	[TBL_ITERM]	= { .rt = { 60, 960, 60 } }, /* mA */
+	[TBL_VREG]	= { .rt = { 3856, 4624, 32 } }, /* mV */
+	[TBL_VSYSMIN]	= {
+		.lt = { sy6974x_vsysmin_tbl, SY6974X_VSYSMIN_SIZE }
+	}, /* mV */
+};
+
+static int sy6974x_field_read(struct sy6974x_device *sy,
+			      enum sy6974x_fields field_id, unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_field_read(sy->rmap_fields[field_id], val);
+	if (ret < 0)
+		dev_err(sy->dev, "regmap field read failed\n");
+
+	return ret;
+}
+
+static int sy6974x_field_write(struct sy6974x_device *sy,
+			       enum sy6974x_fields field_id, unsigned int val)
+{
+	int ret;
+
+	ret = regmap_field_write(sy->rmap_fields[field_id], val);
+	if (ret < 0)
+		dev_err(sy->dev, "regmap field write failed\n");
+
+	return ret;
+}
+
+static int sy6974x_find_idx(int value, enum sy6974x_table_ids id)
+{
+	int idx = 0;
+
+	if (id >= TBL_MAX)
+		return -EINVAL;
+
+	if (id >= TBL_VSYSMIN) {
+		const struct sy6974x_lookup *lt = &sy6974x_tables[id].lt;
+
+		if (!lt->tbl || lt->size == 0)
+			return -EINVAL;
+
+		for (; idx < lt->size - 1 && lt->tbl[idx + 1] <= value; idx++)
+			;
+	} else {
+		const struct sy6974x_range *rt = &sy6974x_tables[id].rt;
+
+		if (rt->step == 0 || rt->min > rt->max)
+			return -EINVAL;
+
+		if (value <= rt->min)
+			return 0;
+		if (value >= rt->max)
+			return (rt->max - rt->min) / rt->step;
+
+		idx = (value - rt->min) / rt->step;
+	}
+
+	return idx;
+}
+
+static int sy6974x_find_val(int idx, enum sy6974x_table_ids id)
+{
+	if (id >= TBL_MAX || idx < 0)
+		return -EINVAL;
+
+	if (id >= TBL_VSYSMIN) {
+		const struct sy6974x_lookup *lt = &sy6974x_tables[id].lt;
+
+		if (!lt->tbl || lt->size == 0)
+			return -EINVAL;
+
+		return (idx < lt->size) ? lt->tbl[idx] : lt->tbl[lt->size - 1];
+	}
+
+	const struct sy6974x_range *rt = &sy6974x_tables[id].rt;
+
+	if (rt->step == 0 || rt->min > rt->max)
+		return -EINVAL;
+
+	if (idx > (rt->max - rt->min) / rt->step)
+		return rt->max;
+
+	return rt->min + idx * rt->step;
+}
+
+static int sy6974x_power_supply_get_property(struct power_supply *psy,
+					     enum power_supply_property psp,
+					     union power_supply_propval *val)
+{
+	struct sy6974x_device *sy = power_supply_get_drvdata(psy);
+	struct sy6974x_state state;
+
+	mutex_lock(&sy->lock);
+	state = sy->state;
+	mutex_unlock(&sy->lock);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!state.pg_status)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (state.chrg_status == STATUS_NOT_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else if (state.chrg_status == STATUS_PRE_CHARGING ||
+			 state.chrg_status == STATUS_FAST_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (state.chrg_status == STATUS_TERMINATION_DONE)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		if (!state.chrg_fault && !state.bat_fault)
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		else if (state.bat_fault)
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		else if (state.chrg_fault == CHRG_FAULT_TIMER_EXPIRED)
+			val->intval = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+		else if (state.chrg_fault == CHRG_FAULT_THERMAL_SHUTDOWN)
+			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		break;
+
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = state.pg_status;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		int vsysmin = sy6974x_find_val(sy->init_data.vsysmin, TBL_VSYSMIN);
+
+		if (vsysmin < 0) {
+			dev_err(sy->dev, "Invalid vsysmin index %d (ret=%d)\n",
+				sy->init_data.vsysmin, vsysmin);
+			return vsysmin;
+		}
+		val->intval = vsysmin;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		int ichg = sy6974x_find_val(sy->init_data.ichg, TBL_ICHG);
+
+		if (ichg < 0) {
+			dev_err(sy->dev, "Invalid ichg index %d (ret=%d)\n",
+				sy->init_data.ichg, ichg);
+			return ichg;
+		}
+		val->intval = ichg;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		int vreg = sy6974x_find_val(sy->init_data.vreg, TBL_VREG);
+
+		if (vreg < 0) {
+			dev_err(sy->dev, "Invalid vreg index %d (ret=%d)\n",
+				sy->init_data.vreg, vreg);
+			return vreg;
+		}
+		val->intval = vreg;
+		break;
+
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		int iprechg = sy6974x_find_val(sy->init_data.iprechg, TBL_IPRECHG);
+
+		if (iprechg < 0) {
+			dev_err(sy->dev, "Invalid iprechg index %d (ret=%d)\n",
+				sy->init_data.iprechg, iprechg);
+			return iprechg;
+		}
+		val->intval = iprechg;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		int iterm = sy6974x_find_val(sy->init_data.iterm, TBL_ITERM);
+
+		if (iterm < 0) {
+			dev_err(sy->dev, "Invalid iterm index %d (ret=%d)\n",
+				sy->init_data.iterm, iterm);
+			return iterm;
+		}
+		val->intval = iterm;
+		break;
+
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		switch (state.vbus_status) {
+		case SY6974X_VBUS_TYPE_SDP:
+			val->intval = POWER_SUPPLY_USB_TYPE_SDP;
+			break;
+		case SY6974X_VBUS_TYPE_CDP:
+			val->intval = POWER_SUPPLY_USB_TYPE_CDP;
+			break;
+		case SY6974X_VBUS_TYPE_DCP:
+			val->intval = POWER_SUPPLY_USB_TYPE_DCP;
+			break;
+		case SY6974X_VBUS_TYPE_OTG:
+			val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
+			break;
+		default:
+			val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+			break;
+		}
+		break;
+
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = SY6974X_MANUFACTURER;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sy6974x_get_chip_state(struct sy6974x_device *sy,
+				  struct sy6974x_state *state)
+{
+	int val = 0, i, ret;
+	struct {
+		enum sy6974x_fields id;
+		int *data;
+	} state_fields[] = {
+		{ F_BUS_STAT,	&state->vbus_status },
+		{ F_CHRG_STAT,	&state->chrg_status },
+		{ F_PG_STAT,	&state->pg_status },
+		{ F_THERM_STAT,	&state->therm_status },
+		{ F_VSYS_STAT,	&state->vsys_status },
+		{ F_CHRG_FAULT,	&state->chrg_fault },
+		{ F_BAT_FAULT,	&state->bat_fault },
+		{ F_NTC_FAULT,	&state->ntc_fault },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(state_fields); i++) {
+		ret = sy6974x_field_read(sy, state_fields[i].id, &val);
+		if (ret < 0)
+			return ret;
+
+		*state_fields[i].data = val;
+	}
+
+	dev_dbg(sy->dev,
+		"S:TYPE/CHRG/PG/THERM/VSYS=%d/%d/%d/%d/%d, F:CHRG/BAT/NTC=%d/%d/%d\n",
+		state->vbus_status, state->chrg_status, state->pg_status,
+		state->therm_status, state->vsys_status, state->chrg_fault,
+		state->bat_fault, state->ntc_fault);
+
+	return 0;
+}
+
+static irqreturn_t sy6974x_irq_handler_thread(int irq, void *private)
+{
+	struct sy6974x_device *sy = private;
+	struct sy6974x_state new_state;
+	int ret;
+
+	ret = sy6974x_get_chip_state(sy, &new_state);
+	if (ret < 0)
+		goto handled;
+
+	/* No state change, skip notification */
+	if (!memcmp(&sy->state, &new_state, sizeof(new_state)))
+		goto handled;
+
+	mutex_lock(&sy->lock);
+	sy->state = new_state;
+	mutex_unlock(&sy->lock);
+
+	power_supply_changed(sy->charger);
+
+handled:
+	return IRQ_HANDLED;
+}
+
+static int sy6974x_chip_reset(struct sy6974x_device *sy)
+{
+	/* Wait max 100us for chip reset completion */
+	int rst_check_counter = 10;
+	int val = 0, ret;
+
+	ret = sy6974x_field_write(sy, F_REG_RST, 1);
+	if (ret < 0)
+		return ret;
+
+	do {
+		ret = sy6974x_field_read(sy, F_REG_RST, &val);
+		if (ret < 0)
+			return ret;
+
+		usleep_range(5, 10);
+	} while (val == 1 && --rst_check_counter);
+
+	if (!rst_check_counter)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int sy6974x_hw_init(struct sy6974x_device *sy)
+{
+	int i, ret;
+	const struct {
+		enum sy6974x_fields id;
+		int *value;
+	} init_data[] = {
+		{ F_ICHG,	&sy->init_data.ichg },
+		{ F_VREG,	&sy->init_data.vreg },
+		{ F_ITERM,	&sy->init_data.iterm },
+		{ F_IPRECHG,	&sy->init_data.iprechg },
+		{ F_SYS_MIN,	&sy->init_data.vsysmin },
+	};
+
+	ret = sy6974x_chip_reset(sy);
+	if (ret < 0) {
+		dev_err(sy->dev, "Reset failed %d\n", ret);
+		return ret;
+	}
+
+	/* disable watchdog */
+	ret = sy6974x_field_write(sy, F_WATCHDOG, 0);
+	if (ret < 0) {
+		dev_err(sy->dev, "Disabling watchdog failed %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(init_data); i++) {
+		ret = sy6974x_field_write(sy, init_data[i].id,
+					  *init_data[i].value);
+		if (ret < 0) {
+			dev_err(sy->dev, "Accessing init data failed %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	ret = sy6974x_get_chip_state(sy, &sy->state);
+	if (ret < 0) {
+		dev_err(sy->dev, "Get state failed %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property sy6974x_power_supply_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static char *sy6974x_charger_supplied_to[] = {
+	"main-battery",
+};
+
+static const struct power_supply_desc sy6974x_power_supply_desc = {
+	.name		= "sy6974x-charger",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.usb_types	= BIT(POWER_SUPPLY_USB_TYPE_SDP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_CDP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_DCP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_PD_DRP) |
+			  BIT(POWER_SUPPLY_USB_TYPE_UNKNOWN),
+	.properties	= sy6974x_power_supply_props,
+	.num_properties	= ARRAY_SIZE(sy6974x_power_supply_props),
+	.get_property	= sy6974x_power_supply_get_property,
+};
+
+static int sy6974x_power_supply_init(struct sy6974x_device *sy)
+{
+	struct power_supply_config psy_cfg = { .drv_data = sy, };
+
+	psy_cfg.supplied_to = sy6974x_charger_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(sy6974x_charger_supplied_to);
+	sy->charger = devm_power_supply_register(
+		sy->dev, &sy6974x_power_supply_desc, &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(sy->charger);
+}
+
+static int sy6974x_parse_dtb(struct sy6974x_device *sy)
+{
+	u32 property = 0;
+	int i, ret;
+	struct sy6974x_init_data *init = &sy->init_data;
+	struct {
+		char *name;
+		enum sy6974x_table_ids tbl_id;
+		int *conv_data;
+	} props[] = {
+		{ "sy,charge-current",		TBL_ICHG, &init->ichg },
+		{ "sy,precharge-current",	TBL_IPRECHG, &init->iprechg },
+		{ "sy,termination-current",	TBL_ITERM, &init->iterm },
+		{ "sy,regulation-voltage",	TBL_VREG, &init->vreg },
+		{ "sy,minimum-sys-voltage",	TBL_VSYSMIN, &init->vsysmin },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		ret = device_property_read_u32(sy->dev, props[i].name,
+					       &property);
+		if (ret < 0) {
+			dev_err(sy->dev, "Unable to read property %d %s\n", ret,
+				props[i].name);
+			return ret;
+		}
+
+		*props[i].conv_data =
+			sy6974x_find_idx((int)property, props[i].tbl_id);
+		if (*props[i].conv_data < 0) {
+			dev_err(sy->dev, "Invalid value %u for property '%s' (ret=%d)\n",
+				property, props[i].name, *props[i].conv_data);
+			return *props[i].conv_data;
+		}
+	}
+
+	return 0;
+}
+
+static int sy6974x_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sy6974x_device *sy;
+	int ret;
+
+	sy = devm_kzalloc(dev, sizeof(*sy), GFP_KERNEL);
+	if (!sy)
+		return -ENOMEM;
+
+	sy->client = client;
+	sy->dev = dev;
+	i2c_set_clientdata(client, sy);
+
+	ret = devm_mutex_init(dev, &sy->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to mutex init\n");
+
+	sy->rmap = devm_regmap_init_i2c(client, &sy6974x_regmap_config);
+	if (IS_ERR(sy->rmap))
+		return dev_err_probe(dev, PTR_ERR(sy->rmap), "failed to init regmap\n");
+
+	ret = devm_regmap_field_bulk_alloc(dev, sy->rmap, sy->rmap_fields,
+			sy6974x_reg_fields, F_MAX_FIELDS);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to allocate regmap field\n");
+
+	ret = sy6974x_parse_dtb(sy);
+	if (ret < 0) {
+		dev_err(dev, "failed to parse dtb ret=%d\n", ret);
+		return ret;
+	}
+
+	ret = sy6974x_hw_init(sy);
+	if (ret < 0) {
+		dev_err(dev, "failed to hw init ret=%d\n", ret);
+		return ret;
+	}
+
+	ret = sy6974x_power_supply_init(sy);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register power supply\n");
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(
+			dev, client->irq, NULL, sy6974x_irq_handler_thread,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT, SY6974X_IRQ_PIN,
+			sy);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request threaded irq\n");
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sy6974x_of_match[] = {
+	{ .compatible = "silergy,sy6974b", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sy6974x_of_match);
+
+static struct i2c_driver sy6974x_driver = {
+	.driver = {
+		.name = "sy6974x-charger",
+		.of_match_table = of_match_ptr(sy6974x_of_match),
+	},
+	.probe = sy6974x_probe,
+};
+module_i2c_driver(sy6974x_driver);
+
+MODULE_AUTHOR("Tian Ge <tian.ge@silergymicro.com>");
+MODULE_DESCRIPTION("sy6974x charger driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

 This email contains information from Silergy Corp. that may be confidential or privileged. Such information is solely for the intended recipient(s).Any review, retransmission, dissemination, disclosure or other use of this information by persons or entities other than intended recipient(s) is strictly prohibited. If you have received this email in error, please notify the sender immediately and delete this email together with any correspondences. 

