Return-Path: <linux-pm+bounces-8420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA88D49DB
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 12:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421631C21493
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6617C7C9;
	Thu, 30 May 2024 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="q0kpfH+r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690F17C7B6
	for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066027; cv=none; b=JKgBkqeZP3QBqhsaqZpfmNPwsoCFGu9KcR+wD6W9/7VKH39cROKLccfEOCwzLsKsnggM11cyXN9SXYBGHO71rpLmb/Jqm9m3hDV5kVRFGa8lvVsLkbWU4RBAnGmRm6mqJPmq0UFXGHj+j90MG2L8nfAOM5jlHU+YjlrWVYQQSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066027; c=relaxed/simple;
	bh=fpPkHXQK5gLX1+LtTuc2BUpsfU+RicfeevlGZMQYjpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmlDBCAj8ew+MRfCbBmNNQdkNqaBwuUAfSYdLtI6VqxSw7hFcKdZF9P9SEm5xgPpjzXNPdCXzMcWxpCOdt6oYnYAaCifqgUlSxMSPneivRhC58W2WRLZxfc67AoBlRXdcHMnlqqOgqTnVyy5sdl4DQwHhMMgsrvDMVKW4xS3BdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=q0kpfH+r; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35dc36b107fso711384f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717066022; x=1717670822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd66fi9Gu6MAFHADfhw9lmH83OBsd6ddRSbMVOfkUug=;
        b=q0kpfH+rOjZpNQVX/beZYDNgqz6ovp8M9+bUaTNpvwYcQFSzdiOUlUrFmjIIpadL6O
         JcBMcDuFjzdPxbAWPpmxvivBhUjqtOr+80P8b3L/HVru8ahypznIQd5t6FqEQG6sAZnB
         iZa5qm7Qva28gUBT0thkpqOWnr9Vy6Rgu3s/VwQaYhvaepZq8K1Ia2wYJda2fnpLSDXn
         SEcrNh9YBx3TjmSOTf5hGeiA4z644jBUXJYcDE/BwgEhDH35we61BSmqOvjOCdk4HCcZ
         xeOGfuxA/1E7qgFYQ1WJr72mm/JaK7DgRx7IXUnBP3GSz8gUYYjvQrxTWwbgu99LSEd5
         k+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717066022; x=1717670822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gd66fi9Gu6MAFHADfhw9lmH83OBsd6ddRSbMVOfkUug=;
        b=poQcRxbL0/McszWhVrcX9ZA6xeTo2qe2YdE63AndJkcfO3CIuE2MvtYD86W87olq1H
         BUZ+3UbGNRrnb0gdd3mGoh948wpltsyoGZoTjOhwe8OCgxrC0VBtm+kiBexiKokIZo99
         WpEoA+cBMaRhXdwpLsx9OI5QpHZwMfN27OLhU9lfF2B9/N/Y9uH9+PY3uiRueLYR/3JZ
         pM5ZbxQi+Bba4ZHgGim0rbrhgli4rzOIsVLMzT4sVCS9PewxCAg+W6mqOUnC4isFp4TG
         Y8jz20bLkLd3g0VBQh2mh2OGy37/WL/xzfI/aY+PTkd+VD1c8OCDDqMHffCr0hWfSymH
         q5ug==
X-Forwarded-Encrypted: i=1; AJvYcCXE1ZGVvCD+rIr6kPXBUtPFE9HdsOSYSdC4ntyFq2syNXe/GnsI5uFZIwk6H8OCLB6mUCG72jyfR+L4fdV25qyX6g6U+J1Br64=
X-Gm-Message-State: AOJu0YwMRMV9OfKP9vp/OOLZ+T4fkinmlEZxJN4nB56fT4RGZlTmTiCb
	9m517nJLx70+cAmZqdwAZskwAe4XI7i9VlA3vmz2b42hRbMmKahUA6Useeu0GnY=
X-Google-Smtp-Source: AGHT+IE6bUyRcpZkvjHQHmD/wfbUljtSmdhXonjze0RK0s0BXt2zk4jHIKOyB5IW1uuuMUKvhPasbQ==
X-Received: by 2002:adf:f404:0:b0:354:f48e:dafe with SMTP id ffacd0b85a97d-35dc0087c50mr1282742f8f.8.1717066021721;
        Thu, 30 May 2024 03:47:01 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7d88esm17235188f8f.19.2024.05.30.03.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 03:47:01 -0700 (PDT)
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
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5] sched: Consolidate cpufreq updates
Date: Thu, 30 May 2024 11:46:53 +0100
Message-Id: <20240530104653.1234004-1-qyousef@layalina.io>
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
3. update_blocked_averages()
4. on syscall that changes policy or uclamp values

The update at context switch should help guarantee that DL and RT get
the right frequency straightaway when they're RUNNING. As mentioned
though the update will happen slightly after enqueue_task(); though in
an ideal world these tasks should be RUNNING ASAP and this additional
delay should be negligible. For fair tasks we need to make sure we send
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
on rate_limit_us and cfs_rq.decay preventing any updates to happen soon
after iowait boost.

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
switch. It doesn't make sense for the kworker that applies the frequency
update (which is a DL task) to trigger a frequency update itself.

The update at task_tick_fair will guarantee that the governor will
follow any updates to load for tasks/CPU or due to new enqueues/dequeues
to the rq. Since DL and RT always run at constant frequencies and have
no load tracking, this is only required for fair tasks.

The update at update_blocked_averages() will ensure we decay frequency
as the CPU becomes idle for long enough.

If the currently running task changes its policy or uclamp values, we
ensure we follow up with cpufreq update to ensure we follow up with any
potential new perf requirements based on the new change.

Results of

	taskset 1 perf stat --repeat 10 -e cycles,instructions,task-clock perf bench sched pipe

on AMD 3900X to verify any potential overhead because of the addition at
context switch against v6.8.7 stable kernel

v6.8.7: schedutil:
------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       850,276,689      cycles:u                  #    0.078 GHz                      ( +-  0.88% )
        82,724,245      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,881.41 msec task-clock:u              #    0.995 CPUs utilized            ( +-  0.12% )

           10.9377 +- 0.0135 seconds time elapsed  ( +-  0.12% )

v6.8.7: performance:
--------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       874,154,415      cycles:u                  #    0.080 GHz                      ( +-  0.78% )
        82,724,420      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,916.47 msec task-clock:u              #    0.999 CPUs utilized            ( +-  0.09% )

           10.9308 +- 0.0100 seconds time elapsed  ( +-  0.09% )

v6.8.7+patch: schedutil:
------------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       816,938,281      cycles:u                  #    0.075 GHz                      ( +-  0.84% )
        82,724,163      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,907.62 msec task-clock:u              #    1.004 CPUs utilized            ( +-  0.11% )

           10.8627 +- 0.0121 seconds time elapsed  ( +-  0.11% )

v6.8.7+patch: performance:
--------------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       814,038,416      cycles:u                  #    0.074 GHz                      ( +-  1.21% )
        82,724,356      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,886.69 msec task-clock:u              #    0.996 CPUs utilized            ( +-  0.17% )

           10.9298 +- 0.0181 seconds time elapsed  ( +-  0.17% )

Note worthy that we still have the following race condition on systems
that have shared policy:

* CPUs with shared policy can end up sending simultaneous cpufreq
  updates requests where the 2nd one will be unlucky and get blocked by
  the rate_limit_us (schedutil).

We can potentially address this limitation later, but it is out of the
scope of this patch.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

Changes since v4:

	* Fix updating freq when uclamp changes before the dequeue/enqueue
	  dance. (Hongyan)
	* Rebased on top of tip/sched/core 6.10-rc1 and resolve some conflicts
	  due to code shuffling to syscalls.c. Added new function
	  update_cpufreq_current() to be used outside core.c when
	  task_current() requires cpufreq update.

Changes since v3:

	* Omit cpufreq updates at attach/detach_entity_load_avg(). They share
	  the update path from enqueue/dequeue which is not intended to trigger
	  an update. And task_change_group_fair() is not expected to cause the
	  root cfs_rq util to change significantly to warrant an immediate
	  update for enqueued tasks. Better defer for next context switch to
	  sample the state of the cpu taking all changes into account before
	  the next task is due to run.
	  Dietmar also pointed out a bug where we could send more updates vs
	  without the patch in this path as I wasn't sending the update for
	  cfs_rq == &rq->cfs.

Changes since v2:

	* Clean up update_cpufreq_ctx_switch() to reduce branches (Peter)
	* Fix issue with cpufreq updates missed on switching from idle (Vincent)
	* perf bench sched pipe regressed after fixing the switch from idle,
	  detect when util_avg has changed when cfs_rq->decayed to fix it
	* Ensure to issue cpufreq updates when task_current() switches
	  policy/uclamp values

Changes since v1:

	* Use taskset and measure with performance governor as Ingo suggested
	* Remove the static key as I found out we always register a function
	  for cpu_dbs in cpufreq_governor.c; and as Christian pointed out it
	  trigger a lock debug warning.
	* Improve detection of sugov workers by using SCHED_FLAG_SUGOV
	* Guard against NSEC_PER_MSEC instead of TICK_USEC to avoid prematurely
	  reducing iowait boost as the latter was a NOP and like
	  sugov_iowait_reset() like Christian pointed out.

v1 discussion: https://lore.kernel.org/all/20240324020139.1032473-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20240505233103.168766-1-qyousef@layalina.io/
v3 discussion: https://lore.kernel.org/lkml/20240512190018.531820-1-qyousef@layalina.io/
v4 discussion: https://lore.kernel.org/lkml/20240516204802.846520-1-qyousef@layalina.io/

 include/linux/sched/cpufreq.h    |   3 +-
 kernel/sched/core.c              | 100 +++++++++++++++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c |  55 ++++++++++++-----
 kernel/sched/deadline.c          |   4 --
 kernel/sched/fair.c              |  64 +++++---------------
 kernel/sched/rt.c                |   8 +--
 kernel/sched/sched.h             |   9 ++-
 kernel/sched/syscalls.c          |  26 ++++++--
 8 files changed, 183 insertions(+), 86 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..2d0a45aba16f 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -8,7 +8,8 @@
  * Interface between cpufreq drivers and the scheduler:
  */
 
-#define SCHED_CPUFREQ_IOWAIT	(1U << 0)
+#define SCHED_CPUFREQ_IOWAIT		(1U << 0)
+#define SCHED_CPUFREQ_FORCE_UPDATE	(1U << 1) /* ignore transition_delay_us */
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5d861b59d737..04cfb403f792 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -153,6 +153,9 @@ const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
+static __always_inline void
+__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev);
+
 #ifdef CONFIG_SCHED_CORE
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
@@ -2042,17 +2045,24 @@ inline int task_curr(const struct task_struct *p)
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
@@ -4917,6 +4927,77 @@ static inline void __balance_callbacks(struct rq *rq)
 
 #endif
 
+static __always_inline void
+__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
+{
+#ifdef CONFIG_CPU_FREQ
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
+		if (unlikely(current->in_iowait)) {
+			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
+			return;
+		}
+
+#ifdef CONFIG_SMP
+		if (unlikely(rq->cfs.decayed)) {
+			rq->cfs.decayed = false;
+			cpufreq_update_util(rq, 0);
+			return;
+		}
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
+		if (current->dl.flags & SCHED_FLAG_SUGOV) {
+			/* Ignore sugov kthreads, they're responding to our requests */
+			return;
+		}
+		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
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
@@ -4934,7 +5015,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -4943,6 +5024,11 @@ static inline void finish_lock_switch(struct rq *rq)
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
 
@@ -5061,7 +5147,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
 	tick_nohz_task_switch();
-	finish_lock_switch(rq);
+	finish_lock_switch(rq, prev);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
 	/*
@@ -6920,6 +7006,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	int prio, oldprio, queued, running, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class;
+	bool class_changed;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -7021,7 +7108,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
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
index eece6244f9d2..e8b65b75e7f3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -59,7 +59,8 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
+				     unsigned int flags)
 {
 	s64 delta_ns;
 
@@ -87,13 +88,16 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return true;
 	}
 
+	if (unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
+		return true;
+
 	delta_ns = time - sg_policy->last_freq_update_time;
 
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
-				   unsigned int next_freq)
+				   unsigned int next_freq, unsigned int flags)
 {
 	if (sg_policy->need_freq_update)
 		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
@@ -101,7 +105,9 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 		return false;
 
 	sg_policy->next_freq = next_freq;
-	sg_policy->last_freq_update_time = time;
+
+	if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
+		sg_policy->last_freq_update_time = time;
 
 	return true;
 }
@@ -249,9 +255,10 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned int flags)
 {
 	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
+	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
 
 	/* Reset boost if the CPU appears to have been idle enough */
-	if (sg_cpu->iowait_boost &&
+	if (sg_cpu->iowait_boost && !forced_update &&
 	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
 		return;
 
@@ -294,17 +301,34 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * being more conservative on tasks which does sporadic IO operations.
  */
 static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
-			       unsigned long max_cap)
+			       unsigned long max_cap, unsigned int flags)
 {
+	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
+	s64 delta_ns = time - sg_cpu->last_update;
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
+		if (delta_ns <= NSEC_PER_MSEC)
+			goto apply_boost;
+
 		/*
 		 * No boost pending; reduce the boost value.
 		 */
@@ -315,6 +339,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		}
 	}
 
+apply_boost:
 	sg_cpu->iowait_boost_pending = false;
 
 	/*
@@ -358,10 +383,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 
 	ignore_dl_rate_limit(sg_cpu);
 
-	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
+	if (!sugov_should_update_freq(sg_cpu->sg_policy, time, flags))
 		return false;
 
-	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
+	boost = sugov_iowait_apply(sg_cpu, time, max_cap, flags);
 	sugov_get_util(sg_cpu, boost);
 
 	return true;
@@ -397,7 +422,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 		sg_policy->cached_raw_freq = cached_freq;
 	}
 
-	if (!sugov_update_next_freq(sg_policy, time, next_f))
+	if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
 		return;
 
 	/*
@@ -449,10 +474,12 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
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
@@ -465,7 +492,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long boost;
 
-		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
+		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap, flags);
 		sugov_get_util(j_sg_cpu, boost);
 
 		util = max(j_sg_cpu->util, util);
@@ -488,10 +515,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	ignore_dl_rate_limit(sg_cpu);
 
-	if (sugov_should_update_freq(sg_policy, time)) {
-		next_f = sugov_next_freq_shared(sg_cpu, time);
+	if (sugov_should_update_freq(sg_policy, time, flags)) {
+		next_f = sugov_next_freq_shared(sg_cpu, time, flags);
 
-		if (!sugov_update_next_freq(sg_policy, time, next_f))
+		if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
 			goto unlock;
 
 		if (sg_policy->policy->fast_switch_enabled)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b216e6deeac4..8e015e219da8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -251,8 +251,6 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
 
 static inline
@@ -265,8 +263,6 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
 
 static inline
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 63113dcb8d1a..143be0cae775 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3988,29 +3988,6 @@ static inline void update_cfs_group(struct sched_entity *se)
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
@@ -4688,8 +4665,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
-
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
@@ -4718,8 +4693,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
-
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
@@ -4735,7 +4708,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
-	int decayed;
+	unsigned long prev_util_avg = cfs_rq->avg.util_avg;
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
@@ -4744,8 +4717,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
 		__update_load_avg_se(now, cfs_rq, se);
 
-	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
-	decayed |= propagate_entity_load_avg(se);
+	cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
+	cfs_rq->decayed |= propagate_entity_load_avg(se);
 
 	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
 
@@ -4766,12 +4739,19 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 */
 		detach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
-	} else if (decayed) {
-		cfs_rq_util_change(cfs_rq, 0);
-
-		if (flags & UPDATE_TG)
-			update_tg_load_avg(cfs_rq);
+	} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
+		update_tg_load_avg(cfs_rq);
 	}
+
+	/*
+	 * This field is used to indicate whether a trigger of cpufreq update
+	 * is required. When the CPU is saturated, other load signals could
+	 * still be changing, but util_avg would have settled down, so ensure
+	 * that we don't trigger unnecessary updates as from fair policy point
+	 * of view, nothing has changed to cause a cpufreq update.
+	 */
+	if (cfs_rq->decayed && prev_util_avg == cfs_rq->avg.util_avg)
+		cfs_rq->decayed = false;
 }
 
 /*
@@ -5145,7 +5125,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
-	cfs_rq_util_change(cfs_rq, 0);
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
@@ -6760,14 +6739,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	/*
-	 * If in_iowait is set, the code below may not trigger any cpufreq
-	 * utilization updates, so do it here explicitly with the IOWAIT flag
-	 * passed.
-	 */
-	if (p->in_iowait)
-		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
-
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			break;
@@ -9357,10 +9328,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	unsigned long hw_pressure;
 	bool decayed;
 
-	/*
-	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
-	 * DL and IRQ signals have been updated before updating CFS.
-	 */
 	curr_class = rq->curr->sched_class;
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -12691,6 +12658,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	check_update_overutilized_status(task_rq(curr));
+	cpufreq_update_util(rq, 0);
 
 	task_tick_core(rq, curr);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 63e49c8ffc4d..92ed373e5b90 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -555,11 +555,8 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 
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
@@ -1064,9 +1061,6 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 		add_nr_running(rq, rt_rq->rt_nr_running);
 		rt_rq->rt_queued = 1;
 	}
-
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 #if defined CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cefa27f92bb6..49f0b4938c47 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -634,6 +634,11 @@ struct cfs_rq {
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
@@ -3564,10 +3569,12 @@ extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern void dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
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
index ae1b42775ef9..8b1194c39161 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -491,7 +491,7 @@ static bool uclamp_reset(const struct sched_attr *attr,
 	return false;
 }
 
-static void __setscheduler_uclamp(struct task_struct *p,
+static bool __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
@@ -517,7 +517,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
-		return;
+		return false;
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
 	    attr->sched_util_min != -1) {
@@ -530,6 +530,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
+
+	return true;
 }
 
 #else /* !CONFIG_UCLAMP_TASK: */
@@ -539,8 +541,11 @@ static inline int uclamp_validate(struct task_struct *p,
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
@@ -614,6 +619,7 @@ int __sched_setscheduler(struct task_struct *p,
 	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class;
 	struct balance_callback *head;
+	bool update_cpufreq;
 	struct rq_flags rf;
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
@@ -796,7 +802,8 @@ int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_params(p, attr);
 		__setscheduler_prio(p, newprio);
 	}
-	__setscheduler_uclamp(p, attr);
+
+	update_cpufreq = __setscheduler_uclamp(p, attr);
 
 	if (queued) {
 		/*
@@ -811,7 +818,14 @@ int __sched_setscheduler(struct task_struct *p,
 	if (running)
 		set_next_task(rq, p);
 
-	check_class_changed(rq, p, prev_class, oldprio);
+	update_cpufreq |= check_class_changed(rq, p, prev_class, oldprio);
+
+	/*
+	 * Changing class or uclamp value implies requiring to send cpufreq
+	 * update.
+	 */
+	if (update_cpufreq && running)
+		update_cpufreq_current(rq);
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
-- 
2.34.1


