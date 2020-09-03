Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A306925C353
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgICOte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 10:49:34 -0400
Received: from foss.arm.com ([217.140.110.172]:34558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbgICOTS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 10:19:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7BC11045;
        Thu,  3 Sep 2020 07:19:17 -0700 (PDT)
Received: from bogus (unknown [10.57.4.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDCF03F71F;
        Thu,  3 Sep 2020 07:19:15 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:19:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200903141909.GA6492@bogus>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200901205549.30096-4-ionela.voinescu@arm.com>
 <20200902132838.GF25462@bogus>
 <20200903134508.GB29370@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903134508.GB29370@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 03, 2020 at 02:45:08PM +0100, Ionela Voinescu wrote:
> Hi Sudeep,
> 
> Thank you for your review here and for the other patches.
> 
> On Wednesday 02 Sep 2020 at 14:28:38 (+0100), Sudeep Holla wrote:
> [..]
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 4d5fe777184a..570bf2ebe9d4 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -61,6 +61,12 @@ static struct cpufreq_driver *cpufreq_driver;
> > >  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
> > >  static DEFINE_RWLOCK(cpufreq_driver_lock);
> > >  
> > > +static DEFINE_STATIC_KEY_FALSE(cpufreq_freq_invariance);
> > > +bool cpufreq_supports_freq_invariance(void)
> > > +{
> > > +	return static_branch_likely(&cpufreq_freq_invariance);
> > > +}
> > > +
> > >  /* Flag to suspend/resume CPUFreq governors */
> > >  static bool cpufreq_suspended;
> > >  
> > > @@ -2720,6 +2726,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> > >  	cpufreq_driver = driver_data;
> > >  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > >  
> > > +	/*
> > > +	 * Mark support for the scheduler's frequency invariance engine for
> > > +	 * drivers that implement target(), target_index() or fast_switch().
> > > +	 */
> > > +	if (!cpufreq_driver->setpolicy) {
> > > +		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
> > > +		pr_debug("supports frequency invariance");
> > > +	}
> > > +
> > >  	if (driver_data->setpolicy)
> > 
> > [super nit] while I understand cpufreq_driver = driver_data, it looks odd
> > if 2 consecutive statements refer it with different variables. Or am I
> > confusing myself hugely.
> > 
> 
> No, you are right. If you look at the rest of the register function,
> after cpufreq_driver = driver_data, both driver_data and cpufreq_driver
> are used. For me using cpufreq_driver seemed more natural as after being
> assigned driver_data, it will continue to be used after registration.
>

Ah OK, I haven't seen the whole file/function, just looked at the patch.

> If it's alright with you I won't make this change for now. It's possible
> that a better solution is to change the other occurrences of either
> cpufreq_driver or driver_data in a separate patch, to make things
> consistent across the function.
> 

I am fine to keep it as is, hence I mentioned it as super nit. If there
are other occurrences, then better to take it up separately.

-- 
Regards,
Sudeep
