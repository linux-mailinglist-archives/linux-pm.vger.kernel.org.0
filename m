Return-Path: <linux-pm+bounces-37984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA32C59ABE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7889D359456
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008331B118;
	Thu, 13 Nov 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="L3UHOli0"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780983195E7;
	Thu, 13 Nov 2025 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060915; cv=none; b=JQa76KJRELk/XcZO6eqU7Hn5BIBEiwS6iv3TKKpDlUdxcFcWt1SIzdZj2Bmr7Zxvk7NoteUIupLvN8qXWCv1qmF133zE7iQfBiWaELJA/kkL4cvySDX3niOHsIP0c1GELM7pnaS39xDnWmf7wHVOCO+Y1BnKDbqNtXIaFx+HmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060915; c=relaxed/simple;
	bh=FLUqwjUCzmLu5oGO+Zln3eWxgqYETZl/0W/pVfo5VbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCDxy475gEkkh0l0HN5BcDsjzxhhxiDKQqsXX0jV781zlY4rLP9vjY0sjXWs32juMS0A9YzHx/N/cJj1SbvcjmrN5sIrCc1i1febDtKayPhgPpbI1iDzWUBXORVV6AdkG31qqfFNxeBB6SfNV5WNCfq+rdwWtiSDN5qJcwpLseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=L3UHOli0; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A128D25DAC;
	Thu, 13 Nov 2025 20:08:30 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZ2ghCEt9r8E; Thu, 13 Nov 2025 20:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060909; bh=FLUqwjUCzmLu5oGO+Zln3eWxgqYETZl/0W/pVfo5VbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L3UHOli0X9kOQO8IOzyxRyVHn0b6xvIny5YUPI/wT7fEDyhYDbeQL2gNBugRp/u7E
	 jME/OkBgB9ApfdjgK1f+Zmq7eHJJaCTtVHozD5QkLVRPx+l0C8lkPnjU7CojeE3mHn
	 +7aTWu9tfCAftY8z1IKrlOQ8bge0n69oBP3ShKg0xCad3cAGgTrTIeyg2nB/s+91rd
	 rMRs0B3LcPK+82UNrYbDC0kVwYKvFdahME0Mod1FQdCora3JEBDfgDmvkqhtg5fjA9
	 7Tjd57pDOgkCQUqnMnPveE4CzvTZVIr9e77PCVSL1aJl2jOltFZ0XDUDI9nkVUXdOv
	 4X+RvHR6dlnBQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:14 +0530
Subject: [PATCH 13/13] power: supply: add support for Samsung S2M series
 PMIC charger device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-13-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=9216;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=FLUqwjUCzmLu5oGO+Zln3eWxgqYETZl/0W/pVfo5VbU=;
 b=oDFpzVZXIoA/aDmvgPLb4M6oS8YnxJb5J0nzPT2JvboX5y5TlS4ysC2wZ0sgzr+28kYUWeOwl
 7A/7Wc+a5p0DfmACtI1kkD0GdWDKFt5PvDbn5tuKYhuP1lEjfPNWNhC
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Add a driver for charger controllers found in certain Samsung S2M series
PMICs. The driver has very basic support for the device, with only
charger online reporting working.

The driver includes initial support for the S2MU005 PMIC charger.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/extcon/extcon-s2m.c        |   2 +-
 drivers/power/supply/Kconfig       |  11 ++
 drivers/power/supply/Makefile      |   1 +
 drivers/power/supply/s2m-charger.c | 216 +++++++++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-s2m.c b/drivers/extcon/extcon-s2m.c
index b27ee9e79bb6..268ad1f65ffd 100644
--- a/drivers/extcon/extcon-s2m.c
+++ b/drivers/extcon/extcon-s2m.c
@@ -289,7 +289,7 @@ static int s2m_muic_probe(struct platform_device *pdev)
 						s2m_muic_irq_func, IRQF_ONESHOT,
 						priv->irq_data[i].name, priv);
 		if (ret)
-			dev_err_probe(dev, ret, "failed to request IRQ\n");
+			return dev_err_probe(dev, ret, "failed to request IRQ\n");
 	}
 
 	return 0;
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 03c8525b480f..f8742d35a288 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -229,6 +229,17 @@ config BATTERY_SAMSUNG_SDI
 	  Say Y to enable support for Samsung SDI battery data.
 	  These batteries are used in Samsung mobile phones.
 
+config CHARGER_S2M
+	tristate "Samsung S2M series PMIC battery charger support"
+	depends on EXTCON_S2M
+	depends on MFD_SEC_CORE
+	select REGMAP_IRQ
+	help
+	  This option enables support for charger devices found in
+	  certain Samsung S2M series PMICs, such as the S2MU005. These
+	  devices provide USB power supply information and also required
+	  for USB OTG role switching.
+
 config BATTERY_COLLIE
 	tristate "Sharp SL-5500 (collie) battery"
 	depends on SA1100_COLLIE && MCP_UCB1200
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 6e37a3edf7e3..dcfae32d1216 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+= qcom_battmgr.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
 obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+= samsung-sdi-battery.o
+obj-$(CONFIG_CHARGER_S2M)	+= s2m-charger.o
 obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
 obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
 obj-$(CONFIG_BATTERY_INTEL_DC_TI) += intel_dc_ti_battery.o
diff --git a/drivers/power/supply/s2m-charger.c b/drivers/power/supply/s2m-charger.c
new file mode 100644
index 000000000000..0a3216a2b545
--- /dev/null
+++ b/drivers/power/supply/s2m-charger.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Battery Charger Driver for Samsung S2M series PMICs.
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/devm-helpers.h>
+#include <linux/delay.h>
+#include <linux/extcon.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/samsung/core.h>
+#include <linux/mfd/samsung/irq.h>
+#include <linux/mfd/samsung/s2mu005.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+struct s2m_chgr {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy;
+	struct extcon_dev *extcon;
+	struct work_struct extcon_work;
+	struct notifier_block extcon_nb;
+};
+
+static int s2mu005_chgr_get_online(struct s2m_chgr *priv, int *value)
+{
+	u32 val;
+	int ret = 0;
+
+	ret = regmap_read(priv->regmap, S2MU005_REG_CHGR_STATUS0, &val);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = !!(val & S2MU005_CHGR_CHG);
+
+	return ret;
+}
+
+static int s2mu005_chgr_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct s2m_chgr *priv = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = s2mu005_chgr_get_online(priv, &val->intval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static void s2mu005_chgr_extcon_work(struct work_struct *work)
+{
+	struct s2m_chgr *priv = container_of(work, struct s2m_chgr,
+						 extcon_work);
+	int ret;
+
+	if (extcon_get_state(priv->extcon, EXTCON_USB_HOST) == true) {
+		ret = regmap_update_bits(priv->regmap, S2MU005_REG_CHGR_CTRL0,
+					 S2MU005_CHGR_OP_MODE,
+					 S2MU005_CHGR_OP_MODE_OTG);
+		if (ret < 0)
+			dev_err(priv->dev, "failed to set operation mode to OTG (%d)\n",
+				ret);
+
+		goto psy_update;
+	}
+
+	if (extcon_get_state(priv->extcon, EXTCON_USB) == true) {
+		ret = regmap_update_bits(priv->regmap, S2MU005_REG_CHGR_CTRL0,
+					 S2MU005_CHGR_OP_MODE,
+					 S2MU005_CHGR_OP_MODE_CHG);
+		if (ret < 0)
+			dev_err(priv->dev, "failed to set operation mode to charging (%d)\n",
+				ret);
+
+		goto psy_update;
+	}
+
+	ret = regmap_clear_bits(priv->regmap, S2MU005_REG_CHGR_CTRL0,
+				S2MU005_CHGR_OP_MODE);
+	if (ret < 0)
+		dev_err(priv->dev, "failed to clear operation mode (%d)\n", ret);
+
+psy_update:
+	power_supply_changed(priv->psy);
+}
+
+static const enum power_supply_property s2mu005_chgr_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
+static const struct power_supply_desc s2mu005_chgr_psy_desc = {
+	.name = "s2mu005-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = s2mu005_chgr_properties,
+	.num_properties = ARRAY_SIZE(s2mu005_chgr_properties),
+	.get_property = s2mu005_chgr_get_property,
+};
+
+static int s2m_chgr_extcon_notifier(struct notifier_block *nb,
+					unsigned long event, void *param)
+{
+	struct s2m_chgr *priv = container_of(nb, struct s2m_chgr, extcon_nb);
+
+	schedule_work(&priv->extcon_work);
+
+	return NOTIFY_OK;
+}
+
+static int s2m_chgr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sec_pmic_dev *pmic_drvdata = dev_get_drvdata(dev->parent);
+	struct s2m_chgr *priv;
+	struct device_node *extcon_node;
+	struct power_supply_config psy_cfg = {};
+	const struct power_supply_desc *psy_desc;
+	work_func_t extcon_work_func;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver private\n");
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+	priv->regmap = pmic_drvdata->regmap_pmic;
+
+	switch (platform_get_device_id(pdev)->driver_data) {
+	case S2MU005:
+		psy_desc = &s2mu005_chgr_psy_desc;
+		extcon_work_func = s2mu005_chgr_extcon_work;
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV,
+				     "device type %d is not supported by driver\n",
+				     pmic_drvdata->device_type);
+	}
+
+	psy_cfg.drv_data = priv;
+	priv->psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
+	if (IS_ERR(priv->psy))
+		return dev_err_probe(dev, PTR_ERR(priv->psy),
+				     "failed to register power supply subsystem\n");
+
+	/* MUIC is mandatory. If unavailable, request probe deferral */
+	extcon_node = of_get_child_by_name(dev->parent->of_node, "extcon");
+	priv->extcon = extcon_find_edev_by_node(extcon_node);
+	if (IS_ERR(priv->extcon))
+		return -EPROBE_DEFER;
+
+	ret = devm_work_autocancel(dev, &priv->extcon_work, extcon_work_func);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize extcon work\n");
+
+	priv->extcon_nb.notifier_call = s2m_chgr_extcon_notifier;
+	ret = devm_extcon_register_notifier_all(dev, priv->extcon, &priv->extcon_nb);
+	if (ret)
+		dev_err_probe(dev, ret, "failed to register extcon notifier\n");
+
+	return 0;
+}
+
+static const struct platform_device_id s2m_chgr_id_table[] = {
+	{ "s2mu005-charger", S2MU005 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, s2m_chgr_id_table);
+
+#ifdef CONFIG_OF
+/*
+ * Device is instantiated through parent MFD device and device matching
+ * is done through platform_device_id.
+ *
+ * However if device's DT node contains proper compatible and driver is
+ * built as a module, then the *module* matching will be done through DT
+ * aliases. This requires of_device_id table. In the same time this will
+ * not change the actual *device* matching so do not add .of_match_table.
+ */
+static const struct of_device_id s2m_chgr_of_match_table[] = {
+	{
+		.compatible = "samsung,s2mu005-charger",
+		.data = (void *)S2MU005,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2m_chgr_of_match_table);
+#endif
+
+static struct platform_driver s2m_chgr_driver = {
+	.driver = {
+		.name = "s2m-charger",
+	},
+	.probe = s2m_chgr_probe,
+	.id_table = s2m_chgr_id_table,
+};
+module_platform_driver(s2m_chgr_driver);
+
+MODULE_DESCRIPTION("Battery Charger Driver For Samsung S2M Series PMICs");
+MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
+MODULE_LICENSE("GPL");

-- 
2.51.2


