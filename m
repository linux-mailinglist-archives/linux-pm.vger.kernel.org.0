Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BCD31D8ED
	for <lists+linux-pm@lfdr.de>; Wed, 17 Feb 2021 12:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhBQL6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 06:58:20 -0500
Received: from foss.arm.com ([217.140.110.172]:57400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhBQL6P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Feb 2021 06:58:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 854FB31B;
        Wed, 17 Feb 2021 03:57:28 -0800 (PST)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24BD23F694;
        Wed, 17 Feb 2021 03:57:28 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:57:26 +0000
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
Message-ID: <20210217115726.GA25441@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210217042558.o4anjdkayzgqny55@vireshk-i7>
 <20210217113011.GA22176@arm.com>
 <20210217114027.ashqh67hrfk4hwib@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217114027.ashqh67hrfk4hwib@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 17 Feb 2021 at 17:10:27 (+0530), Viresh Kumar wrote:
> On 17-02-21, 11:30, Ionela Voinescu wrote:
> > The problem is not topology_scale_freq_invariant() but whether a scale
> > factor is set for some CPUs.
> > 
> > Scenario (test system above):
> >  - "AMUs" are only supported for [1-2],
> >  - cpufreq_supports_freq_invariance() -> false
> > 
> > What should happen:
> >  - topology_scale_freq_invariant() -> false (passed)
> >  - all CPUs should have their freq_scale unmodified (1024) - (failed)
> >    because only 2 out of 6 CPUs have a method of setting a scale factor
> > 
> > What does happen:
> >  - arch_set_freq_tick() -> topology_set_freq_tick() will set a scale
> >    factor for [1-2] based on AMUs. This should not happen. We will end
> >    up with invariant signals for bigs and signals that are not freq
> >    invariant for littles.
> 
> Another case. cpufreq is included as a module and AMU is implemented
> partially.
> 
> - first time cpufreq driver is inserted, we set up everything and
>   freq_scale gets updated on ticks.
> 
> - remove cpufreq driver, we are back in same situation.
> 

Yes, but the littles (lacking AMUs) would have had a scale factor set
through arch_set_freq_scale() which will correspond to the last
frequency change through the cpufreq driver. When removing the driver,
it's unlikely that the frequency of littles will change (no driver).
 - topology_scale_freq_invariant() will still return true.
 - littles would still  have a scale factor set which is likely accurate
 - bigs will continue updating the scale factor through AMUs.

See a very useful comment someone added recently :) :

"""
+	/*
+	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
+	 * counters don't have any dependency on cpufreq driver once we have
+	 * initialized AMU support and enabled invariance. The AMU counters will
+	 * keep on working just fine in the absence of the cpufreq driver, and
+	 * for the CPUs for which there are no counters available, the last set
+	 * value of freq_scale will remain valid as that is the frequency those
+	 * CPUs are running at.
+	 */
"""

> We can't control it that way.. Or we add another call layer in middle
> before the tick-handler gets called for AMU, which will check if we
> are fully invariant or not ?
> 

I would avoid additional work done on the tick, especially for a scenario which
is unlikely. If you think this case is worth supporting, it might be best to do
it at CPUFREQ_REMOVE_POLICY event.

Thanks,
Ionela.

> -- 
> viresh
