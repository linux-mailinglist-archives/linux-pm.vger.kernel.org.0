Return-Path: <linux-pm+bounces-10686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 532CB92878F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69591F21B31
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44381494CC;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndAmxVER"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94451442FD;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178008; cv=none; b=PzLl3HJ2v34+FPv5QJjunbG/Qx4p1N/whswUoz12ND1V2DJnLyIRuTDWpBnDWz1jS/kXexjrr0lOzLjURZbzy4c9F6tcm5f3lD/e6wN/SsvJjgoYKm5u/3K7fW+mYPlB1qQSYhd8d4PhJVlBD8l956l6oZvrspaK/QveZWsPYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178008; c=relaxed/simple;
	bh=gM9KnxmaYBefs+3c9rtIvUowsz/8HqevZUOFQO1FdSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Av03qKCOnJJfMeyZdMaWhDOxfKp13/0dF/jWglJ/bV6czJwqlon/CY07DsPpFN3E5+NRMqwWxq2rdnOQnubbUHoJ3Q18CQKwgKHdvOayPwmClNmulGwhvxFkUQp+a9AXR10mtlfIx36a0tuS+OlQ8Izs42/jeOoJqlp4mA83sOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndAmxVER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69BF0C32781;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178008;
	bh=gM9KnxmaYBefs+3c9rtIvUowsz/8HqevZUOFQO1FdSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ndAmxVEROAcSdGban1ehA+SH9UdFlPywpCZC7HNnNI+omD+1GY75vw5zHd6bWlWNG
	 n5DI0vHSi8/Bdkulw9h30GzOm6pdFc5drrprMrzopG+jlRkavupvzmo8EeSDt0v/Jf
	 Awtq4sNCl8ogOumAdog6KTRcFE+WeknLoheugzK47HmLJjGvOHyvWze7P7P41TcShF
	 OdXMyRxmzPHno0pPzuIKn44+PzaAtNM6mohur1nLFStB4AcyXXJgszJL+H39DSx/+e
	 cl8u11F9wcQHdBAdah2LZjIAHz11MKSgiXhhL9ox1dbruAAeGl/xaW61dkhMNhQQhu
	 Cwl2CDIoxV0DA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B308C3DA40;
	Fri,  5 Jul 2024 11:13:28 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 05 Jul 2024 19:13:26 +0800
Subject: [PATCH 2/3] power: sequenceing: Add power sequence for Amlogic WCN
 chips
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-pwrseq-v1-2-31829b47fc72@amlogic.com>
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
In-Reply-To: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178006; l=7619;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=fusHaIg3W/yshsJI12RRwPi4r8wzlUyT/DZ/71Atthg=;
 b=xBFSKEUkFyv9tbViHER0T6AOEI4XaVkjkqWO2D12mt/jg7tb0QjU9O/QHyCxsOQyHQxI1YX+4
 xO/9OUBHwAqB4vh6/Dr88KdbovrFS/D30t5Z4bbdzfvf6uHE7zYNRih
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add power sequence for Bluetooth and Wi-Fi respectively, including chip_en
pull-up and bt_en pull-up, and generation of the 32.768 clock.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 drivers/power/sequencing/Kconfig          |   7 +
 drivers/power/sequencing/Makefile         |   1 +
 drivers/power/sequencing/pwrseq-aml-wcn.c | 209 ++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index c9f1cdb66524..65d3b2c20bfb 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -26,4 +26,11 @@ config POWER_SEQUENCING_QCOM_WCN
 	  this driver is needed for correct power control or else we'd risk not
 	  respecting the required delays between enabling Bluetooth and WLAN.
 
+config POWER_SEQUENCING_AML_WCN
+	tristate "Amlogic WCN family PMU driver"
+	default m if ARCH_MESON
+	help
+	  Say Y here to enable the power sequencing driver for Amlogic
+	  WCN Bluetooth/WLAN chipsets.
+
 endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index 2eec2df7912d..32706daf8f0f 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
 pwrseq-core-y				:= core.o
 
 obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
+obj-$(CONFIG_POWER_SEQUENCING_AML_WCN)	+= pwrseq-aml-wcn.o
diff --git a/drivers/power/sequencing/pwrseq-aml-wcn.c b/drivers/power/sequencing/pwrseq-aml-wcn.c
new file mode 100644
index 000000000000..6f5bfcf60b9c
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-aml-wcn.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2024 Amlogic, Inc. All rights reserved
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+struct pwrseq_aml_wcn_ctx {
+	struct pwrseq_device *pwrseq;
+	int bt_enable_gpio;
+	int chip_enable_gpio;
+	struct clk *lpo_clk;
+	unsigned int pwr_count;
+};
+
+static DEFINE_MUTEX(pwrseq_lock);
+
+static int pwrseq_aml_wcn_chip_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int err;
+
+	mutex_lock(&pwrseq_lock);
+	if (ctx->pwr_count == 0) {
+		gpio_request(ctx->chip_enable_gpio, "chip-enable-gpios");
+		gpio_direction_output(ctx->chip_enable_gpio, 1);
+		gpio_free(ctx->chip_enable_gpio);
+
+		if (!IS_ERR(ctx->lpo_clk)) {
+			err = clk_prepare_enable(ctx->lpo_clk);
+			if (err) {
+				mutex_unlock(&pwrseq_lock);
+				return err;
+			}
+		}
+	}
+
+	ctx->pwr_count++;
+	mutex_unlock(&pwrseq_lock);
+	return 0;
+}
+
+static int pwrseq_aml_wcn_chip_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	mutex_lock(&pwrseq_lock);
+	if (--ctx->pwr_count == 0) {
+		gpio_request(ctx->chip_enable_gpio, "chip-enable-gpios");
+		gpio_direction_output(ctx->chip_enable_gpio, 0);
+		gpio_free(ctx->chip_enable_gpio);
+
+		if (!IS_ERR(ctx->lpo_clk))
+			clk_disable_unprepare(ctx->lpo_clk);
+	}
+
+	mutex_unlock(&pwrseq_lock);
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_aml_wcn_chip_power_unit_data = {
+	.name = "chip-enable",
+	.enable = pwrseq_aml_wcn_chip_enable,
+	.disable = pwrseq_aml_wcn_chip_disable,
+};
+
+static const struct pwrseq_unit_data *pwrseq_aml_wcn_unit_deps[] = {
+	&pwrseq_aml_wcn_chip_power_unit_data,
+	NULL
+};
+
+static int pwrseq_aml_wcn_bt_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	gpio_request(ctx->bt_enable_gpio, "bt-enable-gpios");
+	gpio_direction_output(ctx->bt_enable_gpio, 1);
+	gpio_free(ctx->bt_enable_gpio);
+
+	/* wait 100ms for bluetooth controller power on  */
+	msleep(100);
+
+	return 0;
+}
+
+static int pwrseq_aml_wcn_bt_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_aml_wcn_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	gpio_request(ctx->bt_enable_gpio, "bt-enable-gpios");
+	gpio_direction_output(ctx->bt_enable_gpio, 0);
+	gpio_free(ctx->bt_enable_gpio);
+
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_aml_wcn_bt_unit_data = {
+	.name = "bluetooth-enable",
+	.deps = pwrseq_aml_wcn_unit_deps,
+	.enable = pwrseq_aml_wcn_bt_enable,
+	.disable = pwrseq_aml_wcn_bt_disable,
+};
+
+static const struct pwrseq_unit_data pwrseq_aml_wcn_wlan_unit_data = {
+	.name = "wlan-enable",
+	.deps = pwrseq_aml_wcn_unit_deps,
+};
+
+static const struct pwrseq_target_data pwrseq_aml_wcn_bt_target_data = {
+	.name = "bluetooth",
+	.unit = &pwrseq_aml_wcn_bt_unit_data,
+};
+
+static const struct pwrseq_target_data pwrseq_aml_wcn_wlan_target_data = {
+	.name = "wlan",
+	.unit = &pwrseq_aml_wcn_wlan_unit_data,
+};
+
+static const struct pwrseq_target_data *pwrseq_aml_wcn_targets[] = {
+	&pwrseq_aml_wcn_bt_target_data,
+	&pwrseq_aml_wcn_wlan_target_data,
+	NULL
+};
+
+static int pwrseq_aml_wcn_match(struct pwrseq_device *pwrseq,
+				 struct device *dev)
+{
+	struct device_node *dev_node = dev->of_node;
+
+	if (!of_property_present(dev_node, "amlogic,wcn-pwrseq"))
+		return 0;
+
+	return 1;
+}
+
+static int pwrseq_aml_wcn_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_aml_wcn_ctx *ctx;
+	struct pwrseq_config config;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->bt_enable_gpio = of_get_named_gpio(dev->of_node,
+					       "amlogic,bt-enable-gpios", 0);
+	if (!gpio_is_valid(ctx->bt_enable_gpio))
+		return dev_err_probe(dev, ctx->bt_enable_gpio,
+				"Failed to get the bt enable GPIO");
+
+	ctx->chip_enable_gpio = of_get_named_gpio(dev->of_node,
+					       "amlogic,chip-enable-gpios", 0);
+	if (!gpio_is_valid(ctx->chip_enable_gpio))
+		return dev_err_probe(dev, ctx->bt_enable_gpio,
+					"Failed to get the chip enable GPIO");
+
+	ctx->lpo_clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ctx->lpo_clk))
+		return dev_err_probe(dev, PTR_ERR(ctx->lpo_clk),
+				"Failed to get the clock source");
+
+	memset(&config, 0, sizeof(config));
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_aml_wcn_match;
+	config.targets = pwrseq_aml_wcn_targets;
+
+	ctx->pwr_count = 0;
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register the power sequencer\n");
+
+	return 0;
+}
+
+static const struct of_device_id pwrseq_aml_wcn_of_match[] = {
+	{ .compatible = "amlogic,w155s2-pwrseq" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, pwrseq_aml_wcn_of_match);
+
+static struct platform_driver pwrseq_aml_wcn_driver = {
+	.driver = {
+		.name = "pwrseq-aml_wcn",
+		.of_match_table = pwrseq_aml_wcn_of_match,
+	},
+	.probe = pwrseq_aml_wcn_probe,
+};
+module_platform_driver(pwrseq_aml_wcn_driver);
+
+MODULE_AUTHOR("Yang Li <yang.li@amlogic.com>");
+MODULE_DESCRIPTION("Amlogic WCN PMU power sequencing driver");
+MODULE_LICENSE("GPL");

-- 
2.42.0



