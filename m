Return-Path: <linux-pm+bounces-83-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262A7F483D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 14:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86EFEB20C27
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6717E4E611;
	Wed, 22 Nov 2023 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E9C197;
	Wed, 22 Nov 2023 05:52:09 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6d63e0412faso1037216a34.1;
        Wed, 22 Nov 2023 05:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661128; x=1701265928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YElAUeh0PJwizqbf2zvUPQjlNmHfIkDxz8S1DX6ndYg=;
        b=irCU1W/0WWk3ThW47N/mG0Uw4khsC0L0uLWF0QCdIEYzjhrrg86uCNOjLtRNzzY+qD
         OanNgDqKxKeDc+ZiGiKzy2qdU9REmLt7iNczZRi2C8mNpzg+6yhTtYSDwd5yfG8ycArZ
         RaKaDYhuYkclyoBwP23asEhnt1sR+5oOexpoJQ0fn7FjZrRxo9Opo8qIhs81QgqqKLZy
         fGwwKD69yf94EdC7lRfw/kzRIwsrAhZsr5ion43zWhc/7JaDo1TUAjliD9HzejQ/Rqnl
         YdofpF4uIiarqA/CivFVSpw/oWLiT+PAKIab4Ps4gcXo6o9nZVPgat6HD54bftc6ho2M
         3hPA==
X-Gm-Message-State: AOJu0YzIHZMrz4C9Jk4QZbMKCoE04k2WEcAp0pEfpceUGhC/97CWlhcp
	fm5Shtld3bbv1ql/Hr7bLu3BHEDJrTxBNzITnzM=
X-Google-Smtp-Source: AGHT+IHrgTixFsC/2ZPYbFCxDDTHbMVbZq39BdpnPk80LT2BokzSULxJqbwu48QT2DpGo2ZHBQBHrqfTG9LRNRVPx4w=
X-Received: by 2002:a05:6871:d20c:b0:1f5:d3f5:2b92 with SMTP id
 pk12-20020a056871d20c00b001f5d3f52b92mr3346592oac.2.1700661128242; Wed, 22
 Nov 2023 05:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122133904.446032-1-vincent.guittot@linaro.org> <20231122133904.446032-3-vincent.guittot@linaro.org>
In-Reply-To: <20231122133904.446032-3-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 14:51:57 +0100
Message-ID: <CAJZ5v0iBO9LUs7xJKF0w1sOTM2ted5KxK4idwyCjBReyEYw+mw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sched/schedutil: Rework iowait boost
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, qyousef@layalina.io, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, wyes.karny@amd.com, 
	beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 2:39=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Use the max value that has already been computed inside sugov_get_util()
> to cap the iowait boost and remove dependency with uclamp_rq_util_with()
> which is not used anymore.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Or if you want me to pick up this series, please let me know.

> ---
>  kernel/sched/cpufreq_schedutil.c | 29 ++++++++-------
>  kernel/sched/sched.h             | 60 --------------------------------
>  2 files changed, 14 insertions(+), 75 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index f3acf2cf26ed..4ee8ad70be99 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -169,11 +169,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, uns=
igned long actual,
>         return max(min, max);
>  }
>
> -static void sugov_get_util(struct sugov_cpu *sg_cpu)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost=
)
>  {
>         unsigned long min, max, util =3D cpu_util_cfs_boost(sg_cpu->cpu);
>
>         util =3D effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> +       util =3D max(util, boost);
>         sg_cpu->bw_min =3D min;
>         sg_cpu->util =3D sugov_effective_cpu_perf(sg_cpu->cpu, util, min,=
 max);
>  }
> @@ -266,18 +267,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg=
_cpu, u64 time,
>   * This mechanism is designed to boost high frequently IO waiting tasks,=
 while
>   * being more conservative on tasks which does sporadic IO operations.
>   */
> -static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> +static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 ti=
me,
>                                unsigned long max_cap)
>  {
> -       unsigned long boost;
> -
>         /* No boost currently required */
>         if (!sg_cpu->iowait_boost)
> -               return;
> +               return 0;
>
>         /* Reset boost if the CPU appears to have been idle enough */
>         if (sugov_iowait_reset(sg_cpu, time, false))
> -               return;
> +               return 0;
>
>         if (!sg_cpu->iowait_boost_pending) {
>                 /*
> @@ -286,7 +285,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_c=
pu, u64 time,
>                 sg_cpu->iowait_boost >>=3D 1;
>                 if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
>                         sg_cpu->iowait_boost =3D 0;
> -                       return;
> +                       return 0;
>                 }
>         }
>
> @@ -296,10 +295,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_=
cpu, u64 time,
>          * sg_cpu->util is already in capacity scale; convert iowait_boos=
t
>          * into the same scale so we can compare.
>          */
> -       boost =3D (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIF=
T;
> -       boost =3D uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
> -       if (sg_cpu->util < boost)
> -               sg_cpu->util =3D boost;
> +       return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
>  }
>
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -329,6 +325,8 @@ static inline bool sugov_update_single_common(struct =
sugov_cpu *sg_cpu,
>                                               u64 time, unsigned long max=
_cap,
>                                               unsigned int flags)
>  {
> +       unsigned long boost;
> +
>         sugov_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update =3D time;
>
> @@ -337,8 +335,8 @@ static inline bool sugov_update_single_common(struct =
sugov_cpu *sg_cpu,
>         if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>                 return false;
>
> -       sugov_get_util(sg_cpu);
> -       sugov_iowait_apply(sg_cpu, time, max_cap);
> +       boost =3D sugov_iowait_apply(sg_cpu, time, max_cap);
> +       sugov_get_util(sg_cpu, boost);
>
>         return true;
>  }
> @@ -439,9 +437,10 @@ static unsigned int sugov_next_freq_shared(struct su=
gov_cpu *sg_cpu, u64 time)
>
>         for_each_cpu(j, policy->cpus) {
>                 struct sugov_cpu *j_sg_cpu =3D &per_cpu(sugov_cpu, j);
> +               unsigned long boost;
>
> -               sugov_get_util(j_sg_cpu);
> -               sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +               boost =3D sugov_iowait_apply(j_sg_cpu, time, max_cap);
> +               sugov_get_util(j_sg_cpu, boost);
>
>                 util =3D max(j_sg_cpu->util, util);
>         }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c1574cd388e7..e58a54bda77d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3058,59 +3058,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq=
)
>         return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
>  }
>
> -/**
> - * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp va=
lues.
> - * @rq:                The rq to clamp against. Must not be NULL.
> - * @util:      The util value to clamp.
> - * @p:         The task to clamp against. Can be NULL if you want to cla=
mp
> - *             against @rq only.
> - *
> - * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
> - *
> - * If sched_uclamp_used static key is disabled, then just return the uti=
l
> - * without any clamping since uclamp aggregation at the rq level in the =
fast
> - * path is disabled, rendering this operation a NOP.
> - *
> - * Use uclamp_eff_value() if you don't care about uclamp values at rq le=
vel. It
> - * will return the correct effective uclamp value of the task even if th=
e
> - * static key is disabled.
> - */
> -static __always_inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -                                 struct task_struct *p)
> -{
> -       unsigned long min_util =3D 0;
> -       unsigned long max_util =3D 0;
> -
> -       if (!static_branch_likely(&sched_uclamp_used))
> -               return util;
> -
> -       if (p) {
> -               min_util =3D uclamp_eff_value(p, UCLAMP_MIN);
> -               max_util =3D uclamp_eff_value(p, UCLAMP_MAX);
> -
> -               /*
> -                * Ignore last runnable task's max clamp, as this task wi=
ll
> -                * reset it. Similarly, no need to read the rq's min clam=
p.
> -                */
> -               if (uclamp_rq_is_idle(rq))
> -                       goto out;
> -       }
> -
> -       min_util =3D max_t(unsigned long, min_util, uclamp_rq_get(rq, UCL=
AMP_MIN));
> -       max_util =3D max_t(unsigned long, max_util, uclamp_rq_get(rq, UCL=
AMP_MAX));
> -out:
> -       /*
> -        * Since CPU's {min,max}_util clamps are MAX aggregated consideri=
ng
> -        * RUNNABLE tasks with _different_ clamps, we can end up with an
> -        * inversion. Fix it now when the clamps are applied.
> -        */
> -       if (unlikely(min_util >=3D max_util))
> -               return min_util;
> -
> -       return clamp(util, min_util, max_util);
> -}
> -
>  /* Is the rq being capped/throttled by uclamp_max? */
>  static inline bool uclamp_rq_is_capped(struct rq *rq)
>  {
> @@ -3148,13 +3095,6 @@ static inline unsigned long uclamp_eff_value(struc=
t task_struct *p,
>         return SCHED_CAPACITY_SCALE;
>  }
>
> -static inline
> -unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> -                                 struct task_struct *p)
> -{
> -       return util;
> -}
> -
>  static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
>
>  static inline bool uclamp_is_used(void)
> --
> 2.34.1
>

