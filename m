Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244DC1F1537
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgFHJSE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 05:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgFHJRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 05:17:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAA0C08C5C9
        for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2020 02:17:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so16549859wrc.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2020 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x1ekzgH61SMSMNEKJSFtFV9vk73XIGNbq1nET0BFIPY=;
        b=jJggZ1+qiIrF9PT052QZAHlJLjPNrJO7Cs+RhWJdAxmpBaQoZ67F+0Kaz+Sx2ZIwpz
         G7Pjd3jQjhfz2mqi1+nQHCg8PYPvXE4na6f68twLNnHRqILxoABqDEwHv/6ZReeJT6YW
         MxseY+whAVUqj3u0oinQ+HkdHaR82nJiEv4LCfQ9uMk9a0/EMZ2SjBjSawspWLkX/0Or
         mY4DM7vIGlMqZvbfSVxNsPxMHm9/t3GJUcY/zW+CsKYw+q7d43BNoNXh1+/MGXsXi8XI
         cgtl83n7isg6H9pdHRNmNeH9H3E2PqUbljGFD65ZpL9EqIoqc/uQjehX4tqs2co5op2J
         aHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1ekzgH61SMSMNEKJSFtFV9vk73XIGNbq1nET0BFIPY=;
        b=qk0y7CaFN1a4q5Tf18bYl905Eargjkcly+pOIRQqKaMHOEkGpCK1nZD89jAEuS+r5+
         8iqvpa3Gk+ScYncS+pM3c9YpPoP+omszvbJeWYrA3x1QmQ7SLvV8LWIFTDjdqP/VqR8r
         465szLtOGy4cMBJPNj8lvwA6kK0Z+bYMja/9bA/MMH9b3hkyeVL/ei+AcJHmFsPCXm4R
         1NOtTfXrOX/6SApagVVGVmmw9juEUzfPN9uYM2lPDu90zMSv9GekJAUe2XlAy46x9xbN
         /d3h/Bz1SCiSwESVjIoVFo4w9wA3FQ7SuFJGREIi7Bh6LtHebEtOHctxAPaSqOCdR1QR
         Ur5g==
X-Gm-Message-State: AOAM532PCMh8tXZ+Hna7z62+LpHAzfVOoxRchSuZEjbuSHxyJST6bNkJ
        bnncBqU1E4jofLrItmTB5qwcNA==
X-Google-Smtp-Source: ABdhPJwyqWluDJGM8TuKYWyuoHgnqBdg1tLGq7uHohm5l/SnmOTZkVN0jyd/97Sn0QsRatB90hGuxA==
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr24028366wrw.180.1591607867340;
        Mon, 08 Jun 2020 02:17:47 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id t7sm22732326wrq.41.2020.06.08.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:17:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] thermal: add support for the MCU controlled FAN on Khadas boards
Date:   Mon,  8 Jun 2020 11:17:37 +0200
Message-Id: <20200608091739.2368-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200608091739.2368-1-narmstrong@baylibre.com>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
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
 drivers/thermal/Kconfig          |  11 ++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/khadas_mcu_fan.c | 174 +++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/thermal/khadas_mcu_fan.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91af271e9bb0..53efd381f434 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -490,4 +490,15 @@ config SPRD_THERMAL
 	help
 	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
 	  framework.
+
+config KHADAS_MCU_FAN_THERMAL
+	tristate "Khadas MCU controller FAN cooling support"
+	depends on OF || COMPILE_TEST
+	depends on MFD_KHADAS_MCU
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
index 000000000000..6995b443cad4
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
+	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
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

