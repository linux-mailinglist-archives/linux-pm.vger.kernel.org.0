Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C10277107
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgIXMav (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:30:51 -0400
Received: from foss.arm.com ([217.140.110.172]:44622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgIXMau (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 08:30:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F8E1396;
        Thu, 24 Sep 2020 05:30:50 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4A043F73B;
        Thu, 24 Sep 2020 05:30:48 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH 1/2] cpufreq,arm,arm64: restructure definitions of arch_set_freq_scale()
Date:   Thu, 24 Sep 2020 13:30:15 +0100
Message-Id: <20200924123016.13427-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924123016.13427-1-ionela.voinescu@arm.com>
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Compared to other arch_* functions, arch_set_freq_scale() has an atypical
weak definition that can be replaced by a strong architecture specific
implementation.

The more typical support for architectural functions involves defining
an empty stub in a header file if the symbol is not already defined in
architecture code. Some examples involve:
 - #define arch_scale_freq_capacity	topology_get_freq_scale
 - #define arch_scale_freq_invariant	topology_scale_freq_invariant
 - #define arch_scale_cpu_capacity	topology_get_cpu_scale
 - #define arch_update_cpu_topology	topology_update_cpu_topology
 - #define arch_scale_thermal_pressure	topology_get_thermal_pressure
 - #define arch_set_thermal_pressure	topology_set_thermal_pressure

Bring arch_set_freq_scale() in line with these functions by renaming it to
topology_set_freq_scale() in the arch topology driver, and by defining the
arch_set_freq_scale symbol to point to the new function for arm and arm64.

While there are other users of the arch_topology driver, this patch defines
arch_set_freq_scale for arm and arm64 only, due to their existing
definitions of arch_scale_freq_capacity. This is the getter function of the
frequency invariance scale factor and without a getter function, the
setter function - arch_set_freq_scale() has not purpose.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      |  4 ++--
 drivers/cpufreq/cpufreq.c         |  7 -------
 include/linux/arch_topology.h     |  2 ++
 include/linux/cpufreq.h           | 11 ++++++++---
 6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 9219e67befbe..e5e3d5ce4d55 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -8,6 +8,7 @@
 #include <linux/arch_topology.h>
 
 /* Replace task scheduler's default frequency-invariant accounting */
+#define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
 
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 7cb519473fbd..11a465243f66 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -26,6 +26,7 @@ void topology_scale_freq_tick(void);
 #endif /* CONFIG_ARM64_AMU_EXTN */
 
 /* Replace task scheduler's default frequency-invariant accounting */
+#define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1705c772c273..ae5a596bcf86 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -33,8 +33,8 @@ __weak bool arch_freq_counters_available(const struct cpumask *cpus)
 }
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
-void arch_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
-			 unsigned long max_freq)
+void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
+			     unsigned long max_freq)
 {
 	unsigned long scale;
 	int i;
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2ea245a6c0c0..f34d3a3d5ba6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -160,13 +160,6 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time);
 
-__weak void arch_set_freq_scale(const struct cpumask *cpus,
-				unsigned long cur_freq,
-				unsigned long max_freq)
-{
-}
-EXPORT_SYMBOL_GPL(arch_set_freq_scale);
-
 /*
  * This is a generic cpufreq init() routine which can be used by cpufreq
  * drivers of SMP systems. It will do following:
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 083df331a3c9..0f6cd6b73a61 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -30,6 +30,8 @@ static inline unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
+void topology_set_freq_scale(const struct cpumask *cpus, unsigned long cur_freq,
+			     unsigned long max_freq);
 bool topology_scale_freq_invariant(void);
 
 bool arch_freq_counters_available(const struct cpumask *cpus);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9f779fbdbe7b..fa37b1c66443 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1011,9 +1011,14 @@ static inline void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
 extern void arch_freq_prepare_all(void);
 extern unsigned int arch_freq_get_on_cpu(int cpu);
 
-extern void arch_set_freq_scale(const struct cpumask *cpus,
-				unsigned long cur_freq,
-				unsigned long max_freq);
+#ifndef arch_set_freq_scale
+static __always_inline
+void arch_set_freq_scale(const struct cpumask *cpus,
+			 unsigned long cur_freq,
+			 unsigned long max_freq)
+{
+}
+#endif
 
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
-- 
2.17.1

