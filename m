Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAED84EB00
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUOrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 10:47:21 -0400
Received: from foss.arm.com ([217.140.110.172]:33752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOrV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Jun 2019 10:47:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBBA528;
        Fri, 21 Jun 2019 07:47:20 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82AD93F575;
        Fri, 21 Jun 2019 07:47:18 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:47:16 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 11/16] sched/fair: uclamp: Add uclamp support to
 energy_compute()
Message-ID: <20190621144716.2322iylanmvwja5c@e110439-lin>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-12-patrick.bellasi@arm.com>
 <20190621140128.GL3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621140128.GL3436@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-Jun 16:01, Peter Zijlstra wrote:
> On Fri, Jun 21, 2019 at 09:42:12AM +0100, Patrick Bellasi wrote:
> 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ce2da8b9ff8c..f81e8930ff19 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2322,7 +2322,6 @@ static inline unsigned long capacity_orig_of(int cpu)
> >  }
> >  #endif
> >  
> > -#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> >  /**
> >   * enum schedutil_type - CPU utilization type
> >   * @FREQUENCY_UTIL:	Utilization used to select frequency
> > @@ -2338,15 +2337,11 @@ enum schedutil_type {
> >  	ENERGY_UTIL,
> >  };
> >  
> > -unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> > -				  unsigned long max, enum schedutil_type type);
> > -
> > -static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
> > -{
> > -	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
> 
> That conflicts with the patch I have removing that NULL argument, fixed
> it up.

Ok, I notice only know you have this:

   commit 119fd437f412 ("sched/topology: Remove unused sd param from arch_scale_cpu_capacity()")

from Vincent on your queue. :/


> > +#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> >  
> > -	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
> > -}
> > +unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
> > +				 unsigned long max, enum schedutil_type type,
> > +				 struct task_struct *p);
> >  
> >  static inline unsigned long cpu_bw_dl(struct rq *rq)
> >  {
> > @@ -2375,11 +2370,8 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
> >  	return READ_ONCE(rq->avg_rt.util_avg);
> >  }
> >  #else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
> > -static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
> > -{
> > -	return cfs;
> > -}
> > -#endif
> > +#define schedutil_cpu_util(cpu, util_cfs, max, type, p) 0
> 
> Was there a good reason for this to be a macro and not an inline
> function?

Mmm... not really, apart perhaps saving some lines.

I notice sometimes we use macros (e.g. perf_domain_span), but it's
certainly not the most common pattern.

> I've changed it, if it explodes in 0day, it's all my fault ;-)

Sure, I guess if 0day explodes will not be for that change. :)


-- 
#include <best/regards.h>

Patrick Bellasi
