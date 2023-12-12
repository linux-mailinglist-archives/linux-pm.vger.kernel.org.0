Return-Path: <linux-pm+bounces-959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639680ED50
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74291C20CF7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87CD61692;
	Tue, 12 Dec 2023 13:22:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C294D44;
	Tue, 12 Dec 2023 05:22:04 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-590a21e977aso136746eaf.1;
        Tue, 12 Dec 2023 05:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387323; x=1702992123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJRNMY2mgce2G8fTxJIV4o/oS0aPFFROU79dw6RrvHE=;
        b=w4kKejQqsbQqCfHaH6UlJfGR8O73mznAvQM/xwu28SJkbVQWpnMHQ96U9j0dHaB10s
         eLW0XuhgNdarK3NDSCcxFekoza3DiIoSayvrBfVnzRhRIW62JrP1bxEVxLFl4lDdbewT
         mPBv8kT2mHTHwWCTjzrcJ1IfZMgZNOTeO758/65jAoxKbrQRwaI3OEKLe8Zux5m1sOYD
         nXOjsJ9PWzwPe5z2V4perJlyLpjdIxLq8qk6iS0mACUzFwGuUzgyrUogFj3wnj9ZvFks
         RONoAXVsB0fUJ8WNBKirDrYC6Anufl4D48LTNJsoAPk5IS4Qob9XT95u9Fv4l7HM2rld
         byaw==
X-Gm-Message-State: AOJu0YxreywMS7UcYScpW+QlgoiqnDpLeQw8zZjPwmn8UgmJ42pVXOif
	lszq1CNSdxAkmVk+YcSkOBx0miWZfUQd3h0rdfA=
X-Google-Smtp-Source: AGHT+IHhWlmsDDYMljaU6EnzphIooMeofMwaBh9MQx8vPKpJW24QQo1ZQ2fpdwO1qzYJULB0XVeBTMlYLeOZ8/6VS90=
X-Received: by 2002:a4a:da02:0:b0:590:8a57:8012 with SMTP id
 e2-20020a4ada02000000b005908a578012mr10340186oou.0.1702387323330; Tue, 12 Dec
 2023 05:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124223226.24249-1-frederic@kernel.org> <20231124223226.24249-7-frederic@kernel.org>
In-Reply-To: <20231124223226.24249-7-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 14:21:52 +0100
Message-ID: <CAJZ5v0gUp9DrzSnSdDYq36YGqKGTc3-fu1PN74WSC8-6fj3rKw@mail.gmail.com>
Subject: Re: [PATCH 6/7] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_POLLING_HARD states
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 11:32=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> The current handling of TIF_NR_POLLING is a bit of a maze:
>
> 1) A common brief part in the generic idle loop sets TIF_NR_POLLING
>   while cpuidle selects an appropriate state and the tick is evaluated
>   and then stopped. Summary: One pair of set/clear
>
> 2) The state cpuidle is then called with TIF_NR_POLLING cleared but if
>   the state polls on need_resched() (software or hardware), it sets
>   again TIF_NR_POLLING and clears it when it completes. Summary: another
>   pair of set/clear
>
> 3) goto 1)
>
> However those costly atomic operations, fully ordered RmW for some of
> them, could be avoided if the cpuidle core knew in advance if the target
> state polls on need_resched(). If so, TIF_NR_POLLING could simply be
> set once before entering the idle loop and cleared once after idle loop
> exit.
>
> Start dealing with that with handling TIF_NR_POLLING on behalf of
> CPUIDLE_FLAG_POLLING_HARD states.
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
> index 737a026ef58a..49078cc83f4a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -213,10 +213,10 @@ noinstr int cpuidle_enter_state(struct cpuidle_devi=
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
> @@ -236,6 +236,23 @@ noinstr int cpuidle_enter_state(struct cpuidle_devic=
e *dev,
>                 broadcast =3D false;
>         }
>
> +       polling =3D target_state->flags & CPUIDLE_FLAG_POLLING_HARD;
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
>                 leave_mm(dev->cpu);
>
> @@ -335,6 +352,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
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
> index 478084f9105e..50c13531f5d8 100644
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
> index 565f8374ddbb..4e554b4e3781 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -94,11 +94,12 @@ void __cpuidle default_idle_call(void)
>                 stop_critical_timings();
>
>                 ct_cpuidle_enter();
> -               arch_cpu_idle();
> +               arch_cpu_idle(); // XXX assumes !polling
>                 ct_cpuidle_exit();
>
>                 start_critical_timings();
>                 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +               __current_set_polling();
>         }
>         local_irq_enable();
>         instrumentation_end();
> @@ -107,31 +108,14 @@ void __cpuidle default_idle_call(void)
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

Since you are removing call_cpuidle(), you may as well remove
call_cpuidle_s2idle() which only has one caller anyway.

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
> @@ -198,7 +182,7 @@ static void cpuidle_idle_call(void)
>                 tick_nohz_idle_stop_tick();
>
>                 next_state =3D cpuidle_find_deepest_state(drv, dev, max_l=
atency_ns);
> -               call_cpuidle(drv, dev, next_state);
> +               cpuidle_enter(drv, dev, next_state);
>         } else {
>                 bool stop_tick =3D true;
>
> @@ -212,7 +196,12 @@ static void cpuidle_idle_call(void)
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
> @@ -220,7 +209,6 @@ static void cpuidle_idle_call(void)
>         }
>
>  exit_idle:
> -       __current_set_polling();
>
>         /*
>          * It is up to the idle functions to reenable local interrupts
> --
> 2.42.1
>

