Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74092B4938
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgKPP1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 10:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731427AbgKPP1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 10:27:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42EC0613D1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 10so24090079wml.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhwqW6rmO79dCZcrlZX8a+exBQddCZ9e0EBD0lwHzSw=;
        b=f4FKNxZPao/xmyLEfIMKW/VYGhxANg2DoAxCWF7OKQ0R3Ts72PYU59CfNEJhseJZPZ
         IuFbQfA+bKcw4YzRYhGgRnofMnR/nZgnJdvNboFvpnqgfbQg6hiuueR6ly3az5n/vnEG
         6pWQ63AilymIQLakV19lzlpd/i35iYkkKIOVxSezg4flzPBCqwDinzvfhHgsZMeg6L3W
         CChUKhdiJju5omTh2mlPw/c0IFRHIXQyTi5B9G43iTRdbnJgLK9vhnE3QzRQ3zIh/juq
         HGPx5i/Bo0XwZR9ngzwg4I/vvoeQKKgAmLTOmneewC6H+NhmAYTcx1TW+EHpSyka10sg
         tN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhwqW6rmO79dCZcrlZX8a+exBQddCZ9e0EBD0lwHzSw=;
        b=TyE4Zc3krCQIxsA64emGupdwRpzyT8vGuUs22XK8ARFv5ghIdodZNLF5H9p28iRnZc
         UMPAWQOU52GfhMCW933BfjdvCG+V0GOxN97ZDRIMGJVszVv+lgeJoRE4DCdf/Or1Jpz+
         hnZQ2mQWqidyMZJXQTeE+XSrtR2NQRGvrHEGWanW3wa8tdiiRGarPNWznSSz6TztCZbg
         W7EzTtrrOferX9Nfdpx/PqLNkYBcOyxU6FYv7xrHGO3Ea1SSdBWnWUze8gyFtLwdL7iR
         dwTZKijldrc0Nq1O6WaZZDB5tbqElFqZW5A2Pz3LMBI7T90sloMVCmVTSTxZylSg57L2
         1aGg==
X-Gm-Message-State: AOAM531uWQ+XHIFPWlL16Hl6TYZ06cUgR4+jmw2anOmZSrEGuEHYcqDX
        DGUgHjYBBm3v7/39Ejl8myZTYg==
X-Google-Smtp-Source: ABdhPJzcK6y56mijg2ie/8pjVPzTCzgrb6/wyQBuDn/to9IWatJFP5biakSuDDP026GcCrC5cpk3PA==
X-Received: by 2002:a1c:2d84:: with SMTP id t126mr138126wmt.132.1605540434982;
        Mon, 16 Nov 2020 07:27:14 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-240.adsl.proxad.net. [82.252.135.240])
        by smtp.gmail.com with ESMTPSA id k20sm19930453wmi.15.2020.11.16.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:27:14 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ilina@codeaurora.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rkumbako@codeaurora.org, rui.zhang@intel.com
Subject: [PATCH v2 4/4] powercap/drivers/dtpm: Add CPU energy model based support
Date:   Mon, 16 Nov 2020 16:26:49 +0100
Message-Id: <20201116152649.11482-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116152649.11482-1-daniel.lezcano@linaro.org>
References: <20201116152649.11482-1-daniel.lezcano@linaro.org>
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

	pkg = dtpm_alloc();
	if (!pkg)
		return -ENOMEM;

	ret = dtpm_register_parent(descr->name, pkg, descr->parent);
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
 drivers/powercap/dtpm_cpu.c | 282 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h  |   1 +
 include/linux/dtpm.h        |   3 +
 5 files changed, 294 insertions(+)
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
index 000000000000..6bff5f27d891
--- /dev/null
+++ b/drivers/powercap/dtpm_cpu.c
@@ -0,0 +1,282 @@
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
+static int set_pd_power_limit(struct powercap_zone *pcz, int cid,
+			      u64 power_limit)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct em_perf_domain *pd;
+	struct cpumask cpus;
+	unsigned long freq;
+	u64 power;
+	int i, nr_cpus;
+
+	spin_lock(&dtpm->lock);
+
+	power_limit = clamp_val(power_limit, dtpm->power_min, dtpm->power_max);
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
+	dtpm->power_limit = pd->table[i - 1].power *
+		MICROWATT_PER_MILLIWATT * nr_cpus;
+
+	spin_unlock(&dtpm->lock);
+
+	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
+
+	return 0;
+}
+
+static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+
+	spin_lock(&dtpm->lock);
+	*data = dtpm->power_limit;
+	spin_unlock(&dtpm->lock);
+
+	return 0;
+}
+
+static int get_pd_power_uw(struct powercap_zone *pcz, u64 *power_uw)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+	struct em_perf_domain *pd;
+	unsigned long freq;
+	int i, nr_cpus;
+
+	freq = cpufreq_quick_get(dtpm_cpu->cpu);
+	pd = em_cpu_get(dtpm_cpu->cpu);
+	nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		if (pd->table[i].frequency < freq)
+			continue;
+
+		*power_uw = pd->table[i].power *
+			MICROWATT_PER_MILLIWATT * nr_cpus;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int cpu_release_zone(struct powercap_zone *pcz)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+	struct dtpm_cpu *dtpm_cpu = dtpm->private;
+
+	freq_qos_remove_request(&dtpm_cpu->qos_req);
+	kfree(dtpm_cpu);
+
+	return dtpm_release_zone(pcz);
+}
+
+static struct powercap_zone_constraint_ops pd_constraint_ops = {
+	.set_power_limit_uw = set_pd_power_limit,
+	.get_power_limit_uw = get_pd_power_limit,
+};
+
+static struct powercap_zone_ops pd_zone_ops = {
+	.get_power_uw = get_pd_power_uw,
+	.release = cpu_release_zone,
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
+        struct dtpm *dtpm;
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
+	dtpm = dtpm_alloc();
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
+	ret = power_add(dtpm, pd);
+	if (ret)
+		goto out_kfree_dtpm_cpu;
+
+	dtpm->power_limit = dtpm->power_max;
+
+	sprintf(name, "cpu%d", dtpm_cpu->cpu);
+
+	ret = dtpm_register(name, dtpm, __parent, &pd_zone_ops,
+			    1, &pd_constraint_ops);
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
index 899d9d8fbccf..fece9bede28b 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -69,4 +69,7 @@ int dtpm_register_parent(const char *name, struct dtpm *dtpm,
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent,
 		  struct powercap_zone_ops *ops, int nr_constraints,
 		  struct powercap_zone_constraint_ops *const_ops);
+
+int dtpm_register_cpu(struct dtpm *parent);
+
 #endif
-- 
2.17.1

