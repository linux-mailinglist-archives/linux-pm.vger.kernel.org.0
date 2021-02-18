Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571B331ED20
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhBRRRW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 12:17:22 -0500
Received: from foss.arm.com ([217.140.110.172]:53202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233306AbhBRQiV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 11:38:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59FDA106F;
        Thu, 18 Feb 2021 08:36:37 -0800 (PST)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7E73F73D;
        Thu, 18 Feb 2021 08:36:36 -0800 (PST)
Date:   Thu, 18 Feb 2021 16:36:35 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210218163635.GA23622@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210218093304.3mt3o7kbeymn5ofl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218093304.3mt3o7kbeymn5ofl@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey,

On Thursday 18 Feb 2021 at 15:03:04 (+0530), Viresh Kumar wrote:
> On 17-02-21, 00:24, Ionela Voinescu wrote:
> > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > index 1e47dfd465f8..47fca7376c93 100644
> > > --- a/arch/arm64/kernel/topology.c
> > > +++ b/arch/arm64/kernel/topology.c
> > > @@ -240,7 +240,6 @@ static struct scale_freq_data amu_sfd = {
> > >  
> > >  static void amu_fie_setup(const struct cpumask *cpus)
> > >  {
> > > -	bool invariant;
> > >  	int cpu;
> > >  
> > >  	/* We are already set since the last insmod of cpufreq driver */
> > > @@ -257,25 +256,10 @@ static void amu_fie_setup(const struct cpumask *cpus)
> > >  
> > >  	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
> > >  
> > > -	invariant = topology_scale_freq_invariant();
> > > -
> > > -	/* We aren't fully invariant yet */
> > > -	if (!invariant && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
> > > -		return;
> > > -
> > 
> > You still need these checks, otherwise you could end up with only part
> > of the CPUs setting a scale factor, when only part of the CPUs support
> > AMUs and there is no cpufreq support for FIE.
> 
> Another look at it and here goes another reason (hope I don't have
> another in-code comment somewhere else to kill this one) :)
> 
> We don't need to care for the reason you gave (which is a valid reason
> otherwise), as we are talking specifically about amu_fie_setup() here
> and it gets called from cpufreq policy-notifier. i.e. we won't support
> AMUs without cpufreq being there in the first place and the same goes
> for cppc-driver.
> 
> Does that sound reasonable ?
> 

Yes, we don't care if there is no cpufreq driver, as the use of AMUs won't
get initialised either. But we do care if there is a cpufreq driver that
does not support frequency invariance, which is the example above.

The intention with the patches that made cpufreq based invariance generic
a while back was for it to be present, seamlessly, for as many drivers as
possible, as a less than accurate invariance default method is still
better than nothing. So only a few drivers today don't support cpufreq
based FI, but it's not a guarantee that it will stay this way.

Hope it makes sense,
Ionela.

> -- 
> viresh
