Return-Path: <linux-pm+bounces-20418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9064A109DE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D2218828DF
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66C61411C8;
	Tue, 14 Jan 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxl7r+jf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9D1E86E;
	Tue, 14 Jan 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866225; cv=none; b=hYebYOd2YNNkgQ2nL8tjEteKY71Jta9a+JlYw6zS8FaJFRPIRTcO/6WC9GfInXqOX16EJeYZ6glYH0jck/eEdqW6TXPAyVPbLFQ/C7RYfQXmzVTZhZy550lwrmNUzfEMHtV4rM5jdsnspWglWCnGfLh4gFXDkrBy94w8Kc7edDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866225; c=relaxed/simple;
	bh=9A+QIqdHk5KcGpZ1EJoEbgk1AZEYj4uA0f0Cq7CtT1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5RWWvvEJDoFlA02gDhFV4EliAsU6I7Lj9DG1Q8ZvnhWYo3+5GnWpQLmd4oMZv+787GZHnHNNDs1L5097DelrC+A7A4PHdLWYQf33BZH++OAtrWepKM56dCBGfzxD+flx7jSUI1+JcO55tvAO6kr27m3JyXQmZIVgf09CuSxXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxl7r+jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDACCC4CEE7;
	Tue, 14 Jan 2025 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736866225;
	bh=9A+QIqdHk5KcGpZ1EJoEbgk1AZEYj4uA0f0Cq7CtT1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mxl7r+jfUQ1G4Qse1YXVsEDpcYfxENw7eYR0GICOlqY2fS4h3lK1+hX+BG9h6OXwF
	 6aPBla0jTVBg0G4sKvpZr0CivFUZRSgMasfao4SnEwNwv5BB+hU7VFiE194niYd2Gv
	 GDh9t7MUZq/eq9rG3qLJey36IBX3AyvFNCpOpfjwo6RR/Bhkl8YdQ2OEfAoMvAEoFZ
	 RsF9YjRUlp7k7My43SWQJmU4stsTuhwKT/59TjkXiTN9nkGz02mVw9r5AltjXEG8HJ
	 88a02HP6eDCs24NGKBYwgRkeU2dRHGmNjq25/2F6JU+6pmwPIIxXYADAdQZ47kzox+
	 +WTVWYNY3ssNQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eba0f09c3aso1791271b6e.1;
        Tue, 14 Jan 2025 06:50:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAbkbeYeo2uwBNcnfUSG0G/zXHvBfoA5ymfldw9t/5ZI3wfT0rWvMQqnUiVanTgch+8zREX3tbCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBrmOYqqQl7e31B5f/4Hd6p6ZcIQK15s+jNTyF8WxsSpp0XUk
	4R2d4fENn8MPCy7T+EnL+5Pi+DjcCscQQ8cH7/dC5z5MuG1Pf6khqy+ezJ4IKmRe7lR4+YFeOpB
	7FYtearju9GVdAif0Gu4qFdb43GA=
X-Google-Smtp-Source: AGHT+IHTKkETVklct/5mK0MshyugBkoo3A798QnO0ScRNIzxsTMwW3xIlm2DcFvMVGUQ+w9tYXr6uLxTHXCxfVBBHX8=
X-Received: by 2002:a05:6808:ecf:b0:3ea:5ef1:c95 with SMTP id
 5614622812f47-3ef2ed4ab47mr15686503b6e.25.1736866224139; Tue, 14 Jan 2025
 06:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102150201.21639-1-frederic@kernel.org> <20250102150201.21639-5-frederic@kernel.org>
In-Reply-To: <20250102150201.21639-5-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 15:50:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j=GN43RWi0zqwHOch-NJWMtfLoRFeMsHPGnOKPUxfGvA@mail.gmail.com>
X-Gm-Features: AbW1kvac8-3AY2ttYTaaspAxnB6sMbXLfnPzHIbYr8tP80d52zypIUj8ZnIuMNk
Message-ID: <CAJZ5v0j=GN43RWi0zqwHOch-NJWMtfLoRFeMsHPGnOKPUxfGvA@mail.gmail.com>
Subject: Re: [PATCH 4/6] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_MWAIT states
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 4:02=E2=80=AFPM Frederic Weisbecker <frederic@kernel=
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
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/x86/include/asm/mwait.h | 27 +++++++++++-------------
>  drivers/cpuidle/cpuidle.c    | 22 +++++++++++++++++++-
>  include/linux/sched/idle.h   |  7 ++++++-
>  kernel/sched/idle.c          | 40 +++++++++++++-----------------------
>  4 files changed, 53 insertions(+), 43 deletions(-)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 920426d691ce..3e06a7f3bf5a 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -116,25 +116,22 @@ static __always_inline void __sti_mwait(unsigned lo=
ng eax, unsigned long ecx)
>   */
>  static __always_inline void mwait_idle_with_hints(unsigned long eax, uns=
igned long ecx)
>  {
> -       if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_a=
nd_test()) {
> -               if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
> -                       mb();
> -                       clflush((void *)&current_thread_info()->flags);
> -                       mb();
> -               }
> +       if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
> +               mb();
> +               clflush((void *)&current_thread_info()->flags);
> +               mb();
> +       }
>
> -               __monitor((void *)&current_thread_info()->flags, 0, 0);
> +       __monitor((void *)&current_thread_info()->flags, 0, 0);
>
> -               if (!need_resched()) {
> -                       if (ecx & 1) {
> -                               __mwait(eax, ecx);
> -                       } else {
> -                               __sti_mwait(eax, ecx);
> -                               raw_local_irq_disable();
> -                       }
> +       if (!need_resched()) {
> +               if (ecx & 1) {
> +                       __mwait(eax, ecx);
> +               } else {
> +                       __sti_mwait(eax, ecx);
> +                       raw_local_irq_disable();
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

Hmmm.  What about "polling" states, like state 0 on all x86?

They also monitor need_resched() -see  poll_idle().

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

Well, what if x86_idle is default_idle()?  Say, somebody boots with
IDLE_NOMWAIT?

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

