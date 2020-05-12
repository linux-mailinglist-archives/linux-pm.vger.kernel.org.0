Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4FD1CF5AA
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgELN0Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 09:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgELN0Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 09:26:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C3DC05BD0B
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:26:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so15376223wra.7
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AT7F3lHkleJYJf6ArphPWyOpM56JVM5mHZcAwbWvMm4=;
        b=P000BKk6kRS6mG4RDIUXyBsNyG/eZJ7AQO5s0MGLc9hZqyfuiPOjkEgCUQeQlwCNfy
         t6Z76E48EStqfJcHbnHe6tz3Utgo5shjjcnpO/SHkfyY4vridZiMlOTrsS1RAZZrGNZp
         0B1YMyWuTVN4SKkzRaM4hCXScc08y1KDSPKqsA5vGcEAl4vMtQsEmIQDtFujzYt9KmoZ
         gbnVilFHiuszaPdiUjb+dw69N5JowJREEUy/Q5PWVid0GpPDEsq0qZn9XPIaa9OCnuFE
         HVVtV3d+IZzYqKGNdgoQZUO1jj3T7wklGo5tIteFSWPbStk2VFDQVPeEFwm4HEXcztIc
         fM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AT7F3lHkleJYJf6ArphPWyOpM56JVM5mHZcAwbWvMm4=;
        b=bhWKKBP/oR8gbMRiNBHezDOKTl6wz5ttdpAnlpOxHlH9LBT9ppzGO31OEvWzGt9me7
         TiEg8wGVICRDHO3swHjMdrVDrr/dVPMQADaSMCq4in1wXV8k96GfvKMzFP3Wp2Q1967M
         9lRtJTrybkjeUl2hN51qEY5Cy3E64sI/V6BbTHSAMoxxTUMPxtJvbFUPlu67PfxYEJEl
         U9ol9WvXAk033rX4s1d0ZYxnyPAEvKMKy4J3/VMnuQBUmwlrKnAZB0gwEOD7Y0/PTr6J
         yeVR4Bw+FO93Gul5CBLITscr86hkkRZjxC6mMOWX/OkC1LjOPNfBOSHWvuTUSObZjJIo
         o4Cw==
X-Gm-Message-State: AGi0PuaKxKYESioB95wOV2asQ31eypptbRqS45XMyVEBRw8q3Pg7nRXN
        Lz9zCbdh6ae/YdcVXJS8YGjKPQ==
X-Google-Smtp-Source: APiQypJAIR/wl5WZ+wRSFmBEv8f8mUMSkzbG4Uh2oabJsHfJxmHHcdTv7uE1/2v38jv8ReO8P2yPPw==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr10712073wrm.404.1589289982214;
        Tue, 12 May 2020 06:26:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id g15sm14441844wro.71.2020.05.12.06.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:26:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     srinivas.kandagatla@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] thermal: add support for the MCU controlled FAN on Khadas boards
Date:   Tue, 12 May 2020 15:26:10 +0200
Message-Id: <20200512132613.31507-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200512132613.31507-1-narmstrong@baylibre.com>
References: <20200512132613.31507-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The new Khadas VIM2 and VIM3 boards controls the cooling fan via the
on-board microcontroller.

This implements the FAN control as thermal devices and as cell of the Khadas
MCU MFD driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/thermal/Kconfig          |  10 ++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/thermal/khadas_mcu_fan.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91af271e9bb0..72b3960cc5ac 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -490,4 +490,14 @@ config SPRD_THERMAL
 	help
 	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
 	  framework.
+
+config KHADAS_MCU_FAN_THERMAL
+	tristate "Khadas MCU controller FAN cooling support"
+	depends on OF || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP
+	help
+	  If you say yes here you get support for the FAN controlled
+	  by the Microcontroller found on the Khadas VIM boards.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8c8ed7b79915..460428c2122c 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
+obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
new file mode 100644
index 000000000000..044d4aba8be2
--- /dev/null
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Khadas MCU Controlled FAN driver
+ *
+ * Copyright (C) 2020 BayLibre SAS
+ * Author(s): Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/khadas-mcu.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/thermal.h>
+
+#define MAX_LEVEL 3
+
+struct khadas_mcu_fan_ctx {
+	struct khadas_mcu *mcu;
+	unsigned int level;
+	struct thermal_cooling_device *cdev;
+};
+
+static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
+				    unsigned int level)
+{
+	int ret;
+
+	ret = regmap_write(ctx->mcu->map, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
+			   level);
+	if (ret)
+		return ret;
+
+	ctx->level = level;
+
+	return 0;
+}
+
+static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
+					unsigned long *state)
+{
+	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+
+	if (!ctx)
+		return -EINVAL;
+
+	*state = MAX_LEVEL;
+
+	return 0;
+}
+
+static int khadas_mcu_fan_get_cur_state(struct thermal_cooling_device *cdev,
+					unsigned long *state)
+{
+	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+
+	if (!ctx)
+		return -EINVAL;
+
+	*state = ctx->level;
+
+	return 0;
+}
+
+static int
+khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
+			     unsigned long state)
+{
+	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+
+	if (!ctx || (state > MAX_LEVEL))
+		return -EINVAL;
+
+	if (state == ctx->level)
+		return 0;
+
+	return khadas_mcu_fan_set_level(ctx, state);
+}
+
+static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
+	.get_max_state = khadas_mcu_fan_get_max_state,
+	.get_cur_state = khadas_mcu_fan_get_cur_state,
+	.set_cur_state = khadas_mcu_fan_set_cur_state,
+};
+
+static int khadas_mcu_fan_probe(struct platform_device *pdev)
+{
+	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
+	struct thermal_cooling_device *cdev;
+	struct device *dev = &pdev->dev;
+	struct khadas_mcu_fan_ctx *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->mcu = mcu;
+	platform_set_drvdata(pdev, ctx);
+
+	cdev = devm_thermal_of_cooling_device_register(dev->parent,
+			dev->parent->of_node, "khadas-mcu-fan", ctx,
+			&khadas_mcu_fan_cooling_ops);
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		dev_err(dev,
+				"Failed to register khadas-mcu-fan as cooling device: %d\n",
+				ret);
+		return ret;
+	}
+	ctx->cdev = cdev;
+	thermal_cdev_update(cdev);
+
+	return 0;
+}
+
+static int khadas_mcu_fan_disable(struct device *dev)
+{
+	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
+	unsigned int level_save = ctx->level;
+	int ret;
+
+	ret = khadas_mcu_fan_set_level(ctx, 0);
+	if (ret)
+		return ret;
+
+	ctx->level = level_save;
+
+	return 0;
+}
+
+static void khadas_mcu_fan_shutdown(struct platform_device *pdev)
+{
+	khadas_mcu_fan_disable(&pdev->dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int khadas_mcu_fan_suspend(struct device *dev)
+{
+	return khadas_mcu_fan_disable(dev);
+}
+
+static int khadas_mcu_fan_resume(struct device *dev)
+{
+	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	return khadas_mcu_fan_set_level(ctx, ctx->level);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(khadas_mcu_fan_pm, khadas_mcu_fan_suspend,
+			 khadas_mcu_fan_resume);
+
+static const struct platform_device_id khadas_mcu_fan_id_table[] = {
+	{ .name = "khadas-mcu-fan-ctrl", },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, khadas_mcu_fan_id_table);
+
+static struct platform_driver khadas_mcu_fan_driver = {
+	.probe		= khadas_mcu_fan_probe,
+	.shutdown	= khadas_mcu_fan_shutdown,
+	.driver	= {
+		.name		= "khadas-mcu-fan-ctrl",
+		.pm		= &khadas_mcu_fan_pm,
+	},
+	.id_table	= khadas_mcu_fan_id_table,
+};
+
+module_platform_driver(khadas_mcu_fan_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Khadas MCU FAN driver");
+MODULE_LICENSE("GPL");
-- 
2.22.0

