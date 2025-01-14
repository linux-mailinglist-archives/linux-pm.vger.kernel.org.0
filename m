Return-Path: <linux-pm+bounces-20420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A5A10A05
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86953A2371
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688201547C6;
	Tue, 14 Jan 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh1C2u5E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E514A60C;
	Tue, 14 Jan 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866620; cv=none; b=QQjPnrgYaZQ9Y7PayOeZIIC7QhOQ7G3Y99kAs7H2Nr1wKeJMvraXpRfTYkzQ+4YGjnDTXzqr1BPmu2NhZRasLV1FBmCi14bQ+0OPadl2ZlQL3GIIwA+h5KOJ4oHGepZIKy0tZDCp2YdfnFq6L7qO3RDYHuTgxqHUnEDnQecgOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866620; c=relaxed/simple;
	bh=hh5riJK1De/6XJNrKaDD6YxVAkXdyI0VoagIQT/xPBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1wTBzZ5SHz3taJa4mlmNbAqS799kR+dg1gaKL70eWL/mV8cFJn5q7IA3UJ0nPh6FVz0r+Wm+RaJgHGy0l3vFN09tHgHsSS501bXmPMCzNeNVJCDpnSRHzfXXD9L2PhE8mmN4Q872+ib1pfXyL+KMALxr/X2CAPWLSK3axGn4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh1C2u5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BFCC4CEE4;
	Tue, 14 Jan 2025 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736866619;
	bh=hh5riJK1De/6XJNrKaDD6YxVAkXdyI0VoagIQT/xPBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kh1C2u5EDdSWvKd5bf256G0OraH6kMy2N3Je3VRnjOUKdrKX9T/wJHc5mP1iQlaq4
	 zKzWZgSNuAEruYAjvx7ixNKQlwVbpBZK5UZ+o/sWASVlds04iiFdfKJTBSMNmb0l9s
	 k/MisytLJR/8cdVpEvfL4++tfiRLGU6pWFs5t/plqpJ23UySJgE44E+SRCfROlVn6m
	 J06F6a+5YL0wzmooj5fjsp9em9v+gmxi/+2L45fSa4Vaz3/g1Qgvfbba5touv0/SMQ
	 4k+awoSkrW6/cpuFQv49FnLRb6M5FgDCtlpum8V3yd+Ss8NFz3Gv+QQAUS+q4+YJAs
	 x5yEeTJy3ylCA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f8befb03d0so723046eaf.1;
        Tue, 14 Jan 2025 06:56:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4d/h2+QQAXzxowPXtoHiBPuvBtCEB/Y4QpaUIzrZwwrqrH5l9DvfAFRmocHLAihhFhVSSyM9cNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yWqicd1R34rSxTuYHVdpL1NqYLqK2jVzHcYurtddD+5xKw8h
	k7sTsJOmswR04YpDZ+meKu+wVISUOGKYuXoiWdNiyL7eXlREZ+3yzTXubPxW7u4o0SxJzMVEjWe
	eAWsau0R0JRCwNpQNje3szGumIAM=
X-Google-Smtp-Source: AGHT+IG8SeMYfZHr7W+Kz8el6c75cZccbGMWHj4V2qBgF8x2fRqSeWLjJ6N/eTsiQAqKJyHwRbxc8JRZeN+9QCjrrSI=
X-Received: by 2002:a05:6871:2005:b0:29e:617f:c96 with SMTP id
 586e51a60fabf-2aa06541debmr15943734fac.6.1736866619131; Tue, 14 Jan 2025
 06:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102150201.21639-1-frederic@kernel.org> <20250102150201.21639-7-frederic@kernel.org>
In-Reply-To: <20250102150201.21639-7-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 15:56:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iy6oN67o2uH_j_weCqAb0CNBJhOLFaxv-Bexmf0Mybaw@mail.gmail.com>
X-Gm-Features: AbW1kvZk6q3x_rVTt46qlYuRJmX4K3IDuhioucKG-B5ow2vzXH2zKLiqxZ10ILA
Message-ID: <CAJZ5v0iy6oN67o2uH_j_weCqAb0CNBJhOLFaxv-Bexmf0Mybaw@mail.gmail.com>
Subject: Re: [PATCH 6/6] cpuidle: Handle TIF_NR_POLLING on behalf of software
 polling idle states
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
> Software polling idle states set again TIF_NR_POLLING and clear it upon
> exit. This involves error prone duplicated code and wasted cycles
> performing atomic operations, sometimes RmW fully ordered.
>
> To avoid this, benefit instead from the same generic TIF_NR_POLLING
> handling that is currently in use for hardware monitoring states.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

So this is the part I was wondering about when I was looking at patch [4/6]=
.

The code changes below look good to me, so feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch when ready.

> ---
>  drivers/cpuidle/cpuidle-powernv.c | 10 ----------
>  drivers/cpuidle/cpuidle-pseries.c | 11 -----------
>  drivers/cpuidle/cpuidle.c         |  2 +-
>  drivers/cpuidle/poll_state.c      | 30 ++++++++++++------------------
>  4 files changed, 13 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-=
powernv.c
> index 9ebedd972df0..1bf0d2234016 100644
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
> index f68c65f1d023..704bb01d9e9e 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -40,8 +40,6 @@ int snooze_loop(struct cpuidle_device *dev, struct cpui=
dle_driver *drv,
>  {
>         u64 snooze_exit_time;
>
> -       set_thread_flag(TIF_POLLING_NRFLAG);
> -
>         pseries_idle_prolog();
>         raw_local_irq_enable();
>         snooze_exit_time =3D get_tb() + snooze_timeout;
> @@ -51,21 +49,12 @@ int snooze_loop(struct cpuidle_device *dev, struct cp=
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
> index 46c0a2726f67..fecc50c2860e 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -237,7 +237,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device=
 *dev,
>                 broadcast =3D false;
>         }
>
> -       polling =3D target_state->flags & CPUIDLE_FLAG_MWAIT;
> +       polling =3D target_state->flags & (CPUIDLE_FLAG_MWAIT | CPUIDLE_F=
LAG_POLLING);
>
>         /*
>          * If the target state doesn't poll on need_resched(), this is
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..d69936e2517e 100644
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
> 2.46.0
>

