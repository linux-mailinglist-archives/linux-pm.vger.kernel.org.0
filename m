Return-Path: <linux-pm+bounces-27242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2070ABA339
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C23BA858
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3C27C864;
	Fri, 16 May 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="rFrm5qmR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72431194A6C;
	Fri, 16 May 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421692; cv=none; b=g0GZqglzqI4LeTCsSRXXa7zDu07ooNGFz/iyu0yub6howlqV/PmVtuUQVbg+k/GnTMrSukqov2StEwr1Wy+CYq/5sS02aoCz0E62vs4NydGnrCCysdHYjL+7JqNahq3ddAZ5COaTzKUMAYNFzqxgLejg/W7knW2S91ufeEIAW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421692; c=relaxed/simple;
	bh=orZ/9ixknjV6B7jYgTXHdv0OWLfY21dMZMtGmHzgMWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b//fx2rX0IY26fRglnR4xIAj8m78ilWs1H8AZw+UUzWrffpYQNlIALQSCsBBbztgnCWYkqqPMhDOI1G5I0mH6m+9ULbYX7NLNhRJLGgR35dVTgMRPIh//1XU1lCm6vpIFH8+qRjBHDf9lrd6ZxEDLeaOoNXxJCENQO51QflNsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=rFrm5qmR; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6A0199C9014;
	Fri, 16 May 2025 14:54:49 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gyaqBsXPLpV5; Fri, 16 May 2025 14:54:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F002F9C9048;
	Fri, 16 May 2025 14:54:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F002F9C9048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421688; bh=tEtiabgVuCm58NCzU9IY5RYYJP1UfGaqmi7K4Yy6MrA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=rFrm5qmRkGNbmsKTVNCkg6bNY4E7MiY5PKce2sEnVCwCppc72rrlYuMc1df2mB3eo
	 ZWsNqUWjNmRFD6LPIskuzAi+R87xUnMJeLDysqCWMjUa9YToh3Rwp9hoIkM0PLaajr
	 fmaylwo/10LQ4fhwdOfG/Y3v66QJcaMkG3IaDbHAUshCPvUvVkif7lAQU2AR3SUs7N
	 XXBnu8wN22hlXbfqQzM089RAP4nmQlCLpd3DfoFQWVUrb9vNBgYoWH3792OqbWz+JK
	 4F7wT523SI8SZVb2UNuOTQ69ygWxBN/DMDNkSp+tUWbJiQIChc0R1hcg+6GCBCpnre
	 W5zeqviiPnOkw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id C9BBrA9AWwoa; Fri, 16 May 2025 14:54:47 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B0ABD9C9014;
	Fri, 16 May 2025 14:54:47 -0400 (EDT)
Date: Fri, 16 May 2025 14:54:46 -0400
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
Subject: [PATCH v2 5/9] mfd: pf1550: add core mfd driver
Message-ID: <85004e02a5177aef6334fc30494bb3924a58f1de.1747409892.git.samuel.kayode@savoirfairelinux.com>
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

Add the core mfd driver for pf1550 PMIC. There are 3 subdevices for
which the drivers will be added in subsequent patches.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 drivers/mfd/Kconfig        |  14 ++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/pf1550.c       | 254 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/pf1550.h | 246 +++++++++++++++++++++++++++++++++++
 4 files changed, 516 insertions(+)
 create mode 100644 drivers/mfd/pf1550.c
 create mode 100644 include/linux/mfd/pf1550.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 22b936310039..e2c2d1d798f3 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -558,6 +558,20 @@ config MFD_MX25_TSADC
 	  i.MX25 processors. They consist of a conversion queue for general
 	  purpose ADC and a queue for Touchscreens.
 
+config MFD_PF1550
+	tristate "Freescale Semiconductor PF1550 PMIC Support"
+	depends on I2C=y
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	help
+	  Say yes here to add support for Freescale Semiconductor PF1550.
+	  This is a companion Power Management IC with regulators, ONKEY,
+	  and charger control on chip.
+	  This driver provides common support for accessing the device;
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 config MFD_HI6421_PMIC
 	tristate "HiSilicon Hi6421 PMU/Codec IC"
 	depends on OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 948cbdf42a18..c4f270c5538a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -120,6 +120,8 @@ obj-$(CONFIG_MFD_MC13XXX)	+= mc13xxx-core.o
 obj-$(CONFIG_MFD_MC13XXX_SPI)	+= mc13xxx-spi.o
 obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
+obj-$(CONFIG_MFD_PF1550)	+= pf1550.o
+
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
 ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o
diff --git a/drivers/mfd/pf1550.c b/drivers/mfd/pf1550.c
new file mode 100644
index 000000000000..6b5bdd9a1630
--- /dev/null
+++ b/drivers/mfd/pf1550.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pf1550.c - mfd core driver for the PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ *
+ * This driver is based on max77693.c
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/pf1550.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+static const struct mfd_cell pf1550_devs[] = {
+	{
+		.name = "pf1550-regulator",
+		.of_compatible = "fsl,pf1550-regulator",
+	},
+	{
+		.name = "pf1550-onkey",
+		.of_compatible = "fsl,pf1550-onkey",
+	},
+	{
+		.name = "pf1550-charger",
+		.of_compatible = "fsl,pf1550-charger",
+	},
+};
+
+static const struct regmap_config pf1550_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PF1550_PMIC_REG_END,
+};
+
+static const struct regmap_irq pf1550_regulator_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_LS,	       0, PMIC_IRQ_SW1_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_LS,	       0, PMIC_IRQ_SW2_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_LS,	       0, PMIC_IRQ_SW3_LS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW1_HS,	       3, PMIC_IRQ_SW1_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW2_HS,	       3, PMIC_IRQ_SW2_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_SW3_HS,	       3, PMIC_IRQ_SW3_HS),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO1_FAULT,    16, PMIC_IRQ_LDO1_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO2_FAULT,    16, PMIC_IRQ_LDO2_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_LDO3_FAULT,    16, PMIC_IRQ_LDO3_FAULT),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_110,      22, PMIC_IRQ_TEMP_110),
+	REGMAP_IRQ_REG(PF1550_PMIC_IRQ_TEMP_125,      22, PMIC_IRQ_TEMP_125),
+};
+
+static const struct regmap_irq_chip pf1550_regulator_irq_chip = {
+	.name			= "pf1550-regulator",
+	.status_base		= PF1550_PMIC_REG_SW_INT_STAT0,
+	.mask_base		= PF1550_PMIC_REG_SW_INT_MASK0,
+	.num_regs		= 23,
+	.irqs			= pf1550_regulator_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_regulator_irqs)
+};
+
+static const struct regmap_irq pf1550_onkey_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_PUSHI,  0, ONKEY_IRQ_PUSHI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_1SI,	0, ONKEY_IRQ_1SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_2SI,	0, ONKEY_IRQ_2SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_3SI,	0, ONKEY_IRQ_3SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_4SI,	0, ONKEY_IRQ_4SI),
+	REGMAP_IRQ_REG(PF1550_ONKEY_IRQ_8SI,    0, ONKEY_IRQ_8SI),
+};
+
+static const struct regmap_irq_chip pf1550_onkey_irq_chip = {
+	.name			= "pf1550-onkey",
+	.status_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
+	.ack_base		= PF1550_PMIC_REG_ONKEY_INT_STAT0,
+	.mask_base		= PF1550_PMIC_REG_ONKEY_INT_MASK0,
+	.use_ack                = 1,
+	.init_ack_masked	= 1,
+	.num_regs		= 1,
+	.irqs			= pf1550_onkey_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_onkey_irqs),
+};
+
+static const struct regmap_irq pf1550_charger_irqs[] = {
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BAT2SOCI,	0, CHARG_IRQ_BAT2SOCI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_BATI,		0, CHARG_IRQ_BATI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_CHGI,		0, CHARG_IRQ_CHGI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_VBUSI,		0, CHARG_IRQ_VBUSI),
+	REGMAP_IRQ_REG(PF1550_CHARG_IRQ_THMI,		0, CHARG_IRQ_THMI),
+};
+
+static const struct regmap_irq_chip pf1550_charger_irq_chip = {
+	.name			= "pf1550-charger",
+	.status_base		= PF1550_CHARG_REG_CHG_INT,
+	.mask_base		= PF1550_CHARG_REG_CHG_INT_MASK,
+	.num_regs		= 1,
+	.irqs			= pf1550_charger_irqs,
+	.num_irqs		= ARRAY_SIZE(pf1550_charger_irqs),
+};
+
+int pf1550_read_otp(struct pf1550_dev *pf1550, unsigned int index,
+		    unsigned int *val)
+{
+	int ret = 0;
+
+	ret = regmap_write(pf1550->regmap, PF1550_PMIC_REG_KEY, 0x15);
+	if (ret)
+		goto read_err;
+	ret = regmap_write(pf1550->regmap, PF1550_CHARG_REG_CHGR_KEY2, 0x50);
+	if (ret)
+		goto read_err;
+	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_KEY3, 0xAB);
+	if (ret)
+		goto read_err;
+	ret = regmap_write(pf1550->regmap, PF1550_TEST_REG_FMRADDR, index);
+	if (ret)
+		goto read_err;
+	ret = regmap_read(pf1550->regmap, PF1550_TEST_REG_FMRDATA, val);
+	if (ret)
+		goto read_err;
+
+	return 0;
+
+read_err:
+	dev_err(pf1550->dev, "read otp reg %x found!\n", index);
+	return ret;
+}
+
+static int pf1550_i2c_probe(struct i2c_client *i2c)
+{
+	struct pf1550_dev *pf1550;
+	unsigned int reg_data = 0;
+	int ret = 0;
+
+	pf1550 = devm_kzalloc(&i2c->dev,
+			      sizeof(struct pf1550_dev), GFP_KERNEL);
+	if (!pf1550)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, pf1550);
+	pf1550->dev = &i2c->dev;
+	pf1550->i2c = i2c;
+	pf1550->irq = i2c->irq;
+
+	pf1550->regmap = devm_regmap_init_i2c(i2c, &pf1550_regmap_config);
+	if (IS_ERR(pf1550->regmap)) {
+		ret = PTR_ERR(pf1550->regmap);
+		dev_err(pf1550->dev, "failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = regmap_read(pf1550->regmap, PF1550_PMIC_REG_DEVICE_ID, &reg_data);
+	if (ret < 0 || reg_data != PF1550_DEVICE_ID) {
+		dev_err(pf1550->dev, "device not found!\n");
+		return ret;
+	}
+
+	pf1550->type = PF1550;
+	dev_info(pf1550->dev, "pf1550 found.\n");
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
+				       pf1550->irq,
+				IRQF_ONESHOT | IRQF_SHARED |
+				IRQF_TRIGGER_FALLING, 0,
+				&pf1550_regulator_irq_chip,
+				&pf1550->irq_data_regulator);
+	if (ret) {
+		dev_err(pf1550->dev, "failed to add irq1 chip: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
+				       pf1550->irq,
+				IRQF_ONESHOT | IRQF_SHARED |
+				IRQF_TRIGGER_FALLING, 0,
+				&pf1550_onkey_irq_chip,
+				&pf1550->irq_data_onkey);
+	if (ret) {
+		dev_err(pf1550->dev, "failed to add irq3 chip: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_regmap_add_irq_chip(pf1550->dev, pf1550->regmap,
+				       pf1550->irq,
+				IRQF_ONESHOT | IRQF_SHARED |
+				IRQF_TRIGGER_FALLING, 0,
+				&pf1550_charger_irq_chip,
+				&pf1550->irq_data_charger);
+	if (ret) {
+		dev_err(pf1550->dev, "failed to add irq4 chip: %d\n", ret);
+		return ret;
+	}
+
+	return devm_mfd_add_devices(pf1550->dev, -1, pf1550_devs,
+			      ARRAY_SIZE(pf1550_devs), NULL, 0, NULL);
+}
+
+static const struct i2c_device_id pf1550_i2c_id[] = {
+	{ "pf1550", PF1550 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, pf1550_i2c_id);
+
+static int pf1550_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev)) {
+		enable_irq_wake(pf1550->irq);
+		disable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+
+static int pf1550_resume(struct device *dev)
+{
+	struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
+	struct pf1550_dev *pf1550 = i2c_get_clientdata(i2c);
+
+	if (device_may_wakeup(dev)) {
+		disable_irq_wake(pf1550->irq);
+		enable_irq(pf1550->irq);
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pf1550_pm, pf1550_suspend, pf1550_resume);
+
+static const struct of_device_id pf1550_dt_match[] = {
+	{ .compatible = "fsl,pf1550" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pf1550_dt_match);
+
+static struct i2c_driver pf1550_i2c_driver = {
+	.driver = {
+		   .name = "pf1550",
+		   .pm = pm_sleep_ptr(&pf1550_pm),
+		   .of_match_table = of_match_ptr(pf1550_dt_match),
+	},
+	.probe = pf1550_i2c_probe,
+	.id_table = pf1550_i2c_id,
+};
+
+module_i2c_driver(pf1550_i2c_driver);
+
+MODULE_DESCRIPTION("Freescale PF1550 multi-function core driver");
+MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/pf1550.h b/include/linux/mfd/pf1550.h
new file mode 100644
index 000000000000..41de05c00b3d
--- /dev/null
+++ b/include/linux/mfd/pf1550.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * pf1550.h - mfd head file for PF1550
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Robin Gong <yibin.gong@freescale.com>
+ */
+
+#ifndef __LINUX_MFD_PF1550_H
+#define __LINUX_MFD_PF1550_H
+
+#include <linux/i2c.h>
+
+enum chips { PF1550 = 1, };
+
+enum pf1550_pmic_reg {
+	/* PMIC regulator part */
+	PF1550_PMIC_REG_DEVICE_ID		= 0x00,
+	PF1550_PMIC_REG_OTP_FLAVOR		= 0x01,
+	PF1550_PMIC_REG_SILICON_REV		= 0x02,
+
+	PF1550_PMIC_REG_INT_CATEGORY		= 0x06,
+	PF1550_PMIC_REG_SW_INT_STAT0		= 0x08,
+	PF1550_PMIC_REG_SW_INT_MASK0		= 0x09,
+	PF1550_PMIC_REG_SW_INT_SENSE0		= 0x0A,
+	PF1550_PMIC_REG_SW_INT_STAT1		= 0x0B,
+	PF1550_PMIC_REG_SW_INT_MASK1		= 0x0C,
+	PF1550_PMIC_REG_SW_INT_SENSE1		= 0x0D,
+	PF1550_PMIC_REG_SW_INT_STAT2		= 0x0E,
+	PF1550_PMIC_REG_SW_INT_MASK2		= 0x0F,
+	PF1550_PMIC_REG_SW_INT_SENSE2		= 0x10,
+	PF1550_PMIC_REG_LDO_INT_STAT0		= 0x18,
+	PF1550_PMIC_REG_LDO_INT_MASK0		= 0x19,
+	PF1550_PMIC_REG_LDO_INT_SENSE0		= 0x1A,
+	PF1550_PMIC_REG_TEMP_INT_STAT0		= 0x20,
+	PF1550_PMIC_REG_TEMP_INT_MASK0		= 0x21,
+	PF1550_PMIC_REG_TEMP_INT_SENSE0		= 0x22,
+	PF1550_PMIC_REG_ONKEY_INT_STAT0		= 0x24,
+	PF1550_PMIC_REG_ONKEY_INT_MASK0		= 0x25,
+	PF1550_PMIC_REG_ONKEY_INT_SENSE0	= 0x26,
+	PF1550_PMIC_REG_MISC_INT_STAT0		= 0x28,
+	PF1550_PMIC_REG_MISC_INT_MASK0		= 0x29,
+	PF1550_PMIC_REG_MISC_INT_SENSE0		= 0x2A,
+
+	PF1550_PMIC_REG_COINCELL_CONTROL	= 0x30,
+
+	PF1550_PMIC_REG_SW1_VOLT		= 0x32,
+	PF1550_PMIC_REG_SW1_STBY_VOLT		= 0x33,
+	PF1550_PMIC_REG_SW1_SLP_VOLT		= 0x34,
+	PF1550_PMIC_REG_SW1_CTRL		= 0x35,
+	PF1550_PMIC_REG_SW1_CTRL1		= 0x36,
+	PF1550_PMIC_REG_SW2_VOLT		= 0x38,
+	PF1550_PMIC_REG_SW2_STBY_VOLT		= 0x39,
+	PF1550_PMIC_REG_SW2_SLP_VOLT		= 0x3A,
+	PF1550_PMIC_REG_SW2_CTRL		= 0x3B,
+	PF1550_PMIC_REG_SW2_CTRL1		= 0x3C,
+	PF1550_PMIC_REG_SW3_VOLT		= 0x3E,
+	PF1550_PMIC_REG_SW3_STBY_VOLT		= 0x3F,
+	PF1550_PMIC_REG_SW3_SLP_VOLT		= 0x40,
+	PF1550_PMIC_REG_SW3_CTRL		= 0x41,
+	PF1550_PMIC_REG_SW3_CTRL1		= 0x42,
+	PF1550_PMIC_REG_VSNVS_CTRL		= 0x48,
+	PF1550_PMIC_REG_VREFDDR_CTRL		= 0x4A,
+	PF1550_PMIC_REG_LDO1_VOLT		= 0x4C,
+	PF1550_PMIC_REG_LDO1_CTRL		= 0x4D,
+	PF1550_PMIC_REG_LDO2_VOLT		= 0x4F,
+	PF1550_PMIC_REG_LDO2_CTRL		= 0x50,
+	PF1550_PMIC_REG_LDO3_VOLT		= 0x52,
+	PF1550_PMIC_REG_LDO3_CTRL		= 0x53,
+	PF1550_PMIC_REG_PWRCTRL0		= 0x58,
+	PF1550_PMIC_REG_PWRCTRL1		= 0x59,
+	PF1550_PMIC_REG_PWRCTRL2		= 0x5A,
+	PF1550_PMIC_REG_PWRCTRL3		= 0x5B,
+	PF1550_PMIC_REG_SW1_PWRDN_SEQ		= 0x5F,
+	PF1550_PMIC_REG_SW2_PWRDN_SEQ		= 0x60,
+	PF1550_PMIC_REG_SW3_PWRDN_SEQ		= 0x61,
+	PF1550_PMIC_REG_LDO1_PWRDN_SEQ		= 0x62,
+	PF1550_PMIC_REG_LDO2_PWRDN_SEQ		= 0x63,
+	PF1550_PMIC_REG_LDO3_PWRDN_SEQ		= 0x64,
+	PF1550_PMIC_REG_VREFDDR_PWRDN_SEQ	= 0x65,
+
+	PF1550_PMIC_REG_STATE_INFO		= 0x67,
+	PF1550_PMIC_REG_I2C_ADDR		= 0x68,
+	PF1550_PMIC_REG_IO_DRV0			= 0x69,
+	PF1550_PMIC_REG_IO_DRV1			= 0x6A,
+	PF1550_PMIC_REG_RC_16MHZ		= 0x6B,
+	PF1550_PMIC_REG_KEY			= 0x6F,
+
+	/* charger part */
+	PF1550_CHARG_REG_CHG_INT		= 0x80,
+	PF1550_CHARG_REG_CHG_INT_MASK		= 0x82,
+	PF1550_CHARG_REG_CHG_INT_OK		= 0x84,
+	PF1550_CHARG_REG_VBUS_SNS		= 0x86,
+	PF1550_CHARG_REG_CHG_SNS		= 0x87,
+	PF1550_CHARG_REG_BATT_SNS		= 0x88,
+	PF1550_CHARG_REG_CHG_OPER		= 0x89,
+	PF1550_CHARG_REG_CHG_TMR		= 0x8A,
+	PF1550_CHARG_REG_CHG_EOC_CNFG		= 0x8D,
+	PF1550_CHARG_REG_CHG_CURR_CNFG		= 0x8E,
+	PF1550_CHARG_REG_BATT_REG		= 0x8F,
+	PF1550_CHARG_REG_BATFET_CNFG		= 0x91,
+	PF1550_CHARG_REG_THM_REG_CNFG		= 0x92,
+	PF1550_CHARG_REG_VBUS_INLIM_CNFG	= 0x94,
+	PF1550_CHARG_REG_VBUS_LIN_DPM		= 0x95,
+	PF1550_CHARG_REG_USB_PHY_LDO_CNFG	= 0x96,
+	PF1550_CHARG_REG_DBNC_DELAY_TIME	= 0x98,
+	PF1550_CHARG_REG_CHG_INT_CNFG		= 0x99,
+	PF1550_CHARG_REG_THM_ADJ_SETTING	= 0x9A,
+	PF1550_CHARG_REG_VBUS2SYS_CNFG		= 0x9B,
+	PF1550_CHARG_REG_LED_PWM		= 0x9C,
+	PF1550_CHARG_REG_FAULT_BATFET_CNFG	= 0x9D,
+	PF1550_CHARG_REG_LED_CNFG		= 0x9E,
+	PF1550_CHARG_REG_CHGR_KEY2		= 0x9F,
+
+	PF1550_TEST_REG_FMRADDR			= 0xC4,
+	PF1550_TEST_REG_FMRDATA			= 0xC5,
+	PF1550_TEST_REG_KEY3			= 0xDF,
+
+	PF1550_PMIC_REG_END			= 0xff,
+};
+
+#define PF1550_DEVICE_ID		0x7c
+
+#define PF1550_CHG_TURNON		0x2
+
+#define PF1550_CHG_PRECHARGE		0
+#define PF1550_CHG_CONSTANT_CURRENT	1
+#define PF1550_CHG_CONSTANT_VOL		2
+#define PF1550_CHG_EOC			3
+#define PF1550_CHG_DONE			4
+#define PF1550_CHG_TIMER_FAULT		6
+#define PF1550_CHG_SUSPEND		7
+#define PF1550_CHG_OFF_INV		8
+#define PF1550_CHG_BAT_OVER		9
+#define PF1550_CHG_OFF_TEMP		10
+#define PF1550_CHG_LINEAR_ONLY		12
+#define PF1550_CHG_SNS_MASK		0xf
+#define PF1550_CHG_INT_MASK             0x51
+
+#define PF1550_BAT_NO_VBUS		0
+#define PF1550_BAT_LOW_THAN_PRECHARG	1
+#define PF1550_BAT_CHARG_FAIL		2
+#define PF1550_BAT_HIGH_THAN_PRECHARG	4
+#define PF1550_BAT_OVER_VOL		5
+#define	PF1550_BAT_NO_DETECT		6
+#define PF1550_BAT_SNS_MASK		0x7
+
+#define PF1550_VBUS_UVLO		BIT(2)
+#define PF1550_VBUS_IN2SYS		BIT(3)
+#define PF1550_VBUS_OVLO		BIT(4)
+#define PF1550_VBUS_VALID		BIT(5)
+
+#define PF1550_CHARG_REG_BATT_REG_CHGCV_MASK		0x3f
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT		6
+#define PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK		(0x3 << 6)
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT	2
+#define PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK	(0x3 << 2)
+
+#define PMIC_IRQ_SW1_LS		BIT(0)
+#define PMIC_IRQ_SW2_LS		BIT(1)
+#define PMIC_IRQ_SW3_LS		BIT(2)
+#define PMIC_IRQ_SW1_HS		BIT(0)
+#define PMIC_IRQ_SW2_HS		BIT(1)
+#define PMIC_IRQ_SW3_HS		BIT(2)
+#define PMIC_IRQ_LDO1_FAULT	BIT(0)
+#define PMIC_IRQ_LDO2_FAULT	BIT(1)
+#define PMIC_IRQ_LDO3_FAULT	BIT(2)
+#define PMIC_IRQ_TEMP_110	BIT(0)
+#define PMIC_IRQ_TEMP_125	BIT(1)
+
+#define ONKEY_IRQ_PUSHI		BIT(0)
+#define ONKEY_IRQ_1SI		BIT(1)
+#define ONKEY_IRQ_2SI		BIT(2)
+#define ONKEY_IRQ_3SI		BIT(3)
+#define ONKEY_IRQ_4SI		BIT(4)
+#define ONKEY_IRQ_8SI		BIT(5)
+
+#define CHARG_IRQ_BAT2SOCI	BIT(1)
+#define CHARG_IRQ_BATI		BIT(2)
+#define CHARG_IRQ_CHGI		BIT(3)
+#define CHARG_IRQ_VBUSI		BIT(5)
+#define CHARG_IRQ_DPMI		BIT(6)
+#define CHARG_IRQ_THMI		BIT(7)
+
+enum pf1550_pmic_irq {
+	PF1550_PMIC_IRQ_SW1_LS,
+	PF1550_PMIC_IRQ_SW2_LS,
+	PF1550_PMIC_IRQ_SW3_LS,
+	PF1550_PMIC_IRQ_SW1_HS,
+	PF1550_PMIC_IRQ_SW2_HS,
+	PF1550_PMIC_IRQ_SW3_HS,
+	PF1550_PMIC_IRQ_LDO1_FAULT,
+	PF1550_PMIC_IRQ_LDO2_FAULT,
+	PF1550_PMIC_IRQ_LDO3_FAULT,
+	PF1550_PMIC_IRQ_TEMP_110,
+	PF1550_PMIC_IRQ_TEMP_125,
+};
+
+enum pf1550_onkey_irq {
+	PF1550_ONKEY_IRQ_PUSHI,
+	PF1550_ONKEY_IRQ_1SI,
+	PF1550_ONKEY_IRQ_2SI,
+	PF1550_ONKEY_IRQ_3SI,
+	PF1550_ONKEY_IRQ_4SI,
+	PF1550_ONKEY_IRQ_8SI,
+};
+
+enum pf1550_charg_irq {
+	PF1550_CHARG_IRQ_BAT2SOCI,
+	PF1550_CHARG_IRQ_BATI,
+	PF1550_CHARG_IRQ_CHGI,
+	PF1550_CHARG_IRQ_VBUSI,
+	PF1550_CHARG_IRQ_THMI,
+};
+
+enum pf1550_regulators {
+	PF1550_SW1,
+	PF1550_SW2,
+	PF1550_SW3,
+	PF1550_VREFDDR,
+	PF1550_LDO1,
+	PF1550_LDO2,
+	PF1550_LDO3,
+};
+
+struct pf1550_irq_info {
+	unsigned int irq;
+	const char *name;
+	unsigned int virq;
+};
+
+struct pf1550_dev {
+	struct device *dev;
+	struct i2c_client *i2c;
+	int type;
+	struct regmap *regmap;
+	struct regmap_irq_chip_data *irq_data_regulator;
+	struct regmap_irq_chip_data *irq_data_onkey;
+	struct regmap_irq_chip_data *irq_data_charger;
+	int irq;
+};
+
+int pf1550_read_otp(struct pf1550_dev *pf1550, unsigned int index,
+		    unsigned int *val);
+
+#endif /* __LINUX_MFD_PF1550_H */
-- 
2.49.0


