Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5151ED1FD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 16:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgFCOXI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 10:23:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33507 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgFCOXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 10:23:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id i74so1970708oib.0;
        Wed, 03 Jun 2020 07:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgD8vssHycca9hhWw5GR8fg56A5aDizlCJPpWsS2JI8=;
        b=M+xvzSpJPWowgOEAm8n6JaDc02zzVADf/NZmcZHdZzFDs272WZua9YLk33TtHtSRMk
         8MxmKB7u6dApAkL0p/k7Wcx/oyJ5XmmvXVVUMNSDnbz3iIOuGEgIWOac/ckERMSFB4pT
         VjwbcKk177pdX4ajFWvTl4w64vlhSOiWsXx5L+Hl4KcgDzlAOLypQwMv+TxwYc+K78Id
         R0PZDuk6ZLRkvWjpNd7WeASDlJBa8TEwTkppGC1XIEjQKocWkVKOiB+sjQgV0y2uGO54
         inu4h7Lag8Y41xSRx8gAayIyU0zZxn5JAyUkTGJ3yHQrbQffN6FfuKY76fGWjnQhks0N
         Ql7w==
X-Gm-Message-State: AOAM532Ov7akC4lZcVqd2xoZeA1NeY6vnquY5i7l+DtaXcF27Wzedg3W
        eX/hE9Ma0D8lf6JDleP2FTb+Ctp0M2c0QjRm3X4=
X-Google-Smtp-Source: ABdhPJzNTezlEavsAbvUt6SDIYhugO+ejOcohba7o+c1KWRIDeyqqhx/0LAPzxS/YsypnS3ROXg5zcM+CnvNeMpqqFg=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr6666418oie.103.1591194186785;
 Wed, 03 Jun 2020 07:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200531182453.15254-1-ggherdovich@suse.cz> <20200531182453.15254-2-ggherdovich@suse.cz>
In-Reply-To: <20200531182453.15254-2-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 16:22:52 +0200
Message-ID: <CAJZ5v0iikLxwwwbe_PWysmG3mz8iO4KqEyXZtL2isvZm1v+J=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86, sched: check for counters overflow in
 frequency invariant accounting
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 8:26 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> The product mcnt * arch_max_freq_ratio can overflows u64.
>
> For context, a large value for arch_max_freq_ratio would be 5000,
> corresponding to a turbo_freq/base_freq ratio of 5 (normally it's more like
> 1500-2000). A large increment frequency for the MPERF counter would be 5GHz
> (the base clock of all CPUs on the market today is less than that). With
> these figures, a CPU would need to go without a scheduler tick for around 8
> days for the u64 overflow to happen. It is unlikely, but the check is
> warranted.
>
> Under similar conditions, the difference acnt of two consecutive APERF
> readings can overflow as well.
>
> In these circumstances is appropriate to disable frequency invariant
> accounting: the feature relies on measures of the clock frequency done at
> every scheduler tick, which need to be "fresh" to be at all meaningful.
>
> A note on i386: prior to version 5.1, the GCC compiler didn't have the
> builtin function __builtin_mul_overflow. In these GCC versions the macro
> check_mul_overflow needs __udivdi3() to do (u64)a/b, which the kernel
> doesn't provide. For this reason this change fails to build on i386 if
> GCC<5.1, and we protect the entire frequency invariant code behind
> CONFIG_X86_64 (special thanks to "kbuild test robot" <lkp@intel.com>).
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/include/asm/topology.h |  2 +-
>  arch/x86/kernel/smpboot.c       | 33 ++++++++++++++++++++++++++++-----
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 79d8d5496330..f4234575f3fd 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -193,7 +193,7 @@ static inline void sched_clear_itmt_support(void)
>  }
>  #endif /* CONFIG_SCHED_MC_PRIO */
>
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
>  #include <asm/cpufeature.h>
>
>  DECLARE_STATIC_KEY_FALSE(arch_scale_freq_key);
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 2f24c334a938..d660966d7de7 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -55,6 +55,7 @@
>  #include <linux/gfp.h>
>  #include <linux/cpuidle.h>
>  #include <linux/numa.h>
> +#include <linux/overflow.h>
>
>  #include <asm/acpi.h>
>  #include <asm/desc.h>
> @@ -1777,6 +1778,7 @@ void native_play_dead(void)
>
>  #endif
>
> +#ifdef CONFIG_X86_64
>  /*
>   * APERF/MPERF frequency ratio computation.
>   *
> @@ -2047,11 +2049,19 @@ static void init_freq_invariance(bool secondary)
>         }
>  }
>
> +static void disable_freq_invariance_workfn(struct work_struct *work)
> +{
> +       static_branch_disable(&arch_scale_freq_key);
> +}
> +
> +static DECLARE_WORK(disable_freq_invariance_work,
> +                   disable_freq_invariance_workfn);
> +
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
>
>  void arch_scale_freq_tick(void)
>  {
> -       u64 freq_scale;
> +       u64 freq_scale = SCHED_CAPACITY_SCALE;
>         u64 aperf, mperf;
>         u64 acnt, mcnt;
>
> @@ -2063,19 +2073,32 @@ void arch_scale_freq_tick(void)
>
>         acnt = aperf - this_cpu_read(arch_prev_aperf);
>         mcnt = mperf - this_cpu_read(arch_prev_mperf);
> -       if (!mcnt)
> -               return;
>
>         this_cpu_write(arch_prev_aperf, aperf);
>         this_cpu_write(arch_prev_mperf, mperf);
>
> -       acnt <<= 2*SCHED_CAPACITY_SHIFT;
> -       mcnt *= arch_max_freq_ratio;
> +       if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> +               goto error;
> +
> +       if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> +               goto error;
>
>         freq_scale = div64_u64(acnt, mcnt);
> +       if (!freq_scale)
> +               goto error;
>
>         if (freq_scale > SCHED_CAPACITY_SCALE)
>                 freq_scale = SCHED_CAPACITY_SCALE;
>
>         this_cpu_write(arch_freq_scale, freq_scale);
> +       return;
> +
> +error:
> +       pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> +       schedule_work(&disable_freq_invariance_work);
> +}
> +#else
> +static inline void init_freq_invariance(bool secondary)
> +{
>  }
> +#endif /* CONFIG_X86_64 */
> --
> 2.16.4
>
