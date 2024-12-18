Return-Path: <linux-pm+bounces-19426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58DD9F6737
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 14:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896237A02C4
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBE1B042F;
	Wed, 18 Dec 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p28bK4pp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01AF1B0426;
	Wed, 18 Dec 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528288; cv=none; b=LAFccbEWeOl+/Rcji9+q49NwPoEsw/o9CfjkrO8AHsRj5Z64lP02fXF/FuDRKxRirEdS2QpGcT++nxAcK+8ghMHpJsC5r/Md0ADcWoKjDRTQ0dfiY14EqaGz2o3zvl+TzuiCiSwxr1PFe8c5axZ3xu2OaKPtKkDhC9foKASLElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528288; c=relaxed/simple;
	bh=A6BYn+6ZhZGz88gWsnIvQcMFZcY0+jz9QE1nywcVhQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARnBBkbUC4tMZPF1e2bYWgZAVT+jon+c3zDLGnj69jGLJ5+sknPmz+PSkxnU6NkqutjJbBKGkS18r/iLl9MELplG6zVqTc4zXfPTgkztTgQEYpA0MNFjb0EQTN/KqKStDWVEgP5b3iOkSXCWV8oFR2eR0VF79nHdhv/PKa6lSHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p28bK4pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16783C4CEE1;
	Wed, 18 Dec 2024 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734528288;
	bh=A6BYn+6ZhZGz88gWsnIvQcMFZcY0+jz9QE1nywcVhQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p28bK4pp6BbFabuu7SVlYwXmV24S557JKBdDyIi7HNEyfDm/mcDXs/zWjo1JH8rFC
	 1Nw4aqSSyTS/+4nguhp11EdU8Ypvv97M6krRGHbcHUBjMsGtxZIkJY5GUdL5GaMM+n
	 WRKt0kCqUGR+ai7wB9So8uNERn0a79YdTRoeSFIY/o4Ig/3we44SwgXhDVhwiBYYl0
	 5cDsooXG7uDmxGSBH527E15hP5QCogi/vayqSdZyOi38mVGwLZjfOIDFyhkVkJSy17
	 xwTsbWOIF9O8EQuuaus6R72xeobAT+dGgmbPGLOlaVyb44PiBSB/g0Q5tJVlu6CAmI
	 iSDHuOZsQrdYw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eb9101419cso3323527b6e.0;
        Wed, 18 Dec 2024 05:24:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwLJEWYyAkERSgGO2nbtzuD0IePr8wEFignod+OISqwV0S9+Iuu1OixnAzpAtOr0VsWPhGqWahYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Ho0eGrj0Ul37uXi7E/aGicA3RK6+EiJfYh6Rb8lRc3eFzBhK
	icymQIZgIZpQLXWEt+ZtL3KpIcizYYlTCy0B6MzKNbmyBSGaL/nsANlSRBYPsCBcEWmTsxESOsy
	ux3/2AOyDjJWwD/azd1eynXIY4vU=
X-Google-Smtp-Source: AGHT+IGtu1hMsYfNwv3D0Zdgevmy9hMTmgZ6fvhksJHuY1BxJLPY2f2y1KzEtdQB2YIdUQ2Mv40Du9DpZ4tTuwKdBl8=
X-Received: by 2002:a05:6808:23d6:b0:3ea:64cc:4954 with SMTP id
 5614622812f47-3eccc09d310mr1906357b6e.35.1734528287213; Wed, 18 Dec 2024
 05:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206130408.18690-1-frederic@kernel.org> <20241206130408.18690-4-frederic@kernel.org>
In-Reply-To: <20241206130408.18690-4-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 14:24:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hJyeoeZ3L=RicDiHz9X8PqEvTgWJVT3s9rsy653w_Fug@mail.gmail.com>
Message-ID: <CAJZ5v0hJyeoeZ3L=RicDiHz9X8PqEvTgWJVT3s9rsy653w_Fug@mail.gmail.com>
Subject: Re: [PATCH 3/5] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_MWAIT states
To: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 2:04=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> The current handling of TIF_NR_POLLING is a bit of a maze:
>
> 1) TIF_NR_POLLING is set on idle entry (one atomic set)
>
> 2) Once cpuidle has selected an appropriate state and the tick is
>    evaluated and then possibly stopped, TIF_NR_POLLING is cleared
>    (one RmW operation)
>
> 2) The cpuidle state is then called with TIF_NR_POLLING cleared but if
>    the state polls on (or monitors) need_resched() it sets again
>    TIF_NR_POLLING before sleeping and clears it on wake-up. Summary:
>    another pair of set/clear
>
> 3) Set back TIF_NR_POLLING (one atomic set)
>
> 4) goto 2) if need_resched() is not set
>
> All those costly atomic operations, fully ordered RmW for some of
> them, could be avoided if the cpuidle core knew in advance if the target
> state polls on (or monitors) need_resched(). If so, TIF_NR_POLLING could
> simply be set once upon entering the idle loop and cleared once after
> idle loop exit.
>
> Start dealing with that with handling TIF_NR_POLLING on behalf of
> mwait based states.
>
> [fweisbec: _ Handle broadcast properly
>            _ Ignore mwait_idle() as it can be used by default_idle_call()=
]
>
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/x86/include/asm/mwait.h |  3 +--
>  drivers/cpuidle/cpuidle.c    | 22 +++++++++++++++++++-
>  include/linux/sched/idle.h   |  7 ++++++-
>  kernel/sched/idle.c          | 40 +++++++++++++-----------------------
>  4 files changed, 42 insertions(+), 30 deletions(-)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 920426d691ce..3634d00e5c37 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -116,7 +116,7 @@ static __always_inline void __sti_mwait(unsigned long=
 eax, unsigned long ecx)
>   */
>  static __always_inline void mwait_idle_with_hints(unsigned long eax, uns=
igned long ecx)
>  {
> -       if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_a=
nd_test()) {
> +       if (static_cpu_has_bug(X86_BUG_MONITOR) || !need_resched()) {

I'm not sure how X86_BUG_MONITOR is going to work after the change.

As is, X86_BUG_MONITOR prevents current_set_polling_and_test() from
being called, so __current_set_polling() will not be called and
TIF_POLLING_NRFLAG will not be set, so an IPI is going to be used for
CPU wakeup, which is what X86_BUG_MONITOR wants.

Preventing need_resched() from being called doesn't have this effect
and the rest of the patch doesn't do anything about X86_BUG_MONITOR.

Is anything missing?

>                 if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
>                         mb();
>                         clflush((void *)&current_thread_info()->flags);
> @@ -134,7 +134,6 @@ static __always_inline void mwait_idle_with_hints(uns=
igned long eax, unsigned lo
>                         }
>                 }
>         }
> -       current_clr_polling();
>  }
>
>  /*
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0835da449db8..46c0a2726f67 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -217,10 +217,10 @@ noinstr int cpuidle_enter_state(struct cpuidle_devi=
ce *dev,
>                                  int index)
>  {
>         int entered_state;
> -
>         struct cpuidle_state *target_state =3D &drv->states[index];
>         bool broadcast =3D !!(target_state->flags & CPUIDLE_FLAG_TIMER_ST=
OP);
>         ktime_t time_start, time_end;
> +       bool polling;
>
>         instrumentation_begin();
>
> @@ -237,6 +237,23 @@ noinstr int cpuidle_enter_state(struct cpuidle_devic=
e *dev,
>                 broadcast =3D false;
>         }
>
> +       polling =3D target_state->flags & CPUIDLE_FLAG_MWAIT;
> +
> +       /*
> +        * If the target state doesn't poll on need_resched(), this is
> +        * the last check after which further TIF_NEED_RESCHED remote set=
ting
> +        * will involve an IPI.
> +        */
> +       if (!polling && current_clr_polling_and_test()) {
> +               if (broadcast)
> +                       tick_broadcast_exit();
> +               dev->last_residency_ns =3D 0;
> +               local_irq_enable();
> +               instrumentation_end();
> +               return -EBUSY;
> +       }
> +
> +
>         if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
>                 leave_mm();
>
> @@ -336,6 +353,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
 *dev,
>                 dev->states_usage[index].rejected++;
>         }
>
> +       if (!polling)
> +               __current_set_polling();
> +
>         instrumentation_end();
>
>         return entered_state;
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index e670ac282333..3e3482bfb028 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -68,6 +68,8 @@ static __always_inline bool __must_check current_set_po=
lling_and_test(void)
>
>  static __always_inline bool __must_check current_clr_polling_and_test(vo=
id)
>  {
> +       bool ret;
> +
>         __current_clr_polling();
>
>         /*
> @@ -76,7 +78,10 @@ static __always_inline bool __must_check current_clr_p=
olling_and_test(void)
>          */
>         smp_mb__after_atomic();
>
> -       return unlikely(tif_need_resched());
> +       ret =3D unlikely(tif_need_resched());
> +       if (ret)
> +               __current_set_polling();
> +       return ret;
>  }
>
>  #else
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 621696269584..9eece3df1080 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -114,12 +114,13 @@ void __cpuidle default_idle_call(void)
>                 stop_critical_timings();
>
>                 ct_cpuidle_enter();
> -               arch_cpu_idle();
> +               arch_cpu_idle(); // XXX assumes !polling
>                 ct_cpuidle_exit();
>
>                 start_critical_timings();
>                 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>                 cond_tick_broadcast_exit();
> +               __current_set_polling();
>         }
>         local_irq_enable();
>         instrumentation_end();
> @@ -128,31 +129,14 @@ void __cpuidle default_idle_call(void)
>  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
>                                struct cpuidle_device *dev)
>  {
> +       int ret;
> +
>         if (current_clr_polling_and_test())
>                 return -EBUSY;
>
> -       return cpuidle_enter_s2idle(drv, dev);
> -}
> -
> -static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_devic=
e *dev,
> -                     int next_state)
> -{
> -       /*
> -        * The idle task must be scheduled, it is pointless to go to idle=
, just
> -        * update no idle residency and return.
> -        */
> -       if (current_clr_polling_and_test()) {
> -               dev->last_residency_ns =3D 0;
> -               local_irq_enable();
> -               return -EBUSY;
> -       }
> -
> -       /*
> -        * Enter the idle state previously returned by the governor decis=
ion.
> -        * This function will block until an interrupt occurs and will ta=
ke
> -        * care of re-enabling the local interrupts
> -        */
> -       return cpuidle_enter(drv, dev, next_state);
> +       ret =3D cpuidle_enter_s2idle(drv, dev);
> +       __current_set_polling();
> +       return ret;
>  }
>
>  /**
> @@ -213,7 +197,7 @@ static void cpuidle_idle_call(void)
>                 tick_nohz_idle_stop_tick();
>
>                 next_state =3D cpuidle_find_deepest_state(drv, dev, max_l=
atency_ns);
> -               call_cpuidle(drv, dev, next_state);
> +               cpuidle_enter(drv, dev, next_state);
>         } else {
>                 bool stop_tick =3D true;
>
> @@ -227,7 +211,12 @@ static void cpuidle_idle_call(void)
>                 else
>                         tick_nohz_idle_retain_tick();
>
> -               entered_state =3D call_cpuidle(drv, dev, next_state);
> +               /*
> +                * Enter the idle state previously returned by the govern=
or decision.
> +                * This function will block until an interrupt occurs and=
 will take
> +                * care of re-enabling the local interrupts.
> +                */
> +               entered_state =3D cpuidle_enter(drv, dev, next_state);
>                 /*
>                  * Give the governor an opportunity to reflect on the out=
come
>                  */
> @@ -235,7 +224,6 @@ static void cpuidle_idle_call(void)
>         }
>
>  exit_idle:
> -       __current_set_polling();
>
>         /*
>          * It is up to the idle functions to re-enable local interrupts
> --
> 2.46.0
>

