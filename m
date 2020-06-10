Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784CB1F514C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 11:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFJJlA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 05:41:00 -0400
Received: from foss.arm.com ([217.140.110.172]:55854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgFJJlA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jun 2020 05:41:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 749F01F1;
        Wed, 10 Jun 2020 02:40:59 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D0B73F73D;
        Wed, 10 Jun 2020 02:40:58 -0700 (PDT)
Date:   Wed, 10 Jun 2020 10:40:57 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200610094057.GA28144@arm.com>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <CAJZ5v0iR3H+PFnJiroNmZcj-a4bCkvT6xB-nd2ntMvakWFOvAg@mail.gmail.com>
 <39d37e1b-7959-9a8f-6876-f2ed4c1dbc37@huawei.com>
 <20200604044140.xlv7h62jfowo3rxe@vireshk-i7>
 <CAJZ5v0jj5OS4oB7MYBqKeYejy_3Vz_2oy0hn-Xm=D7XAszM_vg@mail.gmail.com>
 <20200604125822.GB12397@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604125822.GB12397@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

Sorry for showing up late to the party, I was on holiday last week.

On Thursday 04 Jun 2020 at 13:58:22 (+0100), Sudeep Holla wrote:
> On Thu, Jun 04, 2020 at 12:42:06PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 4, 2020 at 6:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 04-06-20, 09:32, Xiongfeng Wang wrote:
> > > > On 2020/6/3 21:39, Rafael J. Wysocki wrote:
> > > > > The frequency value obtained by kicking the CPU out of idle
> > > > > artificially is bogus, though.  You may as well return a random number
> > > > > instead.
> > > >
> > > > Yes, it may return a randowm number as well.
> > > >
> > > > >
> > > > > The frequency of a CPU in an idle state is in fact unknown in the case
> > > > > at hand, so returning 0 looks like the cleanest option to me.
> > > >
> > > > I am not sure about how the user will use 'cpuinfo_cur_freq' in sysfs. If I
> > > > return 0 when the CPU is idle, when I run a light load on the CPU, I will get a
> > > > zero value for 'cpuinfo_cur_freq' when the CPU is idle. When the CPU is not
> > > > idle, I will get a non-zero value. The user may feel odd about
> > > > 'cpuinfo_cur_frreq' switching between a zero value and a non-zero value. They
> > > > may hope it can return the frequency when the CPU execute instructions, namely
> > > > in C0 state. I am not so sure about the user will look at 'cpuinfo_cur_freq'.
> > >
> > > This is what I was worried about as well. The interface to sysfs needs
> > > to be robust. Returning frequency on some readings and 0 on others
> > > doesn't look right to me as well. This will break scripts (I am not
> > > sure if some scripts are there to look for these values) with the
> > > randomness of values returned by it.
> > 
> > The only thing the scripts need to do is to skip zeros (or anything
> > less than the minimum hw frequency for that matter) coming from that
> > attribute.
> > 
> > > On reading values locally from the CPU, I thought about the case where
> > > userspace can prevent a CPU going into idle just by reading its
> > > frequency from sysfs (and so waste power), but the same can be done by
> > > userspace to run arbitrary load on the CPUs.
> > >
> > > Can we do some sort of caching of the last frequency the CPU was
> > > running at before going into idle ? Then we can just check if cpu is
> > > idle and so return cached value.
> > 
> > That is an option, but it looks like in this case the cpuinfo_cur_freq
> > attribute should not be present at all, as per the documentation.
> > 
> 
> +1 for dropping the attribute.
> 

I've been experimenting with some code quite recently that uses the
scheduler frequency scale factor to compute this hardware current rate
for CPPC.

On the scheduler tick, the scale factor is computed in
arch_scale_freq_tick() to give an indication on delivered performance,
using AMUs on arm64 [1] and APERF/MPERF on x86 [2]. Basically, this scale
factor has the cached value of the average delivered performance between
the last two scheduler ticks, on a capacity scale: 0-1024. All that would
be needed is to convert from the scheduler frequency scale to the CPPC
expected performance scale.

The gist of the code would be:

delivered_perf = topology_get_freq_scale(cpu);
delivered_perf *= fb_ctrs.reference_perf;
delivered_perf = div64_u64(delivered_perf << SCHED_CAPACITY_SHIFT,
			   per_cpu(arch_max_freq_scale, cpu));

While this solution is not perfect, it would provide the best view of
the hardware "current" rate without the cost of waking up the CPU when
idle, scheduling additional work on the CPU, doing checks on whether
the CPU is idle and/or providing other caching mechanisms.

Do you think such an implementation could make cpuinfo_cur_freq worth
keeping?

I'm happy to push the patches for this and discuss the details there.

Thanks,
Ionela.


[1] https://lkml.org/lkml/2020/3/5/183
[2] https://lkml.org/lkml/2020/1/22/1039

> -- 
> Regards,
> Sudeep
