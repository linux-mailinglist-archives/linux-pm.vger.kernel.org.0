Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584A0210D21
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgGAOHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 10:07:38 -0400
Received: from foss.arm.com ([217.140.110.172]:43934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbgGAOHi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 10:07:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30C0F30E;
        Wed,  1 Jul 2020 07:07:37 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C614C3F73C;
        Wed,  1 Jul 2020 07:07:36 -0700 (PDT)
Date:   Wed, 1 Jul 2020 15:07:35 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, sudeep.holla@arm.com,
        will@kernel.org, linux@armlinux.org.uk, valentin.schneider@arm.com,
        mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 4/8] cpufreq,vexpress-spc: fix Frequency Invariance (FI)
 for bL switching
Message-ID: <20200701140735.GB32736@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
 <20200701090751.7543-5-ionela.voinescu@arm.com>
 <20200701095414.2wjcnyhndgcedk2q@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701095414.2wjcnyhndgcedk2q@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 01 Jul 2020 at 16:16:19 (+0530), Viresh Kumar wrote:
> On 01-07-20, 10:07, Ionela Voinescu wrote:
> > In the majority of cases, the index argument to cpufreq's target_index()
> > is meant to identify the frequency that is requested from the hardware,
> > according to the frequency table: policy->freq_table[index].frequency.
> > 
> > After successfully requesting it from the hardware, this value, together
> > with the maximum hardware frequency (policy->cpuinfo.max_freq) are used
> > as arguments to arch_set_freq_scale(), in order to set the task scheduler
> > frequency scale factor. This is a normalized indication of a CPU's
> > current performance.
> > 
> > But for the vexpress-spc-cpufreq driver, when big.LITTLE switching [1]
> > is enabled, there are three issues with using the above information for
> > setting the FI scale factor:
> > 
> >  - cur_freq: policy->freq_table[index].frequency is not the frequency
> >    requested from the hardware. ve_spc_cpufreq_set_rate() will convert
> >    from this virtual frequency to an actual frequency, which is then
> >    requested from the hardware. For the A7 cluster, the virtual frequency
> >    is half the actual frequency. The use of the virtual policy->freq_table
> >    frequency results in an incorrect FI scale factor.
> > 
> >  - max_freq: policy->cpuinfo.max_freq does not correctly identify the
> >    maximum frequency of the physical cluster. This value identifies the
> >    maximum frequency achievable by the big-LITTLE pair, that is the
> >    maximum frequency of the big CPU. But when the LITTLE CPU in the group
> >    is used, the hardware maximum frquency passed to arch_set_freq_scale()
> >    is incorrect.
> > 
> >  - missing a scale factor update: when switching clusters, the driver
> >    recalculates the frequency of the old clock domain based on the
> >    requests of the remaining CPUs in the domain and asks for a clock
> >    change. But this does not result in an update in the scale factor.
> > 
> > Therefore, introduce a local function bLs_set_sched_freq_scale() that
> > helps call arch_set_freq_scale() with correct information for the
> > is_bL_switching_enabled() case, while maintaining the old, more
> > efficient, call site of arch_set_freq_scale() for when cluster
> > switching is disabled.
> > 
> > Also, because of these requirements in computing the scale factor, this
> > driver is the only one that maintains custom support for FI, which is
> > marked by the presence of the CPUFREQ_CUSTOM_SET_FREQ_SCALE flag.
> > 
> > [1] https://lwn.net/Articles/481055/
> > 
> > Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > ---
> >  drivers/cpufreq/vexpress-spc-cpufreq.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> Is there anyone who cares for this driver and EAS ? I will just skip doing the
> FIE thing here and mark it skipped.
> 

That is a good question. The vexpress driver is still used for TC2, but
I don't know of any users of this bL switcher functionality that's part
of the driver. I think there were a few people wondering recently if
it's still used [1].

If we disconsider the bL switcher functionality, then the vexpress
driver itself gets in line with the other drivers supported by this
series. Therefore there would not be a flag set needed here. Also, to
maintain current functionality, we would not need to introduce a flag
at all.

But, the frequency invariance fix is also useful for schedutil to
better select a frequency based on invariant utilization. So if we
independently decide having a flag like the one introduced at 1/8 is
useful, I would recommend to consider this patch, as it does fix some
current functionality in the kernel (whether we can determine if it's
used much or not).

Therefore, IMO, if it's not used any more it should be removed, but if
it's kept it should be fixed.

[1] https://lore.kernel.org/linux-arm-kernel/20200624195811.435857-8-maz@kernel.org/


Thanks,
Ionela.


> -- 
> viresh
