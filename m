Return-Path: <linux-pm+bounces-9633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF9490F76D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3CA1F23A23
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 20:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558C159204;
	Wed, 19 Jun 2024 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="B7bVuqog"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7274068
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828059; cv=none; b=ZDSVxxSOPehXmlCDaIisD1atHpd1wBZPiRy7pPgL8GyZHi/dE9sC5lSMiPaDY1DxjK8p/G9FsdEiPRYX5BEMfjQ+FuhdwMPPTXNYNXbsyzRtWGVmJmc8Uanr4gOUsiuZ1g7WEX7pDq6M18qy0k3Y1rlL1OzKTvf21Y7GUPZ91bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828059; c=relaxed/simple;
	bh=AIfv95sj1Js/hLfn+ylEMc80Gwsb3Dp7cGfpiYUoglw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSU4EjtLKsicGAdJVz9I4FKFzn8IBfDWHQrKppTLXfSIevDJ1FPx7cmZuuH0MCdT4YqRTILDbMPtKNSPDxc4QyVxX0AC8X0b5DZ4Px3Hi65hJrtnkXBEVB387UkAXVF11hOAYRAOpGDuDvKPZOHwvY0QtVli+mdvRdjEnL56/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=B7bVuqog; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42172ed3487so1592515e9.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718828053; x=1719432853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOxL5pQLlkUl/uDE8d6cm6J5apnf8wsa0xS1dcBi1Co=;
        b=B7bVuqoguQC1/C707wm+4piP7sZPpbtwTyLjMsPhZcyTFBT1OC8fEoAxPjkCikAQex
         e7T2WlfvhQIF2ssn5XPMpOCNTht9X99txTo6rbYQjsWUTUYyki/PVXuYwO4uk4MmX/QE
         +mJ6bbt9AQ0QUav6ZT+SD+xaVZtpf9zrgUAjyiwumwsT2cfEtmyVp90w3SljW4Qw8VJi
         c+GdIXRZZPojXHPibRjxE9amDO8VJoCdv8mCL8U+dwY6qHDq1bAjk4/nIs5d6mMGW2Eq
         mxW2bf5tS2U92j6pvbKXBGGvel7Dpqw89trYFKwbmCW6XrmRkj1h4HQeSKuyF/59QKYS
         pTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718828053; x=1719432853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOxL5pQLlkUl/uDE8d6cm6J5apnf8wsa0xS1dcBi1Co=;
        b=j5XFgQjXjMRjApymf16LwHYsXdoc3dQJrfMSG2aRkdoTvSuNj1T+6jMGNc8jHiCK8m
         K/nOFy/ls7Oi/wkdLgouu3ULn0SvTvy+NCCKzjWaYkFwZa5tCPIoT6tqxO9Dc+LhmGOG
         BM7XvyLBUAEgd8+ErTjqJSAnlfzhKmVY9SJqO3gFIVJ2zaCyEXXGcQG2q4LtgIVTa68I
         3zfkDbBlLfFpEndlNCHwhiwppBXweuy30MxQinVlXFqOooFZ202z/0CsDvVu1T+qg+U8
         mjAh/S61IU9tuXa3oBjh1xeA+yZoI09dEtgd1MAk6cwnxxrpCOcYgE5ghpCoMW0uBB3G
         sy+g==
X-Forwarded-Encrypted: i=1; AJvYcCX6jJnWQ0IUNWwQ873mnmxqOx9/1juP9MaTLdt5oVlFOmKmyAzq/K4IWWADhscz27WNJOZKQpEcVVZlZD8pShJ7/nZBz5nr+Jc=
X-Gm-Message-State: AOJu0Yz1l/fHvhIjcZYHqkENAS+c8ZqfO3bCsVnwA/Cx/7RZ0sqlXx6k
	u/GMTIpGemK0FJH3PgdNMzkb8qVFMDpLIDABOVhkEo4hqTTBZGCvWb3Dn6kFQcQ=
X-Google-Smtp-Source: AGHT+IGEaB4CfLZsElE/Lsz18hlzJs6YE22G1vB1ZbzY6bLjcKgPbd3MEsgKIOBS23cKbOVvmLCB+g==
X-Received: by 2002:a05:600c:1608:b0:421:8e64:5f23 with SMTP id 5b1f17b1804b1-4247507a472mr22991935e9.5.1718828052847;
        Wed, 19 Jun 2024 13:14:12 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be818sm1303095e9.15.2024.06.19.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:14:12 -0700 (PDT)
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
Subject: [PATCH v6] sched: Consolidate cpufreq updates
Date: Wed, 19 Jun 2024 21:14:09 +0100
Message-Id: <20240619201409.2071728-1-qyousef@layalina.io>
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
5. on check_preempt_wakeup_fair() if wakeup preemption failed

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

To handle systems with long TICK where tasks could end up enqueued but
no preemption happens until TICK, we add an update in
check_preempt_wakeup_fair() if wake up preemption fails. This will send
special SCHED_CPUFREQ_TASK_ENQUEUED cpufreq update to tell the governor
that the state of the CPU has changed and it can consider an update if
it deems worthwhile. In schedutil this will do an update if no update
was done since sysctl_sched_base_slice which is our ideal slice length
for context switch.

Since we now DL tasks always ignore rate limit, remove
ignore_dl_rate_limit() function as it's no longer necessary.

Also move updating sg_cpu->last_update inside sugov_iowait_boost() where
this variable is associated.

Results of

	taskset 1 perf stat --repeat 10 -e cycles,instructions,task-clock perf bench sched pipe

on AMD 3900X to verify any potential overhead because of the addition at
context switch against v6.8.7 stable kernel

v6.8.7: schedutil:
------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       814,886,355      cycles:u                  #    0.073 GHz                      ( +-  1.79% )
        82,724,139      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         11,112.19 msec task-clock:u              #    0.996 CPUs utilized            ( +-  0.18% )

           11.1575 +- 0.0207 seconds time elapsed  ( +-  0.19% )

v6.8.7: performance:
--------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       731,701,038      cycles:u                  #    0.067 GHz                      ( +-  2.27% )
        82,724,255      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         10,830.95 msec task-clock:u              #    0.992 CPUs utilized            ( +-  0.14% )

           10.9172 +- 0.0150 seconds time elapsed  ( +-  0.14% )

v6.8.7+patch: schedutil:
------------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       814,294,812      cycles:u                  #    0.073 GHz                      ( +-  1.45% )
        82,724,229      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         11,109.70 msec task-clock:u              #    1.000 CPUs utilized            ( +-  0.11% )

           11.1131 +- 0.0125 seconds time elapsed  ( +-  0.11% )

v6.8.7+patch: performance:
--------------------------

 Performance counter stats for 'perf bench sched pipe' (10 runs):

       849,621,311      cycles:u                  #    0.077 GHz                      ( +-  0.50% )
        82,724,306      instructions:u            #    0.10  insn per cycle           ( +-  0.00% )
         11,031.10 msec task-clock:u              #    0.996 CPUs utilized            ( +-  0.14% )

           11.0716 +- 0.0149 seconds time elapsed  ( +-  0.13% )

With performance governor we seem to be doing slightly worse. Comparing
perf diff of

	taskset 1 perf record perf bench sched pipe

    28.95%     -3.66%  [kernel.kallsyms]     [k] delay_halt_mwaitx
     1.49%     +1.08%  [kernel.kallsyms]     [k] update_load_avg
     1.14%     +0.86%  [kernel.kallsyms]     [k] native_sched_clock
     0.56%     +0.56%  [kernel.kallsyms]     [k] sched_clock_cpu
     7.34%     -0.45%  [kernel.kallsyms]     [k] native_write_msr
     8.54%     -0.42%  [kernel.kallsyms]     [k] native_read_msr
     1.07%     +0.34%  [kernel.kallsyms]     [k] pick_next_task_fair
     2.46%     -0.30%  [kernel.kallsyms]     [k] x86_pmu_disable_all
     1.73%     -0.28%  [kernel.kallsyms]     [k] amd_pmu_check_overflow
     0.36%     +0.27%  [kernel.kallsyms]     [k] sched_clock
     1.05%     -0.25%  [kernel.kallsyms]     [k] try_to_wake_up
     0.70%     -0.24%  [kernel.kallsyms]     [k] enqueue_task_fair
     0.88%     +0.20%  [kernel.kallsyms]     [k] pipe_read
     0.54%     +0.19%  [kernel.kallsyms]     [k] dequeue_entity
     0.37%     +0.17%  [kernel.kallsyms]     [k] aa_file_perm
     0.66%     +0.16%  [kernel.kallsyms]     [k] vfs_write
     0.11%     +0.15%  [kernel.kallsyms]     [k] __x64_sys_write
     0.35%     +0.15%  libc.so.6             [.] __GI___libc_write
     1.32%     +0.15%  [kernel.kallsyms]     [k] update_curr
     1.22%     +0.14%  [kernel.kallsyms]     [k] psi_task_switch
     0.58%     -0.14%  [kernel.kallsyms]     [k] enqueue_entity
     0.83%     +0.14%  perf                  [.] worker_thread
     0.63%     +0.13%  [kernel.kallsyms]     [k] dequeue_task_fair
     1.42%     -0.13%  [kernel.kallsyms]     [k] delay_halt
     0.24%     +0.13%  [kernel.kallsyms]     [k] __wake_up_common

It seems update_load_avg() is slightly worse. Earlier versions of the
patch didn't produce such a difference. I am not sure if this is
a problem or just attributed to minor binary difference and caching
effect.

Note worthy that we still have the following race condition on systems
that have shared policy:

* CPUs with shared policy can end up sending simultaneous cpufreq
  updates requests where the 2nd one will be unlucky and get blocked by
  the rate_limit_us (schedutil).

We can potentially address this limitation later, but it is out of the
scope of this patch.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

Changes since v5:

	* Fix a bug where switching between RT and sugov tasks triggered an
	  endless cycle of cpufreq updates.
	* Only do cpufreq updates at tick for fair after verifying
	  rq->cfs.decayed
	* Remove optimization in update_load_avg() to avoid sending an update
	  if util hasn't changed that caused a bug when switching from Idle
	* Handle systems with long ticks by adding extra update on
	  check_preempt_wakeup_fair(). The idea is to rely on context switch
	  but still consider an update if wakeup preemption failed and no
	  update was sent since sysctl_sched_base_slice
	* Remove ignore_dl_rate_limit() as this function is now redundant
	* move sg_cpu->last_update = time inside sugov_iowait_boost()
	* Update commit message with new details and with perf diff output

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
v5 discussion: https://lore.kernel.org/lkml/20240530104653.1234004-1-qyousef@layalina.io/

 include/linux/sched/cpufreq.h    |   4 +-
 kernel/sched/core.c              | 107 +++++++++++++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c | 111 ++++++++++++++++++++-----------
 kernel/sched/deadline.c          |   4 --
 kernel/sched/fair.c              |  79 ++++++++--------------
 kernel/sched/rt.c                |   8 +--
 kernel/sched/sched.h             |   9 ++-
 kernel/sched/syscalls.c          |  26 ++++++--
 8 files changed, 232 insertions(+), 116 deletions(-)

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
index 0935f9d4bb7b..732acf9cc0c5 100644
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
@@ -4917,6 +4927,84 @@ static inline void __balance_callbacks(struct rq *rq)
 
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
@@ -4934,7 +5022,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static inline void finish_lock_switch(struct rq *rq, struct task_struct *prev)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -4943,6 +5031,11 @@ static inline void finish_lock_switch(struct rq *rq)
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
 
@@ -5061,7 +5154,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
 	tick_nohz_task_switch();
-	finish_lock_switch(rq);
+	finish_lock_switch(rq, prev);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
 	/*
@@ -6920,6 +7013,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	int prio, oldprio, queued, running, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class;
+	bool class_changed;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -7021,7 +7115,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
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
index eece6244f9d2..4cdaca0a984e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -59,10 +59,32 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
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
+	 * We want to ensure there's at least an update every
+	 * sysctl_sched_base_slice.
+	 */
+	if (likely(flags & SCHED_CPUFREQ_TASK_ENQUEUED)) {
+		if (delta_ns < sysctl_sched_base_slice)
+			return false;
+	}
+
 	/*
 	 * Since cpufreq_update_util() is called with rq->lock held for
 	 * the @target_cpu, our per-CPU data is fully serialized.
@@ -87,13 +109,14 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
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
 		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
@@ -101,7 +124,9 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 		return false;
 
 	sg_policy->next_freq = next_freq;
-	sg_policy->last_freq_update_time = time;
+
+	if (!unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
+		sg_policy->last_freq_update_time = time;
 
 	return true;
 }
@@ -249,9 +274,12 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned int flags)
 {
 	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
+	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
+
+	sg_cpu->last_update = time;
 
 	/* Reset boost if the CPU appears to have been idle enough */
-	if (sg_cpu->iowait_boost &&
+	if (sg_cpu->iowait_boost && !forced_update &&
 	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
 		return;
 
@@ -294,17 +322,34 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
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
@@ -315,6 +360,7 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		}
 	}
 
+apply_boost:
 	sg_cpu->iowait_boost_pending = false;
 
 	/*
@@ -337,31 +383,18 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
 static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
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
@@ -397,7 +430,7 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 		sg_policy->cached_raw_freq = cached_freq;
 	}
 
-	if (!sugov_update_next_freq(sg_policy, time, next_f))
+	if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
 		return;
 
 	/*
@@ -449,10 +482,12 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
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
@@ -465,7 +500,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long boost;
 
-		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
+		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap, flags);
 		sugov_get_util(j_sg_cpu, boost);
 
 		util = max(j_sg_cpu->util, util);
@@ -483,22 +518,20 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
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
index 41b58387023d..bb67888486c3 100644
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
 
@@ -4735,7 +4708,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 now = cfs_rq_clock_pelt(cfs_rq);
-	int decayed;
 
 	/*
 	 * Track task load average for carrying it to new CPU after migrated, and
@@ -4744,8 +4716,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
 		__update_load_avg_se(now, cfs_rq, se);
 
-	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
-	decayed |= propagate_entity_load_avg(se);
+	cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
+	cfs_rq->decayed |= propagate_entity_load_avg(se);
 
 	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
 
@@ -4766,11 +4738,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
 }
 
@@ -5145,7 +5114,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
-	cfs_rq_util_change(cfs_rq, 0);
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
@@ -6760,14 +6728,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
@@ -8354,7 +8314,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	int cse_is_idle, pse_is_idle;
 
 	if (unlikely(se == pse))
-		return;
+		goto nopreempt;
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
@@ -8363,7 +8323,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * next-buddy nomination below.
 	 */
 	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
-		return;
+		goto nopreempt;
 
 	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
 		set_next_buddy(pse);
@@ -8380,7 +8340,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * below.
 	 */
 	if (test_tsk_need_resched(curr))
-		return;
+		goto nopreempt;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
 	if (unlikely(task_has_idle_policy(curr)) &&
@@ -8392,7 +8352,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * is driven by the tick):
 	 */
 	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
-		return;
+		goto nopreempt;
 
 	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
@@ -8407,7 +8367,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (cse_is_idle && !pse_is_idle)
 		goto preempt;
 	if (cse_is_idle != pse_is_idle)
-		return;
+		goto nopreempt;
 
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
@@ -8418,6 +8378,14 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (pick_eevdf(cfs_rq) == pse)
 		goto preempt;
 
+nopreempt:
+#ifdef CONFIG_SMP
+	if (rq->cfs.decayed && rq->cfs.h_nr_running > 1)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);
+#else
+	if (rq->cfs.h_nr_running > 1)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);
+#endif
 	return;
 
 preempt:
@@ -9357,10 +9325,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	unsigned long hw_pressure;
 	bool decayed;
 
-	/*
-	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
-	 * DL and IRQ signals have been updated before updating CFS.
-	 */
 	curr_class = rq->curr->sched_class;
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
@@ -12699,6 +12663,15 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
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
index 62fd8bc6fd08..87325eff1884 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -639,6 +639,11 @@ struct cfs_rq {
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
@@ -3608,10 +3613,12 @@ extern void set_load_weight(struct task_struct *p, bool update_load);
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


