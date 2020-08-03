Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB923A94C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgHCPYD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 11:24:03 -0400
Received: from foss.arm.com ([217.140.110.172]:58920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCPYD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Aug 2020 11:24:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 480B430E;
        Mon,  3 Aug 2020 08:24:02 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDCC53F718;
        Mon,  3 Aug 2020 08:24:01 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:24:00 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200803152400.GB20312@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-5-ionela.voinescu@arm.com>
 <20200730044346.rgtaikotkgwdpc3m@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730044346.rgtaikotkgwdpc3m@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thursday 30 Jul 2020 at 10:13:46 (+0530), Viresh Kumar wrote:
> On 22-07-20, 10:37, Ionela Voinescu wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 3497c1cd6818..1d0b046fe8e9 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -61,6 +61,9 @@ static struct cpufreq_driver *cpufreq_driver;
> >  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
> >  static DEFINE_RWLOCK(cpufreq_driver_lock);
> >  
> > +/* Mark support for the scheduler's frequency invariance engine */
> > +static DEFINE_STATIC_KEY_FALSE(cpufreq_set_freq_scale);
> > +
> >  /* Flag to suspend/resume CPUFreq governors */
> >  static bool cpufreq_suspended;
> >  
> > @@ -69,6 +72,25 @@ static inline bool has_target(void)
> >  	return cpufreq_driver->target_index || cpufreq_driver->target;
> >  }
> >  
> > +static inline
> > +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> > +{
> > +	if ((driver->target || driver->target_index || driver->fast_switch) &&
> > +	    !driver->setpolicy) {
> 
> Just checking for !driver->setpolicy should be enough here.
> 

Right, cpufreq_register_driver() should check that at least one of them
is present (although currently cpufreq_register_driver() will return
-EINVAL if .fast_switch() alone is present - something to be fixed).

Will do, on both accounts.


> > +		static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> > +		pr_debug("%s: Driver %s can provide frequency invariance.",
> > +			 __func__, driver->name);
> 
> I think a simpler print will work well too.
> 
>                 pr_debug("Freq invariance enabled");
> 

I think the right way of reporting this support is important here.

By enabling the static key here, we're not actually enabling frequency
invariance. So printing "Freq invariance enabled" would be very
misleading. Frequency invariance (scheduler concept) being truly enabled
depends on three things:
 - Having a source of information for current frequency and maximum
   frequency (cpufreq, counters)
 - Having arch support for using that information to set the frequency
   scale factor: arch_set_freq_scale(), arch_scale_freq_tick()
 - Having arch support for passing the set frequency scale factor to the
   scheduler and reporting support for frequency invariance:
   arch_scale_freq_capacity(), arch_scale_freq_invariant().

Therefore, cpufreq can only report that the current driver can be a
source of information for frequency invariance "Driver %s can provide
frequency invariance", but it can't guarantee that the other conditions
are accomplished.

So I would recommend to keep this original debug message.

> __func__ isn't really required as this is the only print with that
> kind of info in cpufreq.c.
>

Makes sense!

> > +	} else
> > +		pr_err("%s: Driver %s cannot provide frequency invariance.",
> > +		__func__, driver->name);
> 
> Why not supporting freq-invariance an error ? I will just drop this
> message completely.

Yes, an error does not make sense here. I was thinking to demote it to a
warning instead in my previous reply to Rafael, but removing it
altogether might be better.

Many thanks for the thorough review,
Ionela.

> 
> -- 
> viresh
