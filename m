Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B5131AED6
	for <lists+linux-pm@lfdr.de>; Sun, 14 Feb 2021 04:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhBNDr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 22:47:57 -0500
Received: from m12-12.163.com ([220.181.12.12]:47386 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhBNDr4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Feb 2021 22:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=lNfbV
        ZTdet/lcahFeCJkx81wDcQVlnZNpxzAgSEZWVU=; b=PQtJ+68Rq4iFQNRSNLtOb
        215u8cmKWE6bDPKIbeImsTKt7jqsRhZNQPWz6Pxt2a142RA7UdjeE9WNxLtBb8CX
        WSxfP7ufeZkys7VTPzEr8vSxMGomkKD9UhqT7344/epF0WQI0evq7wGIOe90IY0H
        Gsxxqi33/f+QO44Ntpt9SY=
Received: from localhost (unknown [183.209.57.125])
        by smtp8 (Coremail) with SMTP id DMCowACnOqiwnChguoVIQg--.56726S2;
        Sun, 14 Feb 2021 11:44:52 +0800 (CST)
Date:   Sun, 14 Feb 2021 11:44:43 +0800
From:   Yue Hu <zbestahu@163.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yue Hu <zbestahu@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com
Subject: Re: [PATCH] cpufreq: schedutil: Don't use the limits_changed flag
 any more
Message-ID: <20210214114421.00000550.zbestahu@163.com>
In-Reply-To: <CAJZ5v0hmgQp--uhRMZbqZnOvQPy9zLfQx_u=xAewmV=LgT6rPA@mail.gmail.com>
References: <20210208030723.781-1-zbestahu@gmail.com>
        <CAJZ5v0hmgQp--uhRMZbqZnOvQPy9zLfQx_u=xAewmV=LgT6rPA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DMCowACnOqiwnChguoVIQg--.56726S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFykZw1UWrWrCr4DGF1kGrg_yoWrAFWxpF
        W3Cayvyw1qva4DX34agFnrCF4YyF1qyrWjgFn5G3ZYywnrKw48KayUJw45uFWxurn3uw4I
        yFn0qay293W8ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNeOXUUUUU=
X-Originating-IP: [183.209.57.125]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/1tbiKQU5EVXlzcWO2wABso
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 12 Feb 2021 17:14:03 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Feb 8, 2021 at 4:08 AM Yue Hu <zbestahu@gmail.com> wrote:
> >
> > From: Yue Hu <huyue2@yulong.com>
> >
> > The limits_changed flag was introduced by commit 600f5badb78c
> > ("cpufreq: schedutil: Don't skip freq update when limits change")
> > due to race condition where need_freq_update is cleared in
> > get_next_freq() which causes reducing the CPU frequency is
> > ineffective while busy.
> >
> > But now, the race condition above is gone because get_next_freq()
> > doesn't clear the flag any more after commit 23a881852f3e ("cpufreq:
> > schedutil: Don't skip freq update if need_freq_update is set").
> >
> > Moreover, need_freq_update currently will be set to true only in
> > sugov_should_update_freq() if CPUFREQ_NEED_UPDATE_LIMITS is not set
> > for the driver. However, limits may have changed at any time.  
> 
> Yes, they may change at any time.
> 
> > And subsequent frequence update is depending on need_freq_update.  
> 
> I'm not following, sorry.
> 
> need_freq_update is set in sugov_should_update_freq() when
> limits_changed is cleared and it cannot be modified until
> sugov_update_next_freq() runs on the same CPU.

get_next_freq() will check if need to update freq not by
limits_changed but by need_freq_update.

And sugov_update_next_freq() is also checking need_freq_update to
update freq or not.

> 
> > So, we may skip this update.  
> 
> I'm not sure why?

As mentioned above, need_freq_update may will not be set when
limits_changed is set since set need_freq_update happens only in
sugov_should_update_freq(), so i understand we may skip this update
or not update in time.

> 
> > Hence, let's remove it to avoid above issue and make code more
> > simple.
> >
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c
> > b/kernel/sched/cpufreq_schedutil.c index 41e498b..7dd85fb 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -40,7 +40,6 @@ struct sugov_policy {
> >         struct task_struct      *thread;
> >         bool                    work_in_progress;
> >
> > -       bool                    limits_changed;
> >         bool                    need_freq_update;
> >  };
> >
> > @@ -89,11 +88,8 @@ static bool sugov_should_update_freq(struct
> > sugov_policy *sg_policy, u64 time) if
> > (!cpufreq_this_cpu_can_update(sg_policy->policy)) return false;
> >
> > -       if (unlikely(sg_policy->limits_changed)) {
> > -               sg_policy->limits_changed = false;
> > -               sg_policy->need_freq_update = true;
> > +       if (unlikely(sg_policy->need_freq_update))
> >                 return true;
> > -       }
> >
> >         delta_ns = time - sg_policy->last_freq_update_time;
> >
> > @@ -323,7 +319,7 @@ static bool sugov_cpu_is_busy(struct sugov_cpu
> > *sg_cpu) static inline void ignore_dl_rate_limit(struct sugov_cpu
> > *sg_cpu, struct sugov_policy *sg_policy) {
> >         if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
> > -               sg_policy->limits_changed = true;
> > +               sg_policy->need_freq_update = true;
> >  }
> >
> >  static inline bool sugov_update_single_common(struct sugov_cpu
> > *sg_cpu, @@ -759,7 +755,6 @@ static int sugov_start(struct
> > cpufreq_policy *policy) sg_policy->last_freq_update_time        = 0;
> >         sg_policy->next_freq                    = 0;
> >         sg_policy->work_in_progress             = false;
> > -       sg_policy->limits_changed               = false;
> >         sg_policy->cached_raw_freq              = 0;
> >
> >         sg_policy->need_freq_update =
> > cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS); @@ -813,7
> > +808,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
> > mutex_unlock(&sg_policy->work_lock); }
> >
> > -       sg_policy->limits_changed = true;
> > +       sg_policy->need_freq_update = true;  
> 
> This may be running in parallel with sugov_update_next_freq() on a
> different CPU, so the latter may clear need_freq_update right after it
> has been set here unless I'm overlooking something.

Whether this logic is also happening for limits_changed in
sugo_should_update_freq() or not?

> 
> >  }
> >
> >  struct cpufreq_governor schedutil_gov = {
> > --
> > 1.9.1
> >  


