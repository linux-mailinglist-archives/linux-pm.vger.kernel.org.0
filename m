Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D407497F5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 06:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfFREPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 00:15:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46334 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfFREPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 00:15:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so6905449pgr.13
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2019 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8w6a5HJ+MAgGKOOMJNctthnsq3yNmEowigfHTQ6ZEU=;
        b=cMxI4YNZyl9/BGPiBCS3kMjFqR79a69+S1mDhu9z7pEMB9Nqou34IVe0ZLIB1VwuNZ
         +dJjFjd6yzl+MO4uQm9AsX4d/mA062iUr7SenIqwg4UHiG+MEBMFTk84z4JLarBL65b2
         sTmszdU/xbqOw6+XUl2PWy765vjPXU7Onrxtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8w6a5HJ+MAgGKOOMJNctthnsq3yNmEowigfHTQ6ZEU=;
        b=GDJonMm6I8aJ0pfJ05PjJHxq7q9In3zvCkHiQUxNEXKAl9GbcSA45kzKWCaMVgrwRY
         ZnooCh7PsasvMOFutPfviHWnuZXDq//plNWmR0Oi109mSQB27h/h4mL+slQkiqTub1/B
         IKJ2jcJdy45K7BrbD1RUZ7r16BrRehMk6rxbUfyZaMRXfvUz2SvxMirAkYb8zfJjm+Ct
         +25av7PmGIdlVl5CYwL4N10AEj7Im+oqbWW4KxxlmPMKheU19Ps9+ST4p3naSl+yEHaJ
         kAN9Tf+y+l+/tjmQEv2LWaSFbcc/o3OFe7U6nWdgJkez6yl/+eLFSmTaRmsZ8lLwBY4k
         WKcw==
X-Gm-Message-State: APjAAAXfzxhz65nmaydSYuQWDQ3PK4xn8T9rU8TYFKBHy132Yp7K1Jjl
        8FcVfw+Z9Ru7UcfpYECu4aay+w==
X-Google-Smtp-Source: APXvYqwa1KmQi0FIN6lvQN5zD3NcCI/sRLoxN2ikKdNiECybGMSzDvuJTpS0IZBrThyEVOZwrz4kfg==
X-Received: by 2002:a62:1bd1:: with SMTP id b200mr92424415pfb.210.1560831308001;
        Mon, 17 Jun 2019 21:15:08 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id 25sm13590685pfp.76.2019.06.17.21.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 21:15:07 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: [PATCH RFC 1/2] PM / devfreq: Generic CPU frequency to device frequency mapping governor
Date:   Tue, 18 Jun 2019 12:14:34 +0800
Message-Id: <20190618041433.245629-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618041433.245629-1-hsinyi@chromium.org>
References: <20190618041433.245629-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

From: Saravana Kannan <skannan@codeaurora.org>

Many CPU architectures have caches that can scale independent of the CPUs.
Frequency scaling of the caches is necessary to make sure the cache is not
a performance bottleneck that leads to poor performance and power. The same
idea applies for RAM/DDR.

To achieve this, this patch adds a generic devfreq governor that takes the
current frequency of each CPU frequency domain and then adjusts the
frequency of the cache (or any devfreq device) based on the frequency of
the CPUs. It listens to CPU frequency transition notifiers to keep itself
up to date on the current CPU frequency.

To decide the frequency of the device, the governor does one of the
following:

* Uses a CPU frequency to device frequency mapping table
  - Either one mapping table used for all CPU freq policies (typically used
    for system with homogeneous cores/clusters that have the same OPPs).
  - One mapping table per CPU freq policy (typically used for ASMP systems
    with heterogeneous CPUs with different OPPs)

OR

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its max
  frequency.  If the CPUs are running at their min frequency, the device
  runs at its min frequency. And interpolated for frequencies in between.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../bindings/devfreq/devfreq-cpufreq-map.txt  |  53 ++
 drivers/devfreq/Kconfig                       |   8 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/governor_cpufreq_map.c        | 583 ++++++++++++++++++
 4 files changed, 645 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
 create mode 100644 drivers/devfreq/governor_cpufreq_map.c

diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
new file mode 100644
index 000000000000..982a30bcfc86
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
@@ -0,0 +1,53 @@
+Devfreq CPUfreq governor
+
+devfreq-cpufreq-map is a parent device that contains one or more child devices.
+Each child device provides CPU frequency to device frequency mapping for a
+specific device. Examples of devices that could use this are: DDR, cache and
+CCI.
+
+Parent device name shall be "devfreq-cpufreq-map".
+
+Required child device properties:
+- cpu-to-dev-map, or cpu-to-dev-map-<X>:
+			A list of tuples where each tuple consists of a
+			CPU frequency (KHz) and the corresponding device
+			frequency. CPU frequencies not listed in the table
+			will use the device frequency that corresponds to the
+			next rounded up CPU frequency.
+			Use "cpu-to-dev-map" if all CPUs in the system should
+			share same mapping.
+			Use cpu-to-dev-map-<cpuid> to describe different
+			mappings for different CPUs. The property should be
+			listed only for the first CPU if multiple CPUs are
+			synchronous.
+- target-dev:		Phandle to device that this mapping applies to.
+
+Example:
+	devfreq-cpufreq-map {
+		cpubw-cpufreq {
+			target-dev = <&cpubw>;
+			cpu-to-dev-map =
+				<  300000  1144000 >,
+				<  422400  2288000 >,
+				<  652800  3051000 >,
+				<  883200  5996000 >,
+				< 1190400  8056000 >,
+				< 1497600 10101000 >,
+				< 1728000 12145000 >,
+				< 2649600 16250000 >;
+		};
+
+		cache-cpufreq {
+			target-dev = <&cache>;
+			cpu-to-dev-map =
+				<  300000  300000 >,
+				<  422400  422400 >,
+				<  652800  499200 >,
+				<  883200  576000 >,
+				<  960000  960000 >,
+				< 1497600 1036800 >,
+				< 1574400 1574400 >,
+				< 1728000 1651200 >,
+				< 2649600 1728000 >;
+		};
+	};
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 0c8204d6b78a..0303f5a400b6 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -74,6 +74,14 @@ config DEVFREQ_GOV_PASSIVE
 	  through sysfs entries. The passive governor recommends that
 	  devfreq device uses the OPP table to get the frequency/voltage.
 
+config DEVFREQ_GOV_CPUFREQ_MAP
+	tristate "CPUfreq Map"
+	depends on CPU_FREQ
+	help
+	  Chooses frequency based on the online CPUs' current frequency and a
+	  CPU frequency to device frequency mapping table(s). This governor
+	  can be useful for controlling devices such as DDR, cache, CCI, etc.
+
 comment "DEVFREQ Drivers"
 
 config ARM_EXYNOS_BUS_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 817dde779f16..81141e2c784f 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
 obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
 obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
 obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
+obj-$(CONFIG_DEVFREQ_GOV_CPUFREQ_MAP)	+= governor_cpufreq_map.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
diff --git a/drivers/devfreq/governor_cpufreq_map.c b/drivers/devfreq/governor_cpufreq_map.c
new file mode 100644
index 000000000000..084a3ffb8f54
--- /dev/null
+++ b/drivers/devfreq/governor_cpufreq_map.c
@@ -0,0 +1,583 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2015, 2018, The Linux Foundation. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "dev-cpufreq-map: " fmt
+
+#include <linux/devfreq.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include "governor.h"
+
+struct cpu_state {
+	unsigned int freq;
+	unsigned int min_freq;
+	unsigned int max_freq;
+	unsigned int first_cpu;
+};
+static struct cpu_state *state[NR_CPUS];
+static int cpufreq_cnt;
+
+struct freq_map {
+	unsigned int cpu_khz;
+	unsigned int target_freq;
+};
+
+struct devfreq_node {
+	struct devfreq *df;
+	void *orig_data;
+	struct device *dev;
+	struct device_node *of_node;
+	struct list_head list;
+	struct freq_map **map;
+	struct freq_map *common_map;
+};
+static LIST_HEAD(devfreq_list);
+static DEFINE_MUTEX(state_lock);
+static DEFINE_MUTEX(cpufreq_reg_lock);
+
+static void update_all_devfreqs(void)
+{
+	struct devfreq_node *node;
+
+	list_for_each_entry(node, &devfreq_list, list) {
+		struct devfreq *df = node->df;
+
+		if (!node->df)
+			continue;
+		mutex_lock(&df->lock);
+		update_devfreq(df);
+		mutex_unlock(&df->lock);
+
+	}
+}
+
+static struct devfreq_node *find_devfreq_node(struct device *dev)
+{
+	struct devfreq_node *node;
+
+	list_for_each_entry(node, &devfreq_list, list)
+		if (node->dev == dev || node->of_node == dev->of_node)
+			return node;
+
+	return NULL;
+}
+
+/* ==================== cpufreq part ==================== */
+static struct cpu_state *add_policy(struct cpufreq_policy *policy)
+{
+	struct cpu_state *new_state;
+	unsigned int cpu, first_cpu;
+
+	new_state = kzalloc(sizeof(struct cpu_state), GFP_KERNEL);
+	if (!new_state)
+		return NULL;
+
+	first_cpu = cpumask_first(policy->related_cpus);
+	new_state->first_cpu = first_cpu;
+	new_state->freq = policy->cur;
+	new_state->min_freq = policy->cpuinfo.min_freq;
+	new_state->max_freq = policy->cpuinfo.max_freq;
+
+	for_each_cpu(cpu, policy->related_cpus)
+		state[cpu] = new_state;
+
+	return new_state;
+}
+
+static int cpufreq_trans_notifier(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct cpufreq_freqs *freq = data;
+	struct cpu_state *s;
+	struct cpufreq_policy *policy = NULL;
+
+	if (event != CPUFREQ_POSTCHANGE)
+		return 0;
+
+	mutex_lock(&state_lock);
+
+	s = state[freq->cpu];
+	if (!s) {
+		policy = cpufreq_cpu_get(freq->cpu);
+		if (policy) {
+			s = add_policy(policy);
+			cpufreq_cpu_put(policy);
+		}
+	}
+	if (!s)
+		goto out;
+
+	if (s->freq != freq->new || policy) {
+		s->freq = freq->new;
+		update_all_devfreqs();
+	}
+
+out:
+	mutex_unlock(&state_lock);
+	return 0;
+}
+
+static struct notifier_block cpufreq_trans_nb = {
+	.notifier_call = cpufreq_trans_notifier
+};
+
+static int register_cpufreq(void)
+{
+	int ret = 0;
+	unsigned int cpu;
+	struct cpufreq_policy *policy;
+
+	mutex_lock(&cpufreq_reg_lock);
+
+	if (cpufreq_cnt)
+		goto cnt_not_zero;
+
+	get_online_cpus();
+	ret = cpufreq_register_notifier(&cpufreq_trans_nb,
+				CPUFREQ_TRANSITION_NOTIFIER);
+	if (ret)
+		goto out;
+
+	for_each_online_cpu(cpu) {
+		policy = cpufreq_cpu_get(cpu);
+		if (policy) {
+			add_policy(policy);
+			cpufreq_cpu_put(policy);
+		}
+	}
+out:
+	put_online_cpus();
+cnt_not_zero:
+	if (!ret)
+		cpufreq_cnt++;
+	mutex_unlock(&cpufreq_reg_lock);
+	return ret;
+}
+
+static int unregister_cpufreq(void)
+{
+	int ret = 0;
+	int cpu;
+
+	mutex_lock(&cpufreq_reg_lock);
+
+	if (cpufreq_cnt > 1)
+		goto out;
+
+	cpufreq_unregister_notifier(&cpufreq_trans_nb,
+				CPUFREQ_TRANSITION_NOTIFIER);
+
+	for (cpu = ARRAY_SIZE(state) - 1; cpu >= 0; cpu--) {
+		if (!state[cpu])
+			continue;
+		if (state[cpu]->first_cpu == cpu)
+			kfree(state[cpu]);
+		state[cpu] = NULL;
+	}
+
+out:
+	cpufreq_cnt--;
+	mutex_unlock(&cpufreq_reg_lock);
+	return ret;
+}
+
+/* ==================== devfreq part ==================== */
+
+static unsigned int interpolate_freq(struct devfreq *df, unsigned int cpu)
+{
+	unsigned long *freq_table = df->profile->freq_table;
+	unsigned int cpu_min = state[cpu]->min_freq;
+	unsigned int cpu_max = state[cpu]->max_freq;
+	unsigned int cpu_freq = state[cpu]->freq;
+	unsigned int dev_min, dev_max, cpu_percent;
+
+	if (freq_table) {
+		dev_min = freq_table[0];
+		dev_max = freq_table[df->profile->max_state - 1];
+	} else {
+		if (df->max_freq <= df->min_freq)
+			return 0;
+		dev_min = df->min_freq;
+		dev_max = df->max_freq;
+	}
+
+	cpu_percent = ((cpu_freq - cpu_min) * 100) / (cpu_max - cpu_min);
+	return dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
+}
+
+static unsigned int cpu_to_dev_freq(struct devfreq *df, unsigned int cpu)
+{
+	struct freq_map *map = NULL;
+	unsigned int cpu_khz = 0, freq;
+	struct devfreq_node *n = df->data;
+
+	if (!state[cpu] || state[cpu]->first_cpu != cpu) {
+		freq = 0;
+		goto out;
+	}
+
+	if (n->common_map)
+		map = n->common_map;
+	else if (n->map)
+		map = n->map[cpu];
+
+	cpu_khz = state[cpu]->freq;
+
+	if (!map) {
+		freq = interpolate_freq(df, cpu);
+		goto out;
+	}
+
+	while (map->cpu_khz && map->cpu_khz < cpu_khz)
+		map++;
+	if (!map->cpu_khz)
+		map--;
+	freq = map->target_freq;
+
+out:
+	dev_dbg(df->dev.parent, "CPU%u: %d -> dev: %u\n", cpu, cpu_khz, freq);
+	return freq;
+}
+
+static int devfreq_cpufreq_get_freq(struct devfreq *df,
+					unsigned long *freq)
+{
+	unsigned int cpu, tgt_freq = 0;
+	struct devfreq_node *node;
+
+	node = df->data;
+	if (!node) {
+		pr_err("Unable to find devfreq node!\n");
+		return -ENODEV;
+	}
+
+	for_each_possible_cpu(cpu)
+		tgt_freq = max(tgt_freq, cpu_to_dev_freq(df, cpu));
+
+	*freq = tgt_freq;
+	return 0;
+}
+
+static unsigned int show_table(char *buf, unsigned int len,
+				struct freq_map *map)
+{
+	unsigned int cnt = 0;
+
+	cnt += snprintf(buf + cnt, len - cnt, "CPU freq\tDevice freq\n");
+
+	while (map->cpu_khz && cnt < len) {
+		cnt += snprintf(buf + cnt, len - cnt, "%8u\t%11u\n",
+				map->cpu_khz, map->target_freq);
+		map++;
+	}
+	if (cnt < len)
+		cnt += snprintf(buf + cnt, len - cnt, "\n");
+
+	return cnt;
+}
+
+static ssize_t freq_map_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct devfreq *df = to_devfreq(dev);
+	struct devfreq_node *n = df->data;
+	struct freq_map *map;
+	unsigned int cnt = 0, cpu;
+
+	mutex_lock(&state_lock);
+	if (n->common_map) {
+		map = n->common_map;
+		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
+				"Common table for all CPUs:\n");
+		cnt += show_table(buf + cnt, PAGE_SIZE - cnt, map);
+	} else if (n->map) {
+		for_each_possible_cpu(cpu) {
+			map = n->map[cpu];
+			if (!map)
+				continue;
+			cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
+					"CPU %u:\n", cpu);
+			if (cnt >= PAGE_SIZE)
+				break;
+			cnt += show_table(buf + cnt, PAGE_SIZE - cnt, map);
+			if (cnt >= PAGE_SIZE)
+				break;
+		}
+	} else {
+		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
+				"Device freq interpolated based on CPU freq\n");
+	}
+	mutex_unlock(&state_lock);
+
+	return cnt;
+}
+
+static DEVICE_ATTR_RO(freq_map);
+static struct attribute *dev_attr[] = {
+	&dev_attr_freq_map.attr,
+	NULL,
+};
+
+static struct attribute_group dev_attr_group = {
+	.name = "cpufreq-map",
+	.attrs = dev_attr,
+};
+
+static int devfreq_cpufreq_gov_start(struct devfreq *devfreq)
+{
+	int ret = 0;
+	struct devfreq_node *node;
+	bool alloc = false;
+
+	ret = register_cpufreq();
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
+	if (ret) {
+		unregister_cpufreq();
+		return ret;
+	}
+
+	mutex_lock(&state_lock);
+
+	node = find_devfreq_node(devfreq->dev.parent);
+	if (node == NULL) {
+		node = kzalloc(sizeof(struct devfreq_node), GFP_KERNEL);
+		if (!node) {
+			ret = -ENOMEM;
+			goto alloc_fail;
+		}
+		alloc = true;
+		node->dev = devfreq->dev.parent;
+		list_add_tail(&node->list, &devfreq_list);
+	}
+	node->df = devfreq;
+	node->orig_data = devfreq->data;
+	devfreq->data = node;
+
+	mutex_lock(&devfreq->lock);
+	ret = update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+	if (ret) {
+		pr_err("Freq update failed!\n");
+		goto update_fail;
+	}
+
+	mutex_unlock(&state_lock);
+	return 0;
+
+update_fail:
+	devfreq->data = node->orig_data;
+	if (alloc) {
+		list_del(&node->list);
+		kfree(node);
+	}
+alloc_fail:
+	mutex_unlock(&state_lock);
+	sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
+	unregister_cpufreq();
+	return ret;
+}
+
+static void devfreq_cpufreq_gov_stop(struct devfreq *devfreq)
+{
+	struct devfreq_node *node = devfreq->data;
+
+	mutex_lock(&state_lock);
+	devfreq->data = node->orig_data;
+	if (node->map || node->common_map) {
+		node->df = NULL;
+	} else {
+		list_del(&node->list);
+		kfree(node);
+	}
+	mutex_unlock(&state_lock);
+
+	sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
+	unregister_cpufreq();
+}
+
+static int devfreq_cpufreq_ev_handler(struct devfreq *devfreq,
+					unsigned int event, void *data)
+{
+	int ret;
+
+	switch (event) {
+	case DEVFREQ_GOV_START:
+
+		ret = devfreq_cpufreq_gov_start(devfreq);
+		if (ret) {
+			pr_err("Governor start failed!\n");
+			return ret;
+		}
+		pr_debug("Enabled CPUfreq-map governor\n");
+		break;
+
+	case DEVFREQ_GOV_STOP:
+
+		devfreq_cpufreq_gov_stop(devfreq);
+		pr_debug("Disabled dev CPUfreq-map governor\n");
+		break;
+	}
+
+	return 0;
+}
+
+static struct devfreq_governor devfreq_cpufreq = {
+	.name = "cpufreq-map",
+	.get_target_freq = devfreq_cpufreq_get_freq,
+	.event_handler = devfreq_cpufreq_ev_handler,
+};
+
+#define NUM_COLS	2
+static struct freq_map *read_tbl(struct device_node *of_node, char *prop_name)
+{
+	int len, nf, i, j;
+	u32 data;
+	struct freq_map *tbl;
+
+	if (!of_find_property(of_node, prop_name, &len))
+		return NULL;
+	len /= sizeof(data);
+
+	if (len % NUM_COLS || len == 0)
+		return NULL;
+	nf = len / NUM_COLS;
+
+	tbl = kzalloc((nf + 1) * sizeof(*tbl), GFP_KERNEL);
+	if (!tbl)
+		return NULL;
+
+	for (i = 0, j = 0; i < nf; i++, j += 2) {
+		of_property_read_u32_index(of_node, prop_name, j, &data);
+		tbl[i].cpu_khz = data;
+
+		of_property_read_u32_index(of_node, prop_name, j + 1, &data);
+		tbl[i].target_freq = data;
+	}
+	tbl[i].cpu_khz = 0;
+
+	return tbl;
+}
+
+#define PROP_TARGET "target-dev"
+#define PROP_TABLE "cpu-to-dev-map"
+static int add_table_from_of(struct device_node *of_node)
+{
+	struct device_node *target_of_node;
+	struct devfreq_node *node;
+	struct freq_map *common_tbl;
+	struct freq_map **tbl_list = NULL;
+	static char prop_name[] = PROP_TABLE "-999999";
+	int cpu, ret, cnt = 0, prop_sz = ARRAY_SIZE(prop_name);
+
+	target_of_node = of_parse_phandle(of_node, PROP_TARGET, 0);
+	if (!target_of_node)
+		return -EINVAL;
+
+	node = kzalloc(sizeof(struct devfreq_node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	common_tbl = read_tbl(of_node, PROP_TABLE);
+	if (!common_tbl) {
+		tbl_list = kzalloc(sizeof(*tbl_list) * NR_CPUS, GFP_KERNEL);
+		if (!tbl_list) {
+			ret = -ENOMEM;
+			goto err_list;
+		}
+
+		for_each_possible_cpu(cpu) {
+			ret = snprintf(prop_name, prop_sz, "%s-%d",
+					PROP_TABLE, cpu);
+			if (ret >= prop_sz) {
+				pr_warn("More CPUs than I can handle!\n");
+				pr_warn("Skipping rest of the tables!\n");
+				break;
+			}
+			tbl_list[cpu] = read_tbl(of_node, prop_name);
+			if (tbl_list[cpu])
+				cnt++;
+		}
+	}
+	if (!common_tbl && !cnt) {
+		ret = -EINVAL;
+		goto err_tbl;
+	}
+
+	mutex_lock(&state_lock);
+	node->of_node = target_of_node;
+	node->map = tbl_list;
+	node->common_map = common_tbl;
+	list_add_tail(&node->list, &devfreq_list);
+	mutex_unlock(&state_lock);
+
+	return 0;
+err_tbl:
+	kfree(tbl_list);
+err_list:
+	kfree(node);
+	return ret;
+}
+
+static int __init devfreq_cpufreq_init(void)
+{
+	int ret;
+	struct device_node *of_par, *of_child;
+
+	of_par = of_find_node_by_name(NULL, "devfreq-cpufreq-map");
+	if (of_par) {
+		for_each_child_of_node(of_par, of_child) {
+			ret = add_table_from_of(of_child);
+			if (ret)
+				pr_err("Parsing %s failed!\n", of_child->name);
+			else
+				pr_debug("Parsed %s.\n", of_child->name);
+		}
+		of_node_put(of_par);
+	} else {
+		pr_info("No tables parsed from DT.\n");
+	}
+
+	ret = devfreq_add_governor(&devfreq_cpufreq);
+	if (ret) {
+		pr_err("cpufreq-map governor add failed!\n");
+		return ret;
+	}
+
+	return 0;
+}
+subsys_initcall(devfreq_cpufreq_init);
+
+static void __exit devfreq_cpufreq_exit(void)
+{
+	int ret, cpu;
+	struct devfreq_node *node, *tmp;
+
+	ret = devfreq_remove_governor(&devfreq_cpufreq);
+	if (ret)
+		pr_err("cpufreq-map governor remove failed!\n");
+
+	mutex_lock(&state_lock);
+	list_for_each_entry_safe(node, tmp, &devfreq_list, list) {
+		kfree(node->common_map);
+		for_each_possible_cpu(cpu)
+			kfree(node->map[cpu]);
+		kfree(node->map);
+		list_del(&node->list);
+		kfree(node);
+	}
+	mutex_unlock(&state_lock);
+}
+module_exit(devfreq_cpufreq_exit);
+
+MODULE_DESCRIPTION("devfreq gov that sets dev freq based on current CPU freq");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

