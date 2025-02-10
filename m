Return-Path: <linux-pm+bounces-21614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FCFA2E1A9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 00:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4EC1887C9C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A1185935;
	Sun,  9 Feb 2025 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="WdU4uUqp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CA156C69
	for <linux-pm@vger.kernel.org>; Sun,  9 Feb 2025 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739145135; cv=none; b=UpE3MfSYaSAPc9r2TRwTxKOwk/JOu9IDsbmNuxrIRxUBPFKmHOiI5L0N1qI/xareeNOKejJd5Gdgef8E4oqSZZFAivowjJUcs9xefFqn/Gs+gpUo+zgjHEKHmhc91lMy2LRj8GILVYAN0vutMywZl4XLzviX7z0uQzxfgxqLRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739145135; c=relaxed/simple;
	bh=MJRJTZptNQd5eeRVN2cfR0sFt3zjXuNyz6Pj9oJAQmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BPfIp9vqgjy538XowFVMAMkNVtmS7XtHxzjFWIlBtPgSXj6Eem5zmy/z8C/dWM0tfRrqHIkdn3b4FigKMnElukXz0Kt2WVKGRvPPbRsz0qk/hFOxkrYhboLThegv+sOPzVeUkleBVU0MjkbS1BsB95Xc6FxyCPP9i9DlHzvBh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=WdU4uUqp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so37341215e9.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2025 15:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1739145129; x=1739749929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odHvkjpC27FVy/jm9E//B94Km7YA3klTRdHp05wOgPQ=;
        b=WdU4uUqpJoEAhHRGUDY6sgSY8n+Kc2A7OJLSLA4DYVU/YqLF4YLtzkrv80iwJCrM0h
         4N7yd2SLH+E/5485azxt8dYvE67RYt/uy402HmPxnm6u5UgGNARoXKPDrDpH/ZLbybv1
         nxMNQTAT5WSpv+oFN2EeY8ZSwMBoXU8ZWbwS6/0vSIrZaJHV1aE9rGCx6CB+ak45QDdo
         CtD4QEvv1Of6LMWsKQMZ7cnGKfs4IHy8rVzAglfMD6EHsjngvLwhOvhs1LkA9ixa/mqG
         Hr6OwPsgdSHtvH7vSXG6/wvqZI8LALlQcS0H0ERTUj3MHUsktNRZDg40Gu26g754GoF0
         D6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739145129; x=1739749929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odHvkjpC27FVy/jm9E//B94Km7YA3klTRdHp05wOgPQ=;
        b=jT/9f6rLq7wgNCxsk5NzzsVZJkn5fmDpzw1fFIBluLZZANEZo6x9TJwTTRmej0qC4K
         VHc98UZIfLmszWS6/6u4xcjYQTcyOnik12G4pdGjg4U4SiIme8tIE6KF1vDMJrTCr4Im
         DStqyPv7U6vZSSxG+Y1lJObjLdXRJ64IkDgTgSg6KnbKayhHJ6PVPZNnX6zzJGeONDaV
         A+vauvES9qcUBrEeCTw/7RodwmQBtYdwb1avOGSjvEurdEysEOlucJ3aQDUbf3qqfi4T
         at8uOYtPLxcTsWfAVaqYpT23R6C46Wn7NdYqcjlRg6YF74JsNGcwDbIengHvJvG6EdiH
         bUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwKngnl9G/dtIrbzNS3qwAl3FVN5A/fxtK0CgbLAFLbsLtKi2DhDUm9qlQugurHcxXi9iMa9HXnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmSD9auTOTdHz6EGkkTtvkLJlnvUcWe4GgsbJxCKnMZ7g/XOn
	6lK6OaH0CwVGEYYHUVuUl/5twUqCPic9z8ldSaAp2mNvIUbLfO8wEawENg0jMH8=
X-Gm-Gg: ASbGncugeDfEtlv5wBkKtPHwyqb8g2e5YQxmu2W+VWg5ACRk7h+0bsJIvP3Y/60TDeu
	Ci5dLoIH5I+Bc3kPvpH4ukFGFUzU824P8b/8Zeo/Gq6pnhXxOgQeWMr9FH7AIM6u5bPIkXKLLSD
	3YgjLeBrFyFSlaETQxiPltOedrHv5zaxk0q39TLWrhU4HqJUrRvjD9R3pZniE7UWpjdC0XXUP5P
	rSXGPmMjvLrAsHMJFfhUYFsLGoQ8asNBYcBf0iUW+mn+SWyNLRUdqcr5bxEo7J7Y9G2aeHLVipo
	786Ck1VhXGL2qEB0HrzioGDDold5VuYtALw3D060TUM1wU51rg0YsvGdfPg1avmNRVTX3/c=
X-Google-Smtp-Source: AGHT+IF7hUQSFzjZ1ar5J/ndBdnLJsbvrqLMKvkPOeD6xstK1z66V/d8VdUx+pJlNcJTCWwefYRBGg==
X-Received: by 2002:a05:600c:3c84:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-43924991e0cmr90929725e9.14.1739145128291;
        Sun, 09 Feb 2025 15:52:08 -0800 (PST)
Received: from airbuntu.. (host109-154-33-115.range109-154.btcentralplus.com. [109.154.33.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d96530fsm160393125e9.19.2025.02.09.15.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 15:52:07 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>,
	Anjali K <anjalik@linux.ibm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v8] sched: Consolidate cpufreq updates
Date: Sun,  9 Feb 2025 23:52:04 +0000
Message-Id: <20250209235204.110989-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the interaction with cpufreq governors by making the
cpufreq_update_util() calls more intentional.

At the moment we send them when load is updated for CFS, bandwidth for
DL and at enqueue/dequeue for RT. But this can lead to too many updates
sent in a short period of time and potentially be ignored at a critical
moment due to the rate_limit_us in schedutil.

For example, simultaneous task enqueue on the CPU where 2nd task is
bigger and requires higher freq. The trigger to cpufreq_update_util() by
the first task will lead to dropping the 2nd request until tick. Or
another CPU in the same policy triggers a freq update shortly after.

Updates at enqueue for RT are not strictly required. Though they do help
to reduce the delay for switching the frequency and the potential
observation of lower frequency during this delay. But current logic
doesn't intentionally (at least to my understanding) try to speed up the
request.

To help reduce the amount of cpufreq updates and make them more
purposeful, consolidate them into these locations:

1. context_switch()
2. task_tick_fair()
3. sched_balance_update_blocked_averages()
4. on sched_setscheduler() syscall that changes policy or uclamp values
5. on check_preempt_wakeup_fair() if wakeup preemption failed
6. on __add_running_bw() to guarantee DL bandwidth requirements.

The update at context switch should help guarantee that RT get the right
frequency straightaway when they're RUNNING. As mentioned though the
update will happen slightly after enqueue_task(); though in an ideal
world these tasks should be RUNNING ASAP and this additional delay
should be negligible. For fair tasks we need to make sure we send
a single update for every decay for the root cfs_rq. Any changes to the
rq will be deferred until the next task is ready to run, or we hit TICK.
But we are guaranteed the task is running at a level that meets its
requirements after enqueue.

To guarantee RT and DL tasks updates are never missed, we add a new
SCHED_CPUFREQ_FORCE_UPDATE to ignore the rate_limit_us. If we are
already running at the right freq, the governor will end up doing
nothing, but we eliminate the risk of the task ending up accidentally
running at the wrong freq due to rate_limit_us.

Similarly for iowait boost, we ignore rate limits. We also handle a case
of a boost reset prematurely by adding a guard in sugov_iowait_apply()
to reduce the boost after 1ms which seems iowait boost mechanism relied
on rate_limit_us and cfs_rq.decayed preventing any updates to happen
soon after iowait boost.

The new SCHED_CPUFREQ_FORCE_UPDATE should not impact the rate limit
time stamps otherwise we can end up delaying updates for normal
requests.

As a simple optimization, we avoid sending cpufreq updates when
switching from RT to another RT as RT tasks run at max freq by default.
If CONFIG_UCLAMP_TASK is enabled, we can do a simple check to see if
uclamp_min is different to avoid unnecessary cpufreq update as most RT
tasks are likely to be running at the same performance level, so we can
avoid unnecessary overhead of forced updates when there's nothing to do.

We also ensure to ignore cpufreq udpates for sugov workers at context
switch if it was prev task.

The update at task_tick_fair() will guarantee that the governor will
follow any updates to load for tasks/CPU or due to new enqueues/dequeues
to the rq. Since DL and RT always run at constant frequencies and have
no load tracking, this is only required for fair tasks.

The update at update_blocked_averages() will ensure we decay frequency
as the CPU becomes idle for long enough.

If the currently running task changes its policy or uclamp values, we
ensure we follow up with cpufreq update to ensure we follow up with any
potential new perf requirements based on the new change.

To handle systems with long TICK where tasks could end up enqueued but
no preemption happens until TICK, we add an update in
check_preempt_wakeup_fair() if wake up preemption fails. This will send
special SCHED_CPUFREQ_TASK_ENQUEUED cpufreq update to tell the governor
that the state of the CPU has changed and it can consider an update if
it deems worthwhile. In schedutil this will do an update if no update
was done since 1ms which is how often util_avg changes roughly.

To ensure DL tasks bandwidth are respected, we do the update on
__add_running_bw() instead of context switch as the delay could result
in missing a deadline when multiple DL tasks are RUNNING.

Since now DL tasks always ignore rate limit, remove
ignore_dl_rate_limit() function as it's no longer necessary.

Also move updating sg_cpu->last_update inside sugov_iowait_boost() where
this variable is associated and rename it to last_iowait_update to
better reflect it is iowait boost specific.

Note worthy that we still have the following race condition on systems
that have shared policy:

Changes to util_est are treated as a change to util_avg and will trigger
a cpufreq update.

* CPUs with shared policy can end up sending simultaneous cpufreq
  updates requests where the 2nd one will be unlucky and get blocked by
  the rate_limit_us (schedutil).

We can potentially address this limitation later, but it is out of the
scope of this patch.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/cpufreq.h    |   4 +-
 kernel/sched/core.c              | 116 +++++++++++++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c | 122 +++++++++++++++++++------------
 kernel/sched/deadline.c          |  10 ++-
 kernel/sched/fair.c              |  84 +++++++++------------
 kernel/sched/rt.c                |   8 +-
 kernel/sched/sched.h             |   9 ++-
 kernel/sched/syscalls.c          |  30 ++++++--
 8 files changed, 266 insertions(+), 117 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..5409a9f79cc0 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -8,7 +8,9 @@
  * Interface between cpufreq drivers and the scheduler:
  */
 
-#define SCHED_CPUFREQ_IOWAIT	(1U << 0)
+#define SCHED_CPUFREQ_IOWAIT		(1U << 0)
+#define SCHED_CPUFREQ_FORCE_UPDATE	(1U << 1) /* ignore transition_delay_us */
+#define SCHED_CPUFREQ_TASK_ENQUEUED	(1U << 2) /* new fair task was enqueued */
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9142a0394d46..811ea6e60871 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -153,6 +153,9 @@ const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
+static __always_inline void
+__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev);
+
 #ifdef CONFIG_SCHED_CORE
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
@@ -2169,17 +2172,24 @@ void check_class_changing(struct rq *rq, struct task_struct *p,
  * this means any call to check_class_changed() must be followed by a call to
  * balance_callback().
  */
-void check_class_changed(struct rq *rq, struct task_struct *p,
+bool check_class_changed(struct rq *rq, struct task_struct *p,
 			 const struct sched_class *prev_class,
 			 int oldprio)
 {
+	bool class_changed = false;
+
 	if (prev_class != p->sched_class) {
 		if (prev_class->switched_from)
 			prev_class->switched_from(rq, p);
 
 		p->sched_class->switched_to(rq, p);
-	} else if (oldprio != p->prio || dl_task(p))
+
+		class_changed = true;
+	} else if (oldprio != p->prio || dl_task(p)) {
 		p->sched_class->prio_changed(rq, p, oldprio);
+	}
+
+	return class_changed;
 }
 
 void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
@@ -5102,6 +5112,93 @@ static inline void __balance_callbacks(struct rq *rq)
 
 #endif
 
+static __always_inline void
+__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
+{
+#ifdef CONFIG_CPU_FREQ
+	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
+		/* Sugov just did an update, don't be too aggressive */
+		return;
+	}
+
+	/*
+	 * RT and DL should always send a freq update. But we can do some
+	 * simple checks to avoid it when we know it's not necessary.
+	 *
+	 * iowait_boost will always trigger a freq update too.
+	 *
+	 * Fair tasks will only trigger an update if the root cfs_rq has
+	 * decayed.
+	 *
+	 * Everything else should do nothing.
+	 */
+	switch (current->policy) {
+	case SCHED_NORMAL:
+	case SCHED_BATCH:
+	case SCHED_IDLE:
+		if (unlikely(current->in_iowait)) {
+			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
+			return;
+		}
+
+#ifdef CONFIG_SMP
+		/*
+		 * Send an update if we switched from RT or DL as they tend to
+		 * boost the CPU and we are likely able to reduce the freq now.
+		 */
+		rq->cfs.decayed |= prev && (rt_policy(prev->policy) || dl_policy(prev->policy));
+
+		if (unlikely(rq->cfs.decayed)) {
+			rq->cfs.decayed = false;
+			cpufreq_update_util(rq, 0);
+			return;
+		}
+#else
+		cpufreq_update_util(rq, 0);
+#endif
+		return;
+	case SCHED_FIFO:
+	case SCHED_RR:
+		if (prev && rt_policy(prev->policy)) {
+#ifdef CONFIG_UCLAMP_TASK
+			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
+			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
+
+			if (curr_uclamp_min == prev_uclamp_min)
+#endif
+				return;
+		}
+#ifdef CONFIG_SMP
+		/* Stopper task masquerades as RT */
+		if (unlikely(current->sched_class == &stop_sched_class))
+			return;
+#endif
+		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
+		return;
+	case SCHED_DEADLINE:
+		/*
+		 * This is handled at enqueue to avoid breaking DL bandwidth
+		 * rules when multiple DL tasks are running on the same CPU.
+		 * Deferring till context switch here could mean the bandwidth
+		 * calculations would be broken to ensure all the DL tasks meet
+		 * their deadlines.
+		 */
+		return;
+	default:
+		return;
+	}
+#endif
+}
+
+/*
+ * Call when currently running task had an attribute change that requires
+ * an immediate cpufreq update.
+ */
+void update_cpufreq_current(struct rq *rq)
+{
+	__update_cpufreq_ctx_switch(rq, NULL);
+}
+
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -5119,7 +5216,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -5128,6 +5225,11 @@ static inline void finish_lock_switch(struct rq *rq)
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
 	__balance_callbacks(rq);
+	/*
+	 * Request freq update after __balance_callbacks to take into account
+	 * any changes to rq.
+	 */
+	__update_cpufreq_ctx_switch(rq, prev);
 	raw_spin_rq_unlock_irq(rq);
 }
 
@@ -5246,7 +5348,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
 	tick_nohz_task_switch();
-	finish_lock_switch(rq);
+	finish_lock_switch(rq, prev);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
 	/*
@@ -7159,6 +7261,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	int prio, oldprio, queued, running, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class, *next_class;
+	bool class_changed;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -7268,7 +7371,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (running)
 		set_next_task(rq, p);
 
-	check_class_changed(rq, p, prev_class, oldprio);
+	class_changed = check_class_changed(rq, p, prev_class, oldprio);
+	if (class_changed && running)
+		update_cpufreq_current(rq);
+
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a2a29e3fffca..e373e19401a1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -44,7 +44,7 @@ struct sugov_cpu {
 
 	bool			iowait_boost_pending;
 	unsigned int		iowait_boost;
-	u64			last_update;
+	u64			last_iowait_update;
 
 	unsigned long		util;
 	unsigned long		bw_min;
@@ -59,10 +59,31 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
+				     unsigned int flags)
 {
 	s64 delta_ns;
 
+	delta_ns = time - sg_policy->last_freq_update_time;
+
+	/*
+	 * We want to update cpufreq at context switch, but on systems with
+	 * long TICK values, this can happen after a long time while more tasks
+	 * would have been added meanwhile leaving us potentially running at
+	 * inadequate frequency for extended period of time.
+	 *
+	 * This logic should only apply when new fair task was added to the
+	 * CPU, we'd want to defer to context switch as much as possible, but
+	 * to avoid the potential delays mentioned above, let's check if this
+	 * additional tasks warrants sending an update sooner.
+	 *
+	 * We want to ensure there's at least an update every 1ms.
+	 */
+	if (likely(flags & SCHED_CPUFREQ_TASK_ENQUEUED)) {
+		if (delta_ns < NSEC_PER_MSEC)
+			return false;
+	}
+
 	/*
 	 * Since cpufreq_update_util() is called with rq->lock held for
 	 * the @target_cpu, our per-CPU data is fully serialized.
@@ -87,13 +108,14 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return true;
 	}
 
-	delta_ns = time - sg_policy->last_freq_update_time;
+	if (unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
+		return true;
 
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
-				   unsigned int next_freq)
+				   unsigned int next_freq, unsigned int flags)
 {
 	if (sg_policy->need_freq_update)
 		sg_policy->need_freq_update = false;
@@ -101,7 +123,9 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 		return false;
 
 	sg_policy->next_freq = next_freq;
-	sg_policy->last_freq_update_time = time;
+
+	if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
+		sg_policy->last_freq_update_time = time;
 
 	return true;
 }
@@ -221,7 +245,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 			       bool set_iowait_boost)
 {
-	s64 delta_ns = time - sg_cpu->last_update;
+	s64 delta_ns = time - sg_cpu->last_iowait_update;
 
 	/* Reset boost only if a tick has elapsed since last request */
 	if (delta_ns <= TICK_NSEC)
@@ -251,30 +275,33 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned int flags)
 {
 	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
+	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
 
 	/* Reset boost if the CPU appears to have been idle enough */
-	if (sg_cpu->iowait_boost &&
+	if (sg_cpu->iowait_boost && !forced_update &&
 	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
-		return;
+		goto done;
 
 	/* Boost only tasks waking up after IO */
 	if (!set_iowait_boost)
-		return;
+		goto done;
 
 	/* Ensure boost doubles only one time at each request */
 	if (sg_cpu->iowait_boost_pending)
-		return;
+		goto done;
 	sg_cpu->iowait_boost_pending = true;
 
 	/* Double the boost at each request */
 	if (sg_cpu->iowait_boost) {
 		sg_cpu->iowait_boost =
 			min_t(unsigned int, sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
-		return;
+		goto done;
 	}
 
 	/* First wakeup after IO: start with minimum boost */
 	sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
+done:
+	sg_cpu->last_iowait_update = time;
 }
 
 /**
@@ -296,17 +323,34 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * being more conservative on tasks which does sporadic IO operations.
  */
 static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
-			       unsigned long max_cap)
+			       unsigned long max_cap, unsigned int flags)
 {
+	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
+	s64 delta_ns = time - sg_cpu->last_iowait_update;
+
 	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
 		return 0;
 
+	if (forced_update)
+		goto apply_boost;
+
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sugov_iowait_reset(sg_cpu, time, false))
 		return 0;
 
 	if (!sg_cpu->iowait_boost_pending) {
+		/*
+		 * This logic relied on PELT signal decays happening once every
+		 * 1ms. But due to changes to how updates are done now, we can
+		 * end up with more request coming up leading to iowait boost
+		 * to be prematurely reduced. Make the assumption explicit
+		 * until we improve the iowait boost logic to be better in
+		 * general as it is due for an overhaul.
+		 */
+		if (delta_ns < NSEC_PER_MSEC)
+			goto apply_boost;
+
 		/*
 		 * No boost pending; reduce the boost value.
 		 */
@@ -317,6 +361,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		}
 	}
 
+apply_boost:
 	sg_cpu->iowait_boost_pending = false;
 
 	/*
@@ -358,31 +403,18 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return false; }
 #endif /* CONFIG_NO_HZ_COMMON */
 
-/*
- * Make sugov_should_update_freq() ignore the rate limit when DL
- * has increased the utilization.
- */
-static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu)
-{
-	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
-		sg_cpu->sg_policy->limits_changed = true;
-}
-
 static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
 	unsigned long boost;
 
-	sugov_iowait_boost(sg_cpu, time, flags);
-	sg_cpu->last_update = time;
-
-	ignore_dl_rate_limit(sg_cpu);
-
-	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
+	if (!sugov_should_update_freq(sg_cpu->sg_policy, time, flags))
 		return false;
 
-	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
+	sugov_iowait_boost(sg_cpu, time, flags);
+
+	boost = sugov_iowait_apply(sg_cpu, time, max_cap, flags);
 	sugov_get_util(sg_cpu, boost);
 
 	return true;
@@ -412,7 +444,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 		sg_policy->cached_raw_freq = cached_freq;
 	}
 
-	if (!sugov_update_next_freq(sg_policy, time, next_f))
+	if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
 		return;
 
 	/*
@@ -457,10 +489,12 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
 				   sg_cpu->util, max_cap);
 
-	sg_cpu->sg_policy->last_freq_update_time = time;
+	if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
+		sg_cpu->sg_policy->last_freq_update_time = time;
 }
 
-static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
+static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time,
+					   unsigned int flags)
 {
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
@@ -473,7 +507,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long boost;
 
-		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
+		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap, flags);
 		sugov_get_util(j_sg_cpu, boost);
 
 		util = max(j_sg_cpu->util, util);
@@ -491,22 +525,20 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sugov_iowait_boost(sg_cpu, time, flags);
-	sg_cpu->last_update = time;
+	if (!sugov_should_update_freq(sg_policy, time, flags))
+		goto unlock;
 
-	ignore_dl_rate_limit(sg_cpu);
+	sugov_iowait_boost(sg_cpu, time, flags);
 
-	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, time);
+	next_f = sugov_next_freq_shared(sg_cpu, time, flags);
 
-		if (!sugov_update_next_freq(sg_policy, time, next_f))
-			goto unlock;
+	if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
+		goto unlock;
 
-		if (sg_policy->policy->fast_switch_enabled)
-			cpufreq_driver_fast_switch(sg_policy->policy, next_f);
-		else
-			sugov_deferred_update(sg_policy);
-	}
+	if (sg_policy->policy->fast_switch_enabled)
+		cpufreq_driver_fast_switch(sg_policy->policy, next_f);
+	else
+		sugov_deferred_update(sg_policy);
 unlock:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 62192ac79c30..f5718e3ab028 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -251,8 +251,12 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
+	/*
+	 * Context switch handles updates, but this is an exception to ensure
+	 * multiple DL tasks run at the correct frequencies. We don't need
+	 * a cpufreq update on dequeue, context switch will handle that.
+	 */
+	cpufreq_update_util(rq_of_dl_rq(dl_rq), SCHED_CPUFREQ_FORCE_UPDATE);
 }
 
 static inline
@@ -265,8 +269,6 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
 
 static inline
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1e78caa21436..075c65839d9c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3980,29 +3980,6 @@ static inline void update_cfs_group(struct sched_entity *se)
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
-{
-	struct rq *rq = rq_of(cfs_rq);
-
-	if (&rq->cfs == cfs_rq) {
-		/*
-		 * There are a few boundary cases this might miss but it should
-		 * get called often enough that that should (hopefully) not be
-		 * a real problem.
-		 *
-		 * It will not get called when we go idle, because the idle
-		 * thread is a different class (!fair), nor will the utilization
-		 * number include things like RT tasks.
-		 *
-		 * As is, the util number is not freq-invariant (we'd have to
-		 * implement arch_scale_freq_capacity() for that).
-		 *
-		 * See cpu_util_cfs().
-		 */
-		cpufreq_update_util(rq, flags);
-	}
-}
-
 #ifdef CONFIG_SMP
 static inline bool load_avg_is_decayed(struct sched_avg *sa)
 {
@@ -4680,8 +4657,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
-
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
@@ -4710,8 +4685,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
-
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
@@ -4758,12 +4731,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 */
 		detach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
-	} else if (decayed) {
-		cfs_rq_util_change(cfs_rq, 0);
-
-		if (flags & UPDATE_TG)
-			update_tg_load_avg(cfs_rq);
+	} else if (decayed && (flags & UPDATE_TG)) {
+		update_tg_load_avg(cfs_rq);
 	}
+
+	/*
+	 * If this is the root cfs_rq, set the decayed flag to let the world
+	 * know a cpufreq update is required.
+	 */
+	if (cfs_rq == &rq_of(cfs_rq)->cfs)
+		cfs_rq->decayed |= decayed;
 }
 
 /*
@@ -4839,6 +4816,7 @@ static inline unsigned long task_util_est(struct task_struct *p)
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
+	unsigned int task_util_est;
 	unsigned int enqueued;
 
 	if (!sched_feat(UTIL_EST))
@@ -4846,7 +4824,10 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 
 	/* Update root cfs_rq's estimated utilization */
 	enqueued  = cfs_rq->avg.util_est;
-	enqueued += _task_util_est(p);
+	task_util_est = _task_util_est(p);
+	if (task_util_est)
+		rq_of(cfs_rq)->cfs.decayed = true;
+	enqueued += task_util_est;
 	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
@@ -5137,7 +5118,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
-	cfs_rq_util_change(cfs_rq, 0);
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
@@ -6917,14 +6897,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		return;
 	}
 
-	/*
-	 * If in_iowait is set, the code below may not trigger any cpufreq
-	 * utilization updates, so do it here explicitly with the IOWAIT flag
-	 * passed.
-	 */
-	if (p->in_iowait)
-		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
-
 	if (task_new && se->sched_delayed)
 		h_nr_runnable = 0;
 
@@ -8721,7 +8693,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	int cse_is_idle, pse_is_idle;
 
 	if (unlikely(se == pse))
-		return;
+		goto nopreempt;
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
@@ -8730,7 +8702,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * next-buddy nomination below.
 	 */
 	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
-		return;
+		goto nopreempt;
 
 	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
 		set_next_buddy(pse);
@@ -8747,10 +8719,10 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * below.
 	 */
 	if (test_tsk_need_resched(rq->curr))
-		return;
+		goto nopreempt;
 
 	if (!sched_feat(WAKEUP_PREEMPTION))
-		return;
+		goto nopreempt;
 
 	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
@@ -8765,13 +8737,13 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (cse_is_idle && !pse_is_idle)
 		goto preempt;
 	if (cse_is_idle != pse_is_idle)
-		return;
+		goto nopreempt;
 
 	/*
 	 * BATCH and IDLE tasks do not preempt others.
 	 */
 	if (unlikely(!normal_policy(p->policy)))
-		return;
+		goto nopreempt;
 
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
@@ -8791,6 +8763,13 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (pick_eevdf(cfs_rq) == pse)
 		goto preempt;
 
+nopreempt:
+	if (rq->cfs.h_nr_runnable > 1) {
+#ifdef CONFIG_SMP
+		if (rq->cfs.decayed)
+#endif
+		cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);
+	}
 	return;
 
 preempt:
@@ -13076,6 +13055,15 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	update_misfit_status(curr, rq);
 	check_update_overutilized_status(task_rq(curr));
 
+#ifdef CONFIG_SMP
+	if (rq->cfs.decayed) {
+		rq->cfs.decayed = false;
+		cpufreq_update_util(rq, 0);
+	}
+#else
+	cpufreq_update_util(rq, 0);
+#endif
+
 	task_tick_core(rq, curr);
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bd66a46b06ac..fded4f2e481c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -554,11 +554,8 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 
 	rt_se = rt_rq->tg->rt_se[cpu];
 
-	if (!rt_se) {
+	if (!rt_se)
 		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
-		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
-	}
 	else if (on_rt_rq(rt_se))
 		dequeue_rt_entity(rt_se, 0);
 }
@@ -1056,9 +1053,6 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 		add_nr_running(rq, rt_rq->rt_nr_running);
 		rt_rq->rt_queued = 1;
 	}
-
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 #if defined CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38e0e323dda2..50bf720aeef1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -689,6 +689,11 @@ struct cfs_rq {
 		unsigned long	runnable_avg;
 	} removed;
 
+	/*
+	 * Store whether last update_load_avg() has decayed
+	 */
+	bool			decayed;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
@@ -3944,10 +3949,12 @@ extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_class_changing(struct rq *rq, struct task_struct *p,
 				 const struct sched_class *prev_class);
-extern void check_class_changed(struct rq *rq, struct task_struct *p,
+extern bool check_class_changed(struct rq *rq, struct task_struct *p,
 				const struct sched_class *prev_class,
 				int oldprio);
 
+extern void update_cpufreq_current(struct rq *rq);
+
 #ifdef CONFIG_SMP
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 149e2c8036d3..fb60fa5ae916 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -398,7 +398,7 @@ static bool uclamp_reset(const struct sched_attr *attr,
 	return false;
 }
 
-static void __setscheduler_uclamp(struct task_struct *p,
+static bool __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
@@ -424,7 +424,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
-		return;
+		return false;
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
 	    attr->sched_util_min != -1) {
@@ -437,6 +437,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
+
+	return true;
 }
 
 #else /* !CONFIG_UCLAMP_TASK: */
@@ -446,8 +448,11 @@ static inline int uclamp_validate(struct task_struct *p,
 {
 	return -EOPNOTSUPP;
 }
-static void __setscheduler_uclamp(struct task_struct *p,
-				  const struct sched_attr *attr) { }
+static bool __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	return false;
+}
 #endif
 
 /*
@@ -521,6 +526,7 @@ int __sched_setscheduler(struct task_struct *p,
 	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class, *next_class;
 	struct balance_callback *head;
+	bool update_cpufreq;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -714,7 +720,8 @@ int __sched_setscheduler(struct task_struct *p,
 		p->sched_class = next_class;
 		p->prio = newprio;
 	}
-	__setscheduler_uclamp(p, attr);
+
+	update_cpufreq = __setscheduler_uclamp(p, attr);
 	check_class_changing(rq, p, prev_class);
 
 	if (queued) {
@@ -730,7 +737,18 @@ int __sched_setscheduler(struct task_struct *p,
 	if (running)
 		set_next_task(rq, p);
 
-	check_class_changed(rq, p, prev_class, oldprio);
+	update_cpufreq |= check_class_changed(rq, p, prev_class, oldprio);
+
+	/*
+	 * Changing class or uclamp value implies requiring to send cpufreq
+	 * update.
+	 */
+	if (update_cpufreq) {
+		if (running)
+			update_cpufreq_current(rq);
+		else if (queued)
+			cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);
+	}
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
-- 
2.34.1


