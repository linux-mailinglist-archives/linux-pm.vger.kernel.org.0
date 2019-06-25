Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4574B52228
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfFYEhr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:37:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727040AbfFYEhp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:37:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P4XlJX124977
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbagt4340-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Jun 2019 05:37:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 05:37:38 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P4bbBP11534396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 04:37:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C54BC11C04C;
        Tue, 25 Jun 2019 04:37:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93E3311C054;
        Tue, 25 Jun 2019 04:37:36 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 04:37:36 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: [RFCv3 6/8] sched/fair: Tune task wake-up logic to pack jitter tasks
Date:   Tue, 25 Jun 2019 10:07:24 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625043726.21490-1-parth@linux.ibm.com>
References: <20190625043726.21490-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19062504-0012-0000-0000-0000032C1B53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062504-0013-0000-0000-000021654EE2
Message-Id: <20190625043726.21490-7-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250036
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The algorithm finds the first non idle core in the system and tries to
place a task in the least utilized CPU in the chosen core. To maintain
cache hotness, work of finding non idle core starts from the prev_cpu,
which also reduces task ping-pong behaviour inside of the core.

This patch defines a new method named core_underutilized() which will
determine if the core utilization is less than 12.5% of its capacity.
Since core with low utilization should not be selected for packing, the
margin of under-utilization is kept at 12.5% of core capacity.

12.5% is an experimental number which identifies whether the core is
considered to be idle or not.  For task packing, the algorithm should
select the best core where the task can be accommodated such that it does
not wake up an idle core. But the jitter tasks should not be placed on the
core which is about to go idle. If the core has aggregated utilization of
<12.5%, it may go idle soon and hence packing on such core should be
ignored. The experiment showed that keeping this threshold to 12.5% gives
better decision capability on not selecting the core which will idle out
soon.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/fair.c | 116 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff3f88d788d8..9d11631ce18c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5318,6 +5318,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+/* A cpumask to find active cores in the system. */
+DEFINE_PER_CPU(cpumask_var_t, turbo_sched_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -5929,8 +5931,22 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
-#ifdef CONFIG_SCHED_SMT
+#ifdef CONFIG_UCLAMP_TASK
+static inline bool is_task_jitter(struct task_struct *p)
+{
+	if (p->is_jitter == 1)
+		return true;
 
+	return false;
+}
+#else
+static inline bool is_task_jitter(struct task_struct *p)
+{
+	return false;
+}
+#endif
+
+#ifdef CONFIG_SCHED_SMT
 #ifndef arch_scale_core_capacity
 static inline unsigned long arch_scale_core_capacity(int first_thread,
 						     unsigned long smt_cap)
@@ -5946,6 +5962,81 @@ static inline unsigned long arch_scale_core_capacity(int first_thread,
 }
 #endif
 
+/*
+ * Core is defined as under-utilized in case if the aggregated utilization of a
+ * all the CPUs in a core is less than 12.5%
+ */
+#define UNDERUTILIZED_THRESHOLD 3
+static inline bool core_underutilized(unsigned long core_util,
+				      unsigned long core_capacity)
+{
+	return core_util < (core_capacity >> UNDERUTILIZED_THRESHOLD);
+}
+
+/*
+ * Try to find a non idle core in the system  with spare capacity
+ * available for task packing, thereby keeping minimal cores active.
+ * Uses first fit algorithm to pack low util jitter tasks on active cores.
+ */
+static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
+{
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
+	int iter_cpu, sibling;
+
+	cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
+
+	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
+		unsigned long core_util = 0;
+		unsigned long core_cap = arch_scale_core_capacity(iter_cpu,
+				capacity_of(iter_cpu));
+		unsigned long est_util = 0, est_util_enqueued = 0;
+		unsigned long util_best_cpu = ULONG_MAX;
+		int best_cpu = iter_cpu;
+		struct cfs_rq *cfs_rq;
+
+		for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
+			__cpumask_clear_cpu(sibling, cpus);
+			core_util += cpu_util(sibling);
+
+			/*
+			 * Keep track of least utilized CPU in the core
+			 */
+			if (cpu_util(sibling) < util_best_cpu) {
+				util_best_cpu = cpu_util(sibling);
+				best_cpu = sibling;
+			}
+		}
+
+		/*
+		 * Find if the selected task will fit into this core or not by
+		 * estimating the utilization of the core.
+		 */
+		if (!core_underutilized(core_util, core_cap)) {
+			cfs_rq = &cpu_rq(best_cpu)->cfs;
+			est_util =
+				READ_ONCE(cfs_rq->avg.util_avg) + task_util(p);
+			est_util_enqueued =
+				READ_ONCE(cfs_rq->avg.util_est.enqueued);
+			est_util_enqueued += _task_util_est(p);
+			est_util = max(est_util, est_util_enqueued);
+			est_util = core_util - util_best_cpu + est_util;
+
+			if (est_util < core_cap) {
+				/*
+				 * Try to bias towards prev_cpu to avoid task
+				 * ping-pong behaviour inside the core.
+				 */
+				if (cpumask_test_cpu(prev_cpu,
+						     cpu_smt_mask(iter_cpu)))
+					return prev_cpu;
+
+				return best_cpu;
+			}
+		}
+	}
+
+	return select_idle_sibling(p, prev_cpu, target);
+}
 #endif
 
 /*
@@ -6402,6 +6493,23 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return -1;
 }
 
+#ifdef CONFIG_SCHED_SMT
+/*
+ * Select all tasks of type 1(jitter) for task packing
+ */
+static inline int turbosched_select_non_idle_core(struct task_struct *p,
+						  int prev_cpu, int target)
+{
+	return select_non_idle_core(p, prev_cpu, target);
+}
+#else
+static inline int turbosched_select_non_idle_core(struct task_struct *p,
+						  int prev_cpu, int target)
+{
+	return select_idle_sibling(p, prev_cpu, target);
+}
+#endif
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
@@ -6467,7 +6575,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
 
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		if (is_turbosched_enabled() && unlikely(is_task_jitter(p)))
+			new_cpu = turbosched_select_non_idle_core(p, prev_cpu,
+								  new_cpu);
+		else
+			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
-- 
2.17.1

