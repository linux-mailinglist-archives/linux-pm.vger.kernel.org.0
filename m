Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBBC3B4690
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 17:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFYP3E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 11:29:04 -0400
Received: from foss.arm.com ([217.140.110.172]:58636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYP3D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Jun 2021 11:29:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3C6F12FC;
        Fri, 25 Jun 2021 08:26:42 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90EF23F694;
        Fri, 25 Jun 2021 08:26:39 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris.Redpath@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com, CCj.Yeh@mediatek.com
Subject: [PATCH 1/3] sched/fair: Prepare variables for increased precision of EAS estimated energy
Date:   Fri, 25 Jun 2021 16:26:01 +0100
Message-Id: <20210625152603.25960-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625152603.25960-1-lukasz.luba@arm.com>
References: <20210625152603.25960-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
task. It probes many possibilities and compares the estimated energy values
for different scenarios. For calculating those energy values it relies on
Energy Model (EM) data and em_cpu_energy(). The precision which is used in
EM data is in milli-Watts (or abstract scale), which sometimes is not
sufficient. In some cases it might happen that two CPUs from different
Performance Domains (PDs) get the same calculated value for a given task
placement, but in more precised scale, they might differ. This rounding
error has to be addressed. This patch prepares EAS code for better
precision in the coming EM improvements.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b8990fd4896..b517c9e79768 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6582,7 +6582,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
  * to compute what would be the energy if we decided to actually migrate that
  * task.
  */
-static long
+static u64
 compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 {
 	struct cpumask *pd_mask = perf_domain_span(pd);
@@ -6689,12 +6689,13 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  */
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
-	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
+	u64 prev_delta = ULLONG_MAX, best_delta = ULLONG_MAX;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
-	unsigned long cpu_cap, util, base_energy = 0;
+	unsigned long cpu_cap, util;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
+	u64 base_energy = 0;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
@@ -6718,9 +6719,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		goto unlock;
 
 	for (; pd; pd = pd->next) {
-		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
+		unsigned long spare_cap, max_spare_cap = 0;
 		bool compute_prev_delta = false;
-		unsigned long base_energy_pd;
+		u64 base_energy_pd, cur_delta;
 		int max_spare_cap_cpu = -1;
 
 		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
@@ -6790,7 +6791,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
 	 * least 6% of the energy used by prev_cpu.
 	 */
-	if ((prev_delta == ULONG_MAX) ||
+	if ((prev_delta == ULLONG_MAX) ||
 	    (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
 		target = best_energy_cpu;
 
-- 
2.17.1

