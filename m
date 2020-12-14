Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F992DA12A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 21:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502986AbgLNUKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 15:10:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55000 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502853AbgLNUKn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 15:10:43 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id ed48d699427488a5; Mon, 14 Dec 2020 21:09:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [PATCH v2 1/3] cpufreq: schedutil: Add util to struct sg_cpu
Date:   Mon, 14 Dec 2020 21:04:11 +0100
Message-ID: <12570124.nDbfvnBycr@kreacher>
In-Reply-To: <3827230.0GnL3RTcl1@kreacher>
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of passing util and max between functions while computing the
utilization and capacity, store the former in struct sg_cpu (along
with the latter and bw_dl).

This will allow the current utilization value to be compared with the
one obtained previously (which is requisite for some code changes to
follow this one), but also it causes the code to look slightly more
consistent and cleaner.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

v1 -> v2:
   * Added the tag from Viresh.

---
 kernel/sched/cpufreq_schedutil.c |   42 ++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -53,6 +53,7 @@ struct sugov_cpu {
 	unsigned int		iowait_boost;
 	u64			last_update;
 
+	unsigned long		util;
 	unsigned long		bw_dl;
 	unsigned long		max;
 
@@ -276,16 +277,15 @@ unsigned long schedutil_cpu_util(int cpu
 	return min(max, util);
 }
 
-static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
+static void sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util = cpu_util_cfs(rq);
 	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
 
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-
-	return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
+	sg_cpu->util = schedutil_cpu_util(sg_cpu->cpu, cpu_util_cfs(rq), max,
+					  FREQUENCY_UTIL, NULL);
 }
 
 /**
@@ -362,8 +362,6 @@ static void sugov_iowait_boost(struct su
  * sugov_iowait_apply() - Apply the IO boost to a CPU.
  * @sg_cpu: the sugov data for the cpu to boost
  * @time: the update time from the caller
- * @util: the utilization to (eventually) boost
- * @max: the maximum value the utilization can be boosted to
  *
  * A CPU running a task which woken up after an IO operation can have its
  * utilization boosted to speed up the completion of those IO operations.
@@ -377,18 +375,17 @@ static void sugov_iowait_boost(struct su
  * This mechanism is designed to boost high frequently IO waiting tasks, while
  * being more conservative on tasks which does sporadic IO operations.
  */
-static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
-					unsigned long util, unsigned long max)
+static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
 {
 	unsigned long boost;
 
 	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
-		return util;
+		return;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sugov_iowait_reset(sg_cpu, time, false))
-		return util;
+		return;
 
 	if (!sg_cpu->iowait_boost_pending) {
 		/*
@@ -397,18 +394,19 @@ static unsigned long sugov_iowait_apply(
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
-			return util;
+			return;
 		}
 	}
 
 	sg_cpu->iowait_boost_pending = false;
 
 	/*
-	 * @util is already in capacity scale; convert iowait_boost
+	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
-	return max(boost, util);
+	boost = (sg_cpu->iowait_boost * sg_cpu->max) >> SCHED_CAPACITY_SHIFT;
+	if (sg_cpu->util < boost)
+		sg_cpu->util = boost;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -439,9 +437,8 @@ static void sugov_update_single(struct u
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
-	unsigned long util, max;
-	unsigned int next_f;
 	unsigned int cached_freq = sg_policy->cached_raw_freq;
+	unsigned int next_f;
 
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -451,10 +448,10 @@ static void sugov_update_single(struct u
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	util = sugov_get_util(sg_cpu);
-	max = sg_cpu->max;
-	util = sugov_iowait_apply(sg_cpu, time, util, max);
-	next_f = get_next_freq(sg_policy, util, max);
+	sugov_get_util(sg_cpu);
+	sugov_iowait_apply(sg_cpu, time);
+
+	next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -491,9 +488,10 @@ static unsigned int sugov_next_freq_shar
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
 
-		j_util = sugov_get_util(j_sg_cpu);
+		sugov_get_util(j_sg_cpu);
+		sugov_iowait_apply(j_sg_cpu, time);
+		j_util = j_sg_cpu->util;
 		j_max = j_sg_cpu->max;
-		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
 		if (j_util * max > j_max * util) {
 			util = j_util;



