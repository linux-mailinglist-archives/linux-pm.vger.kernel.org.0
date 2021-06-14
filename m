Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ED23A6E9D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhFNTOw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 15:14:52 -0400
Received: from foss.arm.com ([217.140.110.172]:44282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233048AbhFNTOw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Jun 2021 15:14:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE86113E;
        Mon, 14 Jun 2021 12:12:48 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.5.127])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A8F43F694;
        Mon, 14 Jun 2021 12:12:45 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, lukasz.luba@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com, thara.gopinath@linaro.org,
        amit.kachhap@gmail.com, amitk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
Subject: [PATCH v4 3/3] sched/cpufreq: Consider reduced CPU capacity in energy calculation
Date:   Mon, 14 Jun 2021 20:12:38 +0100
Message-Id: <20210614191238.23224-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210614185815.15136-1-lukasz.luba@arm.com>
References: <20210614185815.15136-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Energy Aware Scheduling (EAS) needs to predict the decisions made by
SchedUtil. The map_util_freq() exists to do that.

There are corner cases where the max allowed frequency might be reduced
(due to thermal). SchedUtil as a CPUFreq governor, is aware of that
but EAS is not. This patch aims to address it.

SchedUtil stores the maximum allowed frequency in
'sugov_policy::next_freq' field. EAS has to predict that value, which is
the real used frequency. That value is made after a call to
cpufreq_driver_resolve_freq() which clamps to the CPUFreq policy limits.
In the existing code EAS is not able to predict that real frequency.
This leads to energy estimation errors.

To avoid wrong energy estimation in EAS (due to frequency miss prediction)
make sure that the step which calculates Performance Domain frequency,
is also aware of the allowed CPU capacity.

Furthermore, modify map_util_freq() to not extend the frequency value.
Instead, use map_util_perf() to extend the util value in both places:
SchedUtil and EAS, but for EAS clamp it to max allowed CPU capacity.
In the end, we achieve the same desirable behavior for both subsystems
and alignment in regards to the real CPU frequency.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> (For the schedutil part)
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h     | 16 +++++++++++++---
 include/linux/sched/cpufreq.h    |  2 +-
 kernel/sched/cpufreq_schedutil.c |  1 +
 kernel/sched/fair.c              |  2 +-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 757fc60658fa..3f221dbf5f95 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -91,6 +91,8 @@ void em_dev_unregister_perf_domain(struct device *dev);
  * @pd		: performance domain for which energy has to be estimated
  * @max_util	: highest utilization among CPUs of the domain
  * @sum_util	: sum of the utilization of all CPUs in the domain
+ * @allowed_cpu_cap	: maximum allowed CPU capacity for the @pd, which
+			  might reflect reduced frequency (due to thermal)
  *
  * This function must be used only for CPU devices. There is no validation,
  * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
@@ -100,7 +102,8 @@ void em_dev_unregister_perf_domain(struct device *dev);
  * a capacity state satisfying the max utilization of the domain.
  */
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-				unsigned long max_util, unsigned long sum_util)
+				unsigned long max_util, unsigned long sum_util,
+				unsigned long allowed_cpu_cap)
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
@@ -112,11 +115,17 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	/*
 	 * In order to predict the performance state, map the utilization of
 	 * the most utilized CPU of the performance domain to a requested
-	 * frequency, like schedutil.
+	 * frequency, like schedutil. Take also into account that the real
+	 * frequency might be set lower (due to thermal capping). Thus, clamp
+	 * max utilization to the allowed CPU capacity before calculating
+	 * effective frequency.
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
 	ps = &pd->table[pd->nr_perf_states - 1];
+
+	max_util = map_util_perf(max_util);
+	max_util = min(max_util, allowed_cpu_cap);
 	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
 
 	/*
@@ -209,7 +218,8 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 	return NULL;
 }
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-			unsigned long max_util, unsigned long sum_util)
+			unsigned long max_util, unsigned long sum_util,
+			unsigned long allowed_cpu_cap)
 {
 	return 0;
 }
diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index 6205578ab6ee..bdd31ab93bc5 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -26,7 +26,7 @@ bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
 static inline unsigned long map_util_freq(unsigned long util,
 					unsigned long freq, unsigned long cap)
 {
-	return (freq + (freq >> 2)) * util / cap;
+	return freq * util / cap;
 }
 
 static inline unsigned long map_util_perf(unsigned long util)
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4f09afd2f321..57124614363d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -151,6 +151,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 
+	util = map_util_perf(util);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3634e077051d..75e082964250 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6584,7 +6584,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		max_util = max(max_util, min(cpu_util, _cpu_cap));
 	}
 
-	return em_cpu_energy(pd->em_pd, max_util, sum_util);
+	return em_cpu_energy(pd->em_pd, max_util, sum_util, _cpu_cap);
 }
 
 /*
-- 
2.17.1

