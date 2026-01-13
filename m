Return-Path: <linux-pm+bounces-40712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42793D18445
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7372B301A1AA
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B49735CB77;
	Tue, 13 Jan 2026 10:59:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981363557E0
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301949; cv=none; b=dQ4qKIRl0ZnWyK/J3LBOLS/EFCUMt+rl/UoLPg4m0XLIAgW642E8Ha7w9wWXGGywCmnEcJ4lgLQPiN7yFUP4utkH20nWDIv/Z/gIxbtmJMK5df5JGHkx0EmHbOf529/ylJk/gHSvvyzh4ug/oOt1augLdhMLNgzJS+FUQHgzNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301949; c=relaxed/simple;
	bh=zVgC2T1qmVxIG0uAA9JbSZgg+CLSJlVw+aYdFAQNi+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROz/92EUjCYLcAkHQBizvAYzWXNMqUplgzu+vHuYKKC+L8d1v6XWrWeNUquFpNsYe38QJaR+jD5q8b7/55E5CMAYOjbUjxUY+2m0Aw8X+wmmJs/bMM/WEv6QnqEfDmoobsMgNEXQu4NlArvPV8CjrlwDMnz9C3XgisLrMJx3qQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee1879e6d9so87488711cf.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 02:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301946; x=1768906746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzWAvWlKk1ivM3WNqFslwu42j6W682o4xLEKdFkEC58=;
        b=gYw1oR9BIU5LIRyF9PMoZF5XSMOI9FS7HWPbxRteLU02Zt3T7TryEC79xxHzPs2slN
         4pb+g83tWKcyEiZK7LHSgxVUADu1uvSYc6J5vBxGFmAyQ6FtTELBK89exjfaDyaSzmA7
         a6/U2evYQiC/oWUT1f+FWMoUZQq6EKdaL2X3p9ni3nk+xjUwC5WWErleDHKFAqxrMRQ7
         ZJF5Gdi1HeheLV1oNmp1VkAPROvcaZYJnQJ8bhpj9yf/6Glz51/DY1QZeqdaa1DO9ys7
         eC1hVnbZdrUIU7bAAI9mBbeHgzBePY2YidFfDE+JWHWoewR1/t954D/x7UWyjrX5uNbF
         FvMw==
X-Forwarded-Encrypted: i=1; AJvYcCWsWPptjepfBzPJrvcjeaPPo8zBJnYbKtUrq/WfTeJ8BoRL+N3aA1cZT3yOLRQ3SvwFNuAhT3dXUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI40Kg/UfUJgTGEcYDBsX5g0IFJxcUwSKhMtUBIJdxFiHm4/As
	686vU+WPL8xZjuARUuJneBg117pK/kUPQn3rpTnJFPF7MhOySqeKFntEoAhOw501
X-Gm-Gg: AY/fxX5mmMIj/NhP4gQGfsvgh+QDoL85jTitHKR1rAAh4ijFo0gLE0pR8njCjWM1W2S
	w9tf2I4y3GDfjfAWciajNg5WGMBM2LKYJLQhaMXWL1BRcnHvMc3wkG5Vpmbh1WHgQY2z/Lk2+nx
	4Rek7tURyRHyRmgEFmSdeVx656aBeP7vdyRw+8mkYANpMOWKOX5fnPPHw4RVgrONtS4TrvCjvHb
	Bo6i372Rg97jpBTZggyj5UToe8r1KgoPKlW2cFvLl3YmFFNQ+p7PRIN6/UyqKOcwo+nL8LV5EjV
	ni74YSpKIt1n9Nidi5tc1Aq0s8ZL4uTvQmVeeIIKSWe+qqCYpmotqSwA7BPIaFsdQs+Kfgutst5
	4i1OLN/YUg56VCBUBJ6giKYTLGKGFeDZ6G6p5Rt9ULbZDCOMK8Ag/NzDtoPh8IqXIeec3p+IiL6
	T+gjOWUeM+5Vn773UUVutuJwfMYDBZiYWBiyetj5Zy2W2aOWesIiP3
X-Google-Smtp-Source: AGHT+IEjMTT5O6eo4fBHPaWAb6v9NQ5PFfemkebttwSH0GNIgsldvr8Yv9I0i/nc2grtjFWqpkKDLA==
X-Received: by 2002:a05:622a:199b:b0:4f0:2b7e:c5b6 with SMTP id d75a77b69052e-4ffb4a55808mr268935521cf.71.1768301946437;
        Tue, 13 Jan 2026 02:59:06 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d64563sm139559781cf.13.2026.01.13.02.59.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 02:59:06 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so109203061cf.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 02:59:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXvo4SQKrcIDGp3mi4Z1svoJ5L+ygUjSRoCcI5DeOIlqCyPaiWXAheayUHduh/hrMd8LuS2iaPDw==@vger.kernel.org
X-Received: by 2002:a05:6102:4412:b0:4e6:a338:a421 with SMTP id
 ada2fe7eead31-5ecb5cbb070mr8601476137.6.1768301516773; Tue, 13 Jan 2026
 02:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com> <20251230080115.2120612-4-zhenglifeng1@huawei.com>
In-Reply-To: <20251230080115.2120612-4-zhenglifeng1@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Jan 2026 11:51:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeHk-Enc-M9ztwSdeAtE8YPKtJwq+273bGPEFOEsu=Rw@mail.gmail.com>
X-Gm-Features: AZwV_QisLfN-JbYTCLd4Pwog5D8ewcnp0Gg5r8ROYeUNPNSxroJTI4oVjqJhvbQ
Message-ID: <CAMuHMdVeHk-Enc-M9ztwSdeAtE8YPKtJwq+273bGPEFOEsu=Rw@mail.gmail.com>
Subject: Re: [REPOST PATCH v6 3/3] arm64: topology: Handle AMU FIE setup on
 CPU hotplug
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, sudeep.holla@arm.com, gregkh@linuxfoundation.org, 
	dakr@kernel.org, beata.michalska@arm.com, ionela.voinescu@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linuxarm@huawei.com, jonathan.cameron@huawei.com, vincent.guittot@linaro.org, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	zhangpengjie2@huawei.com, wangzhi12@huawei.com, linhongye@h-partners.com, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Lifeng,

On Tue, 30 Dec 2025 at 09:02, Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
> Currently, when a cpufreq policy is created, the AMU FIE setup process
> checks all CPUs in the policy -- including those that are offline. If any
> of these CPUs are offline at that time, their AMU capability flag hasn't
> been verified yet, leading the check fail. As a result, AMU FIE is not
> enabled, even if the CPUs that are online do support it.
>
> Later, when the previously offline CPUs come online and report AMU support,
> there's no mechanism in place to re-enable AMU FIE for the policy. This
> leaves the entire frequency domain without AMU FIE, despite being eligible.
>
> Restrict the initial AMU FIE check to only those CPUs that are online at
> the time the policy is created, and allow CPUs that come online later to
> join the policy with AMU FIE enabled.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Acked-by: Beata Michalska <beata.michalska@arm.com>

Thanks for your patch, which is now commit 6fd9be0b7b2e957d
("arm64: topology: Handle AMU FIE setup on CPU hotplug") in
arm64/for-next/core (next-20260107 and later).

> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -284,7 +284,7 @@ static int init_amu_fie_callback(struct notifier_block *nb, unsigned long val,
>         struct cpufreq_policy *policy = data;
>
>         if (val == CPUFREQ_CREATE_POLICY)
> -               amu_fie_setup(policy->related_cpus);
> +               amu_fie_setup(policy->cpus);
>
>         /*
>          * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> @@ -303,10 +303,71 @@ static struct notifier_block init_amu_fie_notifier = {
>         .notifier_call = init_amu_fie_callback,
>  };
>
> +static int cpuhp_topology_online(unsigned int cpu)
> +{
> +       struct cpufreq_policy *policy = cpufreq_cpu_policy(cpu);
> +
> +       /* Those are cheap checks */
> +
> +       /*
> +        * Skip this CPU if:
> +        *  - it has no cpufreq policy assigned yet,
> +        *  - no policy exists that spans CPUs with AMU counters, or
> +        *  - it was already handled.
> +        */
> +       if (unlikely(!policy) || !cpumask_available(amu_fie_cpus) ||
> +           cpumask_test_cpu(cpu, amu_fie_cpus))
> +               return 0;
> +
> +       /*
> +        * Only proceed if all already-online CPUs in this policy
> +        * support AMU counters.
> +        */
> +       if (unlikely(!cpumask_subset(policy->cpus, amu_fie_cpus)))
> +               return 0;
> +
> +       /*
> +        * If the new online CPU cannot pass this check, all the CPUs related to
> +        * the same policy should be clear from amu_fie_cpus mask, otherwise they
> +        * may use different source of the freq scale.
> +        */
> +       if (!freq_counters_valid(cpu)) {
> +               pr_warn("CPU[%u] doesn't support AMU counters\n", cpu);

This is triggered during resume from s2ram on Renesas R-Car H3
(big.LITTLE 4x Cortex-A57 + 4x Cortex-A53), when enabling the first
little core:

    AMU: CPU[4] doesn't support AMU counters

Adding debug code:

    pr_info("Calling
topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, %*pbl)\n",
cpumask_pr_args(policy->related_cpus));
    pr_info("Calling cpumask_andnot(..., %*pbl, %*pbl)\n",
cpumask_pr_args(amu_fie_cpus), cpumask_pr_args(policy->related_cpus));

gives:

    AMU: Calling topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH, 4-7)
    AMU: Calling cpumask_andnot(..., , 4-7)

so AMU is disabled for all little cores.

Since this only happens during s2ram, and not during initial CPU
bring-up on boot, this looks wrong to me?

> +               topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_ARCH,
> +                                                policy->related_cpus);
> +               cpumask_andnot(amu_fie_cpus, amu_fie_cpus, policy->related_cpus);
> +               return 0;
> +       }
> +
> +       cpumask_set_cpu(cpu, amu_fie_cpus);
> +
> +       topology_set_scale_freq_source(&amu_sfd, cpumask_of(cpu));
> +
> +       pr_debug("CPU[%u]: counter will be used for FIE.", cpu);
> +
> +       return 0;
> +}
> +
>  static int __init init_amu_fie(void)
>  {
> -       return cpufreq_register_notifier(&init_amu_fie_notifier,
> +       int ret;
> +
> +       ret = cpufreq_register_notifier(&init_amu_fie_notifier,
>                                         CPUFREQ_POLICY_NOTIFIER);
> +       if (ret)
> +               return ret;
> +
> +       ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +                                       "arm64/topology:online",
> +                                       cpuhp_topology_online,
> +                                       NULL);
> +       if (ret < 0) {
> +               cpufreq_unregister_notifier(&init_amu_fie_notifier,
> +                                           CPUFREQ_POLICY_NOTIFIER);
> +               return ret;
> +       }
> +
> +       return 0;
>  }
>  core_initcall(init_amu_fie);
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 84ec92bff642..c0ef6ea9c111 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -34,7 +34,14 @@ EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
>
>  static bool supports_scale_freq_counters(const struct cpumask *cpus)
>  {
> -       return cpumask_subset(cpus, &scale_freq_counters_mask);
> +       int i;
> +
> +       for_each_cpu(i, cpus) {
> +               if (cpumask_test_cpu(i, &scale_freq_counters_mask))
> +                       return true;
> +       }
> +
> +       return false;
>  }
>
>  bool topology_scale_freq_invariant(void)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

