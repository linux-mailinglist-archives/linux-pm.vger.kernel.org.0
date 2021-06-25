Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3927A3B4ABC
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jun 2021 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFYWuj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 18:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFYWui (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 18:50:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F5C061574;
        Fri, 25 Jun 2021 15:48:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r7so15460362edv.12;
        Fri, 25 Jun 2021 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErxD8maB1i/ewc9qb7JkQUrub9MpmCOuQbYIh+ng7Mw=;
        b=LAiDAGaiFyVqvINRIsHYkQpEhJbkJynnj4snRQ3VP8yIMN62wTZOmzEFcJRRdlGi44
         0TyYmvPXTsbqUg6Y0Wq0eIPfKJabn7KMJzjx5Z44rza9D3tDtF6t/ulTqxOEIgp9d/Sv
         XNReWSFpvFadKT2PoVpyInEP796Kq+thN6c42jRY/C64g0VssW5GNbHizrO6gJl7SY9s
         xDdZvifNT1nLSNLgFGKAm4L41DvqXJYtXymbucEkQTBp/dLw2qxkfWs3QGmomsmwL3b5
         rTgiUnWAev00YFsKcGzAVVX/bve3N/Ra0ynNICdJNy5sI1s+3DD8tsv7wyguU1qN4qrO
         taxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ErxD8maB1i/ewc9qb7JkQUrub9MpmCOuQbYIh+ng7Mw=;
        b=DS559VuxnaoJelPhgeVP4tiYNCgEuHnoCthPuH9S0AHHVu0U4JQU6gtUP5NbIXxWLh
         zr72WeDSSw7DE+tRjTNw3hrJMdxTfUUFjzTE4RmnF9tNGwHjtA76hAVUNilD9nf4mnNS
         aLgB4WZ019O0mBcO3Urh0OSQtKRAS8vVy5By0LYo5v+H6monrU9+uS1WKUHzcM63Jf6X
         dSw5PG2v4B73rYWcoQK2kmpqMstS6IuhyOdRFkPyyzJe93M5MADx1rcmIupH2VgFkz+Q
         Sob0s/yHWQmDWjrLYWvzAJ1d33CCZzbSCLtifFo31OSqVxHkaumS+m7sFFpMqdQk0J3m
         03ow==
X-Gm-Message-State: AOAM533bOO/s1OjTTBiXxfR54BFB879ZRxQ9/diXvLNsCXSEOKwX7nAR
        /H/6WYj/qWeiotPFQZk7RYI=
X-Google-Smtp-Source: ABdhPJyCzOxYfH0nS/aaMl6oMarNvx3KC9hCa/kwis38Z2qeZrnIU1nPxEQBawSG5dG5oFr4xQriHA==
X-Received: by 2002:a05:6402:516b:: with SMTP id d11mr18111155ede.252.1624661293177;
        Fri, 25 Jun 2021 15:48:13 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id w1sm4719399edr.62.2021.06.25.15.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:48:12 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] power: reset: Add TPS65086 restart driver
Date:   Sat, 26 Jun 2021 00:47:44 +0200
Message-Id: <20210625224744.1020108-4-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625224744.1020108-1-kernel@esmil.dk>
References: <20210625224744.1020108-1-kernel@esmil.dk>
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
---
 drivers/mfd/tps65086.c                 |  1 +
 drivers/power/reset/Kconfig            |  6 ++
 drivers/power/reset/Makefile           |  1 +
 drivers/power/reset/tps65086-restart.c | 99 ++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/power/reset/tps65086-restart.c

diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index cc3478ee9a64..1bfba0758fcc 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -24,6 +24,7 @@
 static const struct mfd_cell tps65086_cells[] = {
 	{ .name = "tps65086-regulator", },
 	{ .name = "tps65086-gpio", },
+	{ .name = "tps65086-restart", },
 };
 
 static const struct regmap_range tps65086_yes_ranges[] = {
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
index 000000000000..ad9f2c5a84ac
--- /dev/null
+++ b/drivers/power/reset/tps65086-restart.c
@@ -0,0 +1,99 @@
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
+	struct tps65086 *tps;
+	struct device *dev;
+};
+
+static int tps65086_restart_notify(struct notifier_block *this,
+				   unsigned long mode, void *cmd)
+{
+	struct tps65086_restart *tps65086_restart =
+		container_of(this, struct tps65086_restart, handler);
+	int ret;
+
+	ret = regmap_write(tps65086_restart->tps->regmap, TPS65086_FORCESHUTDN, 1);
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
+	tps65086_restart->tps = dev_get_drvdata(pdev->dev.parent);
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
+	{ "tps65086-restart", },
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

