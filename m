Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E616124D6D4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgHUOAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgHUOAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 10:00:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C09CC061573;
        Fri, 21 Aug 2020 07:00:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so2365239ejb.11;
        Fri, 21 Aug 2020 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOzTbuxhz01ec0FHvxjhTgrsLeXxnaxSQj60N4kzxmU=;
        b=suFRImbGuCdDd8M7GsBJWgbr2BJ4tbwwknXQx6EeMenUXKRX91YRIBiclvdzfs+IdW
         PWpSldu3O2F9/ys9IPGzIPxCSB33+Qv4M//mMspbDe49MpSQlDyTxuPZnWAtXOWzeejk
         RalOtMVqQigY/vxYCM2FlbjIkhBNEz0DMQDCFNK23hvWYnZjjJaYVOIK/gw+uYRJy4pT
         yMWsUol3cMsxPdPig+hHvJ/qs8EiEX3+0iawia/83k9FaiANZ0Q3aHhnZphzKAzIwzaQ
         8K3E77lO7KYULivQ2i6XWMRJoKuWqXxTi8dvOF21IGICIsyGczu4nHiZxGzdnIqT0VCT
         +b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOzTbuxhz01ec0FHvxjhTgrsLeXxnaxSQj60N4kzxmU=;
        b=ENXDL0gy2dV0sio43LuetQtbUthK/Ou+MRCB8DHS6RPRJeDsgHi/cAeVrJhjSMvzMy
         CW1I05PMuGiRQhFFJ+RLl43rpli1+DbhiVr13dP9B5AAr+0IoGvyo/lZgp+ETwdfkaOt
         UTY2oxfO1PlG+NutjEn7i5AD+k5RnpGs7phEO8L8MXrS5SUA3ikMdlsZwOUVNn+TttN7
         uI5d8MoOer3rLcVMcsgqoBS3jkkz6+Y1Lnd7vv6YGLbenfXlR+jG14zdcvaQS1WWyrnu
         Y/ADLf1loifrLZE1TnC86sdZ+Jz9FkO0TgN8fxPvON21m3BzCU0InFKOHmVlwvDxcN9T
         9HKw==
X-Gm-Message-State: AOAM530lZu3sdFIYb1KiNIYBOPTXqeYEFHN99lLCm0foKSvCgJSwQl8w
        xwHdjKsA3GENaiXz/iGjfcY=
X-Google-Smtp-Source: ABdhPJzQAAOjSWV81PFf97gqBSgjnqxmlqmojOErkHKasq710GNkFvX6TojY269E2Mi1yAzbuVeNNw==
X-Received: by 2002:a17:906:ce59:: with SMTP id se25mr3046802ejb.359.1598018440511;
        Fri, 21 Aug 2020 07:00:40 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-10-16-66.retail.telecomitalia.it. [87.10.16.66])
        by smtp.googlemail.com with ESMTPSA id c7sm1152969edf.1.2020.08.21.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:00:39 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/2] cpufreq: qcom: Add Krait Cache Scaling support
Date:   Fri, 21 Aug 2020 16:00:20 +0200
Message-Id: <20200821140026.19643-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200821140026.19643-1-ansuelsmth@gmail.com>
References: <20200821140026.19643-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qcom Krait CPUs use the generic cpufreq-dt driver and doesn't actually
scale the Cache frequency when the CPU frequency is changed. This
companion driver register with the cpu notifier and scale the Cache
based on the max Freq across all core as the CPU cache is shared across
all of them. If provided this also scale the voltage of the regulator
attached to the CPU cache. The scaling logic is based on the CPU freq
and the 3 scaling interval are set by the device dts.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/cpufreq/Kconfig.arm   |   9 ++
 drivers/cpufreq/Makefile      |   1 +
 drivers/cpufreq/krait-cache.c | 232 ++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/cpufreq/krait-cache.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index c6cbfc8baf72..4ed5e73051df 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -126,6 +126,15 @@ config ARM_OMAP2PLUS_CPUFREQ
 	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 
+config ARM_QCOM_KRAIT_CACHE_SCALE
+	tristate "Scaling support for Krait CPU Cache"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This adds the Scaling support for the Krait CPU Cache shared by
+	  all cores.
+
+	  If in doubt, say N.
+
 config ARM_QCOM_CPUFREQ_NVMEM
 	tristate "Qualcomm nvmem based CPUFreq"
 	depends on ARCH_QCOM
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f6670c4abbb0..eee53d7e8b09 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
+obj-$(CONFIG_ARM_QCOM_KRAIT_CACHE_SCALE) += krait-cache.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
 obj-$(CONFIG_ARM_QCOM_CPUFREQ_NVMEM)	+= qcom-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_RASPBERRYPI_CPUFREQ) 	+= raspberrypi-cpufreq.o
diff --git a/drivers/cpufreq/krait-cache.c b/drivers/cpufreq/krait-cache.c
new file mode 100644
index 000000000000..0646fde9d920
--- /dev/null
+++ b/drivers/cpufreq/krait-cache.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_opp.h>
+
+struct krait_data {
+	struct device *dev;
+
+	unsigned int *l2_rates; /* L2 bus clock rate */
+	unsigned int *l2_cpufreq; /* L2 target CPU frequency */
+
+	struct notifier_block nb;
+};
+
+static int krait_cache_set_opp(struct dev_pm_set_opp_data *data)
+{
+	unsigned long old_freq = data->old_opp.rate, freq = data->new_opp.rate;
+	struct dev_pm_opp_supply *supply = &data->new_opp.supplies[0];
+	struct regulator *reg = data->regulators[0];
+	struct clk *clk = data->clk;
+	struct krait_data *kdata;
+	unsigned long idle_freq;
+	int ret;
+
+	kdata = (struct krait_data *)dev_get_drvdata(data->dev);
+
+	idle_freq = kdata->l2_rates[0];
+
+	ret = regulator_set_voltage_triplet(reg, supply->u_volt_min,
+					    supply->u_volt, supply->u_volt_max);
+	if (ret)
+		goto exit;
+
+	/*
+	 * Set to idle bin if switching from normal to high bin
+	 * or vice versa. It has been notice that a bug is triggered
+	 * in cache scaling when more than one bin is scaled, to fix
+	 * this we first need to transition to the base rate and then
+	 * to target rate
+	 */
+	if (likely(freq != idle_freq && old_freq != idle_freq)) {
+		ret = clk_set_rate(clk, idle_freq);
+		if (ret)
+			goto exit;
+	}
+
+	ret = clk_set_rate(clk, freq);
+	if (ret)
+		goto exit;
+
+exit:
+	return ret;
+}
+
+static int krait_cache_notifier(struct notifier_block *nb, unsigned long cmd,
+				void *v)
+{
+	unsigned int target_freq, cpu, cur_cpu;
+	unsigned int *freq_tbl, *freq_l2tbl;
+	struct cpufreq_freqs *freqs;
+	struct krait_data *data;
+	int ret = 0;
+
+	if (cmd == CPUFREQ_PRECHANGE) {
+		freqs = (struct cpufreq_freqs *)v;
+		target_freq = freqs->new;
+		cur_cpu = freqs->policy->cpu;
+
+		data = container_of(nb, struct krait_data, nb);
+
+		freq_tbl = data->l2_cpufreq;
+		freq_l2tbl = data->l2_rates;
+
+		/* find the max freq across all core */
+		for_each_present_cpu(cpu)
+			if (cpu != cur_cpu)
+				target_freq = max(target_freq,
+						  cpufreq_quick_get(cpu));
+
+		while (*(freq_tbl = freq_tbl + 1) && target_freq >= *freq_tbl)
+			freq_l2tbl = freq_l2tbl + 1;
+
+		ret = dev_pm_opp_set_rate(data->dev, *freq_l2tbl);
+		if (ret)
+			goto exit;
+	}
+
+exit:
+	return notifier_from_errno(ret);
+}
+
+static int krait_cache_probe(struct platform_device *pdev)
+{
+	struct clk *l2_clk;
+	int ret, i = 0, count;
+	unsigned long freq = 0;
+	struct dev_pm_opp *opp;
+	struct opp_table *table;
+	struct device_node *vdd;
+	struct krait_data *data;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+
+	l2_clk = devm_clk_get(dev, "l2");
+	if (IS_ERR(l2_clk)) {
+		ret = PTR_ERR(l2_clk);
+		goto exit;
+	}
+
+	vdd = of_parse_phandle(node, "l2-supply", 0);
+	if (!vdd) {
+		dev_err(dev, "missing L2 supply\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	table = dev_pm_opp_set_regulators(dev, (const char *[]){ vdd->name },
+					  1);
+	if (IS_ERR(table)) {
+		ret = PTR_ERR(table);
+		dev_err(dev, "failed to set regulators %d\n", ret);
+		goto exit_vdd;
+	}
+
+	dev_pm_opp_put(opp);
+
+	ret = PTR_ERR_OR_ZERO(
+		dev_pm_opp_register_set_opp_helper(dev, krait_cache_set_opp));
+	if (ret)
+		goto exit_vdd;
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret) {
+		dev_err(dev, "failed to parse L2 freq thresholds\n");
+		goto exit_vdd;
+	}
+
+	count = dev_pm_opp_get_opp_count(dev);
+
+	data->l2_cpufreq =
+		devm_kzalloc(dev, sizeof(unsigned int) * count, GFP_KERNEL);
+	if (!data->l2_cpufreq) {
+		ret = -ENOMEM;
+		goto exit_vdd;
+	}
+
+	ret = of_property_read_u32_array(node, "l2-cpufreq", data->l2_cpufreq,
+					 count);
+	if (ret) {
+		dev_err(dev, "failed to parse L2 cpufreq thresholds\n");
+		goto exit_vdd;
+	}
+
+	/* Allocate space for opp_count + 1, the last index is used as sentinel */
+	data->l2_rates =
+		devm_kzalloc(dev, sizeof(unsigned int) * count + 1, GFP_KERNEL);
+	if (!data->l2_rates) {
+		ret = -ENOMEM;
+		goto exit_vdd;
+	}
+
+	/* populate the table in increasing order */
+	while (!IS_ERR(opp = dev_pm_opp_find_freq_ceil(dev, &freq))) {
+		data->l2_rates[i] = freq;
+		freq++;
+		i++;
+		dev_pm_opp_put(opp);
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	data->nb.notifier_call = krait_cache_notifier;
+	cpufreq_register_notifier(&data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+
+exit_vdd:
+	of_node_put(vdd);
+exit:
+	return ret;
+}
+
+static int krait_cache_remove(struct platform_device *pdev)
+{
+	struct krait_data *data = platform_get_drvdata(pdev);
+
+	dev_pm_opp_remove_table(data->dev);
+	cpufreq_unregister_notifier(&data->nb, CPUFREQ_TRANSITION_NOTIFIER);
+
+	return 0;
+}
+
+static const struct of_device_id krait_cache_match_table[] = {
+	{ .compatible = "qcom,krait-cache" },
+	{}
+};
+
+static struct platform_driver krait_cache_driver = {
+	.probe		= krait_cache_probe,
+	.remove		= krait_cache_remove,
+	.driver		= {
+		.name   = "krait-cache-scaling",
+		.of_match_table = krait_cache_match_table,
+	},
+};
+
+static int __init krait_cache_init(void)
+{
+	return platform_driver_register(&krait_cache_driver);
+}
+late_initcall(krait_cache_init);
+
+static void __exit krait_cache_exit(void)
+{
+	platform_driver_unregister(&krait_cache_driver);
+}
+module_exit(krait_cache_exit);
+
+MODULE_DESCRIPTION("Krait CPU Cache Scaling driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

