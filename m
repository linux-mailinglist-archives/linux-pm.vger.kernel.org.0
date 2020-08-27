Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AED254B97
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgH0RIZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0RIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 13:08:21 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4FC061264;
        Thu, 27 Aug 2020 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iVlPsWdtIxkxQIFVimWL3fr0+CpQPtHopbFOBBcOtf8=; b=KlNy9ys2jKPqmup9LrSTsbiTer
        B8otHe+V0vlP0IgXNB+i4hUG6Dq11+061RSvsTkPrBpsai3yJ5EZvscxuv1fDwSsap4Qe5O8WJGc6
        MtfRBXtoYs4/+MHhOM6h36cuu9HJw9Fse8STZdal++pdjXvEJEg/C1bL7e0VslsdkQiE=;
Received: from p200300ccff0df1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:f100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kBLNo-0001J5-9u; Thu, 27 Aug 2020 19:08:16 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kBLNn-0003Ay-Ku; Thu, 27 Aug 2020 19:08:15 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] power: supply: Add support for RN5T618/RC5T619 charger and fuel gauge
Date:   Thu, 27 Aug 2020 19:07:13 +0200
Message-Id: <20200827170713.12142-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Both chips have charger and a fuel gauge.

This adds basic support for displaying the state of the battery and the
input power, settings are not modified. There are some defaults set via
OTP.

Charging also starts after plugging USB.

Known issues of the fuel gauge: There are drivers in the wild which disable
the fuel gauge at shutdown. If a kernel is booted without fuel gauge
support, after such a driver has been used, the fuel gauge will stay off
and decalibrate.
If this driver is used after that, it might display wrong values for charge
level.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- patch 2/2 is already accepted, so it is not included, this
  one can be applied independantly
- cleanup of sign handling
- adp properties fixed
 drivers/power/supply/Kconfig         |   8 +
 drivers/power/supply/Makefile        |   1 +
 drivers/power/supply/rn5t618_power.c | 556 +++++++++++++++++++++++++++
 3 files changed, 565 insertions(+)
 create mode 100644 drivers/power/supply/rn5t618_power.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 44d3c8512fb8..28cea178f6f1 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -739,4 +739,12 @@ config CHARGER_WILCO
 	  information can be found in
 	  Documentation/ABI/testing/sysfs-class-power-wilco
 
+config RN5T618_POWER
+	tristate "RN5T618 charger/fuel gauge support"
+	depends on MFD_RN5T618
+	help
+	  Say Y here to have support for RN5T618 PMIC family fuel gauge and charger
+	  This driver can also be built as a module. If so, the module will be
+	  called rn5t618_power.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b9644663e435..23866b6ccdae 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -95,3 +95,4 @@ obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD70528)	+= bd70528-charger.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
+obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
new file mode 100644
index 000000000000..424d2817bee5
--- /dev/null
+++ b/drivers/power/supply/rn5t618_power.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Power supply driver for the RICOH RN5T618 power management chip family
+ *
+ * Copyright (C) 2020 Andreas Kemnade
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mfd/rn5t618.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define CHG_STATE_ADP_INPUT 0x40
+#define CHG_STATE_USB_INPUT 0x80
+#define CHG_STATE_MASK	0x1f
+#define CHG_STATE_CHG_OFF	0
+#define CHG_STATE_CHG_READY_VADP	1
+#define CHG_STATE_CHG_TRICKLE	2
+#define CHG_STATE_CHG_RAPID	3
+#define CHG_STATE_CHG_COMPLETE	4
+#define CHG_STATE_SUSPEND	5
+#define CHG_STATE_VCHG_OVER_VOL	6
+#define CHG_STATE_BAT_ERROR	7
+#define CHG_STATE_NO_BAT	8
+#define CHG_STATE_BAT_OVER_VOL	9
+#define CHG_STATE_BAT_TEMP_ERR	10
+#define CHG_STATE_DIE_ERR	11
+#define CHG_STATE_DIE_SHUTDOWN	12
+#define CHG_STATE_NO_BAT2	13
+#define CHG_STATE_CHG_READY_VUSB	14
+
+#define FG_ENABLE 1
+
+struct rn5t618_power_info {
+	struct rn5t618 *rn5t618;
+	struct platform_device *pdev;
+	struct power_supply *battery;
+	struct power_supply *usb;
+	struct power_supply *adp;
+	int irq;
+};
+
+static enum power_supply_property rn5t618_usb_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static enum power_supply_property rn5t618_adp_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+
+static enum power_supply_property rn5t618_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+};
+
+static int rn5t618_battery_read_doublereg(struct rn5t618_power_info *info,
+					  u8 reg, u16 *result)
+{
+	int ret, i;
+	u8 data[2];
+	u16 old, new;
+
+	old = 0;
+	/* Prevent races when registers are changing. */
+	for (i = 0; i < 3; i++) {
+		ret = regmap_bulk_read(info->rn5t618->regmap,
+				       reg, data, sizeof(data));
+		if (ret)
+			return ret;
+
+		new = data[0] << 8;
+		new |= data[1];
+		if (new == old)
+			break;
+
+		old = new;
+	}
+
+	*result = new;
+
+	return 0;
+}
+
+static int rn5t618_decode_status(unsigned int status)
+{
+	switch (status & CHG_STATE_MASK) {
+	case CHG_STATE_CHG_OFF:
+	case CHG_STATE_SUSPEND:
+	case CHG_STATE_VCHG_OVER_VOL:
+	case CHG_STATE_DIE_SHUTDOWN:
+		return POWER_SUPPLY_STATUS_DISCHARGING;
+
+	case CHG_STATE_CHG_TRICKLE:
+	case CHG_STATE_CHG_RAPID:
+		return POWER_SUPPLY_STATUS_CHARGING;
+
+	case CHG_STATE_CHG_COMPLETE:
+		return POWER_SUPPLY_STATUS_FULL;
+
+	default:
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
+}
+
+static int rn5t618_battery_status(struct rn5t618_power_info *info,
+				  union power_supply_propval *val)
+{
+	unsigned int v;
+	int ret;
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_CHGSTATE, &v);
+	if (ret)
+		return ret;
+
+	val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	if (v & 0xc0) { /* USB or ADP plugged */
+		val->intval = rn5t618_decode_status(v);
+	} else
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+
+	return ret;
+}
+
+static int rn5t618_battery_present(struct rn5t618_power_info *info,
+				   union power_supply_propval *val)
+{
+	unsigned int v;
+	int ret;
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_CHGSTATE, &v);
+	if (ret)
+		return ret;
+
+	v &= CHG_STATE_MASK;
+	if ((v == CHG_STATE_NO_BAT) || (v == CHG_STATE_NO_BAT2))
+		val->intval = 0;
+	else
+		val->intval = 1;
+
+	return ret;
+}
+
+static int rn5t618_battery_voltage_now(struct rn5t618_power_info *info,
+				       union power_supply_propval *val)
+{
+	u16 res;
+	int ret;
+
+	ret = rn5t618_battery_read_doublereg(info, RN5T618_VOLTAGE_1, &res);
+	if (ret)
+		return ret;
+
+	val->intval = res * 2 * 2500 / 4095 * 1000;
+
+	return 0;
+}
+
+static int rn5t618_battery_current_now(struct rn5t618_power_info *info,
+				       union power_supply_propval *val)
+{
+	u16 res;
+	int ret;
+
+	ret = rn5t618_battery_read_doublereg(info, RN5T618_CC_AVEREG1, &res);
+	if (ret)
+		return ret;
+
+	/* current is negative when discharging */
+	val->intval = sign_extend32(res, 13) * 1000;
+
+	return 0;
+}
+
+static int rn5t618_battery_capacity(struct rn5t618_power_info *info,
+				    union power_supply_propval *val)
+{
+	unsigned int v;
+	int ret;
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_SOC, &v);
+	if (ret)
+		return ret;
+
+	val->intval = v;
+
+	return 0;
+}
+
+static int rn5t618_battery_temp(struct rn5t618_power_info *info,
+				union power_supply_propval *val)
+{
+	u16 res;
+	int ret;
+
+	ret = rn5t618_battery_read_doublereg(info, RN5T618_TEMP_1, &res);
+	if (ret)
+		return ret;
+
+	val->intval = sign_extend32(res, 11) * 10 / 16;
+
+	return 0;
+}
+
+static int rn5t618_battery_tte(struct rn5t618_power_info *info,
+			       union power_supply_propval *val)
+{
+	u16 res;
+	int ret;
+
+	ret = rn5t618_battery_read_doublereg(info, RN5T618_TT_EMPTY_H, &res);
+	if (ret)
+		return ret;
+
+	if (res == 65535)
+		return -ENODATA;
+
+	val->intval = res * 60;
+
+	return 0;
+}
+
+static int rn5t618_battery_ttf(struct rn5t618_power_info *info,
+			       union power_supply_propval *val)
+{
+	u16 res;
+	int ret;
+
+	ret = rn5t618_battery_read_doublereg(info, RN5T618_TT_FULL_H, &res);
+	if (ret)
+		return ret;
+
+	if (res == 65535)
+		return -ENODATA;
+
+	val->intval = res * 60;
+
+	return 0;
+}
+
+static int rn5t618_battery_charge_full(struct rn5t618_power_info *info,
+				       union power_supply_propval *val)
+{
+	u16 res;
+	int ret;
+
+	ret = rn5t618_battery_read_doublereg(info, RN5T618_FA_CAP_H, &res);
+	if (ret)
+		return ret;
+
+	val->intval = res * 1000;
+
+	return 0;
+}
+
+static int rn5t618_battery_charge_now(struct rn5t618_power_info *info,
+				      union power_supply_propval *val)
+{
+	u16 res;
+	int ret;
+
+	ret = rn5t618_battery_read_doublereg(info, RN5T618_RE_CAP_H, &res);
+	if (ret)
+		return ret;
+
+	val->intval = res * 1000;
+
+	return 0;
+}
+
+static int rn5t618_battery_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	int ret = 0;
+	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = rn5t618_battery_status(info, val);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = rn5t618_battery_present(info, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = rn5t618_battery_voltage_now(info, val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = rn5t618_battery_current_now(info, val);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = rn5t618_battery_capacity(info, val);
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = rn5t618_battery_temp(info, val);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		ret = rn5t618_battery_tte(info, val);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
+		ret = rn5t618_battery_ttf(info, val);
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = rn5t618_battery_charge_full(info, val);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = rn5t618_battery_charge_now(info, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int rn5t618_adp_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
+	unsigned int chgstate;
+	bool online;
+	int ret;
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_CHGSTATE, &chgstate);
+	if (ret)
+		return ret;
+
+	online = !!(chgstate & CHG_STATE_ADP_INPUT);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = online;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!online) {
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		}
+		val->intval = rn5t618_decode_status(chgstate);
+		if (val->intval != POWER_SUPPLY_STATUS_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rn5t618_usb_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct rn5t618_power_info *info = power_supply_get_drvdata(psy);
+	unsigned int chgstate;
+	bool online;
+	int ret;
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_CHGSTATE, &chgstate);
+	if (ret)
+		return ret;
+
+	online = !!(chgstate & CHG_STATE_USB_INPUT);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = online;
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!online) {
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		}
+		val->intval = rn5t618_decode_status(chgstate);
+		if (val->intval != POWER_SUPPLY_STATUS_CHARGING)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct power_supply_desc rn5t618_battery_desc = {
+	.name                   = "rn5t618-battery",
+	.type                   = POWER_SUPPLY_TYPE_BATTERY,
+	.properties             = rn5t618_battery_props,
+	.num_properties         = ARRAY_SIZE(rn5t618_battery_props),
+	.get_property           = rn5t618_battery_get_property,
+};
+
+static const struct power_supply_desc rn5t618_adp_desc = {
+	.name                   = "rn5t618-adp",
+	.type                   = POWER_SUPPLY_TYPE_MAINS,
+	.properties             = rn5t618_adp_props,
+	.num_properties         = ARRAY_SIZE(rn5t618_adp_props),
+	.get_property           = rn5t618_adp_get_property,
+};
+
+static const struct power_supply_desc rn5t618_usb_desc = {
+	.name                   = "rn5t618-usb",
+	.type                   = POWER_SUPPLY_TYPE_USB,
+	.properties             = rn5t618_usb_props,
+	.num_properties         = ARRAY_SIZE(rn5t618_usb_props),
+	.get_property           = rn5t618_usb_get_property,
+};
+
+static irqreturn_t rn5t618_charger_irq(int irq, void *data)
+{
+	struct device *dev = data;
+	struct rn5t618_power_info *info = dev_get_drvdata(dev);
+
+	unsigned int ctrl, stat1, stat2, err;
+
+	regmap_read(info->rn5t618->regmap, RN5T618_CHGERR_IRR, &err);
+	regmap_read(info->rn5t618->regmap, RN5T618_CHGCTRL_IRR, &ctrl);
+	regmap_read(info->rn5t618->regmap, RN5T618_CHGSTAT_IRR1, &stat1);
+	regmap_read(info->rn5t618->regmap, RN5T618_CHGSTAT_IRR2, &stat2);
+
+	regmap_write(info->rn5t618->regmap, RN5T618_CHGERR_IRR, 0);
+	regmap_write(info->rn5t618->regmap, RN5T618_CHGCTRL_IRR, 0);
+	regmap_write(info->rn5t618->regmap, RN5T618_CHGSTAT_IRR1, 0);
+	regmap_write(info->rn5t618->regmap, RN5T618_CHGSTAT_IRR2, 0);
+
+	dev_dbg(dev, "chgerr: %x chgctrl: %x chgstat: %x chgstat2: %x\n",
+		err, ctrl, stat1, stat2);
+
+	power_supply_changed(info->usb);
+	power_supply_changed(info->adp);
+	power_supply_changed(info->battery);
+
+	return IRQ_HANDLED;
+}
+
+static int rn5t618_power_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	unsigned int v;
+	struct power_supply_config psy_cfg = {};
+	struct rn5t618_power_info *info;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->pdev = pdev;
+	info->rn5t618 = dev_get_drvdata(pdev->dev.parent);
+	info->irq = -1;
+
+	platform_set_drvdata(pdev, info);
+
+	ret = regmap_read(info->rn5t618->regmap, RN5T618_CONTROL, &v);
+	if (ret)
+		return ret;
+
+	if (!(v & FG_ENABLE)) {
+		/* E.g. the vendor kernels of various Kobo and Tolino Ebook
+		 * readers disable the fuel gauge on shutdown. If a kernel
+		 * without fuel gauge support is booted after that, the fuel
+		 * gauge will get decalibrated.
+		 */
+		dev_info(&pdev->dev, "Fuel gauge not enabled, enabling now\n");
+		dev_info(&pdev->dev, "Expect unprecise results\n");
+		regmap_update_bits(info->rn5t618->regmap, RN5T618_CONTROL,
+				   FG_ENABLE, FG_ENABLE);
+	}
+
+	psy_cfg.drv_data = info;
+	info->battery = devm_power_supply_register(&pdev->dev,
+						   &rn5t618_battery_desc,
+						   &psy_cfg);
+	if (IS_ERR(info->battery)) {
+		ret = PTR_ERR(info->battery);
+		dev_err(&pdev->dev, "failed to register battery: %d\n", ret);
+		return ret;
+	}
+
+	info->adp = devm_power_supply_register(&pdev->dev,
+					       &rn5t618_adp_desc,
+					       &psy_cfg);
+	if (IS_ERR(info->adp)) {
+		ret = PTR_ERR(info->adp);
+		dev_err(&pdev->dev, "failed to register adp: %d\n", ret);
+		return ret;
+	}
+
+	info->usb = devm_power_supply_register(&pdev->dev,
+					       &rn5t618_usb_desc,
+					       &psy_cfg);
+	if (IS_ERR(info->usb)) {
+		ret = PTR_ERR(info->usb);
+		dev_err(&pdev->dev, "failed to register usb: %d\n", ret);
+		return ret;
+	}
+
+	if (info->rn5t618->irq_data)
+		info->irq = regmap_irq_get_virq(info->rn5t618->irq_data,
+						RN5T618_IRQ_CHG);
+
+	if (info->irq < 0)
+		info->irq = -1;
+	else {
+		ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
+						rn5t618_charger_irq,
+						IRQF_ONESHOT,
+						"rn5t618_power",
+						&pdev->dev);
+
+		if (ret < 0) {
+			dev_err(&pdev->dev, "request IRQ:%d fail\n",
+				info->irq);
+			info->irq = -1;
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver rn5t618_power_driver = {
+	.driver = {
+		.name   = "rn5t618-power",
+	},
+	.probe = rn5t618_power_probe,
+};
+
+module_platform_driver(rn5t618_power_driver);
+MODULE_ALIAS("platform:rn5t618-power");
+MODULE_DESCRIPTION("Power supply driver for RICOH RN5T618");
+MODULE_LICENSE("GPL");
-- 
2.20.1

