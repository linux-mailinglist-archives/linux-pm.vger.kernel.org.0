Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD03D71E5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 11:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhG0J0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbhG0J0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 05:26:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598F7C061757;
        Tue, 27 Jul 2021 02:26:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qk33so2438972ejc.12;
        Tue, 27 Jul 2021 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTxbpyEBi9BLHVqlKkligQWKEqtO8+9t1v/xWkgvTkU=;
        b=hIF8ix9U4rnGSGmj5vMRPasBGm0tDHFAzvcMAEeiP69CvHPSZ2stmch0+WdJYLwZ/B
         8fWCzZuiZ16mLE6nSWFVPWPmKErMNUkf9zIApidOVaASxAmm8YGsF3JmWWe+mLA2JYKI
         CTQSWNVBTFqH1wk3hUpoFjr2SSI494HOm+v/5ZZFpTPLdWVROnPRdXW8V8HVhAqLCLFt
         bZwcHhGBdJhmtatEGi/vH12hv6UyiAJsJw7+Qz67eUGrvfTYmi10abuQW8tKGUf94eWb
         nSkZDxAPH7ff5zzK7FPZvJ8PeIgkwdk4IDOM/WjKufuasb9JDTLyMZ6ERfxbok+Pn+aS
         UYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zTxbpyEBi9BLHVqlKkligQWKEqtO8+9t1v/xWkgvTkU=;
        b=SMjgSHCZvxg1x048RbBmtpYtKi6478oZm142EeKLy0pdQsJCo/qy70x94F2lNjBk9h
         UVkQHCVdcZ3J3b19j8a+qp6mK4/sxfe3rbhHHvTPvRsg7wPkHskoNcgU5pj2jLURkSga
         /kFOf82NEPCDBySeYP/xmVfWM8SLUsA5R/hhWfZtXgeSYySqjHf61pCpIcVRHqBVCQs+
         TR8XG08vY8rq697ccSTKPLDfu9sJJ1KwJQt8GvhHfnoPl3UiZWH6PYJqe9KiKTpedT0Y
         3SSVaF+aqNQF17M45ZlCyfRtlLdF9LZrmLXwc39yBvEpaHohkpSctTODGIM0XJAeegoJ
         bMRA==
X-Gm-Message-State: AOAM531/qJQKqQ01t43NlsDKZTdUu3qtIU/jbRkM2JvbsFhZBhMDgWcY
        Aec6lT2fWuxt1AzerZFGv7Y=
X-Google-Smtp-Source: ABdhPJzWBthXzvd02bAnk0H2j9AbAxH2DKotrJ6HuwNjc7S9f7aO/yqw3yg2G4aIpf/LkDwcWoBchg==
X-Received: by 2002:a17:906:d182:: with SMTP id c2mr21594069ejz.111.1627377967994;
        Tue, 27 Jul 2021 02:26:07 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id g3sm692369ejp.2.2021.07.27.02.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:26:07 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] power: reset: Add TPS65086 restart driver
Date:   Tue, 27 Jul 2021 11:25:53 +0200
Message-Id: <20210727092554.1059305-4-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727092554.1059305-1-kernel@esmil.dk>
References: <20210727092554.1059305-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only way to reset the BeagleV Starlight v0.9 board[1] properly is to
tell the PMIC to reset itself which will then assert the external reset
lines of the SoC, USB hub and ethernet phy.

This adds a driver to register a reset handler to do just that.

[1] https://github.com/beagleboard/beaglev-starlight

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/reset/Kconfig            |  6 ++
 drivers/power/reset/Makefile           |  1 +
 drivers/power/reset/tps65086-restart.c | 98 ++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/power/reset/tps65086-restart.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4d1192062508..4b563db3ab3e 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -204,6 +204,12 @@ config POWER_RESET_ST
 	help
 	  Reset support for STMicroelectronics boards.
 
+config POWER_RESET_TPS65086
+	bool "TPS65086 restart driver"
+	depends on MFD_TPS65086
+	help
+	  This driver adds support for resetting the TPS65086 PMIC on restart.
+
 config POWER_RESET_VERSATILE
 	bool "ARM Versatile family reboot driver"
 	depends on ARM
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index cf3f4d02d8a5..f606a2f60539 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
 obj-$(CONFIG_POWER_RESET_REGULATOR) += regulator-poweroff.o
 obj-$(CONFIG_POWER_RESET_RESTART) += restart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ST) += st-poweroff.o
+obj-$(CONFIG_POWER_RESET_TPS65086) += tps65086-restart.o
 obj-$(CONFIG_POWER_RESET_VERSATILE) += arm-versatile-reboot.o
 obj-$(CONFIG_POWER_RESET_VEXPRESS) += vexpress-poweroff.o
 obj-$(CONFIG_POWER_RESET_XGENE) += xgene-reboot.o
diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset/tps65086-restart.c
new file mode 100644
index 000000000000..78b89f745a3d
--- /dev/null
+++ b/drivers/power/reset/tps65086-restart.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Emil Renner Berthing
+ */
+
+#include <linux/mfd/tps65086.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+struct tps65086_restart {
+	struct notifier_block handler;
+	struct device *dev;
+};
+
+static int tps65086_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	struct tps65086_restart *tps65086_restart =
+		container_of(this, struct tps65086_restart, handler);
+	struct tps65086 *tps65086 = dev_get_drvdata(tps65086_restart->dev->parent);
+	int ret;
+
+	ret = regmap_write(tps65086->regmap, TPS65086_FORCESHUTDN, 1);
+	if (ret) {
+		dev_err(tps65086_restart->dev, "%s: error writing to tps65086 pmic: %d\n",
+			__func__, ret);
+		return NOTIFY_DONE;
+	}
+
+	/* give it a little time */
+	mdelay(200);
+
+	WARN_ON(1);
+
+	return NOTIFY_DONE;
+}
+
+static int tps65086_restart_probe(struct platform_device *pdev)
+{
+	struct tps65086_restart *tps65086_restart;
+	int ret;
+
+	tps65086_restart = devm_kzalloc(&pdev->dev, sizeof(*tps65086_restart), GFP_KERNEL);
+	if (!tps65086_restart)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, tps65086_restart);
+
+	tps65086_restart->handler.notifier_call = tps65086_restart_notify;
+	tps65086_restart->handler.priority = 192;
+	tps65086_restart->dev = &pdev->dev;
+
+	ret = register_restart_handler(&tps65086_restart->handler);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: cannot register restart handler: %d\n",
+			__func__, ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int tps65086_restart_remove(struct platform_device *pdev)
+{
+	struct tps65086_restart *tps65086_restart = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = unregister_restart_handler(&tps65086_restart->handler);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: cannot unregister restart handler: %d\n",
+			__func__, ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id tps65086_restart_id_table[] = {
+	{ "tps65086-reset", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65086_restart_id_table);
+
+static struct platform_driver tps65086_restart_driver = {
+	.driver = {
+		.name = "tps65086-restart",
+	},
+	.probe = tps65086_restart_probe,
+	.remove = tps65086_restart_remove,
+	.id_table = tps65086_restart_id_table,
+};
+module_platform_driver(tps65086_restart_driver);
+
+MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
+MODULE_DESCRIPTION("TPS65086 restart driver");
+MODULE_LICENSE("GPL v2");
-- 
2.32.0

