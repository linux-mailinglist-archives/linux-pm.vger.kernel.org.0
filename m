Return-Path: <linux-pm+bounces-9269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29290A0F3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 02:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C091C20B02
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CA1FDA;
	Mon, 17 Jun 2024 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Op1iDr1t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320151FBB
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718585207; cv=none; b=qJG249Wnq8KjZSGBR1+e48GFsYNiYE8f5rn0S9E3v4IbU3jRN2mj8x179u5I6oYSJg4JVECBxDGXz9opzs5u7kAx08v6PZ427kHTKxl5haUCeBKZlxB3YK5kVMOgSTGEGSwaBi837IAzjBGa4lvhuTANLlskVfQwLBm22tCtji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718585207; c=relaxed/simple;
	bh=7QN60RNKsIIhY/B5ErYFRsLjYd4lNNAUB6t/uJbw5T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owLyLsok5nxDzi2bR+qRNfhb+AbgLomZRom0yZHu9ratUgtdf097hHD0uFnqPkkmZJfEHZpgfVRQF24UG3lUea0Z6mdbp6NzPzT5IPUNVPso+wv7qbyu9qZCuNf5EsMtrmOcBQyfBb52Tvbm9f4RpnsQQnz0bXZeUtEm0FpB0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Op1iDr1t; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso32854975e9.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 17:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718585203; x=1719190003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0RNOGO5KT+trWShB2zRW0cWMjHECgoKnPIa9zOi8yA=;
        b=Op1iDr1tN+QGiQZiu2+qflDo1X6jjIR98Mwej/KsPTaoXRQ5KTd8jt74KXHgHR0ys0
         YEEkddSP6nusafuY9YkXpPElWg/Ty4aic1imww+fzUs0mmKWrMFz8CPymxmF73utfLM+
         kIx9+K/R049g6I4V5wc0tQ5191j0ubEKYMswIc0JwahLIWwFuWHYN8TPqYT3OrQJOwBU
         vhc2S3fLx4EywZqVl3Law5LQsj5+nwJD9IASIPRSJVCDeuXfrpffHZGuJOEmJEicoYN0
         Xc9Ww+ZtPmmlyNPUkdnJ6TLNDKRUkjukIOqdGofywOApXF66+O8zPrhCxZgtO6flDrGj
         guAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718585203; x=1719190003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0RNOGO5KT+trWShB2zRW0cWMjHECgoKnPIa9zOi8yA=;
        b=IqLDf67hAYByyT/newRG0KKsaYCeBxetwDx1IBHJKxvq95xb9VASNnsmOA0H/YmKLR
         n0hWG8TGKagE1C25/8hf2VA+ipaUZh7AmH99AZJxPlKbZ52yqvGEGmyFPlIkjMwW4y5h
         8JAk7TQWIh5vMiwQbndNDcxl5zJ2LMtqe1UESLvyTheGUBhSu/oSgmEq71u8uc5ChKv6
         ykguTTpTGfR3i2lMjk5rKSW1XDBcklufN4xe9Nvg0/Y+U+GzGG1Kw0PUNk+9TvzjOIyh
         tVfZ9OySQQQl21DdC0NfLXfPlbLdxi+XgtwkCvNn78iBHAFfaGrqYnWwyMwbAsY2o9Q6
         P4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz7iSbhl4iOtJ9ynxxVQkD72nGbH5RZ5/PdyvLbiwO+CzOLZ5yyMAVBZoBlJGmxmrRMgxw7GGc0B12oVSG06gMT94i/j9auo0=
X-Gm-Message-State: AOJu0Yy1EYMfg06I4HrNkU9UvWJdqCNuWWXTdY6eC3A2Uh1Mvan4GVAa
	FpRee2slcwo0csQQSIlOfgUIPk8vN99l4a5d+o1Wzv8163eHosRzgAa5HQGH/yM=
X-Google-Smtp-Source: AGHT+IEUB6m286fG/RcgXyOr765a76w6bxgaj5cXI0hEiOyrTrBA4ejXDOvno8cYoPhTjuO1BL3K8A==
X-Received: by 2002:a05:600c:4650:b0:422:7ad4:be7c with SMTP id 5b1f17b1804b1-4230484c58dmr77780255e9.34.1718585203291;
        Sun, 16 Jun 2024 17:46:43 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de62fsm181688125e9.38.2024.06.16.17.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 17:46:42 -0700 (PDT)
Date: Mon, 17 Jun 2024 01:46:41 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sched: Consolidate cpufreq updates
Message-ID: <20240617004641.bzvuxosttbofajad@airbuntu>
References: <20240530104653.1234004-1-qyousef@layalina.io>
 <20240601224017.qku2mhbaz4vsh3a3@airbuntu>
 <CAKfTPtCHfnDAD-p_ScqHh7cZ=7AXDTw3fE0+ynMHNvCjuG8ogw@mail.gmail.com>
 <20240609222029.yebhborjptp3gr6a@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240609222029.yebhborjptp3gr6a@airbuntu>

On 06/09/24 23:20, Qais Yousef wrote:
> On 06/05/24 14:22, Vincent Guittot wrote:
> > Hi Qais,
> > 
> > On Sun, 2 Jun 2024 at 00:40, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 05/30/24 11:46, Qais Yousef wrote:
> > >
> > > > +static __always_inline void
> > > > +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > > > +{
> > >
> > > I found a problem here. We should check if prev was sugov task. I hit a
> > > corner case where we were constantly switching between RT task and sugov.
> > >
> > >         if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> > >                 /* Sugov just did an update, don't be too aggressive */
> > >                 return;
> > >         }
> > >
> > 
> > I reran my test with this v5 and the fix above but the problem is
> > still there, it waits for the next tick to update the frequency
> > whereas the cpu was idle.
> 
> Hurmph. Sorry I forgot to rerun this test. I broke it again with this
> optimization :( Maybe I can replace this with explicit check with util_avg ==
> SCHED_CAPACITY_SCALE, though this is not generic enough..
> 
> 	diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> 	index 6d8d569cdb6a..d64d47b4471a 100644
> 	--- a/kernel/sched/fair.c
> 	+++ b/kernel/sched/fair.c
> 	@@ -4702,7 +4702,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> 	 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> 	 {
> 		u64 now = cfs_rq_clock_pelt(cfs_rq);
> 	-       unsigned long prev_util_avg = cfs_rq->avg.util_avg;
> 
> 		/*
> 		 * Track task load average for carrying it to new CPU after migrated, and
> 	@@ -4736,16 +4735,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> 		} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
> 			update_tg_load_avg(cfs_rq);
> 		}
> 	-
> 	-       /*
> 	-        * This field is used to indicate whether a trigger of cpufreq update
> 	-        * is required. When the CPU is saturated, other load signals could
> 	-        * still be changing, but util_avg would have settled down, so ensure
> 	-        * that we don't trigger unnecessary updates as from fair policy point
> 	-        * of view, nothing has changed to cause a cpufreq update.
> 	-        */
> 	-       if (cfs_rq->decayed && prev_util_avg == cfs_rq->avg.util_avg)
> 	-               cfs_rq->decayed = false;
> 	 }
> 
> 	 /*

Testing the overhead of context switch is hard.. Compilation differences can
produce strange results. I was seeing a bit of an overhead without the above
but after spending more time debugging the difference is not due to extra
overhead from context switch. It seems some parasitic differences introducing
weird caching effects. Results of perf diff

# Event 'cycles'
#
# Baseline  Delta Abs  Shared Object         Symbol
# ........  .........  ....................  ....................................
#
     1.84%     +0.76%  [kernel.kallsyms]     [k] update_load_avg
     6.12%     +0.76%  [kernel.kallsyms]     [k] native_write_msr
     1.32%     +0.70%  [kernel.kallsyms]     [k] native_sched_clock
     7.13%     +0.61%  [kernel.kallsyms]     [k] native_read_msr
    24.88%     +0.53%  [kernel.kallsyms]     [k] delay_halt_mwaitx
     0.98%     -0.33%  [kernel.kallsyms]     [k] psi_task_change
     1.83%     +0.33%  [kernel.kallsyms]     [k] x86_pmu_disable_all
     0.79%     -0.31%  [kernel.kallsyms]     [k] enqueue_entity
     0.77%     +0.30%  [kernel.kallsyms]     [k] sched_clock_cpu
     0.75%     -0.22%  [kernel.kallsyms]     [k] pick_eevdf
     2.83%     -0.21%  [kernel.kallsyms]     [k] srso_safe_ret
     0.75%     -0.20%  [kernel.kallsyms]     [k] enqueue_task_fair
     0.79%     -0.19%  [kernel.kallsyms]     [k] update_rq_clock
     0.47%     -0.19%  [kernel.kallsyms]     [k] enqueue_task
     1.44%     -0.16%  [kernel.kallsyms]     [k] pick_next_task_fair
     1.08%     -0.16%  [kernel.kallsyms]     [k] apparmor_file_permission
     1.74%     -0.16%  [kernel.kallsyms]     [k] update_curr
     0.87%     -0.16%  [kernel.kallsyms]     [k] vfs_write
     0.40%     +0.15%  [kernel.kallsyms]     [k] sched_clock
     0.52%     -0.15%  [kernel.kallsyms]     [k] update_cfs_group
     0.39%     -0.14%  [kernel.kallsyms]     [k] x64_sys_call
     0.76%     +0.14%  [kernel.kallsyms]     [k] dequeue_task_fair
     0.30%     -0.14%  [kernel.kallsyms]     [k] __enqueue_entity
     1.30%     +0.13%  [kernel.kallsyms]     [k] psi_task_switch
     0.65%     -0.12%  [kernel.kallsyms]     [k] entry_SYSCALL_64_after_hwframe
     0.51%     -0.12%  [kernel.kallsyms]     [k] check_preempt_wakeup_fair
     1.19%     +0.11%  [kernel.kallsyms]     [k] amd_pmu_test_overflow_topbit

> 
> > 
> > Also continuing here the discussion started on v2:
> > 
> > I agree that in the current implementation we are probably calling way
> > too much cpufreq_update, we can optimize some sequences and using the
> > context switch is a good way to get a better sampling but this is not
> > enough and we still need to call cpufreq_update in some other case
> > involving enqueue. The delay of waiting for the next tick is not
> 
> Do you have any suggestions? I'm not sure how to classify different type of
> enqueue events where some would need an update and others don't.
> 
> I think cases that involve wakeup preemption not causing a context switch AND
> maybe a large change in util_avg?
> 
> > acceptable nor sustainable especially with 250 and lower HZ but I'm
> 
> I think it is fine for 250. I have been testing with this and didn't see
> issues. But wider testing could yield different results.
> 
> > pretty sure it would be the same for some system using 1000HZ. IIUC
> > new HW is becoming much more efficient at updating the frequency so it
> > would not be a problem for this new system to update performance more
> > frequently especially when it ends up being as simple as writing a
> > value in a memory region without waiting for it to be applied (like
> > cpufreq fast_switch methods). All this to say that always/only waiting
> > for context switch or tick might be suitable for your case but it
> > doesn't look like the right solution for all devices and systems
> 
> I just don't want us to end up with probabilistic approach. I am fine with more
> updates, but we need to be more intentional/specific when it's truly needed.

This needs more testing still, but how about this approach? If a wakeup
preemption check failed, we send a 'special' request to cpufreq governor to let
it know there's a new task. schedutil will then do a special check to see if
there was no update since sysctl_sched_base_slice (our expected worst case
context switch point) and issue one if it was longer than that.

If this looks agreeable I'll go ahead and do more testing and send a new
version.


From 4c0fcd54a9430164d259877051f6675002f0f5f6 Mon Sep 17 00:00:00 2001
From: Qais Yousef <qyousef@layalina.io>
Date: Sun, 16 Jun 2024 01:30:41 +0100
Subject: [PATCH] fixup: handle long ticks

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/cpufreq.h    |  1 +
 kernel/sched/cpufreq_schedutil.c | 64 +++++++++++++++++---------------
 kernel/sched/fair.c              | 13 ++++---
 3 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index 2d0a45aba16f..5409a9f79cc0 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -10,6 +10,7 @@
 
 #define SCHED_CPUFREQ_IOWAIT		(1U << 0)
 #define SCHED_CPUFREQ_FORCE_UPDATE	(1U << 1) /* ignore transition_delay_us */
+#define SCHED_CPUFREQ_TASK_ENQUEUED	(1U << 2) /* new fair task was enqueued */
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e8b65b75e7f3..4cdaca0a984e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -64,6 +64,27 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
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
@@ -91,8 +112,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
 	if (unlikely(flags & SCHED_CPUFREQ_FORCE_UPDATE))
 		return true;
 
-	delta_ns = time - sg_policy->last_freq_update_time;
-
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
@@ -257,6 +276,8 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
 	bool forced_update = flags & SCHED_CPUFREQ_FORCE_UPDATE;
 
+	sg_cpu->last_update = time;
+
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sg_cpu->iowait_boost && !forced_update &&
 	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
@@ -362,30 +383,17 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
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
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time, flags))
 		return false;
 
+	sugov_iowait_boost(sg_cpu, time, flags);
+
 	boost = sugov_iowait_apply(sg_cpu, time, max_cap, flags);
 	sugov_get_util(sg_cpu, boost);
 
@@ -510,22 +518,20 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sugov_iowait_boost(sg_cpu, time, flags);
-	sg_cpu->last_update = time;
+	if (!sugov_should_update_freq(sg_policy, time, flags))
+		goto unlock;
 
-	ignore_dl_rate_limit(sg_cpu);
+	sugov_iowait_boost(sg_cpu, time, flags);
 
-	if (sugov_should_update_freq(sg_policy, time, flags)) {
-		next_f = sugov_next_freq_shared(sg_cpu, time, flags);
+	next_f = sugov_next_freq_shared(sg_cpu, time, flags);
 
-		if (!sugov_update_next_freq(sg_policy, time, next_f, flags))
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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8b87640f386b..3945aa938436 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8314,7 +8314,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	int cse_is_idle, pse_is_idle;
 
 	if (unlikely(se == pse))
-		return;
+		goto nopreempt;
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
@@ -8323,7 +8323,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * next-buddy nomination below.
 	 */
 	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
-		return;
+		goto nopreempt;
 
 	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
 		set_next_buddy(pse);
@@ -8340,7 +8340,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * below.
 	 */
 	if (test_tsk_need_resched(curr))
-		return;
+		goto nopreempt;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
 	if (unlikely(task_has_idle_policy(curr)) &&
@@ -8352,7 +8352,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * is driven by the tick):
 	 */
 	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
-		return;
+		goto nopreempt;
 
 	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
@@ -8367,7 +8367,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (cse_is_idle && !pse_is_idle)
 		goto preempt;
 	if (cse_is_idle != pse_is_idle)
-		return;
+		goto nopreempt;
 
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
@@ -8378,6 +8378,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (pick_eevdf(cfs_rq) == pse)
 		goto preempt;
 
+nopreempt:
+	if (rq->cfs.decayed && rq->cfs.h_nr_running > 1)
+		cpufreq_update_util(rq, SCHED_CPUFREQ_TASK_ENQUEUED);
 	return;
 
 preempt:
-- 
2.34.1


