Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680E911045
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 01:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEAXmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 19:42:21 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34620 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfEAXmV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 19:42:21 -0400
Received: by mail-it1-f196.google.com with SMTP id p18so4195621itm.1;
        Wed, 01 May 2019 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00VoYupkltIIZPHq0j4gOx9hJNR8372CM8lIROdA4bc=;
        b=r6PUDJpRjbcHYbtQbB4R82KvgyHeXkk9Wto6+ocWTHnY4RDC1sejzDiQJe+2QpGjQk
         O7AO0jaXsY8vmgRmYTYa0TPHG7CtnIfouikVIBHFwjSb9I0WyxpIhsyQ7W/9RmiCtcMw
         85drwVMQlOD5X8N8dtgiUWmwBjedqlItWbFxAOOQvDxM5efWEVxRG8/T+/jQU1/qQZ9E
         4FQVNEmZ5pA5i+mreP3BhCFSMhCZCYz5RcwYN3LK9ECpoLh0AadlXb50tXuV1ZnGdEyn
         ecYSK8Xc80T5Nm9y9cCtPZfPp5WjeqhFnuwfWQjLtn/zMEEfjWLk9Hd2jKekhE3FB+Ej
         R5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00VoYupkltIIZPHq0j4gOx9hJNR8372CM8lIROdA4bc=;
        b=VyhvE/G0duZuR71VZDixTp4bNQ+lEDlKNlj95R49Nl5g7NTs+AZOdLEqfpv0JuQD1E
         cUhhJlkmEJyOfq+i8KEI2YwUN21F3+V3agrVndg4+koFkDuXXJqVhBdL6Wpkx9A20toG
         nvHpWE0ehe+doMCSm51S42b6wtC1e1JhUr0EzO15ws0zDzqalC+NhN19TOEhnxHLYgS5
         fPwGkoTdl84oppHh/40PHrAPBRtc3PKBsO0dJvDgCx65IywVKS0h2tePW6YiRkExawBw
         ku8A6JCTroeqHFHzdOErADItGt5Ju7Sv528n91VwsGVpnCBK/bKHZfeW6p0IqhCH4i5L
         EHUQ==
X-Gm-Message-State: APjAAAWIrM9W35yHrrzfbnR1Z3IaYmPkPD8zuxhneXe3ON0Hb1Kh0ng9
        zrQb+GEGkVjXP99k3SJg/2c=
X-Google-Smtp-Source: APXvYqweRxMpxvQfc4b6wx4nGXWdtHgFvNtylAAY3DqjO33nX8gm4fXZClvO1lIErhNGoKKisWGH8Q==
X-Received: by 2002:a05:660c:12ce:: with SMTP id k14mr215145itd.23.1556754140432;
        Wed, 01 May 2019 16:42:20 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id m3sm2392507ion.69.2019.05.01.16.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:42:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/16] PM / devfreq: Introduce driver for NVIDIA Tegra20
Date:   Thu,  2 May 2019 02:38:15 +0300
Message-Id: <20190501233815.32643-17-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
References: <20190501233815.32643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
reads out Memory Controller counters and adjusts memory frequency based
on the memory clients activity.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS                       |   8 ++
 drivers/devfreq/Kconfig           |  10 ++
 drivers/devfreq/Makefile          |   1 +
 drivers/devfreq/tegra20-devfreq.c | 212 ++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 98edc38bfd7b..e7e434f74038 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10098,6 +10098,14 @@ F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
+MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/tegra20-devfreq.c
+
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index a6bba6e1e7d9..1530dbefa31f 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -100,6 +100,16 @@ config ARM_TEGRA_DEVFREQ
 	  It reads ACTMON counters of memory controllers and adjusts the
 	  operating frequencies and voltages with OPP support.
 
+config ARM_TEGRA20_DEVFREQ
+	tristate "NVIDIA Tegra20 DEVFREQ Driver"
+	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select PM_OPP
+	help
+	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
+	  It reads Memory Controller counters and adjusts the operating
+	  frequencies and voltages with OPP support.
+
 config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
 	depends on ARCH_ROCKCHIP
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 47e5aeeebfd1..338ae8440db6 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
+obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
new file mode 100644
index 000000000000..ff82bac9ee4e
--- /dev/null
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra20 devfreq driver
+ *
+ * Copyright (C) 2019 GRATE-DRIVER project
+ */
+
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#include <soc/tegra/mc.h>
+
+#include "governor.h"
+
+#define MC_STAT_CONTROL				0x90
+#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
+#define MC_STAT_EMC_CLOCKS			0xa4
+#define MC_STAT_EMC_CONTROL			0xa8
+#define MC_STAT_EMC_COUNT			0xb8
+
+#define EMC_GATHER_CLEAR			(1 << 8)
+#define EMC_GATHER_ENABLE			(3 << 8)
+
+struct tegra_devfreq {
+	struct devfreq *devfreq;
+	struct clk *emc_clock;
+	void __iomem *regs;
+};
+
+static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
+				u32 flags)
+{
+	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
+	struct devfreq *devfreq = tegra->devfreq;
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	int err;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	rate = dev_pm_opp_get_freq(opp);
+	dev_pm_opp_put(opp);
+
+	err = clk_set_min_rate(tegra->emc_clock, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(tegra->emc_clock, 0);
+	if (err)
+		goto restore_min_rate;
+
+	return 0;
+
+restore_min_rate:
+	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
+
+	return err;
+}
+
+static int tegra_devfreq_get_dev_status(struct device *dev,
+					struct devfreq_dev_status *stat)
+{
+	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
+
+	/*
+	 * EMC_COUNT returns number of memory events, that number is lower
+	 * than the number of clocks. Conversion ratio of 1/8 results in a
+	 * bit higher bandwidth than actually needed, it is good enough for
+	 * the time being because drivers don't support requesting minimum
+	 * needed memory bandwidth yet.
+	 *
+	 * TODO: adjust the ratio value once relevant drivers will support
+	 * memory bandwidth management.
+	 */
+	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
+	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
+	stat->current_frequency = clk_get_rate(tegra->emc_clock);
+
+	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
+	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
+
+	return 0;
+}
+
+static struct devfreq_dev_profile tegra_devfreq_profile = {
+	.polling_ms	= 500,
+	.target		= tegra_devfreq_target,
+	.get_dev_status	= tegra_devfreq_get_dev_status,
+};
+
+static struct tegra_mc *tegra_get_memory_controller(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct tegra_mc *mc;
+
+	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return mc;
+}
+
+static int tegra_devfreq_probe(struct platform_device *pdev)
+{
+	struct tegra_devfreq *tegra;
+	struct tegra_mc *mc;
+	unsigned long max_rate;
+	unsigned long rate;
+	int err;
+
+	mc = tegra_get_memory_controller();
+	if (IS_ERR(mc)) {
+		err = PTR_ERR(mc);
+		dev_err(&pdev->dev, "failed to get memory controller: %d\n",
+			err);
+		return err;
+	}
+
+	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
+	if (!tegra)
+		return -ENOMEM;
+
+	/* EMC is a system-critical clock that is always enabled */
+	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
+	if (IS_ERR(tegra->emc_clock)) {
+		err = PTR_ERR(tegra->emc_clock);
+		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
+		return err;
+	}
+
+	tegra->regs = mc->regs;
+
+	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
+
+	for (rate = 0; rate <= max_rate; rate++) {
+		rate = clk_round_rate(tegra->emc_clock, rate);
+
+		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+		if (err) {
+			dev_err(&pdev->dev, "failed to add opp: %d\n", err);
+			goto remove_opps;
+		}
+	}
+
+	/*
+	 * Reset statistic gathers state, select global bandwidth for the
+	 * statistics collection mode and set clocks counter saturation
+	 * limit to maximum.
+	 */
+	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
+	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
+	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);
+
+	platform_set_drvdata(pdev, tegra);
+
+	tegra->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
+					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
+	if (IS_ERR(tegra->devfreq)) {
+		err = PTR_ERR(tegra->devfreq);
+		goto remove_opps;
+	}
+
+	return 0;
+
+remove_opps:
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	return err;
+}
+
+static int tegra_devfreq_remove(struct platform_device *pdev)
+{
+	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
+
+	devfreq_remove_device(tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver tegra_devfreq_driver = {
+	.probe		= tegra_devfreq_probe,
+	.remove		= tegra_devfreq_remove,
+	.driver		= {
+		.name	= "tegra20-devfreq",
+	},
+};
+module_platform_driver(tegra_devfreq_driver);
+
+MODULE_ALIAS("platform:tegra20-devfreq");
+MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra20 devfreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

