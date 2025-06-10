Return-Path: <linux-pm+bounces-28412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37503AD4332
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 21:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B92189A1FB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0C265CA2;
	Tue, 10 Jun 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLO0jTuq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCC264FB2;
	Tue, 10 Jun 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584887; cv=none; b=iR++9fyUvFkccSxpECQvn6FPNVlgqUyECYyWoPldymuo+/b43nJ051DE1fXgVQ7ZowET5V5p6WRbUProa3yG5UQbqFWjVimACkxZ9f4kxDnGGHa9mFqT/2A/ZAozXEN7wn1mqajqRQYzMxuV+6XexbpECtfMzHgUzG94EsYR7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584887; c=relaxed/simple;
	bh=cJT2EuxXe+/Es5N8Tk+Lislg1ISVab+68e2xEZ4C6JM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8B5Q5LucgpKaewFmepjucb8YfXrdI+hLc4UgvntxDtzperQ4PZgqnEgNjDIPZEN7RsV5ryZO3QXtW0x64cKcp91N1sCpvvkRtxsJxvas+NlYajRxZ0SYZWs560fcFn0vYnYWfSlCvlCDkwGzbl6/hsC/3EDNMnbEenOqagLJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLO0jTuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4099C4CEF3;
	Tue, 10 Jun 2025 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749584886;
	bh=cJT2EuxXe+/Es5N8Tk+Lislg1ISVab+68e2xEZ4C6JM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jLO0jTuqruFjGKNLjeVqc5yVo8oa3yf7otdf2t4DcR6CB4lF6dciZUPSW/iMbl6zH
	 HviMlvJJHv0xZVEa5URQLatY4ziwKADH+n9y2s49lbhxu5R4/DJa0TXsTnOlAZGLUw
	 z4ToDf19uGywkr0kvNgrl85tPkrVxmAGq2+7vnGlyIZt4No7Fu1Tzenzj+2sN86M/q
	 GQbHoW74tKdh/TY/brq4L/J1l80oz9W/QOE3XTZjCFQHEjqmw+1dXPnstX4xFTz7iH
	 ZT6tDPIdCRHEFEb5igOhX5bRAZIbCxe/5BPK7X+KRe3qwoUvVLeVzXN6dKDkbVuhYc
	 3XSsYWjJYDshA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8357C71133;
	Tue, 10 Jun 2025 19:48:06 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 10 Jun 2025 15:47:32 -0400
Subject: [PATCH v5 4/6] input: pf1550: add onkey support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-pf1550-v5-4-ed0d9e3aaac7@savoirfairelinux.com>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
In-Reply-To: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
 Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749584885; l=8036;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=JS/l4QGiX7+nAuPrzFit8kIZwe3Eqs9OB3rvAc7d51w=;
 b=fPZ6vuEL0kJCCkx4CxLIfnXyl4qKvl6AJi3xtIIfDGG2zLDGyt3kHwWFlKgreFeELzCHVBY2Y
 XF9aQfKQoD5BYqV9j8iZznG8DcxZtBbIlMD/uX72kdPknVhF573f9tx
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
 drivers/input/misc/pf1550-onkey.c | 183 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

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
index 0000000000000000000000000000000000000000..7e604c5544066eefbd84abe7bdff767b8b8978ab
--- /dev/null
+++ b/drivers/input/misc/pf1550-onkey.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for the PF1550 ON_KEY
+// Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
+//
+// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
+// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+//
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
+	const struct pf1550_dev *pf1550;
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
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to allocate the input device\n");
+
+	input->name = pdev->name;
+	input->phys = "pf1550-onkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_KEY, KEY_POWER);
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
+	{ "pf1550-onkey", 0 },
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
2.49.0



