Return-Path: <linux-pm+bounces-23807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4FA5B61E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 02:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1E87A6BC2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19561E98E7;
	Tue, 11 Mar 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="r+DzR7xI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6A1E3772;
	Tue, 11 Mar 2025 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741657818; cv=none; b=I50NQzmxGqINOfxxbUs0slMUfydyLbxMq8WJr0tBPz4JxchGScwEzWD1w+KVWb6sti/AOHWkU+pW9SM7waT4GLh2QaABvrolrMdis1xYz/mzCc1K3Lb4T0KC6IqDHhBDQWuD+/E86/k+WVGBVU7y7FP3Z56a/F1Lg8pVqNPl5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741657818; c=relaxed/simple;
	bh=wYx1CQ78Ndu5nSXyKLNPEjFV9YURlYIneK/YC1bkDgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpnxvyUZ3JvzK9BUQZt4MnKqLlKZmoeW+2vPdTgXIdXO/olSzjKNSd4eGSK+iuySRRQQHiPZVkZucSlevCkRlIK66bFamXcQExdqs3+mkj9wAs9uOu1SdoYxQ9eUn1tDIPZNG1veR5XCBK5LbSSEbkZIE0i4+cMqQUr/8K5lbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=r+DzR7xI; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=m9R48WkcPvqp+088QwO4h5yu2gGi1ZdqKqOstpglSDI=; b=r+DzR7xIbpxJpxrF
	Vle1nM4Mww2qn9rY0gEH6/N4yluw+PcbqRVd+ICIz0S/vsnqKiDjooyiqJMWroJNM0T9sFXQ2+BHF
	9aZEmSQ9n3Vd7qOzGQ6jFpI51vTJz1O0ga4vCK8W/vMWg24HtXHthfgd1kGUyrIIy5QWbPXVFQcFK
	8fmX8QvPCnF2GXvn7x37Y4SaZINHBoU903w7j2OvlMCkEv607xpf9yf6xm2D9EHFStqDggRlbz8hM
	LyKkZ+Vm0cSMQ/XtSwKnL0VgomOcwyUwL27zPIxNdSP9ZRt/MugHKeSuGiP84M4rt9q6V/ajLWy10
	/VSeFvgC3OqCDMlxGA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1trokt-0042n5-1N;
	Tue, 11 Mar 2025 01:50:03 +0000
From: linux@treblig.org
To: arnd@arndb.de,
	lee@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	tsbogend@alpha.franken.de
Cc: linux-mips@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2 5/9] regulator: pcf50633-regulator: Remove
Date: Tue, 11 Mar 2025 01:49:55 +0000
Message-ID: <20250311014959.743322-6-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311014959.743322-1-linux@treblig.org>
References: <20250311014959.743322-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The pcf50633 was used as part of the OpenMoko devices but
the support for its main chip was recently removed in:
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")

See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/regulator/Kconfig              |   7 --
 drivers/regulator/Makefile             |   1 -
 drivers/regulator/pcf50633-regulator.c | 124 -------------------------
 3 files changed, 132 deletions(-)
 delete mode 100644 drivers/regulator/pcf50633-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d8177..1236b3a1f93f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -988,13 +988,6 @@ config REGULATOR_PCAP
 	 This driver provides support for the voltage regulators of the
 	 PCAP2 PMIC.
 
-config REGULATOR_PCF50633
-	tristate "NXP PCF50633 regulator driver"
-	depends on MFD_PCF50633
-	help
-	 Say Y here to support the voltage regulators and converters
-	 on PCF50633
-
 config REGULATOR_PF8X00
 	tristate "NXP PF8100/PF8121A/PF8200 regulator driver"
 	depends on I2C && OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a..8dca3567437f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -132,7 +132,6 @@ obj-$(CONFIG_REGULATOR_PWM) += pwm-regulator.o
 obj-$(CONFIG_REGULATOR_TPS51632) += tps51632-regulator.o
 obj-$(CONFIG_REGULATOR_PBIAS) += pbias-regulator.o
 obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
-obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
 obj-$(CONFIG_REGULATOR_RAA215300) += raa215300.o
 obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY)  += rpi-panel-attiny-regulator.o
 obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
diff --git a/drivers/regulator/pcf50633-regulator.c b/drivers/regulator/pcf50633-regulator.c
deleted file mode 100644
index 9f08a62c800e..000000000000
--- a/drivers/regulator/pcf50633-regulator.c
+++ /dev/null
@@ -1,124 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* NXP PCF50633 PMIC Driver
- *
- * (C) 2006-2008 by Openmoko, Inc.
- * Author: Balaji Rao <balajirrao@openmoko.org>
- * All rights reserved.
- *
- * Broken down from monstrous PCF50633 driver mainly by
- * Harald Welte and Andy Green and Werner Almesberger
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/platform_device.h>
-
-#include <linux/mfd/pcf50633/core.h>
-#include <linux/mfd/pcf50633/pmic.h>
-
-#define PCF50633_REGULATOR(_name, _id, _min_uV, _uV_step, _min_sel, _n) \
-	{							\
-		.name = _name,					\
-		.id = PCF50633_REGULATOR_##_id,			\
-		.ops = &pcf50633_regulator_ops,			\
-		.n_voltages = _n,				\
-		.min_uV = _min_uV,				\
-		.uV_step = _uV_step,				\
-		.linear_min_sel = _min_sel,			\
-		.type = REGULATOR_VOLTAGE,			\
-		.owner = THIS_MODULE,				\
-		.vsel_reg = PCF50633_REG_##_id##OUT,		\
-		.vsel_mask = 0xff,				\
-		.enable_reg = PCF50633_REG_##_id##OUT + 1,	\
-		.enable_mask = PCF50633_REGULATOR_ON,		\
-	}
-
-static const struct regulator_ops pcf50633_regulator_ops = {
-	.set_voltage_sel = regulator_set_voltage_sel_regmap,
-	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-	.list_voltage = regulator_list_voltage_linear,
-	.map_voltage = regulator_map_voltage_linear,
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-};
-
-static const struct regulator_desc regulators[] = {
-	[PCF50633_REGULATOR_AUTO] =
-		PCF50633_REGULATOR("auto", AUTO, 1800000, 25000, 0x2f, 128),
-	[PCF50633_REGULATOR_DOWN1] =
-		PCF50633_REGULATOR("down1", DOWN1, 625000, 25000, 0, 96),
-	[PCF50633_REGULATOR_DOWN2] =
-		PCF50633_REGULATOR("down2", DOWN2, 625000, 25000, 0, 96),
-	[PCF50633_REGULATOR_LDO1] =
-		PCF50633_REGULATOR("ldo1", LDO1, 900000, 100000, 0, 28),
-	[PCF50633_REGULATOR_LDO2] =
-		PCF50633_REGULATOR("ldo2", LDO2, 900000, 100000, 0, 28),
-	[PCF50633_REGULATOR_LDO3] =
-		PCF50633_REGULATOR("ldo3", LDO3, 900000, 100000, 0, 28),
-	[PCF50633_REGULATOR_LDO4] =
-		PCF50633_REGULATOR("ldo4", LDO4, 900000, 100000, 0, 28),
-	[PCF50633_REGULATOR_LDO5] =
-		PCF50633_REGULATOR("ldo5", LDO5, 900000, 100000, 0, 28),
-	[PCF50633_REGULATOR_LDO6] =
-		PCF50633_REGULATOR("ldo6", LDO6, 900000, 100000, 0, 28),
-	[PCF50633_REGULATOR_HCLDO] =
-		PCF50633_REGULATOR("hcldo", HCLDO, 900000, 100000, 0, 28),
-	[PCF50633_REGULATOR_MEMLDO] =
-		PCF50633_REGULATOR("memldo", MEMLDO, 900000, 100000, 0, 28),
-};
-
-static int pcf50633_regulator_probe(struct platform_device *pdev)
-{
-	struct regulator_dev *rdev;
-	struct pcf50633 *pcf;
-	struct regulator_config config = { };
-
-	/* Already set by core driver */
-	pcf = dev_to_pcf50633(pdev->dev.parent);
-
-	config.dev = &pdev->dev;
-	config.init_data = dev_get_platdata(&pdev->dev);
-	config.driver_data = pcf;
-	config.regmap = pcf->regmap;
-
-	rdev = devm_regulator_register(&pdev->dev, &regulators[pdev->id],
-				       &config);
-	if (IS_ERR(rdev))
-		return PTR_ERR(rdev);
-
-	platform_set_drvdata(pdev, rdev);
-
-	if (pcf->pdata->regulator_registered)
-		pcf->pdata->regulator_registered(pcf, pdev->id);
-
-	return 0;
-}
-
-static struct platform_driver pcf50633_regulator_driver = {
-	.driver = {
-		.name = "pcf50633-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe = pcf50633_regulator_probe,
-};
-
-static int __init pcf50633_regulator_init(void)
-{
-	return platform_driver_register(&pcf50633_regulator_driver);
-}
-subsys_initcall(pcf50633_regulator_init);
-
-static void __exit pcf50633_regulator_exit(void)
-{
-	platform_driver_unregister(&pcf50633_regulator_driver);
-}
-module_exit(pcf50633_regulator_exit);
-
-MODULE_AUTHOR("Balaji Rao <balajirrao@openmoko.org>");
-MODULE_DESCRIPTION("PCF50633 regulator driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pcf50633-regulator");
-- 
2.48.1


