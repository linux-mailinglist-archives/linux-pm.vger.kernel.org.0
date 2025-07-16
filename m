Return-Path: <linux-pm+bounces-30919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B4B07934
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F21D3B27DC
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788732EE97D;
	Wed, 16 Jul 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr9HO/6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37614275AE0;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678714; cv=none; b=s9yu/hpCWn2PWzg6oAvvlUcY+5oLSEn80RXm1RFMDQCjI03HMHh1+eM1utA1w1/WEurTMHO14RwY2yBK6otfuEmXCV3vvMT9oEBV0fWMRc12l61VyyFt0aVe6cq5IJSBmi4WKEhAzYI1OE8iZyxR3XwUY88xIHNV1BFZQAKALmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678714; c=relaxed/simple;
	bh=zeUTjh1J//m6OhigRHlKUs+Il+fdWWxPijqspR4x8jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C8BVZYOPRKT49/YIFbFUNKJdNc037bdbSklSbyNqsfjMWXi2D6V/I/LkRSdTK9kAg56QmBJ+vFDdJtL15QDag/FalSf6luyLY2x+fhXEjTrOQ/xZeyjb3rYVYo9dUCPks7X3aFPNw4owbIA6f6xGL/bpvPZaV9DMsXsNTjwm6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr9HO/6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDDF0C4CEFE;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678713;
	bh=zeUTjh1J//m6OhigRHlKUs+Il+fdWWxPijqspR4x8jg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kr9HO/6qP+GjkwkFd4RzgvyYOz1i2XOQgh35GYyXiXM6cl7vCOBP0xeRQMRCTxsaS
	 ku04F4KLC7PHx9PtrxNkgx1UGq24ZiKLjziGbviDL9fkdc5P1VN9TiHJuWY7FCl+li
	 8KWySPGefPDZBOKteqOwt3NpW+trDEnLmPfCILUzioKl3eU0nNGMmNgHTDmr4+fHo2
	 mL1vIwY++IrUD8yZEWBKDBAiIkGYscqY4+tglT5ckSUr/+I4qj2DmDVXHtn07h4Vnm
	 JsthtMFMfayT00zQr2bBIAbzpHqpAYgq1xBmmuZghq5Xumba08T4ZLkePTgj4SLWUK
	 xJe++J+pGEVyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22BFC83F37;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 16 Jul 2025 11:11:47 -0400
Subject: [PATCH v9 4/6] input: pf1550: add onkey support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-pf1550-v9-4-502a647f04ef@savoirfairelinux.com>
References: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com>
In-Reply-To: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, 
 Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752678712; l=8814;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=C+xgFLxnIqfULJKCBSISSMrTcSFdK8J7INoHzCH7r+4=;
 b=MCqXPknHmhknUylLjZ13LPFwvHeTtc4yhA9WbEcPC9RoV7JBGZO0f6A4/n42Q5QJcyLly+1WK
 HNfvzj/cNxaDJINDF+1NAeMevJspFnhqAuoZ6vlEWLAmtOwUG6N79AL
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add support for the onkey of the pf1550 PMIC.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v9:
- Requested by Sean:
  - Add support for disabling power down of system by onkey
v8:
- Pick up `Acked-by` tag from Dmitry
- Use C++ for SPDX license header comment and C type for rest of license
  comment
v7:
- Use reverese christmas tree style
- Drop unecessary 0 in id table's driver data
v4:
- Address Dmitry's feedback
  - Drop irq variable in onkey_drv_data
  - Drop keycode variable in onkey_drv_data
  - Define wakeup as type bool
  - Use platform_get_irq
  - Use type const for struct pf1550_dev in onkey_drv_data
  - Replace (error < 0) with (error) in if statement when applicable
  - No need to define driver_data in table id
- Define driver.pm with pm_sleep_ptr
v3:
- Address Dmitry's feedback
  - Drop compatible string
  - Remove dependency on OF
  - Use generic device properties
  - Drop unnecessary includes
  - Drop unnecessary initializations in probe
  - Always use the KEY_POWER property for onkey->keycode
  - Do mapping of irqs in MFD driver
  - Define onkey->input before interrupts are active
  - Drop unnecessary input_free_device since devm
  - Manage onkey irqs instead of the main interrupt line.
- Fix integer overflow when unmasking onkey irqs in onkey_resume.
v2:
- Add driver for onkey
---
 drivers/input/misc/Kconfig        |  11 +++
 drivers/input/misc/Makefile       |   1 +
 drivers/input/misc/pf1550-onkey.c | 196 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index f5496ca0c0d2bfcb7968503ccd1844ff43bbc1c0..47b3c43ff0550f14d61990997976366436411adc 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -179,6 +179,17 @@ config INPUT_PCSPKR
 	  To compile this driver as a module, choose M here: the
 	  module will be called pcspkr.
 
+config INPUT_PF1550_ONKEY
+	tristate "NXP PF1550 Onkey support"
+	depends on MFD_PF1550
+	help
+	  Say Y here if you want support for PF1550 PMIC. Onkey can trigger
+	  release and 1s(push hold), 2s, 3s, 4s, 8s interrupt for long press
+	  detect.
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called pf1550-onkey.
+
 config INPUT_PM8941_PWRKEY
 	tristate "Qualcomm PM8941 power key support"
 	depends on MFD_SPMI_PMIC
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 6d91804d0a6f761a094e6c380f878f74c3054d63..c652337de464c1eeaf1515d0bc84d10de0cb3a74 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
 obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
+obj-$(CONFIG_INPUT_PF1550_ONKEY)	+= pf1550-onkey.o
 obj-$(CONFIG_INPUT_PM8941_PWRKEY)	+= pm8941-pwrkey.o
 obj-$(CONFIG_INPUT_PM8XXX_VIBRATOR)	+= pm8xxx-vibrator.o
 obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
diff --git a/drivers/input/misc/pf1550-onkey.c b/drivers/input/misc/pf1550-onkey.c
new file mode 100644
index 0000000000000000000000000000000000000000..8b24ed518b8cdd48be9078d0ef9da501752802d6
--- /dev/null
+++ b/drivers/input/misc/pf1550-onkey.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the PF1550 ONKEY
+ * Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+ * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+ */
+
+#include <linux/err.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/platform_device.h>
+
+#define PF1550_ONKEY_IRQ_NR	6
+
+struct onkey_drv_data {
+	struct device *dev;
+	const struct pf1550_ddata *pf1550;
+	bool wakeup;
+	struct input_dev *input;
+};
+
+static irqreturn_t pf1550_onkey_irq_handler(int irq, void *data)
+{
+	struct onkey_drv_data *onkey = data;
+	struct platform_device *pdev = to_platform_device(onkey->dev);
+	int i, state, irq_type = -1;
+
+	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++)
+		if (irq == platform_get_irq(pdev, i))
+			irq_type = i;
+
+	switch (irq_type) {
+	case PF1550_ONKEY_IRQ_PUSHI:
+		state = 0;
+		break;
+	case PF1550_ONKEY_IRQ_1SI:
+	case PF1550_ONKEY_IRQ_2SI:
+	case PF1550_ONKEY_IRQ_3SI:
+	case PF1550_ONKEY_IRQ_4SI:
+	case PF1550_ONKEY_IRQ_8SI:
+		state = 1;
+		break;
+	default:
+		dev_err(onkey->dev, "onkey interrupt: irq %d occurred\n",
+			irq_type);
+		return IRQ_HANDLED;
+	}
+
+	input_event(onkey->input, EV_KEY, KEY_POWER, state);
+	input_sync(onkey->input);
+
+	return IRQ_HANDLED;
+}
+
+static int pf1550_onkey_probe(struct platform_device *pdev)
+{
+	struct onkey_drv_data *onkey;
+	struct input_dev *input;
+	bool key_power = false;
+	int i, irq, error;
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	onkey->dev = &pdev->dev;
+
+	onkey->pf1550 = dev_get_drvdata(pdev->dev.parent);
+	if (!onkey->pf1550->regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to get regmap\n");
+
+	onkey->wakeup = device_property_read_bool(pdev->dev.parent,
+						  "wakeup-source");
+
+	if (device_property_read_bool(pdev->dev.parent,
+				      "nxp,disable-key-power")) {
+		error = regmap_write(onkey->pf1550->regmap,
+				     PF1550_PMIC_REG_PWRCTRL1, 0);
+		if (error)
+			return dev_err_probe(&pdev->dev, error,
+					     "failed: disable turn system off");
+	} else {
+		key_power = true;
+	}
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to allocate the input device\n");
+
+	input->name = pdev->name;
+	input->phys = "pf1550-onkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	if (key_power)
+		input_set_capability(input, EV_KEY, KEY_POWER);
+
+	onkey->input = input;
+	platform_set_drvdata(pdev, onkey);
+
+	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			return irq;
+
+		error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						  pf1550_onkey_irq_handler,
+						  IRQF_NO_SUSPEND,
+						  "pf1550-onkey", onkey);
+		if (error)
+			return dev_err_probe(&pdev->dev, error,
+					     "failed: irq request (IRQ: %d)\n",
+					     i);
+	}
+
+	error = input_register_device(input);
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "failed to register input device\n");
+
+	device_init_wakeup(&pdev->dev, onkey->wakeup);
+
+	return 0;
+}
+
+static int pf1550_onkey_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
+	int i, irq;
+
+	if (!device_may_wakeup(&pdev->dev))
+		regmap_write(onkey->pf1550->regmap,
+			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
+			     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
+			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
+	else
+		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
+			irq = platform_get_irq(pdev, i);
+			if (irq > 0)
+				enable_irq_wake(irq);
+		}
+
+	return 0;
+}
+
+static int pf1550_onkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
+	int i, irq;
+
+	if (!device_may_wakeup(&pdev->dev))
+		regmap_write(onkey->pf1550->regmap,
+			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
+			     ~((u8)(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI |
+			     ONKEY_IRQ_2SI | ONKEY_IRQ_3SI | ONKEY_IRQ_4SI |
+			     ONKEY_IRQ_8SI)));
+	else
+		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
+			irq = platform_get_irq(pdev, i);
+			if (irq > 0)
+				disable_irq_wake(irq);
+		}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
+			 pf1550_onkey_resume);
+
+static const struct platform_device_id pf1550_onkey_id[] = {
+	{ "pf1550-onkey", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, pf1550_onkey_id);
+
+static struct platform_driver pf1550_onkey_driver = {
+	.driver = {
+		.name = "pf1550-onkey",
+		.pm   = pm_sleep_ptr(&pf1550_onkey_pm_ops),
+	},
+	.probe = pf1550_onkey_probe,
+	.id_table = pf1550_onkey_id,
+};
+module_platform_driver(pf1550_onkey_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor");
+MODULE_DESCRIPTION("PF1550 onkey Driver");
+MODULE_LICENSE("GPL");

-- 
2.50.1



