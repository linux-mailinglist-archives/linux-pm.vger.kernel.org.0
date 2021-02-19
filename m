Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADA31F6B1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 10:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBSJph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 04:45:37 -0500
Received: from foss.arm.com ([217.140.110.172]:60446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBSJp3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Feb 2021 04:45:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA595D6E;
        Fri, 19 Feb 2021 01:44:42 -0800 (PST)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686C13F694;
        Fri, 19 Feb 2021 01:44:42 -0800 (PST)
Date:   Fri, 19 Feb 2021 09:44:40 +0000
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
Message-ID: <20210219094440.GA29843@arm.com>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210218093304.3mt3o7kbeymn5ofl@vireshk-i7>
 <20210218163635.GA23622@arm.com>
 <20210219045823.beeijwaymd63prk7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219045823.beeijwaymd63prk7@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 19 Feb 2021 at 10:28:23 (+0530), Viresh Kumar wrote:
> On 18-02-21, 16:36, Ionela Voinescu wrote:
> > Yes, we don't care if there is no cpufreq driver, as the use of AMUs won't
> > get initialised either. But we do care if there is a cpufreq driver that
> > does not support frequency invariance, which is the example above.
> > 
> > The intention with the patches that made cpufreq based invariance generic
> > a while back was for it to be present, seamlessly, for as many drivers as
> > possible, as a less than accurate invariance default method is still
> > better than nothing.
> 
> Right.
> 
> > So only a few drivers today don't support cpufreq based FI
> 
> Only two AFAICT, both x86, and the AMU stuff doesn't conflict with
> them.
> 
> drivers/cpufreq/intel_pstate.c
> drivers/cpufreq/longrun.c
> 
> > but it's not a guarantee that it will stay this way.
> 
> What do you mean by "no guarantee" here ?
> 
> The very core routines (cpufreq_freq_transition_end() and
> cpufreq_driver_fast_switch()) of the cpufreq core call
> arch_set_freq_scale() today and this isn't going to change anytime
> soon. If something gets changed there someone will need to see other
> parts of the kernel which may get broken with that.
> 

Yes, but it won't really be straightforward to notice this breakage if
that happens, so in my opinion it was worth to keep that condition.

> I don't see any need of complicating other parts of the kernel like,
> amu or cppc code for that. They should be kept simple and they should
> assume cpufreq invariance will be supported as it is today.
> 

Fair enough! It is a corner case after all.

Thanks,
Ionela.

> -- 
> viresh
