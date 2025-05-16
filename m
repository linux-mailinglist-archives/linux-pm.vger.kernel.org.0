Return-Path: <linux-pm+bounces-27244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4FCABA356
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 21:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B527B5669
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A4527AC4C;
	Fri, 16 May 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="ha1924NL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46027875A;
	Fri, 16 May 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421854; cv=none; b=oL5xNOpvBanSge7qW1ghyStnItFAlKydAN1PFi34NX/GBkvkgGCynQwVdR0YrnBQPNReU58xx+w4Ithzflk5qeCbBK1szX7EAXTzNpBZz6aDrbEvZ9jgslJsjU5ISvDfaj8bKLMYN8QQIPIe7SgBblo7sZhpMLTNSClcUXRIw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421854; c=relaxed/simple;
	bh=xlLlIm4e+ABQWXe061edXN3a87MRq3AWQF40axYquxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df7b7Xi/memfunrM01qiKHmnfHWXwp+IbOtUIuDR37p8f4cODim/WB81qZAWk0SASz91QT4OXIAbF3qryvU3fhE8POiYdBf47QDN9N6/mJx1w0Vx7tSbxRuBFsz3NoPRAogSDtQQE6XXBJUpTjJqoZmchKWUXFSnFxsuqU2eN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=ha1924NL; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F35779C8E32;
	Fri, 16 May 2025 14:57:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Gpc47g7EJ_vs; Fri, 16 May 2025 14:57:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1BD2F9C9056;
	Fri, 16 May 2025 14:57:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1BD2F9C9056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421850; bh=V1U5IawNA+RWVDfUEn2zIzYoYdDMlZRLwkvIEHpxkbU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ha1924NLAr2UuHMaVlVotxrx6rVHtpStFcIAlD0R5O3h/nmo4k7sBvc2QdZAeV3HC
	 X0obgCmXFh1lVikB4B+HiFKnLxSzVVm5ksWioyZpufIOyPhZJlIvPjuTYyFaVlGFrQ
	 8q3GdtuPl8kZ7+e3C83lmjYJIDQ2QVvFI7KyS4eNQYvWx9Imw7yYKjr4/Li4nIfZY4
	 DwVUBW5d2swpzb/9Y3nCISTX9EkXTzZzO1f4b54NL58n4uT2hUzh5ULd5jf+1BPooz
	 NXfScI+R7OUJbG3UwccYM4iabwkIl95fm2TwUsqz+MyCpqXPr8Tb9WViH+aHfWwSc4
	 g1wKWNb5oXdWw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OE_ryA3TmiKR; Fri, 16 May 2025 14:57:29 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C53169C8E32;
	Fri, 16 May 2025 14:57:29 -0400 (EDT)
Date: Fri, 16 May 2025 14:57:28 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, linux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH v2 7/9] input: pf1550: add onkey support
Message-ID: <7d80afedf1ad9e98c9739163751bcb2785009e74.1747409892.git.samuel.kayode@savoirfairelinux.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>

Add support for the onkey of the pf1550 PMIC.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 drivers/input/keyboard/Kconfig        |   8 ++
 drivers/input/keyboard/Makefile       |   1 +
 drivers/input/keyboard/pf1550_onkey.c | 200 ++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/input/keyboard/pf1550_onkey.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 721ab69e84ac..b01decc03ab9 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -444,6 +444,14 @@ config KEYBOARD_SNVS_PWRKEY
 	  To compile this driver as a module, choose M here; the
 	  module will be called snvs_pwrkey.
 
+config KEYBOARD_PF1550_ONKEY
+	tristate "PF1550 OnKey Driver"
+	depends on MFD_PF1550
+	depends on OF
+	help
+	  This is onkey driver for PF1550 pmic, onkey can trigger release
+	  and 1s(push hold), 2s, 3s, 4s, 8s interrupt for long press detect
+
 config KEYBOARD_IMX
 	tristate "IMX keypad support"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 1e0721c30709..8a6feae3ddb1 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
 obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
 obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
 obj-$(CONFIG_KEYBOARD_SNVS_PWRKEY)	+= snvs_pwrkey.o
+obj-$(CONFIG_KEYBOARD_PF1550_ONKEY)	+= pf1550_onkey.o
 obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
 obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
 obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
diff --git a/drivers/input/keyboard/pf1550_onkey.c b/drivers/input/keyboard/pf1550_onkey.c
new file mode 100644
index 000000000000..b0601acf893d
--- /dev/null
+++ b/drivers/input/keyboard/pf1550_onkey.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the PF1550 ON_KEY
+ * Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct onkey_drv_data {
+	struct device *dev;
+	struct pf1550_dev *pf1550;
+	int irq;
+	int keycode;
+	int wakeup;
+	struct input_dev *input;
+};
+
+static struct pf1550_irq_info pf1550_onkey_irqs[] = {
+	{ PF1550_ONKEY_IRQ_PUSHI,	"release" },
+	{ PF1550_ONKEY_IRQ_1SI,		"1S" },
+	{ PF1550_ONKEY_IRQ_2SI,		"2S" },
+	{ PF1550_ONKEY_IRQ_3SI,		"3S" },
+	{ PF1550_ONKEY_IRQ_4SI,		"4S" },
+	{ PF1550_ONKEY_IRQ_8SI,		"8S" },
+};
+
+static irqreturn_t pf1550_onkey_irq_handler(int irq, void *data)
+{
+	struct onkey_drv_data *onkey = data;
+	int i, state, irq_type = -1;
+
+	onkey->irq = irq;
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_onkey_irqs); i++)
+		if (onkey->irq == pf1550_onkey_irqs[i].virq)
+			irq_type = pf1550_onkey_irqs[i].irq;
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
+	struct input_dev *input = NULL;
+	struct device_node *np = pdev->dev.of_node;
+	struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
+	int i, error;
+
+	if (!np)
+		return -ENODEV;
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	if (of_property_read_u32(np, "linux,keycodes", &onkey->keycode)) {
+		onkey->keycode = KEY_POWER;
+		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
+	}
+
+	onkey->wakeup = of_property_read_bool(np, "wakeup-source");
+
+	input = devm_input_allocate_device(&pdev->dev);
+	if (!input) {
+		dev_err(&pdev->dev, "failed to allocate the input device\n");
+		return -ENOMEM;
+	}
+
+	input->name = pdev->name;
+	input->phys = "pf1550-onkey/input0";
+	input->id.bustype = BUS_HOST;
+
+	input_set_capability(input, EV_KEY, onkey->keycode);
+
+	for (i = 0; i < ARRAY_SIZE(pf1550_onkey_irqs); i++) {
+		struct pf1550_irq_info *onkey_irq =
+						&pf1550_onkey_irqs[i];
+		unsigned int virq = 0;
+
+		virq = regmap_irq_get_virq(pf1550->irq_data_onkey,
+					   onkey_irq->irq);
+		if (!virq)
+			return -EINVAL;
+
+		onkey_irq->virq = virq;
+
+		error = devm_request_threaded_irq(&pdev->dev, virq, NULL,
+						  pf1550_onkey_irq_handler,
+					IRQF_NO_SUSPEND,
+					onkey_irq->name, onkey);
+		if (error) {
+			dev_err(&pdev->dev,
+				"failed: irq request (IRQ: %d, error :%d)\n",
+				onkey_irq->irq, error);
+			return error;
+		}
+	}
+
+	error = input_register_device(input);
+	if (error < 0) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		input_free_device(input);
+		return error;
+	}
+
+	onkey->input = input;
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
+
+	if (!device_may_wakeup(&pdev->dev))
+		regmap_write(onkey->pf1550->regmap,
+			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
+			     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
+			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
+	else
+		enable_irq_wake(onkey->pf1550->irq);
+
+	return 0;
+}
+
+static int pf1550_onkey_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
+
+	if (!device_may_wakeup(&pdev->dev))
+		regmap_write(onkey->pf1550->regmap,
+			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
+			     ~(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
+			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI));
+	else
+		disable_irq_wake(onkey->pf1550->irq);
+
+	return 0;
+}
+
+static const struct of_device_id pf1550_onkey_ids[] = {
+	{ .compatible = "fsl,pf1550-onkey" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pf1550_onkey_ids);
+
+static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
+				pf1550_onkey_resume);
+
+static struct platform_driver pf1550_onkey_driver = {
+	.driver = {
+		.name = "pf1550-onkey",
+		.pm     = &pf1550_onkey_pm_ops,
+		.of_match_table = pf1550_onkey_ids,
+	},
+	.probe = pf1550_onkey_probe,
+};
+module_platform_driver(pf1550_onkey_driver);
+
+MODULE_AUTHOR("Freescale Semiconductor");
+MODULE_DESCRIPTION("PF1550 onkey Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.49.0


