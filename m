Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D2F203232
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFVIhj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFVIhi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 04:37:38 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21798C061794
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 01:37:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so18258777ljb.12
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eXBIJ/ong3y2DHs11bafvAglqmRKvwsWXz4ncOvgbk=;
        b=MyVxAdfQuB3hNhVA6gFQPxOHMVZq4kOoEBR5d6+KvfCryN2lealybR0S635YEMAIb1
         7CZFmBV4O9X4eZXOcbPkmEiodDZvxNhCOL7WBwd6J2Cj3/1b8ZHiWxf3RAU10cL4ibcx
         GbHMLomNSEpu9ejd3MB182JsijA8KDOJSvVUdgJjLz2nAVxl/RIeI6YgcqGWOAnwYJJT
         viXUnrmiCJWl8KHn52/cVCN1oD7n+D/UloNHOitJhWjYp/wwwu2k1gBiVKxW9DHxhhzZ
         GIzmRw7Ry3GeuyRqGCH5rOdvc2R9lNBZeBPcVKaXbXeyiK68BDupWJy+Gt6110i0Vpos
         q/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eXBIJ/ong3y2DHs11bafvAglqmRKvwsWXz4ncOvgbk=;
        b=SADDEKYnYTGJwx5kSZIFhj+nvqY3p754rGr8UklHKHGillDnorgySPtdWkO5eu0Lpw
         2vzJN0jicmol/YfmXXSlHzCqP1oTtSH4P3zYPLe7L+SBIJAFbMwsiL3fIw+o9rnPrX41
         4OzFCZn9ON8QyzA/LjvDWvgGekMaAo01eOrQxiraV9dhp1EtnWqWum961gF1YgkPxFwq
         UJlHAwy3zFsuv9G/a5Il7HxFiaE9sciTbv3j3JgPPA1w441vdsLaPWf6HpdjbmiD+TTl
         h+tVScnkI0Q4A65lamlmRBD+hlswbW55w51fA0crF3uBiq7Gas9oTV3dY1DeMxpiGLCD
         VPSg==
X-Gm-Message-State: AOAM533T9e+DaYcYrNSaoC0V8gPrxgP01bvm/y/A7k/K+Pq8+NtWHpOc
        dl14JUinrisGQM3ayuwQiQ0LyeaQ9YKCkRc2t1Ua2LRNrGM=
X-Google-Smtp-Source: ABdhPJyq2873ShtFN9NjzvHiLg+t0lqwT8VYMxYMqaId//U8qDN7eqNChDblrwuN2XX52zIX4exu3kqPkTH2dU3Dtk0=
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr8528544ljp.226.1592815055424;
 Mon, 22 Jun 2020 01:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200614010755.9129-1-valentin.schneider@arm.com>
 <20200614010755.9129-2-valentin.schneider@arm.com> <CAKfTPtCyi9acak95_2_2uL3Cf0OMAbZhDav2LbPY+ULPrD7z4w@mail.gmail.com>
 <20200620174912.GA18358@arm.com> <jhjmu4xcqyk.mognet@arm.com>
In-Reply-To: <jhjmu4xcqyk.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 22 Jun 2020 10:37:23 +0200
Message-ID: <CAKfTPtDG26Y9s4c+MbdmbxJaiCv6s6WTqmzztcoFsm2SnRL=vQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/cpu-cooling, sched/core: Cleanup thermal
 pressure definition
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 21 Jun 2020 at 00:28, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 20/06/20 18:49, Ionela Voinescu wrote:
> > Hi Vincent,
> >
> > On Thursday 18 Jun 2020 at 17:03:24 (+0200), Vincent Guittot wrote:
> >> On Sun, 14 Jun 2020 at 03:10, Valentin Schneider
> >> <valentin.schneider@arm.com> wrote:
> > [..]
> >> > diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> >> > index e297e135c031..a1efd379b683 100644
> >> > --- a/drivers/thermal/cpufreq_cooling.c
> >> > +++ b/drivers/thermal/cpufreq_cooling.c
> >> > @@ -417,6 +417,11 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> >> >         return 0;
> >> >  }
> >> >
> >> > +__weak void
> >> > +arch_set_thermal_pressure(const struct cpumask *cpus, unsigned long th_pressure)
> >> > +{
> >> > +}
> >>
> >> Having this weak function declared in cpufreq_cooling is weird. This
> >> means that we will have to do so for each one that wants to use it.
> >>
> >> Can't you declare an empty function in a common header file ?
> >
> > Do we expect anyone other than cpufreq_cooling to call
> > arch_set_thermal_pressure()?
> >
> > I'm not against any of the options, either having it here as a week
> > default definition (same as done for arch_set_freq_scale() in cpufreq.c)
> > or in a common header (as done for arch_scale_freq_capacity() in sched.h).
> >
>
> Same thoughts here; I was going for the arch_set_freq_scale() way.
>
> > But for me, Valentin's implementation seems more natural as setters are
> > usually only called from within the framework that does the control
> > (throttling for thermal or frequency setting for cpufreq) and we
> > probably want to think twice if we want to call them from other places.
> >
>
> Well TBH I was tempted to go the other way and keep the definition in
> core.c, given a simple per-cpu value is fairly generic. More precisely, it

Having all definitions in the same place is my main concern here.
If topology.c defines arch_set_thermal_pressure it should also provide
the empty function when the feature is not available or possible
instead of relying of each user of the interface to define a weak
function just in case.

> seems somewhat awkward that architectures have to redefine those interfaces
> when, given what cpufreq_cooling is doing, they'll have to go for per-cpu
> storage in some way or another.
>
> I ultimately decided against it, seeing as it isn't too difficult to come
> up with other drivers of thermal pressure. There was that TDP-bound thing
> [1], where IIUC you could end up with throttling not because of thermal but
> because of power constraints. And then there's always FW that can cap stuff
> as a last resort, and some architectures will want to inform the scheduler
> of that when/if they'll be able to query FW for that.
>
> [1]: 20200428032258.2518-1-currojerez@riseup.net
>
> > Thanks,
> > Ionela.
