Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13502319F
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 12:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfETKrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 06:47:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:55392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732046AbfETKrm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 06:47:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B410AAFDD;
        Mon, 20 May 2019 10:47:40 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mbrugger@suse.de, sboyd@kernel.org, eric@anholt.net,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        ptesarik@suse.com, linux-rpi-kernel@lists.infradead.org,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 5/5] cpufreq: add driver for Raspbery Pi
Date:   Mon, 20 May 2019 12:47:07 +0200
Message-Id: <20190520104708.11980-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520104708.11980-1-nsaenzjulienne@suse.de>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Raspberry Pi's firmware offers and interface though which update it's
performance requirements. It allows us to request for specific runtime
frequencies, which the firmware might or might not respect, depending on
the firmware configuration and thermals.

As the maximum and minimum frequencies are configurable in the firmware
there is no way to know in advance their values. So the Raspberry Pi
cpufreq driver queries them, builds an opp frequency table to then
launch cpufreq-dt.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/cpufreq/Kconfig.arm           |  8 +++
 drivers/cpufreq/Makefile              |  1 +
 drivers/cpufreq/raspberrypi-cpufreq.c | 83 +++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/cpufreq/raspberrypi-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 179a1d302f48..f6eba7ae50d0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -308,3 +308,11 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
 	  If in doubt, say N.
+
+config ARM_RASPBERRYPI_CPUFREQ
+	tristate "Raspberry Pi cpufreq support"
+	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
+	help
+	  This adds the CPUFreq driver for Raspberry Pi
+
+	  If in doubt, say N.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c6f949..02678e9b2ff5 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
 obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
 
 
 ##################################################################################
diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspberrypi-cpufreq.c
new file mode 100644
index 000000000000..a85988867d56
--- /dev/null
+++ b/drivers/cpufreq/raspberrypi-cpufreq.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Raspberry Pi cpufreq driver
+ *
+ * Copyright (C) 2019, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/pm_opp.h>
+#include <linux/cpufreq.h>
+#include <linux/platform_device.h>
+
+static const struct of_device_id machines[] __initconst = {
+	{ .compatible = "raspberrypi,3-model-b-plus" },
+	{ .compatible = "raspberrypi,3-model-b" },
+	{ /* sentinel */ }
+};
+
+static int __init raspberrypi_cpufreq_driver_init(void)
+{
+	struct platform_device *pdev;
+	struct device *cpu_dev;
+	struct clk *clk;
+	long min, max;
+	long rate;
+	int ret;
+
+	if (!of_match_node(machines, of_root))
+		return -ENODEV;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("Cannot get CPU for cpufreq driver\n");
+		return -ENODEV;
+	}
+
+	clk = clk_get(cpu_dev, 0);
+	if (IS_ERR(clk)) {
+		dev_err(cpu_dev, "Cannot get clock for CPU0\n");
+		return PTR_ERR(clk);
+	}
+
+	/*
+	 * The max and min frequencies are configurable in the Raspberry Pi
+	 * firmware, so we query them at runtime
+	 */
+	min = clk_round_rate(clk, 0);
+	max = clk_round_rate(clk, ULONG_MAX);
+	clk_put(clk);
+
+	for (rate = min; rate < max; rate += 100000000) {
+		ret = dev_pm_opp_add(cpu_dev, rate, 0);
+		if (ret)
+			goto remove_opp;
+	}
+
+	ret = dev_pm_opp_add(cpu_dev, max, 0);
+	if (ret)
+		goto remove_opp;
+
+	pdev = platform_device_register_data(NULL, "cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (ret) {
+		dev_err(cpu_dev, "Failed to create platform device, %d\n", ret);
+		goto remove_opp;
+	}
+
+	return 0;
+
+remove_opp:
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
+
+	return ret;
+}
+
+late_initcall(raspberrypi_cpufreq_driver_init);
+
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
+MODULE_DESCRIPTION("Raspberry Pi cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

