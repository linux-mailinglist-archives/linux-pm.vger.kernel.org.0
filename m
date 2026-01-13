Return-Path: <linux-pm+bounces-40750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C30D1A0B0
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 16:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D08B3008D51
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF932B98F;
	Tue, 13 Jan 2026 15:58:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94363043D5;
	Tue, 13 Jan 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319882; cv=none; b=LiPhwH62UkK+4Uwe3aoY0SaNh/3pW/HLyv0dHjgGBb65GRmIuSMFD2KSbws+oYdsVUdFBsGkI35Y1yPpfpObIiKe8vjOdNA9e1TyQ1YTY1uNhjChR747U7w+gWeui4sK18Hjuwio+4U8EY+u/ND57DKE4pQB/xSHAOFzgIvg/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319882; c=relaxed/simple;
	bh=MF0zKwSQPqmRxvYFtUTfngmRZ9Z57fLkUGA9Ql1G2bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT5cBc3nvODIsUJjQ/rg9ESzaER6k0k616GcKFGBx/aidL3Qayo8QxVXyZt286iTqPr1J/cHrzAuHeHHySFCBQ9KhUU8gx6KFBdM1MbtfhF0ChUbehgDGeXXGp0yUCRaFuSudLB45HQ0IfXN2xj63uS1Mdl3lyR31xXZPBfeD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06DF3497;
	Tue, 13 Jan 2026 07:57:52 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993CB3F59E;
	Tue, 13 Jan 2026 07:57:53 -0800 (PST)
Date: Tue, 13 Jan 2026 16:58:01 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, dakr@kernel.org,
	ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, vincent.guittot@linaro.org,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
	zhangpengjie2@huawei.com, wangzhi12@huawei.com,
	linhongye@h-partners.com,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [REPOST PATCH v6 3/3] arm64: topology: Handle AMU FIE setup on
 CPU hotplug
Message-ID: <aWZriVlQZ5jRx2o4@arm.com>
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
 <20251230080115.2120612-4-zhenglifeng1@huawei.com>
 <CAMuHMdVeHk-Enc-M9ztwSdeAtE8YPKtJwq+273bGPEFOEsu=Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVeHk-Enc-M9ztwSdeAtE8YPKtJwq+273bGPEFOEsu=Rw@mail.gmail.com>

Hi Geert,
On Tue, Jan 13, 2026 at 11:51:45AM +0100, Geert Uytterhoeven wrote:
> Hi Lifeng,
> 
> On Tue, 30 Dec 2025 at 09:02, Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
> > Currently, when a cpufreq policy is created, the AMU FIE setup process
> > checks all CPUs in the policy -- including those that are offline. If any
> > of these CPUs are offline at that time, their AMU capability flag hasn't
> > been verified yet, leading the check fail. As a result, AMU FIE is not
> > enabled, even if the CPUs that are online do support it.
> >
> > Later, when the previously offline CPUs come online and report AMU support,
> > there's no mechanism in place to re-enable AMU FIE for the policy. This
> > leaves the entire frequency domain without AMU FIE, despite being eligible.
> >
> > Restrict the initial AMU FIE check to only those CPUs that are online at
> > the time the policy is created, and allow CPUs that come online later to
> > join the policy with AMU FIE enabled.
> >
> > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> > Acked-by: Beata Michalska <beata.michalska@arm.com>
> 
> Thanks for your patch, which is now commit 6fd9be0b7b2e957d
> ("arm64: topology: Handle AMU FIE setup on CPU hotplug") in
> arm64/for-next/core (next-20260107 and later).
> 
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -284,7 +284,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
> >         struct cpufreq_policy *policy = data;
> >
> >         if (val == CPUFREQ_CREATE_POLICY)
> > -               amu_fie_setup(policy->related_cpus);
> > +               amu_fie_setup(policy->cpus);
> >
> >         /*
> >          * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> > @@ -303,10 +303,71 @@ static struct notifier_block init_amu_fie_notifier = {
> >         .notifier_call = init_amu_fie_callback,
> >  };
> >
> > +static int cpuhp_topology_online(unsigned int cpu)
> > +{
> > +       struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
> > +
> > +       /* Those are cheap checks */
> > +
> > +       /*
> > +        * Skip this CPU if:
> > +        *  - it has no cpufreq policy assigned yet,
> > +        *  - no policy exists that spans CPUs with AMU counters, or
> > +        *  - it was already handled.
> > +        */
> > +       if (unlikely(!policy) || !cpumask_available(amu_fie_cpus) ||
> > +           cpumask_test_cpu(cpu, amu_fie_cpus))
> > +               return 0;
> > +
> > +       /*
> > +        * Only proceed if all already-online CPUs in this policy
> > +        * support AMU counters.
> > +        */
> > +       if (unlikely(!cpumask_subset(policy->cpus, amu_fie_cpus)))
> > +               return 0;
> > +
> > +       /*
> > +        * If the new online CPU cannot pass this check, all the CPUs related to
> > +        * the same policy should be clear from amu_fie_cpus mask, otherwise they
> > +        * may use different source of the freq scale.
> > +        */
> > +       if (!freq_counters_valid(cpu)) {
> > +               pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);
> 
> This is triggered during resume from s2ram on Renesas R-Car H3
> (big.LITTLE 4x Cortex-A57 + 4x Cortex-A53), when enabling the first
> little core:
> 
>     AMU: CPU[4] doesn't support AMU counters
> 
> Adding debug code:
> 
>     pr_info("Calling
> topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, %*pbl)\n",
> cpumask_pr_args(policy->related_cpus));
>     pr_info("Calling cpumask_andnot(..., %*pbl, %*pbl)\n",
> cpumask_pr_args(amu_fie_cpus), cpumask_pr_args(policy->related_cpus));
> 
> gives:
> 
>     AMU: Calling topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, 4-7)
>     AMU: Calling cpumask_andnot(..., , 4-7)
> 
> so AMU is disabled for all little cores.
> 
> Since this only happens during s2ram, and not during initial CPU
> bring-up on boot, this looks wrong to me?
This does look rather surprising. If that CPU was marked as supporting AMUs at
the initial bring-up it should be part of amu_fie_cpus mask, so the hp callback
should bail out straight away. Would you be able to add some logs to see what
that mask actually contains ?
Furthermore, freq_counters_valid is logging issues when validating the counters.
Would you be able to re-run it with the debug level to see what might be
happening under the hood, although I am still unsure why it is even reaching
that point ...

---
BR
Beata
> 
> > +               topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH,
> > +                                                policy->related_cpus);
> > +               cpumask_andnot(amu_fie_cpus, amu_fie_cpus, policy->related_cpus);
> > +               return 0;
> > +       }
> > +
> > +       cpumask_set_cpu(cpu, amu_fie_cpus);
> > +
> > +       topology_set_scale_freq_source(&amu_sfd, cpumask_of(cpu));
> > +
> > +       pr_debug("CPU[%u]: counter will be used for FIE.", cpu);
> > +
> > +       return 0;
> > +}
> > +
> >  static int __init init_amu_fie(void)
> >  {
> > -       return cpufreq_register_notifier(&init_amu_fie_notifier,
> > +       int ret;
> > +
> > +       ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> >                                         CPUFREQ_POLICY_NOTIFIER);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > +                                       "arm64/topology:online",
> > +                                       cpuhp_topology_online,
> > +                                       NULL);
> > +       if (ret < 0) {
> > +               cpufreq_unregister_notifier(&init_amu_fie_notifier,
> > +                                           CPUFREQ_POLICY_NOTIFIER);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> >  }
> >  core_initcall(init_amu_fie);
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 84ec92bff642..c0ef6ea9c111 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -34,7 +34,14 @@ EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
> >
> >  static bool supports_scale_freq_counters(const struct cpumask *cpus)
> >  {
> > -       return cpumask_subset(cpus, &scale_freq_counters_mask);
> > +       int i;
> > +
> > +       for_each_cpu(i, cpus) {
> > +               if (cpumask_test_cpu(i, &scale_freq_counters_mask))
> > +                       return true;
> > +       }
> > +
> > +       return false;
> >  }
> >
> >  bool topology_scale_freq_invariant(void)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

