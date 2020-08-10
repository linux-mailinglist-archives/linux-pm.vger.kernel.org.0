Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10362403C4
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHJJBF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 05:01:05 -0400
Received: from foss.arm.com ([217.140.110.172]:54316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbgHJJBD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Aug 2020 05:01:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 992BF101E;
        Mon, 10 Aug 2020 02:01:02 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2BB3F7BB;
        Mon, 10 Aug 2020 02:01:02 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:01:00 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20200810090100.GA7190@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
 <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
 <1db4317a-0018-1590-f0ae-ed5e235b174f@arm.com>
 <20200804063046.a2hw5cxwiewhb3aw@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804063046.a2hw5cxwiewhb3aw@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Tuesday 04 Aug 2020 at 12:00:46 (+0530), Viresh Kumar wrote:
> On 30-07-20, 12:29, Dietmar Eggemann wrote:
> > On 30/07/2020 06:24, Viresh Kumar wrote:
> > > On 22-07-20, 10:37, Ionela Voinescu wrote:
> > >> +++ b/drivers/base/arch_topology.c
> > >> @@ -27,6 +27,7 @@ __weak bool arch_freq_counters_available(struct cpumask *cpus)
> > >>  }
> > >>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
> > >>  
> > >> +#ifndef CONFIG_BL_SWITCHER
> > >>  void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> > >>  			 unsigned long max_freq)
> > >>  {
> > >> @@ -46,6 +47,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> > >>  	for_each_cpu(i, cpus)
> > >>  		per_cpu(freq_scale, i) = scale;
> > >>  }
> > >> +#endif
> > > 
> > > I don't really like this change, the ifdef hackery is disgusting and
> > > then we are putting that in a completely different part of the kernel.
> > > 
> > > There are at least these two ways of solving this, maybe more:
> > > 
> > > - Fix the bl switcher driver and add the complexity in it (which you
> > >   tried to do earlier).
> > > 
> > > - Add a cpufreq flag to skip arch-set-freq-scale call.
> > 
> > I agree it's not nice but IMHO the cpufreq flag is worse since we would
> > introduce new infrastructure only for a deprecated feature. I'm assuming
> > that BL SWITCHER is the only feature needing this CPUfreq flag extension.
> > 
> > #ifdef CONFIG_BL_SWITCHER is already in drivers/irqchip/irq-gic.c so
> > it's ugly already.
> > 
> > Runtime detecting (via bL_switching_enabled) of BL SWITCHER is right now
> > also only handled inside vexpress-spc-cpufreq.c via a
> > bL_switcher_notifier. A mechanism which also sits behind a #ifdef
> > CONFIG_BL_SWITCHER.
> 
> Vexpress one is a driver and so ugliness could be ignored here :)
> 
> So here is option number 3 (in continuation of the earlier two
> options):
> - Don't do anything for bL switcher, just add a TODO/NOTE in the
>   driver that FIE is broken for switcher. And I don't think anyone
>   will care about FIE for the switcher anyway :)
> 

I gave it a bit of time in case anyone had strong opinions about this,
but given the lack of those, what I can do in this series is the
following: ignore the problem :). This issue was there before these
patches and it will continue to be there after these patches - nothing
changes.

Separately from this series, I can submit a patch with Viresh's
suggestion above and we can spin around a bit discussing this, if there
is interest. My opinion on this is that option 1 is ugly but it does fix
an issue in a relatively non-invasive way. I agree with "I don't think
anyone will care about FIE for the switcher anyway", but for me this
means that nobody will care if it's supported (and therefore option 1
is the proper solution). But if bL switcher is used, I think people might
care if it's broken, as it results in incorrect scheduler signals.
Therefore, I would not like leaving it broken (option 3). If it's not
used, option 2 is obvious.


Many thanks,
Ionela.

> -- 
> viresh
