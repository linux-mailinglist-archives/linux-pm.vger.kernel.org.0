Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6583570A26
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbfGVTx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 15:53:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36402 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbfGVTx2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 15:53:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so40734530wrs.3;
        Mon, 22 Jul 2019 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25JsdnSfB14vc5phGQW2itYhu2RCyyauOMt8JESw1E4=;
        b=pEymxfnahPYLHS1/AKiddeowpUV334fnOAVXyU6ROvk+Qxdpz/baBbKojYA7aPCose
         UJhz20w1Q5bEPdUkNJsFGBwBT32IpGTUUKY8xXvE23L1Fje7+fURJwEYu9XXbq7ZerYX
         u6lBFZh/Yd5Vp9/VI+cqBytm6lItXbYOc7g6zwboXg7hKOnAahlZ9ey5hkZRnjrFYt/u
         fMmfBgYI9C27p1NV3AZ/UZFT6CScct35LaYAGNoLicbRtGo8dRhUVAGC5qEC9RJMd1uE
         YWwm7JLuyfDF6g2JVmveUW44fzgcVeLpYfDyjx3xTmpqHplc7mEpBnicFy7EIa9b1jyF
         lz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25JsdnSfB14vc5phGQW2itYhu2RCyyauOMt8JESw1E4=;
        b=ZeSSq7NOcpFBt6vqv5E3E+5oUYCag3ek4NhZeuJws1iAkQ19ZZW2Ts257yyylv5DGq
         MebyL3EvL7PkUZ2l62XpWVI0h+yIZBQtl+7bzYohh9SarBvKKbuWnT6BWO/Tn8mz9f+S
         J4BNzcN6KNqBzDbvD8W2VT42PmVjeA0Tft3k4W82WGdq1otGgMY5/HJcEGpAPFkVHFc6
         WN3kaD3AZ/sejU8lc+TUnlc0b06T9oW+Y/V/hwqsKr8RVf4LT/zMCh2Z26Wf+O+cz3T2
         05CHvwmhxboa9MOcZmToXkH/0+fpGhqzVerWHXj+RLUdWV6V+FByHezp/WJSySPU8k+b
         ZrSg==
X-Gm-Message-State: APjAAAVe9dlDP8kXfyi24Vl8hz4xnU7z1uMbFGwuvRVVffN0pLypNnFG
        1sq7aQUKCxkFOol/594AFVA=
X-Google-Smtp-Source: APXvYqyMhnYuCxR8Gz/N1m1T8Gx6jR9hqzRM9RMGKJSFEIzK+Ya060wZeQ/LR5EOT7AYdX4SFWXU9w==
X-Received: by 2002:adf:e552:: with SMTP id z18mr78243165wrm.45.1563825205777;
        Mon, 22 Jul 2019 12:53:25 -0700 (PDT)
Received: from localhost.localdomain (nat-113.starnet.cz. [178.255.168.113])
        by smtp.googlemail.com with ESMTPSA id c65sm37382975wma.44.2019.07.22.12.53.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:53:25 -0700 (PDT)
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
Subject: [PATCH 3/5] power/reset: Add a power off driver for UART-based PM MCUs
Date:   Mon, 22 Jul 2019 21:53:03 +0200
Message-Id: <efdea0d2c7c5ed65e79fb3604130a4488ec8057c.1563822216.git.evgenyz@gmail.com>
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

This adds the poweroff driver for power managing
micro controller units that are connected to a board
via the UART interface.

Signed-off-by: Evgeny Kolesnikov <evgenyz@gmail.com>
---
 drivers/power/reset/Kconfig         |   7 ++
 drivers/power/reset/Makefile        |   1 +
 drivers/power/reset/uart-poweroff.c | 155 ++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/power/reset/uart-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a564237278ff..02fdf45e3988 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -216,6 +216,13 @@ config POWER_RESET_RMOBILE
 	help
 	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
 
+config POWER_RESET_UART_POWEROFF
+	tristate "UART-based PM MCU power off driver"
+	depends on OF_GPIO
+	help
+	  Power off support for boards with UART-based PM MCU
+	  such as WD My Cloud NAS, QNAP Turbo NAS, Synology devices.
+
 config POWER_RESET_ZX
 	tristate "ZTE SoCs reset driver"
 	depends on ARCH_ZX || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 85da3198e4e0..efe8f25f463d 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
+obj-$(CONFIG_POWER_RESET_UART_POWEROFF) += uart-poweroff.o
 obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
diff --git a/drivers/power/reset/uart-poweroff.c b/drivers/power/reset/uart-poweroff.c
new file mode 100644
index 000000000000..8122a6b306d7
--- /dev/null
+++ b/drivers/power/reset/uart-poweroff.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Power off for boards with UART-based PM MCUs
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/serial_reg.h>
+#include <linux/kallsyms.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#define UART_REG(b, x)	(b + ((UART_##x) << 2))
+
+struct uart_poweroff {
+	const u8 *cmd;
+	int cmd_len;
+	void __iomem *base;
+	unsigned int divisor;
+	u32 byte_delay_ms;
+	u32 timeout_ms;
+};
+
+static void *pm_power_off_org;
+static struct uart_poweroff uart_poweroff;
+
+static void uart_power_off(void)
+{
+	int i;
+
+	/* Hijack UART and reset into sane state */
+	writel(0x83, UART_REG(uart_poweroff.base, LCR));
+	writel(uart_poweroff.divisor & 0xFF, UART_REG(uart_poweroff.base, DLL));
+	writel((uart_poweroff.divisor >> 8) & 0xFF, UART_REG(uart_poweroff.base, DLM));
+	writel(0x03, UART_REG(uart_poweroff.base, LCR));
+	writel(0x00, UART_REG(uart_poweroff.base, IER));
+	writel(0x00, UART_REG(uart_poweroff.base, FCR));
+	writel(0x00, UART_REG(uart_poweroff.base, MCR));
+
+	/* Send the command */
+	for (i = 0; i < uart_poweroff.cmd_len; i++) {
+		writel(uart_poweroff.cmd[i], UART_REG(uart_poweroff.base, TX));
+		mdelay(uart_poweroff.byte_delay_ms);
+	}
+
+	mdelay(uart_poweroff.timeout_ms);
+	WARN_ON(1);
+}
+
+static int uart_poweroff_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	static void __iomem *base;
+	struct clk *clk;
+	u32 baud;
+	bool override;
+	char symname[KSYM_NAME_LEN];
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
+	uart_poweroff.cmd = of_get_property(pdev->dev.of_node, "cmd",
+						&uart_poweroff.cmd_len);
+	if (uart_poweroff.cmd == NULL || uart_poweroff.cmd_len < 1) {
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
+	uart_poweroff.base = base;
+	uart_poweroff.divisor =
+		((clk_get_rate(clk) + (8 * baud)) / (16 * baud));
+	uart_poweroff.byte_delay_ms = 5;
+	uart_poweroff.timeout_ms = 1000;
+	of_property_read_u32(pdev->dev.of_node, "byte-delay",
+				&uart_poweroff.byte_delay_ms);
+	of_property_read_u32(pdev->dev.of_node, "timeout",
+				&uart_poweroff.timeout_ms);
+
+	override = of_property_read_bool(pdev->dev.of_node, "override");
+
+	if (pm_power_off && !override) {
+		lookup_symbol_name((ulong)pm_power_off, symname);
+		dev_err(&pdev->dev,
+			"The pm_power_off is already claimed by %s (%p) and override is false",
+			symname, pm_power_off);
+		return -EBUSY;
+	}
+	pm_power_off_org = pm_power_off;
+	pm_power_off = uart_power_off;
+
+	return 0;
+}
+
+static int uart_poweroff_remove(struct platform_device *pdev)
+{
+	if (pm_power_off == uart_power_off)
+		pm_power_off = pm_power_off_org;
+
+	return 0;
+}
+
+static const struct of_device_id of_uart_poweroff_match[] = {
+	{ .compatible = "uart-poweroff", },
+	{},
+};
+
+static struct platform_driver uart_poweroff_driver = {
+	.probe	= uart_poweroff_probe,
+	.remove	= uart_poweroff_remove,
+	.driver	= {
+		.name	= "uart_poweroff",
+		.of_match_table = of_uart_poweroff_match,
+	},
+};
+module_platform_driver(uart_poweroff_driver);
+
+MODULE_AUTHOR("Evgeny Kolesnikov <evgenyz@gmail.com>");
+MODULE_DESCRIPTION("UART-based PM MCU power off driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

