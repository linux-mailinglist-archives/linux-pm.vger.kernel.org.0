Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570E44E239
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfFUInK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 04:43:10 -0400
Received: from foss.arm.com ([217.140.110.172]:51072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfFUInJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Jun 2019 04:43:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 668181570;
        Fri, 21 Jun 2019 01:43:08 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 131743F246;
        Fri, 21 Jun 2019 01:43:05 -0700 (PDT)
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
Subject: [PATCH v10 13/16] sched/core: uclamp: Propagate parent clamps
Date:   Fri, 21 Jun 2019 09:42:14 +0100
Message-Id: <20190621084217.8167-14-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621084217.8167-1-patrick.bellasi@arm.com>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are (potentially) constrained based on parent's assigned
resources. This requires to properly propagate and aggregate parent
attributes down to its descendants.

Let's implement this mechanism by adding a new "effective" clamp value
for each task group. The effective clamp value is defined as the smaller
value between the clamp value of a group and the effective clamp value
of its parent. This is the actual clamp value enforced on tasks in a
task group.

Since it can be interesting for userspace, e.g. system management
software, to know exactly what the currently propagated/enforced
configuration is, the effective clamp values are exposed to user-space
by means of a new pair of read-only attributes
cpu.util.{min,max}.effective.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>

---
Changes in v10:
 Message-ID: <https://lore.kernel.org/lkml/20190603122422.GA19426@darkstar/>
 - rename cgroup attributes to be cpu.uclamp.{min,max}
 Message-ID: <https://lore.kernel.org/lkml/20190605152754.GO374014@devbig004.ftw2.facebook.com/>
 - use a percentage rational numbers for clamp attributes
---
 Documentation/admin-guide/cgroup-v2.rst |  21 +++++
 kernel/sched/core.c                     | 103 +++++++++++++++++++++++-
 kernel/sched/sched.h                    |   2 +
 3 files changed, 122 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 4761d20c5cad..d4407c40bc64 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1033,6 +1033,17 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This minimum utilization
         value is used to clamp the task specific minimum utilization clamp.
 
+  cpu.uclamp.min.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports minimum utilization clamp value currently enforced on a task
+        group.
+
+        The actual minimum utilization as a percentage rational number,
+        e.g. 12.34 for 12.34%.
+
+        This value can be lower then cpu.uclamp.min in case a parent cgroup
+        allows only smaller minimum utilization values.
+
   cpu.uclamp.max
         A read-write single value file which exists on non-root cgroups.
         The default is "max". i.e. no utilization capping
@@ -1044,6 +1055,16 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.uclamp.max.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports maximum utilization clamp value currently enforced on a task
+        group.
+
+        The actual maximum utilization as a percentage rational number,
+        e.g. 98.76 for 98.76%.
+
+        This value can be lower then cpu.uclamp.max in case a parent cgroup
+        is enforcing a more restrictive clamping on max utilization.
 
 
 Memory
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0975f832066e..2b4d0b9bd6b9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -762,6 +762,18 @@ static void set_load_weight(struct task_struct *p, bool update_load)
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
 
@@ -1126,6 +1138,8 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
+	mutex_init(&uclamp_mutex);
+
 	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
 		cpu_rq(cpu)->uclamp_flags = 0;
@@ -1142,6 +1156,7 @@ static void __init init_uclamp(void)
 		uclamp_default[clamp_id] = uc_max;
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		root_task_group.uclamp_req[clamp_id] = uc_max;
+		root_task_group.uclamp[clamp_id] = uc_max;
 #endif
 	}
 }
@@ -6727,6 +6742,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&tg->uclamp_req[clamp_id],
 			      uclamp_none(clamp_id), false);
+		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
 	}
 #endif
 }
@@ -6977,6 +6993,44 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css,
+				unsigned int clamp_id)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_se, *uc_parent;
+	unsigned int value;
+
+	css_for_each_descendant_pre(css, top_css) {
+		value = css_tg(css)->uclamp_req[clamp_id].value;
+
+		uc_parent = NULL;
+		if (css_tg(css)->parent)
+			uc_parent = &css_tg(css)->parent->uclamp[clamp_id];
+
+		/*
+		 * Skip the whole subtrees if the current effective clamp is
+		 * already matching the TG's clamp value.
+		 * In this case, all the subtrees already have top_value, or a
+		 * more restrictive value, as effective clamp.
+		 */
+		uc_se = &css_tg(css)->uclamp[clamp_id];
+		if (uc_se->value == value &&
+		    uc_parent && uc_parent->value >= value) {
+			css = css_rightmost_descendant(css);
+			continue;
+		}
+
+		/* Propagate the most restrictive effective value */
+		if (uc_parent && uc_parent->value < value)
+			value = uc_parent->value;
+		if (uc_se->value == value)
+			continue;
+
+		uc_se->value = value;
+		uc_se->bucket_id = uclamp_bucket_id(value);
+	}
+}
+
 static inline int uclamp_scale_from_percent(char *buf, u64 *value)
 {
 	*value = SCHED_CAPACITY_SCALE;
@@ -7016,6 +7070,7 @@ static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
 	if (min_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(of_css(of));
@@ -7032,8 +7087,12 @@ static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
 
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN], min_value, false);
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(of_css(of), UCLAMP_MIN);
+
 out:
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return nbytes;
 }
@@ -7052,6 +7111,7 @@ static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
 	if (max_value > SCHED_CAPACITY_SCALE)
 		return -ERANGE;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(of_css(of));
@@ -7068,14 +7128,19 @@ static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
 
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX], max_value, false);
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(of_css(of), UCLAMP_MAX);
+
 out:
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return nbytes;
 }
 
 static inline void cpu_uclamp_print(struct seq_file *sf,
-				    enum uclamp_id clamp_id)
+				    enum uclamp_id clamp_id,
+				    bool effective)
 {
 	struct task_group *tg;
 	u64 util_clamp;
@@ -7083,7 +7148,9 @@ static inline void cpu_uclamp_print(struct seq_file *sf,
 
 	rcu_read_lock();
 	tg = css_tg(seq_css(sf));
-	util_clamp = tg->uclamp_req[clamp_id].value;
+	util_clamp = effective
+		? tg->uclamp[clamp_id].value
+		: tg->uclamp_req[clamp_id].value;
 	rcu_read_unlock();
 
 	if (util_clamp == SCHED_CAPACITY_SCALE) {
@@ -7097,13 +7164,25 @@ static inline void cpu_uclamp_print(struct seq_file *sf,
 
 static int cpu_uclamp_min_show(struct seq_file *sf, void *v)
 {
-	cpu_uclamp_print(sf, UCLAMP_MIN);
+	cpu_uclamp_print(sf, UCLAMP_MIN, false);
 	return 0;
 }
 
 static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 {
-	cpu_uclamp_print(sf, UCLAMP_MAX);
+	cpu_uclamp_print(sf, UCLAMP_MAX, false);
+	return 0;
+}
+
+static int cpu_uclamp_min_effective_show(struct seq_file *sf, void *v)
+{
+	cpu_uclamp_print(sf, UCLAMP_MIN, true);
+	return 0;
+}
+
+static int cpu_uclamp_max_effective_show(struct seq_file *sf, void *v)
+{
+	cpu_uclamp_print(sf, UCLAMP_MAX, true);
 	return 0;
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
@@ -7460,12 +7539,20 @@ static struct cftype cpu_legacy_files[] = {
 		.seq_show = cpu_uclamp_min_show,
 		.write = cpu_uclamp_min_write,
 	},
+	{
+		.name = "uclamp.min.effective",
+		.seq_show = cpu_uclamp_min_effective_show,
+	},
 	{
 		.name = "uclamp.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+	{
+		.name = "uclamp.max.effective",
+		.seq_show = cpu_uclamp_max_effective_show,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7641,12 +7728,20 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_uclamp_min_show,
 		.write = cpu_uclamp_min_write,
 	},
+	{
+		.name = "uclamp.min.effective",
+		.seq_show = cpu_uclamp_min_effective_show,
+	},
 	{
 		.name = "uclamp.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+	{
+		.name = "uclamp.max.effective",
+		.seq_show = cpu_uclamp_max_effective_show,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bdbefd50ff46..507c99898a2a 100644
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

