Return-Path: <linux-pm+bounces-10697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F419288DB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 14:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BDCB2186F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64E14A61B;
	Fri,  5 Jul 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMjsnnSy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8A143C79
	for <linux-pm@vger.kernel.org>; Fri,  5 Jul 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183315; cv=none; b=foTgeWFReUobdDqx9MfW2la9j6ifFhtbKL0U4QyusPCp/XwLSgRbe+Etfsh85ZMfZtJnYZTdXKAi+cFCS7PqbWoyu68Bb9Roghtb509e+l+UEKzWZeDIkM0HB7ghTyETw2stVoQqr2OVSqDNuO2COLMZHxDpbMObepwxginDIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183315; c=relaxed/simple;
	bh=/H+4jkGrYyEgl6IeKRx9uVdcJAyU5cCfGpov4sECtq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMp8JmBvq+L3a/Hy8VfFOiiV2WKr5xSM6ximN0W/4rCZuqEk7QoaShHMQi5MXUuX1pNqSizTkESDW29KMp4Sy7IxxGYihaeSjpQ1Lm7lN9mwTswpSzu6aaoK51692+4TOUZu8v3iXulUT6SZ79FzZt14QD6CXlWC+vyO7C3+yDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMjsnnSy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c967e21888so1094678a91.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2024 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720183313; x=1720788113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=makRKvY1ZzmZLuFxR7OxiDcC7Ot8fAF1urKYVFggErg=;
        b=CMjsnnSyqtFR4DHH18TgdEIFDqloCd6CQlth326oXECRXWYb+ZEa7mgNTaxRkxZkGd
         FoC1/nW7CApsRa6dQXsPp8lE26j7pGncux9Ck6pd4a8Dyz7c+i7CMmU1jxwuywtdrSYJ
         Zq2DxDdxhYB+0jL7MZAQWp9l9HRCZN8G2717Xz6EeXOtwv/XuWt5GGIcDDm79p9vfViS
         ivmJlBr5M3E2pUkvRsdV0Gki2XCxvmC5mcASwoB3FVlQIr11bhsDVa2ggeBL1SubPDZq
         Y1z1s8jJXrJhJ8QLNFHYnz53miqNhPBj9dUPsS7U19d7Mpe1i6+xzV7hADpQS70wjcH9
         iEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720183313; x=1720788113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=makRKvY1ZzmZLuFxR7OxiDcC7Ot8fAF1urKYVFggErg=;
        b=SzGvGIt/u+I07rvVbj4iBOaWYUgLK1v7/TXAXglKWcPEcQH27JbzUbhT2GefRPa+9w
         0xJ+nB42v0Fr72bX3OoFGEiZ94TaFNPeWT2AxlPYxjWgs6QEpp8jCt5vXnqtNNNcIc9y
         bamMCQ6RYsXCHoxIOKg7qHGQXdjzUuxCPzYmxEroAbTKXek/aQDYppLvXnA4uOT63Tiq
         QaMw2RXSXWtumAwo6ZmIKUz/FbVHKvzJzhy79IDCPsDSJHJmmhmmEBOz3dJQCKYbpUhi
         AVaqs/TEu1HZH8Xjlu+IAsKIFk4qgFeA1tdO/L6iZQRYRPqQGUy0PTluCfFxdA4KqgHF
         jw2A==
X-Forwarded-Encrypted: i=1; AJvYcCUQlRRRTd7VZlPwL/pWOQ5FyK0Sjg+XLIDI3rW5qc13sekxwgulwyIOp0WoQGSPWfq88ikyjnOHex4cja50J/pimAUqIIlPU+k=
X-Gm-Message-State: AOJu0YzkNvW7xVJD5F5xOGqD52xNU+/kVcCxLZtkpbk+8U7DXj5XCsI0
	Sv6Y3HxAivl7Z9VUESUzUZlIsLkXSBfiZH2Pi+ude24+fuwGbLnIjqXt5ESYGGGmWP0ylqiKabc
	bivDfhV+2Fxm/uJyArSCw8rrLdc/9a/G0pxk3bw==
X-Google-Smtp-Source: AGHT+IHBBnBRenNmYsaiZhYTb7shVAI1VtgJP37gWYtfrnmNKAqv1YYfVLtF64vh6GmJh6eoVy+gsvonRPqBB33t2iY=
X-Received: by 2002:a17:90a:c38e:b0:2c9:63e9:8461 with SMTP id
 98e67ed59e1d1-2c99c502d58mr3520674a91.2.1720183312970; Fri, 05 Jul 2024
 05:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
In-Reply-To: <ZnM2ywDVRZbrN6OC@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 5 Jul 2024 14:41:41 +0200
Message-ID: <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 21:52, Tejun Heo <tj@kernel.org> wrote:
>
> sched_ext currently does not integrate with schedutil. When schedutil is the
> governor, frequencies are left unregulated and usually get stuck close to
> the highest performance level from running RT tasks.
>
> Add CPU performance monitoring and scaling support by integrating into
> schedutil. The following kfuncs are added:
>
> - scx_bpf_cpuperf_cap(): Query the relative performance capacity of
>   different CPUs in the system.
>
> - scx_bpf_cpuperf_cur(): Query the current performance level of a CPU
>   relative to its max performance.
>
> - scx_bpf_cpuperf_set(): Set the current target performance level of a CPU.
>
> This gives direct control over CPU performance setting to the BPF scheduler.
> The only changes on the schedutil side are accounting for the utilization
> factor from sched_ext and disabling frequency holding heuristics as it may
> not apply well to sched_ext schedulers which may have a lot weaker
> connection between tasks and their current / last CPU.
>
> With cpuperf support added, there is no reason to block uclamp. Enable while
> at it.
>
> A toy implementation of cpuperf is added to scx_qmap as a demonstration of
> the feature.
>
> v2: Ignore cpu_util_cfs_boost() when scx_switched_all() in sugov_get_util()
>     to avoid factoring in stale util metric. (Christian)
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c         |   12 ++
>  kernel/sched/ext.c                       |   83 +++++++++++++++++-
>  kernel/sched/ext.h                       |    9 +
>  kernel/sched/sched.h                     |    1
>  tools/sched_ext/include/scx/common.bpf.h |    3
>  tools/sched_ext/scx_qmap.bpf.c           |  142 ++++++++++++++++++++++++++++++-
>  tools/sched_ext/scx_qmap.c               |    8 +
>  7 files changed, 252 insertions(+), 6 deletions(-)
>
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -197,8 +197,10 @@ unsigned long sugov_effective_cpu_perf(i
>
>  static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>  {
> -       unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> +       unsigned long min, max, util = scx_cpuperf_target(sg_cpu->cpu);
>
> +       if (!scx_switched_all())
> +               util += cpu_util_cfs_boost(sg_cpu->cpu);

I don't see the need for this. If fair is not used, this returns zero

>         util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
>         util = max(util, boost);
>         sg_cpu->bw_min = min;
> @@ -330,6 +332,14 @@ static bool sugov_hold_freq(struct sugov
>         unsigned long idle_calls;
>         bool ret;
>
> +       /*
> +        * The heuristics in this function is for the fair class. For SCX, the
> +        * performance target comes directly from the BPF scheduler. Let's just
> +        * follow it.
> +        */
> +       if (scx_switched_all())
> +               return false;


> +
>         /* if capped by uclamp_max, always update to be in compliance */
>         if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
>                 return false;
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -16,6 +16,8 @@ enum scx_consts {
>         SCX_EXIT_BT_LEN                 = 64,
>         SCX_EXIT_MSG_LEN                = 1024,
>         SCX_EXIT_DUMP_DFL_LEN           = 32768,
> +
> +       SCX_CPUPERF_ONE                 = SCHED_CAPACITY_SCALE,
>  };
>
>  enum scx_exit_kind {
> @@ -3520,7 +3522,7 @@ DEFINE_SCHED_CLASS(ext) = {
>         .update_curr            = update_curr_scx,
>
>  #ifdef CONFIG_UCLAMP_TASK
> -       .uclamp_enabled         = 0,
> +       .uclamp_enabled         = 1,
>  #endif
>  };
>
> @@ -4393,7 +4395,7 @@ static int scx_ops_enable(struct sched_e
>         struct scx_task_iter sti;
>         struct task_struct *p;
>         unsigned long timeout;
> -       int i, ret;
> +       int i, cpu, ret;
>
>         mutex_lock(&scx_ops_enable_mutex);
>
> @@ -4442,6 +4444,9 @@ static int scx_ops_enable(struct sched_e
>
>         atomic_long_set(&scx_nr_rejected, 0);
>
> +       for_each_possible_cpu(cpu)
> +               cpu_rq(cpu)->scx.cpuperf_target = SCX_CPUPERF_ONE;
> +
>         /*
>          * Keep CPUs stable during enable so that the BPF scheduler can track
>          * online CPUs by watching ->on/offline_cpu() after ->init().
> @@ -5836,6 +5841,77 @@ __bpf_kfunc void scx_bpf_dump_bstr(char
>  }
>
>  /**
> + * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
> + * @cpu: CPU of interest
> + *
> + * Return the maximum relative capacity of @cpu in relation to the most
> + * performant CPU in the system. The return value is in the range [1,
> + * %SCX_CPUPERF_ONE]. See scx_bpf_cpuperf_cur().
> + */
> +__bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
> +{
> +       if (ops_cpu_valid(cpu, NULL))
> +               return arch_scale_cpu_capacity(cpu);
> +       else
> +               return SCX_CPUPERF_ONE;
> +}
> +
> +/**
> + * scx_bpf_cpuperf_cur - Query the current relative performance of a CPU
> + * @cpu: CPU of interest
> + *
> + * Return the current relative performance of @cpu in relation to its maximum.
> + * The return value is in the range [1, %SCX_CPUPERF_ONE].
> + *
> + * The current performance level of a CPU in relation to the maximum performance
> + * available in the system can be calculated as follows:
> + *
> + *   scx_bpf_cpuperf_cap() * scx_bpf_cpuperf_cur() / %SCX_CPUPERF_ONE
> + *
> + * The result is in the range [1, %SCX_CPUPERF_ONE].
> + */
> +__bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
> +{
> +       if (ops_cpu_valid(cpu, NULL))
> +               return arch_scale_freq_capacity(cpu);
> +       else
> +               return SCX_CPUPERF_ONE;
> +}
> +
> +/**
> + * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
> + * @cpu: CPU of interest
> + * @perf: target performance level [0, %SCX_CPUPERF_ONE]
> + * @flags: %SCX_CPUPERF_* flags
> + *
> + * Set the target performance level of @cpu to @perf. @perf is in linear
> + * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
> + * schedutil cpufreq governor chooses the target frequency.
> + *
> + * The actual performance level chosen, CPU grouping, and the overhead and
> + * latency of the operations are dependent on the hardware and cpufreq driver in
> + * use. Consult hardware and cpufreq documentation for more information. The
> + * current performance level can be monitored using scx_bpf_cpuperf_cur().
> + */
> +__bpf_kfunc void scx_bpf_cpuperf_set(u32 cpu, u32 perf)
> +{
> +       if (unlikely(perf > SCX_CPUPERF_ONE)) {
> +               scx_ops_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
> +               return;
> +       }
> +
> +       if (ops_cpu_valid(cpu, NULL)) {
> +               struct rq *rq = cpu_rq(cpu);
> +
> +               rq->scx.cpuperf_target = perf;
> +
> +               rcu_read_lock_sched_notrace();
> +               cpufreq_update_util(cpu_rq(cpu), 0);
> +               rcu_read_unlock_sched_notrace();
> +       }
> +}
> +
> +/**
>   * scx_bpf_nr_cpu_ids - Return the number of possible CPU IDs
>   *
>   * All valid CPU IDs in the system are smaller than the returned value.
> @@ -6045,6 +6121,9 @@ BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
>  BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
> +BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
>  BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
>  BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -48,6 +48,14 @@ int scx_check_setscheduler(struct task_s
>  bool task_should_scx(struct task_struct *p);
>  void init_sched_ext_class(void);
>
> +static inline u32 scx_cpuperf_target(s32 cpu)
> +{
> +       if (scx_enabled())
> +               return cpu_rq(cpu)->scx.cpuperf_target;
> +       else
> +               return 0;
> +}
> +
>  static inline const struct sched_class *next_active_class(const struct sched_class *class)
>  {
>         class++;
> @@ -89,6 +97,7 @@ static inline void scx_pre_fork(struct t
>  static inline int scx_fork(struct task_struct *p) { return 0; }
>  static inline void scx_post_fork(struct task_struct *p) {}
>  static inline void scx_cancel_fork(struct task_struct *p) {}
> +static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
>  static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
>  static inline void scx_rq_activate(struct rq *rq) {}
>  static inline void scx_rq_deactivate(struct rq *rq) {}
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -743,6 +743,7 @@ struct scx_rq {
>         u64                     extra_enq_flags;        /* see move_task_to_local_dsq() */
>         u32                     nr_running;
>         u32                     flags;
> +       u32                     cpuperf_target;         /* [0, SCHED_CAPACITY_SCALE] */
>         bool                    cpu_released;
>         cpumask_var_t           cpus_to_kick;
>         cpumask_var_t           cpus_to_kick_if_idle;
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -42,6 +42,9 @@ void scx_bpf_destroy_dsq(u64 dsq_id) __k
>  void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
>  void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
>  void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
> +u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
> +u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
> +void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
>  u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
>  const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
>  const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -69,6 +69,18 @@ struct {
>  };
>
>  /*
> + * If enabled, CPU performance target is set according to the queue index
> + * according to the following table.
> + */
> +static const u32 qidx_to_cpuperf_target[] = {
> +       [0] = SCX_CPUPERF_ONE * 0 / 4,
> +       [1] = SCX_CPUPERF_ONE * 1 / 4,
> +       [2] = SCX_CPUPERF_ONE * 2 / 4,
> +       [3] = SCX_CPUPERF_ONE * 3 / 4,
> +       [4] = SCX_CPUPERF_ONE * 4 / 4,
> +};
> +
> +/*
>   * Per-queue sequence numbers to implement core-sched ordering.
>   *
>   * Tail seq is assigned to each queued task and incremented. Head seq tracks the
> @@ -95,6 +107,8 @@ struct {
>  struct cpu_ctx {
>         u64     dsp_idx;        /* dispatch index */
>         u64     dsp_cnt;        /* remaining count */
> +       u32     avg_weight;
> +       u32     cpuperf_target;
>  };
>
>  struct {
> @@ -107,6 +121,8 @@ struct {
>  /* Statistics */
>  u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
>  u64 nr_core_sched_execed;
> +u32 cpuperf_min, cpuperf_avg, cpuperf_max;
> +u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
>
>  s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
>                    s32 prev_cpu, u64 wake_flags)
> @@ -313,6 +329,29 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 c
>         }
>  }
>
> +void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
> +{
> +       struct cpu_ctx *cpuc;
> +       u32 zero = 0;
> +       int idx;
> +
> +       if (!(cpuc = bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
> +               scx_bpf_error("failed to look up cpu_ctx");
> +               return;
> +       }
> +
> +       /*
> +        * Use the running avg of weights to select the target cpuperf level.
> +        * This is a demonstration of the cpuperf feature rather than a
> +        * practical strategy to regulate CPU frequency.
> +        */
> +       cpuc->avg_weight = cpuc->avg_weight * 3 / 4 + p->scx.weight / 4;
> +       idx = weight_to_idx(cpuc->avg_weight);
> +       cpuc->cpuperf_target = qidx_to_cpuperf_target[idx];
> +
> +       scx_bpf_cpuperf_set(scx_bpf_task_cpu(p), cpuc->cpuperf_target);
> +}
> +
>  /*
>   * The distance from the head of the queue scaled by the weight of the queue.
>   * The lower the number, the older the task and the higher the priority.
> @@ -422,8 +461,9 @@ void BPF_STRUCT_OPS(qmap_dump_cpu, struc
>         if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, cpu)))
>                 return;
>
> -       scx_bpf_dump("QMAP: dsp_idx=%llu dsp_cnt=%llu",
> -                    cpuc->dsp_idx, cpuc->dsp_cnt);
> +       scx_bpf_dump("QMAP: dsp_idx=%llu dsp_cnt=%llu avg_weight=%u cpuperf_target=%u",
> +                    cpuc->dsp_idx, cpuc->dsp_cnt, cpuc->avg_weight,
> +                    cpuc->cpuperf_target);
>  }
>
>  void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struct *p)
> @@ -492,11 +532,106 @@ void BPF_STRUCT_OPS(qmap_cpu_offline, s3
>         print_cpus();
>  }
>
> +struct monitor_timer {
> +       struct bpf_timer timer;
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 1);
> +       __type(key, u32);
> +       __type(value, struct monitor_timer);
> +} monitor_timer SEC(".maps");
> +
> +/*
> + * Print out the min, avg and max performance levels of CPUs every second to
> + * demonstrate the cpuperf interface.
> + */
> +static void monitor_cpuperf(void)
> +{
> +       u32 zero = 0, nr_cpu_ids;
> +       u64 cap_sum = 0, cur_sum = 0, cur_min = SCX_CPUPERF_ONE, cur_max = 0;
> +       u64 target_sum = 0, target_min = SCX_CPUPERF_ONE, target_max = 0;
> +       const struct cpumask *online;
> +       int i, nr_online_cpus = 0;
> +
> +       nr_cpu_ids = scx_bpf_nr_cpu_ids();
> +       online = scx_bpf_get_online_cpumask();
> +
> +       bpf_for(i, 0, nr_cpu_ids) {
> +               struct cpu_ctx *cpuc;
> +               u32 cap, cur;
> +
> +               if (!bpf_cpumask_test_cpu(i, online))
> +                       continue;
> +               nr_online_cpus++;
> +
> +               /* collect the capacity and current cpuperf */
> +               cap = scx_bpf_cpuperf_cap(i);
> +               cur = scx_bpf_cpuperf_cur(i);
> +
> +               cur_min = cur < cur_min ? cur : cur_min;
> +               cur_max = cur > cur_max ? cur : cur_max;
> +
> +               /*
> +                * $cur is relative to $cap. Scale it down accordingly so that
> +                * it's in the same scale as other CPUs and $cur_sum/$cap_sum
> +                * makes sense.
> +                */
> +               cur_sum += cur * cap / SCX_CPUPERF_ONE;
> +               cap_sum += cap;
> +
> +               if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, i))) {
> +                       scx_bpf_error("failed to look up cpu_ctx");
> +                       goto out;
> +               }
> +
> +               /* collect target */
> +               cur = cpuc->cpuperf_target;
> +               target_sum += cur;
> +               target_min = cur < target_min ? cur : target_min;
> +               target_max = cur > target_max ? cur : target_max;
> +       }
> +
> +       cpuperf_min = cur_min;
> +       cpuperf_avg = cur_sum * SCX_CPUPERF_ONE / cap_sum;
> +       cpuperf_max = cur_max;
> +
> +       cpuperf_target_min = target_min;
> +       cpuperf_target_avg = target_sum / nr_online_cpus;
> +       cpuperf_target_max = target_max;
> +out:
> +       scx_bpf_put_cpumask(online);
> +}
> +
> +static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
> +{
> +       monitor_cpuperf();
> +
> +       bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
> +       return 0;
> +}
> +
>  s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
>  {
> +       u32 key = 0;
> +       struct bpf_timer *timer;
> +       s32 ret;
> +
>         print_cpus();
>
> -       return scx_bpf_create_dsq(SHARED_DSQ, -1);
> +       ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
> +       if (ret)
> +               return ret;
> +
> +       timer = bpf_map_lookup_elem(&monitor_timer, &key);
> +       if (!timer)
> +               return -ESRCH;
> +
> +       bpf_timer_init(timer, &monitor_timer, CLOCK_MONOTONIC);
> +       bpf_timer_set_callback(timer, monitor_timerfn);
> +
> +       return bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
>  }
>
>  void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
> @@ -509,6 +644,7 @@ SCX_OPS_DEFINE(qmap_ops,
>                .enqueue                 = (void *)qmap_enqueue,
>                .dequeue                 = (void *)qmap_dequeue,
>                .dispatch                = (void *)qmap_dispatch,
> +              .tick                    = (void *)qmap_tick,
>                .core_sched_before       = (void *)qmap_core_sched_before,
>                .cpu_release             = (void *)qmap_cpu_release,
>                .init_task               = (void *)qmap_init_task,
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -116,6 +116,14 @@ int main(int argc, char **argv)
>                        nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
>                        skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
>                        skel->bss->nr_core_sched_execed);
> +               if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
> +                       printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
> +                              skel->bss->cpuperf_min,
> +                              skel->bss->cpuperf_avg,
> +                              skel->bss->cpuperf_max,
> +                              skel->bss->cpuperf_target_min,
> +                              skel->bss->cpuperf_target_avg,
> +                              skel->bss->cpuperf_target_max);
>                 fflush(stdout);
>                 sleep(1);
>         }
>

