Return-Path: <linux-pm+bounces-43589-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J9XJ71nqGl3uQAAu9opvQ
	(envelope-from <linux-pm+bounces-43589-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:11:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C53204EE4
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10E6C306CF14
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B6379972;
	Wed,  4 Mar 2026 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FWH7CINh"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBA37A49D;
	Wed,  4 Mar 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643863; cv=none; b=qnwBE0cNpkYDL2bIuQb4N+d4AYKXSVa4lH7a3KmNn61rSfNHgK1QYWaOvvFQjE2QYCe6q3YCtn6iC9ec6lIn3Jm3//KL11xjxQGOTeoCiJTGLiMBOIWmASomujQ7DhATCX2Cw6jS6oGKcwA4jZF3pDnL3ipI71B1nBOJ9k5uv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643863; c=relaxed/simple;
	bh=DcNUOSXCuHRThfphJBV1YI7mRpSJHdMf0b+bHozhD5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQOQPCoWDE068Dy+9USyw0Grgg7HeUwDXJP7wf9EYn+fpp4CNWnNLLCMCOwn9F0KasTE16zC3inAqTLRZH6m0+AEVV1JuHeMs+7KRiGcOktQTsnXQqE7/BoA+opEb3jhwt3SPwS4GSXWWL4Ue4Ttog5mycGssX8D7N/2cxGqg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FWH7CINh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7B541268A1;
	Wed,  4 Mar 2026 18:04:14 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9pyzL0Jyi5ga; Wed,  4 Mar 2026 18:04:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1772643853; bh=DcNUOSXCuHRThfphJBV1YI7mRpSJHdMf0b+bHozhD5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FWH7CINhWHOqGXtaFRx1DXF/riyttN0WYAG7pJ62t8Znp80eBNr0zF1Q/q509Dxzd
	 iOArRn+M11/YyWC8x7o3kmIyAcegmm7uRnyl7DKNALfCkj2kIoVJSXgwX6PpApC/bo
	 MP4kAPRkBp/DY4t547DwNMi3BUxw1tb8YGD6FNf4ZWtXz5ALzXc6/QglXjDGmccU1N
	 0oUEaEcScQf1rWxRv0J4h0TEyffPfj2InzYbOFmTbz47sg8JtWzU0fcUi0Rc1gv2Vx
	 a49w6JL7TdoqBf83qPq5bMpvM4aaIG85Sih6+bAP73Y92ZwUk0SaK9Q08rfOejnK1F
	 DyggVL2oJiXkQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 04 Mar 2026 22:33:56 +0530
Subject: [PATCH v3 2/2] power: supply: add support for S2MU005 battery fuel
 gauge device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-s2mu005-fuelgauge-v3-2-e4dc4e47cde8@disroot.org>
References: <20260304-s2mu005-fuelgauge-v3-0-e4dc4e47cde8@disroot.org>
In-Reply-To: <20260304-s2mu005-fuelgauge-v3-0-e4dc4e47cde8@disroot.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Queue-Id: A8C53204EE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43589-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:dkim,disroot.org:email,disroot.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,protonmail.com:email]
X-Rspamd-Action: no action

From: Yassine Oudjana <y.oudjana@protonmail.com>

Samsung's S2MU005 PMIC, which contains battery charger functionality
also includes a battery fuel gauge device, which is separate from the
PMIC itself, and typically connected to an I2C bus. Add a generic driver
to support said device.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Co-developed-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/supply/Kconfig           |  11 ++
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/s2mu005-battery.c | 307 +++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3a5b7d9234c21..e8a1bdb246c4d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -229,6 +229,17 @@ config BATTERY_SAMSUNG_SDI
 	  Say Y to enable support for Samsung SDI battery data.
 	  These batteries are used in Samsung mobile phones.
 
+config BATTERY_S2MU005
+	tristate "Samsung S2MU005 PMIC fuel gauge driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the Samsung S2MU005 PMIC integrated
+	  fuel gauge, which works indepenently of the PMIC battery charger
+	  counterpart, and reports battery metrics.
+
+	  This driver, if built as a module, will be called s2mu005-fuel-gauge.
+
 config BATTERY_COLLIE
 	tristate "Sharp SL-5500 (collie) battery"
 	depends on SA1100_COLLIE && MCP_UCB1200
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index d14420b606d8c..f2efbb82707c7 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+= samsung-sdi-battery.o
+obj-$(CONFIG_BATTERY_S2MU005)	+= s2mu005-battery.o
 obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
 obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
 obj-$(CONFIG_BATTERY_INTEL_DC_TI) += intel_dc_ti_battery.o
diff --git a/drivers/power/supply/s2mu005-battery.c b/drivers/power/supply/s2mu005-battery.c
new file mode 100644
index 0000000000000..686693052a5dc
--- /dev/null
+++ b/drivers/power/supply/s2mu005-battery.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Battery Fuel Gauge Driver for Samsung S2MU005 PMIC.
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ * Copyright (C) 2023 Yassine Oudjana <y.oudjana@protonmail.com>
+ * Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#define S2MU005_FG_REG_STATUS		0x00
+#define S2MU005_FG_REG_IRQ		0x02
+#define S2MU005_FG_REG_RVBAT		0x04
+#define S2MU005_FG_REG_RCURCC		0x06
+#define S2MU005_FG_REG_RSOC		0x08
+#define S2MU005_FG_REG_MONOUT		0x0a
+#define S2MU005_FG_REG_MONOUTSEL	0x0c
+#define S2MU005_FG_REG_RBATCAP		0x0e
+#define S2MU005_FG_REG_RZADJ		0x12
+#define S2MU005_FG_REG_RBATZ0		0x16
+#define S2MU005_FG_REG_RBATZ1		0x18
+#define S2MU005_FG_REG_IRQLVL		0x1a
+#define S2MU005_FG_REG_START		0x1e
+
+#define S2MU005_FG_MONOUTSEL_AVGCURRENT		0x26
+#define S2MU005_FG_MONOUTSEL_AVGVOLTAGE		0x27
+
+struct s2mu005_fg {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy;
+	struct mutex monout_mutex;
+};
+
+static const struct regmap_config s2mu005_fg_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static irqreturn_t s2mu005_handle_irq(int irq, void *data)
+{
+	struct s2mu005_fg *priv = data;
+
+	msleep(100);
+	power_supply_changed(priv->psy);
+
+	return IRQ_HANDLED;
+}
+
+static int s2mu005_fg_get_voltage_now(struct s2mu005_fg *priv, int *value)
+{
+	struct regmap *regmap = priv->regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, S2MU005_FG_REG_RVBAT, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read voltage register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = (val * MICRO) >> 13;
+
+	return 0;
+}
+
+static int s2mu005_fg_get_voltage_avg(struct s2mu005_fg *priv, int *value)
+{
+	struct regmap *regmap = priv->regmap;
+	u32 val;
+	int ret;
+
+	mutex_lock(&priv->monout_mutex);
+
+	ret = regmap_write(regmap, S2MU005_FG_REG_MONOUTSEL,
+			   S2MU005_FG_MONOUTSEL_AVGVOLTAGE);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to enable average voltage monitoring (%d)\n",
+			ret);
+		goto unlock;
+	}
+
+	ret = regmap_read(regmap, S2MU005_FG_REG_MONOUT, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
+		goto unlock;
+	}
+
+	*value = (val * MICRO) >> 12;
+
+unlock:
+	mutex_unlock(&priv->monout_mutex);
+
+	return ret;
+}
+static int s2mu005_fg_get_current_now(struct s2mu005_fg *priv, int *value)
+{
+	struct regmap *regmap = priv->regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, S2MU005_FG_REG_RCURCC, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = -((s16)val * MICRO) >> 12;
+
+	return 0;
+}
+
+static int s2mu005_fg_get_current_avg(struct s2mu005_fg *priv, int *value)
+{
+	struct regmap *regmap = priv->regmap;
+	u32 val;
+	int ret;
+
+	mutex_lock(&priv->monout_mutex);
+
+	ret = regmap_write(regmap, S2MU005_FG_REG_MONOUTSEL,
+			   S2MU005_FG_MONOUTSEL_AVGCURRENT);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to enable average current monitoring (%d)\n",
+			ret);
+		goto unlock;
+	}
+
+	ret = regmap_read(regmap, S2MU005_FG_REG_MONOUT, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
+		goto unlock;
+	}
+
+	*value = -((s16)val * MICRO) >> 12;
+
+unlock:
+	mutex_unlock(&priv->monout_mutex);
+
+	return ret;
+}
+
+static int s2mu005_fg_get_capacity(struct s2mu005_fg *priv, int *value)
+{
+	struct regmap *regmap = priv->regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, S2MU005_FG_REG_RSOC, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read capacity register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = (val * CENTI) >> 14;
+
+	return 0;
+}
+
+static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value)
+{
+	int current_now, current_avg, capacity;
+	int ret;
+
+	ret = s2mu005_fg_get_current_now(priv, &current_now);
+	if (ret < 0)
+		return ret;
+
+	ret = s2mu005_fg_get_current_avg(priv, &current_avg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Verify both current values reported to reduce inaccuracies due to
+	 * internal hysteresis.
+	 */
+	if (current_now < 0 && current_avg < 0) {
+		*value = POWER_SUPPLY_STATUS_DISCHARGING;
+	} else if (current_now == 0) {
+		*value = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	} else {
+		*value = POWER_SUPPLY_STATUS_CHARGING;
+
+		ret = s2mu005_fg_get_capacity(priv, &capacity);
+		if (!ret && capacity > 98)
+			*value = POWER_SUPPLY_STATUS_FULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static const enum power_supply_property s2mu005_fg_properties[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
+static int s2mu005_fg_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct s2mu005_fg *priv = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return s2mu005_fg_get_voltage_now(priv, &val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		return s2mu005_fg_get_voltage_avg(priv, &val->intval);
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return s2mu005_fg_get_current_now(priv, &val->intval);
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		return s2mu005_fg_get_current_avg(priv, &val->intval);
+	case POWER_SUPPLY_PROP_CAPACITY:
+		return s2mu005_fg_get_capacity(priv, &val->intval);
+	case POWER_SUPPLY_PROP_STATUS:
+		return s2mu005_fg_get_status(priv, &val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct power_supply_desc s2mu005_fg_desc = {
+	.name = "s2mu005-fuel-gauge",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = s2mu005_fg_properties,
+	.num_properties = ARRAY_SIZE(s2mu005_fg_properties),
+	.get_property = s2mu005_fg_get_property,
+};
+
+static int s2mu005_fg_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct s2mu005_fg *priv;
+	struct power_supply_config psy_cfg = {};
+	const struct power_supply_desc *psy_desc;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->dev = dev;
+
+	priv->regmap = devm_regmap_init_i2c(client, &s2mu005_fg_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "failed to initialize regmap\n");
+
+	psy_desc = device_get_match_data(dev);
+
+	psy_cfg.drv_data = priv;
+	psy_cfg.fwnode = dev_fwnode(dev);
+	priv->psy = devm_power_supply_register(priv->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(priv->psy))
+		return dev_err_probe(dev, PTR_ERR(priv->psy),
+				     "failed to register power supply subsystem\n");
+
+	ret = devm_mutex_init(dev, &priv->monout_mutex);
+	if (ret)
+		dev_err_probe(dev, ret, "failed to initialize MONOUT mutex\n");
+
+	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
+					s2mu005_handle_irq, IRQF_ONESHOT,
+					psy_desc->name, priv);
+	if (ret)
+		dev_err_probe(dev, ret, "failed to request IRQ\n");
+
+	return 0;
+}
+
+static const struct of_device_id s2mu005_fg_of_match_table[] = {
+	{
+		.compatible = "samsung,s2mu005-fuel-gauge",
+		.data = &s2mu005_fg_desc,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s2mu005_fg_of_match_table);
+
+static struct i2c_driver s2mu005_fg_i2c_driver = {
+	.probe = s2mu005_fg_i2c_probe,
+	.driver = {
+		.name = "s2mu005-fuel-gauge",
+		.of_match_table = s2mu005_fg_of_match_table,
+	},
+};
+module_i2c_driver(s2mu005_fg_i2c_driver);
+
+MODULE_DESCRIPTION("Samsung S2MU005 PMIC Battery Fuel Gauge Driver");
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
+MODULE_LICENSE("GPL");

-- 
2.53.0


