Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60210277136
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgIXMkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:40:22 -0400
Received: from foss.arm.com ([217.140.110.172]:45092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgIXMkU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 08:40:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 382BD152B;
        Thu, 24 Sep 2020 05:40:19 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 662DB3F73B;
        Thu, 24 Sep 2020 05:40:17 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, qperret@google.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 3/3] arm64: rebuild sched domains on invariance status changes
Date:   Thu, 24 Sep 2020 13:39:37 +0100
Message-Id: <20200924123937.20938-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924123937.20938-1-ionela.voinescu@arm.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Task scheduler behavior depends on frequency invariance (FI) support and
the resulting invariant load tracking signals. For example, in order to
make accurate predictions across CPUs for all performance states, Energy
Aware Scheduling (EAS) needs frequency-invariant load tracking signals
and therefore it has a direct dependency on FI. If a platform is found
lacking FI support, EAS is disabled.

While arch_scale_freq_invariant() will see changes in FI support, it
could return different values during system initialisation. Such a
scenario will happen for a system that does not support cpufreq driven
FI, but does support counter-driven FI. For such a system,
arch_scale_freq_invariant() will return false if called before counter
based FI initialisation, but change its status to true after it.

For arm64 this affects the task scheduler behavior which builds its
scheduling domain hierarchy well before the late counter-based FI init.
During that process it will disable EAS due to its dependency on FI.

Two points of early calls to arch_scale_freq_invariant() which determine
EAS enablement are:
 - (1) drivers/base/arch_topology.c:126 <<update_topology_flags_workfn>>
		rebuild_sched_domains();
       This will happen after CPU capacity initialisation.
 - (2) kernel/sched/cpufreq_schedutil.c:917 <<rebuild_sd_workfn>>
		rebuild_sched_domains_energy();
		-->rebuild_sched_domains();
       This will happen during sched_cpufreq_governor_change() for the
       schedutil cpufreq governor.

Therefore, if there is a change in FI support status after counter init,
use the existing rebuild_sched_domains_energy() function to trigger a
rebuild of the scheduling and performance domains that in turn determine
the enablement of EAS.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/topology.h |  1 +
 arch/arm64/kernel/topology.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 7cb519473fbd..9394101e3c08 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -16,6 +16,7 @@ int pcibus_to_node(struct pci_bus *bus);
 
 #include <linux/arch_topology.h>
 
+void rebuild_sched_domains_energy(void);
 #ifdef CONFIG_ARM64_AMU_EXTN
 /*
  * Replace task scheduler's default counter-based
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 543c67cae02f..2a9b69fdabc9 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -213,6 +213,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
 
 static int __init init_amu_fie(void)
 {
+	bool invariance_status = topology_scale_freq_invariant();
 	cpumask_var_t valid_cpus;
 	bool have_policy = false;
 	int ret = 0;
@@ -255,6 +256,15 @@ static int __init init_amu_fie(void)
 	if (!topology_scale_freq_invariant())
 		static_branch_disable(&amu_fie_key);
 
+	/*
+	 * Task scheduler behavior depends on frequency invariance support,
+	 * either cpufreq or counter driven. If the support status changes as
+	 * a result of counter initialisation and use, retrigger the build of
+	 * scheduling domains to ensure the information is propagated properly.
+	 */
+	if (invariance_status != topology_scale_freq_invariant())
+		rebuild_sched_domains_energy();
+
 free_valid_mask:
 	free_cpumask_var(valid_cpus);
 
-- 
2.17.1

