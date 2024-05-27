Return-Path: <linux-pm+bounces-8189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9108D0708
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DC61C2095B
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE1715F3E7;
	Mon, 27 May 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmT8IJbm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9C15F33A;
	Mon, 27 May 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825243; cv=none; b=NXbpgB2v2I+Kjee552B+XAzuHZoTd0/a7ow84Isw6CkbCSJBleBOekaPruZkB4I6rDl8Ui+3g0V87Xu+HHbU0uN9IX+7Ov3BCoBbXkX2y0Z7xilS6Zb+bHrLINGl5ITvPYwGI49zSDVrHRP0wCNfwY/5UpCnhMLwa8sMXxyXiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825243; c=relaxed/simple;
	bh=l1EmPdSeGJxwIDhQawnhTXJxkxkHEHivp5+X/6ScZCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1+4NnkxGTtBiFKNDVYcbmI0vwZaxUcPGPQxFcg5K8KKyxr8hajI5mYaIbMrywzAlBaQ1mkKwrhGWFSn01uU5Emjq/shH4TMXmMZh+K1IJ4rRVfJNoB+FnECIEbWzm0+luzJS9vf9d8TljJMWiAAqexKWBfF2DD9Ep0zu3c9rpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmT8IJbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E7C2BBFC;
	Mon, 27 May 2024 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825243;
	bh=l1EmPdSeGJxwIDhQawnhTXJxkxkHEHivp5+X/6ScZCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmT8IJbmEua1PwtlH7piBBTR2hINmCmYWFQpwe/S/09vvskxh6KJRC0Q3BWwV7Ohz
	 YN2PjNvXjmgCwgV6jaCTDc0AOOANhDrjoSwMAZKLJfbnhr+Vf2FKc1SBWOR5Nc/aXR
	 /qM3RDzWCrMvlTnfIMPD2HLzMv2GvdejiFsrKEUrMggpwqXLPVluhMDvYFxli99unS
	 eeXVXJ+nnUR8DG5gXVVfm19/YlJwswddApHkA5CX5FIrg5QZCZEVn6KcHc1/5P9eJV
	 CvJq1/vK/YXQfRFAF1/m9LotnYPbyc5HEqCRiajT/sYhgZbXBYZJ1MFoy/YsMBDuVZ
	 Z3MDKwxCkLK1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 05/20] cgroup/cpuset: Make cpuset hotplug processing synchronous
Date: Mon, 27 May 2024 11:52:48 -0400
Message-ID: <20240527155349.3864778-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 2125c0034c5dfd61171b494bd309bb7637bff6eb ]

Since commit 3a5a6d0c2b03("cpuset: don't nest cgroup_mutex inside
get_online_cpus()"), cpuset hotplug was done asynchronously via a work
function. This is to avoid recursive locking of cgroup_mutex.

Since then, the cgroup locking scheme has changed quite a bit. A
cpuset_mutex was introduced to protect cpuset specific operations.
The cpuset_mutex is then replaced by a cpuset_rwsem. With commit
d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock
order"), cpu_hotplug_lock is acquired before cpuset_rwsem. Later on,
cpuset_rwsem is reverted back to cpuset_mutex. All these locking changes
allow the hotplug code to call into cpuset core directly.

The following commits were also merged due to the asynchronous nature
of cpuset hotplug processing.

  - commit b22afcdf04c9 ("cpu/hotplug: Cure the cpusets trainwreck")
  - commit 50e76632339d ("sched/cpuset/pm: Fix cpuset vs. suspend-resume
    bugs")
  - commit 28b89b9e6f7b ("cpuset: handle race between CPU hotplug and
    cpuset_hotplug_work")

Clean up all these bandages by making cpuset hotplug
processing synchronous again with the exception that the call to
cgroup_transfer_tasks() to transfer tasks out of an empty cgroup v1
cpuset, if necessary, will still be done via a work function due to the
existing cgroup_mutex -> cpu_hotplug_lock dependency. It is possible
to reverse that dependency, but that will require updating a number of
different cgroup controllers. This special hotplug code path should be
rarely taken anyway.

As all the cpuset states will be updated by the end of the hotplug
operation, we can revert most the above commits except commit
50e76632339d ("sched/cpuset/pm: Fix cpuset vs. suspend-resume bugs")
which is partially reverted.  Also removing some cpus_read_lock trylock
attempts in the cpuset partition code as they are no longer necessary
since the cpu_hotplug_lock is now held for the whole duration of the
cpuset hotplug code path.

Signed-off-by: Waiman Long <longman@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cpuset.h |   3 -
 kernel/cgroup/cpuset.c | 141 ++++++++++++++++-------------------------
 kernel/cpu.c           |  48 --------------
 kernel/power/process.c |   2 -
 4 files changed, 56 insertions(+), 138 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 875d12598bd2d..c9c90ada8cf91 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -70,7 +70,6 @@ extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
-extern void cpuset_wait_for_hotplug(void);
 extern void inc_dl_tasks_cs(struct task_struct *task);
 extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
@@ -190,8 +189,6 @@ static inline void cpuset_update_active_cpus(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
-static inline void cpuset_wait_for_hotplug(void) { }
-
 static inline void inc_dl_tasks_cs(struct task_struct *task) { }
 static inline void dec_dl_tasks_cs(struct task_struct *task) { }
 static inline void cpuset_lock(void) { }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 927bef3a598ad..db8cbb134cc21 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -201,6 +201,14 @@ struct cpuset {
 	struct list_head remote_sibling;
 };
 
+/*
+ * Legacy hierarchy call to cgroup_transfer_tasks() is handled asynchrously
+ */
+struct cpuset_remove_tasks_struct {
+	struct work_struct work;
+	struct cpuset *cs;
+};
+
 /*
  * Exclusive CPUs distributed out to sub-partitions of top_cpuset
  */
@@ -449,12 +457,6 @@ static DEFINE_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
 
-/*
- * CPU / memory hotplug is handled asynchronously.
- */
-static void cpuset_hotplug_workfn(struct work_struct *work);
-static DECLARE_WORK(cpuset_hotplug_work, cpuset_hotplug_workfn);
-
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
 
 static inline void check_insane_mems_config(nodemask_t *nodes)
@@ -540,22 +542,10 @@ static void guarantee_online_cpus(struct task_struct *tsk,
 	rcu_read_lock();
 	cs = task_cs(tsk);
 
-	while (!cpumask_intersects(cs->effective_cpus, pmask)) {
+	while (!cpumask_intersects(cs->effective_cpus, pmask))
 		cs = parent_cs(cs);
-		if (unlikely(!cs)) {
-			/*
-			 * The top cpuset doesn't have any online cpu as a
-			 * consequence of a race between cpuset_hotplug_work
-			 * and cpu hotplug notifier.  But we know the top
-			 * cpuset's effective_cpus is on its way to be
-			 * identical to cpu_online_mask.
-			 */
-			goto out_unlock;
-		}
-	}
-	cpumask_and(pmask, pmask, cs->effective_cpus);
 
-out_unlock:
+	cpumask_and(pmask, pmask, cs->effective_cpus);
 	rcu_read_unlock();
 }
 
@@ -1217,7 +1207,7 @@ static void rebuild_sched_domains_locked(void)
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
 	 * passing doms with offlined cpu to partition_sched_domains().
-	 * Anyways, cpuset_hotplug_workfn() will rebuild sched domains.
+	 * Anyways, cpuset_handle_hotplug() will rebuild sched domains.
 	 *
 	 * With no CPUs in any subpartitions, top_cpuset's effective CPUs
 	 * should be the same as the active CPUs, so checking only top_cpuset
@@ -1260,12 +1250,17 @@ static void rebuild_sched_domains_locked(void)
 }
 #endif /* CONFIG_SMP */
 
-void rebuild_sched_domains(void)
+static void rebuild_sched_domains_cpuslocked(void)
 {
-	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 	rebuild_sched_domains_locked();
 	mutex_unlock(&cpuset_mutex);
+}
+
+void rebuild_sched_domains(void)
+{
+	cpus_read_lock();
+	rebuild_sched_domains_cpuslocked();
 	cpus_read_unlock();
 }
 
@@ -2079,14 +2074,11 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	/*
 	 * For partcmd_update without newmask, it is being called from
-	 * cpuset_hotplug_workfn() where cpus_read_lock() wasn't taken.
-	 * Update the load balance flag and scheduling domain if
-	 * cpus_read_trylock() is successful.
+	 * cpuset_handle_hotplug(). Update the load balance flag and
+	 * scheduling domain accordingly.
 	 */
-	if ((cmd == partcmd_update) && !newmask && cpus_read_trylock()) {
+	if ((cmd == partcmd_update) && !newmask)
 		update_partition_sd_lb(cs, old_prs);
-		cpus_read_unlock();
-	}
 
 	notify_partition_change(cs, old_prs);
 	return 0;
@@ -3599,8 +3591,8 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	 * proceeding, so that we don't end up keep removing tasks added
 	 * after execution capability is restored.
 	 *
-	 * cpuset_hotplug_work calls back into cgroup core via
-	 * cgroup_transfer_tasks() and waiting for it from a cgroupfs
+	 * cpuset_handle_hotplug may call back into cgroup core asynchronously
+	 * via cgroup_transfer_tasks() and waiting for it from a cgroupfs
 	 * operation like this one can lead to a deadlock through kernfs
 	 * active_ref protection.  Let's break the protection.  Losing the
 	 * protection is okay as we check whether @cs is online after
@@ -3609,7 +3601,6 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	 */
 	css_get(&cs->css);
 	kernfs_break_active_protection(of->kn);
-	flush_work(&cpuset_hotplug_work);
 
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
@@ -4353,6 +4344,16 @@ static void remove_tasks_in_empty_cpuset(struct cpuset *cs)
 	}
 }
 
+static void cpuset_migrate_tasks_workfn(struct work_struct *work)
+{
+	struct cpuset_remove_tasks_struct *s;
+
+	s = container_of(work, struct cpuset_remove_tasks_struct, work);
+	remove_tasks_in_empty_cpuset(s->cs);
+	css_put(&s->cs->css);
+	kfree(s);
+}
+
 static void
 hotplug_update_tasks_legacy(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
@@ -4382,12 +4383,21 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
 	 * This is full cgroup operation which will also call back into
-	 * cpuset. Should be done outside any lock.
+	 * cpuset. Execute it asynchronously using workqueue.
 	 */
-	if (is_empty) {
-		mutex_unlock(&cpuset_mutex);
-		remove_tasks_in_empty_cpuset(cs);
-		mutex_lock(&cpuset_mutex);
+	if (is_empty && cs->css.cgroup->nr_populated_csets &&
+	    css_tryget_online(&cs->css)) {
+		struct cpuset_remove_tasks_struct *s;
+
+		s = kzalloc(sizeof(*s), GFP_KERNEL);
+		if (WARN_ON_ONCE(!s)) {
+			css_put(&cs->css);
+			return;
+		}
+
+		s->cs = cs;
+		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
+		schedule_work(&s->work);
 	}
 }
 
@@ -4420,30 +4430,6 @@ void cpuset_force_rebuild(void)
 	force_rebuild = true;
 }
 
-/*
- * Attempt to acquire a cpus_read_lock while a hotplug operation may be in
- * progress.
- * Return: true if successful, false otherwise
- *
- * To avoid circular lock dependency between cpuset_mutex and cpus_read_lock,
- * cpus_read_trylock() is used here to acquire the lock.
- */
-static bool cpuset_hotplug_cpus_read_trylock(void)
-{
-	int retries = 0;
-
-	while (!cpus_read_trylock()) {
-		/*
-		 * CPU hotplug still in progress. Retry 5 times
-		 * with a 10ms wait before bailing out.
-		 */
-		if (++retries > 5)
-			return false;
-		msleep(10);
-	}
-	return true;
-}
-
 /**
  * cpuset_hotplug_update_tasks - update tasks in a cpuset for hotunplug
  * @cs: cpuset in interest
@@ -4492,13 +4478,11 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		compute_partition_effective_cpumask(cs, &new_cpus);
 
 	if (remote && cpumask_empty(&new_cpus) &&
-	    partition_is_populated(cs, NULL) &&
-	    cpuset_hotplug_cpus_read_trylock()) {
+	    partition_is_populated(cs, NULL)) {
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
 		remote = false;
 		cpuset_force_rebuild();
-		cpus_read_unlock();
 	}
 
 	/*
@@ -4518,18 +4502,8 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	else if (is_partition_valid(parent) && is_partition_invalid(cs))
 		partcmd = partcmd_update;
 
-	/*
-	 * cpus_read_lock needs to be held before calling
-	 * update_parent_effective_cpumask(). To avoid circular lock
-	 * dependency between cpuset_mutex and cpus_read_lock,
-	 * cpus_read_trylock() is used here to acquire the lock.
-	 */
 	if (partcmd >= 0) {
-		if (!cpuset_hotplug_cpus_read_trylock())
-			goto update_tasks;
-
 		update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
-		cpus_read_unlock();
 		if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
 			compute_partition_effective_cpumask(cs, &new_cpus);
 			cpuset_force_rebuild();
@@ -4557,8 +4531,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 }
 
 /**
- * cpuset_hotplug_workfn - handle CPU/memory hotunplug for a cpuset
- * @work: unused
+ * cpuset_handle_hotplug - handle CPU/memory hot{,un}plug for a cpuset
  *
  * This function is called after either CPU or memory configuration has
  * changed and updates cpuset accordingly.  The top_cpuset is always
@@ -4572,8 +4545,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
  *
  * Note that CPU offlining during suspend is ignored.  We don't modify
  * cpusets across suspend/resume cycles at all.
+ *
+ * CPU / memory hotplug is handled synchronously.
  */
-static void cpuset_hotplug_workfn(struct work_struct *work)
+static void cpuset_handle_hotplug(void)
 {
 	static cpumask_t new_cpus;
 	static nodemask_t new_mems;
@@ -4584,6 +4559,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
+	lockdep_assert_cpus_held();
 	mutex_lock(&cpuset_mutex);
 
 	/* fetch the available cpus/mems and find out which changed how */
@@ -4665,7 +4641,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	/* rebuild sched domains if cpus_allowed has changed */
 	if (cpus_updated || force_rebuild) {
 		force_rebuild = false;
-		rebuild_sched_domains();
+		rebuild_sched_domains_cpuslocked();
 	}
 
 	free_cpumasks(NULL, ptmp);
@@ -4678,12 +4654,7 @@ void cpuset_update_active_cpus(void)
 	 * inside cgroup synchronization.  Bounce actual hotplug processing
 	 * to a work item to avoid reverse locking order.
 	 */
-	schedule_work(&cpuset_hotplug_work);
-}
-
-void cpuset_wait_for_hotplug(void)
-{
-	flush_work(&cpuset_hotplug_work);
+	cpuset_handle_hotplug();
 }
 
 /*
@@ -4694,7 +4665,7 @@ void cpuset_wait_for_hotplug(void)
 static int cpuset_track_online_nodes(struct notifier_block *self,
 				unsigned long action, void *arg)
 {
-	schedule_work(&cpuset_hotplug_work);
+	cpuset_handle_hotplug();
 	return NOTIFY_OK;
 }
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f8a0406ce8ba5..f0ef0754753f9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1209,52 +1209,6 @@ void __init cpuhp_threads_init(void)
 	kthread_unpark(this_cpu_read(cpuhp_state.thread));
 }
 
-/*
- *
- * Serialize hotplug trainwrecks outside of the cpu_hotplug_lock
- * protected region.
- *
- * The operation is still serialized against concurrent CPU hotplug via
- * cpu_add_remove_lock, i.e. CPU map protection.  But it is _not_
- * serialized against other hotplug related activity like adding or
- * removing of state callbacks and state instances, which invoke either the
- * startup or the teardown callback of the affected state.
- *
- * This is required for subsystems which are unfixable vs. CPU hotplug and
- * evade lock inversion problems by scheduling work which has to be
- * completed _before_ cpu_up()/_cpu_down() returns.
- *
- * Don't even think about adding anything to this for any new code or even
- * drivers. It's only purpose is to keep existing lock order trainwrecks
- * working.
- *
- * For cpu_down() there might be valid reasons to finish cleanups which are
- * not required to be done under cpu_hotplug_lock, but that's a different
- * story and would be not invoked via this.
- */
-static void cpu_up_down_serialize_trainwrecks(bool tasks_frozen)
-{
-	/*
-	 * cpusets delegate hotplug operations to a worker to "solve" the
-	 * lock order problems. Wait for the worker, but only if tasks are
-	 * _not_ frozen (suspend, hibernate) as that would wait forever.
-	 *
-	 * The wait is required because otherwise the hotplug operation
-	 * returns with inconsistent state, which could even be observed in
-	 * user space when a new CPU is brought up. The CPU plug uevent
-	 * would be delivered and user space reacting on it would fail to
-	 * move tasks to the newly plugged CPU up to the point where the
-	 * work has finished because up to that point the newly plugged CPU
-	 * is not assignable in cpusets/cgroups. On unplug that's not
-	 * necessarily a visible issue, but it is still inconsistent state,
-	 * which is the real problem which needs to be "fixed". This can't
-	 * prevent the transient state between scheduling the work and
-	 * returning from waiting for it.
-	 */
-	if (!tasks_frozen)
-		cpuset_wait_for_hotplug();
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 #ifndef arch_clear_mm_cpumask_cpu
 #define arch_clear_mm_cpumask_cpu(cpu, mm) cpumask_clear_cpu(cpu, mm_cpumask(mm))
@@ -1498,7 +1452,6 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 */
 	lockup_detector_cleanup();
 	arch_smt_update();
-	cpu_up_down_serialize_trainwrecks(tasks_frozen);
 	return ret;
 }
 
@@ -1732,7 +1685,6 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 out:
 	cpus_write_unlock();
 	arch_smt_update();
-	cpu_up_down_serialize_trainwrecks(tasks_frozen);
 	return ret;
 }
 
diff --git a/kernel/power/process.c b/kernel/power/process.c
index cae81a87cc91e..66ac067d9ae64 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -194,8 +194,6 @@ void thaw_processes(void)
 	__usermodehelper_set_disable_depth(UMH_FREEZING);
 	thaw_workqueues();
 
-	cpuset_wait_for_hotplug();
-
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
 		/* No other threads should have PF_SUSPEND_TASK set */
-- 
2.43.0


