Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFAC17E4BB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCIQZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 12:25:07 -0400
Received: from mail.manjaro.org ([176.9.38.148]:44340 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgCIQZG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 12:25:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id EDC13370239C;
        Mon,  9 Mar 2020 17:04:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ss1yxnfOmPUg; Mon,  9 Mar 2020 17:04:42 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 2/2] power: supply: add CellWise cw2015 fuel gauge driver
Date:   Mon,  9 Mar 2020 17:03:46 +0100
Message-Id: <20200309160346.2203680-3-t.schramm@manjaro.org>
In-Reply-To: <20200309160346.2203680-1-t.schramm@manjaro.org>
References: <20200309160346.2203680-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds a driver for the CellWise cw2015 fuel gauge.

The CellWise cw2015 is a shuntless, single-cell Li-Ion fuel gauge used
in the pine64 Pinebook Pro laptop and some Raspberry Pi UPS HATs.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 MAINTAINERS                           |   6 +
 drivers/power/supply/Kconfig          |   6 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/cw2015_battery.c | 891 ++++++++++++++++++++++++++
 4 files changed, 904 insertions(+)
 create mode 100644 drivers/power/supply/cw2015_battery.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a6fbdf354d34..ee345ad7bc74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3885,6 +3885,12 @@ F:	arch/powerpc/include/uapi/asm/spu*.h
 F:	arch/powerpc/oprofile/*cell*
 F:	arch/powerpc/platforms/cell/
 
+CELLWISE CW2015 BATTERY DRIVER
+M:	Tobias Schrammm <t.schramm@manjaro.org>
+S:	Maintained
+F:	drivers/power/supply/cw2015_battery.c
+F:	Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
+
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
 M:	Jeff Layton <jlayton@kernel.org>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9a5591ab90d0..1c4c1bbc6863 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -116,6 +116,12 @@ config BATTERY_CPCAP
 	  Say Y here to enable support for battery on Motorola
 	  phones and tablets such as droid 4.
 
+config BATTERY_CW2015
+	tristate "CW2015 Battery driver"
+	help
+	  Say Y here to enable support for the cellwise cw2015
+	  battery fuel gauge (used in the Pinebook Pro & others)
+
 config BATTERY_DS2760
 	tristate "DS2760 battery driver (HP iPAQ & others)"
 	depends on W1
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 6c7da920ea83..69727a10e835 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
 obj-$(CONFIG_BATTERY_CPCAP)	+= cpcap-battery.o
+obj-$(CONFIG_BATTERY_CW2015)	+= cw2015_battery.o
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
 obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
new file mode 100644
index 000000000000..74ac9799221f
--- /dev/null
+++ b/drivers/power/supply/cw2015_battery.c
@@ -0,0 +1,891 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fuel gauge driver for CellWise 2013 / 2015
+ *
+ * Copyright (C) 2012, RockChip
+ * Copyright (C) 2020, Tobias Schramm
+ *
+ * Authors: xuhuicong <xhc@rock-chips.com>
+ * Authors: Tobias Schramm <tobias@t-sys.eu>
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
+#include <linux/workqueue.h>
+#include <linux/regmap.h>
+
+#define CW2015_SIZE_BATINFO		64
+
+#define CW2015_READ_TRIES		30
+#define CW2015_RESET_TRIES		5
+
+#define CW2015_REG_VERSION		0x0
+#define CW2015_REG_VCELL		0x2
+#define CW2015_REG_SOC			0x4
+#define CW2015_REG_RRT_ALERT		0x6
+#define CW2015_REG_CONFIG		0x8
+#define CW2015_REG_MODE			0xA
+#define CW2015_REG_BATINFO		0x10
+
+#define CW2015_MODE_SLEEP_MASK		(0x3<<6)
+#define CW2015_MODE_SLEEP		(0x3<<6)
+#define CW2015_MODE_NORMAL		(0x0<<6)
+#define CW2015_MODE_QUICK_START		(0x3<<4)
+#define CW2015_MODE_RESTART		(0xf<<0)
+
+#define CW2015_CONFIG_UPDATE_FLG	(0x01<<1)
+#define CW2015_ATHD(x)			((x)<<3)
+#define CW2015_MASK_ATHD		(0x1f<<3)
+#define CW2015_MASK_SOC			(0x1fff)
+
+#define CW2015_BATTERY_UP_MAX_CHANGE		(420 * 1000)
+#define CW2015_BATTERY_DOWN_MAX_CHANGE		(120 * 1000)
+#define CW2015_BATTERY_DOWN_CHANGE		60
+#define CW2015_BATTERY_DOWN_MIN_CHANGE_RUN	30
+#define CW2015_BATTERY_DOWN_MIN_CHANGE_SLEEP	1800
+#define CW2015_BATTERY_JUMP_TO_ZERO		(30 * 1000)
+#define CW2015_BATTERY_CAPACITY_ERROR		(40 * 1000)
+#define CW2015_BATTERY_CHARGING_ZERO		(1800 * 1000)
+
+#define CW2015_DEFAULT_MONITOR_MS		8000
+
+#define CW2015_AVERAGING_SAMPLES		3
+
+struct cw_battery {
+	struct i2c_client *client;
+	struct workqueue_struct *battery_workqueue;
+	struct delayed_work battery_delay_work;
+	struct regmap *regmap;
+	struct power_supply *rk_bat;
+	struct power_supply_battery_info battery;
+	u8 *bat_config_info;
+
+#ifdef CONFIG_PM
+	struct timespec64 suspend_time_before;
+	struct timespec64 after;
+	int suspend_resume_mark;
+#endif
+	int charger_mode;
+	int capacity;
+	int voltage;
+	int status;
+	int time_to_empty;
+	int alt;
+	u32 monitor_sec;
+	int bat_change;
+	int charge_count;
+	u8 alert_level;
+};
+
+#define PREFIX "cellwise,"
+
+#define cw_dbg(cw_bat, ...) dev_dbg(&(cw_bat)->client->dev, __VA_ARGS__)
+#define cw_info(cw_bat, ...) dev_info(&(cw_bat)->client->dev, __VA_ARGS__)
+#define cw_warn(cw_bat, ...) dev_warn(&(cw_bat)->client->dev, __VA_ARGS__)
+#define cw_err(cw_bat, ...) dev_err(&(cw_bat)->client->dev, __VA_ARGS__)
+
+static int cw_read(struct cw_battery *cw_bat, u8 reg, u8 *val)
+{
+	u32 tmp;
+	int ret;
+
+	ret = regmap_read(cw_bat->regmap, reg, &tmp);
+	*val = tmp;
+	return ret;
+}
+
+static int cw_write(struct cw_battery *cw_bat, u8 reg, const u8 val)
+{
+	return regmap_write(cw_bat->regmap, reg, val);
+}
+
+static int cw_read_word(struct cw_battery *cw_bat, u8 reg, u16 *val)
+{
+	u8 reg_val[2];
+	int ret;
+
+	ret = regmap_raw_read(cw_bat->regmap, reg, reg_val, 2);
+	*val = (reg_val[0] << 8) + reg_val[1];
+	return ret;
+}
+
+static int cw_read_bulk(struct cw_battery *cw_bat, u8 reg, u8 *buf, size_t len)
+{
+	return regmap_raw_read(cw_bat->regmap, reg, buf, len);
+}
+
+static int cw_write_bulk(struct cw_battery *cw_bat, u8 reg, u8 const *buf,
+				size_t len)
+{
+	return regmap_raw_write(cw_bat->regmap, reg, buf, len);
+}
+
+int cw_update_config_info(struct cw_battery *cw_bat)
+{
+	int ret;
+	u8 reg_val;
+	u8 reset_val;
+
+	if (!cw_bat->bat_config_info) {
+		cw_err(cw_bat,
+			"No battery config info provided, can't update flash contents");
+		return -EINVAL;
+	}
+
+	/* make sure gauge is not in sleep mode */
+	ret = cw_read(cw_bat, CW2015_REG_MODE, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	reset_val = reg_val;
+	if ((reg_val & CW2015_MODE_SLEEP_MASK) == CW2015_MODE_SLEEP) {
+		cw_err(cw_bat,
+			"Device is in sleep mode, can't update battery info");
+		return -EINVAL;
+	}
+
+	/* write new battery info */
+	ret = cw_write_bulk(cw_bat, CW2015_REG_BATINFO,
+				cw_bat->bat_config_info,
+				CW2015_SIZE_BATINFO);
+
+	if (ret < 0)
+		return ret;
+
+	reg_val |= CW2015_CONFIG_UPDATE_FLG;	/* set UPDATE_FLAG */
+	reg_val &= ~CW2015_MASK_ATHD;	/* clear alert level */
+	reg_val |= CW2015_ATHD(cw_bat->alert_level);	/* set alert level */
+	ret = cw_write(cw_bat, CW2015_REG_CONFIG, reg_val);
+	if (ret < 0)
+		return ret;
+
+	/* reset */
+	reset_val &= ~(CW2015_MODE_RESTART);
+	reg_val = reset_val | CW2015_MODE_RESTART;
+	ret = cw_write(cw_bat, CW2015_REG_MODE, reg_val);
+	if (ret < 0)
+		return ret;
+
+	msleep(20);
+	ret = cw_write(cw_bat, CW2015_REG_MODE, reset_val);
+	if (ret < 0)
+		return ret;
+
+	cw_dbg(cw_bat, "Battery config updated");
+
+	return 0;
+}
+
+static int cw_init(struct cw_battery *cw_bat)
+{
+	int ret;
+	int i;
+	u8 reg_val = CW2015_MODE_SLEEP;
+
+	if ((reg_val & CW2015_MODE_SLEEP_MASK) == CW2015_MODE_SLEEP) {
+		reg_val = CW2015_MODE_NORMAL;
+		ret = cw_write(cw_bat, CW2015_REG_MODE, reg_val);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = cw_read(cw_bat, CW2015_REG_CONFIG, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	if ((reg_val & CW2015_MASK_ATHD) != CW2015_ATHD(cw_bat->alert_level)) {
+		cw_dbg(cw_bat, "Setting new alert level");
+		reg_val &= ~CW2015_MASK_ATHD;
+		reg_val |= ~CW2015_ATHD(cw_bat->alert_level);
+		ret = cw_write(cw_bat, CW2015_REG_CONFIG, reg_val);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = cw_read(cw_bat, CW2015_REG_CONFIG, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	if (!(reg_val & CW2015_CONFIG_UPDATE_FLG)) {
+		cw_dbg(cw_bat,
+			"Battery config not present, uploading battery config");
+		if (cw_bat->bat_config_info) {
+			ret = cw_update_config_info(cw_bat);
+			if (ret < 0) {
+				cw_err(cw_bat,
+					 "Failed to upload battery info\n");
+				return ret;
+			}
+		} else {
+			cw_warn(cw_bat,
+				"Have no battery config for uploading, continuing without config");
+		}
+	} else if (cw_bat->bat_config_info) {
+		u8 bat_info[CW2015_SIZE_BATINFO];
+
+		ret = cw_read_bulk(cw_bat, CW2015_REG_BATINFO, bat_info,
+					CW2015_SIZE_BATINFO);
+		if (ret < 0)
+			return ret;
+
+		if (memcmp(bat_info, cw_bat->bat_config_info,
+				CW2015_SIZE_BATINFO)) {
+			cw_warn(cw_bat, "Replacing stored battery info");
+			ret = cw_update_config_info(cw_bat);
+			if (ret < 0)
+				return ret;
+		}
+	} else
+		cw_warn(cw_bat, "Can't check current battery config, no config provided");
+
+	for (i = 0; i < CW2015_READ_TRIES; i++) {
+		ret = cw_read(cw_bat, CW2015_REG_SOC, &reg_val);
+		if (ret < 0)
+			return ret;
+		else if (reg_val <= 100) // SOC can't be more than 100 %
+			break;
+		msleep(120);
+	}
+
+	if (i >= CW2015_READ_TRIES) {
+		reg_val = CW2015_MODE_SLEEP;
+		ret = cw_write(cw_bat, CW2015_REG_MODE, reg_val);
+		cw_err(cw_bat, "Invalid state of charge indication");
+		return -EIO;
+	}
+
+	cw_dbg(cw_bat, "Battery configured");
+	return 0;
+}
+
+static int cw_por(struct cw_battery *cw_bat)
+{
+	int ret;
+	unsigned char reset_val;
+
+	reset_val = CW2015_MODE_SLEEP;
+	ret = cw_write(cw_bat, CW2015_REG_MODE, reset_val);
+	if (ret < 0)
+		return ret;
+	reset_val = CW2015_MODE_NORMAL;
+	msleep(20);
+	ret = cw_write(cw_bat, CW2015_REG_MODE, reset_val);
+	if (ret < 0)
+		return ret;
+	ret = cw_init(cw_bat);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int cw_get_capacity(struct cw_battery *cw_bat)
+{
+	int cw_capacity;
+	int ret;
+	u8 reg_val;
+
+	static int reset_loop;
+	static int charging_loop;
+	static int discharging_loop;
+	static int jump_flag;
+	static int charging_5_loop;
+	int sleep_cap;
+
+	ret = cw_read(cw_bat, CW2015_REG_SOC, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	cw_capacity = reg_val;
+
+	if ((cw_capacity < 0) || (cw_capacity > 100)) {
+		cw_err(cw_bat, "Invalid SoC, SoC = %d %%", cw_capacity);
+		reset_loop++;
+		if (reset_loop >
+		    (CW2015_BATTERY_CAPACITY_ERROR / cw_bat->monitor_sec)) {
+			cw_por(cw_bat);
+			reset_loop = 0;
+		}
+		return cw_bat->capacity;
+	}
+	reset_loop = 0;
+
+	/* case 1 : aviod swing */
+	if (((cw_bat->charger_mode > 0) &&
+	     (cw_capacity <= cw_bat->capacity - 1) &&
+	     (cw_capacity > cw_bat->capacity - 9)) ||
+	    ((cw_bat->charger_mode == 0) &&
+	     (cw_capacity == (cw_bat->capacity + 1)))) {
+		if (!(cw_capacity == 0 && cw_bat->capacity <= 2))
+			cw_capacity = cw_bat->capacity;
+	}
+
+	/* case 2 : ensure battery reaches full state */
+	if ((cw_bat->charger_mode > 0) &&
+	    (cw_capacity >= 95) && (cw_capacity <= cw_bat->capacity)) {
+		charging_loop++;
+		if (charging_loop >
+		    (CW2015_BATTERY_UP_MAX_CHANGE / cw_bat->monitor_sec)) {
+			cw_capacity = (cw_bat->capacity + 1) <= 100 ?
+				      (cw_bat->capacity + 1) : 100;
+			charging_loop = 0;
+			jump_flag = 1;
+		} else {
+			cw_capacity = cw_bat->capacity;
+		}
+	}
+
+	/* case 3 : prevent battery level from jumping to CW_BAT */
+	if ((cw_bat->charger_mode == 0) &&
+	    (cw_capacity <= cw_bat->capacity) &&
+	    (cw_capacity >= 90) && (jump_flag == 1)) {
+#ifdef CONFIG_PM
+		if (cw_bat->suspend_resume_mark == 1) {
+			cw_bat->suspend_resume_mark = 0;
+			sleep_cap = (cw_bat->after.tv_sec +
+				     discharging_loop *
+				     (cw_bat->monitor_sec / 1000)) /
+				     (CW2015_BATTERY_DOWN_MAX_CHANGE / 1000);
+			cw_dbg(cw_bat, "Estimated capacity lost during sleep: %d",
+				sleep_cap);
+
+			if (cw_capacity >= cw_bat->capacity - sleep_cap)
+				return cw_capacity;
+
+			if (!sleep_cap)
+				discharging_loop = discharging_loop +
+					1 + cw_bat->after.tv_sec /
+					(cw_bat->monitor_sec / 1000);
+			else
+				discharging_loop = 0;
+			return cw_bat->capacity - sleep_cap;
+		}
+#endif
+		discharging_loop++;
+		if (discharging_loop >
+		    (CW2015_BATTERY_DOWN_MAX_CHANGE / cw_bat->monitor_sec)) {
+			if (cw_capacity >= cw_bat->capacity - 1)
+				jump_flag = 0;
+			else
+				cw_capacity = cw_bat->capacity - 1;
+
+			discharging_loop = 0;
+		} else {
+			cw_capacity = cw_bat->capacity;
+		}
+	}
+
+	/* case 4 : reset gauge if stuck at 0% while charging */
+	if ((cw_bat->charger_mode > 0) && (cw_capacity == 0)) {
+		charging_5_loop++;
+		if (charging_5_loop >
+		    CW2015_BATTERY_CHARGING_ZERO / cw_bat->monitor_sec) {
+			cw_por(cw_bat);
+			charging_5_loop = 0;
+		}
+	} else if (charging_5_loop != 0) {
+		charging_5_loop = 0;
+	}
+#ifdef CONFIG_PM
+	if (cw_bat->suspend_resume_mark == 1)
+		cw_bat->suspend_resume_mark = 0;
+#endif
+	return cw_capacity;
+}
+
+static int cw_get_voltage(struct cw_battery *cw_bat)
+{
+	int ret, i, voltage;
+	u16 reg_val;
+	u32 avg = 0;
+
+	for (i = 0; i < CW2015_AVERAGING_SAMPLES; i++) {
+		ret = cw_read_word(cw_bat, CW2015_REG_VCELL, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		avg += reg_val;
+	}
+	avg /= 3;
+
+	voltage = avg * 312 / 1024;
+
+	cw_dbg(cw_bat, "Read voltage: %d mV, raw=0x%04x\n", voltage, reg_val);
+	return voltage;
+}
+
+static int cw_get_time_to_empty(struct cw_battery *cw_bat)
+{
+	int ret;
+	u16 value16;
+
+	ret = cw_read_word(cw_bat, CW2015_REG_RRT_ALERT, &value16);
+	if (ret < 0)
+		return ret;
+
+	return value16 & CW2015_MASK_SOC;
+}
+
+static void cw_update_charge_status(struct cw_battery *cw_bat)
+{
+	int cw_charger_mode;
+
+	cw_charger_mode = power_supply_am_i_supplied(cw_bat->rk_bat);
+	if (cw_charger_mode < 0) {
+		cw_warn(cw_bat, "Failed to get supply state: %d",
+				cw_charger_mode);
+	} else if (cw_bat->charger_mode != cw_charger_mode) {
+		cw_bat->charger_mode = cw_charger_mode;
+		cw_bat->bat_change = 1;
+		if (cw_charger_mode)
+			cw_bat->charge_count++;
+	}
+}
+
+static void cw_update_capacity(struct cw_battery *cw_bat)
+{
+	int cw_capacity;
+
+	cw_capacity = cw_get_capacity(cw_bat);
+	if (cw_capacity < 0)
+		cw_err(cw_bat, "Failed to get SoC from gauge: %d", cw_capacity);
+	else if (cw_capacity > 100)
+		cw_err(cw_bat, "Got invalid SoC from gauge: %d %%",
+			cw_capacity);
+	else if (cw_bat->capacity != cw_capacity) {
+		cw_bat->capacity = cw_capacity;
+		cw_bat->bat_change = 1;
+	}
+}
+
+static void cw_update_vol(struct cw_battery *cw_bat)
+{
+	int ret;
+
+	ret = cw_get_voltage(cw_bat);
+	if (ret < 0)
+		cw_err(cw_bat, "Failed to get voltage from gauge: %d",
+			ret);
+	else if (cw_bat->voltage != ret)
+		cw_bat->voltage = ret;
+}
+
+static void cw_update_status(struct cw_battery *cw_bat)
+{
+	int status;
+
+	if (cw_bat->charger_mode > 0) {
+		if (cw_bat->capacity >= 100)
+			status = POWER_SUPPLY_STATUS_FULL;
+		else
+			status = POWER_SUPPLY_STATUS_CHARGING;
+	} else {
+		status = POWER_SUPPLY_STATUS_DISCHARGING;
+	}
+
+	if (cw_bat->status != status) {
+		cw_bat->status = status;
+		cw_bat->bat_change = 1;
+	}
+}
+
+static void cw_update_time_to_empty(struct cw_battery *cw_bat)
+{
+	int ret;
+
+	ret = cw_get_time_to_empty(cw_bat);
+	if (ret < 0)
+		cw_err(cw_bat, "Failed to get time to empty from gauge: %d",
+			ret);
+	else if (cw_bat->time_to_empty != ret) {
+		cw_bat->time_to_empty = ret;
+		cw_bat->bat_change = 1;
+	}
+}
+
+static void cw_bat_work(struct work_struct *work)
+{
+	struct delayed_work *delay_work;
+	struct cw_battery *cw_bat;
+	int ret;
+	u8 reg_val;
+	int i = 0;
+
+	delay_work = container_of(work, struct delayed_work, work);
+	cw_bat =
+		container_of(delay_work, struct cw_battery, battery_delay_work);
+
+	ret = cw_read(cw_bat, CW2015_REG_MODE, &reg_val);
+	if (ret < 0) {
+		cw_err(cw_bat, "Failed to read mode from gauge: %d", ret);
+	} else {
+		if ((reg_val & CW2015_MODE_SLEEP_MASK) == CW2015_MODE_SLEEP) {
+			for (i = 0; i < CW2015_RESET_TRIES; i++) {
+				if (cw_por(cw_bat) == 0)
+					break;
+			}
+		}
+		cw_update_capacity(cw_bat);
+		cw_update_vol(cw_bat);
+		cw_update_charge_status(cw_bat);
+		cw_update_status(cw_bat);
+		cw_update_time_to_empty(cw_bat);
+	}
+	cw_dbg(cw_bat, "charger_mode = %d", cw_bat->charger_mode);
+	cw_dbg(cw_bat, "status = %d", cw_bat->status);
+	cw_dbg(cw_bat, "capacity = %d", cw_bat->capacity);
+	cw_dbg(cw_bat, "voltage = %d", cw_bat->voltage);
+
+#ifdef CONFIG_PM
+	if (cw_bat->suspend_resume_mark == 1)
+		cw_bat->suspend_resume_mark = 0;
+#endif
+
+	if (cw_bat->bat_change == 1) {
+		power_supply_changed(cw_bat->rk_bat);
+		cw_bat->bat_change = 0;
+	}
+	queue_delayed_work(cw_bat->battery_workqueue,
+			   &cw_bat->battery_delay_work,
+			   msecs_to_jiffies(cw_bat->monitor_sec));
+}
+
+static bool cw_battery_valid_time_to_empty(struct cw_battery *cw_bat)
+{
+	return cw_bat->time_to_empty > 0 &&
+		cw_bat->time_to_empty < CW2015_MASK_SOC &&
+		cw_bat->status == POWER_SUPPLY_STATUS_DISCHARGING;
+}
+
+static int cw_battery_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	int ret = 0;
+	struct cw_battery *cw_bat;
+
+	cw_bat = power_supply_get_drvdata(psy);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = cw_bat->capacity;
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = cw_bat->status;
+		break;
+
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = cw_bat->voltage <= 0 ? 0 : 1;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = cw_bat->voltage * 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		if (cw_battery_valid_time_to_empty(cw_bat))
+			val->intval = cw_bat->time_to_empty;
+		else
+			val->intval = 0;
+		break;
+
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
+		val->intval = cw_bat->charge_count;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		if (cw_bat->battery.charge_full_design_uah > 0)
+			val->intval = cw_bat->battery.charge_full_design_uah;
+		else
+			val->intval = 0;
+		break;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (cw_battery_valid_time_to_empty(cw_bat) &&
+			cw_bat->battery.charge_full_design_uah > 0) {
+			// calculate remaining capacity
+			val->intval = cw_bat->battery.charge_full_design_uah;
+			val->intval = val->intval * cw_bat->capacity / 100;
+
+			// estimate current based on time to empty (in minutes)
+			val->intval = 60 * val->intval / cw_bat->time_to_empty;
+		} else {
+			val->intval = 0;
+		}
+
+		break;
+
+	default:
+		break;
+	}
+	return ret;
+}
+
+static enum power_supply_property cw_battery_properties[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_COUNTER,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static const struct power_supply_desc cw2015_bat_desc = {
+	.name		= "cw2015-battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= cw_battery_properties,
+	.num_properties	= ARRAY_SIZE(cw_battery_properties),
+	.get_property	= cw_battery_get_property,
+};
+
+#ifdef CONFIG_OF
+static int cw2015_parse_dt(struct cw_battery *cw_bat)
+{
+	struct device *dev = &cw_bat->client->dev;
+	struct device_node *node = dev->of_node;
+	struct property *prop;
+	int length;
+	u32 value;
+	int ret;
+
+	if (!node)
+		return -ENODEV;
+
+	prop = of_find_property(node, PREFIX"bat-config-info", &length);
+	if (prop) {
+		if (length != CW2015_SIZE_BATINFO) {
+			cw_err(cw_bat, "bat-config-info must be %d bytes",
+				CW2015_SIZE_BATINFO);
+			return -EINVAL;
+		}
+
+		cw_bat->bat_config_info =
+			devm_kzalloc(dev, CW2015_SIZE_BATINFO, GFP_KERNEL);
+		if (!cw_bat->bat_config_info) {
+			cw_err(cw_bat,
+				"Failed to allocate memory for battery config info");
+			return -ENOMEM;
+		}
+
+		ret = of_property_read_u8_array(node, PREFIX"bat-config-info",
+						 cw_bat->bat_config_info,
+						 CW2015_SIZE_BATINFO);
+		if (ret < 0)
+			return ret;
+	} else
+		cw_warn(cw_bat,
+			"No bat-config-info found, rolling with current flash contents");
+
+	cw_bat->monitor_sec = CW2015_DEFAULT_MONITOR_MS;
+
+	ret = of_property_read_u32(node, PREFIX"monitor-interval-ms", &value);
+	if (ret >= 0) {
+		cw_dbg(cw_bat, "Overriding default monitor-interval with %u ms",
+			value);
+		cw_bat->monitor_sec = value;
+	}
+
+	return 0;
+}
+#else
+static int cw2015_parse_dt(struct cw_battery *cw_bat)
+{
+	return -ENODEV;
+}
+#endif
+
+static const struct regmap_range regmap_ranges_rd_yes[] = {
+	regmap_reg_range(CW2015_REG_VERSION, CW2015_REG_VERSION),
+	regmap_reg_range(CW2015_REG_VCELL, CW2015_REG_CONFIG),
+	regmap_reg_range(CW2015_REG_MODE, CW2015_REG_MODE),
+	regmap_reg_range(CW2015_REG_BATINFO, CW2015_REG_BATINFO +
+				CW2015_SIZE_BATINFO - 1),
+};
+
+static const struct regmap_access_table regmap_rd_table = {
+	.yes_ranges = regmap_ranges_rd_yes,
+	.n_yes_ranges = 4,
+};
+
+static const struct regmap_range regmap_ranges_wr_yes[] = {
+	regmap_reg_range(CW2015_REG_RRT_ALERT, CW2015_REG_CONFIG),
+	regmap_reg_range(CW2015_REG_MODE, CW2015_REG_MODE),
+	regmap_reg_range(CW2015_REG_BATINFO, CW2015_REG_BATINFO +
+				CW2015_SIZE_BATINFO - 1),
+};
+
+static const struct regmap_access_table regmap_wr_table = {
+	.yes_ranges = regmap_ranges_wr_yes,
+	.n_yes_ranges = 3,
+};
+
+static const struct regmap_range regmap_ranges_vol_yes[] = {
+	regmap_reg_range(CW2015_REG_VCELL, CW2015_REG_SOC + 1),
+};
+
+static const struct regmap_access_table regmap_vol_table = {
+	.yes_ranges = regmap_ranges_vol_yes,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config cw2015_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &regmap_rd_table,
+	.wr_table = &regmap_wr_table,
+	.volatile_table = &regmap_vol_table,
+	.max_register = CW2015_REG_BATINFO + CW2015_SIZE_BATINFO - 1,
+};
+
+static int cw_bat_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	int ret;
+	struct cw_battery *cw_bat;
+	struct power_supply_config psy_cfg = {0};
+
+	cw_bat = devm_kzalloc(&client->dev, sizeof(*cw_bat), GFP_KERNEL);
+	if (!cw_bat)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, cw_bat);
+	cw_bat->client = client;
+
+	ret = cw2015_parse_dt(cw_bat);
+	if (ret < 0) {
+		cw_err(cw_bat, "Failed to parse cw2015 dt data");
+		return ret;
+	}
+
+	cw_bat->capacity = 1;
+	cw_bat->voltage = 0;
+	cw_bat->status = 0;
+	cw_bat->suspend_resume_mark = 0;
+	cw_bat->charger_mode = 0;
+	cw_bat->bat_change = 0;
+
+	cw_bat->regmap = devm_regmap_init_i2c(client, &cw2015_regmap_config);
+	if (IS_ERR(cw_bat->regmap)) {
+		cw_err(cw_bat, "Failed to allocate regmap: %ld",
+			PTR_ERR(cw_bat->regmap));
+		return PTR_ERR(cw_bat->regmap);
+	}
+
+	ret = cw_init(cw_bat);
+	if (ret) {
+		cw_err(cw_bat, "Init failed: %d", ret);
+		return ret;
+	}
+
+	psy_cfg.drv_data = cw_bat;
+	psy_cfg.of_node = client->dev.of_node;
+
+	cw_bat->rk_bat = devm_power_supply_register(&client->dev,
+		&cw2015_bat_desc, &psy_cfg);
+	if (IS_ERR(cw_bat->rk_bat)) {
+		cw_err(cw_bat, "Failed to register power supply");
+		return -1;
+	}
+
+	ret = power_supply_get_battery_info(cw_bat->rk_bat, &cw_bat->battery);
+	if (ret) {
+		cw_warn(cw_bat,
+			"No monitored battery, some properties will be missing");
+	}
+
+	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
+	INIT_DELAYED_WORK(&cw_bat->battery_delay_work, cw_bat_work);
+	queue_delayed_work(cw_bat->battery_workqueue,
+			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
+
+	cw_dbg(cw_bat, "cw2015/cw2013 driver probe success");
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int cw_bat_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cw_battery *cw_bat = i2c_get_clientdata(client);
+
+	ktime_get_boottime_ts64(&cw_bat->suspend_time_before);
+	cancel_delayed_work_sync(&cw_bat->battery_delay_work);
+	return 0;
+}
+
+static int cw_bat_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct cw_battery *cw_bat = i2c_get_clientdata(client);
+
+	cw_bat->suspend_resume_mark = 1;
+	ktime_get_boottime_ts64(&cw_bat->after);
+	cw_bat->after = timespec64_sub(cw_bat->after,
+				     cw_bat->suspend_time_before);
+	queue_delayed_work(cw_bat->battery_workqueue,
+			   &cw_bat->battery_delay_work, msecs_to_jiffies(2));
+	return 0;
+}
+
+static const struct dev_pm_ops cw_bat_pm_ops = {
+	.suspend  = cw_bat_suspend,
+	.resume   = cw_bat_resume,
+};
+#endif
+
+static int cw_bat_remove(struct i2c_client *client)
+{
+	struct cw_battery *cw_bat = i2c_get_clientdata(client);
+
+	cw_dbg(cw_bat, "Removing device");
+	cancel_delayed_work(&cw_bat->battery_delay_work);
+	power_supply_put_battery_info(cw_bat->rk_bat, &cw_bat->battery);
+	return 0;
+}
+
+static const struct i2c_device_id cw_bat_id_table[] = {
+	{ "cw2015", 0 },
+	{}
+};
+
+static const struct of_device_id cw2015_of_match[] = {
+	{ .compatible = PREFIX"cw2015" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cw2015_of_match);
+
+static struct i2c_driver cw_bat_driver = {
+	.driver = {
+		.name = "cw2015",
+#ifdef CONFIG_PM
+		.pm = &cw_bat_pm_ops,
+#endif
+	},
+	.probe = cw_bat_probe,
+	.remove = cw_bat_remove,
+	.id_table = cw_bat_id_table,
+};
+
+module_i2c_driver(cw_bat_driver);
+
+MODULE_AUTHOR("xhc<xhc@rock-chips.com>");
+MODULE_AUTHOR("Tobias Schramm <t.schramm@manjaro.org>");
+MODULE_DESCRIPTION("cw2015/cw2013 battery driver");
+MODULE_LICENSE("GPL");
-- 
2.24.1

