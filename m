Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590183A99D0
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhFPMDF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 08:03:05 -0400
Received: from foss.arm.com ([217.140.110.172]:35350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232519AbhFPMDF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Jun 2021 08:03:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B091042;
        Wed, 16 Jun 2021 05:00:59 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBD443F719;
        Wed, 16 Jun 2021 05:00:58 -0700 (PDT)
Date:   Wed, 16 Jun 2021 13:00:57 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] arch_topology: Avoid use-after-free for
 scale_freq_data
Message-ID: <20210616120057.GA23282@arm.com>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <9dba462b4d09a1a8a9fbb75740b74bf91a09a3e1.1623825725.git.viresh.kumar@linaro.org>
 <20210616112544.GA23657@arm.com>
 <20210616113604.e4kc3jxb7ayqskev@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616113604.e4kc3jxb7ayqskev@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 16 Jun 2021 at 17:06:04 (+0530), Viresh Kumar wrote:
> Hi Ionela,
> 
> On 16-06-21, 12:25, Ionela Voinescu wrote:
> > Please correct me if I'm wrong, but my understanding is that this is
> > only a problem for the cppc cpufreq invariance functionality. Let's
> > consider a scenario where CPUs are either hotplugged out or the cpufreq
> > CPPC driver module is removed; topology_clear_scale_freq_source() would
> > get called and the sfd_data will be set to NULL. But if at the same
> > time topology_scale_freq_tick() got an old reference of sfd_data,
> > set_freq_scale() will be called. This is only a problem for CPPC cpufreq
> > as cppc_scale_freq_tick() will end up using driver internal data that
> > might have been freed during the hotplug callbacks or the exit path.
> 
> For now, yes, CPPC is the only one affected.
> 
> > If this is the case, wouldn't the synchronisation issue be better
> > resolved in the CPPC cpufreq driver, rather than here?
> 
> Hmm, the way I see it is that topology_clear_scale_freq_source() is an API
> provided by topology core and the topology core needs to guarantee that it
> doesn't use the data any longer after topology_clear_scale_freq_source() is
> called.
> 
> The same is true for other APIs, like:
> 
> irq_work_sync();
> kthread_cancel_work_sync();
> 
> It isn't the user which needs to take this into account, but the API provider.
> 

I would agree if it wasn't for the fact that the driver provides the
set_freq_scale() implementation that ends up using driver internal data
which could have been freed by the driver's own .exit()/stop_cpu()
callbacks. The API and the generic implementation has the responsibility
of making sure of sane access to its own structures.

Even if we would want to keep drivers from shooting themselves in the
foot, I would prefer we postpone it until we have more users for this,
before we add any synchronisation mechanisms to functionality called
on the tick.

Let's see if there's a less invasive solution to fix CPPC for now, what
do you think?

Thanks,
Ionela.

> There may be more users of this in the future, lets say another cpufreq driver,
> and so keeping this synchronization at the API provider is the right thing to do
> IMHO.
> 
> And from the user's perspective, like cppc, it doesn't have any control over who
> is using its callback and how and when. It is very very difficult to provide

> something like this at the users, redundant anyway. For example cppc won't ever
> know when topology_scale_freq_tick() has stopped calling its callback.
> 
> For example this is what cppc driver needs to do now:
> 
> +static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy,
> +                                 unsigned int cpu)
> +{
> +       struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
> +
> +       topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpumask_of(cpu));
> +       irq_work_sync(&cppc_fi->irq_work);
> +       kthread_cancel_work_sync(&cppc_fi->work);
> +}
> 
> The driver uses APIs provided by 3 layers, topology, irq-work, kthread and all
> must provide these guarantees.
> 
> A very similar thing is implemented in kernel/sched/cpufreq.c for example.
> 
> -- 
> viresh
