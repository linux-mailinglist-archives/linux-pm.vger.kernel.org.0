Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD32FD424
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbhATPXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 10:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388155AbhATPJi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 10:09:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE4512336D;
        Wed, 20 Jan 2021 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611155336;
        bh=ND9BSgncNjn0y6BjJzAbUADTI3Dr4GSKaRvxG9v5LxY=;
        h=From:To:Cc:Subject:Date:From;
        b=hvEpRXXa2TnOGrmtsUasxsGTeqxdZG3ey4D+dt6Q66PavcGgQ0LwInbWQRg3LXxj3
         a868mE82AHFSgeS0LOmmHJY3t0z8NcRewm1/cs+c3LvVZuSh8HG6aA9i8GdpSZPbcD
         gv1/b2K/VqLa3wuWi85RbArHa/AA3MvzdMGyUKiYhDIIZp+w0zO351c+EqdiOFcJnq
         K7lOt5mFxw/3lx7a2fDW+vHmvVpMoPu4eBnuBEvsV/1kq5pLuT9pc2/4MELKAOo1Dh
         iBEnmspCnONWoWuXJfs/aYZnv0qSdduxhv/xZQwnGe5U+E+FBuVv67IDHBy+sb5OBg
         /2eY74IUEPbMw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] power/reset: remove zte zx driver
Date:   Wed, 20 Jan 2021 16:08:26 +0100
Message-Id: <20210120150851.1670788-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The zte zx platform is getting removed, so this driver is no
longer needed.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/reset/Kconfig     |  7 ---
 drivers/power/reset/Makefile    |  1 -
 drivers/power/reset/zx-reboot.c | 86 ---------------------------------
 3 files changed, 94 deletions(-)
 delete mode 100644 drivers/power/reset/zx-reboot.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index b22c4fdb2561..0376a90bec09 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -251,13 +251,6 @@ config POWER_RESET_RMOBILE
 	help
 	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
 
-config POWER_RESET_ZX
-	tristate "ZTE SoCs reset driver"
-	depends on ARCH_ZX || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Reboot support for ZTE SoCs.
-
 config REBOOT_MODE
 	tristate
 
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 9dc49d3a57ff..46331119c886 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
 obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
-obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
 obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
deleted file mode 100644
index 457950833dba..000000000000
--- a/drivers/power/reset/zx-reboot.c
+++ /dev/null
@@ -1,86 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * ZTE zx296702 SoC reset code
- *
- * Copyright (c) 2015 Linaro Ltd.
- *
- * Author: Jun Nie <jun.nie@linaro.org>
- */
-
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/notifier.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/reboot.h>
-
-static void __iomem *base;
-static void __iomem *pcu_base;
-
-static int zx_restart_handler(struct notifier_block *this,
-			      unsigned long mode, void *cmd)
-{
-	writel_relaxed(1, base + 0xb0);
-	writel_relaxed(1, pcu_base + 0x34);
-
-	mdelay(50);
-	pr_emerg("Unable to restart system\n");
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block zx_restart_nb = {
-	.notifier_call = zx_restart_handler,
-	.priority = 128,
-};
-
-static int zx_reboot_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	int err;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		WARN(1, "failed to map base address");
-		return -ENODEV;
-	}
-
-	np = of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
-	pcu_base = of_iomap(np, 0);
-	of_node_put(np);
-	if (!pcu_base) {
-		iounmap(base);
-		WARN(1, "failed to map pcu_base address");
-		return -ENODEV;
-	}
-
-	err = register_restart_handler(&zx_restart_nb);
-	if (err) {
-		iounmap(base);
-		iounmap(pcu_base);
-		dev_err(&pdev->dev, "Register restart handler failed(err=%d)\n",
-			err);
-	}
-
-	return err;
-}
-
-static const struct of_device_id zx_reboot_of_match[] = {
-	{ .compatible = "zte,sysctrl" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, zx_reboot_of_match);
-
-static struct platform_driver zx_reboot_driver = {
-	.probe = zx_reboot_probe,
-	.driver = {
-		.name = "zx-reboot",
-		.of_match_table = zx_reboot_of_match,
-	},
-};
-module_platform_driver(zx_reboot_driver);
-
-MODULE_DESCRIPTION("ZTE SoCs reset driver");
-MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
-MODULE_LICENSE("GPL v2");
-- 
2.29.2

