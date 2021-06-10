Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9A3A289A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFJJpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 05:45:00 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45796 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFJJo7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 05:44:59 -0400
Received: by mail-lj1-f176.google.com with SMTP id a19so784754ljq.12
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFMZ6hn0kBDDsWPrF5liecdZCHWos+7s4vNp0cU0WbY=;
        b=nnbRmysLjM19RlYoarApxmIzyRFKTDudbr4x0aDJ/3oPZmwfDLOTi6tcrYVAXic6p8
         QLUckwThgZy43B/xWRvybVeDrFIPDOv+wPR8iDYuDl12STDIi1h/SnJXESCaFCZIxqqf
         koTjxzSqfhWjxKfWI7wk+Xd6v1QywOnFJgBUREU2kZq6qOSsocdU2EzjmvS8N2FcqyEz
         7a94BH6azYi1YWLCj6fqw7p1/FOdYf5bPQ+NuSCHLFXf+svgvm6P3siLi8GD07ng/ftV
         tarwBZJZ0wm5SWK/+sc4jY+cZWb8cZbgAGF1f0j73nwhKfWmq3ZUpBgnXD1BNG47tJx6
         cQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFMZ6hn0kBDDsWPrF5liecdZCHWos+7s4vNp0cU0WbY=;
        b=c8rSEcO56ApiKja+Xcvx+6eas98oNwF4FIbLvj0IKHoC8tRUjbm3RAGLYQjLjzvFSS
         Fw1l1f6DX3rR/ovxt/zwZ3L/gjNGecJD0MePwij3zWKk3q+pY0qho7qHO3kaEgdraDkW
         ifB2Rx+aczAyrKzk7vvbnMTPXme6tDQYTUwPT2JKkda4RoySovg9InbfJAYshcekCZQ9
         lIcfO1d/nnc38DOv82AhpCysOfrygELs3gOhdoTAygT/jCeQwUy1JB6hTWW5XQsFRsmG
         IcEsHyR18jd/ChCurNmX9Wjt4F2xFrSJCgPN9fHxYpcJI4nryhJy+XICDh49YpFhaShU
         GrpA==
X-Gm-Message-State: AOAM5333aRCxAFJd32ZbU17g9ku/Cl1htG3EiIEsC08gRcX0e/8cVH/9
        UJ4ATYeyP3Mp0jgYnhO/xweQghctCxy5+9NeoBACjA==
X-Google-Smtp-Source: ABdhPJwFSXfqZYGxfXQ63mnzlge8gM8A+eCSch5sM4plDBY0DX/qgHy+3OFFLPXofCxHlFLkmbA4FPIq10uiTZSboZU=
X-Received: by 2002:a2e:b5b0:: with SMTP id f16mr1493765ljn.221.1623318106290;
 Thu, 10 Jun 2021 02:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210604080954.13915-1-lukasz.luba@arm.com> <20210604080954.13915-2-lukasz.luba@arm.com>
 <CAKfTPtA0j-hgXC2_LUcbRcWLkLsAB6H_EYewEHJJW+3dVu_hLQ@mail.gmail.com>
 <b01020e5-9f52-87aa-30e3-284e8f86a9df@arm.com> <CAKfTPtCA0svSBp=GG2XjLFqAdNY1FRFmsWNNOVADZf_CVqyORw@mail.gmail.com>
 <8f4156a7-46ca-361d-bcb7-1cbdc860ef37@arm.com>
In-Reply-To: <8f4156a7-46ca-361d-bcb7-1cbdc860ef37@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 11:41:35 +0200
Message-ID: <CAKfTPtACEmidJgzU2JqCSG_D9KNkMicnYiV7+GUL+f6u+2o8Bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Jun 2021 at 11:36, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/10/21 10:11 AM, Vincent Guittot wrote:
> > On Thu, 10 Jun 2021 at 10:42, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 6/10/21 8:59 AM, Vincent Guittot wrote:
> >>> On Fri, 4 Jun 2021 at 10:10, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
> >>>> requests made by the SchedUtil governor to properly estimate energy used
> >>>> in the future. It has to take into account CPUs utilization and forecast
> >>>> Performance Domain (PD) frequency. There is a corner case when the max
> >>>> allowed frequency might be reduced due to thermal. SchedUtil is aware of
> >>>> that reduced frequency, so it should be taken into account also in EAS
> >>>> estimations.
> >>>>
> >>>> SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
> >>>> a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
> >>>> to 'policy::max'. SchedUtil is responsible to respect that upper limit
> >>>> while setting the frequency through CPUFreq drivers. This effective
> >>>> frequency is stored internally in 'sugov_policy::next_freq' and EAS has
> >>>> to predict that value.
> >>>>
> >>>> In the existing code the raw value of arch_scale_cpu_capacity() is used
> >>>> for clamping the returned CPU utilization from effective_cpu_util().
> >>>> This patch fixes issue with too big single CPU utilization, by introducing
> >>>> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
> >>>> capacity reduced by thermal pressure signal. We rely on this load avg
> >>>> geometric series in similar way as other mechanisms in the scheduler.
> >>>>
> >>>> Thanks to knowledge about allowed CPU capacity, we don't get too big value
> >>>> for a single CPU utilization, which is then added to the util sum. The
> >>>> util sum is used as a source of information for estimating whole PD energy.
> >>>> To avoid wrong energy estimation in EAS (due to capped frequency), make
> >>>> sure that the calculation of util sum is aware of allowed CPU capacity.
> >>>>
> >>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>>> ---
> >>>>    kernel/sched/fair.c | 17 ++++++++++++++---
> >>>>    1 file changed, 14 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 161b92aa1c79..1aeddecabc20 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -6527,6 +6527,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >>>>           struct cpumask *pd_mask = perf_domain_span(pd);
> >>>>           unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
> >>>>           unsigned long max_util = 0, sum_util = 0;
> >>>> +       unsigned long _cpu_cap = cpu_cap;
> >>>>           int cpu;
> >>>>
> >>>>           /*
> >>>> @@ -6558,14 +6559,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >>>>                                   cpu_util_next(cpu, p, -1) + task_util_est(p);
> >>>>                   }
> >>>>
> >>>> +               /*
> >>>> +                * Take the thermal pressure from non-idle CPUs. They have
> >>>> +                * most up-to-date information. For idle CPUs thermal pressure
> >>>> +                * signal is not updated so often.
> >>>
> >>> What do you mean by "not updated so often" ? Do you have a value ?
> >>>
> >>> Thermal pressure is updated at the same rate as other PELT values of
> >>> an idle CPU. Why is it a problem there ?
> >>>
> >>
> >>
> >> For idle CPU the value is updated 'remotely' by some other CPU
> >> running nohz_idle_balance(). That goes into
> >> update_blocked_averages() if the flags and checks are OK inside
> >> update_nohz_stats(). Sometimes this is not called
> >> because other_have_blocked() returned false. It can happen for a long
> >
> > So i miss that you were in a loop and the below was called for each
> > cpu and _cpu_cap was overwritten
> >
> > +               if (!idle_cpu(cpu))
> > +                       _cpu_cap = cpu_cap - thermal_load_avg(cpu_rq(cpu));
> >
> > But that also means that if the 1st cpus of the pd are idle, they will
> > use original capacity whereas the other ones will remove the thermal
> > pressure. Isn't this a problem  ?  You don't use the same capacity for
> > all cpus in the performance domain regarding the thermal pressure?
>
> True, but in the experiments for idle CPUs I haven't
> observed that they still have some big util (bigger than _cpu_cap).
> It decayed already, so it's not a problem for idle CPUs.

But it's a problem because there is a random behavior : some idle cpu
will use original capacity whereas others will use the capped value
set by non idle CPUs. You must have consistent behavior across all
idle cpus.

Then, if it's not a problem why adding the if (!idle_cpu(cpu))

>
> Although, it might be my test case which didn't trigger something.
> Is it worth to add the loop above this one, to be 100% sure and
> get a thermal pressure signal from some running CPU?
> Then apply the same value always inside the 2nd loop?
