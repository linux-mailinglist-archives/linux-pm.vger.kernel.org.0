Return-Path: <linux-pm+bounces-41484-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJFoHBmLd2m9hgEAu9opvQ
	(envelope-from <linux-pm+bounces-41484-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 16:41:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40C8A3F7
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 16:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ACB7303B16C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDD340277;
	Mon, 26 Jan 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bwu5xDya"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8A340275;
	Mon, 26 Jan 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442013; cv=none; b=FRUQvHAHWivnLJyUPzceSGhGkqoXFsSFSt80ZcM+0jx6iudCtlCVWDTcq2Vyr224v8P9SIzD5aewIkmxFsrjMEwJ4Qpsv5/i8u3USzvPQ9PTGl1Honxq8scQ51oQ6TGKC4KNdySQ8nJHMRZk5QqQOXlOlK5ypaqSqqyoTOhPWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442013; c=relaxed/simple;
	bh=jjfFByUueOhLF+GJfahp/6Wi2wfOAu+dUSDB+c2Er/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABjvOHef2DfzdB8SP2JsgaFAywsC7wgMwCiYWWeg+G2O3GbaFUZiCsO0/Lg3gthCGe+EV0eJVu6H59MZ09xco0ZjiUjCGpP94OW3GWHpnf0+Q9LfGMhg0ETJso8lsfHQQ496apF3lYkgmkKusWENdida6Wgr7+KexQbGI1VsQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bwu5xDya; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E80BD26426;
	Mon, 26 Jan 2026 16:40:09 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 18c95C4GZO2G; Mon, 26 Jan 2026 16:40:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769442007; bh=jjfFByUueOhLF+GJfahp/6Wi2wfOAu+dUSDB+c2Er/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bwu5xDyazB59Yq5gcZ+Ixkkhpr3VRzYElQqcgkBiIkbXPJ5KGk7PW+vcg/RXfTna2
	 rhyBHuxOFzZJkbckNqnJ2MffDWiv5rEBumYWzX0Vgoct9v07S/Ab1syEO+9dMCPJhp
	 ZYK+yxbrXG/adjU0ZHqX3gFH2nUPXK39C81s5kdQl1cfO+WSOL0/9rmeWLww25CaT2
	 p+FVmSkq8gCsNz8Xpf+v0DERwbLjXsP4IjqmeRdtdfyQnBUdyeuDvIF/rnpxu3u2Fv
	 BI0ruAMqxAniPmv6HkM/cCfjopZEkXTqyEx3nOCBJmMFtP5PJuSPXLxKTQzI+06o/H
	 XSQk3YD0uWadw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 21:09:49 +0530
Subject: [PATCH 2/2] power: supply: add support for S2MU005 battery fuel
 gauge device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-fuelgauge-v1-2-68a146ed0819@disroot.org>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
In-Reply-To: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41484-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[disroot.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,protonmail.com:email]
X-Rspamd-Queue-Id: DA40C8A3F7
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
 drivers/power/supply/Kconfig           |   9 ++
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/s2mu005-battery.c | 234 +++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 92f9f7aae92f2..a5777309b1f62 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -229,6 +229,15 @@ config BATTERY_SAMSUNG_SDI
 	  Say Y to enable support for Samsung SDI battery data.
 	  These batteries are used in Samsung mobile phones.
 
+config BATTERY_S2MU005
+	tristate "Samsung S2MU005 PMIC fuel gauge driver"
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
index 4b79d5abc49a7..cd061887c1727 100644
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
index 0000000000000..914308e82683b
--- /dev/null
+++ b/drivers/power/supply/s2mu005-battery.c
@@ -0,0 +1,234 @@
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
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define S2MU005_FG_REG_STATUS		0x00
+#define S2MU005_FG_REG_IRQ		0x02
+#define S2MU005_FG_REG_RVBAT		0x04
+#define S2MU005_FG_REG_RCUR_CC		0x06
+#define S2MU005_FG_REG_RSOC		0x08
+#define S2MU005_FG_REG_MONOUT		0x0a
+#define S2MU005_FG_REG_MONOUT_SEL	0x0c
+#define S2MU005_FG_REG_RBATCAP		0x0e
+#define S2MU005_FG_REG_RZADJ		0x12
+#define S2MU005_FG_REG_RBATZ0		0x16
+#define S2MU005_FG_REG_RBATZ1		0x18
+#define S2MU005_FG_REG_IRQ_LVL		0x1a
+#define S2MU005_FG_REG_START		0x1e
+
+struct s2mu005_fg {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy;
+};
+
+static const struct regmap_config s2mu005_fg_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
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
+	u16 reg;
+	int ret;
+
+	ret = regmap_raw_read(regmap, S2MU005_FG_REG_RVBAT, &reg, sizeof(reg));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read voltage register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = ((unsigned long)reg * 1000000) >> 13; /* uV */
+
+	return 0;
+}
+
+static int s2mu005_fg_get_current_now(struct s2mu005_fg *priv, int *value)
+{
+	struct regmap *regmap = priv->regmap;
+	s16 reg;
+	int ret;
+
+	ret = regmap_raw_read(regmap, S2MU005_FG_REG_RCUR_CC, &reg, sizeof(reg));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = -((long)reg * 1000000) >> 12; /* uA */
+
+	return 0;
+}
+
+static int s2mu005_fg_get_capacity(struct s2mu005_fg *priv, int *value)
+{
+	struct regmap *regmap = priv->regmap;
+	s16 reg;
+	int ret;
+
+	ret = regmap_raw_read(regmap, S2MU005_FG_REG_RSOC, &reg, sizeof(reg));
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read capacity register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = (reg * 100) >> 14; /* percentage */
+
+	return 0;
+}
+
+static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value)
+{
+	int current_now;
+	int capacity;
+	int ret;
+
+	ret = s2mu005_fg_get_current_now(priv, &current_now);
+	if (ret)
+		return ret;
+
+	if (current_now <= 0) {
+		*value = POWER_SUPPLY_STATUS_DISCHARGING;
+		return 0;
+	}
+
+	ret = s2mu005_fg_get_capacity(priv, &capacity);
+	if (ret)
+		return ret;
+
+	if (capacity < 90)
+		*value = POWER_SUPPLY_STATUS_CHARGING;
+	else
+		*value = POWER_SUPPLY_STATUS_FULL;
+
+	return 0;
+}
+
+static const enum power_supply_property s2mu005_fg_properties[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_STATUS,
+};
+
+static int s2mu005_fg_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct s2mu005_fg *priv = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = s2mu005_fg_get_voltage_now(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = s2mu005_fg_get_current_now(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = s2mu005_fg_get_capacity(priv, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = s2mu005_fg_get_status(priv, &val->intval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
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
+	int flags;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to allocate driver private\n");
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
+	priv->psy = devm_power_supply_register(priv->dev, psy_desc, &psy_cfg);
+	if (IS_ERR(priv->psy))
+		return dev_err_probe(dev, PTR_ERR(priv->psy),
+				     "failed to register power supply subsystem\n");
+
+	flags = irq_get_trigger_type(client->irq);
+
+	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
+					s2mu005_handle_irq, IRQF_ONESHOT | flags,
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
+	}, { },
+};
+MODULE_DEVICE_TABLE(of, s2mu005_fg_of_match_table);
+
+static struct i2c_driver s2mu005_fg_i2c_driver = {
+	.probe = s2mu005_fg_i2c_probe,
+	.driver = {
+		.name = "s2mu005-fuel-gauge",
+		.of_match_table = of_match_ptr(s2mu005_fg_of_match_table),
+	},
+};
+module_i2c_driver(s2mu005_fg_i2c_driver);
+
+MODULE_DESCRIPTION("Samsung S2MU005 PMIC Battery Fuel Gauge Driver");
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
+MODULE_LICENSE("GPL");

-- 
2.52.0


