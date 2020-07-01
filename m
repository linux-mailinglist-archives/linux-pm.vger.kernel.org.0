Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE112107AA
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgGAJJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:45 -0400
Received: from foss.arm.com ([217.140.110.172]:47876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbgGAJJo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5002139F;
        Wed,  1 Jul 2020 02:09:43 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CA303F68F;
        Wed,  1 Jul 2020 02:09:41 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] arch_topology,cpufreq,sched/core: constify arch_* cpumasks
Date:   Wed,  1 Jul 2020 10:07:49 +0100
Message-Id: <20200701090751.7543-7-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701090751.7543-1-ionela.voinescu@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

The passed cpumask arguments to:
 - arch_set_freq_scale(),
 - arch_set_thermal_pressure(), and
 - arch_freq_counters_available()

are only iterated over, so reflect this in the prototype. This also
allows to pass system cpumasks like cpu_online_mask without getting
a warning.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm64/kernel/topology.c  | 2 +-
 drivers/base/arch_topology.c  | 4 ++--
 drivers/cpufreq/cpufreq.c     | 5 +++--
 include/linux/arch_topology.h | 4 ++--
 include/linux/cpufreq.h       | 3 ++-
 kernel/sched/core.c           | 2 +-
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0801a0f3c156..9a9f2b8dedf5 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -253,7 +253,7 @@ static int __init init_amu_fie(void)
 }
 late_initcall_sync(init_amu_fie);
 
-bool arch_freq_counters_available(struct cpumask *cpus)
+bool arch_freq_counters_available(const struct cpumask *cpus)
 {
 	return amu_freq_invariant() &&
 	       cpumask_subset(cpus, amu_fie_cpus);
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4d0a0038b476..8447e1f30340 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,13 +21,13 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
-__weak bool arch_freq_counters_available(struct cpumask *cpus)
+__weak bool arch_freq_counters_available(const struct cpumask *cpus)
 {
 	return false;
 }
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
-void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
+void arch_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
 			 unsigned long max_freq)
 {
 	unsigned long scale;
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 60b5272c5d80..161b8089b0f6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -177,8 +177,9 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time);
 
-__weak void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
-		unsigned long max_freq)
+__weak void arch_set_freq_scale(const struct cpumask *cpus,
+				unsigned long cur_freq,
+				unsigned long max_freq)
 {
 }
 EXPORT_SYMBOL_GPL(arch_set_freq_scale);
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0566cb3314ef..4be0315700cb 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -30,7 +30,7 @@ static inline unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
-bool arch_freq_counters_available(struct cpumask *cpus);
+bool arch_freq_counters_available(const struct cpumask *cpus);
 
 DECLARE_PER_CPU(unsigned long, thermal_pressure);
 
@@ -39,7 +39,7 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
 	return per_cpu(thermal_pressure, cpu);
 }
 
-void arch_set_thermal_pressure(struct cpumask *cpus,
+void arch_set_thermal_pressure(const struct cpumask *cpus,
 			       unsigned long th_pressure);
 
 struct cpu_topology {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 8b6369d657bd..23398133c24b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1003,7 +1003,8 @@ static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
 extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
-extern void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
+extern void arch_set_freq_scale(const struct cpumask *cpus,
+				unsigned long cur_freq,
 				unsigned long max_freq);
 
 /* the following are really really optional */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f518af52d0fb..b44a42b1236c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3645,7 +3645,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 
 DEFINE_PER_CPU(unsigned long, thermal_pressure);
 
-void arch_set_thermal_pressure(struct cpumask *cpus,
+void arch_set_thermal_pressure(const struct cpumask *cpus,
 			       unsigned long th_pressure)
 {
 	int cpu;
-- 
2.17.1

