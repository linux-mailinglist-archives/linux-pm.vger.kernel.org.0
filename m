Return-Path: <linux-pm+bounces-40912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B87FD233C7
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 09:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0382300CBAB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377233DED6;
	Thu, 15 Jan 2026 08:45:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3233E357
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466756; cv=none; b=Z4JwnsUG5xGATq+dORF+aWsoYFW4bGjpUF/RVj3T7NsDxHfjp6oXsIBN8mR+iHNclFS1BYf4tvvaZwnc2jepNcxWmqvalo3gTbuh/IUGPTguoip3wUys9AoR6N6rqwq8HgO++ks9S/j7ERubWNSwB1LhK8B6LJ1lGQvs1piO5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466756; c=relaxed/simple;
	bh=paTnkoL9xUak4CUxnRb/yoa9tXE3w3bGYQXVfiVJENY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdIumQF/sPeOePlXq21pRPWSr7f2P2aIh/lZqNnBjjhvqVT12A9Bsnl0EoLYGoMhGnj2ZeyJbFvJOI7dGP3Khg8BydBm+4EhDKKkbyqRj8b4tF5OCsgOcN3pfzgw+D4tjXQ9LCjy11troXgyf7Q1ifxMcUDETq0ykj+7cwZTRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so335975b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 00:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466754; x=1769071554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEhW79U6doUL/JqAk9Ut/HyEczQFD5R9B9xZcFtsnOI=;
        b=n/C12+Zj6sQVP8rHsbRTrPtKSdkmXBYxMoqNMjiAZohqGz7Scv6HgeRC9IdbA+jMHc
         EXsc1TKIGKTYdytGfDNvrSyWW+HFqT2X4b0blx1k+6RMHaWgE4EOyCqbBhfAE/bSwapo
         bMlTqdIMLhlVw5M8Xxg/CFVQiCzzm2yRSfT/FaD7tYzaCPC4dUHXUkrG4AuYSakgMIT9
         Wnsgi60s+3YKqUd7q8RyHN9levpeA72NlA23E2UJKJyc3UT5eRhKJEVVVwyXIsQTLaVN
         OeA+7/6u0/OVoNCGtUIaxr3XJVIxulj5hpqTkgB5qaE8e0aS8+9gq0tq/muFmabxHbFc
         z+gg==
X-Forwarded-Encrypted: i=1; AJvYcCXBkhzsvcnooG6qBGX0PXN/BPfG9pdUQ0Vr1Noqr9Tj37OCNe7Ql5wg9DUJ4a1oxz+Z+mEvo8yrGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+xZuszd3cEK2vSEq7gcNbeBX8qoMyfYFv/g1Ejp+qY0uw54y
	IdIe8DrfbQS0Z8lw39mwC/2T3usnX3EGrkzEEomSHoqOt/jf1T8BrAQTcdvYDMsS
X-Gm-Gg: AY/fxX6k17I+Z0TgE+KgIgI1JHBE+LVlD84IKSr5lRA5XXznMi85QnGb913vp9+hrxV
	ZY6ZEVSvb6NxoHLuDlvSiSdn51/ExMl3lcXG6TEYcZTnvlBdzQOGpipXYk/a3MbCZdSzUDEPNgw
	ngAknAyenD+q1Lz9XxLAXuvN/58JJwJwY+avwX8ClEs+0Jk6mSdFxxtDOkBtfZi6nJz6YUUsXpu
	rLoodBDt4lQMfBfY69oTt4j5av2cdBf40BLrLiw9qUqZUhHoJ+vpyKtzoMBhXDsys0lWOl7xSnE
	JJrjeBgN2jVNjDApb6E/U3lJ1WyB4BEzdKvX4eBR0eNoZh+cZuSyJtzkt4KvvHxttX5XOnTDvnq
	B7zVmKlMnEdbAuZod8Bl40XVkP5gMjKFss7PXMNUpWtSf8ucyfUeboVmIVuD8BM3hYO35wFR1Qv
	GYg/k1hFg3I+GhObWtDBi+AswEzstV5E9mqdPwDITPyBE7khU=
X-Received: by 2002:a05:6a00:3311:b0:81e:5a6e:339 with SMTP id d2e1a72fcca58-81f83c881aemr4592595b3a.22.1768466753583;
        Thu, 15 Jan 2026 00:45:53 -0800 (PST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4f61fdsm1818105b3a.26.2026.01.15.00.45.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 00:45:53 -0800 (PST)
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12331482b8fso2165181c88.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 00:45:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwXumaBuepuC/0F4keSgifhjy9ijSE7GHPagawhZ4hB0si7tIWfNvmf4MJ8Gxwhf+n3DneacTsBw==@vger.kernel.org
X-Received: by 2002:a05:6122:3b81:b0:563:4a88:6ea5 with SMTP id
 71dfb90a1353d-563a2093a5dmr1838362e0c.5.1768466262231; Thu, 15 Jan 2026
 00:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
 <20251230080115.2120612-4-zhenglifeng1@huawei.com> <CAMuHMdVeHk-Enc-M9ztwSdeAtE8YPKtJwq+273bGPEFOEsu=Rw@mail.gmail.com>
 <aWZriVlQZ5jRx2o4@arm.com> <CAMuHMdVgbQnaCQ8U8FK6J1vJLsqc0_MC7zSTX2B=rsuF2kpEKg@mail.gmail.com>
 <41b7398c-b1a4-4b87-b6f9-07eacf4f4752@huawei.com>
In-Reply-To: <41b7398c-b1a4-4b87-b6f9-07eacf4f4752@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2026 09:37:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuTrF=eN5tMsjmOfWuuT9r7aCOTS7=YP6+KrSdNrhEpw@mail.gmail.com>
X-Gm-Features: AZwV_QgJfgfwWgiDZ0xWQqvqqWOvLCpdrYhSVw3ZJkes_w8m6CntQRIYTUo-KYk
Message-ID: <CAMuHMdUuTrF=eN5tMsjmOfWuuT9r7aCOTS7=YP6+KrSdNrhEpw@mail.gmail.com>
Subject: Re: [REPOST PATCH v6 3/3] arm64: topology: Handle AMU FIE setup on
 CPU hotplug
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Beata Michalska <beata.michalska@arm.com>, catalin.marinas@arm.com, will@kernel.org, 
	rafael@kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, 
	gregkh@linuxfoundation.org, dakr@kernel.org, ionela.voinescu@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, vincent.guittot@linaro.org, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Lifeng,

On Thu, 15 Jan 2026 at 03:25, zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
> On 2026/1/14 21:54, Geert Uytterhoeven wrote:
> > On Tue, 13 Jan 2026 at 16:58, Beata Michalska <beata.michalska@arm.com> wrote:
> >> On Tue, Jan 13, 2026 at 11:51:45AM +0100, Geert Uytterhoeven wrote:
> >>> On Tue, 30 Dec 2025 at 09:02, Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
> >>>> Currently, when a cpufreq policy is created, the AMU FIE setup process
> >>>> checks all CPUs in the policy -- including those that are offline. If any
> >>>> of these CPUs are offline at that time, their AMU capability flag hasn't
> >>>> been verified yet, leading the check fail. As a result, AMU FIE is not
> >>>> enabled, even if the CPUs that are online do support it.
> >>>>
> >>>> Later, when the previously offline CPUs come online and report AMU support,
> >>>> there's no mechanism in place to re-enable AMU FIE for the policy. This
> >>>> leaves the entire frequency domain without AMU FIE, despite being eligible.
> >>>>
> >>>> Restrict the initial AMU FIE check to only those CPUs that are online at
> >>>> the time the policy is created, and allow CPUs that come online later to
> >>>> join the policy with AMU FIE enabled.
> >>>>
> >>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >>>> Acked-by: Beata Michalska <beata.michalska@arm.com>
> >>>
> >>> Thanks for your patch, which is now commit 6fd9be0b7b2e957d
> >>> ("arm64: topology: Handle AMU FIE setup on CPU hotplug") in
> >>> arm64/for-next/core (next-20260107 and later).
> >>>
> >>>> --- a/arch/arm64/kernel/topology.c
> >>>> +++ b/arch/arm64/kernel/topology.c
> >>>> @@ -284,7 +284,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
> >>>>         struct cpufreq_policy *policy = data;
> >>>>
> >>>>         if (val == CPUFREQ_CREATE_POLICY)
> >>>> -               amu_fie_setup(policy->related_cpus);
> >>>> +               amu_fie_setup(policy->cpus);
> >>>>
> >>>>         /*
> >>>>          * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> >>>> @@ -303,10 +303,71 @@ static struct notifier_block init_amu_fie_notifier = {
> >>>>         .notifier_call = init_amu_fie_callback,
> >>>>  };
> >>>>
> >>>> +static int cpuhp_topology_online(unsigned int cpu)
> >>>> +{
> >>>> +       struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
> >>>> +
> >>>> +       /* Those are cheap checks */
> >>>> +
> >>>> +       /*
> >>>> +        * Skip this CPU if:
> >>>> +        *  - it has no cpufreq policy assigned yet,
> >>>> +        *  - no policy exists that spans CPUs with AMU counters, or
> >>>> +        *  - it was already handled.
> >>>> +        */
> >>>> +       if (unlikely(!policy) || !cpumask_available(amu_fie_cpus) ||
> >>>> +           cpumask_test_cpu(cpu, amu_fie_cpus))
> >>>> +               return 0;
> >>>> +
> >>>> +       /*
> >>>> +        * Only proceed if all already-online CPUs in this policy
> >>>> +        * support AMU counters.
> >>>> +        */
> >>>> +       if (unlikely(!cpumask_subset(policy->cpus, amu_fie_cpus)))
> >>>> +               return 0;
> >>>> +
> >>>> +       /*
> >>>> +        * If the new online CPU cannot pass this check, all the CPUs related to
> >>>> +        * the same policy should be clear from amu_fie_cpus mask, otherwise they
> >>>> +        * may use different source of the freq scale.
> >>>> +        */
> >>>> +       if (!freq_counters_valid(cpu)) {
> >>>> +               pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);
> >>>
> >>> This is triggered during resume from s2ram on Renesas R-Car H3
> >>> (big.LITTLE 4x Cortex-A57 + 4x Cortex-A53), when enabling the first
> >>> little core:
> >>>
> >>>     AMU: CPU[4] doesn't support AMU counters
> >>>
> >>> Adding debug code:
> >>>
> >>>     pr_info("Calling
> >>> topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, %*pbl)\n",
> >>> cpumask_pr_args(policy->related_cpus));
> >>>     pr_info("Calling cpumask_andnot(..., %*pbl, %*pbl)\n",
> >>> cpumask_pr_args(amu_fie_cpus), cpumask_pr_args(policy->related_cpus));
> >>>
> >>> gives:
> >>>
> >>>     AMU: Calling topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, 4-7)
> >>>     AMU: Calling cpumask_andnot(..., , 4-7)
> >>>
> >>> so AMU is disabled for all little cores.
> >>>
> >>> Since this only happens during s2ram, and not during initial CPU
> >>> bring-up on boot, this looks wrong to me?
> >> This does look rather surprising. If that CPU was marked as supporting AMUs at
> >> the initial bring-up it should be part of amu_fie_cpus mask, so the hp callback
> >> should bail out straight away. Would you be able to add some logs to see what
> >> that mask actually contains ?
> >> Furthermore, freq_counters_valid is logging issues when validating the counters.
> >> Would you be able to re-run it with the debug level to see what might be
> >> happening under the hood, although I am still unsure why it is even reaching
> >> that point ...
> >
> > Adding extra debugging info, and "#define DEBUG" at the top.
> >
> > During boot:
> >
> >     AMU: amu_fie_setup:260: cpus 0-3 amu_fie_cpus
> >     ^^^ empty amu_fie_cpus
> >     AMU: CPU0: counters are not supported.
> >     ^^^ pr_debug
> >     AMU: amu_fie_setup:260: cpus 4-7 amu_fie_cpus
> >     ^^^ empty amu_fie_cpus
> >     AMU: CPU4: counters are not supported.
> >     ^^^ pr_debug
> >
> > During resume from s2ram:
> >
> >     AMU: cpuhp_topology_online:314: cpu 1 amu_fie_cpus
> >     AMU: cpuhp_topology_online:343: skipped
> > (!cpumask_subset(policy->cpus, amu_fie_cpus))
> >     AMU: cpuhp_topology_online:314: cpu 2 amu_fie_cpus
> >     AMU: cpuhp_topology_online:343: skipped
> > (!cpumask_subset(policy->cpus, amu_fie_cpus))
> >     AMU: cpuhp_topology_online:314: cpu 3 amu_fie_cpus
> >     AMU: cpuhp_topology_online:343: skipped
> > (!cpumask_subset(policy->cpus, amu_fie_cpus))
> >     AMU: cpuhp_topology_online:314: cpu 4 amu_fie_cpus
> >     AMU: CPU4: counters are not supported.
> >     ^^^ pr_debug
> >     AMU: CPU[4] doesn't support AMU counters
> >     ^^^ pr_warn
> >     AMU: Calling topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, 4-7)
> >     AMU: Calling cpumask_andnot(..., , 4-7)
>
> Something strange here. If AMU is not supported at all, amu_fie_cpus should
> never be available and cpuhp_topology_online() should return in the first
> 'if'. Why it runs this far?

You mean the "!cpumask_available(amu_fie_cpus)" test?

include/linux/cpumask.h:

    #ifdef CONFIG_CPUMASK_OFFSTACK
    static __always_inline bool cpumask_available(cpumask_var_t mask)
    {
            return mask != NULL;
    }
    #else
    static __always_inline bool cpumask_available(cpumask_var_t mask)
    {
            return true;
    }
    #endif /* CONFIG_CPUMASK_OFFSTACK */

include/linux/cpumask_types.h:

    #ifdef CONFIG_CPUMASK_OFFSTACK
    typedef struct cpumask *cpumask_var_t;
    #else
    typedef struct cpumask cpumask_var_t[1];
    #endif /* CONFIG_CPUMASK_OFFSTACK */

So if CONFIG_CPUMASK_OFFSTACK is not enabled, it always returns true.

arch/arm64/Kconfig:

    config ARM64
        [...]
        select CPUMASK_OFFSTACK if NR_CPUS > 256

> >     AMU: cpuhp_topology_online:314: cpu 5 amu_fie_cpus
> >     AMU: cpuhp_topology_online:343: skipped
> > (!cpumask_subset(policy->cpus, amu_fie_cpus))
> >     AMU: cpuhp_topology_online:314: cpu 6 amu_fie_cpus
> >     AMU: cpuhp_topology_online:343: skipped
> > (!cpumask_subset(policy->cpus, amu_fie_cpus))
> >     AMU: cpuhp_topology_online:314: cpu 7 amu_fie_cpus
> >     AMU: cpuhp_topology_online:343: skipped
> > (!cpumask_subset(policy->cpus, amu_fie_cpus))
> >
> > Hence there is no issue, as AMU is not supported at all!
> >
> > The confusing part is in the (absence of) logging.
> > If AMU is not supported, freq_counters_valid() uses:
> >
> >      pr_debug("CPU%d: counters are not supported.\n", cpu);
> >
> > which is typically not printed, unless DEBUG is enabled.
> >
> > If freq_counters_valid() failed, the new cpuhp_topology_online() uses:
> >
> >     pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);
> >
> > which is always printed.
> >
> > Given freq_counters_valid() already prints a (debug) message, I think
> > the pr_warn() should just be removed.  Do you agree, or is there still
> > another incorrect check that should prevent getting this far?
>
> I'm OK with removing it.

OK, I will send a patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

