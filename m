Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95381FDD7B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 13:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfKOMZS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 07:25:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40658 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfKOMZS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 07:25:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so10507219ljg.7
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 04:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a5dA1if5/dQUQeOTvdz3dJTa9SYokhdVUuKyxt1MvCE=;
        b=yWCtHgRlb4JZrA50T4PvT54dR5u+qgTHvhqG+YCar+56kZzaBL1GHP4g9OKYRAiq3q
         8yjgciJsyX4xve0vLX7QAOCUtaTNM6p58BmQDeip9IcENPnSCmpEmhqekYKAlZFxWAJo
         d8/gD7pxEipb4Zqr0AJlDuCiaSVVkQl2ldBcVIfwCZ7CcczIILwMLvOZIQjiVMmTxkmO
         Rbu4huZoF982p2IGm30Dyn22gJam6KHByalfJ+1lFQ33UCjNajxN9dALj3LTYcSB7hQP
         t1RW37inWkg8hUugq+lFfKrQNQRMWsYKH6T8shNgx3L3Fez1L8InBtQgk+qF/XA/yKM9
         ZuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a5dA1if5/dQUQeOTvdz3dJTa9SYokhdVUuKyxt1MvCE=;
        b=NV7d+8cQ7wWbwuhpadW092J9kqbRAie2+AXEDuP1tXaNSobPKjuh1mNUNOe66GPcFQ
         FWa49euqjf14UKN+Gbog1UY0cPOoYIowrXCsU4sT34WGMAexYsK+G2Lyw7sSRTBxxrkz
         Y3SZnWZjkg2EBamaZ1u16wxRa753Yv79FBIjmngQ0nL5ahGgya+1LUz5EUpMIXFyRybC
         VSBvuXCfiIiVBrgYpelM7HS8+I4Ehp9VuJUfIgNaTtPrQdW1yVipB10X4yvTRH6z1VV8
         7AWab8fJsncBUnmQ9cVjGEiWVyjteYwuKHByLFYEEuHSOiPzp3Da5PKciBGUj97ktmQS
         OmIA==
X-Gm-Message-State: APjAAAW2nyyLvg4C4qlFCWQuYMW0WNQ9qAmAaA7gNQA42PaHNSlaynTw
        f0epBfUXoMgir6r5ktCexDWj0yWKBQcDyImnjMmSTg==
X-Google-Smtp-Source: APXvYqx8XtWvU/urGTyHEcUEsNketHxIixjd/Ef3NbTOYU3Cg7krIvcGwOH3/8NFn7fsISi0vWBtOnn97sLIk8bgVhk=
X-Received: by 2002:a2e:9695:: with SMTP id q21mr10562244lji.206.1573820716098;
 Fri, 15 Nov 2019 04:25:16 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <CAKfTPtA-up_9WHfTka33WRxXCatUZioYS0v5gY9jjzOGT98oLQ@mail.gmail.com> <20191115115935.GA27454@linaro.org>
In-Reply-To: <20191115115935.GA27454@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 13:25:04 +0100
Message-ID: <CAKfTPtDzeFi7E3q-o7-KghKWm6eVgN4BLKKphQJYJyqCoVP5Yg@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Nov 2019 at 12:59, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Le Friday 15 Nov 2019 =C3=A0 11:29:03 (+0100), Vincent Guittot a =C3=A9cr=
it :
> > On Fri, 15 Nov 2019 at 11:18, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Fri, 15 Nov 2019 at 10:55, Peter Zijlstra <peterz@infradead.org> w=
rote:
> > > >
> > > > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > > > > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pel=
t decays,
> > > > > which might be inefficient when cpufreq driver has rate limitatio=
n.
> > > > >
> > > > > When a task is attached on a CPU, we have call path:
> > > > >
> > > > > update_load_avg()
> > > > >   update_cfs_rq_load_avg()
> > > > >     cfs_rq_util_change -- > trig frequency update
> > > > >   attach_entity_load_avg()
> > > > >     cfs_rq_util_change -- > trig frequency update
> > > > >
> > > > > The 1st frequency update will not take into account the utilizati=
on of the
> > > > > newly attached task and the 2nd one might be discard because of r=
ate
> > > > > limitation of the cpufreq driver.
> > > >
> > > > Doesn't this just show that a dumb rate limit in the driver is brok=
en?
> > >
> > > But the rate limit may come from HW constraints that forces to wait
> > > let say 4ms or even 10ms between each frequency update.
> > >
> > > >
> > > > > update_cfs_rq_load_avg() is only called by update_blocked_average=
s()
> > > > > and update_load_avg() so we can move the call to
> > > > > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. =
It's also
> > > > > interesting to notice that update_load_avg() already calls direct=
ly
> > > > > cfs_rq_util_change() for !SMP case.
> > > > >
> > > > > This changes will also ensure that cpufreq_update_util() is calle=
d even
> > > > > when there is no more CFS rq in the leaf_cfs_rq_list to update bu=
t only
> > > > > irq, rt or dl pelt signals.
> > > >
> > > > I don't think it does that; that is, iirc the return value of
> > > > ___update_load_sum() is 1 every time a period lapses. So even if th=
e avg
> > > > is 0 and doesn't change, it'll still return 1 on every period.
> > > >
> > > > Which is what that dumb rate-limit thing wants of course. But I'm s=
till
> > > > thinking that it's stupid to do. If nothing changes, don't generate
> > > > events.
> > >
> > > When everything (irq, dl, rt, cfs) is 0, we don't generate events
> > > because update_blocked_averages is no more called because
> > > rq->has_blocked_load is clear
> > >
> > > With current implementation, if cfs is 0 but not irq, dl or rt, we
> > > don't call cpufreq_update_util because it is only called through cfs
> > >
> > > >
> > > > If anything, update_blocked_avgerages() should look at
> > > > @done/others_have_blocked() to emit events for rt,dl,irq.
> > >
> > > other_have_blocked can be set but no decay happened during the update
> > > and we don't need to call cpufreq_update_util
> > >
> > > >
> > > > So why are we making the scheduler code more ugly instead of fixing=
 that
> > > > driver?
> >
> > Also, I think that calling cfs_rq_util_change in
> > attach_entity_load_avg is not optimal because the attach can happen at
> > a child level before it has been propagated down to root
> > So I'm working on trying to remove it from attach_entity_load_avg and
> > keep it in update_load_avg. this would help cleaning the ugly
> >
> > -       } else if (decayed && (flags & UPDATE_TG))
> > -               update_tg_load_avg(cfs_rq, 0);
> > +       } else if (decayed) {
> > +               cfs_rq_util_change(cfs_rq, 0);
> > +
> > +               if (flags & UPDATE_TG)
> > +                       update_tg_load_avg(cfs_rq, 0);
> > +       }
> >  }
> >
>
> we can also do this instead :
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d377a3f..550b6bc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3614,15 +3614,15 @@ static inline void update_load_avg(struct cfs_rq =
*cfs_rq, struct sched_entity *s
>                  *
>                  * IOW we're enqueueing a task on a new CPU.
>                  */
> -               attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATIO=
N);
> +               attach_entity_load_avg(cfs_rq, se, 0);
>                 update_tg_load_avg(cfs_rq, 0);
> +               decayed =3D 1;
>
> -       } else if (decayed) {
> -               cfs_rq_util_change(cfs_rq, 0);
> +       } else if (decayed && (flags & UPDATE_TG))
> +               update_tg_load_avg(cfs_rq, 0);
>
> -               if (flags & UPDATE_TG)
> -                       update_tg_load_avg(cfs_rq, 0);
> -       }
> +       if (decayed)
> +               cfs_rq_util_change(cfs_rq, 0);
>  }

Forget this ... It's not enough and will continue to generate spurious
call when task is at root domain

>
>
>
> >
