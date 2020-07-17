Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4571A2238A3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGQJq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 05:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 05:46:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557FDC061755
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 02:46:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so11927480ljl.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2020 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7jqqiBnn0EOR7Uz6m1vSHmx7Jr6H9WscOd+TJEXNhvY=;
        b=YBxxuNKX9oEaG5Bgad9mGmnuiidocTB75FBw77Hzs4cty2jsmwzWdJGfad4164O2FP
         NXGBGN/KAcPaI9Sp9o4zgR4+69Et7zQrfCxGnxnD6kc2+Un6IGIVzCNvG8TnzUbE2gQU
         g4NE59gvC7E6b//9N4Yy9y3gAXU1vpDET/4qojLbUXjivfnf/gvIf/kHCKJ61tJ2ucmr
         TiOf1bhI1M4P3A0s7mzvH6tsXhm2yQh2U5NDPKWU8T3n+aUr37BlsD20UoltmT2d8vkj
         RGfqhe4uUPa8DARhSJPFMEbZ4J7JN1VTslCm8t2sYSBD+ihL6l8G7NyonFkdH+kcUVNz
         eW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7jqqiBnn0EOR7Uz6m1vSHmx7Jr6H9WscOd+TJEXNhvY=;
        b=nWcd/CK3vZ5th2zWvZcMXkczbtDUjEa5gQ4Wqp6aHQjikvdDSEeMzc8qzeDoGqN9Ei
         0YNfFjx0mAdKYHEM76AUzx1TScYcfP3DFgh7M2o93yLmUXBqeF77m2S4tsB99Vdun/gu
         Fu3d4hVwtYD3lAflsQEbmAb22lZO9fZxtoB86KsxBJDWsmnflJdCNgl//hsfICdSqMAO
         g8OLsaTkQBTwR9nBeE5/HOuYecRLVoon6NsWkbt7gnpfkio0zibFUhSeuo6uD98nWlk5
         2zg+tgMTiHwivZBfQPt5Je4VIzA17xH5BaYJvNV/4n2SroLXetKbcgtoO36gBrT0Af4Z
         X8rw==
X-Gm-Message-State: AOAM531CC2vXN6QlXHHpSX0s14ILj54S6RiVIaLSyyj9zrK+eCvuQUF3
        fYKQ4FAmYFdtm0lkNn9QhTnkKmZJxfGoeZopfd8bcg==
X-Google-Smtp-Source: ABdhPJznGLiAyjz45x44DOpY2IA2pnD7XITqMyYoEtmK35LE84M7UK3IgrdS+Mo4kip6/ULVtTCVuHd0kNoTLO4eEtY=
X-Received: by 2002:a2e:80c9:: with SMTP id r9mr4269550ljg.69.1594979184517;
 Fri, 17 Jul 2020 02:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594707424.git.viresh.kumar@linaro.org> <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net> <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
In-Reply-To: <681fb3e8-d645-2558-38de-b39b372499de@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jul 2020 11:46:12 +0200
Message-ID: <CAKfTPtA+BPegK2h6PQMFs+p4dpxO+sk1FDQuOfJvSpGCJ-rBrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 16 Jul 2020 at 16:24, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Peter,
>
> Thank you for summarizing this. I've put my comments below.
>
> On 7/16/20 12:56 PM, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2020 at 12:06:53PM +0530, Viresh Kumar wrote:
> >>   /**
> >> + * get_load() - get current load for a cpu
> >>    * @cpufreq_cdev:  &struct cpufreq_cooling_device for this cpu
> >>    * @cpu:   cpu number
> >> + * @cpu_idx:        index of the cpu
> >>    *
> >> + * Return: The current load of cpu @cpu in percentage.
> >>    */
> >>   static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> >>                  int cpu_idx)
> >>   {
> >> +    unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> >> +    unsigned long max = arch_scale_cpu_capacity(cpu);
> >>
> >> +    util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);
> >> +    return (util * 100) / max;
> >>   }
> >
> > So there's a number of things... let me recap a bunch of things that
> > got mentioned on IRC earlier this week and then continue from there..
> >
> > So IPA* (or any other thermal governor) needs energy estimates for the
> > various managed devices, cpufreq_cooling, being the driver for the CPU
> > device, needs to provide that and in return receives feedback on how
> > much energy it is allowed to consume, cpufreq_cooling then dynamically
> > enables/disables OPP states.
>
> Currently, only IPA uses the power estimation, other governors don't
> use these API functions in cpufreq_cooling.
>
> >
> > There are actually two methods the thermal governor will use:
> > get_real_power() and get_requested_power().
> >
> > The first isn't used anywhere in mainline, but could be implemented on
> > hardware that has energy counters (like say x86 RAPL).
>
> The first is only present as callback for registered devfreq cooling,
> which is registered by devfreq driver. If that driver provides the
> get_real_power(), it will be called from get_requested_power().
> Thus, it's likely that IPA would get real power value from HW.
>
> I was planning to add it also to cpufreq_cooling callbacks years
> ago...
>
> >
> > The second attempts to guesstimate power, and is the subject of this
> > patch.
> >
> > Currently cpufreq_cooling appears to estimate the CPU energy usage by
> > calculating the percentage of idle time using the per-cpu cpustat stuff,
> > which is pretty horrific.
>
> Even worse, it then *samples* the *current* CPU frequency at that
> particular point in time and assumes that when the CPU wasn't idle
> during that period - it had *this* frequency...

So there is 2 problems in the power calculation of cpufreq cooling device :
- How to get an accurate utilization level of the cpu which is what
this patch is trying to fix because using idle time is just wrong
whereas scheduler utilization is frequency invariant
- How to get power estimate from this utilization level. And as you
pointed out, using the current freq which is not accurate.

>
> >
> > This patch then attempts to improve upon that by using the scheduler's
> > cpu_util(ENERGY_UTIL) estimate, which is also used to select OPP state
> > and improves upon avg idle. This should be a big improvement as higher
>
> IMHO this patch set doesn't address the real problem: 'sampling
> freq problem' described above. There was no issue with getting idle
> period. The avg freq was the problem, in that period when the

Not sure that you can say that avg freq is a bigger problem than
getting the load because there is a real issue with tracking idle
period for estimating load because running slower reduces the idle
time and increases artificially the load. That's why we implemented
frequency invariance in PELT.

At the opposite when the thermal mitigation happens, the frequency
will be most probably capped by cpu cooling device and will most
probably stay at the capped value

> CPUs were running. The model implemented in alg was also a problem.
>
> The whole period (e.g. CPU freqs which were used or idle state)
>
> ^(CPU freq)
> |
> |                            sampling the current freq
> |                _______        |
> |               |      |        |
> |________       |      |        |
> |       |       |      |        |
> |       | idle  |      |________v________...
> |_ _____|_______|__________________________> (time)
>    start of period               end
>    |<------- (typically 100ms)-->|
>
>
>
> > frequency consumes more energy, but should we not also consider that:
> >
> >       E = C V^2 f
> >
> > The EAS energy model has tables for the OPPs that contain this, but in
> > this case we seem to be assuming a linear enery/frequency curve, which
> > is just not the case.
>
> I am not sure if I got your point. To understand your point better
> I think some drawing would be required. I will skip this patch
> and old mainline code and focus on your proposed solution
> (because this patch set does not address 'sampling freq problem').
>
> >
> > I suppose we could do something like **:
> >
> >       100 * util^3 / max^3
> >
> > which assumes V~f.
>
> In EM we keep power values in the array and these values grow
> exponentially. Each OPP has it corresponding
>
> P_x = C (V_x)^2 f_x    , where x is the OPP id thus corresponding V,f
>
> so we have discrete power values, growing like:
>
> ^(power)
> |
> |
> |                          *
> |
> |
> |                       *
> |                       |
> |                   *   |
> |                       | <----- power estimation function
> |            *          |        should not use linear 'util/max_util'
> |   *                   |        relation here *
> |_______________________|_____________> (freq)
>     opp0     opp1  opp2 opp3 opp4
>
> What is the problem
> First:
> We need to pick the right Power from the array. I would suggest
> to pick the max allowed frequency for that whole period, because
> we don't know if the CPUs were using it (it's likely).
> Second:
> Then we have the utilization, which can be considered as:
> 'idle period & running period with various freq inside', lets
> call it avg performance in that whole period.
> Third:
> Try to estimate the power used in that whole period having
> the avg performance and max performance.

We already have a function that is doing such kind of computation
based of the utilization of the CPU : em_pd_energy(). And we could
reuse some of this function if not exactly this one

>
> What you are suggesting is to travel that [*] line in
> non-linear fashion, but in (util^3)/(max_util^3). Which means
> it goes down faster when the utilization drops.
> I think it is too aggressive, e.g.
> 500^3 / 1024^3 = 0.116  <--- very little, ~12%
> 200^3 / 300^3  = 0.296
>
> Peter could you confirm if I understood you correct?
> This is quite important bit for me.
>
> >
> > Another point is that cpu_util() vs turbo is a bit iffy, and to that,
> > things like x86-APERF/MPERF and ARM-AMU got mentioned. Those might also
> > have the benefit of giving you values that match your own sampling
> > interval (100ms), where the sched stuff is PELT (64,32.. based).
> >
> > So what I've been thinking is that cpufreq drivers ought to be able to
> > supply this method, and only when they lack, can the cpufreq-governor
> > (schedutil) install a fallback. And then cpufreq-cooling can use
> > whatever is provided (through the cpufreq interfaces).
> >
> > That way, we:
> >
> >   1) don't have to export anything
> >   2) get arch drivers to provide something 'better'
> >
> >
> > Does that sounds like something sensible?
> >
>
> Yes, make sense. Please also keep in mind that this
> utilization somehow must be mapped into power in a proper way.
> I am currently working on addressing all of these problems
> (including this correlation).
>
> Thank you for your time spending on it and your suggestions.
>
> Regards,
> Lukasz
>
> >
> >
> >
> > [*] I always want a beer when I see that name :-)
> >
> > [**] I despise code that uses percentages, computers suck at
> > /100 and there is no reason not to use any other random fraction, so why
> > pick a bad one.
> >
