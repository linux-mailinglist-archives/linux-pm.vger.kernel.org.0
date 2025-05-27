Return-Path: <linux-pm+bounces-27704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A87AC5D0D
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CC64A81EF
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 22:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0A218AC1;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlqpKvnX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26C21770C;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384785; cv=none; b=ZXi0aZRYi0Dl/+LBjdrVQDD1TDYr7MAc4u/dSu5vkxES5TjJhy96exW680HyFamLM68RZ8vkAekXtEzcw4HR6OXtyv6KFAHI8ZANkDxxwFT0Gk+2jqMVTEz5AzRxBx2TbCv3DcAWEk9+OcOEiSxxbJ+FwCYW1Bpas9EsEN42cgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384785; c=relaxed/simple;
	bh=4dGG9cNsmbWRrUh8AMfJ3DPeCEL7b5KAdhyrq1boNy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmyfNx/gyN+JpY7efMr5GW/N6d2w2kDFwWIcko2QoUzciuhT0Ypm9vVlSUETDMkD4VWj8C5uyrru0BpjM+3b2DjKBU9b1k8joAsIFtT3e/lYWH461WpIDjIEnSzLRh+GjX4wpbtRLevJ6R3PGDLyjSj8HIwoS3gKdxX/HJ4WqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlqpKvnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEF5AC4CEF7;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384785;
	bh=4dGG9cNsmbWRrUh8AMfJ3DPeCEL7b5KAdhyrq1boNy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BlqpKvnXxvph5vaY9wypjaoqIMpV6lnqfyDuAgfYDszCxi+g9u3yyPWDI8ww7hY8T
	 iAXmPmSm1MgEt8IRdbHY9+9QT33GyfZsTk97rajoSKg165I4E5d0AxUd1i+GpwCgGX
	 HwFAGc+c1HRQ+z/c4z6c8+CfasHm/X/8j94YvWdpfR1utX/mSZqOWC5pH6HJBzHEcA
	 l9CuoS91BDd3NjADKBT8NhN/VhmUJYnTMjmvbJoO4Sa3j9sCA3GKv79/0hoHH+h5f9
	 +MBBBnt+Ru7y/Fgd/zHIRxYYkQmqdltEUBospNC2dsAuLQW+fnqRNowG9h/aq5DdfH
	 hOq0+1oE82C3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1828C54ED1;
	Tue, 27 May 2025 22:26:24 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 27 May 2025 18:25:36 -0400
Subject: [PATCH v3 4/6] input: pf1550: add onkey support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pf1550-v3-4-45f69453cd51@savoirfairelinux.com>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
In-Reply-To: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, eballetbo@gmail.com, 
 abelvesa@linux.com, b38343@freescale.com, yibin.gong@nxp.com, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748384783; l=8033;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=/wsti50j6s+keD9n41QfbYKR2di1w3YFr5KzADXNbQc=;
 b=5ldXQyt/42Ui6q4uRuxUv33gUv2By7+g1mu/z1QyvcnwVNwxRURUJjDrDOgsMUYmXThsEx4yb
 weC2ZWpel3VAxLQKMSCJpWQSkf0gUMda1sTzDeujPgNEgnLXH1QnNCt
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add support for the onkey of the pf1550 PMIC.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
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
 drivers/input/misc/pf1550-onkey.c | 202 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index f5496ca0c0d2bfcb7968503ccd1844ff43bbc1c0..50ae50628f4d03f54b5678dbd28e3b58f8d02f86 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -179,6 +179,17 @@ config INPUT_PCSPKR
 	  To compile this driver as a module, choose M here: the
 	  module will be called pcspkr.
 
+config INPUT_PF1550_ONKEY
+	tristate "PF1550 Onkey support"
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
index 0000000000000000000000000000000000000000..7c10bc75708891a22d8b67b44e55f18c42f09749
--- /dev/null
+++ b/drivers/input/misc/pf1550-onkey.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the PF1550 ON_KEY
+ * Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
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
+	struct pf1550_dev *pf1550;
+	unsigned int irq;
+	int keycode;
+	int wakeup;
+	struct input_dev *input;
+};
+
+static irqreturn_t pf1550_onkey_irq_handler(int irq, void *data)
+{
+	struct onkey_drv_data *onkey = data;
+	struct irq_domain *domain;
+	int i, state, irq_type = -1;
+	unsigned int virq;
+
+	domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
+	onkey->irq = irq;
+
+	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
+		virq = irq_find_mapping(domain, i);
+		if (onkey->irq == virq)
+			irq_type = i;
+	}
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
+	input_event(onkey->input, EV_KEY, onkey->keycode, state);
+	input_sync(onkey->input);
+
+	return IRQ_HANDLED;
+}
+
+static int pf1550_onkey_probe(struct platform_device *pdev)
+{
+	struct onkey_drv_data *onkey;
+	struct input_dev *input;
+	struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
+	struct irq_domain *domain;
+	int i, error;
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	if (!pf1550->regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to get regmap\n");
+
+	onkey->wakeup = device_property_read_bool(pdev->dev.parent,
+						  "wakeup-source");
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to allocate the input device\n");
+
+	onkey->input = input;
+	onkey->keycode = KEY_POWER;
+
+	input->name = pdev->name;
+	input->phys = "pf1550-onkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_KEY, onkey->keycode);
+
+	domain = regmap_irq_get_domain(pf1550->irq_data_onkey);
+
+	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
+		unsigned int virq = irq_find_mapping(domain, i);
+
+		error = devm_request_threaded_irq(&pdev->dev, virq, NULL,
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
+	if (error < 0)
+		return dev_err_probe(&pdev->dev, error,
+				     "failed to register input device\n");
+
+	onkey->pf1550 = pf1550;
+	platform_set_drvdata(pdev, onkey);
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
+	struct irq_domain *domain;
+	unsigned int virq;
+	int i;
+
+	domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
+
+	if (!device_may_wakeup(&pdev->dev)) {
+		regmap_write(onkey->pf1550->regmap,
+			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
+			     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
+			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
+	} else {
+		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
+			virq = irq_find_mapping(domain, i);
+
+			if (virq)
+				enable_irq_wake(virq);
+		}
+	}
+
+	return 0;
+}
+
+static int pf1550_onkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
+	struct irq_domain *domain;
+	unsigned int virq;
+	int i;
+
+	domain = regmap_irq_get_domain(onkey->pf1550->irq_data_onkey);
+
+	if (!device_may_wakeup(&pdev->dev)) {
+		regmap_write(onkey->pf1550->regmap,
+			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
+			     ~((u8)(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI |
+			     ONKEY_IRQ_2SI | ONKEY_IRQ_3SI | ONKEY_IRQ_4SI |
+			     ONKEY_IRQ_8SI)));
+	} else {
+		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
+			virq = irq_find_mapping(domain, i);
+
+			if (virq)
+				disable_irq_wake(virq);
+		}
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
+			 pf1550_onkey_resume);
+
+static const struct platform_device_id pf1550_onkey_id[] = {
+	{ "pf1550-onkey", PF1550 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, pf1550_onkey_id);
+
+static struct platform_driver pf1550_onkey_driver = {
+	.driver = {
+		.name = "pf1550-onkey",
+		.pm   = &pf1550_onkey_pm_ops,
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
2.49.0



