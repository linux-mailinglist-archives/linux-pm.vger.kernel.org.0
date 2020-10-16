Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598929085F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410121AbgJPP3r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:29:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35409 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407477AbgJPP3r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:29:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id w141so2868383oia.2;
        Fri, 16 Oct 2020 08:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXhI22XAr9QzRuwe87asqlMQMLxwTwVNTWciuAMb+bw=;
        b=GQtkcjkEmuX6yXVbf5YWfQqpHkLHlJyht7e/mlUU9QjVRTERgDkNFqbKtXZMeWkYfd
         10JsGLOxNpbObp0wyaQjyc5cp/JYhTG1W5H/MAVWmADg3c+FYRtSgBa+yZuLlir3R/dg
         KTi+MGepu0XH4A6bJM7/xR4mnifbRQ2zlOqwqyYV/BWJikdKTWaHRj7H5bCLfPBUKv5W
         vZ1+TXwaDBFy7mHRwR9E8CCM81ZlGH2RSBDr+djSIAvu89p6D21JNurSXRGJQnxUmmH3
         L42Lh9HnVG2QFmrSpO9EtMlIPltkXT/zTe5Nf/zHfC3Jy2McPvZOujKbjxYkkw6tqlhl
         dLxA==
X-Gm-Message-State: AOAM531Rg0KQZAfuCtzMy3rIEkK7q9rvtDo2u4qg4S1gLGvQxofKWRBY
        Wlg5UodCQRkjjhGI6A19DlEFb/xoDj/XzGibgT0=
X-Google-Smtp-Source: ABdhPJy4hrU2lU+3QjTmaeU44NjAxcXQ5fVUg4lrlZfb/u1ptd6lnum/YIQ1b5IpjyYol7BUsq4F50F50fb7nq5Gn8o=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2863592oii.69.1602862186025;
 Fri, 16 Oct 2020 08:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <25f31d3e-7a67-935f-93ba-32216a5084e2@intel.com>
 <20201006211820.GN3227@techsingularity.net> <2382d796-7c2f-665e-9169-5cdc437bf34c@intel.com>
 <20201008090909.GP3227@techsingularity.net> <dcf4266a-5769-8a6b-d8e1-e77553126861@intel.com>
 <20201008173436.GQ3227@techsingularity.net> <f6b04376-4214-ff5d-1069-890449a923e2@intel.com>
 <20201014223703.GT3227@techsingularity.net> <20201015183410.GU3227@techsingularity.net>
 <CAJZ5v0jzZ6iQGYNnkgi-pPmdbq3aH+RoH+tBbEoBxFfmt_0MDg@mail.gmail.com> <20201016140909.GV3227@techsingularity.net>
In-Reply-To: <20201016140909.GV3227@techsingularity.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:29:34 +0200
Message-ID: <CAJZ5v0gYddcnpWEB+rSxXdr3vkgTkO6MJGH8qR0v_d9qfFWTRw@mail.gmail.com>
Subject: Re: ACPI _CST introduced performance regresions on Haswll
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 4:09 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Oct 16, 2020 at 03:41:12PM +0200, Rafael J. Wysocki wrote:
> > > Turns out I didn't even have that. On another machine (same model,
> > > same cpu, different BIOS that cannot be updated), enabling the C6 state
> > > still did not enable it on boot and dmesg complained about CST not being
> > > usable. This is weird because one would expect that if CST was unusable
> > > that it would be the same as use_acpi == false.
> > >
> > > This could potentially be if the ACPI tables are unsuitable due to bad
> > > bad FFH information for a lower c-state. If _CST is not found or usable,
> > > should acpi_state_table.count be reset to go back to the old behaviour?
> >
> > Yes, it should, although I would reset it in intel_idle_cst_usable()
> > right away before returning 'false'.
> >
>
> Good stuff.
>
> > I can send a patch to do the above or please submit the one below as
> > it works too.
> >
>
> I'm happy to go with your alternative if you prefer. For a finish,
> I decided it was worth reporting if the _CST was ignored regardless of
> the reason. It performs roughly the same as setting use_acpi = false on
> the affected machines.
>
> ---8<---
> intel_idle: Ignore _CST if control cannot be taken from the platform
>
> e6d4f08a6776 ("intel_idle: Use ACPI _CST on server systems") avoids
> enabling c-states that have been disabled by the platform with the
> exception of C1E.
>
> Unfortunately, BIOS implementations are not always consistent in terms
> of how capabilities are advertised and control cannot always be handed
> over. If control cannot be handed over then intel_idle reports that "ACPI
> _CST not found or not usable" but does not clear acpi_state_table.count
> meaning the information is still partially used.
>
> This patch ignores ACPI information if CST control cannot be requested from
> the platform. This was only observed on a number of Haswell platforms that
> had identical CPUs but not identical BIOS versions.  While this problem
> may be rare overall, 24 separate test cases bisected to this specific
> commit across 4 separate test machines and is worth addressing. If the
> situation occurs, the kernel behaves as it did before commit e6d4f08a6776
> and uses any c-states that are discovered.
>
> The affected test cases were all ones that involved a small number of
> processes -- exec microbenchmark, pipe microbenchmark, git test suite,
> netperf, tbench with one client and system call microbenchmark. Each
> case benefits from being able to use turboboost which is prevented if the
> lower c-states are unavailable. This may mask real regressions specific
> to older hardware so it is worth addressing.
>
> C-state status before and after the patch
>
> 5.9.0-vanilla            POLL     latency:0      disabled:0 default:enabled
> 5.9.0-vanilla            C1       latency:2      disabled:0 default:enabled
> 5.9.0-vanilla            C1E      latency:10     disabled:0 default:enabled
> 5.9.0-vanilla            C3       latency:33     disabled:1 default:disabled
> 5.9.0-vanilla            C6       latency:133    disabled:1 default:disabled
> 5.9.0-ignore-cst-v1r1    POLL     latency:0      disabled:0 default:enabled
> 5.9.0-ignore-cst-v1r1    C1       latency:2      disabled:0 default:enabled
> 5.9.0-ignore-cst-v1r1    C1E      latency:10     disabled:0 default:enabled
> 5.9.0-ignore-cst-v1r1    C3       latency:33     disabled:0 default:enabled
> 5.9.0-ignore-cst-v1r1    C6       latency:133    disabled:0 default:enabled
>
> Patch enables C3/C6.
>
> Netperf UDP_STREAM
>
> netperf-udp
>                                       5.5.0                  5.9.0
>                                     vanilla        ignore-cst-v1r1
> Hmean     send-64         193.41 (   0.00%)      226.54 *  17.13%*
> Hmean     send-128        392.16 (   0.00%)      450.54 *  14.89%*
> Hmean     send-256        769.94 (   0.00%)      881.85 *  14.53%*
> Hmean     send-1024      2994.21 (   0.00%)     3468.95 *  15.85%*
> Hmean     send-2048      5725.60 (   0.00%)     6628.99 *  15.78%*
> Hmean     send-3312      8468.36 (   0.00%)    10288.02 *  21.49%*
> Hmean     send-4096     10135.46 (   0.00%)    12387.57 *  22.22%*
> Hmean     send-8192     17142.07 (   0.00%)    19748.11 *  15.20%*
> Hmean     send-16384    28539.71 (   0.00%)    30084.45 *   5.41%*
>
> Fixes: e6d4f08a6776 ("intel_idle: Use ACPI _CST on server systems")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  drivers/idle/intel_idle.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 9a810e4a7946..4af2d3f2c8aa 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1212,14 +1212,13 @@ static bool __init intel_idle_acpi_cst_extract(void)
>                 if (!intel_idle_cst_usable())
>                         continue;
>
> -               if (!acpi_processor_claim_cst_control()) {
> -                       acpi_state_table.count = 0;
> -                       return false;
> -               }
> +               if (!acpi_processor_claim_cst_control())
> +                       break;
>
>                 return true;
>         }
>
> +       acpi_state_table.count = 0;
>         pr_debug("ACPI _CST not found or not usable\n");
>         return false;
>  }

Applied as a fix for 5.10-rc1, thanks!
