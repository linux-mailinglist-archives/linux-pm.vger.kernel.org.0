Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49790398B2A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFBN6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 09:58:23 -0400
Received: from foss.arm.com ([217.140.110.172]:45380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhFBN6X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Jun 2021 09:58:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F32211FB;
        Wed,  2 Jun 2021 06:56:40 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.1.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CFBCB3F73D;
        Wed,  2 Jun 2021 06:56:36 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, lukasz.luba@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com
Subject: [PATCH 1/2] sched/fair: Take thermal pressure into account while estimating energy
Date:   Wed,  2 Jun 2021 14:56:08 +0100
Message-Id: <20210602135609.10867-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602135609.10867-1-lukasz.luba@arm.com>
References: <20210602135609.10867-1-lukasz.luba@arm.com>
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

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..ca0a6f1408da 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6525,8 +6525,9 @@ static long
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
 	struct cpumask *pd_mask = perf_domain_span(pd);
-	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
+	unsigned long _cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
 	unsigned long max_util = 0, sum_util = 0;
+	unsigned long cpu_cap = _cpu_cap;
 	int cpu;
 
 	/*
@@ -6558,6 +6559,14 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 				cpu_util_next(cpu, p, -1) + task_util_est(p);
 		}
 
+		/*
+		 * Take the thermal pressure from non-idle CPUs. They have
+		 * most up-to-date information. For idle CPUs thermal pressure
+		 * signal is not updated so often.
+		 */
+		if (!idle_cpu(cpu))
+			cpu_cap = _cpu_cap - thermal_load_avg(cpu_rq(cpu));
+
 		/*
 		 * Busy time computation: utilization clamping is not
 		 * required since the ratio (sum_util / cpu_capacity)
-- 
2.17.1

