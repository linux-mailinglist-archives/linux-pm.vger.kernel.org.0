Return-Path: <linux-pm+bounces-41435-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HXqC3RqdmkVQgEAu9opvQ
	(envelope-from <linux-pm+bounces-41435-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:09:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E028A81F41
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19AE33011C64
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC02F3621;
	Sun, 25 Jan 2026 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZC6xOpag"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFDB8F4A;
	Sun, 25 Jan 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368138; cv=none; b=WsJEAsrfI0xGvn7EkJRcYPUfnpjv+M1aZAABH84Fs7fzEtVPWT6B4wnHUJ0vjoNETD7jM+7REKxsFRhtAhJizNXT4CBcYyVkI3COvRfPWB+QlJsH4kR2BIWIEY+hbqptlLuzIFkYVSdZDwu5sTa1FW5J9RwU4vEDFGjurnDLkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368138; c=relaxed/simple;
	bh=d080FNm0u+7ZOHr4ji+ICwSqBO1gkL47TYsLJthwYVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=il8hBLioUIQkAr4cTqHV8tE/X/M7IxPVEwlIb+tB0rvdWtc+lBSj1xvUmVTNmFFJZ6f/WAtz7NufBAVspvunbZoDgyIaWdgRoRfYXHFLstrRiy4G9yoMhe35RvF5ycBb0L9P5+PhPl4AlOo/Rq6nIWIh5G5MUJbriXAWHvUl9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZC6xOpag; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 943AC27E78;
	Sun, 25 Jan 2026 20:08:55 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LxfTmmAVVvvx; Sun, 25 Jan 2026 20:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368134; bh=d080FNm0u+7ZOHr4ji+ICwSqBO1gkL47TYsLJthwYVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZC6xOpagS0HJgdqwiog8f4PyQ/PIe1hjzlgE3+tHbRFv07BW7tSF01U7do0Jk4uoI
	 4jsElELxnTh7n/YMobvkqTUcAGMp0w2XNjR+YgMPstL/k3bGUjGAD/UCQCY23z4f06
	 Vi0UAd/L0Si9FlBavIK32M2zsPv7+x66AwneR1xvmKY9Jev2AoJ/UxgVxL/epdlVT2
	 +A2ntX41u575vIur2LOstPakqW5l1iwJDhxNHTM9jtw0yUxRpJIJJNhQ7oI2Nol90h
	 FPo1cw4skUckKi39o/ELiMug/LIDxEeSZgQkV0MPH1l5Fc/fVT/nXAfl+h6E5tq/Pk
	 vGI1KnIbd3k9g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:18 +0530
Subject: [PATCH v2 11/12] extcon: add support for Samsung S2M series PMIC
 extcon devices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-11-78f1a75f547a@disroot.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41435-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E028A81F41
X-Rspamd-Action: no action

Add a driver for MUIC devices found in certain Samsung S2M series PMICs
These are USB port accessory detectors. These devices report multiple
cable states depending on the ID-GND resistance measured by an internal
ADC.

The driver includes initial support for the S2MU005 PMIC extcon.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/extcon/Kconfig      |  10 ++
 drivers/extcon/Makefile     |   1 +
 drivers/extcon/extcon-s2m.c | 351 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 362 insertions(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 68d9df7d2dae0..19c712e591955 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -183,6 +183,16 @@ config EXTCON_RT8973A
 	  and switch that is optimized to protect low voltage system
 	  from abnormal high input voltage (up to 28V).
 
+config EXTCON_S2M
+	tristate "Samsung S2M series PMIC EXTCON support"
+	depends on MFD_SEC_CORE
+	select REGMAP_IRQ
+	help
+	  This option enables support for MUIC devices found in certain
+	  Samsung S2M series PMICs, such as the S2MU005. These devices
+	  have internal ADCs measuring the ID-GND resistance, thereby
+	  can be used as a USB port accessory detector.
+
 config EXTCON_SM5502
 	tristate "Silicon Mitus SM5502/SM5504/SM5703 EXTCON support"
 	depends on I2C
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 6482f2bfd6611..e3939786f3474 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_EXTCON_PALMAS)	+= extcon-palmas.o
 obj-$(CONFIG_EXTCON_PTN5150)	+= extcon-ptn5150.o
 obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
 obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
+obj-$(CONFIG_EXTCON_S2M)	+= extcon-s2m.o
 obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
 obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
 obj-$(CONFIG_EXTCON_USBC_CROS_EC) += extcon-usbc-cros-ec.o
diff --git a/drivers/extcon/extcon-s2m.c b/drivers/extcon/extcon-s2m.c
new file mode 100644
index 0000000000000..7a49e8e54f439
--- /dev/null
+++ b/drivers/extcon/extcon-s2m.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Extcon Driver for Samsung S2M series PMICs.
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ * Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/delay.h>
+#include <linux/extcon-provider.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/samsung/core.h>
+#include <linux/mfd/samsung/s2mu005.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct s2m_muic {
+	struct device *dev;
+	struct regmap *regmap;
+	struct extcon_dev *extcon;
+	struct s2m_muic_irq_data *irq_data;
+	const unsigned int *extcon_cable;
+	bool attached;
+};
+
+struct s2m_muic_irq_data {
+	const char *name;
+	int (*const handler)(struct s2m_muic *);
+	int irq;
+};
+
+static int s2mu005_muic_detach(struct s2m_muic *priv)
+{
+	int ret;
+	int i;
+
+	ret = regmap_set_bits(priv->regmap, S2MU005_REG_MUIC_CTRL1,
+			      S2MU005_MUIC_MAN_SW);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to disable manual switching\n");
+		return ret;
+	}
+
+	ret = regmap_set_bits(priv->regmap, S2MU005_REG_MUIC_CTRL3,
+			      S2MU005_MUIC_ONESHOT_ADC);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to enable ADC oneshot mode\n");
+		return ret;
+	}
+
+	ret = regmap_clear_bits(priv->regmap, S2MU005_REG_MUIC_SWCTRL, ~0);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to clear switch control register\n");
+		return ret;
+	}
+
+	/* Find all set states and clear them */
+	for (i = 0; priv->extcon_cable[i]; i++) {
+		unsigned int state = priv->extcon_cable[i];
+
+		if (extcon_get_state(priv->extcon, state) == true)
+			extcon_set_state_sync(priv->extcon, state, false);
+	}
+
+	priv->attached = false;
+
+	return 0;
+}
+
+static int s2mu005_muic_attach(struct s2m_muic *priv)
+{
+	unsigned int type;
+	int ret;
+
+	/* If any device is already attached, detach it */
+	if (priv->attached) {
+		s2mu005_muic_detach(priv);
+		msleep(100);
+	}
+
+	ret = regmap_read(priv->regmap, S2MU005_REG_MUIC_DEV1, &type);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to read DEV1 register\n");
+		return ret;
+	}
+
+	/*
+	 * All USB connections which require communication via its D+
+	 * and D- wires need it.
+	 */
+	if (type & (S2MU005_MUIC_OTG | S2MU005_MUIC_DCP | S2MU005_MUIC_SDP)) {
+		ret = regmap_update_bits(priv->regmap, S2MU005_REG_MUIC_SWCTRL,
+					 S2MU005_MUIC_DM_DP,
+					 S2MU005_MUIC_DM_DP_USB);
+		if (ret < 0) {
+			dev_err(priv->dev, "failed to configure DM/DP pins\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * For OTG connections, enable manual switching and ADC oneshot
+	 * mode. Since the port will now be supplying power, the
+	 * internal ADC (measuring the ID-GND resistance) is made to
+	 * poll periodically for any changes, so as to prevent any
+	 * damages due to power.
+	 */
+	if (type & S2MU005_MUIC_OTG) {
+		ret = regmap_clear_bits(priv->regmap, S2MU005_REG_MUIC_CTRL1,
+					S2MU005_MUIC_MAN_SW);
+		if (ret < 0) {
+			dev_err(priv->dev, "failed to enable manual switching\n");
+			return ret;
+		}
+
+		ret = regmap_clear_bits(priv->regmap, S2MU005_REG_MUIC_CTRL3,
+					S2MU005_MUIC_ONESHOT_ADC);
+		if (ret < 0) {
+			dev_err(priv->dev, "failed to disable ADC oneshot mode\n");
+			return ret;
+		}
+	}
+
+	switch (type) {
+	case S2MU005_MUIC_OTG:
+		dev_dbg(priv->dev, "USB OTG connection detected\n");
+		extcon_set_state_sync(priv->extcon, EXTCON_USB_HOST, true);
+		priv->attached = true;
+		break;
+	case S2MU005_MUIC_CDP:
+		dev_dbg(priv->dev, "USB CDP connection detected\n");
+		extcon_set_state_sync(priv->extcon, EXTCON_USB, true);
+		extcon_set_state_sync(priv->extcon, EXTCON_CHG_USB_CDP, true);
+		priv->attached = true;
+		break;
+	case S2MU005_MUIC_SDP:
+		dev_dbg(priv->dev, "USB SDP connection detected\n");
+		extcon_set_state_sync(priv->extcon, EXTCON_USB, true);
+		extcon_set_state_sync(priv->extcon, EXTCON_CHG_USB_SDP, true);
+		priv->attached = true;
+		break;
+	case S2MU005_MUIC_DCP:
+		dev_dbg(priv->dev, "USB DCP connection detected\n");
+		extcon_set_state_sync(priv->extcon, EXTCON_USB, true);
+		extcon_set_state_sync(priv->extcon, EXTCON_CHG_USB_DCP, true);
+		priv->attached = true;
+		break;
+	case S2MU005_MUIC_UART:
+		dev_dbg(priv->dev, "UART connection detected\n");
+		extcon_set_state_sync(priv->extcon, EXTCON_JIG, true);
+		priv->attached = true;
+		break;
+	}
+
+	if (!priv->attached)
+		dev_warn(priv->dev, "failed to recognize the device attached\n");
+
+	return ret;
+}
+
+static int s2mu005_muic_init(struct s2m_muic *priv)
+{
+	int ret = 0;
+
+	ret = regmap_update_bits(priv->regmap, S2MU005_REG_MUIC_LDOADC_L,
+				 S2MU005_MUIC_VSET, S2MU005_MUIC_VSET_3P0V);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set internal ADC voltage regulator\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(priv->regmap, S2MU005_REG_MUIC_LDOADC_H,
+				 S2MU005_MUIC_VSET, S2MU005_MUIC_VSET_3P0V);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to set internal ADC voltage regulator\n");
+		return ret;
+	}
+
+	ret = regmap_clear_bits(priv->regmap, S2MU005_REG_MUIC_CTRL1,
+				S2MU005_MUIC_IRQ);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to enable MUIC interrupts\n");
+		return ret;
+	}
+
+	return s2mu005_muic_attach(priv);
+}
+
+static const unsigned int s2mu005_muic_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_CHG_USB_DCP,
+	EXTCON_CHG_USB_CDP,
+	EXTCON_JIG,
+	EXTCON_NONE,
+};
+
+static struct s2m_muic_irq_data s2mu005_muic_irq_data[] = {
+	{
+		.name = "attach",
+		.handler = s2mu005_muic_attach
+	}, {
+		.name = "detach",
+		.handler = s2mu005_muic_detach
+	}, {
+		/* sentinel */
+	}
+};
+
+static irqreturn_t s2m_muic_irq_func(int virq, void *data)
+{
+	struct s2m_muic *priv = data;
+	const struct s2m_muic_irq_data *irq_data = priv->irq_data;
+	int ret;
+	int i;
+
+	for (i = 0; irq_data[i].handler; i++) {
+		if (virq != irq_data[i].irq)
+			continue;
+
+		ret = irq_data[i].handler(priv);
+		if (ret < 0)
+			dev_err(priv->dev, "failed to handle interrupt for %s (%d)\n",
+				irq_data[i].name, ret);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int s2m_muic_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sec_pmic_dev *pmic_drvdata = dev_get_drvdata(dev->parent);
+	struct s2m_muic *priv;
+	int ret;
+	int i;
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
+		priv->extcon_cable = s2mu005_muic_extcon_cable;
+		priv->irq_data = s2mu005_muic_irq_data;
+		/* Initialize MUIC */
+		ret = s2mu005_muic_init(priv);
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV,
+				     "device type %d is not supported by driver\n",
+				     pmic_drvdata->device_type);
+	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to initialize MUIC\n");
+
+	priv->extcon = devm_extcon_dev_allocate(&pdev->dev, priv->extcon_cable);
+	if (IS_ERR(priv->extcon))
+		return dev_err_probe(dev, PTR_ERR(priv->extcon),
+				     "failed to allocate memory for extcon\n");
+
+	ret = devm_extcon_dev_register(dev, priv->extcon);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register extcon device\n");
+
+	for (i = 0; priv->irq_data[i].handler; i++) {
+		int irq = platform_get_irq_byname_optional(pdev,
+							   priv->irq_data[i].name);
+		if (irq == -ENXIO)
+			continue;
+		if (irq <= 0)
+			return dev_err_probe(dev, -EINVAL, "failed to get IRQ %s\n",
+					     priv->irq_data[i].name);
+
+		priv->irq_data[i].irq = irq;
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						s2m_muic_irq_func, IRQF_ONESHOT,
+						priv->irq_data[i].name, priv);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request IRQ\n");
+	}
+
+	return 0;
+}
+
+static void s2m_muic_remove(struct platform_device *pdev)
+{
+	struct s2m_muic *priv = dev_get_drvdata(&pdev->dev);
+
+	/*
+	 * Disabling the MUIC device is important as it disables manual
+	 * switching mode, thereby enabling auto switching mode.
+	 *
+	 * This is to ensure that when the board is powered off, it
+	 * goes into LPM charging mode when a USB charger is connected.
+	 */
+	switch (platform_get_device_id(pdev)->driver_data) {
+	case S2MU005:
+		s2mu005_muic_detach(priv);
+		break;
+	}
+}
+
+static const struct platform_device_id s2m_muic_id_table[] = {
+	{ "s2mu005-muic", S2MU005 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, s2m_muic_id_table);
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
+static const struct of_device_id s2m_muic_of_match_table[] = {
+	{
+		.compatible = "samsung,s2mu005-muic",
+		.data = (void *)S2MU005,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2m_muic_of_match_table);
+#endif
+
+static struct platform_driver s2m_muic_driver = {
+	.driver = {
+		.name = "s2m-muic",
+	},
+	.probe = s2m_muic_probe,
+	.remove = s2m_muic_remove,
+	.id_table = s2m_muic_id_table,
+};
+module_platform_driver(s2m_muic_driver);
+
+MODULE_DESCRIPTION("Extcon Driver For Samsung S2M Series PMICs");
+MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
+MODULE_LICENSE("GPL");

-- 
2.52.0


