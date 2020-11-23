Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4902C17DB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbgKWVmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 16:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbgKWVm3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 16:42:29 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F47CC061A4D
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 13:42:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p22so740741wmg.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2020 13:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BY6V6LfPzm2TS6iX4iHYAl5lbJAiGRYPM4silY/pXUU=;
        b=cYcxYg2EvHJvWPFpV9ifYndNPY5XKKrtY8Jo6nNz4evKNYpNM2EVlVPBPqrwwkXpUr
         T5rptMfLkvEATBcMH2sHEgguTuVaFLuO4N62/ihwffLuekWequYW3PmXZHOrZupe+HgI
         bFqPP5fvNHQmc0NFy9EPjwx/aS24Vli1EVqbyGhNp4SSd7Hw5v/H3dhdtcNNVuROkvKi
         1nSZuJg0zf/41u4J+MrcdSZQOdIFYtYJ9sqQdM9Xh8PxyQtQZ6BnjuwyQfkjTCgqwauX
         riX1zizRnOfL6Y9Fe1pyeSLxtA6V5qNrfmEPI3knt6R20ZF0axxwu7TBcSA3Uq8WIT5q
         arwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BY6V6LfPzm2TS6iX4iHYAl5lbJAiGRYPM4silY/pXUU=;
        b=flL8jSnV5I92gOzG+iT2FSX/hCdjHPp3B5pUxNuu+w60iLWJgkGTCE2ox21BoWolEr
         YfWGJsoHzE8acLstitHJfnDSEpqw+jOJ89wqoFhWR28xcbj7Pb5ypNK3D3b7vq4J6t9X
         Vs+Pl4WZavd2mhwLiZb25oe4jWNC5Q6Me3sQ5xXfAlGgo9w3GMgjpH8t9dTolzHq6pks
         AQCfw4pG7olPKiefGNPUGDWwny2pKAD0IyvdEAmZZ38oMjhZ67sxg6BS+bFq6vCn8Wk6
         muayMPYCxO0WitIcd9CEEGwHC6HBZ6Klz6MUbLenMEAiQqWdV3j6vcrzZkM0oJlbivjt
         i6Pg==
X-Gm-Message-State: AOAM530WG7RXkekMpQ+RkBhPaLZpqZlA1uscPa4quurC/Z8cKE6HTT3e
        7tnlAmvaugcIXUZD47tBzqgkZg==
X-Google-Smtp-Source: ABdhPJz0GKiPyiPTYzNNcZ+NDu6P551D1kPE69BsevKBnpK/Ar3FskhUAxMv7PlOdl1slz4AucSGAw==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr946586wme.2.1606167746704;
        Mon, 23 Nov 2020 13:42:26 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-164.adsl.proxad.net. [82.252.157.164])
        by smtp.gmail.com with ESMTPSA id 35sm22400598wro.71.2020.11.23.13.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 13:42:26 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, corbet@lwn.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilina@codeaurora.org, lukasz.luba@arm.com, rkumbako@codeaurora.org,
        rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] powercap/drivers/dtpm: Add CPU energy model based support
Date:   Mon, 23 Nov 2020 22:42:08 +0100
Message-Id: <20201123214208.11007-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123214208.11007-1-daniel.lezcano@linaro.org>
References: <20201123214208.11007-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the powercap dtpm controller, we are able to plug devices with
power limitation features in the tree.

The following patch introduces the CPU power limitation based on the
energy model and the performance states.

The power limitation is done at the performance domain level. If some
CPUs are unplugged, the corresponding power will be subtracted from
the performance domain total power.

It is up to the platform to initialize the dtpm tree and add the CPU.

Here is an example to create a simple tree with one root node called
"pkg" and the CPU's performance domains.

static int dtpm_register_pkg(struct dtpm_descr *descr)
{
	struct dtpm *pkg;
	int ret;

	pkg = dtpm_alloc(NULL);
	if (!pkg)
		return -ENOMEM;

	ret = dtpm_register(descr->name, pkg, descr->parent);
	if (ret)
		return ret;

	return dtpm_register_cpu(pkg);
}

static struct dtpm_descr descr = {
	.name = "pkg",
	.init = dtpm_register_pkg,
};
DTPM_DECLARE(descr);

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig    |   7 +
 drivers/powercap/Makefile   |   1 +
 drivers/powercap/dtpm_cpu.c | 252 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h  |   1 +
 include/linux/dtpm.h        |   2 +
 5 files changed, 263 insertions(+)
 create mode 100644 drivers/powercap/dtpm_cpu.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index cc1953bd8bed..20b4325c6161 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -49,4 +49,11 @@ config DTPM
 	help
 	  This enables support for the power capping for the dynamic
 	  thermal power management userspace engine.
+
+config DTPM_CPU
+	bool "Add CPU power capping based on the energy model"
+	depends on DTPM && ENERGY_MODEL
+	help
+	  This enables support for CPU power limitation based on
+	  energy model.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index 6482ac52054d..fabcf388a8d3 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_DTPM) += dtpm.o
+obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
new file mode 100644
index 000000000000..81f0996dd8ad
--- /dev/null
+++ b/drivers/powercap/dtpm_cpu.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The DTPM CPU is based on the energy model. It hooks the CPU in the
+ * DTPM tree which in turns update the power number by propagating the
+ * power number from the CPU energy model information to the parents.
+ *
+ * The association between the power and the performance state, allows
+ * to set the power of the CPU at the OPP granularity.
+ *
+ * The CPU hotplug is supported and the power numbers will be updated
+ * if a CPU is hot plugged / unplugged.
+ */
+#include <linux/cpumask.h>
+#include <linux/cpufreq.h>
+#include <linux/cpuhotplug.h>
+#include <linux/dtpm.h>
+#include <linux/energy_model.h>
+#include <linux/pm_qos.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+
+static struct dtpm *__parent;
+
+static DEFINE_PER_CPU(struct dtpm *, dtpm_per_cpu);
+
+struct dtpm_cpu {
+	struct freq_qos_request qos_req;
+	int cpu;
+};
+
+/*
+ * When a new CPU is inserted at hotplug or boot time, add the power
+ * contribution and update the dtpm tree.
+ */
+static int power_add(struct dtpm *dtpm, struct em_perf_domain *em)
+{
+	u64 power_min, power_max;
+
+	power_min = em->table[0].power;
+	power_min *= MICROWATT_PER_MILLIWATT;
+	power_min += dtpm->power_min;
+
+	power_max = em->table[em->nr_perf_states - 1].power;
+	power_max *= MICROWATT_PER_MILLIWATT;
+	power_max += dtpm->power_max;
+
+	return dtpm_update_power(dtpm, power_min, power_max);
+}
+
+/*
+ * When a CPU is unplugged, remove its power contribution from the
+ * dtpm tree.
+ */
+static int power_sub(struct dtpm *dtpm, struct em_perf_domain *em)
+{
+	u64 power_min, power_max;
+
+	power_min = em->table[0].power;
+	power_min *= MICROWATT_PER_MILLIWATT;
+	power_min = dtpm->power_min - power_min;
+
+	power_max = em->table[em->nr_perf_states - 1].power;
+	power_max *= MICROWATT_PER_MILLIWATT;
+	power_max = dtpm->power_max - power_max;
+
+	return dtpm_update_power(dtpm, power_min, power_max);
+}
+
+static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
+{
+	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct em_perf_domain *pd;
+	struct cpumask cpus;
+	unsigned long freq;
+	u64 power;
+	int i, nr_cpus;
+
+	pd = em_cpu_get(dtpm_cpu->cpu);
+
+	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
+
+	nr_cpus = cpumask_weight(&cpus);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		power = pd->table[i].power * MICROWATT_PER_MILLIWATT * nr_cpus;
+
+		if (power > power_limit)
+			break;
+	}
+
+	freq = pd->table[i - 1].frequency;
+
+	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
+
+	power_limit = pd->table[i - 1].power *
+		MICROWATT_PER_MILLIWATT * nr_cpus;
+
+	return power_limit;
+}
+
+static u64 get_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct em_perf_domain *pd;
+	struct cpumask cpus;
+	unsigned long freq;
+	int i, nr_cpus;
+
+	pd = em_cpu_get(dtpm_cpu->cpu);
+	freq = cpufreq_quick_get(dtpm_cpu->cpu);
+	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
+	nr_cpus = cpumask_weight(&cpus);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		if (pd->table[i].frequency < freq)
+			continue;
+
+		return pd->table[i].power *
+			MICROWATT_PER_MILLIWATT * nr_cpus;
+	}
+
+	return 0;
+}
+
+static void pd_release(struct dtpm *dtpm)
+{
+	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+
+	freq_qos_remove_request(&dtpm_cpu->qos_req);
+	kfree(dtpm_cpu);
+}
+
+static struct dtpm_ops dtpm_ops = {
+	.set_power_uw = set_pd_power_limit,
+	.get_power_uw = get_pd_power_uw,
+	.release = pd_release,
+};
+
+static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+	struct em_perf_domain *pd;
+	struct dtpm *dtpm;
+
+	policy = cpufreq_cpu_get(cpu);
+
+	if (!policy)
+		return 0;
+
+	pd = em_cpu_get(cpu);
+	if (!pd)
+		return -EINVAL;
+
+	dtpm = per_cpu(dtpm_per_cpu, cpu);
+
+	power_sub(dtpm, pd);
+
+	if (cpumask_weight(policy->cpus) != 1)
+		return 0;
+
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(dtpm_per_cpu, cpu) = NULL;
+
+	dtpm_unregister(dtpm);
+
+	return 0;
+}
+
+static int cpuhp_dtpm_cpu_online(unsigned int cpu)
+{
+	struct dtpm *dtpm;
+	struct dtpm_cpu *dtpm_cpu;
+	struct cpufreq_policy *policy;
+	struct em_perf_domain *pd;
+	char name[CPUFREQ_NAME_LEN];
+	int ret;
+
+	policy = cpufreq_cpu_get(cpu);
+
+	if (!policy)
+		return 0;
+
+	pd = em_cpu_get(cpu);
+	if (!pd)
+		return -EINVAL;
+
+	dtpm = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm)
+		return power_add(dtpm, pd);
+
+	dtpm = dtpm_alloc(&dtpm_ops);
+	if (!dtpm)
+		return -EINVAL;
+
+	dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);
+	if (!dtpm_cpu) {
+		kfree(dtpm);
+		return -ENOMEM;
+	}
+
+	dtpm->private = dtpm_cpu;
+	dtpm_cpu->cpu = cpu;
+
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(dtpm_per_cpu, cpu) = dtpm;
+
+	sprintf(name, "cpu%d", dtpm_cpu->cpu);
+
+	ret = dtpm_register(name, dtpm, __parent);
+	if (ret)
+		goto out_kfree_dtpm_cpu;
+
+	ret = power_add(dtpm, pd);
+	if (ret)
+		goto out_power_sub;
+
+	ret = freq_qos_add_request(&policy->constraints,
+				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
+				   pd->table[pd->nr_perf_states - 1].frequency);
+	if (ret)
+		goto out_dtpm_unregister;
+
+	return 0;
+
+out_dtpm_unregister:
+	dtpm_unregister(dtpm);
+	dtpm_cpu = NULL; /* Already freed by the release ops */
+out_power_sub:
+	power_sub(dtpm, pd);
+out_kfree_dtpm_cpu:
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(dtpm_per_cpu, cpu) = NULL;
+	kfree(dtpm_cpu);
+
+	return ret;
+}
+
+int dtpm_register_cpu(struct dtpm *parent)
+{
+	__parent = parent;
+
+	return cpuhp_setup_state(CPUHP_AP_DTPM_CPU_ONLINE,
+				 "dtpm_cpu:online",
+				 cpuhp_dtpm_cpu_online,
+				 cpuhp_dtpm_cpu_offline);
+}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bc56287a1ed1..72fd8db62342 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -192,6 +192,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
+	CPUHP_AP_DTPM_CPU_ONLINE,
 	CPUHP_AP_ACTIVE,
 	CPUHP_ONLINE,
 };
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 84b087b4ac01..723fe51f1628 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -73,4 +73,6 @@ void dtpm_unregister(struct dtpm *dtpm);
 
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
+int dtpm_register_cpu(struct dtpm *parent);
+
 #endif
-- 
2.17.1

