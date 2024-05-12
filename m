Return-Path: <linux-pm+bounces-7745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD698C380F
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2024 21:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7281C211EC
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2024 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93E4EB31;
	Sun, 12 May 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="HlQi+qwM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBE146B80
	for <linux-pm@vger.kernel.org>; Sun, 12 May 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715540443; cv=none; b=HYTghccRpHttc5jUCEdlw+To4uQSDMNMRajsj6Z1GH/X1Y305OYMueZNBq5zepAIfJQeDZrVKs+LOOd+icNtx6F31B2+Olae/nzqEUSIMa5puInR6aFDwgrKOnQy5Jmb/kFI6/081cHeD83/TD6pB4ni04tIovWtt/kedP0tsxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715540443; c=relaxed/simple;
	bh=Q/HlHcyK/wFLR4urZw89ON5Z4GSlzK0hj3I0ntAkjfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PKcJMpNyXHUb/AyLalNOa4giMyfSWnDKB/1VoeBSJIy+TZzEqsKXTOSBu8MCkS8JFjII+NgeMgOxRXCnjKacl+3B9CWQZ1kvxF6P0dPzgRp3OJbBlSp+Cjn1a8RKp2bIs+sS8GpW0vcyeTRaQrivfK733+jUMoL0FMJguxplpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=HlQi+qwM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34dc9065606so1952357f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 12 May 2024 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715540438; x=1716145238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odKRLSqFepvYT5QKe8uFncz6SZtwqjUAU32q27BjV4U=;
        b=HlQi+qwMBeUSbNltpjkXFf4Q1Nt0zGuPy8GlZSsfO8O3Wl2rBgiflNnUUyx02ivSFq
         wovdmVCKKOl5UO21k/nxDTTJhJ7CesegoIGCN0qQqbyzXBxPg3FF2ps7zhlwuRCKLbDM
         xZFulI0C8mI2RSwvXLIzEVW7TstX13/C735TT0LMo82OveOUs6U7tAV7qFmNcIKmoTJy
         eYttuYr2xK3GxOp+uEhbXxaWYYGO/mLDsVLUERjrXI8dul3ij8lIuzmP+AglbsAEEk/2
         s2Ei+dP9lfkkT8UjsVmjB1M5cSnfyrxNtTxJZ0BkkxzKIb1JKZCeMre0WIla2/tIiXD7
         arUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715540438; x=1716145238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odKRLSqFepvYT5QKe8uFncz6SZtwqjUAU32q27BjV4U=;
        b=htspa6tAhk0bR/MZqOretHeC5snY3BJo1dNBBVgnh+enblVMLCYFDWj6Esx4C3gUl+
         xB/1Jame6LWCiPLrmly5TQv65duD8933QjT6RK6wfYFaWyH2bt8JsZJ5xe3Z5d/eiG7N
         X7PfGVNe3QVBzc+vIyo5Bpl1d/8OGsZRgwZbG0hdYu08e/s+oLqzzUkNdCXaiAI+t0M2
         SWuxOFchQTRpjWa6eJF6AnmoOcRCUwyGJywNhLMdBg4y0rdXXya1g5j+guc9pqhy//rd
         q/rv6aS0VntKujequLolyQxmhY50+scvDZ3C0pJjbSAjSxcphI0bu/5i3c2j4kcCP6tu
         oDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH3U/fcpUABGoUMXrm8ZUwEHuHllnYD+AMSJ7YFGA70ERtZT38mxhAHtYflFDk0cSH9pqgOLK9ATbdoQp6gJvVfazhUJBH5B0=
X-Gm-Message-State: AOJu0YwumxDls2fTTtc/4TYJvssRpRNUA4hmVUGYsyEztxyBPSCnyPWN
	l3v5rNg/UNH5dc7aX1R02B+gstAqudoGKtFxMhqQpuS0jFUnqaJp1HNkc1up/RE=
X-Google-Smtp-Source: AGHT+IHss/lMz42B0UCv9gIdOPpMto2JT7eMo6QpPDwOzIBtVyAXph2q9cbhc9K1z/PCNw8h9Ysc2g==
X-Received: by 2002:adf:cf0d:0:b0:346:47a6:e77e with SMTP id ffacd0b85a97d-350185d763fmr10542484f8f.27.1715540438097;
        Sun, 12 May 2024 12:00:38 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee94dasm133004545e9.32.2024.05.12.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 12:00:37 -0700 (PDT)
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
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v3] sched: Consolidate cpufreq updates
Date: Sun, 12 May 2024 20:00:18 +0100
Message-Id: <20240512190018.531820-1-qyousef@layalina.io>
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
3. {attach, detach}_entity_load_avg()
4. update_blocked_averages()
5. on syscall that changes policy or uclamp values

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

The update at attach/detach_entity_load_avg() will ensure we adapt to
big changes when tasks are added/removed from cgroups.

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

Changes since v2:

	* Clean up update_cpufreq_ctx_switch() to reduce branches (Peter)
	* Fix issue with cpufreq updates missed on switching from idle
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

 include/linux/sched/cpufreq.h    |  3 +-
 kernel/sched/core.c              | 95 ++++++++++++++++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c | 55 +++++++++++++-----
 kernel/sched/deadline.c          |  4 --
 kernel/sched/fair.c              | 64 ++++++---------------
 kernel/sched/rt.c                |  8 +--
 kernel/sched/sched.h             |  5 ++
 7 files changed, 156 insertions(+), 78 deletions(-)

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
index 1a914388144a..d0c97a66627a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -152,6 +152,9 @@ const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
+static __always_inline void
+update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev);
+
 #ifdef CONFIG_SCHED_CORE
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
@@ -1958,7 +1961,7 @@ static bool uclamp_reset(const struct sched_attr *attr,
 	return false;
 }
 
-static void __setscheduler_uclamp(struct task_struct *p,
+static void __setscheduler_uclamp(struct rq *rq, struct task_struct *p,
 				  const struct sched_attr *attr)
 {
 	enum uclamp_id clamp_id;
@@ -1980,7 +1983,6 @@ static void __setscheduler_uclamp(struct task_struct *p,
 			value = uclamp_none(clamp_id);
 
 		uclamp_se_set(uc_se, value, false);
-
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
@@ -1997,6 +1999,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
+
+	/*
+	 * Updating uclamp values has impact on freq, ensure it is taken into
+	 * account.
+	 */
+	if (task_current(rq, p))
+		update_cpufreq_ctx_switch(rq, NULL);
 }
 
 static void uclamp_fork(struct task_struct *p)
@@ -2071,7 +2080,7 @@ static inline int uclamp_validate(struct task_struct *p,
 {
 	return -EOPNOTSUPP;
 }
-static void __setscheduler_uclamp(struct task_struct *p,
+static void __setscheduler_uclamp(struct rq *rq, struct task_struct *p,
 				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
@@ -2230,6 +2239,13 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 			prev_class->switched_from(rq, p);
 
 		p->sched_class->switched_to(rq, p);
+
+		/*
+		 * Changing policies could imply requiring to send cpufreq
+		 * update.
+		 */
+		if (task_current(rq, p))
+			update_cpufreq_ctx_switch(rq, NULL);
 	} else if (oldprio != p->prio || dl_task(p))
 		p->sched_class->prio_changed(rq, p, oldprio);
 }
@@ -5134,6 +5150,68 @@ static inline void balance_callbacks(struct rq *rq, struct balance_callback *hea
 
 #endif
 
+static __always_inline void
+update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
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
 static inline void
 prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
@@ -5151,7 +5229,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -5160,6 +5238,11 @@ static inline void finish_lock_switch(struct rq *rq)
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
 	__balance_callbacks(rq);
+	/*
+	 * Request freq update after __balance_callbacks to take into account
+	 * any changes to rq.
+	 */
+	update_cpufreq_ctx_switch(rq, prev);
 	raw_spin_rq_unlock_irq(rq);
 }
 
@@ -5278,7 +5361,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
 	tick_nohz_task_switch();
-	finish_lock_switch(rq);
+	finish_lock_switch(rq, prev);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
 	/*
@@ -7891,7 +7974,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_params(p, attr);
 		__setscheduler_prio(p, newprio);
 	}
-	__setscheduler_uclamp(p, attr);
+	__setscheduler_uclamp(rq, p, attr);
 
 	if (queued) {
 		/*
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
index a04a436af8cc..02c9c2488091 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -252,8 +252,6 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	dl_rq->running_bw += dl_bw;
 	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
 
 static inline
@@ -266,8 +264,6 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
-	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
 
 static inline
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9eb63573110c..43f6244ab0f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3982,29 +3982,6 @@ static inline void update_cfs_group(struct sched_entity *se)
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
@@ -4682,7 +4659,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
+	cpufreq_update_util(rq_of(cfs_rq), 0);
 
 	trace_pelt_cfs_tp(cfs_rq);
 }
@@ -4712,7 +4689,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
+	cpufreq_update_util(rq_of(cfs_rq), 0);
 
 	trace_pelt_cfs_tp(cfs_rq);
 }
@@ -4729,7 +4706,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
-	int decayed;
+	unsigned long prev_util_avg = cfs_rq->avg.util_avg;
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
@@ -4738,8 +4715,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
 		__update_load_avg_se(now, cfs_rq, se);
 
-	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
-	decayed |= propagate_entity_load_avg(se);
+	cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
+	cfs_rq->decayed |= propagate_entity_load_avg(se);
 
 	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
 
@@ -4760,12 +4737,19 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -5139,7 +5123,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
-	cfs_rq_util_change(cfs_rq, 0);
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
@@ -6754,14 +6737,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -9351,10 +9326,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	unsigned long hw_pressure;
 	bool decayed;
 
-	/*
-	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
-	 * DL and IRQ signals have been updated before updating CFS.
-	 */
 	curr_class = rq->curr->sched_class;
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -12685,6 +12656,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	check_update_overutilized_status(task_rq(curr));
+	cpufreq_update_util(rq, 0);
 
 	task_tick_core(rq, curr);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3261b067b67e..fe6d8b0ffa95 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -556,11 +556,8 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 
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
@@ -1065,9 +1062,6 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 		add_nr_running(rq, rt_rq->rt_nr_running);
 		rt_rq->rt_queued = 1;
 	}
-
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 #if defined CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cb3792c04eea..86cec2145221 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -632,6 +632,11 @@ struct cfs_rq {
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
-- 
2.34.1


