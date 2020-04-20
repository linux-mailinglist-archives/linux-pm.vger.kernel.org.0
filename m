Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC6B1B01C8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 08:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDTGtH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTGtG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 02:49:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87714C061A0C
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 23:49:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 7so4237246pjo.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQGG6DqR+aQd7lfrY0B6TjSFS6DgE7uSY3kCKd6Vxw0=;
        b=mAYD8qoTqJx7bIt5lj2G8pyg65R0duAgNL+faC+g1DOEJ4Nv7aiTsf9XxbGif4+BKB
         5sE759wfqZ3clrMdsd8xQQ6LJRJcFX8J4dnSuP/N//gQ4FwJ4Uc9NgfiexMphTat8mcy
         A/o6WN8BKKHeDw2wUDD+m+vFcKwr/KgNUu0B1oteWb+RGnX+tpzA7+moNUA9EA8i1GUC
         PkX9Ni2Yn7qwuah7N2DMnbg10j1TLIwBKVGN3E3vaRPoVAREHFCHVH4TwOScBQNmEwHt
         Ww3Nl3kEBojgc5uCBsWMHBgPhrXx2jLfM4ItuwGm0hZPKuB6S3S2ZsxGdS4x+iotsMSX
         iVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQGG6DqR+aQd7lfrY0B6TjSFS6DgE7uSY3kCKd6Vxw0=;
        b=mEb4vaY4wrC5pfAFr5CnruagnciFnhRYqPV7L5z4cdRVOtKpu1wz/tRPoehMSYYp79
         UkyLKOH2whWZJHDufe3ZOfKTJ23DgVQ6/sLk8wznlozElGh9AgiLo9Kv1LpZIyUGm22E
         egQR4FH+4AJakJ3qAoCxylBc7ZNnVMCG+VtPSDhzMBYlK8bLoEQgQw4v6pm8Z4p8Fnr5
         eQoHDRAS24SueOjy73oeO4AHz7RztJzkAuEG/RVBO6UbLA2ndEauModsFfqGCS+wSG1l
         r5oVa/VPI+NazG+Se5NBU4p6IKgee4wiKSv3viyYY5T8hBsTkcN0KtDcctbSrXF35R1k
         uHZg==
X-Gm-Message-State: AGi0PuakcRmL1sYaUKy3FpsrQgpAOnFy86kptKac39qMKOz+UR/LeckX
        pNMqOuBh/4nbOESS0vjSndYbBCbF
X-Google-Smtp-Source: APiQypIM1wiylcfIARw1gNogdZkv4xMX06t02gkeNP79wQp3z/dYWNVE0jmX74u/gH3j/cn6zBg38Q==
X-Received: by 2002:a17:90a:6548:: with SMTP id f8mr19410313pjs.114.1587365346073;
        Sun, 19 Apr 2020 23:49:06 -0700 (PDT)
Received: from bj04432pcu2.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w3sm128254pfn.115.2020.04.19.23.49.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 23:49:05 -0700 (PDT)
From:   gao.yunxiao6@gmail.com
To:     daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org
Cc:     linux-pm@vger.kernel.org, kernel-team@android.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Jeson Gao <jeson.gao@unisoc.com>
Subject: [PATCH 2/2] thermal/drivers/sprd_cpu_cooling: Add platform mitigation thermal driver
Date:   Mon, 20 Apr 2020 14:48:40 +0800
Message-Id: <1587365320-25222-2-git-send-email-gao.yunxiao6@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
References: <1587365320-25222-1-git-send-email-gao.yunxiao6@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jeson Gao <jeson.gao@unisoc.com>

This driver provides a further core ctrl policy to reduce temperature for
unisoc platform.

CPU unplug or isolation usually would be used for core ctrl policy.

This dirver is showing an example of using core ctrl policy.

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
---
 drivers/thermal/Kconfig            |   8 +
 drivers/thermal/Makefile           |   1 +
 drivers/thermal/sprd_cpu_cooling.c | 340 +++++++++++++++++++++++++++++++++++++
 3 files changed, 349 insertions(+)
 create mode 100644 drivers/thermal/sprd_cpu_cooling.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 91af271..41a57b0 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -490,4 +490,12 @@ config SPRD_THERMAL
 	help
 	  Support for the Spreadtrum thermal sensor driver in the Linux thermal
 	  framework.
+
+config SPRD_CPU_COOLING
+	tristate "sprd cpu cooling support"
+	depends on CPU_FREQ_THERMAL
+	help
+	  This implements the sprd cpu cooling mechanism to mitigate temperature
+	  rising.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8c8ed7b..4031842 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
 obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
+obj-$(CONFIG_SPRD_CPU_COOLING)	+= sprd_cpu_cooling.o
diff --git a/drivers/thermal/sprd_cpu_cooling.c b/drivers/thermal/sprd_cpu_cooling.c
new file mode 100644
index 0000000..2af2714
--- /dev/null
+++ b/drivers/thermal/sprd_cpu_cooling.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 Spreadtrum Communications Inc.
+
+#include <linux/thermal.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/cpufreq.h>
+
+#include <linux/cpu_cooling.h>
+
+struct sprd_cooling_cluster {
+	int id;
+	int cpu;
+	int cpus;
+	u32 min_freq;
+	struct cpufreq_policy policy;
+};
+
+struct sprd_cooling_data {
+	int nr_clusters;
+	struct sprd_cooling_cluster *cluster;
+};
+
+static void sprd_update_target_cpus(struct cpufreq_policy *policy,
+				    u32 target_cpus)
+{
+	int ret, cpu, first;
+	u32 curr_online_cpus, ncpus;
+
+	ncpus = cpumask_weight(policy->related_cpus);
+	curr_online_cpus = cpumask_weight(policy->cpus);
+	first = cpumask_first(policy->related_cpus);
+
+	if (target_cpus > curr_online_cpus) {
+		cpu = first;
+		for_each_cpu(cpu, policy->related_cpus) {
+			if (curr_online_cpus == target_cpus)
+				break;
+			if ((target_cpus > curr_online_cpus) &&
+			    !cpu_online(cpu)) {
+				ret = add_cpu(cpu);
+				if (!ret && cpu_online(cpu))
+					curr_online_cpus++;
+			}
+		}
+	} else if (target_cpus < curr_online_cpus) {
+		for (cpu = (first + ncpus - 1); cpu >= first; cpu--) {
+			if (curr_online_cpus == target_cpus)
+				break;
+			if ((target_cpus < curr_online_cpus) &&
+			    cpu_online(cpu)) {
+				ret = remove_cpu(cpu);
+				if (!ret && !cpu_online(cpu))
+					curr_online_cpus--;
+			}
+		}
+	}
+}
+
+static void sprd_estimate_down_cpus(struct cpufreq_policy *policy,
+				    u32 load, u32 normalised_power,
+				    u32 freq_power)
+{
+	int i = 0;
+	u32 target_cpus, online_cpus;
+	u32 avg_load, estimate_power =  0;
+
+	if (normalised_power) {
+		online_cpus = cpumask_weight(policy->cpus);
+		if (!online_cpus)
+			return;
+
+		avg_load = (load / online_cpus) ?: 1;
+		do {
+			estimate_power += (freq_power * avg_load) / 100;
+			if (estimate_power > normalised_power)
+				break;
+			i++;
+		} while (i < online_cpus);
+
+		target_cpus = max(i, 0);
+	} else
+		target_cpus = 0;
+
+	sprd_update_target_cpus(policy, target_cpus);
+}
+
+static void sprd_estimate_up_cpus(struct cpufreq_policy *policy,
+				  u32 load, u32 normalised_power,
+				  u32 freq_power)
+{
+	int i = 0, ncpus;
+	u32 target_cpus;
+	u32 avg_load, estimate_power =  0;
+
+	ncpus = cpumask_weight(policy->related_cpus);
+	avg_load = (load / ncpus) ?: 1;
+
+	do {
+		estimate_power += (freq_power * avg_load) / 100;
+		if (estimate_power > normalised_power)
+			break;
+		i++;
+	} while (i < ncpus);
+
+	target_cpus = min(i, ncpus);
+	sprd_update_target_cpus(policy, target_cpus);
+}
+
+static void sprd_keep_cpus(struct cpufreq_policy *policy)
+{
+	u32 online_cpus;
+
+	online_cpus = cpumask_weight(policy->cpus);
+	sprd_update_target_cpus(policy, online_cpus);
+}
+
+static int sprd_cpufreq_cpu_ctrl(struct cpufreq_policy *policy,
+				 u32 load, u32 normalised_power,
+				 u32 freq_power)
+{
+	unsigned int ncpus, online_cpus;
+
+	ncpus = cpumask_weight(policy->related_cpus);
+	online_cpus = cpumask_weight(policy->cpus);
+
+	if (normalised_power <  freq_power)
+		sprd_estimate_down_cpus(policy, load,
+					normalised_power, freq_power);
+	else if (online_cpus < ncpus)
+		sprd_estimate_up_cpus(policy, load,
+				      normalised_power, freq_power);
+	else
+		sprd_keep_cpus(policy);
+
+	return 0;
+}
+
+static void sprd_cpufreq_min_freq_limit(struct cpufreq_policy *policy,
+					u32 *target_freq)
+{
+	struct sprd_cooling_cluster *cluster =
+		container_of(policy, struct sprd_cooling_cluster, policy);
+
+	if (*target_freq < cluster->min_freq)
+		*target_freq = cluster->min_freq;
+}
+
+struct cpufreq_cooling_plat_ops plat_ops = {
+	.cpufreq_plat_cpu_ctrl = sprd_cpufreq_cpu_ctrl,
+	.cpufreq_plat_min_freq_limit = sprd_cpufreq_min_freq_limit,
+};
+
+static int sprd_get_cluster_counts(void)
+{
+	int cpu = 0, core_num = -1;
+	int cluster_num = 0;
+
+	do {
+		core_num = cpumask_weight(topology_core_cpumask(cpu));
+		if (core_num > 0) {
+			cpu = cpu + core_num;
+			cluster_num++;
+		} else
+			break;
+	} while (cpu > 0);
+
+	return cluster_num;
+}
+
+static int sprd_cpu_cooling_ops_register(struct platform_device *pdev)
+{
+	int id, ret = 0;
+	struct thermal_cooling_device *cdev;
+	struct sprd_cooling_cluster *cluster;
+	struct sprd_cooling_data *data = platform_get_drvdata(pdev);
+
+	for (id = 0; id < data->nr_clusters; id++) {
+		cluster = &data->cluster[id];
+		cdev = cluster->policy.cdev;
+		if (cdev) {
+			ret = cpufreq_cooling_plat_ops_register(cdev,
+								&plat_ops);
+			if (ret < 0) {
+				dev_err(&pdev->dev,
+					"CPU%d: failed to register platform function\n",
+					cluster->cpu);
+				break;
+			}
+		} else {
+			ret = -ENODEV;
+			dev_err(&pdev->dev,
+				"CPU%d: failed to get thermal device\n",
+				cluster->cpu);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int sprd_cpu_cooling_ops_unregister(struct platform_device *pdev)
+{
+	int id, ret = 0;
+	struct thermal_cooling_device *cdev;
+	struct sprd_cooling_cluster *cluster;
+	struct sprd_cooling_data *data = platform_get_drvdata(pdev);
+
+	for (id = 0; id < data->nr_clusters; id++) {
+		cluster = &data->cluster[id];
+		cdev = cluster->policy.cdev;
+		if (cdev) {
+			ret = cpufreq_cooling_plat_ops_unregister(cdev);
+			if (ret < 0) {
+				dev_err(&pdev->dev,
+					"cpu%d: failed to unregister platform function\n",
+					cluster->cpu);
+				break;
+			}
+		} else {
+			dev_err(&pdev->dev,
+				"cpu%d: failed to get thermal device\n",
+				cluster->cpu);
+			ret = -ENODEV;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int sprd_init_cooling_cluster(struct platform_device *pdev)
+{
+	int cpu = 0, id, core_num, ret = 0;
+	struct sprd_cooling_cluster *cluster;
+	struct sprd_cooling_data *data = platform_get_drvdata(pdev);
+
+	do {
+		core_num = cpumask_weight(topology_core_cpumask(cpu));
+		id = topology_physical_package_id((cpu));
+		if (core_num > 0 && id >= 0) {
+			cluster = &data->cluster[id];
+			cluster->id = id;
+			cluster->cpu = cpu;
+			cluster->cpus = core_num;
+			ret = cpufreq_get_policy(&(cluster->policy), cpu);
+			if (ret < 0) {
+				dev_err(&pdev->dev,
+					"CPU%d failed to get policy\n",
+					cpu);
+				break;
+			}
+
+			cpu = cpu + core_num;
+		} else
+			break;
+
+	} while (cpu > 0);
+
+	return ret;
+}
+
+static int sprd_cpu_cooling_probe(struct platform_device *pdev)
+{
+	int ret = -1;
+	int counts = 0;
+	struct sprd_cooling_data *data;
+	struct device *dev = &pdev->dev;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	counts = sprd_get_cluster_counts();
+	data->nr_clusters = counts;
+	data->cluster = devm_kzalloc(dev,
+				     sizeof(*data->cluster) * data->nr_clusters,
+				     GFP_KERNEL);
+	if (!data->cluster)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+
+	ret = sprd_init_cooling_cluster(pdev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init cooling cluster\n");
+		return ret;
+	}
+
+	ret = sprd_cpu_cooling_ops_register(pdev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register cooling callback function\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sprd_cpu_cooling_remove(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = sprd_cpu_cooling_ops_unregister(pdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to unregister cooling callback function\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver sprd_cpu_cooling_driver = {
+	.probe = sprd_cpu_cooling_probe,
+	.remove = sprd_cpu_cooling_remove,
+	.driver = {
+		   .owner = THIS_MODULE,
+		   .name = "sprd_cpu_cooling",
+		   },
+};
+static int __init sprd_cpu_cooling_init(void)
+{
+	return platform_driver_register(&sprd_cpu_cooling_driver);
+}
+
+static void __exit sprd_cpu_cooling_exit(void)
+{
+	platform_driver_unregister(&sprd_cpu_cooling_driver);
+}
+
+module_init(sprd_cpu_cooling_init)
+module_exit(sprd_cpu_cooling_exit);
+
+MODULE_DESCRIPTION("sprd cpu cooling");
+MODULE_LICENSE("GPL");
-- 
1.9.1

