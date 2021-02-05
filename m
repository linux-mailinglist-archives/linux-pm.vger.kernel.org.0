Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD63D3115C9
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 23:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBEWlp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 17:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBENeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 08:34:25 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA1EC06178A
        for <linux-pm@vger.kernel.org>; Fri,  5 Feb 2021 05:33:24 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id RRZN2400Q4C55Sk06RZNM3; Fri, 05 Feb 2021 14:33:22 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l81Eg-003Npa-5n; Fri, 05 Feb 2021 14:33:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l81Ef-0083mN-B4; Fri, 05 Feb 2021 14:33:21 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb reset handling
Date:   Fri,  5 Feb 2021 14:33:19 +0100
Message-Id: <20210205133319.1921108-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, there are two drivers binding to the R-Mobile System
Controller (SYSC):
  - The rmobile-sysc driver registers PM domains from a core_initcall(),
    and does not use a platform driver,
  - The rmobile-reset driver registers a reset handler, and does use a
    platform driver.

As fw_devlink only considers devices, it does not know that the
rmobile-sysc driver is ready.  Hence if fw_devlink is enabled, probing
of on-chip devices that are part of the SYSC PM domain is deferred until
the optional rmobile-reset has been bound, which may happen too late
(for e.g. the system timer on SoCs lacking an ARM architectured or
global timer), or not at all, leading to complete system boot failures.

Fix this by:
  1. Setting the OF_POPULATED flag for the SYSC device node after
     successful initialization.
     This will make of_link_to_phandle() ignore the SYSC device node as
     a dependency, making consumer devices probe again.
  2. Move reset handling from its own driver into the rmobile-sysc
     driver.
     This is needed because setting OF_POPULATED prevents the
     rmobile-reset driver from binding against the same device.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in renesas-devel for v5.13.

Tested on:
  - SH-Mobile AG5 (KZM-A9-GT),
  - R-Mobile APE6 (APE6-EVM),
  - R-Mobile A1 (Armadillo-800 EVA).

 drivers/power/reset/Kconfig         |  7 ---
 drivers/power/reset/Makefile        |  1 -
 drivers/power/reset/rmobile-reset.c | 88 -----------------------------
 drivers/soc/renesas/rmobile-sysc.c  | 65 ++++++++++++++++++++-
 4 files changed, 64 insertions(+), 97 deletions(-)
 delete mode 100644 drivers/power/reset/rmobile-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 1737e227b16e5136..417b112be3f660de 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -251,13 +251,6 @@ config POWER_RESET_SYSCON_POWEROFF
 	help
 	  Poweroff support for generic SYSCON mapped register poweroff.
 
-config POWER_RESET_RMOBILE
-	tristate "Renesas R-Mobile reset driver"
-	depends on ARCH_RMOBILE || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
-
 config POWER_RESET_ZX
 	tristate "ZTE SoCs reset driver"
 	depends on ARCH_ZX || COMPILE_TEST
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index b4601c0a96ed26c7..77a57ca8e5300d60 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_POWER_RESET_XGENE) += xgene-reboot.o
 obj-$(CONFIG_POWER_RESET_KEYSTONE) += keystone-reset.o
 obj-$(CONFIG_POWER_RESET_SYSCON) += syscon-reboot.o
 obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) += syscon-poweroff.o
-obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rmobile-reset.c
deleted file mode 100644
index bd3b396558e0df8c..0000000000000000
--- a/drivers/power/reset/rmobile-reset.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Renesas R-Mobile Reset Driver
- *
- * Copyright (C) 2014 Glider bvba
- */
-
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/notifier.h>
-#include <linux/of_address.h>
-#include <linux/platform_device.h>
-#include <linux/printk.h>
-#include <linux/reboot.h>
-
-/* SYSC Register Bank 2 */
-#define RESCNT2		0x20		/* Reset Control Register 2 */
-
-/* Reset Control Register 2 */
-#define RESCNT2_PRES	0x80000000	/* Soft power-on reset */
-
-static void __iomem *sysc_base2;
-
-static int rmobile_reset_handler(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
-{
-	pr_debug("%s %lu\n", __func__, mode);
-
-	/* Let's assume we have acquired the HPB semaphore */
-	writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block rmobile_reset_nb = {
-	.notifier_call = rmobile_reset_handler,
-	.priority = 192,
-};
-
-static int rmobile_reset_probe(struct platform_device *pdev)
-{
-	int error;
-
-	sysc_base2 = of_iomap(pdev->dev.of_node, 1);
-	if (!sysc_base2)
-		return -ENODEV;
-
-	error = register_restart_handler(&rmobile_reset_nb);
-	if (error) {
-		dev_err(&pdev->dev,
-			"cannot register restart handler (err=%d)\n", error);
-		goto fail_unmap;
-	}
-
-	return 0;
-
-fail_unmap:
-	iounmap(sysc_base2);
-	return error;
-}
-
-static int rmobile_reset_remove(struct platform_device *pdev)
-{
-	unregister_restart_handler(&rmobile_reset_nb);
-	iounmap(sysc_base2);
-	return 0;
-}
-
-static const struct of_device_id rmobile_reset_of_match[] = {
-	{ .compatible = "renesas,sysc-rmobile", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, rmobile_reset_of_match);
-
-static struct platform_driver rmobile_reset_driver = {
-	.probe = rmobile_reset_probe,
-	.remove = rmobile_reset_remove,
-	.driver = {
-		.name = "rmobile_reset",
-		.of_match_table = rmobile_reset_of_match,
-	},
-};
-
-module_platform_driver(rmobile_reset_driver);
-
-MODULE_DESCRIPTION("Renesas R-Mobile Reset Driver");
-MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmobile-sysc.c
index bf64d052f9245db5..a8d85d111924d9ee 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * rmobile power management support
+ * R-Mobile power management and reset support
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
  * Copyright (C) 2012  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  * Copyright (C) 2014  Glider bvba
+ * Copyright (C) 2021  Glider bv
  *
  * based on pm-sh7372.c
  *  Copyright (C) 2011 Magnus Damm
@@ -12,11 +13,13 @@
 #include <linux/clk/renesas.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pm.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 
 #include <asm/io.h>
@@ -29,6 +32,11 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
+/* SYSC Register Bank 2 */
+#define RESCNT2		0x20	/* Reset Control Register 2 */
+
+#define RESCNT2_PRES	BIT(31)	/* Soft power-on reset */
+
 struct rmobile_pm_domain {
 	struct generic_pm_domain genpd;
 	struct dev_power_governor *gov;
@@ -309,6 +317,54 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
 	return 0;
 }
 
+struct rmobile_reset {
+	void __iomem *base;
+	struct notifier_block nb;
+};
+
+static int rmobile_reset_handler(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	struct rmobile_reset *reset = container_of(this, struct rmobile_reset,
+						   nb);
+
+	pr_debug("%s %lu\n", __func__, mode);
+
+	/* Let's assume we have acquired the HPB semaphore */
+	writel(RESCNT2_PRES, reset->base + RESCNT2);
+
+	return NOTIFY_DONE;
+}
+
+static int rmobile_reset_setup(struct device_node *np)
+{
+	struct rmobile_reset *reset;
+	int error;
+
+	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->base = of_iomap(np, 1);
+	if (!reset->base)
+		goto fail_free;
+
+	reset->nb.notifier_call = rmobile_reset_handler;
+	reset->nb.priority = 192;
+
+	error = register_restart_handler(&reset->nb);
+	if (error)
+		goto fail_unmap;
+
+	return 0;
+
+fail_unmap:
+	iounmap(reset->base);
+fail_free:
+	kfree(reset);
+	return error;
+}
+
 static int __init rmobile_init_pm_domains(void)
 {
 	struct device_node *np, *pmd;
@@ -342,6 +398,13 @@ static int __init rmobile_init_pm_domains(void)
 			of_node_put(np);
 			break;
 		}
+
+		of_node_set_flag(np, OF_POPULATED);
+
+		ret = rmobile_reset_setup(np);
+		if (ret)
+			pr_err("%pOF: cannot register restart handler (%d)\n",
+			       np, ret);
 	}
 
 	put_special_pds();
-- 
2.25.1

