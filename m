Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939C227A1BC
	for <lists+linux-pm@lfdr.de>; Sun, 27 Sep 2020 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0QFb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgI0QFa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 12:05:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C70C0613CE;
        Sun, 27 Sep 2020 09:05:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so9058478wrm.9;
        Sun, 27 Sep 2020 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+uCd2aiJyKL53Ba6K8/jHRIihife9CKta06WZ74uh4=;
        b=U8BnWowAstPhKcGbTDc0BfZ2FoJ3VKHuqwWRKVBHd1ycV7Z7KCUDWkv+Nt6DsbjK3t
         NsMB2r0aOIZA6v/tVxXGrId3yWqCvoCZx5LY5L7zGcThMO9E2tocBVG1FUw/E8ZmDAoG
         HRf56NOcgOvJTW4MlYsmWoGCsPB4YSjAjkH9eLsLwErkFg3zWEUOGW9wqiVMPAva6a6n
         yfHCXdXLXwPTNZtMK7q1qUKYtndUU4GlZeot4vdKPrIHj8yFa7ojpgLdvQ1Gv5az+yQo
         +FBPNpR1nZD0ig+jsRbHn4jvPsfH3dPB8aLY4ICW9ov741vQfJQ7aLhDVU3IIhb8DJKW
         p6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+uCd2aiJyKL53Ba6K8/jHRIihife9CKta06WZ74uh4=;
        b=fJzkGk6XmjubeVKbVX0BRjia+iM14nKV1T7W66ZY8++8wfAvLyiOmjWFPJBD9vGDsJ
         VTH2Zc1kLU9JtiUpHunns4ZzebchYkELxitRMgaLdcy2E7HU9pOKqnZwq2e9lVrCHAXL
         QUok5p58VLNl1fOJQSyJk2+QQVxJVElYSIUUNT2KvqnJVpJ20wQE3spsL3cbnJ5cHSo7
         v48EJ/bH6oxL5WkAjW3KiETfbHkTgl9AEE5WhcEuQ8HvFbbiY28SQUF6+y9UrFLlz+n3
         E5pKIcBrjyW0OmuBNlGdMasWLR1bpvzj2NREXyHrGsYJo8MsOskzZAZaW6LFICEfpjnT
         nl9A==
X-Gm-Message-State: AOAM531E1jIi8lExBwyYoCURzIc2fDLDrX8UaUagDD3AU7r9I0aplG6h
        vTVs4RBiDVWUySl4CEMY0aPaGLii9wg=
X-Google-Smtp-Source: ABdhPJx+SNUlOVjlsz5PPRc9XN1WRD0+XFJxcTgoiCDrTgEVG3YFpiS4NcmXY4Kw+WRpFXQCaGueig==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr14470331wrs.36.1601222728743;
        Sun, 27 Sep 2020 09:05:28 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (93-39-149-95.ip76.fastwebnet.it. [93.39.149.95])
        by smtp.googlemail.com with ESMTPSA id n4sm5677659wmc.48.2020.09.27.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 09:05:27 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] devfreq: qcom: Add L2 Krait Cache devfreq scaling driver
Date:   Sun, 27 Sep 2020 18:05:12 +0200
Message-Id: <20200927160515.6480-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qcom L2 Krait CPUs use the generic cpufreq-dt driver and doesn't actually
scale the Cache frequency when the CPU frequency is changed. This
devfreq driver register with the cpu notifier and scale the Cache
based on the max Freq across all core as the CPU cache is shared across
all of them. If provided this also scale the voltage of the regulator
attached to the CPU cache. The scaling logic is based on the CPU freq
and the 3 scaling interval are set by the device dts.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/devfreq/Kconfig               |  10 +
 drivers/devfreq/Makefile              |   1 +
 drivers/devfreq/krait-cache-devfreq.c | 298 ++++++++++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 drivers/devfreq/krait-cache-devfreq.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 37dc40d1fcfb..99051aaf9c5e 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -143,6 +143,16 @@ config ARM_RK3399_DMC_DEVFREQ
 	  It sets the frequency for the memory controller and reads the usage counts
 	  from hardware.
 
+config ARM_KRAIT_CACHE_DEVFREQ
+	tristate "Scaling support for Krait CPU Cache Devfreq"
+	depends on ARCH_QCOM || COMPILE_TEST
+	help
+	  This adds the DEVFREQ driver for the Krait CPU L2 Cache shared by all cores.
+
+	  The driver register with the cpufreq notifier and find the right frequency
+	  based on the max frequency across all core and the range set in the device
+	  dts. If provided this scale also the regulator attached to the l2 cache.
+
 source "drivers/devfreq/event/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 3ca1ad0ecb97..bb87925a6a2d 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
 obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
+obj-$(CONFIG_ARM_KRAIT_CACHE_DEVFREQ)	+= krait-cache-devfreq.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/krait-cache-devfreq.c b/drivers/devfreq/krait-cache-devfreq.c
new file mode 100644
index 000000000000..4a82e45e2aac
--- /dev/null
+++ b/drivers/devfreq/krait-cache-devfreq.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/cpufreq.h>
+#include <linux/devfreq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_opp.h>
+
+#include "governor.h"
+
+struct krait_data {
+	struct device *dev;
+	struct devfreq *devfreq;
+
+	struct clk *l2_clk;
+
+	unsigned long *freq_table; /* L2 bus clock rate */
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
+	idle_freq = kdata->freq_table[0];
+
+	if (reg) {
+		ret = regulator_set_voltage_triplet(reg, supply->u_volt_min,
+						    supply->u_volt,
+						    supply->u_volt_max);
+		if (ret)
+			goto exit;
+	}
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
+};
+
+static int krait_cache_target(struct device *dev, unsigned long *freq,
+			      u32 flags)
+{
+	return dev_pm_opp_set_rate(dev, *freq);
+};
+
+static int krait_cache_get_dev_status(struct device *dev,
+				      struct devfreq_dev_status *stat)
+{
+	struct krait_data *data = dev_get_drvdata(dev);
+
+	stat->busy_time = 0;
+	stat->total_time = 0;
+	stat->current_frequency = clk_get_rate(data->l2_clk);
+
+	return 0;
+};
+
+static int krait_cache_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct krait_data *data = dev_get_drvdata(dev);
+
+	*freq = clk_get_rate(data->l2_clk);
+
+	return 0;
+};
+
+static struct devfreq_dev_profile tegra_devfreq_profile = {
+	.target = krait_cache_target,
+	.get_dev_status = krait_cache_get_dev_status,
+	.get_cur_freq = krait_cache_get_cur_freq
+};
+
+static int krait_cache_notifier(struct notifier_block *nb, unsigned long action,
+				void *v)
+{
+	struct cpufreq_freqs *freqs;
+	unsigned int cpu, cur_cpu;
+	struct krait_data *data;
+	struct devfreq *devfreq;
+	unsigned long freq;
+	int ret = 0;
+
+	if (action != CPUFREQ_POSTCHANGE)
+		return NOTIFY_OK;
+
+	data = container_of(nb, struct krait_data, nb);
+	devfreq = data->devfreq;
+
+	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
+
+	freqs = (struct cpufreq_freqs *)v;
+	freq = freqs->new;
+	cur_cpu = freqs->policy->cpu;
+
+	/* find the max freq across all core */
+	for_each_present_cpu(cpu)
+		if (cpu != cur_cpu)
+			freq = max(freq, (unsigned long)cpufreq_quick_get(cpu));
+
+	devfreq->governor->get_target_freq(devfreq, &freq);
+
+	ret = devfreq->profile->target(data->dev, &freq, 0);
+	if (ret < 0)
+		goto out;
+
+	if (devfreq->profile->freq_table &&
+	    (devfreq_update_status(devfreq, freq)))
+		dev_err(data->dev,
+			"Couldn't update frequency transition information.\n");
+
+	devfreq->previous_freq = freq;
+
+out:
+	mutex_unlock(&devfreq->lock);
+	return notifier_from_errno(ret);
+};
+
+static int krait_cache_governor_get_target(struct devfreq *devfreq,
+					   unsigned long *freq)
+{
+	unsigned int *l2_cpufreq;
+	unsigned long *freq_table;
+	unsigned long target_freq = *freq;
+	struct krait_data *data = dev_get_drvdata(devfreq->dev.parent);
+
+	l2_cpufreq = data->l2_cpufreq;
+	freq_table = data->freq_table;
+
+	/*
+	 * Find the highest l2 freq interval based on the max cpufreq
+	 * across all core
+	 */
+	while (*(l2_cpufreq = l2_cpufreq + 1) && target_freq >= *l2_cpufreq)
+		freq_table = freq_table + 1;
+
+	*freq = *freq_table;
+
+	return 0;
+};
+
+static int krait_cache_governor_event_handler(struct devfreq *devfreq,
+					      unsigned int event, void *data)
+{
+	struct krait_data *kdata = dev_get_drvdata(devfreq->dev.parent);
+	int ret = 0;
+
+	switch (event) {
+	case DEVFREQ_GOV_START:
+		kdata->nb.notifier_call = krait_cache_notifier;
+		ret = cpufreq_register_notifier(&kdata->nb,
+						CPUFREQ_TRANSITION_NOTIFIER);
+		break;
+
+	case DEVFREQ_GOV_STOP:
+		cpufreq_unregister_notifier(&kdata->nb,
+					    CPUFREQ_TRANSITION_NOTIFIER);
+		break;
+	}
+
+	return ret;
+};
+
+static struct devfreq_governor krait_devfreq_governor = {
+	.name = "krait_governor",
+	.get_target_freq = krait_cache_governor_get_target,
+	.event_handler = krait_cache_governor_event_handler,
+	.immutable = true,
+};
+
+static int krait_cache_probe(struct platform_device *pdev)
+{
+	int ret, count;
+	struct opp_table *table;
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
+	data->l2_clk = devm_clk_get(dev, "l2");
+	if (IS_ERR(data->l2_clk))
+		return PTR_ERR(data->l2_clk);
+
+	table = dev_pm_opp_set_regulators(dev, (const char *[]){ "l2" }, 1);
+	if (IS_ERR(table)) {
+		ret = PTR_ERR(table);
+		dev_err(dev, "failed to set regulators %d\n", ret);
+		return ret;
+	}
+
+	ret = PTR_ERR_OR_ZERO(
+		dev_pm_opp_register_set_opp_helper(dev, krait_cache_set_opp));
+	if (ret)
+		return ret;
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret) {
+		dev_err(dev, "failed to parse L2 freq thresholds\n");
+		return ret;
+	}
+
+	count = dev_pm_opp_get_opp_count(dev);
+
+	data->l2_cpufreq =
+		devm_kzalloc(dev, sizeof(unsigned int) * count, GFP_KERNEL);
+	if (!data->l2_cpufreq)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(node, "l2-cpufreq", data->l2_cpufreq,
+					 count);
+	if (ret) {
+		dev_err(dev, "failed to parse L2 cpufreq thresholds\n");
+		return ret;
+	}
+
+	ret = devfreq_add_governor(&krait_devfreq_governor);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add governor: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	data->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
+					   "krait_governor", NULL);
+
+	/* Cache freq_table to quickly get it when needed */
+	data->freq_table = data->devfreq->profile->freq_table;
+
+	if (IS_ERR(data->devfreq))
+		return PTR_ERR(data->devfreq);
+
+	return 0;
+};
+
+static int krait_cache_remove(struct platform_device *pdev)
+{
+	struct krait_data *data = platform_get_drvdata(pdev);
+
+	dev_pm_opp_remove_table(data->dev);
+
+	return 0;
+};
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
+module_platform_driver(krait_cache_driver);
+
+MODULE_DESCRIPTION("Krait CPU Cache Scaling driver");
+MODULE_AUTHOR("Ansuel Smith <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

