Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151691F603
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfEONxz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 09:53:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728031AbfEONxz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 09:53:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FDrRU2140395
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgkpdsgf4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:53 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 15 May 2019 14:53:51 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 14:53:48 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FDrmHE45088980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:53:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCE855204E;
        Wed, 15 May 2019 13:53:47 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.18.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 789C452057;
        Wed, 15 May 2019 13:53:45 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        dsmythies@telus.net
Subject: [RFCv2 5/6] sched/fair: Tune task wake-up logic to pack jitter tasks
Date:   Wed, 15 May 2019 19:23:21 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051513-0008-0000-0000-000002E6FA57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051513-0009-0000-0000-000022539A27
Message-Id: <20190515135322.19393-6-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The algorithm finds the first non idle core in the system and tries to
place a task in the least utilized CPU in the chosen core. To maintain
cache hotness, work of finding non idle core starts from the prev_cpu,
which also reduces task ping-pong behaviour inside of the core.

The CPU/core is defined as under-utilized when the aggregated utilization
of the given CPUs is less than 12.5%. The function is named as
core_underutilized because of its specific use in finding a non idle core.

This patch uses the core_underutilized method to calculate whether the core
should be considered sufficiently busy or not. Since core with low
utilization should not be selected for packing, the margin of
under-utilization is kept at 12.5% of core capacity. This number is
experimental and can be modified as per the need. More larger the number,
more aggressive task packing will be.

12.5% is an experimental number which identifies whether the core is
considered to be idle or not.  For task packing, the algorithm should
select the best core where the task can be accommodated such that it does
not wake up an idle core. But the jitter tasks should not be placed on the
core which is about to go idle. Since the core having aggregated
utilization of <12.5%, it may go idle soon and hence packing on such core
should be ignored. The experiment showed that keeping this threshold to
12.5% gives better decision capability on not selecting the core which will
idle out soon.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/fair.c | 100 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2578e6bdf85b..d2d556eb6d0f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5323,6 +5323,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+/* A cpumask to find active cores in the system. */
+DEFINE_PER_CPU(cpumask_var_t, turbo_sched_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 /*
@@ -6248,6 +6250,73 @@ static inline unsigned long arch_scale_core_capacity(int first_thread,
 }
 #endif
 
+/*
+ * Core is defined as under-utilized in case if the aggregated utilization of a
+ * all the CPUs in a core is less than 12.5%
+ */
+static inline bool core_underutilized(unsigned long core_util,
+				      unsigned long core_capacity)
+{
+	return core_util < (core_capacity >> 3);
+}
+
+/*
+ * Try to find a non idle core in the system  with spare capacity
+ * available for task packing, thereby keeping minimal cores active.
+ * Uses first fit algorithm to pack low util jitter tasks on active cores.
+ */
+static int select_non_idle_core(struct task_struct *p, int prev_cpu)
+{
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
+	int iter_cpu, sibling;
+
+	cpumask_and(cpus, cpu_online_mask, &p->cpus_allowed);
+
+	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
+		unsigned long core_util = 0;
+		unsigned long core_cap = arch_scale_core_capacity(iter_cpu,
+				capacity_of(iter_cpu));
+		unsigned long est_util = 0, est_util_enqueued = 0;
+		unsigned long util_best_cpu = (unsigned int)-1;
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
+		 * Find if the selected task will fit into the tracked minutil
+		 * CPU or not by estimating the utilization of the CPU.
+		 */
+		cfs_rq = &cpu_rq(best_cpu)->cfs;
+		est_util = READ_ONCE(cfs_rq->avg.util_avg) + task_util(p);
+		est_util_enqueued = READ_ONCE(cfs_rq->avg.util_est.enqueued);
+		est_util_enqueued += _task_util_est(p);
+		est_util = max(est_util, est_util_enqueued);
+
+		if (!core_underutilized(core_util, core_cap) && est_util < core_cap) {
+			/*
+			 * Try to bias towards prev_cpu to avoid task ping-pong
+			 * behaviour inside the core.
+			 */
+			if (cpumask_test_cpu(prev_cpu, cpu_smt_mask(iter_cpu)))
+				return prev_cpu;
+
+			return best_cpu;
+		}
+	}
+	return -1;
+}
 #endif
 
 /*
@@ -6704,6 +6773,31 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return -1;
 }
 
+#ifdef CONFIG_SCHED_SMT
+/*
+ * Select all tasks of type 1(jitter) for task packing
+ */
+static int turbosched_select_idle_sibling(struct task_struct *p, int prev_cpu,
+					  int target)
+{
+	int new_cpu;
+
+	if (unlikely(task_group(p)->turbo_sched_enabled)) {
+		new_cpu = select_non_idle_core(p, prev_cpu);
+		if (new_cpu >= 0)
+			return new_cpu;
+	}
+
+	return select_idle_sibling(p, prev_cpu, target);
+}
+#else
+static int turbosched_select_idle_sibling(struct task_struct *p, int prev_cpu,
+					  int target)
+{
+	return select_idle_sibling(p, prev_cpu, target);
+}
+#endif
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
@@ -6769,7 +6863,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
 
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		if (is_turbosched_enabled())
+			new_cpu = turbosched_select_idle_sibling(p, prev_cpu,
+								 new_cpu);
+		else
+			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
-- 
2.17.1

