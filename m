Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F110394D41
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhE2Qy0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 12:54:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229815AbhE2QyZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 12:54:25 -0400
X-UUID: ebe04b6d50be4222a2f9baa36f0cb1f5-20210530
X-UUID: ebe04b6d50be4222a2f9baa36f0cb1f5-20210530
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1247811430; Sun, 30 May 2021 00:52:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 00:52:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 May 2021 00:52:43 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, <hector.yuan@mediatek.com>
Subject: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Date:   Sun, 30 May 2021 00:52:32 +0800
Message-ID: <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Hector.Yuan" <hector.yuan@mediatek.com>

Add cpufreq HW support.

Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
---
 drivers/cpufreq/Kconfig.arm           |   12 ++
 drivers/cpufreq/Makefile              |    1 +
 drivers/cpufreq/mediatek-cpufreq-hw.c |  370 +++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
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
index 0000000..6f3a461
--- /dev/null
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -0,0 +1,370 @@
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
+struct cpufreq_mtk {
+	struct cpufreq_frequency_table *table;
+	void __iomem *reg_bases[REG_ARRAY_SIZE];
+	int nr_opp;
+	cpumask_t related_cpus;
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
+static struct cpufreq_mtk *mtk_freq_domain_map[NR_CPUS];
+
+static int __maybe_unused
+mtk_cpufreq_get_cpu_power(unsigned long *mW,
+			  unsigned long *KHz, struct device *cpu_dev)
+{
+	struct cpufreq_mtk *c = mtk_freq_domain_map[cpu_dev->id];
+	int i;
+
+	for (i = 0; i < c->nr_opp; i++) {
+		if (c->table[i].frequency < *KHz)
+			break;
+	}
+	i--;
+
+	*KHz = c->table[i].frequency;
+	*mW = readl_relaxed(c->reg_bases[REG_EM_POWER_TBL] +
+			    i * LUT_ROW_SIZE) / 1000;
+
+	return 0;
+}
+
+static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
+				       unsigned int index)
+{
+	struct cpufreq_mtk *c = policy->driver_data;
+
+	writel_relaxed(index, c->reg_bases[REG_FREQ_PERF_STATE]);
+
+	return 0;
+}
+
+static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
+{
+	struct cpufreq_mtk *c;
+	unsigned int index;
+
+	c = mtk_freq_domain_map[cpu];
+
+	index = readl_relaxed(c->reg_bases[REG_FREQ_PERF_STATE]);
+	index = min(index, LUT_MAX_ENTRIES - 1);
+
+	return c->table[index].frequency;
+}
+
+static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
+					       unsigned int target_freq)
+{
+	struct cpufreq_mtk *c = policy->driver_data;
+	unsigned int index;
+
+	index = cpufreq_table_find_index_dl(policy, target_freq);
+
+	writel_relaxed(index, c->reg_bases[REG_FREQ_PERF_STATE]);
+
+	return policy->freq_table[index].frequency;
+}
+
+static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_mtk *c;
+	struct device *cpu_dev;
+	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
+	struct pm_qos_request *qos_request;
+	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
+	unsigned int latency;
+
+	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
+	if (!qos_request)
+		return -ENOMEM;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	c = mtk_freq_domain_map[policy->cpu];
+	if (!c) {
+		pr_err("No scaling support for CPU%d\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	cpumask_copy(policy->cpus, &c->related_cpus);
+
+	policy->freq_table = c->table;
+	policy->driver_data = c;
+
+	latency = readl_relaxed(c->reg_bases[REG_FREQ_LATENCY]);
+	if (!latency)
+		latency = CPUFREQ_ETERNAL;
+
+	/* us convert to ns */
+	policy->cpuinfo.transition_latency = latency * 1000;
+
+	policy->fast_switch_possible = true;
+
+	/* Let CPUs leave idle-off state for SVS CPU initializing */
+	cpu_latency_qos_add_request(qos_request, 0);
+
+	/* HW should be in enabled state to proceed now */
+	writel_relaxed(0x1, c->reg_bases[REG_FREQ_ENABLE]);
+
+	if (readl_poll_timeout(c->reg_bases[REG_FREQ_HW_STATE], sig,
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
+	em_dev_register_perf_domain(cpu_dev, c->nr_opp, &em_cb, policy->cpus, true);
+
+	cpu_latency_qos_remove_request(qos_request);
+	kfree(qos_request);
+
+	return 0;
+}
+
+static int mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct cpufreq_mtk *c;
+
+	c = mtk_freq_domain_map[policy->cpu];
+	if (!c) {
+		pr_err("No scaling support for CPU%d\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	/* HW should be in paused state now */
+	writel_relaxed(0x0, c->reg_bases[REG_FREQ_ENABLE]);
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
+static int mtk_cpu_create_freq_table(struct platform_device *pdev,
+				     struct cpufreq_mtk *c)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base_table;
+	u32 data, i, freq, prev_freq = 0;
+
+	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
+				sizeof(*c->table), GFP_KERNEL);
+	if (!c->table)
+		return -ENOMEM;
+
+	base_table = c->reg_bases[REG_FREQ_LUT_TABLE];
+
+	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
+		data = readl_relaxed(base_table + (i * LUT_ROW_SIZE));
+		freq = FIELD_GET(LUT_FREQ, data) * 1000;
+
+		if (freq == prev_freq)
+			break;
+
+		c->table[i].frequency = freq;
+
+		dev_dbg(dev, "index=%d freq=%d\n",
+			i, c->table[i].frequency);
+
+		prev_freq = freq;
+	}
+
+	c->table[i].frequency = CPUFREQ_TABLE_END;
+	c->nr_opp = i;
+
+	return 0;
+}
+
+static int mtk_get_related_cpus(int index, struct cpufreq_mtk *c)
+{
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	int cpu, ret;
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np)
+			continue;
+
+		ret = of_parse_phandle_with_args(cpu_np, "performance-domains",
+						 "#performance-domain-cells", 0,
+						 &args);
+		of_node_put(cpu_np);
+		if (ret < 0)
+			continue;
+
+		if (index == args.args[0]) {
+			cpumask_set_cpu(cpu, &c->related_cpus);
+			mtk_freq_domain_map[cpu] = c;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_cpu_resources_init(struct platform_device *pdev,
+				  unsigned int cpu, int index,
+				  const u16 *offsets)
+{
+	struct cpufreq_mtk *c;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+	void __iomem *base;
+
+	if (mtk_freq_domain_map[cpu])
+		return 0;
+
+	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, index);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
+		c->reg_bases[i] = base + offsets[i];
+
+	ret = mtk_get_related_cpus(index, c);
+	if (ret) {
+		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
+		return ret;
+	}
+
+	ret = mtk_cpu_create_freq_table(pdev, c);
+	if (ret) {
+		dev_err(dev, "Domain-%d failed to create freq table\n", index);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
+{
+	struct device_node *cpu_np;
+	struct of_phandle_args args;
+	const u16 *offsets;
+	unsigned int cpu;
+	int ret;
+
+	offsets = of_device_get_match_data(&pdev->dev);
+	if (!offsets)
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		cpu_np = of_cpu_device_node_get(cpu);
+		if (!cpu_np) {
+			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
+				cpu);
+			return -ENODEV;
+		}
+
+		ret = of_parse_phandle_with_args(cpu_np, "performance-domains",
+						 "#performance-domain-cells", 0,
+						 &args);
+		if (ret < 0)
+			return ret;
+
+		/* Get the bases of cpufreq for domains */
+		ret = mtk_cpu_resources_init(pdev, cpu, args.args[0], offsets);
+		if (ret) {
+			dev_err(&pdev->dev, "CPUFreq resource init failed\n");
+			return ret;
+		}
+	}
+
+	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
+		return ret;
+	}
+
+	return 0;
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
+MODULE_DESCRIPTION("Mediatek cpufreq-hw driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

