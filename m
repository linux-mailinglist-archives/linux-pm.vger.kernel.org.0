Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EC2255FCD
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 19:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgH1ReH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 13:34:07 -0400
Received: from foss.arm.com ([217.140.110.172]:54184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgH1ReF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 13:34:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF9C1FB;
        Fri, 28 Aug 2020 10:34:05 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A62673F71F;
        Fri, 28 Aug 2020 10:34:03 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v4 5/5] arch_topology, arm, arm64: define arch_scale_freq_invariant()
Date:   Fri, 28 Aug 2020 18:33:03 +0100
Message-Id: <20200828173303.11939-6-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828173303.11939-1-ionela.voinescu@arm.com>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

arch_scale_freq_invariant() is used by schedutil to determine whether
the scheduler's load-tracking signals are frequency invariant. Its
definition is overridable, though by default it is hardcoded to 'true'
if arch_scale_freq_capacity() is defined ('false' otherwise).

This behaviour is not overridden on arm, arm64 and other users of the
generic arch topology driver, which is somewhat precarious:
arch_scale_freq_capacity() will always be defined, yet not all cpufreq
drivers are guaranteed to drive the frequency invariance scale factor
setting. In other words, the load-tracking signals may very well *not*
be frequency invariant.

Now that cpufreq can be queried on whether the current driver is driving
the Frequency Invariance (FI) scale setting, the current situation can
be improved. This combines the query of whether cpufreq supports the
setting of the frequency scale factor, with whether all online CPUs are
counter-based FI enabled.

While cpufreq FI enablement applies at system level, for all CPUs,
counter-based FI support could also be used for only a subset of CPUs to
set the invariance scale factor. Therefore, if cpufreq-based FI support
is present, we consider the system to be invariant. If missing, we
require all online CPUs to be counter-based FI enabled in order for the
full system to be considered invariant.

If the system ends up not being invariant, a new condition is needed in
the counter initialization code that disables all scale factor setting
based on counters.

Precedence of counters over cpufreq use is not important here. The
invariant status is only given to the system if all CPUs have at least
one method of setting the frequency scale factor.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/include/asm/topology.h   | 1 +
 arch/arm64/include/asm/topology.h | 1 +
 arch/arm64/kernel/topology.c      | 7 +++++++
 drivers/base/arch_topology.c      | 6 ++++++
 include/linux/arch_topology.h     | 2 ++
 5 files changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index e0593cf095d0..9219e67befbe 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -9,6 +9,7 @@
 
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_capacity topology_get_freq_scale
+#define arch_scale_freq_invariant topology_scale_freq_invariant
 
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index e042f6527981..7cb519473fbd 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -27,6 +27,7 @@ void topology_scale_freq_tick(void);
 
 /* Replace task scheduler's default frequency-invariant accounting */
 #define arch_scale_freq_capacity topology_get_freq_scale
+#define arch_scale_freq_invariant topology_scale_freq_invariant
 
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 9a9f2b8dedf5..4064d39bb66d 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -246,6 +246,13 @@ static int __init init_amu_fie(void)
 		static_branch_enable(&amu_fie_key);
 	}
 
+	/*
+	 * If the system is not fully invariant after AMU init, disable
+	 * partial use of counters for frequency invariance.
+	 */
+	if (!topology_scale_freq_invariant())
+		static_branch_disable(&amu_fie_key);
+
 free_valid_mask:
 	free_cpumask_var(valid_cpus);
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6d304f0eb810..1705c772c273 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,6 +21,12 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
+bool topology_scale_freq_invariant(void)
+{
+	return cpufreq_supports_freq_invariance() ||
+	       arch_freq_counters_available(cpu_online_mask);
+}
+
 __weak bool arch_freq_counters_available(const struct cpumask *cpus)
 {
 	return false;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 810c83336257..083df331a3c9 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -30,6 +30,8 @@ static inline unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
+bool topology_scale_freq_invariant(void);
+
 bool arch_freq_counters_available(const struct cpumask *cpus);
 
 DECLARE_PER_CPU(unsigned long, thermal_pressure);
-- 
2.17.1

