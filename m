Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422DA2107AF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgGAJJ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:59 -0400
Received: from foss.arm.com ([217.140.110.172]:47902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbgGAJJr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9949213FD;
        Wed,  1 Jul 2020 02:09:46 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2AF93F68F;
        Wed,  1 Jul 2020 02:09:44 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] arch_topology,arm64: define arch_scale_freq_invariant()
Date:   Wed,  1 Jul 2020 10:07:50 +0100
Message-Id: <20200701090751.7543-8-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701090751.7543-1-ionela.voinescu@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/topology.c  | 7 +++++++
 drivers/base/arch_topology.c  | 6 ++++++
 include/linux/arch_topology.h | 4 ++++
 3 files changed, 17 insertions(+)

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
index 8447e1f30340..8686771b866d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -21,6 +21,12 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
+bool topology_scale_freq_invariant(void)
+{
+	return cpufreq_sets_freq_scale() ||
+	       arch_freq_counters_available(cpu_online_mask);
+}
+
 __weak bool arch_freq_counters_available(const struct cpumask *cpus)
 {
 	return false;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 4be0315700cb..6272fbc05cde 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -53,6 +53,10 @@ struct cpu_topology {
 };
 
 #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
+
+extern bool topology_scale_freq_invariant(void);
+#define arch_scale_freq_invariant() topology_scale_freq_invariant()
+
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
 #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
-- 
2.17.1

