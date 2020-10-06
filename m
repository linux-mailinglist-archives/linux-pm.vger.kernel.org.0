Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6A28507D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJFRJS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 13:09:18 -0400
Received: from foss.arm.com ([217.140.110.172]:52520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFRJS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Oct 2020 13:09:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC15D6E;
        Tue,  6 Oct 2020 10:09:18 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8133F66B;
        Tue,  6 Oct 2020 10:09:17 -0700 (PDT)
Date:   Tue, 6 Oct 2020 18:09:16 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq,arm,arm64: restructure definitions of
 arch_set_freq_scale()
Message-ID: <20201006170916.GB17897@arm.com>
References: <20200924123016.13427-1-ionela.voinescu@arm.com>
 <20200924123016.13427-2-ionela.voinescu@arm.com>
 <20201006070551.kokmnsuzyzqxqbq5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006070551.kokmnsuzyzqxqbq5@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Tuesday 06 Oct 2020 at 12:35:51 (+0530), Viresh Kumar wrote:
> On 24-09-20, 13:30, Ionela Voinescu wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 2ea245a6c0c0..f34d3a3d5ba6 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -160,13 +160,6 @@ u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
> >  }
> >  EXPORT_SYMBOL_GPL(get_cpu_idle_time);
> >  
> > -__weak void arch_set_freq_scale(const struct cpumask *cpus,
> > -				unsigned long cur_freq,
> > -				unsigned long max_freq)
> > -{
> > -}
> > -EXPORT_SYMBOL_GPL(arch_set_freq_scale);
> > -
> 
> Why can't we have this anymore ? Because it is a macro now instead of a routine
> for ARM ?

Yes, instead of having a strong counterpart in arch_topology.c to be used
for both arm64 and arm, I separated the definitions of the
arch_set_freq_scale symbol in each architecture's topology.h in order to
be filtered if needed (as is the case for arm's BL_SWITCHER).

I could have kept either this weak stub definition or the stub that is
now in cpufreq.h under "#ifndef arch_set_freq_scale", but I chose the
latter as it's more aligned with the other architectural functions
referenced in the commit message.

So this patch has both the purpose of enabling a nicer filtering of
frequency invariance for BL_SWITCHER but also follows the definition
pattern of the other functions so we don't keep having two mindsets when
working with them.

Thanks,
Ionela.
