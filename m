Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9B3A2EF5
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFJPFl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 11:05:41 -0400
Received: from foss.arm.com ([217.140.110.172]:34002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhFJPFk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Jun 2021 11:05:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 437FD13A1;
        Thu, 10 Jun 2021 08:03:44 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.4.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CD2E3F719;
        Thu, 10 Jun 2021 08:03:40 -0700 (PDT)
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
Subject: [PATCH v3 2/3] sched/fair: Take thermal pressure into account while estimating energy
Date:   Thu, 10 Jun 2021 16:03:23 +0100
Message-Id: <20210610150324.22919-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210610150324.22919-1-lukasz.luba@arm.com>
References: <20210610150324.22919-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Energy Aware Scheduling (EAS) needs to be able to predict the frequency
requests made by the SchedUtil governor to properly estimate energy used
in the future. It has to take into account CPUs utilization and forecast
Performance Domain (PD) frequency. There is a corner case when the max
allowed frequency might be reduced due to thermal. SchedUtil is aware of
that reduced frequency, so it should be taken into account also in EAS
estimations.

SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
to 'policy::max'. SchedUtil is responsible to respect that upper limit
while setting the frequency through CPUFreq drivers. This effective
frequency is stored internally in 'sugov_policy::next_freq' and EAS has
to predict that value.

In the existing code the raw value of arch_scale_cpu_capacity() is used
for clamping the returned CPU utilization from effective_cpu_util().
This patch fixes issue with too big single CPU utilization, by introducing
clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
capacity reduced by thermal pressure signal. We rely on this load avg
geometric series in similar way as other mechanisms in the scheduler.

Thanks to knowledge about allowed CPU capacity, we don't get too big value
for a single CPU utilization, which is then added to the util sum. The
util sum is used as a source of information for estimating whole PD energy.
To avoid wrong energy estimation in EAS (due to capped frequency), make
sure that the calculation of util sum is aware of allowed CPU capacity.

This thermal pressure might be visible in scenarios where the CPUs are not
heavily loaded, but some other component (like GPU) drastically reduced
available power budget and increased the SoC temperature. Thus, we still
use EAS for task placement and CPUs are not over-utilized.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..237726217dad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6527,8 +6527,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	struct cpumask *pd_mask = perf_domain_span(pd);
 	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
 	unsigned long max_util = 0, sum_util = 0;
+	unsigned long _cpu_cap, thermal_pressure;
 	int cpu;
 
+	thermal_pressure = arch_scale_thermal_pressure(cpumask_first(pd_mask));
+	_cpu_cap = cpu_cap - thermal_pressure;
+
 	/*
 	 * The capacity state of CPUs of the current rd can be driven by CPUs
 	 * of another rd if they belong to the same pd. So, account for the
@@ -6564,8 +6568,10 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
-					       ENERGY_UTIL, NULL);
+		cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
+					      ENERGY_UTIL, NULL);
+
+		sum_util += min(cpu_util, _cpu_cap);
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -6576,7 +6582,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 */
 		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
-		max_util = max(max_util, cpu_util);
+		max_util = max(max_util, min(cpu_util, _cpu_cap));
 	}
 
 	return em_cpu_energy(pd->em_pd, max_util, sum_util);
-- 
2.17.1

