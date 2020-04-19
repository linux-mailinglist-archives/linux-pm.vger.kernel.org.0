Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1C1AFC69
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 19:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDSRId (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 13:08:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37685 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgDSRIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so5975814oto.4;
        Sun, 19 Apr 2020 10:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDsOf8xrlQkbUqgAcINGDxLpBH8V3FiknyRNzRYDKwo=;
        b=HBlY/b+Bi/uYplJx7cQo6KfMD+OH7dH0OY6bDjkY5rzUOp6dCvWAU/4fRvnLC25ffw
         7tbSQAJi4nyYNBZi4EvYKh/K1/qOuRd8jjJIp5lXsaXgzj3FEJOXrjirvrhYvnNa495j
         LkzjpXc1Yg5N24eBWcnuyv2su5ega54xqwgVFxi22k2JZHS1snwY8r0D7Ue1zLf90MDI
         +rLO2TOTLs8YR4t3R1fxUgagMvN0nJz85wF0rfpj2TUeDkV0Fe+LRd7a4VqwCFVk/z9q
         7N19XaNYY34In6phMSCpGrsWG2bUs0VOl3EovaeEVzaeqigHj5tv9O+NuUw2QR3vfxS9
         65oA==
X-Gm-Message-State: AGi0PuZlr8wjUgs2IKdAzX1r0Tif4rsclgK9HAniPbkrrf4vQ66p/Pzr
        qRI5txxszwp9OGfVIG3fKw==
X-Google-Smtp-Source: APiQypLFbtfp79/5QJZvCudLXXjTScxXROV1png55ZPeGSDdb0tkJrrhen3wX4MDPaz1N8eU87z+3A==
X-Received: by 2002:a9d:6447:: with SMTP id m7mr6587316otl.256.1587316110736;
        Sun, 19 Apr 2020 10:08:30 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 13/17] bus: vexpress-config: Merge vexpress-syscfg into vexpress-config
Date:   Sun, 19 Apr 2020 12:08:06 -0500
Message-Id: <20200419170810.5738-14-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only thing that vexpress-syscfg does is provide a regmap to
vexpress-config bus child devices. There's little reason to have 2
components for this. The current structure with initcall ordering
requirements makes turning these components into modules more difficult.

So let's start to simplify things and merge vexpress-syscfg into
vexpress-config. There's no functional change in this commit and it's
still separate components until subsequent commits.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-vexpress/Kconfig |   1 -
 drivers/bus/vexpress-config.c  | 283 +++++++++++++++++++++++++++++++--
 drivers/misc/Kconfig           |   9 --
 drivers/misc/Makefile          |   1 -
 drivers/misc/vexpress-syscfg.c | 280 --------------------------------
 include/linux/vexpress.h       |  17 --
 6 files changed, 274 insertions(+), 317 deletions(-)
 delete mode 100644 drivers/misc/vexpress-syscfg.c

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 2d1fdec4c230..065e12991663 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -20,7 +20,6 @@ menuconfig ARCH_VEXPRESS
 	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select VEXPRESS_CONFIG
-	select VEXPRESS_SYSCFG
 	help
 	  This option enables support for systems using Cortex processor based
 	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index ff70575b2db6..43f5beac9811 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -6,10 +6,48 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <linux/vexpress.h>
 
+#define SYS_CFGDATA		0x0
+
+#define SYS_CFGCTRL		0x4
+#define SYS_CFGCTRL_START	(1 << 31)
+#define SYS_CFGCTRL_WRITE	(1 << 30)
+#define SYS_CFGCTRL_DCC(n)	(((n) & 0xf) << 26)
+#define SYS_CFGCTRL_FUNC(n)	(((n) & 0x3f) << 20)
+#define SYS_CFGCTRL_SITE(n)	(((n) & 0x3) << 16)
+#define SYS_CFGCTRL_POSITION(n)	(((n) & 0xf) << 12)
+#define SYS_CFGCTRL_DEVICE(n)	(((n) & 0xfff) << 0)
+
+#define SYS_CFGSTAT		0x8
+#define SYS_CFGSTAT_ERR		(1 << 1)
+#define SYS_CFGSTAT_COMPLETE	(1 << 0)
+
+
+struct vexpress_syscfg {
+	struct device *dev;
+	void __iomem *base;
+	struct list_head funcs;
+};
+
+struct vexpress_syscfg_func {
+	struct list_head list;
+	struct vexpress_syscfg *syscfg;
+	struct regmap *regmap;
+	int num_templates;
+	u32 template[]; /* Keep it last! */
+};
+
+struct vexpress_config_bridge_ops {
+	struct regmap * (*regmap_init)(struct device *dev, void *context);
+	void (*regmap_exit)(struct regmap *regmap, void *context);
+};
 
 struct vexpress_config_bridge {
 	struct vexpress_config_bridge_ops *ops;
@@ -27,17 +65,12 @@ void vexpress_config_set_master(u32 site)
 	vexpress_config_site_master = site;
 }
 
-u32 vexpress_config_get_master(void)
-{
-	return vexpress_config_site_master;
-}
-
-void vexpress_config_lock(void *arg)
+static void vexpress_config_lock(void *arg)
 {
 	mutex_lock(&vexpress_config_mutex);
 }
 
-void vexpress_config_unlock(void *arg)
+static void vexpress_config_unlock(void *arg)
 {
 	mutex_unlock(&vexpress_config_mutex);
 }
@@ -59,7 +92,7 @@ static void vexpress_config_find_prop(struct device_node *node,
 	}
 }
 
-int vexpress_config_get_topo(struct device_node *node, u32 *site,
+static int vexpress_config_get_topo(struct device_node *node, u32 *site,
 		u32 *position, u32 *dcc)
 {
 	vexpress_config_find_prop(node, "arm,vexpress,site", site);
@@ -113,7 +146,7 @@ struct regmap *devm_regmap_init_vexpress_config(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_regmap_init_vexpress_config);
 
-struct device *vexpress_config_bridge_register(struct device *parent,
+static struct device *vexpress_config_bridge_register(struct device *parent,
 		struct vexpress_config_bridge_ops *ops, void *context)
 {
 	struct device *dev;
@@ -201,3 +234,235 @@ static int __init vexpress_config_init(void)
 }
 postcore_initcall(vexpress_config_init);
 
+static int vexpress_syscfg_exec(struct vexpress_syscfg_func *func,
+		int index, bool write, u32 *data)
+{
+	struct vexpress_syscfg *syscfg = func->syscfg;
+	u32 command, status;
+	int tries;
+	long timeout;
+
+	if (WARN_ON(index >= func->num_templates))
+		return -EINVAL;
+
+	command = readl(syscfg->base + SYS_CFGCTRL);
+	if (WARN_ON(command & SYS_CFGCTRL_START))
+		return -EBUSY;
+
+	command = func->template[index];
+	command |= SYS_CFGCTRL_START;
+	command |= write ? SYS_CFGCTRL_WRITE : 0;
+
+	/* Use a canary for reads */
+	if (!write)
+		*data = 0xdeadbeef;
+
+	dev_dbg(syscfg->dev, "func %p, command %x, data %x\n",
+			func, command, *data);
+	writel(*data, syscfg->base + SYS_CFGDATA);
+	writel(0, syscfg->base + SYS_CFGSTAT);
+	writel(command, syscfg->base + SYS_CFGCTRL);
+	mb();
+
+	/* The operation can take ages... Go to sleep, 100us initially */
+	tries = 100;
+	timeout = 100;
+	do {
+		if (!irqs_disabled()) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(usecs_to_jiffies(timeout));
+			if (signal_pending(current))
+				return -EINTR;
+		} else {
+			udelay(timeout);
+		}
+
+		status = readl(syscfg->base + SYS_CFGSTAT);
+		if (status & SYS_CFGSTAT_ERR)
+			return -EFAULT;
+
+		if (timeout > 20)
+			timeout -= 20;
+	} while (--tries && !(status & SYS_CFGSTAT_COMPLETE));
+	if (WARN_ON_ONCE(!tries))
+		return -ETIMEDOUT;
+
+	if (!write) {
+		*data = readl(syscfg->base + SYS_CFGDATA);
+		dev_dbg(syscfg->dev, "func %p, read data %x\n", func, *data);
+	}
+
+	return 0;
+}
+
+static int vexpress_syscfg_read(void *context, unsigned int index,
+		unsigned int *val)
+{
+	struct vexpress_syscfg_func *func = context;
+
+	return vexpress_syscfg_exec(func, index, false, val);
+}
+
+static int vexpress_syscfg_write(void *context, unsigned int index,
+		unsigned int val)
+{
+	struct vexpress_syscfg_func *func = context;
+
+	return vexpress_syscfg_exec(func, index, true, &val);
+}
+
+static struct regmap_config vexpress_syscfg_regmap_config = {
+	.lock = vexpress_config_lock,
+	.unlock = vexpress_config_unlock,
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_read = vexpress_syscfg_read,
+	.reg_write = vexpress_syscfg_write,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+
+static struct regmap *vexpress_syscfg_regmap_init(struct device *dev,
+		void *context)
+{
+	int err;
+	struct vexpress_syscfg *syscfg = context;
+	struct vexpress_syscfg_func *func;
+	struct property *prop;
+	const __be32 *val = NULL;
+	__be32 energy_quirk[4];
+	int num;
+	u32 site, position, dcc;
+	int i;
+
+	err = vexpress_config_get_topo(dev->of_node, &site,
+				&position, &dcc);
+	if (err)
+		return ERR_PTR(err);
+
+	prop = of_find_property(dev->of_node,
+			"arm,vexpress-sysreg,func", NULL);
+	if (!prop)
+		return ERR_PTR(-EINVAL);
+
+	num = prop->length / sizeof(u32) / 2;
+	val = prop->value;
+
+	/*
+	 * "arm,vexpress-energy" function used to be described
+	 * by its first device only, now it requires both
+	 */
+	if (num == 1 && of_device_is_compatible(dev->of_node,
+			"arm,vexpress-energy")) {
+		num = 2;
+		energy_quirk[0] = *val;
+		energy_quirk[2] = *val++;
+		energy_quirk[1] = *val;
+		energy_quirk[3] = cpu_to_be32(be32_to_cpup(val) + 1);
+		val = energy_quirk;
+	}
+
+	func = kzalloc(struct_size(func, template, num), GFP_KERNEL);
+	if (!func)
+		return ERR_PTR(-ENOMEM);
+
+	func->syscfg = syscfg;
+	func->num_templates = num;
+
+	for (i = 0; i < num; i++) {
+		u32 function, device;
+
+		function = be32_to_cpup(val++);
+		device = be32_to_cpup(val++);
+
+		dev_dbg(dev, "func %p: %u/%u/%u/%u/%u\n",
+				func, site, position, dcc,
+				function, device);
+
+		func->template[i] = SYS_CFGCTRL_DCC(dcc);
+		func->template[i] |= SYS_CFGCTRL_SITE(site);
+		func->template[i] |= SYS_CFGCTRL_POSITION(position);
+		func->template[i] |= SYS_CFGCTRL_FUNC(function);
+		func->template[i] |= SYS_CFGCTRL_DEVICE(device);
+	}
+
+	vexpress_syscfg_regmap_config.max_register = num - 1;
+
+	func->regmap = regmap_init(dev, NULL, func,
+			&vexpress_syscfg_regmap_config);
+
+	if (IS_ERR(func->regmap)) {
+		void *err = func->regmap;
+
+		kfree(func);
+		return err;
+	}
+
+	list_add(&func->list, &syscfg->funcs);
+
+	return func->regmap;
+}
+
+static void vexpress_syscfg_regmap_exit(struct regmap *regmap, void *context)
+{
+	struct vexpress_syscfg *syscfg = context;
+	struct vexpress_syscfg_func *func, *tmp;
+
+	regmap_exit(regmap);
+
+	list_for_each_entry_safe(func, tmp, &syscfg->funcs, list) {
+		if (func->regmap == regmap) {
+			list_del(&syscfg->funcs);
+			kfree(func);
+			break;
+		}
+	}
+}
+
+static struct vexpress_config_bridge_ops vexpress_syscfg_bridge_ops = {
+	.regmap_init = vexpress_syscfg_regmap_init,
+	.regmap_exit = vexpress_syscfg_regmap_exit,
+};
+
+
+static int vexpress_syscfg_probe(struct platform_device *pdev)
+{
+	struct vexpress_syscfg *syscfg;
+	struct resource *res;
+	struct device *bridge;
+
+	syscfg = devm_kzalloc(&pdev->dev, sizeof(*syscfg), GFP_KERNEL);
+	if (!syscfg)
+		return -ENOMEM;
+	syscfg->dev = &pdev->dev;
+	INIT_LIST_HEAD(&syscfg->funcs);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	syscfg->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(syscfg->base))
+		return PTR_ERR(syscfg->base);
+
+	/* Must use dev.parent (MFD), as that's where DT phandle points at... */
+	bridge = vexpress_config_bridge_register(pdev->dev.parent,
+			&vexpress_syscfg_bridge_ops, syscfg);
+
+	return PTR_ERR_OR_ZERO(bridge);
+}
+
+static const struct platform_device_id vexpress_syscfg_id_table[] = {
+	{ "vexpress-syscfg", },
+	{},
+};
+
+static struct platform_driver vexpress_syscfg_driver = {
+	.driver.name = "vexpress-syscfg",
+	.id_table = vexpress_syscfg_id_table,
+	.probe = vexpress_syscfg_probe,
+};
+
+static int __init vexpress_syscfg_init(void)
+{
+	return platform_driver_register(&vexpress_syscfg_driver);
+}
+core_initcall(vexpress_syscfg_init);
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 99e151475d8f..edd5dd5ebfdc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -423,15 +423,6 @@ config SRAM
 config SRAM_EXEC
 	bool
 
-config VEXPRESS_SYSCFG
-	bool "Versatile Express System Configuration driver"
-	depends on VEXPRESS_CONFIG
-	default y
-	help
-	  ARM Ltd. Versatile Express uses specialised platform configuration
-	  bus. System Configuration interface is one of the possible means
-	  of generating transactions on this bus.
-
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9abf2923d831..c7bd01ac6291 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
-obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
deleted file mode 100644
index a431787c0898..000000000000
--- a/drivers/misc/vexpress-syscfg.c
+++ /dev/null
@@ -1,280 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *
- * Copyright (C) 2014 ARM Limited
- */
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/sched/signal.h>
-#include <linux/slab.h>
-#include <linux/syscore_ops.h>
-#include <linux/vexpress.h>
-
-
-#define SYS_CFGDATA		0x0
-
-#define SYS_CFGCTRL		0x4
-#define SYS_CFGCTRL_START	(1 << 31)
-#define SYS_CFGCTRL_WRITE	(1 << 30)
-#define SYS_CFGCTRL_DCC(n)	(((n) & 0xf) << 26)
-#define SYS_CFGCTRL_FUNC(n)	(((n) & 0x3f) << 20)
-#define SYS_CFGCTRL_SITE(n)	(((n) & 0x3) << 16)
-#define SYS_CFGCTRL_POSITION(n)	(((n) & 0xf) << 12)
-#define SYS_CFGCTRL_DEVICE(n)	(((n) & 0xfff) << 0)
-
-#define SYS_CFGSTAT		0x8
-#define SYS_CFGSTAT_ERR		(1 << 1)
-#define SYS_CFGSTAT_COMPLETE	(1 << 0)
-
-
-struct vexpress_syscfg {
-	struct device *dev;
-	void __iomem *base;
-	struct list_head funcs;
-};
-
-struct vexpress_syscfg_func {
-	struct list_head list;
-	struct vexpress_syscfg *syscfg;
-	struct regmap *regmap;
-	int num_templates;
-	u32 template[]; /* Keep it last! */
-};
-
-
-static int vexpress_syscfg_exec(struct vexpress_syscfg_func *func,
-		int index, bool write, u32 *data)
-{
-	struct vexpress_syscfg *syscfg = func->syscfg;
-	u32 command, status;
-	int tries;
-	long timeout;
-
-	if (WARN_ON(index >= func->num_templates))
-		return -EINVAL;
-
-	command = readl(syscfg->base + SYS_CFGCTRL);
-	if (WARN_ON(command & SYS_CFGCTRL_START))
-		return -EBUSY;
-
-	command = func->template[index];
-	command |= SYS_CFGCTRL_START;
-	command |= write ? SYS_CFGCTRL_WRITE : 0;
-
-	/* Use a canary for reads */
-	if (!write)
-		*data = 0xdeadbeef;
-
-	dev_dbg(syscfg->dev, "func %p, command %x, data %x\n",
-			func, command, *data);
-	writel(*data, syscfg->base + SYS_CFGDATA);
-	writel(0, syscfg->base + SYS_CFGSTAT);
-	writel(command, syscfg->base + SYS_CFGCTRL);
-	mb();
-
-	/* The operation can take ages... Go to sleep, 100us initially */
-	tries = 100;
-	timeout = 100;
-	do {
-		if (!irqs_disabled()) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(usecs_to_jiffies(timeout));
-			if (signal_pending(current))
-				return -EINTR;
-		} else {
-			udelay(timeout);
-		}
-
-		status = readl(syscfg->base + SYS_CFGSTAT);
-		if (status & SYS_CFGSTAT_ERR)
-			return -EFAULT;
-
-		if (timeout > 20)
-			timeout -= 20;
-	} while (--tries && !(status & SYS_CFGSTAT_COMPLETE));
-	if (WARN_ON_ONCE(!tries))
-		return -ETIMEDOUT;
-
-	if (!write) {
-		*data = readl(syscfg->base + SYS_CFGDATA);
-		dev_dbg(syscfg->dev, "func %p, read data %x\n", func, *data);
-	}
-
-	return 0;
-}
-
-static int vexpress_syscfg_read(void *context, unsigned int index,
-		unsigned int *val)
-{
-	struct vexpress_syscfg_func *func = context;
-
-	return vexpress_syscfg_exec(func, index, false, val);
-}
-
-static int vexpress_syscfg_write(void *context, unsigned int index,
-		unsigned int val)
-{
-	struct vexpress_syscfg_func *func = context;
-
-	return vexpress_syscfg_exec(func, index, true, &val);
-}
-
-static struct regmap_config vexpress_syscfg_regmap_config = {
-	.lock = vexpress_config_lock,
-	.unlock = vexpress_config_unlock,
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_read = vexpress_syscfg_read,
-	.reg_write = vexpress_syscfg_write,
-	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
-	.val_format_endian = REGMAP_ENDIAN_LITTLE,
-};
-
-
-static struct regmap *vexpress_syscfg_regmap_init(struct device *dev,
-		void *context)
-{
-	int err;
-	struct vexpress_syscfg *syscfg = context;
-	struct vexpress_syscfg_func *func;
-	struct property *prop;
-	const __be32 *val = NULL;
-	__be32 energy_quirk[4];
-	int num;
-	u32 site, position, dcc;
-	int i;
-
-	err = vexpress_config_get_topo(dev->of_node, &site,
-				&position, &dcc);
-	if (err)
-		return ERR_PTR(err);
-
-	prop = of_find_property(dev->of_node,
-			"arm,vexpress-sysreg,func", NULL);
-	if (!prop)
-		return ERR_PTR(-EINVAL);
-
-	num = prop->length / sizeof(u32) / 2;
-	val = prop->value;
-
-	/*
-	 * "arm,vexpress-energy" function used to be described
-	 * by its first device only, now it requires both
-	 */
-	if (num == 1 && of_device_is_compatible(dev->of_node,
-			"arm,vexpress-energy")) {
-		num = 2;
-		energy_quirk[0] = *val;
-		energy_quirk[2] = *val++;
-		energy_quirk[1] = *val;
-		energy_quirk[3] = cpu_to_be32(be32_to_cpup(val) + 1);
-		val = energy_quirk;
-	}
-
-	func = kzalloc(struct_size(func, template, num), GFP_KERNEL);
-	if (!func)
-		return ERR_PTR(-ENOMEM);
-
-	func->syscfg = syscfg;
-	func->num_templates = num;
-
-	for (i = 0; i < num; i++) {
-		u32 function, device;
-
-		function = be32_to_cpup(val++);
-		device = be32_to_cpup(val++);
-
-		dev_dbg(dev, "func %p: %u/%u/%u/%u/%u\n",
-				func, site, position, dcc,
-				function, device);
-
-		func->template[i] = SYS_CFGCTRL_DCC(dcc);
-		func->template[i] |= SYS_CFGCTRL_SITE(site);
-		func->template[i] |= SYS_CFGCTRL_POSITION(position);
-		func->template[i] |= SYS_CFGCTRL_FUNC(function);
-		func->template[i] |= SYS_CFGCTRL_DEVICE(device);
-	}
-
-	vexpress_syscfg_regmap_config.max_register = num - 1;
-
-	func->regmap = regmap_init(dev, NULL, func,
-			&vexpress_syscfg_regmap_config);
-
-	if (IS_ERR(func->regmap)) {
-		void *err = func->regmap;
-
-		kfree(func);
-		return err;
-	}
-
-	list_add(&func->list, &syscfg->funcs);
-
-	return func->regmap;
-}
-
-static void vexpress_syscfg_regmap_exit(struct regmap *regmap, void *context)
-{
-	struct vexpress_syscfg *syscfg = context;
-	struct vexpress_syscfg_func *func, *tmp;
-
-	regmap_exit(regmap);
-
-	list_for_each_entry_safe(func, tmp, &syscfg->funcs, list) {
-		if (func->regmap == regmap) {
-			list_del(&syscfg->funcs);
-			kfree(func);
-			break;
-		}
-	}
-}
-
-static struct vexpress_config_bridge_ops vexpress_syscfg_bridge_ops = {
-	.regmap_init = vexpress_syscfg_regmap_init,
-	.regmap_exit = vexpress_syscfg_regmap_exit,
-};
-
-
-static int vexpress_syscfg_probe(struct platform_device *pdev)
-{
-	struct vexpress_syscfg *syscfg;
-	struct resource *res;
-	struct device *bridge;
-
-	syscfg = devm_kzalloc(&pdev->dev, sizeof(*syscfg), GFP_KERNEL);
-	if (!syscfg)
-		return -ENOMEM;
-	syscfg->dev = &pdev->dev;
-	INIT_LIST_HEAD(&syscfg->funcs);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	syscfg->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(syscfg->base))
-		return PTR_ERR(syscfg->base);
-
-	/* Must use dev.parent (MFD), as that's where DT phandle points at... */
-	bridge = vexpress_config_bridge_register(pdev->dev.parent,
-			&vexpress_syscfg_bridge_ops, syscfg);
-
-	return PTR_ERR_OR_ZERO(bridge);
-}
-
-static const struct platform_device_id vexpress_syscfg_id_table[] = {
-	{ "vexpress-syscfg", },
-	{},
-};
-
-static struct platform_driver vexpress_syscfg_driver = {
-	.driver.name = "vexpress-syscfg",
-	.id_table = vexpress_syscfg_id_table,
-	.probe = vexpress_syscfg_probe,
-};
-
-static int __init vexpress_syscfg_init(void)
-{
-	return platform_driver_register(&vexpress_syscfg_driver);
-}
-core_initcall(vexpress_syscfg_init);
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 2ec7992b054c..65096c792d57 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -18,23 +18,6 @@
 /* Config infrastructure */
 
 void vexpress_config_set_master(u32 site);
-u32 vexpress_config_get_master(void);
-
-void vexpress_config_lock(void *arg);
-void vexpress_config_unlock(void *arg);
-
-int vexpress_config_get_topo(struct device_node *node, u32 *site,
-		u32 *position, u32 *dcc);
-
-/* Config bridge API */
-
-struct vexpress_config_bridge_ops {
-	struct regmap * (*regmap_init)(struct device *dev, void *context);
-	void (*regmap_exit)(struct regmap *regmap, void *context);
-};
-
-struct device *vexpress_config_bridge_register(struct device *parent,
-		struct vexpress_config_bridge_ops *ops, void *context);
 
 /* Config regmap API */
 
-- 
2.20.1

