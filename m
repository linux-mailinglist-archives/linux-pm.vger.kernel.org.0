Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB7349AAB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 20:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCYTvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 15:51:33 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39828 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhCYTvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 15:51:05 -0400
Received: by mail-ot1-f45.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so3116950ote.6;
        Thu, 25 Mar 2021 12:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcBD+yV296KejJumcNog1gY0dMH71GzRffk+94rnKhA=;
        b=gExrAyv1RcyptcNeVJgTPr4BDo+YZGen0fMUbkWdPcU7nrt0VKOD32aTNrgwU4zoIO
         3NQYVMGWNCYfYbni51XmHoh6S8pIvp6YyT6gSqGGQkmvqiHEHcOYOZdmLLzMmsljpxaU
         VcrktFsJEHSk8hhLOrplBSlIPsdPzRFvyTISxBVRx5dJkMMuWOoTAfsmJCFIPY7uWOLI
         yVPSv0hA+hwv90Yw/529X7IywQjVVa2l9XjAznopF6CnD8y8mBO6x+kKpi3LUuHnPuVU
         FPeWkFqr7OeBYr+bNZsYXv1kyDmJYkKBtmqvJhbTfyEAH0KRLLX5nYqNQEafVK9N8e6V
         jAFQ==
X-Gm-Message-State: AOAM532i1g2SgHNgXgm4mg3KHegwuT/23JrTspHKw7qlweMc8NK2mC+g
        MUWdV94CV8k0nsw90uyacfHsWZ5jbF382viw2p4=
X-Google-Smtp-Source: ABdhPJy2F3aKMX/jQtTbjZ0DPU13F0IGt77twoi7kIOQwSUOE7hvcufQqnODQ0HtPmc1jQnrZhFqMpC2Vhviqr8hzrE=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr9328124otf.206.1616701865328;
 Thu, 25 Mar 2021 12:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210311123708.23501-1-frederic@kernel.org> <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
 <20210325131400.GA938586@lothringen> <5712356.lOV4Wx5bFT@kreacher> <YTBPR01MB326253A7B094A2F603488EA8C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YTBPR01MB326253A7B094A2F603488EA8C4629@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Mar 2021 20:50:54 +0100
Message-ID: <CAJZ5v0h2BZdj4ds1NUKUcdJ_WCZe-0EogE1k5qbJkoEGFkjJyw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19ubw==?=
        =?UTF-8?B?aHpfZ2V0X3NsZWVwX2xlbmd0aCgpIGZyb20gcmV0dXJuaW5nIG5lZ2F0aXZlIHZhbHVl?=
To:     "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 25, 2021 at 8:18 PM Zhou Ti (x2019cwm) <x2019cwm@stfx.ca> wrote:
>
> On March 25, 2021 14:56, Rafael J. Wysocki wrote:
> > On Thursday, March 25, 2021 2:14:00 PM CET Frederic Weisbecker wrote:
> > > On Tue, Mar 16, 2021 at 04:08:08PM +0000, Zhou Ti (x2019cwm) wrote:
> > > > But I don't think it's a good idea to handle this in callers, because logically the function shouldn't return negative values. Returning 0 directly would allow idle governors to get another chance to select again.
> > >
> > > Hmm, I'm going to leave the last word to Rafael since cpuidle are the only
> > > callers of this. In any case we need to fix it.
> >
> > Yes, we do.
> >
> > So I said that I preferred to address this in the callers and the reason why
> > is because, for example, for the teo governor it would be a matter of using
> > a different data type to store the tick_nohz_get_sleep_length() return value,
> > like in the (untested) patch below.
> >
> > So at least in this case there is no need to add any new branches anywhere.
> >
> > I'm still not sure about menu, because it is more complicated, but even if
> > that one needs an extra branch, that is a win already.
>
> I would like to point out the potential trouble that fixing this issue in the
> callers could cause.
>
> 1. This function is called multiple times in menu governor and TEO
> governor.

What do you mean by "multiple times"?

Each of the governors calls it once per cycle and its previous return
value is not used in the next cycle at least in teo.

> I'm not sure that receiving results using signed integers is enough
> to solve all the problems, in the worst case it may require increasing
> the logical complexity of the code.

That is a valid concern, so it is a tradeoff between increasing the
logical complexity of the code and adding branches to it.

> 2. This function is important for developing idle governor.
> If the problem is not fixed in the function itself, then this potential
> pitfall should be explicitly stated in the documentation.

That I can agree with.

> This is because
> it is difficult to predict from the definition and naming of the function
> that it might return a negative number. I actually discovered this anomaly
> when I was doing data analysis on my own idle governor. For some idle control
> algorithms, this exception return could lead to serious consequences,
> because negative return logically won't happen.

Well, it's a matter of how to take the possible negative return value
into account so it does not affect the result of the computations.

> >
> > ---
> >  drivers/cpuidle/governors/teo.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/cpuidle/governors/teo.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> > +++ linux-pm/drivers/cpuidle/governors/teo.c
> > @@ -100,8 +100,8 @@ struct teo_idle_state {
> >   * @intervals: Saved idle duration values.
> >   */
> >  struct teo_cpu {
> > -       u64 time_span_ns;
> > -       u64 sleep_length_ns;
> > +       s64 time_span_ns;
> > +       s64 sleep_length_ns;
> >         struct teo_idle_state states[CPUIDLE_STATE_MAX];
> >         int interval_idx;
> >         u64 intervals[INTERVALS];
> > @@ -216,7 +216,7 @@ static bool teo_time_ok(u64 interval_ns)
> >   */
> >  static int teo_find_shallower_state(struct cpuidle_driver *drv,
> >                                     struct cpuidle_device *dev, int state_idx,
> > -                                   u64 duration_ns)
> > +                                   s64 duration_ns)
> >  {
> >         int i;
> >
> > @@ -242,7 +242,7 @@ static int teo_select(struct cpuidle_dri
> >  {
> >         struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> >         s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
> > -       u64 duration_ns;
> > +       s64 duration_ns;
> >         unsigned int hits, misses, early_hits;
> >         int max_early_idx, prev_max_early_idx, constraint_idx, idx, i;
> >         ktime_t delta_tick;
>
