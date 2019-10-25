Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59EE5091
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 17:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395552AbfJYPzg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 11:55:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44115 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388136AbfJYPzg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 11:55:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so1828173pfn.11;
        Fri, 25 Oct 2019 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8RrHF7TqDCN4jnIJX5+Z5WZczW/NMGJz5XWTw0ktrTM=;
        b=bhkqUtHbvhdpImiw/SmOtQK9cuVJWC9t4gRuB99B/47MHh6JCL7Onf/alT367Jr+GA
         tU3L7zJdctiRJ0WuoWCL8BXQTPQpBECh0N5hSFUkyQ1tP2AB9aUrkgdo4DjRAR7wqHIT
         WKgwcL4ZB5Imo+s7WDKm42EKvjj3jHmy4W+jMWRhJRgCVLaeeWMWsOnjz24LsFUeHvg4
         wIPJN0r2RLKhk3x7HatWG4+7Uh5ZCqeW6X3Gc5sM6zI2MWNy81Xo7a4mwOprCDzxy7OA
         qJzq+nixN2VhuKblJTXo8dYpODdXqZB+3IczaWkSgaMAXGAAJ0rY87g6J1FUtGeNn7n/
         Aung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8RrHF7TqDCN4jnIJX5+Z5WZczW/NMGJz5XWTw0ktrTM=;
        b=juRcKM/ugqPPhmvwWtI7ms7PbxduEPhgwt+CW4uqmEOPoQFSRMyMCIUDtvf4r8kG5d
         SBMsrXxBoA0RtR+PpFnv2S++tfjAsydZy1bANF0GUw17D8agYn+tlBaDTsWDW0KloT8I
         0phEfES1tPqFkoMdxG7uBugc8vIn+9Sm3UQEhEHRaroVtV5P0SojEZ/hLFGET9YAmJFF
         O701pM+3yelTLSucQyuHimEidpmwFGnY2fxbWvqJi6FhaHDIbDu5YwNIiYoDdT0Tdbho
         Zj9n1ZVtuLnG4x5Q+mioviKCq1fUyd/SshlBCjdPS6KTVhjZBRCAN8hfrcoRdm3pQcvx
         xB0Q==
X-Gm-Message-State: APjAAAULIdPgTfWTwq96bJcCzip1moFgNhmldPLMUEgPji3A1p89SHto
        26NbBsFQ2N4BDSe06o0ZGX4=
X-Google-Smtp-Source: APXvYqxM5RJ/Xh2vFiNPBpPWTMZqqg32EgIrbvbcqiA3CC+7LiLKnsNCLDVpSjE0RpRsnH7c20j5cQ==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr5188788pje.128.1572018935709;
        Fri, 25 Oct 2019 08:55:35 -0700 (PDT)
Received: from s15.smythies.com (mail.smythies.com. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id z9sm2745092pgs.46.2019.10.25.08.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Oct 2019 08:55:34 -0700 (PDT)
From:   Doug Smythies <doug.smythies@gmail.com>
X-Google-Original-From: Doug Smythies <dsmythies@telus.net>
To:     vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Doug Smythies <dsmythies@telus.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, sargun@sargun.me,
        tj@kernel.org, xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load balancing path"
Date:   Fri, 25 Oct 2019 08:55:04 -0700
Message-Id: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 039ae8bcf7a5f4476f4487e6bf816885fb3fb617,
which, in turn, was a re-apply of
commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
after it was reverted via
commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")

For an idle system, the cfs_rq_is_decayed function components can underflow to 0 and
incorrectly return TRUE, when the item should not be deleted from the list.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: sargun@sargun.me
Cc: tj@kernel.org
Cc: xiexiuqi@huawei.com
Cc: xiezhipeng1@huawei.com
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

---
Note 1: Both this reversion and just deleting the cfs_rq_is_decayed function
and it's call and leaving the other changes have been tested. I do not know
which solution is better. (ie for the "list_for_each_entry_rcu" part of it.)

Note 2: Previous controversy over this patch was based on heavy workloads,
but this is based on minimal or no workload, or "idle".
Where "idle" on my test server, with no gui and many services disabled,
tends to mean more "idle" than most systems.

Note 3: While this supporting data only involves the intel_pstate CPU
frequency scaling driver as a casualty, it is beyond my capabilities
to determine what other tasks that should be running might be omitted.

Use case example 1:
System Idle: The intel pstate CPU frequency scaling driver:
Mode: Active, non-hwp, powersave governor.
Expected behaviour: There is never ever a duration (time between calls to
the driver / per CPU) longer than 4 seconds (the watchdog time, I think).
Actual behaviour: There are long long gaps between calls to the driver:

Kernel: 5.4-rc2 CPU:7
duration: 327.17 Seconds. (this is one of many hundreds of examples.)
mpref: 44023326
apref: 20716861
tsc: 1.11604E+12
load: 0
CPU frequency: 1.6053 GHz (average over this 327 second sample period).
old pstate: 16 (the lowest for my processor)
new pstate: 16

Kernel: 5.4-rc2 + reversion (either method)
After several hours of testing, maximum durations were never more
than 4 seconds (well plus some jitter).
reversion method: max=4.07908 seconds
CPU:7
mperf: 492578
apref: 231813 (56,829 per second average is consistent with other tests)
tsc: 13914264074
load: 0
CPU frequency: 1.6052 GHz
old pstate: 16 (the lowest for my precessor)
new pstate: 16

On average, the non-reverted kernel executes the driver 25% less
than the reverted kernel during idle.

O.K. so who cares, the requested pstate doesn't change?
First, one wonders if the math could overflow.
(although 7180ddd suggests maybe it won't)
Second, the sample is largely dominated by obsolete information.
Third, this can be problematic, and potentially wastes energy,
for the busy to idle transition.

Use case example 2:
The busy to idle transition:

Typically, the pstate request response to a busy to idle transition
is very slow because the duration suddenly goes from, typically,
10 milliseconds to much much longer, up to 4 seconds. Transition
times to the system being fully idle, with all requested pstates
being at minimum, takes around 8 seconds with this reversion,
and, potentially, a very very long time (over 100 seconds has been
measured) without.

Again, so who cares, if the processor is in a deep idle state anyway,
not consuming much energy? O.K. but what if it is in an idle state
where energy consumption is a function of the requested pstate?
For example, for my processor (i7-2600K), idle state 1, then processor
package energy can be over double what it should be for many 10s of
seconds.

Experiment method:

enable only idle state 1
Dountil stopped
  apply a 100% load (all CPUs)
  after awhile (about 50 seconds) remove the load.
  allow a short transient delay (1 second).
  measure the processor package joules used over the next 149 seconds.
Enduntil

Kernel k5.4-rc2 + reversion (this method)
Average processor package power: 9.148 watts (128 samples, > 7 hours)
Minimum: 9.02 watts
Maximum: 9.29 watts
Note: outlyer data point group removed, as it was assumed the computer
had something to do and wasn't actually "idle".

Kernel 5.4-rc2:
Average processor package power: 9.969 watts (150 samples, > 8 hours)
Or 9% more energy for the idle phases of the work load.
Minimum: 9.15 watts
Maximum: 13.79 watts (51% more power)

---
 kernel/sched/fair.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83ab35e..51625b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -381,10 +381,9 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
-/* Iterate thr' all leaf cfs_rq's on a runqueue */
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)			\
-	list_for_each_entry_safe(cfs_rq, pos, &rq->leaf_cfs_rq_list,	\
-				 leaf_cfs_rq_list)
+/* Iterate through all cfs_rq's on a runqueue in bottom-up order */
+#define for_each_leaf_cfs_rq(rq, cfs_rq) \
+	list_for_each_entry_rcu(cfs_rq, &rq->leaf_cfs_rq_list, leaf_cfs_rq_list)
 
 /* Do the two (enqueued) entities belong to the same group ? */
 static inline struct cfs_rq *
@@ -481,8 +480,8 @@ static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
 }
 
-#define for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos)	\
-		for (cfs_rq = &rq->cfs, pos = NULL; cfs_rq; cfs_rq = pos)
+#define for_each_leaf_cfs_rq(rq, cfs_rq)	\
+		for (cfs_rq = &rq->cfs; cfs_rq; cfs_rq = NULL)
 
 static inline struct sched_entity *parent_entity(struct sched_entity *se)
 {
@@ -7502,27 +7501,10 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-	if (cfs_rq->load.weight)
-		return false;
-
-	if (cfs_rq->avg.load_sum)
-		return false;
-
-	if (cfs_rq->avg.util_sum)
-		return false;
-
-	if (cfs_rq->avg.runnable_load_sum)
-		return false;
-
-	return true;
-}
-
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
@@ -7534,7 +7516,7 @@ static void update_blocked_averages(int cpu)
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
 	 */
-	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+	for_each_leaf_cfs_rq(rq, cfs_rq) {
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
@@ -7545,13 +7527,6 @@ static void update_blocked_averages(int cpu)
 		if (se && !skip_blocked_update(se))
 			update_load_avg(cfs_rq_of(se), se, 0);
 
-		/*
-		 * There can be a lot of idle CPU cgroups.  Don't let fully
-		 * decayed cfs_rqs linger on the list.
-		 */
-		if (cfs_rq_is_decayed(cfs_rq))
-			list_del_leaf_cfs_rq(cfs_rq);
-
 		/* Don't need periodic decay once load/util_avg are null */
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
@@ -10444,10 +10419,10 @@ const struct sched_class fair_sched_class = {
 #ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
-	struct cfs_rq *cfs_rq, *pos;
+	struct cfs_rq *cfs_rq;
 
 	rcu_read_lock();
-	for_each_leaf_cfs_rq_safe(cpu_rq(cpu), cfs_rq, pos)
+	for_each_leaf_cfs_rq(cpu_rq(cpu), cfs_rq)
 		print_cfs_rq(m, cpu, cfs_rq);
 	rcu_read_unlock();
 }
-- 
2.7.4

