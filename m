Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5334220D4C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgGOMr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:47:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41348 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgGOMr2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:47:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id y22so2073059oie.8;
        Wed, 15 Jul 2020 05:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wdDNfmxaJDMgzx6KGb0R32bfQn7xefP7F9Z+jm7O8M=;
        b=ErJPE7Y3tXa/QwfTZ8E+hqgzHhBnqeik0/u9v8c2k/hJSZsMGii49ClvmN/ypA/kBC
         LZf1jkIHDdBCftCqO6/DPZ7c0RbRUznkZ1EHz/yx+qeGKpK3E+UWrgy0Qen3ihsF4vpB
         of2Gx9AJ2R1fiNZX0x6zp4m3T3I7QPJ+2TcQ4dFS6Coc2CroJnOedC/ueCHmhAdDpnEF
         KzrRdDg3a/JCSe38u1z8L0DvcZNt7ctxu5ibhuucAxtl8SlANBBGV9cR5YEhCTo0DOi/
         lfYysjgs7Pc6VMhDgMaGq4sH2rBkI3o58VhwzqHYzrD1xsugWObKTuZlI5bUWC9eUMib
         U+AA==
X-Gm-Message-State: AOAM532VzyGKuCZdE6uD8Bkh1N682rX85s9rUDdBSwEsNoc+YJ/uetJH
        r5NOhq0Xo1AguSMcoP/SCTCn4LZyEu97jx6O7P4=
X-Google-Smtp-Source: ABdhPJxewLcMbqQtHFzIXxogNRmQ7yp2yEiyvW8cX3rQxeBkDtYIVHg606iB1KWw9RAdZfYsCuseer30sxq1Sm9KkVg=
X-Received: by 2002:aca:f58a:: with SMTP id t132mr7362035oih.68.1594817247377;
 Wed, 15 Jul 2020 05:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594707424.git.viresh.kumar@linaro.org> <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <CAJZ5v0i=yNH9pGkty2QdeQLcqJcuY=pLx_XcY4VXs8bSqXL=dg@mail.gmail.com> <20200715073225.vnf6dibfca3oc2h4@vireshk-i7>
In-Reply-To: <20200715073225.vnf6dibfca3oc2h4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jul 2020 14:47:16 +0200
Message-ID: <CAJZ5v0j1iaOuASa9K0x3QsWW2mhqoMQyhiVU5eXbNgEN=aU_rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 9:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-07-20, 15:05, Rafael J. Wysocki wrote:
> > On Tue, Jul 14, 2020 at 8:37 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> > >                     int cpu_idx)
> > >  {
> > > -       u32 load;
> > > -       u64 now, now_idle, delta_time, delta_idle;
> > > -       struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> > > -
> > > -       now_idle = get_cpu_idle_time(cpu, &now, 0);
> > > -       delta_idle = now_idle - idle_time->time;
> > > -       delta_time = now - idle_time->timestamp;
> > > +       unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> > > +       unsigned long max = arch_scale_cpu_capacity(cpu);
> > >
> > > -       if (delta_time <= delta_idle)
> > > -               load = 0;
> > > -       else
> > > -               load = div64_u64(100 * (delta_time - delta_idle), delta_time);
> > > -
> > > -       idle_time->time = now_idle;
> > > -       idle_time->timestamp = now;
> > > -
> > > -       return load;
> > > +       util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);
> >
> > Hmm.
> >
> > It doesn't look like cpufreq_cdev and cpu_idx are needed any more in
> > this function, so maybe drop them from the arg list?
>
> Right.
>
> > And then there
> > won't be anything specific to CPU cooling in this function, so maybe
> > move it to sched and export it from there properly?
>
> There isn't a lot happening in this routine right now TBH and am not
> sure if it is really worth it to have a separate routine for this
> (unless we can get rid of something for all the callers, like avoiding
> a call to arch_scale_cpu_capacity() and then naming it
> effective_cpu_load().

Maybe yes.  Or sched_cpu_load() to stand for "the effective CPU load
as seen by the scheduler".

But I'm not sure if percent is the best unit to return from it.  Maybe
make it return something like (util << SCHED_CAPACITY_SHFT) /
arch_scale_cpu_capacity(cpu).

> > Also it looks like max could be passed to it along with the CPU number
> > instead of being always taken as arch_scale_cpu_capacity(cpu).
>
> I am not sure what you are suggesting here. What will be the value of
> max if not arch_scale_cpu_capacity() ?

I was thinking about a value supplied by the caller, eg.
sched_cpu_load(cpu, max), but if all callers would pass
arch_scale_cpu_capacity(cpu) as max anyway, then it's better to simply
call it from there.
