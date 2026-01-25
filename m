Return-Path: <linux-pm+bounces-41436-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JDQJ2lqdmkuQgEAu9opvQ
	(envelope-from <linux-pm+bounces-41436-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:09:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 128EF81F14
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB66A3001CF3
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C492F39B5;
	Sun, 25 Jan 2026 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SDuFiYaf"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333282F2604;
	Sun, 25 Jan 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368144; cv=none; b=Otj6TVbvXQsRDiVCgWr9a0uw8UOGq5qpd1g+MOuB4UXU4CL2WC46JDy6zVep2h7Pwg9ZpJAX+yDlV194HfCGdxeZ+ECUG0RBc0pidiKXpr/3HuekZjnSWaJDU01U1axS27xjBu3ob1o6BwKrl7IkxV+GtELApM1lycGIm6FNIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368144; c=relaxed/simple;
	bh=zC/3rnQyt3mAnYw4WziZKdbnacGpu6rOWazsrIUSjWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=peMXRoduiiTYx5WB6X+w1tb1O1CwgOI2JBV7ttArHJdsTLP48fvRTPV0VGt+fkxEnlTI99UzkUiaZABFGbtiFKdm0Uc9tbzaJ2fJacdOm5zFg0KpWTqFaAq4yTl64b/RlCa20pa2xEEBZh8QlGwO6zkNZ0UAvjwx51u9QAvStVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SDuFiYaf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id ED62527D96;
	Sun, 25 Jan 2026 20:09:01 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1tjh9D-EX7Wv; Sun, 25 Jan 2026 20:09:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368140; bh=zC/3rnQyt3mAnYw4WziZKdbnacGpu6rOWazsrIUSjWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SDuFiYafpuryiQ5OYSeCkb5HVjaV3gpAE9JVGCtMh9fNEuLv0RcSWk5ikB24xqMef
	 oE5Oe9Ne+V9dJWN3aymgTacoaU+C5kpjubn2LWi6his1GL+0fkNyS/kzRkJLxyMQ4j
	 o211vuyxap48K1d3pfnB8v9ttWwQDtU37/S6eWOXEsrdnnofylwoCFaKwOADR4AoSV
	 mii1WwIjSGNtBNp+Atx5c5P9TZDubDUFSqMq3ptWQK7wH6azuERQVb92iDz1cJg/VK
	 lWKSD/PAoCXyin56BS45DVbb6C65M0kCM0YLl1XQa6V1USwl2oTnIoqPQT1XRdl78u
	 OjgywB/MUPZlw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:19 +0530
Subject: [PATCH v2 12/12] power: supply: add support for Samsung S2M series
 PMIC charger device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-12-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
In-Reply-To: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
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
	TAGGED_FROM(0.00)[bounces-41436-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,disroot.org:email,disroot.org:dkim,disroot.org:mid]
X-Rspamd-Queue-Id: 128EF81F14
X-Rspamd-Action: no action

Add a driver for charger controllers found in certain Samsung S2M series
PMICs. The driver has very basic support for the device, with only
charger online reporting working.

The driver includes initial support for the S2MU005 PMIC charger.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/supply/Kconfig       |  11 ++
 drivers/power/supply/Makefile      |   1 +
 drivers/power/supply/s2m-charger.c | 213 +++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 92f9f7aae92f2..b9a6bdf014586 100644
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
index 4b79d5abc49a7..795ef40d95311 100644
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
index 0000000000000..c212bc59f93cc
--- /dev/null
+++ b/drivers/power/supply/s2m-charger.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Battery Charger Driver for Samsung S2M series PMICs.
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/devm-helpers.h>
+#include <linux/extcon.h>
+#include <linux/mfd/samsung/core.h>
+#include <linux/mfd/samsung/s2mu005.h>
+#include <linux/module.h>
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
2.52.0


