Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7127D955
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgI2UzV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 16:55:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbgI2UzV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Sep 2020 16:55:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94AF431B;
        Tue, 29 Sep 2020 13:55:20 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CED1D3F73B;
        Tue, 29 Sep 2020 13:55:18 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     dietmar.eggemann@arm.com, qperret@google.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 1/3] sched/topology,schedutil: wrap sched domains rebuild
Date:   Tue, 29 Sep 2020 21:54:40 +0100
Message-Id: <20200929205442.24792-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929205442.24792-1-ionela.voinescu@arm.com>
References: <20200929205442.24792-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the rebuild_sched_domains_energy() function to wrap the functionality
that rebuilds the scheduling domains if any of the Energy Aware Scheduling
(EAS) initialisation conditions change. This functionality is used when
schedutil is added or removed or when EAS is enabled or disabled
through the sched_energy_aware sysctl.

Therefore, create a single function that is used in both these cases and
that can be later reused.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Quentin Perret <qperret@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched/topology.h   |  8 ++++++++
 kernel/sched/cpufreq_schedutil.c |  9 +--------
 kernel/sched/topology.c          | 18 +++++++++++-------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 9ef7bf686a9f..8f0f778b7c91 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -225,6 +225,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 
 #endif	/* !CONFIG_SMP */
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+extern void rebuild_sched_domains_energy(void);
+#else
+static inline void rebuild_sched_domains_energy(void)
+{
+}
+#endif
+
 #ifndef arch_scale_cpu_capacity
 /**
  * arch_scale_cpu_capacity - get the capacity scale factor of a given CPU.
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e39008242cf4..0337a9b025e1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -912,16 +912,9 @@ struct cpufreq_governor *cpufreq_default_governor(void)
 cpufreq_governor_init(schedutil_gov);
 
 #ifdef CONFIG_ENERGY_MODEL
-extern bool sched_energy_update;
-extern struct mutex sched_energy_mutex;
-
 static void rebuild_sd_workfn(struct work_struct *work)
 {
-	mutex_lock(&sched_energy_mutex);
-	sched_energy_update = true;
-	rebuild_sched_domains();
-	sched_energy_update = false;
-	mutex_unlock(&sched_energy_mutex);
+	rebuild_sched_domains_energy();
 }
 static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 55c453d140e9..e0a8e55e7df0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -211,6 +211,15 @@ unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
 
+void rebuild_sched_domains_energy(void)
+{
+	mutex_lock(&sched_energy_mutex);
+	sched_energy_update = true;
+	rebuild_sched_domains();
+	sched_energy_update = false;
+	mutex_unlock(&sched_energy_mutex);
+}
+
 #ifdef CONFIG_PROC_SYSCTL
 int sched_energy_aware_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
@@ -223,13 +232,8 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
-		if (state != sysctl_sched_energy_aware) {
-			mutex_lock(&sched_energy_mutex);
-			sched_energy_update = 1;
-			rebuild_sched_domains();
-			sched_energy_update = 0;
-			mutex_unlock(&sched_energy_mutex);
-		}
+		if (state != sysctl_sched_energy_aware)
+			rebuild_sched_domains_energy();
 	}
 
 	return ret;
-- 
2.17.1

