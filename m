Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2172A09AB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 16:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgJ3PXg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 11:23:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33213 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgJ3PXf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 11:23:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id s21so7049537oij.0;
        Fri, 30 Oct 2020 08:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wasqnwYz4GmqPxfDBbw9YaJh5CbiEJhSDwPHe9OxKVc=;
        b=BUSxEySNEopaYr8fKLn/0gpNqVCPWgisoVww1TBJ52zuT80vk0Ad4rZQ4FMO2CsyKj
         boXdFoTjUzigZlEfBYj16de9hRmrt59zvc5e3dwSPoNffQpWQJJDrsCfYuyyFbvIok7a
         CcT3M6uqQm3yk+K2mijvxTh+wheze32kOnr+S0//kEbv+e/k0i+VpL1dPxQxrOmB68KI
         VvkYNP8z3gMOoFJtoiGJwg9PUqL2AHUqrO7Dgl2Be2h9m0+/jQU7vl2X9iNefTc+V3WG
         V6qYKPJktthMmeKOO+K6mq/oGl2Q6bprySmxBjhK0KeHyDfloZ1wgEDNT8bIP2/WK/Gd
         ocMQ==
X-Gm-Message-State: AOAM530wUPnavR1Zz6iB2LRa9lIi0bweSsBkknmFb/xFnnTqF9eQ77Xu
        E9B/tuKoiY7jKl64Lr6BRCgCVo2NmMIhdgZY8b0=
X-Google-Smtp-Source: ABdhPJyM5/SucttxKsd1wqznBg3ep4n3Wy5//PMGi/CLLJ3R8UPOOzjY0fw4iXERuk9fP4fZF+WSYrOk9O3W5uhHbvE=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr2001006oiw.69.1604071414328;
 Fri, 30 Oct 2020 08:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <2954009.kBar6x9KXa@kreacher> <207ae817a778d79a99c30cb48f2ea1f527416519.1604042421.git.viresh.kumar@linaro.org>
 <CAJZ5v0j2uoaUdSr1-OonPkR6QapjOm4RE2Ya=LBpV1KDrLF3gw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j2uoaUdSr1-OonPkR6QapjOm4RE2Ya=LBpV1KDrLF3gw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 16:23:23 +0100
Message-ID: <CAJZ5v0gURd-dcAWj0KdmodM3MfU_DQ_HEiX-CCcd+fHpRikSyA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't skip freq update if
 need_freq_update is set
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        zhuguangqing <zhuguangqing@xiaomi.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 30, 2020 at 4:07 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 30, 2020 at 8:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > The cpufreq policy's frequency limits (min/max) can get changed at any
> > point of time, while schedutil is trying to update the next frequency.
> > Though the schedutil governor has necessary locking and support in place
> > to make sure we don't miss any of those updates, there is a corner case
> > where the governor will find that the CPU is already running at the
> > desired frequency and so may skip an update.
> >
> > For example, consider that the CPU can run at 1 GHz, 1.2 GHz and 1.4 GHz
> > and is running at 1 GHz currently. Schedutil tries to update the
> > frequency to 1.2 GHz, during this time the policy limits get changed as
> > policy->min = 1.4 GHz. As schedutil (and cpufreq core) does clamp the
> > frequency at various instances, we will eventually set the frequency to
> > 1.4 GHz, while we will save 1.2 GHz in sg_policy->next_freq.
> >
> > Now lets say the policy limits get changed back at this time with
> > policy->min as 1 GHz. The next time schedutil is invoked by the
> > scheduler, we will reevaluate the next frequency (because
> > need_freq_update will get set due to limits change event) and lets say
> > we want to set the frequency to 1.2 GHz again. At this point
> > sugov_update_next_freq() will find the next_freq == current_freq and
> > will abort the update, while the CPU actually runs at 1.4 GHz.
> >
> > Until now need_freq_update was used as a flag to indicate that the
> > policy's frequency limits have changed, and that we should consider the
> > new limits while reevaluating the next frequency.
> >
> > This patch fixes the above mentioned issue by extending the purpose of
> > the need_freq_update flag. If this flag is set now, the schedutil
> > governor will not try to abort a frequency change even if next_freq ==
> > current_freq.
> >
> > As similar behavior is required in the case of
> > CPUFREQ_NEED_UPDATE_LIMITS flag as well, need_freq_update will never be
> > set to false if that flag is set for the driver.
> >
> > We also don't need to consider the need_freq_update flag in
> > sugov_update_single() anymore to handle the special case of busy CPU, as
> > we won't abort a frequency update anymore.
> >
> > Reported-by: zhuguangqing <zhuguangqing@xiaomi.com>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks for following my suggestion!
>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index c03a5775d019..c6861be02c86 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -102,9 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >  static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
> >                                    unsigned int next_freq)
> >  {
> > -       if (sg_policy->next_freq == next_freq &&
> > -           !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> > -               return false;
> > +       if (!sg_policy->need_freq_update) {
> > +               if (sg_policy->next_freq == next_freq)
> > +                       return false;
> > +       } else if (!cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS)) {
> > +               sg_policy->need_freq_update = false;

One nit, though.

This can be changed into

} else {
      sg_policy->need_freq_update =
cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
}

to save a branch and because need_freq_update is there in the cache
already, this should be a fast update.

So I'm going to make this change while applying the patch.

> > +       }
> >
> >         sg_policy->next_freq = next_freq;
> >         sg_policy->last_freq_update_time = time;
> > @@ -162,11 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >
> >         freq = map_util_freq(util, freq, max);
> >
> > -       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update &&
> > -           !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
> > +       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> >                 return sg_policy->next_freq;
> >
> > -       sg_policy->need_freq_update = false;
> >         sg_policy->cached_raw_freq = freq;
> >         return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> > @@ -442,7 +443,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> >         unsigned long util, max;
> >         unsigned int next_f;
> > -       bool busy;
> >         unsigned int cached_freq = sg_policy->cached_raw_freq;
> >
> >         sugov_iowait_boost(sg_cpu, time, flags);
> > @@ -453,9 +453,6 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >         if (!sugov_should_update_freq(sg_policy, time))
> >                 return;
> >
> > -       /* Limits may have changed, don't skip frequency update */
> > -       busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
> > -
> >         util = sugov_get_util(sg_cpu);
> >         max = sg_cpu->max;
> >         util = sugov_iowait_apply(sg_cpu, time, util, max);
> > @@ -464,7 +461,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >          * Do not reduce the frequency if the CPU has not been idle
> >          * recently, as the reduction is likely to be premature then.
> >          */
> > -       if (busy && next_f < sg_policy->next_freq) {
> > +       if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> >                 next_f = sg_policy->next_freq;
> >
> >                 /* Restore cached freq as next_freq has changed */
> > @@ -829,9 +826,10 @@ static int sugov_start(struct cpufreq_policy *policy)
> >         sg_policy->next_freq                    = 0;
> >         sg_policy->work_in_progress             = false;
> >         sg_policy->limits_changed               = false;
> > -       sg_policy->need_freq_update             = false;
> >         sg_policy->cached_raw_freq              = 0;
> >
> > +       sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > +
> >         for_each_cpu(cpu, policy->cpus) {
> >                 struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
> >
> > --
>
> I'll queue it up for -rc3 next week, thanks!
