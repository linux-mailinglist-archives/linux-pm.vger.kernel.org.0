Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0BC2EA88B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbhAEKXz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 05:23:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24786 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbhAEKXy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1609842234; x=1641378234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0blYauGVBsp1QYFpJOSrncBm8JMBg705SUx5SH8GbVo=;
  b=J37ucfWS6dEJVxtN1G4lMGgXqFl3FS8JWewVEC7nXZIHZMpzLhrqXtiA
   Fk5/JMT4mI0lVlAQzL+AkGwh10FHIvg0xaCJnFT/Zn2JSfCuCIyi2JP+o
   TWrOw8QwUdq3y0CjR4WATPLHxgX6lS8GGp/nTPGf4/msFuob4TbM/SzHd
   n0wnxmBcjspH29XBPbeAza1R/Bq8Ojt9R09ORGEA6b7wwdfT9qUFEXp/d
   SNcsszqZWAvBDIAKFPPeqUAUiCsYjhUXJin6jifLIWwL58Mx9DKlBkxoE
   QonqWeP5xC9VEdaF0hDVweNNkW2eAH7I7jTD5hN2m4NdYKxaID5O2YQ8p
   g==;
IronPort-SDR: E3GZ6pkwd8afqYlUOLBsya19RbjQgK9VnAAvK+VLeVKczhfSE/TgQPxibgEadQMeD8cDvZaki7
 abFbGbCxJZS40mZg3uzuviNxrw6s8toYh67jK1ZOAWfRve9HvBOYuh6w8To/aM+w6ohRbVQRMT
 DjIH3YwB/IjsIG2DFmW7n1u4iURIkE9IbefIrNUiCmMvMXEB5KjlXs0K2kVu0kWJ0LdHoeCZAx
 cn+vUjH0cryABpSy5+Pp0mzA/ONWW4cDCbPlFeZ+f9VQc6qPB3Bsqxfwqbpq7o+09VSdJdgRBx
 YWU=
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="104832079"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2021 03:22:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 03:22:38 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 5 Jan 2021 03:22:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] cpufreq: sama7g5: add cpufreq driver
Date:   Tue, 5 Jan 2021 12:22:26 +0200
Message-ID: <1609842147-8161-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
References: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Microchip SAMA7G5 devices supports runtime changes of CPU frequency.
This is doable by changing CPUPLL frequency along with MCK0 frequency.
Along with this CPU's regulator must be changed to accommodate new
frequencies.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/cpufreq/Kconfig.arm          |   9 +
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 drivers/cpufreq/sama7g5-cpufreq.c    | 371 +++++++++++++++++++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 drivers/cpufreq/sama7g5-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1f73fa75b1a0..22ebd7c988e8 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -261,6 +261,15 @@ config ARM_SA1100_CPUFREQ
 config ARM_SA1110_CPUFREQ
 	bool
 
+config ARM_SAMA7G5_CPUFREQ
+	bool "Microchip SAMA7G5 CPUFreq support"
+	depends on SOC_SAMA7G5
+	depends on COMMON_CLK
+	select PM_OPP
+	default y
+	help
+	  This adds the CPUFreq driver support for Microchip SAMA7G5 platforms.
+
 config ARM_SCMI_CPUFREQ
 	tristate "SCMI based CPUfreq driver"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f1b7e3dd6e5d..3900f3507f72 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
+obj-$(CONFIG_ARM_SAMA7G5_CPUFREQ)	+= sama7g5-cpufreq.o
 obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd2db0188cbb..61834e307236 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -153,6 +153,8 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "qcom,msm8974", },
 	{ .compatible = "qcom,msm8960", },
 
+	{ .compatible = "microchip,sama7g5", },
+
 	{ }
 };
 
diff --git a/drivers/cpufreq/sama7g5-cpufreq.c b/drivers/cpufreq/sama7g5-cpufreq.c
new file mode 100644
index 000000000000..f961758f4ac3
--- /dev/null
+++ b/drivers/cpufreq/sama7g5-cpufreq.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SAMA7G5 CPUFREQ driver.
+ *
+ * Copyright (C) 2020 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
+
+#define TOL (25000)
+
+/**
+ * struct sama7g5_cpufreq_info - sama7g5 CPUFreq driver data
+ * @cpu: CPU device
+ * @cpu: CPU clock
+ * @mck: master clock
+ * @reg: CPU regulator
+ */
+static struct sama7g5_cpufreq_info {
+	struct device *cpudev;
+	struct clk *cpuck;
+	struct clk *mck;
+	struct regulator *reg;
+} sama7g5_cpufreq;
+
+static int sama7g5_cpufreq_set_target(struct cpufreq_policy *policy,
+				      unsigned int index)
+{
+	struct cpufreq_frequency_table *freq_table = policy->freq_table;
+	struct clk *cpuck = policy->clk;
+	struct clk *mck = sama7g5_cpufreq.mck;
+	struct dev_pm_opp *opp;
+	long cur_cpuck_freq_hz, new_cpuck_freq_hz, mck_freq_hz;
+	long new_voltage, cur_voltage;
+	unsigned long tmp;
+	u32 cur_div, new_div, diff_div;
+	int ret;
+
+	cur_cpuck_freq_hz = clk_get_rate(cpuck);
+	mck_freq_hz = clk_get_rate(mck);
+	new_cpuck_freq_hz = freq_table[index].frequency * 1000;
+
+	cur_voltage = regulator_get_voltage(sama7g5_cpufreq.reg);
+	if (cur_voltage < 0) {
+		dev_err(sama7g5_cpufreq.cpudev, "Invalid voltage: %ld\n",
+			cur_voltage);
+		return cur_voltage;
+	}
+
+	opp = dev_pm_opp_find_freq_ceil(sama7g5_cpufreq.cpudev,
+					&new_cpuck_freq_hz);
+	if (IS_ERR(opp)) {
+		dev_err(sama7g5_cpufreq.cpudev, "Failed to find OPP for %lu\n",
+			new_cpuck_freq_hz);
+		return PTR_ERR(opp);
+	}
+	new_voltage = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+
+	/* Scale up volgage. */
+	if (cur_voltage < new_voltage) {
+		ret = regulator_set_voltage(sama7g5_cpufreq.reg, new_voltage,
+					    new_voltage + TOL);
+		if (ret) {
+			dev_err(sama7g5_cpufreq.cpudev,
+				"Failed to scale up voltage!\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * The relation b/w mck and cpuck is as follows:
+	 *
+	 *                         +--------------> cpuck
+	 *                         |
+	 *               +------+  |    +-----+
+	 *  cpupllck --> | pres |--+--> | div |---> mck
+	 *               +------+       +-----+
+	 *
+	 * So we need to do the changes as follows:
+	 *     1/ change mck to avoid its underclocking/overclocking
+	 *     2/ change the cpuck: this will lead to changing the cpupllck
+	 *        as well as changing the pres to accommodate cpuck requested
+	 *        frequency
+	 *     3/ change mck to preserve its initial frequency
+	 */
+
+	/* Scale up/down MCK. */
+	cur_div = DIV_ROUND_CLOSEST(cur_cpuck_freq_hz, mck_freq_hz);
+	new_div = DIV_ROUND_CLOSEST(new_cpuck_freq_hz, mck_freq_hz);
+	diff_div = abs(cur_div - new_div);
+
+	tmp = DIV_ROUND_CLOSEST_ULL(cur_cpuck_freq_hz, (cur_div + diff_div));
+	ret = clk_set_rate(mck, tmp);
+	if (ret) {
+		dev_err(sama7g5_cpufreq.cpudev,
+			"Failed to set - intermediary - MCK to %lu\n", tmp);
+		goto restore_regulator;
+	}
+
+	/* Set cpuck. */
+	ret = clk_set_rate(cpuck, new_cpuck_freq_hz);
+	if (ret) {
+		dev_err(sama7g5_cpufreq.cpudev,
+			"Failed to scale cpu clk frequency!\n");
+		goto restore_mck;
+	}
+
+	/* Scale down/up MCK. */
+	tmp = DIV_ROUND_CLOSEST_ULL(new_cpuck_freq_hz, new_div);
+	ret = clk_set_rate(mck, tmp);
+	if (ret) {
+		dev_err(sama7g5_cpufreq.cpudev,
+			"Failed to set - final - MCK to %lu\n", tmp);
+		goto restore_cpuck;
+	}
+
+	if (cur_voltage > new_voltage) {
+		ret = regulator_set_voltage(sama7g5_cpufreq.reg, new_voltage,
+					    new_voltage + TOL);
+		if (ret) {
+			dev_err(sama7g5_cpufreq.cpudev,
+				"Failed to scale down voltage!\n");
+			goto restore_cpuck;
+		}
+	}
+
+	return 0;
+
+restore_cpuck:
+	/* Scale up/down MCK. */
+	cur_div = DIV_ROUND_CLOSEST(new_cpuck_freq_hz, mck_freq_hz);
+	new_div = DIV_ROUND_CLOSEST(cur_cpuck_freq_hz, mck_freq_hz);
+	diff_div = abs(cur_div - new_div);
+
+	tmp = DIV_ROUND_CLOSEST_ULL(new_cpuck_freq_hz, (cur_div + diff_div));
+	clk_set_rate(mck, tmp);
+	/* Set cpuck. */
+	clk_set_rate(cpuck, cur_cpuck_freq_hz);
+restore_mck:
+	/* Scale down/up MCK. */
+	clk_set_rate(mck, mck_freq_hz);
+restore_regulator:
+	if (cur_voltage < new_voltage)
+		regulator_set_voltage(sama7g5_cpufreq.reg, cur_voltage,
+				      cur_voltage + TOL);
+
+	return ret;
+}
+
+static int sama7g5_cpufreq_drvinit(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *freq_table;
+	struct dev_pm_opp *opp;
+	unsigned long uV_min = INT_MIN, uV_max = 0;
+	unsigned long uV, freq_hz, latency;
+	int ret, i;
+
+	ret = dev_pm_opp_init_cpufreq_table(sama7g5_cpufreq.cpudev,
+					    &freq_table);
+	if (ret) {
+		dev_err(sama7g5_cpufreq.cpudev,
+			"Failed to init cpufreq table for cpu%d: %d\n",
+			policy->cpu, ret);
+		return ret;
+	}
+
+	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		freq_hz = freq_table[i].frequency * 1000;
+		opp = dev_pm_opp_find_freq_ceil(sama7g5_cpufreq.cpudev,
+						&freq_hz);
+		if (IS_ERR(opp))
+			continue;
+		uV = dev_pm_opp_get_voltage(opp);
+		dev_pm_opp_put(opp);
+
+		if (uV < uV_min)
+			uV_min = uV;
+		else if (uV > uV_max)
+			uV_max = uV;
+	}
+
+	if (uV_min == INT_MIN || !uV_max) {
+		dev_err(sama7g5_cpufreq.cpudev,
+			"Failed to locate min, max voltages for regulator\n");
+		dev_pm_opp_free_cpufreq_table(sama7g5_cpufreq.cpudev,
+					      &freq_table);
+		return -EINVAL;
+	}
+
+	latency = regulator_set_voltage_time(sama7g5_cpufreq.reg, uV_min,
+					     uV_max);
+	if (latency >= 0) {
+		latency *= 1000;
+		latency += dev_pm_opp_get_max_clock_latency(sama7g5_cpufreq.cpudev);
+		/* Measuements for regulator updates via i2c @1MHz. */
+		latency += 540 * 1000;
+	} else {
+		latency = 0;
+	}
+
+	if (!latency)
+		latency = CPUFREQ_ETERNAL;
+
+	policy->freq_table = freq_table;
+	policy->clk = sama7g5_cpufreq.cpuck;
+	policy->cpuinfo.transition_latency = latency;
+
+	return 0;
+}
+
+static int sama7g5_cpufreq_drvexit(struct cpufreq_policy *policy)
+{
+	dev_pm_opp_free_cpufreq_table(sama7g5_cpufreq.cpudev,
+				      &policy->freq_table);
+
+	return 0;
+}
+
+static struct cpufreq_driver sama7g5_cpufreq_driver = {
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = sama7g5_cpufreq_set_target,
+	.get = cpufreq_generic_get,
+	.init = sama7g5_cpufreq_drvinit,
+	.exit = sama7g5_cpufreq_drvexit,
+	.name = "sama7g5-cpufreq",
+	.attr = cpufreq_generic_attr,
+};
+
+static int sama7g5_cpufreq_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	sama7g5_cpufreq.cpudev = get_cpu_device(0);
+	if (!sama7g5_cpufreq.cpudev) {
+		dev_err(&pdev->dev, "Failed to get cpu0 device\n");
+		return -ENODEV;
+	}
+
+	sama7g5_cpufreq.cpuck = clk_get(sama7g5_cpufreq.cpudev, "cpu");
+	if (IS_ERR(sama7g5_cpufreq.cpuck)) {
+		ret = PTR_ERR(sama7g5_cpufreq.cpuck);
+		dev_err(&pdev->dev, "Failed to get cpu clock: %d\n", ret);
+		return ret;
+	}
+
+	sama7g5_cpufreq.mck = clk_get(sama7g5_cpufreq.cpudev, "mck");
+	if (IS_ERR(sama7g5_cpufreq.mck)) {
+		ret = PTR_ERR(sama7g5_cpufreq.mck);
+		dev_err(&pdev->dev, "Failed to get master clock: %d\n", ret);
+		goto free_resources;
+	}
+
+	sama7g5_cpufreq.reg = regulator_get(sama7g5_cpufreq.cpudev, "cpu");
+	if (IS_ERR(sama7g5_cpufreq.reg)) {
+		ret = PTR_ERR(sama7g5_cpufreq.reg);
+		dev_err(&pdev->dev, "Failed to get cpu regulator: %d\n", ret);
+		goto free_resources;
+	}
+
+	ret = clk_prepare_enable(sama7g5_cpufreq.cpuck);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable cpu clk: %d\n", ret);
+		goto free_resources;
+	}
+
+	ret = clk_prepare_enable(sama7g5_cpufreq.mck);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable MCK clk: %d\n", ret);
+		goto unprepare_cpuck;
+	}
+
+	ret = dev_pm_opp_of_add_table(sama7g5_cpufreq.cpudev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to init OPP table: %d\n", ret);
+		goto unprepare_mck;
+	}
+
+	ret = cpufreq_register_driver(&sama7g5_cpufreq_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register sama7g5-cpufreq driver: %d\n",
+			ret);
+		goto remove_table;
+	}
+
+	return 0;
+
+remove_table:
+	dev_pm_opp_of_remove_table(sama7g5_cpufreq.cpudev);
+unprepare_mck:
+	clk_disable_unprepare(sama7g5_cpufreq.mck);
+unprepare_cpuck:
+	clk_disable_unprepare(sama7g5_cpufreq.cpuck);
+free_resources:
+	if (!IS_ERR_OR_NULL(sama7g5_cpufreq.cpuck))
+		clk_put(sama7g5_cpufreq.cpuck);
+	if (!IS_ERR_OR_NULL(sama7g5_cpufreq.mck))
+		clk_put(sama7g5_cpufreq.mck);
+	if (!IS_ERR_OR_NULL(sama7g5_cpufreq.reg))
+		regulator_put(sama7g5_cpufreq.reg);
+
+	return ret;
+}
+
+static struct platform_driver sama7g5_cpufreq_platdrv = {
+	.driver = {
+		.name	= "sama7g5-cpufreq",
+	},
+	.probe		= sama7g5_cpufreq_probe,
+};
+
+static const struct of_device_id sama7g5_cpufreq_dt_ids[] __initconst = {
+	{ .compatible = "microchip,sama7g5", },
+	{ },
+};
+
+static int __init sama7g5_cpufreq_driver_init(void)
+{
+	const struct of_device_id *match;
+	struct platform_device *pdev;
+	struct device_node *np;
+	int ret;
+
+	np = of_find_node_by_path("/");
+	if (!np)
+		return -ENODEV;
+
+	match = of_match_node(sama7g5_cpufreq_dt_ids, np);
+	of_node_put(np);
+	if (!match) {
+		pr_err("Couldn't find sama7g5-cpufreq compatible machine\n");
+		ret = -ENODEV;
+		goto put_node;
+	}
+
+	ret = platform_driver_register(&sama7g5_cpufreq_platdrv);
+	if (ret)
+		goto put_node;
+
+	pdev = platform_device_register_simple("sama7g5-cpufreq", -1, NULL, 0);
+	if (IS_ERR_OR_NULL(pdev)) {
+		pr_err("failed to register sama7g5-cpufreq platform device\n");
+		ret = PTR_ERR(pdev);
+		goto driver_unregister;
+	}
+
+	return 0;
+
+driver_unregister:
+	platform_driver_unregister(&sama7g5_cpufreq_platdrv);
+put_node:
+	of_node_put(np);
+
+	return ret;
+}
+device_initcall(sama7g5_cpufreq_driver_init);
+
+MODULE_ALIAS("platform:sama7g5-cpufreq");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea@microchip.com>");
+MODULE_DESCRIPTION("Microchip SAMA7G5 CPUFreq driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

