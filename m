Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827202CAC62
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbgLATaC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 14:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404324AbgLATaC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 14:30:02 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1482C061A4A
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 11:29:10 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so4478731wrw.10
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VOd3JSDgGEf/sA/gneW99yzrnw1TXcmtGN43mHDRXQY=;
        b=T09eoCIyyL0p97FRT3WIcvf3dvO1HjfeGP1LTk6iswcKA1VIKznSxtVnYUSVzXJGWs
         wRgcBydqKmJESEMxQca3qn89xmbZXmilx6wPepjrzrBt+Q9FSs/yJeU5flGyDGAQiHqr
         mRowDXJ+OLvS1TF/yWi2jWgkRB6rmpKilaoXuMmgd00ryW4WRmreOXQz3mHkn7kJVyph
         yQtbLqsmsYkNYXbWf9sbG3IhmiQZpUeBS7eYSaZVcf6AFoUZHTJBsqEBUnL09VD2RIs9
         lj33v+S1ukAs/vVaRHVYpsh7KSYN2lzx9fSqvq83hEioU+M9aXNzzdMZn5pzJ3BomJlI
         5BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VOd3JSDgGEf/sA/gneW99yzrnw1TXcmtGN43mHDRXQY=;
        b=GvhtkyprVncrvbZzLkGObnVbkMl68I6/QtKiDGyrBqIQmBW2MV8qaMN6PBpZpSS6C1
         gpz2xvL/gRdt6OK9paZLg1yx/6vKnxVlnbJytGr31A9jI7ZPfp3iSx/VHErSJqcNJiGL
         O2uHSAGbv17jgTqfDlN2N9jezIIjT/x355Ejh7bfsrqkV7zm4j3blCm0ptod1K33Kl/G
         rSqONeL/TMCIpy1cMK8Xw16dzR+xvB94hbiynyOvSHaEFV+GPaZ9bjTYe6AI07ZGxxzz
         i4nWk2Pp8KJcCduPofK0CkCixKWlMDvNrSMLe7kC2s4Nu7SK+x24HRrb/YUv7ZL5FSbD
         trKw==
X-Gm-Message-State: AOAM532lQ2Yy+/ekWUdH0UhDTPQgkDQocvx19TNeZQLHM/flAWk2nQGe
        gSH3pvCBd1WP2Mdgk+28/Y2qeA==
X-Google-Smtp-Source: ABdhPJxquZkyO9JsBW4vJGPgahoZbAmqxDm4OKYyraAIIDQZUIJFE1wOB935o+StRfbXRxp+w9OyFQ==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr5848029wrm.259.1606850949389;
        Tue, 01 Dec 2020 11:29:09 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-140-184.adsl.proxad.net. [82.252.140.184])
        by smtp.gmail.com with ESMTPSA id n123sm1317922wmn.7.2020.12.01.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:29:08 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zqiang <qiang.zhang@windriver.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Leach <mike.leach@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Andrew Jones <drjones@redhat.com>
Subject: [PATCH v4 4/4] powercap/drivers/dtpm: Add CPU energy model based support
Date:   Tue,  1 Dec 2020 20:28:01 +0100
Message-Id: <20201201192801.27607-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201192801.27607-1-daniel.lezcano@linaro.org>
References: <20201201192801.27607-1-daniel.lezcano@linaro.org>
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

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig    |   7 +
 drivers/powercap/Makefile   |   1 +
 drivers/powercap/dtpm_cpu.c | 257 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h  |   1 +
 include/linux/dtpm.h        |   2 +
 5 files changed, 268 insertions(+)
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
index 000000000000..6933c783c6b4
--- /dev/null
+++ b/drivers/powercap/dtpm_cpu.c
@@ -0,0 +1,257 @@
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
+	if (freq_qos_request_active(&dtpm_cpu->qos_req))
+		freq_qos_remove_request(&dtpm_cpu->qos_req);
+
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
+	int ret = -ENOMEM;
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
+	if (!dtpm_cpu)
+		goto out_kfree_dtpm;
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
+		goto out_dtpm_unregister;
+
+	ret = freq_qos_add_request(&policy->constraints,
+				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
+				   pd->table[pd->nr_perf_states - 1].frequency);
+	if (ret)
+		goto out_power_sub;
+
+	return 0;
+
+out_power_sub:
+	power_sub(dtpm, pd);
+
+out_dtpm_unregister:
+	dtpm_unregister(dtpm);
+	dtpm_cpu = NULL;
+	dtpm = NULL;
+
+out_kfree_dtpm_cpu:
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(dtpm_per_cpu, cpu) = NULL;
+	kfree(dtpm_cpu);
+
+out_kfree_dtpm:
+	kfree(dtpm);
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
index 7a1d0b50e334..e80a332e3d8a 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -72,4 +72,6 @@ void dtpm_unregister(struct dtpm *dtpm);
 
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
 
+int dtpm_register_cpu(struct dtpm *parent);
+
 #endif
-- 
2.17.1

