Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50461ACAF5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgDPPmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 11:42:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35019 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395513AbgDPPl7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 11:41:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id e20so3455780otl.2;
        Thu, 16 Apr 2020 08:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2r2r7O0CFpemVMZF52M89j+FDaTZj9iicBxWLrdGKQ=;
        b=cWxSd2WFCpFpPKJYhn5g9auh747t7vpQLWrKQiFns9euE2mwmJAxx4OswvcW1SJdNr
         5pBjf6DV7dvZCsq/fSzoUVXlvHRMkSx5+4PlPcqxb8BQm35ojCCp0MlczkoZdT58Ta9L
         BLYBbqLol5UHyDawboY8p67ytB3sBdgT3UQNQYdCNc4vftu64uKewgavnd19LZdU6PWA
         R96S9mVXSX/WFaMjCeyPrONJ43dwpqq0/TAWr1f9VwP6OVDa3Bqix21AjhDx+GCjR7ck
         uKHyl+TEPCjWd8upAIVIeBD/5m6jvkVL9UlByAYK3e+k1npepC+Ytb0Vcxb/mHfkUayd
         wrNg==
X-Gm-Message-State: AGi0PuYG8NhUrTEKoXVwKRBu6oI4hiyibXJJem/CiN5kOx3pT3FFcZ1v
        l18MSUDnR7YzSGa3yYkHEEWvNbNvbGQtpZ1Q3RU=
X-Google-Smtp-Source: APiQypKYmfqXSVukeSYfuQdxJzi/Fy9tusMoaZDOo2RFrsmXI9m1AdnnIuDy0Q/dp38vblR7AcNuNmt5u6ZjLa0nqSU=
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr17036281otq.262.1587051718557;
 Thu, 16 Apr 2020 08:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200416054745.740-1-ggherdovich@suse.cz> <20200416054745.740-2-ggherdovich@suse.cz>
In-Reply-To: <20200416054745.740-2-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Apr 2020 17:41:47 +0200
Message-ID: <CAJZ5v0hypB1cYAis6+tg5_ckY6Z4-Xbif8ZUj5ZP+M9SFHM4fw@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86, sched: Bail out of frequency invariance if base
 frequency is unknown
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Doug Smythies <dsmythies@telus.net>,
        Like Xu <like.xu@linux.intel.com>,
        Neil Rickert <nwr10cst-oslnx@yahoo.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 16, 2020 at 7:48 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Some hypervisors such as VMWare ESXi 5.5 advertise support for
> X86_FEATURE_APERFMPERF but then fill all MSR's with zeroes. In particular,
> MSR_PLATFORM_INFO set to zero tricks the code that wants to know the base
> clock frequency of the CPU (highest non-turbo frequency), producing a
> division by zero when computing the ratio turbo_freq/base_freq necessary
> for frequency invariant accounting.
>
> It is to be noted that even if MSR_PLATFORM_INFO contained the appropriate
> data, APERF and MPERF are constantly zero on ESXi 5.5, thus freq-invariance
> couldn't be done in principle (not that it would make a lot of sense in a
> VM anyway). The real problem is advertising X86_FEATURE_APERFMPERF. This
> appears to be fixed in more recent versions: ESXi 6.7 doesn't advertise
> that feature.
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all patches in the series and I'm expecting them to be routed through tip.

Thanks!

> ---
>  arch/x86/kernel/smpboot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index fe3ab9632f3b..3a318ec9bc17 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1985,6 +1985,15 @@ static bool intel_set_max_freq_ratio(void)
>         return false;
>
>  out:
> +       /*
> +        * Some hypervisors advertise X86_FEATURE_APERFMPERF
> +        * but then fill all MSR's with zeroes.
> +        */
> +       if (!base_freq) {
> +               pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
> +               return false;
> +       }
> +
>         arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
>                                         base_freq);
>         arch_set_max_freq_ratio(turbo_disabled());
> --
> 2.16.4
>
