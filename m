Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73AE29EA55
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 12:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJ2LRU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 07:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2LRT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 07:17:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69497C0613CF;
        Thu, 29 Oct 2020 04:17:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o129so2079623pfb.1;
        Thu, 29 Oct 2020 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=bvbU6Ows4Lpdv0MfoVVQxKi2gfZNl+WGx7TLiEmQYfY=;
        b=AWNMMv8nSzIsssZ7zYWKEvcFPFkFDQ/0gFNfyx7MnSTDQN9Ps3owgS2GhtkxT6rKBl
         4pNVRKILIbpZazcCJQ3isQpsd/CaBQxSU6/L0dOsPO3OXkWu8usZ5z4PoI835VVo5wYK
         PPhl1sC2GYjnIyCSfwJNndVoBCr0cVfGZ/a35Dtst6eFq5UCC2A2ngXTgPgs1jctA90e
         tdVdVbFaX8oNYjw0Y3FVjxc3Us88OvHSvkZsDLCWgmpbk2xDPo+hXC3BS7wYPONpMEXy
         KRKNnRTjY/+wMzF/6CgjA3e7ydua91vmkWH/vnbBPFi6pIu21PpT73DZkI+EU3KrkoHG
         uX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=bvbU6Ows4Lpdv0MfoVVQxKi2gfZNl+WGx7TLiEmQYfY=;
        b=MPD0tR1hx9Iw7fGYB47iH4lizod4aR+4WbI3QtbChTnGcyTdvP0dHlDr968anUyIUQ
         y7Nf7fbdFr/G/679sIOZS5z64tthCprZdDRvxwdGJ+5w+Pdtd5eTZydOYpFQ4zFIss7M
         uDtZq16C1Rk7MKJ7O4cTmlaDt92Z4Bagim+/zHu/v6gV/UOeEZ1BZchj5e7sfsw1qeDz
         hovwED0JpTsVUS2jJa6Y1/mi9k0uo+ZTgO5Sag9ioFrFjxp9I6MOSBIcid6wBaMe50US
         v6lelYgnDkSyKf6YcEr1+huJJvCGJgrAAyRgFxo16kcy8WE8V8myKrU20Xq/jg8fM5Ps
         nFpQ==
X-Gm-Message-State: AOAM53387l6IYDGU9esbSxKjSl9NJ1aoDz9qszP8aL+/vICsSlyDKI5W
        xl13FIsU7lEGn3JtTAMNhr8=
X-Google-Smtp-Source: ABdhPJxc8ucWCWPZK3BGP3Y51CWN/aiabNVZJxwJZO9EhcFolgYz/3U/OKQBtpy9t1iQPMNxPIbwsw==
X-Received: by 2002:a17:90a:fe8:: with SMTP id 95mr3714004pjz.73.1603970238965;
        Thu, 29 Oct 2020 04:17:18 -0700 (PDT)
Received: from DESKTOPIUKEMQD ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id b24sm2192450pge.59.2020.10.29.04.17.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 04:17:18 -0700 (PDT)
From:   "zhuguangqing83" <zhuguangqing83@gmail.com>
To:     "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc:     <rjw@rjwysocki.net>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'zhuguangqing'" <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] cpufreq: schedutil: set sg_policy->next_freq to the final cpufreq
Date:   Thu, 29 Oct 2020 19:17:11 +0800
Message-ID: <004001d6ade5$0f8dde00$2ea99a00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: Adat5JyEmiSqpB6FQymtPuWqEtgQKw==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/2020 15:19=A3=ACViresh Kumar<viresh.kumar@linaro.org> =
wrote=A3=BA
> Your mail client is screwing the "In-reply-to" field of the message
> and that prevents it to appear properly in the thread in mailboxes of
> other people, please fix that.
>=20

I will try to fix that.

> On 29-10-20, 09:43, zhuguangqing83 wrote:
> > > diff --git a/kernel/sched/cpufreq_schedutil.c =
b/kernel/sched/cpufreq_schedutil.c
> > > index 0c5c61a095f6..bf7800e853d3 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -105,7 +105,6 @@ static bool sugov_update_next_freq(struct =
sugov_policy *sg_policy, u64 time,
> > >         if (sg_policy->next_freq =3D=3D next_freq)
> > >                 return false;
> > >
> > > -       sg_policy->next_freq =3D next_freq;
> > >         sg_policy->last_freq_update_time =3D time;
> > >
> > >         return true;
> >
> > It's a little strange that sg_policy->next_freq and
> > sg_policy->last_freq_update_time are not updated at the same time.
> >
> > > @@ -115,7 +114,7 @@ static void sugov_fast_switch(struct =
sugov_policy *sg_policy, u64 time,
> > >                               unsigned int next_freq)
> > >  {
> > >         if (sugov_update_next_freq(sg_policy, time, next_freq))
> > > -               cpufreq_driver_fast_switch(sg_policy->policy, =
next_freq);
> > > +               sg_policy->next_freq =3D =
cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
> > >  }
> > >
> >
> > Great, it also takes into account the issue that 0 is returned by =
the
> > driver's ->fast_switch() callback to indicate an error condition.
>=20
> Yes but even my change wasn't good enough, more on it later.
>=20
> > For policy->min/max may be not the real CPU frequency in OPPs, so
>=20
> No, that can't happen. If userspace tries to set a value too large or
> too small, we clamp that too to policy->max/min and so the below
> problem shall never occur.
>=20
> > next_freq got from get_next_freq() which is after clamping between
> > policy->min and policy->max may be not the real CPU frequency in =
OPPs.
> > In that case, if we use a real CPU frequency in OPPs returned from
> > cpufreq_driver_fast_switch() to compare with next_freq,
> > "if (sg_policy->next_freq =3D=3D next_freq)" will never be =
satisfied, so we
> > change the CPU frequency every time schedutil callback gets called =
from
> > the scheduler. I see the current code in get_next_freq() as =
following,
> > the issue mentioned above should not happen. Maybe it's just one of =
my
> > unnecessary worries.
>=20
> Coming back to my patch (and yours too), it only fixes the fast-switch
> case and not the slow path which can also end up clamping the
> frequency. And to be honest, even the drivers can have their own
> clamping code in place, no one is stopping them too.
>=20
> And we also need to do something about the cached_raw_freq as well, as
> it will not be in sync with next_freq anymore.
>=20
> Here is another attempt from me tackling this problem. The idea is to
> check if the previous freq update went as expected or not. And if not,
> we can't rely on next_freq or cached_raw_freq anymore. For this to
> work properly, we need to make sure policy->cur isn't getting updated
> at the same time when get_next_freq() is running. For that I have
> given a different meaning to work_in_progress flag, which now creates
> a lockless (kind of) critical section where we won't play with
> next_freq while the cpufreq core is updating the frequency.
>=20

I think your patch is ok for tackling this problem.

> diff --git a/kernel/sched/cpufreq_schedutil.c =
b/kernel/sched/cpufreq_schedutil.c
> index 0c5c61a095f6..8991cc31b011 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -121,13 +121,8 @@ static void sugov_fast_switch(struct sugov_policy =
*sg_policy, u64 time,
>  static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 =
time,
>                                   unsigned int next_freq)
>  {
> -       if (!sugov_update_next_freq(sg_policy, time, next_freq))
> -               return;
> -
> -       if (!sg_policy->work_in_progress) {
> -               sg_policy->work_in_progress =3D true;
> +       if (sugov_update_next_freq(sg_policy, time, next_freq))
>                 irq_work_queue(&sg_policy->irq_work);
> -       }
>  }
>=20
>  /**
> @@ -159,6 +154,15 @@ static unsigned int get_next_freq(struct =
sugov_policy *sg_policy,
>         unsigned int freq =3D arch_scale_freq_invariant() ?
>                                 policy->cpuinfo.max_freq : =
policy->cur;
>=20
> +       /*
> +        * The previous frequency update didn't go as we expected it =
to be. Lets
> +        * start again to make sure we don't miss any updates.
> +        */
> +       if (unlikely(policy->cur !=3D sg_policy->next_freq)) {
> +               sg_policy->next_freq =3D 0;
> +               sg_policy->cached_raw_freq =3D 0;
> +       }
> +
>         freq =3D map_util_freq(util, freq, max);
>=20
>         if (freq =3D=3D sg_policy->cached_raw_freq && =
!sg_policy->need_freq_update)
> @@ -337,8 +341,14 @@ static void sugov_update_single(struct =
update_util_data *hook, u64 time,
>=20
>         ignore_dl_rate_limit(sg_cpu, sg_policy);
>=20
> +       if (!sg_policy->policy->fast_switch_enabled) {
> +               raw_spin_lock(&sg_policy->update_lock);
> +               if (sg_policy->work_in_progress)
> +                       goto unlock;
> +       }
> +

Maybe it's better to bring the following code before the code above.
         if (!sugov_should_update_freq(sg_policy, time))
               return;

>         if (!sugov_should_update_freq(sg_policy, time))
> -               return;
> +               goto unlock;
>=20
>         /* Limits may have changed, don't skip frequency update */
>         busy =3D !sg_policy->need_freq_update && =
sugov_cpu_is_busy(sg_cpu);
> @@ -363,13 +373,14 @@ static void sugov_update_single(struct =
update_util_data *hook, u64 time,
>          * concurrently on two different CPUs for the same target and =
it is not
>          * necessary to acquire the lock in the fast switch case.
>          */
> -       if (sg_policy->policy->fast_switch_enabled) {
> +       if (sg_policy->policy->fast_switch_enabled)
>                 sugov_fast_switch(sg_policy, time, next_f);
> -       } else {
> -               raw_spin_lock(&sg_policy->update_lock);
> +       else
>                 sugov_deferred_update(sg_policy, time, next_f);
> +
> +unlock:
> +       if (!sg_policy->policy->fast_switch_enabled)
>                 raw_spin_unlock(&sg_policy->update_lock);
> -       }
>  }
>=20
>  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, =
u64 time)
> @@ -405,6 +416,9 @@ sugov_update_shared(struct update_util_data *hook, =
u64 time, unsigned int flags)
>=20
>         raw_spin_lock(&sg_policy->update_lock);
>=20
> +       if (sg_policy->work_in_progress)
> +               goto unlock;
> +
>         sugov_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update =3D time;
>=20
> @@ -419,33 +433,30 @@ sugov_update_shared(struct update_util_data =
*hook, u64 time, unsigned int flags)
>                         sugov_deferred_update(sg_policy, time, =
next_f);
>         }
>=20
> +unlock:
>         raw_spin_unlock(&sg_policy->update_lock);
>  }
>=20
>  static void sugov_work(struct kthread_work *work)
>  {
>         struct sugov_policy *sg_policy =3D container_of(work, struct =
sugov_policy, work);
> -       unsigned int freq;
>         unsigned long flags;
>=20
>         /*
> -        * Hold sg_policy->update_lock shortly to handle the case =
where:
> -        * incase sg_policy->next_freq is read here, and then updated =
by
> -        * sugov_deferred_update() just before work_in_progress is set =
to false
> -        * here, we may miss queueing the new update.
> -        *
> -        * Note: If a work was queued after the update_lock is =
released,
> -        * sugov_work() will just be called again by kthread_work =
code; and the
> -        * request will be proceed before the sugov thread sleeps.
> +        * Prevent the schedutil hook to run in parallel while we are =
updating
> +        * the frequency here and accessing next_freq.
>          */
>         raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> -       freq =3D sg_policy->next_freq;
> -       sg_policy->work_in_progress =3D false;
> +       sg_policy->work_in_progress =3D true;
>         raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
>=20
>         mutex_lock(&sg_policy->work_lock);
> -       __cpufreq_driver_target(sg_policy->policy, freq, =
CPUFREQ_RELATION_L);
> +       __cpufreq_driver_target(sg_policy->policy, =
sg_policy->next_freq, CPUFREQ_RELATION_L);
>         mutex_unlock(&sg_policy->work_lock);
> +
> +       raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
> +       sg_policy->work_in_progress =3D false;
> +       raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
>  }
>=20
>  static void sugov_irq_work(struct irq_work *irq_work)
>=20
> --
> viresh

