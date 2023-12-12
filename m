Return-Path: <linux-pm+bounces-960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A8180ED8A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D381F21411
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDBD61FA2;
	Tue, 12 Dec 2023 13:27:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63525D65;
	Tue, 12 Dec 2023 05:27:50 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-590a21e977aso137318eaf.1;
        Tue, 12 Dec 2023 05:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387669; x=1702992469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt6fdI/cbCPQ7iqiyCD0Kz5AK/2nJCArCn0TPONSklY=;
        b=Qo0NkIUFlrMGBjz0Qdi+mPsasQyRuM9MaAkIbAPXqqUj1CLNxXQVsUNcEoNoue/Vsx
         Dp1PJ6f6I5lztb1IP7pX6tS5ZBx3gBrBh36SyGzP1r0smdZrVoVwpJbpr7mHeQ1b9WAL
         Rv1tEzIfiEA9pjuAshYgoksRu5RcQzWOmYt9yMmuTRid/jVqBfBaIewDTAc9XTDWyFRg
         7z2cOVGXIZ5OeGmI/7I38uuKTjPOWD48ACKzdlU+XVPgYNyuraIcDLZyZo5Kp7S67FGc
         WLSEOaqxEBUYmTPXHYoUS5o4+A/+UsCQdzWIPXZQbhiqgr8eZuZsdp2pCz+Zy4SMwgl0
         6H1A==
X-Gm-Message-State: AOJu0YzV4elXXxb/QhItI4Dqmdtg0s4SeZkm+N++cobYqpBDfJ231dtl
	KLzepdfDJHb10/VY6F4VckJbJgXYA1j/QqHBrrw=
X-Google-Smtp-Source: AGHT+IEMwrh+wmwyKoQDkoqdfpyeZge+VcdwSydHOS2utHB15/FENFpmZig3kvIyZrcafSowtaEmtOvUvN0E1gAnFGE=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr10131153ooq.1.1702387669582; Tue, 12 Dec
 2023 05:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124223226.24249-1-frederic@kernel.org> <20231124223226.24249-8-frederic@kernel.org>
In-Reply-To: <20231124223226.24249-8-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 14:27:38 +0100
Message-ID: <CAJZ5v0h4xic09rEOQSAnjA282mkrfA87Vo58a+Ag00x2BcVbQA@mail.gmail.com>
Subject: Re: [PATCH 7/7] cpuidle: Handle TIF_NR_POLLING on behalf of software
 polling idle states
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 11:33=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Software polling idle states set again TIF_NR_POLLING and clear it upon
> exit. This involves error prone duplicated code and wasted cycles
> performing atomic operations, sometimes RmW fully ordered.
>
> To avoid this, benefit instead from the same generic TIF_NR_POLLING
> handling that is currently in use for hardware polling states.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 10 ----------
>  drivers/cpuidle/cpuidle-pseries.c | 11 -----------
>  drivers/cpuidle/cpuidle.c         |  4 ++--
>  drivers/cpuidle/poll_state.c      | 30 ++++++++++++------------------
>  4 files changed, 14 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-=
powernv.c
> index 675b8eb81ebd..b88bbf7ead41 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -71,8 +71,6 @@ static int snooze_loop(struct cpuidle_device *dev,
>  {
>         u64 snooze_exit_time;
>
> -       set_thread_flag(TIF_POLLING_NRFLAG);
> -
>         local_irq_enable();
>
>         snooze_exit_time =3D get_tb() + get_snooze_timeout(dev, drv, inde=
x);
> @@ -81,21 +79,13 @@ static int snooze_loop(struct cpuidle_device *dev,
>         HMT_very_low();
>         while (!need_resched()) {
>                 if (likely(snooze_timeout_en) && get_tb() > snooze_exit_t=
ime) {
> -                       /*
> -                        * Task has not woken up but we are exiting the p=
olling
> -                        * loop anyway. Require a barrier after polling i=
s
> -                        * cleared to order subsequent test of need_resch=
ed().
> -                        */
> -                       clear_thread_flag(TIF_POLLING_NRFLAG);
>                         dev->poll_time_limit =3D true;
> -                       smp_mb();
>                         break;
>                 }
>         }
>
>         HMT_medium();
>         ppc64_runlatch_on();
> -       clear_thread_flag(TIF_POLLING_NRFLAG);
>
>         local_irq_disable();
>
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-=
pseries.c
> index 4e08c9a39172..0ae76512b740 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -39,8 +39,6 @@ int snooze_loop(struct cpuidle_device *dev, struct cpui=
dle_driver *drv,
>  {
>         u64 snooze_exit_time;
>
> -       set_thread_flag(TIF_POLLING_NRFLAG);
> -
>         pseries_idle_prolog();
>         raw_local_irq_enable();
>         snooze_exit_time =3D get_tb() + snooze_timeout;
> @@ -50,21 +48,12 @@ int snooze_loop(struct cpuidle_device *dev, struct cp=
uidle_driver *drv,
>                 HMT_low();
>                 HMT_very_low();
>                 if (likely(snooze_timeout_en) && get_tb() > snooze_exit_t=
ime) {
> -                       /*
> -                        * Task has not woken up but we are exiting the p=
olling
> -                        * loop anyway. Require a barrier after polling i=
s
> -                        * cleared to order subsequent test of need_resch=
ed().
> -                        */
>                         dev->poll_time_limit =3D true;
> -                       clear_thread_flag(TIF_POLLING_NRFLAG);
> -                       smp_mb();
>                         break;
>                 }
>         }
>
>         HMT_medium();
> -       clear_thread_flag(TIF_POLLING_NRFLAG);
> -
>         raw_local_irq_disable();
>
>         pseries_idle_epilog();
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 49078cc83f4a..9eb811b5d8b6 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -236,8 +236,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
 *dev,
>                 broadcast =3D false;
>         }
>
> -       polling =3D target_state->flags & CPUIDLE_FLAG_POLLING_HARD;
> -
> +       polling =3D (target_state->flags & (CPUIDLE_FLAG_POLLING_SOFT |
> +                                         CPUIDLE_FLAG_POLLING_HARD));

The outer parens are not needed on the right-hand side, or apply !! to it.

>         /*
>          * If the target state doesn't poll on need_resched(), this is
>          * the last check after which further TIF_NEED_RESCHED remote set=
ting
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index a2fe173de117..3bfa251b344a 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -13,35 +13,29 @@
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
> -       u64 time_start;
> -
> -       time_start =3D local_clock_noinstr();
> +       u64 time_start =3D local_clock_noinstr();
> +       unsigned int loop_count =3D 0;
> +       u64 limit;
>
>         dev->poll_time_limit =3D false;
>
>         raw_local_irq_enable();
> -       if (!current_set_polling_and_test()) {
> -               unsigned int loop_count =3D 0;
> -               u64 limit;
>
> -               limit =3D cpuidle_poll_time(drv, dev);
> +       limit =3D cpuidle_poll_time(drv, dev);
>
> -               while (!need_resched()) {
> -                       cpu_relax();
> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -                               continue;
> +       while (!need_resched()) {
> +               cpu_relax();
> +               if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> +                       continue;
>
> -                       loop_count =3D 0;
> -                       if (local_clock_noinstr() - time_start > limit) {
> -                               dev->poll_time_limit =3D true;
> -                               break;
> -                       }
> +               loop_count =3D 0;
> +               if (local_clock_noinstr() - time_start > limit) {
> +                       dev->poll_time_limit =3D true;
> +                       break;
>                 }
>         }
>         raw_local_irq_disable();
>
> -       current_clr_polling();
> -
>         return index;
>  }
>
> --

