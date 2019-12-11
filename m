Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1268B11A8E7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 11:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfLKK2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 05:28:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43171 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLKK2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 05:28:45 -0500
Received: from 79.184.253.70.ipv4.supernova.orange.pl (79.184.253.70) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 2490e063850f2c90; Wed, 11 Dec 2019 11:28:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU offline
Date:   Wed, 11 Dec 2019 11:28:41 +0100
Message-ID: <2691942.bH9KnLg61H@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The scheduler code calling cpufreq_update_util() may run during CPU
offline on the target CPU after the IRQ work lists have been flushed
for it, so the target CPU should be prevented from running code that
may queue up an IRQ work item on it at that point.

Unfortunately, that may not be the case if dvfs_possible_from_any_cpu
is set for at least one cpufreq policy in the system, because that
allows the CPU going offline to run the utilization update callback
of the cpufreq governor on behalf of another (online) CPU in some
cases.

If that happens, the cpufreq governor callback may queue up an IRQ
work on the CPU running it, which is going offline, and the IRQ work
will not be flushed after that point.  Moreover, that IRQ work cannot
be flushed until the "offlining" CPU goes back online, so if any
other CPU calls irq_work_sync() to wait for the completion of that
IRQ work, it will have to wait until the "offlining" CPU is back
online and that may not happen forever.  In particular, a system-wide
deadlock may occur during CPU online as a result of that.

The failing scenario is as follows.  CPU0 is the boot CPU, so it
creates a cpufreq policy and becomes the "leader" of it
(policy->cpu).  It cannot go offline, because it is the boot CPU.
Next, other CPUs join the cpufreq policy as they go online and they
leave it when they go offline.  The last CPU to go offline, say CPU3,
may queue up an IRQ work while running the governor callback on
behalf of CPU0 after leaving the cpufreq policy because of the
dvfs_possible_from_any_cpu effect described above.  Then, CPU0 is
the only online CPU in the system and the stale IRQ work is still
queued on CPU3.  When, say, CPU1 goes back online, it will run
irq_work_sync() to wait for that IRQ work to complete and so it
will wait for CPU3 to go back online (which may never happen even
in principle), but (worse yet) CPU0 is waiting for CPU1 at that
point too and a system-wide deadlock occurs.

To address this problem notice that CPUs which cannot run cpufreq
utilization update code for themselves (for example, because they
have left the cpufreq policies that they belonged to), should also
be prevented from running that code on behalf of the other CPUs that
belong to a cpufreq policy with dvfs_possible_from_any_cpu set and so
in that case the cpufreq_update_util_data pointer of the CPU running
the code must not be NULL as well as for the CPU which is the target
of the cpufreq utilization update in progress.

Accordingly, change cpufreq_this_cpu_can_update() into a regular
function in kernel/sched/cpufreq.c (instead of a static inline in a
header file) and make it check the cpufreq_update_util_data pointer
of the local CPU if dvfs_possible_from_any_cpu is set for the target
cpufreq policy.

Also update the schedutil governor to do the
cpufreq_this_cpu_can_update() check in the non-fast-switch
case too to avoid the stale IRQ work issues.

Fixes: 99d14d0e16fa ("cpufreq: Process remote callbacks from any CPU if the platform permits")
Link: https://lore.kernel.org/linux-pm/20191121093557.bycvdo4xyinbc5cb@vireshk-i7/
Reported-by: Anson Huang <anson.huang@nxp.com>
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Peter,

The reason why I want to address the issue this way is because IMO
the right place to do the check is the cpufreq governor.  Governors
that don't use cpufreq_this_cpu_can_update() at all don't need to
worry as well as governors that don't use IRQ works.

The cpufreq governor is given an opportunity to update the frequency
of the CPU and it needs to decide whether or not to really do that.

Please let me know if you have any concerns.

---
 include/linux/cpufreq.h          |   11 -----------
 include/linux/sched/cpufreq.h    |    3 +++
 kernel/sched/cpufreq.c           |   18 ++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |    8 +++-----
 4 files changed, 24 insertions(+), 16 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -595,17 +595,6 @@ struct governor_attr {
 			 size_t count);
 };
 
-static inline bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
-{
-	/*
-	 * Allow remote callbacks if:
-	 * - dvfs_possible_from_any_cpu flag is set
-	 * - the local and remote CPUs share cpufreq policy
-	 */
-	return policy->dvfs_possible_from_any_cpu ||
-		cpumask_test_cpu(smp_processor_id(), policy->cpus);
-}
-
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
Index: linux-pm/kernel/sched/cpufreq.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq.c
+++ linux-pm/kernel/sched/cpufreq.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
+#include <linux/cpufreq.h>
+
 #include "sched.h"
 
 DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
@@ -57,3 +59,19 @@ void cpufreq_remove_update_util_hook(int
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), NULL);
 }
 EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
+
+/**
+ * cpufreq_this_cpu_can_update - Check if cpufreq policy can be updated.
+ * @policy: cpufreq policy to check.
+ *
+ * Return 'true' if:
+ * - the local and remote CPUs share @policy,
+ * - dvfs_possible_from_any_cpu is set in @policy and the local CPU is not going
+ *   offline (in which case it is not expected to run cpufreq updates any more).
+ */
+bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
+{
+	return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
+		(policy->dvfs_possible_from_any_cpu &&
+		 rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
+}
Index: linux-pm/include/linux/sched/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/sched/cpufreq.h
+++ linux-pm/include/linux/sched/cpufreq.h
@@ -12,6 +12,8 @@
 #define SCHED_CPUFREQ_MIGRATION	(1U << 1)
 
 #ifdef CONFIG_CPU_FREQ
+struct cpufreq_policy;
+
 struct update_util_data {
        void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
 };
@@ -20,6 +22,7 @@ void cpufreq_add_update_util_hook(int cp
                        void (*func)(struct update_util_data *data, u64 time,
 				    unsigned int flags));
 void cpufreq_remove_update_util_hook(int cpu);
+bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
 
 static inline unsigned long map_util_freq(unsigned long util,
 					unsigned long freq, unsigned long cap)
Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -82,12 +82,10 @@ static bool sugov_should_update_freq(str
 	 * by the hardware, as calculating the frequency is pointless if
 	 * we cannot in fact act on it.
 	 *
-	 * For the slow switching platforms, the kthread is always scheduled on
-	 * the right set of CPUs and any CPU can find the next frequency and
-	 * schedule the kthread.
+	 * This is needed on the slow switching platforms too to prevent CPUs
+	 * going offline from leaving stale IRQ work items behind.
 	 */
-	if (sg_policy->policy->fast_switch_enabled &&
-	    !cpufreq_this_cpu_can_update(sg_policy->policy))
+	if (!cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
 	if (unlikely(sg_policy->limits_changed)) {



