Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFAE61BD9
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfGHIoR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 04:44:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbfGHIoQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 04:44:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A5B1509;
        Mon,  8 Jul 2019 01:44:16 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B69213F246;
        Mon,  8 Jul 2019 01:44:13 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH v11 2/5] sched/core: uclamp: Propagate parent clamps
Date:   Mon,  8 Jul 2019 09:43:54 +0100
Message-Id: <20190708084357.12944-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190708084357.12944-1-patrick.bellasi@arm.com>
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are locally consistent and constrained based on parent's
assigned resources. This requires to properly propagate and aggregate
parent attributes down to its descendants.

Implement this mechanism by adding a new "effective" clamp value for each
task group. The effective clamp value is defined as the smaller value
between the clamp value of a group and the effective clamp value of its
parent. This is the actual clamp value enforced on tasks in a task group.

Since it's possible for a cpu.uclamp.min value to be bigger than the
cpu.uclamp.max value, ensure local consistency by restricting each
"protection"
(i.e. min utilization) with the corresponding "limit" (i.e. max
utilization). Do that at effective clamps propagation to ensure all
user-space write never fails while still always tracking the most
restrictive values.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>

---
Changes in v11:
 Message-ID: <20190624174607.GQ657710@devbig004.ftw2.facebook.com>
 - Removed user-space uclamp.{min.max}.effective API
 - Ensure group limits always clamps group protections
---
 kernel/sched/core.c  | 65 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  2 ++
 2 files changed, 67 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 17ebdaaf7cd9..ec91f4518752 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,6 +773,18 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+/*
+ * Serializes updates of utilization clamp values
+ *
+ * The (slow-path) user-space triggers utilization clamp value updates which
+ * can require updates on (fast-path) scheduler's data structures used to
+ * support enqueue/dequeue operations.
+ * While the per-CPU rq lock protects fast-path update operations, user-space
+ * requests are serialized using a mutex to reduce the risk of conflicting
+ * updates or API abuses.
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
 /* Max allowed minimum utilization */
 unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 
@@ -1137,6 +1149,8 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
+	mutex_init(&uclamp_mutex);
+
 	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
 		cpu_rq(cpu)->uclamp_flags = 0;
@@ -1153,6 +1167,7 @@ static void __init init_uclamp(void)
 		uclamp_default[clamp_id] = uc_max;
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		root_task_group.uclamp_req[clamp_id] = uc_max;
+		root_task_group.uclamp[clamp_id] = uc_max;
 #endif
 	}
 }
@@ -6738,6 +6753,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&tg->uclamp_req[clamp_id],
 			      uclamp_none(clamp_id), false);
+		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
 	}
 #endif
 }
@@ -6988,6 +7004,45 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_se = NULL;
+	unsigned int eff[UCLAMP_CNT];
+	unsigned int clamp_id;
+	unsigned int clamps;
+
+	css_for_each_descendant_pre(css, top_css) {
+		uc_se = css_tg(css)->parent
+			? css_tg(css)->parent->uclamp : NULL;
+
+		for_each_clamp_id(clamp_id) {
+			/* Assume effective clamps matches requested clamps */
+			eff[clamp_id] = css_tg(css)->uclamp_req[clamp_id].value;
+			/* Cap effective clamps with parent's effective clamps */
+			if (uc_se &&
+			    eff[clamp_id] > uc_se[clamp_id].value) {
+				eff[clamp_id] = uc_se[clamp_id].value;
+			}
+		}
+		/* Ensure protection is always capped by limit */
+		eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
+
+		/* Propagate most restrictive effective clamps */
+		clamps = 0x0;
+		uc_se = css_tg(css)->uclamp;
+		for_each_clamp_id(clamp_id) {
+			if (eff[clamp_id] == uc_se[clamp_id].value)
+				continue;
+			uc_se[clamp_id].value = eff[clamp_id];
+			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
+			clamps |= (0x1 << clamp_id);
+		}
+		if (!clamps)
+			css = css_rightmost_descendant(css);
+	}
+}
+
 static inline int uclamp_scale_from_percent(char *buf, u64 *value)
 {
 	*value = SCHED_CAPACITY_SCALE;
@@ -7027,13 +7082,18 @@ static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
 	if (min_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(of_css(of));
 	if (tg->uclamp_req[UCLAMP_MIN].value != min_value)
 		uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN], min_value, false);
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(of_css(of));
+
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return nbytes;
 }
@@ -7052,13 +7112,18 @@ static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
 	if (max_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(of_css(of));
 	if (tg->uclamp_req[UCLAMP_MAX].value != max_value)
 		uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX], max_value, false);
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(of_css(of));
+
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return nbytes;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3723037ea80d..8c3aefdaf0ef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -397,6 +397,8 @@ struct task_group {
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Clamp values requested for a task group */
 	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+	/* Effective clamp values used for a task group */
+	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
 };
-- 
2.21.0

