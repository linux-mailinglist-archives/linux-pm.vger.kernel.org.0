Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206A23FA64F
	for <lists+linux-pm@lfdr.de>; Sat, 28 Aug 2021 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhH1PCQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Aug 2021 11:02:16 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58342 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230088AbhH1PCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Aug 2021 11:02:14 -0400
X-UUID: 31be7a35ca1b4f56996fb77e88d43a9a-20210828
X-UUID: 31be7a35ca1b4f56996fb77e88d43a9a-20210828
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 181223088; Sat, 28 Aug 2021 23:01:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 28 Aug 2021 23:01:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 28 Aug 2021 23:01:18 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v14 3/3] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Date:   Sat, 28 Aug 2021 23:01:12 +0800
Message-ID: <1630162872-25452-4-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
References: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Hector.Yuan" <hector.yuan@mediatek.com>

Introduce cpufreq HW driver which can support
CPU frequency adjust in MT6779 platform.

Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
---
 drivers/cpufreq/Kconfig.arm           |   12 ++
 drivers/cpufreq/Makefile              |    1 +
 drivers/cpufreq/mediatek-cpufreq-hw.c |  319 +++++++++++++++++++++++++++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a5c5f70..954749a 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -133,6 +133,18 @@ config ARM_MEDIATEK_CPUFREQ
 	help
 	  This adds the CPUFreq driver support for MediaTek SoCs.
 
+config ARM_MEDIATEK_CPUFREQ_HW
+	tristate "MediaTek CPUFreq HW driver"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	default m
+	help
+	  Support for the CPUFreq HW driver.
+	  Some MediaTek chipsets have a HW engine to offload the steps
+	  necessary for changing the frequency of the CPUs. Firmware loaded
+	  in this engine exposes a programming interface to the OS.
+	  The driver implements the cpufreq interface for this HW engine.
+	  Say Y if you want to support CPUFreq HW.
+
 config ARM_OMAP2PLUS_CPUFREQ
 	bool "TI OMAP2+"
 	depends on ARCH_OMAP2PLUS
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 27d3bd7..48ee585 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+= imx-cpufreq-dt.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
+obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ_HW)	+= mediatek-cpufreq-hw.o
 obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
new file mode 100644
index 0000000..79862a5
--- /dev/null
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cpufreq.h>
+#include <linux/energy_model.h>
+#include <linux/init.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_qos.h>
+#include <linux/slab.h>
+
+#define LUT_MAX_ENTRIES			32U
+#define LUT_FREQ			GENMASK(11, 0)
+#define LUT_ROW_SIZE			0x4
+#define CPUFREQ_HW_STATUS		BIT(0)
+#define SVS_HW_STATUS			BIT(1)
+#define POLL_USEC			1000
+#define TIMEOUT_USEC			300000
+
+enum {
+	REG_FREQ_LUT_TABLE,
+	REG_FREQ_ENABLE,
+	REG_FREQ_PERF_STATE,
+	REG_FREQ_HW_STATE,
+	REG_EM_POWER_TBL,
+	REG_FREQ_LATENCY,
+
+	REG_ARRAY_SIZE,
+};
+
+struct mtk_cpufreq_data {
+	struct cpufreq_frequency_table *table;
+	void __iomem *reg_bases[REG_ARRAY_SIZE];
+	int nr_opp;
+};
+
+static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
+	[REG_FREQ_LUT_TABLE]	= 0x0,
+	[REG_FREQ_ENABLE]	= 0x84,
+	[REG_FREQ_PERF_STATE]	= 0x88,
+	[REG_FREQ_HW_STATE]	= 0x8c,
+	[REG_EM_POWER_TBL]	= 0x90,
+	[REG_FREQ_LATENCY]	= 0x110,
+};
+
+static int __maybe_unused
+mtk_cpufreq_get_cpu_power(unsigned long *mW,
+			  unsigned long *KHz, struct device *cpu_dev)
+{
+	struct mtk_cpufreq_data *data;
+	struct cpufreq_policy *policy;
+	int i;
+
+	policy = cpufreq_cpu_get_raw(cpu_dev->id);
+	if (!policy)
+		return 0;
+
+	data = policy->driver_data;
+
+	for (i = 0; i < data->nr_opp; i++) {
+		if (data->table[i].frequency < *KHz)
+			break;
+	}
+	i--;
+
+	*KHz = data->table[i].frequency;
+	*mW = readl_relaxed(data->reg_bases[REG_EM_POWER_TBL] +
+			    i * LUT_ROW_SIZE) / 1000;
+
+	return 0;
+}
+
+static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
+				       unsigned int index)
+{
+	struct mtk_cpufreq_data *data = policy->driver_data;
+
+	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
+
+	return 0;
+}
+
+static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
+{
+	struct mtk_cpufreq_data *data;
+	struct cpufreq_policy *policy;
+	unsigned int index;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return 0;
+
+	data = policy->driver_data;
+
+	index = readl_relaxed(data->reg_bases[REG_FREQ_PERF_STATE]);
+	index = min(index, LUT_MAX_ENTRIES - 1);
+
+	return data->table[index].frequency;
+}
+
+static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
+					       unsigned int target_freq)
+{
+	struct mtk_cpufreq_data *data = policy->driver_data;
+	unsigned int index;
+
+	index = cpufreq_table_find_index_dl(policy, target_freq);
+
+	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
+
+	return policy->freq_table[index].frequency;
+}
+
+static int mtk_cpu_create_freq_table(struct platform_device *pdev,
+				     struct mtk_cpufreq_data *data)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base_table;
+	u32 temp, i, freq, prev_freq = 0;
+
+	data->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
+				   sizeof(*data->table), GFP_KERNEL);
+	if (!data->table)
+		return -ENOMEM;
+
+	base_table = data->reg_bases[REG_FREQ_LUT_TABLE];
+
+	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+		temp = readl_relaxed(base_table + (i * LUT_ROW_SIZE));
+		freq = FIELD_GET(LUT_FREQ, temp) * 1000;
+
+		if (freq == prev_freq)
+			break;
+
+		data->table[i].frequency = freq;
+
+		dev_dbg(dev, "index=%d freq=%d\n", i, data->table[i].frequency);
+
+		prev_freq = freq;
+	}
+
+	data->table[i].frequency = CPUFREQ_TABLE_END;
+	data->nr_opp = i;
+
+	return 0;
+}
+
+static int mtk_cpu_resources_init(struct platform_device *pdev,
+				  struct cpufreq_policy *policy,
+				  const u16 *offsets)
+{
+	struct mtk_cpufreq_data *data;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int ret, i;
+	int index;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	index = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
+						   "#performance-domain-cells",
+						   policy->cpus);
+
+	base = devm_platform_ioremap_resource(pdev, index);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
+		data->reg_bases[i] = base + offsets[i];
+
+	ret = mtk_cpu_create_freq_table(pdev, data);
+	if (ret) {
+		dev_info(dev, "Domain-%d failed to create freq table\n", index);
+		return ret;
+	}
+
+	policy->freq_table = data->table;
+	policy->driver_data = data;
+
+	return 0;
+}
+
+static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
+{
+	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
+	struct platform_device *pdev = cpufreq_get_driver_data();
+	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
+	struct mtk_cpufreq_data *data;
+	struct device *cpu_dev;
+	unsigned int latency;
+	const u16 *offsets;
+	int ret;
+
+	offsets = of_device_get_match_data(&pdev->dev);
+	if (!offsets)
+		return -EINVAL;
+
+	/* Get the bases of cpufreq for domains */
+	ret = mtk_cpu_resources_init(pdev, policy, offsets);
+	if (ret) {
+		dev_info(&pdev->dev, "CPUFreq resource init failed\n");
+		return ret;
+	}
+
+	data = policy->driver_data;
+
+	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
+	if (!latency)
+		latency = CPUFREQ_ETERNAL;
+
+	/* us convert to ns */
+	policy->cpuinfo.transition_latency = latency;
+
+	policy->fast_switch_possible = true;
+
+	/* HW should be in enabled state to proceed now */
+	writel_relaxed(0x1, data->reg_bases[REG_FREQ_ENABLE]);
+	if (readl_poll_timeout(data->reg_bases[REG_FREQ_HW_STATE], sig,
+			       (sig & pwr_hw) == pwr_hw, POLL_USEC,
+			       TIMEOUT_USEC)) {
+		if (!(sig & CPUFREQ_HW_STATUS)) {
+			pr_info("cpufreq hardware of CPU%d is not enabled\n",
+				policy->cpu);
+			return -ENODEV;
+		}
+
+		pr_info("SVS of CPU%d is not enabled\n", policy->cpu);
+	}
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_info("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	em_dev_register_perf_domain(cpu_dev, data->nr_opp, &em_cb, policy->cpus,
+				    true);
+
+	return 0;
+}
+
+static int mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct mtk_cpufreq_data *data = policy->driver_data;
+	void __iomem *base;
+	int i;
+
+	/* HW should be in paused state now */
+	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
+
+	for (i = 0; i < REG_ARRAY_SIZE; i++) {
+		base = data->reg_bases[i];
+		iounmap(base);
+	}
+
+	kfree(data->table);
+	kfree(data);
+
+	return 0;
+}
+
+static struct cpufreq_driver cpufreq_mtk_hw_driver = {
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_IS_COOLING_DEV,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= mtk_cpufreq_hw_target_index,
+	.get		= mtk_cpufreq_hw_get,
+	.init		= mtk_cpufreq_hw_cpu_init,
+	.exit		= mtk_cpufreq_hw_cpu_exit,
+	.fast_switch	= mtk_cpufreq_hw_fast_switch,
+	.name		= "mtk-cpufreq-hw",
+	.attr		= cpufreq_generic_attr,
+};
+
+static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	cpufreq_mtk_hw_driver.driver_data = pdev;
+
+	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
+	if (ret)
+		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+
+	return ret;
+}
+
+static int mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
+{
+	return cpufreq_unregister_driver(&cpufreq_mtk_hw_driver);
+}
+
+static const struct of_device_id mtk_cpufreq_hw_match[] = {
+	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_offsets },
+	{}
+};
+
+static struct platform_driver mtk_cpufreq_hw_driver = {
+	.probe = mtk_cpufreq_hw_driver_probe,
+	.remove = mtk_cpufreq_hw_driver_remove,
+	.driver = {
+		.name = "mtk-cpufreq-hw",
+		.of_match_table = mtk_cpufreq_hw_match,
+	},
+};
+module_platform_driver(mtk_cpufreq_hw_driver);
+
+MODULE_AUTHOR("Hector Yuan <hector.yuan@mediatek.com>");
+MODULE_DESCRIPTION("Mediatek cpufreq-hw driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

