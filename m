Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEDD284B8C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgJFMVO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgJFMVN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:21:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECC4C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 05:21:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so7464044wrq.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t0N69QCkcOuVUePm6DDLzLJ3FPaHM4LOMBGRQnTz/dA=;
        b=c6M1Lc+afDx4uhXXLf/SzKWfMa1oMBn+neWQFcy0qgimYoNn3V8OX9CGf3VVdO0nHu
         hcGjXSMi3vDhg/Kmhz2XI9wZafkHYzgOgduPcBg0yY9ISM06OMitmPHzN0IBvOpec/hL
         PORQndl1bNHVYio4O5Iyu8Cab0l9+FkOsgcLoIksEacjXQ38EPdEn2u/nqiOIpLTiOnR
         Qut+1MyXGzgJgQ+QyVA0pziFxtdUWmWBz1L8H2gJY7pDm6m1k/UhM00YsaeDE/0BNagT
         ZMSrssg0lFzvjTPpjHaGDaoG8mX1PsUQFyOWmy50ZH6cPejf93nbKf7JSfcXezGbwDlJ
         gEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t0N69QCkcOuVUePm6DDLzLJ3FPaHM4LOMBGRQnTz/dA=;
        b=h7vlZJw4+k1FyGDznnOg8wZwTX/hAZ27pH8obkBiUuw4tGPW655F28qxd3IblW5myU
         vPOeHUHtVrP/G5yoUh8m5+WpdqKRJT1iXSAvRDha/oB8KjRh7kziGjOkh5BtdIpVjWSb
         G+6RMw2VYm/CHjRH8AfPIo+pGRC4XEq7PtcjnubsNvxdnwcIDvZPJpKZT6Y7GmSr2SCQ
         1XBsG20I9mYqleuUq9JVbC6liCywR9qf/+sRotbQLP8Ud3x2X80Hu1gS05MeDb9n8nm+
         WSiZ07dQUXK7cuqlc82fyC1LvrUl3ue5NpTBjf7ubvaTcIjXWclPxct1X55IjYLoLPbI
         39WQ==
X-Gm-Message-State: AOAM5329xpimApOrDe05uu2Mn2GKLzCG7WjGPP7mp7K+V2FWKdJoGblD
        XTc4ZSME3FThljIuVGe/6f0DeQ==
X-Google-Smtp-Source: ABdhPJwC89P7MlUrxsd5DJ5eTfNxbp0oV1tGR0OA2BskLMPr8AeOjhS6QyRdMMLfIDKJ9tTZ+YtRBA==
X-Received: by 2002:adf:eb04:: with SMTP id s4mr4963161wrn.81.1601986871692;
        Tue, 06 Oct 2020 05:21:11 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-130-8.adsl.proxad.net. [82.252.130.8])
        by smtp.gmail.com with ESMTPSA id s19sm3742521wmc.41.2020.10.06.05.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:21:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH 4/4] powercap/drivers/dtpm: Add CPU energy model based support
Date:   Tue,  6 Oct 2020 14:20:24 +0200
Message-Id: <20201006122024.14539-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006122024.14539-1-daniel.lezcano@linaro.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With the powercap dtpm controller, we are able to plug devices with
power limitation features in the tree.

The following patch introduces the CPU power limitation based on the
energy model and the performance states.

The power limitation is done at the performance domain level. If some
CPUs are unplugged, the corresponding power will be substracted from
the performance domain total power.

It is up to the platform to initialize the dtpm tree and add the CPU.

Here is an example to create a simple tree with one root node called
"pkg" and the cpu's performance domains.

int dtpm_register_pkg(struct dtpm_descr *descr)
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

struct dtpm_descr descr = {
	.name = "pkg",
	.init = dtpm_register_pkg,
};
DTPM_DECLARE(descr);

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/Kconfig    |   8 ++
 drivers/powercap/Makefile   |   1 +
 drivers/powercap/dtpm_cpu.c | 242 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h  |   1 +
 include/linux/dtpm.h        |   3 +
 5 files changed, 255 insertions(+)
 create mode 100644 drivers/powercap/dtpm_cpu.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index 777cf60300b8..240dc09e8dc2 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -49,4 +49,12 @@ config DTPM
 	help
 	  This enables support for the power capping for the dynamic
 	  thermal management userspace engine.
+
+config DTPM_CPU
+	bool "Add CPU power capping based on the energy model"
+	depends on DTPM && ENERGY_MODEL
+	help
+	  This enables support for CPU power limitation based on
+	  energy model.
+
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
index 000000000000..23ebf704c599
--- /dev/null
+++ b/drivers/powercap/dtpm_cpu.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
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
+	unsigned long freq;
+	int i, nr_cpus;
+
+	spin_lock(&dtpm->lock);
+
+	power_limit = clamp_val(power_limit, dtpm->power_min, dtpm->power_max);
+
+	pd = em_cpu_get(dtpm_cpu->cpu);
+
+	nr_cpus = cpumask_weight(to_cpumask(pd->cpus));
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		u64 power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+
+		if ((power * nr_cpus) > power_limit)
+			break;
+	}
+
+	freq = pd->table[i - 1].frequency;
+
+	freq_qos_update_request(&dtpm_cpu->qos_req, freq);
+
+	dtpm->power_limit = power_limit;
+
+	spin_unlock(&dtpm->lock);
+
+	return 0;
+}
+
+static int get_pd_power_limit(struct powercap_zone *pcz, int cid, u64 *data)
+{
+	struct dtpm *dtpm = to_dtpm(pcz);
+
+	spin_lock(&dtpm->lock);
+	*data = dtpm->power_max;
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
+	if (!dtpm_cpu)
+		return -ENOMEM;
+
+	dtpm->private = dtpm_cpu;
+	dtpm_cpu->cpu = cpu;
+
+	for_each_cpu(cpu, policy->related_cpus)
+		per_cpu(dtpm_per_cpu, cpu) = dtpm;
+
+	ret = power_add(dtpm, pd);
+	if (ret)
+		return ret;
+
+	dtpm->power_limit = dtpm->power_max;
+
+	sprintf(name, "cpu%d", dtpm_cpu->cpu);
+
+	ret = dtpm_register(name, dtpm, __parent, &pd_zone_ops,
+			    1, &pd_constraint_ops);
+	if (ret)
+		return ret;
+
+	ret = freq_qos_add_request(&policy->constraints,
+				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
+				   pd->table[pd->nr_perf_states - 1].frequency);
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
index bf9181cef444..6792bad4a435 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -190,6 +190,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
 	CPUHP_AP_X86_HPET_ONLINE,
 	CPUHP_AP_X86_KVM_CLK_ONLINE,
+	CPUHP_AP_DTPM_CPU_ONLINE,
 	CPUHP_AP_ACTIVE,
 	CPUHP_ONLINE,
 };
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index 6696bdcfdb87..b62215a13baa 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -70,4 +70,7 @@ int dtpm_register_parent(const char *name, struct dtpm *dtpm,
 int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent,
 		  struct powercap_zone_ops *ops, int nr_constraints,
 		  struct powercap_zone_constraint_ops *const_ops);
+
+int dtpm_register_cpu(struct dtpm *parent);
+
 #endif
-- 
2.17.1

