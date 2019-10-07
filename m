Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2930CDD62
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2019 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfJGIb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Oct 2019 04:31:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727516AbfJGIbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Oct 2019 04:31:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x978UJd2039448
        for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2019 04:31:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vg0vsj9sp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2019 04:31:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 7 Oct 2019 09:31:10 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 7 Oct 2019 09:31:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x978V4en25755878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Oct 2019 08:31:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4EEA11C052;
        Mon,  7 Oct 2019 08:31:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AAFD11C054;
        Mon,  7 Oct 2019 08:31:02 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.220])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Oct 2019 08:31:02 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, pavel@ucw.cz, dsmythies@telus.net,
        quentin.perret@arm.com, rafael.j.wysocki@intel.com,
        tim.c.chen@linux.intel.com, daniel.lezcano@linaro.org
Subject: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small background tasks on fewer cores
Date:   Mon,  7 Oct 2019 14:00:49 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007083051.4820-1-parth@linux.ibm.com>
References: <20191007083051.4820-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100708-0028-0000-0000-000003A6BE49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0029-0000-0000-00002468CDCC
Message-Id: <20191007083051.4820-5-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070088
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The algorithm finds the first non idle core in the system and tries to
place a task in the idle CPU in the chosen core. To maintain
cache hotness, work of finding non idle core starts from the prev_cpu,
which also reduces task ping-pong behaviour inside of the core.

Define a new method to select_non_idle_core which keep tracks of the idle
and non-idle CPUs in the core and based on the heuristics determines if the
core is sufficiently busy to place the incoming backgroung task. The
heuristic further defines the non-idle CPU into either busy (>12.5% util)
CPU and overutilized (>80% util) CPU.
- The core containing more idle CPUs and no busy CPUs is not selected for
  packing
- The core if contains more than 1 overutilized CPUs are exempted from
  task packing
- Pack if there is atleast one busy CPU and overutilized CPUs count is <2

Value of 12.5% utilization for busy CPU gives sufficient heuristics for CPU
doing enough work and not become idle in nearby timeframe.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c |  3 ++
 kernel/sched/fair.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e1ae8046fe0..7e3aff59540a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6402,6 +6402,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, turbo_sched_mask);
 
 void __init sched_init(void)
 {
@@ -6442,6 +6443,8 @@ void __init sched_init(void)
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
+		per_cpu(turbo_sched_mask, i) = (cpumask_var_t)kzalloc_node(
+			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b798fe7ff7cd..d4a1b6474338 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5353,6 +5353,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+/* A cpumask to find active cores in the system. */
+DEFINE_PER_CPU(cpumask_var_t, turbo_sched_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -5964,6 +5966,76 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+#ifdef CONFIG_SCHED_SMT
+static inline bool is_background_task(struct task_struct *p)
+{
+	if (p->flags & PF_CAN_BE_PACKED)
+		return true;
+
+	return false;
+}
+
+#define busyness_threshold	(100 >> 3)
+#define is_cpu_busy(util) ((util) > busyness_threshold)
+
+/*
+ * Try to find a non idle core in the system  based on few heuristics:
+ * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
+ * - If none CPUs are busy then do not select the core for task packing
+ * - If atleast one CPU is busy then do task packing unless overutilized CPUs
+ *   count is < busy/2 CPU count
+ * - Always select idle CPU for task packing
+ */
+static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
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
+			if (idle_cpu(iter_cpu)) {
+				idle_cpu_count++;
+				best_cpu = iter_cpu;
+			} else {
+				non_idle_cpu_count++;
+				if (cpu_overutilized(iter_cpu))
+					overutil_cpu_count++;
+				if (is_cpu_busy(cpu_util(iter_cpu)))
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
+	return select_idle_sibling(p, prev_cpu, target);
+}
+#endif /* CONFIG_SCHED_SMT */
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
@@ -6418,6 +6490,23 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return -1;
 }
 
+#ifdef CONFIG_SCHED_SMT
+/*
+ * Select all classified background tasks for task packing
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
@@ -6483,7 +6572,11 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
 
-		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		if (is_turbosched_enabled() && unlikely(is_background_task(p)))
+			new_cpu = turbosched_select_non_idle_core(p, prev_cpu,
+								  new_cpu);
+		else
+			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
 			current->recent_used_cpu = cpu;
-- 
2.17.1

