Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3162242C3B
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405794AbfFLQ2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 12:28:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42204 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfFLQ2a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 12:28:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id go2so6825230plb.9;
        Wed, 12 Jun 2019 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdp9jb1iQbG9Kova7Br2RxvqbYmrw8HsNZzWEL/RCVM=;
        b=VRsETXQw0bWXNVCmgx5Iz+z/LyvoTcg++/ZugoE1IPV9qjSkR0zp5qfcNouPYRyTJr
         UYz6SFS9oOeWmDBQaicPzbJt3fyWqoggNt6i0nDgXuYhJnVVQoqVtHryOS5sHTX4xNvR
         7itdQJrTB/Ccwu1EhfDnzp9dgfSBoFHxctL+onv2sxEh0r04QBchyI6KbJ4RZRPxt42d
         8X2FM2yAOAG1nuHJ5WKQACwJ/XHge5d7JdEAFcdCwWX/bSf3N6TiXvEwv6/VohM6bZJ+
         Gj3JCvDB9pklX+vfZuVMhw03BNLbX0ZXGzoeauZhwN1DS6u1NSoUN0Kn8WcAWOzOkvuR
         AhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdp9jb1iQbG9Kova7Br2RxvqbYmrw8HsNZzWEL/RCVM=;
        b=ocdjptfu1lCa8GV4c6WNkoU1C8/SiyqKxfS02fp+fHGAte12u//lR+wRPBq99w7BdJ
         yRJIqCbOfOk4P5+K1v/JFF6BZpNX0jMB+0awY7bxpHYZK2I1Pml7SOY2/nLF5eahQhiX
         CAB9KN6fShpfgb0DdBQ4bP2BitRPUJxqd3CRgNkDqtpLJeWi6+cBoiGL795gviwcGFcG
         P3nhUln2/Lhu4jHiQPm0J4Jg7+OPV1L5ukxtkW8Opl96S9CrCmSW7ge9S/25znoZTbUZ
         Rs/Yy8y4DL5zP0Sw/QU9VvtQgk/NAGYjs8N3axH5FkSFOVbIftjVbqWOanyC+D8wRBZC
         hIJg==
X-Gm-Message-State: APjAAAX0U1lmOzuMq0ccV5yWQFe/m8a/CZUWs7Q8HQrhAlvtnqAc0K3A
        2mdSrK3jZYpPPGyDHBYT9+o=
X-Google-Smtp-Source: APXvYqymuXsDqJJ5nR5lkIk+0FhI6kdWHd4u85U7lbbkQ80kuJUREetb3d6f1riQEThcuJHoMGuv7Q==
X-Received: by 2002:a17:902:7448:: with SMTP id e8mr72691415plt.222.1560356909521;
        Wed, 12 Jun 2019 09:28:29 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 144sm37259pfa.180.2019.06.12.09.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 09:28:28 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND, PATCH v4 1/2] cpufreq: Add sun50i nvmem based CPU scaling driver
Date:   Wed, 12 Jun 2019 12:28:15 -0400
Message-Id: <20190612162816.31713-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190612162816.31713-1-tiny.windzz@gmail.com>
References: <20190612162816.31713-1-tiny.windzz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For some SoCs, the CPU frequency subset and voltage value of each OPP
varies based on the silicon variant in use. The sun50i-cpufreq-nvmem
driver reads the efuse value from the SoC to provide the OPP framework
with required information.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 MAINTAINERS                            |   7 +
 drivers/cpufreq/Kconfig.arm            |  12 ++
 drivers/cpufreq/Makefile               |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c   |   2 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 226 +++++++++++++++++++++++++
 5 files changed, 248 insertions(+)
 create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..c57f869af9d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -668,6 +668,13 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALLWINNER CPUFREQ DRIVER
+M:	Yangtao Li <tiny.windzz@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
+F:	drivers/cpufreq/sun50i-cpufreq-nvmem.c
+
 ALLWINNER SECURITY SYSTEM
 M:	Corentin Labbe <clabbe.montjoie@gmail.com>
 L:	linux-crypto@vger.kernel.org
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index f8129edc145e..5796ecf13d7f 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -19,6 +19,18 @@ config ACPI_CPPC_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
+	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
+	depends on ARCH_SUNXI
+	depends on NVMEM_SUNXI_SID
+	select PM_OPP
+	help
+	  This adds the nvmem based CPUFreq driver for Allwinner
+	  h6 SoC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sun50i-cpufreq-nvmem.
+
 config ARM_ARMADA_37XX_CPUFREQ
 	tristate "Armada 37xx CPUFreq support"
 	depends on ARCH_MVEBU && CPUFREQ_DT
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c6f949..a78b8da80383 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
+obj-$(CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 47729a22c159..50e7810f3a28 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -105,6 +105,8 @@ static const struct of_device_id whitelist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blacklist[] __initconst = {
+	{ .compatible = "allwinner,sun50i-h6", },
+
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
 
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
new file mode 100644
index 000000000000..eca32e443716
--- /dev/null
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner CPUFreq nvmem based driver
+ *
+ * The sun50i-cpufreq-nvmem driver reads the efuse value from the SoC to
+ * provide the OPP framework with required information.
+ *
+ * Copyright (C) 2019 Yangtao Li <tiny.windzz@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define MAX_NAME_LEN	7
+
+#define NVMEM_MASK	0x7
+#define NVMEM_SHIFT	5
+
+static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
+
+/**
+ * sun50i_cpufreq_get_efuse() - Parse and return efuse value present on SoC
+ * @versions: Set to the value parsed from efuse
+ *
+ * Returns 0 if success.
+ */
+static int sun50i_cpufreq_get_efuse(u32 *versions)
+{
+	struct nvmem_cell *speedbin_nvmem;
+	struct device_node *np;
+	struct device *cpu_dev;
+	u32 *speedbin, efuse_value;
+	size_t len;
+	int ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	if (!np)
+		return -ENOENT;
+
+	ret = of_device_is_compatible(np,
+				      "allwinner,sun50i-h6-operating-points");
+	if (!ret) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+
+	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+	of_node_put(np);
+	if (IS_ERR(speedbin_nvmem)) {
+		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
+			pr_err("Could not get nvmem cell: %ld\n",
+			       PTR_ERR(speedbin_nvmem));
+		return PTR_ERR(speedbin_nvmem);
+	}
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	nvmem_cell_put(speedbin_nvmem);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
+	switch (efuse_value) {
+	case 0b0001:
+		*versions = 1;
+		break;
+	case 0b0011:
+		*versions = 2;
+		break;
+	default:
+		/*
+		 * For other situations, we treat it as bin0.
+		 * This vf table can be run for any good cpu.
+		 */
+		*versions = 0;
+		break;
+	}
+
+	kfree(speedbin);
+	return 0;
+};
+
+static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
+{
+	struct opp_table **opp_tables;
+	char name[MAX_NAME_LEN];
+	unsigned int cpu;
+	u32 speed = 0;
+	int ret;
+
+	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
+			     GFP_KERNEL);
+	if (!opp_tables)
+		return -ENOMEM;
+
+	ret = sun50i_cpufreq_get_efuse(&speed);
+	if (ret)
+		return ret;
+
+	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
+
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev = get_cpu_device(cpu);
+
+		if (!cpu_dev) {
+			ret = -ENODEV;
+			goto free_opp;
+		}
+
+		opp_tables[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
+		if (IS_ERR(opp_tables[cpu])) {
+			ret = PTR_ERR(opp_tables[cpu]);
+			pr_err("Failed to set prop name\n");
+			goto free_opp;
+		}
+	}
+
+	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
+							  NULL, 0);
+	if (!IS_ERR(cpufreq_dt_pdev)) {
+		platform_set_drvdata(pdev, opp_tables);
+		return 0;
+	}
+
+	ret = PTR_ERR(cpufreq_dt_pdev);
+	pr_err("Failed to register platform device\n");
+
+free_opp:
+	for_each_possible_cpu(cpu) {
+		if (IS_ERR_OR_NULL(opp_tables[cpu]))
+			break;
+		dev_pm_opp_put_prop_name(opp_tables[cpu]);
+	}
+	kfree(opp_tables);
+
+	return ret;
+}
+
+static int sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
+{
+	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	unsigned int cpu;
+
+	platform_device_unregister(cpufreq_dt_pdev);
+
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_put_prop_name(opp_tables[cpu]);
+
+	kfree(opp_tables);
+
+	return 0;
+}
+
+static struct platform_driver sun50i_cpufreq_driver = {
+	.probe = sun50i_cpufreq_nvmem_probe,
+	.remove = sun50i_cpufreq_nvmem_remove,
+	.driver = {
+		.name = "sun50i-cpufreq-nvmem",
+	},
+};
+
+static const struct of_device_id sun50i_cpufreq_match_list[] = {
+	{ .compatible = "allwinner,sun50i-h6" },
+	{}
+};
+
+static const struct of_device_id *sun50i_cpufreq_match_node(void)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(sun50i_cpufreq_match_list, np);
+	of_node_put(np);
+
+	return match;
+}
+
+/*
+ * Since the driver depends on nvmem drivers, which may return EPROBE_DEFER,
+ * all the real activity is done in the probe, which may be defered as well.
+ * The init here is only registering the driver and the platform device.
+ */
+static int __init sun50i_cpufreq_init(void)
+{
+	const struct of_device_id *match;
+	int ret;
+
+	match = sun50i_cpufreq_match_node();
+	if (!match)
+		return -ENODEV;
+
+	ret = platform_driver_register(&sun50i_cpufreq_driver);
+	if (unlikely(ret < 0))
+		return ret;
+
+	sun50i_cpufreq_pdev =
+		platform_device_register_simple("sun50i-cpufreq-nvmem",
+						-1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(sun50i_cpufreq_pdev);
+	if (ret == 0)
+		return 0;
+
+	platform_driver_unregister(&sun50i_cpufreq_driver);
+	return ret;
+}
+module_init(sun50i_cpufreq_init);
+
+static void __exit sun50i_cpufreq_exit(void)
+{
+	platform_device_unregister(sun50i_cpufreq_pdev);
+	platform_driver_unregister(&sun50i_cpufreq_driver);
+}
+module_exit(sun50i_cpufreq_exit);
+
+MODULE_DESCRIPTION("Sun50i-h6 cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0

