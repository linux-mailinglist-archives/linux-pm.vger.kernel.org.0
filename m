Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F05255FD1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgH1ReR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 13:34:17 -0400
Received: from foss.arm.com ([217.140.110.172]:54172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgH1ReD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 13:34:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB59106F;
        Fri, 28 Aug 2020 10:34:02 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 647213F71F;
        Fri, 28 Aug 2020 10:34:01 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v4 4/5] arch_topology, cpufreq: constify arch_* cpumasks
Date:   Fri, 28 Aug 2020 18:33:02 +0100
Message-Id: <20200828173303.11939-5-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828173303.11939-1-ionela.voinescu@arm.com>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

The passed cpumask arguments to arch_set_freq_scale() and
arch_freq_counters_available() are only iterated over, so reflect this
in the prototype. This also allows to pass system cpumasks like
cpu_online_mask without getting a warning.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c  | 2 +-
 drivers/base/arch_topology.c  | 4 ++--
 drivers/cpufreq/cpufreq.c     | 5 +++--
 include/linux/arch_topology.h | 2 +-
 include/linux/cpufreq.h       | 3 ++-
 5 files changed, 9 insertions(+), 7 deletions(-)

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
index 5708eb724790..6d304f0eb810 100644
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
index f97c743a988d..fe1f7606b899 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -160,8 +160,9 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
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
index 69b1dabe39dc..810c83336257 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -30,7 +30,7 @@ static inline unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
-bool arch_freq_counters_available(struct cpumask *cpus);
+bool arch_freq_counters_available(const struct cpumask *cpus);
 
 DECLARE_PER_CPU(unsigned long, thermal_pressure);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 091df9968945..8f22072c8d90 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1011,7 +1011,8 @@ static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
 extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
-extern void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
+extern void arch_set_freq_scale(const struct cpumask *cpus,
+				unsigned long cur_freq,
 				unsigned long max_freq);
 
 /* the following are really really optional */
-- 
2.17.1

