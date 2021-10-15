Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E438542F60C
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbhJOOsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 10:48:11 -0400
Received: from foss.arm.com ([217.140.110.172]:44052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235318AbhJOOsL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Oct 2021 10:48:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE4F1515;
        Fri, 15 Oct 2021 07:46:04 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.23.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 909993F66F;
        Fri, 15 Oct 2021 07:46:01 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Subject: [PATCH v2 1/5] arch_topology: Introduce thermal pressure update function
Date:   Fri, 15 Oct 2021 15:45:46 +0100
Message-Id: <20211015144550.23719-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015144550.23719-1-lukasz.luba@arm.com>
References: <20211015144550.23719-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal pressure is a mechanism which is used for providing
information about reduced CPU performance to the scheduler. Usually code
has to convert the value from frequency units into capacity units,
which are understandable by the scheduler. Create a common conversion code
which can be just used via a handy API.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 36 ++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h     |  3 +++
 include/linux/sched/topology.h    |  7 ++++++
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 470299ee2fba..aee6c456c085 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -24,6 +24,7 @@
 /* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
 #define arch_set_thermal_pressure   topology_set_thermal_pressure
+#define arch_thermal_pressure_update	topology_thermal_pressure_update
 
 #else
 
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index ec2db3419c41..c997015402bc 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -33,6 +33,7 @@ void update_freq_counters_refs(void);
 /* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
 #define arch_set_thermal_pressure   topology_set_thermal_pressure
+#define arch_thermal_pressure_update	topology_thermal_pressure_update
 
 #include <asm-generic/topology.h>
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 43407665918f..1fa28b5afdb2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -25,6 +25,7 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
+static DEFINE_PER_CPU(u32, freq_factor) = 1;
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
@@ -168,6 +169,40 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
 }
 EXPORT_SYMBOL_GPL(topology_set_thermal_pressure);
 
+/**
+ * topology_thermal_pressure_update() - Update thermal pressure for CPUs
+ * @cpus	: The related CPUs for which capacity has been reduced
+ * @capped_freq	: The maximum allowed frequency that CPUs can run at
+ *
+ * Update the value of thermal pressure for all @cpus in the mask. The
+ * cpumask should include all (online+offline) affected CPUs, to avoid
+ * operating on stale data when hot-plug is used for some CPUs. The
+ * @capped_freq must be less or equal to the max possible frequency and
+ * reflects the currently allowed max CPUs frequency due to thermal capping.
+ * The @capped_freq must be provided in kHz.
+ */
+void topology_thermal_pressure_update(const struct cpumask *cpus,
+				      unsigned long capped_freq)
+{
+	unsigned long max_capacity, capacity;
+	int cpu;
+
+	if (!cpus)
+		return;
+
+	cpu = cpumask_first(cpus);
+	max_capacity = arch_scale_cpu_capacity(cpu);
+
+	/* Convert to MHz scale which is used in 'freq_factor' */
+	capped_freq /= 1000;
+
+	capacity = mult_frac(capped_freq, max_capacity,
+			     per_cpu(freq_factor, cpu));
+
+	arch_set_thermal_pressure(cpus, max_capacity - capacity);
+}
+EXPORT_SYMBOL_GPL(topology_thermal_pressure_update);
+
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -220,7 +255,6 @@ static void update_topology_flags_workfn(struct work_struct *work)
 	update_topology = 0;
 }
 
-static DEFINE_PER_CPU(u32, freq_factor) = 1;
 static u32 *raw_capacity;
 
 static int free_raw_capacity(void)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index f180240dc95f..9e183621a59b 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -59,6 +59,9 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
 void topology_set_thermal_pressure(const struct cpumask *cpus,
 				   unsigned long th_pressure);
 
+void topology_thermal_pressure_update(const struct cpumask *cpus,
+				      unsigned long capped_freq);
+
 struct cpu_topology {
 	int thread_id;
 	int core_id;
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..990d14814427 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -266,6 +266,13 @@ void arch_set_thermal_pressure(const struct cpumask *cpus,
 { }
 #endif
 
+#ifndef arch_thermal_pressure_update
+static __always_inline
+void arch_thermal_pressure_update(const struct cpumask *cpus,
+				      unsigned long capped_frequency)
+{ }
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.17.1

