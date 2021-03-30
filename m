Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56934EAF8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhC3Os3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 10:48:29 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42931 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhC3OsH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 10:48:07 -0400
Received: by mail-oi1-f170.google.com with SMTP id n140so16711216oig.9;
        Tue, 30 Mar 2021 07:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQ/R6CX19Up1J/nwzUUDCWCDOqM+HhWlcKjpkwoy/dw=;
        b=mtU6z3upXkBBcGeDOTZoFToB84dfqk5/SNFDioGQtaZuoW1jnbJHjIYaW/8LzHOHzL
         DDK9RoPg5dOWix7D38RHvTh9DAhA7pCKSChsLOuR5h9af9Opq+3IWTHP8Vl5TSVKVgvf
         Q4tpqI0hP1SaDruhmc3MBP1PotNsfavOLXpZBG32GwOXEtKLUMimlFIVZZepklK+hX+/
         v8a0l5ZBAKYGhC36uo/TB3+L+Q06vDT1waZfjzrH1dBvkBIz/bcWI1vYC7xR3NE3R4GB
         5ua1GMsD5E+wPWHYIy9suUhboATia3rAq0siVE47hCzUr0ahU5gr3iZARL9L9VbBLKZP
         2ubQ==
X-Gm-Message-State: AOAM530ou1oblJZuMA2njTLeh6EC5n1LjtBsN6D7Sl76gvz6Ct0mes4K
        Job9TVQdMCBBa6jAj7dvsQcrezet34FBE1BLN5Q=
X-Google-Smtp-Source: ABdhPJw75WK5bLCPQwIm+UDp3+5uDPOkoCrL/5DraFpHz6I7ZSACiuS3AlGcJfUEX9ZpsZysU1F8SRkITlmRM0MJyyg=
X-Received: by 2002:a05:6808:24b:: with SMTP id m11mr3513854oie.157.1617115686845;
 Tue, 30 Mar 2021 07:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <2764850.e9J7NaK4W3@kreacher> <7927358.NyiUUSuA9g@kreacher> <YTBPR01MB3262DB49961DBCCE96C51AB8C47D9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YTBPR01MB3262DB49961DBCCE96C51AB8C47D9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Mar 2021 16:47:56 +0200
Message-ID: <CAJZ5v0g75+AFyQ-SP=ckKR5M171i7RaR1Qj66rUpHZujCFMqbA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] cpuidle: menu: Take negative "sleep length" values
 into account
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 30, 2021 at 4:00 AM Zhou Ti (x2019cwm) <x2019cwm@stfx.ca> wrote:
>
> On Mon 2021-03-29 14:37 Rafael J. Wysocki wrote:
> > Make the menu governor check the tick_nohz_get_next_hrtimer()
> > return value so as to avoid dealing with negative "sleep length"
> > values and make it use that value directly when the tick is stopped.
> >
> > While at it, rename local variable delta_next in menu_select() to
> > delta_tick which better reflects its purpose.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |   17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/menu.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> > +++ linux-pm/drivers/cpuidle/governors/menu.c
> > @@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_dr
> >          u64 predicted_ns;
> >          u64 interactivity_req;
> >          unsigned long nr_iowaiters;
> > -       ktime_t delta_next;
> > +       ktime_t delta, delta_tick;
> >          int i, idx;
> >
> >          if (data->needs_update) {
> > @@ -280,7 +280,12 @@ static int menu_select(struct cpuidle_dr
> >          }
> >
> >          /* determine the expected residency time, round up */
> > -       data->next_timer_ns = tick_nohz_get_sleep_length(&delta_next);
> > +       delta = tick_nohz_get_sleep_length(&delta_tick);
> > +       if (unlikely(delta < 0)) {
> > +               delta = 0;
> > +               delta_tick = 0;
> > +       }
> > +       data->next_timer_ns = delta;
> >
> >          nr_iowaiters = nr_iowait_cpu(dev->cpu);
> >          data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
> > @@ -318,7 +323,7 @@ static int menu_select(struct cpuidle_dr
> >                   * state selection.
> >                   */
> >                  if (predicted_ns < TICK_NSEC)
> > -                       predicted_ns = delta_next;
> > +                       predicted_ns = data->next_timer_ns;
> >          } else {
> >                  /*
> >                   * Use the performance multiplier and the user-configurable
> > @@ -377,7 +382,7 @@ static int menu_select(struct cpuidle_dr
> >                           * stuck in the shallow one for too long.
> >                           */
> >                          if (drv->states[idx].target_residency_ns < TICK_NSEC &&
> > -                           s->target_residency_ns <= delta_next)
> > +                           s->target_residency_ns <= delta_tick)
> >                                  idx = i;
> >
> >                          return idx;
> > @@ -399,7 +404,7 @@ static int menu_select(struct cpuidle_dr
> >               predicted_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
> >                  *stop_tick = false;
> >
> > -               if (idx > 0 && drv->states[idx].target_residency_ns > delta_next) {
> > +               if (idx > 0 && drv->states[idx].target_residency_ns > delta_tick) {
> >                          /*
> >                           * The tick is not going to be stopped and the target
> >                           * residency of the state to be returned is not within
> > @@ -411,7 +416,7 @@ static int menu_select(struct cpuidle_dr
> >                                          continue;
> >
> >                                  idx = i;
> > -                               if (drv->states[i].target_residency_ns <= delta_next)
> > +                               if (drv->states[i].target_residency_ns <= delta_tick)
> >                                          break;
> >                          }
> >                  }
>
> How about this.
> I think it's possible to avoid the new variable delta.
>
> ---
>
> --- linux-pm/drivers/cpuidle/governors/menu.c.orig      2021-03-29 22:44:02.316971970 -0300
> +++ linux-pm/drivers/cpuidle/governors/menu.c   2021-03-29 22:51:15.804377168 -0300
> @@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_dr
>         u64 predicted_ns;
>         u64 interactivity_req;
>         unsigned long nr_iowaiters;
> -       ktime_t delta_next;
> +       ktime_t delta_tick;
>         int i, idx;
>
>         if (data->needs_update) {
> @@ -280,7 +280,12 @@ static int menu_select(struct cpuidle_dr
>         }
>
>         /* determine the expected residency time, round up */
> -       data->next_timer_ns = tick_nohz_get_sleep_length(&delta_next);
> +       data->next_timer_ns = tick_nohz_get_sleep_length(&delta_tick);
> +
> +       if (unlikely(data->next_timer_ns >> 63)) {
> +               data->next_timer_ns = 0;
> +               delta_tick = 0;
> +       }

Well, not really.  Using a new local var is cleaner IMO.
