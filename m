Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F670A1E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfGVTxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 15:53:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbfGVTxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 15:53:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so36351144wma.1;
        Mon, 22 Jul 2019 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bg3NOyYgAWvTM2AHLzN6gt3uUe6onVadeq9y9paS70s=;
        b=fX31OhKjRtSJbdPXbFaBb+fdZjIbiHtzFNkgdCnesHOum96e+CFTkOq1m3zMHhiKo1
         bIafHw9/ZRnh3BlqWygP61EMSbXUtTp7cpFJSdTvsVYFlE7ogkL6ITAdtcoUIS/RAiw9
         9U+dl3hC6CZuW9Yq+KuJhYIgH/mCSnxNUePGGYuwyLXSQ2HQzJ5NCx/1hpc5Zhrgxe9V
         pFlwGMCyEsher2p2mFmyrGNnBUbNRTR7qYn/1VnwT+2fW8TUX9w62hw9Y43ypD7bi5nn
         e2Z+QjGXK/BBYNJVsHxarv2DhdWq/d0d8mFpAJt8uS7Cthrzo0PtqZX44Jw3ZUUWJxqP
         UzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bg3NOyYgAWvTM2AHLzN6gt3uUe6onVadeq9y9paS70s=;
        b=CK3NZzyJknu8NA8neQwKwrsclrt01EpDGiibpQyVMtV3+2at59BdEmdaOHkdKrsSaX
         OugDZvKSo1gEnrzC3gAQx9+bbbqqZWN2AT83/X1+Hsa7lyctkOYicb5eNVIOFA4GRmdT
         /TJyCdqMvDM9S3mM4jhVJC6eymrN/ph9EG/LBp5+RuuUAThCEnQpv+ygCNwt31UsWX0f
         61GKoSYG4xBo6HO+VzzZvNS13ZafqNC424HJAAlnx+e6oxJqFIP3m3fsm/BzQ2hNv5zm
         pcBPSe3/hi8hQbhlS11490Ca8tOmWYKUuz6DhTJgovUCD9yxMA/bvc5wtWfbKM6zMMwI
         c89A==
X-Gm-Message-State: APjAAAX4bTpny7OUTXoEOQcxRnUH8zaP2wSU/pa0AZhFwwNRxQGGJexB
        tjfNz57QAiUDBonGhz4xDAI=
X-Google-Smtp-Source: APXvYqzIejkrbtnZhZXUB3etEfSKe6Ng2SsEyaHPoury5Bd3GT/54m7o9LtQ9fQ9Ey5LdZTBwnm1Tg==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr60524747wmc.110.1563825208796;
        Mon, 22 Jul 2019 12:53:28 -0700 (PDT)
Received: from localhost.localdomain (nat-113.starnet.cz. [178.255.168.113])
        by smtp.googlemail.com with ESMTPSA id c65sm37382975wma.44.2019.07.22.12.53.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:53:28 -0700 (PDT)
From:   Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Evgeny Kolesnikov <evgenyz@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] power/reset: Add a restart driver for UART-based PM MCUs
Date:   Mon, 22 Jul 2019 21:53:04 +0200
Message-Id: <ae33cb72a370d3af6319330e950cdd6cc68a007c.1563822216.git.evgenyz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563822216.git.evgenyz@gmail.com>
References: <cover.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the restart driver for power managing
micro controller units that are connected to a board
via the UART interface.

Signed-off-by: Evgeny Kolesnikov <evgenyz@gmail.com>
---
 drivers/power/reset/Kconfig        |   7 +
 drivers/power/reset/Makefile       |   1 +
 drivers/power/reset/uart-restart.c | 204 +++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/power/reset/uart-restart.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 02fdf45e3988..4b187af1fba6 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -223,6 +223,13 @@ config POWER_RESET_UART_POWEROFF
 	  Power off support for boards with UART-based PM MCU
 	  such as WD My Cloud NAS, QNAP Turbo NAS, Synology devices.
 
+config POWER_RESET_UART
+	tristate "UART-based PM MCU restart driver"
+	depends on OF_GPIO
+	help
+	  Reboot support for boards with UART-based PM MCU
+	  such as WD My Cloud NAS, QNAP Turbo NAS, Synology devices.
+
 config POWER_RESET_ZX
 	tristate "ZTE SoCs reset driver"
 	depends on ARCH_ZX || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index efe8f25f463d..fa8a936d7a1a 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_POWER_RESET_UART_POWEROFF) += uart-poweroff.o
+obj-$(CONFIG_POWER_RESET_UART) += uart-restart.o
 obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
diff --git a/drivers/power/reset/uart-restart.c b/drivers/power/reset/uart-restart.c
new file mode 100644
index 000000000000..be4dcbbb826e
--- /dev/null
+++ b/drivers/power/reset/uart-restart.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Restart for boards with UART-based PM MCUs
+ * such as WD My Cloud NAS, QNAP Turbo NAS, Synology devices.
+ *
+ * Copyright (C) 2019 Evgeny Kolesnikov <evgenyz@gmail.com>
+ *
+ * Based on the code from:
+ *
+ * Copyright (C) 2016 Martin Mueller <mm@sig21.net>
+ * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
+ * Copyright (C) 2009 Martin Michlmayr <tbm@cyrius.com>
+ * Copyright (C) 2008 Byron Bradley <byron.bbradley@gmail.com>
+ *
+ */
+
+#include <linux/reboot.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/serial_reg.h>
+#include <linux/kallsyms.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#ifdef CONFIG_ARM
+#include <asm/system_misc.h>
+#endif
+
+#define UART_REG(b, x)	(b + ((UART_##x) << 2))
+
+
+struct uart_restart {
+	struct notifier_block restart_handler;
+	const u8 *cmd;
+	int cmd_len;
+	void __iomem *base;
+	unsigned int divisor;
+	u32 byte_delay_ms;
+	u32 timeout_ms;
+	void *pm_restart_org;
+};
+
+static int uart_restart_notify(struct notifier_block *this,
+				unsigned long mode, void *cmd)
+{
+	struct uart_restart *uart_restart =
+		container_of(this, struct uart_restart, restart_handler);
+	int i;
+
+	/* Hijack UART and reset into sane state */
+	writel(0x83, UART_REG(uart_restart->base, LCR));
+	writel(uart_restart->divisor & 0xFF, UART_REG(uart_restart->base, DLL));
+	writel((uart_restart->divisor >> 8) & 0xFF, UART_REG(uart_restart->base, DLM));
+	writel(0x03, UART_REG(uart_restart->base, LCR));
+	writel(0x00, UART_REG(uart_restart->base, IER));
+	writel(0x00, UART_REG(uart_restart->base, FCR));
+	writel(0x00, UART_REG(uart_restart->base, MCR));
+
+	/* Send the command */
+	for (i = 0; i < uart_restart->cmd_len; i++) {
+		writel(uart_restart->cmd[i], UART_REG(uart_restart->base, TX));
+		mdelay(uart_restart->byte_delay_ms);
+	}
+	mdelay(uart_restart->timeout_ms);
+	WARN_ON(1);
+
+	return NOTIFY_DONE;
+}
+
+static int uart_restart_probe(struct platform_device *pdev)
+{
+	struct uart_restart *uart_restart;
+	struct resource *res;
+	void __iomem *base;
+	struct clk *clk;
+	u32 baud;
+	bool override;
+	int err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Missing resource\n");
+		return -EINVAL;
+	}
+
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!base) {
+		dev_err(&pdev->dev, "Unable to map resource\n");
+		return -EINVAL;
+	}
+
+	/* We need to know tclk in order to calculate the UART divisor */
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Clk missing\n");
+		return PTR_ERR(clk);
+	}
+
+	uart_restart = devm_kzalloc(&pdev->dev, sizeof(*uart_restart),
+			GFP_KERNEL);
+	if (!uart_restart)
+		return -ENOMEM;
+
+	uart_restart->cmd = of_get_property(pdev->dev.of_node, "cmd",
+						&uart_restart->cmd_len);
+	if (uart_restart->cmd == NULL || uart_restart->cmd_len < 1) {
+		dev_err(&pdev->dev, "Cmd is missing or empty\n");
+		return -EINVAL;
+	}
+
+	of_property_read_u32(pdev->dev.of_node, "baud", &baud);
+	if (baud < 75 || baud > 460800) {
+		dev_err(&pdev->dev, "Baud rate is missing or invalid\n");
+		return -EINVAL;
+	}
+
+	uart_restart->restart_handler.notifier_call = uart_restart_notify;
+	uart_restart->restart_handler.priority = 129;
+	uart_restart->base = base;
+	uart_restart->divisor =
+		((clk_get_rate(clk) + (8 * baud)) / (16 * baud));
+	uart_restart->byte_delay_ms = 5;
+	uart_restart->timeout_ms = 1000;
+	of_property_read_u32(pdev->dev.of_node, "byte-delay",
+				&uart_restart->byte_delay_ms);
+	of_property_read_u32(pdev->dev.of_node, "timeout",
+				&uart_restart->timeout_ms);
+
+	override = of_property_read_bool(pdev->dev.of_node, "override");
+
+	if (override)
+		uart_restart->restart_handler.priority = 192;
+
+	platform_set_drvdata(pdev, uart_restart);
+
+#ifdef CONFIG_ARM
+	char symname[KSYM_NAME_LEN];
+
+	if (arm_pm_restart && !override) {
+		lookup_symbol_name((ulong)arm_pm_restart, symname);
+		dev_err(&pdev->dev,
+			"The arm_pm_restart is already claimed by %s (%p) and override is false",
+			symname, arm_pm_restart);
+		return -EBUSY;
+	}
+#endif
+
+	err = register_restart_handler(&uart_restart->restart_handler);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Unable to register restart handler: %d\n", err);
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_ARM
+	if (arm_pm_restart && override) {
+		uart_restart->pm_restart_org = arm_pm_restart;
+		arm_pm_restart = NULL;
+	}
+#endif
+
+	return 0;
+}
+
+static int uart_restart_remove(struct platform_device *pdev)
+{
+	struct uart_restart *uart_restart = platform_get_drvdata(pdev);
+	int err;
+
+	err = unregister_restart_handler(&uart_restart->restart_handler);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Unable to unregister restart handler, %d\n", err);
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_ARM
+	if (arm_pm_restart == NULL && uart_restart->pm_restart_org != NULL)
+		arm_pm_restart = uart_restart->pm_restart_org;
+#endif
+
+	return 0;
+}
+
+static const struct of_device_id of_uart_restart_match[] = {
+	{ .compatible = "uart-restart", },
+	{},
+};
+
+static struct platform_driver uart_restart_driver = {
+	.probe	= uart_restart_probe,
+	.remove	= uart_restart_remove,
+	.driver	= {
+		.name	= "uart_restart",
+		.of_match_table = of_uart_restart_match,
+	},
+};
+module_platform_driver(uart_restart_driver);
+
+MODULE_AUTHOR("Evgeny Kolesnikov <evgenyz@gmail.com>");
+MODULE_DESCRIPTION("UART-based PM MCU restart driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

