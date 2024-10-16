Return-Path: <linux-pm+bounces-15743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A816A9A039C
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 10:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3262B26B30
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331A1D54E7;
	Wed, 16 Oct 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="rR9B9E25"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499161D27A4;
	Wed, 16 Oct 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065813; cv=none; b=a97z/ypon48ZeM2+CxmL0g6/2IpqAmh4VMSONJXORxvVpBiO6RZoztHHLJ4ELbm6LgZaFQLxCL15uY11VYTD8bAnyLYLylKz212Ev0XVHrfPVOXhspWQf0aQJe+P03DI8FL87z6L9kl+6Erwo+dxrnDtRVV2N6N3jqaEzeQq/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065813; c=relaxed/simple;
	bh=miO95E1w/yy7h2eiR0G+9OwWCv4EOd7vVcw2Vmv4rAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D73lPqkMxu81zUevxBwwJ45XnGMbmi4W/vJybFX4cY9ecE0L9VYkTxNNszOl0ODTjO5CjQYaaMUJ/+wEW+d1o3upXSQ3TpVdejxHuujQADOiCPZp8zyw3D6X3z8xB2CjaaweDj3DOe5WTc6+m7LG2nyZJBzrNxaCTRTm6oD7l1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=rR9B9E25; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tvZDHHQjAu3gWPeojLD7DKVEdsODfgId+nLTTruTR7M=; b=rR9B9E25hlvsQlzgL3GYfjcJw8
	tCq5SFi9xBp5jQ9jay3uMCNQsFTb5Il5Kt9oUx9Oy4w8mM3z+XOWus391Y5PiCYurQtLgnJZkRygM
	joFUsDb3lOqeTBKW65oyTWJOmVNn6MDcTgwVH0dWQEogd4z6LD8c2DInUk8Oh5Ei66QDX2f69FuyZ
	OKmIQyn0NESlNElJKLhQH+nVTyZg9vtDYL6FhDIaM++8f5TS2JtGe6ahlzKD1i1fnZhbNHdMksQ/U
	oD7qF0xtsqOTwfquaWVGpygpQMj1jm32uE/rKJsY84WuF1kbz2rKPkc+wkdvw7DZOYAnm03K2XzN5
	FCrwJO7g==;
From: Andreas Kemnade <andreas@kemnade.info>
To: khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	tony@atomide.com,
	linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 2/3] power: supply: initial support for TWL6030/32
Date: Wed, 16 Oct 2024 10:03:13 +0200
Message-Id: <20241016080314.222674-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016080314.222674-1-andreas@kemnade.info>
References: <20241016080314.222674-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the charger in the TWL6030/32. For now it does not report
much in sysfs but parameters are set up for USB, charging is enabled with
the specified parameters. It stops charging when full and also restarts
charging.
This prevents ending up in a system setup where you run out of battery
although a charger is plugged in after precharge completed.

Battery voltage behavior was checked via the GPADC.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/Kconfig           |  10 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/twl6030_charger.c | 581 +++++++++++++++++++++++++
 3 files changed, 592 insertions(+)
 create mode 100644 drivers/power/supply/twl6030_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index bcfa63fb9f1e2..9f2eef6787f7a 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -493,6 +493,16 @@ config CHARGER_TWL4030
 	help
 	  Say Y here to enable support for TWL4030 Battery Charge Interface.
 
+config CHARGER_TWL6030
+	tristate "OMAP TWL6030 BCI charger driver"
+	depends on IIO && TWL4030_CORE
+	help
+	  Say Y here to enable support for TWL6030/6032 Battery Charge
+	  Interface.
+
+	  This driver can be build as a module. If so, the module will be
+	  called twl6030_charger.
+
 config CHARGER_LP8727
 	tristate "TI/National Semiconductor LP8727 charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 8dcb415453171..59c4a9f40d28a 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
 obj-$(CONFIG_CHARGER_ISP1704)	+= isp1704_charger.o
 obj-$(CONFIG_CHARGER_MAX8903)	+= max8903_charger.o
 obj-$(CONFIG_CHARGER_TWL4030)	+= twl4030_charger.o
+obj-$(CONFIG_CHARGER_TWL6030)	+= twl6030_charger.o
 obj-$(CONFIG_CHARGER_LP8727)	+= lp8727_charger.o
 obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
diff --git a/drivers/power/supply/twl6030_charger.c b/drivers/power/supply/twl6030_charger.c
new file mode 100644
index 0000000000000..b4ec26ff257cc
--- /dev/null
+++ b/drivers/power/supply/twl6030_charger.c
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TWL6030 charger
+ *
+ * Copyright (C) 2024 Andreas Kemnade <andreas@kemnade.info>
+ *
+ * based on older 6030 driver found in a v3.0 vendor kernel
+ *
+ * based on twl4030_bci_battery.c by TI
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/bits.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/twl.h>
+#include <linux/power_supply.h>
+#include <linux/notifier.h>
+#include <linux/usb/otg.h>
+#include <linux/iio/consumer.h>
+#include <linux/devm-helpers.h>
+
+#define CONTROLLER_INT_MASK	0x00
+#define CONTROLLER_CTRL1	0x01
+#define CONTROLLER_WDG		0x02
+#define CONTROLLER_STAT1	0x03
+#define CHARGERUSB_INT_STATUS	0x04
+#define CHARGERUSB_INT_MASK	0x05
+#define CHARGERUSB_STATUS_INT1	0x06
+#define CHARGERUSB_STATUS_INT2	0x07
+#define CHARGERUSB_CTRL1	0x08
+#define CHARGERUSB_CTRL2	0x09
+#define CHARGERUSB_CTRL3	0x0A
+#define CHARGERUSB_STAT1	0x0B
+#define CHARGERUSB_VOREG	0x0C
+#define CHARGERUSB_VICHRG	0x0D
+#define CHARGERUSB_CINLIMIT	0x0E
+#define CHARGERUSB_CTRLLIMIT1	0x0F
+#define CHARGERUSB_CTRLLIMIT2	0x10
+#define ANTICOLLAPSE_CTRL1	0x11
+#define ANTICOLLAPSE_CTRL2	0x12
+
+/* TWL6032 registers 0xDA to 0xDE - TWL6032_MODULE_CHARGER */
+#define CONTROLLER_CTRL2	0x00
+#define CONTROLLER_VSEL_COMP	0x01
+#define CHARGERUSB_VSYSREG	0x02
+#define CHARGERUSB_VICHRG_PC	0x03
+#define LINEAR_CHRG_STS		0x04
+
+#define LINEAR_CHRG_STS_CRYSTL_OSC_OK	0x40
+#define LINEAR_CHRG_STS_END_OF_CHARGE	0x20
+#define LINEAR_CHRG_STS_VBATOV		0x10
+#define LINEAR_CHRG_STS_VSYSOV		0x08
+#define LINEAR_CHRG_STS_DPPM_STS	0x04
+#define LINEAR_CHRG_STS_CV_STS		0x02
+#define LINEAR_CHRG_STS_CC_STS		0x01
+
+#define FG_REG_00	0x00
+#define FG_REG_01	0x01
+#define FG_REG_02	0x02
+#define FG_REG_03	0x03
+#define FG_REG_04	0x04
+#define FG_REG_05	0x05
+#define FG_REG_06	0x06
+#define FG_REG_07	0x07
+#define FG_REG_08	0x08
+#define FG_REG_09	0x09
+#define FG_REG_10	0x0A
+#define FG_REG_11	0x0B
+
+/* CONTROLLER_INT_MASK */
+#define MVAC_FAULT		BIT(7)
+#define MAC_EOC			BIT(6)
+#define LINCH_GATED		BIT(5)
+#define MBAT_REMOVED		BIT(4)
+#define MFAULT_WDG		BIT(3)
+#define MBAT_TEMP		BIT(2)
+#define MVBUS_DET		BIT(1)
+#define MVAC_DET		BIT(0)
+
+/* CONTROLLER_CTRL1 */
+#define CONTROLLER_CTRL1_EN_LINCH	BIT(5)
+#define CONTROLLER_CTRL1_EN_CHARGER	BIT(4)
+#define CONTROLLER_CTRL1_SEL_CHARGER	BIT(3)
+
+/* CONTROLLER_STAT1 */
+#define CONTROLLER_STAT1_EXTCHRG_STATZ	BIT(7)
+#define CONTROLLER_STAT1_LINCH_GATED	BIT(6)
+#define CONTROLLER_STAT1_CHRG_DET_N	BIT(5)
+#define CONTROLLER_STAT1_FAULT_WDG	BIT(4)
+#define CONTROLLER_STAT1_VAC_DET	BIT(3)
+#define VAC_DET	BIT(3)
+#define CONTROLLER_STAT1_VBUS_DET	BIT(2)
+#define VBUS_DET	BIT(2)
+#define CONTROLLER_STAT1_BAT_REMOVED	BIT(1)
+#define CONTROLLER_STAT1_BAT_TEMP_OVRANGE BIT(0)
+
+/* CHARGERUSB_INT_STATUS */
+#define EN_LINCH		BIT(4)
+#define CURRENT_TERM_INT	BIT(3)
+#define CHARGERUSB_STAT		BIT(2)
+#define CHARGERUSB_THMREG	BIT(1)
+#define CHARGERUSB_FAULT	BIT(0)
+
+/* CHARGERUSB_INT_MASK */
+#define MASK_MCURRENT_TERM		BIT(3)
+#define MASK_MCHARGERUSB_STAT		BIT(2)
+#define MASK_MCHARGERUSB_THMREG		BIT(1)
+#define MASK_MCHARGERUSB_FAULT		BIT(0)
+
+/* CHARGERUSB_STATUS_INT1 */
+#define CHARGERUSB_STATUS_INT1_TMREG	BIT(7)
+#define CHARGERUSB_STATUS_INT1_NO_BAT	BIT(6)
+#define CHARGERUSB_STATUS_INT1_BST_OCP	BIT(5)
+#define CHARGERUSB_STATUS_INT1_TH_SHUTD	BIT(4)
+#define CHARGERUSB_STATUS_INT1_BAT_OVP	BIT(3)
+#define CHARGERUSB_STATUS_INT1_POOR_SRC	BIT(2)
+#define CHARGERUSB_STATUS_INT1_SLP_MODE	BIT(1)
+#define CHARGERUSB_STATUS_INT1_VBUS_OVP	BIT(0)
+
+/* CHARGERUSB_STATUS_INT2 */
+#define ICCLOOP		BIT(3)
+#define CURRENT_TERM	BIT(2)
+#define CHARGE_DONE	BIT(1)
+#define ANTICOLLAPSE	BIT(0)
+
+/* CHARGERUSB_CTRL1 */
+#define SUSPEND_BOOT	BIT(7)
+#define OPA_MODE	BIT(6)
+#define HZ_MODE		BIT(5)
+#define TERM		BIT(4)
+
+/* CHARGERUSB_CTRL2 */
+#define UA_TO_VITERM(x) (((x) / 50000 - 1) << 5)
+
+/* CHARGERUSB_CTRL3 */
+#define VBUSCHRG_LDO_OVRD	BIT(7)
+#define CHARGE_ONCE		BIT(6)
+#define BST_HW_PR_DIS		BIT(5)
+#define AUTOSUPPLY		BIT(3)
+#define BUCK_HSILIM		BIT(0)
+
+/* CHARGERUSB_VOREG */
+#define UV_TO_VOREG(x) (((x) - 3500000) / 20000)
+#define VOREG_TO_UV(x) (((x) & 0x3F) * 20000 + 3500000)
+#define CHARGERUSB_VOREG_3P52		0x01
+#define CHARGERUSB_VOREG_4P0		0x19
+#define CHARGERUSB_VOREG_4P2		0x23
+#define CHARGERUSB_VOREG_4P76		0x3F
+
+/* CHARGERUSB_VICHRG */
+/*
+ * might be inaccurate for < 500 mA, diffent scale might apply,
+ * either starting from 100 mA or 300 mA
+ */
+#define UA_TO_VICHRG(x) (((x) / 100000) - 1)
+#define VICHRG_TO_UA(x) (((x) & 0xf) * 100000 + 100000)
+
+/* CHARGERUSB_CINLIMIT */
+#define CHARGERUSB_CIN_LIMIT_100	0x1
+#define CHARGERUSB_CIN_LIMIT_300	0x5
+#define CHARGERUSB_CIN_LIMIT_500	0x9
+#define CHARGERUSB_CIN_LIMIT_NONE	0xF
+
+/* CHARGERUSB_CTRLLIMIT2 */
+#define CHARGERUSB_CTRLLIMIT2_1500	0x0E
+#define		LOCK_LIMIT		BIT(4)
+
+/* ANTICOLLAPSE_CTRL2 */
+#define BUCK_VTH_SHIFT			5
+
+/* FG_REG_00 */
+#define CC_ACTIVE_MODE_SHIFT	6
+#define CC_AUTOCLEAR		BIT(2)
+#define CC_CAL_EN		BIT(1)
+#define CC_PAUSE		BIT(0)
+
+#define REG_TOGGLE1		0x90
+#define REG_PWDNSTATUS1		0x93
+#define FGDITHS			BIT(7)
+#define FGDITHR			BIT(6)
+#define FGS			BIT(5)
+#define FGR			BIT(4)
+#define BBSPOR_CFG		0xE6
+#define	BB_CHG_EN		BIT(3)
+
+struct twl6030_charger_info {
+	struct device		*dev;
+	struct power_supply	*usb;
+	struct power_supply_battery_info *binfo;
+	struct work_struct	work;
+	int			irq_chg;
+	int			input_current_limit;
+	struct iio_channel	*channel_vusb;
+	struct delayed_work	charger_monitor;
+	bool			extended_current_range;
+};
+
+struct twl6030_charger_chip_data {
+	bool extended_current_range;
+};
+
+static int twl6030_charger_read(u8 reg, u8 *val)
+{
+	return twl_i2c_read_u8(TWL_MODULE_MAIN_CHARGE, val, reg);
+}
+
+static int twl6030_charger_write(u8 reg, u8 val)
+{
+	return twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, val, reg);
+}
+
+static int twl6030_config_cinlimit_reg(struct twl6030_charger_info *charger,
+				       unsigned int ua)
+{
+	if (ua >= 50000 && ua <= 750000) {
+		ua = (ua - 50000) / 50000;
+	} else if ((ua > 750000) && (ua <= 1500000) && charger->extended_current_range) {
+		ua = ((ua % 100000) ? 0x30 : 0x20) + ((ua - 100000) / 100000);
+	} else {
+		if (ua < 50000) {
+			dev_err(charger->dev, "invalid input current limit\n");
+			return -EINVAL;
+		}
+		/* This is no current limit */
+		ua = 0x0F;
+	}
+
+	return twl6030_charger_write(CHARGERUSB_CINLIMIT, ua);
+}
+
+/*
+ * rewriting all stuff here, resets to extremely conservative defaults were
+ * seen under some circumstances, like charge voltage to 3.5V
+ */
+static int twl6030_enable_usb(struct twl6030_charger_info *charger)
+{
+	int ret;
+
+	ret = twl6030_charger_write(CHARGERUSB_VICHRG,
+				    UA_TO_VICHRG(charger->binfo->constant_charge_current_max_ua));
+	if (ret < 0)
+		return ret;
+
+	ret = twl6030_charger_write(CONTROLLER_WDG, 0xff);
+	if (ret < 0)
+		return ret;
+
+	charger->input_current_limit = 500000;
+	ret = twl6030_config_cinlimit_reg(charger, charger->input_current_limit);
+	if (ret < 0)
+		return ret;
+
+	ret = twl6030_charger_write(CHARGERUSB_CINLIMIT, CHARGERUSB_CIN_LIMIT_500);
+	if (ret < 0)
+		return ret;
+
+	ret = twl6030_charger_write(CHARGERUSB_VOREG,
+				    UV_TO_VOREG(charger->binfo->constant_charge_voltage_max_uv));
+	if (ret < 0)
+		return ret;
+
+	ret = twl6030_charger_write(CHARGERUSB_CTRL1, TERM);
+	if (ret < 0)
+		return ret;
+
+	if (charger->binfo->charge_term_current_ua != -EINVAL) {
+		ret = twl6030_charger_write(CHARGERUSB_CTRL2,
+					    UA_TO_VITERM(charger->binfo->charge_term_current_ua));
+		if (ret < 0)
+			return ret;
+	}
+
+	return twl6030_charger_write(CONTROLLER_CTRL1, CONTROLLER_CTRL1_EN_CHARGER);
+}
+
+static void twl6030_charger_wdg(struct work_struct *data)
+{
+	struct twl6030_charger_info *charger =
+		container_of(data, struct twl6030_charger_info,
+			     charger_monitor.work);
+
+	u8 val;
+	u8 int_stat;
+	u8 stat_int1;
+	u8 stat_int2;
+
+	twl6030_charger_read(CONTROLLER_STAT1, &val);
+	twl6030_charger_read(CHARGERUSB_INT_STATUS, &int_stat);
+	twl6030_charger_read(CHARGERUSB_STATUS_INT1, &stat_int1);
+	twl6030_charger_read(CHARGERUSB_STATUS_INT2, &stat_int2);
+	dev_dbg(charger->dev,
+		"wdg: stat1: %02x %s INT_STATUS %02x STATUS_INT1 %02x STATUS_INT2 %02x\n",
+		val, (val & VBUS_DET) ? "usb online" :  "usb offline",
+		int_stat, stat_int1, stat_int2);
+
+	twl6030_charger_write(CONTROLLER_WDG, 0xff);
+	schedule_delayed_work(&charger->charger_monitor,
+			      msecs_to_jiffies(10000));
+}
+
+static irqreturn_t twl6030_charger_interrupt(int irq, void *arg)
+{
+	struct twl6030_charger_info *charger = arg;
+	u8 val;
+	u8 int_stat;
+	u8 stat_int1;
+	u8 stat_int2;
+
+	if (twl6030_charger_read(CONTROLLER_STAT1, &val) < 0)
+		return IRQ_HANDLED;
+
+	if (twl6030_charger_read(CHARGERUSB_INT_STATUS, &int_stat) < 0)
+		return IRQ_HANDLED;
+
+	if (twl6030_charger_read(CHARGERUSB_STATUS_INT1, &stat_int1) < 0)
+		return IRQ_HANDLED;
+
+	if (twl6030_charger_read(CHARGERUSB_STATUS_INT2, &stat_int2) < 0)
+		return IRQ_HANDLED;
+
+	dev_dbg(charger->dev,
+		"charger irq: stat1: %02x %s INT_STATUS %02x STATUS_INT1 %02x STATUS_INT2 %02x\n",
+		val, (val & VBUS_DET) ? "usb online" :  "usb offline",
+		int_stat, stat_int1, stat_int2);
+	power_supply_changed(charger->usb);
+
+	if (val & VBUS_DET) {
+		if (twl6030_charger_read(CONTROLLER_CTRL1, &val) < 0)
+			return IRQ_HANDLED;
+
+		if (!(val & CONTROLLER_CTRL1_EN_CHARGER)) {
+			if (twl6030_enable_usb(charger) < 0)
+				return IRQ_HANDLED;
+
+			schedule_delayed_work(&charger->charger_monitor,
+					      msecs_to_jiffies(10000));
+		}
+	} else {
+		cancel_delayed_work(&charger->charger_monitor);
+	}
+	return IRQ_HANDLED;
+}
+
+static int twl6030_charger_usb_get_property(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val)
+{
+	struct twl6030_charger_info *charger = power_supply_get_drvdata(psy);
+	int ret;
+	u8 stat1;
+	u8 intstat;
+
+	ret = twl6030_charger_read(CONTROLLER_STAT1, &stat1);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!(stat1 & VBUS_DET)) {
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		}
+		ret = twl6030_charger_read(CHARGERUSB_STATUS_INT2, &intstat);
+		if (ret)
+			return ret;
+
+		if (intstat & CHARGE_DONE)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (intstat & CURRENT_TERM)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (!charger->channel_vusb)
+			return -ENODATA;
+
+		ret = iio_read_channel_processed_scale(charger->channel_vusb, &val->intval, 1000);
+		if (ret < 0)
+			return ret;
+
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = !!(stat1 & VBUS_DET);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval = charger->input_current_limit;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int twl6030_charger_usb_set_property(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    const union power_supply_propval *val)
+{
+	struct twl6030_charger_info *charger = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		charger->input_current_limit = val->intval;
+		return twl6030_config_cinlimit_reg(charger, charger->input_current_limit);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int twl6030_charger_usb_property_is_writeable(struct power_supply *psy,
+						     enum power_supply_property psp)
+{
+	dev_info(&psy->dev, "is %d writeable?\n", (int)psp);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static enum power_supply_property twl6030_charger_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
+static const struct power_supply_desc twl6030_charger_usb_desc = {
+	.name		= "twl6030_usb",
+	.type		= POWER_SUPPLY_TYPE_USB,
+	.properties	= twl6030_charger_props,
+	.num_properties	= ARRAY_SIZE(twl6030_charger_props),
+	.get_property	= twl6030_charger_usb_get_property,
+	.set_property	= twl6030_charger_usb_set_property,
+	.property_is_writeable	= twl6030_charger_usb_property_is_writeable,
+};
+
+static int twl6030_charger_probe(struct platform_device *pdev)
+{
+	struct twl6030_charger_info *charger;
+	const struct twl6030_charger_chip_data *chip_data;
+	struct power_supply_config psy_cfg = {};
+	int ret;
+	u8 val;
+
+	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
+	if (!charger)
+		return -ENOMEM;
+
+	charger->dev = &pdev->dev;
+	charger->irq_chg = platform_get_irq(pdev, 0);
+
+	chip_data = device_get_match_data(&pdev->dev);
+	if (!chip_data)
+		return dev_err_probe(&pdev->dev, -EINVAL, "missing chip data\n");
+
+	charger->extended_current_range = chip_data->extended_current_range;
+	platform_set_drvdata(pdev, charger);
+	psy_cfg.drv_data = charger;
+	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
+
+	charger->channel_vusb = devm_iio_channel_get(&pdev->dev, "vusb");
+	if (IS_ERR(charger->channel_vusb)) {
+		ret = PTR_ERR(charger->channel_vusb);
+		if (ret == -EPROBE_DEFER)
+			return ret;	/* iio not ready */
+		dev_warn(&pdev->dev, "could not request vusb iio channel (%d)",
+			 ret);
+		charger->channel_vusb = NULL;
+	}
+
+	charger->usb = devm_power_supply_register(&pdev->dev,
+						  &twl6030_charger_usb_desc,
+						  &psy_cfg);
+	if (IS_ERR(charger->usb))
+		return dev_err_probe(&pdev->dev, PTR_ERR(charger->usb),
+				     "Failed to register usb\n");
+
+	ret = power_supply_get_battery_info(charger->usb, &charger->binfo);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get battery info\n");
+
+	dev_info(&pdev->dev, "battery with vmax %d imax: %d\n",
+		 charger->binfo->constant_charge_voltage_max_uv,
+		 charger->binfo->constant_charge_current_max_ua);
+
+	if (charger->binfo->constant_charge_voltage_max_uv == -EINVAL) {
+		ret = twl6030_charger_read(CHARGERUSB_CTRLLIMIT1, &val);
+		if (ret < 0)
+			return ret;
+
+		charger->binfo->constant_charge_voltage_max_uv =
+			VOREG_TO_UV(val);
+	}
+
+	if (charger->binfo->constant_charge_voltage_max_uv > 4760000 ||
+	    charger->binfo->constant_charge_voltage_max_uv < 350000)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid charge voltage\n");
+
+	if (charger->binfo->constant_charge_current_max_ua == -EINVAL) {
+		ret = twl6030_charger_read(CHARGERUSB_CTRLLIMIT2, &val);
+		if (ret < 0)
+			return ret;
+
+		charger->binfo->constant_charge_current_max_ua = VICHRG_TO_UA(val);
+	}
+
+	if (charger->binfo->constant_charge_current_max_ua < 100000 ||
+	    charger->binfo->constant_charge_current_max_ua > 1500000) {
+		return dev_err_probe(&pdev->dev, -EINVAL,
+			 "Invalid charge current\n");
+	}
+
+	if ((charger->binfo->charge_term_current_ua != -EINVAL) &&
+	    (charger->binfo->charge_term_current_ua > 400000 ||
+	     charger->binfo->charge_term_current_ua < 50000)) {
+		return dev_err_probe(&pdev->dev, -EINVAL,
+			"Invalid charge termination current\n");
+	}
+
+	ret = devm_delayed_work_autocancel(&pdev->dev,
+					   &charger->charger_monitor,
+					   twl6030_charger_wdg);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to register delayed work\n");
+
+	ret = devm_request_threaded_irq(&pdev->dev, charger->irq_chg, NULL,
+					twl6030_charger_interrupt,
+					IRQF_ONESHOT, pdev->name,
+					charger);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not request irq %d\n",
+				     charger->irq_chg);
+
+	/* turing to charging to configure things */
+	twl6030_charger_write(CONTROLLER_CTRL1, 0);
+	twl6030_charger_interrupt(0, charger);
+
+	return 0;
+}
+
+static const struct twl6030_charger_chip_data twl6030_data = {
+	.extended_current_range = false,
+};
+
+static const struct twl6030_charger_chip_data twl6032_data = {
+	.extended_current_range = true,
+};
+
+static const struct of_device_id twl_charger_of_match[] = {
+	{.compatible = "ti,twl6030-charger", .data = &twl6030_data},
+	{.compatible = "ti,twl6032-charger", .data = &twl6032_data},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, twl_charger_of_match);
+
+static struct platform_driver twl6030_charger_driver = {
+	.probe = twl6030_charger_probe,
+	.driver	= {
+		.name	= "twl6030_charger",
+		.of_match_table = twl_charger_of_match,
+	},
+};
+module_platform_driver(twl6030_charger_driver);
+
+MODULE_DESCRIPTION("TWL6030 Battery Charger Interface driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2


