Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4E4143725
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2020 07:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAUGd0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jan 2020 01:33:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbgAUGdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2020 01:33:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L6Wcjt021644
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:24 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgcp3gdm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2020 01:33:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 21 Jan 2020 06:33:22 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Jan 2020 06:33:18 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00L6XHfr17694914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 06:33:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F531A406B;
        Tue, 21 Jan 2020 06:33:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FA70A405B;
        Tue, 21 Jan 2020 06:33:15 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.158])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jan 2020 06:33:15 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        qperret@google.com, tim.c.chen@linux.intel.com
Subject: [RFC v6 3/5] sched/fair: Tune task wake-up logic to pack small background tasks on fewer cores
Date:   Tue, 21 Jan 2020 12:03:05 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200121063307.17221-1-parth@linux.ibm.com>
References: <20200121063307.17221-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012106-0020-0000-0000-000003A291A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012106-0021-0000-0000-000021FA1F92
Message-Id: <20200121063307.17221-4-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_01:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001210056
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The algorithm finds the first non idle core in the system and tries to
place a task in the idle CPU of the chosen core. To maintain cache hotness,
work of finding non idle core starts from the prev_cpu, which also reduces
task ping-pong behaviour inside of the core.

Define a new method to select_non_idle_core which keep tracks of the idle
and non-idle CPUs in the core and based on the heuristics determines if the
core is sufficiently busy to place the waking up background task. The
heuristic further defines the non-idle CPU into either busy (>12.5% util)
CPU and overutilized (>80% util) CPU.
- The core containing more idle CPUs and no busy CPUs is not selected for
  packing
- The core if contains more than 1 overutilized CPUs are exempted from
  task packing
- Pack if there is atleast one busy CPU and overutilized CPUs count is <2

Value of 12.5% utilization for busy CPU gives sufficient heuristics for CPU
doing enough work and not become idle in nearby time frame.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c |  3 ++
 kernel/sched/fair.c | 87 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 629c2589d727..a34a5589ae16 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6617,6 +6617,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, turbo_sched_mask);
 
 void __init sched_init(void)
 {
@@ -6657,6 +6658,8 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(turbo_sched_mask, i) = (cpumask_var_t)kzalloc_node(
+			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d170b5da0e3..8643e6309451 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5379,6 +5379,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+/* A cpumask to find active cores in the system. */
+DEFINE_PER_CPU(cpumask_var_t, turbo_sched_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -5883,6 +5885,81 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+#ifdef CONFIG_SCHED_SMT
+
+/* Define non-idle CPU as the one with the utilization >= 12.5% */
+#define merely_used_cpu(util) ((cpu_util(util)) > (100 >> 3))
+
+/*
+ * Classify small background tasks with higher latency_nice value for task
+ * packing.
+ */
+static inline bool is_small_bg_task(struct task_struct *p)
+{
+	if (is_bg_task(p) && (task_util(p) > (SCHED_CAPACITY_SCALE >> 3)))
+		return true;
+
+	return false;
+}
+
+/*
+ * Try to find a non idle core in the system  based on few heuristics:
+ * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
+ * - If none CPUs are busy then do not select the core for task packing
+ * - If atleast one CPU is busy then do task packing unless overutilized CPUs
+ *   count is < busy/2 CPU count
+ * - Always select idle CPU for task packing
+ */
+static int select_non_idle_core(struct task_struct *p, int prev_cpu)
+{
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
+	int iter_cpu, sibling;
+
+	cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
+
+	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
+		int idle_cpu_count = 0, non_idle_cpu_count = 0;
+		int overutil_cpu_count = 0;
+		int busy_cpu_count = 0;
+		int best_cpu = iter_cpu;
+
+		for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
+			__cpumask_clear_cpu(sibling, cpus);
+			if (idle_cpu(sibling)) {
+				idle_cpu_count++;
+				best_cpu = sibling;
+			} else {
+				non_idle_cpu_count++;
+				if (cpu_overutilized(sibling))
+					overutil_cpu_count++;
+				if (merely_used_cpu(sibling))
+					busy_cpu_count++;
+			}
+		}
+
+		/*
+		 * Pack tasks to this core if
+		 * 1. Idle CPU count is higher and atleast one is busy
+		 * 2. If idle_cpu_count < non_idle_cpu_count then ideally do
+		 * packing but if there are more CPUs overutilized then don't
+		 * overload it.
+		 */
+		if (idle_cpu_count > non_idle_cpu_count) {
+			if (busy_cpu_count)
+				return best_cpu;
+		} else {
+			/*
+			 * Pack tasks if at max 1 CPU is overutilized
+			 */
+			if (overutil_cpu_count < 2)
+				return best_cpu;
+		}
+	}
+
+	return -1;
+}
+#endif /* CONFIG_SCHED_SMT */
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -6367,6 +6444,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 			new_cpu = prev_cpu;
 		}
 
+#ifdef CONFIG_SCHED_SMT
+		if (is_turbosched_enabled() && unlikely(is_small_bg_task(p))) {
+			new_cpu = select_non_idle_core(p, prev_cpu);
+			if (new_cpu >= 0)
+				return new_cpu;
+			new_cpu = prev_cpu;
+		}
+#endif
+
 		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
 			      cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
@@ -6400,7 +6486,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
-
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
-- 
2.17.2

